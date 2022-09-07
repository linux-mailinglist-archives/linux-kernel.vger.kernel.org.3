Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B345AFCFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiIGHA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiIGHAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:00:46 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 923AD4D4F6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gpA8V
        5pVUBWAKuao2rXSBnqg89Sc8Qap5SeGlb1rPH0=; b=DAAkSiGC+7yrIU20vZ8vp
        B9wBbjLsQdyzBOl2g0JLM+jjfphlgE3BmgKhHEtLQDoPf705ABH40eGkAIcb1I6m
        bP4NWmKIWFZjZoHt4qWSuaU4SgZUKq+UQY0yesKko9MyaiDsfESeWs8Yr0FIfien
        xCYalk1PblhX/tXKznZqE4=
Received: from localhost.localdomain (unknown [36.112.3.164])
        by smtp5 (Coremail) with SMTP id HdxpCgB3yRFKQRhj9Mwsag--.49282S4;
        Wed, 07 Sep 2022 14:59:30 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] ALSA: hda/ca0132: fix potential memory leak in dspxfr_image()
Date:   Wed,  7 Sep 2022 14:59:17 +0800
Message-Id: <20220907065917.55810-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgB3yRFKQRhj9Mwsag--.49282S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1rCFWDGFW7uw43Kw17Wrg_yoW8Jw17pa
        y8KrZ8GrZ7Xr1jyw4rJ34jg3WUW3ykZFyftr4Ykw1fZ3sIgFyDXas8G3sYvF4S9FWvkryU
        XFWkCwn8XayDtF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zilksPUUUUU=
X-Originating-IP: [36.112.3.164]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiQxJ1jFc7bS461AAAsp
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
dsp_allocate_ports_format(). When gets some error, the allocated
DSP ports are not released, which will lead to a memory leak.

We can fix it by releasing DSP ports with dsp_free_ports() when
getting some error.

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

