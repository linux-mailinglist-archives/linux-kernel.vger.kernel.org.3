Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050B54C8DC5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiCAOce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiCAOcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:32:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E15DA145D;
        Tue,  1 Mar 2022 06:31:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E637DB819EB;
        Tue,  1 Mar 2022 14:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557EAC340EE;
        Tue,  1 Mar 2022 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646145109;
        bh=z9sBMCaC7PrIXmRTVNKzPUl4Np+y5tuogN0n+r7OyP4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=X1iB8bj0FXrV0BTbZZ6gw/o6yeajKjg755ldIZFdjzmiumf0foSn2ehK/kEZS7Qhz
         GJMVdo/q+UUyHELVIji7Xhb1YU2kG8JKaF4H3zE4BzFs6yF+Gz+UQhUOZCXYUbKchI
         uX8QucfWMKUGoI3EI+jXD4pGSdMq419cDFrkKNVe4R6hjpuJb2eUsRzRI41oC7Q6oX
         D1zZuTVBy+CXFQyUjY0KbrGAJoVXhxB246ha9TOMyxTVSb0fDiR2fInLMwFndCS2GB
         nIMbsWTHpmf4WW40FBp4IzpXjterVp9req2ZylVlDZVXBtnbQisbmuUEosYN3BEvyi
         p8WmeT08fknlg==
Date:   Tue, 1 Mar 2022 15:31:46 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean O'Brien <seobrien@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: vivaldi: fix sysfs attributes leak
In-Reply-To: <YhmAAjNeTjiNoLlJ@google.com>
Message-ID: <nycvar.YFH.7.76.2203011531370.11721@cbobk.fhfr.pm>
References: <YhmAAjNeTjiNoLlJ@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022, Dmitry Torokhov wrote:

> The driver creates the top row map sysfs attribute in input_configured()
> method; unfortunately we do not have a callback that is executed when HID
> interface is unbound, thus we are leaking these sysfs attributes, for
> example when device is disconnected.
> 
> To fix it let's switch to managed version of adding sysfs attributes which
> will ensure that they are destroyed when the driver is unbound.
> 
> Fixes: 14c9c014babe ("HID: add vivaldi HID driver")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Compiled only.
> 
>  drivers/hid/hid-vivaldi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
> index efa6140915f4..42ceb2058a09 100644
> --- a/drivers/hid/hid-vivaldi.c
> +++ b/drivers/hid/hid-vivaldi.c
> @@ -144,7 +144,7 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
>  static int vivaldi_input_configured(struct hid_device *hdev,
>  				    struct hid_input *hidinput)
>  {
> -	return sysfs_create_group(&hdev->dev.kobj, &input_attribute_group);
> +	return devm_device_add_group(&hdev->dev, &input_attribute_group);
>  }
>  
>  static const struct hid_device_id vivaldi_table[] = {

Applied, thanks Dmitry.

-- 
Jiri Kosina
SUSE Labs

