Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6372577AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiGRGaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiGRGa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:30:27 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB315FFB;
        Sun, 17 Jul 2022 23:30:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VJe-3rM_1658125823;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VJe-3rM_1658125823)
          by smtp.aliyun-inc.com;
          Mon, 18 Jul 2022 14:30:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     john.johansen@canonical.com
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] apparmor: Fix some kernel-doc comments
Date:   Mon, 18 Jul 2022 14:30:22 +0800
Message-Id: <20220718063022.129998-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove warnings found by running scripts/kernel-doc, which is caused by
using 'make W=1'.
security/apparmor/policy_ns.c:65: warning: Function parameter or member 'curr' not described in 'aa_ns_name'
security/apparmor/policy_ns.c:65: warning: Function parameter or member 'view' not described in 'aa_ns_name'
security/apparmor/policy_ns.c:65: warning: Function parameter or member 'subns' not described in 'aa_ns_name'
security/apparmor/policy_ns.c:65: warning: expecting prototype for aa_na_name(). Prototype was for aa_ns_name() instead
security/apparmor/policy_ns.c:214: warning: Function parameter or member 'view' not described in '__aa_lookupn_ns'
security/apparmor/policy_ns.c:214: warning: Excess function parameter 'base' description in '__aa_lookupn_ns'
security/apparmor/policy_ns.c:297: warning: expecting prototype for aa_create_ns(). Prototype was for __aa_find_or_create_ns() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/policy_ns.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 300953a02a24..0ef268d6554d 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -54,10 +54,10 @@ bool aa_ns_visible(struct aa_ns *curr, struct aa_ns *view, bool subns)
 }
 
 /**
- * aa_na_name - Find the ns name to display for @view from @curr
- * @curr - current namespace (NOT NULL)
- * @view - namespace attempting to view (NOT NULL)
- * @subns - are subns visible
+ * aa_ns_name - Find the ns name to display for @view from @curr
+ * @curr: current namespace (NOT NULL)
+ * @view: namespace attempting to view (NOT NULL)
+ * @subns: are subns visible
  *
  * Returns: name of @view visible from @curr
  */
@@ -200,7 +200,7 @@ struct aa_ns *aa_find_ns(struct aa_ns *root, const char *name)
 
 /**
  * __aa_lookupn_ns - lookup the namespace matching @hname
- * @base: base list to start looking up profile name from  (NOT NULL)
+ * @view: namespace to search in  (NOT NULL)
  * @hname: hierarchical ns name  (NOT NULL)
  * @n: length of @hname
  *
@@ -285,7 +285,7 @@ static struct aa_ns *__aa_create_ns(struct aa_ns *parent, const char *name,
 }
 
 /**
- * aa_create_ns - create an ns, fail if it already exists
+ * __aa_find_or_create_ns - create an ns, fail if it already exists
  * @parent: the parent of the namespace being created
  * @name: the name of the namespace
  * @dir: if not null the dir to put the ns entries in
-- 
2.20.1.7.g153144c

