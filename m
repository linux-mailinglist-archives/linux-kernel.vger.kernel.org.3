Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C355034A4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 09:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiDPHhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 03:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPHht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 03:37:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F72424971
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:35:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g18so12866905wrb.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=n3udlrmFRG5gOrbFNhXLisVJVRQDIPelDEgRxtU6UwA=;
        b=RA8I9Cdr3AKi1lYngqd/bphEz2n7JJWcnyCNtKEpfArKxgIc+8PRyHMpMh12dE6t0M
         gAj8j4is59ks+20l8jN9jnFhNbu+cOQ9K1LQsotipfxEi4MxvsuogVF6t4A++4mbdo1a
         RQ2p7Wc0mJukYm6jyRIeCxwmbxtSFNGzzwodbssHLJ2/SRd8g3kOha92ZvTBNr03epFF
         Qbfjtx0gDPcCVCDZ9lJ2gqmbh8yBgR78MUt3j7Nz1mfExrbexbiez8a/SznHxtY6kmp9
         PqJzgpGoaYE3XplfaqGiKk3B6NY0+V4vbftGba4vBGvIetTv8opxaYRGtUMGgROF/fkc
         y7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n3udlrmFRG5gOrbFNhXLisVJVRQDIPelDEgRxtU6UwA=;
        b=XZgZDzV+V5BfIy9BK8OpX7+Gyg5EkJyJZuyBR+uxk8RvVYT36b0brYS32x5/HuphVc
         WPlTfbet6Rs5Rip5ZvBbKfGgDRFMTti7ouAy8e5SO8GvEby+VVGAib1QGaayqE91ulE+
         JYrV11saniyPpZbfGowPpElYvUl/WFmMoeZgC/lRXIa89kLNx8AVpBq9iqbzT68fcvdc
         kOHlQdh7jHXouM8zUugPra2tSyCrnoMsbBQFYknciML12/0yiRE2Hs1CdznQw6Gb+1Pi
         enVg/1zk57mTvIxrR5EUluPQoWxtlWuZntnRSFa5ggduxbeVXsD08bMT6v1Ito3R0JTg
         9gsg==
X-Gm-Message-State: AOAM53106fU7IVnbpEVrSGyFe39HVbhuBAPI7xw9DY6dzpcGTxZLrWq5
        rofz2j3czbRXDmoqBfRraToBnBT0xGo=
X-Google-Smtp-Source: ABdhPJyv8ehPti8tRf6o2sqU7F//aIHeAkOa/ls1y1ClnrI6aBDeG2kUvsM6Mic5Yq4tWHGMGdgKWA==
X-Received: by 2002:adf:ed43:0:b0:207:ac79:84ee with SMTP id u3-20020adfed43000000b00207ac7984eemr1733242wro.321.1650094516563;
        Sat, 16 Apr 2022 00:35:16 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id 205-20020a1c02d6000000b003928c42d02asm800268wmc.23.2022.04.16.00.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 00:35:16 -0700 (PDT)
Date:   Sat, 16 Apr 2022 09:35:13 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        cmuellner@linux.com, philipp.tomsich@vrull.eu
Subject: Re: [PATCH 0/2] riscv: implement Zicbom-based CMO instructions + the
 t-head variant
Message-ID: <YlpxsYREWv/LQ+HY@Red>
References: <20220307224620.1933061-1-heiko@sntech.de>
 <YllWTN+15CoskNBt@Red>
 <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Apr 15, 2022 at 09:19:23PM -0500, Samuel Holland a écrit :
> On 4/15/22 6:26 AM, Corentin Labbe wrote:
> > Le Mon, Mar 07, 2022 at 11:46:18PM +0100, Heiko Stuebner a écrit :
> >> This series is based on the alternatives changes done in my svpbmt series
> >> and thus also depends on Atish's isa-extension parsing series.
> >>
> >> It implements using the cache-management instructions from the  Zicbom-
> >> extension to handle cache flush, etc actions on platforms needing them.
> >>
> >> SoCs using cpu cores from T-Head like the Allwinne D1 implement a
> >> different set of cache instructions. But while they are different,
> >> instructions they provide the same functionality, so a variant can
> >> easly hook into the existing alternatives mechanism on those.
> >>
> >>
> > 
> > Hello
> > 
> > I am testing https://github.com/smaeul/linux.git branch:origin/riscv/d1-wip which contain this serie.
> > 
> > I am hitting a buffer corruption problem with DMA.
> > The sun8i-ce crypto driver fail self tests due to "device overran destination buffer".
> > In fact the buffer is not overran by device but by dma_map_single() operation.
> > 
> > The following small code show the problem:
> > 
> > dma_addr_t dma;
> > u8 *buf;
> > #define BSIZE 2048
> > #define DMASIZE 16
> > 
> > buf = kmalloc(BSIZE, GFP_KERNEL | GFP_DMA);
> > for (i = 0; i < BSIZE; i++)
> >     buf[i] = 0xFE;
> > print_hex_dump(KERN_INFO, "DMATEST1:", DUMP_PREFIX_NONE, 16, 4, buf, 256, false);
> > dma = dma_map_single(ce->dev, buf, DMASIZE, DMA_FROM_DEVICE);
> 
> This function (through dma_direct_map_page()) ends up calling
> arch_sync_dma_for_device(..., ..., DMA_FROM_DEVICE), which invalidates the CPU's
> cache. This is the same thing other architectures do (at least arm, arm64,
> openrisc, and powerpc). So this appears to be working as intended.
> 
> Regards,
> Samuel
> 

This behavour is not present at least on ARM and ARM64.
The sample code I provided does not corrupt the buffer on them.

Regards
