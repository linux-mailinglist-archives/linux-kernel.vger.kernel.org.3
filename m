Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B235A0B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbiHYI0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiHYIZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:25:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64165A61D0;
        Thu, 25 Aug 2022 01:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8369B825C6;
        Thu, 25 Aug 2022 08:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33959C433C1;
        Thu, 25 Aug 2022 08:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661415912;
        bh=+3nbUDEGFHWk7BXN0epNvlnSXMzGK3xJtVizdfnqTik=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=C6Y5F6TdMhjaHXDBt8319eHc36cT5d3h3VBOl2NdUXxuKtnMhdQDZEk6ezQcXs/J5
         tl+o80MiQOmPjzyuuHcGZGRJ9qXK/rr8xi0tE4+m1Vh3ZbetWSC2JezIVvZ38ebBNp
         mf0nCJMtcchvzNRKCv2S86lDgQJGYbUG7+His1hly9Op/AWZ08rA00ksyumBYozxHG
         Hq0uz9QhGWwgGTM8hG3EXJFjNntxf2xGnBuvui3SrDMo4Salyxz8GYIvT5oxcPQ2I7
         Jw8bn1dxCRWJz7oJmKZQrB4OJH/a+/Qe2qVz20pqm33RMiycnU5mzy6Ct9sqdxO10X
         Xpm+hCJoaCKRQ==
Date:   Thu, 25 Aug 2022 10:25:08 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] HID: uclogic: Add missing suffix for
 digitalizers
In-Reply-To: <20220815142615.17965-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2208251025020.19850@cbobk.fhfr.pm>
References: <20220815142615.17965-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022, José Expósito wrote:

> The Pen (0x02) application usage was changed to Digitalizer (0x01) in
> commit f7d8e387d9ae ("HID: uclogic: Switch to Digitizer usage for
> styluses"). However, a suffix was not selected for the new usage.
> 
> Handle the digitalizer application usage in uclogic_input_configured()
> and add the required suffix.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> ---
> 
> Kindly resending this patch so it doesn't get lost after the merge
> window.
> ---
>  drivers/hid/hid-uclogic-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
> index 47a17375c7fc..ff46604ef1d8 100644
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -153,6 +153,7 @@ static int uclogic_input_configured(struct hid_device *hdev,
>  			suffix = "Pad";
>  			break;
>  		case HID_DG_PEN:
> +		case HID_DG_DIGITIZER:
>  			suffix = "Pen";
>  			break;
>  		case HID_CP_CONSUMER_CONTROL:

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

