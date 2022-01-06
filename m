Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214FB486208
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiAFJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:23:19 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:42850 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237329AbiAFJXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:23:18 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowAAXHgLytNZh+qC1BQ--.58853S2;
        Thu, 06 Jan 2022 17:22:58 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org, knv418@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] staging: kpc2000: kpc2000_spi: Check for null pointer after calling devm_ioremap
Date:   Thu,  6 Jan 2022 17:22:57 +0800
Message-Id: <20220106092257.2738018-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAXHgLytNZh+qC1BQ--.58853S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GryUuFyftr13uFy8AF18Xwb_yoWkXrcEkF
        48u3ykC3yUC3s5A3WDZry5ZFy0yF4DZr4xtw4ktrZ3K3y3ZF4xWFyj9w1fXFyDZayUKry7
        C3yjk3Wa9r1q9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUOo7ZUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the allocation, the devm_ioremap() may return
NULL pointer.
Then the kpspi->base is assigned to cs->base in kp_spi_setup() and used
in kp_spi_read_reg() and kp_spi_write_reg().
Therefore, it should be better to add the sanity check and return error
in order to avoid the dereference of the NULL pointer.

Fixes: 677b993a5749 ("staging: kpc2000: kpc_spi: use devm_* API to manage mapped I/O space")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 16ca18b8aa15..ead4aa0c988c 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -466,6 +466,10 @@ kp_spi_probe(struct platform_device *pldev)
 
 	kpspi->base = devm_ioremap(&pldev->dev, r->start,
 				   resource_size(r));
+	if (!kpspi->base) {
+		status = -ENOMEM;
+		goto free_master;
+	}
 
 	status = spi_register_master(master);
 	if (status < 0) {
-- 
2.25.1

