Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468934E4774
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiCVU0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiCVU0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:26:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F74673E3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:25:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so3176637pjp.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KBqRRjmyBIn9G9ZorQxLnBHmi+/+3pYxqBdWDE+C/h0=;
        b=QVj4H0CUlWQ5vQKEDtMLPZ5WughFRdBirAdJepmK+UsR6L3WanpFq5R8rpbDgcBDU7
         eELiXn7Z5wxTnuBebBroHbMf3T6cUZBo+LzQNkpjmFVoaTQTUN6b9KMHJqg0PBCPACoV
         ADwC0mO/sw+ftEDvqUwCCmI1BNTB2j/AQYNeB3N0wvNV1QB9S2dxwuG4Q5pIAusqXvz/
         /R2wuSpQqQF7Y/YXNQF2WcdOEm0nlsIE4r7AD9/xHn80N0fudUE27DupJW9PSKmx0Ilt
         G7KOV3BDgGu3kjWie63TKNoqCz3T27Q6TFXn35pPLFQ/I2jpz+cpaPy9YrjQzzQIF/Oa
         iQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KBqRRjmyBIn9G9ZorQxLnBHmi+/+3pYxqBdWDE+C/h0=;
        b=5zpW7na3TRaSmYEljb6kILJtSEv0r4XHl9b5GGkEtUV0iTky1oXJXF2siLzC6uDTOy
         KOk9d0aF6ZyghnMrp3wRlB3F0wKJRDEjxgj7gJFjFTlCMmKwWF2T2FVNwHVA0VRYfOq3
         zFRXQUnJku7rl5kXsuxGSQpkIOrwMZMblZxZ+sNeDZTzrY9fycq5gH39WxzcS/+SjiVM
         D8/mYEuvaEH2HDbp1WTR8JaMWxV9XDQzanBBmPM5KLY063cNkywCOFKGs013T1Qvm5mT
         P0CkO0s/XCPfmmzNZV4YAMaLiW/jllCBcG1lZgm0pkE/QFVkq7Psm40Q+UTk6QNMFGgu
         fuzw==
X-Gm-Message-State: AOAM531Hzt+lI2xOnrIfr8fwJQgTBlm2Eau3+gsZFBiF103x6XuTQBPH
        GSvOtYOmwSU6dQKYeqAsuvPkYg==
X-Google-Smtp-Source: ABdhPJxpl3qEKXDhNbHnFZKQvRTCkeBj0DR1o/BQb6NrhzPQKyIlM6/7MwwUMElzOfKlgPPAzIwbeA==
X-Received: by 2002:a17:902:da90:b0:154:1510:acc7 with SMTP id j16-20020a170902da9000b001541510acc7mr20256747plx.103.1647980704517;
        Tue, 22 Mar 2022 13:25:04 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id 96-20020a17090a09e900b001c6dc775159sm3633031pjo.46.2022.03.22.13.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 13:25:03 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:25:03 -0700 (PDT)
X-Google-Original-Date: Tue, 22 Mar 2022 13:25:01 PDT (-0700)
Subject:     Re: [PATCH v7 00/13] riscv: support for Svpbmt and D1 memory types
In-Reply-To: <1720848.VLH7GnMWUR@diego>
CC:     anup@brainfault.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        drew@beagleboard.org, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>, wens@csie.org,
        maxime@cerno.tech, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        mick@ics.forth.gr, allen.baum@esperantotech.com,
        jscheid@ventanamicro.com, rtrauben@gmail.com, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-a2327bcc-8c68-48a5-9af6-94b7931194c8@palmer-ri-x1c9>
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

