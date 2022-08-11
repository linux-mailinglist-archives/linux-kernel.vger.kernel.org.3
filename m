Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4479F58F70C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiHKEwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiHKEwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:52:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9140C66137
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:52:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w14so16025645plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=f9lKlYHVcsMmtqSXgvKZOc7zNWpHzbugb2ZvOggm7+8=;
        b=S4gcGXoUOmKHDv7mFl6eUlG9J/CJI3jZ30sxu4tI7jxbsBvGExLMnbZKnJivB6YDwh
         7A69bemlu4GU+2S8fOGcqweOrlqe1X3U7nd+qD7TLdKOOyp90ZKpNcAMnlvVEMqi6d9/
         vuO50kb2z+nkMJd9lwWR032rWCz8BgRieK1bZGd0hgEUCPkYwiK5tieI70SRir4XPQ5m
         17UGyABv6pu1/7YyiwBUNMx8Pk3EDi3p7URwERFthkOtIYIxmhdQ+Ew9c39bS3dyR3ik
         zsBAdWUml+ClfZ1v8bL5gDT4BRfYYiQGijXZ32sOKVQRUX2HtL+cxuNhJp6zgTr8AB6p
         L1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=f9lKlYHVcsMmtqSXgvKZOc7zNWpHzbugb2ZvOggm7+8=;
        b=tO/RDLNjE+Cl2lfV13Pl3Q/hCuHQRQyKYdnOVTl8IqkzH1n5MQzqg12EqmmzxMl2md
         Q2TPeQEJqyyF7nTlWvnSyaNiN3Mm9PNxt2R52DmyVKH6IoKSv357UV86LXPwSl4MjLrc
         taslOFs4sYUVfz/Uv04GJzPq72LZvDx3Dllys2jHxQtQgc0hCtbocxjhaVXVEZcJrS45
         Mc1ADVX1FRUPKcKknj5Hfoa3gHFsp6P9AzfLhJw79ztiDpGfOwZe/ZKMIfW4thyiHePj
         bGB6Ul4Hl9dCbCoCV0PbmrJjWVFCJKpgVg+JogOFg7pP3qPwRcMAA/Dq+Yi2koZQLQlI
         k6Fw==
X-Gm-Message-State: ACgBeo1JlVdOz3HEXCtu1m50FpvZO0asYeNBAJ3Fq4ek764d+j/iqa7+
        QhNJgLu1g3+3DdR4y0rEFbx3Iw==
X-Google-Smtp-Source: AA6agR49u3UFrXcLzjikkseLWSPFxFzGbnFqnrRqM5nDSGc27oRG4AhuNkUD/YKHXYE+RICXLuszxw==
X-Received: by 2002:a17:903:1207:b0:170:96d4:ac1d with SMTP id l7-20020a170903120700b0017096d4ac1dmr20466454plh.11.1660193536910;
        Wed, 10 Aug 2022 21:52:16 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id ok3-20020a17090b1d4300b001f23db09351sm2615106pjb.46.2022.08.10.21.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 21:52:16 -0700 (PDT)
Date:   Wed, 10 Aug 2022 21:52:16 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Aug 2022 21:52:13 PDT (-0700)
Subject:     Re: [PATCH v7 0/4] riscv: implement Zicbom-based CMO instructions + the t-head variant
In-Reply-To: <20220706231536.2041855-1-heiko@sntech.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Christoph Hellwig <hch@lst.de>,
        samuel@sholland.org, atishp@atishpatra.org, anup@brainfault.org,
        mick@ics.forth.gr, robh+dt@kernel.org, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, drew@beagleboard.org,
        rdunlap@infradead.org, heiko@sntech.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-2f62428c-544a-4908-a91d-fb8788ae67b3@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2022 16:15:32 PDT (-0700), heiko@sntech.de wrote:
