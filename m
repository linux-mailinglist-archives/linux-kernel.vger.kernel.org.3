Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4351952E949
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347917AbiETJqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244958AbiETJqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:46:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03660328;
        Fri, 20 May 2022 02:46:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L4MLl1wQBz4xDK;
        Fri, 20 May 2022 19:46:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653040000;
        bh=UdX0I3S31U4Zq+mgg99EGlxgpDh9JmkS37nsxtBDFIQ=;
        h=Date:From:To:Cc:Subject:From;
        b=IGKTJKRMAdfBREvqln3jTPMS3OccS9zWfTh3TIJ0nlnaB/P8I/p6HW/DCW+XBJbuk
         VUouuId7y7lckOJGfMlIR/IUDCoKKtKVt80JBe00YYywBcT42k2hrIfMQmSsoBPw0+
         6A7WeoULlOeu7zTx8icQhmm5njSaCN3jNw7dAPNIo9RXbPe++K+udAo+AOropQ1QSg
         Hig4s1hcJLMtdlYmg1IsZ9PEPPEZaCxvymqbTRLZZjNRd3UgV3gX02+8mutqXb4CwJ
         zkT3OQevDVD5mxJeD83DWJnzymCgZnIiwN4Hx5mdcUbstkmuiI8NN2Zy6gn35jc9Wu
         ankyXPmPU5uLw==
Date:   Fri, 20 May 2022 19:46:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the char-misc tree
Message-ID: <20220520194637.03824f7f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i4CIhAztvp3LxxFc+knzPA+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i4CIhAztvp3LxxFc+knzPA+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the soundwire tree, today's linux-next build (x86_64
allmodconfig) failed like this:

make[4]: *** Deleting file 'drivers/accessibility/speakup/mapdata.h'
can't open ./include/linux/input.h
make[4]: *** [/home/sfr/next/next/drivers/accessibility/speakup/Makefile:46=
: drivers/accessibility/speakup/mapdata.h] Error 1
make[3]: *** [/home/sfr/next/next/scripts/Makefile.build:542: drivers/acces=
sibility/speakup] Error 2

Caused by commit

  6646b95aab5f ("speakup: Generate speakupmap.h automatically")

I have used the char-misc tree from next-20220519 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/i4CIhAztvp3LxxFc+knzPA+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKHY30ACgkQAVBC80lX
0GyKSQf/V4H1+pqw22P4eNQPHNkgTmIFlNx8k6uYJ0eCDeAXtv+ni/A+N2Oh9t3n
iEonVw0NJ3JRTmFm0Y1zSL82xkeAdaRpXp/ZkAMf52mwhc9EpQsvF1Q/6wXSNySf
xmLMDQraBooQT2ET3+U+vM8KPja4ql1qVufCDDjt7pTUa6Hh1Pcsm+uVaKp9Zx22
b6RIz40cGPcwg7zygJdlDVJS6KGboyoUZyYB23WxNU6XSsS6o0Qq0TIttDG6cBsF
jV5vOMGC2GONcDnjj+BHWOsfpnN9Vnm8nk8gAtMttytAObdiJTg4qtm8DCVamRnJ
sEDo132deuWMGKTjZGuPrtlFHNO74Q==
=kmCz
-----END PGP SIGNATURE-----

--Sig_/i4CIhAztvp3LxxFc+knzPA+--
