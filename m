Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17EC4EA45D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiC2AzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 20:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiC2Ay7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 20:54:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DF4255B8;
        Mon, 28 Mar 2022 17:53:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KS9z909R3z4xLS;
        Tue, 29 Mar 2022 11:53:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648515191;
        bh=2lwjxvCdH5o+2pRxNG/TWtu7CImYj/ctSD1Cs2hUXNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HdDdcXYUbERJgegAjqMJdMBQJ38/lgIubqeF7sXOFsY+jCRFIxVsQ2MpShdAt6fQZ
         LEsSBdNzlxssuDYvrjxcXj1BtGKR2MAuEwFC8RfcWu/UBKgVUV5q2A7FauZR778kEh
         vn3b0A1zaxQF9WEIUhq8iXQ8jV6ozJmC79ZhRQDrwTVMVbd9BKYU9IbBqRlUL7w/kr
         DoxQRHDjoSbjxW1hOPwWYdmBpVR6LL3/krQ8nqopKKzO2llCIdirzoBJ4KILSiZcWf
         Cp6PnRZ1E+MjXLJtByDHYE+OKX6Z+6lSnUl2vb30RpqHridbH1oraKCUTNUQjTafUZ
         hEGXp0IJvEQrQ==
Date:   Tue, 29 Mar 2022 11:53:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ptrace: Cleanups for v5.18
Message-ID: <20220329115308.7388b656@canb.auug.org.au>
In-Reply-To: <CAHk-=wj2u3MT5Ukaw9aAB-0oSs9S58kuRNqqy5AL-GTn9LNGkA@mail.gmail.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
        <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
        <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org>
        <CAHk-=wj2u3MT5Ukaw9aAB-0oSs9S58kuRNqqy5AL-GTn9LNGkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2MXOFHk+i2vG91Hv_GQhHJV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2MXOFHk+i2vG91Hv_GQhHJV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, 28 Mar 2022 17:33:52 -0700 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> On Mon, Mar 28, 2022 at 4:56 PM Eric W. Biederman <ebiederm@xmission.com>=
 wrote:
> >
> > The removal of tracehook.h is quite significant as it has been a major
> > source of confusion in recent years.  Much of that confusion was
> > around task_work and TIF_NOTIFY_SIGNAL (which I have now decoupled
> > making the semantics clearer). =20
>=20
> Hmm. I love removing tracehook.c, but this looks like it hasn't been
> in linux-next.

See https://lore.kernel.org/lkml/20220316165612.4f50faad@canb.auug.org.au/

--=20
Cheers,
Stephen Rothwell

--Sig_/2MXOFHk+i2vG91Hv_GQhHJV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJCWHQACgkQAVBC80lX
0GyhUgf/T23S1R6g/ttqdhUGwrz8Y1AZDAns6+ddi6NUlOsHZRuVVbN1ADJw26gg
BlAcMrK/Y+UwN/WyM3YQCz9kcp2H+/J40tdwb1Ox81LxTDSWr56GNOOE828tYrla
T9EJZ+tX8NuvbFcIKpEY0GbpXvy9wZohlyu2GB3+anVAfgGlmwo70hkkP93O5qBT
ZKawgHfrBbEjO8JvgTEhHCyM42EE0ZuGUHfhn2R+FbFFTKxuQk4OhEQ8JpsXCHzm
MX1W4qUjdrM5bQd2q3KzxmxbEAwj5ouvux2G14DDbAwl9f9sy2iKQjr0opO0xWVY
USy8hBRXHdMvBiXzsL3YnFvaxA5cxA==
=T2kj
-----END PGP SIGNATURE-----

--Sig_/2MXOFHk+i2vG91Hv_GQhHJV--
