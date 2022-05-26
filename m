Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5CE534E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344334AbiEZLcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiEZLca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84E02689B7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653564746;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8y279O13sFCKDM6vsE4RCO7ZGvdXhMVo/XWynS55+1M=;
        b=XC+WBrA9N+oQyGMGzpMiTbG+gGtrYV8yzofaYLUAf3Mwgcg1giaCpkcFYDGsWyIPiVYpnx
        EVPRhzTem87F1EgQOtd4xVvCaCD2zijrPbA52c8M39f5UPbCzcjLxR0OY85Bd23bLzU5tf
        EQkn6e0PYcGqaHX0HNsf3yaF7QEpSkA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-3CFp11K5M2yKQaLeI9E1Lw-1; Thu, 26 May 2022 07:32:25 -0400
X-MC-Unique: 3CFp11K5M2yKQaLeI9E1Lw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B58429AB3FE;
        Thu, 26 May 2022 11:32:25 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.192.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB2A91121315;
        Thu, 26 May 2022 11:32:24 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 24QBWLME096219
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 13:32:21 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 24QBWKmx096218;
        Thu, 26 May 2022 13:32:20 +0200
Date:   Thu, 26 May 2022 13:32:19 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, Jan Hubicka <jh@suse.cz>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: objtool warning, branch, patch, and .config (GCC bug)
Message-ID: <Yo9lQxpj9U+fQTKH@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20220525173332.GA4008581@paulmck-ThinkPad-P17-Gen-1>
 <20220525173444.GA4010526@paulmck-ThinkPad-P17-Gen-1>
 <20220526080313.GM2578@worktop.programming.kicks-ass.net>
 <20220526080849.GF6479@worktop.programming.kicks-ass.net>
 <Yo9CCoEF7nOd6lQI@tucnak>
 <20220526094124.GN2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220526094124.GN2578@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 11:41:24AM +0200, Peter Zijlstra wrote:
> On Thu, May 26, 2022 at 11:02:02AM +0200, Jakub Jelinek wrote:
> > On Thu, May 26, 2022 at 10:08:49AM +0200, Peter Zijlstra wrote:
> > > On Thu, May 26, 2022 at 10:03:13AM +0200, Peter Zijlstra wrote:
> > >=20
> > > > Which is just bloody weird/broken if you ask me. What's worse, GCC-=
10
> > > > does the same. Only when I use GCC-11 do I get sensible code again:
> > >=20
> > > Just to clarify, I can reproduce using:
> > >=20
> > > gcc-9 (Debian 9.4.0-5) 9.4.0
> > > gcc-10 (Debian 10.3.0-15) 10.3.0
> > >=20
> > > The good compiler is:
> > >=20
> > > gcc-11 (Debian 11.3.0-1) 11.3.0
> >=20
> > Such fallthrough into another function is typically the result
> > of __builtin_unreachable (), either explicit somewhere in the code,
> > or invoking undefined behavior somewhere and __builtin_unreachable ()
> > replacing the UB code.
> > I'd need preprocessed source + full gcc command line to tell more
> > (as long as it is not LTO, with LTO that isn't enough of course).
>=20
>  $ make O=3Dbuild/ CC=3Dgcc-9 kernel/rcu/update.o V=3D1
>=20
> gives the compile command as:
>=20
>   gcc-9 -Wp,-MMD,kernel/rcu/.update.o.d -nostdinc -I../arch/x86/include -=
I./arch/x86/include/generated -I../include -I./include -I../arch/x86/includ=
e/uapi -I./arch/x86/include/generated/uapi -I../include/uapi -I./include/ge=
nerated/uapi -include ../include/linux/compiler-version.h -include ../inclu=
de/linux/kconfig.h -include ../include/linux/compiler_types.h -D__KERNEL__ =
-fmacro-prefix-map=3D../=3D -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-=
trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=
=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-ty=
pe -Wno-format-security -std=3Dgnu11 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow=
 -mno-avx -fcf-protection=3Dnone -m64 -falign-jumps=3D1 -falign-loops=3D1 -=
mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3D3 -mskip-rax-setu=
p -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -Wno-sign-compare -fno-a=
synchronous-unwind-tables -mindirect-branch=3Dthunk-extern -mindirect-branc=
h-register -fno-jump-tables -fno-delete-null-pointer-checks -Wno-frame-addr=
ess -Wno-format-truncation -Wno-format-overflow -Wno-address-of-packed-memb=
er -O2 --param=3Dallow-store-data-races=3D0 -Wframe-larger-than=3D2048 -fst=
ack-protector-strong -Werror -Wimplicit-fallthrough=3D5 -Wno-main -Wno-unus=
ed-but-set-variable -Wno-unused-const-variable -fomit-frame-pointer -fno-st=
ack-clash-protection -Wdeclaration-after-statement -Wvla -Wno-pointer-sign =
-Wcast-function-type -Wno-stringop-truncation -Wno-stringop-overflow -Wno-r=
estrict -Wno-maybe-uninitialized -Wno-alloc-size-larger-than -fno-strict-ov=
erflow -fno-stack-check -fconserve-stack -Werror=3Ddate-time -Werror=3Dinco=
mpatible-pointer-types -Werror=3Ddesignated-init -Wno-packed-not-aligned -I=
 ../kernel/rcu -I ./kernel/rcu    -DKBUILD_MODFILE=3D'"kernel/rcu/update"' =
-DKBUILD_BASENAME=3D'"update"' -DKBUILD_MODNAME=3D'"update"' -D__KBUILD_MOD=
NAME=3Dkmod_update -c -o kernel/rcu/update.o ../kernel/rcu/update.c
>=20
> I've attached the output of:
>=20
>  $ make O=3Dbuild/ CC=3Dgcc-9 kernel/rcu/update.i

Filed https://gcc.gnu.org/PR105739 for this, the replacement
happens during inlining, so I've CCed Honza Hubicka who knows
that code best.

It is unlikely anything can be done about this for GCC 9,
because the final GCC 9.5 release is to be released tomorrow,
there is no chance of getting it fixed by then, especially
when it doesn't look like a recent regression.

	Jakub

