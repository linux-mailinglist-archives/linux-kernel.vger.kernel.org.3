Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA085AD7EF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiIEQ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiIEQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:58:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F1B5A153
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662397109; x=1693933109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OPhWheACqB5voc1DZNgFZ9E6/Dr9gFqeq2wdG3AQr3g=;
  b=ZWbehCmary3+6IQJSficzmYFlZuJexq6PI80wFaR0zuJqArxJAhgITrL
   vkpUd4V4GmRa3ZM6m6uEW1BUz7yU9mm5y9rQPOn8P9T/2dZdnM7z5CHCs
   EEYGrEob/fAn6vi2mPPNalbRWW2wEL5ICVfIoIYOfzz/iqupIMH4YisOd
   W8OFIMq9XEqi8VDtsvzb+prSDWGECXIw5mfBCY0rmvLoCZjBYXYTh7hXf
   wUAk/jORj5XSCE5PKCgTGva6DYqjbYnFgXJm+F92QwLoeo0rVqveMM1Is
   lVztkZa6z3b/cMg3r9a+uii0hca8bZzi9gZ2VN6Bj8YDl9+GdgiBzEPqE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276820231"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="276820231"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 09:58:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="789428926"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 05 Sep 2022 09:58:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 85A22F7; Mon,  5 Sep 2022 19:58:33 +0300 (EEST)
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
Subject: [PATCH v1 2/2] ALSA: hda: cs35l41: Utilize acpi_get_subsystem_id()
Date:   Mon,  5 Sep 2022 19:58:26 +0300
Message-Id: <20220905165826.35979-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220905165826.35979-1-andriy.shevchenko@linux.intel.com>
References: <20220905165826.35979-1-andriy.shevchenko@linux.intel.com>
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

Replace open coded variant of recently introduced acpi_get_subsystem_id().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/hda/cs35l41_hda.c | 46 ++++++++-----------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 12e955931044..3952f2853703 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -842,8 +842,8 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 
 	comps->dev = dev;
 	if (!cs35l41->acpi_subsystem_id)
-		cs35l41->acpi_subsystem_id = devm_kasprintf(dev, GFP_KERNEL, "%.8x",
-							    comps->codec->core.subsystem_id);
+		cs35l41->acpi_subsystem_id = kasprintf(GFP_KERNEL, "%.8x",
+						       comps->codec->core.subsystem_id);
 	cs35l41->codec = comps->codec;
 	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
 
@@ -1048,36 +1048,6 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 	return cs35l41_hda_channel_map(cs35l41->dev, 0, NULL, 1, &hw_cfg->spk_pos);
 }
 
-static int cs35l41_get_acpi_sub_string(struct device *dev, struct acpi_device *adev,
-				       const char **subsysid)
-{
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-	acpi_status status;
-	int ret = 0;
-
-	status = acpi_evaluate_object(adev->handle, "_SUB", NULL, &buffer);
-	if (ACPI_SUCCESS(status)) {
-		obj = buffer.pointer;
-		if (obj->type == ACPI_TYPE_STRING) {
-			*subsysid = devm_kstrdup(dev, obj->string.pointer, GFP_KERNEL);
-			if (*subsysid == NULL) {
-				dev_err(dev, "Cannot allocate Subsystem ID");
-				ret = -ENOMEM;
-			}
-		} else {
-			dev_warn(dev, "Warning ACPI _SUB did not return a string\n");
-			ret = -ENODEV;
-		}
-		acpi_os_free(buffer.pointer);
-	} else {
-		dev_dbg(dev, "Warning ACPI _SUB failed: %#x\n", status);
-		ret = -ENODEV;
-	}
-
-	return ret;
-}
-
 static int cs35l41_get_speaker_id(struct device *dev, int amp_index,
 				  int num_amps, int fixed_gpio_id)
 {
@@ -1182,6 +1152,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	u32 values[HDA_MAX_COMPONENTS];
 	struct acpi_device *adev;
 	struct device *physdev;
+	const char *sub;
 	char *property;
 	size_t nval;
 	int i, ret;
@@ -1195,11 +1166,10 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	physdev = get_device(acpi_get_first_physical_node(adev));
 	acpi_dev_put(adev);
 
-	ret = cs35l41_get_acpi_sub_string(cs35l41->dev, adev, &cs35l41->acpi_subsystem_id);
-	if (ret)
-		dev_info(cs35l41->dev, "No Subsystem ID found in ACPI: %d", ret);
-	else
-		dev_dbg(cs35l41->dev, "Subsystem ID %s found", cs35l41->acpi_subsystem_id);
+	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
+	if (IS_ERR(sub))
+		sub = NULL;
+	cs35l41->acpi_subsystem_id = sub;
 
 	property = "cirrus,dev-index";
 	ret = device_property_count_u32(physdev, property);
@@ -1434,6 +1404,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
+	kfree(cs35l41->acpi_subsystem_id);
 
 	return ret;
 }
@@ -1456,6 +1427,7 @@ void cs35l41_hda_remove(struct device *dev)
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
+	kfree(cs35l41->acpi_subsystem_id);
 }
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_remove, SND_HDA_SCODEC_CS35L41);
 
-- 
2.35.1

