Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F79757FEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiGYLvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiGYLvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:51:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4342EB7C3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658749899; x=1690285899;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cvTo8GqvnQFWmbF6eR8Vwn2L+k6eSHKRRyfsXDj1nVs=;
  b=U2lkvg3J0ehghMvQMYaVQ64LtKki8hGS5szmhotcxWcKzM8JrFSsRqMq
   zvcQm6+eBUxEejKWVtkPmp9hdoDyXba900f/CO9gL6onY1v66ZW33k0SQ
   VIlys6tRummRiCrVCLcIn5Kx1e/G4vlb0IAKMr0wjLZxYAHxs7bdPg0My
   DSiHlnvw9eMnv2xC+lPeZdNGVyZRjXyXYjek6mg843w/HKs5UXEbuw7AJ
   XI25j9dRIk6/pgCSGjBAy8QizRmWYbVED0muaXQFzys6KT7soF6rXom+e
   OhCI6pumXvPw/xtZowKtJv9T34Dje+ePRw6FEIAN0lY7ouqFDbDtCzPTs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="285227645"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="285227645"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 04:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="549961671"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2022 04:51:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFwcO-00056U-0g;
        Mon, 25 Jul 2022 11:51:24 +0000
Date:   Mon, 25 Jul 2022 19:50:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: arch/x86/events/core.c:1869:25: warning: Local variable 'pmu'
 shadows outer variable [shadowVariable]
Message-ID: <202207251957.44kuib07-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: a9c81ccdf52dd73a20178c40bca34cf52991fdea perf/x86: Add structures for the attributes of Hybrid PMUs
date:   1 year, 3 months ago
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout a9c81ccdf52dd73a20178c40bca34cf52991fdea
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cppcheck warnings: (new ones prefixed by >>)
                                         ^
   arch/x86/events/core.c:766:20: note: Using pointer that is a temporary.
    if (WARN_ON_ONCE(!cpuc->pmu))
                      ^
>> arch/x86/events/core.c:1869:25: warning: Local variable 'pmu' shadows outer variable [shadowVariable]
    struct x86_hybrid_pmu *pmu;
                           ^
   arch/x86/events/core.c:48:19: note: Shadowed declaration
   static struct pmu pmu;
                     ^
   arch/x86/events/core.c:1869:25: note: Shadow variable
    struct x86_hybrid_pmu *pmu;
                           ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

                                         ^
   arch/x86/events/core.c:766:20: note: Using pointer that is a temporary.
    if (WARN_ON_ONCE(!cpuc->pmu))
                      ^
   arch/x86/events/core.c:769:9: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
    return cpuc->pmu;
           ^
   arch/x86/events/core.c:760:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:766:18: note: Assuming condition is false
    if (WARN_ON_ONCE(!cpuc->pmu))
                    ^
   arch/x86/events/core.c:760:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:769:9: note: Using pointer that is a temporary.
    return cpuc->pmu;
           ^
   arch/x86/events/core.c:1561:56: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
    pr_info("CPU#%d: active:     %016llxn", cpu, *(u64 *)cpuc->active_mask);
                                                          ^
   arch/x86/events/core.c:1529:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:1536:6: note: Assuming condition is false
    if (!num_counters)
        ^
   arch/x86/events/core.c:1529:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:1561:56: note: Using pointer that is a temporary.
    pr_info("CPU#%d: active:     %016llxn", cpu, *(u64 *)cpuc->active_mask);
                                                          ^
   arch/x86/events/core.c:1577:35: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
     if (fixed_counter_disabled(idx, cpuc->pmu))
                                     ^
   arch/x86/events/core.c:1529:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:1536:6: note: Assuming condition is false
    if (!num_counters)
        ^
   arch/x86/events/core.c:1529:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:1577:35: note: Using pointer that is a temporary.
     if (fixed_counter_disabled(idx, cpuc->pmu))
                                     ^
   arch/x86/events/core.c:1760:3: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
     cpuc->kfree_on_online[i] = NULL;
     ^
   arch/x86/events/core.c:1756:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:1756:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:1760:3: note: Using pointer that is a temporary.
     cpuc->kfree_on_online[i] = NULL;
     ^
   arch/x86/events/core.c:1779:9: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
     kfree(cpuc->kfree_on_online[i]);
           ^
   arch/x86/events/core.c:1775:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:1775:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:1779:9: note: Using pointer that is a temporary.
     kfree(cpuc->kfree_on_online[i]);
           ^
   arch/x86/events/core.c:1780:3: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
     cpuc->kfree_on_online[i] = NULL;
     ^
   arch/x86/events/core.c:1775:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:1775:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:1780:3: note: Using pointer that is a temporary.
     cpuc->kfree_on_online[i] = NULL;
     ^
   arch/x86/events/core.c:2113:3: warning: Same expression on both sides of '-'. [duplicateExpression]
     __EVENT_CONSTRAINT(0, (1ULL << x86_pmu.num_counters) - 1,
     ^
   arch/x86/events/core.c:2163:26: warning: Local variable 'hybrid_pmu' shadows outer function [shadowFunction]
     struct x86_hybrid_pmu *hybrid_pmu;
                            ^
   arch/x86/events/perf_event.h:660:47: note: Shadowed declaration
   static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
                                                 ^
   arch/x86/events/core.c:2163:26: note: Shadow variable
     struct x86_hybrid_pmu *hybrid_pmu;
                            ^

vim +/pmu +1869 arch/x86/events/core.c

  1862	
  1863	ssize_t events_hybrid_sysfs_show(struct device *dev,
  1864					 struct device_attribute *attr,
  1865					 char *page)
  1866	{
  1867		struct perf_pmu_events_hybrid_attr *pmu_attr =
  1868			container_of(attr, struct perf_pmu_events_hybrid_attr, attr);
> 1869		struct x86_hybrid_pmu *pmu;
  1870		const char *str, *next_str;
  1871		int i;
  1872	
  1873		if (hweight64(pmu_attr->pmu_type) == 1)
  1874			return sprintf(page, "%s", pmu_attr->event_str);
  1875	
  1876		/*
  1877		 * Hybrid PMUs may support the same event name, but with different
  1878		 * event encoding, e.g., the mem-loads event on an Atom PMU has
  1879		 * different event encoding from a Core PMU.
  1880		 *
  1881		 * The event_str includes all event encodings. Each event encoding
  1882		 * is divided by ";". The order of the event encodings must follow
  1883		 * the order of the hybrid PMU index.
  1884		 */
  1885		pmu = container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
  1886	
  1887		str = pmu_attr->event_str;
  1888		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
  1889			if (!(x86_pmu.hybrid_pmu[i].cpu_type & pmu_attr->pmu_type))
  1890				continue;
  1891			if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
  1892				next_str = strchr(str, ';');
  1893				if (next_str)
  1894					return snprintf(page, next_str - str + 1, "%s", str);
  1895				else
  1896					return sprintf(page, "%s", str);
  1897			}
  1898			str = strchr(str, ';');
  1899			str++;
  1900		}
  1901	
  1902		return 0;
  1903	}
  1904	EXPORT_SYMBOL_GPL(events_hybrid_sysfs_show);
  1905	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
