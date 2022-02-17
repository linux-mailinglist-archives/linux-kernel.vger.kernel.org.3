Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0522F4BA384
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbiBQOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:48:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbiBQOsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:48:35 -0500
X-Greylist: delayed 4777 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 06:48:18 PST
Received: from 2.mo575.mail-out.ovh.net (2.mo575.mail-out.ovh.net [46.105.52.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72360160439
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:48:18 -0800 (PST)
Received: from player715.ha.ovh.net (unknown [10.110.208.99])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 185A521852
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:28:39 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id 427C6275AA832;
        Thu, 17 Feb 2022 13:28:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-105G006e63af0f4-c81f-4ba4-8116-8bbaba4cb0a8,
                    22612CF5F7DCE3600E782894758BDCCEF4E309CF) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, Stephen Kitt <steve@sk2.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH] ASoC: SOF: Replace zero-length array with flexible-array member
Date:   Thu, 17 Feb 2022 14:27:55 +0100
Message-Id: <20220217132755.1786130-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5586152390832588312
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepleekieffleegledvfffhkeehleejfedtgeeuiedvleduffetfeetgeffudffkeevnecuffhomhgrihhnpeifihhkihhpvgguihgrrdhorhhgpdhkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeduhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use "flexible array members"[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/78
Link: https://github.com/KSPP/linux/issues/180
Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 include/sound/sof/topology.h | 2 +-
 sound/soc/sof/topology.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
index d12736e14b69..adee6afd1490 100644
--- a/include/sound/sof/topology.h
+++ b/include/sound/sof/topology.h
@@ -237,7 +237,7 @@ struct sof_ipc_comp_process {
 	/* reserved for future use */
 	uint32_t reserved[7];
 
-	uint8_t data[0];
+	uint8_t data[];
 } __packed;
 
 /* frees components, buffers and pipelines
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index e72dcae5e7ee..1d119d1dd69d 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2164,7 +2164,7 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
 	 */
 	if (ipc_data_size) {
 		for (i = 0; i < widget->num_kcontrols; i++) {
-			memcpy(&process->data + offset,
+			memcpy(&process->data[offset],
 			       wdata[i].pdata->data,
 			       wdata[i].pdata->size);
 			offset += wdata[i].pdata->size;

base-commit: f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
-- 
2.27.0

