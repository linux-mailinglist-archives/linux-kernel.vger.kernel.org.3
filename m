Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314424E6872
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346569AbiCXSOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352531AbiCXSOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:14:39 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10089E32
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:13:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t13so3227851pgn.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B9ualNSGObXfxaCa3kXHHyApJTXDIAKHdNNtrcoqJWI=;
        b=MExshGDIxKjIurGB37rYruuvymM2AkRYuBHIbyagDRS4ILfNBgz/dqnyI/Zw7/0JLH
         wZNN5AvUoo66OL1cIYxX8fmi9tBe5WoWxqfanEtjTeLdkgLWSTC7xX3kZofmZDu2ua96
         qqlcrHM0i7sC6MJ9DvDQfJp9gB5x7jqqtv7Ty4ybLZDUVKYRh4Sv/JH9i+SzLgdveqSS
         aFzL65g/6jhnp/55WnFCQyqq799VHArujGpCYA8SAPa3ORWs8mP5GpKP8wo4xTyB9qNc
         RFM11wud888ixz7h25LQpeYIAFQ+FuNkOEBxfuMpPcfLMaVNNOIxsz4tAPgi1r8oD0Fz
         RKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B9ualNSGObXfxaCa3kXHHyApJTXDIAKHdNNtrcoqJWI=;
        b=7U7xp5fA1CL5XI9aZ1RRqnpGcGiB+fQTdZwBAxjRCUK8byZvgRUfNn5TLUlxJcIAPB
         BAvP/1FkDokRA7p2diEZG2dRETroLGTSI6s/zWZmuJhiCjVORTMfqISxYD7qM88g9d4p
         NBxywOMi6H77pO19Ufq7lEWASYU4//s2CYOwYuD/JF3szpq0YuUSn7fFdC4S0niVt4/t
         eGRi05C5uEqypEW5K+deNS1kcgn/Rv5B4fh1d3Uoak4i0Jd0PtOYttmRggUqyu+RM0B1
         0MPXdX7fcedTXgZkBS4LQdU+uvEksR0JI1k1kHLcIkWP8VQy+MXpyR2ecYi+97YDkYN+
         FmeQ==
X-Gm-Message-State: AOAM532fbQiZv26yWymyrqZl/Rae2e8I/15mJH8wTDgMnWKy0T2n7GgB
        tV/IPo2u8ZIDR5Oqc6piYuX9
X-Google-Smtp-Source: ABdhPJyF08kfFc5MvihMf3hsgPrkVapyZtyaD61zjIxm3Yzhqocq4XWT/5Us5T8udLRICCL93zyNOw==
X-Received: by 2002:a05:6a00:b8e:b0:4fa:de88:9fc7 with SMTP id g14-20020a056a000b8e00b004fade889fc7mr6314709pfj.56.1648145582915;
        Thu, 24 Mar 2022 11:13:02 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id d18-20020a056a0010d200b004fa2e13ce80sm4244469pfu.76.2022.03.24.11.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 11:13:02 -0700 (PDT)
Date:   Thu, 24 Mar 2022 23:42:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/25] dmaengine: dw-edma: Stop checking
 debugfs_create_*() return value
Message-ID: <20220324181255.GV2854@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-14-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:24AM +0300, Serge Semin wrote:
> First of all they never return NULL. So checking their return value for
> being not NULL just pointless. Secondly the DebugFS subsystem is designed
> in a way to be used as simple as possible. So if one of the
> debugfs_create_*() method in a hierarchy fails, the following methods will
> just silently return the passed erroneous parental dentry. Finally the
> code is supposed to be working no matter whether anything DebugFS-related
> fails. So in order to make code simpler and DebugFS-independent let's drop
> the debugfs_create_*() methods return value checking in the same way as
> the most of the kernel drivers do.
> 
> Note in order to preserve some memory space we suggest to skip the DebugFS
> nodes initialization if the file system in unavailable.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Man

> ---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index 12845a2dc016..808eed212be8 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -100,9 +100,8 @@ static void dw_edma_debugfs_create_x32(const struct debugfs_entries entries[],
>  	int i;
>  
>  	for (i = 0; i < nr_entries; i++) {
> -		if (!debugfs_create_file_unsafe(entries[i].name, 0444, dir,
> -						entries[i].reg,	&fops_x32))
> -			break;
> +		debugfs_create_file_unsafe(entries[i].name, 0444, dir,
> +					   entries[i].reg, &fops_x32);
>  	}
>  }
>  
> @@ -168,8 +167,6 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
>  	char name[16];
>  
>  	regs_dir = debugfs_create_dir(WRITE_STR, dir);
> -	if (!regs_dir)
> -		return;
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
>  	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> @@ -184,8 +181,6 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
>  		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
>  
>  		ch_dir = debugfs_create_dir(name, regs_dir);
> -		if (!ch_dir)
> -			return;
>  
>  		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].wr, ch_dir);
>  
> @@ -237,8 +232,6 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
>  	char name[16];
>  
>  	regs_dir = debugfs_create_dir(READ_STR, dir);
> -	if (!regs_dir)
> -		return;
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
>  	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> @@ -253,8 +246,6 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
>  		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
>  
>  		ch_dir = debugfs_create_dir(name, regs_dir);
> -		if (!ch_dir)
> -			return;
>  
>  		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].rd, ch_dir);
>  
> @@ -273,8 +264,6 @@ static void dw_edma_debugfs_regs(void)
>  	int nr_entries;
>  
>  	regs_dir = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
> -	if (!regs_dir)
> -		return;
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
>  	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> @@ -285,6 +274,9 @@ static void dw_edma_debugfs_regs(void)
>  
>  void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
>  {
> +	if (!debugfs_initialized())
> +		return;
> +
>  	dw = chip->dw;
>  	if (!dw)
>  		return;
> @@ -294,8 +286,6 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
>  		return;
>  
>  	dw->debugfs = debugfs_create_dir(dw->name, NULL);
> -	if (!dw->debugfs)
> -		return;
>  
>  	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->chip->mf);
>  	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
> -- 
> 2.35.1
> 
