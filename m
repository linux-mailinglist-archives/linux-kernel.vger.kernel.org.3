Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8220056396E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiGASxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiGASxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F208111455
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656701593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/eGVHzjhye4tUiS8VCyJS+YtTUEyz7/sK1IBUUWWhM=;
        b=gofCx+Z4pLFmQ7yLPqU9uoQ92xbabBlgKGhj8n8DuaBQGlvnQJaJgArRUyFQL6gIR6Z5To
        oYQrCTzfID+YrtsyRfD/SfPH4boEbi1lc26fiGi/tqizkDIbGsacNI7DZRNbsksbOpUyKB
        5NU6KgqtibhcIy+hGw2DWL+2DQFK78M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-yKMdK10gPBCNqhmvPAK18w-1; Fri, 01 Jul 2022 14:53:11 -0400
X-MC-Unique: yKMdK10gPBCNqhmvPAK18w-1
Received: by mail-ed1-f70.google.com with SMTP id w22-20020a05640234d600b00435ba41dbaaso2294902edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 11:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/eGVHzjhye4tUiS8VCyJS+YtTUEyz7/sK1IBUUWWhM=;
        b=5TjIk/f4d1uXhl55zyDAq95ti37BwW+/YcepNFXls2QVcHgMn0MXY0N8k3bIW0lAWE
         f+Y8g38n7bzl2GIjnwmJMvISVvO9IurHb1AVRIzUvbRggeeW8/YjR8DW0KHdRjhYVDZ9
         NqnyP66V1HnIZyKTEVYNLClhKU1KpvPWN8han1dgeJclvx8i291W5DvYF8ToAASz9XAv
         CTb0Sq8aGy5ZqUd7JmQlGRTXzSlf8nsRlB/cGXFSLIEniLpwnNkb4wtEaFVNKUQPjkse
         coqKtgWRe1vcWpS+KvTcEn9uzCy9fBwAyq/QD9osN+W2bB1L4VQq60CDDoNdqcXsWC3w
         DobQ==
X-Gm-Message-State: AJIora867kPEa5j1zrjy+CDFBXizE68PEGCV4PUBXIs0kOGuj1d8pEJh
        NkquKq6Fek7cPp8tpEmND4BSOdSYS4L2Ohd6x1Mr7FFzYh4xA6kRan7RvB0K8bKnAu+7DK0IR7m
        uwqC7RpU/2tqkRvVkcOqkQ16m
X-Received: by 2002:a17:907:9488:b0:722:e5c8:c647 with SMTP id dm8-20020a170907948800b00722e5c8c647mr15451432ejc.291.1656701590532;
        Fri, 01 Jul 2022 11:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1twrosMg5ykAMCjALhx0tb7xsAbjXTCVpYQRYG7l64S4JJBJdRhEr/kbxeM0Y3ZOyHI+W5ZJQ==
X-Received: by 2002:a17:907:9488:b0:722:e5c8:c647 with SMTP id dm8-20020a170907948800b00722e5c8c647mr15451417ejc.291.1656701590372;
        Fri, 01 Jul 2022 11:53:10 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id cb25-20020a0564020b7900b004359dafe822sm15406658edb.29.2022.07.01.11.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:53:10 -0700 (PDT)
From:   dakr@redhat.com
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 01/10] drm/amdgpu: use idr_init_base() to initialize mgr->ctx_handles
Date:   Fri,  1 Jul 2022 20:52:54 +0200
Message-Id: <20220701185303.284082-2-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701185303.284082-1-dakr@redhat.com>
References: <20220701185303.284082-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Since, for this IDR, no ID < 1 is ever requested, using
idr_init_base(&idr, 1) avoids unnecessary tree walks.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 7dc92ef36b2b..cc87c3809a8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -841,7 +841,7 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
 
 	mgr->adev = adev;
 	mutex_init(&mgr->lock);
-	idr_init(&mgr->ctx_handles);
+	idr_init_base(&mgr->ctx_handles, 1);
 
 	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
 		atomic64_set(&mgr->time_spend[i], 0);
-- 
2.36.1

