Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A34521CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbiEJOqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346228AbiEJOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:42:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B95652FF705;
        Tue, 10 May 2022 07:00:17 -0700 (PDT)
Received: from pwmachine.localnet (154.pool92-186-13.dynamic.orange.es [92.186.13.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id A601220EC9A5;
        Tue, 10 May 2022 07:00:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A601220EC9A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1652191217;
        bh=7OCMzdl5ESPExXL11Am5FVLKgSI7cID21CgOvybjxvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dw697TJfld1wJuEyRncPW0WOPvcm4zY57brhwUmjrGHkewRFrfiMqsBGnZ/prTdqi
         pbM5BdXqFufVjQTmQML1+tOBEi7nspAMBWTBvKPPOU6a1HlyhgxFlOytRxcOyFFymZ
         qsMx9NCPwYHGJ9ObWDm9rY8x7tS7LovUiggj1nwY=
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
Date:   Tue, 10 May 2022 15:00:11 +0100
Message-ID: <2826417.e9J7NaK4W3@pwmachine>
Organization: Microsoft
In-Reply-To: <20220510105948.GB27557@willie-the-truck>
References: <20220509151958.441240-1-flaniel@linux.microsoft.com> <20220509151958.441240-2-flaniel@linux.microsoft.com> <20220510105948.GB27557@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Le mardi 10 mai 2022, 11:59:48 BST Will Deacon a =E9crit :
> On Mon, May 09, 2022 at 04:19:57PM +0100, Francis Laniel wrote:
> > This patch enables exeve*() to be traced by syscalls:sys_exit_execve
> > tracepoint.
> > Previously, calling forget_syscall() would set syscall to -1, which
> > impedes
> > this tracepoint to prints its information.
> > So, this patch makes call to forget_syscall() conditional by only calli=
ng
> > it when syscall number is not execve() or execveat().
> >=20
> > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > ---
> >=20
> >  arch/arm64/include/asm/processor.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm64/include/asm/processor.h
> > b/arch/arm64/include/asm/processor.h index 73e38d9a540c..e12ceb363d6a
> > 100644
> > --- a/arch/arm64/include/asm/processor.h
> > +++ b/arch/arm64/include/asm/processor.h
> > @@ -34,6 +34,8 @@
> >=20
> >  #include <vdso/processor.h>
> >=20
> > +#include <asm-generic/unistd.h>
> > +
> >=20
> >  #include <asm/alternative.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/hw_breakpoint.h>
> >=20
> > @@ -250,8 +252,12 @@ void tls_preserve_current_state(void);
> >=20
> >  static inline void start_thread_common(struct pt_regs *regs, unsigned
> >  long pc) {
> >=20
> > +	s32 previous_syscall =3D regs->syscallno;
> >=20
> >  	memset(regs, 0, sizeof(*regs));
> >=20
> > -	forget_syscall(regs);
> > +	if (previous_syscall =3D=3D __NR_execve || previous_syscall =3D=3D
> > __NR_execveat)
> > +		regs->syscallno =3D previous_syscall;
> > +	else
> > +		forget_syscall(regs);
>=20
> Hmm, this really looks like a bodge and it doesn't handle the compat case
> either.
>=20
> How do other architectures handle this?

My understanding of others architectures is quite limited, but here are my=
=20
findings and understanding of some of them:
* arm (32 bits) EABI: start_thread() sets r7 to previous r7 for ELF FDPIC  =
and=20
to 0 for other binfmts [1].
* arm (32 bits) OABI: syscall number is set to -1 if=20
ptrace_report_syscall_entry() failed [2].
* mips: start_thread() does not modify current_thread_info->syscall which i=
s=20
taken directly from v0 [3, 4].
* riscv: start_thread() does not modify a7 [5].
* x86_64: start_thread_common() does not touch orig_ax which seems to conta=
in=20
the syscall number [6].

> Will

Best regards.
=2D--
[1] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/arm/include/asm/
processor.h#L52
[2] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/arm/kernel/
ptrace.c#L847
[3] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/mips/kernel/
process.c#L52
[4] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/mips/kernel/
scall64-n64.S#L85
[5] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/riscv/kernel/
process.c#L87
[6] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/x86/kernel/
process_64.c#L505


