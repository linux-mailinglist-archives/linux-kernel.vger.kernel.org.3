Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88765B096E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiIGQAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIGP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:59:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6968611C3B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662566374; x=1694102374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2LoTcrDdIIjhQQzEoUzp6PWW1yQHSMcHmGudjZ75118=;
  b=MQLn8MyVXk+5ejEzOhi3Ygng3PdjtiLn1f9FG4KDuTaMlwdu0NICSfdA
   dgd1Z7FL64hUh1KppAy5Q0VosFyAG2M2EVEDS1+IVyeJf0ZW0bcsKt4iz
   wO+qlmrHBO7YjysqLtAcsE9g4oGhpZo2HnFSMgzw/VjeJrU6jaoQz9H8Z
   OwG3Wuj3NqhEGsfw/hKcYjotDw05TcwN4JdaM9GnZ8Hv7ZUyPhrt6jKTY
   J9lvfGKLf91/sXLldWQwB5aa3lHpUfyxRFl+0IZwEhdXInBy520Kh+RBX
   H+6eWKxx6iL+FV9o4QP3kgjbTgPzVILWEfccUElY9sAqo7k/J/RO39MG8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297701322"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="297701322"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:59:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676247865"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:59:07 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
Subject: [PATCH v8 07/16] mei: gsc: wait for reset thread on stop
Date:   Wed,  7 Sep 2022 18:58:04 +0300
Message-Id: <20220907155813.1427526-8-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907155813.1427526-1-tomas.winkler@intel.com>
References: <20220907155813.1427526-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Wait for reset work to complete before initiating
stop reset flow sequence.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index eb052005ca86..bc054baf496c 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2012-2019, Intel Corporation. All rights reserved.
+ * Copyright (c) 2012-2022, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -320,6 +320,8 @@ void mei_stop(struct mei_device *dev)
 
 	mei_clear_interrupts(dev);
 	mei_synchronize_irq(dev);
+	/* to catch HW-initiated reset */
+	mei_cancel_work(dev);
 
 	mutex_lock(&dev->device_lock);
 
-- 
2.37.2

