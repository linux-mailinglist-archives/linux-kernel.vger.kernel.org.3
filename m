Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3075154E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380078AbiD2T5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiD2T5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 438C928E2C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651262070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nORssVNFSPGiam+YA0wQPxcM033zLAladfHr6fH3pgg=;
        b=TW11FjojLoApI2YcVnpYykYL9QMg48RBZuL1SUGU1KVfREn4i14L4R0jG097n7VgchBTyY
        bykvwXGs+XYj6rcgVp3mkGZBgVQiJcgtjsjQT50zgM42wLBQ4k7dXiPDwsVBTLDc1RyTUm
        rBPDqtHEHZIddrZ04ofwcTE7MtZVIFE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-hizdAN70OnGH8m37kkElmw-1; Fri, 29 Apr 2022 15:54:26 -0400
X-MC-Unique: hizdAN70OnGH8m37kkElmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 346B183395E;
        Fri, 29 Apr 2022 19:54:26 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.16.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF2B2166B4D;
        Fri, 29 Apr 2022 19:54:22 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/nouveau/subdev/bus: Ratelimit logging for fault errors
Date:   Fri, 29 Apr 2022 15:53:47 -0400
Message-Id: <20220429195350.85620-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's plenty of ways to fudge the GPU when developing on nouveau by
mistake, some of which can result in nouveau seriously spamming dmesg with
fault errors. This can be somewhat annoying, as it can quickly overrun the
message buffer (or your terminal emulator's buffer) and get rid of actually
useful feedback from the driver. While working on my new atomic only MST
branch, I ran into this issue a couple of times.

So, let's fix this by adding nvkm_error_ratelimited(), and using it to
ratelimit errors from faults. This should be fine for developers, since
it's nearly always only the first few faults that we care about seeing.
Plus, you can turn off rate limiting in the kernel if you really need to.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h |  2 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c    | 14 +++++++-------
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c     |  6 +++---
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c     |  6 +++---
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
index 1665738948fb..96113c8bee8c 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
@@ -62,4 +62,6 @@ void nvkm_subdev_intr(struct nvkm_subdev *);
 #define nvkm_debug(s,f,a...) nvkm_printk((s), DEBUG,   info, f, ##a)
 #define nvkm_trace(s,f,a...) nvkm_printk((s), TRACE,   info, f, ##a)
 #define nvkm_spam(s,f,a...)  nvkm_printk((s),  SPAM,    dbg, f, ##a)
+
+#define nvkm_error_ratelimited(s,f,a...) nvkm_printk((s), ERROR, err_ratelimited, f, ##a)
 #endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
index 53a6651ac225..80b5aaceeaad 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
@@ -35,13 +35,13 @@ gf100_bus_intr(struct nvkm_bus *bus)
 		u32 addr = nvkm_rd32(device, 0x009084);
 		u32 data = nvkm_rd32(device, 0x009088);
 
-		nvkm_error(subdev,
-			   "MMIO %s of %08x FAULT at %06x [ %s%s%s]\n",
-			   (addr & 0x00000002) ? "write" : "read", data,
-			   (addr & 0x00fffffc),
-			   (stat & 0x00000002) ? "!ENGINE " : "",
-			   (stat & 0x00000004) ? "PRIVRING " : "",
-			   (stat & 0x00000008) ? "TIMEOUT " : "");
+		nvkm_error_ratelimited(subdev,
+				       "MMIO %s of %08x FAULT at %06x [ %s%s%s]\n",
+				       (addr & 0x00000002) ? "write" : "read", data,
+				       (addr & 0x00fffffc),
+				       (stat & 0x00000002) ? "!ENGINE " : "",
+				       (stat & 0x00000004) ? "PRIVRING " : "",
+				       (stat & 0x00000008) ? "TIMEOUT " : "");
 
 		nvkm_wr32(device, 0x009084, 0x00000000);
 		nvkm_wr32(device, 0x001100, (stat & 0x0000000e));
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
index ad8da523bb22..c75e463f3501 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
@@ -45,9 +45,9 @@ nv31_bus_intr(struct nvkm_bus *bus)
 		u32 addr = nvkm_rd32(device, 0x009084);
 		u32 data = nvkm_rd32(device, 0x009088);
 
-		nvkm_error(subdev, "MMIO %s of %08x FAULT at %06x\n",
-			   (addr & 0x00000002) ? "write" : "read", data,
-			   (addr & 0x00fffffc));
+		nvkm_error_ratelimited(subdev, "MMIO %s of %08x FAULT at %06x\n",
+				       (addr & 0x00000002) ? "write" : "read", data,
+				       (addr & 0x00fffffc));
 
 		stat &= ~0x00000008;
 		nvkm_wr32(device, 0x001100, 0x00000008);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
index 3a1e45adeedc..2055d0b100d3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
@@ -60,9 +60,9 @@ nv50_bus_intr(struct nvkm_bus *bus)
 		u32 addr = nvkm_rd32(device, 0x009084);
 		u32 data = nvkm_rd32(device, 0x009088);
 
-		nvkm_error(subdev, "MMIO %s of %08x FAULT at %06x\n",
-			   (addr & 0x00000002) ? "write" : "read", data,
-			   (addr & 0x00fffffc));
+		nvkm_error_ratelimited(subdev, "MMIO %s of %08x FAULT at %06x\n",
+				       (addr & 0x00000002) ? "write" : "read", data,
+				       (addr & 0x00fffffc));
 
 		stat &= ~0x00000008;
 		nvkm_wr32(device, 0x001100, 0x00000008);
-- 
2.35.1

