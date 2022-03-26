Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1504E7FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiCZHYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiCZHYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:24:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E853931A6;
        Sat, 26 Mar 2022 00:22:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u22so8345965pfg.6;
        Sat, 26 Mar 2022 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=FrsCzHUOMb3jS+AAxbsvf5dDmNa3e9DNdcETUxBJfds=;
        b=Lp3RFtqePdFuo2/WjIauHyHaoTOTEMVb9ii3Uole/f01OndxyJhBC1/GuFoF65UZF7
         ckae7wl/Z2to1tdXx8Fqc07p8tQFKKiQttXbKjprpgZgsu33X65FT2wd3Y04XpY12KeV
         cbV17gnh4+S0CBwd6JhN9h7GGywU2/t5mtfxWr1oSfsVCv+EZkiz3b7FyJf6MX71rmza
         2ow27c1AM5GfkenA+AWq/dc20CAg+wtzygfTgDvrEatTOr9gWWqTGuXqgZYcH3OXtYg7
         4nNCNhhVLmXli9lyg2/lMWd8ynr/rEhzuad8V193OGTeWxCNOB7oJeVtXHfsS9l5kk5l
         1QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FrsCzHUOMb3jS+AAxbsvf5dDmNa3e9DNdcETUxBJfds=;
        b=7+h7kXU6D2L+5xKaAam3I2hpXK2Q9Agj88qTY+psrtyhRpVnYGvBUsbUO8TfqXJr7o
         rIupz4Vopxd3rgsdzNWfcdpHAPgvqHuM7BPP+sBQV6csRqUMVBN+5YMJAxSbC6oebwGC
         23CR1XfW7BvgggctD24NRSCo/6EhU+o0+vRrPqKDiFeW8SMRTJPf8a3qqUdGVu5RyhxN
         0uymmuoY/T3J+qHBffCXHg2CcCXgD7P5pcU5nAUggRhMh6saPLYJUnU+MuHHpDK6MpMM
         b2h5nV+jLN0BwxORKg/cxvrSGK2Tc5ceCKJunKmnTuzfhQnlvrGv7SLYQBM8xLBd2O0L
         kKvw==
X-Gm-Message-State: AOAM532IUMK9sOWjQ1Sq6/bDfCuc60cM0ctgYkuW42kd2mKAtDenUWyD
        qPTiewHB9BFATgFEOidzc5o=
X-Google-Smtp-Source: ABdhPJzQqLS8i9quyP+b1igcsB9qKJwqLnzZUNSbckVKnC/PM3Xn18cDs2WJ11eglVu3F3DWZY6FNA==
X-Received: by 2002:a05:6a00:1702:b0:4fb:1450:22ad with SMTP id h2-20020a056a00170200b004fb145022admr6449174pfc.56.1648279344623;
        Sat, 26 Mar 2022 00:22:24 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm3938520pjy.35.2022.03.26.00.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 00:22:24 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     mchehab@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, yangyingliang@huawei.com,
        v4l@cerqueira.org, akpm@osdl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v2] saa7134: fix incorrect check to determine if list is empty
Date:   Sat, 26 Mar 2022 15:22:15 +0800
Message-Id: <20220326072215.11608-1-xiam0nd.tong@gmail.com>
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
value will be NULL if the list is empty. Instead, check with list_empty()
and move the 'if' ahead, to fix this bug.

Fixes: 4aabf6331f89c ("[PATCH] v4l: (951) Make saa7134-oss as a stand-alone module")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
changes since v1:
 - check with list_empty() (Jakob Koschel)
 - and move the 'if' ahead (Xiaomeng Tong)
v1:https://lore.kernel.org/all/20220320025718.10053-1-xiam0nd.tong@gmail.com/
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

