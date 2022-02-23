Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB684C0D25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbiBWHSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiBWHSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:18:32 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81936EB1F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:18:04 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id p7so6707168qvk.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N4B4mDV8JjOEepG6T/J1kqCdNA6meuh9hg3A+Zp29gE=;
        b=RdNA7DnyXJ0Kj2AabN0MN0vv3aq2M+MRO9h0RW5u2gTg9981Wf0Hca/JInQujvMgno
         EImY6M1EXq8OPeEyCmJUidLPPOOR0zBXqx3S25Tj5AXT6ASVsVQQD8UYd41UU/28JyBK
         mmzKrPRDc/QNxLqbkDJY6LQqPEv1O7FVm7zohDe0CLlg8azXbgq5LGJjDxgTORrxCdeS
         VFc8W7lAQzd3289YqTD2RO9Q1V2D7kPcsYls3xQggSCIMOATg0aUQsg9V4sJo/gaaggi
         bRm4EmAXyR5uS7vi1Orb3gGkqNxJXaJCkUI7M+4RPgbW3ivOG8hyJyJUquxu2sdTyG5V
         6GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N4B4mDV8JjOEepG6T/J1kqCdNA6meuh9hg3A+Zp29gE=;
        b=U+v+Bm//ratSvcUBYqYz4VaNhBFnEx7ZQ5llemj7J5w9+WUKijUnFtWLmP8groi5r6
         ULxgSJ+zs2j+yf6+SEyIBsdlHu0bK1TLKPy+9h5iOgMwtbUS+EMe9m4RNcPe4CeCHu8W
         gqy+HVAcdx0Gmw2HLLuBawosF6FmiM096nLuLa9t3C3kMIGcm5E3vY/lg1O+JY7zwSi4
         xezs3c1nmjLAExM/DHnGN0aPMExBkUtQy6h7EM40USOWZLlY1EhRRBz135RG5tompwim
         3BGQdBfir+pKMUx9rlKJuxOvCK2wgYKk5oS6//jUe97XlUOxwQrdhZVLOmkpNM0sU3cm
         H+5w==
X-Gm-Message-State: AOAM5317bk2KXPer4EUHuMq8aJjZjtBDfBuumiogVwwv+P/O240r85Qz
        y5W0RdXhwRuZT39yso4S2g4=
X-Google-Smtp-Source: ABdhPJzVtkkin3VXw+8xInWXnKF2npxYawCcZotHdHJ/NCI86+mLuRdcPM7TFAzf+eeQsR2QpBU5sw==
X-Received: by 2002:ad4:5948:0:b0:42d:7abd:7f9c with SMTP id eo8-20020ad45948000000b0042d7abd7f9cmr21986732qvb.80.1645600683799;
        Tue, 22 Feb 2022 23:18:03 -0800 (PST)
Received: from mail.google.com ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id x134sm1246948qkb.92.2022.02.22.23.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:18:03 -0800 (PST)
Date:   Wed, 23 Feb 2022 15:18:01 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     changbin.du@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: patch: remove lockdep assertion on lock text_mutex
Message-ID: <20220223071801.2gyv23lyf6gumpau@mail.google.com>
References: <20210417023532.354714-1-changbin.du@gmail.com>
 <mhng-6a0fd653-64f8-4d0d-a265-d80cecdc1b84@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-6a0fd653-64f8-4d0d-a265-d80cecdc1b84@palmerdabbelt-glaptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 11:20:20PM -0700, Palmer Dabbelt wrote:
