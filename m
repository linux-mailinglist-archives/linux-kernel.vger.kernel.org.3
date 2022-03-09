Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646734D296F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiCIH1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiCIH07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:26:59 -0500
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.146.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03375ED946
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:26:00 -0800 (PST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 80FE0D192D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:26:00 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id Rqhsn4zbT22u3RqhsnpyVo; Wed, 09 Mar 2022 01:26:00 -0600
X-Authority-Reason: nr=8
Received: from host-82-63-1-3.business.telecomitalia.it ([82.63.1.3]:40294 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nRqhr-002Nwk-Sw; Wed, 09 Mar 2022 01:26:00 -0600
Message-ID: <eeb95928-02cf-a38c-8079-d2bbf4edb7e7@kernel.org>
Date:   Wed, 9 Mar 2022 08:25:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Warning when exiting osnoise tracer
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org, mtosatti <mtosatti@redhat.com>
References: <c898d1911f7f9303b7e14726e7cc9678fbfb4a0e.camel@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <c898d1911f7f9303b7e14726e7cc9678fbfb4a0e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 82.63.1.3
X-Source-L: No
X-Exim-ID: 1nRqhr-002Nwk-Sw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-82-63-1-3.business.telecomitalia.it ([10.0.0.45]) [82.63.1.3]:40294
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas

On 3/8/22 18:30, Nicolas Saenz Julienne wrote:
> While running next-20220307, on a system with isolated CPUs (don't know if
> relevant but less tested code-path), I see this after killing (ctrl-C) the
> following trace command:
> 
> 	trace-cmd record -e all -M 10 -p osnoise --poll
> 
> Note that this is *without* my recent osnoise patch.

yeah, your patch does not hit this part of the code.

> [  129.925474] ------------[ cut here ]------------
> [  129.926021] WARNING: CPU: 0 PID: 1217 at kernel/tracepoint.c:404 tracepoint_probe_unregister+0x280/0x370
> [  129.927077] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink intel_rapl_msr intel_rapl_common irqbypass iTCO_wdt rapl snd_pcm iTCO_vendor_support snd_timer snd soundcore i2c_i801 lpc_ich i2c_smbus virtio_balloon pcspkr fuse drm xfs libcrc32c crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ahci libahci serio_raw virtio_net libata net_failover failover virtio_blk
> [  129.932263] CPU: 0 PID: 1217 Comm: trace-cmd Not tainted 5.17.0-rc6-next-20220307-nico+ #19
> [  129.933184] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.15.0-1.el9 04/01/2014
> [  129.933947] RIP: 0010:tracepoint_probe_unregister+0x280/0x370
> [  129.934590] Code: 48 8d 04 40 48 8d 0c c3 48 8b 01 48 85 c0 74 21 49 39 c5 75 e5 4c 3b 71 08 75 df 48 c7 01 20 95 3e ae eb d6 41 bc fe ff ff ff <0f> 0b e9 22 ff ff ff 48 81 fb 00 f0 ff ff 0f 87 cb 00 00 00 45 31
> [  129.936605] RSP: 0018:ffffb978c1093db8 EFLAGS: 00010246
> [  129.937192] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  129.937968] RDX: ffff8ee953ab8000 RSI: ffffffffae40cb20 RDI: ffffffffafc4c940
> [  129.938752] RBP: ffffffffafd1c560 R08: 0000000000000000 R09: 0000000000000000
> [  129.939537] R10: 0000000000000010 R11: 0000000000000000 R12: 00000000fffffffe
> [  129.940323] R13: ffffffffae40cb20 R14: 0000000000000000 R15: 0000000000000003
> [  129.941104] FS:  00007ff9198d1740(0000) GS:ffff8ee97ca00000(0000) knlGS:0000000000000000
> [  129.941992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  129.942633] CR2: 00007ff919b29497 CR3: 0000000109da4005 CR4: 0000000000170ef0
> [  129.943420] Call Trace:
> [  129.943714]  <TASK>
> [  129.943960]  osnoise_workload_stop+0x36/0x90

osnoise_workload_stop() is being called twice by trace-cmd. trace-cmd stops the
tracer, and then after that, it switches to nop. I did not cover this case when
I added the support for multiple instances (it is a tracer problem, not a
trace-cmd problem).

I am testing a fix already - fix for 5.16 on.

Thanks!
-- Daniel

> [  129.944447]  tracing_set_tracer+0x108/0x260
> [  129.944917]  tracing_set_trace_write+0x94/0xd0
> [  129.945423]  ? __check_object_size.part.0+0x10a/0x150
> [  129.945986]  ? selinux_file_permission+0x104/0x150
> [  129.946531]  vfs_write+0xb5/0x290
> [  129.946908]  ksys_write+0x5f/0xe0
> [  129.947291]  do_syscall_64+0x3b/0x90
> [  129.947693]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  129.948257] RIP: 0033:0x7ff919a18127
> [  129.948660] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [  129.950688] RSP: 002b:00007ffe388ceda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  129.951530] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff919a18127
> [  129.952355] RDX: 0000000000000003 RSI: 000000000044a514 RDI: 0000000000000004
> [  129.953142] RBP: 00007ffe388cede0 R08: 0000000001cffd40 R09: 00007ff919a8a4e0
> [  129.953917] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe388cf0c8
> [  129.954692] R13: 000000000040a578 R14: 00007ff919b67aa0 R15: 0000000000461d18
> [  129.955477]  </TASK>
> [  129.955728] ---[ end trace 0000000000000000 ]---
> 
> Regards,
> 

