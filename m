Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039CC4F1791
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiDDOuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378258AbiDDOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:49:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA026449;
        Mon,  4 Apr 2022 07:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 858B5B815AA;
        Mon,  4 Apr 2022 14:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A597FC340EE;
        Mon,  4 Apr 2022 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649083553;
        bh=k9WAcFBCFfb+3TY2XrOQKaVZhD+Dcxfd/5cZ6RmH+D4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4SvhD9u8ufJSVbfTnoJX2D4cS2Z0ggUcxa/IR5dnmJ8NSOTR7xfILZAzjGHcr/JW
         e4M47qdBhXdxqmjzbckSKIsTr4tjgA70Q7WU5fIEpfD8ffMjmRhz8SnPZkT5nDtksg
         SsrhO+Iqx038tynbid79VN1Dcu/cAwwcduH2S0nE=
Date:   Mon, 4 Apr 2022 16:45:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Johan Hovold <johan@kernel.org>,
        Yang Guang <yang.guang5@zte.com.cn>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_aspeed_vuart: Fix potential NULL
 dereference in aspeed_vuart_probe
Message-ID: <YksEnnyJDoL+fE5d@kroah.com>
References: <20220404143842.16960-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404143842.16960-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 02:38:40PM +0000, Miaoqian Lin wrote:
> platform_get_resource() may fail and return NULL, so we should
> better check it's return value to avoid a NULL pointer dereference.
> 
> Fixes: 54da3e381c2b ("serial: 8250_aspeed_vuart: use UPF_IOREMAP to set up register mapping")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 93fe10c680fb..9d2a7856784f 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -429,6 +429,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>  	timer_setup(&vuart->unthrottle_timer, aspeed_vuart_unthrottle_exp, 0);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;

How did you test this change was correct?
