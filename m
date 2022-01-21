Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6DE49645B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351846AbiAURoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:44:04 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:14372 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239311AbiAURoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:44:02 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LAHDBc029276;
        Fri, 21 Jan 2022 09:43:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Hnkix26dB7dgPESASXxF1i0pv7jnm1c9dtXBbWPYVcE=;
 b=KLHovAyNE6av5OXWA6fal0yS0jBi4j+doUeXaSkgpUzFq6rPxyK34zRqIs+GTMxHMkkj
 R59gNK0DwQaRN5rZNSSzuic2jh3ZuEWmImwiuofTUHZj/W+ugxSMTFS4/EhkqbYR3Zby
 Dk5ekkjKIHpwwrUqkr/PzruEDYuXR1WJHefYqpgkY3hvcaMew2h3wrg+vuxdFvAR+N/L
 r7W+xC2PMHKl3wi3qAUntgTKMA3iGBEWq4ZiVm9QLufjpVEX5Q6Zf1kaAfyaQzMcM4U8
 H2Un1A1STe9L7FvvdKBg1JpurjA53H+HT02gQJ5ek+FYyGIXXVqU7HmHQmw2ZrV3KVIL Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dqj05jw27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 09:43:49 -0800
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20LHbGkC021851;
        Fri, 21 Jan 2022 09:43:49 -0800
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dqj05jw23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 09:43:48 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 21 Jan
 2022 09:43:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 21 Jan 2022 09:43:46 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
        by maili.marvell.com (Postfix) with ESMTP id 8EEA33F70A1;
        Fri, 21 Jan 2022 09:43:42 -0800 (PST)
From:   Shijith Thotton <sthotton@marvell.com>
To:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     Shijith Thotton <sthotton@marvell.com>,
        <linux-crypto@vger.kernel.org>, <jerinj@marvell.com>,
        <sgoutham@marvell.com>, Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        chiminghao <chi.minghao@zte.com.cn>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        "Suheil Chandran" <schandran@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] crypto: octeontx2: fix NULL pointer dereference
Date:   Fri, 21 Jan 2022 23:13:23 +0530
Message-ID: <3ef09bf0c4adf7bc33f01f60cb8ce96e8f77b58c.1642786900.git.sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3ff70ee925aad3afa1adc4ad1f4a7a494929d400.1642773756.git.sthotton@marvell.com>
References: <3ff70ee925aad3afa1adc4ad1f4a7a494929d400.1642773756.git.sthotton@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Va0f9547P-r80JbcPiW8guMOVHxl2ZDU
X-Proofpoint-ORIG-GUID: cbe3lamZNG3loXYPqGV06Tp3x0cDp6Yr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_09,2022-01-21_01,2021-12-02_01
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

Fixes: 6f03f0e8b6c8 ("crypto: octeontx2 - register with linux crypto framework")

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
v2:
- Added fixes line to commit message.

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

