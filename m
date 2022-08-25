Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C9A5A1BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbiHYWGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242951AbiHYWGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:06:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6925D10D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:06:09 -0700 (PDT)
Received: from localhost (unknown [188.27.54.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D20966601EB5;
        Thu, 25 Aug 2022 23:06:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661465168;
        bh=Q5+Bi1B/SMTx6MvZqr40BzbPGKrMBPLeIBYyqLazQ/8=;
        h=From:To:Cc:Subject:Date:From;
        b=gh6ftKJIVQLKO5dOmvcFnfcDOzXHWNzMS9IHXZj2byYLR8MxxEqTYAsGt7UmckXyl
         bNx2FSRFzzKbrfrDQPx6UsRpdJzjGrAmb/9nJaOD7OyndFWU9x8WtENvd0aq2JYNCU
         bPGGD1LMHXMtMYWqcN5i4vXfXi22vq0EBK+8kOSD3fhMnY+jvLDCWJcbmLIKl+Ziix
         K1i8wgWCxzjORxZbhRZfNBwhZcWkjOk8niA0b8YiCI3TO+V2Wn0igc3DyunWYxm2Rv
         u/Jv9Xoc1Sj8wL6TXlsie24cwPDe+Q6TpC9WzjpCN1VGketA87UoLR8asvOE78Hy1F
         kxoL511toqAlQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vlad Karpovich <Vlad.Karpovich@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2] ASoC: wm_adsp: Handle optional legacy support
Date:   Fri, 26 Aug 2022 01:05:30 +0300
Message-Id: <20220825220530.1205141-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracing capabilities for the speaker protection fw enabled via
commit c55b3e46cb99 ("ASoC: wm_adsp: Add trace caps to speaker
protection FW") are not be available on all platforms, such as the
Valve's Steam Deck which is based on the Halo Core DSP.

As a consequence, whenever the firmware is loaded, a rather misleading
'Failed to parse legacy: -19' error message is written to the kernel
ring buffer:

[  288.977412] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Firmware version: 3
[  288.978002] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: cs35l41-dsp1-spk-prot.wmfw: Fri 02 Apr 2021 21:03:50 W. Europe Daylight Time
[  289.094065] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Firmware: 400a4 vendor: 0x2 v0.33.0, 2 algorithms
[  289.095073] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: 0: ID cd v29.53.0 XM@94 YM@e
[  289.095665] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: 1: ID f20b v0.0.1 XM@170 YM@0
[  289.096275] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Protection: C:\Users\ocanavan\Desktop\cirrusTune_july2021.bin
[  291.172383] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Failed to parse legacy: -19

Update wm_adsp_buffer_init() to print a more descriptive info message
when wm_adsp_buffer_parse_legacy() returns -ENODEV.

Fixes: c55b3e46cb99 ("ASoC: wm_adsp: Add trace caps to speaker protection FW")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
 - Add a generic handling of the issue, not bound to a particular
   firmware, as suggested by Charles
 - Update commit message, including the subject, to reflect the changes

 sound/soc/codecs/wm_adsp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index cfaa45ede916..8a2e9771bb50 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1602,7 +1602,9 @@ static int wm_adsp_buffer_init(struct wm_adsp *dsp)
 	if (list_empty(&dsp->buffer_list)) {
 		/* Fall back to legacy support */
 		ret = wm_adsp_buffer_parse_legacy(dsp);
-		if (ret)
+		if (ret == -ENODEV)
+			adsp_info(dsp, "Legacy support not available\n");
+		else if (ret)
 			adsp_warn(dsp, "Failed to parse legacy: %d\n", ret);
 	}
 

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.2

