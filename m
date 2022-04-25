Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9075550E493
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbiDYPlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239227AbiDYPlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:41:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21A444A17;
        Mon, 25 Apr 2022 08:38:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z99so18897591ede.5;
        Mon, 25 Apr 2022 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lyKb4FdguiCq+rrS9QTQp8nb4hp+SYmLFGLR3Wa4zP0=;
        b=oR0hgVe+fDdxZD9+CK6avbwwxst9IxTbsMtLq6aW8nl049044HLXTgVi9nHCY+Qc5n
         GMmxTLe9j6AsomYiIspYq9X9YCBjYb3QrCgO8e75oi5Ip2iR02r/0xDDKIkN8H1V6398
         DH6oUE+7acEJ3s3LcKhnf8heFGPMFI6NahiyzttiY/ZuPZH/iQpUsjjgiZ72ISHVHT2z
         2KB4ViwjkhWkcWf4b6u6ZOACe4oj+ACgcDAqUtvRFigC8GlOAdb8EKLWIFqsR7uj3FgR
         CfhJl9XUC0NooRA5BFTahfsDuLxzdbTtqP56TE5L6rOke5C+YgB+2Mi4TOTlVYB2TmN7
         BiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lyKb4FdguiCq+rrS9QTQp8nb4hp+SYmLFGLR3Wa4zP0=;
        b=GBTYKmbqkeGLzq3wFKY/CMyvV7QxKtKR5bD+arH4cYqF4BeE/dFaaf5aEGIR4TwtZN
         rm+tbsdfctJ5SA43z7fIcfIsNBABGv8jtH457FcvrZvC2t5X+VGcy7PSt0LRrVXydX4w
         QBrunsuARKjiDk926aYpEYpIJ0sMi3iAARPO+Mjn9dXSw1iULXAhZxHhb+giNmsgvx0h
         I3lDkJrgXk5DAs+Fdi9juTHAkWlo4Oz0ureTAlgi/N0u99V0oCcGWQVev8U7h5vyFUsV
         oferHz6cwmJUyns6yKIzsoMhm3/OhZ4u9VbU4GDc7G3r6B0vzhf4OOvGfw2LSm4z5JFJ
         MGqA==
X-Gm-Message-State: AOAM531+TUjW1FgYyskCTcm4Eklbdmlxz7nKJ2MfjHTX+6CXAtgZWLo8
        d+qkOfpi6y04aUge2eXDCIA=
X-Google-Smtp-Source: ABdhPJy7/i2EjP7Cft8S7OWZdF41cMgkZwTrPEfilPCAN8PeG/6lORkVjz6ueYqKFCMOyADTntHYyA==
X-Received: by 2002:a05:6402:1e93:b0:424:1b50:688d with SMTP id f19-20020a0564021e9300b004241b50688dmr19810193edf.405.1650901119465;
        Mon, 25 Apr 2022 08:38:39 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906505600b006da7d71f25csm3747575ejk.41.2022.04.25.08.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:38:39 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] mmc: sunxi-mmc: Fix DMA descriptors allocated above 32 bits
Date:   Mon, 25 Apr 2022 17:38:37 +0200
Message-ID: <7372337.EvYhyI6sBW@kista>
In-Reply-To: <20220424231751.32053-1-samuel@sholland.org>
References: <20220424231751.32053-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 25. april 2022 ob 01:17:50 CEST je Samuel Holland napisal(a):
> Newer variants of the MMC controller support a 34-bit physical address
> space by using word addresses instead of byte addresses. However, the
> code truncates the DMA descriptor address to 32 bits before applying the
> shift. This breaks DMA for descriptors allocated above the 32-bit limit.
> 
> Fixes: 3536b82e5853 ("mmc: sunxi: add support for A100 mmc controller")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
>  drivers/mmc/host/sunxi-mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index c62afd212692..46f9e2923d86 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -377,8 +377,9 @@ static void sunxi_mmc_init_idma_des(struct 
sunxi_mmc_host *host,
>  		pdes[i].buf_addr_ptr1 =
>  			cpu_to_le32(sg_dma_address(&data->sg[i]) >>
>  				    host->cfg->idma_des_shift);
> -		pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc >>
> -						    host-
>cfg->idma_des_shift);
> +		pdes[i].buf_addr_ptr2 =
> +			cpu_to_le32(next_desc >>
> +				    host->cfg->idma_des_shift);
>  	}
>  
>  	pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
> -- 
> 2.35.1
> 
> 


