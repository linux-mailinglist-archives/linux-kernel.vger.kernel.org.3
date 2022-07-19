Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A5C57A22B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbiGSOsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiGSOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:48:45 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BBCEAC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:48:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 600193F3BD;
        Tue, 19 Jul 2022 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658242122;
        bh=AvYcZcToBAAnfmFM45alM5FvVGJ3gSm105Dq6wUqcmw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=M4LBTZOIWTCzLkUwctVzsSbya8Nmf+Nic/k9snJH1tKr8hXrbajBgCf4e/GDxL2BZ
         YQdiyZ6ce2YAY9N9ToM5sWMqPsfXP93sDzGImIP+u4erSCxL/evPkfO9UHGfPfnm08
         9vJc9C93fZHH9SW2oCoT+XitJVQRnI9s9n+bYwHx5iz1Pm9kDxYqV2teZmygxf7389
         z7bmtF/hum06CSaqay9jFHFBIOiCK+hsAFKE7xGC8IUs4YRYbfN363mwYus/5q52zI
         w8MZRXbI9vti0BJ+nojXYWRfcti5II6ws4mlLIEUpZP8vUbeljxSPfL+z8dwHD4kjH
         Xqz3AOh8ahnpA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: Skip creating captures in SOF context
Date:   Tue, 19 Jul 2022 22:47:52 +0800
Message-Id: <20220719144753.252231-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On HP laptops that use SOF driver for DMIC, the micmute LED doesn't
light up when mic is muted after commit 9b014266ef8a ("ASoC: SOF:
topology: use new sound control LED layer").

The micmute LED itself is still working via sysfs, but it doesn't follow
mute anymore. That's because unlike vendors like Dell and Lenovo, HP
laptops use HDA codec to control mute LEDs instead of ACPI. So on HP
laptops, both SOF and HDA create captures with
SNDRV_CTL_ELEM_ACCESS_MIC_LED access, snd_ctl_led_set_state() considers
there are two different kcontrols and one of them is not muted.

So skip creating captures for HDA when it's called from SOF, the
captures are already handled by SOF.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_generic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index fc114e5224806..2a6c1a77c49ac 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5075,10 +5075,14 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 			return err;
 	}
 
-
-	err = create_capture_mixers(codec);
-	if (err < 0)
-		return err;
+	/* Skip creating capture on SOF which creates captures based on
+	 * topology file.
+	 */
+	if (codec->core.type != HDA_DEV_ASOC) {
+		err = create_capture_mixers(codec);
+		if (err < 0)
+			return err;
+	}
 
 	err = parse_mic_boost(codec);
 	if (err < 0)
-- 
2.36.1

