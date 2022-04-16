Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A4C5037F6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 21:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiDPTfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiDPTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 15:34:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1BF9968B;
        Sat, 16 Apr 2022 12:32:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k22so14237384wrd.2;
        Sat, 16 Apr 2022 12:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zKq3t9+WVckk287gJXVdTxBsvDIgk8B6FZnSS1BTPL4=;
        b=hFNxStPk6ljDQwSVsjzOkbywBaCgUHFTMhRf8KLzWQKkAK634TFpEv/iqqflmNmc+4
         H5nPQkWkiCU5YeKVCZyn9zW2a0IzF5fciuEckFnKEkxcMmv/IliYbvr7PY0OQC8wO1J7
         D5duSREpTHMOB/N5dyAEucbZIv8PnD3VrVhYI1hMKM8jNKMBLBmrtXkpuLAJsMzQUJHx
         kpO7aJeENbJYmrwewNwsbiwZirIGezWs9INOqa0rj/PUxb3hridsT8SLJtx94UvJ+/Ps
         B7zYWz90bX9w/cGmPrCiyYRos0wXG13wi8iUXmqdoaEhqNEpJqz/StjpZHP4ZnK7rHKI
         p4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zKq3t9+WVckk287gJXVdTxBsvDIgk8B6FZnSS1BTPL4=;
        b=d5Q+sD3DPL1gQTx8UXgShR1zYprNz1vamwRSmcgwfqJaor1CQRK9kpyaYYn2/GS3rS
         oMelwH9QdwQokm1zAB/yL1GIDnLY8LKSBkV9h0UJnjhouV3ez+AfCVTJCcpCbW38D6hL
         YGpnPFIEzxNf+TVD1Kmvb9i+x+v7tpX38FbkLlorV5yinMA2FilDTJYhae0H7vBEFnwP
         HbtAyXcp0fZd9UsTF+W4s0SyKvF78XZ6wEK1cRjv7knfqnyogowmw1ZU00pluxADx5jV
         BSIOhD4IUHCO9K3/OH13wnLz7Y2fo/R1pZT2y1Wkc1UFgZRqvPccKysL6MYkBc8M3JNB
         5nsQ==
X-Gm-Message-State: AOAM531W+hoBHzOZKKX/jj2J84NI5yVbaveTnI7PCpzg2BQFxCHZX2ek
        tgVe8SASd8Dri27lD6DlOa8=
X-Google-Smtp-Source: ABdhPJwXXdg4aIH03y8wvyozMGxucmhHV8S1YG4lSMDVE8AYMR7NHA91JGYnlXTGTd4gigMfa1nlvQ==
X-Received: by 2002:a05:6000:1568:b0:1f0:250a:d3ef with SMTP id 8-20020a056000156800b001f0250ad3efmr3322201wrz.402.1650137543384;
        Sat, 16 Apr 2022 12:32:23 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm6798423wrg.62.2022.04.16.12.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 12:32:22 -0700 (PDT)
Date:   Sat, 16 Apr 2022 21:32:21 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        cmuellner@linux.com, philipp.tomsich@vrull.eu,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: implement Zicbom-based CMO instructions + the
 t-head variant
Message-ID: <YlsZxVjgt3ZNQ7Ub@Red>
References: <20220307224620.1933061-1-heiko@sntech.de>
 <YllWTN+15CoskNBt@Red>
 <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org>
 <YlpxsYREWv/LQ+HY@Red>
 <849a3728-7e84-4f26-0c73-4d68eae9ae01@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <849a3728-7e84-4f26-0c73-4d68eae9ae01@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Apr 16, 2022 at 12:47:29PM -0500, Samuel Holland a écrit :
> On 4/16/22 2:35 AM, Corentin Labbe wrote:
> > Le Fri, Apr 15, 2022 at 09:19:23PM -0500, Samuel Holland a écrit :
> >> On 4/15/22 6:26 AM, Corentin Labbe wrote:
> >>> Le Mon, Mar 07, 2022 at 11:46:18PM +0100, Heiko Stuebner a écrit :
> >>>> This series is based on the alternatives changes done in my svpbmt series
> >>>> and thus also depends on Atish's isa-extension parsing series.
> >>>>
> >>>> It implements using the cache-management instructions from the  Zicbom-
> >>>> extension to handle cache flush, etc actions on platforms needing them.
> >>>>
> >>>> SoCs using cpu cores from T-Head like the Allwinne D1 implement a
> >>>> different set of cache instructions. But while they are different,
> >>>> instructions they provide the same functionality, so a variant can
> >>>> easly hook into the existing alternatives mechanism on those.
> >>>>
> >>>>
> >>>
> >>> Hello
> >>>
> >>> I am testing https://github.com/smaeul/linux.git branch:origin/riscv/d1-wip which contain this serie.
> >>>
> >>> I am hitting a buffer corruption problem with DMA.
> >>> The sun8i-ce crypto driver fail self tests due to "device overran destination buffer".
> >>> In fact the buffer is not overran by device but by dma_map_single() operation.
> >>>
> >>> The following small code show the problem:
> >>>
> >>> dma_addr_t dma;
> >>> u8 *buf;
> >>> #define BSIZE 2048
> >>> #define DMASIZE 16
> >>>
> >>> buf = kmalloc(BSIZE, GFP_KERNEL | GFP_DMA);
> >>> for (i = 0; i < BSIZE; i++)
> >>>     buf[i] = 0xFE;
> >>> print_hex_dump(KERN_INFO, "DMATEST1:", DUMP_PREFIX_NONE, 16, 4, buf, 256, false);
> >>> dma = dma_map_single(ce->dev, buf, DMASIZE, DMA_FROM_DEVICE);
> >>
> >> This function (through dma_direct_map_page()) ends up calling
> >> arch_sync_dma_for_device(..., ..., DMA_FROM_DEVICE), which invalidates the CPU's
> >> cache. This is the same thing other architectures do (at least arm, arm64,
> >> openrisc, and powerpc). So this appears to be working as intended.
> > 
> > This behavour is not present at least on ARM and ARM64.
> > The sample code I provided does not corrupt the buffer on them.
> 
> That can be explained by the 0xFE bytes having been flushed to DRAM already in
> your ARM/ARM64 tests, whereas in your riscv64 case, the 0xFE bytes were still in
> a dirty cache line. The cache topology and implementation is totally different
> across the SoCs, so this is not too surprising.
> 
> Semantically, dma_map_single(..., DMA_FROM_DEVICE) means you are doing a
> unidirectional DMA transfer from the device into that buffer. So the contents of
> the buffer are "undefined" until the DMA transfer completes. If you are also
> writing data into the buffer from the CPU side, then you need DMA_BIDIRECTIONAL.
> 
> Regards,
> Samuel

+CC crypto mailing list + maintainer

My problem is that crypto selftest, for each buffer where I need to do a cipher operation,
concat a poison buffer to check that device does write beyond buffer.

But the dma_map_sg(FROM_DEVICE) corrupts this poison buffer and crypto selftests fails thinking my device did a buffer overrun.

So you mean that on SoC D1, this crypto API check strategy is impossible ?
