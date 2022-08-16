Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6513B595854
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiHPKbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbiHPKa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:30:26 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE69422EE
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:55:53 -0700 (PDT)
X-QQ-mid: bizesmtp75t1660640107t9u3xd1f
Received: from localhost.localdomain ( [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 16:55:04 +0800 (CST)
X-QQ-SSF: 01400000002000D0T000B00A0000000
X-QQ-FEAT: 6aXALTFZqPsYTigoi/pJHQIrfEjlbZTVVo4ceE/miflM2QL0ScN/MLKWd9pj/
        GpI0Y0g4qovfiem9q3Z4SWKP5MlRzDTno+u3GL4PM5mbtBXO1WJo87SgDryelNO5b+KbCo1
        NDdEC7iYKBCJIT0zjx28cAXU3afo3bcJHpKQb+2xypQmKjrX3+PeqMkUlok2zrH4YSP6Xof
        P3ocSKToVuCM5NhP6UKY0j5U0XyEvbkqt2W0HGR4i3ACGDI2sCY6IUEAEDzg9Guy1VXWsYn
        0JNzO3WBs1tO1hvkNDIpnW6zFIBetn4QxfGTB6REcvv59IkDvcTLffgOOQkscmi22zR2iCW
        23sOHumGks+sjSme0AjnLWeAEAfLBIVMJUhoPNL8cSi/hAbBEWF2FigQ7QXiw==
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org,
        guennadi.liakhovetski@linux.intel.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] ASoC: intel: Replace scnprintf() calls with sysfs_emit_at()
Date:   Tue, 16 Aug 2022 16:55:02 +0800
Message-Id: <20220816085502.25295-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
instead of the raw sprintf() & co.  This patch replaces the open-code
with a new helper, sysfs_emit_at(), by passing the string offset.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 sound/soc/sof/intel/hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 6d4ecbe14adf..917d639671a7 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -574,7 +574,7 @@ static void hda_dsp_dump_ext_rom_status(struct snd_sof_dev *sdev, const char *le
 	chip = get_chip_info(sdev->pdata);
 	for (i = 0; i < HDA_EXT_ROM_STATUS_SIZE; i++) {
 		value = snd_sof_dsp_read(sdev, HDA_DSP_BAR, chip->rom_status_reg + i * 0x4);
-		len += scnprintf(msg + len, sizeof(msg) - len, " 0x%x", value);
+		len += sysfs_emit_at(msg, len, " 0x%x", value);
 	}
 
 	dev_printk(level, sdev->dev, "extended rom status: %s", msg);
-- 
2.20.1

