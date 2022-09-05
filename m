Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668EC5AD7EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiIEQ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIEQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:58:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4161A5A3DB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662397101; x=1693933101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e8YXLtq3TD5WABfmx3boLopZxKdFinKI+1f8BL03nW8=;
  b=L+JNMl+JuyNBMrAM3abIbGtkTN6Va0EdlxftuM+uikL3Vu11cXr//aCN
   h4zechOG8GmVVZkUwqa4/wKgwPLZ6gKIzApAXQrNA2/d0bUn6zCvpOYz1
   CLfUHcxcn1ClZOnXAzUnI7w6eIPriWCRquFVqE+BcAZCnQ8nERGrf91ix
   p3VCj2KXygG152XxV88/mw+yH5D2ihn40dG6lRA1tHAE4oLJZO4WUOrTE
   1EuYbjgbLR0L5erp2FK99Cpu6FvkJSpdXIsin9stUqCHQl3ZAHvJ28xz1
   6iGIxMEcjZtZJaqg/6qWEWwcyNvQMIZgQt0WK3DmawRTvBT0sXEua9tX9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="295163288"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="295163288"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 09:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="609716171"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 05 Sep 2022 09:58:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7C131101; Mon,  5 Sep 2022 19:58:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] ALSA: hda: cs35l41: Call put_device() in the scope of get_device()
Date:   Mon,  5 Sep 2022 19:58:25 +0300
Message-Id: <20220905165826.35979-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

When put_device() is called in another function it's hard to realize
that and easy to "fix" the code in a wrong way. Instead, move
put_device() to be in the same scope as get_device(), so we prevent
appearance of any attempts to "fix" the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/hda/cs35l41_hda.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 15e2a0009080..12e955931044 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1154,7 +1154,6 @@ static int cs35l41_no_acpi_dsd(struct cs35l41_hda *cs35l41, struct device *physd
 	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
 	hw_cfg->gpio2.valid = true;
 	hw_cfg->valid = true;
-	put_device(physdev);
 
 	if (strncmp(hid, "CLSA0100", 8) == 0) {
 		hw_cfg->bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
@@ -1204,9 +1203,10 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 
 	property = "cirrus,dev-index";
 	ret = device_property_count_u32(physdev, property);
-	if (ret <= 0)
-		return cs35l41_no_acpi_dsd(cs35l41, physdev, id, hid);
-
+	if (ret <= 0) {
+		ret = cs35l41_no_acpi_dsd(cs35l41, physdev, id, hid);
+		goto err_put_physdev;
+	}
 	if (ret > ARRAY_SIZE(values)) {
 		ret = -EINVAL;
 		goto err;
@@ -1295,8 +1295,9 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	return 0;
 
 err:
-	put_device(physdev);
 	dev_err(cs35l41->dev, "Failed property %s: %d\n", property, ret);
+err_put_physdev:
+	put_device(physdev);
 
 	return ret;
 }
-- 
2.35.1

