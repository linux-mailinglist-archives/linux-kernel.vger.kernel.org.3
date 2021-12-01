Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5114E46440A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345875AbhLAAwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:52:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:18121 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345867AbhLAAwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:52:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="299743880"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="299743880"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 16:48:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="540619572"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2021 16:48:53 -0800
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Xiuli Pan <xiuli.pan@intel.com>, Brent Lu <brent.lu@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: intel-dsp-config: add JasperLake support
Date:   Wed,  1 Dec 2021 08:46:28 +0800
Message-Id: <20211201004628.1153763-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rules to select SOF driver for Jasper Lake systems if digital
microphone is present or the system is a Chromebook.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/hda/intel-dsp-config.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index b9ac9e9e45a4..be47a1ca12b6 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -299,6 +299,27 @@ static const struct config_entry config_table[] = {
 	},
 #endif
 
+/* Jasper Lake */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_JASPERLAKE)
+	{
+		.flags = FLAG_SOF,
+		.device = 0x4dc8,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.ident = "Google Chromebooks",
+				.matches = {
+					DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+				}
+			},
+			{}
+		}
+	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC,
+		.device = 0x4dc8,
+	},
+#endif
+
 /* Tigerlake */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_TIGERLAKE)
 	{
-- 
2.25.1

