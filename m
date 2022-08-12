Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10360590E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiHLJuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHLJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:50:16 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79DAB9F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:50:14 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id j8so1114890ejx.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HGfWnaevDnjU3IQ3+RdJwKSR3tW/9GSGc+g+aLgic7o=;
        b=e+nYWqDOcx3R3vb+I1PaX2heh5HFdwHqVQ32tRDEZB5dQqDyazrhEq0do+92HwDrrd
         2XLqpUp0UZqR1eP3MU70H2g2mjNdJFH6bmBcoKjsm327ujDgAXlal9eZHdTTTb4Akwbc
         C/dPrbQPoiHlSh08Oz/OYY/k/LF8U6coV+7xdrixCFMtOqGNacocvs30BEKsvU1jg2XW
         jnMyC//tAhQdHKXAjrUFxHpQR7DWmDnhwseWixkRKqVFVbbXovWqtJOLkljZhz3IQ2nB
         +0Z1S+TcFdsQ9FYt4mnrJrA2YmGXONTw3gFBzNo9SgEIHtKgMukUz1SIa0aVNKcZ+FIc
         G5bA==
X-Gm-Message-State: ACgBeo1thQfnNW8Ja2sB4LFc9+ogj+UbJsaFFL5A06DbzLLvcw3rB36C
        buJkkKgWekvpo2v3gz0Arb4=
X-Google-Smtp-Source: AA6agR6lMAS0qN9ddYs4JHDbW9YbKlkyvXYWVM8+kmSqDly1XGEGeh+g56gcdRVmxbD8IU2MSXA5nw==
X-Received: by 2002:a17:906:5d13:b0:733:10e:b957 with SMTP id g19-20020a1709065d1300b00733010eb957mr2147676ejt.452.1660297813246;
        Fri, 12 Aug 2022 02:50:13 -0700 (PDT)
Received: from localhost (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090681c800b0072b8fbc9be1sm595537ejx.187.2022.08.12.02.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 02:50:12 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     scott.branden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
Subject: [RESEND PATCH] misc: bcm_vk: Remove usage of deprecated functions
Date:   Fri, 12 Aug 2022 02:47:17 -0700
Message-Id: <20220812094717.4097179-1-leitao@debian.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <612446a2-5a22-a349-35fc-47f34792b504@broadcom.com>
References: <612446a2-5a22-a349-35fc-47f34792b504@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_simple_get() and ida_simple_remove() functions are deprecated now.
These functions were replaced by ida_alloc() and ida_free()
respectively. This patch modernize bcm_vk to use the replacement
functions.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/bcm_vk_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index a16b99bdaa13..a3a82ebbc699 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1401,7 +1401,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		bcm_vk_tty_set_irq_enabled(vk, i);
 	}
 
-	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&bcm_vk_ida, GFP_KERNEL);
 	if (id < 0) {
 		err = id;
 		dev_err(dev, "unable to get id\n");
@@ -1500,7 +1500,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	misc_device->name = NULL;
 
 err_ida_remove:
-	ida_simple_remove(&bcm_vk_ida, id);
+	ida_free(&bcm_vk_ida, id);
 
 err_irq:
 	for (i = 0; i < vk->num_irqs; i++)
@@ -1573,7 +1573,7 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 	if (misc_device->name) {
 		misc_deregister(misc_device);
 		kfree(misc_device->name);
-		ida_simple_remove(&bcm_vk_ida, vk->devid);
+		ida_free(&bcm_vk_ida, vk->devid);
 	}
 	for (i = 0; i < vk->num_irqs; i++)
 		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), vk);
-- 
2.30.2

