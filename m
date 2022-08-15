Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17790593214
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiHOPhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiHOPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:37:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A8013D1D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660577859; x=1692113859;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cx6ub1fiFN3r2E7pXAGJqaaG5Bzu9YbO0Zc5o5K8Ip0=;
  b=e85lzQH5lttXw4BW8v2FkPDksWwBzhGTtY2+ZzomJKQEK7kSXQwWY9ax
   1d2/Pd/jSs+w+HOv1RSPTY3742aJVJVtLQZxWzs1+VouQYOIL1rSUrRfN
   8MIW0s7ix5NJ+fR1AvmGeqsWaf/NYSfHTC9qLAtnCXS1huefZGmdEvNSq
   ym1DM4k00RxO53lP1HvtEgUjJ4BiOzN/d6N/wQRqMiSOoK928yazhkFmd
   BalTSkLKBw7vmwS3Dou76Wb01MVphfHXyZF7XzqXlTa/ZFxvUq6mrlXLS
   Vclu7TZNvd18lXvyrBs2NlvWnzLywa0hl0d7b7SbO2CSdyAA7jKgR8EOL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="275040378"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="275040378"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 08:37:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="557327726"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2022 08:37:37 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNc9o-00016X-1T;
        Mon, 15 Aug 2022 15:37:36 +0000
Date:   Mon, 15 Aug 2022 23:36:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [akpm-mm:mm-unstable 26/98] fs/libfs.c:1231:47: warning: Local
 variable 'anon_aops' shadows outer variable [shadowVariable]
Message-ID: <202208152329.qv11tHmt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   d2af7b221349ff6241e25fa8c67bcfae2b360700
commit: e4ab315810850b93cac381d6f4efd532f45a790e [26/98] procfs: add 'path' to /proc/<pid>/fdinfo/
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout e4ab315810850b93cac381d6f4efd532f45a790e
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cppcheck warnings: (new ones prefixed by >>)
>> init/main.c:333:18: warning: Pointer addition with NULL pointer. [nullPointerArithmetic]
    char *end = buf + size;
                    ^
   init/main.c:376:28: note: Calling function 'xbc_snprint_cmdline', 1st argument 'NULL' value is 0
    len = xbc_snprint_cmdline(NULL, 0, root);
                              ^
   init/main.c:333:18: note: Null pointer addition
    char *end = buf + size;
                    ^
