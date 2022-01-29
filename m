Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451754A2B52
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 03:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbiA2CvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 21:51:11 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51138 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352223AbiA2CvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 21:51:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V34nGA9_1643424666;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V34nGA9_1643424666)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Jan 2022 10:51:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     serge@hallyn.com
Cc:     jmorris@namei.org, john.johansen@canonical.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/3] apparmor: Fix some kernel-doc comments
Date:   Sat, 29 Jan 2022 10:51:00 +0800
Message-Id: <20220129025101.38355-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220129025101.38355-1-yang.lee@linux.alibaba.com>
References: <20220129025101.38355-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @ns_name, change function name aa_u16_chunck to
unpack_u16_chunk and verify_head to verify_header in kernel-doc comment
to remove warnings found by running scripts/kernel-doc, which is caused
by using 'make W=1'.

security/apparmor/policy_unpack.c:224: warning: expecting prototype for
aa_u16_chunck(). Prototype was for unpack_u16_chunk() instead
security/apparmor/policy_unpack.c:678: warning: Function parameter or
member 'ns_name' not described in 'unpack_profile'
security/apparmor/policy_unpack.c:950: warning: expecting prototype for
verify_head(). Prototype was for verify_header() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/policy_unpack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 55dca9e3af50..3cc0fd2dff87 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -214,7 +214,7 @@ static void *kvmemdup(const void *src, size_t len)
 }
 
 /**
- * aa_u16_chunck - test and do bounds checking for a u16 size based chunk
+ * unpack_u16_chunk - test and do bounds checking for a u16 size based chunk
  * @e: serialized data read head (NOT NULL)
  * @chunk: start address for chunk of data (NOT NULL)
  *
@@ -671,6 +671,7 @@ static int datacmp(struct rhashtable_compare_arg *arg, const void *obj)
 /**
  * unpack_profile - unpack a serialized profile
  * @e: serialized data extent information (NOT NULL)
+ * @ns_name: pointer of newly allocated copy of %NULL in case of error
  *
  * NOTE: unpack profile sets audit struct if there is a failure
  */
@@ -939,7 +940,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 }
 
 /**
- * verify_head - unpack serialized stream header
+ * verify_header - unpack serialized stream header
  * @e: serialized data read head (NOT NULL)
  * @required: whether the header is required or optional
  * @ns: Returns - namespace if one is specified else NULL (NOT NULL)
-- 
2.20.1.7.g153144c

