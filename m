Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFEA52E68A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346623AbiETHuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiETHuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:50:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6E3E27A3;
        Fri, 20 May 2022 00:49:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L4Jm41GMXz4xD8;
        Fri, 20 May 2022 17:49:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653032997;
        bh=QT7x01Q92I85+kgNTbeXkiQbH8g+BwQhn0R2E/EfRcA=;
        h=Date:From:To:Cc:Subject:From;
        b=lDTuarZzogEy92HG42We4tH1yU3B+VDG9GBfg5CwiiMunIu0B79Reo5O6j2zIQbKe
         i7Sv01xwiUOhG2p9LkID3A6l7l0F5jW+8Wrx4RleZDwaIMjCitqsaE56a7CsbyE6dn
         SI3v10e5CGN7Ck1KAa2L8SD0TLi4cnLATA2+vnazgFe5nW+Qg1XEemHw7k3ucMlgFa
         ltt4zN+wLNl9xiboLADlhX76gbVOPUI9hE1SzQcshVyickVRevvkMBVCtl2rFSCxD/
         osY4AQaM3iVKSkpVyMFEAKuxm3XiCc1fMx0kOJrSeSvVBm15KfOSDHXURtkZWjKZ/M
         6GJBHogJX/LvA==
Date:   Fri, 20 May 2022 17:49:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tip tree
Message-ID: <20220520174954.1c306fc0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ByX/JcQufY.VzC6DVEQ_.av";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ByX/JcQufY.VzC6DVEQ_.av
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
produced these warnings:

vmlinux.o: warning: objtool: vc_switch_off_ist+0x76: relocation to !ENDBR: =
entry_SYSCALL_64+0x15c
vmlinux.o: warning: objtool: vc_switch_off_ist+0x8e: relocation to !ENDBR: =
entry_SYSCALL_compat+0xa5
vmlinux.o: warning: objtool: vc_switch_off_ist+0x96: relocation to !ENDBR: =
.entry.text+0x21ca
vmlinux.o: warning: objtool: vc_switch_off_ist+0xee: relocation to !ENDBR: =
.entry.text+0x162
vmlinux.o: warning: objtool: __sev_es_ist_enter+0x5f: relocation to !ENDBR:=
 entry_SYSCALL_64+0x15c
vmlinux.o: warning: objtool: __sev_es_ist_enter+0x6b: relocation to !ENDBR:=
 .entry.text+0x162
vmlinux.o: warning: objtool: __sev_es_ist_enter+0x89: relocation to !ENDBR:=
 entry_SYSCALL_compat+0xa5
vmlinux.o: warning: objtool: __sev_es_ist_enter+0xc0: relocation to !ENDBR:=
 .entry.text+0x21ca

I don't know what caused this.

--=20
Cheers,
Stephen Rothwell

--Sig_/ByX/JcQufY.VzC6DVEQ_.av
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKHSCIACgkQAVBC80lX
0GxJ+gf/fmbXQ/4JX81E4Y/cpAhHHtDpN79i2p2Ebe9oOP3IE5ga+Mtv48328xmb
CvkDikw0xLI9YS7YdjbWbjsvIluDf7+UA91orivpreXkOnm2c6m301RpxR3nKSQS
oZvNPb5ICcK0isY4eyVVAOsCmgiQb5/A5f+Mr7frdrUrNb1hJeuJsHqx9Lt0x7rN
RzMCCaeUp959l/IWutSd6Ky2t/IU5rBgd7gI9qogfIUOERDQe7+5Hzv5CyMggMjW
/vHWYBeI35uqoADdrUdwspj0LVt+RD2+Zq9bvrFBQzkQjo8jy7ItbMTZ6ExKx0kd
pjimrmWrNFBmqA7Ac1jYAg2vu6YsBg==
=x856
-----END PGP SIGNATURE-----

--Sig_/ByX/JcQufY.VzC6DVEQ_.av--
