Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37AE534B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbiEZIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346590AbiEZIDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:03:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C51170367;
        Thu, 26 May 2022 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VyX8pOU5Kx5xXW7rQ6M4FCSql6AwXKJBYD0UdJmHeAM=; b=ns0XlMGuz5q36hF8ULS7GYKSXr
        x9E0Hh+4alviWY80plNauY16+lg4hONYd2bNl6FAgufL2vy19EdG2CrvNqRMjDPywXKi5ESwlfmT1
        Ni9my8Xg6crJLVOSI5zmnnNlSvVGJk58qFsrBRc+bcD3jBwwAvgAORpOqdFZilFU1ra1Ha+rHhsBO
        7dPGJMnpeiQfRg/FkPhfmFoE4LXYSel9ZxisdKnUTk8NMaBTw1zcqem9DenD6LLjeXKDcmkPOM8uz
        R3HxE/c1locUDA0B9uJrR/xF7nYx2TGBTcW5n3x88Ug42KX6+v2riOf/FVpI0NpLoSfG03HMWvmP8
        ATCL05uA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nu8Sf-001qoL-RL; Thu, 26 May 2022 08:03:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B9F8980E04; Thu, 26 May 2022 10:03:13 +0200 (CEST)
Date:   Thu, 26 May 2022 10:03:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: objtool warning, branch, patch, and .config (GCC bug)
Message-ID: <20220526080313.GM2578@worktop.programming.kicks-ass.net>
References: <20220525173332.GA4008581@paulmck-ThinkPad-P17-Gen-1>
 <20220525173444.GA4010526@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220525173444.GA4010526@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+ Josh + toolchains

Start of thread (including .config) here:

  https://lore.kernel.org/all/20220525173332.GA4008581@paulmck-ThinkPad-P17=
-Gen-1/T/#u

On Wed, May 25, 2022 at 10:34:44AM -0700, Paul E. McKenney wrote:
> On Wed, May 25, 2022 at 10:33:32AM -0700, Paul E. McKenney wrote:
> > Hello, Peter,
> >=20
> > Please see below for a .config that emits this warning:
> >=20
> > $ make -j32 kernel/rcu/{rcuscale,rcu_segcblist,rcutorture,refscale,srcu=
tree,sync,tree,update}.o kernel/torture.o
> > kernel/rcu/update.o: warning: objtool: rcu_tasks_trace_pertask() falls =
through to next function rcu_tasks_trace_postscan.cold()
> > kernel/rcu/update.o: warning: objtool: rcu_tasks_trace_postscan() falls=
 through to next function rcu_early_boot_tests()
> >=20
> > The commit where I see it is for-peterz.2022.05.25a on -rcu.
> >=20
> > If I apply this patch, it goes away.  Sometimes it goes away of its own
> > accord, no idea why.
>=20
> And the compiler:
>=20
> $ gcc -v
> Using built-in specs.
> COLLECT_GCC=3Dgcc
> COLLECT_LTO_WRAPPER=3D/usr/lib/gcc/x86_64-linux-gnu/9/lto-wrapper
> OFFLOAD_TARGET_NAMES=3Dnvptx-none:hsa
> OFFLOAD_TARGET_DEFAULT=3D1
> Target: x86_64-linux-gnu
> Configured with: ../src/configure -v --with-pkgversion=3D'Ubuntu 9.4.0-1u=
buntu1~20.04.1' --with-bugurl=3Dfile:///usr/share/doc/gcc-9/README.Bugs --e=
nable-languages=3Dc,ada,c++,go,brig,d,fortran,objc,obj-c++,gm2 --prefix=3D/=
usr --with-gcc-major-version-only --program-suffix=3D-9 --program-prefix=3D=
x86_64-linux-gnu- --enable-shared --enable-linker-build-id --libexecdir=3D/=
usr/lib --without-included-gettext --enable-threads=3Dposix --libdir=3D/usr=
/lib --enable-nls --enable-clocale=3Dgnu --enable-libstdcxx-debug --enable-=
libstdcxx-time=3Dyes --with-default-libstdcxx-abi=3Dnew --enable-gnu-unique=
-object --disable-vtable-verify --enable-plugin --enable-default-pie --with=
-system-zlib --with-target-system-zlib=3Dauto --enable-objc-gc=3Dauto --ena=
ble-multiarch --disable-werror --with-arch-32=3Di686 --with-abi=3Dm64 --wit=
h-multilib-list=3Dm32,m64,mx32 --enable-multilib --with-tune=3Dgeneric --en=
able-offload-targets=3Dnvptx-none=3D/build/gcc-9-Av3uEd/gcc-9-9.4.0/debian/=
tmp-nvptx/usr,hsa --without-cuda-driver --enable-checking=3Drelease --build=
=3Dx86_64-linux-gnu --host=3Dx86_64-linux-gnu --target=3Dx86_64-linux-gnu
> Thread model: posix
> gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1)=20

