Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B548CF0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiALXUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiALXUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:20:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801FCC06173F;
        Wed, 12 Jan 2022 15:20:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r28so7005700wrc.3;
        Wed, 12 Jan 2022 15:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZetsEggcZdDtvIjPQfbsaoX1aAbsURqAycl8u60wPc=;
        b=QiPlOCYzz/Afi5jyqbpliTey9a1ba0Gw+PfX7Gz9I5jPJfchYzAEMdwuSs5fwgiyla
         Nma1aLjBfrZ4L1MA91ynUGNmJLvtdwN04Mmm8jmLrEEkMIl5OvyEq67/8lRKVKgztmTe
         TRsMDFyWM/K4HrHcE8v4VwSg21tXdYXEq+WH4lRrWPN6wF0HiJ2lABoGZbDpmE8Xr+ep
         rHA8kp6G+LZPhAgiPeADqbJ1gW12d0a59/pVlW4iek9Q9s6/ZBAiPqpAM3Rndi/sALTi
         NmcfQu/xi0NgeIznj/AkpwQzOrWwyBUeviNF22XlqgKy2pOkqfqIICm7sOvKAqMASpBL
         hxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZetsEggcZdDtvIjPQfbsaoX1aAbsURqAycl8u60wPc=;
        b=Pi9X0pur6n4GRktNy9fDbP8A/uIcEU56OFC22MZK/WjlYz6lAyrsPixM4YCta6VfcQ
         FF8sXbeAiuPVVe+1qHGF0gAHWw5F/zwmZsuq8MLR25JdU0o8g9MNn5akhWpzzZdH+wjB
         B5U3ihxQoF7pe/Px/bXBbCANr8HEehKzyl3G0GF3eHHNJFEgk0Y3cDHKx9JCfW/Xp0VY
         c6Chrwe8ImDOYy0p1/teVbwd0kwDMUXhAJIRvgAjfUlwbKT+yjdtSKRfmETs+GDsoO4N
         g5jNPl6fYR3T+gBxASY2PrNzi775EstF5h/8E6S5yQ3l738nfMf7Z6GS0ljtnuVlicQa
         JtRg==
X-Gm-Message-State: AOAM5310vDYWHT9rNrywp6gEU/ccL2X8+ZDN2P38v+ipFdgANKD1Psgd
        GgjuFTSuEBsbFUz1n2zXD5Q=
X-Google-Smtp-Source: ABdhPJxqVabMtVcZhWSJ9raCaLAxk4HaOSfwpuc8+h9zSIMyHVxyFvF0t1vLFmXru6xvw/3inQWmVw==
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr1577287wry.41.1642029637059;
        Wed, 12 Jan 2022 15:20:37 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k10sm992328wrz.113.2022.01.12.15.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 15:20:36 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] drm/vc4: remove redundant assignment of variable size
Date:   Wed, 12 Jan 2022 23:20:36 +0000
Message-Id: <20220112232036.1182846-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'size' is being assigned a value that is never read,
the assignment is redundant and can be removed. Cleans up clang-scan
warning:

drivers/gpu/drm/vc4/vc4_bo.c:358:2: warning: Value stored to 'size'
is never read [deadcode.DeadStores]
        size = roundup(size, PAGE_SIZE);

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_bo.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 6d1281a343e9..e451cc5bcfac 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -355,8 +355,6 @@ static struct vc4_bo *vc4_bo_get_from_cache(struct drm_device *dev,
 	uint32_t page_index = bo_page_index(size);
 	struct vc4_bo *bo = NULL;
 
-	size = roundup(size, PAGE_SIZE);
-
 	mutex_lock(&vc4->bo_lock);
 	if (page_index >= vc4->bo_cache.size_list_size)
 		goto out;
-- 
2.33.1

