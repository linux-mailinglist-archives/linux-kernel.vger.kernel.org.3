Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8168E48D623
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiAMKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:55:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:24902 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233747AbiAMKzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642071340; x=1673607340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K42JSa+QW3UaIuzTP0hhO/S5VNVEbXBxl5jgOoJNEY8=;
  b=GnN89BfGgDqOilpz2wBtgsXVWNmrN/FbxA/Q4v6E7fngvZ9PZ2tjFkOl
   6GaClIOMvYezV4ZWlBu8zqam0BLx9bcxaKVA2DdkIPtIPsR9PkSUN1AlQ
   /6kbkRE4rAl8B3pJShvyZ+FTP0EXhyP0vM0tU7xZZxTUDeKNvuVHuJFin
   UufpfmEcCJQcODCEBYs+FrURsrGS+a7/J9C2Efu6xbi2oko0EqIkTCVNo
   0pV1UvANXuaUOiDUnST6UUcGxnpcL42RKnoUS+/L7sqjfGB7s9tYwwUOp
   l9IKjW50IDYbQXc6EmPdrdhZhPhifKHKSd0+voMqN3hE/OeXHFRhlRGH9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307330242"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307330242"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="475267073"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2022 02:55:21 -0800
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>, Brent Lu <brent.lu@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ALSA: hda: intel-dsp-config: reorder the config table
Date:   Thu, 13 Jan 2022 18:52:20 +0800
Message-Id: <20220113105220.1114694-3-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113105220.1114694-1-brent.lu@intel.com>
References: <20220113105220.1114694-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entries without dmi_table nor codec_hid field need to be placed after
entries with these two fields or they will be always selected.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/hda/intel-dsp-config.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 3a3026fa4a17..4fb90ceb4053 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -249,13 +249,13 @@ static const struct config_entry config_table[] = {
 		}
 	},
 	{
-		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.flags = FLAG_SOF,
 		.device = 0x02c8,
+		.codec_hid = "ESSX8336",
 	},
 	{
-		.flags = FLAG_SOF,
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = 0x02c8,
-		.codec_hid = "ESSX8336",
 	},
 /* Cometlake-H */
 	{
@@ -278,14 +278,14 @@ static const struct config_entry config_table[] = {
 		}
 	},
 	{
-		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x06c8,
-	},
-		{
 		.flags = FLAG_SOF,
 		.device = 0x06c8,
 		.codec_hid = "ESSX8336",
 	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = 0x06c8,
+	},
 #endif
 
 /* Icelake */
@@ -351,17 +351,17 @@ static const struct config_entry config_table[] = {
 		}
 	},
 	{
-		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.flags = FLAG_SOF,
 		.device = 0xa0c8,
+		.codec_hid = "ESSX8336",
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x43c8,
+		.device = 0xa0c8,
 	},
 	{
-		.flags = FLAG_SOF,
-		.device = 0xa0c8,
-		.codec_hid = "ESSX8336",
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = 0x43c8,
 	},
 #endif
 
-- 
2.25.1

