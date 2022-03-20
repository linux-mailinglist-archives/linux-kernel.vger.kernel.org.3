Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1A4E1980
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 03:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbiCTC6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 22:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiCTC6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 22:58:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71A51CD7CC;
        Sat, 19 Mar 2022 19:57:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so10023399plg.5;
        Sat, 19 Mar 2022 19:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=f2V16VQGlEWJs89nhNWj6KgqYUtM5qh8Hz8sytX12p4=;
        b=pdWxJ7QA1+glIkDG1YQnhFIGl+qLfJ8DOxeaivhlqCO620c7QuOQU8dRFRvvAwDawb
         SiuBPPwIP38sm6p6t5Y3o67ToHT+qTrf687WU84cJSj3Y620hHR8DrbaPLFgKOdw95IR
         PuCBdT4SUsLYfgK7Z5ruzCWikb7gPdUfAUkk+T3z4aamXiZ3ZlCZ6ddRm9fMlLggDvjO
         hzUp+7wxeGugd5cvRLg64hJuD12Dgzl+j9XW7mSzLekD+fYmyO4KZcEZjms3mGx8qZNl
         Wu7u0DnDpRqUcngg5J/xsw5aeW1eNro4Ubj6+kTi89GVUn0rYnSy0LDy0ps+xP1qNKFc
         YLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f2V16VQGlEWJs89nhNWj6KgqYUtM5qh8Hz8sytX12p4=;
        b=AnJADTQgLd9Rc4I7ME8iodJbouAV0Rp1BpGSzQn53paF4koSCh/dcAXsvyDR6CuF5q
         jHg7OyD2uMY0fe7ybHkdruDzi8ujKRK3WvhTm2AKaKIdzZrjv8J4a25dlEhQQlnIO5lF
         h5BU9OEyFAv6+t6pAZPnq5KIUkSlQxV3YQPFvKmaHomhcG/kdgQez9uzomI6j8WlqPWi
         iPjmRyHoHF2AemBCTabTz9y+F1gq+ApuexmZsb2RdtbDQjFLewzIYCB7xu+7WTsEF6VE
         PPQbE5LEdpoWG8gOQLyYjkek1eOy2x3cYV2yAeTJJ5Fr8/88GuED/O7QUYB0Qrf1ZcgI
         lkXQ==
X-Gm-Message-State: AOAM532j13RBg1nlysgdbejJxH+z+zESZtkLUrK3xj5akuHvpTmo4ktC
        8bF7NsPGNgetypgMkirXCqCeOwd20g4hww==
X-Google-Smtp-Source: ABdhPJytm3dCJedsBHgku/N7tF2qD0s90eclfziKIjxIcwzdaYaqNXHFzd6eJtX4zrffRV2HSaG24Q==
X-Received: by 2002:a17:902:7608:b0:153:32d3:f721 with SMTP id k8-20020a170902760800b0015332d3f721mr6746661pll.168.1647745048256;
        Sat, 19 Mar 2022 19:57:28 -0700 (PDT)
Received: from localhost.localdomain ([183.157.215.81])
        by smtp.googlemail.com with ESMTPSA id q2-20020a056a00084200b004f761a7287dsm14947368pfk.131.2022.03.19.19.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 19:57:27 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     mchehab@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, yangyingliang@huawei.com, akpm@osdl.org,
        v4l@cerqueira.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, jakobkoschel@gmail.com,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] saa7134: fix incorrect check to determine if no element is found in list
Date:   Sun, 20 Mar 2022 10:57:18 +0800
Message-Id: <20220320025718.10053-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bug is here: "if (dev == NULL)".

The list iterator value will *always* be set and non-NULL by
list_for_each_entry(), so it is incorrect to assume that the iterator
value will be NULL if the list is empty or no element is found in list.

Use a new value 'iter' as the list iterator, while use the old value
'req' as a dedicated pointer to point to the found element, which
1. can fix this bug, due to now 'req' is NULL only if it's not found.
2. do not need to change all the uses of 'req' after the loop.
3. can also limit the scope of the list iterator 'iter' *only inside*
   the traversal loop by simply declaring 'iter' inside the loop in the
   future, as usage of the iterator outside of the list_for_each_entry
   is considered harmful. https://lkml.org/lkml/2022/2/17/1032

Fixes: 4aabf6331f89c ("[PATCH] v4l: (951) Make saa7134-oss as a stand-alone module")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/media/pci/saa7134/saa7134-alsa.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
index fb24d2ed3621..4955f7e7c5bf 100644
--- a/drivers/media/pci/saa7134/saa7134-alsa.c
+++ b/drivers/media/pci/saa7134/saa7134-alsa.c
@@ -1215,18 +1215,21 @@ static int alsa_device_exit(struct saa7134_dev *dev)
 static int saa7134_alsa_init(void)
 {
 	struct saa7134_dev *dev = NULL;
+	struct saa7134_dev *iter;
 
 	saa7134_dmasound_init = alsa_device_init;
 	saa7134_dmasound_exit = alsa_device_exit;
 
 	pr_info("saa7134 ALSA driver for DMA sound loaded\n");
 
-	list_for_each_entry(dev, &saa7134_devlist, devlist) {
-		if (dev->pci->device == PCI_DEVICE_ID_PHILIPS_SAA7130)
+	list_for_each_entry(iter, &saa7134_devlist, devlist) {
+		dev = iter;
+
+		if (iter->pci->device == PCI_DEVICE_ID_PHILIPS_SAA7130)
 			pr_info("%s/alsa: %s doesn't support digital audio\n",
-				dev->name, saa7134_boards[dev->board].name);
+				iter->name, saa7134_boards[iter->board].name);
 		else
-			alsa_device_init(dev);
+			alsa_device_init(iter);
 	}
 
 	if (dev == NULL)
-- 
2.17.1

