Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC2756397D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiGATCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiGATCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 460003917D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656702163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jrqIOUaKKQbWi9G365N+s7BAFB2QpummhvZ1Qj6rHlE=;
        b=dQBoysKPZK1RHyjgzMWJOlTu4nFKdNcpXbVw6Mi8OcCpWl1sBTNp1+sKriphKKDW+28bCm
        lJImEr2gii8JYsul09cVhl7wY4ioLwgklrey8dVH2righ6i33LqT3Z1h1GYQAEpZ2duqZp
        4BAgW0MryIrYwtVS2kcE6ktKcuHyrQ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-nAQO2VpYPgOzF_OnePyIZA-1; Fri, 01 Jul 2022 15:02:40 -0400
X-MC-Unique: nAQO2VpYPgOzF_OnePyIZA-1
Received: by mail-wr1-f71.google.com with SMTP id e6-20020adfc846000000b0021d2af9adb6so549389wrh.18
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 12:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrqIOUaKKQbWi9G365N+s7BAFB2QpummhvZ1Qj6rHlE=;
        b=3jCIfxrnV+kT4JWskkf9AHX3w2kjN3LwY0leUkDEF9396W6laAKCwTEpgPkk2Sjq6r
         9SCKZd4DwpBLkeypdFJCKWidthvLPs7NBuoYRvok1w6Bl1p0aFSsvIbl4y/+Aftxd5pA
         frO5McNiDhO5bluisjEX7R/i7yJaBDcJpCNZlcQlcW3DaFAGI3KWe8sm+HXvxmRAa2qx
         SNCOe/5jnTQS2CA6MMfZ5y07vKeYaediN4AHLqsn6kuZLi5QuNzLTit7X+glW6mdHSOe
         oFGEeNyBHkA7dD5hlyaoQHdhyRSgXflttmKB8DxAj8kJBVn2XToWfLHPJ3Cg2EqHSLyY
         YMnQ==
X-Gm-Message-State: AJIora8yxxu2cuEILoP9AiHWuqw2JxY9oX+HmZCSTtrw2BPqWTcBjJHl
        UfwRUgQFVBpCLa2SerT+kYdw/UpUV3y7tcR1b/guJnWiBlz9STmYUvdVrgeTzYlYb6amamGlKcE
        lQj9ozigB15+Jk/0S2iAjbj5h
X-Received: by 2002:a05:600c:4f81:b0:39c:809c:8a9e with SMTP id n1-20020a05600c4f8100b0039c809c8a9emr20291079wmq.39.1656702158839;
        Fri, 01 Jul 2022 12:02:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vV8/aKK46I0XwYmtYH6nEdafsMBLfquMnfV6l0ttdxxkjxJCItV0d0EK67aRhPcMUKsTmmuQ==
X-Received: by 2002:a05:600c:4f81:b0:39c:809c:8a9e with SMTP id n1-20020a05600c4f8100b0039c809c8a9emr20291062wmq.39.1656702158674;
        Fri, 01 Jul 2022 12:02:38 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0039c5642e430sm12535470wmq.20.2022.07.01.12.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:02:38 -0700 (PDT)
From:   dakr@redhat.com
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 09/10] drm/via: use idr_init_base() to initialize dev_priv->object_idr
Date:   Fri,  1 Jul 2022 21:02:26 +0200
Message-Id: <20220701190227.284783-2-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701190227.284783-1-dakr@redhat.com>
References: <20220701185303.284082-1-dakr@redhat.com>
 <20220701190227.284783-1-dakr@redhat.com>
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
 drivers/gpu/drm/via/via_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/via/via_map.c b/drivers/gpu/drm/via/via_map.c
index a9f6b0c11966..c20bb20c0e09 100644
--- a/drivers/gpu/drm/via/via_map.c
+++ b/drivers/gpu/drm/via/via_map.c
@@ -106,7 +106,7 @@ int via_driver_load(struct drm_device *dev, unsigned long chipset)
 	if (dev_priv == NULL)
 		return -ENOMEM;
 
-	idr_init(&dev_priv->object_idr);
+	idr_init_base(&dev_priv->object_idr, 1);
 	dev->dev_private = (void *)dev_priv;
 
 	dev_priv->chipset = chipset;
-- 
2.36.1

