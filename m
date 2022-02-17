Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DE54BA48C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242587AbiBQPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:39:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242583AbiBQPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:39:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BA6A2B1A98
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645112335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CoTxwG5lqMogkG1tkhH6Op74mbfSGaKHCACVBM5sEqs=;
        b=GoKXCy0XFen0//Aok/RaXchamrfvKqQC7tYoWqLIdRpA2s/vjOwcd33NsjuVE4cz6PKu+Q
        ALZxEerDfmS3qr7znF4dMxa6nFc3g/8Wi6O2OVAO2iJLI76VQYTMLz4Wmzvf7NhLADwdLc
        yPQ3zLzBYAhQskqrgO1anAarCSpdLyI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-W2CqRNxvO7ySxUffts7nhw-1; Thu, 17 Feb 2022 10:38:54 -0500
X-MC-Unique: W2CqRNxvO7ySxUffts7nhw-1
Received: by mail-oo1-f71.google.com with SMTP id a142-20020a4a4c94000000b0031a9acddae9so2728162oob.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CoTxwG5lqMogkG1tkhH6Op74mbfSGaKHCACVBM5sEqs=;
        b=uGgiW8cCzzmYOblaXZD0VFTFjR86/uMNzCTq7rmlzPkD2bKEviEStCtfzqbRfgwCvZ
         rdv95z7tmQZpvtKegLP3u4FLkZMIyvIjlkqyFjUv+4F8q+woLUvbXrj3IGtQbKBBLtIH
         d5MnkX39vBS4jwFD9FrFK+Z6XwV+SvwPULHOFYL45ZuIkkvLp4Sa3bAPgSZkyOSV96QN
         igjpw4Gs3maPwExgCG//l7HvKGnGJTA+zogMYTpndt99kK2FXPL/kNK7qd97QLIqUhoM
         ZQkuQ/Pam43emkTYXAkarW1L6qq//QQ99C7hYN3SNbx7ghu2/BJcmsCG+2oB1WygZ8sc
         caOQ==
X-Gm-Message-State: AOAM533zSlHW2XlaUQ5bwmsZZ6c0TQrQXL3DjoYBqsf4N/ndpdoAyorE
        l3JDYt6IB5vXPga1dUwA2A2TbZgrG5406W5tqraXFm81gT/ZPgaFIFlRkojZgNor/emEwX9ISVM
        VV3B56zPSYBwXYUhmBRrTRSpD
X-Received: by 2002:a05:6830:41:b0:5a0:93fa:161d with SMTP id d1-20020a056830004100b005a093fa161dmr1020910otp.88.1645112333689;
        Thu, 17 Feb 2022 07:38:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNPtTeWpYlbfs2THVEoksmj7PsLvm2GLCm7n8pIk1AhH37AWo21W37FGBs4lG0Kd2SS1+XmQ==
X-Received: by 2002:a05:6830:41:b0:5a0:93fa:161d with SMTP id d1-20020a056830004100b005a093fa161dmr1020900otp.88.1645112333470;
        Thu, 17 Feb 2022 07:38:53 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id q28sm2691306ots.76.2022.02.17.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 07:38:53 -0800 (PST)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nathan@kernel.org, ndesaulniers@google.com, Hawking.Zhang@amd.com,
        john.clements@amd.com, tao.zhou1@amd.com, YiPeng.Chai@amd.com,
        luben.tuikov@amd.com, Stanley.Yang@amd.com, Dennis.Li@amd.com,
        mukul.joshi@amd.com, nirmoy.das@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: fix amdgpu_ras_block_late_init error handler
Date:   Thu, 17 Feb 2022 07:38:42 -0800
Message-Id: <20220217153842.3252424-1-trix@redhat.com>
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

Clang build fails with
amdgpu_ras.c:2416:7: error: variable 'ras_obj' is used uninitialized
  whenever 'if' condition is true
  if (adev->in_suspend || amdgpu_in_reset(adev)) {
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

amdgpu_ras.c:2453:6: note: uninitialized use occurs here
 if (ras_obj->ras_cb)
     ^~~~~~~

There is a logic error in the error handler's labels.
ex/ The sysfs: is the last goto label in the normal code but
is the middle of error handler.  Rework the error handler.

cleanup: is the first error, so it's handler should be last.

interrupt: is the second error, it's handler is next.  interrupt:
handles the failure of amdgpu_ras_interrupt_add_hander() by
calling amdgpu_ras_interrupt_remove_handler().  This is wrong,
remove() assumes the interrupt has been setup, not torn down by
add().  Change the goto label to cleanup.

sysfs is the last error, it's handler should be first.  sysfs:
handles the failure of amdgpu_ras_sysfs_create() by calling
amdgpu_ras_sysfs_remove().  But when the create() fails there
is nothing added so there is nothing to remove.  This error
handler is not needed. Remove the error handler and change
goto label to interrupt.

Fixes: b293e891b057 ("drm/amdgpu: add helper function to do common ras_late_init/fini (v3)")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b5cd21cb6e58..c5c8a666110f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2432,12 +2432,12 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	if (ras_obj->ras_cb) {
 		r = amdgpu_ras_interrupt_add_handler(adev, ras_block);
 		if (r)
-			goto interrupt;
+			goto cleanup;
 	}
 
 	r = amdgpu_ras_sysfs_create(adev, ras_block);
 	if (r)
-		goto sysfs;
+		goto interrupt;
 
 	/* Those are the cached values at init.
 	 */
@@ -2447,12 +2447,11 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	}
 
 	return 0;
-cleanup:
-	amdgpu_ras_sysfs_remove(adev, ras_block);
-sysfs:
+
+interrupt:
 	if (ras_obj->ras_cb)
 		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
-interrupt:
+cleanup:
 	amdgpu_ras_feature_enable(adev, ras_block, 0);
 	return r;
 }
-- 
2.26.3

