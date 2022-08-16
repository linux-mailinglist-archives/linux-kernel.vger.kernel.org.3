Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CFE595441
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiHPH5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiHPH4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:56:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B60DAECC;
        Mon, 15 Aug 2022 22:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660626769; x=1692162769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W4FsooIY90DJ4wSDkByefvULZD2ZAidvkULz+CXxv3w=;
  b=T4RY775pft2VekOZVKKnCFuhZNnX88sLqv90d0d518dBnG4NXGmvvKCz
   LDTYZZHfc9yfkKAI5ogp+sLV8ikETvUXhuFX13lTubshUts6MQQiU/axD
   1AbU9y0nZcycGpPs2HMDBea4TP30QK92aGz70xxUjYjBkrskCttmQ4VXF
   EGMGsub7+k8PjPoFxAE76dKEoB2BLBJzRM5MRZB7Iyb2wenzjq3czWKSQ
   Q+gWj5jB/KoIJJekYmeIe+MbnWwBR2BQL9dC5GrIOd3DgG2pXZUSqQymf
   dseIDQCSVUjpPDAYhF9dZkvtGUXcVtdwRTdB5Lcrg90yM6ijrbj+gG21N
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356130124"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356130124"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 22:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="666953435"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2022 22:12:45 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH V2 0/8] x86/topology: Improve CPUID.1F handling
Date:   Tue, 16 Aug 2022 13:16:25 +0800
Message-Id: <20220816051633.17775-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel AlderLake-N platforms where there are Ecores only, the Ecore
Module topology is enumerated via CPUID.1F Module level, which has not
been supported by Linux kernel yet.

This exposes two issues in current CPUID.1F handling code.
1. Linux interprets the Module ID bits as package ID and erroneously
   reports a multi module system as a multi-package system.
2. Linux excludes the unknown Module ID bits from the core ID, and results
   in duplicate core ID’s shown in a package after the first issue solved.

Plus that, a third problem is observed on Intel Hybrid ADL-S/P platforms.
The return value of CPUID.1F SMT level EBX (number of siblings) differs on
Pcore CPUs and Ecore CPUs, and results in inconsistent smp_num_siblings
value based on the Pcore/Ecore CPU enumeration order. This could bring
some potential issues although we have not observed any functionalities
issues so far.

This patch series fixes these three problems in CPUID.1F handling code,
together with some related fixes and document updates.

thanks,
-rui

---
Changes since V1:
 - fix/improve changelog/comment wording issues
 - reorder the patches to eliminate bisection breakage window
 - add a new patch for coretemp driver variable renaming
 - update coretemp driver patch to fix a case of ida_free(&ida, -2)
