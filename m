Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F374B59D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357425AbiBNSWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:22:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245427AbiBNSWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E37B32983A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644862959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6KphgiHwgRe3NkAsq1kWFGjvzJI/mlc7nnNKh2wAjkA=;
        b=D9o3A4P7Fu/G+WYZPhpdU7z8ul/WUQE8lIlL2RTfkp8qaCjKitvKzQHzv/SPZvZXyo10/C
        d01BCKAwt1cga8fDJ2xfmOisiFHBnmFt3jHfCgRbX4o0VgJpuhwQX3JPj16X29shXNbhq+
        /5LRhPcgBqTES7ghXqxyPLL9IcrMAQc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-Z7ciOw1rNZCtJLNu-XOwpA-1; Mon, 14 Feb 2022 13:22:38 -0500
X-MC-Unique: Z7ciOw1rNZCtJLNu-XOwpA-1
Received: by mail-oi1-f199.google.com with SMTP id q10-20020a056808200a00b002cefffffe5eso3929538oiw.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KphgiHwgRe3NkAsq1kWFGjvzJI/mlc7nnNKh2wAjkA=;
        b=SSIDLhbJ8K9zPLvXku2sa/ncrH8ztgfXYFZtfC9ZzdU7j8+gQAXY4RCI0yuvLzJJ8p
         03/QAeooSSOFELiHNhguu+yM7za3oebv2KvJ0fVekQrIJ31nabfcNJkNtjxXy/aaviwQ
         2oBpGxQrINKYrWWkj3jULvSPYb7PY9/JT5FardVkLFfMspDQ96oYx05MI/KyTNDqkxf4
         FFlZL1QLAuEUZrlIEF/xachFyLcbYySA0uCq9aRrBItzLR/PmGDXl0q+cDXWZqgILqB9
         TSsy1/WoNXBOgW7WZYWlVKr66gTi0Ys93PH2YHY1W3+JQBna+IZ8aNg4IfBATxNfo4tb
         J1zw==
X-Gm-Message-State: AOAM530vK3TrKr5kGCaVy7CZ1CrqsrgM+2fffoAmiJlT4cUhmm4Ld+6W
        CzLDcOk/KIh9/VHQ4XECPzM0k+E3mNSjr4m0XLnqHo7zzRa7CYHeHvck0YFLa3N1RkUjkHUGZx4
        O4sjsQN4vos1hP7ddkZ0zkLPU
X-Received: by 2002:a05:6808:2227:: with SMTP id bd39mr64708oib.142.1644862956381;
        Mon, 14 Feb 2022 10:22:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVpfes2LLHqPuaIsi0+RkM/zs2xkzYjID6G+ExdR/vMlhePhV1G0FpY7aHAfq8EanEFOo3Eg==
X-Received: by 2002:a05:6808:2227:: with SMTP id bd39mr64640oib.142.1644862954708;
        Mon, 14 Feb 2022 10:22:34 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id j6sm12673419otq.76.2022.02.14.10.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:22:34 -0800 (PST)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nathan@kernel.org, ndesaulniers@google.com, luben.tuikov@amd.com,
        david.nieto@amd.com, nirmoy.das@amd.com, Ken.Xue@amd.com,
        Roy.Sun@amd.com, evan.quan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: check return status before using stable_pstate
Date:   Mon, 14 Feb 2022 10:22:24 -0800
Message-Id: <20220214182224.2906060-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
amdgpu_ctx.c:616:26: warning: Assigned value is garbage
  or undefined
  args->out.pstate.flags = stable_pstate;
                         ^ ~~~~~~~~~~~~~
amdgpu_ctx_stable_pstate can fail without setting
stable_pstate.  So check.

Fixes: 8cda7a4f96e4 ("drm/amdgpu/UAPI: add new CTX OP to get/set stable pstates")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 1c72f6095f08..f522b52725e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -613,7 +613,8 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 		if (args->in.flags)
 			return -EINVAL;
 		r = amdgpu_ctx_stable_pstate(adev, fpriv, id, false, &stable_pstate);
-		args->out.pstate.flags = stable_pstate;
+		if (!r)
+			args->out.pstate.flags = stable_pstate;
 		break;
 	case AMDGPU_CTX_OP_SET_STABLE_PSTATE:
 		if (args->in.flags & ~AMDGPU_CTX_STABLE_PSTATE_FLAGS_MASK)
-- 
2.26.3

