Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EDF59CE02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbiHWBnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiHWBnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:43:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D980E10;
        Mon, 22 Aug 2022 18:43:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u22so11502497plq.12;
        Mon, 22 Aug 2022 18:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=V9q0q2/QxbNvfOOowc3MnXFd5fHZg5Kih7cADAHli34=;
        b=o2SkIvPyybUVThnWFIF0mEQ1toFoDZdhab0XVz5z04Y23lonBlSKs2UtoeWoQ0hknp
         Y/S12YhtJMqioYvY/tiuVPbxwyaBTg5rJGEPljAYVCga+4edWfQM6vAgkwTaFQvSJ9oT
         6HBDZuhuj1C6CDKmxxa0LR/7pCJSnnUorZaasingb+kO87Dr7wXUIQfG+2Pxserq2pfK
         +vNqnSC3dxMjFhcRj+yUq3Xsulx9Vqp1XiVAz9t76DpyUAVHIG04XMi0yU4M92SDjHW0
         0kdVlJCV5hwJ7+8Wy4z3AI+6X7hntmtCzo99Cib/qq9gR3M9tCZjflhiHf3c0TdQKz5l
         YwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=V9q0q2/QxbNvfOOowc3MnXFd5fHZg5Kih7cADAHli34=;
        b=JqYJf5KzAsynQy9uUvhB3hNyHl8g4i/qGmBc4FJ1gdb10znImyecMt/JQyKo7XzEno
         VOLPtyUXE04BjXP4hqOprv50Gn5mfMs2Y9ETU7Q4c9HaLCb1OfREWYXr9rvKY8A/84iN
         Dw/ZGc01JmFPvbrgTr0Kg89aJvaovhFSCEelVsHdoutRvJ38bt8zA7lFmWn43ISuIVSY
         hq5Bq2JweB3oBYWAFaio3cUM/CzBZjr7O/3op282NKNIqX8KPJAvmJcPnnCU8t6lH+Z/
         Y3Rv2HNqZqyvUIvSzyroS0Ff49zcSMg2qgHJioGYNLgsT68XMX+3c7OBGPhSP/5XnXj8
         gx7w==
X-Gm-Message-State: ACgBeo1yuTDmd9J8bGVXSMpLi7S7NwIrD9jZgqNhLInr5/E+PeRljCQh
        tjFWrLHEgbNsFF9YO6w8VxwWYpQVu34ilvzgxHo=
X-Google-Smtp-Source: AA6agR5eM2rKQl1i2NCLvfv06QtijaO7dlv63CAbLScBggr7Q1lpBuqfcCF7lAfxWRtWlY2FCb1psMOwJKOHYDheJiA=
X-Received: by 2002:a17:902:744a:b0:172:fca9:6625 with SMTP id
 e10-20020a170902744a00b00172fca96625mr2403598plt.133.1661218995709; Mon, 22
 Aug 2022 18:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220821010030.97539-1-zhouzhouyi@gmail.com> <6375fd69-d57f-be90-6b17-f183e918dbc8@csgroup.eu>
