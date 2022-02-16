Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5324B8D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiBPQKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:10:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiBPQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:10:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5182AC907;
        Wed, 16 Feb 2022 08:10:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89C0DB81F1E;
        Wed, 16 Feb 2022 16:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EE2C004E1;
        Wed, 16 Feb 2022 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645027801;
        bh=invbru5iq/kzOOAzKbrSzFKl2EUzGbaQH6b7feWk4vk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=noPx9ICkSbUkC801iMzKN93IYwSvDIkNfy8I229A3Y4MyeOhCloj6+gA9PBu9aftX
         Q8zXU6H6QxcbygcXg2lj9PFaiZcmw8b3cr0oICC3jBG8NdxUJrXrKy7MJyHqbZH8qg
         mV7vv5M8LubeCZGzYTlWxfXhAbuscqu9GmhFf0yFB4LfaLCYwl59Adxo16mPhwzeid
         by96RKj6gkAaSLslBJQMaoHJxFexGB4qUjvLriOAAPk1ThYJZXWiCOqGyb05uQ1bft
         of9ENnzlWiKdMC3/+W3I8Y4BMX1hWZI+FvIS4MeaMaG0clPs4ZC+nGuh6eq4JTmZz2
         KsLju+q+WOD7Q==
Date:   Wed, 16 Feb 2022 17:09:58 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Michael_H=FCbner?= <michaelh.95@t-online.de>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: Add support for open wheel and no attachment to
 T300
In-Reply-To: <20220120074048.14764-1-michaelh.95@t-online.de>
Message-ID: <nycvar.YFH.7.76.2202161709510.11721@cbobk.fhfr.pm>
References: <20220120074048.14764-1-michaelh.95@t-online.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022, Michael Hübner wrote:

> Different add ons to the wheel base report different models. Having
> no wheel mounted to the base and using the open wheel attachment is
> added here.
> 
> Signed-off-by: Michael Hübner <michaelh.95@t-online.de>
> ---
>  drivers/hid/hid-thrustmaster.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-thrustmaster.c b/drivers/hid/hid-thrustmaster.c
> index 03b935ff02d5..a4e20f9e598b 100644
> --- a/drivers/hid/hid-thrustmaster.c
> +++ b/drivers/hid/hid-thrustmaster.c
> @@ -64,7 +64,9 @@ struct tm_wheel_info {
>   */
>  static const struct tm_wheel_info tm_wheels_infos[] = {
>  	{0x0306, 0x0006, "Thrustmaster T150RS"},
> +	{0x0200, 0x0005, "Thrustmaster T300RS (Missing Attachment)"},
>  	{0x0206, 0x0005, "Thrustmaster T300RS"},
> +	{0x0209, 0x0005, "Thrustmaster T300RS (Open Wheel Attachment)"},
>  	{0x0204, 0x0005, "Thrustmaster T300 Ferrari Alcantara Edition"},
>  	{0x0002, 0x0002, "Thrustmaster T500RS"}
>  	//{0x0407, 0x0001, "Thrustmaster TMX"}

Applied, thanks Michael.

-- 
Jiri Kosina
SUSE Labs

