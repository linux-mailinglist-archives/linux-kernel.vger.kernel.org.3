Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F952B47A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiERIOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiERIOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:14:19 -0400
X-Greylist: delayed 138834 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 May 2022 01:14:14 PDT
Received: from azure-sdnproxy-1.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5508F880D8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=uGJhjE0VdQZaCtd5P8DjiImSj+n7K+Kp/VzkVHM4y8g=; b=N
        jJJo8O/wqMmlgm1EBVxj3S+q34kGyjSNBqbagtYoPsOQCnakD89Jbj6EM0PELZXP
        RJOQ1cmHAf6CW3B2S1LCl/f+20WxRQh23f6jQ84S0yGDYQTfDnSyUjdzT2iqM0A3
        U4GR7XfLW58RzkBa15orkLJZGGk8c8v7PDFa7sj9IY=
Received: from localhost (unknown [10.129.21.144])
        by front01 (Coremail) with SMTP id 5oFpogCnr7eHqoRix3JcBw--.41772S2;
        Wed, 18 May 2022 16:12:55 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org,
        felipe.balbi@linux.intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuyq@stu.pku.edu.cn, Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] usb: cdns3:  Fix potential dereference of NULL pointer
Date:   Wed, 18 May 2022 01:12:50 -0700
Message-Id: <1652861570-102489-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 5oFpogCnr7eHqoRix3JcBw--.41772S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWkAFyxCr4rJw13XF18Xwb_yoWktrg_Cw
        4UurZrKFW5X34UZw4DG34fG348KFsrX3WkJFsrta43CayUKr4kArW8Zr95CF1xZa18Kr1k
        Aw1rKa1fCFsxJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK
        6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
        CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEJBlPy7vIULQAJsA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of cdns3_gadget_ep_alloc_request()
needs to be checked to avoid use of NULL pointer
in case of an allocation failure.

Fixes: 7733f6c32e36f ("usb: cdns3: Add Cadence USB3 DRD Driver")

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/usb/cdns3/cdns3-gadget.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 5d8c982..7be328e 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2568,6 +2568,10 @@ static int cdns3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 		struct cdns3_request *priv_req;
 
 		zlp_request = cdns3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
+		if (!zlp_request) {
+			ret = -ENOMEM;
+			goto err;
+		}
 		zlp_request->buf = priv_dev->zlp_buf;
 		zlp_request->length = 0;
 
@@ -2578,7 +2582,7 @@ static int cdns3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 			priv_ep->name);
 		ret = __cdns3_gadget_ep_queue(ep, zlp_request, gfp_flags);
 	}
-
+err:
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
 	return ret;
 }
-- 
2.7.4

