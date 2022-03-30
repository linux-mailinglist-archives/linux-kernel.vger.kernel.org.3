Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6864EC32A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344791AbiC3MUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347312AbiC3MGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:06:11 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E16432
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w7so15813239pfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mw0Xb3acT/jJngaoGEDh96qavNQRf5DbODEg2Ia3G20=;
        b=j6tRbHGh4PwL7QVNwVCLvVVrcrP+486cq3+/B0xQQu2bAJsOtuKDqRaidYYvWi8QiJ
         9EBrPA+wjyOnufhmgXp/tCoEIh6VuWtCqEFwoSgY1CBncvyGFo9i+MZjB3+4aGb0rGGO
         g/6gkLtPfHVx/nmbA1pOqMUqcXQ/XnRC6opt0Y6pe3t+W/SBvFPGxGPWP1xXk1kcUjJm
         cRGYrS8ElkYE0UHThjswLXBZLSQQhtflN0tCC5ZbPDWpKOgvbfieOitc+xecRpvTo9QK
         8RRWp9rlO2FSN+AoX9nuBUIwGA+flgagxlgF12DgERG2eEJtR/zbLyUS2hZ1ei1CPreK
         SuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mw0Xb3acT/jJngaoGEDh96qavNQRf5DbODEg2Ia3G20=;
        b=wGU9W7A+sOpP2nPXg5XJm1vBFpdRbG60i5BZDUxjnnYnrbTDziyAWNU2fCfNiGelAT
         ZdJotmCsqZzEVRw7H/gIyOR12OgKYYnnJ5rkXiwOxoDqvhN9IfUGDPtL3LDi1mc87g/3
         xrEs21TE1+rQLFKkV2AAi/nCn1shsOjO/I7wU6C6HRzSYlIWZbcnlNbYNkG6ET0+yP0j
         CIDtjCjYYo2TtERmWVmkRjsQcluazL6JgyW9Xp7kiuPPVpOt4thDJnCu4oeDsaLfCSI9
         E4J8rXcccENwKgqZxo3wSuIxLkvj7D3Dov9Zag8Y4ZMs675KPW4rY/FvkGAFnw4+tnBq
         trRQ==
X-Gm-Message-State: AOAM530LcQeacShpf5kQ87IZ9Z8Bcn2bmzM5ofYZJZipbV5qU/QterzN
        /RmHghLjw1OIB+l+0wAi99s=
X-Google-Smtp-Source: ABdhPJwEBM261hXljDs2qeFIV354BPd5l2EbtG6IRonEl0apDdH4VGgubhpJfsdQJ9mYtScoLWW0BA==
X-Received: by 2002:aa7:8211:0:b0:4f7:8b7:239b with SMTP id k17-20020aa78211000000b004f708b7239bmr32372071pfi.64.1648641811381;
        Wed, 30 Mar 2022 05:03:31 -0700 (PDT)
Received: from localhost ([119.3.119.18])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm6446120pjb.16.2022.03.30.05.03.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 05:03:30 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     rob@ti.com, yakui.zhao@intel.com, airlied@redhat.com,
        alan@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH 4/5] gma500: fix a missing break in cdv_intel_dp_set_m_n
Date:   Wed, 30 Mar 2022 20:02:45 +0800
Message-Id: <20220330120246.25580-5-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330120246.25580-1-xiam0nd.tong@gmail.com>
References: <20220330120246.25580-1-xiam0nd.tong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of exiting the loop as expected when an entry is found, the
list_for_each_entry() continues until the traversal is complete. It
could lead to a invalid reference to 'lane_count/bpp' after the loop.

The invalid reference to 'lane_count/bpp' is here:
	cdv_intel_dp_compute_m_n(bpp, lane_count,

To fix this, when found the entry, add a break after the switch statement.

Fixes: 8695b61294356 ("gma500: Add the support of display port on CDV")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index ba6ad1466374..e6473b8da296 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -1016,6 +1016,8 @@ cdv_intel_dp_set_m_n(struct drm_crtc *crtc, struct drm_display_mode *mode,
 			bpp = dev_priv->edp.bpp;
 			break;
 		}
+
+		break;
 	}
 
 	/*
-- 
2.17.1

