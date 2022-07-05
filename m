Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1895956738E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiGEPyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiGEPyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:54:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743F42A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657036357; x=1688572357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cBtwS58z1fGTuH27Pya4llI0JyNcEMHOWHNVeu9CBWE=;
  b=Hv4ri0zBhqdVH0bvpyaUF1RQfsQAxgw75/KFoxpEd3pl+boCOWjM/JfY
   HieGKSQnkFmbrhpM4fZKYL3Z1OvW/iGwf9vQ5zFdIIofZbX1Jo5cznLcu
   C4sEhmLviiaRDXCNMYvBBvh6UE7Ur2TJFH166zj4MOPvP++Xb/hBgMVtC
   ouGGvOqzN9LDD3/oSIaXWoH/rtDO48jYtT5phGy4aHBGRxbBQqqvP3irl
   SdtY/5eRzTIQsYFQ3lwc2izYIJBNrpbil9mlCBe66q56U5gq5b9RHQo1V
   LUNshSgnrvtsccN1kttjpt3R3YqKosNqpOvmtX9ulH1f2VFRxEDJTksuJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="272170058"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="272170058"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="769699683"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2022 08:52:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 178BF1A0; Tue,  5 Jul 2022 18:52:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/1] ASoC: madera: Replace kernel.h with the necessary inclusions
Date:   Tue,  5 Jul 2022 18:52:39 +0300
Message-Id: <20220705155239.75736-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
v2: added tag (Richard), Cc'ed ASoC maintainers
 include/sound/madera-pdata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/madera-pdata.h b/include/sound/madera-pdata.h
index e3060f48f108..58398d80c3de 100644
--- a/include/sound/madera-pdata.h
+++ b/include/sound/madera-pdata.h
@@ -9,7 +9,7 @@
 #ifndef MADERA_CODEC_PDATA_H
 #define MADERA_CODEC_PDATA_H
 
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 #define MADERA_MAX_INPUT		6
 #define MADERA_MAX_MUXED_CHANNELS	4
-- 
2.35.1

