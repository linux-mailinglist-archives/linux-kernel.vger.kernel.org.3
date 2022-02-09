Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D184AEE9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiBIJyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiBIJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:54:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0604DE0D58B7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:54:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C5BEB81FDD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A56CC340E7;
        Wed,  9 Feb 2022 09:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644400082;
        bh=qBP7pDK7v38bL/Wj23CF1WYCYm0yN9WGAG1T7aIL6zE=;
        h=From:To:Cc:Subject:Date:From;
        b=pwVFI2DHuD5WANevgFZO5eTXkSYgF8i/AqqKyxhI7D2y7gwNK5gAG1MbxIBvopFcg
         JssvS1Rp7ZC+VwYn7JxhS2d2oTjEQBDjQiu/3QKrvfMHXD8aakfxxBzzTTRDOevF5M
         kQ/02Yudbgib+7HitDR+8jwNG0IaSdEHL35RJ+LFt24nMgZPSEfM6xS6Hoe5ISOKUJ
         ORMv7iTHx6V/8izzdWD3HrKvaUUWfzDtO4pWzcUQ1DSYLkLYX1lNBp5EF9FV79Dka5
         pjsqfujr5YEHgB5/MUSo3iEdp0MJLA4PgXtYPSpB62YMS4TBXG2buasZjd2JcBozsb
         uDwQmUJ7o9qWw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shy828301@gmail.com, ziy@nvidia.com, ying.huang@intel.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH RESEND] migrate: Wrap CONFIG_DEVICE_PRIVATE dependent function declarations with ifdef
Date:   Wed,  9 Feb 2022 09:47:53 +0000
Message-Id: <20220209094753.22022-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'migrate_vma_{setup,pages,finalize}()' functions are defined under
CONFIG_DEVICE_PRIVATE, but their declarations are not.  This commit
wraps the declaration under the config to minimize confusion.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/migrate.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 66a34eae8cb6..f8fa7db83e23 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -162,9 +162,14 @@ struct migrate_vma {
 	unsigned long		flags;
 };
 
+#ifdef CONFIG_DEVICE_PRIVATE
+
 int migrate_vma_setup(struct migrate_vma *args);
 void migrate_vma_pages(struct migrate_vma *migrate);
 void migrate_vma_finalize(struct migrate_vma *migrate);
+
+#endif /* CONFIG_DEVICE_PRIVATE */
+
 int next_demotion_node(int node);
 
 #else /* CONFIG_MIGRATION disabled: */
-- 
2.17.1

