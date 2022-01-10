Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274114892D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 08:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiAJHz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 02:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiAJHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:53:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DF4C03327D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 23:43:55 -0800 (PST)
Date:   Mon, 10 Jan 2022 08:43:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641800634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYq5G9lgiVp0cF250rfn+yN99kmFZjjrNjZ4Pnf7uWc=;
        b=Kh4DMynpSosqw2U0wRoMJgbR778dSXXWTKH1mI+OONwH9VCDyo4CoqMYWv3IgltKBpX7iR
        0P3l/wbbPWK98/a7VTM6REiVg4bazKnP2BMhwxkI2t13kRivjnSqprXp8v0XygbuL/zh/1
        zE3hx3W64YlHak0KAQP0DUui3NqJbhrBPhDZWwH3luJA7GX7hV+Wdfpb++zf47SVXiCXdX
        sOadVCN/5wQaGeYBH4xb2xQ0LM6FYnFOLrLPyDaBT7p9gafwaNY5y44wJoSAmP+Jb+2m4+
        +5MDz9/EDZPqa9vZrRJ8b4wjcy8Nls2QwF0quGof8q0RhzcqWa1HWdyXV8NShQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641800634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYq5G9lgiVp0cF250rfn+yN99kmFZjjrNjZ4Pnf7uWc=;
        b=mh/9QkYXqYKpQ1YfKjo0UY2qMLVpgW5uYiXkflfbBNFSbI9mngWdgga+Ng/gewO3MXupzj
        0QdxK71P3DUZLODQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/local_lock: Make the empty local_lock_*()
 function a macro.
Message-ID: <YdvjuZATR4727gaT@linutronix.de>
References: <20220105202623.1118172-1-bigeasy@linutronix.de>
 <00c4c55b-7fa6-d29c-4a80-c196922ef527@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <00c4c55b-7fa6-d29c-4a80-c196922ef527@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-05 22:34:31 [-0500], Waiman Long wrote:
>=20
> I try out this patch and it indeed helps to reduce the object size of
> functions that use local_lock(). However, the extra code isn't an additio=
nal
> mov+add.
>=20
> Using folio_add_lru() as an example,
>=20
> Without the patch:
>=20
> 466=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 local_lock(&lru_pvecs.lock);
> =C2=A0=C2=A0 0x00000000000032ee <+14>:=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=
=C2=A0 $0x1,%edi
> =C2=A0=C2=A0 0x00000000000032f3 <+19>:=C2=A0=C2=A0=C2=A0 callq=C2=A0 0x32=
f8 <folio_add_lru+24>
> =C2=A0=C2=A0 0x00000000000032f8 <+24>:=C2=A0=C2=A0=C2=A0 callq=C2=A0 0x32=
fd <folio_add_lru+29>

The call here might be due to some debugging switches or compiler
optimisation. I have with no debug and gcc-11:
| # mm/swap.c:466:     local_lock(&lru_pvecs.lock);
|         movq    $lru_pvecs, %rbx        #, tmp135
|         movq    %rbx, %rax      # tmp135, tcp_ptr__
| #APP
| # 466 "mm/swap.c" 1
|         add %gs:this_cpu_off(%rip), %rax        # this_cpu_off, tcp_ptr__

so it is mov per-CPU variable, add per-CPU offset.

Sebastian
