Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8344F0A29
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356204AbiDCOXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiDCOXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1199396A5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648995708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2NzOUXV5geNPV1jFPan7KnjsKEym0Ss9ltF3bQDMSJk=;
        b=UxS4IW4HPgjtWRwM9boaNYf5ScTzXbTB60MzTGVDRa/b01s7lrMv15UTu3t6VRq+nMlmH2
        cQk7tB711qOSHDosaxN45yuQ4i6NnZolp/luWfcsZzvpupsw0PJ3QoWuB4T0ERHlBum7CX
        zNJr7SrWBi1HwHBSDJLiYHvUhsaj/do=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-LZSLYwDtMmqakd-ceuJ0fw-1; Sun, 03 Apr 2022 10:21:47 -0400
X-MC-Unique: LZSLYwDtMmqakd-ceuJ0fw-1
Received: by mail-qk1-f199.google.com with SMTP id 207-20020a3706d8000000b0067b322bef9eso4837920qkg.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 07:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2NzOUXV5geNPV1jFPan7KnjsKEym0Ss9ltF3bQDMSJk=;
        b=rh9qAhXDZdDmRGoabhuN/GWdlvWpa0mdO9WNxjfXfeZ9lGDPMyrLa5tPtIBSr/TkxP
         ZQEbx2KdbyC2Re/mpITjvlPVAHW1ukIJGIFPnkhvKKBiGVdQNKhJ7cXMmUIZqo929ybl
         Dvgxg/xHFaRlMlfAkYAvtUWyB4c9wnTrSwnZUV64A3b65GCw/K5kiaezhjeY8d2n7z6j
         KiCHj3bDCi4TzBfYdMbVr6SXFoWYXlzg5Jsa4ntKlrf9a53U9jAarLtbXZWuikkEfn2u
         n4A6CdJM9AhzfPryTo72IzBP03m0hueXtSrLEMFytmZeNHZ6K9OpZLMdmS8Pdh3pUFxl
         2FAA==
X-Gm-Message-State: AOAM530gIfvVZKc4LGODA5hineaJgH92h0MWXeh612QaFskTONrP6phF
        En6HiYy78Odh47Rzww9lg0jMoF9FpmQHnM/jvvbEeMyicPvhzwglShA9Vh3q62Y79D5y4Dop1hm
        PRE+TM6wuxMlqaBJ3O5unc8jd
X-Received: by 2002:a05:6214:da9:b0:441:2d37:1fdf with SMTP id h9-20020a0562140da900b004412d371fdfmr14150777qvh.14.1648995707220;
        Sun, 03 Apr 2022 07:21:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvPjZwizmTlC5AqPbCRYoH/kd4u1WRNzlEq/em0QPB+9sK5Zmh1lXeSdZpIFrdpTz7Zx+Gqg==
X-Received: by 2002:a05:6214:da9:b0:441:2d37:1fdf with SMTP id h9-20020a0562140da900b004412d371fdfmr14150757qvh.14.1648995707058;
        Sun, 03 Apr 2022 07:21:47 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85e06000000b002e1e8a98abbsm6194271qtx.41.2022.04.03.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:21:46 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, wenjing.liu@amd.com, waynelin@amd.com,
        Anson.Jacob@amd.com, Yu-ting.Shen@amd.com, keescook@chromium.org,
        nicholas.kazlauskas@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: cleanup extern usage in function definition
Date:   Sun,  3 Apr 2022 10:21:37 -0400
Message-Id: <20220403142137.2234322-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
hdcp1_execution.c:500:29: warning: function
  'mod_hdcp_hdcp1_dp_execution' with external linkage
  has definition

The storage-class-specifier extern is not needed in a
definition, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 6ec918af3bff..1ddb4f5eac8e 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -497,9 +497,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_execution(struct mod_hdcp *hdcp,
 	return status;
 }
 
-extern enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
-		struct mod_hdcp_event_context *event_ctx,
-		struct mod_hdcp_transition_input_hdcp1 *input)
+enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
+						 struct mod_hdcp_event_context *event_ctx,
+						 struct mod_hdcp_transition_input_hdcp1 *input)
 {
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
-- 
2.27.0

