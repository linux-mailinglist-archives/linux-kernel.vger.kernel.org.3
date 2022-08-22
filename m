Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8780E59BB2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiHVIOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiHVIOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:14:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0366A1A83F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:14:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v23so3958813plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vFL4Ok6aVz+SF4AwWxLqDJ9FHif8ySEihParxtYrieU=;
        b=byGR/js11m4a8Js4TSQCX47v+0BUDKlOmW4jrvz+e1uNJeU7y2gEvVdl7VJwzGPvUi
         fsk+l1iQUDEZrrivhKeoUL+vHAMvMk9UgYv9U9t4Oe8k805g27z4t3vLplIAc/zalee/
         UkrohqvCiKb93QewIV1rqfjJF7IyqR+GS/wn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vFL4Ok6aVz+SF4AwWxLqDJ9FHif8ySEihParxtYrieU=;
        b=FR2qRE2G/82Xp4XMua0cj1RSwGm+YKfsuTn2yHUx9pfCXfSknHTUKExobefEA5eC+f
         HL0H7AzVDGFLz6F9QW14v3/NKzad8OR9KEXrV2OmhWIeaFh6UnSujBwJtpXck0N73bgV
         0VzvGdBHEXDT76O7kKmfUGtj2e25fgxhgbKiYE6xfIxE7T2MBG1pg26K+jHm9+Mhe93A
         05GL3ks8fl0UioJApksGbT7tL1kIYIWRW2WA/0xE7PKY5kJe21liFHKpLnHI4BJHAoRw
         /gJ45QUZ4FBU7dBMU1ndLs6Ah02cX5H6Hv2TMT4WNcBiCvtRCu/jP4Xl60lZ66EFq4Jo
         UtyQ==
X-Gm-Message-State: ACgBeo0y9ZtCfQaacb5gTf6bPbcUt2eb4VRsbQhPSEHInMshNMcJPY6P
        l5KdBV3drUJM/vT6OftKIdwGaP9s2kR2cw==
X-Google-Smtp-Source: AA6agR5x1ulnqmLHSRLCyJZRdkdDCiS5g9qlKQK1unmkvno1XeD7aFXF1CYQBd5BdFlFECphtFU0Nw==
X-Received: by 2002:a17:902:be02:b0:172:d409:e057 with SMTP id r2-20020a170902be0200b00172d409e057mr9499042pls.90.1661156082565;
        Mon, 22 Aug 2022 01:14:42 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d583:9d7d:3429:1b4b])
        by smtp.gmail.com with ESMTPSA id f184-20020a6238c1000000b00536b3fe1300sm1204858pfa.13.2022.08.22.01.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 01:14:42 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 0/2] clk: Fix CLK_OPS_PARENT_ENABLE and runtime PM
Date:   Mon, 22 Aug 2022 16:14:22 +0800
Message-Id: <20220822081424.1310926-1-wenst@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike, Stephen,

Resending this series from last month. This is now based on
next-20220822, but should apply cleanly to v6.0-rc1.

Here are a couple fixes for the clk core. They are unrelated but overlap
in diff context, so I'm sending them together.

Patch 1 makes the clk core honor CLK_OPS_PARENT_ENABLE for clk gate ops.
Without this, dumping clk_summary on the MT8192 would cause the system
to hang.

Patch 2 reorders the runtime PM call in clk_core_unprepare() to match
the order described in its original commit, and the opposite of that
in clk_core_prepare().

Changes since v1
- Use clk_core_{enable,disable}_lock() instead of non-locking variant.
  Reported by Nícolas
- Added coverage for clk_core_is_prepared()
- Correct sequencing in clk_core_is_enabled() so that runtime PM is
  handled before parent clock is enabled, matching other functions.


Regards
ChenYu

Chen-Yu Tsai (2):
  clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops
  clk: core: Fix runtime PM sequence in clk_core_unprepare()

 drivers/clk/clk.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

-- 
2.37.1.595.g718a3a8f04-goog

