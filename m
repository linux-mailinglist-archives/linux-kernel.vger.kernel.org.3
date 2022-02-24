Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55204C24D8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiBXIEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBXIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:04:21 -0500
X-Greylist: delayed 83 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 00:03:50 PST
Received: from www.kot-begemot.co.uk (ivanoab7.miniserver.com [37.128.132.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E671A2704
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:03:50 -0800 (PST)
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1nN96F-000Ab2-TW; Thu, 24 Feb 2022 08:03:48 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1nN96C-008sD3-HN; Thu, 24 Feb 2022 08:03:43 +0000
Subject: Re: [PATCH] Input: samsung-keypad - Properly state IOMEM dependency
To:     David Gow <davidgow@google.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org
References: <20220224035819.1593730-1-davidgow@google.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <19c9bf24-c3e1-36a3-376e-7091cc3b3f62@cambridgegreys.com>
Date:   Thu, 24 Feb 2022 08:03:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220224035819.1593730-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2022 03:58, David Gow wrote:
> Make the samsung-keypad driver explicitly depend on CONFIG_IOMEM, as it
> calls devm_ioremap(). This prevents compile errors in some configs (e.g,
> allyesconfig/randconfig under UML):
> 
> /usr/bin/ld: drivers/input/keyboard/samsung-keypad.o: in function `samsung_keypad_probe':
> samsung-keypad.c:(.text+0xc60): undefined reference to `devm_ioremap'
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>   drivers/input/keyboard/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 0c607da9ee10..5c98d5f996e4 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -556,7 +556,7 @@ config KEYBOARD_PMIC8XXX
>   
>   config KEYBOARD_SAMSUNG
>   	tristate "Samsung keypad support"
> -	depends on HAVE_CLK
> +	depends on IOMEM && HAVE_CLK
>   	select INPUT_MATRIXKMAP
>   	help
>   	  Say Y here if you want to use the keypad on your Samsung mobile
> 
Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
