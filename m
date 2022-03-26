Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06474E7FC5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiCZH2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiCZH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:28:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C270D21805;
        Sat, 26 Mar 2022 00:26:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E3E5B80E61;
        Sat, 26 Mar 2022 07:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60363C340ED;
        Sat, 26 Mar 2022 07:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648279607;
        bh=xirFoJbRJSlOuSaLCipr97c50u9T+OQDwkkYd9o/BbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWUI0Z7zSaQzKUsR5q66Gy6XhKBH1SLdTrTJlAyKfnYD3ZBheK47uqVTFrjbl3aZ0
         lmZkVYEgXUJFuDKm6s7TaFEmvCDkJ0iksda7/Ybt3ogQ6E/nG77EwpO1mbyqzTftkS
         0f4l6mHvS9XR/kF7NKJzjmM/nc3M1GhDTnrSZZt7x2UizatXUCECv/3Fp8q5V4fP9W
         stdd2L3Y6Y3/4uNeTYI8pgXp9apWfAPBg6v4w476hpD/j96mnowK9KsR+8eN/4kTJ2
         vjWbN8fNDAsJVnFZVSYvkezZDI2EPw1uJtdYsvu627+umEivNWSzeB/oE8K1vzWerQ
         1mqb2oQnmBLnw==
Date:   Sat, 26 Mar 2022 15:18:25 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Atish Kumar Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 0/6] Provide a fraemework for RISC-V ISA extensions
Message-ID: <Yj6+QZUgrzA9UK/J@xhacker>
References: <20220215090211.911366-1-atishp@rivosinc.com>
 <YgvNSeUekqEVS1yE@xhacker>
 <CAHBxVyF65jC_wvxcD6bueqpCY8-Kbahu1yxsSoBmO1s15dGkSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHBxVyF65jC_wvxcD6bueqpCY8-Kbahu1yxsSoBmO1s15dGkSQ@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 11:06:24AM -0800, Atish Kumar Patra wrote:
> On Tue, Feb 15, 2022 at 8:04 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Tue, Feb 15, 2022 at 01:02:05AM -0800, Atish Patra wrote:
> > > This series implements a generic framework to parse multi-letter ISA
> > > extensions. This series is based on Tsukasa's v3 isa extension improvement
> > > series[1]. I have fixed few bugs and improved comments from that series
> > > (PATCH1-3). I have not used PATCH 4 from that series as we are not using
> > > ISA extension versioning as of now. We can add that later if required.
> > >
> > > PATCH 4 allows the probing of multi-letter extensions via a macro.
> > > It continues to use the common isa extensions between all the harts.
> > > Thus hetergenous hart systems will only see the common ISA extensions.
> > >
> > > PATCH 6 improves the /proc/cpuinfo interface for the available ISA extensions
> > > via /proc/cpuinfo.
> > >
> > > Here is the example output of /proc/cpuinfo:
> > > (with debug patches in Qemu and Linux kernel)
> > >
> > > / # cat /proc/cpuinfo
> > > processor     : 0
> > > hart          : 0
> > > isa           : rv64imafdcsu
> > > isa-ext               : sstc,sscofpmf
> > > mmu           : sv48
> > >
> > > processor     : 1
> > > hart          : 1
> > > isa           : rv64imafdcsu
> > > isa-ext               : sstc,sscofpmf
> > > mmu           : sv48
> > >
> > > processor     : 2
> > > hart          : 2
> > > isa           : rv64imafdcsu
> > > isa-ext               : sstc,sscofpmf
> > > mmu           : sv48
> > >
> > > processor     : 3
> > > hart          : 3
> > > isa           : rv64imafdcsu
> > > isa-ext               : sstc,sscofpmf
> > > mmu           : sv48
> > >
> > > Anybody adding support for any new multi-letter extensions should add an
> > > entry to the riscv_isa_ext_id and the isa extension array.
> > > E.g. The patch[2] adds the support for various ISA extensions.
> >
> > Hi Atish,
> >
> > Thanks for this series. I'm thinking cpu features VS ISA extenstions.
> > I'm converting the sv48 to static key:
> > https://lore.kernel.org/linux-riscv/20220125165036.987-1-jszhang@kernel.org/
> >
> > Previously, I thought the SV48 as a cpu feature, and there will be
> > more and more cpu features, so I implemented an unified static key
> > mechanism for CPU features. But after reading this series, I think
> > I may need to rebase(even reimplement) the above patch to your series.
> > But I'm a bit confused by CPU features VS ISA extenstions now:
> >
> > 1. Is cpu feature  == ISA extension?
> >
> > 2. Is SV48 considered as ISA extension?
> > If yes, now SV48 or not is determined during runtime, but current ISA
> > extensions seem parsed from DT. So how to support those ISA extensions
> > which can be determined during runtime?
> >
> > Could you please share your thought?
> >
> 
> Here are my two cents:
> 
> I think the cpu feature is a superset of the ISA extension.
> cpu feature != ISA extension.
> 
> While all ISA extensions are cpu features, all CPU features may not be
> an ISA extension.
> e.g. sv48 is not a ISA extension but F/D are (used to set the
> cpu_hwcap_fpu static key)
> 
> Moreover, not all cpu feature/ISA extension requires a static key.
> e.g SSTC extension will require a static key because the check has to
> happen in the hot path.
> However, sscofpmf extension don't need a static key as the check
> happens only one time during boot.
> 
> We should keep these two separate but a common static framework would
> be very useful.
> 
> Here is the flow that I have in my mind.
> 1. All ISA extensions will be parsed through riscv,isa DT property
> 2. Any supported/enabled extension will be set in riscv_isa bitmap
> 3. Any extension requiring a static key will invoke the cpus_set_cap.
> 
> cpus_set_cap will be invoked from a different code path that uses a
> static key for a specific ISA
> extension or a CPU feature.
> 
> The only problem I see here is that we have to set a bit in both
> cpu_hwcaps & riscv_isa bitmap.
> We also have to define the value of that bit for any extension
> requiring a static key twice as well.
> 
> I think that should be okay. But I would like to hear what everybody
> else thinks as well.
> 

Thank Atish's input. I notice that SV57 support is merged, I'll
send a new version to apply static mechanism to both SV48 and SV57
once rc1 is released.
