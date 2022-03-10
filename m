Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC084D5339
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245518AbiCJUuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243957AbiCJUuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:50:05 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AD5186452
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646945343; x=1678481343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XBV/vhSpOQFq3ItxNWH3aLVfSt1M13WXm1fnUUqRboI=;
  b=bCsFg8cMjIoxUDOBKfKaUlZuG8faa1JpG2/qO1PSRI6CJscLdsvcUl0R
   noAEYz3J8FTSLC+CTJpGiErUY7RPypBl9tJNoqOkPjsMQFjGXhMpWmPMW
   J/z9NK4WOLeTHQ4spQ4KYW/2nyncXgj9rNSmYLl6cm/4/+sh0puG2vI9i
   +/GScGItfNuJYrqmow2gf3ObkVF723IyQNl8uf9ZnmzrDUYjcDZ9Us/UK
   NypCkDj6lKirl3WqnqYhHTAKwlYxQz33ce4hTNBSsWMyKSESlZVKAr2J1
   bUcrFrJnJoFNmRgVTK3hcxLvGxH0GtUQzcmOEK5KJCbLTUytGsYHT3tmD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254205623"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="254205623"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 12:49:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="554843291"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 12:49:02 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 0/2] Make life miserable for split lockers
Date:   Thu, 10 Mar 2022 12:48:52 -0800
Message-Id: <20220310204854.31752-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217012721.9694-1-tony.luck@intel.com>
References: <20220217012721.9694-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See part 0001 commit message for what & why.

Changes since v1(RFC) based on feedback from Thomas:

1) No longer implemented as new sub-option of split_lock_detect boot
   option.  Just update the existing (default) "warn" mode.
2) Use the (more appropriate) "schedule_delayed_work_on() instead of
   schedule_delayed_work() to re-enable split lock detection.
3) Add msleep for extra misery before disabling split lock detection
   on a core.

Next two aren't from Thomas.
4) Drop the TIF_SLD bit and associated code. No longer needed. This
   part is done as clean up in patch 0002.
5) Add a bit in task structure to make sure each split-locking task
   only tries to print a warn message to the console once. Need this
   to preserve existing behavior that was previously controlled by the
   TIF_SLD bit.

Testing notes. I checked this out by running 2,000 processes that
each looped executing 10,000 split locks. System remains very
responsive while this test is running (compared with unusable
without these patches). When each process gets the semaphore
and two jiffies of time to execute split locks it manages to
complete ~430 before the delayed work thread re-enables detection.

The semaphore gives nice round-robin access to the 2,000 tasks.
So each ends up blocking for 24ish seconds while the other 1,999
task take their turn.

Tony Luck (2):
  x86/split_lock: Make life miserable for split lockers
  x86/split-lock: Remove unused TIF_SLD bit

 arch/x86/include/asm/cpu.h         |  2 -
 arch/x86/include/asm/thread_info.h |  4 +-
 arch/x86/kernel/cpu/intel.c        | 77 +++++++++++++++++++++---------
 arch/x86/kernel/process.c          |  3 --
 include/linux/sched.h              |  3 ++
 kernel/fork.c                      |  5 ++
 6 files changed, 64 insertions(+), 30 deletions(-)

-- 
2.35.1

