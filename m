Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AC050A089
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiDUNSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiDUNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 531576394
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650546922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XJ+q4BlTQtZT3BUqYMUruPECm6TJtmAxu5VYqnXrhVE=;
        b=D8F/v7+FKJcFga7jm+hIhK0MyMAM1Vct1RgjH/BvFqIK/hvDH9xPoXv5iAyKBup3OSKbcg
        KUzghd3Z58i6qbcC9cL6qblVBWk/AaE5xtB4nEaCSaxUBjQ+QwtuoMKyA+xubRaoqzVlW1
        H5HoUpd6wUWnk8YZ6y9OC2B02/yuhrA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-WGQlI761MymHaco9woVT2A-1; Thu, 21 Apr 2022 09:15:21 -0400
X-MC-Unique: WGQlI761MymHaco9woVT2A-1
Received: by mail-qv1-f72.google.com with SMTP id o12-20020a0562140e4c00b0044a67ef728dso3520460qvc.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJ+q4BlTQtZT3BUqYMUruPECm6TJtmAxu5VYqnXrhVE=;
        b=YVO1jF7K1mc1IP1fOpNoBQjTnPyI04oV9/jTE3jWnOdONiYaeskdL1EWOno99Q8dI4
         RdKTPxgNWpFJu1XczcivDXEUchic5lEmbFBZS7LEMrXXVGV0cadSP+zbSfI0WVOiSI9l
         09U8N2LSS1j4oxGcTPIFTDQSL0a/DMlSzigPGe7EhODlij9W9K26KM/8zKxC2C+BL309
         lBA6pZvw4sMHNgV0BFIzTfYcYTp6rGv76G51udi1LmJi/UGUAFmSvPsYEyTifP7n/imx
         rzorYKr2nY2XzXBL6KixjHAzQFPXIjzKNbbzOrYwVmklWQr28ACp5MqFWhxLFomXEVif
         sFpQ==
X-Gm-Message-State: AOAM531s39z0NAQaQeINRlvLfBTxOp6uh4lw8dmCFiRQEYgPuWNuIQhz
        LIMbeXT6k9DT3syN/EuMV6LE1qCxvSKn+N5GqAtvD77vjXfAiLTSRWa7xR4g7QjLkL4pzJuWWlN
        YP7XhIloMPUr55FlRoapcnuk+
X-Received: by 2002:a05:620a:4093:b0:69c:fda:3cf2 with SMTP id f19-20020a05620a409300b0069c0fda3cf2mr15404143qko.245.1650546920743;
        Thu, 21 Apr 2022 06:15:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1p460pSQsriY5we0lc7aVE2SA3Un1gDznPdW1XSStmWduRojaJ0UnG57Ylk7u7lLp/dyJdg==
X-Received: by 2002:a05:620a:4093:b0:69c:fda:3cf2 with SMTP id f19-20020a05620a409300b0069c0fda3cf2mr15404128qko.245.1650546920553;
        Thu, 21 Apr 2022 06:15:20 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm3868302qtw.64.2022.04.21.06.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:15:19 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/msm: change msm_sched_ops from global to static
Date:   Thu, 21 Apr 2022 09:15:07 -0400
Message-Id: <20220421131507.1557667-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
msm_ringbuffer.c:43:36: warning: symbol 'msm_sched_ops' was not declared. Should it be static?

msm_sched_ops is only used in msm_ringbuffer.c so change its
storage-class specifier to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/msm/msm_ringbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index 367a6aaa3a20..66f4ec09ef67 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -40,7 +40,7 @@ static void msm_job_free(struct drm_sched_job *job)
 	msm_gem_submit_put(submit);
 }
 
-const struct drm_sched_backend_ops msm_sched_ops = {
+static const struct drm_sched_backend_ops msm_sched_ops = {
 	.run_job = msm_job_run,
 	.free_job = msm_job_free
 };
-- 
2.27.0

