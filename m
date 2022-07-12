Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E6571893
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiGLLcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiGLLcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:32:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9B4F641
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:32:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id bh13so7303576pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oyv6ls5n5LtXZ+eFrLN0Kgir8c8eeeHctyKmi21xDfU=;
        b=ImsYx5Ku+Ab8MqVb/ZzRH9XFV9El4m+WUWrW9VTtX2efmRpl6j584D6ilTaioM7GuY
         3VWIEvaYsJqJnJa8kNtQyoKP3nRUjATbmmw20kX0OzdXf2ckm2LhB7D57Z1bD50XZDfH
         PlJK0/nVT2+QXEt8i3DxTxerhl831H78bmZxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oyv6ls5n5LtXZ+eFrLN0Kgir8c8eeeHctyKmi21xDfU=;
        b=3bQiKDHSnJsyoZU0oVCSv0vT+EOBQCF5Fjg5BxsDrlskvaOWH0NEnLa1DNn0pGJWzM
         jGTc7ULpd+/EtUS1IVf2RKF86Kpe9wJLp0T1y9SDaFE5W2pleYRzKwBvmfd6WdzZ2NFt
         8vxrsu+6asW88Xw4aLyZ1E75+n7y3jHTgzv2SpCeNuQHT27FO1qP967LZTbxJbkD/1Ju
         DHsxPA1RpcZQ5PV5RjYImmP20jh0pqOK1LnWEVUSRGAvmlK2cFPBxkbMf5UJL6biJNQ4
         zrxfx4p3Gq6f8F3PmYKjKc1BBgZk6qdNLP3VXtXqKzuW147KmDXA62w1Fc2qGCCE2Bx4
         Hzww==
X-Gm-Message-State: AJIora+Qwa1AwFlFTHL0HY6A8reu5bWAdW2aQ+srNOd6OtnRzIFosO+L
        QURpjTBGfl4EQHNlZVgZ3FnfNw==
X-Google-Smtp-Source: AGRyM1vNTI7P5FFRL8K9PK2KWyhjO0NXooJUOhB6blvPca1HMAd1tLyTL0bTIb9nIiSlIRA9J2QFCg==
X-Received: by 2002:a63:2c89:0:b0:411:66bf:9efc with SMTP id s131-20020a632c89000000b0041166bf9efcmr19639098pgs.589.1657625528922;
        Tue, 12 Jul 2022 04:32:08 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d1a9:ca7d:e86f:cf6f])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902f64c00b0016bf9437766sm6527972plg.261.2022.07.12.04.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:32:02 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH 0/2] clk: Fix CLK_OPS_PARENT_ENABLE and runtime PM
Date:   Tue, 12 Jul 2022 19:31:05 +0800
Message-Id: <20220712113107.871623-1-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike, Stephen,

Here are a couple fixes for the clk core. They are unrelated but overlap
in diff context, so I'm sending them together.

Patch 1 makes the clk core honor CLK_OPS_PARENT_ENABLE for clk gate ops.
Without this, dumping clk_summary on the MT8192 would cause the system
to hang.

Patch 2 reorders the runtime PM call in clk_core_unprepare() to match
the order described in its original commit, and the opposite of that
in clk_core_prepare().


Regards
ChenYu

Chen-Yu Tsai (2):
  clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops
  clk: core: Fix runtime PM sequence in clk_core_unprepare()

 drivers/clk/clk.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
2.37.0.144.g8ac04bfd2-goog

