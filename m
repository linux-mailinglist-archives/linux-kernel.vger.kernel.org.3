Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D94505C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbiDRQrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346374AbiDRQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E76B32993
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hfOUYN9UIIiOEE4PlLjMhtSzjMtNPDZSzWUFehT4Zg4=;
        b=Gv4ZuCbtDzEFiCawXPjcKeqqISdmtU2rGvSxW9zS9uiBhT5woIp15WryeMwHHcfM6M5Og9
        ToNOMg0SXBuKaKQcKeg2Y5bNd2TByEzXWqvror2JY/V14MKmz56DdofKsL9xFHwTyULcSe
        GvUEFESQKd0JTVqGk3JRLB1+o3auDho=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-gJA-uPoRPK2ArMCbVfq3Ow-1; Mon, 18 Apr 2022 12:44:16 -0400
X-MC-Unique: gJA-uPoRPK2ArMCbVfq3Ow-1
Received: by mail-qk1-f197.google.com with SMTP id y13-20020a05620a44cd00b0069c35f1ea3eso10781081qkp.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfOUYN9UIIiOEE4PlLjMhtSzjMtNPDZSzWUFehT4Zg4=;
        b=b/9JGZmMls70ag6wFfMZL0JR+ZN9/l04jQdRRfEvSfssq3CeSe+f3SjuE4pTNWn2A8
         rSeN+fZV7Oyp33tglApy+YF6vMcWbXW3AFojQj+vARIf3Lx2VJzgyAnE1xEdX26Jr/64
         8XjX/V2utrdLKrFXxx7n3PnwWJRK25y72W+vv0yrYBGf9hX7SgLyEMYjAq3TLuwM6mln
         cLxtPZ68hO41+e245FtABvDsDrtNOAPEDhTSJFeq5fDQlizW6dAqH8Q2pT4jZ7Ps/Fe3
         lsA2P0sK4KB1eCIvMJlfe2RCizVUoBNM7ciljWjjbLSaTSJqzflDXD+4PDiIcnRmhh8d
         Wceg==
X-Gm-Message-State: AOAM533iBYnhlxmJtSdBJEKIvyay5JDHY8byUdi5pySUac53nM83n0bI
        Bj6R6/TMI2+lXlXX6Fguubc8Kf0CLNuKWmoOnwdWr1+1kbYc4s5GahTcrQH0vxaZJ8im01WlXu6
        SEdijEAn95x62btMLJjF3IpHe
X-Received: by 2002:a05:620a:4154:b0:69c:6976:1ee4 with SMTP id k20-20020a05620a415400b0069c69761ee4mr7210400qko.463.1650300256493;
        Mon, 18 Apr 2022 09:44:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYPpaPozKKnyQ/NIX2bofZripMjbu2H4MFzW0nKSXBeZharHnP4QWvyOGM0K+33nrpfMsqGQ==
X-Received: by 2002:a05:620a:4154:b0:69c:6976:1ee4 with SMTP id k20-20020a05620a415400b0069c69761ee4mr7210387qko.463.1650300256303;
        Mon, 18 Apr 2022 09:44:16 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m139-20020a37a391000000b0069e88edfdacsm2895896qke.105.2022.04.18.09.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:44:15 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        gregkh@linuxfoundation.org, stefan.wahren@i2se.com,
        gascoar@gmail.com, ojaswin98@gmail.com
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] staging: vchiq_arm: change vchiq_platform_init from global to static
Date:   Mon, 18 Apr 2022 12:43:56 -0400
Message-Id: <20220418164356.3532969-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
vchiq_arm.c:466:5: warning: symbol 'vchiq_platform_init'
  was not declared. Should it be static?

vchiq_platform_init is only used in vchiq_arm.c.  Single
file variables should not be global so change
vchiq_platform_init's storage-class specifier to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 0596ac61e286..7de98655e8ec 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -463,7 +463,7 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
 	cleanup_pagelistinfo(pagelistinfo);
 }
 
-int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
+static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 {
 	struct device *dev = &pdev->dev;
 	struct vchiq_drvdata *drvdata = platform_get_drvdata(pdev);
-- 
2.27.0

