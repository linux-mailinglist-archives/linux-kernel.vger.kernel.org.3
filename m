Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC71B59B074
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiHTU3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 16:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiHTU3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:29:03 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB4624099;
        Sat, 20 Aug 2022 13:29:02 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KJ3Cr7010886;
        Sat, 20 Aug 2022 20:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=xc5IsnZxbDxugpMggkpCA85TYXE4zuMF/pqCCJobznM=;
 b=gIqB3IAlKHoPbPw6stquoG8oygjKDS6RF3hASewfOZGn2SkKMEO+xEfwmSNn679x6NmD
 EC1lw8s5DdATsGP/DfNOqUf6vsZVhCYASNuH0Owjyz4V0kI1CAk3FUHYoW13gLOIxBHq
 ByNkFvCaTyPlUsPcVCIVzO00b27E8TliWgwv4Ryu3zGuIDXJC+qNLFiA8Zr/0VkS+8Ov
 mHl3I1uUmLojwvvgm35oekjvuC2HUZZ/y9d0Tgy1Zp8vvavomMP2R2oPgF+RG8EZNLvz
 fqkT4wrQh3bwdWQlKbesdlEerQjW0lwMtgKUmPJkM7V5rni1d72/Y97jB3L4h0Lgb6Sk dQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wn92hea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 20:28:48 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8C5098001AE;
        Sat, 20 Aug 2022 20:28:47 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 1D6F58075F9;
        Sat, 20 Aug 2022 20:28:47 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 1/2] watchdog/hpwdt: Include nmi.h only if CONFIG_HPWDT_NMI_DECODING
Date:   Sat, 20 Aug 2022 14:28:20 -0600
Message-Id: <20220820202821.1263837-2-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820202821.1263837-1-jerry.hoemann@hpe.com>
References: <20220820202821.1263837-1-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1SQrYM0QXqBb_Dg-b33zGICRu2m_y5Sa
X-Proofpoint-ORIG-GUID: 1SQrYM0QXqBb_Dg-b33zGICRu2m_y5Sa
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: d48b0e173715 ("x86, nmi, drivers: Fix nmi splitup build bug")

Arm64 does not support NMI and has no <asm/nmi.h>.

Include <asm/nmi.h> only if CONFIG_HPWDT_NMI_DECODING is defined to
avoid build failure on non-existent header file on Arm64.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index a5006a58e0db..f79f932bca14 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -20,7 +20,9 @@
 #include <linux/pci_ids.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
+#ifdef CONFIG_HPWDT_NMI_DECODING
 #include <asm/nmi.h>
+#endif
 #include <linux/crash_dump.h>
 
 #define HPWDT_VERSION			"2.0.4"
-- 
2.37.1

