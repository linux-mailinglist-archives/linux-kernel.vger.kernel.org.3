Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0FA535AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242605AbiE0IDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348313AbiE0IDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:03:36 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB563FF58A;
        Fri, 27 May 2022 01:03:31 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R6eshZ013603;
        Fri, 27 May 2022 00:57:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=VDnFvteMFLJMKe8wl7YI99gfac2Lg0oXYmlxdZuYXzk=;
 b=ee7IpkFNMEp+qJnCYldxmTbQZ5xpiyOq8f8JkUt1t/PPTRdZ96nVRvsRTgKvAEbkdZ/p
 4XHMBHbIksogizVyfdtY+rstpfA/QynX7hJ8fQ2r0hkY+fQciPz50yPBykEeLTmT3xh3
 otdXTx3W3TB7jYwoyGdSKBahKMnD3D8vN3yx4M10+BpR0hp2fmpS70nt3DDjkZU0o3Kz
 K4e6RnDyWj2riPWNC7u1gX14wXZ4WPhQE88Z9W7olU+TX7lLf1oD/FJGd69YfI3gidlI
 2hDpxdnF2PDACvcOjftVAB/mBDo+1lDS8AVM4Bj2IgBYpYvG/0tN9z+Hce+uEeDMceex Tw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3gaf2rtjrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 00:57:43 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 May
 2022 00:57:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 May 2022 00:57:41 -0700
Received: from localhost.localdomain (unknown [10.28.34.29])
        by maili.marvell.com (Postfix) with ESMTP id DE1333F706A;
        Fri, 27 May 2022 00:57:38 -0700 (PDT)
From:   Shijith Thotton <sthotton@marvell.com>
To:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     Shijith Thotton <sthotton@marvell.com>,
        <linux-crypto@vger.kernel.org>, <jerinj@marvell.com>,
        <sgoutham@marvell.com>, Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: octeontx2: add firmware version in devlink info
Date:   Fri, 27 May 2022 13:24:48 +0530
Message-ID: <421b1fbe94a82e678887260f768478c11daa1e32.1653589007.git.sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TF_yE3dCLGnInHXZU6UkxIyt7jjnZ3uT
X-Proofpoint-GUID: TF_yE3dCLGnInHXZU6UkxIyt7jjnZ3uT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_02,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added running firmware version information of AE, SE and IE components
in devlink info.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 .../marvell/octeontx2/otx2_cpt_devlink.c      | 40 ++++++++++++++++++-
 .../marvell/octeontx2/otx2_cptpf_ucode.c      |  2 +-
 .../marvell/octeontx2/otx2_cptpf_ucode.h      |  3 ++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c b/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
index bb02e0db3615..7503f6b18ac5 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
@@ -51,11 +51,47 @@ static const struct devlink_param otx2_cpt_dl_params[] = {
 			     NULL),
 };
 
-static int otx2_cpt_devlink_info_get(struct devlink *devlink,
+static int otx2_cpt_dl_info_firmware_version_put(struct devlink_info_req *req,
+						 struct otx2_cpt_eng_grp_info grp[],
+						 const char *ver_name, int eng_type)
+{
+	struct otx2_cpt_engs_rsvd *eng;
+	int i;
+
+	for (i = 0; i < OTX2_CPT_MAX_ENGINE_GROUPS; i++) {
+		eng = find_engines_by_type(&grp[i], eng_type);
+		if (eng)
+			return devlink_info_version_running_put(req, ver_name,
+								eng->ucode->ver_str);
+	}
+
+	return 0;
+}
+
+static int otx2_cpt_devlink_info_get(struct devlink *dl,
 				     struct devlink_info_req *req,
 				     struct netlink_ext_ack *extack)
 {
-	return devlink_info_driver_name_put(req, "rvu_cptpf");
+	struct otx2_cpt_devlink *cpt_dl = devlink_priv(dl);
+	struct otx2_cptpf_dev *cptpf = cpt_dl->cptpf;
+	int err;
+
+	err = devlink_info_driver_name_put(req, "rvu_cptpf");
+	if (err)
+		return err;
+
+	err = otx2_cpt_dl_info_firmware_version_put(req, cptpf->eng_grps.grp,
+						    "fw.ae", OTX2_CPT_AE_TYPES);
+	if (err)
+		return err;
+
+	err = otx2_cpt_dl_info_firmware_version_put(req, cptpf->eng_grps.grp,
+						    "fw.se", OTX2_CPT_SE_TYPES);
+	if (err)
+		return err;
+
+	return otx2_cpt_dl_info_firmware_version_put(req, cptpf->eng_grps.grp,
+						    "fw.ie", OTX2_CPT_IE_TYPES);
 }
 
 static const struct devlink_ops otx2_cpt_devlink_ops = {
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 9cba2f714c7e..46ffb7ae982c 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -476,7 +476,7 @@ static int cpt_ucode_load_fw(struct pci_dev *pdev, struct fw_info_t *fw_info)
 	return ret;
 }
 
-static struct otx2_cpt_engs_rsvd *find_engines_by_type(
+struct otx2_cpt_engs_rsvd *find_engines_by_type(
 					struct otx2_cpt_eng_grp_info *eng_grp,
 					int eng_type)
 {
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.h b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.h
index 8f4d4e5f531a..e69320a54b5d 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.h
@@ -166,4 +166,7 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 int otx2_cpt_dl_custom_egrp_delete(struct otx2_cptpf_dev *cptpf,
 				   struct devlink_param_gset_ctx *ctx);
 void otx2_cpt_print_uc_dbg_info(struct otx2_cptpf_dev *cptpf);
+struct otx2_cpt_engs_rsvd *find_engines_by_type(
+					struct otx2_cpt_eng_grp_info *eng_grp,
+					int eng_type);
 #endif /* __OTX2_CPTPF_UCODE_H */
-- 
2.25.1

