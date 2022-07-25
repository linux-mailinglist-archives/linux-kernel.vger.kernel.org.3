Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E129057FBCD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiGYIyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiGYIyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:54:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4739F14D35;
        Mon, 25 Jul 2022 01:54:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bp15so19324006ejb.6;
        Mon, 25 Jul 2022 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=47BArXHIXB9BaUKafjhngHzvOxajXlmoQN8z1D/nn+k=;
        b=B41XXnogGRTsWKKXwcoVzwsvOVhDu+KdXGyBeafZ1MaGPuUh4vnxjsQXjc8jbR5BBv
         SCctWK9I6ec7nWLK3mFS2ySQdQOQTcADnPRRy+INY23rx2hJ2FEdUM3vdMmvsTZMxi7X
         NCXPWQD27B9faXLggMdit79b6ZCsHXRXRB8HDWREM4Bf30T1E/jADVd5Do/UD0nlUfp+
         eMzDPGC3FdLP0swH/1Rz1dpt75QlZ2V2VR2T0h4iCIN5j5SOXNEb6zaD4f0+n29SZ90z
         Sgdr9kr94lC1Q/n8KU1MkFEghauVPT5XQ+NdXq3q8fGtWCUZAnwhmFCXQlRQJT02e7vo
         UljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=47BArXHIXB9BaUKafjhngHzvOxajXlmoQN8z1D/nn+k=;
        b=m5+KEMf6mRMJ2hu7EbfcMqArYpq+b4cIrR49MuC3nRtR3CIAeZKZ6b9bwq/Er4jKdL
         sERNv4Kprk5LcHiXNaWbJ9vNKu0OdL6ALx//gnVS6tF38zmspAqT9p2J7tLAze2KWn+E
         WBt4AiqwWLoybOY9ST9Kc7Ed1C14gQH35EpDu/sLijLMHWq3c7jzLHVesVU/C+Op5I1J
         RyHAXUHDTcVJo1zqLEoWnJNA6yaCJGkTLJyEXz0dXKWmZddrwrfGaUcGVSN+JoO/jEBv
         TNGZ+PL0L+U6tstwbJ6zvTxESzrGTiATT0W5r+tas6N9hfG1tE16TRiP+A6USueccAmZ
         lOHw==
X-Gm-Message-State: AJIora/fkCf2z/X4hN/tY0U+F6LcRUyujOhTAh1hDPZ0cRQO4TM5m8uZ
        UIsMqPpNy72A0iKSJE+YCkiPvRHcpe5yhujNACU=
X-Google-Smtp-Source: AGRyM1ucJl22LjVfdToVKOyeMo26q7eY0GRrHMqckh/jVztpOQJSV3YJaIKA5CRwG8w5JQUh30s5gHzVh+rKmUChl4w=
X-Received: by 2002:a17:906:8a5a:b0:72b:6b60:2d9f with SMTP id
 gx26-20020a1709068a5a00b0072b6b602d9fmr9263214ejc.324.1658739275459; Mon, 25
 Jul 2022 01:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220724010221.17371-1-zhouzhouyi@gmail.com> <878rohd3u8.fsf@mpe.ellerman.id.au>
In-Reply-To: <878rohd3u8.fsf@mpe.ellerman.id.au>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 25 Jul 2022 16:54:24 +0800
Message-ID: <CAABZP2wL4o+EjLWSxNNeyuo40zcDQDQ3Q0T1v9+h65phRLJMCg@mail.gmail.com>
Subject: Re: [PATCH linux-next] powerpc: init jump label early in ppc 64
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>,
        christophe.leroy@csgroup.eu, wangkefeng.wang@huawei.com,
        Nicholas Piggin <npiggin@gmail.com>, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 3:55 PM Michael Ellerman <mpe@ellerman.id.au> wrote=
