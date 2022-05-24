Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CFD532811
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiEXKpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiEXKpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:45:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60B55EDDB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kt2sayrFs9fm5f2jDsLTGATuG5rlPL0q0HMqvl93aaY=;
        t=1653389117; x=1654598717; b=KH/49QEzCCtlTfrU4QoDTcBU2X7ScvOMp+0wIi+rxt37SaV
        faWqZhbdZsx31lVLZIvEEBosTS9ub+H8VI02LF54yRVlYumxYs5tFN+RylyRT8WfMDjdfxlkXB5nn
        Pakcxy2Ve7n39eo/I9YNBwgYMgSAMo4fw+xFXGCtrlcgnkfZd6dC7IPyc1JHVe1DwQLiC0soSAbvZ
        fNtOWO+UuFGjHnf/Szz+4obBsJB3u7H2UqVilu8rlI3ZGIXeWVfmSmfMO9gXvHr5iF4uZd7mNB8a0
        p+pD3ka2cutRmkLCLUE42tDzKySGZ5URkSipgMdb1cJP/cACQJ9nVJCK74LAQ1WQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ntS2D-003HQk-AK;
        Tue, 24 May 2022 12:45:05 +0200
Message-ID: <fce12845b59a49cc2994e55cfd88071f6890c138.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Date:   Tue, 24 May 2022 12:45:03 +0200
In-Reply-To: <20220524103423.GA13239@axis.com>
References: <20200226004608.8128-1-trishalfonso@google.com>
         <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
         <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
         <CAKFsvULGSQRx3hL8HgbYbEt_8GOorZj96CoMVhx6sw=xWEwSwA@mail.gmail.com>
         <1fb57ec2a830deba664379f3e0f480e08e6dec2f.camel@sipsolutions.net>
         <20220524103423.GA13239@axis.com>
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

Hi Vincent,

> Old thread, but I had a look at this the other day and I think I got it
> working.  Since the entire shadow area is mapped at init, we don't need
> to do any mappings later.

Nice!! I've always wanted to get back to this too.

> It works both with and without KASAN_VMALLOC.  KASAN_STACK works too
> after I disabled sanitization of the stacktrace code.  All kasan kunit
> tests pass and the test_kasan.ko module works too.

:-)

> The CONFIG_UML checks need to
> be replaced with something more appropriate (new config? __weak
> functions?) and the free functions should probably be hooked up to
> madvise(MADV_DONTNEED) so we discard unused pages in the shadow
> mapping.

I guess a new config would be most appropriate - that way code can be
compiled out accordingly. But I don't know who maintains the KASAN code,
I guess have to discuss with them.

> Note that there's a KASAN stack-out-of-bounds splat on startup when just
> booting UML.  That looks like a real (17-year-old) bug, I've posted a
> fix for that:
>=20
>  https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch=
@axis.com/

Hah, right, I was wondering how that came up suddenly now... Almost
suprised it's just a single bug so far :)

> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -295,8 +295,14 @@ int kasan_populate_vmalloc(unsigned long addr, unsig=
ned long size)
>  		return 0;
> =20
>  	shadow_start =3D (unsigned long)kasan_mem_to_shadow((void *)addr);
> -	shadow_start =3D ALIGN_DOWN(shadow_start, PAGE_SIZE);
>  	shadow_end =3D (unsigned long)kasan_mem_to_shadow((void *)addr + size);
> +
> +	if (IS_ENABLED(CONFIG_UML)) {
> +		__memset(kasan_mem_to_shadow((void *)addr), KASAN_VMALLOC_INVALID, sha=
dow_end - shadow_start);
> +		return 0;
> +	}
>=20

If that were

	if (IS_ENABLED(CONFIG_KASAN_NO_SHADOW_ALLOC)) {
		...
	}

(or so) as discussed above, it might be a little more readable, but
otherwise it doesn't really seem all _that_ intrusive.

I'll give it a spin later.

johannes
