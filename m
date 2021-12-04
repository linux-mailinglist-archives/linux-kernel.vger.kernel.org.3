Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78954685B8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhLDOrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:47:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:38169 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232056AbhLDOrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:47:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="234634031"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="234634031"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 06:43:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="678431598"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Dec 2021 06:43:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtWGW-000J6p-0I; Sat, 04 Dec 2021 14:43:52 +0000
Date:   Sat, 4 Dec 2021 22:43:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH rt-devel] softirq: timer_threads can be static
Message-ID: <20211204144304.GA11849@ce7bf8684400>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/softirq.c:1031:27: warning: symbol 'timer_threads' was not declared. Should it be static?

Fixes: 87b7f9e13d14 ("softirq: Use a dedicated thread for timer wakeups.")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 softirq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index e49fcdea145d8..0d1cc191e4f41 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -1028,7 +1028,7 @@ void raise_timer_softirq(void)
 }
 #endif
 
-struct smp_hotplug_thread timer_threads = {
+static struct smp_hotplug_thread timer_threads = {
         .store                  = &timersd,
         .setup                  = timersd_setup,
         .thread_should_run      = timersd_should_run,
