Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F6C4D02FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbiCGPd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243812AbiCGPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:33:49 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07665403D1;
        Mon,  7 Mar 2022 07:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646667173; x=1678203173;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gsmx9JsR+nCJ1tL1LopmQSPZOhGLxmtw74vFEai5lBE=;
  b=h5dj0Vv9gfNotDjru9MdDRnenfhEOhcnjSHGQ8pH8HaEICjN3KH5h9de
   T3Q9lNJbjX84cD6mEAwSOxOXeIo+WzucdhjgAc02RvhXbkvyIThhF3t7A
   vWTftTVlRAh7QhiVxJ6JoaK39Emy6Hrt5QUZDfC8rAiWeE+clZpkU/nZC
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Mar 2022 07:32:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 07:32:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Mar 2022 07:32:51 -0800
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Mar 2022 07:32:50 -0800
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <corbet@lwn.net>
CC:     <pekka.paalanen@collabora.com>, <dri-devel@lists.freedesktop.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [RESEND PATCH] drm/doc: Clarify what ioctls can be used on render nodes
Date:   Mon, 7 Mar 2022 08:32:36 -0700
Message-ID: <1646667156-16366-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for render nodes indicates that only "PRIME-related"
ioctls are valid on render nodes, but the documentation does not clarify
what that means.  If the reader is not familiar with PRIME, they may
beleive this to be only the ioctls with "PRIME" in the name and not other
ioctls such as set of syncobj ioctls.  Clarify the situation for the
reader by referencing where the reader will find a current list of valid
ioctls.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---

I was confused by this when reading the documentation.  Now that I have
figured out what the documentation means, I would like to add a clarification
for the next reader which would have helped me.

 Documentation/gpu/drm-uapi.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 199afb5..ce47b42 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -148,7 +148,9 @@ clients together with the legacy drmAuth authentication procedure.
 If a driver advertises render node support, DRM core will create a
 separate render node called renderD<num>. There will be one render node
 per device. No ioctls except PRIME-related ioctls will be allowed on
-this node. Especially GEM_OPEN will be explicitly prohibited. Render
+this node. Especially GEM_OPEN will be explicitly prohibited. For a
+complete list of driver-independent ioctls that can be used on render
+nodes, see the ioctls marked DRM_RENDER_ALLOW in drm_ioctl.c  Render
 nodes are designed to avoid the buffer-leaks, which occur if clients
 guess the flink names or mmap offsets on the legacy interface.
 Additionally to this basic interface, drivers must mark their
-- 
2.7.4