> This series is based on the alternatives changes done in my svpbmt series
> and thus also depends on Atish's isa-extension parsing series.
>
> It implements using the cache-management instructions from the  Zicbom-
> extension to handle cache flush, etc actions on platforms needing them.
>
> SoCs using cpu cores from T-Head like the Allwinne D1 implement a
> different set of cache instructions. But while they are different,
> instructions they provide the same functionality, so a variant can
> easly hook into the existing alternatives mechanism on those.
>
>
> An ongoing discussion is about the currently used pre-coded
> instructions. Palmer's current thinking is that we should wait
> until the relevant instructions have landed in binutils.
>
> The main Zicbom instructions are in toolchains now and at least
> Debian also carries a binutils snapshot with it, but the T-Head
> variant still uses pre-coded instructions for now.
>
> The series sits on top of my svpbmt fixup series, which
> for example includes the conversion away from function pointers
> for the check-functions.
>
>
> It also uses my nops-series to shorten multiple nop statements:
> https://lore.kernel.org/r/20220607143059.1054074-1-heiko@sntech.de
>
>
> A new dma-noncoherent property was added for the devicetree-specification
> and dt-schema in:
> - https://www.spinics.net/lists/devicetree-spec/msg01053.html
> - https://github.com/devicetree-org/dt-schema/pull/78
>
> The dtschema-patch was already merged and patch1 in this series
> got a reviewed-by from Rob, so I guess that new property should be
> ok to use.
>
> changes in v7:
> - add recently received review-tags
> - fix wrong rv32 mabi when testing for Zicbom in Kconfig
>
> changes in v6:
> - add recently received review-tags
> - adapt non-coherent patch subject as suggested by Christoph Hellwig
>
> changes in v5:
> - beautify of_dma_is_coherent as suggested by Christoph Hellwig
> - WARN_TAINT when ARCH_DMA_MINALIGN smaller than riscv,cbom-block-size
>   (similar to how arm64 does this)
> - add a function to track if non-coherent handling is available
> - WARN_TAINT if a device is non-coherent but no non-coherent handling
> - use clean instead of inval in arch_sync_dma_for_device:DMA_FROM_DEVICE
>   hopefully I understood
>     https://lore.kernel.org/linux-arm-kernel/20220610151228.4562-1-will@kernel.org/T/
>   correctly in this
>
> changes in v4:
> - modify of_dma_is_coherent() also handle coherent system
>   with maybe noncoherent devices
> - move Zicbom to use real instructions
> - split off the actual dma-noncoherent code from the Zicbom
>   extension
> - Don't assumes devices are non-coherent, instead default to
>   coherent and require the non-coherent ones to be marked
> - CPUFEATURE_ZICBOM instead of CPUFEATURE_CMO
> - fix used cache addresses
> - drop some unused headers from dma-noncoherent.c
> - move unsigned long cast when calling ALT_CMO_OP
> - remove unneeded memset-0
> - define ARCH_DMA_MINALIGN
> - use flush instead of inval in arch_sync_dma_for_cpu()
> - depend on !XIP_KERNEL
> - trim some line lengths
> - improve Kconfig description
>
> changes in v3:
> - rebase onto 5.19-rc1 + svpbmt-fixup-series
> - adapt wording for block-size binding
> - include asm/cacheflush.h into dma-noncoherent to fix the
>   no-prototype error clang seems to generate
> - use __nops macro for readability
> - add some received tags
> - add a0 to the clobber list
>
> changes in v2:
> - cbom-block-size is hardware-specific and comes from firmware
> - update Kconfig name to use the ISA extension name
> - select the ALTERNATIVES symbol when enabled
> - shorten the line lengths of the errata-assembly
>
> Heiko Stuebner (4):
>   of: also handle dma-noncoherent in of_dma_is_coherent()
>   dt-bindings: riscv: document cbom-block-size
>   riscv: Add support for non-coherent devices using zicbom extension
>   riscv: implement cache-management errata for T-Head SoCs
>
>  .../devicetree/bindings/riscv/cpus.yaml       |   5 +
>  arch/riscv/Kconfig                            |  31 +++++
>  arch/riscv/Kconfig.erratas                    |  11 ++
>  arch/riscv/Makefile                           |   4 +
>  arch/riscv/errata/thead/errata.c              |  20 ++++
>  arch/riscv/include/asm/cache.h                |   4 +
>  arch/riscv/include/asm/cacheflush.h           |  10 ++
>  arch/riscv/include/asm/errata_list.h          |  59 ++++++++-
>  arch/riscv/include/asm/hwcap.h                |   1 +
>  arch/riscv/kernel/cpu.c                       |   1 +
>  arch/riscv/kernel/cpufeature.c                |  24 ++++
>  arch/riscv/kernel/setup.c                     |   2 +
>  arch/riscv/mm/Makefile                        |   1 +
>  arch/riscv/mm/dma-noncoherent.c               | 112 ++++++++++++++++++
>  drivers/of/address.c                          |  17 +--
>  15 files changed, 293 insertions(+), 9 deletions(-)
>  create mode 100644 arch/riscv/mm/dma-noncoherent.c

Thanks, this is on for-next.  I had to fix up a few things, nothing big 
but I did end up making Zicbom depend on MMU -- that's probably not 
strictly necessary, but it looks like the dma_noncoherent stuff pulls in 
some MMU dependencies.  Since the only hardware that has Zicbom also has 
an MMU I figured it's OK for now, but happy to take an improvement if 
someone has one.

Since there's a new extension it also requires updating sparse, I sent a 
patch (linked in the merge commit).
