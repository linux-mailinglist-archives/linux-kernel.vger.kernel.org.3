Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79AE4DD3A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiCRDlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiCRDln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:41:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB30E266B5E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:40:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c11so4186819pgu.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=3z0/mInRqoLS/gNYcHKM+YZD4abZpfprx7wEh6KQLj8=;
        b=6cqPzUaR/UJCnJmQGJMnMamAYRclpVvPNshJIyEoVeXTPqW6d7pVCnz1FeJm/FiArN
         7OLUVyIsYbnSbn8XEMTsUtXxmN3nRi9j081t6by9P2soNISya/vSohxgyNNR2oDn3S3K
         FFojAnZucEvUHrJ3REThIJSN5FW2pVlxWonb7n8+bHXMIfStzLg3DEX1kyX0rumVJmkL
         1Y18/H/ANpdSoeBlHkQhGB/CDT/xXrxorBq1VaaIBxIDKI64GyYs3kc3GFXF5VJW8gzc
         IOxHDLm6ACfw11HZtt0FoYqpoldq27D771uMpNSv3MbGqvlX0fAOgjUZL7OIkYrntGSv
         493w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=3z0/mInRqoLS/gNYcHKM+YZD4abZpfprx7wEh6KQLj8=;
        b=JpWY41ifZdl5EzFW3MOmtD/CQRGUZqUSUy9Z9H9pTKbH5PC104Go6vMc7nrzXeDTeg
         uDT+0wVVkS0QjMMVSsMkz7AMNHn/k2y1qVfaRAQTMsni4Wlol68ryIqHNLkC8IM/08t/
         KqeQQMk3KO7S6jWsQF9KY/PDmOUgPdmK26rhaJkKwI+bN/aY/yEFtlppqJCRejHbjYTU
         gGS140nGIuWU3xfE08rUHLhvGCm4nHDNSpDBngYTW7ESF3KliQYmk3jfzMC4Ez9q6j00
         Ai+3r7JcZ4T7bwdNmWUlqkQz6cdY6uhNcdkZCFqwEjtz1Rlazn6aw02QN773PQqymZ1m
         PLSw==
X-Gm-Message-State: AOAM533K9hG7FuW1/D2BGoCW2hFLUlRX+CldhEjARo1cY3vc5r8NuPww
        EQVbeSgnqiXq2Te0V1ymd4kMAw==
X-Google-Smtp-Source: ABdhPJyu7XzVd5zzEL3Hum1KCo0su8pSd5TXXC8CMPMTYuwiyeOgJMjM+0wttMg+kuiDdGssHRgDtA==
X-Received: by 2002:a63:b10:0:b0:373:393f:2015 with SMTP id 16-20020a630b10000000b00373393f2015mr6303867pgl.322.1647574824070;
        Thu, 17 Mar 2022 20:40:24 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id w8-20020a63a748000000b0038117e18f02sm6452927pgo.29.2022.03.17.20.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 20:40:23 -0700 (PDT)
Date:   Thu, 17 Mar 2022 20:40:23 -0700 (PDT)
X-Google-Original-Date: Thu, 17 Mar 2022 20:40:21 PDT (-0700)
Subject:     Re: [PATCH v7 00/13] riscv: support for Svpbmt and D1 memory types
In-Reply-To: <9863388.BuYlmvG7s8@diego>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        wens@csie.org, maxime@cerno.tech, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        mick@ics.forth.gr, allen.baum@esperantotech.com,
        jscheid@ventanamicro.com, rtrauben@gmail.com, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-07819dc7-9fae-4638-b97a-d486b16c28ac@palmer-ri-x1c9>
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

