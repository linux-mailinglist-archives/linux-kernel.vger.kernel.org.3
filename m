Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA34ABE53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391612AbiBGMC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 07:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379853AbiBGLjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:39:51 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0678CC0401E5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:38:30 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id s18so16209565ioa.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V1HhHC6A+Fh64mlRZvqHU0ihErJfsCQ9xqa/pAlWGN4=;
        b=PrOAB9A2HHgfvLxb74o4f28JVkndZq/dGRnddZYRW3V3i48pAI/ZrVHT35BPBPRreF
         a5QNFqpATVKAZkI9FIZuVd8DgFYAY8GzQ6M8E0kobNOhEbFRYgBEvouMoNMSQiEgckIT
         u2aicIo1izkgVf5yJh6QTL8ZqSN5G1F6cZdeCWsnpvkKRRoenflPgwoYlwbmXdUGX7ST
         NUoZd1FYMv/vue48Un5t17d1zDCCxpjEKV991uiIiRcNxyCHUsXCd9AD+hSujFXnbhm0
         vLNPHziXcKMi/MTP5omdcptnFgBcBX2BZD3JdFczYN3PfnMqdluV1528yDTW7VP9/oi3
         LjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V1HhHC6A+Fh64mlRZvqHU0ihErJfsCQ9xqa/pAlWGN4=;
        b=BdPUalQWu6wWQqqIeocmoRlPHsdEG+eSMcvwYCGupn8F95Q0614CoHJcsLqFt4BFwU
         XlsuYEzG2Ys2OvxFuLdZQvOcsgQmqlc5gwG4yx8ksfV26Q+FSd/Vjf4UIw2QC9SFevQ+
         EwbhapdHPe6L5zDgwfib4w0+Ga/4JKHJuugJF7ENc610AbuuoDCqwcdfiHFa2St5WJ9u
         6x7irzCvkSimAjoVgVBNuX5VQtQahGAVgqVunt8e/0cCJGOFXPYDcQzL5m2PlbyHwpO3
         ws2PI/SZvCCQgHH8YJKusMKK/dSkXys1tGqDXSJ+norA6E+DSDnq18zr15nKp5+kCC96
         h3Iw==
X-Gm-Message-State: AOAM531A7trOT6+9nVu510nHX+A347SnrFh5+h92vSaM+2L4lnuPiItJ
        zmelcHR3IKX7ARZlC7yXsOQq1imRCck=
X-Google-Smtp-Source: ABdhPJzRR5S68u7qyO+FpvQHmiNfeYVYIYcLxWGoIQTmq0NS1UBCevdZSJZQjG3UmWmXdm/fh6A8Vw==
X-Received: by 2002:a02:aa09:: with SMTP id r9mr5653673jam.199.1644233909576;
        Mon, 07 Feb 2022 03:38:29 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x19sm5852263iov.33.2022.02.07.03.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 03:38:28 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id B010027C0054;
        Mon,  7 Feb 2022 06:38:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Feb 2022 06:38:26 -0500
X-ME-Sender: <xms:sgQBYmrEhvN7xWQJeZvmbKsp2cmw1HJFtHY0Qony-saLFIgZ9w1syQ>
    <xme:sgQBYkr5hgqhkuVBBruckqPbKUeOwQr7lqkEnDhuhL7ZFRyhBkU5Ox2dnMQSu0Qmv
    laqTBnvLs0S2w8BAg>
X-ME-Received: <xmr:sgQBYrP4CLM7X60p_WV0hGlSbTNdCzSwcu1M900hcyMDnG-zeNbuQRCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeuheejjeeiveeuueetieeluedvvdevvdeiledttddukeeggeeuledvtdektedt
    veenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:sgQBYl4iKg6Rmg-wZJ2ARbw6ZGce5SquOp12DtNRtjpipIoZ7qBEbw>
    <xmx:sgQBYl7avFGTznrzayDX4Etp-eL0l2DG36FRwsAhOa3jtXuG2QeB-w>
    <xmx:sgQBYlgKKM2ykr8rQdLvzO-ls9x_khQz9YhBbNzER3ttGBFl2zYQQw>
    <xmx:sgQBYjRlJAB2gbjaxk-mR6oOQRDctsqBuMC3mvI_IF9lHess_7Yrmw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 06:38:24 -0500 (EST)
Date:   Mon, 7 Feb 2022 19:38:20 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, ardb@kernel.org, arnd@arndb.de,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v3] atomics: fix atomic64_{read_acquire,set_release}
 fallbacks
