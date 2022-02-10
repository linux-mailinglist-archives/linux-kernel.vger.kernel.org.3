Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4634B13CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbiBJRE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:04:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiBJRE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:04:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 125E5BB9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644512666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yfg+rvc8vcVuTj7+GQ4UV9mGgjoAYvtiDa4kYWoYjJ8=;
        b=JWaoNWxy4Bl+YqCl3QsuFt92xpIDuXVhfFj7tVv9cRZeVJrTR+h9vlUbdjQkKEyWNPTJXJ
        +q0caz5G52kK5EF5Rn/5rjpj2Bygn5huFJSdH5yYR+ag/Fo7/LB9B8Gh3e5YZBk6pJ40ow
        gb5Ot25BYk2m8Qf706le86uCU9bEm68=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-YqBEonnVPDa2k1DeDmUcug-1; Thu, 10 Feb 2022 12:04:25 -0500
X-MC-Unique: YqBEonnVPDa2k1DeDmUcug-1
Received: by mail-qk1-f198.google.com with SMTP id p23-20020a05620a15f700b00506d8ec3749so4032185qkm.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfg+rvc8vcVuTj7+GQ4UV9mGgjoAYvtiDa4kYWoYjJ8=;
        b=ubfT6otvOKB8jYcFbww+qQNQ/KywUGa8Jo7bmYX9edL7dUSbIrcxkjrVEpC3L06zcP
         nH+GYEnL6bnN2dPeEgOaSw1bmYNMcip+IOfWEVtC/DbHiO/eQ36o1LwUOdAd7USFmsSY
         XjYD43wM2uzbNf/zuGeW4ojAxZjvasCGOpglJMr25gIX/EP9horLQRZ7gZO7RB/iTpsz
         DJaq+j4CYveaulmnSI8meje2SC/9c797LsxY5NOPb4DVd0xF4jjaV/DbIZWD0YJosBe3
         qFp2w/RG6ez6TxWNcx+xmA7x+iFAcsz3lJqDLSG47okBbCES2QPGPGkzZMi/0taFiyul
         znOg==
X-Gm-Message-State: AOAM532IaSupthVV0zHCuI/iaHEqBOOvGlX0cSjrkQUrifa0OU7KDffD
        A2LWZr9C2xH8632PNw0c59kCo0v0VfPEvW+LSB1FA9IzLwnNS7rNstcFdWaYtStxPwtnhF4hqkk
        S4Ba1S5g92gUGfoxRA8kj2OuI
X-Received: by 2002:a05:622a:488:: with SMTP id p8mr5619784qtx.97.1644512664764;
        Thu, 10 Feb 2022 09:04:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6fO5DYKXU/juk8kup+dK1EWIDMNgxbwD2+eVcMOxOQtX4NtPMxUE/mv2fPNsQDd1zWg2wfQ==
X-Received: by 2002:a05:622a:488:: with SMTP id p8mr5619768qtx.97.1644512664592;
        Thu, 10 Feb 2022 09:04:24 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id j11sm11156880qtj.74.2022.02.10.09.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:04:24 -0800 (PST)
From:   trix@redhat.com
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        rajneesh.bhardwaj@amd.com, david.yatsin@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdkfd: fix loop error handling
Date:   Thu, 10 Feb 2022 09:04:18 -0800
Message-Id: <20220210170418.2404807-1-trix@redhat.com>
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

Clang static analysis reports this problem
kfd_chardev.c:2594:16: warning: The expression is an uninitialized value.
  The computed value will also be garbage
        while (ret && i--) {
                      ^~~

i is a loop variable and this block unwinds a problem in the loop.
When the error happens before the loop, this value is garbage.
Move the initialization of i to its decalaration.

Fixes: be072b06c739 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 636391c61cafb..4310ca07af130 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2374,7 +2374,7 @@ static int criu_restore_bos(struct kfd_process *p,
 	const bool criu_resume = true;
 	bool flush_tlbs = false;
 	int ret = 0, j = 0;
-	uint32_t i;
+	uint32_t i = 0;
 
 	if (*priv_offset + (args->num_bos * sizeof(*bo_privs)) > max_priv_data_size)
 		return -EINVAL;
@@ -2410,7 +2410,7 @@ static int criu_restore_bos(struct kfd_process *p,
 	*priv_offset += args->num_bos * sizeof(*bo_privs);
 
 	/* Create and map new BOs */
-	for (i = 0; i < args->num_bos; i++) {
+	for (; i < args->num_bos; i++) {
 		struct kfd_criu_bo_bucket *bo_bucket;
 		struct kfd_criu_bo_priv_data *bo_priv;
 		struct kfd_dev *dev;
-- 
2.26.3

