Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E94506724
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350124AbiDSIvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbiDSIvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:51:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD602DFED;
        Tue, 19 Apr 2022 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650358114; x=1681894114;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UWIE0HnD9NgxQVsp7h7r45uq5pwm8u3x3+QkXUgh0ts=;
  b=XZQbFXUWzY0oedL/qqq+v7Sj02DRegtj1gKB83jnQsQ76y51o0NX6yLC
   QftxaMyiqm1PzLdHNZa8mTeLz9xmFWm0Q7qLbPIeLxbeBETAd79TuNbGs
   JKwnJNwX49BOzJ7bh7dyFhGMHfuOMLOEJDM6Le/RdJUwxV0jFnioO4Jyb
   jicYbe06cAtDd+ckXLNq1D0IjGz4/0FQ0/paDDRjR2VELeDiiBcHvh2mP
   X2c+vvJyK8mtpmcttx2V7OGYt51BR7+Rl3z0JBLsho1HmZFe9W/nQftn9
   XbY59C4xvGmr8SEPQdGBZwjDow9fGThsqPmXd5SUraKLFrVgAhNvMs6lv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263473468"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="263473468"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 01:48:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="575996084"
Received: from majiangy-mobl.ccr.corp.intel.com ([10.249.173.141])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 01:48:32 -0700
Message-ID: <a7861e9a6a311f09c03b2e6e47dd4d3283cb58e2.camel@intel.com>
Subject: Re: [PATCH v1] thermal/core: change mm alloc method to avoid kernel
 warning
From:   Zhang Rui <rui.zhang@intel.com>
To:     Junwen Wu <wudaemon@163.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Tue, 19 Apr 2022 16:48:29 +0800
In-Reply-To: <20220417125601.18535-1-wudaemon@163.com>
References: <20220417125601.18535-1-wudaemon@163.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-17 at 12:56 +0000, Junwen Wu wrote:
> Very high cooling device max state value makes cooling device stats
> buffer allocation fails,like below.Using kzvalloc instead of kzalloc
> can avoid this issue.

When a cooling device has big max_state, this patch can get ride of the
warning here, but still we end up with the read failure of the
trans_table in sysfs because it is larger than PAGE_SIZE.

$ cat /sys/class/thermal/cooling_device8/stats/trans_table 
cat: /sys/class/thermal/cooling_device8/stats/trans_table: File too
large

IMO, unless we can fix both places, I'd suggest we skip allocating and
creating the broken trans_table attr. Like a prototype patch below

thanks,
rui

From 2a504596d06a91d6f01d25eee71ebcdeff164e59 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Tue, 19 Apr 2022 16:40:04 +0800
Subject: [PATCH] thermal: thermal_stats: skip broken trans_table

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sysfs.c | 40 ++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index f154bada2906..d917489f89bc 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -686,7 +686,8 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 		goto unlock;
 
 	update_time_in_state(stats);
-	stats->trans_table[stats->state * stats->max_states + new_state]++;
+	if (stats->trans_table)
+		stats->trans_table[stats->state * stats->max_states + new_state]++;
 	stats->state = new_state;
 	stats->total_trans++;
 
@@ -741,8 +742,9 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
 
 	stats->total_trans = 0;
 	stats->last_time = ktime_get();
-	memset(stats->trans_table, 0,
-	       states * states * sizeof(*stats->trans_table));
+	if (stats->trans_table)
+		memset(stats->trans_table, 0,
+		       states * states * sizeof(*stats->trans_table));
 
 	for (i = 0; i < stats->max_states; i++)
 		stats->time_in_state[i] = ktime_set(0, 0);
@@ -805,7 +807,6 @@ static struct attribute *cooling_device_stats_attrs[] = {
 	&dev_attr_total_trans.attr,
 	&dev_attr_time_in_state_ms.attr,
 	&dev_attr_reset.attr,
-	&dev_attr_trans_table.attr,
 	NULL
 };
 
