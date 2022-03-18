Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF4F4DD5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiCRIIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiCRIIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:08:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ED4231936;
        Fri, 18 Mar 2022 01:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647590802; x=1679126802;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wwp1j4OGk9F57hN1np0w7mtBafinWSVg7Jz/pfT+Xe8=;
  b=YhU4YfKqYvXIgAEEkhPgWM5wofqzaVYYphzWESC+7gVLsQfZuDkGxxDl
   1Y0iSNWt3f9fTVNrESbxcEZoIg/rlv/gw5Eg+utSyplA0KYMXxNNmAB68
   LoYk1S0xsb/u/bpiEvphsLbQ67plogbLBkkfUpSi7WT70i04E1RHbDuQE
   Ld5IQwgIkjYdzF7kFgbms0Te+I+zCNHLWht2bNS1jXgFtjQj+D6v/pQTS
   UDNVUYe0ZulZIPNB0Z2+NTARYb8cPsFZeEu5041ydari1JAh2gJfog7nW
   qhxQgheRAOStDXZbnIbb5KdUbZcuRLYcCGAg6gswWVJ5qaTbaNRtRnSvH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="255917333"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="255917333"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 01:06:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="541734757"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 01:06:39 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] rcu: Deoffload rdp if rcuop/rcuog kthreads spawn failed
Date:   Fri, 18 Mar 2022 16:07:17 +0800
Message-Id: <20220318080719.1501471-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_RCU_NOCB_CPU is enabled and 'rcu_nocbs' is set, the rcuop
and rcuog kthreads is created. however the rcuop or rcuog kthreads
creation may fail, if failed, deoffload the offloaded rdp.

---
 v1->v2:
 Invert the locking dependency order between rcu_state.barrier_mutex
 and hotplug lock.

 Holding nocb_gp_kthread_mutex, ensure that the nocb_gp_kthread exists.

 v2->v3:
 Adjust the position of the nocb_gp_kthread_mutex, in rdp_gp->nocb_gp_kthread
 check upper lock nocb_gp_kthread_mutex.

 Do the locking order change in a separate patch.

 Zqiang(2):
 rcu: Call rcu_nocb_rdp_deoffload() directly after rcuog/op kthreads spawn failed
 rcu: Invert the locking dependency order between rcu_state.barrier_mutex and hotplug lock

 kernel/rcu/tree_nocb.h | 83 ++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 20 deletions(-)

-- 
2.25.1

