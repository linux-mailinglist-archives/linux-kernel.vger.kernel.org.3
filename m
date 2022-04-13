Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7654FF319
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiDMJOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbiDMJNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:13:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DC92ED6B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:11:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e21so1645619wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98UsXQix7jmh2cjHZ+lRGQpOdqdEegIRaK/uMV/eJ28=;
        b=iVK5UmVvCHhETfmtz2Qc+ZHtQcwLys6z2ZXcKFnORfL+TAUKnWFCasQFj4X/XBAtUu
         MTxinFP+6r4X88OLlV/7jz/M6eaqdHncUrrLxNBQIo6zEaqjn1RcdzhSGbNxOvU2uioP
         s68RG0sX988OCW6p/Go3qeRNJmWMGflCB/pulvnjJZSqvyRVd6NdBvPqYpmqctvPDtbw
         BgsVrFxGYWGdJQz6vrBt1+oRgZPcAZ32bAnkfALV4SKxNxC7i5taGxb/dAWT+jr4GmvP
         EmnO4/lWNUrzNApzvN+z4h7Fscw4G8hoDErt4ieBR5BTiGwR4jMcTLn9O4vSG8731rUo
         bnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98UsXQix7jmh2cjHZ+lRGQpOdqdEegIRaK/uMV/eJ28=;
        b=TqQbp8OpaZUZthSSe8vUrPe8XRI7oFph90ViY29PxkiGgqs3gFkWAX9x5IunjFu7pq
         WuyxntKld3aZgRjjovXlym0UKdc3ZQqWH/sQ6xlDPEeyWyfRvmILOAasqbsoZt3BkdlT
         ryjd9zVCt4odca1YjC1KU4LCV+/xn9dJWW4NlnNvTaoC3ySdBna4W/LwLXNV4s8/vLoj
         L0OLkfBGzXW2Z3PHZEpiSIihvxNjP1HGt7s1FzVR1Ccyh3XsoCl6Muwy3vGuaKtB41HB
         Ybe8Wk2zvS3k1RiigOn0w8UF05Lub+TY5oUxUVPMPzCvRyccQFZxoVhIhibfRk3cQznH
         2KsQ==
X-Gm-Message-State: AOAM533PdAHsQM8bpqPQXKozgpHHn4Hlif93Ni8DFhqYIIBroQfXWthZ
        D7s0Zi7UlE00/D/hSsHJ9/l82jspdmyg3mdymnY0BA==
X-Google-Smtp-Source: ABdhPJyVZBhXbYYrZDmje6PtSvknj4BB+HRS34vLJXFflzTnZA27yZJtw2C9C/1QutOiBbxWkfGYC+mTgT/Zwe/cM/s=
X-Received: by 2002:adf:e84a:0:b0:207:a697:462c with SMTP id
 d10-20020adfe84a000000b00207a697462cmr11096993wrn.312.1649841081615; Wed, 13
 Apr 2022 02:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-10-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-10-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:11:09 +0200
Message-ID: <CAAeLtUDkODLd55EWWKj8PS2sh_TjEO_LDSFik9djgb5BLDJMBw@mail.gmail.com>
Subject: Re: [PATCH v9 09/12] riscv: add RISC-V Svpbmt extension support
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        Wei Wu <lazyparser@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Bill Huffman <huffman@cadence.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 at 05:03, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Svpbmt (the S should be capitalized) is the
> "Supervisor-mode: page-based memory types" extension
> that specifies attributes for cacheability, idempotency
> and ordering.
>
> The relevant settings are done in special bits in PTEs:
>
> Here is the svpbmt PTE format:
> | 63 | 62-61 | 60-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>   N     MT     RSW    D   A   G   U   X   W   R   V
>         ^
>
> Of the Reserved bits [63:54] in a leaf PTE, the high bit is already
> allocated (as the N bit), so bits [62:61] are used as the MT (aka
> MemType) field. This field specifies one of three memory types that
> are close equivalents (or equivalent in effect) to the three main x86
> and ARMv8 memory types - as shown in the following table.
>
> RISC-V
> Encoding &
> MemType     RISC-V Description
> ----------  ------------------------------------------------
> 00 - PMA    Normal Cacheable, No change to implied PMA memory type
> 01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
> 10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
> 11 - Rsvd   Reserved for future standard use
>
> As the extension will not be present on all implementations,
> implement a method to handle cpufeatures via alternatives
> to not incur runtime penalties on cpu variants not supporting
> specific extensions and patch relevant code parts at runtime.
>
> Co-developed-by: Wei Fu <wefu@redhat.com>
> Signed-off-by: Wei Fu <wefu@redhat.com>
> Co-developed-by: Liu Shaohua <liush@allwinnertech.com>
> Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> [moved to use the alternatives mechanism]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Drew Fustini <drew@beagleboard.org>
> Cc: Wei Fu <wefu@redhat.com>
> Cc: Wei Wu <lazyparser@gmail.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Maxime Ripard <maxime@cerno.tech>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Greg Favor <gfavor@ventanamicro.com>
> Cc: Andrea Mondelli <andrea.mondelli@huawei.com>
> Cc: Jonathan Behrens <behrensj@mit.edu>
> Cc: Xinhaoqu (Freddie) <xinhaoqu@huawei.com>
> Cc: Bill Huffman <huffman@cadence.com>
> Cc: Nick Kossifidis <mick@ics.forth.gr>
> Cc: Allen Baum <allen.baum@esperantotech.com>
> Cc: Josh Scheid <jscheid@ventanamicro.com>
> Cc: Richard Trauben <rtrauben@gmail.com>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
