Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EF6506973
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350892AbiDSLLw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Apr 2022 07:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiDSLLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:11:51 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04FE2AC49
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:09:08 -0700 (PDT)
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 85CD1C2A32
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:09:07 +0000 (UTC)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B084E0008;
        Tue, 19 Apr 2022 11:08:59 +0000 (UTC)
Message-ID: <3f0dd8e6d0d6d01483e21e7702f5f59ad60a077c.camel@hadess.net>
Subject: Re: [PATCH] USB: using pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
From:   Bastien Nocera <hadess@hadess.net>
To:     cgel.zte@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Tue, 19 Apr 2022 13:08:58 +0200
In-Reply-To: <20220419110553.2574548-1-chi.minghao@zte.com.cn>
References: <20220419110553.2574548-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-19 at 11:05 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Reviewed-by: Bastien Nocera <hadess@hadess.net>

Thanks!

> ---
>  drivers/usb/misc/apple-mfi-fastcharge.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c
> b/drivers/usb/misc/apple-mfi-fastcharge.c
> index ac8695195c13..fba102245d8f 100644
> --- a/drivers/usb/misc/apple-mfi-fastcharge.c
> +++ b/drivers/usb/misc/apple-mfi-fastcharge.c
> @@ -119,11 +119,9 @@ static int apple_mfi_fc_set_property(struct
> power_supply *psy,
>  
>         dev_dbg(&mfi->udev->dev, "prop: %d\n", psp);
>  
> -       ret = pm_runtime_get_sync(&mfi->udev->dev);
> -       if (ret < 0) {
> -               pm_runtime_put_noidle(&mfi->udev->dev);
> +       ret = pm_runtime_resume_and_get(&mfi->udev->dev);
> +       if (ret < 0)
>                 return ret;
> -       }
>  
>         switch (psp) {
>         case POWER_SUPPLY_PROP_CHARGE_TYPE:

