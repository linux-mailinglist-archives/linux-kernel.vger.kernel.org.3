Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D125B1FC5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiIHN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiIHN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:56:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A05DF8268;
        Thu,  8 Sep 2022 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662645408; x=1694181408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yWEV9GAwWGkFztIMMA29BYDtjRMjBH0LG0XI3ex1bhw=;
  b=oJL7kBgJHvrPgvv/J5ewD1z8CZLVGgI9JtR5BocErHJUVHIwNiqaWQ/6
   v9RV27aZgU3x7VtPbRMHYyu8UMlZE4HF6fP0KUObAYzPuixT5p95NGtVH
   uL1wl5kY3T7tP3ud6b2maxA6Ji3mC93lS7kobb85yI0gNbcQg16+CWL5p
   1p+S+cWEBiZKPxGwD6gk8dQCOUxAicUQa1ioWeSO0tmKXwiAzaP4Iji0x
   vacHmmlOc3JmxYHrw+FTyqTyIHozcGRvE8ntsg26o52H8FzWl7E5N7rMO
   CqUfgyVr4j8FAjmEiOS033lYS4+JaMeCqm75cg2AinNryLnrpm+2SqlVy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="277560798"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="277560798"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="592173750"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 08 Sep 2022 06:56:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4A121235; Thu,  8 Sep 2022 16:57:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 0/9] pwm: lpss: Clean up and convert to a pure library
Date:   Thu,  8 Sep 2022 16:56:49 +0300
Message-Id: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, a set of cleanups and code deduplications (for better
maintenance) to the PWM LPSS driver.

Second, we may (re-)use the core part as a library in the future in
the devices that combine the same PWM IP in their address space. So
convert the core file to be a pure library which doesn't require any
special resource handling or alike.

Changelog v2:
- replace patch 1 by Uwe's version (Uwe)
- update NS patch to have a default namespace defined (Uwe)
- describe all changes done in patch 4 (Uwe)

Andy Shevchenko (8):
  pwm: lpss: Move exported symbols to PWM_LPSS namespace
  pwm: lpss: Move resource mapping to the glue drivers
  pwm: lpss: Include headers we are direct user of
  pwm: lpss: Use device_get_match_data to get device data
  pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
  pwm: lpss: Make use of bits.h macros for all masks
  pwm: lpss: Add a comment to the bypass field
  pwm: lpss: Allow other drivers to enable PWM LPSS

Uwe Kleine-König (1):
  pwm: lpss: Deduplicate board info data structures

 drivers/pwm/pwm-lpss-pci.c                 | 48 +++++-----------------
 drivers/pwm/pwm-lpss-platform.c            | 40 +++++-------------
 drivers/pwm/pwm-lpss.c                     | 46 ++++++++++++++++++---
 drivers/pwm/pwm-lpss.h                     | 22 ++++------
 include/linux/platform_data/x86/pwm-lpss.h | 33 +++++++++++++++
 5 files changed, 101 insertions(+), 88 deletions(-)
 create mode 100644 include/linux/platform_data/x86/pwm-lpss.h

-- 
2.35.1

