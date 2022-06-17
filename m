Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40B55004C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383016AbiFQXFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382985AbiFQXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:05:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80CA63BD6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655507105; x=1687043105;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6VpsBgK0w+skGEr+pYfQXHaL9I84ln9HOXT42zU0tbo=;
  b=bTgE4KTcgYgnnHoXkJJjrdDXMgGLXYo7ZkeF5f/F1r4UuC1DCRXAzsAn
   MGIn0jwEU6r722OsRrm21JfktgYDuqqgp+hal9Wrm/6iOLKcBK3LU1tIm
   VXExcRTQsUl+fyniOApoV5EgQUtNMGSKdYRdlX2IbDvIBb2G/EratBoe0
   rU8OBj10dG3K/fXY6G5VHCcbTlVsbLj0VPbpznJUbepO5il96nHsnw41Q
   XCmpaFn453v2GSlExMGn8KJYjA6l6QJhy3z9mucJs7x0Y7sFA9gzPPt6k
   r1Kc+XEW9DTtyU2zN+r7SngfqJalxVdYaMigxPPEC7Ocgcjm7nPz4oD6r
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259426010"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259426010"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 16:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="675669003"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2022 16:04:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2L1N-000Ppm-Tx;
        Fri, 17 Jun 2022 23:04:57 +0000
Date:   Sat, 18 Jun 2022 07:04:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/madvise.c:1438:6: warning: Redundant assignment of 'ret' to
 itself. [selfAssignment]
Message-ID: <202206180617.UzO7ymnD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b35035bcf80ddb47c0112c4fbd84a63a2836a18
commit: 5bd009c7c9a9e888077c07535dc0c70aeab242c3 mm: madvise: return correct bytes advised with process_madvise
date:   3 months ago
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 5bd009c7c9a9e888077c07535dc0c70aeab242c3
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> mm/madvise.c:1438:6: warning: Redundant assignment of 'ret' to itself. [selfAssignment]
    ret = (total_len - iov_iter_count(&iter)) ? : ret;
        ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   mm/madvise.c:123:28: warning: Parameter 'anon_name' can be declared with const [constParameter]
        struct anon_vma_name *anon_name)
                              ^

vim +/ret +1438 mm/madvise.c

  1378	
  1379	SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
  1380			size_t, vlen, int, behavior, unsigned int, flags)
  1381	{
  1382		ssize_t ret;
  1383		struct iovec iovstack[UIO_FASTIOV], iovec;
  1384		struct iovec *iov = iovstack;
  1385		struct iov_iter iter;
  1386		struct task_struct *task;
  1387		struct mm_struct *mm;
  1388		size_t total_len;
  1389		unsigned int f_flags;
  1390	
  1391		if (flags != 0) {
  1392			ret = -EINVAL;
  1393			goto out;
  1394		}
  1395	
  1396		ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
  1397		if (ret < 0)
  1398			goto out;
  1399	
  1400		task = pidfd_get_task(pidfd, &f_flags);
  1401		if (IS_ERR(task)) {
  1402			ret = PTR_ERR(task);
  1403			goto free_iov;
  1404		}
  1405	
  1406		if (!process_madvise_behavior_valid(behavior)) {
  1407			ret = -EINVAL;
  1408			goto release_task;
  1409		}
  1410	
  1411		/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
  1412		mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
  1413		if (IS_ERR_OR_NULL(mm)) {
  1414			ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
  1415			goto release_task;
  1416		}
  1417	
  1418		/*
  1419		 * Require CAP_SYS_NICE for influencing process performance. Note that
  1420		 * only non-destructive hints are currently supported.
  1421		 */
  1422		if (!capable(CAP_SYS_NICE)) {
  1423			ret = -EPERM;
  1424			goto release_mm;
  1425		}
  1426	
  1427		total_len = iov_iter_count(&iter);
  1428	
  1429		while (iov_iter_count(&iter)) {
  1430			iovec = iov_iter_iovec(&iter);
  1431			ret = do_madvise(mm, (unsigned long)iovec.iov_base,
  1432						iovec.iov_len, behavior);
  1433			if (ret < 0)
  1434				break;
  1435			iov_iter_advance(&iter, iovec.iov_len);
  1436		}
  1437	
> 1438		ret = (total_len - iov_iter_count(&iter)) ? : ret;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
