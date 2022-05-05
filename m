Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E3651C2B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378668AbiEEOli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiEEOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:41:35 -0400
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC19853A43;
        Thu,  5 May 2022 07:37:55 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 4E558440F39;
        Thu,  5 May 2022 17:36:58 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1651761418;
        bh=YKpQePxu2a+ZeS7IXYXOK7QZI9aPzC1QorvRu4TfF58=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=nPsokUTenIiWaJ4S8OJO9pB/xvlgAdOVqNlCq5iThlZqza+uc/Ra2IUiG8gdjC0Sa
         I9BDG250OJq5Lauf8STOlphUvMZ15ZIsU/hR7H3FoLufpOFeaTtK+ZbSqcO8YEWdg7
         DaF0tVIaihHhnL9YAYJl41CdakzPctGTYM/19F9BF4YQqyQSbNuGdw/JaGR2EubwDh
         KsEAiDnSLaJL75WaVxcsxMb8QR+452URXbM/+eE3MbhjFHiagxrsg6pVQw8lzn5zQg
         rgQ/BV2IxzCjoON5Ohvx3odPBAU6bLP/ed5DO41bMyin7kbEM29ymK0trVxCo5k/iv
         RA1Of6ec9AmuQ==
References: <20220505124621.1592697-1-yangyingliang@huawei.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Subject: Re: [PATCH] tty/serial: digicolor: fix possible null-ptr-deref in
 digicolor_uart_probe()
Date:   Thu, 05 May 2022 17:36:36 +0300
In-reply-to: <20220505124621.1592697-1-yangyingliang@huawei.com>
Message-ID: <87h764hwow.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Thu, May 05 2022, Yang Yingliang wrote:
> It will cause null-ptr-deref when using 'res', if platform_get_resource()
> returns NULL, so move using 'res' after devm_ioremap_resource() that
> will check it to avoid null-ptr-deref.
> And use devm_platform_get_and_ioremap_resource() to simplify code.
>
> Fixes: 5930cb3511df ("serial: driver for Conexant Digicolor USART")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/tty/serial/digicolor-usart.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
> index 6d70fea76bb3..e37a917b9dbb 100644
> --- a/drivers/tty/serial/digicolor-usart.c
> +++ b/drivers/tty/serial/digicolor-usart.c
> @@ -471,11 +471,10 @@ static int digicolor_uart_probe(struct platform_device *pdev)
>  	if (IS_ERR(uart_clk))
>  		return PTR_ERR(uart_clk);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	dp->port.mapbase = res->start;
> -	dp->port.membase = devm_ioremap_resource(&pdev->dev, res);
> +	dp->port.membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(dp->port.membase))
>  		return PTR_ERR(dp->port.membase);
> +	dp->port.mapbase = res->start;
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
