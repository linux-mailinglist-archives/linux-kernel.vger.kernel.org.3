Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B26457E0B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiGVLTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVLTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:19:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E36F8BABF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658488774; x=1690024774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tT9ALYJSV5LaLx0ox9r9S2itnE9o1KOtWzOII8e5iPk=;
  b=VcPRfz3UjDPzgxkOy1CAWazc/mIE8wrM5b6ThEKt/qHvT046RNtAGKjm
   SU+fPnAgD5B427+T3tHA4Nin4tjd/7nrtbKVYHmEM5QAoA5Fq2VInVGUA
   j4TG1dLzf6CaiKJ/sqjzlfuGbZu+dLSy5SS6tz5U4nUB59WEX0z/irbFU
   VWiyy/QvyXnWS6UC14gwVzcrOEW+ooGdk5hLNVUrL2mfTz2Jb8egDRD1Y
   s2yqfR5dNtcn5/7YHNtkOrEQbchOkrSb5klIWcX0GE8POIM1NpE6qujFD
   Wu8US3L63yfDfWMqvP2gNeWyLLOsfffckMklrEOPJWqWbHD9T/CpZDJtA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267689527"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="267689527"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 04:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="657179045"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jul 2022 04:19:30 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        alsa-devel@alsa-project.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH] ASoC: Intel: avs: Use lookup table to create modules
Date:   Fri, 22 Jul 2022 13:19:59 +0200
Message-Id: <20220722111959.2588597-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Nathan, when building avs driver using clang with:
  CONFIG_COMPILE_TEST=y
  CONFIG_FORTIFY_SOURCE=y
  CONFIG_KASAN=y
  CONFIG_PCI=y
  CONFIG_SOUND=y
  CONFIG_SND=y
  CONFIG_SND_SOC=y
  CONFIG_SND_SOC_INTEL_AVS=y

there are reports of too big stack use, like:
  sound/soc/intel/avs/path.c:815:18: error: stack frame size (2176) exceeds limit (2048) in 'avs_path_create' [-Werror,-Wframe-larger-than]
  struct avs_path *avs_path_create(struct avs_dev *adev, u32 dma_id,
                   ^
  1 error generated.

This is apparently caused by inlining many calls to guid_equal which
inlines fortified memcpy, using 2 size_t variables.

Instead of hardcoding many calls to guid_equal, use lookup table with
one call, this improves stack usage.

Link: https://lore.kernel.org/alsa-devel/YtlzY9aYdbS4Y3+l@dev-arch.thelio-3990X/T/
Link: https://github.com/ClangBuiltLinux/linux/issues/1642
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Build-tested-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/soc/intel/avs/path.c | 54 ++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/sound/soc/intel/avs/path.c b/sound/soc/intel/avs/path.c
index 3d46dd5e5bc4..ce157a8d6552 100644
--- a/sound/soc/intel/avs/path.c
+++ b/sound/soc/intel/avs/path.c
@@ -449,35 +449,39 @@ static int avs_modext_create(struct avs_dev *adev, struct avs_path_module *mod)
 	return ret;
 }
 
+static int avs_probe_create(struct avs_dev *adev, struct avs_path_module *mod)
+{
+	dev_err(adev->dev, "Probe module can't be instantiated by topology");
+	return -EINVAL;
+}
+
+struct avs_module_create {
+	guid_t *guid;
+	int (*create)(struct avs_dev *adev, struct avs_path_module *mod);
+};
+
+static struct avs_module_create avs_module_create[] = {
+	{ &AVS_MIXIN_MOD_UUID, avs_modbase_create },
+	{ &AVS_MIXOUT_MOD_UUID, avs_modbase_create },
+	{ &AVS_KPBUFF_MOD_UUID, avs_modbase_create },
+	{ &AVS_COPIER_MOD_UUID, avs_copier_create },
+	{ &AVS_MICSEL_MOD_UUID, avs_micsel_create },
+	{ &AVS_MUX_MOD_UUID, avs_mux_create },
+	{ &AVS_UPDWMIX_MOD_UUID, avs_updown_mix_create },
+	{ &AVS_SRCINTC_MOD_UUID, avs_src_create },
+	{ &AVS_AEC_MOD_UUID, avs_aec_create },
+	{ &AVS_ASRC_MOD_UUID, avs_asrc_create },
+	{ &AVS_INTELWOV_MOD_UUID, avs_wov_create },
+	{ &AVS_PROBE_MOD_UUID, avs_probe_create },
+};
+
 static int avs_path_module_type_create(struct avs_dev *adev, struct avs_path_module *mod)
 {
 	const guid_t *type = &mod->template->cfg_ext->type;
 
-	if (guid_equal(type, &AVS_MIXIN_MOD_UUID) ||
-	    guid_equal(type, &AVS_MIXOUT_MOD_UUID) ||
-	    guid_equal(type, &AVS_KPBUFF_MOD_UUID))
-		return avs_modbase_create(adev, mod);
-	if (guid_equal(type, &AVS_COPIER_MOD_UUID))
-		return avs_copier_create(adev, mod);
-	if (guid_equal(type, &AVS_MICSEL_MOD_UUID))
-		return avs_micsel_create(adev, mod);
-	if (guid_equal(type, &AVS_MUX_MOD_UUID))
-		return avs_mux_create(adev, mod);
-	if (guid_equal(type, &AVS_UPDWMIX_MOD_UUID))
-		return avs_updown_mix_create(adev, mod);
-	if (guid_equal(type, &AVS_SRCINTC_MOD_UUID))
-		return avs_src_create(adev, mod);
-	if (guid_equal(type, &AVS_AEC_MOD_UUID))
-		return avs_aec_create(adev, mod);
-	if (guid_equal(type, &AVS_ASRC_MOD_UUID))
-		return avs_asrc_create(adev, mod);
-	if (guid_equal(type, &AVS_INTELWOV_MOD_UUID))
-		return avs_wov_create(adev, mod);
-
-	if (guid_equal(type, &AVS_PROBE_MOD_UUID)) {
-		dev_err(adev->dev, "Probe module can't be instantiated by topology");
-		return -EINVAL;
-	}
+	for (int i = 0; i < ARRAY_SIZE(avs_module_create); i++)
+		if (guid_equal(type, avs_module_create[i].guid))
+			return avs_module_create[i].create(adev, mod);
 
 	return avs_modext_create(adev, mod);
 }
-- 
2.25.1

