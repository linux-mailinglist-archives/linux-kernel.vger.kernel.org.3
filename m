Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F94C506D92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbiDSNj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352343AbiDSNjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1A573819E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650375392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TisNtD1J5PmBK8R9kgSJt0gLr8nDMGO0aIKPyed6r2U=;
        b=HJorpN8WjvOg6jOBVKXyVcepb0Jjp1Zr2rdAcQKrwhJtuepmhW/a4slRRtR4rMsklWK0Tn
        KrbYdvGwVmkDjIVF5OTneXW5gohn8aigA5XN18Jtmbsn/WugltfKIPQkDpE2Dsp5/Pmnhw
        dE00a4MxofSulY2nH1ym0fkvfcNDUbw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-AEr1JMqRPaWoZpC0xoOcHA-1; Tue, 19 Apr 2022 09:36:30 -0400
X-MC-Unique: AEr1JMqRPaWoZpC0xoOcHA-1
Received: by mail-qv1-f69.google.com with SMTP id t12-20020a0cea2c000000b004443d7585f0so14379514qvp.19
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TisNtD1J5PmBK8R9kgSJt0gLr8nDMGO0aIKPyed6r2U=;
        b=pieXVN1wQ7VRtm5SYedkVCJFPyibR2YtH+LYOS0mKBkC21Yt8lSt+hnjXRzz7n+WkF
         /b01YTaueudjKtxdt+ijJFEnAf8Ssan+b204AmLymo+jy9RrafP3ypZNlh9y0mvEf98F
         aWS4XKNhQbw/iCCYjUjQbTUZuVIhQvwQ8jw4+Kjodd7uxiyfOcScaGiX7CWliCz7WinE
         oZkCtRD/T7mVN0LBrU4U6dUYZ/RiQT7J8mN4rEnY0pbnPZKRHtbxp+EtPw83N2Ha1qTL
         PQshXuYXzmfg5Wq8GSU/F4LjIqFNDkSlwPQF5pdM6lL/pn+8bhWi+bJtyjXYtqOAudw3
         Ly7A==
X-Gm-Message-State: AOAM531VJUbJSbk4WWIaTdMAz8ngSX/y8w2oruRl46ymH4aWWYLblbrg
        EMNLVRMth4Cnpnuot9osN/1NBuQfmO99mia1aRpxIjjncyLoaVNo5MfOq9UWMINlUCjnZkGRvIy
        OPi1rMeLGHKcurOMQL7xsSth3
X-Received: by 2002:a05:620a:2888:b0:699:b9a0:b618 with SMTP id j8-20020a05620a288800b00699b9a0b618mr9595089qkp.358.1650375390155;
        Tue, 19 Apr 2022 06:36:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV2T4w1vEBvKKqeuAZm2QIyB+6IhmSfNN720JnV76tZFvQn/+PTuuEUmczxU5MaDozm5Jaaw==
X-Received: by 2002:a05:620a:2888:b0:699:b9a0:b618 with SMTP id j8-20020a05620a288800b00699b9a0b618mr9595073qkp.358.1650375389924;
        Tue, 19 Apr 2022 06:36:29 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s19-20020a05622a179300b002e1ceeb21d0sm4355qtk.97.2022.04.19.06.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 06:36:29 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        gregkh@linuxfoundation.org, stefan.wahren@i2se.com,
        gascoar@gmail.com, ojaswin98@gmail.com
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] staging: vchiq_arm: change vchiq_platform_init from global to static
Date:   Tue, 19 Apr 2022 09:36:16 -0400
Message-Id: <20220419133616.544255-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
vchiq_arm.c:466:5: warning: symbol 'vchiq_platform_init' was not declared. Should it be static?

vchiq_platform_init is only used in vchiq_arm.c.  Single file variables should
not be global so change vchiq_platform_init's storage-class specifier to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: refomat commit log

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

