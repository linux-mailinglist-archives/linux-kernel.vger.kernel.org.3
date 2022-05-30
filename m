Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8FB538891
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243263AbiE3VU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241918AbiE3VUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:20:25 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0A46A428;
        Mon, 30 May 2022 14:20:22 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6D8F420005;
        Mon, 30 May 2022 21:20:16 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1nvmoB-006sq4-Sw; Mon, 30 May 2022 23:20:15 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     santoshkumar.yadav@barco.com, peter.korsgaard@barco.com,
        hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: Add check for
 platform_driver_register
References: <20220526090345.1444172-1-jiasheng@iscas.ac.cn>
Date:   Mon, 30 May 2022 23:20:15 +0200
In-Reply-To: <20220526090345.1444172-1-jiasheng@iscas.ac.cn> (Jiasheng Jiang's
        message of "Thu, 26 May 2022 17:03:45 +0800")
Message-ID: <87bkve4t0w.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jiasheng" == Jiasheng Jiang <jiasheng@iscas.ac.cn> writes:

 > As platform_driver_register() could fail, it should be better
 > to deal with the return value in order to maintain the code
 > consisitency.

 > Fixes: 86af1d02d458 ("platform/x86: Support for EC-connected GPIOs for
 > identify LED/button on Barco P50 board")

 > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Acked-by: Peter Korsgaard <peter.korsgaard@barco.com>


> ---
 >  drivers/platform/x86/barco-p50-gpio.c | 5 ++++-
 >  1 file changed, 4 insertions(+), 1 deletion(-)

 > diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/barco-p50-gpio.c
 > index 05534287bc26..8dd672339485 100644
 > --- a/drivers/platform/x86/barco-p50-gpio.c
 > +++ b/drivers/platform/x86/barco-p50-gpio.c
 > @@ -405,11 +405,14 @@ MODULE_DEVICE_TABLE(dmi, dmi_ids);
 >  static int __init p50_module_init(void)
 >  {
 >  	struct resource res = DEFINE_RES_IO(P50_GPIO_IO_PORT_BASE, P50_PORT_CMD + 1);
 > +	int ret;
 
 >  	if (!dmi_first_match(dmi_ids))
 >  		return -ENODEV;
 
 > -	platform_driver_register(&p50_gpio_driver);
 > +	ret = platform_driver_register(&p50_gpio_driver);
 > +	if (ret)
 > +		return ret;
 
 >  	gpio_pdev = platform_device_register_simple(DRIVER_NAME, PLATFORM_DEVID_NONE, &res, 1);
 >  	if (IS_ERR(gpio_pdev)) {
 > -- 

 > 2.25.1


-- 
Bye, Peter Korsgaard
