Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF9D528072
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbiEPJJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241928AbiEPJJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:09:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D57FE038
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:09:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so10479392wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4y1lUQE4jcfytaW0Wa1mHb+7bWWQjJjq9fZCketHKQ=;
        b=X1DNS3izGDmG2ZzNwvKwxubD4dAzvtune5mqBpUfMaC9AZjnraMTJnXgdFUIyF2x8l
         LpSUaDNEShEjSSelQzC1RgUbQEVH4tRAKa8t5gVFugBLXmG8gwhO+xsowghGh1Z86GSI
         h68cyD6r7+NpmD0LUWLywlB0zmSOm5GJxaT8l/5sYrnNyYCUtNR16XtgoBxDfZQQMSY7
         mmDv4thUTnvZkUNzp8v5ULMPpXBqIlv4QwUiL7c6NFJ+DNVEeXBm7z0Z2imtZrkK/Wq+
         Z4gDfU9HjbF9BLHILP8lNkrvw7yNct7x6tCww/34XQf+x906GIwQASqqcESIo1cu6LBE
         4UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4y1lUQE4jcfytaW0Wa1mHb+7bWWQjJjq9fZCketHKQ=;
        b=temrkMxjXqbppDwCWY43N6QZuE3qAJu2Y8IuF8tD4kfINOTtYLrpKXRMP3iIXM8i6P
         BYoX4XXJA2vBmLxmZWHsf8EbA+jr87Np+XDtLSGjuPEM9uhVLuLowpOZOLLYb9Lb4gMB
         JLAhNyBsoCzOG7Gv6uOZXF10U+UWhxux5A2cTMMtHzL73Orw/Yk0K1h4P+B69WM+VAL5
         fceAQTg1/Fm4QcPGFp7tJ35SVgujsR8N8TMiDnmx2+NXFRYlqHV0m+Cm8C602TyFcuGW
         EzaKaCA9/bTobNYomQpsVqNByvzPoiCEfQAjwknP/UZ/STYRhhBM7r3w+rbEXbRT5B1Y
         zFgw==
X-Gm-Message-State: AOAM532rTj50Ww01DGJkeNFDpIVDoJ2LxmF8zQhMZRnjmWhssOuEOgzr
        fJEfySGYRQSmgkLI8vDXy/Ou0k16LfCJ9aJxUkMG2w==
X-Google-Smtp-Source: ABdhPJzaH5D/cwvGZZz2FqkpuCt6jbGdMpmbQ0qiLJscQytQAeNBmss4eT1Hr7IgpgoBwJev5e9CSA8k5/ijl63BYYY=
X-Received: by 2002:a05:600c:19c9:b0:394:766a:318d with SMTP id
 u9-20020a05600c19c900b00394766a318dmr26005246wmq.199.1652692163753; Mon, 16
 May 2022 02:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220511192921.2223629-1-heiko@sntech.de> <20220511192921.2223629-10-heiko@sntech.de>
 <20220516061057.GL12339@lst.de>
In-Reply-To: <20220516061057.GL12339@lst.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Mon, 16 May 2022 11:09:12 +0200
Message-ID: <CAAeLtUA1FWQRot6=zHXWBa3YnfxuhL2TW-a-TNomDeUFPrrz1A@mail.gmail.com>
Subject: Re: [PATCH 09/12] riscv: add RISC-V Svpbmt extension support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
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

On Mon, 16 May 2022 at 08:11, Christoph Hellwig <hch@lst.de> wrote:
>
> > +config RISCV_ISA_SVPBMT
> > +     bool "SVPBMT extension support"
>
> I don't think this prompt is very useful as it doesn't describe
> what it does.  But do we even want people to disable it as it is
> really essentially for a fully functioning kernel and a pity that
> it took RISC-V so long to get there?

Given that RISC-V is (in some ways) an ISA construction set, there
will be valid use cases for embedded users to disable this (e.g. if
they have their own non-standard way to configure these).  So while
kernels for binary distributions (and desktop, server, or
general-purpose embedded) will always enable these, I would fully
expect some users to want to turn these off.

@Heiko: I would request that we have a longer help text on this, which
explains what it is and ends with the usual "When in doubt, say Y."

> > +     depends on 64BIT && MMU
> > +     select RISCV_ALTERNATIVE
> > +     default y
> > +     help
> > +        Adds support to dynamically detect the presence of the SVPBMT extension
>
> overly long line here.
>
> > index 5f1046e82d9f..dbfcd9b72bd8 100644
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -14,6 +14,9 @@
> >  #define      ERRATA_SIFIVE_NUMBER 2
> >  #endif
> >
> > +#define      CPUFEATURE_SVPBMT 0
> > +#define      CPUFEATURE_NUMBER 1
>
> is errata_list.h really the right place for architectural features?
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
