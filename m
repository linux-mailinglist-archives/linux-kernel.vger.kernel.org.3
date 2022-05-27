Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F475367F2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350492AbiE0UO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiE0UOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 16:14:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B61F703C7
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 13:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/JbY6NIfEA9XeqiPP6KIr66UKiO0C7oMhJ4ZgGJq/uk=;
        t=1653682490; x=1654892090; b=a4yAYzDaNhpN9aT5ZV6TebPFY/3WxaxEFbEEkoS5FYSZZ3p
        1OqwD8jdSeEIol+yBXwHRxqzrzafQDkZy66tujSxuXZEcnnhYVrxQPDLdZtqBkAyzZzedkdUyO5ge
        +OQRtPHJN5s63iCoeZ2HVkYSUzYcSD6f/CGThEvqcoqpQ6puukpoegrHOJJ/akqYo2VrKy3wIue2e
        8/dxJx+JItwbyfqor5Tt86fyjCtSgCAW8QW34ZkXD/q/7J4A54I0I9BKvaEvqxsudibj3swTS7IAm
        y4LN2o3JNDGVf6qfpvYKN849kREJm+5aXBGyXBAmBQOpULfpU0fYivXSKvCjvuRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nugM3-006B6d-Au;
        Fri, 27 May 2022 22:14:39 +0200
Message-ID: <de38a6b852d31cbe123d033965dbd9b662d29a76.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Gow <davidgow@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>, linux-mm@kvack.org
Date:   Fri, 27 May 2022 22:14:37 +0200
In-Reply-To: <20220527185600.1236769-2-davidgow@google.com>
References: <20220527185600.1236769-1-davidgow@google.com>
         <20220527185600.1236769-2-davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 11:56 -0700, David Gow wrote:
>=20
> This is v2 of the KASAN/UML port. It should be ready to go.

Nice, thanks a lot! :)

> It does benefit significantly from the following patches:
> - Bugfix for memory corruption, needed for KASAN_STACK support:
> https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch@=
axis.com/

Btw, oddly enough, I don't seem to actually see this (tried gcc 10.3 and
11.3 so far) - is there anything you know about compiler versions
related to this perhaps? Or clang only?

The kasan_stack_oob test passes though, and generally 45 tests pass and
10 are skipped.


> +# Kernel config options are not included in USER_CFLAGS, but the
> option for KASAN
> +# should be included if the KASAN config option was set.
> +ifdef CONFIG_KASAN
> +	USER_CFLAGS+=3D-DCONFIG_KASAN=3Dy
> +endif
>=20

I'm not sure that's (still?) necessary - you don't #ifdef on it anywhere
in the user code; perhaps the original intent had been to #ifdef
kasan_map_memory()?


> +++ b/arch/um/os-Linux/user_syms.c
> @@ -27,10 +27,10 @@ EXPORT_SYMBOL(strstr);
>  #ifndef __x86_64__
>  extern void *memcpy(void *, const void *, size_t);
>  EXPORT_SYMBOL(memcpy);
> -#endif
> -
>  EXPORT_SYMBOL(memmove);
>  EXPORT_SYMBOL(memset);
> +#endif
> +
>  EXPORT_SYMBOL(printf);
> =20
>  /* Here, instead, I can provide a fake prototype. Yes, someone cares: ge=
nksyms.
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index ba5789c35809..f778e37494ba 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -28,7 +28,8 @@ else
> =20
>  obj-y +=3D syscalls_64.o vdso/
> =20
> -subarch-y =3D ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk=
_64.o
> +subarch-y =3D ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk=
_64.o \
> +	../lib/memmove_64.o ../lib/memset_64.o

I wonder if we should make these two changes contingent on KASAN too, I
seem to remember that we had some patches from Anton flying around at
some point to use glibc string routines, since they can be even more
optimised (we're in user space, after all).

But I suppose for now this doesn't really matter, and even if we did use
them, they'd come from libasan anyway?


Anyway, looks good to me, not sure the little not above about the user
cflags matters.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes
