Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A3348A5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiAKCva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:51:30 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:51648 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229544AbiAKCv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:51:28 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowABnb1uO8NxhZQNmBQ--.51057S2;
        Tue, 11 Jan 2022 10:50:54 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, tony@atomide.com, sre@kernel.org, pavel@ucw.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] ASoC: cpcap: Check for NULL pointer after calling of_get_child_by_name
Date:   Tue, 11 Jan 2022 10:50:48 +0800
Message-Id: <20220111025048.524134-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnb1uO8NxhZQNmBQ--.51057S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr13KFy3XryxZryktF4fXwb_yoWfKwb_K3
        y8ua9agry2q3WIqFZrZw12vrnYvrn3Cr1jqr4ktry7ta45AF4fJanxZr13ur4UWrs7WFy5
        GF9I9rW2yr12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbpwZ7UUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device does not exist, of_get_child_by_name() will return NULL
pointer.
And devm_snd_soc_register_component() does not check it.
Also, I have noticed that cpcap_codec_driver has not been used yet.
Therefore, it should be better to check it in order to avoid the future
dereference of the NULL pointer.

Fixes: f6cdf2d3445d ("ASoC: cpcap: new codec")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 sound/soc/codecs/cpcap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
index 05bbacd0d174..f1c13f42e1c1 100644
--- a/sound/soc/codecs/cpcap.c
+++ b/sound/soc/codecs/cpcap.c
@@ -1667,6 +1667,8 @@ static int cpcap_codec_probe(struct platform_device *pdev)
 {
 	struct device_node *codec_node =
 		of_get_child_by_name(pdev->dev.parent->of_node, "audio-codec");
+	if (!codec_node)
+		return -ENODEV;
 
 	pdev->dev.of_node = codec_node;
 
-- 
2.25.1

