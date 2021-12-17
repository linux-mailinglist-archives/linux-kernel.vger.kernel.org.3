Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4294783B7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhLQDkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhLQDkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:40:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD74C061574;
        Thu, 16 Dec 2021 19:40:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFZVv1lHgz4xdH;
        Fri, 17 Dec 2021 14:40:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639712407;
        bh=GxSSqJOXqS35uH17TBKHWTjytAbihY44ax+Ndfqbw6I=;
        h=Date:From:To:Cc:Subject:From;
        b=eYoNkSOcPUY+SBqSLe3h25KtLGtoEo0sHmiPumYIPuvV/u9Hhai0i5rYLCyJXoFfX
         KQaL8JY6Bf9m2FLmY53388bQjzH9p+hs0F2/GuR38WjWnIXBkx81QoJRXnNOvvWN+m
         gh6FKb1lEJAQLClMVOpu+SsQo5nxb+lFcq8L2rwiCrE1XA/Gz9H4JGvbDC5GvjFBvQ
         WHxg4m5INFzv/rdQpdLAjhJOKWZTcAWIrcoIRQdYPAoD9FkNZqjx4ULnItOFMnRV8F
         pLCbwkZpGm3XT4maahXN+cQ5PHOAcv2ReAOl59ctGKvKN0F0W4ZhZWv1FbKRnyCsaq
         tNSv1UOx4aaZQ==
Date:   Fri, 17 Dec 2021 14:40:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tip tree
Message-ID: <20211217144004.0c00fabc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b3cpkwV.TnqU4jRVh1q/2Rg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b3cpkwV.TnqU4jRVh1q/2Rg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
produced these warnings:

lib/strnlen_user.o: warning: objtool: strnlen_user()+0xc9: call to do_strnl=
en_user() with UACCESS enabled
lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x129: call =
to do_strncpy_from_user() with UACCESS enabled
vmlinux.o: warning: objtool: mce_start()+0x5c: call to __kasan_check_write(=
) leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode.con=
stprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_read_aux()+0x8a: call to mca_msr_reg() lea=
ves .noinstr.text section
vmlinux.o: warning: objtool: do_machine_check()+0x192: call to mce_no_way_o=
ut() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_severity_amd.constprop.0()+0xca: call to m=
ce_severity_amd_smca() leaves .noinstr.text section

I am not sure which changes caused the above.

--=20
Cheers,
Stephen Rothwell

--Sig_/b3cpkwV.TnqU4jRVh1q/2Rg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG8BpQACgkQAVBC80lX
0GwXvAf+Pu1oO34pCUZS6SEXFaYlYap5zQJE7sal/pVTUgfgESBq8s923SnPSftr
dOUpj76q8UI2QduSIczMkd6/X2DhWCyYC5wp6HzYcRIw96Kc11515nAO0XQkV0TC
SWgQ/f/qSERwfwon0DUurJnr2ACBse1pCILWu9tkJP8DaZPg5CWlGvXpnPvMQ1tQ
Xlk7B5FjHioD7k1J16gY86HmXzzlTUq41RGq0q5fSk18ziVrPqC5kamUgdAzp/gE
JezjmDpIluJ3uFEiddw82JvMz6hPh85tQB/RuOzHfXFVv9+0rtKPFWSFLObfUmnL
2zzHTnqfHBS8lCFI/5JXFZewtkd2nA==
=02Ab
-----END PGP SIGNATURE-----

--Sig_/b3cpkwV.TnqU4jRVh1q/2Rg--
