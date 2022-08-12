Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D77590E46
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiHLJlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiHLJlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:41:01 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63C26F571
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:41:00 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id y13so1056637ejp.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SDU6eJ9jqxKJGVdNe7phaO+u1XVdpyUB36/gamPBeE4=;
        b=naV5wG041j30HnfdVQdJwtvC4GoJ+URYkmGna0aYDzBYcXXm7PV3Tt82/8pZdm5oWt
         hZA4aXChdo5qawzs7QHqqho7GKj9YUNq4k8I6SK6+Yt4TR6jB1Bv04YR6KBm78emMwFC
         1HqpbFBwjFCI7n4OtO40k0wO6jRlRbAuJQM76ckNNtMm3DLok2oOxHU1k+HoWG+rYK5e
         cnTHMKOY+4ObRmrrLUmN/hlwPec0Wi/RIsVLuz/m3lvSE87XL2haX2P6AUy5gxEk+SrH
         9jrI1oWZVfsQhpOQaAa85K7LLuBQaQWfU6e06clz3ZbfyCyEqUaTb8sPQudW45Ge25uC
         06Sw==
X-Gm-Message-State: ACgBeo1RhyAZrL4AWX6jNY2/kMjnQfd+OTy86diSBxCWeJnWtTCGWWRN
        /JX5v36MpB5YUmYqDEM3eXs=
X-Google-Smtp-Source: AA6agR6yp8EhyZ/kEQafv6W+jji4vrY+cmuoWsi9P/PHSJnKTZJe30zwitzSij6ZwXSuGIvQmVRiFA==
X-Received: by 2002:a17:907:762f:b0:730:95d9:9955 with SMTP id jy15-20020a170907762f00b0073095d99955mr2076982ejc.505.1660297259332;
        Fri, 12 Aug 2022 02:40:59 -0700 (PDT)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b00730c3923a2csm627784ejg.11.2022.08.12.02.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 02:40:58 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     scott.branden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
Subject: [RESEND PATCH] misc: bcm-vk: Specify the minimum number of IRQ vecs
Date:   Fri, 12 Aug 2022 02:40:11 -0700
Message-Id: <20220812094011.4064729-1-leitao@debian.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <e416c587-d3cc-947a-7336-2c1954e2e432@broadcom.com>
References: <e416c587-d3cc-947a-7336-2c1954e2e432@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During bcm_vk_probe(), pci_alloc_irq_vectors() is called passing the
number of IRQ vectors as 1, but, later, check how many IRQ vectors it
got, and fails if it is smaller than VK_MSIX_IRQ_MIN_REQ.

The most appropriated way to do it is setting the 'min_vecs' param as
VK_MSIX_IRQ_MIN_REQ, instead of one. pci_alloc_irq_vectors() should
know the requirements when called.

The test was done by just loading this module on a machine with a
Valkyrie offload engine hardware.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/bcm_vk_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index a3a82ebbc699..d4a96137728d 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1339,7 +1339,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_drvdata(pdev, vk);
 
 	irq = pci_alloc_irq_vectors(pdev,
-				    1,
+				    VK_MSIX_IRQ_MIN_REQ,
 				    VK_MSIX_IRQ_MAX,
 				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
 
-- 
2.30.2

