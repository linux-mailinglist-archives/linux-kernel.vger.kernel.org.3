Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D30571F76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiGLPff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiGLPfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:35:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C05BC08F8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657640126; x=1689176126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1wj1Gy8GF/XmQXmZM6ThKfzWjSdr3qtAlVHAsnysHN8=;
  b=nAL94Oqt38RAV6xvBJlxR2d0zrdO4Itg8hfVrnr9cG0aO4f3i9e4Vcts
   j6RqZUXK4vbd2cKBIXo2Hq1+e3/2TES2GnUzibtrksZIc/gLyrDdVFUky
   rNuLF/0u2pj/7RakupkoN1NvGZGcvqm32DZj0B7VFRl0jLFeEw0KwnAY4
   LGhC5TIgwvWBjkXoeaAb0UyNbYLp6ibhu9cn7qJfbejZVaMiM/94vXR6Q
   oyNIjf99Aex7Qt+DULFY9sxD6RfFgMdj9c8bEe2YrXP15mi3mqc4Hiwsi
   NiUb4tMEmZeT+uF8g0eNGKI5XyzaFkgxifTVThZvczdEN+aa4y1zMheLZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="310590208"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="310590208"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 08:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="595326460"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 12 Jul 2022 08:35:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1634CF1; Tue, 12 Jul 2022 18:35:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/4] ALSA: hda: cs35l41: Don't dereference fwnode handle
Date:   Tue, 12 Jul 2022 18:35:16 +0300
Message-Id: <20220712153519.35692-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
which is a better coding practice.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new change
 sound/pci/hda/cs35l41_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 49b25432a9f5..1a1afa0725e0 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -347,7 +347,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	/* To use the same release code for all laptop variants we can't use devm_ version of
 	 * gpiod_get here, as CLSA010* don't have a fully functional bios with an _DSD node
 	 */
-	cs35l41->reset_gpio = fwnode_gpiod_get_index(&adev->fwnode, "reset", cs35l41->index,
+	cs35l41->reset_gpio = fwnode_gpiod_get_index(acpi_fwnode_handle(adev), "reset", cs35l41->index,
 						     GPIOD_OUT_LOW, "cs35l41-reset");
 
 	property = "cirrus,speaker-position";
-- 
2.35.1

