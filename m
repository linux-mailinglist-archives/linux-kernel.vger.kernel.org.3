Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2D559EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiFXQsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiFXQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:48:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5A449918
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:48:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id r1so2574501plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7vaOGSSaS2BSeF0eCGOBdnJBKLvorCKIGcPWI6JfN0M=;
        b=y/IbSUpXpt2dGe1jDFLOsSSUkh1YBHRUnJmUb8sFZZm5NLih02wnUPXYt5zjjKeypb
         5Ffpu8piazgJRDNC42kW6T6j1S8K0mebrE7N0RwQPnfu+w8dFmATyybUe8Li6Ax2Pbsq
         6i0tJIm6mnulrZuaP8LlD+bk0IDIh7ztPilxJLZ2r82xW5PSaATQjSK6ypPckDxrjzPQ
         1bJK58MfXrbD6UbHeCtj6QwHeNzd3TOhfuFAniLjlYZ5xRUrZA93EYYGbms/FfDtCwRZ
         fD3/L6ZsvUORcp5roVkzX0bDUqQJrvcXD+t6BkwOR2kijU8lP3ghEMss2dpRQ7RGgeA7
         3xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vaOGSSaS2BSeF0eCGOBdnJBKLvorCKIGcPWI6JfN0M=;
        b=EjhB4xFFS0ayV3nJhx0Ct08hefIjCHQhB2vetHXOgjCSTGfm5RMIG4xlPsEAqSDObE
         1txj8AgcuPljJGmENszB4FIjHSj1TtTAlG6ob3MRjWsQvnMDe0LAWAl7rCvv4H5kPnE7
         7AKtihu8yCZ8QoolcroCrrxm4zIIaQjl8O5qlgCNSh9c7sGsTYdhuDSXbPZ/05PEnZp8
         kAVZSg6EWajGXdqACkmVURIuT6cXK1e2FoE94+yrPyaNVEHZwK1belaSorTcKChDPVuY
         8Zd96ipXXc/QC4lsKlTMBNpd+QqDga98qY1PdJhezS2HqN851L3VpJpHcQGTcenChVA4
         4Fqg==
X-Gm-Message-State: AJIora/6a1SE3lx6FclVHRCo92a8Naa1vB8YYjqbZbMeH0nNHGnCRCGj
        qLvGbARtLUzxu6wc8cMI1TXl9A==
X-Google-Smtp-Source: AGRyM1sMTKHk1czlE8w1vn1du6WoyJEAfH19Gy+e0hnTwhXskgrBEnEhnbwsZHR1W2asFkceOKtghg==
X-Received: by 2002:a17:902:e8d7:b0:168:e2da:893c with SMTP id v23-20020a170902e8d700b00168e2da893cmr45709631plg.152.1656089318365;
        Fri, 24 Jun 2022 09:48:38 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f70900b001663cf001besm2033477plo.174.2022.06.24.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 09:48:36 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:48:34 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     bjorn.andersson@linaro.org, robin.murphy@arm.com, hch@lst.de,
        m.szyprowski@samsung.com, matthias.bgg@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com
Subject: Re: [PATCH 0/2] dma-mapping, remoteproc: Fix dma_mem leak after
 rproc_shutdown
Message-ID: <20220624164834.GA1736477@p14s>
References: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:24:34PM +0800, Mark-PK Tsai wrote:
> Release dma coherent memory before rvdev is free in
> rproc_rvdev_release().
> 
> Below is the kmemleak report:
> unreferenced object 0xffffff8051c1a980 (size 128):
>   comm "sh", pid 4895, jiffies 4295026604 (age 15481.896s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000003a0f3ec0>] dma_declare_coherent_memory+0x44/0x11c
>     [<00000000ad243164>] rproc_add_virtio_dev+0xb8/0x20c
>     [<00000000d219c8e9>] rproc_vdev_do_start+0x18/0x24
>     [<00000000e694b468>] rproc_start+0x22c/0x3e0
>     [<000000000b938941>] rproc_boot+0x4a4/0x860
>     [<000000003c4dc532>] state_store.52856+0x10c/0x1b8
>     [<00000000df2297ac>] dev_attr_store+0x34/0x84
>     [<0000000083a53bdb>] sysfs_kf_write+0x60/0xbc
>     [<000000008ed830df>] kernfs_fop_write+0x198/0x458
>     [<0000000072b9ad06>] __vfs_write+0x50/0x210
>     [<00000000377d7469>] vfs_write+0xe4/0x1a8
>     [<00000000c3fc594e>] ksys_write+0x78/0x144
>     [<000000009aef6f4b>] __arm64_sys_write+0x1c/0x28
>     [<0000000003496a98>] el0_svc_common+0xc8/0x22c
>     [<00000000ea3fe7a3>] el0_svc_compat_handler+0x1c/0x28
>     [<00000000d1a85a4e>] el0_svc_compat+0x8/0x24
> 
> Mark-PK Tsai (2):
>   dma-mapping: Add dma_release_coherent_memory to DMA API
>   remoteproc: Fix dma_mem leak after rproc_shutdown
> 
>  drivers/remoteproc/remoteproc_core.c |  1 +
>  include/linux/dma-map-ops.h          |  3 +++
>  kernel/dma/coherent.c                | 10 ++++++++--
>  3 files changed, 12 insertions(+), 2 deletions(-)

Applied.

Thanks,
Mathieu

> 
> -- 
> 2.18.0
> 
