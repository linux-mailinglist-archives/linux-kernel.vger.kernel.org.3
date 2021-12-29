Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC274813E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240153AbhL2OPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhL2OPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:15:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E01C061574;
        Wed, 29 Dec 2021 06:15:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB342614C9;
        Wed, 29 Dec 2021 14:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB679C36AE9;
        Wed, 29 Dec 2021 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640787299;
        bh=sNviMGkw+EDDvnPrxN650ZZafy3DQSyIckS9RrKIRn0=;
        h=From:To:Cc:Subject:Date:From;
        b=BAlhAikEAqBG3cZCo7LtoNnYdEXdF92qunpi+o0UcBlbzMJ+xMoeqSzEgZkQLgbkx
         dPnVPUUXQ495pYvu5wXlpV6HyHaYQ48PHWgWxXy8Jrm+xs5V8GEdMOghDg6WcW8HVO
         s1wb9vaAf66ulv1CVQfgQ7pSB9xLtUrBJ4Xi7Q4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: intel-uncore-frequency: use default_groups in kobj_type
Date:   Wed, 29 Dec 2021 15:14:54 +0100
Message-Id: <20211229141454.2552950-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; h=from:subject; bh=sNviMGkw+EDDvnPrxN650ZZafy3DQSyIckS9RrKIRn0=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlncuOijUMFZyTdXfdhs0wm9/WPtztM7+0+IxX9+vzJWTE6 h28IdsSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEpJUZFmzO0dTQErhTYabDqBWrLL ntW1dCF8OCDXl378z/7+0haql4+ubM0GJ3vWNdAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the uncore-frequency sysfs code to use default_groups field
which has been the preferred way since aa30f47cf666 ("kobject: Add
support for default attribute groups to kobj_type") so that we can soon
get rid of the obsolete default_attrs field.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/uncore-frequency.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency.c
index 3ee4c5c8a64f..4cd8254f2e40 100644
--- a/drivers/platform/x86/intel/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency.c
@@ -225,6 +225,7 @@ static struct attribute *uncore_attrs[] = {
 	&min_freq_khz.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(uncore);
 
 static void uncore_sysfs_entry_release(struct kobject *kobj)
 {
@@ -236,7 +237,7 @@ static void uncore_sysfs_entry_release(struct kobject *kobj)
 static struct kobj_type uncore_ktype = {
 	.release = uncore_sysfs_entry_release,
 	.sysfs_ops = &kobj_sysfs_ops,
-	.default_attrs = uncore_attrs,
+	.default_groups = uncore_groups,
 };
 
 /* Caller provides protection */
-- 
2.34.1

