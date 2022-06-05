Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE7753DAC4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348751AbiFEHs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 03:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiFEHsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 03:48:20 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A4A26121
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Nb946ADPU8+F5cp0E+j5t/xiaYdvwB7u7ZX/wWM6fZs=;
        b=bhzEdrT76xVrGwzdECLBx2qcs7fOPfbDZNBxVC+SLhK6o0kvAUUX4WUOc2TPcGBeiQB+357HgkG5z
         GHdnIh0xTFew95Zxb3GKCa+b2lzutS8P8shd+SuKhgfd8ywctHXQGlnH9BF5g7MZrnqxpCglEq/ed2
         4n5L6L0CiObwis86n47v/RgNc4tvRpCkmzpleVEi98yaw0xRqv3w7X26zsAWhok25zYyHVh4KtGbUv
         KM7uBCKV2hB0Xjzo7nBuHm6nIbWizTjVvg80WxKGmTo/iANAMCTxfO/B+JzQn6hPgWaWgf1TRlxXA2
         B4zEdYjh3g8gx6kSrnc2IQ85iW2XiqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Nb946ADPU8+F5cp0E+j5t/xiaYdvwB7u7ZX/wWM6fZs=;
        b=s9zwhB7yQlTyveNdqGSACc4SeMy8tUDMCXEgHqEGV3IU1PaGEN4OS6oaXLk4WOYA15JLebeOOppBW
         O7oEe7oDQ==
X-HalOne-Cookie: 5bac6b0e734b689d45c0ffd4db3f3b5ce36b8985
X-HalOne-ID: daab1d3c-e4a3-11ec-8231-d0431ea8bb10
Received: from mailproxy2.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id daab1d3c-e4a3-11ec-8231-d0431ea8bb10;
        Sun, 05 Jun 2022 07:48:14 +0000 (UTC)
Date:   Sun, 5 Jun 2022 09:48:12 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Hellstrom <daniel@gaisler.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc32,leon: Fix reference leak in leon_ipi_init
Message-ID: <YpxfvKVTBkZRpXTy@ravnborg.org>
References: <20220605052943.54265-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605052943.54265-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 09:29:41AM +0400, Miaoqian Lin wrote:
> of_find_node_by_path() returns a node pointer with
> refcount incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 1ca0c808c60f ("sparc32,leon: Implemented SMP IPIs for LEON CPU")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

The patch is finei, thanks:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

All other uses of of_find_node_by_path() in sparc has the same issue.
Could you try to take a look at the rest too?

	Sam
> ---
>  arch/sparc/kernel/leon_smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
> index 1eed26d423fb..85b22669c002 100644
> --- a/arch/sparc/kernel/leon_smp.c
> +++ b/arch/sparc/kernel/leon_smp.c
> @@ -284,6 +284,7 @@ static void __init leon_ipi_init(void)
>  		pp = of_find_property(rootnp, "ipi_num", &len);
>  		if (pp && (*(int *)pp->value))
>  			leon_ipi_irq = *(int *)pp->value;
> +		of_node_put(rootnp);
>  	}
>  	printk(KERN_INFO "leon: SMP IPIs at IRQ %d\n", leon_ipi_irq);
>  
> -- 
> 2.25.1
