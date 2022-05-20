Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622AD52EFD1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351134AbiETP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbiETP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:57:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97992A7768
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:57:37 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KDhpfS012784;
        Fri, 20 May 2022 15:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=h+FMIaMbYBHmr462sNYgkwt/IvmyaI0IcvD2SRf4XwY=;
 b=trRjO9RkedfAEozyJ/l90fCrha7/oKs0gGqNWq68RlVgyBPahqrblSI6dPWjNJuJnKiC
 PFcoSRxfK3ilsxy5fiw/Gy2qGOIjpboPifsQUYFKIbjLXTW6dI38OgVb3Upr3QTImKyd
 okDUg/Nv3e3Y0RfvCH9qB8fWe8BBmHDZ1qCSwDpJccKVlaA2zLmjvoW7MbuZ8cqghcLT
 HUs4EbNvW9uOz0ZnwztraiL0rnDA+fgj135fMAilnoi7WVg3gxK8Pme68bmeePqPcz1I
 YBboF7jiQxznwGutDfTLIaJLTBpdr1r5BFbBIUXA0djT9+C3bDDX0nK73kNd0TwVi8IB aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6c4835mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 15:57:29 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24KFUdZ3017013;
        Fri, 20 May 2022 15:57:29 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6c4835m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 15:57:28 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KFs9YN025089;
        Fri, 20 May 2022 15:57:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429h2wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 15:57:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24KFvNwL20840808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 15:57:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D33C9AE055;
        Fri, 20 May 2022 15:57:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8526AAE04D;
        Fri, 20 May 2022 15:57:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.68.37])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 May 2022 15:57:23 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com
Cc:     aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/64s: Don't read H_BLOCK_REMOVE characteristics in radix mode
Date:   Fri, 20 May 2022 17:57:21 +0200
Message-Id: <20220520155721.10211-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LNzXv5lovOiCpHs6gGL84tbuLKGxxBaX
X-Proofpoint-ORIG-GUID: 9FE4Q_Y2SokTdK3DT22wtauNZjiRzOL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_04,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to read the H_BLOCK_REMOVE characteristics when running in
Radix mode because this hcall is never called.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index c9fcc30a0365..654d2b999c25 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -803,7 +803,8 @@ static void __init pSeries_setup_arch(void)
 
 	pseries_setup_security_mitigations();
 #ifdef CONFIG_PPC_64S_HASH_MMU
-	pseries_lpar_read_hblkrm_characteristics();
+	if (!radix_enabled())
+		pseries_lpar_read_hblkrm_characteristics();
 #endif
 
 	/* By default, only probe PCI (can be overridden by rtas_pci) */
-- 
2.36.1

