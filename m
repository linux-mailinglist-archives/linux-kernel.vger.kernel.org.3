Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFCB4E7FC9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiCZHeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiCZHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:34:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB51AE01D;
        Sat, 26 Mar 2022 00:33:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w8so10404291pll.10;
        Sat, 26 Mar 2022 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=rZDP/4Mhjr1+TUZZk1Co3Aep1xOdAOYrejqBkqWY1xw=;
        b=fgPctAjAt/0RF+09t2VHyDDhikM33mm6GdoqZvSkcngivFbWaUMAALXNyCiZV0Nrk8
         PpU6sUl/Vv+7CH/SisgnE2ISWvHUNMuyuR8FAfXo9+V5jtRl+Eoo5HQA3z0Yy1ZwGzVW
         oVdq/cXmAK1RxUMyx60cLOcx2+HIgGYez4j+6kbXefXHDkez35hsF3VCrSHs2zJBFxpA
         musGPPtWizeSCH8ifqy2BPZCXYJq6zq6qdU37QLy4QmYi+tu3i2lo+sduvig70NIEaYI
         UHPrHUPL3VeVmhzCfBvFnEO38Nom9N2grkgGKNvGoxd01+VvoqnowI0yVN8NBpa78phu
         n4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rZDP/4Mhjr1+TUZZk1Co3Aep1xOdAOYrejqBkqWY1xw=;
        b=w+uLCZVxPP2/VSF6jFi6DVyjy1IU8cI5I7RwvYmCpxrS4FTGl2/SC8vQRPOr+3wqh9
         mHb8xq3ns8wJeQeG941uwMU9+RAzZJrZjKU+w18XwRjpUR5NdWCQZdWEzE2MFClxZ3NT
         Gb9gFiRA2Jw4nsYpsvZZw6BHVtlkdsXIgCZTAdocdhRvkt3OG8Cuu53HBIzDyoqzsQHQ
         OmKNTk2IAiAVm/TE0ayXrvqqUDpAApIiTfqllAB0ZjMZrz6MiBOD+MeLCdUFj6pkpDPQ
         tDLG4hBQ5j0ILctM7AsdRVFvuNPXXJeZmbPWQa06tHd1sqzZFNt2aHItHBMbKuL3MwLG
         fs3A==
X-Gm-Message-State: AOAM531hUtPY3d1vK9h+Qm98y6GZhStul1WYy0FuRv5AE653EFnFnhvd
        ZkfKd4NjxKa5EGRRyR/vzl8=
X-Google-Smtp-Source: ABdhPJwanJsoFAHQzvCaqlw4iCK3WmBega0/mc4LjcKG+hVGnkRFMN2BWh4fSIMusIBevJ6sMDo18Q==
X-Received: by 2002:a17:90b:4c0a:b0:1c6:90be:1e03 with SMTP id na10-20020a17090b4c0a00b001c690be1e03mr29580678pjb.7.1648279990376;
        Sat, 26 Mar 2022 00:33:10 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id l9-20020a655609000000b0037589f4337dsm7345377pgs.78.2022.03.26.00.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 00:33:09 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     mchehab@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, yangyingliang@huawei.com,
        v4l@cerqueira.org, akpm@osdl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v2] saa7134: fix incorrect check to determine if list is empty
Date:   Sat, 26 Mar 2022 15:33:01 +0800
Message-Id: <20220326073301.12949-1-xiam0nd.tong@gmail.com>
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
changes from v1:
 - check with list_empty() (Jakob Koschel)
 - move the 'if' ahead (Xiaomeng Tong)
v1:https://lore.kernel.org/all/20220320025718.10053-1-xiam0nd.tong@gmail.com/
sorry for the wrong PATCH v2:
https://lore.kernel.org/all/20220326072215.11608-1-xiam0nd.tong@gmail.com/
just skip it.
---
 drivers/media/pci/saa7134/saa7134-alsa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
index fb24d2ed3621..f0318617197c 100644
--- a/drivers/media/pci/saa7134/saa7134-alsa.c
+++ b/drivers/media/pci/saa7134/saa7134-alsa.c
@@ -1214,13 +1214,16 @@ static int alsa_device_exit(struct saa7134_dev *dev)
 
 static int saa7134_alsa_init(void)
 {
-	struct saa7134_dev *dev = NULL;
+	struct saa7134_dev *dev;
 
 	saa7134_dmasound_init = alsa_device_init;
 	saa7134_dmasound_exit = alsa_device_exit;
 
 	pr_info("saa7134 ALSA driver for DMA sound loaded\n");
 
+	if (list_empty(&saa7134_devlist))
+		pr_info("saa7134 ALSA: no saa7134 cards found\n");
+
 	list_for_each_entry(dev, &saa7134_devlist, devlist) {
 		if (dev->pci->device == PCI_DEVICE_ID_PHILIPS_SAA7130)
 			pr_info("%s/alsa: %s doesn't support digital audio\n",
@@ -1229,9 +1232,6 @@ static int saa7134_alsa_init(void)
 			alsa_device_init(dev);
 	}
 
-	if (dev == NULL)
-		pr_info("saa7134 ALSA: no saa7134 cards found\n");
-
 	return 0;
 
 }
-- 
2.17.1

