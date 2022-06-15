Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14FA54D51D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354250AbiFOXRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356144AbiFOXQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:16:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF713BBDB;
        Wed, 15 Jun 2022 16:16:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LNh5J1Rhgz4xbN;
        Thu, 16 Jun 2022 09:16:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655334996;
        bh=i56oAXNwE3Q5VLAEiK9NM/Mnc/C+L7RsLPNrpupmL6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rbP1XFqz52rd67eFs+BTKOvnyqAEL1G9B3afIov4ehKT8WgN2oNR0XMNXlw+glkd2
         cUwqoxiZYo9RvyFSEZPCC1L5gab7U1Omn40gb26IcZTqFEBSTq+sN6pHI+UJhlXJEl
         y/Ci3/6yo69/MhqPziHEILp2efGfjwnuVLvcthAABKI7+6rAakr72XhvgJgjgPnnc9
         as7idqpV1TFdWpZk+YaTXHnj6UdQRm9kbWlZ8TgWlzKiR7UYVCuEJ1hd6y3aTAufgF
         oZDJq2APRPWqMarpFg8+UgbSZC0D0GuMOSsQ30jfgjyJuf7sre3Jp9nZsHac/k6o7+
         6kxPd4KP5S85A==
Date:   Thu, 16 Jun 2022 09:16:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: Contextual conflict between kspp and rcu trees
Message-ID: <20220616091634.55ebbdb0@canb.auug.org.au>
In-Reply-To: <Yqo5SequJuC2qX6S@dev-arch.thelio-3990X>
References: <Yqo5SequJuC2qX6S@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3no60Zq5C=H6WqeVvlYJFXM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3no60Zq5C=H6WqeVvlYJFXM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Wed, 15 Jun 2022 12:55:53 -0700 Nathan Chancellor <nathan@kernel.org> wr=
ote:
>
> There is a contextual conflict between commit e1d337335207 ("cfi: Fix
> __cfi_slowpath_diag RCU usage with cpuidle") in the kspp tree and commit
> dcc0c11aa87b ("rcu/context-tracking: Remove rcu_irq_enter/exit()") in
> the rcu tree, which is visible when building ARCH=3Darm64 defconfig +
> CONFIG_LTO_CLANG_THIN=3Dy + CONFIG_CFI_CLANG=3Dy with clang:
>=20
>   kernel/cfi.c:298:3: error: call to undeclared function 'rcu_irq_enter';=
 ISO C99 and later do not support implicit function declarations [-Wimplici=
t-function-declaration]
>                   rcu_irq_enter();
>                   ^
>   kernel/cfi.c:298:3: note: did you mean 'ct_irq_enter'?
>   ./include/linux/context_tracking_irq.h:6:6: note: 'ct_irq_enter' declar=
ed here
>   void ct_irq_enter(void);
>        ^
>   kernel/cfi.c:307:3: error: call to undeclared function 'rcu_irq_exit'; =
ISO C99 and later do not support implicit function declarations [-Wimplicit=
-function-declaration]
>                   rcu_irq_exit();
>                   ^
>   kernel/cfi.c:307:3: note: did you mean 'ct_irq_exit'?
>   ./include/linux/context_tracking_irq.h:7:6: note: 'ct_irq_exit' declare=
d here
>   void ct_irq_exit(void);
>        ^
>   2 errors generated.
>=20
>=20
> Per the above RCU commit and commit 6c5218715286 ("context_tracking:
> Take IRQ eqs entrypoints over RCU"), it appears that the following diff
> is the proper fix up. Would you mind applying it to the merge of
> whichever tree comes second if possible? I did build and boot test it
> but it would not be a bad idea for Sami and Frederic to verify that it
> is correct so that Kees/Paul can mention it to Linus :)
>=20
> Cheers,
> Nathan
>=20
> diff --git a/kernel/cfi.c b/kernel/cfi.c
> index 08102d19ec15..2046276ee234 100644
> --- a/kernel/cfi.c
> +++ b/kernel/cfi.c
> @@ -295,7 +295,7 @@ static inline cfi_check_fn find_check_fn(unsigned lon=
g ptr)
>  	rcu_idle =3D !rcu_is_watching();
>  	if (rcu_idle) {
>  		local_irq_save(flags);
> -		rcu_irq_enter();
> +		ct_irq_enter();
>  	}
> =20
>  	if (IS_ENABLED(CONFIG_CFI_CLANG_SHADOW))
> @@ -304,7 +304,7 @@ static inline cfi_check_fn find_check_fn(unsigned lon=
g ptr)
>  		fn =3D find_module_check_fn(ptr);
> =20
>  	if (rcu_idle) {
> -		rcu_irq_exit();
> +		ct_irq_exit();
>  		local_irq_restore(flags);
>  	}
> =20

I will apply that to the merge of the rcu tree today (unless Paul finds
time to update (and test :-) ) the rcu tree before I get to it) as the
CFI fix is now in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/3no60Zq5C=H6WqeVvlYJFXM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKqaFMACgkQAVBC80lX
0GxMBgf+IZMzcN6XlmZSjaMP4poWD8ue8PXIFK8AC3CHx00YzJrLHI8XtGAXwD7G
jmJLuJs4IogmJoEKDLVfl5jnNOmIypuKtSDsM59WaQeXwvdSFvhWStMXRKv75MZv
7AsT2+/miaSp9F5y7H77NA//rezbpUVMaX/ypdsZ7JVAWUAjcSZgKfLB8FeCXaWC
/rfLYqBStCdhc3A2fKryVYiyYH13x1x26XENLsKXjNn8yrCUR0oh+aMqk3mi12Ft
f1VfjQNjMpElEx1yq+JXGTKAM6zh/eqyJTuU0yOBAYad7ZcTHT2OIynjQINbD9y/
iYbsPjnSpd6mETGVim+95TqYFogVOA==
=7PdO
-----END PGP SIGNATURE-----

--Sig_/3no60Zq5C=H6WqeVvlYJFXM--
