Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7188C52DE60
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiESU0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiESU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AEE27168;
        Thu, 19 May 2022 13:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E1B4617ED;
        Thu, 19 May 2022 20:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F313C34100;
        Thu, 19 May 2022 20:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652991967;
        bh=Quh9L0q3EahfNIUTr+QDaYHBwXik/wbXAFmGrSnt9fI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1KrnXNRvU+9wV1q3KLJidxtm9bnPrPVuVIPpnmNCknQ35CXkWLDk/n0Z/cjaVUBh
         i4RwQDb5oxRe29AbKFCVc3F+H/VjBowWcdHsluxPcvWPgZoGRp8Zgjvv6tJEhg2OcI
         9BsRM0XpZ3oSecOGPkdHY55bbB+TcW+9VdQoxI20/3QTFM/UjNmzgR1FdVUGM+EKgz
         ToBb2WAYowYOGH0qLnOQn0KaWr7nyX6aOWauzZPvQOvu7ZNJ8izxrbm+ZQE5dPzgYZ
         WSbIVObb26EY5x3ebaiIdUStR65xhh1xFrro7TkQgVP147ymcC5wKJu3KWydixnXBR
         eXxn+99uGjAsA==
Date:   Thu, 19 May 2022 13:26:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 00/21] KCFI support
Message-ID: <Yoan3dgL988r0Mv/@dev-arch.thelio-3990X>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <CA+icZUWr+-HjMvY1VZf+nqjTadxSTDciux0Y5Y-+p_j4o7CmXg@mail.gmail.com>
 <CABCJKueVcwYishxSoEyn9b1vaGTXdoYWF7VyANPm7V=H+yyfhQ@mail.gmail.com>
 <CA+icZUUBqz1zTcj61nK=sbkWcSncKYZgR2Qg0FSCWi9un84yLw@mail.gmail.com>
 <YoPuMhc03hUJxmPs@dev-arch.thelio-3990X>
 <CA+icZUU0k8UHRiFvV45nr1xY0p3SgaG+MLjJoEnmUCQ8T+WGdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUU0k8UHRiFvV45nr1xY0p3SgaG+MLjJoEnmUCQ8T+WGdg@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 11:01:40AM +0200, Sedat Dilek wrote:
