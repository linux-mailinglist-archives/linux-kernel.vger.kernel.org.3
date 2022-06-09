Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A7854414B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiFICM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiFICMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:12:24 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7D4F7233EA3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 19:12:18 -0700 (PDT)
Received: from jleng.ambarella.net (unknown [116.246.37.178])
        by mail-app2 (Coremail) with SMTP id by_KCgAnzUHjVqFi40WJAQ--.61551S2;
        Thu, 09 Jun 2022 10:11:55 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     pawell@cadence.com, gregkh@linuxfoundation.org,
        peter.chen@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH] usb: cdnsp: Fixed setting last_trb incorrectly
Date:   Thu,  9 Jun 2022 10:11:34 +0800
Message-Id: <20220609021134.1606-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgAnzUHjVqFi40WJAQ--.61551S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryUtF4DXF4kuFWxJw1DZFb_yoW8Ar1xpF
        47JFWqkr1fArW3Awn7KFn8X3W5GrnakFy7KFZ7Z3sakr13Aas7uFn8Kr10qrZxCryrZr4q
        9FsIqas7Zanag3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWlnxkEFVCFx7IYxxCEVcI2
        5VAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
        W8JbIYCTnIWIevJa73UjIFyTuYvjxU4038UUUUU
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwQPBVNG3GzSjQACs1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

When ZLP occurs in bulk transmission, currently cdnsp will set last_trb
for the last two TRBs, it will trigger an error "ERROR Transfer event TRB
DMA ptr not part of current TD ...".

Fixes: e913aada0683 ("usb: cdnsp: Fixed issue with ZLP")
Signed-off-by: Jing Leng <jleng@ambarella.com>
---
 drivers/usb/cdns3/cdnsp-ring.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index e45c3d6e1536..794e413800ae 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -1941,13 +1941,16 @@ int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, struct cdnsp_request *preq)
 		}
 
 		if (enqd_len + trb_buff_len >= full_len) {
-			if (need_zero_pkt)
-				zero_len_trb = !zero_len_trb;
-
-			field &= ~TRB_CHAIN;
-			field |= TRB_IOC;
-			more_trbs_coming = false;
-			preq->td.last_trb = ring->enqueue;
+			if (need_zero_pkt && !zero_len_trb) {
+				zero_len_trb = true;
+			} else {
+				zero_len_trb = false;
+				field &= ~TRB_CHAIN;
+				field |= TRB_IOC;
+				more_trbs_coming = false;
+				need_zero_pkt = false;
+				preq->td.last_trb = ring->enqueue;
+			}
 		}
 
 		/* Only set interrupt on short packet for OUT endpoints. */
@@ -1962,7 +1965,7 @@ int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, struct cdnsp_request *preq)
 		length_field = TRB_LEN(trb_buff_len) | TRB_TD_SIZE(remainder) |
 			TRB_INTR_TARGET(0);
 
-		cdnsp_queue_trb(pdev, ring, more_trbs_coming | zero_len_trb,
+		cdnsp_queue_trb(pdev, ring, more_trbs_coming,
 				lower_32_bits(send_addr),
 				upper_32_bits(send_addr),
 				length_field,
-- 
2.17.1

