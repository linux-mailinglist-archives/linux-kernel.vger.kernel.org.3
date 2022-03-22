Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90214E3F50
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiCVNS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiCVNSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:18:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45FD64712;
        Tue, 22 Mar 2022 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647955038; x=1679491038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dAcxrMAdYGWi8WSTjO6a3fMaU21hxA6oy2q2nk6xPPc=;
  b=dZs5xOzUCW1TpjMvTbS9UluzpgVIuu5dS4IVYTVQVUIkR7kZeLk1+xdn
   hv0Ya2wwNO4IZop33ERGUfYTjI+DQxF3y7X0BbBqIQ3rjtND0Hh402u8f
   rleea1KXPdeAY2WyuYcPRZCyz6EeOrjOrgH/DB+KIyWeqt34taim7xDjN
   kRFJ7tBJPYC0KYa+KQ2MJ2JfqHeyQNuh6tdkg4MyaOp/Ne8RS0akYoqbV
   RU2OlQLJGBuHBJex/XcsRim1R4MhPZS2yaLDnEyzsfbUF5HHjoxuO0ykE
   XHmrJJ6T7OO2a0msl/Wup4kBVtQ8yN0u9Gx/rs36+LRCcQktJpRzKUR+R
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="237755597"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="237755597"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 06:17:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="543686431"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 06:17:16 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] rcu: Deoffload rdp if rcuop/rcuog kthreads spawn failed
Date:   Tue, 22 Mar 2022 21:17:51 +0800
Message-Id: <20220322131753.1680329-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

 v3->v4:
 Protect SEGCBLIST_KTHREAD_CB flags clear with rcu_nocb lock.

 Zqiang(2):
 rcu: Call rcu_nocb_rdp_deoffload() directly after rcuog/op kthreads spawn failed
 rcu: Invert the locking dependency order between rcu_state.barrier_mutex and hotplug lock

 kernel/rcu/tree_nocb.h | 85 ++++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 20 deletions(-)

-- 
2.25.1

