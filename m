Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F9B543033
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiFHMXx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Jun 2022 08:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbiFHMXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:23:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AFB1C590E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:23:38 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1nyuij-0006jK-8c; Wed, 08 Jun 2022 14:23:33 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@rivosinc.com>, Ron Economos <re@w6rz.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V Patches for the 5.19 Merge Window, Part 1
Date:   Wed, 08 Jun 2022 14:23:32 +0200
Message-ID: <1767879.8hzESeGDPO@diego>
In-Reply-To: <06c46bde-5d3f-9123-93b4-9e0f3824ac3a@w6rz.net>
References: <mhng-3cfe92b5-a83a-4642-9b9e-8416ae717fd6@palmer-ri-x1c9> <827324415.0ifERbkFSE@diego> <06c46bde-5d3f-9123-93b4-9e0f3824ac3a@w6rz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 8. Juni 2022, 02:12:47 CEST schrieb Ron Economos:
> On 6/7/22 4:36 PM, Heiko Stübner wrote:
> > Am Dienstag, 7. Juni 2022, 22:46:52 CEST schrieb Ron Economos:
> >> On 5/31/22 10:13 AM, Palmer Dabbelt wrote:
> >>> The following changes since commit 9282d0996936c5fbf877c0d096a3feb456c878ad:
> >>>
> >>>     csky: Move to generic ticket-spinlock (2022-05-11 11:50:15 -0700)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>     git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-mw0
> >>>
> >>> for you to fetch changes up to 7699f7aacf3ebfee51c670b6f796b2797f0f7487:
> >>>
> >>>     RISC-V: Prepare dropping week attribute from arch_kexec_apply_relocations[_add] (2022-05-30 16:04:37 -0700)
> >>>
> >>> ----------------------------------------------------------------
> >>> RISC-V Patches for the 5.19 Merge Window, Part 1
> >>>
> >>> * Support for the Svpbmt extension, which allows memory attributes to be
> >>>     encoded in pages.
> >>>
> >>>
> >>> Heiko Stuebner (12):
> >>>         riscv: integrate alternatives better into the main architecture
> >>>         riscv: allow different stages with alternatives
> >>>         riscv: implement module alternatives
> >>>         riscv: implement ALTERNATIVE_2 macro
> >>>         riscv: extend concatenated alternatives-lines to the same length
> >>>         riscv: prevent compressed instructions in alternatives
> >>>         riscv: move boot alternatives to after fill_hwcap
> >>>         riscv: Fix accessing pfn bits in PTEs for non-32bit variants
> >>>         riscv: add RISC-V Svpbmt extension support
> >>>         riscv: remove FIXMAP_PAGE_IO and fall back to its default value
> >>>         riscv: don't use global static vars to store alternative data
> >>>         riscv: add memory-type errata for T-Head
> >>>
> >> An issue was found on the HiFive Unmatched with the 5.19-rc1 kernel. The
> >> following warning occurs during boot:
> >>
> >> riscv64 kernel:
> >> ----------------------------------------------------------------
> >> riscv64 kernel: WARNING: Missing the following errata may cause
> >> potential issues
> >> riscv64 kernel:         SiFive Errata[0]:cip-453
> >> riscv64 kernel:         SiFive Errata[1]:cip-1200
> >> riscv64 kernel: Please enable the corresponding Kconfig to apply them
> >> riscv64 kernel:
> >> ----------------------------------------------------------------
> >>
> >> I've manually bisected the problem to this commit:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ff689fd21cb13098305bae3f8d0c0065df2e2fc1
> > hmm, on first glance I can't really see how that specific commit would
> > affect Sifive erratas. Patches directly before this one did change
> > alternative / errata things though.
> >
> > (1) From looking at your output, it seems at least CONFIG_ERRATA_SIFIVE
> > is enabled as the general sifive errata code is running, but are the
> > individual erratas also still enabled in your config?
> > They're default=y forever and weren't touched by the svpbmt series,
> > but it'd be nice to know how the config looks, to see if the Kconfig
> > settings are strange somewhere
> >
> >
> > (2) Going from the list on
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=ff689fd21cb13098305bae3f8d0c0065df2e2fc1
> >
> > could you maybe check if it's really working with the parent of the
> > commit you found. (i.e. patches before the svpbmt addition).
> >
> > Also just to be sure, it still works correctly with 5.18, right?
> >
> >
> > Thanks
> > Heiko
> >
> >
> Yes, that commit was surprising. I also thought it would have been one 
> of the previous "alternatives" commits. But I tested them all, and the 
> warning only appears with the "add RISC-V Svpbmt extension support" 
> commit. In other words, "git checkout 100631b" works fine, but "git 
> checkout ff689fd" does not.

after talking with Ron a bit more, we came across the finding that the
warnings actually happen later in the boot process, pointing to modules.

Which lead me to [0] for explanation of the issue and a possible fix.


[0] https://lore.kernel.org/r/20220608120849.1695191-1-heiko@sntech.de/




