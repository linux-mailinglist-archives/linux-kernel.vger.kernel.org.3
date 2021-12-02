Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9FA465EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345635AbhLBHh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:37:58 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:43180
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345631AbhLBHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:37:54 -0500
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4BE0140078;
        Thu,  2 Dec 2021 07:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638430466;
        bh=daGfkCmFd2T/mh9PjPT6uP/gwdzM5b89BaR4Dee9AME=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Y9JzoMKtUSVYu7DWExsE8O7aCVt5r9gqMeOMA14v4kdvgJ1dHQavtfbv2KNN/d4XI
         hZ/CCtgN5EVwSapE6+KdCO7ekaEQgBZEQl6q7v9xrMSiKoPneeX9ndOaDxPdipbZJl
         R/NvmazaFiTCNPxbpjCpglLBD8KQpSiX912SL1o9FCmSMaHesXmBiR5RoOPXZ3ldWg
         3UsjIzIw84hwjp/lFSphRMD8d85/xmHJCiqrL42lIaOEfHDH5t3xCyaOciNeTTkMDD
         KCcxS0T18DZpkIBzffcKGHpqboQTAjj7H1dlvbxwEfO4LSSFtTUmv3zIE+ucXVbr9Z
         WFOaABUwDfMgg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/hdmi: Consider ELD is invalid when no SAD is present
Date:   Thu,  2 Dec 2021 15:33:35 +0800
Message-Id: <20211202073338.1384768-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a system that reports a bogus HDMI audio interface:
$ cat eld#2.0
monitor_present         1
eld_valid               1
monitor_name
connection_type         DisplayPort
eld_version             [0x2] CEA-861D or below
edid_version            [0x3] CEA-861-B, C or D
manufacture_id          0xe430
product_id              0x690
port_id                 0x0
support_hdcp            0
support_ai              0
audio_sync_delay        0
speakers                [0xffff] FL/FR LFE FC RL/RR RC FLC/FRC RLC/RRC FLW/FRW FLH/FRH TC FCH
sad_count               0

Since playing audio is not possible without SAD, also consider ELD is
invalid for this case.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 415701bd10ac8..e7c2f3167f311 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1535,7 +1535,7 @@ static void update_eld(struct hda_codec *codec,
 		}
 	}
 
-	if (!eld->eld_valid || eld->eld_size <= 0) {
+	if (!eld->eld_valid || eld->eld_size <= 0 || eld->info.sad_count <= 0) {
 		eld->eld_valid = false;
 		eld->eld_size = 0;
 	}
-- 
2.32.0

