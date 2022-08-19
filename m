Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B644D59A91C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbiHSXPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243825AbiHSXO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:14:58 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEAEDAB96;
        Fri, 19 Aug 2022 16:14:56 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JLOHRQ021597;
        Fri, 19 Aug 2022 23:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=nCwDyrezujJ59TpPL9d8GNAEdr/akhU/9hhx7cy4SIU=;
 b=HLgsRdkjgIxtDy5osrj+RmELjHU+JZ2dJesw8Luo3LiOF5xjrEG7R6Kw506n4/lUh5zp
 haY73TkRoUwUCvWGeIoIAjnfUxRsaX4II/6giKwBwyIAmgkMMdXwmZr4pw/Dh3vED54S
 D/sNeoyGZpUVPr7GFKz/hHuMeS39PzbLJ1PBsCU7jDGxFPSsdg98As/rNdIpmIQEeQ6E
 xQXHkU58eGgd8OKB3oh0DBDbK1cG41tkiBw68yW+d0wC9t20SNwD5Z3CcuYnyqduL/Bu
 sFl7p0lfPHxgfTqhfiQ6R5XYw9pMrVZKSnN3R7mY8xAz2emVzJaCKHvm1KJ/O6883YOP yQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2jd3gmtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 23:14:42 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 06319800E80;
        Fri, 19 Aug 2022 23:14:42 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 9E0E7807C18;
        Fri, 19 Aug 2022 23:14:41 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 1/2] watchdog/hpwdt: Build issue for ARM64 platforms
Date:   Fri, 19 Aug 2022 17:14:22 -0600
Message-Id: <20220819231423.1236664-2-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819231423.1236664-1-jerry.hoemann@hpe.com>
References: <20220819231423.1236664-1-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KzCAKyntMivfCG8jzbfH7h1rSjJWTlSQ
X-Proofpoint-ORIG-GUID: KzCAKyntMivfCG8jzbfH7h1rSjJWTlSQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=986 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes commit d48b0e173715 ("x86, nmi, drivers: Fix nmi splitup build bug")

Include <asm/nmi.h> only if CONFIG_HPWDT_NMI_DECODING is defined.

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

