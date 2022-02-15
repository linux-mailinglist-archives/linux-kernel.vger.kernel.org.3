Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505234B63BC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiBOGob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:44:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiBOGo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:44:29 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC027C24A3;
        Mon, 14 Feb 2022 22:44:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyWlg0BXtz4xcY;
        Tue, 15 Feb 2022 17:44:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644907455;
        bh=Me7gKSD/eykmW/PwyxtAO5OSQgVRSm8H5mAjaHBSKYY=;
        h=Date:From:To:Cc:Subject:From;
        b=lZpY04WCqpDSXnaqdlm8JOEYwNY7DzdhvRAvBJdqlBIgYD4SwmVir80xi/t/ZehMQ
         kkzuRRkQPcnJ6IiiRdKcxVUR9YSuk9jdBr95OvVgMajFSj/PivpZ+jThjc+HI8E75b
         GuP6nWdxEQLB1M6fiuMaTQ8UGvJXXEu8IpcHiVDProjL6u53KLcPRGycD4weLo36/W
         aULgfChR6doY9OzXdW9UOX1I/nqUEsgvWCUGxp9mXGcAL1rU5R4zrnUJSrmnPRfv8N
         et7O/oLJRFbBBClPhmfnWvnZIbRpw7JafgjierNPoR0zpugGnNTpLr1Xi7oYU3rqp/
         rnFrcDydaiV8w==
Date:   Tue, 15 Feb 2022 17:44:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the folio tree
Message-ID: <20220215174411.49e1d3ba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//UaxFjjj36yAv0OYS9D1ELy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//UaxFjjj36yAv0OYS9D1ELy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the folio tree, today's linux-next build (sparc defconfig)
failed like this:

mm/page_vma_mapped.c: In function 'page_vma_mapped_walk':
mm/page_vma_mapped.c:219:48: error: implicit declaration of function 'pmd_p=
fn'; did you mean 'pmd_off'? [-Werror=3Dimplicit-function-declaration]
  219 |                                 if (!check_pmd(pmd_pfn(pmde), pvmw))
      |                                                ^~~~~~~
      |                                                pmd_off


Caused by commit

  b1dede582893 ("mm: Convert page_vma_mapped_walk to work on PFNs")

I applied the following hack just to make it build:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 15 Feb 2022 17:15:48 +1100
Subject: [PATCH] fix up for "mm: Convert page_vma_mapped_walk to work on PF=
Ns"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/include/asm/pgtable_32.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/p=
gtable_32.h
index ffccfe3b22ed..30d55a37515d 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -424,6 +424,13 @@ static inline int io_remap_pfn_range(struct vm_area_st=
ruct *vma,
 	__changed;							  \
 })
=20
+static inline unsigned long pmd_pfn(pmd_t pmd)
+{
+	pte_t pte =3D __pte(pmd_val(pmd));
+
+	return pte_pfn(pte);
+}
+
 #endif /* !(__ASSEMBLY__) */
=20
 #define VMALLOC_START           _AC(0xfe600000,UL)
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_//UaxFjjj36yAv0OYS9D1ELy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmILS7sACgkQAVBC80lX
0Gw7kQf+IGSmrnK0XCUqcNQZ7RMYTMRCGyc4OTiXc8fsyYOjBsCKQjNbJzqawYgE
UBuDmrmdnTBKgukq3AoF0xWYumO3TTB98RZ/Mt3MpOmW8brdGFhXxDQfSeEnys1/
NZ/wrVug2f7mTCkuof5VMnRk0Gz987h0PeJMgWSssJrV6II1wSAt3uUrjRkd7aL+
DWc+xVsl2oq8pgdy/M7vmlm47G5opAhqNoDC6CYZrC3v3f9NYbJiSplBExnlpEs+
ugvuQPonxZhY0Jwk6ODQev4N9maueuHFHJ08QEJ03cO7CzcDHRKwyRR00PuAFT1v
JbLtcqqx3psaFbn4owuKvqEyMM4TzA==
=sy8j
-----END PGP SIGNATURE-----

--Sig_//UaxFjjj36yAv0OYS9D1ELy--
