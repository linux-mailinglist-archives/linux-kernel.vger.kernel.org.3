Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099F948D622
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiAMKzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:55:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:24902 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230354AbiAMKzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642071339; x=1673607339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FhVHgSN/lNJeu2IDjj6rTRXUr8eMT8m7IgjmIJEwy3Y=;
  b=PDBX3OKvTknYI/5b7wIyPPFvBQXwYOw8AjYVKZRWgRWgQJrH5tOe6VSh
   7lE2byljhgvNeAItKlQHOKkt5sVN7/86ldfzh32NbhjU8QOSGymkaKHcQ
   iLo48ljtG+nE3E5hWjlgcUU9mMQeoW6I24iKg09dMKjujTJ2l8AaocTcT
   beEi/yAW6BMqBNL3ESJQioT1m7c7qtNF1AlQzGnL89SJOFuzw9BFYkhaH
   JWF5kjz+kOmTs3xxpd2qIj29bV3lmK3KiLj6fRZJdvzMQN0+TxQod+2/j
   YgEww+eniiZoKmnjvdm+TgZf2yhUaBbVo25uEuWVsFvqkUiXzsSxx/USd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307330238"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307330238"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:55:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="475267052"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2022 02:55:19 -0800
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>, Brent Lu <brent.lu@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ALSA: hda: intel-dsp-config: add JasperLake support
Date:   Thu, 13 Jan 2022 18:52:19 +0800
Message-Id: <20220113105220.1114694-2-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113105220.1114694-1-brent.lu@intel.com>
References: <20220113105220.1114694-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rules to select SOF driver for Jasper Lake systems if digital
microphone is present or the system is a Chromebook.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/hda/intel-dsp-config.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index c26229ed642f..3a3026fa4a17 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -309,13 +309,30 @@ static const struct config_entry config_table[] = {
 	},
 #endif
 
-/* JasperLake */
+/* Jasper Lake */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_JASPERLAKE)
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
 	{
 		.flags = FLAG_SOF,
 		.device = 0x4dc8,
 		.codec_hid = "ESSX8336",
 	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC,
+		.device = 0x4dc8,
+	},
 #endif
 
 /* Tigerlake */
-- 
2.25.1

