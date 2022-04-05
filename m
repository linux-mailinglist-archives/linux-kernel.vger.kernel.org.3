Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C0C4F523B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849746AbiDFCkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574552AbiDEW4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:56:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA0197AC7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:38:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d5so724747lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 14:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bxKqK2XNY4gRVlPJC2xJqtnMP47aAtqK7bCRdORZQrc=;
        b=pPMhHD+MAeCOHNTEHA/NpfXCwZpLhzs4orOzrp/sfSfjhe/NVw9jqmSdaz70eZjqcR
         5o+2PV5F7QxxcmHTa8f6dNstumF3Bgv/gf8pWeNhL92TVdFP5PDHzDOoRJk5nLuBT0nS
         Jd1XoFDylIGl8besXC0b/wp9t8DBqdw1LRLz1HySjABgaPBfJls6Zszkyb83sFtIXLBl
         x7DLWhNpP05EDwn4zDvh3/5kTeSgrs/vR5QgrL0lKRUw9/WB6jSazvA40N5k1wEL+bJi
         2+PfQeE4zNpnRiCg30HJ7RKvxj6OZihDtemYYzyAROjixwHBVKJbKZ0wixHYaNKh9va7
         t1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bxKqK2XNY4gRVlPJC2xJqtnMP47aAtqK7bCRdORZQrc=;
        b=U9lYH06mwrFiAZGcsYaee154v5EbWZoXRGtyx+q+YVyWAfgkTqQAMSvRSVYyL2972+
         av1fhLhPxh2Oa8rBat634EmLoGeI6EralTgRUJwjuWwCNoneSJYgcaCjLapQZFKljveP
         38IBr1pWBApWSNuUtazE6EhETBEDlfSNnHxjhoQM8hc4euTTaw+28UOEsh2UbFnZHISO
         hsslbAHk4d4SXw2CQfUbx5CuIZm7Dj85VMtSIgOL+sULrxM3xTZ1fnRBx6ZWxPmu1izD
         krd2WO0fk9t2Vrii6vq8ajFb0yLU+diJ4vQPzkKtWeEajqtmViB76RKQGlUPY7afcNlS
         zGZA==
X-Gm-Message-State: AOAM5309FKTpCN09j2hqngSlQssM8HYpDzaHnGu0e1sYfrtKWGQZZEUB
        Ng0RgPelwpwI+oSwTnL/GJqaXLY8xCiOIw==
X-Google-Smtp-Source: ABdhPJzRzL5AGzm3x9i2e6gg3GsjIDzn3cmvURvQmjY6sxRLiGWhAVY1LXX59+ePvChm1x9/n+eryg==
X-Received: by 2002:a05:6512:3d8e:b0:44a:3ad1:8bae with SMTP id k14-20020a0565123d8e00b0044a3ad18baemr3806975lfv.231.1649194682658;
        Tue, 05 Apr 2022 14:38:02 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:226e:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id v17-20020a2e7a11000000b0024b127cfc2bsm1033175ljc.127.2022.04.05.14.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:38:02 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guchun Chen <guchun.chen@amd.com>,
        Joseph Greathouse <Joseph.Greathouse@amd.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Unnecessary code in gfx_v7_0.c
Date:   Wed,  6 Apr 2022 00:37:59 +0300
Message-Id: <20220405213800.90205-1-h0tc0d3@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is useless and doesn't change the value.

(0 << GB_ADDR_CONFIG__ROW_SIZE__SHIFT) = 0
gb_addr_config | 0 = gb_addr_config

Perhaps there could be 1 instead of 0, but this does not correspond with
the logic of the switch.

Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 1cb5db17d2b9..5ed84a6467ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4409,16 +4409,14 @@ static void gfx_v7_0_gpu_early_init(struct amdgpu_device *adev)
 	/* fix up row size */
 	gb_addr_config &= ~GB_ADDR_CONFIG__ROW_SIZE_MASK;
 	switch (adev->gfx.config.mem_row_size_in_kb) {
-	case 1:
-	default:
-		gb_addr_config |= (0 << GB_ADDR_CONFIG__ROW_SIZE__SHIFT);
-		break;
 	case 2:
 		gb_addr_config |= (1 << GB_ADDR_CONFIG__ROW_SIZE__SHIFT);
 		break;
 	case 4:
 		gb_addr_config |= (2 << GB_ADDR_CONFIG__ROW_SIZE__SHIFT);
 		break;
+	default:
+		break;
 	}
 	adev->gfx.config.gb_addr_config = gb_addr_config;
 }
-- 
2.35.1

