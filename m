Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031FB4C56B8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 16:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiBZP7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 10:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiBZP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 10:59:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7006179257
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645891142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Grhy4tvGVEY5R3BS2D+G2b4sVPmyn1TwoVnElYjF3HA=;
        b=Ipku3yC4aCig8NgOKZ8/63iSE4nGmfoSLjuxW1bqxPDZvEpcUr+c6qF0mxWMUkbqXLfsuc
        guDBKWK5pxhU5hj1i70wQJbBtUQpJsXXophs38njDH3QwCr55RAlU2bri4kayousVUgupD
        o8gHsH6gX7egUXuZwNeGy+Kv4fcMFEg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-IUfESuxqPIa4Iee-FS37WA-1; Sat, 26 Feb 2022 10:59:01 -0500
X-MC-Unique: IUfESuxqPIa4Iee-FS37WA-1
Received: by mail-qv1-f69.google.com with SMTP id hu9-20020a056214234900b0042c4017aeb3so8058657qvb.14
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Grhy4tvGVEY5R3BS2D+G2b4sVPmyn1TwoVnElYjF3HA=;
        b=MZr870v/sth9oiLNd8AizZRC/7S0x0fy/Q2Y/W2BUf991Smnegjwxp9w5jcHgS/IMm
         qKVHByI/GBJEaVnOGZKRo2gsXzbSRHfur8mKCb7hf3k7gCbbFKZbl6JbzgWsVnSVh8CC
         qhe0Xu1ZqtOgCSxJ9xQ9Kinlr1TlT16zC9oH4ZHElzr8Iyn9/j/QD1Ldo1sQL4juwDlJ
         1H+iyYmzKOSZqKMxccMYoymU76NRwaRWORNITE2iUqNOPnzbJV9vn36MX7KTqADN+mlG
         qFzePiH7bDYCFJLBlSM6yAOjL5qb8XdkEeeNBMEr7ipvC2pPKKdVi/rT4xbw37a5nSr3
         UmWw==
X-Gm-Message-State: AOAM531zcQJDMO0in08Yvhl3cavWv02Ur1Sihas7lF9lSFXZLthNNF3I
        dxDiCUrYuc6dIt5la+DfGGhzx3KrNDTiE++SNVfSteB9x/6sb7mp+ktMmluoU8770nkzYNIU/k6
        iSIdXUs6qKdwevNEHrU8GsFwm
X-Received: by 2002:a05:620a:122c:b0:47e:1445:15e8 with SMTP id v12-20020a05620a122c00b0047e144515e8mr7667248qkj.200.1645891141072;
        Sat, 26 Feb 2022 07:59:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyep784W30LsjYckoKZZTZAqrxmyuQo5OmviyaAolfcaSK5XfS1laivNCE0UKTxjerrO/TlHg==
X-Received: by 2002:a05:620a:122c:b0:47e:1445:15e8 with SMTP id v12-20020a05620a122c00b0047e144515e8mr7667237qkj.200.1645891140834;
        Sat, 26 Feb 2022 07:59:00 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a148900b005f188f755adsm2640064qkj.32.2022.02.26.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 07:59:00 -0800 (PST)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nathan@kernel.org, ndesaulniers@google.com, nirmoy.das@amd.com,
        lijo.lazar@amd.com, tom.stdenis@amd.com, evan.quan@amd.com,
        kevin1.wang@amd.com, Amaranath.Somalapuram@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: Fix realloc of ptr
Date:   Sat, 26 Feb 2022 07:58:51 -0800
Message-Id: <20220226155851.4176109-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error
amdgpu_debugfs.c:1690:9: warning: 1st function call
  argument is an uninitialized value
  tmp = krealloc_array(tmp, i + 1,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~

realloc will free tmp, so tmp can not be garbage.
And the return needs to be checked.

Fixes: 5ce5a584cb82 ("drm/amdgpu: add debugfs for reset registers list")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 9eb9b440bd438..159b97c0b4ebc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1676,7 +1676,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	char reg_offset[11];
-	uint32_t *tmp;
+	uint32_t *tmp = NULL;
 	int ret, i = 0, len = 0;
 
 	do {
@@ -1688,6 +1688,10 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 		}
 
 		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto error_free;
+		}
 		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
 			ret = -EINVAL;
 			goto error_free;
-- 
2.26.3

