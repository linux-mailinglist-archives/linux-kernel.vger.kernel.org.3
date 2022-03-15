Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6B74DA3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351667AbiCOU0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiCOU0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:26:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351201EC59;
        Tue, 15 Mar 2022 13:24:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x13so198898wrg.4;
        Tue, 15 Mar 2022 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLLTqIhVx97asbYPr4Ba30RhGW0/k9gGUJ6yMqUQca8=;
        b=HGVwT2u8w1di/2Ba6Mr3uF7wANvgMQhwksp2VCgHGD+YHZd2YNQFvthoW0aL1i+eUW
         Ut+47rb5iS6ZjVGYKl2VEeLBQBkEs0iwXXdh6PwbjyICixDvwj0+2y6GSgtdUAIsve/K
         Y1u/+x3hCOFHzjtISdWRQnfcaRJHy1R3n3I8jaNS8pqfX+EFIpDL3ZyF/dR8mnWyTSFa
         9gwxCf5RcGXqMHGEWNpB1V1Eb1DvqizTGVwm9nggVh2QjXqGLhyWVkGBzGLAJ7W79MB+
         d8Z7AKgHVKJ/vLT0PSkxbR/zwLHNXat10jflfoOOXA2Ppjcb3X0gT2rqdevVVOXxRDt6
         0ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLLTqIhVx97asbYPr4Ba30RhGW0/k9gGUJ6yMqUQca8=;
        b=pBdtkWjV/UwKNwsQxvxb1goUTvVFX+WJQj2PTXIoZcDaU5u+hC2NQFT8nMRGPuY9Xa
         C2g6rxpehQB5hcFedmyHoG4V/f2/fYq0H4YU3f4bNGHwQY31DXNGp5zGfebj3FCXnFlk
         +rHWfX2qUxDTUD0pyl82KaoXvA1OTSvVd9Ak7ySCK1Lku1zI27IH6SYbHhhWTuneqSaJ
         KaUMMBT1WdMYkeevUsuc5ENNyo4vra8e1XFYnzddvQjeeMtI26Cqb4Ld9NVgOjXsX9LS
         o4fI9y96Z/Oqwxz5gXQ8Q1yFnEB6qsgvQAUJJk14UuyjX6fCcw8kXWX+jaIgnq/tOWj3
         Q4mA==
X-Gm-Message-State: AOAM531gaunSLWy1X5W+4ILLqayiT7T67zOCyntyW2fukvRR5Jwvew1X
        NgIbSLSQVMaucxk2ihP74EClvhcPEp7aZw==
X-Google-Smtp-Source: ABdhPJxhdTXqW/kPnVuI531rJ1j83VzktKMWxWPNmL/em2OL4k0Zaihe+NRG+blq1ChVnZ991OdzQA==
X-Received: by 2002:a5d:6d86:0:b0:1f1:f938:6626 with SMTP id l6-20020a5d6d86000000b001f1f9386626mr21184356wrs.701.1647375890836;
        Tue, 15 Mar 2022 13:24:50 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0020294da2b42sm24801116wrn.117.2022.03.15.13.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:24:50 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/reg: Fix spelling mistake "Unsupport" -> "Unsupported"
Date:   Tue, 15 Mar 2022 20:24:49 +0000
Message-Id: <20220315202449.2952845-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a gvt_vgpu_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/gvt/handlers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index 520a7e1942f3..a01e3a893e24 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -914,7 +914,7 @@ static int update_fdi_rx_iir_status(struct intel_vgpu *vgpu,
 	else if (FDI_RX_IMR_TO_PIPE(offset) != INVALID_INDEX)
 		index = FDI_RX_IMR_TO_PIPE(offset);
 	else {
-		gvt_vgpu_err("Unsupport registers %x\n", offset);
+		gvt_vgpu_err("Unsupported registers %x\n", offset);
 		return -EINVAL;
 	}
 
-- 
2.35.1