Right, I so have a Debian based 9.4 but it reproduces just fine. The
offending code gen is:

=2E..

00000000000059f0 <rcu_tasks_trace_pertask>:
    59f0:       48 85 ff                test   %rdi,%rdi
    59f3:       74 40                   je     5a35 <rcu_tasks_trace_pertas=
k+0x45>
    59f5:       65 48 8b 04 25 00 00 00 00      mov    %gs:0x0,%rax     59f=
a: R_X86_64_32S      current_task
    59fe:       48 39 c7                cmp    %rax,%rdi
    5a01:       74 32                   je     5a35 <rcu_tasks_trace_pertas=
k+0x45>
    5a03:       c6 87 41 04 00 00 00    movb   $0x0,0x441(%rdi)
    5a0a:       f0 83 44 24 fc 00       lock addl $0x0,-0x4(%rsp)
    5a10:       c7 87 3c 04 00 00 ff ff ff ff   movl   $0xffffffff,0x43c(%r=
di)
    5a1a:       8b 87 3c 04 00 00       mov    0x43c(%rdi),%eax
    5a20:       83 f8 ff                cmp    $0xffffffff,%eax
    5a23:       74 11                   je     5a36 <rcu_tasks_trace_pertas=
k+0x46>
    5a25:       0f b6 87 58 04 00 00    movzbl 0x458(%rdi),%eax
    5a2c:       84 c0                   test   %al,%al
    5a2e:       0f 85 00 00 00 00       jne    5a34 <rcu_tasks_trace_pertas=
k+0x44>      5a30: R_X86_64_PC32     .text.unlikely+0x30e
    5a34:       c3                      ret
    5a35:       c3                      ret
    5a36:       e9 65 fb ff ff          jmp    55a0 <trc_wait_for_one_reade=
r.part.0>
    5a3b:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)

0000000000005a40 <rcu_tasks_trace_postscan>:
    5a40:       41 54                   push   %r12
    5a42:       49 89 fc                mov    %rdi,%r12
    5a45:       55                      push   %rbp
    5a46:       bd ff ff ff ff          mov    $0xffffffff,%ebp
    5a4b:       53                      push   %rbx
    5a4c:       65 48 8b 1c 25 00 00 00 00      mov    %gs:0x0,%rbx     5a5=
1: R_X86_64_32S      current_task
    5a55:       89 ef                   mov    %ebp,%edi
    5a57:       48 c7 c6 00 00 00 00    mov    $0x0,%rsi        5a5a: R_X86=
_64_32S      __cpu_online_mask
    5a5e:       e8 00 00 00 00          call   5a63 <rcu_tasks_trace_postsc=
an+0x23>     5a5f: R_X86_64_PLT32    cpumask_next-0x4
    5a63:       3b 05 00 00 00 00       cmp    0x0(%rip),%eax        # 5a69=
 <rcu_tasks_trace_postscan+0x29>     5a65: R_X86_64_PC32     nr_cpu_ids-0x4
    5a69:       89 c5                   mov    %eax,%ebp
    5a6b:       73 50                   jae    5abd <rcu_tasks_trace_postsc=
an+0x7d>
    5a6d:       89 ef                   mov    %ebp,%edi
    5a6f:       e8 00 00 00 00          call   5a74 <rcu_tasks_trace_postsc=
an+0x34>     5a70: R_X86_64_PLT32    idle_task-0x4
    5a74:       48 89 c7                mov    %rax,%rdi
    5a77:       48 85 c0                test   %rax,%rax
    5a7a:       74 d9                   je     5a55 <rcu_tasks_trace_postsc=
an+0x15>
    5a7c:       48 39 d8                cmp    %rbx,%rax
    5a7f:       74 d4                   je     5a55 <rcu_tasks_trace_postsc=
an+0x15>
    5a81:       c6 80 41 04 00 00 00    movb   $0x0,0x441(%rax)
    5a88:       f0 83 44 24 fc 00       lock addl $0x0,-0x4(%rsp)
    5a8e:       c7 80 3c 04 00 00 ff ff ff ff   movl   $0xffffffff,0x43c(%r=
ax)
    5a98:       8b 80 3c 04 00 00       mov    0x43c(%rax),%eax
    5a9e:       83 f8 ff                cmp    $0xffffffff,%eax
    5aa1:       74 10                   je     5ab3 <rcu_tasks_trace_postsc=
