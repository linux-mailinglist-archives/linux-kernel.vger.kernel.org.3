Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A844A7A98
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347697AbiBBVnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiBBVnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:43:04 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625CC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:43:04 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id e81so917658oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3C86wM4RRIil8SxMQCDDt7pq/c7kC+1ToUwcaauhcY=;
        b=bcf0lTZn99V9oVeN3ea94gI1jVOL8i6cIyNZAtSXBbrZbPkj8NiwExPSavIGezwB08
         Yt2kEnAKIfK+aMT4IMo13Lf2CI613trgWsAu4Xz7yme4kxZTHYcGto0WkIrYeqeJ2paT
         28Laff0Gxkao9X+felx3/7XAyw5d+vPztBfK2aBiCnNS2KLhhgYku9YK3wc5FwDD98aI
         GuRSCHSGpXjmhiq+79D/+vguYkybVKv6rM+Qmswkz29/ARg/whzqyxkQIqtY90nsJCB9
         ewRk0pOkfGjjbCxd9KVqKUXTYPjmxbargNak9k85YpPdHIQKt+5zr5g+F5J4deC7ebCm
         wG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3C86wM4RRIil8SxMQCDDt7pq/c7kC+1ToUwcaauhcY=;
        b=dAPtpZ/QgE9eP8vSpegOX/hFMXnNFz36x0pTb1GjyXcaGCeGnf7wBLGoJnV33gahzN
         PoaqVeupmmSn3CDlYB49gDY07v59yRtNlb1Wjw55dZoi+cD5kP+nhq6D+XIEW5P0FAq8
         G4ooxLyD3QH1P5XDWSAcxhr1QbXK4Ux0kljEhezi8yoTzwynZMJLedeJURgwnSm0lXdQ
         spHk1jP6MZnzklvjV8CmVrkbL6yjFbHOXVJd4aTwjuIaYL9mZd63XLmiuk3bIByd9ydA
         N3KiTgVKsGCjSJQ1nugVCAJskYL+VOCNnXu1HyF4SaIcsMTKk8PC6lIGCr5+sxpdpImD
         Yfkg==
X-Gm-Message-State: AOAM532HUKCOsOIhFj15WJzzFbh68lQVJ0R1PrfFXcyBUxn1bJENKNql
        ht3NrcUdgmKuYmoYO+Ywlbo=
X-Google-Smtp-Source: ABdhPJxX0n9uNpXvgGpEUqJyCL3sYTi8+QyGIJtIaJ57BLSpqMGEySXmBI0EIFOhg4b3VrVTjkeuvw==
X-Received: by 2002:a05:6808:10ce:: with SMTP id s14mr1474773ois.164.1643838183932;
        Wed, 02 Feb 2022 13:43:03 -0800 (PST)
Received: from magali.lan ([191.181.56.252])
        by smtp.gmail.com with ESMTPSA id y15sm11701268oof.37.2022.02.02.13.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:43:03 -0800 (PST)
From:   Magali Lemes <magalilemes00@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     Magali Lemes <magalilemes00@gmail.com>,
        kernel test robot <lkp@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Use NULL pointer instead of plain integer
Date:   Wed,  2 Feb 2022 18:38:56 -0300
Message-Id: <20220202213856.409403-1-magalilemes00@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assigning 0L to a pointer variable caused the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/rc_calc_fpu.c:71:40:
warning: Using plain integer as NULL pointer

In order to remove this warning, this commit assigns a NULL pointer to
the pointer variable that caused this issue.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
index ec636d06e18c..ef75eb7d5adc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
@@ -68,7 +68,7 @@ static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
 	int sel = table_hash(mode, bpc, max_min);
 	int table_size = 0;
 	int index;
-	const struct qp_entry *table = 0L;
+	const struct qp_entry *table = NULL;
 
 	// alias enum
 	enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
-- 
2.25.1