> On Tue, May 17, 2022 at 8:49 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > I have run kCFI (v1, I haven't had time to test v2) on x86_64 hardware,
> > both AMD and Intel. I have only found two failures so far: the i915
> > issue that I mention below and a failure in the KVM subsystem, which I
> > can see by just running QEMU:
> >
> 
> Is there a fix around this issue?

No, I mentioned it offhand to Sami in IRC but I never followed up. This
failure appears to be introduced by commit f922bd9bf33b ("KVM: Move MMU
notifier's mmu_lock acquisition into common helper").

Sami, do you want an issue opened around this somewhere?

> > [  124.344654] CFI failure at kvm_mmu_notifier_invalidate_range_end+0xca/0x177 [kvm] (target: kvm_null_fn+0x0/0x7 [kvm]; expected type: 0x1e2c5b9c)
> > [  124.344691] WARNING: CPU: 5 PID: 2767 at kvm_mmu_notifier_invalidate_range_end+0xca/0x177 [kvm]
> > [  124.344708] Modules linked in: ...
> > [  124.344737] CPU: 5 PID: 2767 Comm: qemu-system-x86 Tainted: P                  5.18.0-rc6-debug-00033-g1d5284aff7cd #1 8c4966c7fb24f3345076747feebac5fb340a4797
> > [  124.344738] Hardware name: ASUS System Product Name/PRIME Z590M-PLUS, BIOS 1203 10/27/2021
> > [  124.344738] RIP: 0010:kvm_mmu_notifier_invalidate_range_end+0xca/0x177 [kvm]
> > [  124.344756] Code: 48 89 da e8 88 16 86 dd 48 85 c0 89 6c 24 0c 74 30 4d 85 f6 74 36 48 c7 c5 19 c8 b4 c0 4c 8b 34 24 81 7d fa 9c 5b 2c 1e 74 02 <0f> 0b 48 89 c7 4c 89 fe 48 89 da e8 b6 16 86 dd 48 85 c0 75 e2 eb
> > [  124.344757] RSP: 0018:ffffc033039d78e8 EFLAGS: 00010282
> > [  124.344758] RAX: ffffa0a141ed9450 RBX: 00007fb897e9efff RCX: ffffa0a143c9d850
> > [  124.344758] RDX: 00007fb897e9efff RSI: 00007fb897e9e000 RDI: ffffc03304499cf8
> > [  124.344759] RBP: ffffffffc0b4c819 R08: 0000000000000000 R09: 0000000000000000
> > [  124.344759] R10: 0000000000000000 R11: ffffffffc0b4c639 R12: ffffc03304499000
> > [  124.344760] R13: ffffc033044a30a0 R14: ffffc033044a3120 R15: 00007fb897e9e000
> > [  124.344760] FS:  00007fbca4bc3640(0000) GS:ffffa0a87f540000(0000) knlGS:0000000000000000
> > [  124.344761] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  124.344761] CR2: 0000000000000000 CR3: 0000000119f74006 CR4: 0000000000772ee0
> > [  124.344762] PKRU: 55555554
> > [  124.344762] Call Trace:
> > [  124.344762]  <TASK>
> > [  124.344763]  __mmu_notifier_invalidate_range_end+0xa1/0xd7
> > [  124.344764]  wp_page_copy+0x592/0x920
> > [  124.344766]  __handle_mm_fault+0x820/0x8f0
> > [  124.344767]  handle_mm_fault+0xe0/0x227
> > [  124.344768]  __get_user_pages+0x17a/0x430
> > [  124.344769]  get_user_pages_unlocked+0xd9/0x327
> > [  124.344770]  hva_to_pfn+0xfa/0x3f7 [kvm 950e483805e01f967a3e331506278d766494a4cc]
> > [  124.344788]  kvm_faultin_pfn+0xc3/0x2f0 [kvm 950e483805e01f967a3e331506278d766494a4cc]
> > [  124.344806]  ? fast_page_fault+0x400/0x4c0 [kvm 950e483805e01f967a3e331506278d766494a4cc]
> > [  124.344823]  direct_page_fault+0x130/0x350 [kvm 950e483805e01f967a3e331506278d766494a4cc]
> > [  124.344841]  kvm_mmu_page_fault+0x176/0x2f7 [kvm 950e483805e01f967a3e331506278d766494a4cc]
> > [  124.344858]  vmx_handle_exit+0xe/0x37 [kvm_intel 647f514f18fc365045dc57db46d2bb4930b746eb]
> > [  124.344863]  vcpu_enter_guest+0xbff/0x1030 [kvm 950e483805e01f967a3e331506278d766494a4cc]
> > [  124.344881]  vcpu_run+0x65/0x2f0 [kvm 950e483805e01f967a3e331506278d766494a4cc]
> > [  124.344898]  kvm_arch_vcpu_ioctl_run+0x15f/0x3f7 [kvm 950e483805e01f967a3e331506278d766494a4cc]
> > [  124.344916]  kvm_vcpu_ioctl+0x547/0x627 [kvm 950e483805e01f967a3e331506278d766494a4cc]
> > [  124.344933]  ? syscall_exit_to_user_mode+0x24/0x47
> > [  124.344934]  ? do_syscall_64+0x7a/0x97
> > [  124.344935]  ? __fget_files+0xa1/0xc0
> > [  124.344936]  __se_sys_ioctl+0x7c/0xc0
> > [  124.344937]  do_syscall_64+0x6c/0x97
> > [  124.344938]  ? do_syscall_64+0x7a/0x97
> > [  124.344939]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  124.344940] RIP: 0033:0x7fbca75f7b1f
> > [  124.344940] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> > [  124.344941] RSP: 002b:00007fbca4bc2550 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > [  124.344942] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007fbca75f7b1f
> > [  124.344942] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000000e
> > [  124.344943] RBP: 000056351ba661d0 R08: 000056351a74dc48 R09: 0000000000000004
> > [  124.344943] R10: 004818cf4f129e11 R11: 0000000000000246 R12: 0000000000000000
> > [  124.344943] R13: 0000000000000000 R14: 00007fbca814f004 R15: 0000000000000000
> > [  124.344944]  </TASK>
> > [  124.344945] ---[ end trace 0000000000000000 ]---

Cheers,
Nathan
