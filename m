Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B990C46CE7C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbhLHHuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLHHuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:50:00 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8820C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 23:46:28 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p18so978070plf.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 23:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtweuKbs2MfZWpt5xIw7VULyGKHm7TbvXq2wNntSpHI=;
        b=gdVTOE/ai17mTSNNToyDWKlCUDe3++Fiq5333dNqaAZWFllNV6wdTeIwHnGFpLcNt6
         mo9untbxCaZANNouIWrm0+XYHyL7jbUDZbD7Z96FckR9nrlspVLyrQdmcYJvxcQyiz0t
         xMbllJcj+WLCGpADoGyoXZLghlq/OFM5MI+CADL4EvoS0KI657CePJDMpuhVEsduyZIw
         sIhM4sloq0D5x/XO7VRtzoe9bQ65XQ3UyOkr6/bZ8EUhjso6F6RDnDzJA6qANE0s/gCU
         zrmoCq8PTAP4gxW6+kzQmoAsl/Za+ZMHvzw8ZtqGEGAmMUjXj0ZLaArx9A7Ga+VI3G/L
         wXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtweuKbs2MfZWpt5xIw7VULyGKHm7TbvXq2wNntSpHI=;
        b=FeOXUDhxo3T6tvNARv1zmC+E6x0/pAKpToM1mzxquCyAoau7lTVDavmWPkAdY6ytVs
         7/yxbva/kSIcum0vYaAVSni7cgTWeMnQR513Fuo5Uuwi7DX7Rspq/0vbBTJJy8fcRfzI
         zW3esYnpREksMw5fvfpAS9+eJ6W19PiiQM/Rt7A2IgcdB4Q9ws5vEKrQ5QzygXD1xDQu
         qIKF75n6K8IfmP97EjtVqXoJ4gNfk6w2v/OatSFz55HtlQQN5m6L/jgWMYhAU/wnJeAT
         WLRUKz8I/ZL7WWRvbspzzO3W6MTMSfhn7efag504PBkUUTA7kH3ZMxtvCwNVS0Wn6IgR
         2mUg==
X-Gm-Message-State: AOAM530zUvRuzuDVNvw0Wely8dNLE6elK6UqeH/FKU7+XVLoMaPmJ86W
        dO1RsW0Mc/oJ81VXllR35cBlaGDV3Ck=
X-Google-Smtp-Source: ABdhPJxLWUdY5+jg/o/MLuMbGm2XLR0ZC+WwijUBNG7QGGTXHMPXPQn3tyTHWqsMJ0cS3qdtZXeTXg==
X-Received: by 2002:a17:90a:e016:: with SMTP id u22mr5113888pjy.95.1638949588555;
        Tue, 07 Dec 2021 23:46:28 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j16sm1673681pga.32.2021.12.07.23.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 23:46:28 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/i915/display: Delete redundant post_mask assignment
Date:   Wed,  8 Dec 2021 07:46:19 +0000
Message-Id: <20211208074619.404138-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

This value will be overwritten by the following if statement, even
if the if is not executed, the value will not be used

The clang_analyzer complains as follows:

Value stored to 'port_mask' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index bd18432..3aad0c3 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -2011,7 +2011,6 @@ void intel_ddi_sanitize_encoder_pll_mapping(struct intel_encoder *encoder)
 			return;
 	}
 
-	port_mask = BIT(encoder->port);
 	ddi_clk_needed = encoder->base.crtc;
 
 	if (encoder->type == INTEL_OUTPUT_DSI) {
-- 
2.15.2