In-Reply-To: <6375fd69-d57f-be90-6b17-f183e918dbc8@csgroup.eu>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 23 Aug 2022 09:43:04 +0800
Message-ID: <CAABZP2y8dGAWHZwbXpbQgc3iO+7hBMuexqvcYUK-GKaKnAHH5Q@mail.gmail.com>
Subject: Re: [PATCH linux-next] powerpc: disable sanitizer in irq_soft_mask_set
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "atrajeev@linux.vnet.ibm.com" <atrajeev@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lance@osuosl.org" <lance@osuosl.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 2:04 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 21/08/2022 =C3=A0 03:00, Zhouyi Zhou a =C3=A9crit :
> > In ppc, compiler based sanitizer will generate instrument instructions
> > around statement WRITE_ONCE(local_paca->irq_soft_mask, mask):
> >
> >     0xc000000000295cb0 <+0>:  addis   r2,r12,774
> >     0xc000000000295cb4 <+4>:  addi    r2,r2,16464
> >     0xc000000000295cb8 <+8>:  mflr    r0
> >     0xc000000000295cbc <+12>: bl      0xc00000000008bb4c <mcount>
> >     0xc000000000295cc0 <+16>: mflr    r0
> >     0xc000000000295cc4 <+20>: std     r31,-8(r1)
> >     0xc000000000295cc8 <+24>: addi    r3,r13,2354
> >     0xc000000000295ccc <+28>: mr      r31,r13
> >     0xc000000000295cd0 <+32>: std     r0,16(r1)
> >     0xc000000000295cd4 <+36>: stdu    r1,-48(r1)
> >     0xc000000000295cd8 <+40>: bl      0xc000000000609b98 <__asan_store1=
+8>
> >     0xc000000000295cdc <+44>: nop
> >     0xc000000000295ce0 <+48>: li      r9,1
> >     0xc000000000295ce4 <+52>: stb     r9,2354(r31)
> >     0xc000000000295ce8 <+56>: addi    r1,r1,48
> >     0xc000000000295cec <+60>: ld      r0,16(r1)
> >     0xc000000000295cf0 <+64>: ld      r31,-8(r1)
> >     0xc000000000295cf4 <+68>: mtlr    r0
> >
> > If there is a context switch before "stb     r9,2354(r31)", r31 may
> > not equal to r13, in such case, irq soft mask will not work.
> >
> > This patch disable sanitizer in irq_soft_mask_set.
>
> Well spotted, thanks.
Thank Christophe for reviewing my patch and your guidance!
>
> You should add:
>
> Fixes: ef5b570d3700 ("powerpc/irq: Don't open code irq_soft_mask helpers"=
)
OK, I will do it!
>
> By the way, I think the READ_ONCE() likely has the same issue so you
> should fix irq_soft_mask_return() at the same time.
Yes, after disassembling irq_soft_mask_return, she has the same issue
as irq_soft_mask_set.

In addition, I read hw_irq.h by naked eye to search for removed inline
assembly one by one,
I found another place that we could possible enhance (Thank Paul E.
McKenny for teaching me use git blame ;-)):
077fc62b2b66a("powerpc/irq: remove inline assembly in hard_irq_disable macr=
o")
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -282,9 +282,7 @@ static inline bool pmi_irq_pending(void)
        flags =3D irq_soft_mask_set_return(IRQS_ALL_DISABLED);            \
        local_paca->irq_happened |=3D PACA_IRQ_HARD_DIS;                  \
        if (!arch_irqs_disabled_flags(flags)) {                         \
-               asm ("stdx %%r1, 0, %1 ;"                               \
-                    : "=3Dm" (local_paca->saved_r1)                      \
-                    : "b" (&local_paca->saved_r1));                    \
+               WRITE_ONCE(local_paca->saved_r1, current_stack_pointer);\
                trace_hardirqs_off();                                   \
        }                                                               \
 } while(0)
I wrap the macro hard_irq_disable into a test function and disassemble
it, she has the above issue too:
(gdb) disassemble test002
Dump of assembler code for function test002:
   0xc000000000295db0 <+0>:    addis   r2,r12,774
   0xc000000000295db4 <+4>:    addi    r2,r2,16464
   0xc000000000295db8 <+8>:    mflr    r0
   0xc000000000295dbc <+12>:    bl      0xc00000000008bacc <mcount>
   0xc000000000295dc0 <+16>:    mflr    r0
   0xc000000000295dc4 <+20>:    std     r30,-16(r1)
   0xc000000000295dc8 <+24>:    std     r31,-8(r1)
   0xc000000000295dcc <+28>:    li      r9,2
   0xc000000000295dd0 <+32>:    std     r0,16(r1)
   0xc000000000295dd4 <+36>:    stdu    r1,-48(r1)
   0xc000000000295dd8 <+40>:    mtmsrd  r9,1
   0xc000000000295ddc <+44>:    addi    r3,r13,2354
   0xc000000000295de0 <+48>:    mr      r31,r13
   0xc000000000295de4 <+52>:    bl      0xc000000000609838 <__asan_load1+8>
   0xc000000000295de8 <+56>:    nop
   0xc000000000295dec <+60>:    li      r3,3
   0xc000000000295df0 <+64>:    lbz     r30,2354(r31)
   0xc000000000295df4 <+68>:    bl      0xc00000000028de90 <irq_soft_mask_s=
