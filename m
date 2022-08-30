Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C71A5A5AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiH3En1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3EnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:43:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AC7AB075
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:43:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m7so5013388lfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8xaCXOqGfO+vQafsuCd8VhQH7il5VLrKJWKilF4St6M=;
        b=GwXz5yPPgm9q+uJRWBAXBMfz9q2Z3LD2knKm+awIpyhrT0PxqlLIdd0R77flcUOhW2
         3CEnf4yaakjY3/a5y1FLPd7WBpEBSFOAJKKJdMsrWZVfSrM6T+GK6NBssk2f53jtws+w
         rtPF+gNYi+HMcNJNzZEW3iUkGldnNdN+JpBoQU6KUWbouwnOfqm83q+aGMj321lNitE8
         vkgqxIP8LQZihOG0buJT+jiR7cfescw9PBAu+LiREdc92V1EcblaJRUAgovQY3cF/IIS
         tVfvxQessHLqHZl2+HXkm5k3Suf4IbcVctAL7p7YZFOAL7QyJJD3RF2A55s0xJxOt3Ac
         UbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8xaCXOqGfO+vQafsuCd8VhQH7il5VLrKJWKilF4St6M=;
        b=QlmO8IOemaHLoAcKmbuD/gjgNb2wvUpfr8t9xTiJ8FUNLZcH1DUfQ/LEphdiAcTjKC
         zgV4lhN7y8/yj0338qffBYmDwtH0dPyBqC7GUS43Vcl4ZL3AuL3hakh6a5qmP1ejvrQs
         iiKEsoaqRSbcvOMDROJRXxeBR4NziVAAAitCm0Hs7hJlHApFL4Piz8aFE+yuz8jDsCfX
         eiUHkzFK7yXUdAeQOR2TI9unFM+jTaOhDu9pKwGYxOleOqI79cDV6KMl0VojxrmAUF9V
         mvrj26n4NwDY1qFErwyyo/qxcbynvmV78DMRuLLKKaITIqCEWIrttIYYK+vtHC5yjPpc
         OvUQ==
X-Gm-Message-State: ACgBeo1dn0o3td2+7GvPjR775TYW/6eXLC3bcgJp4XcHdcXUlcOQVYJQ
        Tlvx3EVvjyrNsdCwQ/yFyEpnyyNrMyo+7l2Og0bECeI7sNI=
X-Google-Smtp-Source: AA6agR6FIH9Ge0gOMHTpvPyKFk1FkUkl+1IoM24o5dRVl1xQTe2JUeowYngO6o1DEiT2kIyUvTkO2MLvRM2Q3rTY2gk=
X-Received: by 2002:a05:6512:68f:b0:492:cbb1:c4b2 with SMTP id
 t15-20020a056512068f00b00492cbb1c4b2mr7774424lfe.130.1661834603011; Mon, 29
 Aug 2022 21:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220829125226.511564-1-apatel@ventanamicro.com> <f4b2daab-72f6-ab5a-5743-b41bd5e2c920@microchip.com>
In-Reply-To: <f4b2daab-72f6-ab5a-5743-b41bd5e2c920@microchip.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 30 Aug 2022 10:13:11 +0530
Message-ID: <CAK9=C2UOGR2VQao8CCJ82mRP4kL_1V=8uXyKj_vnOXW7a=Kt8A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add PMEM support for RISC-V
To:     Conor.Dooley@microchip.com
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        atishp@atishpatra.org, heiko@sntech.de, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, Aug 29, 2022 at 11:11 PM <Conor.Dooley@microchip.com> wrote:
>
> On 29/08/2022 13:52, Anup Patel wrote:
> > The Linux NVDIMM PEM drivers require arch support to map and access the
> > persistent memory device. This series adds RISC-V PMEM support using
> > recently added Svpbmt and Zicbom support.
> >
> > These patches can also be found in riscv_pmem_v1 branch at:
> > https://github.com/avpatel/linux.git
>
> Hey Anup, couple build errors here:
>
> /stuff/linux/arch/riscv/mm/cacheflush.c:99:2: error: call to undeclared function 'for_each_of_cpu_node'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>         for_each_of_cpu_node(node) {
>         ^
> /stuff/linux/arch/riscv/mm/cacheflush.c:99:28: error: expected ';' after expression
>         for_each_of_cpu_node(node) {
>                                   ^
>                                   ;
> 1 warning generated.
> /stuff/linux/arch/riscv/mm/cacheflush.c:105:4: error: 'continue' statement not in loop statement
>                         continue;
>                         ^
> /stuff/linux/arch/riscv/mm/cacheflush.c:108:4: error: 'continue' statement not in loop statement
>                         continue;
>                         ^
> /stuff/linux/arch/riscv/mm/cacheflush.c:111:9: error: call to undeclared function 'of_property_read_u32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                 ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
>                       ^
> /stuff/linux/arch/riscv/mm/cacheflush.c:113:4: error: 'continue' statement not in loop statement
>                         continue;
>                         ^
> 6 errors generated.
>
> LKP already complained about this prior to you posting & as it has
> all the repro needed, there's not much point in me sharing my config
> etc:
> https://lore.kernel.org/all/202208272028.IwrNZ0Ur-lkp@intel.com/

Strange, I never got this email.

I will send v2 to fix this.

Regards,
Anup

>
> Thanks,
> Conor.
>
> PS: I liked the last patch, must've been a hard config option to
> find if it took two of you! ;)
>
>
> >
> > Anup Patel (4):
> >   RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
> >   RISC-V: Move riscv_init_cbom_blocksize() to cacheflush.c
> >   RISC-V: Implement arch specific PMEM APIs
> >   RISC-V: Enable PMEM drivers
> >
> >  arch/riscv/Kconfig                  |  1 +
> >  arch/riscv/configs/defconfig        |  1 +
> >  arch/riscv/include/asm/cacheflush.h |  2 ++
> >  arch/riscv/include/asm/io.h         | 10 ++++++++
> >  arch/riscv/include/asm/pgtable.h    |  2 ++
> >  arch/riscv/mm/Makefile              |  1 +
> >  arch/riscv/mm/cacheflush.c          | 37 +++++++++++++++++++++++++++++
> >  arch/riscv/mm/dma-noncoherent.c     | 36 ----------------------------
> >  arch/riscv/mm/pmem.c                | 21 ++++++++++++++++
> >  9 files changed, 75 insertions(+), 36 deletions(-)
> >  create mode 100644 arch/riscv/mm/pmem.c
> >
