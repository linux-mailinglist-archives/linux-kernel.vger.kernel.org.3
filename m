Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D1E4F0711
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 05:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiDCDJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 23:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiDCDI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 23:08:56 -0400
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 20:06:50 PDT
Received: from mail.tintel.eu (mail.tintel.eu [51.83.127.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB97E38DAF;
        Sat,  2 Apr 2022 20:06:50 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id 93436443B963;
        Sun,  3 Apr 2022 04:59:52 +0200 (CEST)
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id CuXfQFQux2ea; Sun,  3 Apr 2022 04:59:52 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id 1A5EC4407628;
        Sun,  3 Apr 2022 04:59:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.tintel.eu 1A5EC4407628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux-ipv6.be;
        s=502B7754-045F-11E5-BBC5-64595FD46BE8; t=1648954792;
        bh=NB63kV2iVRK0aO2l931FJgETcLzKN2fr5wWYFpZPrSc=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=kROjGDT/7E7FhZEkku8DfmNfFhQvb4rAgv50wdx5dEAuxonn8MOytFygXbZ9Io2nL
         cPzXN3MJ0CcaDQBqMaMLPgN6hjkNPbFoRcIo92Be1rQV13aPXAfAvWgx1GgqHIJMvN
         9197vEj+dUIha/mZH1cX0PZOouqxQQRlBTAXqoiQ=
X-Virus-Scanned: amavisd-new at mail.tintel.eu
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id YkEFaBaNcsiX; Sun,  3 Apr 2022 04:59:52 +0200 (CEST)
Received: from taz.sof.bg.adlevio.net (unknown [IPv6:2001:67c:21bc:20::10])
        by mail.tintel.eu (Postfix) with ESMTPS id BF5E0443A8BC;
        Sun,  3 Apr 2022 04:59:51 +0200 (CEST)
From:   Stijn Tintel <stijn@linux-ipv6.be>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MIPS: Octeon: fix CN6640 hang on XAUI init
Date:   Sun,  3 Apr 2022 05:59:49 +0300
Message-Id: <20220403025950.837085-1-stijn@linux-ipv6.be>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: IP_WHITELIST
X-Rspamd-Queue-Id: BF5E0443A8BC
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: IP_WHITELIST
X-Spamd-Result: default: False [0.00 / 15.00];
        IP_WHITELIST(0.00)[2001:67c:21bc:20::10];
        ASN(0.00)[asn:200533, ipnet:2001:67c:21bc::/48, country:BG]
X-Rspamd-Server: skulls
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some CN66XX series Octeon II chips seem to hang if a reset is issued on
XAUI initialization. Avoid the hang by disabling the reset.

Tested on SNIC10E.

Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/=
mips/cavium-octeon/executive/cvmx-helper-xaui.c
index fea71a85bb29..a92632223497 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -156,8 +156,9 @@ int __cvmx_helper_xaui_enable(int interface)
 	xauiCtl.u64 =3D cvmx_read_csr(CVMX_PCSXX_CONTROL1_REG(interface));
 	xauiCtl.s.lo_pwr =3D 0;
=20
-	/* Issuing a reset here seems to hang some CN68XX chips. */
-	if (!OCTEON_IS_MODEL(OCTEON_CN68XX_PASS1_X) &&
+	/* Issuing a reset here seems to hang some CN66XX/CN68XX chips. */
+	if (!OCTEON_IS_MODEL(OCTEON_CN66XX) &&
+	    !OCTEON_IS_MODEL(OCTEON_CN68XX_PASS1_X) &&
 	    !OCTEON_IS_MODEL(OCTEON_CN68XX_PASS2_X))
 		xauiCtl.s.reset =3D 1;
=20
--=20
2.35.1

