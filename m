Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DEE4C5C9F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiB0Pkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiB0Pkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:40:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8791955BE5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 07:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645976394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JUKXRy9HtvoNJh5zgWKk9291k0gpOXjxfgvv4FNocC0=;
        b=gRQGiiFJSK/Mmq3a7ZObrrDF88bF+GGe7J8OcX0HflxZHw6x+TivgkIFOYa+4KKeG6ZAbF
        p+zjvW9Kf0gP6v59DOBHIeQBQrhxwozpEcgMrtp2nntbx39mxVW1DhAp2HPmEnAisRGxwu
        3VeBP8H5QW8q2yFHWJniifYsFn/OSV8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-OeTIlzlnOCuAKAbIvU1DEA-1; Sun, 27 Feb 2022 10:39:53 -0500
X-MC-Unique: OeTIlzlnOCuAKAbIvU1DEA-1
Received: by mail-qv1-f71.google.com with SMTP id a17-20020a0cca91000000b00432b9388584so7532846qvk.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 07:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUKXRy9HtvoNJh5zgWKk9291k0gpOXjxfgvv4FNocC0=;
        b=aB7YBp97Kgto1uuyIHPGlZ6z5Nzwnr44DcNv5jXgDp/8JSp2thCOVxJgTPaTaXKbUS
         9kQhOM644WJZAcrWNGgYaAXHHzYdxN/cxfdZY6pI0wj64mJaT+zJ6YvllA8Ck/siX4mF
         rpbqlbdq1ZHimfJyqrlj8m/M75XR6O/PPreI8Em2dOOg4mGc49DgGXc1AW9egnICfiqm
         AsDE9YNfRxHJWfruYQ1eDQbRkFEzGjY+RMkXaho72Vxnirq8WlvG2/kdq/910lVrHCGv
         Mh+Kb+57Xjy6bPWjB/9dk/eIJmZJfOARV48zi6VzVD+ySfKjX4b7PL+KVThRX2HoQET+
         F9fQ==
X-Gm-Message-State: AOAM531YRVrk1/Jankv9B6iS0hjAbjPvqnqL7Y54K5Vs92sGcXciDyQ5
        ddWtn0lYJZp9ZTJsc/Y/vRxUKxz5ih6VRCaiCTmxU3g4E1yIgdKJJ0ZpTmEEGPIP6w5nZQVvh9I
        QcFk/4zVGzjmRWyYuNTmUucye
X-Received: by 2002:ad4:5883:0:b0:432:b007:962b with SMTP id dz3-20020ad45883000000b00432b007962bmr10545689qvb.55.1645976392540;
        Sun, 27 Feb 2022 07:39:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypeMdQov6ivEZ1hmtZAlsJVizNYH0ogniT3ujzWNSu97z8PC8qPn1bhLsvRrQy0v8d6KuyjQ==
X-Received: by 2002:ad4:5883:0:b0:432:b007:962b with SMTP id dz3-20020ad45883000000b00432b007962bmr10545670qvb.55.1645976392292;
        Sun, 27 Feb 2022 07:39:52 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id c6-20020ac87d86000000b002ddd9f33ed1sm5036371qtd.44.2022.02.27.07.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:39:51 -0800 (PST)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nathan@kernel.org, ndesaulniers@google.com, lijo.lazar@amd.com,
        nirmoy.das@amd.com, kevin1.wang@amd.com, tom.stdenis@amd.com,
        evan.quan@amd.com, Amaranath.Somalapuram@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] drm/amdgpu: Fix realloc of ptr
Date:   Sun, 27 Feb 2022 07:33:42 -0800
Message-Id: <20220227153342.79546-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

realloc uses tmp, so tmp can not be garbage.
And the return needs to be checked.

Fixes: 5ce5a584cb82 ("drm/amdgpu: add debugfs for reset registers list")
Signed-off-by: Tom Rix <trix@redhat.com>
---
v2:
  use 'new' to hold/check the ralloc return
  fix commit log mistake on ralloc freeing to using input ptr
  
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 9eb9b440bd438..2f4f8c5618d81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1676,7 +1676,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	char reg_offset[11];
-	uint32_t *tmp;
+	uint32_t *new, *tmp = NULL;
 	int ret, i = 0, len = 0;
 
 	do {
@@ -1687,7 +1687,12 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 			goto error_free;
 		}
 
-		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
+		new = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
+		if (!new) {
+			ret = -ENOMEM;
+			goto error_free;
+		}
+		tmp = new;
 		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
 			ret = -EINVAL;
 			goto error_free;
-- 
2.26.3

