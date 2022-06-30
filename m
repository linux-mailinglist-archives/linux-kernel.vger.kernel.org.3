Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6581D56210B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiF3RQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiF3RQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:16:51 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BEE33E5CB;
        Thu, 30 Jun 2022 10:16:49 -0700 (PDT)
Received: from pwmachine.localnet (lfbn-lyo-1-1062-211.w86-248.abo.wanadoo.fr [86.248.131.211])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2DC9820CD162;
        Thu, 30 Jun 2022 10:16:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DC9820CD162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1656609409;
        bh=SGD2plOXYG2nU4Of126mBupBbHA9hW8xg+IkPu4iDNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQbqXMoUrJxHzROhBQ3e0SJezOdTvWLczgzgy2+lK/lGe5/pJ6Y2A5KoLCbB3m0jD
         1/N/By54UqMsk6HuD3ClVbUpctFpbDBksdZAr3VSC0H5jQM1bJlOZwjblrRgnxuSQK
         c/zxz6wjAU3lhtoHlQqeb5JBAIrIbOQUMwRagtJU=
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
Date:   Thu, 30 Jun 2022 19:16:44 +0200
Message-ID: <4722000.GXAFRqVoOG@pwmachine>
Organization: Microsoft
In-Reply-To: <3439466.iIbC2pHGDl@pwmachine>
References: <20220608162447.666494-1-flaniel@linux.microsoft.com> <20220628135834.GA24116@willie-the-truck> <3439466.iIbC2pHGDl@pwmachine>
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

Le mardi 28 juin 2022, 21:26:32 CEST Francis Laniel a =E9crit :
> Hi.
>=20
> Le mardi 28 juin 2022, 15:58:35 CEST Will Deacon a =E9crit :
> > On Wed, Jun 08, 2022 at 05:24:46PM +0100, Francis Laniel wrote:
> > > This patch enables exeve*() to be traced with syscalls:sys_exit_execve
> > > tracepoint.
> > > Previous to it, by calling forget_syscall(), this tracepoint would not
> > > print its information as syscall is -1.
> > > So, this patch removes call to forget_syscall() and set regs->syscall=
no
> > > to its previous value.
> > >=20
> > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > ---
> > >=20
> > >  arch/arm64/include/asm/processor.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm64/include/asm/processor.h
> > > b/arch/arm64/include/asm/processor.h index 9e58749db21d..86eb0bfe3b38
> > > 100644
> > > --- a/arch/arm64/include/asm/processor.h
> > > +++ b/arch/arm64/include/asm/processor.h
> > > @@ -272,8 +272,9 @@ void tls_preserve_current_state(void);
> > >=20
> > >  static inline void start_thread_common(struct pt_regs *regs, unsigned
> > >  long pc) {
> > >=20
> > > +	s32 previous_syscall =3D regs->syscallno;
> > >=20
> > >  	memset(regs, 0, sizeof(*regs));
> > >=20
> > > -	forget_syscall(regs);
> > > +	regs->syscallno =3D previous_syscall;
> >=20
> > I'm still unsure about this. Even if we preserve the syscall number her=
e,
> > won't all the arguments be reported as 0?
>=20
> I am not really sure what you meant about arguments, can you please preci=
se
> between command line arguments (ls -al) and syscall arguments (argp, envp,
> etc.)?
> Indeed, if my understanding is correct syscall arguments are showed by
> sys_enter_* while sys_exit_* only reports the syscall return code.
>=20
> Regarding the return code I think the value is correct as it is used in
> syscall_trace_exit() but set in invoke_syscall() after the syscall finish=
es
> [1, 2].
> The comparison of arm64 and amd64 output also shows no difference:
> # amd64
> ls 435739 [002] 24689.292479:  syscalls:sys_exit_execve: 0x0
>             7fc43732e100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
> # arm64
> ls   266 [000]    34.708444:  syscalls:sys_exit_execve: 0x0
>                     1140 [unknown] (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
>=20
> > I also looked quickly at the 32-bit arch/arm/ code and it looks like the
> > same behaviour exists there (module CONFIG_BINFMT_ELF_FDPIC).
>=20

I tested arm32 and it is not affected (even though I did not have=20
CONFIG_BINFMT_ELF_FDPIC set).
Here is ftrace output for arm64 without this patch:
            bash-316     [000] .....    72.167342: sys_execve(filename:=20
aaaaf9bbcd30, argv: aaaaf9bb54f0, envp: aaaaf9a7d9b0)
Here is the output for arm64 with this patch:
             cat-313     [000] .....   417.926073: sys_execve(filename:=20
aaaaee7ce9f0, argv: aaaaee7833a0, envp: aaaaee6a69b0)
             cat-313     [000] .....   417.939619: sys_execve -> 0x0
And here is output for arm32:
             cat-254     [000] .....   127.804128: sys_execve(filename: 5bf=
f18,=20
argv: 53bb00, envp: 5543a8)
             cat-254     [000] .....   127.809142: sys_execve -> 0x0
=46rom the above, the arm32 output seems correct even though:
# CONFIG_BINFMT_ELF_FDPIC is not set

After some debugging, I realized that arm32 syscall_get_nr() uses abi_sysca=
ll=20
to get the syscall number and not a register (I guess abi_syscall was set t=
o=20
value of R7 before) [1].
So the fact that regs->uregs are memset'ed to 0 is not a problem.

>=20
> Best regards.
> ---
> [1] https://elixir.bootlin.com/linux/v5.18/source/arch/arm64/kernel/
> ptrace.c#L1868
> [2] https://elixir.bootlin.com/linux/v5.18/source/arch/arm64/kernel/
> syscall.c#L57


Best regards.
=2D--
[1] https://elixir.bootlin.com/linux/v5.18.8/source/arch/arm/include/asm/
syscall.h#L22


