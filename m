Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D84E7FCF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiCZHqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiCZHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:46:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214D433E;
        Sat, 26 Mar 2022 00:45:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b8so9494709pjb.4;
        Sat, 26 Mar 2022 00:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ttQHNeY3MOxG84rURJzpKfkNMVpHm0nxtM9wAM2eeko=;
        b=jeRDXzJjY+26qU3Ek0UvfVTSD3cvcAoc2ogtzq84soO/OyK9gkg4NcQDnYcltpAe0m
         DmBbHBDoZbxj7OyS/ioqNYc1tE9fwP3V+ijTiM0zlxR9AiZHy2and8BgVaDjTboBQYjM
         ytl02ZwDYcvTybmct0HO2WcXowV0reRbcGoocMB+pUBjhWBaEITLWa7ogIlM+oa0KOoa
         acxKm7UgARyHA7pJJ7qqsVHzuKmHWddHCGRcNjkBkO+XYlknyoUDeLpHGVIQAVgSY4bh
         AbHoOfq7rgfYI6mz6USNsfxbNk610L0Jf8G8U7dhf736ASAsT7iKXq1YAQT0n0Og8Ljs
         coQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ttQHNeY3MOxG84rURJzpKfkNMVpHm0nxtM9wAM2eeko=;
        b=bhI48nv988aOz4pc1MUONGeV8/K/Yq9stloNT5/1vJvB68t0U3Crutg5iQ0wpqwbdp
         YUMtloVSZLGJB8MN6IKeGs4/Zd30rXJacEx3B6Qie6SandXeD6164Bn8PuMwqQYtNng2
         C2n1BHIpUb6vakEXORrMckClOf5vyrdQh92Elg+sPxZBKOXfuFLlz6T35YLCMz+4Gbcv
         5PgwFP/eOYdABmG2lAHRVIb6A8Yl/a72EIcIu3fb/heCmKvY/jZuUxNv7ns7VU7OYTwy
         AzTdcOAozTewf3kXh8YwZ9TAOJproUQke0Zp6D5ezaK0NYFil9/VHJ+vxsuKtZb3snve
         m4Ag==
X-Gm-Message-State: AOAM530UdpRb0IeH47HNjPnggsBIQ1iSfC71tapx1qvWLVn8nyjQsinQ
        wjuR0zWa7BahkX75RD0Go38brXly2vY=
X-Google-Smtp-Source: ABdhPJwCEHE9AzHK74QFs9C6mgx8FlBWNHbnxU8JJm5/Cv+ffA2e6YQ0Q+qZ985bk0ybE5qIt1OsCA==
X-Received: by 2002:a17:90b:1a8a:b0:1c7:c60b:f12 with SMTP id ng10-20020a17090b1a8a00b001c7c60b0f12mr13216160pjb.139.1648280703721;
        Sat, 26 Mar 2022 00:45:03 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm4009723pjy.35.2022.03.26.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 00:45:03 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     mchehab@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, yangyingliang@huawei.com,
        v4l@cerqueira.org, akpm@osdl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v3] saa7134: fix incorrect check to determine if list is empty
Date:   Sat, 26 Mar 2022 15:44:54 +0800
Message-Id: <20220326074454.13813-1-xiam0nd.tong@gmail.com>
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
to fix this bug, and move the 'if' ahead to make the logic clearer.

Fixes: 4aabf6331f89c ("[PATCH] v4l: (951) Make saa7134-oss as a stand-alone module")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
changes since v2:
 - add return (Xiaomeng Tong)
changes since v1:
 - check with list_empty() (Jakob Koschel)
 - and move the 'if' ahead (Xiaomeng Tong)
v1:https://lore.kernel.org/all/20220320025718.10053-1-xiam0nd.tong@gmail.com/
v2:https://lore.kernel.org/all/20220326073301.12949-1-xiam0nd.tong@gmail.com/
---
 drivers/media/pci/saa7134/saa7134-alsa.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
index fb24d2ed3621..1eb2e8da8950 100644
--- a/drivers/media/pci/saa7134/saa7134-alsa.c
+++ b/drivers/media/pci/saa7134/saa7134-alsa.c
@@ -1214,13 +1214,18 @@ static int alsa_device_exit(struct saa7134_dev *dev)
 
 static int saa7134_alsa_init(void)
 {
-	struct saa7134_dev *dev = NULL;
+	struct saa7134_dev *dev;
 
 	saa7134_dmasound_init = alsa_device_init;
 	saa7134_dmasound_exit = alsa_device_exit;
 
 	pr_info("saa7134 ALSA driver for DMA sound loaded\n");
 
+	if (list_empty(&saa7134_devlist)) {
+		pr_info("saa7134 ALSA: no saa7134 cards found\n");
+		return 0;
+	}
+
 	list_for_each_entry(dev, &saa7134_devlist, devlist) {
 		if (dev->pci->device == PCI_DEVICE_ID_PHILIPS_SAA7130)
 			pr_info("%s/alsa: %s doesn't support digital audio\n",
@@ -1229,9 +1234,6 @@ static int saa7134_alsa_init(void)
 			alsa_device_init(dev);
 	}
 
-	if (dev == NULL)
-		pr_info("saa7134 ALSA: no saa7134 cards found\n");
-
 	return 0;
 
 }
-- 
2.17.1