et>
   0xc000000000295df8 <+72>:    mr      r31,r13
   0xc000000000295dfc <+76>:    addi    r3,r13,2355
   0xc000000000295e00 <+80>:    bl      0xc000000000609838 <__asan_load1+8>
   0xc000000000295e04 <+84>:    nop
   0xc000000000295e08 <+88>:    lbz     r9,2355(r31)
   0xc000000000295e0c <+92>:    andi.   r10,r30,1
   0xc000000000295e10 <+96>:    ori     r9,r9,1
   0xc000000000295e14 <+100>:    stb     r9,2355(r31)
   0xc000000000295e18 <+104>:    bne     0xc000000000295e30 <test002+128>
   0xc000000000295e1c <+108>:    mr      r30,r1
   0xc000000000295e20 <+112>:    addi    r3,r31,2328
   0xc000000000295e24 <+116>:    bl      0xc000000000609dd8 <__asan_store8+=
8>
   0xc000000000295e28 <+120>:    nop
   0xc000000000295e2c <+124>:    std     r30,2328(r31)
   0xc000000000295e30 <+128>:    addi    r1,r1,48
   0xc000000000295e34 <+132>:    ld      r0,16(r1)
   0xc000000000295e38 <+136>:    ld      r30,-16(r1)
   0xc000000000295e3c <+140>:    ld      r31,-8(r1)
   0xc000000000295e40 <+144>:    mtlr    r0
   0xc000000000295e44 <+148>:    blr
Could we rewrite this macro into a static inline function as
irq_soft_mask_set does, and disable sanitizer for it?

Thanks again
Cheers
Zhouyi
>
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> > Dear PPC developers
> >
> > I found this bug when trying to do rcutorture tests in ppc VM of
> > Open Source Lab of Oregon State University following Paul E. McKenny's =
guidance.
> >
> > console.log report following bug:
> >
> > [  346.527467][  T100] BUG: using smp_processor_id() in preemptible [00=
000000] code: rcu_torture_rea/100^M
> > [  346.529416][  T100] caller is rcu_preempt_deferred_qs_irqrestore+0x7=
4/0xed0^M
> > [  346.531157][  T100] CPU: 4 PID: 100 Comm: rcu_torture_rea Tainted: G=
        W          5.19.0-rc5-next-20220708-dirty #253^M
> > [  346.533620][  T100] Call Trace:^M
> > [  346.534449][  T100] [c0000000094876c0] [c000000000ce2b68] dump_stack=
_lvl+0xbc/0x108 (unreliable)^M
> > [  346.536632][  T100] [c000000009487710] [c000000001712954] check_pree=
mption_disabled+0x154/0x160^M
> > [  346.538665][  T100] [c0000000094877a0] [c0000000002ce2d4] rcu_preemp=
t_deferred_qs_irqrestore+0x74/0xed0^M
> > [  346.540830][  T100] [c0000000094878b0] [c0000000002cf3c0] __rcu_read=
_unlock+0x290/0x3b0^M
> > [  346.542746][  T100] [c000000009487910] [c0000000002bb330] rcu_tortur=
e_read_unlock+0x30/0xb0^M
> > [  346.544779][  T100] [c000000009487930] [c0000000002b7ff8] rcutorture=
_one_extend+0x198/0x810^M
> > [  346.546851][  T100] [c000000009487a10] [c0000000002b8bfc] rcu_tortur=
e_one_read+0x58c/0xc90^M
> > [  346.548844][  T100] [c000000009487ca0] [c0000000002b942c] rcu_tortur=
e_reader+0x12c/0x360^M
> > [  346.550784][  T100] [c000000009487db0] [c0000000001de978] kthread+0x=
1e8/0x220^M
> > [  346.552555][  T100] [c000000009487e10] [c00000000000cd54] ret_from_k=
ernel_thread+0x5c/0x64^M
> >
> > After 12 days debugging, I finally narrow the problem to irq_soft_mask_=
set.
> >
> > I am a beginner, hope I can be of some beneficial to the community ;-)
> >
> > Thanks
> > Zhouyi
> > --
> >   arch/powerpc/include/asm/hw_irq.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/a=
sm/hw_irq.h
> > index 26ede09c521d..a5ae8d82cc9d 100644
> > --- a/arch/powerpc/include/asm/hw_irq.h
> > +++ b/arch/powerpc/include/asm/hw_irq.h
> > @@ -121,7 +121,7 @@ static inline notrace unsigned long irq_soft_mask_r=
eturn(void)
> >    * for the critical section and as a clobber because
> >    * we changed paca->irq_soft_mask
> >    */
> > -static inline notrace void irq_soft_mask_set(unsigned long mask)
> > +static inline notrace __no_kcsan __no_sanitize_address void irq_soft_m=
ask_set(unsigned long mask)
> >   {
> >       /*
> >        * The irq mask must always include the STD bit if any are set.
