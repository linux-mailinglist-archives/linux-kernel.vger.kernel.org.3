Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34724521231
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiEJKbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbiEJKbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:31:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A48F1F9788
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:27:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g184so11785073pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=e3aaHC6M7lIaSfFh37M3Xo570/fu3gjrjBjkmDxi3WQ=;
        b=qs+2GutOD1z54W3JMhgCDk9IXz3XdrTrzpmnsqFlzp+yd5A/nIQAg4H4ajttvUXTAX
         xbeTSXa0qiufhGlbK0h+/6wtDAvYD5YNbRcPbSJojM/ooQ0oD+JKfSez7EblXvALl3oS
         VRIZ3o/ZkKzdZC/AYHJG6h1TiNm4M0wrYRa1rGVJL/w1u9vQZZLFvr5y16AKljQldPyX
         fYAr4Fh4R2LvXm14qbHg4wVeK2JCecorWIte8HoX+j9Ua82aMeWkUVQO5QdXhns44SQv
         P9iwOsnGXK1SX9nZEYTwazff4oBDc0tCUdrEHGl9Xz3NhLSmz7ul/cYemT4J2abpRAMf
         L3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e3aaHC6M7lIaSfFh37M3Xo570/fu3gjrjBjkmDxi3WQ=;
        b=MblZj8nhco4Z5kdIxi3VCIYj8RKjCdUwm1UslrY5l1Q5kNpLGILJf4zemk3rNSj9/y
         gkvDZWNlLOTwaifYV0v9GNcq8aFOGTVyzvNzATlrOd9DgWcYS8Q2H0XGz/Ic0vsHPIf2
         3lq3TiZ8w+Ihv7T0yas75keqf9liGhQQ+LtRPIjey2IL2/dFH521AvIm8nHUyldAhBgd
         daHmEnqd9SnlZYcoYIsJxELyvAy/WpKV5GI5bDKi2dIEPlLD8rB2qjgbVWk7AHIoVAGx
         2kBz2VE82LM+W1PpBHy0k9YGrSbuVCqdEv+6DQiqE2cnYjrMhXGy0wW3+qx5lJtJ/Ui+
         LC4w==
X-Gm-Message-State: AOAM530l6y5QZRjsxwm2mfHw1ylxHI66lIMpcCPKJ0r26IkRfr8+/abI
        Y0du0TBKDJ14+ZGjZUHC/P60Ng==
X-Google-Smtp-Source: ABdhPJyDLM8NswYfMnb7ATK+850jBtliq7JRY8Pb44/lOUvDDGvb26qNFRxQH8JTr8oPs6C+5u5iyQ==
X-Received: by 2002:a05:6a00:1352:b0:50d:ecff:f06c with SMTP id k18-20020a056a00135200b0050decfff06cmr20006427pfu.6.1652178454797;
        Tue, 10 May 2022 03:27:34 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id q65-20020a17090a4fc700b001daac75511esm1445393pjh.51.2022.05.10.03.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:27:33 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     virtualization@lists.linux-foundation.org
Cc:     mie@igel.co.jp, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] virtio: fix virtio transitional ids
Date:   Tue, 10 May 2022 19:27:23 +0900
Message-Id: <20220510102723.87666-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the transitional PCI device ID.

Fixes: d61914ea6ada ("virtio: update virtio id table, add transitional ids")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 include/uapi/linux/virtio_ids.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 80d76b75bccd..7aa2eb766205 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -73,12 +73,12 @@
  * Virtio Transitional IDs
  */
 
-#define VIRTIO_TRANS_ID_NET		1000 /* transitional virtio net */
-#define VIRTIO_TRANS_ID_BLOCK		1001 /* transitional virtio block */
-#define VIRTIO_TRANS_ID_BALLOON		1002 /* transitional virtio balloon */
-#define VIRTIO_TRANS_ID_CONSOLE		1003 /* transitional virtio console */
-#define VIRTIO_TRANS_ID_SCSI		1004 /* transitional virtio SCSI */
-#define VIRTIO_TRANS_ID_RNG		1005 /* transitional virtio rng */
-#define VIRTIO_TRANS_ID_9P		1009 /* transitional virtio 9p console */
+#define VIRTIO_TRANS_ID_NET		0x1000 /* transitional virtio net */
+#define VIRTIO_TRANS_ID_BLOCK		0x1001 /* transitional virtio block */
+#define VIRTIO_TRANS_ID_BALLOON		0x1002 /* transitional virtio balloon */
+#define VIRTIO_TRANS_ID_CONSOLE		0x1003 /* transitional virtio console */
+#define VIRTIO_TRANS_ID_SCSI		0x1004 /* transitional virtio SCSI */
+#define VIRTIO_TRANS_ID_RNG		0x1005 /* transitional virtio rng */
+#define VIRTIO_TRANS_ID_9P		0x1009 /* transitional virtio 9p console */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.17.1

