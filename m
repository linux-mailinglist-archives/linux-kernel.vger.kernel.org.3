Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEF1563982
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiGATCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiGATCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2059237ABE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656702159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LWfDQABAaX6JpmqkFhW71LBBJJ2YX+O6PnBrulbv00=;
        b=X4gdVzkJrJyio3IFAqwXu5JxDK+kE3K823RF/ZE9DWiU9oEzAIoSmR7P21unssXyjVTttu
        OC187BR6cXMxGrTvRz5NqDFTVCwT0MKCwfiMFTlOWwxQ5SQuumwQkxODb2pbef9Bdh8ssn
        V+hMfZGc2iimRkIPMxzXNhJtd4c1P40=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-4uShMGItPOOQ_Zqo0y_ykA-1; Fri, 01 Jul 2022 15:02:37 -0400
X-MC-Unique: 4uShMGItPOOQ_Zqo0y_ykA-1
Received: by mail-wm1-f72.google.com with SMTP id az40-20020a05600c602800b003a048edf007so1344930wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 12:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LWfDQABAaX6JpmqkFhW71LBBJJ2YX+O6PnBrulbv00=;
        b=bUF5U7nlR8SjafvEb0yf5AspcnpZsrT3FOd6DLckiL+9o9IQ2AtZMud98fShP2sPpS
         FqhL1Dn+GuvyndnQdOcyfAiHjHpzL1XDMiCCMeqagb7DRO4M1Zpdnxc0CK9GDdldmODw
         102P+xzly479dSazKX3JMPlyIuK83kF46v3x1bDf1+Atx5QFm+7fw3ZDxDD2dmbR2QsG
         zqZV5ONZYSrUr+6kC9HyIUJosm3wFtlybI7oJK1N2ctb0m4WRdlxa6AYKmA2dx8GNw5H
         cCPbPvGgPmfJLg8A7Ia8mhGhL6j4T+RuJUMCVndTXv0D7dQyfW/GWh3TS1lY5mA3xeHb
         HVvw==
X-Gm-Message-State: AJIora9sndrXJB6WpXM8l57ha+aPhakRHllBTy8ll1S+Ms0rb/UuG2rE
        eGtyyZp30RCi++j5BRV5/al52apKp5+GzpDz7v7WbFIPStRI/YRxXoDM082Ax0d7m0rWBrsCr/P
        n48NxY7Fo98JgNzbjEFG25XQq
X-Received: by 2002:a5d:420f:0:b0:21d:54a1:691c with SMTP id n15-20020a5d420f000000b0021d54a1691cmr599960wrq.40.1656702156600;
        Fri, 01 Jul 2022 12:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slXnmlpnnf2Fh346beEHXPcik49nkXMKD8QypwkLs3wJX8XDvqeUcc8EozNRusoL1OG6yUpQ==
X-Received: by 2002:a5d:420f:0:b0:21d:54a1:691c with SMTP id n15-20020a5d420f000000b0021d54a1691cmr599950wrq.40.1656702156446;
        Fri, 01 Jul 2022 12:02:36 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0039c5642e430sm12535470wmq.20.2022.07.01.12.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:02:36 -0700 (PDT)
From:   dakr@redhat.com
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 08/10] drm/v3d: use idr_init_base() to initialize v3d_priv->perfmon.idr
Date:   Fri,  1 Jul 2022 21:02:25 +0200
Message-Id: <20220701190227.284783-1-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701185303.284082-1-dakr@redhat.com>
References: <20220701185303.284082-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danilo Krummrich <dakr@redhat.com>

idr_init_base(), implemented by commit 6ce711f27500 ("idr: Make 1-based
IDRs more efficient"), let us set an arbitrary base other than
idr_init(), which uses base 0.

Since, for this IDR, no ID < 1 is ever requested/allocated, using
idr_init_base(&idr, 1) avoids unnecessary tree walks.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/v3d/v3d_perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index f6a88abccc7d..48aaaa972c49 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -95,7 +95,7 @@ struct v3d_perfmon *v3d_perfmon_find(struct v3d_file_priv *v3d_priv, int id)
 void v3d_perfmon_open_file(struct v3d_file_priv *v3d_priv)
 {
 	mutex_init(&v3d_priv->perfmon.lock);
-	idr_init(&v3d_priv->perfmon.idr);
+	idr_init_base(&v3d_priv->perfmon.idr, 1);
 }
 
 static int v3d_perfmon_idr_del(int id, void *elem, void *data)
-- 
2.36.1