On Tue, 22 Mar 2022 09:09:04 PDT (-0700), heiko@sntech.de wrote:
> Am Freitag, 18. März 2022, 22:50:05 CET schrieb Palmer Dabbelt:
>> On Fri, 18 Mar 2022 09:22:29 PDT (-0700), heiko@sntech.de wrote:
>> > Hi Palmer,
>> >
>> > Am Freitag, 18. März 2022, 04:40:23 CET schrieb Palmer Dabbelt:
>> >> On Wed, 09 Mar 2022 14:06:55 PST (-0800), heiko@sntech.de wrote:
>> >> > Am Dienstag, 8. März 2022, 12:56:20 CET schrieb Heiko Stübner:
>> >> >> Hi Palmer,
>> >> >> 
>> >> >> Am Dienstag, 8. März 2022, 01:47:25 CET schrieb Palmer Dabbelt:
>> >> >> > On Mon, 07 Mar 2022 12:52:57 PST (-0800), heiko@sntech.de wrote:
>> >> >> > > Svpbmt is an extension defining "Supervisor-mode: page-based memory types"
>> >> >> > > for things like non-cacheable pages or I/O memory pages.
>> >> >> > >
>> >> >> > >
>> >> >> > > So this is my 2nd try at implementing Svpbmt (and the diverging D1 memory
>> >> >> > > types) using the alternatives framework.
>> >> >> > >
>> >> >> > > This includes a number of changes to the alternatives mechanism itself.
>> >> >> > > The biggest one being the move to a more central location, as I expect
>> >> >> > > in the future, nearly every chip needing some sort of patching, be it
>> >> >> > > either for erratas or for optional features (svpbmt or others).
>> >> >> > >
>> >> >> > > Detection of the svpbmt functionality is done via Atish's isa extension
>> >> >> > > handling series [0] and thus does not need any dt-parsing of its own
>> >> >> > > anymore.
>> >> >> > >
>> >> >> > > The series also introduces support for the memory types of the D1
>> >> >> > > which are implemented differently to svpbmt. But when patching anyway
>> >> >> > > it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the same
>> >> >> > > location.
>> >> >> > >
>> >> >> > > The only slightly bigger difference is that the "normal" type is not 0
>> >> >> > > as with svpbmt, so kernel patches for this PMA type need to be applied
>> >> >> > > even before the MMU is brought up, so the series introduces a separate
>> >> >> > > stage for that.
>> >> >> > >
>> >> >> > >
>> >> >> > > In theory this series is 3 parts:
>> >> >> > > - sbi cache-flush / null-ptr
>> >> >> > 
>> >> >> > That first patch looks like an acceptable candidate for fixes.  If 
>> >> >> > there's a regression that manifests I'm happy to take it, but if it's 
>> >> >> > only possible to manifest a crash with the new stuff then I'm OK just 
>> >> >> > holding off until the merge window.
>> >> >> 
>> >> >> While right now only my poking around the early init via alternatives
>> >> >> is affected, the problem exists for everyone.
>> >> >> 
>> >> >> I.e. I do consider flush_icache_all() to be generic enough that we
>> >> >> should expect someone trying to call this in some early code-path
>> >> >> as well.
>> >> >> 
>> >> >> But any call to flush_icache_all() before sbi_init() ran will cause the
>> >> >> breakage that is fixed by patch1 .
>> >> >> 
>> >> >> 
>> >> >> So it doesn't look like any _current_ code path has that issue, but
>> >> >> it might be good to just pick patch1 for the next merge window
>> >> >> individually?
>> >> >> 
>> >> >> 
>> >> >> 
>> >> >> > > - alternatives improvements
>> >> >> > > - svpbmt+d1
>> >> >> > >
>> >> >> > > So expecially patches from the first 2 areas could be applied when
>> >> >> > > deemed ready, I just thought to keep it together to show-case where
>> >> >> > > the end-goal is and not requiring jumping between different series.
>> >> >> > >
>> >> >> > >
>> >> >> > > I picked the recipient list from the previous versions, hopefully
>> >> >> > > I didn't forget anybody.
>> >> >> > >
>> >> >> > > changes in v7:
>> >> >> > > - fix typo in patch1 (Atish)
>> >> >> > > - moved to Atish's isa-extension framework
>> >> >> > > - and therefore move regular boot-alternatives directly behind fill_hwcaps
>> >> >> > > - change T-Head errata Kconfig text (Atish)
>> >> >> > 
>> >> >> > I was just poking around v6, so I have some minor comments there.  None 
>> >> >> > of those need to block merging this, but I am getting a bunch of build 
>> >> >> > failures under allmodconfig
>> >> >> > 
>> >> >> >     $ make.riscv allmodconfig
>> >> >> >     #
>> >> >> >     # configuration written to .config
>> >> >> >     #
>> >> >> >     $ make.riscv mm/kasan/init.o
>> >> >> >       SYNC    include/config/auto.conf.cmd
>> >> >> >       CALL    scripts/atomic/check-atomics.sh
>> >> >> >       CC      arch/riscv/kernel/asm-offsets.s
>> >> >> >       CALL    scripts/checksyscalls.sh
>> >> >> >       CC      mm/kasan/init.o
>> >> >> >     ./arch/riscv/include/asm/pgtable.h: Assembler messages:
>> >> >> >     ./arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> >> >> >     make[2]: *** [scripts/Makefile.build:288: mm/kasan/init.o] Error 1
>> >> >> >     make[1]: *** [scripts/Makefile.build:550: mm/kasan] Error 2
>> >> >> >     make: *** [Makefile:1831: mm] Error 2
>> >> >> > 
>> >> >> > Unfortunately my build box just blew up so I haven't had time to confim 
>> >> >> > this still exists on v7, but nothing's jumping out as a fix.  I've put 
>> >> >> > this on the riscv-d1 branch at kernel.org/palmer/linux, not sure exactly 
>> >> >> > what's going on but I'm guessing one of the macros has gone off the 
>> >> >> > rails.  I'm going to look at something else (as this one at least 
>> >> >> > depends on Atish's patches), but LMK if you've got the time to look into 
>> >> >> > this or if I should.
>> >> >> 
>> >> >> Yeah, we now depend on Atish's isa-extension parsing (same for my cmo
>> >> >> series and some more series I saw on the list), so getting that into a
>> >> >> mergeable position would be really great :-)
>> >> >> 
>> >> >> "attempt to move .org backwards" seems to be the telltale sign of the
>> >> >> alternatives blocks not matching up in size. While I definitly didn't see
>> >> >> anything like this in my tests on qemu + d1, I'll try to investigate where
>> >> >> that comes from.
>> >> >
>> >> > Hmm, looking at your branch [0] it seems that you're missing
>> >> > patch7 that introduces the no-compressed-instruction thingy
>> >> > for alternatives.
>> >> >
>> >> > And missing that patch will of course cause the size issue.
>> >> >
>> >> > The patch has made its way to the actual mailing lists [1], so I guess
>> >> > it "just" somehow didn't reach your inbox due to some mail hickup?
>> >> 
>> >> Sorry about that, I'm not sure what happened.
>> >
>> > no worries :-) . And I also have no clue where the hickup happened
>> > but am thankful that there is no general problem with mails.
>> >
>> >
>> >> Unfortunately I'm now getting some even trickier failures: a handful of 
>> >> configurations are failing very early in boot.  There doesn't seem to be 
>> >> much pattern to the configs that fail, but at least rv32 defconfig (on 
>> >> QEMU's virt board) is doing so.  I've tried poking around a bit and 
>> >> can't figure out what's going on.  I'll try and look again tomorrow 
>> >> morning.
>> 
>> (I guess morning means 2pm these days...)
>> 
>> > Hmm, really strange especially as the whole thing is somewhat
>> > limited to 64bit anyway.
>> >
>> > I guess it would be interesting if it's in the alternative-basics
>> > part of the svpbmt implementation.
>> 
>> Oddly enough it seems to be hanging as soon as I call into any of the 
>> m*id SBI routines, but I'm not entierly sure what's up and I've been 
>> bouncing between things so I might just be crazy.
>
> You're defintily not crazy here :-) .
>
> I.e. I didn't notice your reply from friday until now and so did the same
> stepping through the code myself as well, after finally getting a rv32
> build working.
>
> Similarly I ended up at sbi_get_mvendorid() being the first failing function.
>
> _But_ ... sbi isn't at fault here. What is causing the issue is the writes
> to the static global variables. And I guess that will also be the issue
> you saw on the other platforms.
>
> The early-alternatives-mechanism runs before the kernel relocation,
> so likely triggers some memory protection, which I didn't think of.
>
> I'll just rework the code to not use static variables for storing both
> the architecture-ids as well as the patch-func, which I think should
> solve that issue for all platforms.

Awesome, thanks for looking at this.

> Heiko
>
>
>> I did bisect the rv32-defconfig failure down to the last patch.
>> 
>> >
>> > My short try on getting a (any) rv32 kernel boot in qemu wasn't sucessful
>> > yet, so I'll need to poke that more next week.
>> 
>> There's a bunch of failing cases, not just rv32, but I can't figure out 
>> what logic there is behind the failing cases.  They're all in my 
>> riscv-system-ci repo, it's a mess but should at least build.  I see the 
>> following hang:
>> 
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/halt-strict_rwx/kernel -initrd check/qemu-rv32gc-virt-smp4/halt-strict_rwx/initrd -serial mon:pipe:/tmp/tmp.BM8zYJCKKZ/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/halt-slab_freelist_random/kernel -initrd check/qemu-rv32gc-virt-smp4/halt-slab_freelist_random/initrd -serial mon:pipe:/tmp/tmp.x7BL4Y1UsX/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/halt-medlow/kernel -initrd check/qemu-rv32gc-virt-smp4/halt-medlow/initrd -serial mon:pipe:/tmp/tmp.I9NZ3ow1GY/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/halt-kasan_sparsemem_novmemmmap/kernel -initrd check/qemu-rv32gc-virt-smp4/halt-kasan_sparsemem_novmemmmap/initrd -serial mon:pipe:/tmp/tmp.c9UPXaNcfR/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/halt-kasan_vmalloc/kernel -initrd check/qemu-rv32gc-virt-smp4/halt-kasan_vmalloc/initrd -serial mon:pipe:/tmp/tmp.AkLFnd3IDt/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/halt-kasan/kernel -initrd check/qemu-rv32gc-virt-smp4/halt-kasan/initrd -serial mon:pipe:/tmp/tmp.TbUWlXHDtO/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/halt-kasan_sparsemem_vmemmmap/kernel -initrd check/qemu-rv32gc-virt-smp4/halt-kasan_sparsemem_vmemmmap/initrd -serial mon:pipe:/tmp/tmp.E4h3Gw5Ecv/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/halt-slab/kernel -initrd check/qemu-rv32gc-virt-smp4/halt-slab/initrd -serial mon:pipe:/tmp/tmp.anq8X90A1C/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/halt-legacy_sbi/kernel -initrd check/qemu-rv32gc-virt-smp4/halt-legacy_sbi/initrd -serial mon:pipe:/tmp/tmp.4MK3Xys4YL/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/halt-vmap_stack/kernel -initrd check/qemu-rv32gc-virt-smp4/halt-vmap_stack/initrd -serial mon:pipe:/tmp/tmp.fC0b16uUpo/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 8G -smp 8 -cpu rv64 -kernel check/qemu-rv64gc-virt-smp8/halt-medlow/kernel -initrd check/qemu-rv64gc-virt-smp8/halt-medlow/initrd -serial mon:pipe:/tmp/tmp.t8nlK1Cvkk/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 8G -smp 8 -cpu rv64 -kernel check/qemu-rv64gc-virt-smp8/halt-kasan_sparsemem_novmemmmap/kernel -initrd check/qemu-rv64gc-virt-smp8/halt-kasan_sparsemem_novmemmmap/initrd -serial mon:pipe:/tmp/tmp.stV634slMi/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 8G -smp 8 -cpu rv64 -kernel check/qemu-rv64gc-virt-smp8/halt-kasan_vmalloc/kernel -initrd check/qemu-rv64gc-virt-smp8/halt-kasan_vmalloc/initrd -serial mon:pipe:/tmp/tmp.D0M6BSjwo2/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 8G -smp 8 -cpu rv64 -kernel check/qemu-rv64gc-virt-smp8/halt-kasan/kernel -initrd check/qemu-rv64gc-virt-smp8/halt-kasan/initrd -serial mon:pipe:/tmp/tmp.x9AoOydj6h/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 8G -smp 8 -cpu rv64 -kernel check/qemu-rv64gc-virt-smp8/halt-kasan_sparsemem_vmemmmap/kernel -initrd check/qemu-rv64gc-virt-smp8/halt-kasan_sparsemem_vmemmmap/initrd -serial mon:pipe:/tmp/tmp.cYwEP0Xod2/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 2G -smp 1 -cpu rv64 -kernel check/qemu-rv64gc-virt-m2g/halt-medlow/kernel -initrd check/qemu-rv64gc-virt-m2g/halt-medlow/initrd -serial mon:pipe:/tmp/tmp.EmYY46ZyFw/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 2G -smp 1 -cpu rv64 -kernel check/qemu-rv64gc-virt-m2g/halt-kasan_sparsemem_novmemmmap/kernel -initrd check/qemu-rv64gc-virt-m2g/halt-kasan_sparsemem_novmemmmap/initrd -serial mon:pipe:/tmp/tmp.UGF8OoNOXr/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 2G -smp 1 -cpu rv64 -kernel check/qemu-rv64gc-virt-m2g/halt-kasan_vmalloc/kernel -initrd check/qemu-rv64gc-virt-m2g/halt-kasan_vmalloc/initrd -serial mon:pipe:/tmp/tmp.E540ImVMDZ/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 2G -smp 1 -cpu rv64 -kernel check/qemu-rv64gc-virt-m2g/halt-kasan/kernel -initrd check/qemu-rv64gc-virt-m2g/halt-kasan/initrd -serial mon:pipe:/tmp/tmp.Hg8iJhkm2R/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 2G -smp 1 -cpu rv64 -kernel check/qemu-rv64gc-virt-m2g/halt-kasan_sparsemem_vmemmmap/kernel -initrd check/qemu-rv64gc-virt-m2g/halt-kasan_sparsemem_vmemmmap/initrd -serial mon:pipe:/tmp/tmp.4KQh2WmFWc/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M spike -m 1G -smp 1 -cpu rv64 -kernel check/qemu-rv64gc-spike/halt-legacy_sbi/kernel -initrd check/qemu-rv64gc-spike/halt-legacy_sbi/initrd -serial mon:pipe:/tmp/tmp.Ore2LcgxNR/guest -bios default -nographic -append console=hvc0
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 8G -smp 4 -cpu rv64 -kernel check/qemu-rv64gc-virt-smp4/halt-kasan/kernel -initrd check/qemu-rv64gc-virt-smp4/halt-kasan/initrd -serial mon:pipe:/tmp/tmp.jnvHnbSJKT/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 8G -smp 4 -cpu rv64 -kernel check/qemu-rv64gc-virt-smp4/halt-medlow/kernel -initrd check/qemu-rv64gc-virt-smp4/halt-medlow/initrd -serial mon:pipe:/tmp/tmp.30Kl16f7mY/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 8G -smp 4 -cpu rv64 -kernel check/qemu-rv64gc-virt-smp4/halt-kasan_sparsemem_novmemmmap/kernel -initrd check/qemu-rv64gc-virt-smp4/halt-kasan_sparsemem_novmemmmap/initrd -serial mon:pipe:/tmp/tmp.ojW4EsFqOX/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 8G -smp 4 -cpu rv64 -kernel check/qemu-rv64gc-virt-smp4/halt-kasan_vmalloc/kernel -initrd check/qemu-rv64gc-virt-smp4/halt-kasan_vmalloc/initrd -serial mon:pipe:/tmp/tmp.iKrvig4P7H/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv64 -M virt -m 8G -smp 4 -cpu rv64 -kernel check/qemu-rv64gc-virt-smp4/halt-kasan_sparsemem_vmemmmap/kernel -initrd check/qemu-rv64gc-virt-smp4/halt-kasan_sparsemem_vmemmmap/initrd -serial mon:pipe:/tmp/tmp.LGrpnHKQXO/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/cpuinfo-defconfig/kernel -initrd check/qemu-rv32gc-virt-smp4/cpuinfo-defconfig/initrd -serial mon:pipe:/tmp/tmp.0RO7a4EUiB/guest -bios default -nographic
>>     qemu/install/bin/qemu-system-riscv32 -M virt -m 1G -smp 4 -cpu rv32 -kernel check/qemu-rv32gc-virt-smp4/halt-defconfig/kernel -initrd check/qemu-rv32gc-virt-smp4/halt-defconfig/initrd -serial mon:pipe:/tmp/tmp.Ltd1s19HqT/guest -bios default -nographic
>> 
>> rv32 defconfig seemed like the simplest, but there's a bunch of rv64 
>> configs that fail too (though not defconfig, and the earlycon configs 
>> don't hang).
>> 
>> I'm going to go look at that other stuff I wanted to, but I'll try and 
>> find some time this weekend if nobody else can figure out what's up.
>> 
>> 
>> >
>> > Heiko
>> >
>> >
>> >> I've put my somewhat messy merged test branch at 
>> >> kernel.org/palmer/riscv-d1-merge .  Happy to hear if you have any 
>> >> insights, otherwise I'l give it another shot (possibly after looking at 
>> >> some other patches, there's quite a bit of a queue for this late).
>> >> 
>> >> >
>> >> >
>> >> > Heiko
>> >> >
>> >> >
>> >> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-d1
>> >> > [1] https://lore.kernel.org/all/20220307205310.1905628-8-heiko@sntech.de/
>> >> >
>> >> >
>> >> >> > > changes in v6:
>> >> >> > > - rebase onto 5.17-rc1
>> >> >> > > - handle sbi null-ptr differently
>> >> >> > > - improve commit messages
>> >> >> > > - use riscv,mmu as property name
>> >> >> > >
>> >> >> > > changes in v5:
>> >> >> > > - move to use alternatives for runtime-patching
>> >> >> > > - add D1 variant
>> >> >> > >
>> >> >> > >
>> >> >> > > [0] https://lore.kernel.org/r/20220222204811.2281949-2-atishp@rivosinc.com
>> >> >> > >
>> >> >> > >
>> >> >> > > Heiko Stuebner (12):
>> >> >> > >   riscv: prevent null-pointer dereference with sbi_remote_fence_i
>> >> >> > >   riscv: integrate alternatives better into the main architecture
>> >> >> > >   riscv: allow different stages with alternatives
>> >> >> > >   riscv: implement module alternatives
>> >> >> > >   riscv: implement ALTERNATIVE_2 macro
>> >> >> > >   riscv: extend concatenated alternatives-lines to the same length
>> >> >> > >   riscv: prevent compressed instructions in alternatives
>> >> >> > >   riscv: move boot alternatives to after fill_hwcap
>> >> >> > >   riscv: Fix accessing pfn bits in PTEs for non-32bit variants
>> >> >> > >   riscv: add cpufeature handling via alternatives
>> >> >> > >   riscv: remove FIXMAP_PAGE_IO and fall back to its default value
>> >> >> > >   riscv: add memory-type errata for T-Head
>> >> >> > >
>> >> >> > > Wei Fu (1):
>> >> >> > >   riscv: add RISC-V Svpbmt extension support
>> >> >> > >
>> >> >> > >  arch/riscv/Kconfig.erratas                  |  29 +++--
>> >> >> > >  arch/riscv/Kconfig.socs                     |   1 -
>> >> >> > >  arch/riscv/Makefile                         |   2 +-
>> >> >> > >  arch/riscv/errata/Makefile                  |   2 +-
>> >> >> > >  arch/riscv/errata/sifive/errata.c           |  17 ++-
>> >> >> > >  arch/riscv/errata/thead/Makefile            |   1 +
>> >> >> > >  arch/riscv/errata/thead/errata.c            |  85 +++++++++++++++
>> >> >> > >  arch/riscv/include/asm/alternative-macros.h | 114 +++++++++++---------
>> >> >> > >  arch/riscv/include/asm/alternative.h        |  16 ++-
>> >> >> > >  arch/riscv/include/asm/errata_list.h        |  52 +++++++++
>> >> >> > >  arch/riscv/include/asm/fixmap.h             |   2 -
>> >> >> > >  arch/riscv/include/asm/hwcap.h              |   1 +
>> >> >> > >  arch/riscv/include/asm/pgtable-32.h         |  17 +++
>> >> >> > >  arch/riscv/include/asm/pgtable-64.h         |  79 +++++++++++++-
>> >> >> > >  arch/riscv/include/asm/pgtable-bits.h       |  10 --
>> >> >> > >  arch/riscv/include/asm/pgtable.h            |  53 +++++++--
>> >> >> > >  arch/riscv/include/asm/vendorid_list.h      |   1 +
>> >> >> > >  arch/riscv/kernel/Makefile                  |   1 +
>> >> >> > >  arch/riscv/{errata => kernel}/alternative.c |  48 +++++++--
>> >> >> > >  arch/riscv/kernel/cpu.c                     |   1 +
>> >> >> > >  arch/riscv/kernel/cpufeature.c              |  80 +++++++++++++-
>> >> >> > >  arch/riscv/kernel/module.c                  |  29 +++++
>> >> >> > >  arch/riscv/kernel/sbi.c                     |  10 +-
>> >> >> > >  arch/riscv/kernel/setup.c                   |   2 +
>> >> >> > >  arch/riscv/kernel/smpboot.c                 |   4 -
>> >> >> > >  arch/riscv/kernel/traps.c                   |   2 +-
>> >> >> > >  arch/riscv/mm/init.c                        |   1 +
>> >> >> > >  27 files changed, 546 insertions(+), 114 deletions(-)
>> >> >> > >  create mode 100644 arch/riscv/errata/thead/Makefile
>> >> >> > >  create mode 100644 arch/riscv/errata/thead/errata.c
>> >> >> > >  rename arch/riscv/{errata => kernel}/alternative.c (59%)
>> >> >> > 
>> >> >> 
>> >> >> 
>> >> 
>> 
