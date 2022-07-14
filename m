Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BFB5755BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiGNTS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbiGNTSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:18:25 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DC943E58
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wlMwv2W7GppNW4+mdMkQLIwBGJUS+zaRkk+Q+NpsBjg=; b=ktpMXb04Vk8Tfpp5vf51DoeBMR
        5T/ukhWs+mpvQfTnfPSEGggnRMv7k/v9wOpIkVdJcb9CgyDrOnLF2WRSySYYr3fVfIRlpkjzW9w42
        S8xvj2gKSCt69MaSqeNfHbMgV0t/bp10LOZOpM7CWfOIKETnLapjKL1omBmK2E8T8AktAurILQ+zz
        heV45xARt+ucMwBLnJpaNxi3ynM6P5VlEBVU5ygkH46qJv0up6QM1lcKS36U7T3CyeF5Jni0TumC5
        ZE+WJ9Q7APe+qCI3JYl3Fho91/CmxeThqMdO44RnGwyTdZNfYm1F8toarDxhKIj+m100jfvCn+Oyg
        bL6Q2Iug==;
Received: from [177.139.47.106] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oC4Ls-00Gla6-AH; Thu, 14 Jul 2022 21:18:20 +0200
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
Subject: [PATCH v2 2/2] Documentation/gpu: Add GFXOFF section
Date:   Thu, 14 Jul 2022 16:17:45 -0300
Message-Id: <20220714191745.45512-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220714191745.45512-1-andrealmeid@igalia.com>
References: <20220714191745.45512-1-andrealmeid@igalia.com>
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

Add a GFXOFF section at "GPU Power Controls" file, explaining what it is
and how userspace can interact with it.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v1: file created

 Documentation/gpu/amdgpu/thermal.rst | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 8aeb0186c9ef..14c0fb874cf6 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -63,3 +63,44 @@ gpu_metrics
 
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: gpu_metrics
+
+GFXOFF
+======
+
+GFXOFF is a feature found in some mobile GPUs that saves power consumption. The
+card's firmware uses RLC (RunList Controller) to power off the gfx engine
+dynamically when there is no workload on gfx pipe and puts gfx into "idle"
+state. GFXOFF is on by default on supported GPUs.
+
+Userspace can interact with GFXOFF through a debugfs interface:
+
+``amdgpu_gfxoff``
+-----------------
+
+Use it to enable/disable GFXOFF, and to check if it's current enabled/disabled::
+
+  $ xxd -l1 -p /sys/kernel/debug/dri/0/amdgpu_gfxoff
+  01
+
+- Write 0 to disable it, and 1 to enable it.
+- Read 0 means it's disabled, 1 it's enabled.
+
+If it's enabled, that means that the GPU is free to enter into GFXOFF mode as
+needed. Disabled means that it will never enter GFXOFF mode.
+
+``amdgpu_gfxoff_status``
+------------------------
+
+Read it to check current GFXOFF's status of a GPU::
+
+  $ xxd -l1 -p /sys/kernel/debug/dri/0/amdgpu_gfxoff_status
+  02
+
+- 0: GPU is in GFXOFF state, the gfx engine is powered down.
+- 1: Transition out of GFXOFF state
+- 2: Not in GFXOFF state
+- 3: Transition into GFXOFF state
+
+If GFXOFF is enabled, the value will be transitioning around [0, 3], always
+getting into 0 when possible. When it's disabled, it's always at 2. Returns
+``-EINVAL`` if it's not supported.
-- 
2.37.0

