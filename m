Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5207503401
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiDPCII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiDPCGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D632711A0D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650074409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YHrAg7n6zMoQ3QTYYxR0HFkLhNqMvfNcjlotyIwEVgI=;
        b=IB05sqLjHSPlruu2/UZOajj2Sb6f42cPZsA2QqsX7YeHcLSfa2YaaFbELcoEaw5ZXv1DVD
        isq4BGfqYb9vmsMefTwSHM/i5VbxaZRIFlOEGA13YsReYb3j2tj/21jdOCdXN4xxxJcKSO
        LL1PIu6HTF6ck50bsuLL68BghSoDCSY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-UQ9Rk-8kPWisiR6yO0sNNw-1; Fri, 15 Apr 2022 20:46:53 -0400
X-MC-Unique: UQ9Rk-8kPWisiR6yO0sNNw-1
Received: by mail-qt1-f200.google.com with SMTP id d18-20020ac81192000000b002ebdd6ef307so6078562qtj.20
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHrAg7n6zMoQ3QTYYxR0HFkLhNqMvfNcjlotyIwEVgI=;
        b=hHvuCute046G6zWipNRhZ90QOFJrCU13iaTML43SOH6fA4oJBk84YggkbRjDK+sONN
         Cn7+SY2KvCGV0Gd9IczTezbGt27Y0W5Wji8EPEci5C1l6LMPbL0vTkvcmiIg8tRjBr62
         mCma7Ycshs29YMX5XCNsLLjrRuU6ru94+SxQKPIKvWTe5gxF2r8doITCPOHwd0yd75KM
         a65WzsYYe3abOBevKPWFU3hmifgqh712c9u44fkDr5iEvxTm4lTnY/PxF5fl4HLj7/+D
         +FOA5BlsmIo54zdGXeU5Xwnr2/H75CDfQmX2slpmmzbdnHYPuOP9FGQbxP4GJ1DKOlXw
         gW2Q==
X-Gm-Message-State: AOAM532vo7yst3UnK1cwNXB3Sm6b8xpWwo4JA5FVbGKU9w3eqQweoQLC
        XnO+CJXB51z5MAi3duoyTm3EHN2kY/kAOG9cXl5NczWI2bFD2witukGbEya1GkEmZrjGF7vzH00
        39rsxGL4fRvuc4cxh1IvtHpB+
X-Received: by 2002:a05:620a:6cc:b0:69b:dd1b:3235 with SMTP id 12-20020a05620a06cc00b0069bdd1b3235mr898675qky.374.1650070012288;
        Fri, 15 Apr 2022 17:46:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/vsoWJjZRlJ6n6b4XIGJrVAS1j6Hb0fZcrj3UE2XFvrB3IhH7pwRt7ixO8WS6cPipqhJ6rg==
X-Received: by 2002:a05:620a:6cc:b0:69b:dd1b:3235 with SMTP id 12-20020a05620a06cc00b0069bdd1b3235mr898664qky.374.1650070011948;
        Fri, 15 Apr 2022 17:46:51 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id k66-20020a37ba45000000b0069c5adb2f2fsm3300842qkf.6.2022.04.15.17.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:46:51 -0700 (PDT)
Date:   Fri, 15 Apr 2022 17:46:48 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com
Subject: Re: [PATCH 1/2] x86/unwind/orc: recheck address range after stack
 info was updated
Message-ID: <20220416004648.qttbugqbh5u2aja6@treble>
References: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:40:03AM +0300, Dmitry Monakhov wrote:
> get_stack_info() detects stack type only by begin address, so we must
> check that address range in question is fully covered by detected stack
> 
> Otherwise following crash is possible:
> -> unwind_next_frame
>    case ORC_TYPE_REGS:
>      if (!deref_stack_regs(state, sp, &state->ip, &state->sp))
>      -> deref_stack_regs
>        -> stack_access_ok  <- here addr is inside stack range, but addr+len-1 is not, but we still exit with success
>      *ip = READ_ONCE_NOCHECK(regs->ip); <- Here we hit stack guard fault

Hi Dmitry,

Thanks for the patch.

