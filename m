Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6A47A51E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 07:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhLTGuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 01:50:09 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:39018 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234245AbhLTGuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 01:50:08 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowADX3Z2LJ8BhM+lcBA--.36169S2;
        Mon, 20 Dec 2021 14:49:49 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     ok@artecdesign.ee, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] USB: host: Check for null res pointer
Date:   Mon, 20 Dec 2021 14:49:46 +0800
Message-Id: <20211220064946.817004-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADX3Z2LJ8BhM+lcBA--.36169S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW5ZF48KFyxCry3GFy8Krg_yoWDWFg_Cw
        4F9rn5Kr1DCFn0ya18Ar13C392vwsrWr45u3W8ta4avryjqw17G3yDurWfAF98Xw4DAryD
        GryDArs3Z345ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8AwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU24E_UUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of platform_get_resource() needs to be checked.
To avoid use of error pointer in case of the failure of alloc.

Fixes: 4808a1c02611 ("[PATCH] USB: Add isp116x-hcd USB host controller driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/usb/host/isp116x-hcd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/isp116x-hcd.c b/drivers/usb/host/isp116x-hcd.c
index 8835f6bd528e..addd2b43a14c 100644
--- a/drivers/usb/host/isp116x-hcd.c
+++ b/drivers/usb/host/isp116x-hcd.c
@@ -1541,9 +1541,15 @@ static int isp116x_remove(struct platform_device *pdev)
 
 	iounmap(isp116x->data_reg);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -EINVAL;
+
 	release_mem_region(res->start, 2);
 	iounmap(isp116x->addr_reg);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
 	release_mem_region(res->start, 2);
 
 	usb_put_hcd(hcd);
-- 
2.25.1

