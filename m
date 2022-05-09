Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B91051FB3D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiEIL1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiEIL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:27:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E0F17E2F;
        Mon,  9 May 2022 04:23:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kxf1m29bWz4xcY;
        Mon,  9 May 2022 21:23:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652095420;
        bh=sVs5mE+Ih3vtL54hZC+Fs5rcEMw8hXULCDyv47iMCHs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IyqhQceKIEyWrymMJCxBBLPDPJoW9lXFbcM/+XIHN+P1SJuD5NLSpHecI1OLCdxXk
         KmTyC942+G8VL8CXYLHXJpmwxWEKEw20+b4kzzceMWfijyEybKBsVpb72W3R54VDfk
         bxpH61zCrH4QN1zEiSQ5KIx9faZdCg5K7zHcjJvHnJ/TddaRwviekxIitWuwm8Rrye
         iqJwM1Cl70gDrGTaqS0q+4qFP3fXRcreI9a9viIVPmHPoyTNogcgbFgyOSoawzILGJ
         s+igR1+pNVaQ+vLURaFX08a1/yy2mipfTkcKn/K5NimVWlj30WFp1faRzLiZhPTHdX
         ERe6HYjyBTreA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Cc:     fnovak@us.ibm.com
Subject: Re: request_module DoS
In-Reply-To: <YnXiuhdZ49pKL/dK@gondor.apana.org.au>
References: <YnXiuhdZ49pKL/dK@gondor.apana.org.au>
Date:   Mon, 09 May 2022 21:23:39 +1000
Message-ID: <874k1zt0ec.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:
> Hi:
>
> There are some code paths in the kernel where you can reliably
> trigger a request_module of a non-existant module.  For example,
> if you attempt to load a non-existent crypto algorithm, or create
> a socket of a non-existent network family, it will result in a
> request_module call that is guaranteed to fail.
>
> As user-space can do this repeatedly, it can quickly overwhelm
> the concurrency limit in kmod.  This in itself is expected,
> however, at least on some platforms this appears to result in
> a live-lock.  Here is an example triggered by stress-ng on ppc64:
>
> [  529.853264] request_module: kmod_concurrent_max (0) close to 0 (max_modprobes: 50), for module crypto-aegis128l, throttling...
...
> [  580.414590] __request_module: 25 callbacks suppressed
> [  580.414597] request_module: kmod_concurrent_max (0) close to 0 (max_modprobes: 50), for module crypto-aegis256-all, throttling...
> [  580.423082] watchdog: CPU 784 self-detected hard LOCKUP @ plpar_hcall_norets_notrace+0x18/0x2c
> [  580.423097] watchdog: CPU 784 TB:1297691958559475, last heartbeat TB:1297686321743840 (11009ms ago)
> [  580.423099] Modules linked in: cast6_generic cast5_generic cast_common camellia_generic blowfish_generic blowfish_common tun nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill bonding tls ip_set nf_tables nfnetlink pseries_rng binfmt_misc drm drm_panel_orientation_quirks xfs libcrc32c sd_mod t10_pi sg ibmvscsi ibmveth scsi_transport_srp vmx_crypto dm_mirror dm_region_hash dm_log dm_mod fuse
> [  580.423136] CPU: 784 PID: 77071 Comm: stress-ng Kdump: loaded Not tainted 5.14.0-55.el9.ppc64le #1
> [  580.423139] NIP:  c0000000000f8ff4 LR: c0000000001f7c38 CTR: 0000000000000000
> [  580.423140] REGS: c0000043fdd7bd60 TRAP: 0900   Not tainted  (5.14.0-55.el9.ppc64le)
> [  580.423142] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28008202  XER: 20040000
> [  580.423148] CFAR: 0000000000000c00 IRQMASK: 1 
>                GPR00: 0000000028008202 c0000044c46b3850 c000000002a46f00 0000000000000000 
>                GPR04: ffffffffffffffff 0000000000000000 0000000000000010 c000000002a83060 
>                GPR08: 0000000000000000 0000000000000001 0000000000000001 0000000000000000 
>                GPR12: c0000000001b9530 c0000043ffe16700 0000000200000117 0000000010185ea8 
>                GPR16: 0000000010212150 0000000010186198 00000000101863a0 000000001021b3c0 
>                GPR20: 0000000000000001 0000000000000000 0000000000000001 00000000000000ff 
>                GPR24: c0000043f4a00e14 c0000043fafe0e00 000000000c440000 0000000000000000 
>                GPR28: c0000043f4a00e00 c0000043f4a00e00 c0000000021e0e00 c000000002561aa0 
> [  580.423166] NIP [c0000000000f8ff4] plpar_hcall_norets_notrace+0x18/0x2c
> [  580.423168] LR [c0000000001f7c38] __pv_queued_spin_lock_slowpath+0x528/0x530
> [  580.423173] Call Trace:
> [  580.423174] [c0000044c46b3850] [0000000100006b60] 0x100006b60 (unreliable)
> [  580.423177] [c0000044c46b3910] [c000000000ea6948] _raw_spin_lock_irqsave+0xa8/0xc0
> [  580.423182] [c0000044c46b3940] [c0000000001dd7c0] prepare_to_wait_event+0x40/0x200
> [  580.423185] [c0000044c46b39a0] [c00000000019e9e0] __request_module+0x320/0x510
> [  580.423188] [c0000044c46b3ac0] [c0000000006f1a14] crypto_alg_mod_lookup+0x1e4/0x2e0
> [  580.423192] [c0000044c46b3b60] [c0000000006f2178] crypto_alloc_tfm_node+0xa8/0x1a0
> [  580.423194] [c0000044c46b3be0] [c0000000006f84f8] crypto_alloc_aead+0x38/0x50
> [  580.423196] [c0000044c46b3c00] [c00000000072cba0] aead_bind+0x70/0x140
> [  580.423199] [c0000044c46b3c40] [c000000000727824] alg_bind+0xb4/0x210
> [  580.423201] [c0000044c46b3cc0] [c000000000bc2ad4] __sys_bind+0x114/0x160
> [  580.423205] [c0000044c46b3d90] [c000000000bc2b48] sys_bind+0x28/0x40
> [  580.423207] [c0000044c46b3db0] [c000000000030880] system_call_exception+0x160/0x300
> [  580.423209] [c0000044c46b3e10] [c00000000000c168] system_call_vectored_common+0xe8/0x278
> [  580.423213] --- interrupt: 3000 at 0x7fff9b824464
> [  580.423214] NIP:  00007fff9b824464 LR: 0000000000000000 CTR: 0000000000000000
> [  580.423215] REGS: c0000044c46b3e80 TRAP: 3000   Not tainted  (5.14.0-55.el9.ppc64le)
> [  580.423216] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42004802  XER: 00000000
> [  580.423221] IRQMASK: 0 
>                GPR00: 0000000000000147 00007fffdcff2780 00007fff9b917100 0000000000000004 
>                GPR04: 00007fffdcff27e0 0000000000000058 0000000000000000 0000000000000000 
>                GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>                GPR12: 0000000000000000 00007fff9bc9efe0 0000000200000117 0000000010185ea8 
>                GPR16: 0000000010212150 0000000010186198 00000000101863a0 000000001021b3c0 
>                GPR20: 0000000000000004 00007fffdcff2a00 0000000300000117 00000000101862b8 
>                GPR24: 0000000000000004 0000000046401570 0000000046401120 0000000046404650 
>                GPR28: 0000000000000020 0000000000000020 0000000000000060 0000000046404bf0 
> [  580.423236] NIP [00007fff9b824464] 0x7fff9b824464
> [  580.423237] LR [0000000000000000] 0x0
> [  580.423238] --- interrupt: 3000
> [  580.423239] Instruction dump:
> [  580.423241] e8690000 7c0803a6 3884fff8 78630100 78840020 4bfffeb8 3c4c0295 3842df24 
> [  580.423244] 7c421378 7c000026 90010008 44000022 <38800000> 988d0931 80010008 7c0ff120 
>
> Would it be possible to modify kmod so that in such cases that
> request_module calls fail more quickly rather than repeatedly
> obtaining a spinlock that appears to be under high contention?

If you run stress-ng with a timeout does the system eventually recover?

cheers
