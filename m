Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761FF47A5BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbhLTIJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:09:49 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:58194 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237821AbhLTIJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:09:48 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowABXX1s4OsBhbOTtAw--.19265S2;
        Mon, 20 Dec 2021 16:09:28 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] usb: dwc2: Check for null res pointer
Date:   Mon, 20 Dec 2021 16:09:26 +0800
Message-Id: <20211220080926.883605-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXX1s4OsBhbOTtAw--.19265S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW5CF1fXw17GF1rXw4Utwb_yoWfJrXEqF
        sYga17G3yvkFyvkrWqyr1avryFk3Z7uw1fWFn5trW3Kay7ZF18Xryj9F4fCry3u34ayF9r
        Aa9rGrnxur1I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8ZwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUIzuXUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of platform_get_resource() needs to be checked.
To avoid use of error pointer in case of the failure of alloc.

Fixes: 348becdcc319 ("usb: dwc2: fix "iomem 0x00000000" message")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2

*Change 1. Correct the commit message.
---
 drivers/usb/dwc2/hcd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 2a7828971d05..517743555b9c 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5191,6 +5191,11 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 	hcd->has_tt = 1;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		retval = -EINVAL;
+		goto error1;
+	}
+
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 
-- 
2.25.1

