Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A03523C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346166AbiEKSUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346168AbiEKST7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A097B14043B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652293197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OjmqosTJ6Gizg8804eI7hEvoeZHHnweNRCj5+1JAafk=;
        b=VYXKQ/iHdXb2ogBJ4m+Vjq5e8O+qdH2qTVwVETflCgZ9Y+PmrtrNRbEjWZGjdJpnpL2GKq
        2/40AtPta/pe6rd3Dr/OXys1CRapMr53t7h7l5sBaDYOKAiWKRtbmg6YN8J1AjdD7VtIJl
        GQPdUwCh+A+QnRQb26DNnNXtiiSCysE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-EUlxPZ5CMFK0edoaKGsZPQ-1; Wed, 11 May 2022 14:19:52 -0400
X-MC-Unique: EUlxPZ5CMFK0edoaKGsZPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B16AA85A5A8;
        Wed, 11 May 2022 18:19:51 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.33.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1084F400E43D;
        Wed, 11 May 2022 18:19:51 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Solomon Chiu <solomon.chiu@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/amdgpu: Add 'modeset' module parameter
Date:   Wed, 11 May 2022 14:19:33 -0400
Message-Id: <20220511181935.810735-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many DRM drivers feature a 'modeset' argument, which can be used to
enable/disable the entire driver (as opposed to passing nomodeset to the
kernel, which would disable modesetting globally and make it difficult to
load amdgpu afterwards). Apparently amdgpu is actually missing this
however, so let's add it!

Keep in mind that this currently just lets one enable or disable amdgpu, I
haven't bothered adding a headless mode like nouveau has - however I'm sure
someone else can add this if needed.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ebd37fb19cdb..24e6fb4517cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -872,6 +872,15 @@ MODULE_PARM_DESC(smu_pptable_id,
 	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
 module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
 
+/**
+ * DOC: modeset (int)
+ * Used to enable/disable modesetting for amdgpu exclusively.
+ */
+bool amdgpu_enable_modeset = true;
+MODULE_PARM_DESC(modeset,
+		 "Enable or disable display driver (1 = on (default), 0 = off");
+module_param_named(modeset, amdgpu_enable_modeset, bool, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
@@ -2003,6 +2012,11 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	bool is_fw_fb;
 	resource_size_t base, size;
 
+	if (!amdgpu_enable_modeset) {
+		DRM_INFO("modeset=0 passed to amdgpu, driver will not be enabled\n");
+		return -ENODEV;
+	}
+
 	/* skip devices which are owned by radeon */
 	for (i = 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
 		if (amdgpu_unsupported_pciidlist[i] == pdev->device)
-- 
2.35.1

