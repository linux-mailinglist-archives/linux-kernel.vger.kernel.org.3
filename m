Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21165521CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbiEJOwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345434AbiEJOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:51:21 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35D20267091;
        Tue, 10 May 2022 07:12:17 -0700 (PDT)
Received: from pwmachine.localnet (154.pool92-186-13.dynamic.orange.es [92.186.13.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 98D7C20DED47;
        Tue, 10 May 2022 07:12:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98D7C20DED47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1652191929;
        bh=SMXRjgASxoY9GANcr+RrOLPmCsV3l+6OdEbY8o5d4Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/umbaWjpofQ6mQCCPA8N0L2yqe2CopqIn/eA+AtE38GGYUb5NNJGPC3It4bPFOHP
         ri2QItOL4uMuhiPwcHtz2dNHE2g2+C7ePm/PvHMlOnhTB8vOQBUBTG0fFHKSXx6V5g
         ZUA1qzPjqM1HMWfqk3fUJVY03fO965VV9fWaSUmQ=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-trace-devel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Kiss <daniel.kiss@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] arm64: Forget syscall if different from execve*()
Date:   Tue, 10 May 2022 15:12:02 +0100
Message-ID: <8061631.T7Z3S40VBb@pwmachine>
Organization: Microsoft
In-Reply-To: <20220510140333.GA28104@willie-the-truck>
References: <20220509151958.441240-1-flaniel@linux.microsoft.com> <2826417.e9J7NaK4W3@pwmachine> <20220510140333.GA28104@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 10 mai 2022, 15:03:33 BST Will Deacon a =E9crit :
> On Tue, May 10, 2022 at 03:00:11PM +0100, Francis Laniel wrote:
> > Le mardi 10 mai 2022, 11:59:48 BST Will Deacon a =E9crit :
> > > On Mon, May 09, 2022 at 04:19:57PM +0100, Francis Laniel wrote:
> > > > diff --git a/arch/arm64/include/asm/processor.h
> > > > b/arch/arm64/include/asm/processor.h index 73e38d9a540c..e12ceb363d=
6a
> > > > 100644
> > > > --- a/arch/arm64/include/asm/processor.h
> > > > +++ b/arch/arm64/include/asm/processor.h
> > > > @@ -34,6 +34,8 @@
> > > >=20
> > > >  #include <vdso/processor.h>
> > > >=20
> > > > +#include <asm-generic/unistd.h>
> > > > +
> > > >=20
> > > >  #include <asm/alternative.h>
> > > >  #include <asm/cpufeature.h>
> > > >  #include <asm/hw_breakpoint.h>
> > > >=20
> > > > @@ -250,8 +252,12 @@ void tls_preserve_current_state(void);
> > > >=20
> > > >  static inline void start_thread_common(struct pt_regs *regs, unsig=
ned
> > > >  long pc) {
> > > >=20
> > > > +	s32 previous_syscall =3D regs->syscallno;
> > > >=20
> > > >  	memset(regs, 0, sizeof(*regs));
> > > >=20
> > > > -	forget_syscall(regs);
> > > > +	if (previous_syscall =3D=3D __NR_execve || previous_syscall =3D=3D
> > > > __NR_execveat)
> > > > +		regs->syscallno =3D previous_syscall;
> > > > +	else
> > > > +		forget_syscall(regs);
> > >=20
> > > Hmm, this really looks like a bodge and it doesn't handle the compat
> > > case
> > > either.
> > >=20
> > > How do other architectures handle this?
> >=20
> > My understanding of others architectures is quite limited, but here are=
 my
> > findings and understanding of some of them:
> > * arm (32 bits) EABI: start_thread() sets r7 to previous r7 for ELF FDP=
IC=20
> > and to 0 for other binfmts [1].
> > * arm (32 bits) OABI: syscall number is set to -1 if
> > ptrace_report_syscall_entry() failed [2].
> > * mips: start_thread() does not modify current_thread_info->syscall whi=
ch
> > is taken directly from v0 [3, 4].
> > * riscv: start_thread() does not modify a7 [5].
> > * x86_64: start_thread_common() does not touch orig_ax which seems to
> > contain the syscall number [6].
>=20
> Hmm, so the million dollar question is why on Earth we have that
> forget_syscall() call to start with. Amusingly I've, err, forgotten;
> forget_forget_syscall() perhaps?

I think this is maybe tied to this comment [1]:
The de-facto standard way to skip a system call using ptrace=20
is to set the system call to -1 (NO_SYSCALL)

But I will let the original author explain as his/her explaination will be=
=20
better than mine.

> Catalin? It's been there since day one afaict.
>=20
> Will

=2D--
[1] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/arm64/kernel/
syscall.c#L121


