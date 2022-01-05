Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F60348523E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbiAEME6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiAEMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:04:48 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0486BC061799
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 04:04:48 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t123so34976958pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 04:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=wZQVYKA/l1SV8AWz433qKhWKOkbVbgPv85MCDpXpzDk=;
        b=JdOS4h2mHactNft1+fa4HuzLmVEk9WpOntlE3igFnvGIMjpOjcXZYDb7OErXUf6rtI
         iMGPeW1wGazBneBHZZRUdSWhvlbOTjOyaFdkbmDEshZKP+yHTypC/+kzJj/3C0ycKioB
         sB9yikZB0nWJuojd1I9IW+YV/RpAmHqaplxsh0djpSXj98QtFfJLNne+xSsN+i0h9RIK
         pNH1393cOyhch4JImiNmBXfY9TATzSzAEQKdtfdVeW6+VppJhsYPAzh5R6zuNWdCiOfF
         sWjx5W9sN4UzzadMbNyRAdFTPeAvhsWWeBwT8CwWtXhHyoUJQNfCBb9bLBmspja773cV
         kqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wZQVYKA/l1SV8AWz433qKhWKOkbVbgPv85MCDpXpzDk=;
        b=p7i3oIjSOICM6i31M6WLU7Qc1i0yQ8OsFnGkXREZ6BQJJz8K6oLiF9i5A4svn4r4JD
         ym9vvTHNpK2YNuCJFkYF7GtdmcPWO66O+o5c9aWSd2mFyPETXRXQpdrjM50ADGddNFl9
         tU3LMvPX+W3UksjFCfVZGLzoS+EhDf/bmCKKR1IrtD0HFyHIJuiOICdhfTV9GFi+wICc
         Y999gTasxr68nriu1eM87BR/PS53EAdwIOm15p1uxhnSw54xtpGa1nHEFIJBSjbrxJ8A
         7Odcj7gNkZIbcU1GbmH+FDxo05BY1rpaYSj5rGYqzCdrzTse0q98l7xwVDq+8yrjF2fK
         XpGQ==
X-Gm-Message-State: AOAM531LpoiI21KnN2LocTbjFfu5nDguTVjRu57FQqRwo1AjLMBr35/F
        9JddoVyq8vluTm1s0BbTUVthK0jxIrkyNQ==
X-Google-Smtp-Source: ABdhPJybLgZfdzb84PU0vel94N2UrQNfmRkVoJUvOqo81/mOUSfSO9R+DVoIcNpHEKXN4IWaZi5utQ==
X-Received: by 2002:a63:935e:: with SMTP id w30mr37822635pgm.342.1641384287576;
        Wed, 05 Jan 2022 04:04:47 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 204sm26701428pfy.207.2022.01.05.04.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 04:04:47 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/v3d: Fix PM disable depth imbalance in v3d_platform_drm_probe
Date:   Wed,  5 Jan 2022 12:04:42 +0000
Message-Id: <20220105120442.14418-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: 57692c9 ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index bd46396a1ae0..4f293aa733b8 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -300,6 +300,8 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	v3d_gem_destroy(drm);
 dma_free:
 	dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
+pm_disable:
+	pm_runtime_disable(dev);
 	return ret;
 }
 
-- 
2.17.1

