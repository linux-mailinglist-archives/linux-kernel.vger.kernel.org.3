Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFBF4D1F21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349177AbiCHRbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiCHRbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:31:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C81255574F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646760635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=l7asnA7LXZyQWZy5g2QEgoRUfjTEVlMr+Ij+QDuYX2o=;
        b=dGMnYALNImQh37g0kDktb054hMk5YidZm0GuH+DfZi+vefeg8CdvUeO2Vhd2HpmxvJ2rIE
        eRqBXDxzoplpnPR7woNGs+2eiapuTZI3MagtiFSMTlsGWk144qeCGKLN6CwJohEErbxRkf
        JurDjG9yPA+ypvEmvU8mit8WxjOQdoY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-q1-q4eNMNACB3cZJvaqAHQ-1; Tue, 08 Mar 2022 12:30:32 -0500
X-MC-Unique: q1-q4eNMNACB3cZJvaqAHQ-1
Received: by mail-wr1-f69.google.com with SMTP id a11-20020adffb8b000000b001efe754a488so5705991wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=l7asnA7LXZyQWZy5g2QEgoRUfjTEVlMr+Ij+QDuYX2o=;
        b=Ufpv/E0iOwQRheeIaEo8VbyjwwEHEIvv4VrL+8qNESuny08QkyV/g1PO1I7e7XuIqU
         4UqrJBJ9xb8jLMB9KivpabyssivGyK+Dbs4yRqnCgqRqQ6F8H10kVa1STlyHvySMk2WZ
         HoEuFkL8hhIhtJF1yYLz80iP992hurF2Ha/X+aR5lsY9P0Jyh/tDWpkcX8Y3skk8PulF
         kv+gCR7DeAbOigjSVcSWdtW7Avq10M8bnl/xIN9r0SNA60FVthlrZk6NgZG6wjDipqp3
         ZaRgRmCUwjyBcSlN9t8Fn50V/ZhC77QNrt7Lgjr8tS8tGYuAAIesFik2dXsLkaBQ0mC7
         6xaA==
X-Gm-Message-State: AOAM533Orup0ySkbVTjlxh7tfNIqgdD/jrP3IJu0HJUCKKrnR0bV0K4o
        Yq5DHXNqMeJH16Ood0QnjYo6rAPRIPIVXp7j0Sk5Nr+a6oQT0TON/KvSJhJf22ei0fI6WJRK1oH
        KwN/AvTkEjzuQ5qAfuBLIPVw4
X-Received: by 2002:a5d:5255:0:b0:1f0:5992:673e with SMTP id k21-20020a5d5255000000b001f05992673emr13005761wrc.423.1646760631157;
        Tue, 08 Mar 2022 09:30:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiu9fGlgmzu8FeVd8qv7AaiAa/14Gb+xn6++scnNFw2UwFoXBTbpf2fcr3a6+avTm0rZ+KxQ==
X-Received: by 2002:a5d:5255:0:b0:1f0:5992:673e with SMTP id k21-20020a5d5255000000b001f05992673emr13005744wrc.423.1646760630937;
        Tue, 08 Mar 2022 09:30:30 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3506:3400:69b5:c807:1d52:ff67? ([2a0c:5a80:3506:3400:69b5:c807:1d52:ff67])
        by smtp.gmail.com with ESMTPSA id r186-20020a1c2bc3000000b0037bdd94a4e5sm2757590wmr.39.2022.03.08.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:30:29 -0800 (PST)
Message-ID: <c898d1911f7f9303b7e14726e7cc9678fbfb4a0e.camel@redhat.com>
Subject: Warning when exiting osnoise tracer
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>, bristot <bristot@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org, mtosatti <mtosatti@redhat.com>
Date:   Tue, 08 Mar 2022 18:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running next-20220307, on a system with isolated CPUs (don't know if
relevant but less tested code-path), I see this after killing (ctrl-C) the
following trace command:

	trace-cmd record -e all -M 10 -p osnoise --poll

Note that this is *without* my recent osnoise patch.

[  129.925474] ------------[ cut here ]------------
[  129.926021] WARNING: CPU: 0 PID: 1217 at kernel/tracepoint.c:404 tracepoint_probe_unregister+0x280/0x370
[  129.927077] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink intel_rapl_msr intel_rapl_common irqbypass iTCO_wdt rapl snd_pcm iTCO_vendor_support snd_timer snd soundcore i2c_i801 lpc_ich i2c_smbus virtio_balloon pcspkr fuse drm xfs libcrc32c crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ahci libahci serio_raw virtio_net libata net_failover failover virtio_blk
[  129.932263] CPU: 0 PID: 1217 Comm: trace-cmd Not tainted 5.17.0-rc6-next-20220307-nico+ #19
[  129.933184] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.15.0-1.el9 04/01/2014
[  129.933947] RIP: 0010:tracepoint_probe_unregister+0x280/0x370
[  129.934590] Code: 48 8d 04 40 48 8d 0c c3 48 8b 01 48 85 c0 74 21 49 39 c5 75 e5 4c 3b 71 08 75 df 48 c7 01 20 95 3e ae eb d6 41 bc fe ff ff ff <0f> 0b e9 22 ff ff ff 48 81 fb 00 f0 ff ff 0f 87 cb 00 00 00 45 31
[  129.936605] RSP: 0018:ffffb978c1093db8 EFLAGS: 00010246
[  129.937192] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  129.937968] RDX: ffff8ee953ab8000 RSI: ffffffffae40cb20 RDI: ffffffffafc4c940
[  129.938752] RBP: ffffffffafd1c560 R08: 0000000000000000 R09: 0000000000000000
[  129.939537] R10: 0000000000000010 R11: 0000000000000000 R12: 00000000fffffffe
[  129.940323] R13: ffffffffae40cb20 R14: 0000000000000000 R15: 0000000000000003
[  129.941104] FS:  00007ff9198d1740(0000) GS:ffff8ee97ca00000(0000) knlGS:0000000000000000
[  129.941992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  129.942633] CR2: 00007ff919b29497 CR3: 0000000109da4005 CR4: 0000000000170ef0
[  129.943420] Call Trace:
[  129.943714]  <TASK>
[  129.943960]  osnoise_workload_stop+0x36/0x90
[  129.944447]  tracing_set_tracer+0x108/0x260
[  129.944917]  tracing_set_trace_write+0x94/0xd0
[  129.945423]  ? __check_object_size.part.0+0x10a/0x150
[  129.945986]  ? selinux_file_permission+0x104/0x150
[  129.946531]  vfs_write+0xb5/0x290
[  129.946908]  ksys_write+0x5f/0xe0
[  129.947291]  do_syscall_64+0x3b/0x90
[  129.947693]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  129.948257] RIP: 0033:0x7ff919a18127
[  129.948660] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  129.950688] RSP: 002b:00007ffe388ceda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  129.951530] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff919a18127
[  129.952355] RDX: 0000000000000003 RSI: 000000000044a514 RDI: 0000000000000004
[  129.953142] RBP: 00007ffe388cede0 R08: 0000000001cffd40 R09: 00007ff919a8a4e0
[  129.953917] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe388cf0c8
[  129.954692] R13: 000000000040a578 R14: 00007ff919b67aa0 R15: 0000000000461d18
[  129.955477]  </TASK>
[  129.955728] ---[ end trace 0000000000000000 ]---

Regards,

-- 
Nicolás Sáenz

