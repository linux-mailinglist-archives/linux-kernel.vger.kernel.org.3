Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B3154F3BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381422AbiFQI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381418AbiFQI5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:57:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE3C4991B;
        Fri, 17 Jun 2022 01:57:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b8so5282636edj.11;
        Fri, 17 Jun 2022 01:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FbtKPklDAzYqBxI9midbYskvWSeku8VgHM4QUv4J+g=;
        b=RIKHRpM0wUlv8lDPilrhaOhSpY747adTj7jmL+FXxXSdcmIjxhX0Lkw1pm+H4jCe6Y
         ml/nDp0R8WSzIO6Y4+TMTO5T+EgaW0Fv65fbBlvLBQg7AKwVHrPEL5DnYmCVnK1Gz6CE
         ahp0XJk1jYPqPxK/YnubRBwE3gDKZOrd9NCQjYVA17cJqqI2isHsGzRSlO1OKg9m3EF7
         O9vntabP/uW+nTYRnpc4lSoNe2QEGelbtCCRpXBOeQqC5xRl195yUEgU4gVtA5roGtjC
         nlOXbhZgLE4nRdhbQgP0LfrWe+MSYg+hvmj5oZg7JYMMtRzpjHmzqAscNrQ/uewV496K
         GvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FbtKPklDAzYqBxI9midbYskvWSeku8VgHM4QUv4J+g=;
        b=omg4xlDJHqNwgVkpAiHStXVvj8WpjWwlh1YnmpWUhKkTKy1becC6Zs0MPOx4dpK6Vt
         Ot/jpM9tvCZ03KKNZrnWfH1bT4XMzg4Vw/MA5unDIeGWdo1qeWJPYd67o1RCmyY7mjl4
         YtpmJz6SnnOUXzpZ4q+41xj1PRXEoQQ18vQjS/v5Ffu7Cx6IUZJV3zurzQLL/0ZYA3Cs
         yBYTEE1GqzYDvUSKnDnTY4t3vPeRTMVbkdvnfrOQLuvlIiMcUGyr/34KlePCbAhD+A+5
         eJiT35QoYNXTAB8tnQ0x7xGfWzmdWITgyYqo21vXa5P325ewT0YtG1AXr37FuSpcdDF6
         hNug==
X-Gm-Message-State: AJIora/9MMHOxeqcNWh4Wypgmf8CVGnQiSib2fDojG9l2i0waUfLeYu4
        A6gaVC3i6z1EbNXNwmhZTvnx/LzVPh0=
X-Google-Smtp-Source: AGRyM1uLOxptLIvHstxzriWtY/q4UBxlt3fidCgVPZqCtQXF7jzPX8mLudscCl/W3SvwTk6vu2FBBQ==
X-Received: by 2002:a50:d097:0:b0:42d:d158:4e61 with SMTP id v23-20020a50d097000000b0042dd1584e61mr11144467edd.42.1655456239177;
        Fri, 17 Jun 2022 01:57:19 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id r13-20020a05640251cd00b0042ab4e20543sm3388788edd.48.2022.06.17.01.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:57:08 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        kernel-team@android.com
Cc:     tjmercier@google.com, daniel.vetter@ffwll.ch, gregkh@google.com,
        sumit.semwal@linaro.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] dma-buf: deprecate DMABUF_SYSFS_STATS
Date:   Fri, 17 Jun 2022 10:57:02 +0200
Message-Id: <20220617085702.4298-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a warning that this UAPI wasn't such a good idea and shouldn't be
used by anybody.

That should give us a better chance to remove it at some point and
prevents others from running into the same issues.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index 541efe01abc7..e4dc53a36428 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -75,7 +75,7 @@ menuconfig DMABUF_HEAPS
 	  between drivers.
 
 menuconfig DMABUF_SYSFS_STATS
-	bool "DMA-BUF sysfs statistics"
+	bool "DMA-BUF sysfs statistics (DEPRECATED)"
 	depends on DMA_SHARED_BUFFER
 	help
 	   Choose this option to enable DMA-BUF sysfs statistics
@@ -85,6 +85,10 @@ menuconfig DMABUF_SYSFS_STATS
 	   statistics for the DMA-BUF with the unique inode number
 	   <inode_number>.
 
+	   This option is deprecated and should sooner or later be removed.
+	   Android is the only user of this and it turned out that this resulted
+	   in quite some performance problems.
+
 source "drivers/dma-buf/heaps/Kconfig"
 
 endmenu
-- 
2.25.1

