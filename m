Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689FF5256F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358665AbiELVR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353619AbiELVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:17:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FB568F8D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B41B1B82799
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868CDC385B8;
        Thu, 12 May 2022 21:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652390241;
        bh=LqARVq2lcGKNOIxt7wFh53bt74j0X8rRusVOxvkYpqc=;
        h=From:To:Cc:Subject:Date:From;
        b=rZ3+EgEYyfYagLTq+TdC4pKBLiDez079XtAYlgTUYUFuMa0Ux2wykWoHakFcl66NP
         DMM1LrO2Go1ZGCa7NvfLFPw1ZYpSvu+jnRIwlnyL0VtGR4+ZciJKYE6w8DA0kKhZzP
         i/RzliIrkgPlOmyGRbUm3B8O/d+XccJEXp5059+ctKavd4qXTtyMJxGG/MRjQSCSHj
         +1BIlMiDFc4YvnrGGbcyFsKig6kZVxRxf5RiDeSxoS1tj/Ye9jf4MBVpGltSCHdpN6
         mqIJBjcYU+gvxi0cNXDsYkzK64SkUtAOPO0leSOiYbA1pQEMH3NmxuQ3j7Ao1SDAv+
         jGYAbhzxC8eDg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] drm/i915: Fix CFI violation with show_dynamic_id()
Date:   Thu, 12 May 2022 14:17:04 -0700
Message-Id: <20220512211704.3158759-1-nathan@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an attribute group is created with sysfs_create_group(), the
->sysfs_ops() callback is set to kobj_sysfs_ops, which sets the ->show()
callback to kobj_attr_show(). kobj_attr_show() uses container_of() to
get the ->show() callback from the attribute it was passed, meaning the
->show() callback needs to be the same type as the ->show() callback in
'struct kobj_attribute'.

However, show_dynamic_id() has the type of the ->show() callback in
'struct device_attribute', which causes a CFI violation when opening the
'id' sysfs node under drm/card0/metrics. This happens to work because
the layout of 'struct kobj_attribute' and 'struct device_attribute' are
the same, so the container_of() cast happens to allow the ->show()
callback to still work.

Change the type of show_dynamic_id() to match the ->show() callback in
'struct kobj_attributes' and update the type of sysfs_metric_id to
match, which resolves the CFI violation.

Fixes: f89823c21224 ("drm/i915/perf: Implement I915_PERF_ADD/REMOVE_CONFIG interface")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/i915/i915_perf.c       | 4 ++--
 drivers/gpu/drm/i915/i915_perf_types.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 0a9c3fcc09b1..1577ab6754db 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4050,8 +4050,8 @@ static struct i915_oa_reg *alloc_oa_regs(struct i915_perf *perf,
 	return ERR_PTR(err);
 }
 
-static ssize_t show_dynamic_id(struct device *dev,
-			       struct device_attribute *attr,
+static ssize_t show_dynamic_id(struct kobject *kobj,
+			       struct kobj_attribute *attr,
 			       char *buf)
 {
 	struct i915_oa_config *oa_config =
diff --git a/drivers/gpu/drm/i915/i915_perf_types.h b/drivers/gpu/drm/i915/i915_perf_types.h
index 473a3c0544bb..05cb9a335a97 100644
--- a/drivers/gpu/drm/i915/i915_perf_types.h
+++ b/drivers/gpu/drm/i915/i915_perf_types.h
@@ -55,7 +55,7 @@ struct i915_oa_config {
 
 	struct attribute_group sysfs_metric;
 	struct attribute *attrs[2];
-	struct device_attribute sysfs_metric_id;
+	struct kobj_attribute sysfs_metric_id;
 
 	struct kref ref;
 	struct rcu_head rcu;

base-commit: 7ecc3cc8a7b39f08eee9aea7b718187583342a70
-- 
2.36.1

