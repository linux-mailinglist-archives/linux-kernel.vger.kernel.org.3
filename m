Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D83510CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356232AbiDZX7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbiDZX7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:59:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB1544750
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651017392; x=1682553392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eIHvaM/jF1FT9l+KeJTLO1Jd1NhIocqtHenQEupdkBw=;
  b=K/mT2yM9sH9GdjD4qpne5XIYA69BYzKUIJbZF6zgdbrtOxs9Jc5PRs/c
   tM7Of4Sb+6nIy9LootlPYfx7peCg6FYyCqQ/UsyUiJ4CHO4iMnPQXywEq
   fR7H8ncQJ2b8aFKb4tLdPvQ0nDaldu2Wy6aUnFbeYEsNmQorYPP5gl4nJ
   oxLUX6KvmTv83ZsQlJ65pd0sgmK0u+2oGtSyernLIZzhrnzSUXwGE6Dhh
   8OugX4I9VIG/GTSMU839JZ3xPyLYy6bt1ygXuOJjrWf7eJVNJuJp20JPv
   ubAf6rGKUKzlf89ckr4DiPbIEPKIhuK7AQ0G/ofkNcJ8L+Mlaplx8R6HK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245682865"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="245682865"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:56:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="730515003"
Received: from htamura-mobl2.gar.corp.intel.com (HELO bard-pc.domain.name) ([10.252.185.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:56:29 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/5] soundwire: use pm_runtime_resume_and_get()
Date:   Wed, 27 Apr 2022 07:56:18 +0800
Message-Id: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pm_runtime_resume_and_get() to replace the pm_runtime_get_sync() and
pm_runtime_put_noidle() pattern.

Pierre-Louis Bossart (5):
  soundwire: qcom: return error when pm_runtime_get_sync fails
  soundwire: bus: use pm_runtime_resume_and_get()
  soundwire: cadence: use pm_runtime_resume_and_get()
  soundwire: intel: use pm_runtime_resume_and_get()
  soundwire: qcom: use pm_runtime_resume_and_get()

 drivers/soundwire/bus.c            | 15 +++++----------
 drivers/soundwire/cadence_master.c |  5 ++---
 drivers/soundwire/intel.c          |  5 ++---
 drivers/soundwire/qcom.c           | 17 ++++++++---------
 4 files changed, 17 insertions(+), 25 deletions(-)

-- 
2.25.1

