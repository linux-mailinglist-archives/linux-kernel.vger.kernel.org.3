Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A843578068
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiGRLFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGRLFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:05:14 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 04:05:13 PDT
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975151F2CD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:05:13 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,280,1650960000"; 
   d="scan'208";a="82587672"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 18 Jul 2022 03:04:08 -0800
IronPort-SDR: KOLm0fDLK17UpztQZHEOU5e2xawaiZVzBw4G8CBYJEeLKxtuqJtFywAAQ9j0ljtTxxAP5TOKpW
 GyBfn0wKp9zk8UIadzBPooNUcb0tWXJoKzledJEWzThCBbnY4ZLGEoc6rs79HR84FToENs4DLo
 4lzixczAIatDJ8yy+x7Dr9U4VL/NjPPEVEURIL2W0zucDrOOy+2kI0ve3a7J8T2p3vnWCc95O6
 Y/8L7KCq73kAi5iGfFOaqXupBtRZjbzSl9PhkvY4mjMmnV1EY850RaTndEoyH7HOpk9ZGmT/ee
 OXg=
From:   Jiada Wang <jiwang_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>, <Dean_Jenkins@mentor.com>,
        <erosca@de.adit-jv.com>
Subject: [PATCH v1 1/1] rsnd: ssiu: add missing .quit callback for gen2
Date:   Mon, 18 Jul 2022 20:04:04 +0900
Message-ID: <20220718110404.1529085-1-jiwang_wang@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jiada <jiada_wang@mentor.com>

commit 83b220cf8eb2a ("ASoC: rsnd: implement BUSIF related
code in ssiu.c") moved BUSIF related code in ssiu.c
which added .quit callback in ssiu.c to disable error irq
when ssiu quits.

But .quit callback was added only for gen1 and is missing
for gen2, this causes error irq is left enabled after ssiu
quits on gen2.

This commit adds missing .quit callback for gen2

Signed-off-by: Wang Jiada <jiada_wang@mentor.com>
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 sound/soc/sh/rcar/ssiu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 4b8a63e336c7..19a8030a660d 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -417,6 +417,7 @@ static struct rsnd_mod_ops rsnd_ssiu_ops_gen2 = {
 	.name		= SSIU_NAME,
 	.dma_req	= rsnd_ssiu_dma_req,
 	.init		= rsnd_ssiu_init_gen2,
+	.quit		= rsnd_ssiu_quit,
 	.start		= rsnd_ssiu_start_gen2,
 	.stop		= rsnd_ssiu_stop_gen2,
 	.get_status	= rsnd_ssiu_get_status,
-- 
2.25.1

