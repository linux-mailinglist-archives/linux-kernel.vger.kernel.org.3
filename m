Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7E487BD0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiAGSJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:09:04 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:44485 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240468AbiAGSJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641578942; x=1673114942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BmhPFW1q0OdAFsLIXcbkLXvE9OceVGBzXPJvOxfchrY=;
  b=nRuo298CEn/tkSA6um9Sk0UgUt49lObcX2VAS5CXvnW5NuXjEshXet72
   c4xNTqwKB8bGUbIvEqFiZXtV92Vog3mDE3Nzj2hp5DdFzKzaoJ39LKXWO
   aTzB49DmbX+peCfQL4kYVs6gJ7xuzlFoYsvNtuuFmlIS/bZyy6Z8dwteH
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jan 2022 10:09:02 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 10:09:02 -0800
Received: from blr-ubuntu-498.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 7 Jan 2022 10:08:56 -0800
From:   Pintu Kumar <quic_pintu@quicinc.com>
To:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <quic_pintu@quicinc.com>, <linux-mm@kvack.org>,
        <ebiederm@xmission.com>, <christian.brauner@ubuntu.com>,
        <sfr@canb.auug.org.au>, <legion@kernel.org>, <sashal@kernel.org>,
        <gorcunov@gmail.com>, <chris.hyser@oracle.com>,
        <ccross@google.com>, <pcc@google.com>, <dave@stgolabs.net>,
        <caoxiaofeng@yulong.com>, <david@redhat.com>,
        <pintu.ping@gmail.com>, <vbabka@suse.cz>
CC:     <linux-api@vger.kernel.org>
Subject: [PATCH v2] sysinfo: include availram field in sysinfo struct
Date:   Fri, 7 Jan 2022 23:37:34 +0530
Message-ID: <1641578854-14232-1-git-send-email-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
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
 include/uapi/linux/sysinfo.h | 3 ++-
 kernel/sys.c                 | 4 ++++
 mm/page_alloc.c              | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
index 435d5c2..fe84c6a 100644
--- a/include/uapi/linux/sysinfo.h
+++ b/include/uapi/linux/sysinfo.h
@@ -19,7 +19,8 @@ struct sysinfo {
 	__kernel_ulong_t totalhigh;	/* Total high memory size */
 	__kernel_ulong_t freehigh;	/* Available high memory size */
 	__u32 mem_unit;			/* Memory unit size in bytes */
-	char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];	/* Padding: libc5 uses this.. */
+	__kernel_ulong_t availram;	/* Memory available for allocation */
+	char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];	/* Padding: libc5 uses this.. */
 };
 
 #endif /* _LINUX_SYSINFO_H */
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

