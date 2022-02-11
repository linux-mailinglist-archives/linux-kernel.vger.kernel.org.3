Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838D84B1B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346948AbiBKBnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:43:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiBKBnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:43:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF85F8C;
        Thu, 10 Feb 2022 17:43:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvxFy5gJMz4xRB;
        Fri, 11 Feb 2022 12:43:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644543783;
        bh=g1adS5Mf4yxBoE+lEPW0CS33tWPdSm6l7vqPogSlpBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=piiw5O2jYqPXo0dNH0SzpRBhMKIOBmaNz6kTj5uv/w8VhvYNe3W29omjs98o0TM8l
         9ydK6dq/axl6fVbABNAQgisaPL18bRmizNZ4kNlD8tWeMmzBRoI/etSAoVTbLGN9RM
         YtU74Ap7UC7xxUCUFX8HqdbYZ6Bx6ij+1EMj3cYR4cv64dy72i2AtRyDfspXvyk77E
         q426a7EPCr1YxSs2gcDrq91Ar6dayCnjlRM5Mp2dToAsUd1Va7M9746kntCVU2SXRk
         o1ZOJttcUqdUY1M/UHWcKubD0K8rhv3LMtsQzpARSgqDJpWkWSs/PGYghpNU/5JdB7
         m3oqfwfgWmsuw==
Date:   Fri, 11 Feb 2022 12:43:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boottime warning from todays linux-next
Message-ID: <20220211124302.7b0f0ec0@canb.auug.org.au>
In-Reply-To: <CAA5qM4BKwS9W5UCbnfo_xSTJKBuUEyNzUrg0UfGhoxWK5WK3RQ@mail.gmail.com>
References: <20220210184340.7eba108a@canb.auug.org.au>
        <CAA5qM4BKwS9W5UCbnfo_xSTJKBuUEyNzUrg0UfGhoxWK5WK3RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DL6fQvuyFhN33u0jVrgCW+u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DL6fQvuyFhN33u0jVrgCW+u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tong,

On Thu, 10 Feb 2022 15:35:30 -0800 Tong Zhang <ztong0001@gmail.com> wrote:
>
> I am trying to see if I can reproduce this.
> Could you share the QEMU command line and pseries_le_defconfig?
> Latest kernel does not have pseries_le_defconfig so I assume you have
> your own version.

This is a ARCH=3Dpowerpc build and qemu run.

qemu-system-ppc64 -M pseries -cpu POWER8 -m 2G -vga none -nographic -kernel=
 $vmlinux -initrd $initrd

I have a simple initrd that just boots to a login prompt.

Anyway, it seems that the mystery has been solved (hopefully).
--=20
Cheers,
Stephen Rothwell

--Sig_/DL6fQvuyFhN33u0jVrgCW+u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIFvyYACgkQAVBC80lX
0Gx8PQf+I+iXCArkWWbLWbI9BLA9VZcLxJA1D4IOYLvQVXKyJK88MCptqO84EKit
dY0y5chaiXO4ux7u0PesR4HOI6kwwEWMcT/poZZIzzl5hgYyuPbbZisEF+U9ARRt
n5LEHb8ikbByW9lM5IrWZWEmx2nYG05toveuLGvyBxgZStgg+6PmJMhlA+EF+J4F
kzZsRSmJYcm7S8tYXOcdLQnLO5xcIHLdosfD4nVmmKq2DmA23t91GY8CYUkQmO/X
zdtSim2x7iPNKgnpNDDzOFko3VM5CKGwyfH0jE6z3itvv7ca4tepjXv55eFgv01r
okVCObDCJ0sACOw65UoOyDBmm1oYCw==
=diWt
-----END PGP SIGNATURE-----

--Sig_/DL6fQvuyFhN33u0jVrgCW+u--
