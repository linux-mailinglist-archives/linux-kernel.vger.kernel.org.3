Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852B5567E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiGFGUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGFGUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:20:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB0814D3A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657088439; x=1688624439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WCNFrp3GBFE7vxeb/x0ph+v6bM71Q3gAe1RlvA/BV6U=;
  b=Uwt/JPsXn+oiHVxDPZVpcMO3PodjiltgQSw4c4DVc2jrjNorGJdrfaIO
   omB2TAvCRTzvSvE6Zm48S4LpgNsDhzK3tZvSB8u3h3YF32UO9X7JFlasf
   96kxBMl9P/9/zLHA8VygwbTs8N086tblgDPplsPINuKkMW3/lxGEluhry
   R2DOYC/nLNiapj9O5s9Atn89fS0bVLdT0GUi20MZwpsy5xtRc0hEEr6/c
   uiBvmowLYBpmU6qGPSHBPJap6cGM5Uy7aoqKd0kIaG1UXEhqUbGTh9apJ
   +Aj3TF7t9vlbCxj4rToxue3ar7aRk/7DdW3o5RCHOIupogZdbOxouFyKh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="263443662"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="263443662"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 23:20:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="650520723"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2022 23:20:36 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     tiwai@suse.com, perex@perex.cz,
        amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        sfr@canb.auug.org.au, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: Intel: avs: Fix i2s_test card name initialization
Date:   Wed,  6 Jul 2022 08:29:52 +0200
Message-Id: <20220706062952.251704-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update printf formatting as 'ssp_port' argument is of type 'int', not
'long int'.

Fixes: e39acc4cfd92 ("ASoC: Intel: avs: Add I2S-test machine board")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/avs/boards/i2s_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/boards/i2s_test.c b/sound/soc/intel/avs/boards/i2s_test.c
index 461b651cd331..8f0fd87bc866 100644
--- a/sound/soc/intel/avs/boards/i2s_test.c
+++ b/sound/soc/intel/avs/boards/i2s_test.c
@@ -127,7 +127,7 @@ static int avs_i2s_test_probe(struct platform_device *pdev)
 	if (!card)
 		return -ENOMEM;
 
-	card->name = devm_kasprintf(dev, GFP_KERNEL, "ssp%ld-loopback", ssp_port);
+	card->name = devm_kasprintf(dev, GFP_KERNEL, "ssp%d-loopback", ssp_port);
 	if (!card->name)
 		return -ENOMEM;
 
-- 
2.25.1

