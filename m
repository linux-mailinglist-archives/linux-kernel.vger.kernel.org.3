Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21B84C6F90
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiB1Od4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiB1Ody (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:33:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED6275CE;
        Mon, 28 Feb 2022 06:33:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6jXj0ckNz4xmt;
        Tue,  1 Mar 2022 01:33:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646058789;
        bh=W8JBmFB98etfgpQuvLuN/JdQL3ZK1zpIWNU9xCD+EUs=;
        h=Date:From:To:Cc:Subject:From;
        b=XtKP8n9wZ2mnHrEes/FmITjGnWjGb66NNveIUv7qY5pyzcXHLbH2x/r4lDISJn0Yr
         RwF525MG2bsLtXQ7VAMjFM0OoAvdhGxuedhxC8Mb3ilHEgjMcV8cwF6M7LpMLVxPmG
         NNu87yfAw76nNpFWUfQLH1kXAl5vmkANFPYoPdMKAefklc6vTx2dwbjFVvXX2hSVYk
         FhmcEWxWWgN5HMf3+0Egred9RsFjqldcJbvkkDCI5xrLAFaOBW6IWUiIy1ospEt6BJ
         oJMAKZcpwMajwuK5MBkCkp/zoPCb0NnMgJ6bKjrbZL4ALorNa8NCE9KAI76uVnYMIO
         s9w1pxji1cmOA==
Date:   Tue, 1 Mar 2022 01:33:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20220301013308.5a91c6a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8QAGid8aQOLPe+jd+onInlp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8QAGid8aQOLPe+jd+onInlp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

mm/rmap.c: In function 'try_to_migrate_one':
mm/rmap.c:1870:64: error: 'page' undeclared (first use in this function)
 1870 |                                                 compound_order(page=
));
      |                                                                ^~~~
mm/rmap.c:1870:64: note: each undeclared identifier is reported only once f=
or each function it appears in

Caused by commit

  e05239e90b65 ("mm/migration: add trace events for base page and HugeTLB m=
igrations")

inertacting with commit

  efe8a99f35f6 ("mm/rmap: Convert rmap_walk() to take a folio")

from the folio tree.

I have reverted commit e05239e90b65 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/8QAGid8aQOLPe+jd+onInlp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIc3SQACgkQAVBC80lX
0GyDOAf+JaesLaGKc5Xn8DLm0u+CPw//91quz18MjfwUVHZDdaMeDE8T1WMmf8p3
P55hjGRLEkniu8Hq4H79l+2mjP/mILEzwSlVmLkgBUxLxZ/SP16M/zQ7i4MtpfYN
cDxVJPdc+KNcT76N/2l2khJ5uv8DGSOty/RiV1jUnFc33ib3IGdJTyyPF52bd9KT
lUGgqAixr3agfbnr/lN0PT8g9MkXFFt9DHohIi55iKUpn2lV/ewysjIIiRqYdvnB
cRn8Lm4LjzwNQ2mMh3DQb9cW+0OV+OY917m748OoAaccODbwxnOVhZEcvbSext9D
7DKaMefwfBIkFCeinCXGXZaT1eK2Tw==
=pRp5
-----END PGP SIGNATURE-----

--Sig_/8QAGid8aQOLPe+jd+onInlp--
