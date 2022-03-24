Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725264E67ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352321AbiCXRlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiCXRlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:41:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA4775E5B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:39:39 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648143578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yt6RjQL7+8uCUwnFlP+GHK79ld0XaeD3LIiPog555q8=;
        b=bxjpBRoqXsCOLpylQDPNICcchH+GaINGX7NUSPQT5DIFaVy/UxU18HEGj3qkU3kIgolv5N
        xaPYDJGB8VIDagNwtS81RDnRdFtS5XUM6tMlf/6r6EXlwfCfog+im2fkHja36IF3deWv3y
        6yFXzAuJtU+MM/nNhNIQyxFisAPE2764zrzQlDwl1xLK1sip9qoTsfCEvr63rRto656oNH
        ZIuqE7aAYxjfe0nBp+cCDDGQSLYtRk4ghwluQxkLT4Vp50MkzbELYuNnqpfAVw/ZEHHm6X
        wmjUINZKAykK2al7LwnLxmCMdn45s6yQwLTGQhBM621XtL5skN4hRL/KjuaMnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648143578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yt6RjQL7+8uCUwnFlP+GHK79ld0XaeD3LIiPog555q8=;
        b=GuCaIz4L+sC5pGzb7fZ/lADakGrKq7QSy1LQiRw6TlKYUBIgYiRHk3teyzF7xH96PAKod0
        OqlamYvXmO823dDg==
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        boqun.feng@gmail.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH 0/3] Remove volatile from arch_raw_cpu_ptr() and revert the hacks.
Date:   Thu, 24 Mar 2022 18:39:24 +0100
Message-Id: <20220324173927.2230447-1-bigeasy@linutronix.de>
In-Reply-To: <CAHk-=wh81PAKxapicYOby3WWOFJV2htR5KWCRdKNgw68mOc0Zg@mail.gmail.com>
References: <CAHk-=wh81PAKxapicYOby3WWOFJV2htR5KWCRdKNgw68mOc0Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-23 10:17:08 [-0700], Linus Torvalds wrote:
> I get the feeling that the real problem is that on x86, we have this:
>=20
> #define arch_raw_cpu_ptr(ptr)                           \
> ({                                                      \
>         unsigned long tcp_ptr__;                        \
>         asm volatile("add " __percpu_arg(1) ", %0"      \
>                      : "=3Dr" (tcp_ptr__)                 \
>                      : "m" (this_cpu_off), "0" (ptr));  \
>         (typeof(*(ptr)) __kernel __force *)tcp_ptr__;   \
> })
>=20
> and that "volatile" is just *WRONG*.
>=20
> That volatile is what literally tells the compiler "you can't remove
> this if it isn't used".

It is indeed just x86. After double checking arm/mips removes that code
properly.

> But there's no point to that.
>=20
> So how about we
>=20
>  (a) just revert commit 9983a9d577db4
>=20
>  (b) remove that bogus 'volatile'
>=20
> Doesn't that fix the problem?

The following series does that. The assembly code looks okay. In a few
simple test cases the this_cpu_ptr() usage is always created and is not
moved passed preempt_enable() statement.
The resulting vmlinux shrunk a bit. The test config lost ~2KiB:
     text      data       bss       dec      hex filename
 22533901  10722831  13963496  47220228  2d08604 vmlinux.volatile
 22531589  10722831  13971688  47226108  2d09cfc vmlinux.patched

after looking at it it was sometimes due avoiding this_cpu_ptr(),
sometimes it looked that the compiler made other decisions at the
earlier resulting to be more beneficial later on.

Sebastian


