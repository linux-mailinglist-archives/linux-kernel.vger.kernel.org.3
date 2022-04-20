Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6115081BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359611AbiDTHLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiDTHLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:11:12 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADCB2E0A9;
        Wed, 20 Apr 2022 00:08:27 -0700 (PDT)
Received: from pyrite.rasen.tech (softbank114048062035.bbtec.net [114.48.62.35])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3DE1C25B;
        Wed, 20 Apr 2022 09:08:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1650438506;
        bh=660hDm8g+tKmivxQ/wa40tMJVujuie8GXITDeJZR+ME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdBFr2suV33dZeLTB7eG9PU6XRB6glWghOkrC8PjAWvW/L+8Emh4them1QqUqg2+Z
         FngtSR1JPY7Y5Si4yMfMOuULk3odTAOtrd4kg9EFe69WzSMedE8/LoGgMkhi3nz7Js
         x3nH0V1BvIC++zGpN+RVwaY0M7HYeVt4WYjWwPk4=
Date:   Wed, 20 Apr 2022 16:08:17 +0900
From:   paul.elder@ideasonboard.com
To:     "Haifeng" <haifeng.li@timesintelli.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]usb: gadget: musb: Fix the DMA transfer error for
 Isochronous transfers
Message-ID: <20220420070817.GC3237525@pyrite.rasen.tech>
References: <001401d85247$2c66cd40$853467c0$@timesintelli.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401d85247$2c66cd40$853467c0$@timesintelli.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Haifeng,

On Sun, Apr 17, 2022 at 06:37:44PM +0800, Haifeng wrote:
> For Isochronous transfer mode, the ISO bit should be kept in CSR.
> Otherwise, the DMA transfer will be terminated unexpected since
> the ISO bit is missed once the last packet is a short packet.
> 
> Signed-off-by: Haifeng Li <haifeng.li@timesintelli.com>

Looks good to me.

Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>

> ---
>  drivers/usb/musb/musb_gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 51274b87f46c..b99faf627dce 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -482,7 +482,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>  			if (csr & MUSB_TXCSR_TXPKTRDY)
>  				return;
>  
> -			musb_writew(epio, MUSB_TXCSR, MUSB_TXCSR_MODE
> +			musb_writew(epio, MUSB_TXCSR, csr | MUSB_TXCSR_MODE
>  					| MUSB_TXCSR_TXPKTRDY);
>  			request->zero = 0;
>  		}
> -- 
> 2.17.1
> 
