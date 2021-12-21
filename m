Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19047BA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhLUHGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:06:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234594AbhLUHGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:06:46 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BL5xuvC032611;
        Tue, 21 Dec 2021 07:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+FzhdU8s+H6f8OYVqx0rwO0AUCZKk5PGUnwZ8gKaqck=;
 b=pIsfjXYVwjl/zgkWFOQ9xC/fCjGtuOwzRZdC7xIlHDJtyzRHutn01+SQLbRwiKTW24xm
 Wk8adOVEdoReJ4fhZpPZd8xGtNXmy0MuZVhHXXCTjp335s9BJB0ROULmr8SluBpTh2St
 FnjGPpNsR360rFY3lTZZdtyqyQHkpimxMMZAZetVTlQ6VmWZHFu14r9437JZDGO/J8jH
 4rnMGAguG93pFWdXKS8yRqL2BvGrAQ3FJc0RFYXVGnuLeFxK42s9v1YdaitXf118FBQ0
 97AIScR6x3yMTEfZ1nWPBnrm3SBOs3XGFaq2qYuAhllYKRgiEDik7hOFrJv6r2Zy1W7J tQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d3990h54n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 07:06:31 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BL72cBI021010;
        Tue, 21 Dec 2021 07:06:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3d1799jtpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 07:06:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BL76Q5q43909516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 07:06:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFCDB5204E;
        Tue, 21 Dec 2021 07:06:26 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com.com (unknown [9.145.30.13])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 665F852050;
        Tue, 21 Dec 2021 07:06:26 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] asm/sections: fix memory object end check
Date:   Tue, 21 Dec 2021 08:06:24 +0100
Message-Id: <20211221070624.1541842-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 673ZBziW4vko3o26ne_5eF7mGHtXdOa1
X-Proofpoint-GUID: 673ZBziW4vko3o26ne_5eF7mGHtXdOa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_02,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function memory_contains() checks whether a memory object is
entirely contained within a memory region. The condition that
checks the upper bound of the object against the upper bound
of the region is inclusive. That does not correspond to the
similar checks in memory_intersects() friend function, nor
to the actual regions memory_contains() is called against.

In particular, __init_end address assumed do not belong to
the init section itself. Similarly, on ARM __idmap_text_end
and __entry_text_end are affected.

Fixes: 979559362516 ("asm/sections: add helpers to check for section data")
Cc: Thierry Reding <treding@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/asm-generic/sections.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 1dfadb2e878d..23f325cd2c66 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -78,7 +78,7 @@ extern __visible const void __nosave_begin, __nosave_end;
 static inline bool memory_contains(void *begin, void *end, void *virt,
 				   size_t size)
 {
-	return virt >= begin && virt + size <= end;
+	return virt >= begin && virt + size < end;
 }
 
 /**
-- 
2.32.0

