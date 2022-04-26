Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9C1510AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355070AbiDZUmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355075AbiDZUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:42:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1757A99A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA04961159
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986A8C385A0;
        Tue, 26 Apr 2022 20:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651005533;
        bh=ye+LjKF19sj8g3+LRr6BvSaFMe97AXGWcgOi77vqX+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7XaVBw134K8ApDrlwRjsp7ewuaN3S9FtArmXBU/1Y67xi4cbPkBASSJtAHGdNGii
         d3e9uJyqYrMnf7JcI6aF1Ya2Q9pdwpcVeR6AiWFxZAdQRyfkmRsG5RGJk774JjSSYZ
         IoQ/aLF5L5N2Y+MuHEkCBk9feeTPJ2ULfft9kDMWFwuw4TO0SRgyfA3Dk2dEMqukH8
         yNEhOleftuRUHFPLXHqpJ9g4eK5Zz9ocZ6LFVhrWBnPGhxaFCx5Bh9vLTrsGStbezK
         QISOG77qZVvBCDcOo3sApIXh1oe1tJeIM7NAdi4IUjQUXbr/Qi9VBOLLmSFEOvniyN
         bDo1KF6RVn4yQ==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/4] mm/damon/sysfs: add a file for listing available monitoring ops
Date:   Tue, 26 Apr 2022 20:38:41 +0000
Message-Id: <20220426203843.45238-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426203843.45238-1-sj@kernel.org>
References: <20220426203843.45238-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

DAMON programming interface users can know if specific monitoring ops
set is registered or not using 'damon_is_registered_ops()', but there is
no such method for the user space.  To help the case, this commit adds a
new DAMON sysfs file called 'avail_operations' under each context
directory for listing available monitoring ops.  Reading the file will
list each registered monitoring ops on each line.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 48e434cd43d8..6ad6364780b8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1810,6 +1810,21 @@ static void damon_sysfs_context_rm_dirs(struct damon_sysfs_context *context)
 	kobject_put(&context->schemes->kobj);
 }
 
+static ssize_t avail_operations_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	enum damon_ops_id id;
+	int len = 0;
+
+	for (id = 0; id < NR_DAMON_OPS; id++) {
+		if (!damon_is_registered_ops(id))
+			continue;
+		len += sysfs_emit_at(buf, len, "%s\n",
+				damon_sysfs_ops_strs[id]);
+	}
+	return len;
+}
+
 static ssize_t operations_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -1840,10 +1855,14 @@ static void damon_sysfs_context_release(struct kobject *kobj)
 	kfree(container_of(kobj, struct damon_sysfs_context, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_context_avail_operations_attr =
+		__ATTR_RO_MODE(avail_operations, 0400);
+
 static struct kobj_attribute damon_sysfs_context_operations_attr =
 		__ATTR_RW_MODE(operations, 0600);
 
 static struct attribute *damon_sysfs_context_attrs[] = {
+	&damon_sysfs_context_avail_operations_attr.attr,
 	&damon_sysfs_context_operations_attr.attr,
 	NULL,
 };
-- 
2.25.1

