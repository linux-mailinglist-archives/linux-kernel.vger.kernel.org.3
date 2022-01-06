Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B204866C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbiAFPfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:35:11 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:44967 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240432AbiAFPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641483310; x=1673019310;
  h=from:to:subject:date:message-id:mime-version;
  bh=zE11GEEqGIvDeT3m5AvaWeOmWoeEO/rQSHvRb9jM9uQ=;
  b=HcmwEFq0Cwevvpi4/oLce4vhKiJ9HxgWeZmnq4G8QC66uO5wDCeV5mF5
   yClTNontlEItuR9skdq7wyFM+J+UaIDnNZxgXdN2g7jolmOAqqoyBTWs6
   q67Z9P2WI60qRnlQ2NmH4gpFkou5K5dJzPMO0ISk9R80P9l2F8rPH2a4f
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jan 2022 07:35:10 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 07:35:09 -0800
Received: from blr-ubuntu-498.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 6 Jan 2022 07:35:04 -0800
From:   Pintu Kumar <quic_pintu@quicinc.com>
To:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <quic_pintu@quicinc.com>, <linux-mm@kvack.org>,
        <ebiederm@xmission.com>, <christian.brauner@ubuntu.com>,
        <sfr@canb.auug.org.au>, <legion@kernel.org>, <sashal@kernel.org>,
        <gorcunov@gmail.com>, <chris.hyser@oracle.com>,
        <ccross@google.com>, <pcc@google.com>, <dave@stgolabs.net>,
        <caoxiaofeng@yulong.com>, <david@redhat.com>,
        <pintu.ping@gmail.com>
Subject: [PATCH] sysinfo: include availram field in sysinfo struct
Date:   Thu, 6 Jan 2022 21:04:10 +0530
Message-ID: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysinfo member does not have any "available ram" field and
the bufferram field is not much helpful either, to get a rough
estimate of available ram needed for allocation.

One needs to parse MemAvailable field separately from /proc/meminfo
to get this info instead of directly getting if from sysinfo itself.

Thus, this patch introduce a new field as availram in sysinfo
so that all the info total/free/available can be retrieved from
one place itself.

There are couple of places in kernel as well where this can be improved.
For example:
In fs/proc/meminfo.c:
meminfo_proc_show:
   si_meminfo(&i);
   available = si_mem_available();
Now with this change the second call be avoided.
Thus, we can directly do:
show_val_kb(m, "MemAvailable:   ", i.availram);

Note, this also requires update in procfs for free and other commands.
Like in free command as well we frist call sysinfo then again parse
/proc/meminfo to get available field.
This can be avoided too with higher kernel version.

A sample output with single sysinfo call is shown below:
Total RAM: 248376 kB
 Free RAM: 231540 kB
Avail RAM: 230448 kB

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
---
 include/uapi/linux/sysinfo.h | 1 +
 kernel/sys.c                 | 4 ++++
 mm/page_alloc.c              | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
index 435d5c2..6e77e90 100644
--- a/include/uapi/linux/sysinfo.h
+++ b/include/uapi/linux/sysinfo.h
@@ -12,6 +12,7 @@ struct sysinfo {
 	__kernel_ulong_t freeram;	/* Available memory size */
 	__kernel_ulong_t sharedram;	/* Amount of shared memory */
 	__kernel_ulong_t bufferram;	/* Memory used by buffers */
+	__kernel_ulong_t availram;	/* Memory available for allocation */
 	__kernel_ulong_t totalswap;	/* Total swap space size */
 	__kernel_ulong_t freeswap;	/* swap space still available */
 	__u16 procs;		   	/* Number of current processes */
diff --git a/kernel/sys.c b/kernel/sys.c
index ecc4cf0..7059515 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2671,6 +2671,7 @@ static int do_sysinfo(struct sysinfo *info)
 	info->freeram <<= bitcount;
 	info->sharedram <<= bitcount;
 	info->bufferram <<= bitcount;
+	info->availram <<= bitcount;
 	info->totalswap <<= bitcount;
 	info->freeswap <<= bitcount;
 	info->totalhigh <<= bitcount;
@@ -2700,6 +2701,7 @@ struct compat_sysinfo {
 	u32 freeram;
 	u32 sharedram;
 	u32 bufferram;
+	u32 availram;
 	u32 totalswap;
 	u32 freeswap;
 	u16 procs;
@@ -2732,6 +2734,7 @@ COMPAT_SYSCALL_DEFINE1(sysinfo, struct compat_sysinfo __user *, info)
 		s.freeram >>= bitcount;
 		s.sharedram >>= bitcount;
 		s.bufferram >>= bitcount;
+		s.availram >>= bitcount;
 		s.totalswap >>= bitcount;
 		s.freeswap >>= bitcount;
 		s.totalhigh >>= bitcount;
@@ -2747,6 +2750,7 @@ COMPAT_SYSCALL_DEFINE1(sysinfo, struct compat_sysinfo __user *, info)
 	s_32.freeram = s.freeram;
 	s_32.sharedram = s.sharedram;
 	s_32.bufferram = s.bufferram;
+	s_32.availram = s.availram;
 	s_32.totalswap = s.totalswap;
 	s_32.freeswap = s.freeswap;
 	s_32.procs = s.procs;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b5d62e1..5013c75 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5786,6 +5786,7 @@ void si_meminfo(struct sysinfo *val)
 	val->sharedram = global_node_page_state(NR_SHMEM);
 	val->freeram = global_zone_page_state(NR_FREE_PAGES);
 	val->bufferram = nr_blockdev_pages();
+	val->availram = si_mem_available();
 	val->totalhigh = totalhigh_pages();
 	val->freehigh = nr_free_highpages();
 	val->mem_unit = PAGE_SIZE;
@@ -5807,6 +5808,7 @@ void si_meminfo_node(struct sysinfo *val, int nid)
 	val->totalram = managed_pages;
 	val->sharedram = node_page_state(pgdat, NR_SHMEM);
 	val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
+	val->availram = si_mem_available();
 #ifdef CONFIG_HIGHMEM
 	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
 		struct zone *zone = &pgdat->node_zones[zone_type];
-- 
2.7.4

