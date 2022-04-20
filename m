Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0146507DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358672AbiDTAqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358658AbiDTAqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:46:42 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6617A17A93;
        Tue, 19 Apr 2022 17:43:57 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4D9F41BF206;
        Wed, 20 Apr 2022 00:43:50 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 11/11] driver/int3400_thermal: Fix prototype matching
Date:   Tue, 19 Apr 2022 17:42:41 -0700
Message-Id: <20220420004241.2093-12-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Moreira <joao@overdrivepizza.com>

The function attr_dev_show directly invokes functions from drivers
expecting an specific prototype. The driver for int3400_thermal
implements the given show function using a different prototype than what
is expected. This violates the prototype-based fine-grained CFI policy.

Make the function prototype compliant and cast the respective assignement
so it can be properly user together with fine-grained CFI.

(FWIIW, there should be a less ugly patch for this, but I don't know
enough about the touched source code).

Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
---
 .../thermal/intel/int340x_thermal/int3400_thermal.c    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 4954800b9850..4bd95a2016b7 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -311,12 +311,13 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
 	return result;
 }
 
-static ssize_t odvp_show(struct kobject *kobj, struct kobj_attribute *attr,
+static ssize_t odvp_show(struct device *kobj, struct device_attribute *attr,
 			 char *buf)
 {
+	struct kobj_attribute *kattr = (struct kobj_attribute *) attr;
 	struct odvp_attr *odvp_attr;
 
-	odvp_attr = container_of(attr, struct odvp_attr, attr);
+	odvp_attr = container_of(kattr, struct odvp_attr, attr);
 
 	return sprintf(buf, "%d\n", odvp_attr->priv->odvp[odvp_attr->odvp]);
 }
@@ -388,7 +389,10 @@ static int evaluate_odvp(struct int3400_thermal_priv *priv)
 				goto out_err;
 			}
 			odvp->attr.attr.mode = 0444;
-			odvp->attr.show = odvp_show;
+			odvp->attr.show = (ssize_t (*)
+					(struct kobject *,
+					 struct kobj_attribute *,
+					 char *)) odvp_show;
 			odvp->attr.store = NULL;
 			ret = sysfs_create_file(&priv->pdev->dev.kobj,
 						&odvp->attr.attr);
-- 
2.35.1

