Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B5D4A3ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiA3XKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiA3XKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:10:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E719CC061714;
        Sun, 30 Jan 2022 15:10:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jn6NM4bKkz4xRB;
        Mon, 31 Jan 2022 10:09:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643584195;
        bh=bDpsJoZWES//hT1pTNftPxhCHGgocAa0nMe8EX/9mA0=;
        h=Date:From:To:Cc:Subject:From;
        b=kdmvn6grKXsB/4rdyx3o3I3cofHcTXQ/LbvvvOhUEMj9JcthWq7oc/z0HkHpd4Qli
         y8gGWOj5O8uwqkv6sROMLbi+GbPmGQUjSetrWFJocvkyT5D2lXuvBWlevD+YfCNGch
         7TJexujRAQRMua3AUvqOjPRG6132rut3udkb2kO5+tcPPuB44xWgsJM9dgke/+Rgnj
         6QQ8t57aRlUWcMCSaIyTMAjv8VF3JaO+1+tgjwLb2SwHqpw8SvtxtgHqlClP13gDi+
         6wzjMl9jGdkoWTJ9zpvF3ocvKQjvfoJh01e8OvQgbCgSovECHmt4g08Cy1eUywjK77
         nI9pUGrqY+P/Q==
Date:   Mon, 31 Jan 2022 10:09:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20220131100954.74a2034f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zu4q6q2/mkBU.yay6bQj.rh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zu4q6q2/mkBU.yay6bQj.rh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/string.h:253,
                 from include/linux/bitmap.h:11,
                 from include/linux/cpumask.h:12,
                 from arch/x86/include/asm/cpumask.h:5,
                 from arch/x86/include/asm/msr.h:11,
                 from arch/x86/include/asm/processor.h:22,
                 from arch/x86/include/asm/timex.h:5,
                 from include/linux/timex.h:65,
                 from include/linux/time32.h:13,
                 from include/linux/time.h:60,
                 from include/linux/skbuff.h:15,
                 from include/linux/tcp.h:17,
                 from drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:33:
In function 'fortify_memcpy_chk',
    inlined from 'mlx5e_insert_vlan' at drivers/net/ethernet/mellanox/mlx5/=
core/en_tx.c:211:2,
    inlined from 'mlx5e_sq_xmit_wqe' at drivers/net/ethernet/mellanox/mlx5/=
core/en_tx.c:496:4:
include/linux/fortify-string.h:325:25: error: call to '__write_overflow_fie=
ld' declared with attribute warning: detected write beyond size of field (1=
st parameter); maybe use struct_group()? [-Werror=3Dattribute-warning]
  325 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/string.h:253,
                 from include/linux/bitmap.h:11,
                 from include/linux/cpumask.h:12,
                 from arch/x86/include/asm/cpumask.h:5,
                 from arch/x86/include/asm/msr.h:11,
                 from arch/x86/include/asm/processor.h:22,
                 from arch/x86/include/asm/timex.h:5,
                 from include/linux/timex.h:65,
                 from include/linux/time32.h:13,
                 from include/linux/time.h:60,
                 from include/linux/ktime.h:24,
                 from include/linux/timer.h:6,
                 from include/linux/netdevice.h:24,
                 from include/trace/events/xdp.h:8,
                 from include/linux/bpf_trace.h:5,
                 from drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:33:
In function 'fortify_memcpy_chk',
    inlined from 'mlx5e_xmit_xdp_frame' at drivers/net/ethernet/mellanox/ml=
x5/core/en/xdp.c:344:3:
include/linux/fortify-string.h:325:25: error: call to '__write_overflow_fie=
ld' declared with attribute warning: detected write beyond size of field (1=
st parameter); maybe use struct_group()? [-Werror=3Dattribute-warning]
  325 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by various commits in the mlx5 driver interacting with the new
memcpy checking.

I have disabled CONFIG_MLX5_CORE_EN for today while this gets sorted
out properly.

--=20
Cheers,
Stephen Rothwell

--Sig_/zu4q6q2/mkBU.yay6bQj.rh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH3GsIACgkQAVBC80lX
0GwP6Qf9EISBThaLkN39k4EX2CoZ3A7N1cqf1QaL/+IEsaOCxaX8BOcMyvj/D2dA
kZ/w+ZAnGOeeLTWgDE4phA05h7wKZ09HTjM+6kuQH4nm9NjylxC9VfJp+Fxi6W5S
CjN+lGRrtO7I/+eJPA7BTy3pH0sBGwBcLy+ZlVdbO/zrm+6TlFkYqXzgJJgNazmE
xSuC/WVvRTv1PBfo7Rjp8VD0XiYOsK46ovJP3tYA51BzhepyWcl0yduBAzjWB/wp
7pnjWOaBmHeo2VHmSQo+71+IlteslG7tSlO87c9XAoL0FWB0MmeW9CX82TMU4H8h
YfnbU02OM7AUMfYVFCEobwTwHlf0jQ==
=Nn/o
-----END PGP SIGNATURE-----

--Sig_/zu4q6q2/mkBU.yay6bQj.rh--
