Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328675ABD9B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 09:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiICHOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 03:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiICHOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 03:14:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E122DF33;
        Sat,  3 Sep 2022 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662189270; x=1693725270;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0VMaUf39Dl5/S2OcKDeWvPX+WLyOasn5kDclyX6/3Mo=;
  b=jLqB61ue/kUkZIiussW/zZUfjoQ22vTu8es6jtSkBb+OnCArR58hx2OM
   TpUhStvo0tD39SepGcQX8LXbNAP19oAKyJ+ZkKo8ETqCVXcekDAV7cDNO
   /nFbYUgsbQPPBx9oi/a6p8a3HXepwbtS7qR5SmIJ9dg36/JUKrO3SJAmt
   RrPntgMScVcbjWTuwA6ILesVtEWgsWUDX8K/b1/lEQBEyJOuJozUxYULg
   WBVJtEZwh5wMaOweiNmze9/eA6QSKMkBfHziau/GAYvjAJXWBN34H/90n
   5eYZwORtT4qqTYkKrQzG911roNOm6jeBk/br+O+UvdNNZ/4qsivh9bleM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="276536234"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="276536234"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 00:14:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="674642960"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.118])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 00:14:28 -0700
Message-ID: <ca905aa0-9d7b-d6d8-c789-2bd22057619b@intel.com>
Date:   Sat, 3 Sep 2022 10:14:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: perf top -p broken for multithreaded processes since 5.19
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     =?UTF-8?B?VG9tw6HFoSBUcm5rYQ==?= <trnka@scm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <10137382.nUPlyArG6x@mintaka.ncbr.muni.cz>
 <2fd9b620-e9a8-9cd9-1b4a-6b13d829b2ae@intel.com>
 <YxJW19MwaMOb8D30@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YxJW19MwaMOb8D30@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/09/22 22:17, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 02, 2022 at 05:50:22PM +0300, Adrian Hunter escreveu:
>> On 2/09/22 17:46, Tomáš Trnka wrote:
>>> Hello,
>>>
>>> A bug in perf v5.19 and newer completely breaks monitoring multithreaded
>>> processes using "perf top -p". The tool fails to start with "Failed to mmap
>>> with 22 (Invalid argument)". It still seems to work fine on single-threaded
>>> processes. "perf record" is also unaffected.
>>
>> It has been reported here:
>>
>> 	https://bugzilla.kernel.org/show_bug.cgi?id=216441
> 
> If I do:
> 
> ⬢[acme@toolbox perf-urgent]$ git log -2
> commit dfeb0bc60782471c293938e71b1a1117cfac2cb3 (HEAD -> perf/urgent)
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri Sep 2 16:15:39 2022 -0300
> 
>     Revert "libperf evlist: Check nr_mmaps is correct"
> 
>     This reverts commit 4ce47d842d4c16c07b135b8a7975b8f0672bcc0e.
> 
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> commit 78cd283f6b8ab701cb35eafd5af8140560a88f16
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri Sep 2 16:13:41 2022 -0300
> 
>     Revert "libperf evlist: Allow mixing per-thread and per-cpu mmaps"
> 
>     This reverts commit ae4f8ae16a07896403c90305d4b9be27f657c1fc.
> 
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ⬢[acme@toolbox perf-urgent]$
> 
> It works again, Tomáš can you please try doing this to see if this works
> for you?
> 

This is the fix I have so far.  I would like to test it some more though.

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Sat, 3 Sep 2022 10:05:08 +0300
Subject: [PATCH] libperf evlist: Fix per-thread mmaps for multi-threaded
 targets

Offending commit did not consider the different set-output rules for
per-thread mmaps i.e. in the per-thread case set-output is used for
mmaps of the same thread not the same cpu.

This was not immediately noticed because it only happens with
multi-threaded targets and we do not have a test for that yet.

Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index e6c98a6e3908e..24280c887520c 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -486,6 +486,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			if (ops->idx)
 				ops->idx(evlist, evsel, mp, idx);
 
+			pr_debug("idx %d: mmapping fd %d\n", idx, *output);
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 
@@ -494,6 +495,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			if (!idx)
 				perf_evlist__set_mmap_first(evlist, map, overwrite);
 		} else {
+			pr_debug("idx %d: set output fd %d -> %d\n", idx, fd, *output);
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
 				return -1;
 
@@ -519,6 +521,47 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	return 0;
 }
 
+static int
+mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+		struct perf_mmap_param *mp)
+{
+	int nr_threads = perf_thread_map__nr(evlist->threads);
+	int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
+	int cpu, thread, idx = 0;
+	int nr_mmaps = 0;
+
+	pr_debug("%s: nr cpu values (may include -1) %d nr threads %d\n", __func__, nr_cpus, nr_threads);
+
+	/* per-thread mmaps */
+	for (thread = 0; thread < nr_threads; thread++, idx++) {
+		int output = -1;
+		int output_overwrite = -1;
+
+		if (mmap_per_evsel(evlist, ops, idx, mp, 0, thread, &output,
+				   &output_overwrite, &nr_mmaps))
+			goto out_unmap;
+	}
+
+	/* system-wide mmaps i.e. per-cpu */
+	for (cpu = 1; cpu < nr_cpus; cpu++, idx ++) {
+		int output = -1;
+		int output_overwrite = -1;
+
+		if (mmap_per_evsel(evlist, ops, idx, mp, cpu, 0, &output,
+				   &output_overwrite, &nr_mmaps))
+			goto out_unmap;
+	}
+
+	if (nr_mmaps != evlist->nr_mmaps)
+		pr_err("Miscounted nr_mmaps %d vs %d\n", nr_mmaps, evlist->nr_mmaps);
+
+	return 0;
+
+out_unmap:
+	perf_evlist__munmap(evlist);
+	return -1;
+}
+
 static int
 mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	     struct perf_mmap_param *mp)
@@ -528,6 +571,8 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	int nr_mmaps = 0;
 	int cpu, thread;
 
+	pr_debug("%s: nr cpu values %d nr threads %d\n", __func__, nr_cpus, nr_threads);
+
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		int output = -1;
 		int output_overwrite = -1;
@@ -569,6 +614,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
 			  struct perf_mmap_param *mp)
 {
+	const struct perf_cpu_map *cpus = evlist->all_cpus;
 	struct perf_evsel *evsel;
 
 	if (!ops || !ops->get || !ops->mmap)
@@ -588,6 +634,9 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
+	if (perf_cpu_map__empty(cpus))
+		return mmap_per_thread(evlist, ops, mp);
+
 	return mmap_per_cpu(evlist, ops, mp);
 }
 
-- 
2.34.1



