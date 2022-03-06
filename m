Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB614CEE77
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 00:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiCFX2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 18:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCFX2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 18:28:33 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50E3F1C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 15:27:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBd6f13N4z4xsk;
        Mon,  7 Mar 2022 10:27:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1646609258;
        bh=ecFwYfD7mRQxoIkEczbbOaKJ1xong6ZLGztAcRw7l6g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Iltodzo+XuUBbPmqGgFaECqIb5PjFin+/o+OsX7hG5fep9Ro7yAS1hRJVLZPhBrui
         5I1hiydo1xnX/UMeha2bDyMVTnO7zkBD29rUVSwFAvLxPpYV7jbIXlbLfy218W/drD
         ZH01hEBVaGn7fTB5VGcuca4PsrNnJSUtJG6sxphCDeKRfjJRtPDFZ7tQzHOEhd1o+2
         rurc+7Nzn5KwYEowDSz4YVzK885QIam2kymI8UbXRTKhxDgUnw+kwWMgWTqtL+Cdi8
         ZGzbByLPg6/0yjat1+COw6CU4MLHjvx26M+E8UAVi4Kw1YgAIRoEddIYVUHusHtJNL
         o3N0J6opa4e0A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        muriloo@linux.ibm.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-5 tag
In-Reply-To: <CAHk-=whEQRDQ3fJT1KVVAeaWiJ+mYTM+MwYoXEOUQrnbERLa5w@mail.gmail.com>
References: <87bkyjo6wn.fsf@mpe.ellerman.id.au>
 <CAHk-=whEQRDQ3fJT1KVVAeaWiJ+mYTM+MwYoXEOUQrnbERLa5w@mail.gmail.com>
Date:   Mon, 07 Mar 2022 10:27:31 +1100
Message-ID: <878rtmoe58.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Sat, Mar 5, 2022 at 11:51 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> powerpc fixes for 5.17 #5
>>
>> Fix build failure when CONFIG_PPC_64S_HASH_MMU is not set.
>
> Hmm.
>
> I'm *still* not seeing the fix for the reported
> powerpc:skiroot_defconfig failure:
>
>     arch/powerpc/kernel/stacktrace.c: In function 'handle_backtrace_ipi':
>     arch/powerpc/kernel/stacktrace.c:171:9: error: implicit
> declaration of function 'nmi_cpu_backtrace'
>
> which has been pending forever.
>
> The alleged fix (commit 5a72345e6a78: "powerpc: Fix STACKTRACE=n
> build") has been in linux-next for three weeks by now, but hasn't been
> sent to me. And you must be aware of it, since you're the author,
> signed off on it and committed it.
>
> What's up? This has been reported forever, and was already failing in
> rc2. I'm about to release rc7 and it's *still* there.

Yeah, hmm indeed.

It's in my next branch, not my fixes branch. That's why you see it in
linux-next.

I don't recall why I put it in next, possibly I thought it wasn't a
regression in this release, but I may have just put it in next by
accident.

I'll cherry pick it into fixes and send it to you before the release.

cheers
