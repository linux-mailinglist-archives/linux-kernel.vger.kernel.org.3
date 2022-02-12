Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884CA4B35A4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiBLOcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 09:32:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBLOcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 09:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61438B0B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 06:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644676362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dhkBUafRYMIN2ZNq66x6pdK7QQV3sobrHVPooiq4Ffs=;
        b=f1StX3fxvdiODqEMqmhwZD5aqJBhxIXXLKwJn2bWnMKDrXiawx8BTTy7nS6hwP2/+x7v9m
        lRgWyz03Eq2983qNYr1HaPwBVKNnkbLSkinVYdz2hiqPH22T+ZH0cId3CK4LFTKq7UuP1r
        jG0aIxQ4NCFRI81gyO8rqNCHGwUEMXA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-tddvth_XNLaplUKb9E293Q-1; Sat, 12 Feb 2022 09:32:41 -0500
X-MC-Unique: tddvth_XNLaplUKb9E293Q-1
Received: by mail-oo1-f72.google.com with SMTP id t16-20020a4ae9b0000000b0031877e91c80so3976488ood.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 06:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dhkBUafRYMIN2ZNq66x6pdK7QQV3sobrHVPooiq4Ffs=;
        b=1LnAmbWXXXZMJhj4yhudaH/+l3znstmIEHjph20QtOygxzGEfLjGLb+VZ+tex9SKk7
         vNbiLi2CQzyCyvoWIUrw/AOmQxq+2XrHEYOH+HhqNtV5Eahc7n8GnJDoMrNAuNr9SRy4
         Dy7/yLKKrTxfwxtRjvFkakXZZCovQBBBkfeCGOH+BNwFTXL9cMFJUxynb6EsvkyFzwbT
         RI+ydg/nqFBy/CdCDk8KQhiQRH3BIwjfgEiK0LsIvSGYd7gSdZ45ZRnFCA1wY0+zLp5K
         XyobK/Y2HEO2hERjv4ruxB/ocfagZeTuWBRER7VKVraNCGfqBs01rpz4FVZwCtZJUBo2
         +1Ag==
X-Gm-Message-State: AOAM533eaWJe5hlzTG7PHVDyxZll8z796YhrdJ/aqOgpginDdfeGjSs9
        o3eCjwWgnmnpwjzPvV7E8N6uxjn+yHSL6gmpE0T02oG0ZfJSGwp5ZoRcJDJx70RruPR8qigdScN
        Wct/I6cwcPEjb1rfEpGaFrbnA
X-Received: by 2002:a9d:224e:: with SMTP id o72mr2236874ota.133.1644676360375;
        Sat, 12 Feb 2022 06:32:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+V1Og7y2w/PlYSwRJ/CwPj+KrlgFnukKod4c2HkpOJdG/P10h8FHDEV0CV8tP1+qCzWrRCA==
X-Received: by 2002:a9d:224e:: with SMTP id o72mr2236863ota.133.1644676359825;
        Sat, 12 Feb 2022 06:32:39 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id t21sm10166108otq.81.2022.02.12.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 06:32:39 -0800 (PST)
From:   trix@redhat.com
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] driver core: cleanup double words comments
Date:   Sat, 12 Feb 2022 06:32:33 -0800
Message-Id: <20220212143233.2648872-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'are' and 'the'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/base/dd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9eaaff2f556c..1a4113b3b3b9 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -835,7 +835,7 @@ struct device_attach_data {
 	struct device *dev;
 
 	/*
-	 * Indicates whether we are are considering asynchronous probing or
+	 * Indicates whether we are considering asynchronous probing or
 	 * not. Only initial binding after device or driver registration
 	 * (including deferral processing) may be done asynchronously, the
 	 * rest is always synchronous, as we expect it is being done by
@@ -1039,7 +1039,7 @@ static void __device_driver_lock(struct device *dev, struct device *parent)
  * @parent: Parent device. Needed if the bus requires parent lock
  *
  * This function will release the required locks for manipulating dev->drv.
- * Normally this will just be the the @dev lock, but when called for a
+ * Normally this will just be the @dev lock, but when called for a
  * USB interface, @parent lock will be released as well.
  */
 static void __device_driver_unlock(struct device *dev, struct device *parent)
-- 
2.26.3

