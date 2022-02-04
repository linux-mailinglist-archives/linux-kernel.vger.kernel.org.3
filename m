Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCD84A918B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356199AbiBDAUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356204AbiBDAUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:20:35 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EC9C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:20:35 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id n17so5467999iod.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 16:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e7ntfngrKw/fBnLk9u9OyecAZyKn8vv0COC2cQhZPaY=;
        b=m6e0Ztp7hmBnSSCwFgvVt3y/QROPcZu+ljb6SsDelUL7KkqSRDrtUXzF+HIU4uxuC6
         5gABqoAc9CxBHGvJhJqMQIaitN4jM77bpoUEfdXWKhrJermsPrwQLz87km5KZM9BNMsi
         1GyDZJOiwhtf2faHI75JMpPZSMC013VE+1P6qXpaZoIko3y6SqmbMSZZbzfQx0/LWr+P
         FVAB9psQcFgvrKLYjeTOM8o4i4ptuh9FP8c9JTajgKMWRnPLWV+wYldCa9j7Cn2jHPVP
         bVvxPtnSHSp7drtp1CrsgUE6w9y3v26EIMPmG7RlE38I+FIyFLDVDgZ4Kr6uGnKUU5lk
         hm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e7ntfngrKw/fBnLk9u9OyecAZyKn8vv0COC2cQhZPaY=;
        b=BoyYI4H8CSVUIfTigOJby0KtlKsM50v07bAgjRqjxkFUAo/e7ooRX/vVVRd02lOuWv
         bdtIw3kOQELV85iG8N+cSa7aCk7UfcFhzoHS7geq/BVy8EeLoeJCi7HELO/zTKwSXxTS
         TJodOC0fQFAXFGFuQPIZzZPIdlxZblcO8zcG5c7TRz1oZnRruUTfEldzzOFQtsAIHeyd
         T/y0ynZ5hOwFomi8gBnjzAw/YHW1I0aZ/SMSi18GECbGqCDzwqf9EtIcqhxup3W0rD/y
         W2iUVT1ywNzye5OIjUBxYj4ci3ZuGWw4DT7Ce0VQTQrxPjTYg9t7RKlem5I5YIiT6hhd
         S+xA==
X-Gm-Message-State: AOAM5335Vc6jR4kaJW/lCfxIombgEuDi4A3QIR761eeI4BZmba18Ei0t
        KuLXfUrwtZ6ChC95bJu/9wo=
X-Google-Smtp-Source: ABdhPJykchsmMWUEeQyovkh1N8mPvOZ/Fv0MLh6ROaj4SaP7saodshFLK1FyjSEt9Aa4HuLXF1C0CQ==
X-Received: by 2002:a02:9f07:: with SMTP id z7mr200556jal.87.1643934034657;
        Thu, 03 Feb 2022 16:20:34 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id i10sm200482ilv.86.2022.02.03.16.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 16:20:33 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 20C5F27C0054;
        Thu,  3 Feb 2022 19:20:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 03 Feb 2022 19:20:32 -0500
X-ME-Sender: <xms:T3H8Yez_k_gpAncaYXslSRCTzbwSREmZLqwM1Q04Yku8KSt3btRZYw>
    <xme:T3H8YaQbeKwNyAM0V3mv62VJNjmpScRmGqtg3lS7P6U-KHLBWdUcprwHMPwUYoqz_
    stT4sjgbJnVI2-scg>
X-ME-Received: <xmr:T3H8YQV1iQKgV0Zs3ng7wO3H6X8fgU4KDtoglxRvEj9MW_C0hJXipLXb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehfedujeeuffejleektdegleellefgfffhhfdvhedtkeevheejiedvjeeguddu
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:T3H8YUi9KA83uy_uAyjHfsbJNXeN0s8N-146fBmdu3QWOZg_6tsYEQ>
    <xmx:T3H8YQAMCzkx26adUsga6_uhIblfW5fJhh2KxQuawRTj8Cfzma7-NQ>
    <xmx:T3H8YVK4YsddepUMTYs-Q0fvf4qJ1-Z6zkoSZmIbqwwYTPUQWUMTxA>
    <xmx:T3H8Yf4r7iGDbH-cy3S3JcJ3znmBZ0SY--TRsvjMWrELC_T97H0kVQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Feb 2022 19:20:30 -0500 (EST)
Date:   Fri, 4 Feb 2022 08:20:25 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, ardb@kernel.org, arnd@arndb.de,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v2] atomics: fix atomic64_{read_acquire,set_release}
 fallbacks
Message-ID: <YfxxSX3v6nSJ0tKo@tardis>
References: <20220203161243.3955547-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DeK3NdMhXyr5ss/7"
Content-Disposition: inline
In-Reply-To: <20220203161243.3955547-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DeK3NdMhXyr5ss/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2022 at 04:12:43PM +0000, Mark Rutland wrote:
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

The changes for atomic_t are not necessary, right? They are correct but
"side effects" because of the change in scripts. If so, it's better to
mention this somewhere.

Regards,
Boqun

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

--DeK3NdMhXyr5ss/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmH8cUQACgkQSXnow7UH
+rhBYwf+KigCllStLyqJn7racO6pAE6IUw2TuK3BtBiUtXbE7C+BBVoxwfv/HPMs
RQ8fNJp/XcXNLqgsZ5uMNnVHaOPXr1lh5c7fnWXSGTgFuJqinAsclc1hcEzSHoIk
8drywpQlVZoqF5bauSHBp4tYUk2D9jomMU6eFu+sRlHdugTpUXJFR/r64Xn3ja/I
TtlGpICkPalaU5ROqKGJLz0eVm6JxYoAUl4uBnctQ45XkJbojMyib1ARWWBdG+dR
RDHnx1IM9Z12OLbEnFNtDoHLsAwEiA8e+UmJmcPiF47SdsJ7eaVqEPWGgcxX9i80
a3zJXpYLg7TeBiiqQabYboV2zx9r9w==
=KBIG
-----END PGP SIGNATURE-----

--DeK3NdMhXyr5ss/7--
