Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DEE47ED99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352155AbhLXJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:04:15 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:49956 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241559AbhLXJEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:04:14 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowABnbp7pjMVhX9gFBQ--.25613S2;
        Fri, 24 Dec 2021 17:03:37 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] staging: greybus: audio: Check null pointer
Date:   Fri, 24 Dec 2021 17:03:36 +0800
Message-Id: <20211224090336.1612305-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABnbp7pjMVhX9gFBQ--.25613S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy5ZF1kJrW7Jw4rtr13Jwb_yoW5Xw1fpF
        sYkr9Iyr4UJasI9Fs7Ars5Z3ZxZ34kKFWUK3y7Ww45ZrsIqrW093W3KryYvFn8Wr18Jw4F
        ya10vrW5A3Wqqr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
        cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4BT5UUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible alloc failure of devm_kcalloc, it could return null
pointer.
To prevent the dereference of the null pointer, it should be checked.

Fixes: e65579e335da ("greybus: audio: topology: Enable enumerated control support")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/staging/greybus/audio_topology.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 1fc7727ab7be..e9f47a1f0d28 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -146,7 +146,11 @@ static const char **gb_generate_enum_strings(struct gbaudio_module_info *gb,
 	__u8 *data;
 
 	items = le32_to_cpu(gbenum->items);
+
 	strings = devm_kcalloc(gb->dev, items, sizeof(char *), GFP_KERNEL);
+	if (!strings)
+		return NULL;
+
 	data = gbenum->names;
 
 	for (i = 0; i < items; i++) {
@@ -654,7 +658,10 @@ static int gbaudio_tplg_create_enum_kctl(struct gbaudio_module_info *gb,
 
 	/* since count=1, and reg is dummy */
 	gbe->items = le32_to_cpu(gb_enum->items);
+
 	gbe->texts = gb_generate_enum_strings(gb, gb_enum);
+	if (!gbe->texts)
+		return -ENOMEM;
 
 	/* debug enum info */
 	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->items,
@@ -861,7 +868,10 @@ static int gbaudio_tplg_create_enum_ctl(struct gbaudio_module_info *gb,
 
 	/* since count=1, and reg is dummy */
 	gbe->items = le32_to_cpu(gb_enum->items);
+
 	gbe->texts = gb_generate_enum_strings(gb, gb_enum);
+	if (!gbe->texts)
+		return -ENOMEM;
 
 	/* debug enum info */
 	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->items,
@@ -1032,8 +1042,12 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 			csize += offsetof(struct gb_audio_ctl_elem_info, value);
 			csize += offsetof(struct gb_audio_enumerated, names);
 			csize += le16_to_cpu(gbenum->names_length);
+
 			control->texts = (const char * const *)
 				gb_generate_enum_strings(module, gbenum);
+			if (!control->texts)
+				return -ENOMEM;
+
 			control->items = le32_to_cpu(gbenum->items);
 		} else {
 			csize = sizeof(struct gb_audio_control);
@@ -1181,8 +1195,12 @@ static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
 			csize += offsetof(struct gb_audio_ctl_elem_info, value);
 			csize += offsetof(struct gb_audio_enumerated, names);
 			csize += le16_to_cpu(gbenum->names_length);
+
 			control->texts = (const char * const *)
 				gb_generate_enum_strings(module, gbenum);
+			if (!control->texts)
+				return -ENOMEM;
+
 			control->items = le32_to_cpu(gbenum->items);
 		} else {
 			csize = sizeof(struct gb_audio_control);
-- 
2.25.1