> On Fri, 16 Apr 2021 19:35:32 PDT (-0700), changbin.du@gmail.com wrote:
> > The function patch_insn_write() expects that the text_mutex is already
> > held. There's a case that text_mutex is acquired by ftrace_run_update_code()
> > under syscall context but then patch_insn_write() will be executed under the
> > migration kthread context as we involves stop machine. So we should remove
> > the assertion, or it can cause warning storm in kernel message.
> > 
> > [  104.641978] ------------[ cut here ]------------
> > [  104.642327] WARNING: CPU: 0 PID: 13 at arch/riscv/kernel/patch.c:63 patch_insn_write+0x166/0x17c
> > [  104.643587] Modules linked in:
> > [  104.644691] CPU: 0 PID: 13 Comm: migration/0 Not tainted 5.12.0-rc7-00067-g9cdbf6467424 #102
> > [  104.644907] Hardware name: riscv-virtio,qemu (DT)
> > [  104.645068] Stopper: multi_cpu_stop+0x0/0x17e <- 0x0
> > [  104.645349] epc : patch_insn_write+0x166/0x17c
> > [  104.645467]  ra : patch_insn_write+0x162/0x17c
> > [  104.645534] epc : ffffffe0000059c6 ra : ffffffe0000059c2 sp : ffffffe002a33c70
> > [  104.645580]  gp : ffffffe0019e5518 tp : ffffffe002a232c0 t0 : ffffffe01295e8a8
> > [  104.645622]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffffe002a33cc0
> > [  104.645675]  s1 : ffffffe000007f72 a0 : 0000000000000000 a1 : ffffffffffffffff
> > [  104.645716]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : 0000000000000001
> > [  104.645757]  a5 : ffffffe0799e45c8 a6 : 00000000000ca097 a7 : 0000000000000000
> > [  104.645798]  s2 : 0000000000000008 s3 : 0000000000000f72 s4 : ffffffe002a33ce0
> > [  104.645839]  s5 : 0000000000000f7a s6 : 0000000000000003 s7 : 0000000000000003
> > [  104.645880]  s8 : 0000000000000004 s9 : 0000000000000002 s10: 0000000000000000
> > [  104.645920]  s11: 0000000000000002 t3 : 0000000000000001 t4 : ffffffe000c615c8
> > [  104.645958]  t5 : 0000000000007fff t6 : 0000000000000380
> > [  104.645998] status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
> > [  104.646081] Call Trace:
> > [  104.646147] [<ffffffe0000059c6>] patch_insn_write+0x166/0x17c
> > [  104.646280] [<ffffffe0000059ec>] patch_text_nosync+0x10/0x32
> > [  104.646317] [<ffffffe000007d0c>] ftrace_update_ftrace_func+0x74/0xac
> > [  104.646352] [<ffffffe0000d338a>] ftrace_modify_all_code+0x9c/0x144
> > [  104.646387] [<ffffffe0000d3444>] __ftrace_modify_code+0x12/0x1c
> > [  104.646420] [<ffffffe0000c4c2c>] multi_cpu_stop+0xa8/0x17e
> > [  104.646451] [<ffffffe0000c4474>] cpu_stopper_thread+0xb2/0x156
> > [  104.646489] [<ffffffe00003645e>] smpboot_thread_fn+0x102/0x1ea
> > [  104.646524] [<ffffffe0000311b0>] kthread+0x132/0x148
> > [  104.646556] [<ffffffe000002e02>] ret_from_exception+0x0/0x14
> > [  104.646657] ---[ end trace ccf71babb9de4d5b ]---
> > [  104.647444] ------------[ cut here ]------------
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  arch/riscv/kernel/patch.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 0b552873a577..6d2ed9c15065 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -49,19 +49,18 @@ static void patch_unmap(int fixmap)
> >  }
> >  NOKPROBE_SYMBOL(patch_unmap);
> > 
> > +
> > +/*
> > + * Before reaching here, it was expected to lock the text_mutex
> > + * already, so we don't need to give another lock here and could
> > + * ensure that it was safe between each cores.
> > + */
> >  static int patch_insn_write(void *addr, const void *insn, size_t len)
> >  {
> >  	void *waddr = addr;
> >  	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> >  	int ret;
> > 
> > -	/*
> > -	 * Before reaching here, it was expected to lock the text_mutex
> > -	 * already, so we don't need to give another lock here and could
> > -	 * ensure that it was safe between each cores.
> > -	 */
> > -	lockdep_assert_held(&text_mutex);
> > -
> >  	if (across_pages)
> >  		patch_map(addr + len, FIX_TEXT_POKE1);
> 
> Well, we definately need the lock -- otherwise concurrent callers will
> install conflicting maps for FIX_TEXT_POKE*, step on each other, and install
> the wrong patch.  I just sent out a patch to use an explicit lock here, as
> sharing text_mutex doesn't seem safe.

Just a note that this issue still exist on mainline. 
-- 
Cheers,
Changbin Du
