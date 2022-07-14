Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E55755B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiGNTSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGNTST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:18:19 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC57D42ADC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4hMXKYb5oQeNCFz0c5Kq84rZ4yBy2gy1pD+jGE3P3t0=; b=hzGt9vhXedFNIhMMyzDtltnFsN
        qHJGD1K/NmIpjvwDfx37/4PDdhVGGOYopt0A1BpHCQTMapNn6BBaNKMWNOzptlfLiaqXTOWIgcrnY
        SQ/6ExW/Nwtao3frIJqaWQQeG8suwTLA/l7BwenxaEJ7LPzYRazspQJ1fAJtvUToQBwFzLGMLn3hp
        ktgfgSwR8Vr6wqwrfHvGtwtvEhyuzpZYW6PpEHNL2srhziFui0utvITAiMzyFjSFl8fk++kJWrpUB
        pjR11wBisDiyG3U372KUOBEvfc8ewyv6sVSlL2ZFMd17BXuySIu/QPaq9o7v27xsJfgcDQ4/Yg8nU
        lXGGfS1w==;
Received: from [177.139.47.106] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oC4Ll-00Gla6-1q; Thu, 14 Jul 2022 21:18:13 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
        'Pan Xinhui' <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom St Denis <tom.stdenis@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     kernel-dev@igalia.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 1/2] drm/amd/debugfs: Expose GFXOFF state to userspace
Date:   Thu, 14 Jul 2022 16:17:44 -0300
Message-Id: <20220714191745.45512-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GFXOFF has two different "state" values: one to define if the GPU is
allowed/disallowed to enter GFXOFF, usually called state; and another
one to define if currently GFXOFF is being used, usually called status.
Even when GFXOFF is allowed, GPU firmware can decide to not used it
accordingly to the GPU load.

Userspace can allow/disallow GPUs to enter into GFXOFF via debugfs. The
kernel maintains a counter of requests for GFXOFF (gfx_off_req_count)
that should be decreased to allow GFXOFF and increased to disallow.

The issue with this interface is that userspace can't be sure if GFXOFF
is currently allowed. Even by checking amdgpu_gfxoff file, one might get
an ambiguous 2, that means that GPU is currently out of GFXOFF, but that
can be either because it's currently disallowed or because it's allowed
but given the current GPU load it's enabled. Then, userspace needs to
rely on the fact that GFXOFF is enabled by default on boot and to track
this information.

To make userspace life easier and GFXOFF more reliable, return the
current state of GFXOFF to userspace when reading amdgpu_gfxoff with the
same semantics of writing: 0 means not allowed, not 0 means allowed.

Expose the current status of GFXOFF through a new file,
amdgpu_gfxoff_status.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v1: none

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 49 ++++++++++++++++++++-
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f3b3c688e4e7..e2eec985adb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1117,13 +1117,50 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
 	}
 
 	while (size) {
-		uint32_t value;
+		u32 value = adev->gfx.gfx_off_state;
+
+		r = put_user(value, (u32 *)buf);
+		if (r)
+			goto out;
+
+		result += 4;
+		buf += 4;
+		*pos += 4;
+		size -= 4;
+	}
+
+	r = result;
+out:
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
+	return r;
+}
+
+static ssize_t amdgpu_debugfs_gfxoff_status_read(struct file *f, char __user *buf,
+						 size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = file_inode(f)->i_private;
+	ssize_t result = 0;
+	int r;
+
+	if (size & 0x3 || *pos & 0x3)
+		return -EINVAL;
+
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	while (size) {
+		u32 value;
 
 		r = amdgpu_get_gfx_off_status(adev, &value);
 		if (r)
 			goto out;
 
-		r = put_user(value, (uint32_t *)buf);
+		r = put_user(value, (u32 *)buf);
 		if (r)
 			goto out;
 
@@ -1206,6 +1243,12 @@ static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
 	.llseek = default_llseek
 };
 
+static const struct file_operations amdgpu_debugfs_gfxoff_status_fops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_debugfs_gfxoff_status_read,
+	.llseek = default_llseek
+};
+
 static const struct file_operations *debugfs_regs[] = {
 	&amdgpu_debugfs_regs_fops,
 	&amdgpu_debugfs_regs2_fops,
@@ -1217,6 +1260,7 @@ static const struct file_operations *debugfs_regs[] = {
 	&amdgpu_debugfs_wave_fops,
 	&amdgpu_debugfs_gpr_fops,
 	&amdgpu_debugfs_gfxoff_fops,
+	&amdgpu_debugfs_gfxoff_status_fops,
 };
 
 static const char *debugfs_regs_names[] = {
@@ -1230,6 +1274,7 @@ static const char *debugfs_regs_names[] = {
 	"amdgpu_wave",
 	"amdgpu_gpr",
 	"amdgpu_gfxoff",
+	"amdgpu_gfxoff_status",
 };
 
 /**
-- 
2.37.0

