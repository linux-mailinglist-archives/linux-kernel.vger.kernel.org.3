Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F7B46AED5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377968AbhLGAO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:14:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:62300 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350858AbhLGAOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:14:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237667819"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237667819"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 16:11:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="461037079"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Dec 2021 16:11:24 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muO4p-000LuW-OR; Tue, 07 Dec 2021 00:11:23 +0000
Date:   Tue, 7 Dec 2021 08:10:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:1390
 ZSTD_decompressSequences() warn: inconsistent indenting
Message-ID: <202112070813.V4QHm1sF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f80ef9e49fdfbfbc4197711230098b90e6b05a7e
commit: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10
date:   4 weeks ago
config: x86_64-randconfig-m001-20211206 (https://download.01.org/0day-ci/archive/20211207/202112070813.V4QHm1sF-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:1390 ZSTD_decompressSequences() warn: inconsistent indenting
arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:1414 ZSTD_decompressSequencesLong() warn: inconsistent indenting

Old smatch warnings:
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:397 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:397 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:850 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:850 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &
arch/x86/boot/compressed/misc.c:292 parse_elf() warn: ignoring unreachable code.

vim +1390 arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c

  1369	
  1370	typedef size_t (*ZSTD_decompressSequences_t)(
  1371	                            ZSTD_DCtx* dctx,
  1372	                            void* dst, size_t maxDstSize,
  1373	                            const void* seqStart, size_t seqSize, int nbSeq,
  1374	                            const ZSTD_longOffset_e isLongOffset,
  1375	                            const int frame);
  1376	
  1377	#ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG
  1378	static size_t
  1379	ZSTD_decompressSequences(ZSTD_DCtx* dctx, void* dst, size_t maxDstSize,
  1380	                   const void* seqStart, size_t seqSize, int nbSeq,
  1381	                   const ZSTD_longOffset_e isLongOffset,
  1382	                   const int frame)
  1383	{
  1384	    DEBUGLOG(5, "ZSTD_decompressSequences");
  1385	#if DYNAMIC_BMI2
  1386	    if (dctx->bmi2) {
  1387	        return ZSTD_decompressSequences_bmi2(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
  1388	    }
  1389	#endif
> 1390	  return ZSTD_decompressSequences_default(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
  1391	}
  1392	#endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG */
  1393	
  1394	
  1395	#ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
  1396	/* ZSTD_decompressSequencesLong() :
  1397	 * decompression function triggered when a minimum share of offsets is considered "long",
  1398	 * aka out of cache.
  1399	 * note : "long" definition seems overloaded here, sometimes meaning "wider than bitstream register", and sometimes meaning "farther than memory cache distance".
  1400	 * This function will try to mitigate main memory latency through the use of prefetching */
  1401	static size_t
  1402	ZSTD_decompressSequencesLong(ZSTD_DCtx* dctx,
  1403	                             void* dst, size_t maxDstSize,
  1404	                             const void* seqStart, size_t seqSize, int nbSeq,
  1405	                             const ZSTD_longOffset_e isLongOffset,
  1406	                             const int frame)
  1407	{
  1408	    DEBUGLOG(5, "ZSTD_decompressSequencesLong");
  1409	#if DYNAMIC_BMI2
  1410	    if (dctx->bmi2) {
  1411	        return ZSTD_decompressSequencesLong_bmi2(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
  1412	    }
  1413	#endif
> 1414	  return ZSTD_decompressSequencesLong_default(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
  1415	}
  1416	#endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT */
  1417	
  1418	
  1419	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
