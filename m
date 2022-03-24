Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA94E6076
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348978AbiCXIjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiCXIjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:39:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D849BBAE;
        Thu, 24 Mar 2022 01:37:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k6so3989445plg.12;
        Thu, 24 Mar 2022 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXhYQHS4VNqf/GV/cJxxnwtzAOHEaduwd81EzKtbsnI=;
        b=plSM3VwYch6XnDt4M+ew5Jpe3OJZ6zJCswrbKrS9FmEM0Zb8/LmCvz9x2sEqfvhWWO
         JPTMiRVUDSeL164vpn19/N2W56HYNrEbV5rWuaL25HxDHQS2bkmZzMNbp1CD+UujJ8an
         4VtioyKhu5fi8LbZKbuWXuPviEJcCxQnyghYmIHIMfjaa4Kuav6hQgo4hlJRCEPVQHGh
         RZhQ1YA/BEzGiLGsiD2k38v0CBHl7gGTccZi321t9mF4ZEfsE6RBzWmI9E1/2paH7HML
         zWUWNX6glxtg3UHpm7lUz46qdgrkOEYzqn6f9uQjkFYLeYWl5ZLjICQ8UK/nHfQxvIN1
         s8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXhYQHS4VNqf/GV/cJxxnwtzAOHEaduwd81EzKtbsnI=;
        b=ix3nJnNiidQINTLmHO8zs35F5RF+DFhZEkb6ubhKDC2y0k711IsEhXu7XUcg6UJKFr
         Pm1v19UAWUQNr7SXnbTHGv0uwFNab9aOUvv382JlNha2AyIgrDsI86PqnXd+obTJhSGp
         RBdKRzNelGMuKxK/C1RqsPpV5ju2Z653uL8wCmyojjsbPbxjDrVFdgGw8mEWcERpm/kC
         m46i7MtA1bNdt9qMIDpdD4jd4zWuGXhrDOJZuTNlo+DfsspyY4JKOwoQTCqw/9D5Ua8/
         zrFlw9JzTKbfUIF8eXHPZ9tCT1333PexAEw88OhourrYOVaVhRSkotuQIBFGF7ZXD614
         I4pA==
X-Gm-Message-State: AOAM532LjT37BHArFVts3joL1rzgcmibHQ4D+GWrhrnpPGTZKunQI5WE
        8/z2Jlr29RW2nHi/QDpHERI=
X-Google-Smtp-Source: ABdhPJyzShKJ4vQLUuiEeWac72aMhLVYjSSrsrD7Vm+92vH+ZI7xaWjZIOtvrtINE3EiKAW5oDFf3g==
X-Received: by 2002:a17:902:f646:b0:151:d5b1:cbb4 with SMTP id m6-20020a170902f64600b00151d5b1cbb4mr4605810plg.150.1648111057790;
        Thu, 24 Mar 2022 01:37:37 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id z9-20020a63b909000000b003823389e47csm1881046pge.9.2022.03.24.01.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 01:37:37 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     jacob-chen@iotwrt.com, ezequiel@vanguardiasur.com.ar,
        mchehab@kernel.org, heiko@sntech.de
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] media: rga: fix possible memory leak in rga_probe
Date:   Thu, 24 Mar 2022 16:37:24 +0800
Message-Id: <20220324083724.42654-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

rga->m2m_dev needs to be freed when rga_probe fails.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/media/platform/rockchip/rga/rga.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 4de5e8d2b261..c2ce4fdcdb7f 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -865,7 +865,7 @@ static int rga_probe(struct platform_device *pdev)
 
 	ret = pm_runtime_resume_and_get(rga->dev);
 	if (ret < 0)
-		goto rel_vdev;
+		goto rel_m2m;
 
 	rga->version.major = (rga_read(rga, RGA_VERSION_INFO) >> 24) & 0xFF;
 	rga->version.minor = (rga_read(rga, RGA_VERSION_INFO) >> 20) & 0x0F;
@@ -881,7 +881,7 @@ static int rga_probe(struct platform_device *pdev)
 					   DMA_ATTR_WRITE_COMBINE);
 	if (!rga->cmdbuf_virt) {
 		ret = -ENOMEM;
-		goto rel_vdev;
+		goto rel_m2m;
 	}
 
 	rga->src_mmu_pages =
@@ -918,6 +918,8 @@ static int rga_probe(struct platform_device *pdev)
 free_dma:
 	dma_free_attrs(rga->dev, RGA_CMDBUF_SIZE, rga->cmdbuf_virt,
 		       rga->cmdbuf_phy, DMA_ATTR_WRITE_COMBINE);
+rel_m2m:
+	v4l2_m2m_release(rga->m2m_dev);
 rel_vdev:
 	video_device_release(vfd);
 unreg_v4l2_dev:
-- 
2.25.1