On Wed, 09 Mar 2022 14:06:55 PST (-0800), heiko@sntech.de wrote:
> Am Dienstag, 8. März 2022, 12:56:20 CET schrieb Heiko Stübner:
>> Hi Palmer,
>> 
>> Am Dienstag, 8. März 2022, 01:47:25 CET schrieb Palmer Dabbelt:
>> > On Mon, 07 Mar 2022 12:52:57 PST (-0800), heiko@sntech.de wrote:
>> > > Svpbmt is an extension defining "Supervisor-mode: page-based memory types"
>> > > for things like non-cacheable pages or I/O memory pages.
>> > >
>> > >
>> > > So this is my 2nd try at implementing Svpbmt (and the diverging D1 memory
>> > > types) using the alternatives framework.
>> > >
>> > > This includes a number of changes to the alternatives mechanism itself.
>> > > The biggest one being the move to a more central location, as I expect
>> > > in the future, nearly every chip needing some sort of patching, be it
>> > > either for erratas or for optional features (svpbmt or others).
>> > >
>> > > Detection of the svpbmt functionality is done via Atish's isa extension
>> > > handling series [0] and thus does not need any dt-parsing of its own
>> > > anymore.
>> > >
>> > > The series also introduces support for the memory types of the D1
>> > > which are implemented differently to svpbmt. But when patching anyway
>> > > it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the same
>> > > location.
>> > >
>> > > The only slightly bigger difference is that the "normal" type is not 0
>> > > as with svpbmt, so kernel patches for this PMA type need to be applied
>> > > even before the MMU is brought up, so the series introduces a separate
>> > > stage for that.
>> > >
>> > >
>> > > In theory this series is 3 parts:
>> > > - sbi cache-flush / null-ptr
>> > 
>> > That first patch looks like an acceptable candidate for fixes.  If 
>> > there's a regression that manifests I'm happy to take it, but if it's 
>> > only possible to manifest a crash with the new stuff then I'm OK just 
>> > holding off until the merge window.
>> 
>> While right now only my poking around the early init via alternatives
>> is affected, the problem exists for everyone.
>> 
>> I.e. I do consider flush_icache_all() to be generic enough that we
>> should expect someone trying to call this in some early code-path
>> as well.
>> 
>> But any call to flush_icache_all() before sbi_init() ran will cause the
>> breakage that is fixed by patch1 .
>> 
>> 
>> So it doesn't look like any _current_ code path has that issue, but
>> it might be good to just pick patch1 for the next merge window
>> individually?
>> 
>> 
>> 
>> > > - alternatives improvements
>> > > - svpbmt+d1
>> > >
>> > > So expecially patches from the first 2 areas could be applied when
>> > > deemed ready, I just thought to keep it together to show-case where
>> > > the end-goal is and not requiring jumping between different series.
>> > >
>> > >
>> > > I picked the recipient list from the previous versions, hopefully
>> > > I didn't forget anybody.
>> > >
>> > > changes in v7:
>> > > - fix typo in patch1 (Atish)
>> > > - moved to Atish's isa-extension framework
>> > > - and therefore move regular boot-alternatives directly behind fill_hwcaps
>> > > - change T-Head errata Kconfig text (Atish)
>> > 
>> > I was just poking around v6, so I have some minor comments there.  None 
>> > of those need to block merging this, but I am getting a bunch of build 
>> > failures under allmodconfig
>> > 
>> >     $ make.riscv allmodconfig
>> >     #
>> >     # configuration written to .config
>> >     #
>> >     $ make.riscv mm/kasan/init.o
>> >       SYNC    include/config/auto.conf.cmd
>> >       CALL    scripts/atomic/check-atomics.sh
>> >       CC      arch/riscv/kernel/asm-offsets.s
>> >       CALL    scripts/checksyscalls.sh
>> >       CC      mm/kasan/init.o
>> >     ./arch/riscv/include/asm/pgtable.h: Assembler messages:
>> >     ./arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> >     make[2]: *** [scripts/Makefile.build:288: mm/kasan/init.o] Error 1
>> >     make[1]: *** [scripts/Makefile.build:550: mm/kasan] Error 2
>> >     make: *** [Makefile:1831: mm] Error 2
>> > 
>> > Unfortunately my build box just blew up so I haven't had time to confim 
>> > this still exists on v7, but nothing's jumping out as a fix.  I've put 
>> > this on the riscv-d1 branch at kernel.org/palmer/linux, not sure exactly 
>> > what's going on but I'm guessing one of the macros has gone off the 
>> > rails.  I'm going to look at something else (as this one at least 
>> > depends on Atish's patches), but LMK if you've got the time to look into 
>> > this or if I should.
>> 
>> Yeah, we now depend on Atish's isa-extension parsing (same for my cmo
>> series and some more series I saw on the list), so getting that into a
>> mergeable position would be really great :-)
>> 
>> "attempt to move .org backwards" seems to be the telltale sign of the
>> alternatives blocks not matching up in size. While I definitly didn't see
>> anything like this in my tests on qemu + d1, I'll try to investigate where
>> that comes from.
>
> Hmm, looking at your branch [0] it seems that you're missing
> patch7 that introduces the no-compressed-instruction thingy
> for alternatives.
>
> And missing that patch will of course cause the size issue.
>
> The patch has made its way to the actual mailing lists [1], so I guess
> it "just" somehow didn't reach your inbox due to some mail hickup?

Sorry about that, I'm not sure what happened.

