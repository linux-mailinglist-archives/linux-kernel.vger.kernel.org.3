Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172C04C85F0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiCAIIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiCAIIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:08:54 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F10B5C862
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:08:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id E5E4EE0050;
        Tue,  1 Mar 2022 00:07:41 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NjUDqyp8Owl9; Tue,  1 Mar 2022 00:07:41 -0800 (PST)
Message-ID: <d73eed98b74535f0b67b843d9c40cac11b41bcb6.camel@puri.sm>
Subject: Re: [PATCH] input: keyboard: snvs_pwrkey: Fix SNVS_HPVIDR1 register
 address
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Date:   Tue, 01 Mar 2022 09:07:34 +0100
In-Reply-To: <20220228184652.277252-1-sebastian.krzyszkowiak@puri.sm>
References: <20220228184652.277252-1-sebastian.krzyszkowiak@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 28.02.2022 um 19:46 +0100 schrieb Sebastian
Krzyszkowiak:
> Both i.MX6 and i.MX8 reference manuals list 0xBF8 as SNVS_HPVIDR1
> (chapters 57.9 and 6.4.5 respectively).
> 
> Fixes: 1a26c920717a ("Input: snvs_pwrkey - send key events for i.MX6
> S, DL and Q")
> Signed-off-by: Sebastian Krzyszkowiak
> <sebastian.krzyszkowiak@puri.sm>

Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>

using evemu-record. Because the commit message doesn't describe it:
Without this, when "pressing" power key, events "1" and "0" together
would be delivered in one. With this fix, it's only "1", and when
"releasing" we see the "0" event as expected.

thank you,
                             martin


> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c
> b/drivers/input/keyboard/snvs_pwrkey.c
> index 65286762b02a..ad8660be0127 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -20,7 +20,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  
> -#define SNVS_HPVIDR1_REG       0xF8
> +#define SNVS_HPVIDR1_REG       0xBF8
>  #define SNVS_LPSR_REG          0x4C    /* LP Status Register */
>  #define SNVS_LPCR_REG          0x38    /* LP Control Register */
>  #define SNVS_HPSR_REG          0x14


