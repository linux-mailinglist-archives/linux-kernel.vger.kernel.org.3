Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F20481863
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 03:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhL3CMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 21:12:02 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:50512 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232758AbhL3CMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:12:01 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowAA3UJJaFc1hMUHlBA--.8478S2;
        Thu, 30 Dec 2021 10:11:39 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     yokota@netlab.is.tsukuba.ac.jp, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] scsi: nsp_cs: Check of ioremap return value
Date:   Thu, 30 Dec 2021 10:11:37 +0800
Message-Id: <20211230021137.1823352-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAA3UJJaFc1hMUHlBA--.8478S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF47JF1rZFyfJryDWF17Wrg_yoWDJrb_ua
        yj9347JrZxWr10kw17Jr4SkryYyFZ8ZF1q9FyrKFyY939rZF1UCF18Xwn8Wwnru398Ja4D
        WwsFqF1rAw13AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4U
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbYhF7UUUU
        U==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the ioremap(), the 'data->MmioAddress' could
be NULL.
Therefore it should be better to check it in order to transfer the
error.

Fixes: 0e6f9d270840 ("pcmcia: use pcmcia_loop_config in scsi pcmcia drivers")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/scsi/pcmcia/nsp_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index ac89002646a3..bcd61439ca3f 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1560,6 +1560,9 @@ static int nsp_cs_config_check(struct pcmcia_device *p_dev, void *priv_data)
 		data->MmioAddress = (unsigned long)
 			ioremap(p_dev->resource[2]->start,
 					resource_size(p_dev->resource[2]));
+		if (!data->MmioAddress)
+			goto next_entry;
+
 		data->MmioLength  = resource_size(p_dev->resource[2]);
 	}
 	/* If we got this far, we're cool! */
-- 
2.25.1

