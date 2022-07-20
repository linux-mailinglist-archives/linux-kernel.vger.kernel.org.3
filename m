Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5418657B76B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiGTN2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGTN2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F00828E15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658323717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+f2U5Jo1TdZSY11r/ueBE+7GgJruty1MjYryFBsUD7o=;
        b=YRJqxRa7z507ulCpkXTQOQrXCwY2iZFRZ1W4z1dz2CnMYAya2sus376GWg7xyuWa7NkTrE
        b09yM2HX4DRfw2PJXxIwrxcoW0PbVux2aXuAAXcR5Mr7NAuwXY5Y9LtCdDUnR+Wap8j/vs
        CZKbXoXRPal9468jlGKIMkhXUokk8C4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-ireu0n0aOCqoTJOQhK-KKA-1; Wed, 20 Jul 2022 09:28:36 -0400
X-MC-Unique: ireu0n0aOCqoTJOQhK-KKA-1
Received: by mail-ed1-f72.google.com with SMTP id m10-20020a056402510a00b0043a93d807ffso12064839edd.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+f2U5Jo1TdZSY11r/ueBE+7GgJruty1MjYryFBsUD7o=;
        b=JB1z+4qwmyQ+0HHgiwQM4XOXJaCBX4KritB4pyp7Ri9X6+gmIOLOF5pYxjVNG0ZTsi
         ij/TWM7XVIGoImu/iBvfvjnWPyYhOPpJEFwn3l0Dl6qPv1783fFNBfNYVKv2m/zPF22d
         cGND7tanqCo+AWthNR0YWgqe4mmd7ws2NAv44K+a1uJ5vwwnwnweAG6TmJUswhGuxd6g
         0kusCsk3QGGqtjgvqGOzXTqms8FrxbKPuokFsDwrYdWni9+7mYmslJbLZBZmiWGmKJh5
         23wnj0qEm9TXhkVnBnS/ZCxyRXXHdVgvB0OonK7VpRYp39AzaLSRlQeMO01iU8fCipuV
         DQhQ==
X-Gm-Message-State: AJIora/a3QPH8lD/1+ThvwXJumt5m8G9bKv7gH7IRex0/faAJXMq56FB
        Dt5kMFrz5sFjilBUeiflAO7xD384UEow+4O3cEdig9gmOlbD1s0t8cHcqPvnx64jGBaUnujC5VH
        OGvkWIapEl3QekBiDZteNQt8k
X-Received: by 2002:aa7:df83:0:b0:43a:4b96:f126 with SMTP id b3-20020aa7df83000000b0043a4b96f126mr4357278edy.309.1658323714996;
        Wed, 20 Jul 2022 06:28:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vLFazpLitgbJcdGubIMhTG6WFsmdCd40ex9BK/SES/RtLtw9an98NNGQ71I0eglmrGe8zNyw==
X-Received: by 2002:aa7:df83:0:b0:43a:4b96:f126 with SMTP id b3-20020aa7df83000000b0043a4b96f126mr4357256edy.309.1658323714847;
        Wed, 20 Jul 2022 06:28:34 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm12220687edb.55.2022.07.20.06.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:28:34 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        christian.koenig@amd.com, emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 01/10] drm/amdgpu: use idr_init_base() to initialize mgr->ctx_handles
Date:   Wed, 20 Jul 2022 15:28:21 +0200
Message-Id: <20220720132830.193747-2-dakr@redhat.com>
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

Since, for this IDR, no ID < 1 is ever requested, using
idr_init_base(&idr, 1) avoids unnecessary tree walks.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
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