:
>
> zhouzhouyi@gmail.com writes:
> > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >
> > In ppc 64, invoke jump_label_init in setup_feature_keys is too late
> > because static key will be used in subroutine of early_init_devtree.
> >
> > So we can invoke jump_label_init earlier in early_setup.
> > We can not move setup_feature_keys backward because its subroutine
> > cpu_feature_keys_init depend on data structures initialized in
> > early_init_devtree.
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> > Dear PPC developers
> >
> > I found this bug when trying to do rcutorture tests in ppc VM of
> > Open Source Lab of Oregon State University.
> >
> > qemu-system-ppc64 -nographic -smp cores=3D8,threads=3D1 -net none -M ps=
eries -nodefaults -device spapr-vscsi -serial file:/home/ubuntu/linux-next/=
tools/testing/selftests/rcutorture/res/2022.07.19-01.18.42-torture/results-=
rcutorture/TREE03/console.log -m 512 -kernel /home/ubuntu/linux-next/tools/=
testing/selftests/rcutorture/res/2022.07.19-01.18.42-torture/results-rcutor=
ture/TREE03/vmlinux -append "debug_boot_weak_hash panic=3D-1 console=3DttyS=
0 rcupdate.rcu_cpu_stall_suppress_at_boot=3D1 torture.disable_onoff_at_boot=
 rcupdate.rcu_task_stall_timeout=3D30000 rcutorture.onoff_interval=3D200 rc=
