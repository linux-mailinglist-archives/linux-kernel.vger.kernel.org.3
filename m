Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355EA55EDD6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiF1Tal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiF1TaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:30:05 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9B8A2CC8F;
        Tue, 28 Jun 2022 12:26:37 -0700 (PDT)
Received: from pwmachine.localnet (lfbn-lyo-1-1062-211.w86-248.abo.wanadoo.fr [86.248.131.211])
        by linux.microsoft.com (Postfix) with ESMTPSA id 28D8620CDF22;
        Tue, 28 Jun 2022 12:26:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28D8620CDF22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1656444397;
        bh=yr6ynDdw6pyVh9Iwg4x+jvCjxckbKOv/2p2g1OJXeOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mduRND+hdKqkoVwX7rwN2WOfSSmhv5moEqFiXNXdSoyWo8lF1IcJzK1POPG9dc71u
         hcOxNdCTFYo+kw2fDyx1WE3cXbj585ZTHmUK0vNTkkbW4ypZwnGgBHwP3coyHuMO0y
         mxSyI6BDmOlJM5RsyUO0sm4gNpKKdVXnW3+CPANQ=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-trace-devel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: Do not forget syscall when starting a new thread.
Date:   Tue, 28 Jun 2022 21:26:32 +0200
Message-ID: <3439466.iIbC2pHGDl@pwmachine>
Organization: Microsoft
In-Reply-To: <20220628135834.GA24116@willie-the-truck>
References: <20220608162447.666494-1-flaniel@linux.microsoft.com> <20220608162447.666494-2-flaniel@linux.microsoft.com> <20220628135834.GA24116@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Le mardi 28 juin 2022, 15:58:35 CEST Will Deacon a =E9crit :
> On Wed, Jun 08, 2022 at 05:24:46PM +0100, Francis Laniel wrote:
> > This patch enables exeve*() to be traced with syscalls:sys_exit_execve
> > tracepoint.
> > Previous to it, by calling forget_syscall(), this tracepoint would not
> > print its information as syscall is -1.
> > So, this patch removes call to forget_syscall() and set regs->syscallno
> > to its previous value.
> >=20
> > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > ---
> >=20
> >  arch/arm64/include/asm/processor.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm64/include/asm/processor.h
> > b/arch/arm64/include/asm/processor.h index 9e58749db21d..86eb0bfe3b38
> > 100644
> > --- a/arch/arm64/include/asm/processor.h
> > +++ b/arch/arm64/include/asm/processor.h
> > @@ -272,8 +272,9 @@ void tls_preserve_current_state(void);
> >=20
> >  static inline void start_thread_common(struct pt_regs *regs, unsigned
> >  long pc) {
> >=20
> > +	s32 previous_syscall =3D regs->syscallno;
> >=20
> >  	memset(regs, 0, sizeof(*regs));
> >=20
> > -	forget_syscall(regs);
> > +	regs->syscallno =3D previous_syscall;
>=20
> I'm still unsure about this. Even if we preserve the syscall number here,
> won't all the arguments be reported as 0?

I am not really sure what you meant about arguments, can you please precise=
=20
between command line arguments (ls -al) and syscall arguments (argp, envp,=
=20
etc.)?
Indeed, if my understanding is correct syscall arguments are showed by=20
sys_enter_* while sys_exit_* only reports the syscall return code.

Regarding the return code I think the value is correct as it is used in=20
syscall_trace_exit() but set in invoke_syscall() after the syscall finishes=
 [1,=20
2].
The comparison of arm64 and amd64 output also shows no difference:
# amd64
ls 435739 [002] 24689.292479:  syscalls:sys_exit_execve: 0x0
            7fc43732e100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
# arm64
ls   266 [000]    34.708444:  syscalls:sys_exit_execve: 0x0
                    1140 [unknown] (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
=20
> I also looked quickly at the 32-bit arch/arm/ code and it looks like the
> same behaviour exists there (module CONFIG_BINFMT_ELF_FDPIC).

I can try to fix it for this architecture too.
Can you please point me the part of the code which shows the same behavior?
=20
> Will


Best regards.
=2D--
[1] https://elixir.bootlin.com/linux/v5.18/source/arch/arm64/kernel/
ptrace.c#L1868
[2] https://elixir.bootlin.com/linux/v5.18/source/arch/arm64/kernel/
syscall.c#L57


