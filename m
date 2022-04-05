Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064CC4F4510
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449061AbiDEUKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457062AbiDEQCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:02:42 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C743BF32AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:26:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r66so2474997pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kdycBsuX0g++/RcAqO3Nh9RpbFLdm52QoSaW2fF8jpA=;
        b=vWElyWYs5POabdNlTJG/H3Z8Mcd7e7W1xxw4ojO5DcfZmeJmBi4zgZ4udZCL5YkkJC
         gcfavDDrTarEbQoPO4Sdio+h9k3N6ADyEMGUi2aHg7GXp2palwloLsHgGZNrDlCbcL2x
         ar4hVSaUpOdRz3ORNcruxOquOe7N6t2NeatyyU3qjlHvvq9TbTKXi+s+9icEwa4BgjH9
         5FLHspkniaM0KwAJhgpa6Du4DK5nYVmJaiJmRAazUcC+uPIvQ5xOHHuogY1cNOTeyxSw
         vwjjpLCs1Q0xNLcF7g4oMhTJZaF7Drg3jNvA6UtPNtKESTPExorYtxrIBGkXbYKmJIcb
         WNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kdycBsuX0g++/RcAqO3Nh9RpbFLdm52QoSaW2fF8jpA=;
        b=Jv7Ivd2/auhPsSn3ZZtq3ooK581rzGR5eNMIKG7mvV0dA4KhoqkVXsQZySMyAJ3BEm
         q6glG8ieRMypE7dHnoqxrk4Vm8ZwQbLOtfgufZXsHS2ebwh6Ir7GPTjswH9Vs/x7ZxwR
         Le2iyC7I15lMqIKdOuKrxAabxtSNg9VfRo31dA1kYMCT9GlnKaOEdGFGe6vMuvfO+cz5
         55024OXMm2F6ftD9X+y0I0rIWenizXwEaqZY/+Pe9PtXa89P5fwZyt6jiiMRsXhAbEP5
         v4pjeZ6TJxDXAnx2WZLf/1vXA5WP3G+FVFXiyywIvlijWnbpuPGYwca80VvzPT4j5Z3q
         G9Gg==
X-Gm-Message-State: AOAM532uLwMhp1R/EYKfPsNV+TnAykkoN1MRSyxReXdKVIZB54jcvZrh
        XG2NMlgTouO/T0Befr+VrDMIUA==
X-Google-Smtp-Source: ABdhPJzrbX/Sddjrknw9Kh/d2WHnv7CItd5Pk7DXrwOfNDQD+F5B4NYZiMWJySrhddyqzsAOE88YMg==
X-Received: by 2002:a65:6813:0:b0:384:b288:8702 with SMTP id l19-20020a656813000000b00384b2888702mr3339475pgt.275.1649172413085;
        Tue, 05 Apr 2022 08:26:53 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090ab79500b001ca3c46ba2fsm2737681pjr.24.2022.04.05.08.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:26:52 -0700 (PDT)
Date:   Tue, 5 Apr 2022 09:26:49 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v2] RISC-V: configs: Configs that had RPMSG_CHAR now get
 RPMSG_CTRL
Message-ID: <20220405152649.GC4147585@p14s>
References: <20220405115729.1020889-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405115729.1020889-1-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:57:29PM +0200, Arnaud Pouliquen wrote:
> In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
> from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
> By default give everyone who had the old driver enabled the rpmsg_ctrl
> driver too.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
> 
> This patch is extracted from the series [1] that has been partially
> integrated in the Linux Kernel 5.18-rc1.
> 
> Update vs previous version:
> - remove "Fixes:" tag in commit, requested by Mathieu Poirier in [2]
> 
> [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
> [2]https://lore.kernel.org/linux-arm-kernel/CANLsYky1_b80qPbgOaLGVYD-GEr21V6C653iGEB7VCU=GbGvAQ@mail.gmail.com/T/
> ---
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 30e3017f22bc..0cc17db8aaba 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -101,6 +101,7 @@ CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_INPUT=y
>  CONFIG_VIRTIO_MMIO=y
>  CONFIG_RPMSG_CHAR=y
> +CONFIG_RPMSG_CTRL=y
>  CONFIG_RPMSG_VIRTIO=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 7e5efdc3829d..6cd9d84d3e13 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -93,6 +93,7 @@ CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_INPUT=y
>  CONFIG_VIRTIO_MMIO=y
>  CONFIG_RPMSG_CHAR=y
> +CONFIG_RPMSG_CTRL=y
>  CONFIG_RPMSG_VIRTIO=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.25.1
> 