utorture.onoff_holdoff=3D30 rcutree.gp_preinit_delay=3D12 rcutree.gp_init_d=
elay=3D3 rcutree.gp_cleanup_delay=3D3 rcutree.kthread_prio=3D2 threadirqs t=
ree.use_softirq=3D0 rcutorture.n_barrier_cbs=3D4 rcutorture.stat_interval=
=3D15 rcutorture.shutdown_secs=3D420 rcutorture.test_no_idle_hz=3D1 rcutort=
ure.verbose=3D1"
> >
> > console.log report following WARN:
> > [    0.000000][    T0] static_key_enable_cpuslocked(): static key '0xc0=
00000002953260' used before call to jump_label_init()^M
> > [    0.000000][    T0] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:16=
6 static_key_enable_cpuslocked+0xfc/0x120^M
> > [    0.000000][    T0] Modules linked in:^M
> > [    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-r=
c5-next-20220708-dirty #131^M
> > [    0.000000][    T0] NIP:  c00000000038068c LR: c000000000380688 CTR:=
 c000000000186ac0^M
> > [    0.000000][    T0] REGS: c000000002867930 TRAP: 0700   Not tainted =
 (5.19.0-rc5-next-20220708-dirty)^M
> > [    0.000000][    T0] MSR:  8000000000022003 <SF,FP,RI,LE>  CR: 242822=
24  XER: 20040000^M
> > [    0.000000][    T0] CFAR: 0000000000000730 IRQMASK: 1 ^M
> > [    0.000000][    T0] GPR00: c000000000380688 c000000002867bd0 c000000=
002868d00 0000000000000065 ^M
> > [    0.000000][    T0] GPR04: 0000000000000001 0000000000000000 0000000=
000000080 000000000000000d ^M
> > [    0.000000][    T0] GPR08: 0000000000000000 0000000000000000 c000000=
0027fd000 000000000000000f ^M
> > [    0.000000][    T0] GPR12: c000000000186ac0 c000000002082280 0000000=
000000003 000000000000000d ^M
> > [    0.000000][    T0] GPR16: 0000000002cc00d0 0000000000000000 c000000=
002082280 0000000000000001 ^M
> > [    0.000000][    T0] GPR20: c000000002080942 0000000000000000 0000000=
000000000 0000000000000000 ^M
> > [    0.000000][    T0] GPR24: 0000000000000000 c0000000010d6168 0000000=
000000000 c0000000020034c8 ^M
> > [    0.000000][    T0] GPR28: 0000002800000000 0000000000000000 c000000=
002080942 c000000002953260 ^M
> > [    0.000000][    T0] NIP [c00000000038068c] static_key_enable_cpusloc=
ked+0xfc/0x120^M
> > [    0.000000][    T0] LR [c000000000380688] static_key_enable_cpuslock=
ed+0xf8/0x120^M
> > [    0.000000][    T0] Call Trace:^M
> > [    0.000000][    T0] [c000000002867bd0] [c000000000380688] static_key=
_enable_cpuslocked+0xf8/0x120 (unreliable)^M
> > [    0.000000][    T0] [c000000002867c40] [c000000000380810] static_key=
_enable+0x30/0x50^M
> > [    0.000000][    T0] [c000000002867c70] [c000000002030314] setup_forc=
ed_irqthreads+0x28/0x40^M
> > [    0.000000][    T0] [c000000002867c90] [c000000002003568] do_early_p=
aram+0xa0/0x108^M
> > [    0.000000][    T0] [c000000002867d10] [c000000000175340] parse_args=
+0x290/0x4e0^M
> > [    0.000000][    T0] [c000000002867e10] [c000000002003c74] parse_earl=
y_options+0x48/0x5c^M
> > [    0.000000][    T0] [c000000002867e30] [c000000002003ce0] parse_earl=
y_param+0x58/0x84^M
> > [    0.000000][    T0] [c000000002867e60] [c000000002009878] early_init=
_devtree+0xd4/0x518^M
> > [    0.000000][    T0] [c000000002867f10] [c00000000200aee0] early_setu=
p+0xb4/0x214^M
> >
> > After this fix, the WARN does not show again.
>
> Hi Zhouyi,
Thank Michael for your guidance.
>
> We have hit something like this previously, see the stack trace in
> commit e7eb919057c3 ("powerpc/64s: Handle program checks in wrong endian
> during early boot").
I am learning the fantastic work by you (git log -p e7eb919057c3),
e7eb919057c3 provides
a trampoline to detect and correct the wrong endian when handling the
exception caused by the WARN
(static key used before call to jump_label_init)
>
> That was fixed incidentally/accidentally by the page_poison code
> changing to not use static keys so early.
>
> There was a similar case recently in the random code too, see
> 60e5b2886b92 ("random: do not use jump labels before they are
> initialized").
I am also studying 60e5b2886b92, this commit delays the use of the
static key after jump_label_init is called.
>
> But I guess this will keep happening, as generic code authors expect to
> be able to use static keys in early_param() handlers.
>
> I think the ideal solution would be to move most early param parsing
> later. There's only a few parameters that need to be parsed that early
> in early_init_devtree(). That would be a complex and error-prone change
> though, so I won't ask you to do that :)
Yes, as a beginner, I like to study technologies, but I am not able to
do such a complex job ;-)
>
> But I think it would be better if you moved the call to
> jump_label_init() into early_init_devtree(), just before we call
> parse_early_param(), with a comment saying that it's required to call it
> before parsing early params.
OK, I will do that.
>
> And ...
>
> > diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup=
_64.c
> > index 2b2d0b0fbb30..bf2fb76221da 100644
> > --- a/arch/powerpc/kernel/setup_64.c
> > +++ b/arch/powerpc/kernel/setup_64.c
> > @@ -365,6 +365,9 @@ void __init early_setup(unsigned long dt_ptr)
> >
> >       udbg_printf(" -> %s(), dt_ptr: 0x%lx\n", __func__, dt_ptr);
> >
> > +     /* Initialise jump label because subsequent calls need it */
> > +     jump_label_init();
> > +
> >       /*
> >        * Do early initialization using the flattened device
> >        * tree, such as retrieving the physical memory map or
> > @@ -394,8 +397,15 @@ void __init early_setup(unsigned long dt_ptr)
> >
> >       /* Apply all the dynamic patching */
> >       apply_feature_fixups();
> > -     setup_feature_keys();
>
> I think you can just leave this as-is, it's fine to call
> jump_label_init() more than once.
Thanks again for your guidance ;-)
I will try to make a second version of the PATCH tomorrow.
Anyhow, this is a valuable learning process for me ;-)

Many Thank
Best Regards
Zhouyi
>
> > +
> > +     /*
> > +      * All the cpu/mmu_has_feature() checks take on their correct pol=
arity
> > +      * based on the current set of CPU/MMU features. These should be =
done
> > +      * only after early_init_devtree.
> > +      */
> > +     cpu_feature_keys_init();
> > +     mmu_feature_keys_init();
> > +
> >
> >       /* Initialize the hash table or TLB handling */
> >       early_init_mmu();
> > --
> > 2.25.1
>
> cheers
