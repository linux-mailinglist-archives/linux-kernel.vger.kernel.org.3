Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6294C55B3AF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiFZTL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 15:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiFZTLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:11:24 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A4FBCAE;
        Sun, 26 Jun 2022 12:11:22 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F0E29C0005;
        Sun, 26 Jun 2022 19:11:19 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1o5XfC-00CMMP-Iw; Sun, 26 Jun 2022 21:11:18 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     santoshkumar.yadav@barco.com, peter.korsgaard@barco.com,
        hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] platform: x86: Remove duplicated include in
 barco-p50-gpio.c
References: <YriUMDJoip0Mknh3@Sauravs-MacBook-Air.local>
Date:   Sun, 26 Jun 2022 21:11:18 +0200
In-Reply-To: <YriUMDJoip0Mknh3@Sauravs-MacBook-Air.local> (Saurav Girepunje's
        message of "Sun, 26 Jun 2022 22:45:28 +0530")
Message-ID: <8735fr1bqh.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Saurav" == Saurav Girepunje <saurav.girepunje@gmail.com> writes:

 > Remove the duplicate include of linux/io.h in barco-p50-gpio.c
 > file.

 > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

What tree is this against? The io.h include in the line just above
delay.h was already removed by:

commit 011881b80ebe773914b59905bce0f5e0ef93e7ba
Author: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Date:   Thu May 26 17:03:45 2022 +0800

    platform/x86: barco-p50-gpio: Add check for platform_driver_register

    As platform_driver_register() could fail, it should be better
    to deal with the return value in order to maintain the code
    consisitency.

    Fixes: 86af1d02d458 ("platform/x86: Support for EC-connected GPIOs for identify LED/button on Barco P50 board")
    Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
    Acked-by: Peter Korsgaard <peter.korsgaard@barco.com>
    Link: https://lore.kernel.org/r/20220526090345.1444172-1-jiasheng@iscas.ac.cn
    Signed-off-by: Hans de Goede <hdegoede@redhat.com>

> ---
 >  drivers/platform/x86/barco-p50-gpio.c | 1 -
 >  1 file changed, 1 deletion(-)

 > diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/barco-p50-gpio.c
 > index f5c72e33f9ae..bb8ed8e95225 100644
 > --- a/drivers/platform/x86/barco-p50-gpio.c
 > +++ b/drivers/platform/x86/barco-p50-gpio.c
 > @@ -14,7 +14,6 @@
 >  #include <linux/delay.h>
 >  #include <linux/dmi.h>
 >  #include <linux/err.h>
 > -#include <linux/io.h>
 >  #include <linux/kernel.h>
 >  #include <linux/leds.h>
 >  #include <linux/module.h>
 > --
 > 2.33.0


-- 
Bye, Peter Korsgaard
