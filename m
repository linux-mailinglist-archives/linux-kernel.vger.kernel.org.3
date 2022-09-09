Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71DE5B2D93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 06:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIIEk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 00:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIIEkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:40:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73BF7D1E7;
        Thu,  8 Sep 2022 21:40:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v16so1213062ejr.10;
        Thu, 08 Sep 2022 21:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NOESYgoK2wMPdnD2YfaTrguO/djOwdOuUJuGX9ov7n8=;
        b=meNsPfiLywKgKFDDvhtxftkHvuDh/WiZHX2Z1dmBwtfDHgO36Nj1yVuy1IKmGlDU49
         /az6NEjYB5gLRkND+3l1hVhavoH/n1JLic50JLRBihmfW8Qi3mejmU83jCiGVNYTXZBZ
         DcSXrVGjF76nSlgBjF2/aAIzDp6/8NIKUJpdz5oSuA/vwh4qvBod/9sQIn/SAcRgtl48
         8bR1uYYfCukDI84yqsDymw8gY07hjgNoNCP8dBqcXbv3db1pwLkm1vmjeubjDVatD387
         cn+5BLjxfeBVd7JSUQrQg/ccKzX/tCZGEU7KIrXL3QKhlFTDUwFpg+YgVdZUQmtNWiPk
         vBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NOESYgoK2wMPdnD2YfaTrguO/djOwdOuUJuGX9ov7n8=;
        b=7QWk1qriv49rk2jJlmy9tcZAOCz8ubjVk5b9KTQH1NtQNTOpnxjIhEceqbZMxylD5z
         5lTpmtFPGDBRxkgrvqYfUNgUqCW9Z7jrue7QEB7k/1+/00x2Npf1ge8V/w8ROEeL3lTa
         u6vPObm8HU6+dBVnzVji5lAEx8yE3h3cPKs00ZrOmMq2T7bw60couUPo0nvVzqtakst6
         9oTAOs0sPwLE1yeo0iwqCJPH4nM1hG5K0Psb5RBG5WLOCZIMDYR22K9/yn2EfxURBuW9
         pHx6dTUVSSux9IVTru/7Csg5QIaiVNSJb37MUds21d5zmt/xsDrWf6UR0NK1PUiUWBsW
         w/Rg==
X-Gm-Message-State: ACgBeo0fkA4a9gUi35zBSY3KdTyLl+cMyRrllCPXWLPCl5m7Rg4q63DZ
        1h2QBga7RCAf1vJyAxU0MkKlfuexVt9vXzcVq1g=
X-Google-Smtp-Source: AA6agR5ik0/CfPVi5GdwZMYYyFQwzDdtK6EYklLEoOGvER0iKkdIFE9toRIRoQmVP45iGah3ph7Sf46nDTUSkJyhO8o=
X-Received: by 2002:a17:906:8b81:b0:733:183b:988e with SMTP id
 nr1-20020a1709068b8100b00733183b988emr8401446ejc.457.1662698423278; Thu, 08
 Sep 2022 21:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220822082120.8347-1-yangyicong@huawei.com> <20220822082120.8347-2-yangyicong@huawei.com>
 <cc68c8c0-0db1-1678-2095-54383c1383ad@arm.com>
In-Reply-To: <cc68c8c0-0db1-1678-2095-54383c1383ad@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 9 Sep 2022 16:40:11 +1200
Message-ID: <CAGsJ_4zajhnbt47HQHCyu7fL5Y-b3BOb8MSCb2kr2CfW+gC5gg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] Revert "Documentation/features: mark
 BATCHED_UNMAP_TLB_FLUSH doesn't apply to ARM64"
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, peterz@infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 4:26 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 8/22/22 13:51, Yicong Yang wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > This reverts commit 6bfef171d0d74cb050112e0e49feb20bfddf7f42.
> >
> > I was wrong. Though ARM64 has hardware TLB flush, but it is not free
> > and it is still expensive.
> > We still have a good chance to enable batched and deferred TLB flush
> > on ARM64 for memory reclamation. A possible way is that we only queue
> > tlbi instructions in hardware's queue. When we have to broadcast TLB,
> > we broadcast it by dsb. We just need to get adapted the existing
> > BATCHED_UNMAP_TLB_FLUSH.
> >
> > Tested-by: Xin Hao <xhao@linux.alibaba.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  Documentation/features/arch-support.txt        | 1 -
> >  Documentation/features/vm/TLB/arch-support.txt | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/Documentation/features/arch-support.txt b/Documentation/features/arch-support.txt
> > index 118ae031840b..d22a1095e661 100644
> > --- a/Documentation/features/arch-support.txt
> > +++ b/Documentation/features/arch-support.txt
> > @@ -8,5 +8,4 @@ The meaning of entries in the tables is:
> >      | ok |  # feature supported by the architecture
> >      |TODO|  # feature not yet supported by the architecture
> >      | .. |  # feature cannot be supported by the hardware
> > -    | N/A|  # feature doesn't apply to the architecture
> >
> > diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
> > index 039e4e91ada3..1c009312b9c1 100644
> > --- a/Documentation/features/vm/TLB/arch-support.txt
> > +++ b/Documentation/features/vm/TLB/arch-support.txt
> > @@ -9,7 +9,7 @@
> >      |       alpha: | TODO |
> >      |         arc: | TODO |
> >      |         arm: | TODO |
> > -    |       arm64: | N/A  |
> > +    |       arm64: | TODO |
> >      |        csky: | TODO |
> >      |     hexagon: | TODO |
> >      |        ia64: | TODO |
>
> I believe this patch is not needed, which explicitly reverts an
> older commit. Instead when ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> framework gets enabled on arm64, the same patch could just drop
> 'NA' as possible values for arch support for a give feature in
> file Documentation/features/arch-support.txt.

Sure. it is certainly ok to fix this in
arm64: support batched/deferred tlb shootdown during page reclamation

By a separate patch, I was trying to highlight that my previous patch was
wrong. but, yes. it is not fundamentally necessary.

Thanks
Barry
