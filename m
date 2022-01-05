Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC7C4855FC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbiAEPha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241550AbiAEPhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:37:11 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A719DC061245;
        Wed,  5 Jan 2022 07:37:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f5so163669506edq.6;
        Wed, 05 Jan 2022 07:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IUKwGI9uAX6PYPoRB8Gc90h0oTgFN8Bu0rvMiUFNi5U=;
        b=IuI8aayf6o1krrqgG9a5vwEePOnTfQJSqNzjVMpcnIF62P887eUSC9vfNVM6sIRPPN
         4RoSlU2mO7p4Ik7kzXr1Q2VFdQFNmSXo857a4Bs8C29L0NM75oFStF38+vEJV7R6wx6t
         h1WLeYSapuQXxItef4iV/vX/VPCIj2MGWNqHqVKtmYqB7T/TxtcvGLvWJMVv4kb0jkOz
         VRFnnGce+rr7tK6i85H0e7uB7bTS/xLJY9k+zhyDTDeI2ONgsIoFL/21+jCCzqEF2Q6b
         RrDJwJfn/PF6NNLRV47IHRrVB8HSwI3MzxXNqM4/6FvGte589oARnjEBCmtcHXRkYHX7
         OD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IUKwGI9uAX6PYPoRB8Gc90h0oTgFN8Bu0rvMiUFNi5U=;
        b=6cwTmLcCeJruehL6ZCKpce8yXNsfUcF2Rm4RGlVFZAHeHzlfTNh/j9bkCjgtFng/Vw
         49YvOojqp5nXN2uFmuX9bqaQ/KJ2zZv+0hIC/c7V1DH08zXAC/A/4k5JRY/3rARqx2fZ
         dIZkQ+UlV+tIBS1Mp2bfhgjZ43oervuxKw1vTqvWWEydAwXyruWNqYIMG/xGfgCpt+2e
         F41V6ykaDq/mdOlxGOeP1cFo95QjcHdqjsdyuXhVRSA0Ub1YMSu1MqGKaY+vVb2Ic+OT
         6r4yXBnw+nrnRGwbD2S8c6ifC39Qer8UAiD0H8Iwj+IWSA6AV//8JWFOlhogqW9DbuW4
         Ak2w==
X-Gm-Message-State: AOAM533DnPUXa//RJO3Wy9XOAkfcrTL8+0v2ngHw7mYEvlPcT5ep16fk
        TRUQ0WHHBScXS4+LCrVYGLZF5F5Ti/E=
X-Google-Smtp-Source: ABdhPJy1fi1qZja7Sbk+Q2F5UOdV+lzqZVrjT3Y3y12frTUZVirNIov72AFlPPyZAuQDDMslXK9SMQ==
X-Received: by 2002:a50:fd9a:: with SMTP id o26mr14488918edt.199.1641397029323;
        Wed, 05 Jan 2022 07:37:09 -0800 (PST)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id d7sm307621edt.74.2022.01.05.07.37.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 07:37:08 -0800 (PST)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     tomba@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     openpvrsgx-devgroup@letux.org, merlijn@wizzup.org,
        philipp@uvos.xyz, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-omap@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] drm: omapdrm: Fix implicit dma_buf fencing
Date:   Wed,  5 Jan 2022 17:36:58 +0200
Message-Id: <1641397018-29872-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently omapdrm driver does not initialize dma_buf_export_info resv
member, which leads to a new dma_resv being allocated and attached to
the exported dma_buf. This leads to the issue that fences created on
dma_buf objects imported by other drivers are ignored by omapdrm, as only
fences in gem object resv are waited on. This leads to various issues like
displaying incomplete frames.

Fix that by initializing dma_buf resv to the resv of the gem object being
exported.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
index f1f93cabb61e..a111e5c91925 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
@@ -88,6 +88,7 @@ struct dma_buf *omap_gem_prime_export(struct drm_gem_object *obj, int flags)
 	exp_info.size = omap_gem_mmap_size(obj);
 	exp_info.flags = flags;
 	exp_info.priv = obj;
+	exp_info.resv = obj->resv;
 
 	return drm_gem_dmabuf_export(obj->dev, &exp_info);
 }
-- 
2.20.1

