Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89E54A6014
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbiBAP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:28:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:50145 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240291AbiBAP2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643729288; x=1675265288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mUqio7p7oQ4SXILXZ4GtuOsMQERZFpZ7ZLYHPqpcNQA=;
  b=QLz82PLqyZTDk6qwDPLe7M2jXU/BUYT6/aomjWmLerDlG9AP1UVpymDq
   ycB7Stqzcgxo4gWmK1rLgKMatP/DydWE+VqNgmTGyr8I3rBdZi9VOzA9a
   uo7X4hkst21jSSBwIZy8e9Xa9zrXl9tzNigs9NhQHXPu3MMyWc/09P+kM
   oTajYtQtSGoz6GAOk6W7uxlcrRzCcYCT76XFV+0c6VqkNBm752cYhuL8k
   iH1MsTygMLC7L1o1wkyP3NoD3zebsyVOpMoFjQ5fO//OupAu35CWlAIRu
   N7zjbKBC4DLPVqNNWYfpMKXXn5CfLqDqRAO0nlxKjvZWewbEZhSwMOTR1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="245307492"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="245307492"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:28:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="479722748"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 07:28:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF29F15E; Tue,  1 Feb 2022 17:28:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 0/4] gpiolib: A fix and a few cleanups
Date:   Tue,  1 Feb 2022 17:27:54 +0200
Message-Id: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 is a fix for wrong error code to user space.
Patches 2-4 are small cleanups.

Can be routed via my tree, or directly into GPIO, whatever maintainers
prefer.

Changelog v3:
- joined two patches into a single fix (Bart)
- added Rb tag (Linus)
- renamed for_each_gpio_desc_with_flag() macro to be descriptive (Johan)
- added two new cleanups

Andy Shevchenko (4):
  gpiolib: Never return internal error codes to user space
  gpiolib: Introduce for_each_gpio_desc_with_flag() macro
  gpiolib: Use short form of ternary operator in gpiod_get_index()
  gpiolib: Simplify error path in gpiod_get_index() when requesting GPIO

 drivers/gpio/gpiolib-cdev.c  |  6 +++---
 drivers/gpio/gpiolib-of.c    | 10 ++++------
 drivers/gpio/gpiolib-sysfs.c | 14 ++++----------
 drivers/gpio/gpiolib.c       | 35 ++++++++++++++++-------------------
 drivers/gpio/gpiolib.h       | 19 +++++++++++++++++++
 5 files changed, 46 insertions(+), 38 deletions(-)

-- 
2.34.1

