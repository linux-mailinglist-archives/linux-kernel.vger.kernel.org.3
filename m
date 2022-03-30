Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B704EB798
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbiC3A6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiC3A6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:58:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC91A19B0B5;
        Tue, 29 Mar 2022 17:56:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KSp0L1YL1z4xXS;
        Wed, 30 Mar 2022 11:56:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648601780;
        bh=q9ispVHQZsP/kWZG11ABn0H1jP7mArtgDdqW0V4HNqk=;
        h=Date:From:To:Cc:Subject:From;
        b=TZCNrKq0WJSwTw++aIdVCIVQDmpCewCy8v3eGY6z7d+lmOG1D1z3q369Xrkl1gApL
         2dpdJyH/sGsDKa93Qmo9Mj+ulSBObt/m22NqJ+/qEBea7rYbkzfKmQI26XEwq5xbws
         3MUJ96TzW3tLj03mQHV2vmqkXywLQJc4V2SDSIulN6KVtp7PMVBcwFRpQOBIfemLcJ
         JvBigAS/+bNUSNUQcYWi7FWPYHSr2vMLRa/O1gY6O2xTaXyUpchi2gexGahfODJTRW
         c7fcCY5IrLRRZPm++iZgAxex+Ml9tftOG+MyHOvGy4TBlxjf3SFYgNrM30WVzCGzgf
         vM+USRJaGJjaA==
Date:   Wed, 30 Mar 2022 11:56:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Wei Xiao <xiaowei66@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sysctl tree
Message-ID: <20220330115617.4d694d11@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/utDjZbC=jwOONQinnZoZiXR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/utDjZbC=jwOONQinnZoZiXR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sysctl tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

kernel/sysctl.c:1776:36: error: 'C_A_D' undeclared here (not in a function)
 1776 |                 .data           =3D &C_A_D,
      |                                    ^~~~~

Caused by commit

  84053cc7ef2f ("ftrace: move sysctl_ftrace_enabled to ftrace.c")

I can't imagine how that happened (though I do note that the whole branch
has been rebased and not tested :-( ).

I have used the sysctl tree from next-20220329 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/utDjZbC=jwOONQinnZoZiXR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJDqrEACgkQAVBC80lX
0Gw70gf+N0DGEz2TeLx060lK9dFhP15qdUGpnTc5wCbJX9QRNYK93zx+Ehxcn0KM
RZAvbq3RsSv38WHbjKhkNi4zZaS9L92RVJsz61CXKOJ7n/qTgZRjfaqFY4srsPGb
paZdgf/u6ijZPBcVBQ9S04EPFVyfgOwP2BQk0udpPSEgW9/Fc4rpYyEbdBQmnGPh
zz/s2t28HVla3NjnlIkcxHp1KCSGdKRTY+kl1h/BGYCmGAopIFWebY6N9U0/dTOg
0vDz418Lm2muskzzxPUBTX4G5rWqWAgJRTRaen1WvvvDUrW+6zJ5q907CurSYQWl
gLveRZeaFsgb9X0pP6BI/3poZDCb4A==
=fTKK
-----END PGP SIGNATURE-----

--Sig_/utDjZbC=jwOONQinnZoZiXR--
