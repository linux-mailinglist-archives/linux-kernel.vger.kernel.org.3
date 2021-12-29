Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03540480EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 03:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbhL2C30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 21:29:26 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:52402 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229620AbhL2C30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 21:29:26 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowABnb3_kx8thSpE9BQ--.9864S2;
        Wed, 29 Dec 2021 10:28:52 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] staging: greybus: audio: Check null pointer
Date:   Wed, 29 Dec 2021 10:28:50 +0800
Message-Id: <20211229022850.1682897-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABnb3_kx8thSpE9BQ--.9864S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw13uF13KF45Kr45tr1DKFg_yoWrWry7pF
        s5KrnxAr4DJasIkFs7Ar4rZ3ZxZ34kGFWUK3y7W3yDZrsIqrW09ay3KFyYvF13uFy8Zw40
        ya1IvF45X3WqvrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbpwZ7UUUU
        U==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 10:50:22PM +0800, Alex Elder wrote:
> But the two places you're returning are in the middle of a loop (in 
> gbaudio_tplg_create_widget() and gbaudio_tplg_process_kcontrols()).
> Each is building up a sort of hierarchical data structure, and as
> you can see, the existing code takes care to de-construct the partially
> built structure in the event an error occurs before it completes.
>
> There is a chance that your simple return would "work", but by
> reading the surrounding code you should recognize that the proper
> way to handle the error is to jump to the cleanup at the end.

Yes, I agree with your opinion and this time I use "goto error" instead
of directly return in the two callers.
The new patch is as follow.

As the possible alloc failure of devm_kcalloc(), it could return null
pointer.
Therefore, 'strings' should be checked and return NULL if alloc fails to
prevent the dereference of the NULL pointer.
Also, the caller should also deal with the return value of the
gb_generate_enum_strings() and return -ENOMEM if returns NULL.
Moreover, because the memory allocated with devm_kzalloc() will be
freed automatically when the last reference to the device is dropped,
the 'gbe' in gbaudio_tplg_create_enum_kctl() and
gbaudio_tplg_create_enum_ctl() do not need to free manually.
But the 'control' in gbaudio_tplg_create_widget() and
gbaudio_tplg_process_kcontrols() has a specially error handle to
cleanup.
So it should be better to cleanup 'control' when fails.

Fixes: e65579e335da ("greybus: audio: topology: Enable enumerated control support")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2

*Change 1. Add the cleanup process when alloc fails in two callers and
refine the commit message.
---
 drivers/staging/greybus/audio_topology.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 1fc7727ab7be..6bba735d2e5c 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -147,6 +147,9 @@ static const char **gb_generate_enum_strings(struct gbaudio_module_info *gb,
 
 	items = le32_to_cpu(gbenum->items);
 	strings = devm_kcalloc(gb->dev, items, sizeof(char *), GFP_KERNEL);
+	if (!strings)
+		return NULL;
+
 	data = gbenum->names;
 
 	for (i = 0; i < items; i++) {
@@ -655,6 +658,8 @@ static int gbaudio_tplg_create_enum_kctl(struct gbaudio_module_info *gb,
 	/* since count=1, and reg is dummy */
 	gbe->items = le32_to_cpu(gb_enum->items);
 	gbe->texts = gb_generate_enum_strings(gb, gb_enum);
+	if (!gbe->texts)
+		return -ENOMEM;
 
 	/* debug enum info */
 	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->items,
@@ -862,6 +867,8 @@ static int gbaudio_tplg_create_enum_ctl(struct gbaudio_module_info *gb,
 	/* since count=1, and reg is dummy */
 	gbe->items = le32_to_cpu(gb_enum->items);
 	gbe->texts = gb_generate_enum_strings(gb, gb_enum);
+	if (!gbe->texts)
+		return -ENOMEM;
 
 	/* debug enum info */
 	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->items,
@@ -1034,6 +1041,10 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 			csize += le16_to_cpu(gbenum->names_length);
 			control->texts = (const char * const *)
 				gb_generate_enum_strings(module, gbenum);
+			if (!control->texts) {
+				ret = -ENOMEM;
+				goto error;
+			}
 			control->items = le32_to_cpu(gbenum->items);
 		} else {
 			csize = sizeof(struct gb_audio_control);
@@ -1183,6 +1194,10 @@ static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
 			csize += le16_to_cpu(gbenum->names_length);
 			control->texts = (const char * const *)
 				gb_generate_enum_strings(module, gbenum);
+			if (!control->texts) {
+				ret = -ENOMEM;
+				goto error;
+			}
 			control->items = le32_to_cpu(gbenum->items);
 		} else {
 			csize = sizeof(struct gb_audio_control);
-- 
2.25.1