Message-ID: <20220207113820.hl6kpewb7blzllf5@tardis>
References: <20220207101943.439825-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sih24bywnblxktiw"
Content-Disposition: inline
In-Reply-To: <20220207101943.439825-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sih24bywnblxktiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 07, 2022 at 10:19:43AM +0000, Mark Rutland wrote:
> Arnd reports that on 32-bit architectures, the fallbacks for
> atomic64_read_acquire() and atomic64_set_release() are broken as they
> use smp_load_acquire() and smp_store_release() respectively, which do
> not work on types larger than the native word size.
>=20
> Since those contain compiletime_assert_atomic_type(), any attempt to use
> those fallbacks will result in a build-time error. e.g. with the
> following added to arch/arm/kernel/setup.c:
>=20
> | void test_atomic64(atomic64_t *v)
> | {
> |        atomic64_set_release(v, 5);
> |        atomic64_read_acquire(v);
> | }
>=20
> The compiler will complain as follows:
>=20
> | In file included from <command-line>:
> | In function 'arch_atomic64_set_release',
> |     inlined from 'test_atomic64' at ./include/linux/atomic/atomic-instr=
umented.h:669:2:
> | ././include/linux/compiler_types.h:346:38: error: call to '__compiletim=
e_assert_9' declared with attribute error: Need native word sized stores/lo=
ads for atomicity.
> |   346 |  _compiletime_assert(condition, msg, __compiletime_assert_, __C=
OUNTER__)
> |       |                                      ^
> | ././include/linux/compiler_types.h:327:4: note: in definition of macro =
'__compiletime_assert'
> |   327 |    prefix ## suffix();    \
> |       |    ^~~~~~
> | ././include/linux/compiler_types.h:346:2: note: in expansion of macro '=
_compiletime_assert'
> |   346 |  _compiletime_assert(condition, msg, __compiletime_assert_, __C=
OUNTER__)
> |       |  ^~~~~~~~~~~~~~~~~~~
> | ././include/linux/compiler_types.h:349:2: note: in expansion of macro '=
compiletime_assert'
> |   349 |  compiletime_assert(__native_word(t),    \
> |       |  ^~~~~~~~~~~~~~~~~~
> | ./include/asm-generic/barrier.h:133:2: note: in expansion of macro 'com=
piletime_assert_atomic_type'
> |   133 |  compiletime_assert_atomic_type(*p);    \
> |       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> | ./include/asm-generic/barrier.h:164:55: note: in expansion of macro '__=
smp_store_release'
> |   164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_sto=
re_release(p, v); } while (0)
> |       |                                                       ^~~~~~~~~=
~~~~~~~~~~
> | ./include/linux/atomic/atomic-arch-fallback.h:1270:2: note: in expansio=
n of macro 'smp_store_release'
> |  1270 |  smp_store_release(&(v)->counter, i);
> |       |  ^~~~~~~~~~~~~~~~~
> | make[2]: *** [scripts/Makefile.build:288: arch/arm/kernel/setup.o] Erro=
r 1
> | make[1]: *** [scripts/Makefile.build:550: arch/arm/kernel] Error 2
> | make: *** [Makefile:1831: arch/arm] Error 2
>=20
> Fix this by only using smp_load_acquire() and smp_store_release() for
> native atomic types, and otherwise falling back to the regular barriers
> necessary for acquire/release semantics, as we do in the more generic
> acquire and release fallbacks.
>=20
> Since the fallback templates are used to generate the atomic64_*() and
> atomic_*() operations, the __native_word() check is added to both. For
> the atomic_*() operations, which are always 32-bit, the __native_word()
> check is redundant but not harmful, as it is always true.
>=20
> For the example above this works as expected on 32-bit, e.g. for arm
> multi_v7_defconfig:
>=20
> | <test_atomic64>:
> |         push    {r4, r5}
> |         dmb     ish
> |         pldw    [r0]
> |         mov     r2, #5
> |         mov     r3, #0
> |         ldrexd  r4, [r0]
> |         strexd  r4, r2, [r0]
> |         teq     r4, #0
> |         bne     484 <test_atomic64+0x14>
> |         ldrexd  r2, [r0]
> |         dmb     ish
> |         pop     {r4, r5}
> |         bx      lr
>=20
> ... and also on 64-bit, e.g. for arm64 defconfig:
>=20
> | <test_atomic64>:
> |         bti     c
> |         paciasp
> |         mov     x1, #0x5
> |         stlr    x1, [x0]
> |         ldar    x0, [x0]
> |         autiasp
> |         ret
>=20
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  include/linux/atomic/atomic-arch-fallback.h | 38 ++++++++++++++++++---
>  scripts/atomic/fallbacks/read_acquire       | 11 +++++-
>  scripts/atomic/fallbacks/set_release        |  7 +++-
>  3 files changed, 49 insertions(+), 7 deletions(-)
>=20
> Since v1 [1]:
> * Fix templates to use arch_${atomic}_{read,write}()
> * Update 32-bit sample codegen
> * Correct typo in commit message
>=20
> Since v2 [2]:
> * Explain why redundant checks are safe for atomic_t operations
> * Add Ard's Reviewed-by tag
>=20
> [1] https://lore.kernel.org/lkml/20220203143848.3934515-1-mark.rutland@ar=
m.com
> [2] https://lore.kernel.org/lkml/20220203161243.3955547-1-mark.rutland@ar=
m.com
>=20
> diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/=
atomic/atomic-arch-fallback.h
> index a3dba31df01e..6db58d180866 100644
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -151,7 +151,16 @@
>  static __always_inline int
>  arch_atomic_read_acquire(const atomic_t *v)
>  {
> -	return smp_load_acquire(&(v)->counter);
> +	int ret;
> +
> +	if (__native_word(atomic_t)) {
> +		ret =3D smp_load_acquire(&(v)->counter);
> +	} else {
> +		ret =3D arch_atomic_read(v);
> +		__atomic_acquire_fence();
> +	}
> +
> +	return ret;
>  }
>  #define arch_atomic_read_acquire arch_atomic_read_acquire
>  #endif
> @@ -160,7 +169,12 @@ arch_atomic_read_acquire(const atomic_t *v)
>  static __always_inline void
>  arch_atomic_set_release(atomic_t *v, int i)
>  {
> -	smp_store_release(&(v)->counter, i);
> +	if (__native_word(atomic_t)) {
> +		smp_store_release(&(v)->counter, i);
> +	} else {
> +		__atomic_release_fence();
> +		arch_atomic_set(v, i);
> +	}
>  }
>  #define arch_atomic_set_release arch_atomic_set_release
>  #endif
> @@ -1258,7 +1272,16 @@ arch_atomic_dec_if_positive(atomic_t *v)
>  static __always_inline s64
>  arch_atomic64_read_acquire(const atomic64_t *v)
>  {
> -	return smp_load_acquire(&(v)->counter);
> +	s64 ret;
> +
> +	if (__native_word(atomic64_t)) {
> +		ret =3D smp_load_acquire(&(v)->counter);
> +	} else {
> +		ret =3D arch_atomic64_read(v);
> +		__atomic_acquire_fence();
> +	}
> +
> +	return ret;
>  }
>  #define arch_atomic64_read_acquire arch_atomic64_read_acquire
>  #endif
> @@ -1267,7 +1290,12 @@ arch_atomic64_read_acquire(const atomic64_t *v)
>  static __always_inline void
>  arch_atomic64_set_release(atomic64_t *v, s64 i)
>  {
> -	smp_store_release(&(v)->counter, i);
> +	if (__native_word(atomic64_t)) {
> +		smp_store_release(&(v)->counter, i);
> +	} else {
> +		__atomic_release_fence();
> +		arch_atomic64_set(v, i);
> +	}
>  }
>  #define arch_atomic64_set_release arch_atomic64_set_release
>  #endif
> @@ -2358,4 +2386,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
>  #endif
> =20
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
> +// 8e2cc06bc0d2c0967d2f8424762bd48555ee40ae
> diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallb=
acks/read_acquire
> index 803ba7561076..a0ea1d26e6b2 100755
> --- a/scripts/atomic/fallbacks/read_acquire
> +++ b/scripts/atomic/fallbacks/read_acquire
> @@ -2,6 +2,15 @@ cat <<EOF
>  static __always_inline ${ret}
>  arch_${atomic}_read_acquire(const ${atomic}_t *v)
>  {
> -	return smp_load_acquire(&(v)->counter);
> +	${int} ret;
> +
> +	if (__native_word(${atomic}_t)) {
> +		ret =3D smp_load_acquire(&(v)->counter);
> +	} else {
> +		ret =3D arch_${atomic}_read(v);
> +		__atomic_acquire_fence();
> +	}
> +
> +	return ret;
>  }
>  EOF
> diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallba=
cks/set_release
> index 86ede759f24e..05cdb7f42477 100755
> --- a/scripts/atomic/fallbacks/set_release
> +++ b/scripts/atomic/fallbacks/set_release
> @@ -2,6 +2,11 @@ cat <<EOF
>  static __always_inline void
>  arch_${atomic}_set_release(${atomic}_t *v, ${int} i)
>  {
> -	smp_store_release(&(v)->counter, i);
> +	if (__native_word(${atomic}_t)) {
> +		smp_store_release(&(v)->counter, i);
> +	} else {
> +		__atomic_release_fence();
> +		arch_${atomic}_set(v, i);
> +	}
>  }
>  EOF
> --=20
> 2.30.2
>=20

--sih24bywnblxktiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmIBBKcACgkQSXnow7UH
+rjhsAgAmYttN/jqrhZzG3tdq9PQEX3xUQ4KPYQc4CmncPseaSxZaW24PioTF5b7
+f6Z8TxkXgytDc2hDIdQhm6eoUd05QWxZNoPYyF4If94WhD9qmt0a28ofDVBR323
wbJ5jbZRI3d3n1kB7yAUDyXgbVvRW9okY4oAW4d9ZwZ4oD2wf6eSP4K+TNypdukQ
BXCsv7oRwQNmfH5HIR9fU4yxmYhTGq+DWkT7WjIjNLBQ/zWMjr2HX0Mr3/ugnOqD
EdpQOJ7bBFUAkwdK8Gm5dDkem2kg/DSPz03sb5OJgUgIEeEoUiz91vvd0x+4Ca7b
8Vqvi2nzR5xT7peQvHcMDNHSpDtctA==
=KEIh
-----END PGP SIGNATURE-----

--sih24bywnblxktiw--
