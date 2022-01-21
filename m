Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A8C496061
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380984AbiAUOFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:05:05 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:32358 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1380986AbiAUOEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:04:32 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LAASLt015148;
        Fri, 21 Jan 2022 06:04:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=E6656S2D8v2JjAZAXSy/62KUS+Okbjyp/3Dlv5zadkk=;
 b=W9a+YgL8pF7GsPGicJyl7/3/0o/Dk3qTPAI6YCChpdOMR2gROgZcA30/nIE9gtee4k4v
 nbpRbjda9lkO7Ctht5W9/qo6btysECQeOG8W49koxA9s+lBY/LEa0IyYa2HKynhYs6Fg
 psdrK76tzCeTEHqOkiA/XsgLntFTV71fujDLsGvQp669y135pce53Xzv4wHvcy7YVDRA
 KgZqVv98APGZt5NQGSZUAcXf0sbssVq0vIERnSfXqgDi/Dg3QC4dy9Z0oV1x+mrB7hqO
 Acw+q3VmuMV0GWbsspIYlBJFIv8b9S+yIZZWAbevrH9tUXvNvZzVH9T2R7Yn0gDo+cGC 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3dqhytt7u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 06:04:23 -0800
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20LDifah013909;
        Fri, 21 Jan 2022 06:04:22 -0800
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3dqhytt7u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 06:04:22 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 21 Jan
 2022 06:04:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 21 Jan 2022 06:04:21 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
        by maili.marvell.com (Postfix) with ESMTP id C26403F70B7;
        Fri, 21 Jan 2022 06:04:16 -0800 (PST)
From:   Shijith Thotton <sthotton@marvell.com>
To:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     Shijith Thotton <sthotton@marvell.com>,
        <linux-crypto@vger.kernel.org>, <jerinj@marvell.com>,
        <sgoutham@marvell.com>, Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Lukasz Bartosik" <lbartosik@marvell.com>,
        Suheil Chandran <schandran@marvell.com>,
        chiminghao <chi.minghao@zte.com.cn>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: octeontx2: fix NULL pointer dereference
Date:   Fri, 21 Jan 2022 19:33:10 +0530
Message-ID: <3ff70ee925aad3afa1adc4ad1f4a7a494929d400.1642773756.git.sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Zo-svCzrrA672kxN1-Yc_IEylYeN4Oz4
X-Proofpoint-GUID: cPup4_Sb39qjQfrLoMdWJVRB3POsKrqm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-21_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DM_CRYPT is checked before registering ciphers, but not before
unregister. This could lead to a NULL pointer dereference during driver
release (in unregister) if CONFIG_DM_CRYPT is enabled.

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

Added a CONFIG_DM_CRYPT check, similar to register, in unregister to
avoid this.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
index 2748a3327e39..620fa9b23e78 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
@@ -1650,7 +1650,7 @@ static inline int cpt_register_algs(void)
 
 	err = crypto_register_aeads(otx2_cpt_aeads,
 				    ARRAY_SIZE(otx2_cpt_aeads));
-	if (err) {
+	if (err && !IS_ENABLED(CONFIG_DM_CRYPT)) {
 		crypto_unregister_skciphers(otx2_cpt_skciphers,
 					    ARRAY_SIZE(otx2_cpt_skciphers));
 		return err;
@@ -1661,8 +1661,9 @@ static inline int cpt_register_algs(void)
 
 static inline void cpt_unregister_algs(void)
 {
-	crypto_unregister_skciphers(otx2_cpt_skciphers,
-				    ARRAY_SIZE(otx2_cpt_skciphers));
+	if (!IS_ENABLED(CONFIG_DM_CRYPT))
+		crypto_unregister_skciphers(otx2_cpt_skciphers,
+					    ARRAY_SIZE(otx2_cpt_skciphers));
 	crypto_unregister_aeads(otx2_cpt_aeads, ARRAY_SIZE(otx2_cpt_aeads));
 }
 
-- 
2.25.1