an+0x73>
    5aa3:       0f b6 87 58 04 00 00    movzbl 0x458(%rdi),%eax
    5aaa:       84 c0                   test   %al,%al
    5aac:       74 a7                   je     5a55 <rcu_tasks_trace_postsc=
an+0x15>
    5aae:       e9 00 00 00 00          jmp    5ab3 <rcu_tasks_trace_postsc=
an+0x73>     5aaf: R_X86_64_PC32     .text.unlikely+0x311
    5ab3:       4c 89 e6                mov    %r12,%rsi
    5ab6:       e8 e5 fa ff ff          call   55a0 <trc_wait_for_one_reade=
r.part.0>
    5abb:       eb 98                   jmp    5a55 <rcu_tasks_trace_postsc=
an+0x15>
    5abd:       e8 00 00 00 00          call   5ac2 <rcu_tasks_trace_postsc=
an+0x82>     5abe: R_X86_64_PLT32    cpus_read_unlock-0x4
    5ac2:       5b                      pop    %rbx
    5ac3:       5d                      pop    %rbp
    5ac4:       41 5c                   pop    %r12
    5ac6:       e9 00 00 00 00          jmp    5acb <rcu_tasks_trace_postsc=
an+0x8b>     5ac7: R_X86_64_PLT32    synchronize_rcu-0x4
    5acb:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)

=2E..

0000000000000312 <rcu_tasks_trace_pertask.cold>:
 312:   8b 47 14                mov    0x14(%rdi),%eax

0000000000000315 <rcu_tasks_trace_postscan.cold>:
 315:   8b 47 14                mov    0x14(%rdi),%eax

0000000000000318 <rcu_early_boot_tests>:
=2E..


Which is just bloody weird/broken if you ask me. What's worse, GCC-10
does the same. Only when I use GCC-11 do I get sensible code again:

00000000000002ef <rcu_tasks_trace_postscan.cold>:
 2ef:   8b 4f 14                mov    0x14(%rdi),%ecx
 2f2:   8b 97 88 05 00 00       mov    0x588(%rdi),%edx
 2f8:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi        2fb: R_X86_64_32S  =
     .rodata+0x40
 2ff:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi        302: R_X86_64_32S  =
     .rodata.str1.8+0x5e0
 306:   e8 00 00 00 00          call   30b <rcu_tasks_trace_postscan.cold+0=
x1c> 307: R_X86_64_PLT32     _printk-0x4
 30b:   e9 00 00 00 00          jmp    310 <rcu_tasks_trace_pertask.cold>  =
     30c: R_X86_64_PC32      .text+0x5721

0000000000000310 <rcu_tasks_trace_pertask.cold>:
 310:   8b 4f 14                mov    0x14(%rdi),%ecx
 313:   8b 97 88 05 00 00       mov    0x588(%rdi),%edx
 319:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi        31c: R_X86_64_32S  =
     .rodata+0x40
 320:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi        323: R_X86_64_32S  =
     .rodata.str1.8+0x5e0
 327:   e9 00 00 00 00          jmp    32c <rcu_early_boot_tests>       328=
: R_X86_64_PLT32     _printk-0x4


> > ------------------------------------------------------------------------
> >=20
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 3f7601eca554d..0104bb37a034b 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1388,8 +1388,6 @@ static void trc_wait_for_one_reader(struct task_s=
truct *t,
> > =20
> >  	// The current task had better be in a quiescent state.
> >  	if (t =3D=3D current) {
> > -		if (READ_ONCE(t->trc_needreport))
> > -			pr_info("%s(P%d/%d) is currently running task.\n", __func__, t->pid=
, task_cpu(t));
> >  		rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
> >  		WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
> >  		return;
> > @@ -1398,8 +1396,6 @@ static void trc_wait_for_one_reader(struct task_s=
truct *t,
> >  	// Attempt to nail down the task for inspection.
> >  	get_task_struct(t);
> >  	if (!task_call_func(t, trc_inspect_reader, NULL)) {
> > -		if (READ_ONCE(t->trc_needreport))
> > -			pr_info("%s(P%d/%d) task_call_func() succeeded.\n", __func__, t->pi=
d, task_cpu(t));
> >  		put_task_struct(t);
> >  		return;
> >  	}
> >=20
> > ------------------------------------------------------------------------

Yeah, so it moves that printk invocation into a .cold subfunction, which
is entirely reasonable, except it then completely mangles it, which is
less reasonable.

I suppose the next step is you upgrading your compiler to gcc-11 or
later and any inteterested tools person looking at fixing gcc<11 if they
still care enough about them.
