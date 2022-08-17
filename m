Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A340596EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbiHQMtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbiHQMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:49:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD77E6170A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660740536; x=1692276536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kYOYATKAKktz41sDaZZq1GXiosh7ennmO+42v74MCX0=;
  b=mSnfgGusfF4aiuSvXeEM5drfB5nslroX7X4xMgPYqH3H84dEA5iYzTkJ
   VgKqgn1KAj628HCvq7Jl/PXulHgX8uaJoIp/fscjSfP4phMln9MRdFAYO
   h96ifpcEJ0akdqRDT57wxTqqCT88aLmZKKNvC0zeBGYIKMDBmTgeLH82t
   cmtOvBZs1Qs2Zpp+w9K+HyjmauF+FmxRo9fOOLCDQ76uKIXqDVzKNz2Sd
   SmdjRfUfj35zlErXSWDAChS5nnaqvyj962tKbuZwIkVjn12b9Nw/DyVQN
   xSQv5fYOS7WnA1kHX7pisIjS2Q/zGFa838SAhf7wv/fnEpn5rusVEynpZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="292478318"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="292478318"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:48:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="583755219"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2022 05:48:54 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [RESEND][PATCH] ALSA: info: Fix llseek return value when using callback
Date:   Wed, 17 Aug 2022 14:49:24 +0200
Message-Id: <20220817124924.3974577-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using callback there was a flow of

	ret = -EINVAL
	if (callback) {
		offset = callback();
		goto out;
	}
	...
	offset = some other value in case of no callback;
	ret = offset;
out:
	return ret;

which causes the snd_info_entry_llseek() to return -EINVAL when there is
callback handler. Fix this by setting "ret" directly to callback return
value before jumping to "out".

73029e0ff18d ("ALSA: info - Implement common llseek for binary mode")
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/core/info.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index b8058b341178..0b2f04dcb589 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -111,9 +111,9 @@ static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
 	entry = data->entry;
 	mutex_lock(&entry->access);
 	if (entry->c.ops->llseek) {
-		offset = entry->c.ops->llseek(entry,
-					      data->file_private_data,
-					      file, offset, orig);
+		ret = entry->c.ops->llseek(entry,
+					   data->file_private_data,
+					   file, offset, orig);
 		goto out;
 	}
 
-- 
2.25.1

