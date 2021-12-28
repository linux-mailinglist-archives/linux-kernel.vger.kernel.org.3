Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D64805FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 05:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhL1DlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 22:41:00 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:55426 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234740AbhL1Dk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 22:40:59 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowAAXHlorh8phNPjPBA--.38932S2;
        Tue, 28 Dec 2021 11:40:27 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     krzysztof.kozlowski@canonical.com, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] ASoC: samsung: idma: Check of ioremap return value
Date:   Tue, 28 Dec 2021 11:40:26 +0800
Message-Id: <20211228034026.1659385-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXHlorh8phNPjPBA--.38932S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1xZw45XrWrtFW8tFykAFb_yoWfGrb_Ka
        93uw1rWryDtF1Skr1DZrWUCr47X34UCF4xKr1Sqrn8JrWrJayfAw4fArZ3Cw1UXr4xCFZ8
        WF1UZrW7Cry3tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
        W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gr4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU-miiUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the potential failure of the ioremap(), the buf->area could
be NULL.
Therefore, we need to check it and return -ENOMEM in order to transfer
the error.

Fixes: f09aecd50f39 ("ASoC: SAMSUNG: Add I2S0 internal dma driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 sound/soc/samsung/idma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index 66bcc2f97544..c3f1b054e238 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -360,6 +360,8 @@ static int preallocate_idma_buffer(struct snd_pcm *pcm, int stream)
 	buf->addr = idma.lp_tx_addr;
 	buf->bytes = idma_hardware.buffer_bytes_max;
 	buf->area = (unsigned char * __force)ioremap(buf->addr, buf->bytes);
+	if (!buf->area)
+		return -ENOMEM;
 
 	return 0;
 }
-- 
2.25.1