Unfortunately I'm now getting some even trickier failures: a handful of 
configurations are failing very early in boot.  There doesn't seem to be 
much pattern to the configs that fail, but at least rv32 defconfig (on 
QEMU's virt board) is doing so.  I've tried poking around a bit and 
can't figure out what's going on.  I'll try and look again tomorrow 
morning.

I've put my somewhat messy merged test branch at 
kernel.org/palmer/riscv-d1-merge .  Happy to hear if you have any 
insights, otherwise I'l give it another shot (possibly after looking at 
some other patches, there's quite a bit of a queue for this late).

>
>
> Heiko
>
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-d1
> [1] https://lore.kernel.org/all/20220307205310.1905628-8-heiko@sntech.de/
>
>
>> > > changes in v6:
>> > > - rebase onto 5.17-rc1
>> > > - handle sbi null-ptr differently
>> > > - improve commit messages
>> > > - use riscv,mmu as property name
>> > >
>> > > changes in v5:
>> > > - move to use alternatives for runtime-patching
>> > > - add D1 variant
>> > >
>> > >
>> > > [0] https://lore.kernel.org/r/20220222204811.2281949-2-atishp@rivosinc.com
>> > >
>> > >
>> > > Heiko Stuebner (12):
>> > >   riscv: prevent null-pointer dereference with sbi_remote_fence_i
>> > >   riscv: integrate alternatives better into the main architecture
>> > >   riscv: allow different stages with alternatives
>> > >   riscv: implement module alternatives
>> > >   riscv: implement ALTERNATIVE_2 macro
>> > >   riscv: extend concatenated alternatives-lines to the same length
>> > >   riscv: prevent compressed instructions in alternatives
>> > >   riscv: move boot alternatives to after fill_hwcap
>> > >   riscv: Fix accessing pfn bits in PTEs for non-32bit variants
>> > >   riscv: add cpufeature handling via alternatives
>> > >   riscv: remove FIXMAP_PAGE_IO and fall back to its default value
>> > >   riscv: add memory-type errata for T-Head
>> > >
>> > > Wei Fu (1):
>> > >   riscv: add RISC-V Svpbmt extension support
>> > >
>> > >  arch/riscv/Kconfig.erratas                  |  29 +++--
>> > >  arch/riscv/Kconfig.socs                     |   1 -
>> > >  arch/riscv/Makefile                         |   2 +-
>> > >  arch/riscv/errata/Makefile                  |   2 +-
>> > >  arch/riscv/errata/sifive/errata.c           |  17 ++-
>> > >  arch/riscv/errata/thead/Makefile            |   1 +
>> > >  arch/riscv/errata/thead/errata.c            |  85 +++++++++++++++
>> > >  arch/riscv/include/asm/alternative-macros.h | 114 +++++++++++---------
>> > >  arch/riscv/include/asm/alternative.h        |  16 ++-
>> > >  arch/riscv/include/asm/errata_list.h        |  52 +++++++++
>> > >  arch/riscv/include/asm/fixmap.h             |   2 -
>> > >  arch/riscv/include/asm/hwcap.h              |   1 +
>> > >  arch/riscv/include/asm/pgtable-32.h         |  17 +++
>> > >  arch/riscv/include/asm/pgtable-64.h         |  79 +++++++++++++-
>> > >  arch/riscv/include/asm/pgtable-bits.h       |  10 --
>> > >  arch/riscv/include/asm/pgtable.h            |  53 +++++++--
>> > >  arch/riscv/include/asm/vendorid_list.h      |   1 +
>> > >  arch/riscv/kernel/Makefile                  |   1 +
>> > >  arch/riscv/{errata => kernel}/alternative.c |  48 +++++++--
>> > >  arch/riscv/kernel/cpu.c                     |   1 +
>> > >  arch/riscv/kernel/cpufeature.c              |  80 +++++++++++++-
>> > >  arch/riscv/kernel/module.c                  |  29 +++++
>> > >  arch/riscv/kernel/sbi.c                     |  10 +-
>> > >  arch/riscv/kernel/setup.c                   |   2 +
>> > >  arch/riscv/kernel/smpboot.c                 |   4 -
>> > >  arch/riscv/kernel/traps.c                   |   2 +-
>> > >  arch/riscv/mm/init.c                        |   1 +
>> > >  27 files changed, 546 insertions(+), 114 deletions(-)
>> > >  create mode 100644 arch/riscv/errata/thead/Makefile
>> > >  create mode 100644 arch/riscv/errata/thead/errata.c
>> > >  rename arch/riscv/{errata => kernel}/alternative.c (59%)
>> > 
>> 
>> 
