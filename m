Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E78A49FB22
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiA1N6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:58:33 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43218 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231741AbiA1N6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:58:32 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20SB53ff008036;
        Fri, 28 Jan 2022 05:58:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=dpHLngKpzeSUefPC+0h4EN3iJnANrfkMo9Dxfn4BYrI=;
 b=kr85X4gV9SaMMjyF0ZVhjgslFHntjRqIf3ATl1JygFuOc95vZDUdtnlNYpKHPAYnVHPC
 F0QSP6J7gFVAI3M+sw/62X/y9h5el5CtwR4DYKT3gJ72asoHsa8ZnqJ08gdweswj6V0X
 Y6GfA3pfVocAbr4Tj2yyll80NvVfSbQC8zSfQvD3LkiMnSssFEdXpD9a7oySRJKGdazr
 XfxAJNHJQ+0TytXWQx7HBRdMd0uH4hmGgxwrqKd+Jb4xjbDWNMA4OxunsGjdb0Tf7KYv
 5odonp0Emo2FDYtrqnZNS+ixRpXUtKO1fzsXbjoUzF3U2f9WE1x8PBHBV8xf+bY+df1p 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dusebmugt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 05:58:23 -0800
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20SDqAnB004714;
        Fri, 28 Jan 2022 05:58:22 -0800
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dusebmugn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 05:58:22 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 Jan
 2022 05:58:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 28 Jan 2022 05:58:20 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
        by maili.marvell.com (Postfix) with ESMTP id 724323F706F;
        Fri, 28 Jan 2022 05:58:15 -0800 (PST)
From:   Shijith Thotton <sthotton@marvell.com>
To:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     Shijith Thotton <sthotton@marvell.com>,
        <linux-crypto@vger.kernel.org>, <jerinj@marvell.com>,
        <sgoutham@marvell.com>, <anoobj@marvell.com>,
        "Srujana Challa" <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Ovidiu Panait" <ovidiu.panait@windriver.com>,
        chiminghao <chi.minghao@zte.com.cn>,
        Suheil Chandran <schandran@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] crypto: octeontx2: remove CONFIG_DM_CRYPT check
Date:   Fri, 28 Jan 2022 19:27:42 +0530
Message-ID: <2ea465e8bde7f4d03757ae398d38f62a350dd28c.1643378034.git.sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3ef09bf0c4adf7bc33f01f60cb8ce96e8f77b58c.1642786900.git.sthotton@marvell.com>
References: <3ef09bf0c4adf7bc33f01f60cb8ce96e8f77b58c.1642786900.git.sthotton@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uu0_W5SP2KJD5K_e5La4MF_ZAQtB5Kx_
X-Proofpoint-GUID: m9vOcveRtMH810eaaRkxxo3sKUaOzXZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_04,2022-01-27_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No issues were found while using the driver with dm-crypt enabled. So
CONFIG_DM_CRYPT check in the driver can be removed.

This also fixes the NULL pointer dereference in driver release if
CONFIG_DM_CRYPT is enabled.

...
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
...
Call trace:
 crypto_unregister_alg+0x68/0xfc
 crypto_unregister_skciphers+0x44/0x60
 otx2_cpt_crypto_exit+0x100/0x1a0
 otx2_cptvf_remove+0xf8/0x200
 pci_device_remove+0x3c/0xd4
 __device_release_driver+0x188/0x234
 device_release_driver+0x2c/0x4c
...

Fixes: 6f03f0e8b6c8 ("crypto: octeontx2 - register with linux crypto framework")
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 .../crypto/marvell/octeontx2/otx2_cptvf_algs.c  | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
index 2748a3327e39..f8f8542ce3e4 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
@@ -1634,16 +1634,13 @@ static inline int cpt_register_algs(void)
 {
 	int i, err = 0;
 
-	if (!IS_ENABLED(CONFIG_DM_CRYPT)) {
-		for (i = 0; i < ARRAY_SIZE(otx2_cpt_skciphers); i++)
-			otx2_cpt_skciphers[i].base.cra_flags &=
-							~CRYPTO_ALG_DEAD;
-
-		err = crypto_register_skciphers(otx2_cpt_skciphers,
-						ARRAY_SIZE(otx2_cpt_skciphers));
-		if (err)
-			return err;
-	}
+	for (i = 0; i < ARRAY_SIZE(otx2_cpt_skciphers); i++)
+		otx2_cpt_skciphers[i].base.cra_flags &= ~CRYPTO_ALG_DEAD;
+
+	err = crypto_register_skciphers(otx2_cpt_skciphers,
+					ARRAY_SIZE(otx2_cpt_skciphers));
+	if (err)
+		return err;
 
 	for (i = 0; i < ARRAY_SIZE(otx2_cpt_aeads); i++)
 		otx2_cpt_aeads[i].base.cra_flags &= ~CRYPTO_ALG_DEAD;
-- 
2.25.1

