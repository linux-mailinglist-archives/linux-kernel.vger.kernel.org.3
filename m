Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEB350C6B2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiDWCob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiDWCo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:44:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390D91F6255
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 19:41:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d15so14706208pll.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 19:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=REmfpzw1xMslNBXNKTYCRBYBhCFLFRCkqr4sRav5rgY=;
        b=4WeFBWPm+HwABfSRIIkgJWStFSAErKQ/PmL1rmQcC8lm1M4HPRnhWaTMlxULv/SJGz
         ZgQ+tx/5aektTp0kYDf9FspiE/y5Zv7s8DUB6Esf1qL39NDJqj3bXDRhACiW3YnolmTB
         P+qGJIIMZ8W9gNEo+ngQg63rzScAPaKDmbLMZ2pcxKUvkNQR1PB0iuJc+ZmFhJqek+Jt
         TJYj3VMtSZFbSsbpRAu9X7+MqLSBKd5OKX8QYOQQIWMVV4CSO2spuqMfg2Nsi0wCxfpT
         dRfP1s9+4hfKrzJYg+TxTWs1NHV8mfHUa9Uv5mFJKQ94O/WpZ44cF+dHvqMg9aYA3Um/
         MTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=REmfpzw1xMslNBXNKTYCRBYBhCFLFRCkqr4sRav5rgY=;
        b=p5ytj4Q2SKGcV0zK2c9U8AXKP59JtM5eB+KwoZ7KWc+wiSyqY9r1Nnl242Gzs5R6cA
         hTO/AUG7VEHcJb97Nq7DbEDxXWIIgF7PSjgJz0YR+aekSuLqS8U7WQ5nAEWxWLokC/Zz
         b2GDg0L5hT0qv0UzUb44D9urg4XW+PfbWSyXAWWnQEWaffiHIta0VfT12W703pS81LgW
         BPD4fnJz3d/0c6DYQCyo+fL5KtSPlCrS4q1JUAhGI3c0bxC6Fp9p5nG3yuMY3ldEeQ5K
         H36HlIoEA0WnmGxONiT0KU8m4BOpTlKvt4mhV3BqSgfng8O7yKpa9jwEMPTSSqIWUmfb
         nqqA==
X-Gm-Message-State: AOAM533xJvEoIab+PATBWeKRZTBiU5Qw2f3d6nvQrTHcbnvz8NlV3sca
        a1R4TQtTr8GTKqq9o8w+NpA9aw==
X-Google-Smtp-Source: ABdhPJzTDUsXmUPRCkNu/YoxmSMlqJ3ANNR0+ezB3YEc/HXUrEK20xXuSZtgCWqoud9K1+OVziq2Cg==
X-Received: by 2002:a17:903:18f:b0:15a:1cc6:48f5 with SMTP id z15-20020a170903018f00b0015a1cc648f5mr7521584plg.161.1650681691627;
        Fri, 22 Apr 2022 19:41:31 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id ch10-20020a056a00288a00b0050a51a95e91sm3614749pfb.201.2022.04.22.19.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 19:41:30 -0700 (PDT)
Date:   Fri, 22 Apr 2022 19:41:30 -0700 (PDT)
X-Google-Original-Date: Fri, 22 Apr 2022 19:26:44 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
In-Reply-To: <20220404090527.582217-1-arnaud.pouliquen@foss.st.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        anup@brainfault.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     arnaud.pouliquen@foss.st.com
Message-ID: <mhng-540193db-7721-4cd3-935a-be485b4af058@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Apr 2022 02:05:27 PDT (-0700), arnaud.pouliquen@foss.st.com wrote:
> In the patch 617d32938d1b: "rpmsg: Move the rpmsg control device
> from rpmsg_char to rpmsg_ctrl", we split the rpmsg_char driver in two.
> By default give everyone who had the old driver enabled the rpmsg_ctrl
> driver too.
>
> Fixes: 617d32938d1b ("rpmsg: Move the rpmsg control device from rpmsg_char to rpmsg_ctrl", 2022-01-24)
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
> this patch is extracted from the series [1] that has been partially
> integrated in the Linux Kernel 5.18-rc1.
>
> [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
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

Thanks, this is on fixes.
