Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDD947D33E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245552AbhLVNyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:54:46 -0500
Received: from ip-16.mailobj.net ([213.182.54.16]:32848 "EHLO msg-6.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245526AbhLVNym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1640181266; bh=y8jlbXfYt1AeDQhiMiTHZHLZPsddA25UVMnP2UJ9BiU=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=FFYy4yPP37Iov3V2+kplZ6D/SF/7+58u+X2LM7p/SAVsmZK8f934MeXz1iwQHl/OW
         MZfKgPvcc6pYt10lOF7HGXmknDx3MYnT4e2X+S2PUsOU4x5R1jepqRTA7Ui3bgXVrz
         0+fkf9pQ884/2fi4eNdWO368axGOewd5qey2jLw0=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Wed, 22 Dec 2021 14:54:26 +0100 (CET)
X-EA-Auth: t8EL3DbqiWC969FFZkRYrCyuIZ/vmSsrsNuxeYWaPTdY9PXzEbXh18Lb+DVV5hZO0XcqdB7WVS+XV8q+znoISXe03fXVjhpQUJMouuDhgps=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     broonie@kernel.org
Cc:     stephan@gerhold.net, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH] ASoC: codecs: ak4375: Change invert controls to a stereo switch
Date:   Wed, 22 Dec 2021 14:54:03 +0100
Message-Id: <20211222135403.2991657-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use enums for DACL/DACR Signal Invert controls,
and change them into a stereo "DAC Signal Invert Switch" control.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 sound/soc/codecs/ak4375.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/ak4375.c b/sound/soc/codecs/ak4375.c
index a893aff42a01..22cda0699341 100644
--- a/sound/soc/codecs/ak4375.c
+++ b/sound/soc/codecs/ak4375.c
@@ -127,7 +127,6 @@ static DECLARE_TLV_DB_SCALE(hpg_tlv, -4200, 20, 0);
 
 static const char * const ak4375_ovolcn_select_texts[]	= { "Dependent", "Independent" };
 static const char * const ak4375_mdac_select_texts[]	= { "x1", "x1/2" };
-static const char * const ak4375_inv_select_texts[]	= { "Normal", "Inverting" };
 static const char * const ak4375_cpmode_select_texts[]	= {
 	"Automatic Switching",
 	"+-VDD Operation",
@@ -157,12 +156,6 @@ static const struct soc_enum ak4375_mdacl_enum =
 static const struct soc_enum ak4375_mdacr_enum =
 	SOC_ENUM_SINGLE(AK4375_07_DAC_MONO_MIXING, 6,
 			ARRAY_SIZE(ak4375_mdac_select_texts), ak4375_mdac_select_texts);
-static const struct soc_enum ak4375_invl_enum =
-	SOC_ENUM_SINGLE(AK4375_07_DAC_MONO_MIXING, 3,
-			ARRAY_SIZE(ak4375_inv_select_texts), ak4375_inv_select_texts);
-static const struct soc_enum ak4375_invr_enum =
-	SOC_ENUM_SINGLE(AK4375_07_DAC_MONO_MIXING, 7,
-			ARRAY_SIZE(ak4375_inv_select_texts), ak4375_inv_select_texts);
 static const struct soc_enum ak4375_cpmode_enum =
 	SOC_ENUM_SINGLE(AK4375_03_POWER_MANAGEMENT4, 2,
 			ARRAY_SIZE(ak4375_cpmode_select_texts), ak4375_cpmode_select_texts);
@@ -176,11 +169,11 @@ static const struct snd_kcontrol_new ak4375_snd_controls[] = {
 	SOC_SINGLE_TLV("HP-Amp Analog Volume",
 		       AK4375_0D_HP_VOLUME_CONTROL, 0, 0x1f, 0, hpg_tlv),
 
+	SOC_DOUBLE("DAC Signal Invert Switch", AK4375_07_DAC_MONO_MIXING, 3, 7, 1, 0),
+
 	SOC_ENUM("Digital Volume Control", ak4375_ovolcn_enum),
 	SOC_ENUM("DACL Signal Level", ak4375_mdacl_enum),
 	SOC_ENUM("DACR Signal Level", ak4375_mdacr_enum),
-	SOC_ENUM("DACL Signal Invert", ak4375_invl_enum),
-	SOC_ENUM("DACR Signal Invert", ak4375_invr_enum),
 	SOC_ENUM("Charge Pump Mode", ak4375_cpmode_enum),
 	SOC_ENUM("DAC Digital Filter Mode", ak4375_digfil_enum),
 };
-- 
2.31.1



