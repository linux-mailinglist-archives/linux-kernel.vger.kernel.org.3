Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DEF57B77C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbiGTN3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbiGTN2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46FD64333A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658323724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+PcLE/VWZKE0O75uq+LhMOqrtDlyMvhqIp9miCLrKk=;
        b=IHD4WDp7SIIChIeiQiWByRb5gbcgrGb3GTrIowebJgMKtuCVjmbaq0DNiBf1sWBQ7PJ89p
        Z8CoccQqe83av4T83YJx4ESAJYkQhyBz7khKoHQS+FQsOCY6KJA69D2ewtVgoyP7ZFCKyk
        3zEaymWPuaGp+gUSUbbV9kwEZqkKC0Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-jIcHRIhAPXyVvrLD5KSPoQ-1; Wed, 20 Jul 2022 09:28:40 -0400
X-MC-Unique: jIcHRIhAPXyVvrLD5KSPoQ-1
Received: by mail-ej1-f71.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso4045563ejs.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+PcLE/VWZKE0O75uq+LhMOqrtDlyMvhqIp9miCLrKk=;
        b=Ky+IU3PKJzs0N7xxQdHqPlxVzA4eFHpcXm2jynRy55yfKrCtqutkqMg39hlESRs6pU
         1mjanloHD6EqJRh6UFjkpLtXfdIYvwpIU3TOF/4Pgco4xSFZzc15TB3yRncOgyqgYdEy
         l1M+TAox3EqTMrWbhPlwTPUmcRH2sTw+w8J79lBslIXtcZWQN1AxiQ8fJMG4q7kbYVEo
         X/Z4tRVBh/sgTRCXBs32ctC1ugIvKfCPJ5dWJmBebKt0d5F2HCFDbs4P/q0NgUvVibRC
         6yZOeGX3SykyFEqlIBn5OywezGwKK/5vUbgYi3xfKL6Pti7PhzBxJVhJukTXmZQBSD1V
         M8NQ==
X-Gm-Message-State: AJIora8R5mJCQolINEUXMVNeMJvcmiwgqz3McxX7cpi+JNsph7e526ev
        36Zqsjm9OJqIJlpTUjG5X9iboYwIp1gS/qJjmfjvurd5UDIZLZTPOAtw559MKKlf0bIP8c5ij4b
        9V6gIvjjKk4lbjpcykhsb76Pj
X-Received: by 2002:aa7:c9d3:0:b0:43a:67b9:6eea with SMTP id i19-20020aa7c9d3000000b0043a67b96eeamr49930813edt.94.1658323719488;
        Wed, 20 Jul 2022 06:28:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vEyOQrCfAYTR3roW2kvuyG5vM8MOGEzRZ+5S4xhOeQcoo4SnmiDYQWkH0qb2zNTJLilpgqgg==
X-Received: by 2002:aa7:c9d3:0:b0:43a:67b9:6eea with SMTP id i19-20020aa7c9d3000000b0043a67b96eeamr49930796edt.94.1658323719350;
        Wed, 20 Jul 2022 06:28:39 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm12220687edb.55.2022.07.20.06.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:28:39 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        christian.koenig@amd.com, emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 05/10] drm: use idr_init_base() to initialize mode_config.object_idr
Date:   Wed, 20 Jul 2022 15:28:25 +0200
Message-Id: <20220720132830.193747-6-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720132830.193747-1-dakr@redhat.com>
References: <20220720132830.193747-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_init_base(), implemented by commit 6ce711f27500 ("idr: Make 1-based
IDRs more efficient"), let us set an arbitrary base other than
idr_init(), which uses base 0.

Since, for this IDR, no ID < 1 is ever requested/allocated, using
idr_init_base(&idr, 1) avoids unnecessary tree walks.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_mode_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 37b4b9f0e468..e2a295a4ee0b 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -411,7 +411,7 @@ int drmm_mode_config_init(struct drm_device *dev)
 	INIT_LIST_HEAD(&dev->mode_config.property_blob_list);
 	INIT_LIST_HEAD(&dev->mode_config.plane_list);
 	INIT_LIST_HEAD(&dev->mode_config.privobj_list);
-	idr_init(&dev->mode_config.object_idr);
+	idr_init_base(&dev->mode_config.object_idr, 1);
 	idr_init(&dev->mode_config.tile_idr);
 	ida_init(&dev->mode_config.connector_ida);
 	spin_lock_init(&dev->mode_config.connector_list_lock);
-- 
2.36.1

