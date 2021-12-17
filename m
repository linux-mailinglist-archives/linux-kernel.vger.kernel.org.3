Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCA94782EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 03:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhLQCBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 21:01:13 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:57680 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231336AbhLQCBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:01:10 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowADX3p5R77thyz23Aw--.30715S2;
        Fri, 17 Dec 2021 10:00:51 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     alexander.shishkin@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] intel_th: msu-sink: potential dereference of null pointer
Date:   Fri, 17 Dec 2021 10:00:47 +0800
Message-Id: <20211217020047.446983-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADX3p5R77thyz23Aw--.30715S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKry5Gw43trykuF48Gw43GFg_yoWfZrX_Cw
        45Wr93GryqgF1S93WUAa43AryIkayxWr4kZrn2g3yav343uFn8Xryqv343ArsrZryDCFZ5
        Ja9rKryruw15CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gr1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUgVyxUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of dma_alloc_coherent() needs to be checked.
To avoid use of null pointer in sg_set_buf() in case of the failure of
alloc.

Fixes: f220df66f676 ("intel_th: msu-sink: An example msu buffer "sink"")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/hwtracing/intel_th/msu-sink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/intel_th/msu-sink.c b/drivers/hwtracing/intel_th/msu-sink.c
index 2c7f5116be12..891b28ea25fe 100644
--- a/drivers/hwtracing/intel_th/msu-sink.c
+++ b/drivers/hwtracing/intel_th/msu-sink.c
@@ -71,6 +71,9 @@ static int msu_sink_alloc_window(void *data, struct sg_table **sgt, size_t size)
 		block = dma_alloc_coherent(priv->dev->parent->parent,
 					   PAGE_SIZE, &sg_dma_address(sg_ptr),
 					   GFP_KERNEL);
+		if (!block)
+			return -ENOMEM;
+
 		sg_set_buf(sg_ptr, block, PAGE_SIZE);
 	}
 
-- 
2.25.1

