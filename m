Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DC458F4E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiHJXa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiHJX3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:29:55 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724D583F33
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ciDPhF07fS+tRj3SbXyJWbm9upDSDTB8l7rbsGiPQ3k=; b=RkaB8hBq3/R/1OYWjtaZU64XCX
        3OmzaUdxiynm4exZuNrmc6p80Mw5Q6TYSSnSb/f1mTTaOmyzWraHCWxeISIq1a1ICOLOzZmlweG0o
        YOmSL381a0dVFwm5y1rNY8WU5GNzqwCjTruBEEV0GEyTjt4gRDE2hh+yRINWGSaTFlAi1r6sEUQBM
        DLld2kb46YIkOfVWUrCd61qLCINDWkePkLM9hWKCHeyfQMuPQ4RxM+rbHM2B8H7Lgj9+lvMGgr/nv
        B9KLN8qAnLDY6xslPCom9REx6WbYaVQXvAoCBquUIG8VXYXzipYvOf+Drhi1GLdT5TXFFv6zg5n1n
        qYTw7yMQ==;
Received: from [191.17.41.12] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oLv8x-004r9g-62; Thu, 11 Aug 2022 01:29:43 +0200
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
Subject: [PATCH v3 3/4] Documentation/gpu: Document GFXOFF's count and residency
Date:   Wed, 10 Aug 2022 20:28:57 -0300
Message-Id: <20220810232858.11844-4-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810232858.11844-1-andrealmeid@igalia.com>
References: <20220810232858.11844-1-andrealmeid@igalia.com>
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

Add documentation explaining those two new files.

While here, add a note about the value type.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 Documentation/gpu/amdgpu/thermal.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 997231b6adcf..5e27e4eb3959 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -72,7 +72,8 @@ card's RLC (RunList Controller) firmware powers off the gfx engine
 dynamically when there is no workload on gfx or compute pipes. GFXOFF is on by
 default on supported GPUs.
 
-Userspace can interact with GFXOFF through a debugfs interface:
+Userspace can interact with GFXOFF through a debugfs interface (all values in
+`uint32_t`, unless otherwise noted):
 
 ``amdgpu_gfxoff``
 -----------------
@@ -104,3 +105,18 @@ Read it to check current GFXOFF's status of a GPU::
 If GFXOFF is enabled, the value will be transitioning around [0, 3], always
 getting into 0 when possible. When it's disabled, it's always at 2. Returns
 ``-EINVAL`` if it's not supported.
+
+``amdgpu_gfxoff_count``
+-----------------------
+
+Read it to get the total GFXOFF entry count at the time of query since system
+power-up. The value is an `uint64_t` type, however, due to firmware limitations,
+it can currently overflow as an `uint32_t`. *Only supported in vangogh*
+
+``amdgpu_gfxoff_residency``
+---------------------------
+
+Write 1 to amdgpu_gfxoff_residency to start logging, and 0 to stop. Read it to
+get average GFXOFF residency % multiplied by 100 during the last logging
+interval. E.g. a value of 7854 means 78.54% of the time in the last logging
+interval the GPU was in GFXOFF mode. *Only supported in vangogh*
-- 
2.37.1

