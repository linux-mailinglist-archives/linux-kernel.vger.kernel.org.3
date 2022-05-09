Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E3651F386
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiEIEju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiEIEgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:36:44 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BADB126C2A
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 21:32:49 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248Nq6e9004620;
        Sun, 8 May 2022 21:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=rLr3fZbfrwdxpdqUmO+7CXj9h1u666zzhD5qe0O+oHw=;
 b=HWh81//F61cNkEG0UfKh0asgFZK/aJYN7qH9erMthRC7zPeorO2Oh85f6wHN9qnX2hXm
 9/hYFfGTtryZFjQ09rmSH/ou0wNFtnZDgphD6kBpSA383yx9LnFgee3L/movHN8sVZFo
 nvw3cOzjtuXJ3u61f0xtowoSie1WaNSepTyJVlMayfJaYZWRI3aGofclNfFQlL6eEnIi
 qzZ20MhPx9UeWz3Wur8RrVcdyG8VacWhn9gQ0tAzB+UHlfCPVKbfxeDp8GiLqo4EtOEf
 zFAhEOSbJsQuf86Omi2DQvrY83RBomls+Ph60UvLu/fDiUMPgUCL4cwOjU4Z57tM9BTX LQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3fwy5j3mh1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 08 May 2022 21:32:30 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 8 May
 2022 21:32:28 -0700
Received: from localhost.localdomain (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 8 May 2022 21:32:25 -0700
From:   Linu Cherian <lcherian@marvell.com>
To:     <maz@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuc.decode@gmail.com>,
        Linu Cherian <lcherian@marvell.com>,
        "kernel test robot" <lkp@intel.com>
Subject: [PATCH V2] arm64: Declare non global symbols as static
Date:   Mon, 9 May 2022 10:02:21 +0530
Message-ID: <20220509043221.16361-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VPmKMi-ejMp8eedWKaFJv5xE6Cx2Mhc-
X-Proofpoint-GUID: VPmKMi-ejMp8eedWKaFJv5xE6Cx2Mhc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_01,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below sparse warnings introduced while adding errata.

arch/arm64/kernel/cpu_errata.c:218:25: sparse: warning: symbol
'cavium_erratum_23154_cpus' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changes from V1:
Reverted change to global symbol cavium_erratum_27456_cpus since it
was used in other files.

 arch/arm64/kernel/cpu_errata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 4c9b5b4b7a0b..49f4863c6c56 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -215,7 +215,7 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 #endif
 
 #ifdef CONFIG_CAVIUM_ERRATUM_23154
-const struct midr_range cavium_erratum_23154_cpus[] = {
+static const struct midr_range cavium_erratum_23154_cpus[] = {
 	MIDR_ALL_VERSIONS(MIDR_THUNDERX),
 	MIDR_ALL_VERSIONS(MIDR_THUNDERX_81XX),
 	MIDR_ALL_VERSIONS(MIDR_THUNDERX_83XX),
-- 
2.31.1

