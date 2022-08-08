Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB84F58C53F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbiHHJFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiHHJF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:05:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0F85F7D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:05:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5BB8B80E23
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1B5C43470;
        Mon,  8 Aug 2022 09:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659949525;
        bh=D9qUF5UuvjzJ40cDcAJkTszFmP3h82udJTEW397VIfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AEFQSJcQva6qpoaL+9U1uZPpXwiHelkldRIqOiHIXVyHK+ZiEWCTDgyQ3vNrbcitU
         O53vvosfnZ/iMfUeAzCsz/nuGG7p1DTYxKCGA5PsnKF4FhAC6KgDAKHuvhq7U57MNH
         zXQoQAzRZwhYoU+yJSE0OtXEOkdq2O+JmNsXx/iyse7iPr9cRI8jiFkmULlrZ9synO
         OmwKFv3j/ZIH2S8ym231ieOLE/X9+UvpQfY5H/2IG+8jnY5e2Jhp2fZU4jC4DhxWTp
         PobQ7l7f1KF93G7SLtLJ5+eWvnv164EpTOWwdyKEm66UJQSZk3h7UE5FVISMc14lqm
         vFq5DTCqsFiwA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oKyhP-001ce3-5T;
        Mon, 08 Aug 2022 10:05:23 +0100
MIME-Version: 1.0
Date:   Mon, 08 Aug 2022 10:05:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] irqchip/loongson-pch-pic: Move find_pch_pic() into
 CONFIG_ACPI
In-Reply-To: <20220808085359.3351574-1-chenhuacai@loongson.cn>
References: <20220808085359.3351574-1-chenhuacai@loongson.cn>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <61d4525e971206082096fd86525f1fcc@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: chenhuacai@loongson.cn, tglx@linutronix.de, linux-kernel@vger.kernel.org, lixuefeng@loongson.cn, chenhuacai@gmail.com, jiaxun.yang@flygoat.com, lkp@intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-08 09:53, Huacai Chen wrote:
> MIPS doesn't declare find_pch_pic(), which makes a build warning:
> 
>>> drivers/irqchip/irq-loongson-pch-pic.c:51:5: warning: no previous 
>>> prototype for function 'find_pch_pic' [-Wmissing-prototypes]
>    int find_pch_pic(u32 gsi)
>        ^
>    drivers/irqchip/irq-loongson-pch-pic.c:51:1: note: declare 'static'
> if the function is not intended to be used outside of this translation
> unit
>    int find_pch_pic(u32 gsi)
>    ^
>    static
>    1 warning generated.
> 
> Move find_pch_pic() into CONFIG_ACPI which only used by LoongArch to 
> fix
> the warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-pch-pic.c | 38 +++++++++++++-------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c
> b/drivers/irqchip/irq-loongson-pch-pic.c
> index b6f1392964b1..b987b6517d59 100644
> --- a/drivers/irqchip/irq-loongson-pch-pic.c
> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
> @@ -48,25 +48,6 @@ static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
> 
>  struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
> 
> -int find_pch_pic(u32 gsi)
> -{
> -	int i;
> -
> -	/* Find the PCH_PIC that manages this GSI. */
> -	for (i = 0; i < MAX_IO_PICS; i++) {
> -		struct pch_pic *priv = pch_pic_priv[i];
> -
> -		if (!priv)
> -			return -1;
> -
> -		if (gsi >= priv->gsi_base && gsi < (priv->gsi_base + 
> priv->vec_count))
> -			return i;
> -	}
> -
> -	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
> -	return -1;
> -}
> -
>  static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
>  {
>  	u32 reg;
> @@ -325,6 +306,25 @@ IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0",
> pch_pic_of_init);
>  #endif
> 
>  #ifdef CONFIG_ACPI
> +int find_pch_pic(u32 gsi)
> +{
> +	int i;
> +
> +	/* Find the PCH_PIC that manages this GSI. */
> +	for (i = 0; i < MAX_IO_PICS; i++) {
> +		struct pch_pic *priv = pch_pic_priv[i];
> +
> +		if (!priv)
> +			return -1;
> +
> +		if (gsi >= priv->gsi_base && gsi < (priv->gsi_base + 
> priv->vec_count))
> +			return i;
> +	}
> +
> +	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
> +	return -1;
> +}
> +
>  static int __init
>  pch_lpc_parse_madt(union acpi_subtable_headers *header,
>  		       const unsigned long end)

While you're fixing this, can you also please fix this:

$ git grep find_pch_pic
arch/loongarch/include/asm/irq.h:extern int find_pch_pic(u32 gsi);
arch/loongarch/include/asm/irq.h:int find_pch_pic(u32 gsi);

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
