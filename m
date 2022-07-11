Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F161856FF5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiGKKqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiGKKpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:45:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F066DEDB74
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657533149; x=1689069149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SGu3Iez0MNumhaZ/Y5N82y7aeHKR+TFgV9GmQXULqtk=;
  b=kxlKTiBQ7mtuoWnpv+5Q+OX7QRksVZBCzTnRBlAwBSVvf6Sat14bKoKm
   JHbYBFEMA4eFVDagsOKr8in4X1Q/yxFZDcB7wfgWIOF/8uuFDlIAP5TFL
   eM3ri6wJtI7CY6MiIGf3EWMi4rfP/RS3eqpKmVYTFrxoDmROJ7p0Ul86Y
   1vHRDp9pMqf0KplFUcXnYyKU3EhqzEubSId3AxFlEky7LBajyNp6fsXWU
   OQ+C9Xus+yCSFvZAlmBMnwn9F3Gi2QdIkgyKic7oNEqOCMDmDd1LQd7on
   v4rJfgdyEf12w5jxq4W+zZwdzUjFmPZ/RGj8S2Zb3vvLeaEBx5r8KZv+4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282171878"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="282171878"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 02:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="662485655"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2022 02:52:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6AEBE1A0; Mon, 11 Jul 2022 12:52:26 +0300 (EEST)
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
Subject: [PATCH v1 1/4] ALSA: hda: cs35l41: Improve dev_err_probe() messaging
Date:   Mon, 11 Jul 2022 12:52:16 +0300
Message-Id: <20220711095219.36915-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop duplicate print of returned value in the messages and use pattern
return dev_err_probe(...) where it's possible.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/hda/cs35l41_hda.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index cce27a86267f..23a97ada7272 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -460,10 +460,8 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	dev_set_drvdata(dev, cs35l41);
 
 	ret = cs35l41_hda_read_acpi(cs35l41, device_name, id);
-	if (ret) {
-		dev_err_probe(cs35l41->dev, ret, "Platform not supported %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(cs35l41->dev, ret, "Platform not supported\n");
 
 	if (IS_ERR(cs35l41->reset_gpio)) {
 		ret = PTR_ERR(cs35l41->reset_gpio);
@@ -471,7 +469,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 		if (ret == -EBUSY) {
 			dev_info(cs35l41->dev, "Reset line busy, assuming shared reset\n");
 		} else {
-			dev_err_probe(cs35l41->dev, ret, "Failed to get reset GPIO: %d\n", ret);
+			dev_err_probe(cs35l41->dev, ret, "Failed to get reset GPIO\n");
 			goto err;
 		}
 	}
-- 
2.35.1

