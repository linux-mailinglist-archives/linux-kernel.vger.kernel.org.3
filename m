Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3EA508EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381374AbiDTSAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381362AbiDTSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:00:37 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D474756D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:57:39 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KC6qk1009257;
        Wed, 20 Apr 2022 10:57:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=A0HtCp2tynCEi42rEm66H/yvK3b33NoJskOoLtuAASc=;
 b=iVULywRm7IZRv/jJuHM7DlOWFl8eApChEgdBBvPoWS7yZJ98F/00xgspcD+Ao6sMlftM
 WG4ZcclnNlZMc02ytKUSE6hhoCZKOmuMsN5keQBRRHI1qGsGWXtbok27uwbelgpb/NUM
 IdoWDq6b8Mt0zBaQx7F2zeJ0LMNwdgIkImFnLkCkppITckbR14aOhmsMcL4m9WCMPE8w
 fyiOO1ivpyeYbl213rM1f3dQt6r1uym07U8eMysz0YzM9rbn6Zv9dcUXy67ZOKKuT/Bf
 qiKNH7spKCiF9fPnsxxRApvnNbQ23wIvSe+VOruZd18Wmz/i32gfdclgQUMn5ozNuVJP zA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3fhtapefa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 10:57:33 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Apr
 2022 10:57:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Apr 2022 10:57:31 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 4F9F43F7068;
        Wed, 20 Apr 2022 10:57:31 -0700 (PDT)
From:   Vasyl Gomonovych <vgomonovych@marvell.com>
To:     <bp@suse.de>, <ying.huang@intel.com>, <alex.kluver@hpe.com>,
        <linux-kernel@vger.kernel.org>, <vgomonovych@marvell.com>
Subject: [PATCH] efi: cper: Define macro for errors type
Date:   Wed, 20 Apr 2022 10:57:24 -0700
Message-ID: <20220420175726.27789-1-vgomonovych@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: bF1Tm5LyJxiCmxYQg_p48xWZXp1iC3JK
X-Proofpoint-ORIG-GUID: bF1Tm5LyJxiCmxYQg_p48xWZXp1iC3JK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_05,2022-04-20_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPER defines errors type, which is currently in
form of raw numbers referenced from cper and
ghes_edac modules. CPER format sharable with
firmware. This errors type macro can be common
and share errors type between kernel and firmware
and eliminate magic numbers uses. Also will
simplify do code reuse in ghes_edac_report_mem_error.

Signed-off-by: Vasyl Gomonovych <vgomonovych@marvell.com>
---
 include/linux/cper.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 6a511a1078ca069c4fa0e120b781c4203571afc8..13c09b08695241c9f040680c7435081f1cd2bcff 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -314,6 +314,23 @@ enum {
 #define CPER_ARM_ERR_ACCESS_MODE_SHIFT		43
 #define CPER_ARM_ERR_ACCESS_MODE_MASK		GENMASK(0,0)
 
+#define CPER_MEM_ERR_TYPE_UNKNOWN		0
+#define CPER_MEM_ERR_TYPE_NO_ERR		1
+#define CPER_MEM_ERR_TYPE_SBIT_ECC		2
+#define CPER_MEM_ERR_TYPE_MBIT_ECC		3
+#define CPER_MEM_ERR_TYPE_SSB_ECC		4
+#define CPER_MEM_ERR_TYPE_MSB_ECC		5
+#define CPER_MEM_ERR_TYPE_MSTR_ABRT		6
+#define CPER_MEM_ERR_TYPE_TARG_ABRT		7
+#define CPER_MEM_ERR_TYPE_PARITY_ERR		8
+#define CPER_MEM_ERR_TYPE_WDG_TIMOUT		9
+#define CPER_MEM_ERR_TYPE_INVAL_ADDR		10
+#define CPER_MEM_ERR_TYPE_MIRR_BROK		11
+#define CPER_MEM_ERR_TYPE_MEM_SPARING		12
+#define CPER_MEM_ERR_TYPE_SBR_CE		13
+#define CPER_MEM_ERR_TYPE_SBR_UE		14
+#define CPER_MEM_ERR_TYPE_PHYS_MAPOUT		15
+
 /*
  * All tables and structs must be byte-packed to match CPER
  * specification, since the tables are provided by the system BIOS
-- 
2.17.1

