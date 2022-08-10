Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D2E58E8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiHJIj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiHJIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:39:54 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DD9321271;
        Wed, 10 Aug 2022 01:39:53 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CE7C31E80D95;
        Wed, 10 Aug 2022 16:37:58 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WsnNz-N9TF6o; Wed, 10 Aug 2022 16:37:56 +0800 (CST)
Received: from nfschina.com.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhounan@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id F25D01E80CD2;
        Wed, 10 Aug 2022 16:37:55 +0800 (CST)
From:   zhoun <zhounan@nfschina.com>
To:     john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhounan <zhounan@nfschina.com>
Subject: [PATCH] remove unnecessary type casting
Date:   Wed, 10 Aug 2022 04:39:35 -0400
Message-Id: <20220810083935.83452-1-zhounan@nfschina.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhounan <zhounan@nfschina.com>

'policy' is already a pointer to the struct aa_profile,
 so there is no need to cast 'policy' when it is called.

Signed-off-by: zhounan <zhounan@nfschina.com>
---
 security/apparmor/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index b0cbc4906cb3..9643801c4ee7 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -1003,7 +1003,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 			rcu_assign_pointer(ent->new->parent, aa_get_profile(p));
 		} else if (policy != &ns->base) {
 			/* released on profile replacement or free_profile */
-			struct aa_profile *p = (struct aa_profile *) policy;
+			struct aa_profile *p = policy;
 			rcu_assign_pointer(ent->new->parent, aa_get_profile(p));
 		}
 	}
-- 
2.27.0