As Peter mentioned, the root cause of the crash was that the stack was
changing while the unwinder was reading it.  But the patch is still
valid since the unwinder needs to be paranoid.

The commit log should have that background.

> OOPS LOG:
> <0>[ 1941.845743] BUG: stack guard page was hit at 000000000dd984a2 (stack is 00000000d1caafca..00000000613712f0)
> <4>[ 1941.845744] kernel stack overflow (page fault): 0000 [#1] SMP NOPTI
> <4>[ 1941.845744] CPU: 93 PID: 23787 Comm: context_switch1 Not tainted 5.4.145 #1
> <4>[ 1941.845745] Hardware name: XXXXXXXXXXXXXX
> <4>[ 1941.845746] RIP: 0010:unwind_next_frame+0x311/0x5b0
> <4>[ 1941.845746] Code: 01 0f 84 f6 01 00 00 0f 83 cc fe ff ff e9 f9 fe ff ff ba a8 00 00 00 4c 89 fe 48 89 df e8 57 fa ff ff 84 c0 0f 84 d9 00 00 00 <49> 8b 87 80 00 00 00 48 89 43 48 49 8b 87 98 00 00 00 4c 89 7b 50
> <4>[ 1941.845747] RSP: 0018:fffffe00012908f0 EFLAGS: 00010002
> <4>[ 1941.845748] RAX: 0000000000000001 RBX: fffffe0001290930 RCX: 0000000000000001
> <4>[ 1941.845748] RDX: 0000000000000002 RSI: ffff893d94719e80 RDI: ffffc9001b9d7fc8
> <4>[ 1941.845748] RBP: 0000000000000004 R08: ffffffff81a009bf R09: ffffffff824c7c20
> <4>[ 1941.845749] R10: ffffffff824c7c1c R11: 0000000000000023 R12: ffffffff826c9cde
> <4>[ 1941.845749] R13: ffffffff81a009d2 R14: fffffe0001289ff0 R15: ffffc9001b9d7fc8
> <4>[ 1941.845749] FS:  00007f57ff9aa700(0000) GS:ffff893f6f140000(0000) knlGS:0000000000000000
> <4>[ 1941.845750] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[ 1941.845750] CR2: ffffc9001b9d8048 CR3: 000000bcd3936000 CR4: 0000000000340ee0
> <4>[ 1941.845750] Call Trace:
> <4>[ 1941.845750]  <NMI>
> <4>[ 1941.845751]  perf_callchain_kernel+0x12b/0x140
> <4>[ 1941.845751]  ? interrupt_entry+0xb2/0xc0
> <4>[ 1941.845751]  get_perf_callchain+0x10d/0x280
> <4>[ 1941.845751]  perf_callchain+0x6e/0x80
> <4>[ 1941.845752]  perf_prepare_sample+0x87/0x540
> <4>[ 1941.845752]  perf_event_output_forward+0x31/0x90
> <4>[ 1941.845752]  ? sched_clock+0x5/0x10
> <4>[ 1941.845752]  ? sched_clock_cpu+0xc/0xb0
> <4>[ 1941.845753]  ? arch_perf_update_userpage+0xd0/0xe0
> <4>[ 1941.845753]  ? sched_clock+0x5/0x10
> <4>[ 1941.845753]  ? sched_clock_cpu+0xc/0xb0
> <4>[ 1941.845753]  __perf_event_overflow+0x5a/0xf0
> <4>[ 1941.845754]  perf_ibs_handle_irq+0x340/0x5b0
> <4>[ 1941.845754]  ? interrupt_entry+0xb2/0xc0
> <4>[ 1941.845754]  ? interrupt_entry+0xb2/0xc0
> <4>[ 1941.845754]  ? __set_pte_vaddr+0x28/0x40
> <4>[ 1941.845755]  ? __set_pte_vaddr+0x28/0x40
> <4>[ 1941.845755]  ? set_pte_vaddr+0x3c/0x60
> <4>[ 1941.845755]  ? __native_set_fixmap+0x24/0x30
> <4>[ 1941.845755]  ? native_set_fixmap+0x3c/0xb0
> <4>[ 1941.845756]  ? ghes_copy_tofrom_phys+0x98/0x130
> <4>[ 1941.845756]  ? interrupt_entry+0xb2/0xc0
> <4>[ 1941.845756]  ? __ghes_peek_estatus.isra.16+0x49/0xb0
> <4>[ 1941.845756]  ? perf_ibs_nmi_handler+0x34/0x60
> <4>[ 1941.845757]  ? sched_clock+0x5/0x10
> <4>[ 1941.845757]  perf_ibs_nmi_handler+0x34/0x60
> <4>[ 1941.845757]  nmi_handle+0x79/0x190
> <4>[ 1941.845757]  default_do_nmi+0x3e/0x110
> <4>[ 1941.845758]  do_nmi+0x18d/0x1e0
> <4>[ 1941.845758]  end_repeat_nmi+0x16/0x50
> <4>[ 1941.845758] RIP: 0010:syscall_return_via_sysret+0x26/0x7f
> <4>[ 1941.845759] Code: 3e 09 00 00 41 5f 41 5e 41 5d 41 5c 5d 5b 5e 41 5a 41 59 41 58 58 5e 5a 5e 48 89 e7 65 48 8b 24 25 04 60 00 00 ff 77 28 ff 37 <50> eb 43 0f 20 df eb 34 48 89 f8 48 81 e7 ff 07 00 00 65 48 0f a3
> <4>[ 1941.845759] RSP: 0018:fffffe0001289ff0 EFLAGS: 00000046
> <4>[ 1941.845760] RAX: 0000000000000001 RBX: 0000559a21ff71d0 RCX: 00007f57ff286260
> <4>[ 1941.845760] RDX: 0000000000000001 RSI: 00007ffe43dc3d17 RDI: ffffc9001b9d7fc8
> <4>[ 1941.845760] RBP: 00007ffe43dc3d17 R08: 0000000000005ceb R09: 00007f57ff9aa700
> <4>[ 1941.845761] R10: 00007f57ff9aa9d0 R11: 0000000000000246 R12: 00007f57ff9aa698
> <4>[ 1941.845761] R13: 00007f57ff9b5d00 R14: 0000559a1d5bb070 R15: 0000000000000005
> <4>[ 1941.845761]  ? syscall_return_via_sysret+0x26/0x7f
> <4>[ 1941.845761]  ? syscall_return_via_sysret+0x26/0x7f
> <4>[ 1941.845762]  </NMI>
> <4>[ 1941.845762]  <ENTRY_TRAMPOLINE>
> <4>[ 1941.845762]  </ENTRY_TRAMPOLINE>
> <4>[ 1941.845762] Modules linked in: unix_diag ip6table_filter sch_fq_codel tcp_diag inet_diag act_police act_gact cls_u32 sch_ingress netconsole configfs 8021q garp stp mrp llc amd64_edac_mod edac_mce_amd ghash_clmulni_intel ipmi_ssif ipmi_si ipmi_devintf ipmi_msghandler sp5100_tco i2c_piix4 k10temp tcp_htcp tcp_bbr kvm_amd ccp kvm irqbypass mpls_gso mpls_iptunnel mpls_router fou6 fou ip_tunnel ip6_udp_tunnel udp_tunnel mlx4_en mlx4_core dummy msr ip6_tables ip_tables x_tables ip6_tunnel tunnel6 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear ast drm_vram_helper i2c_algo_bit mlx5_core drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops mlxfw ttm pci_hyperv_intf tls drm

This oops has way too much detail for the commit log and can be trimmed
down a lot.  See for example the backtraces section in
Documentation/process/submitting-patches.rst.

> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> ---
>  arch/x86/kernel/unwind_orc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 794fdef2501a..80b878772b86 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -343,7 +343,9 @@ static bool stack_access_ok(struct unwind_state *state, unsigned long _addr,
>  	    (get_stack_info(addr, state->task, info, &state->stack_mask)))
>  		return false;
>  
> -	return true;
> +	/* Recheck range after stack info was updated */
> +	return on_stack(info, addr, len);
> +
>  }

This punishes the typical case where the first on_stack() call
succeeded.  It only needs to be done if the first on_stack() failed.

-- 
Josh

