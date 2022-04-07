Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6130F4F74F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 06:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbiDGEsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 00:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbiDGErd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:47:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DE4B28;
        Wed,  6 Apr 2022 21:45:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KYpj13M0Wz4x5W;
        Thu,  7 Apr 2022 14:45:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649306726;
        bh=nboON7t6FGjROyfVQUKf5whIOw0I2W4Po+mSYogO1MA=;
        h=Date:From:To:Cc:Subject:From;
        b=qfYeiIxBJiRBD8xOndebn6NfWnTQ0yho8SJZeoWV9bdNIMSGx8lAnMe1Lu7sqj83B
         432V0I7zcZQm2GkIgp5UOycXsp48K6bZMWDYRF4AbQnTna6EaATD8ZEeIq6HgWemQc
         pESq9Z6kSS2nMJUtXEaUM00Jju3nXf1rKhbzgoAj7zy40BdyztW8n/Om0mndbYdR9f
         BqPFhBFdUZBPcrdOvMnnfGv2W23QN/7sD6DcIC0JMy5G3+/0MxmVkF7BFNlQao1nbs
         57zj7nS+UcsF1NTNLvmh9GBN2bUWE+PEPqE4I3WisxOSbj371rU9ECzBT4RRFupObu
         vfHLZdnBXHtuQ==
Date:   Thu, 7 Apr 2022 14:45:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: linux-next: runtime warning after merge of the cel-fixes tree
Message-ID: <20220407144524.2a592ed6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mmSWu2=IIrDB.qOXQSmL4o4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mmSWu2=IIrDB.qOXQSmL4o4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cel-fixes tree, today's linux-next build (powerpc
pseries_le_defconfig) produced this warning:

ftrace: allocating 33539 entries in 13 pages
ftrace: allocated 13 pages with 3 groups
trace event string verifier disabled
rcu: Hierarchical RCU implementation.
rcu: 	RCU event tracing is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=3D2048 to nr_cpu_ids=3D1.
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D1
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/trace/trace_events.c:431 trace_event_raw_i=
nit+0x1a4/0x7d0
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.18.0-rc1 #2
NIP:  c0000000002c0924 LR: c0000000002c0ce8 CTR: c0000000002c0990
REGS: c000000002787a00 TRAP: 0700   Not tainted  (5.18.0-rc1)
MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 44000282  XER: 20000000
CFAR: c0000000002c0b34 IRQMASK: 1=20
GPR00: c0000000002c0cd0 c000000002787ca0 c00000000278ae00 0000000000000000=
=20
GPR04: 000000000000002c 0000000000000005 0000000000000057 c0000000002c08ac=
=20
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR12: c0000000002c0780 c000000002950000 0000000000000003 0000000000000000=
=20
GPR16: 0000000002bf00d0 000000007e68ebc8 c000000000fb0758 000508b58019388f=
=20
GPR20: 0000000000000000 0000000000000001 c000000000fb0748 0000000000000003=
=20
GPR24: 0000000000000000 0000000000000000 0000000000000001 0000000000000000=
=20
GPR28: c0000000026fcde0 c0000000026f60e0 000000000000005f c0000000026f613f=
=20
NIP [c0000000002c0924] trace_event_raw_init+0x1a4/0x7d0
LR [c0000000002c0ce8] trace_event_raw_init+0x568/0x7d0
Call Trace:
[c000000002787ca0] [c0000000002c0cd0] trace_event_raw_init+0x550/0x7d0 (unr=
eliable)
[c000000002787da0] [c0000000002bd908] event_init+0x78/0x100
[c000000002787e10] [c0000000020346ac] trace_event_init+0xc8/0x334
[c000000002787eb0] [c000000002033d20] trace_init+0x18/0x2c
[c000000002787ed0] [c000000002004318] start_kernel+0x598/0x8d8
[c000000002787f90] [c00000000000d19c] start_here_common+0x1c/0x600
Instruction dump:
41800348 60000000 60420000 3bde0001 7fdf07b4 7ffdfa14 891f0000 710a00ff=20
4082ff5c 2c3a0000 38600000 41820230 <0fe00000> f9c10070 f9e10078 fa010080=20
---[ end trace 0000000000000000 ]---
event svc_defer_recv has unsafe dereference of argument 1
print_fmt: "addr=3D%pISpc dr=3D%p xid=3D0x%08x", (struct sockaddr *)__get_d=
ynamic_array(addr), REC->dr, REC->xid
event svc_defer_queue has unsafe dereference of argument 1
print_fmt: "addr=3D%pISpc dr=3D%p xid=3D0x%08x", (struct sockaddr *)__get_d=
ynamic_array(addr), REC->dr, REC->xid
event svc_defer_drop has unsafe dereference of argument 1
print_fmt: "addr=3D%pISpc dr=3D%p xid=3D0x%08x", (struct sockaddr *)__get_d=
ynamic_array(addr), REC->dr, REC->xid
NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.

Introduced by commit

  e2e917f8677d ("SUNRPC: Fix the svc_deferred_event trace class")

At least reverting that commit makes the warning go away.

I have left that commit reverted for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/mmSWu2=IIrDB.qOXQSmL4o4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJObGQACgkQAVBC80lX
0GyE2wf/aGM5jaE1UYPkt402jf3FnD++s6vDpNtL3TdInMu1BvQomoHhWEXOeLZl
3YLmQqZ5KkGEwIxW4XzNdZOehfvNcwZ1Vy0+jlntByXxm5sJ6bbK1UTX1XHtEFKg
V2crd4KrFvbtWR362m3DAjU8phBm8EnvKxEBRpIuSfG/MbuhM6KAnEOX25Z4qklq
VIjLe/byUihoGf7v++eTYWmn63Mi6bpxHz7t+EB57Nb0gwoX0u2jTFaxnMfCoyqz
TDeqVtJ8NTBxeq0LG7yOLzyRlqxeGEIeDJwa3uh+hVBnag8YqKfnqtNF4NCmSxS2
GvThRU9lb+G3a9y4a1+MSry8WjfqVQ==
=skcD
-----END PGP SIGNATURE-----

--Sig_/mmSWu2=IIrDB.qOXQSmL4o4--
