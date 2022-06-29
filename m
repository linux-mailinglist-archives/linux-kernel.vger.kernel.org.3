Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EE56072F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiF2RSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiF2RSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:18:21 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ACA814D21
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4LY16
        jXNOO3NnZYt2XPxv6e2XDSY56+x04x00eM0eSw=; b=Ku9xFXFMF8qJehaXdeeiT
        /3lE3nhviqQ15HlgwyIZs4JhRD2/jjwOIVXwJbxx1TDlWlRPt/nGayV5GKrM09z2
        EsjRKLCai72AfqwFfJUHnLNbHHwbjM0F2te0q9GN/TMbOCDLzuWJhNOOkcAqHPUe
        cAj70vsHQ7gM20wrngTftM=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp4 (Coremail) with SMTP id HNxpCgBH9dwDibxiJ3aiLw--.50037S4;
        Thu, 30 Jun 2022 01:16:59 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     perex@perex.cz, tiwai@suse.com, colin.king@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] ALSA: hda/ca0132: fix potential memory leak in dspxfr_image()
Date:   Thu, 30 Jun 2022 01:16:50 +0800
Message-Id: <20220629171650.2162130-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgBH9dwDibxiJ3aiLw--.50037S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1rCFWfJrWxGFWDWFWrGrg_yoW8Jw1rpa
        y8GrWDGrZ7Xr1qyw4rJ34jga1rG3ykZFyftrWYk3Z3Z3sIgryDXas8G3sYvF4S9FW09ryU
        XFWkAwn8JayDtF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRxOz-UUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiMgsvjFWBztXbKAAAsm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dspxfr_image() allocates DSP ports for the download stream with
dsp_allocate_ports_format(). When some error occurs, the allocated
DSP ports are not released, which will lead to a memory leak.

We can fix it by releasing DSP ports with dsp_free_ports() if some
error occurs.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 sound/pci/hda/patch_ca0132.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 208933792787..6b8f45e14075 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3455,6 +3455,7 @@ static int dspxfr_image(struct hda_codec *codec,
 					&port_map_mask);
 	if (status < 0) {
 		codec_dbg(codec, "alloc ports fail\n");
+		dsp_free_ports(codec);
 		goto exit;
 	}
 
@@ -3463,6 +3464,7 @@ static int dspxfr_image(struct hda_codec *codec,
 			WIDGET_CHIP_CTRL, stream_id, 0, &response);
 	if (status < 0) {
 		codec_dbg(codec, "set stream chan fail\n");
+		dsp_free_ports(codec);
 		goto exit;
 	}
 
@@ -3470,6 +3472,7 @@ static int dspxfr_image(struct hda_codec *codec,
 		if (!is_valid(fls_data)) {
 			codec_dbg(codec, "FLS check fail\n");
 			status = -EINVAL;
+			dsp_free_ports(codec);
 			goto exit;
 		}
 		status = dspxfr_one_seg(codec, fls_data, reloc,
-- 
2.25.1

