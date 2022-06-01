Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E22B539F10
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350542AbiFAIK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350574AbiFAIJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:09:58 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD04356436;
        Wed,  1 Jun 2022 01:09:57 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VMJRSr007355;
        Wed, 1 Jun 2022 01:09:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=sQSNY7RRz2Ap5IH2BMIUKIP53aA2GrvaUEc+gCJvoic=;
 b=UkYTrhtnLNGcf3Pa0WqEllPq4mMvPTzIfU3kpUF8LQChlbboiVMwxCjYk74cP75fSS+c
 KEAmMy+ykFp4C8BDwuoo3gXpdCDtBGTY98aX1ogcJ+c8MoKGK9HfDxNDuSSVqu7ABuf1
 cUxzu0yvqzPVnapzB1KE7qra3f9p4FFgBkZWipzbrpblhBtxYu1iIBB4iICRa/9BvX/S
 /dRC0h88zFhLNO3UlRwdSSq8BWaF4zDw60TqyPwMfA7SpwhwRVUz2vJ6I4K+sASZoX+h
 SrUVs0IkgJaRPvwewaqLTRwQ4UuIoV5n4UOLVnlMe87BQSg78s7jZ03Ce9bxdt01beyV 8w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3gbk8nd8yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 01:09:37 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 1 Jun
 2022 01:09:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 1 Jun 2022 01:09:35 -0700
Received: from localhost.localdomain (unknown [10.28.34.29])
        by maili.marvell.com (Postfix) with ESMTP id C36AE3F7079;
        Wed,  1 Jun 2022 01:09:31 -0700 (PDT)
From:   Shijith Thotton <sthotton@marvell.com>
To:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
CC:     Shijith Thotton <sthotton@marvell.com>,
        <linux-crypto@vger.kernel.org>, <jerinj@marvell.com>,
        <sgoutham@marvell.com>, Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] crypto: octeontx2: fix potential null pointer access
Date:   Wed, 1 Jun 2022 13:38:59 +0530
Message-ID: <6f772668877d2bd7dfdf7b45bb90cb56b3a6339b.1654070734.git.sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
References: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aWuB22d5fM_4GgWUb8rNdGK6mWi6wk53
X-Proofpoint-GUID: aWuB22d5fM_4GgWUb8rNdGK6mWi6wk53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_02,2022-05-30_03,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing checks to avoid null pointer dereference.

The patch fixes below issue reported by klocwork tool:
. Pointer 'strsep( &val, ":" )' returned from call to function 'strsep'
  at line 1608 may be NULL and will be dereferenced at line 1608. Also
  there are 2 similar errors on lines 1620, 1632 in otx2_cptpf_ucode.c.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
v2:
* Removed unwanted check for pcim_iomap_table.

 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 9cba2f714c7e..080cbfa093ec 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1605,7 +1605,10 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		if (!strncasecmp(val, "se", 2) && strchr(val, ':')) {
 			if (has_se || ucode_idx)
 				goto err_print;
-			tmp = strim(strsep(&val, ":"));
+			tmp = strsep(&val, ":");
+			if (!tmp)
+				goto err_print;
+			tmp = strim(tmp);
 			if (!val)
 				goto err_print;
 			if (strlen(tmp) != 2)
@@ -1617,7 +1620,10 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		} else if (!strncasecmp(val, "ae", 2) && strchr(val, ':')) {
 			if (has_ae || ucode_idx)
 				goto err_print;
-			tmp = strim(strsep(&val, ":"));
+			tmp = strsep(&val, ":");
+			if (!tmp)
+				goto err_print;
+			tmp = strim(tmp);
 			if (!val)
 				goto err_print;
 			if (strlen(tmp) != 2)
@@ -1629,7 +1635,10 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		} else if (!strncasecmp(val, "ie", 2) && strchr(val, ':')) {
 			if (has_ie || ucode_idx)
 				goto err_print;
-			tmp = strim(strsep(&val, ":"));
+			tmp = strsep(&val, ":");
+			if (!tmp)
+				goto err_print;
+			tmp = strim(tmp);
 			if (!val)
 				goto err_print;
 			if (strlen(tmp) != 2)
-- 
2.25.1

