Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABB24B9ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiBQIW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:22:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiBQIW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:22:56 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8304B1EB425
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:22:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id om7so4866704pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0zytHf9FkJ/PPPieoPlaB6am9Dki6g+U3R/IZo38jLU=;
        b=auYbTr3bUun55c3vBXt7qY9ZrmwpIs78nu5pz18cj7v0siiy6+G4aRNbk/2LLcvodS
         asUmF3hxOd6ZBy+ihtNE6oN8R9cn1ymyRv9UHjqnbDk+q41MxMNbtxf/MMEUbPKEYXA/
         dhm2coht7GKbfTxGOJDbdrBGoDbRdjO0iSzxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0zytHf9FkJ/PPPieoPlaB6am9Dki6g+U3R/IZo38jLU=;
        b=tBihTjw5Dj9c3n2y7kfYy/SjLdxc4Jmox4/r1HWcQlG8toASOlqHc85vExNie2pmlz
         newY6rtWkpJ/k6+zC/fS2c28UZDJGSmKMDEtjlFX7Y0ZFEysn8EfUtGYhPon6k1MkKk4
         6cALejdBFg+92N9ahkGZiXCV7aKqXSD6dOB5gCas9Vprhgl4ZMcHynmRNuqXnUIi8MbD
         r237WAX6sAOqyrNRIRWySTzyNTYaDdRDa5NSmC/EvF3i9bmEfrNw2/85z9hFa6BgDXab
         WzWKOxo2PvLhmCgt2WVfJV1pI1TkvG+0ClR9aq2l9kHhRDtwdKCaDJDA7L93I+twlzjk
         UugA==
X-Gm-Message-State: AOAM531WfwLjHayxNESvP3E0LZ4598L+EazKtYtlW/MbclM1JFyzMM4N
        0Rhj3aZno7zVj0qTBhBsUDNffgDIeasGsQ==
X-Google-Smtp-Source: ABdhPJzkyaeJpICrlVtn3FjTPp3zOJJq42VV/eJRldL/wDp5OS70ij2lPbhKBr0CbkwHJR5GBhSQ+Q==
X-Received: by 2002:a17:90a:9408:b0:1b5:3908:d3d1 with SMTP id r8-20020a17090a940800b001b53908d3d1mr1948242pjo.188.1645086161956;
        Thu, 17 Feb 2022 00:22:41 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cdb:2c0b:b1f8:e426])
        by smtp.gmail.com with ESMTPSA id m8sm1545449pgb.0.2022.02.17.00.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 00:22:41 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Xin Ji <xji@analogixsemi.com>, Robert Foss <robert.foss@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH v2] drm/bridge: Clear the DP_AUX_I2C_MOT bit passed in aux read command.
Date:   Thu, 17 Feb 2022 16:22:25 +0800
Message-Id: <20220217082224.1823916-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the previous transfer didn't end with a command without DP_AUX_I2C_MOT,
the next read trasnfer will miss the first byte. But if the command in
previous transfer is requested with length 0, it's a no-op to anx7625
since it can't process this command. anx7625 requires the last command
to be read command with length > 0.

It's observed that if we clear the DP_AUX_I2C_MOT in read transfer, we
can still get correct data. Clear the read commands with DP_AUX_I2C_MOT
bit to fix this issue.

Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid through aux channel")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v1->v2: Offline discussed with Xin Ji, it's better to clear the bit on
read commands only.
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 633618bafd75d3..2805e9bed2c2f4 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -253,6 +253,8 @@ static int anx7625_aux_trans(struct anx7625_data *ctx, u8 op, u32 address,
 	addrm = (address >> 8) & 0xFF;
 	addrh = (address >> 16) & 0xFF;
 
+	if (!is_write)
+		op &= ~DP_AUX_I2C_MOT;
 	cmd = DPCD_CMD(len, op);
 
 	/* Set command and length */
-- 
2.35.1.265.g69c8d7142f-goog