>> fs/libfs.c:1231:47: warning: Local variable 'anon_aops' shadows outer variable [shadowVariable]
    static const struct address_space_operations anon_aops = {
                                                 ^
   fs/libfs.c:1220:46: note: Shadowed declaration
   static const struct address_space_operations anon_aops = {
                                                ^
   fs/libfs.c:1231:47: note: Shadow variable
    static const struct address_space_operations anon_aops = {
                                                 ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> init/main.c:736:28: warning: Comparing pointers that point to different objects [comparePointers]
    for (p = __setup_start; p < __setup_end; p++) {
                              ^
   init/main.c:197:38: note: Variable declared here.
   extern const struct obs_kernel_param __setup_start[], __setup_end[];
                                        ^
   init/main.c:736:11: note: Array decayed to pointer here.
    for (p = __setup_start; p < __setup_end; p++) {
             ^
   init/main.c:197:55: note: Variable declared here.
   extern const struct obs_kernel_param __setup_start[], __setup_end[];
                                                         ^
   init/main.c:736:30: note: Array decayed to pointer here.
    for (p = __setup_start; p < __setup_end; p++) {
                                ^
   init/main.c:736:28: note: Comparing pointers that point to different objects
    for (p = __setup_start; p < __setup_end; p++) {
                              ^
   init/main.c:1412:33: warning: Comparing pointers that point to different objects [comparePointers]
    for (fn = __initcall_start; fn < __initcall0_start; fn++)
                                   ^
   init/main.c:1316:25: note: Variable declared here.
   extern initcall_entry_t __initcall_start[];
                           ^
   init/main.c:1412:12: note: Array decayed to pointer here.
    for (fn = __initcall_start; fn < __initcall0_start; fn++)
              ^
   init/main.c:1317:25: note: Variable declared here.
   extern initcall_entry_t __initcall0_start[];
                           ^
   init/main.c:1412:35: note: Array decayed to pointer here.
    for (fn = __initcall_start; fn < __initcall0_start; fn++)
                                     ^
   init/main.c:1412:33: note: Comparing pointers that point to different objects
    for (fn = __initcall_start; fn < __initcall0_start; fn++)
                                   ^
>> init/main.c:1215:31: warning: Uninitialized variable: entry->buf [uninitvar]
     if (!strcmp(fn_name, entry->buf)) {
                                 ^
   init/main.c:1202:16: note: Assuming condition is false
    if (list_empty(&blacklisted_initcalls))
                  ^
   init/main.c:1215:31: note: Uninitialized variable: entry->buf
     if (!strcmp(fn_name, entry->buf)) {
                                 ^
--
>> kernel/sysctl.c:224:52: warning: Parameter 'ppos' can be declared with const [constParameter]
   static bool proc_first_pos_non_zero_ignore(loff_t *ppos,
                                                      ^
>> kernel/sysctl.c:571:19: warning: Parameter 'lenp' can be declared with const [constParameter]
             size_t *lenp, loff_t *ppos,
                     ^
>> kernel/sysctl.c:787:41: warning: Parameter 'table' can be declared with const [constParameter]
   static int proc_taint(struct ctl_table *table, int write,
                                           ^
>> kernel/sysctl.c:857:36: warning: Uninitialized variable: tmp [uninitvar]
     if ((param->min && *param->min > tmp) ||
                                      ^
   kernel/sysctl.c:853:6: note: Assuming condition is false
    if (ret)
        ^
   kernel/sysctl.c:857:36: note: Uninitialized variable: tmp
     if ((param->min && *param->min > tmp) ||
                                      ^
   kernel/sysctl.c:922:36: warning: Uninitialized variable: tmp [uninitvar]
     if ((param->min && *param->min > tmp) ||
                                      ^
   kernel/sysctl.c:918:6: note: Assuming condition is false
    if (ret)
        ^
   kernel/sysctl.c:922:36: note: Uninitialized variable: tmp
     if ((param->min && *param->min > tmp) ||
                                      ^
   kernel/sysctl.c:1259:36: warning: Uninitialized variable: tmp [uninitvar]
     if ((param->min && *param->min > tmp) ||
                                      ^
   kernel/sysctl.c:1255:6: note: Assuming condition is false
    if (ret)
        ^
   kernel/sysctl.c:1259:36: note: Uninitialized variable: tmp
     if ((param->min && *param->min > tmp) ||
                                      ^
>> mm/vmstat.c:1420:53: warning: Parameter 'pos' can be declared with const [constParameter]
   static void *frag_start(struct seq_file *m, loff_t *pos)
                                                       ^
>> mm/vmstat.c:1661:68: warning: Parameter 'zone' can be declared with const [constParameter]
   static bool is_zone_first_populated(pg_data_t *pgdat, struct zone *zone)
                                                                      ^
   mm/vmstat.c:1791:55: warning: Parameter 'pos' can be declared with const [constParameter]
   static void *vmstat_start(struct seq_file *m, loff_t *pos)
                                                         ^
>> mm/dmapool.c:479:65: warning: Parameter 'match_data' can be declared with const [constParameter]
   static int dmam_pool_match(struct device *dev, void *res, void *match_data)
                                                                   ^
>> mm/dmapool.c:88:20: warning: Uninitialized variable: page->in_use [uninitvar]
      blocks += page->in_use;
                      ^
>> mm/dmapool.c:95:21: warning: Uninitialized variable: pool->allocation [uninitvar]
        pages * (pool->allocation / pool->size),
                       ^
>> mm/dmapool.c:326:13: warning: Uninitialized variable: page->offset [uninitvar]
     if (page->offset < pool->allocation)
               ^
>> mm/dmapool.c:387:19: warning: Uninitialized variable: page->dma [uninitvar]
     if (dma < page->dma)
                     ^
>> mm/madvise.c:1485:6: warning: Redundant assignment of 'ret' to itself. [selfAssignment]
    ret = (total_len - iov_iter_count(&iter)) ? : ret;
        ^
>> mm/madvise.c:125:28: warning: Parameter 'anon_name' can be declared with const [constParameter]
        struct anon_vma_name *anon_name)
                              ^
--
>> fs/proc/task_mmu.c:127:50: warning: Parameter 'ppos' can be declared with const [constParameter]
   static void *m_start(struct seq_file *m, loff_t *ppos)
                                                    ^
>> fs/proc/task_mmu.c:1349:64: warning: Parameter 'pme' can be declared with const [constParameter]
   static int add_to_pagemap(unsigned long addr, pagemap_entry_t *pme,
                                                                  ^
>> kernel/sched/fair.c:11575:62: warning: Same value in both branches of ternary operator. [duplicateValueTernary]
    update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
                                                                ^
>> kernel/sched/fair.c:7461:1: warning: Label 'done' is not used. There is #if in function body so the label might be used in code that is removed by the preprocessor. [unusedLabelConfiguration]
   done: __maybe_unused;
   ^
>> kernel/sched/sched.h:2058:67: warning: Parameter 'p' can be declared with const [constParameter]
   static inline int task_current(struct rq *rq, struct task_struct *p)
                                                                     ^
>> kernel/sched/fair.c:5149:25: warning: Uninitialized variables: cfs_rq.load, cfs_rq.nr_running, cfs_rq.h_nr_running, cfs_rq.idle_nr_running, cfs_rq.idle_h_nr_running, cfs_rq.exec_clock, cfs_rq.min_vruntime, cfs_rq.min_vruntime_copy, cfs_rq.tasks_timeline, cfs_rq.curr, cfs_rq.next, cfs_rq.last, cfs_rq.skip [uninitvar]
     struct rq *rq = rq_of(cfs_rq);
                           ^
   kernel/sched/fair.c:5149:25: warning: Uninitialized variables: cfs_rq.load, cfs_rq.nr_running, cfs_rq.h_nr_running, cfs_rq.idle_nr_running, cfs_rq.idle_h_nr_running, cfs_rq.exec_clock, cfs_rq.min_vruntime, cfs_rq.min_vruntime_copy, cfs_rq.tasks_timeline, cfs_rq.curr, cfs_rq.next, cfs_rq.last, cfs_rq.skip, cfs_rq.rq, cfs_rq.on_list, cfs_rq.leaf_cfs_rq_list, cfs_rq.tg, cfs_rq.idle, cfs_rq.runtime_enabled, cfs_rq.runtime_remaining, cfs_rq.throttled_pelt_idle, cfs_rq.throttled_pelt_idle_copy, cfs_rq.throttled_clock, cfs_rq.throttled_clock_pelt, cfs_rq.throttled_clock_pelt_time, cfs_rq.throttled, cfs_rq.throttle_count, cfs_rq.throttled_list [uninitvar]
     struct rq *rq = rq_of(cfs_rq);
                           ^
>> kernel/sched/fair.c:6481:16: warning: Local variable 'task_util' shadows outer function [shadowFunction]
    unsigned long task_util, best_cap = 0;
                  ^
   kernel/sched/fair.c:4093:29: note: Shadowed declaration
   static inline unsigned long task_util(struct task_struct *p)
                               ^
   kernel/sched/fair.c:6481:16: note: Shadow variable
    unsigned long task_util, best_cap = 0;
                  ^
   kernel/sched/fair.c:6522:16: warning: Local variable 'task_util' shadows outer function [shadowFunction]
    unsigned long task_util;
                  ^
   kernel/sched/fair.c:4093:29: note: Shadowed declaration
   static inline unsigned long task_util(struct task_struct *p)
                               ^
   kernel/sched/fair.c:6522:16: note: Shadow variable
    unsigned long task_util;
                  ^
>> kernel/sched/fair.c:10528:6: warning: Local variable 'update_next_balance' shadows outer function [shadowFunction]
    int update_next_balance = 0;
        ^
   kernel/sched/fair.c:10382:1: note: Shadowed declaration
   update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
   ^
   kernel/sched/fair.c:10528:6: note: Shadow variable
    int update_next_balance = 0;
        ^
   kernel/sched/fair.c:10926:6: warning: Local variable 'update_next_balance' shadows outer function [shadowFunction]
    int update_next_balance = 0;
        ^
   kernel/sched/fair.c:10382:1: note: Shadowed declaration
   update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
   ^
   kernel/sched/fair.c:10926:6: note: Shadow variable
    int update_next_balance = 0;
        ^
>> kernel/sched/fair.c:9079:58: warning: Parameter 'p' can be declared with const [constParameter]
   static int idle_cpu_without(int cpu, struct task_struct *p)
                                                            ^
   kernel/sched/fair.c:5149:25: warning: Uninitialized variables: cfs_rq.load, cfs_rq.nr_running, cfs_rq.h_nr_running, cfs_rq.idle_nr_running, cfs_rq.idle_h_nr_running, cfs_rq.exec_clock, cfs_rq.min_vruntime, cfs_rq.min_vruntime_copy, cfs_rq.tasks_timeline, cfs_rq.curr, cfs_rq.next, cfs_rq.last, cfs_rq.skip, cfs_rq.avg, cfs_rq.last_update_time_copy, cfs_rq.removed [uninitvar]
     struct rq *rq = rq_of(cfs_rq);
                           ^
>> kernel/sched/fair.c:6540:25: warning: Uninitialized variable: task_util [uninitvar]
        asym_fits_capacity(task_util, target))
                           ^
   kernel/sched/fair.c:6529:28: note: Assuming condition is false
    if (static_branch_unlikely(&sched_asym_cpucapacity)) {
                              ^
   kernel/sched/fair.c:6540:25: note: Uninitialized variable: task_util
        asym_fits_capacity(task_util, target))
                           ^
>> mm/migrate.c:916:7: warning: Redundant initialization for 'rc'. The initialized value is overwritten before it is read. [redundantInitialization]
      rc = migrate_folio(mapping, dst, src, mode);
         ^
   mm/migrate.c:906:9: note: rc is initialized
    int rc = -EAGAIN;
           ^
   mm/migrate.c:916:7: note: rc is overwritten
      rc = migrate_folio(mapping, dst, src, mode);
         ^
>> mm/migrate.c:354:54: warning: Parameter 'mapping' can be declared with const [constParameter]
   static int folio_expected_refs(struct address_space *mapping,
                                                        ^
>> kernel/sched/core.c:5820:2: warning: Comparing pointers that point to different objects [comparePointers]
    for_each_class(class) {
    ^
   kernel/sched/sched.h:2243:27: note: Variable declared here.
   extern struct sched_class __sched_class_highest[];
                             ^
   kernel/sched/core.c:5820:2: note: Array decayed to pointer here.
    for_each_class(class) {
    ^
   kernel/sched/sched.h:2244:27: note: Variable declared here.
   extern struct sched_class __sched_class_lowest[];
                             ^
   kernel/sched/core.c:5820:2: note: Array decayed to pointer here.
    for_each_class(class) {
    ^
   kernel/sched/core.c:5820:2: note: Comparing pointers that point to different objects
    for_each_class(class) {
    ^
>> kernel/sched/sched.h:2058:67: warning: Parameter 'p' can be declared with const [constParameter]
   static inline int task_current(struct rq *rq, struct task_struct *p)
                                                                     ^
>> kernel/sched/core.c:2748:4: warning: Address of local auto-variable assigned to a function parameter. [autoVariables]
      p->migration_pending = &my_pending;
      ^
   kernel/sched/core.c:9268:3: warning: Comparing pointers that point to different objects [comparePointers]
     for_each_class(class) {
     ^
   kernel/sched/sched.h:2243:27: note: Variable declared here.
   extern struct sched_class __sched_class_highest[];
                             ^
   kernel/sched/core.c:9268:3: note: Array decayed to pointer here.
     for_each_class(class) {
     ^
   kernel/sched/sched.h:2244:27: note: Variable declared here.
   extern struct sched_class __sched_class_lowest[];
                             ^
   kernel/sched/core.c:9268:3: note: Array decayed to pointer here.
     for_each_class(class) {
     ^
   kernel/sched/core.c:9268:3: note: Comparing pointers that point to different objects
     for_each_class(class) {
     ^
   kernel/sched/core.c:9280:3: warning: Comparing pointers that point to different objects [comparePointers]
     for_each_class(class) {
     ^
   kernel/sched/sched.h:2243:27: note: Variable declared here.
   extern struct sched_class __sched_class_highest[];
                             ^
   kernel/sched/core.c:9280:3: note: Array decayed to pointer here.
     for_each_class(class) {
     ^
   kernel/sched/sched.h:2244:27: note: Variable declared here.
   extern struct sched_class __sched_class_lowest[];
                             ^
   kernel/sched/core.c:9280:3: note: Array decayed to pointer here.
     for_each_class(class) {
     ^
   kernel/sched/core.c:9280:3: note: Comparing pointers that point to different objects
     for_each_class(class) {
     ^
>> mm/shmem.c:411:25: warning: Parameter 'expected' can be declared with const [constParameter]
      pgoff_t index, void *expected, void *replacement)
                           ^
   mm/shmem.c:701:29: warning: Parameter 'expected' can be declared with const [constParameter]
          pgoff_t index, void *expected, gfp_t gfp,
                               ^

vim +/anon_aops +1231 fs/libfs.c

e4ab315810850b9 Kalesh Singh            2022-06-23  1228  
6987843ff7e836e Al Viro                 2013-10-02  1229  struct inode *alloc_anon_inode(struct super_block *s)
6987843ff7e836e Al Viro                 2013-10-02  1230  {
6987843ff7e836e Al Viro                 2013-10-02 @1231  	static const struct address_space_operations anon_aops = {
46de8b979492e13 Matthew Wilcox (Oracle  2022-02-09  1232) 		.dirty_folio	= noop_dirty_folio,
6987843ff7e836e Al Viro                 2013-10-02  1233  	};
6987843ff7e836e Al Viro                 2013-10-02  1234  	struct inode *inode = new_inode_pseudo(s);
6987843ff7e836e Al Viro                 2013-10-02  1235  
6987843ff7e836e Al Viro                 2013-10-02  1236  	if (!inode)
6987843ff7e836e Al Viro                 2013-10-02  1237  		return ERR_PTR(-ENOMEM);
6987843ff7e836e Al Viro                 2013-10-02  1238  
6987843ff7e836e Al Viro                 2013-10-02  1239  	inode->i_ino = get_next_ino();
6987843ff7e836e Al Viro                 2013-10-02  1240  	inode->i_mapping->a_ops = &anon_aops;
6987843ff7e836e Al Viro                 2013-10-02  1241  
6987843ff7e836e Al Viro                 2013-10-02  1242  	/*
6987843ff7e836e Al Viro                 2013-10-02  1243  	 * Mark the inode dirty from the very beginning,
6987843ff7e836e Al Viro                 2013-10-02  1244  	 * that way it will never be moved to the dirty
6987843ff7e836e Al Viro                 2013-10-02  1245  	 * list because mark_inode_dirty() will think
6987843ff7e836e Al Viro                 2013-10-02  1246  	 * that it already _is_ on the dirty list.
6987843ff7e836e Al Viro                 2013-10-02  1247  	 */
6987843ff7e836e Al Viro                 2013-10-02  1248  	inode->i_state = I_DIRTY;
6987843ff7e836e Al Viro                 2013-10-02  1249  	inode->i_mode = S_IRUSR | S_IWUSR;
6987843ff7e836e Al Viro                 2013-10-02  1250  	inode->i_uid = current_fsuid();
6987843ff7e836e Al Viro                 2013-10-02  1251  	inode->i_gid = current_fsgid();
6987843ff7e836e Al Viro                 2013-10-02  1252  	inode->i_flags |= S_PRIVATE;
078cd8279e65998 Deepa Dinamani          2016-09-14  1253  	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
6987843ff7e836e Al Viro                 2013-10-02  1254  	return inode;
6987843ff7e836e Al Viro                 2013-10-02  1255  }
6987843ff7e836e Al Viro                 2013-10-02  1256  EXPORT_SYMBOL(alloc_anon_inode);
1c994a0909a5565 Jeff Layton             2014-08-27  1257  

:::::: The code at line 1231 was first introduced by commit
:::::: 6987843ff7e836ea65b554905aec34d2fad05c94 take anon inode allocation to libfs.c

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