@@ -814,11 +815,25 @@ static const struct attribute_group cooling_device_stats_attr_group = {
 	.name = "stats"
 };
 
+static struct attribute *cooling_device_stats_ext_attrs[] = {
+	&dev_attr_total_trans.attr,
+	&dev_attr_time_in_state_ms.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_trans_table.attr,
+	NULL
+};
+
+static const struct attribute_group cooling_device_stats_ext_attr_group = {
+	.attrs = cooling_device_stats_ext_attrs,
+	.name = "stats"
+};
+
 static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 {
 	struct cooling_dev_stats *stats;
 	unsigned long states;
-	int var;
+	int var, size;
+	bool ext = false;
 
 	if (cdev->ops->get_max_state(cdev, &states))
 		return;
@@ -827,14 +842,20 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 
 	var = sizeof(*stats);
 	var += sizeof(*stats->time_in_state) * states;
-	var += sizeof(*stats->trans_table) * states * states;
+	size = sizeof(*stats->trans_table) * states * states;
+
+	if (var + size < PAGE_SIZE) {
+		ext = true;
+		var += size;
+	}
 
 	stats = kzalloc(var, GFP_KERNEL);
 	if (!stats)
 		return;
 
 	stats->time_in_state = (ktime_t *)(stats + 1);
-	stats->trans_table = (unsigned int *)(stats->time_in_state + states);
+	if (ext)
+		stats->trans_table = (unsigned int *)(stats->time_in_state + states);
 	cdev->stats = stats;
 	stats->last_time = ktime_get();
 	stats->max_states = states;
@@ -843,7 +864,10 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 
 	/* Fill the empty slot left in cooling_device_attr_groups */
 	var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
-	cooling_device_attr_groups[var] = &cooling_device_stats_attr_group;
+	if (ext)
+		cooling_device_attr_groups[var] = &cooling_device_stats_ext_attr_group;
+	else
+		cooling_device_attr_groups[var] = &cooling_device_stats_attr_group;
 }
 
 static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
-- 
2.17.1

> 
> [    7.392644]WARNING: CPU: 7 PID: 1747 at mm/page_alloc.c:5090
> __alloc_pages_nodemask+0x1c0/0x3dc
> [    7.392989]Call trace:
> [    7.392992]__alloc_pages_nodemask+0x1c0/0x3dc
> [    7.392995]kmalloc_order+0x54/0x358
> [    7.392997]kmalloc_order_trace+0x34/0x1bc
> [    7.393001]__kmalloc+0x5cc/0x9c8
> [    7.393005]thermal_cooling_device_setup_sysfs+0x90/0x218
> [    7.393008]__thermal_cooling_device_register+0x160/0x7a4
> [    7.393012]thermal_of_cooling_device_register+0x14/0x24
> [    7.393140]backlight_cdev_register+0x88/0x100 [msm_drm]
> 
> 
> Signed-off-by: Junwen Wu <wudaemon@163.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c
> b/drivers/thermal/thermal_sysfs.c
> index f154bada2906..361e0d0c241b 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -829,7 +829,7 @@ static void cooling_device_stats_setup(struct
> thermal_cooling_device *cdev)
>  	var += sizeof(*stats->time_in_state) * states;
>  	var += sizeof(*stats->trans_table) * states * states;
>  
> -	stats = kzalloc(var, GFP_KERNEL);
> +	stats = kvzalloc(var, GFP_KERNEL);
>  	if (!stats)
>  		return;
>  
> @@ -848,7 +848,7 @@ static void cooling_device_stats_setup(struct
> thermal_cooling_device *cdev)
>  
>  static void cooling_device_stats_destroy(struct
> thermal_cooling_device *cdev)
>  {
> -	kfree(cdev->stats);
> +	kvfree(cdev->stats);
>  	cdev->stats = NULL;
>  }
>  

