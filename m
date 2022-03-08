Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ECA4D0DBE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbiCHB5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiCHB5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:57:22 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F903F321
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:56:26 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id p8so16020557pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 17:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2E8yu0dx7WwOCxdxcyi0NQqYJT6dBXDVWvwU57lz8KQ=;
        b=W4Vvp4Om53sRLaPMGoPv5Lw3SKc1neqXL4ODSGoSFaBNP4IX+aOSiXUdqKNhBI1OLU
         0+beRrK3uYfg8BWDrympGzCfIi66zeCPkX0fLoNA19CS/iCRkHKA+uk2vKPPxmEzNRg4
         ZM3ycFOrv6n6KdLAoJieK+TsbBUTPC4hSjCgUsCF/L8P3cmush/4rcPuiuonl0whQhyS
         RrozoUF0mcg0tb9JSS453Z5DAzB7TacoKp/s+nN6LuSvH76qiIA4wP0CKbCIMf4/5Y06
         qbmnQIzm3JdWCFW4yi5GJwB/AoB2og/tQCSEpoApP4QAURHorqMd5zAi3SEjUurw2urR
         AgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2E8yu0dx7WwOCxdxcyi0NQqYJT6dBXDVWvwU57lz8KQ=;
        b=retFsTTn3vVY0GvCbySentOVXWYyeoyKrxn4sjLilxM7TWZdajaDdedUks69tJrPbi
         hUcHlpBeQwRvZBvn8lwB+PW2QMATHMMgIuTUSthmPsL2eyK716r2XXylXN7S8OHn88/H
         6gMKLEO/6q8ikTWqJcPUxQzEAD02nVZCqdoSNjgXkwp9YkB/kZFzvWUm7YQQorY8SK3D
         lVzp0vHx3kCldODWMVLr3muNmIP23l8nRuhRxDXZDnAki+iKKR6EY/FoJ13zk1zVieEe
         e/OQ46s2RQkmOuGxjTMK/+QJbkHT0+DxxscT6WspmueAgqPw+XAqSzkowS8soQ3rx0wS
         iOFg==
X-Gm-Message-State: AOAM531uSB1OEpydSbnPT9LrOhX5Q32tDuuoDuIGIZXnMDtmgqzSe4U9
        9EkZTgTE9Qy8xEohXkTqDuc=
X-Google-Smtp-Source: ABdhPJyc8tex3nzmMFhV2LyL3qoBzinohm5njUfxL/3uqEMMkFBn6X+k9KVvHtUHpCN1RBuTP/4w4Q==
X-Received: by 2002:a05:6a00:a23:b0:4f6:72a8:20c7 with SMTP id p35-20020a056a000a2300b004f672a820c7mr15968222pfh.12.1646704585971;
        Mon, 07 Mar 2022 17:56:25 -0800 (PST)
Received: from lxb-server.lan ([2605:52c0:2:32c::])
        by smtp.gmail.com with ESMTPSA id mm17-20020a17090b359100b001bef7e5bdffsm619629pjb.20.2022.03.07.17.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:56:25 -0800 (PST)
From:   Yunhao Tian <t123yh.xyz@gmail.com>
To:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Yunhao Tian <t123yh.xyz@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mipi-dbi: Fix max_chunk calculation in spi_transfer
Date:   Tue,  8 Mar 2022 09:56:11 +0800
Message-Id: <20220308015611.3007395-1-t123yh.xyz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

In __spi_validate, there's a validation that no partial transfers
are accepted (xfer->len % w_size must be zero). When
max_chunk is not a multiple of bpw (e.g.max_chunk = 65535,
bpw = 16), the transfer will be rejected.

This patch clamps max_chunk to the word size, preventing
the transfer from being rejected.

Signed-off-by: Yunhao Tian <t123yh.xyz@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 71b646c4131f..440dc9fec6cc 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -1182,6 +1182,15 @@ int mipi_dbi_spi_transfer(struct spi_device *spi, u32 speed_hz,
 	struct spi_message m;
 	size_t chunk;
 	int ret;
+	int w_size;
+
+	if (bpw <= 8)
+		w_size = 1;
+	else if (bpw <= 16)
+		w_size = 2;
+	else
+		w_size = 4;
+	max_chunk -= (max_chunk % w_size);
 
 	spi_message_init_with_transfers(&m, &tr, 1);
 
-- 
2.25.1

