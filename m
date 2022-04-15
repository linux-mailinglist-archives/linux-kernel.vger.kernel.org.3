Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A605028DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352680AbiDOL2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbiDOL2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:28:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4581E49F23
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:26:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e21so10324967wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JEwBbnSv4wy8BjMA4tVtRE4HEbh8Klb/JEyZ0qGQGEM=;
        b=lHNQR8bOCTyJ+udwv0kNNIQuWIfcelZdA7qCYzeh/hfp1PGUUju3szcLwobmWjlG+D
         nd0gbdBgA+U/G9MwTm6EwcybEYhz9O7zcuGb+XquO85Cnt3zAnRGSOozeRkelx+Dl5iy
         Zd1kypx1KsUUlc7kim/LpcGrnp2xsx7hzQBG/i9AToI6iucVECFhibyYCMZ9Hn/abBQs
         RYYcuLDe6al/DRJa9I4lwCgCdG83QErLqu6AJeyceCHJL7SbVd0fLrGL7VmFqALstkvY
         bDZ9UIiWlLF66dUri7slTgwOOZnJ8JSVJWFhPE5BC+kVnEgmI4Xok/PyCKyW1WOL8t+E
         OdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JEwBbnSv4wy8BjMA4tVtRE4HEbh8Klb/JEyZ0qGQGEM=;
        b=1heLqZhYoSHAzMOPgTy5MAMsd4+TTsHOIaSR3WdDTeSAtTE1K2TLz4eGeBOTqDuwVh
         /qZJCdotipk2EwWX5MmCpF8jOJt+5QWwBUKGPaXcKiRRgDr7hR6biB4G7UcsAehOZDJz
         AVrMzPvXvA4M7pXAEqc6ajPvcjHutA1+GbNybBzMOGq0MGseUELDEkmm1EJLzpNZVja0
         H/d6GjG2SbWq/f3wKNK7/2Bsewy2ymexMPFAc8KTjZUF3oQVfVtqkVzcHC8LHEzeYMF/
         GyDS+7j5tyiW8Nj7Rqpw11VJOGeNeP08ZkPchHWPg8sSTZ5/89xLnu9EGmWHQazlEg1D
         IW3Q==
X-Gm-Message-State: AOAM530WrxHNIsAEmi5NOGcEvKdtFj7wPMUa1A0+9C6CwqoJTT9nI6OD
        iH9gYWjtZ5U68WImD79hDtI=
X-Google-Smtp-Source: ABdhPJwXbN5EDaBIeTHDhxBCGKD6+A4UtWqBM0PcYmjyQnQruTkfe96lqckZZFEVlN2ZGc/B8znUZw==
X-Received: by 2002:a5d:47cc:0:b0:204:1c9d:2157 with SMTP id o12-20020a5d47cc000000b002041c9d2157mr5084367wrc.294.1650021966801;
        Fri, 15 Apr 2022 04:26:06 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id bg8-20020a05600c3c8800b0038e4c5967besm5255924wmb.3.2022.04.15.04.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 04:26:06 -0700 (PDT)
Date:   Fri, 15 Apr 2022 13:26:04 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu
Subject: Re: [PATCH 0/2] riscv: implement Zicbom-based CMO instructions + the
 t-head variant
Message-ID: <YllWTN+15CoskNBt@Red>
References: <20220307224620.1933061-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220307224620.1933061-1-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Mar 07, 2022 at 11:46:18PM +0100, Heiko Stuebner a écrit :
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

Hello

I am testing https://github.com/smaeul/linux.git branch:origin/riscv/d1-wip which contain this serie.

I am hitting a buffer corruption problem with DMA.
The sun8i-ce crypto driver fail self tests due to "device overran destination buffer".
In fact the buffer is not overran by device but by dma_map_single() operation.

The following small code show the problem:

dma_addr_t dma;
u8 *buf;
#define BSIZE 2048
#define DMASIZE 16

buf = kmalloc(BSIZE, GFP_KERNEL | GFP_DMA);
for (i = 0; i < BSIZE; i++)
    buf[i] = 0xFE;
print_hex_dump(KERN_INFO, "DMATEST1:", DUMP_PREFIX_NONE, 16, 4, buf, 256, false);
dma = dma_map_single(ce->dev, buf, DMASIZE, DMA_FROM_DEVICE);
dma_unmap_single(ce->dev, dma, DMASIZE, DMA_FROM_DEVICE);
print_hex_dump(KERN_INFO, "DMATEST3:", DUMP_PREFIX_NONE, 16, 4, buf, 256, false);

Will lead to:
[    2.960040] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    2.965354] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    2.970709] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    2.976069] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    2.981440] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    2.986814] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    2.992188] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    2.997560] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    3.002934] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    3.008307] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    3.013680] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    3.019054] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    3.024427] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    3.029802] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    3.035175] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    3.040546] DMATEST1:fefefefe fefefefe fefefefe fefefefe
[    3.401647] DMATEST3:a9c3a9c3 a9c3a9c3 a9c3a9c3 a9c3a9c3
[    3.406982] DMATEST3:a9c3a9c3 a9c3a9c3 a9c3a9c3 a9c3a9c3
[    3.412350] DMATEST3:a9c3a9c3 a9c3a9c3 a9c3a9c3 a9c3a9c3
[    3.417720] DMATEST3:a9c3a9c3 a9c3a9c3 a9c3a9c3 a9c3a9c3
[    3.423094] DMATEST3:fefefefe fefefefe fefefefe fefefefe
[    3.428468] DMATEST3:fefefefe fefefefe fefefefe fefefefe
[    3.433841] DMATEST3:fefefefe fefefefe fefefefe fefefefe
[    3.439213] DMATEST3:fefefefe fefefefe fefefefe fefefefe
[    3.444588] DMATEST3:fefefefe fefefefe fefefefe fefefefe
[    3.449962] DMATEST3:fefefefe fefefefe fefefefe fefefefe
[    3.455334] DMATEST3:fefefefe fefefefe fefefefe fefefefe
[    3.460707] DMATEST3:fefefefe fefefefe fefefefe fefefefe
[    3.466081] DMATEST3:fefefefe fefefefe fefefefe fefefefe
[    3.471454] DMATEST3:fefefefe fefefefe fefefefe fefefefe
[    3.476828] DMATEST3:fefefefe fefefefe fefefefe fefefefe
[    3.482200] DMATEST3:fefefefe fefefefe fefefefe fefefefe

Even with no DMA action, the buffer is corrupted.

Regards
