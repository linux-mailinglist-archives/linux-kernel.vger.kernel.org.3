Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFA848097F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhL1NTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:19:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54514 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhL1NTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:19:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95EF2B811F6;
        Tue, 28 Dec 2021 13:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A9CC36AE7;
        Tue, 28 Dec 2021 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640697556;
        bh=kO/fFn2P+NnNbeUNRt7ndHbtmklWlYmiN7ryiQUJY2g=;
        h=From:To:Cc:Subject:Date:From;
        b=kZuHZYOZ5gQR1jQ/9YghTls/H6baz+RTZ5zgYcyQzfIcpTE2zXANqRO45mqKBi7t1
         Dx0b4c2yhILi41BcXi+MyfDF39Z0G4dnzthNFTayKIhYDq6I+Z72O9ZosKgnfwa+7R
         pwFChv6/cpo79gTUFDhcIvBKKJ9yE5iPbLs7FgNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: use default_groups in kobj_type
Date:   Tue, 28 Dec 2021 14:19:12 +0100
Message-Id: <20211228131912.260899-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3915; h=from:subject; bh=kO/fFn2P+NnNbeUNRt7ndHbtmklWlYmiN7ryiQUJY2g=; b=owGbwMvMwCRo6H6F97bub03G02pJDImn+S5c+rp/j5Luzh/XDk2+Pd/A6q9y1dqjr+Y/Xbns9xXl nhNKFzpiWRgEmRhkxRRZvmzjObq/4pCil6HtaZg5rEwgQxi4OAVgItPWMMyv9XwfHXbVpFOLU1WFRy +czXBp8h2gqEzs13w9obSq/oAcy5NBpcvC9rcAAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the cpufreq code to use default_groups field which has been
the preferred way since aa30f47cf666 ("kobject: Add support for default
attribute groups to kobj_type") so that we can soon get rid of the
obsolete default_attrs field.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq.c              | 5 +++--
 drivers/cpufreq/cpufreq_conservative.c | 5 +++--
 drivers/cpufreq/cpufreq_ondemand.c     | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e338d2f010fe..09d676d5237e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -924,7 +924,7 @@ cpufreq_freq_attr_rw(scaling_max_freq);
 cpufreq_freq_attr_rw(scaling_governor);
 cpufreq_freq_attr_rw(scaling_setspeed);
 
-static struct attribute *default_attrs[] = {
+static struct attribute *cpufreq_attrs[] = {
 	&cpuinfo_min_freq.attr,
 	&cpuinfo_max_freq.attr,
 	&cpuinfo_transition_latency.attr,
@@ -938,6 +938,7 @@ static struct attribute *default_attrs[] = {
 	&scaling_setspeed.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(cpufreq);
 
 #define to_policy(k) container_of(k, struct cpufreq_policy, kobj)
 #define to_attr(a) container_of(a, struct freq_attr, attr)
@@ -1000,7 +1001,7 @@ static const struct sysfs_ops sysfs_ops = {
 
 static struct kobj_type ktype_cpufreq = {
 	.sysfs_ops	= &sysfs_ops,
-	.default_attrs	= default_attrs,
+	.default_groups	= cpufreq_groups,
 	.release	= cpufreq_sysfs_release,
 };
 
diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 0879ec3c170c..08515f7e515f 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -257,7 +257,7 @@ gov_attr_rw(ignore_nice_load);
 gov_attr_rw(down_threshold);
 gov_attr_rw(freq_step);
 
-static struct attribute *cs_attributes[] = {
+static struct attribute *cs_attrs[] = {
 	&sampling_rate.attr,
 	&sampling_down_factor.attr,
 	&up_threshold.attr,
@@ -266,6 +266,7 @@ static struct attribute *cs_attributes[] = {
 	&freq_step.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(cs);
 
 /************************** sysfs end ************************/
 
@@ -315,7 +316,7 @@ static void cs_start(struct cpufreq_policy *policy)
 
 static struct dbs_governor cs_governor = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
-	.kobj_type = { .default_attrs = cs_attributes },
+	.kobj_type = { .default_groups = cs_groups },
 	.gov_dbs_update = cs_dbs_update,
 	.alloc = cs_alloc,
 	.free = cs_free,
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 3b8f924771b4..6a41ea4729b8 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -328,7 +328,7 @@ gov_attr_rw(sampling_down_factor);
 gov_attr_rw(ignore_nice_load);
 gov_attr_rw(powersave_bias);
 
-static struct attribute *od_attributes[] = {
+static struct attribute *od_attrs[] = {
 	&sampling_rate.attr,
 	&up_threshold.attr,
 	&sampling_down_factor.attr,
@@ -337,6 +337,7 @@ static struct attribute *od_attributes[] = {
 	&io_is_busy.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(od);
 
 /************************** sysfs end ************************/
 
@@ -401,7 +402,7 @@ static struct od_ops od_ops = {
 
 static struct dbs_governor od_dbs_gov = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
-	.kobj_type = { .default_attrs = od_attributes },
+	.kobj_type = { .default_groups = od_groups },
 	.gov_dbs_update = od_dbs_update,
 	.alloc = od_alloc,
 	.free = od_free,
-- 
2.34.1

