Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0822F5730F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiGMIXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiGMIXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:23:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9106E24BF0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:21:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so2372641pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5tqKmI0VtDav4ikokY0BzkYbycUnUxRQ6P+/2oYKpE=;
        b=a7N3b5EUaL7IAQGgk/tg9fBS5xWt/oI88kNN3Ka8ICnGZuY+llH+mjd0vSJMYO7Chz
         ppeKVX+nDXuJzLSCYom74OLx+Wts00I2An62EJ8GBTHHn7Y6Ph/63CV9Ur/qTExHHhi0
         Aefn0JxibQbjbpUnJ4HXXHslE1frvl0Xad5OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5tqKmI0VtDav4ikokY0BzkYbycUnUxRQ6P+/2oYKpE=;
        b=FfROhrTJlcdCIXB4n9t7D4IuHxmt8EZTGBrw0v1jXb+/AYM6zXzRebdlCfphO4VYbN
         zg4eEbHw3riUtB1B1CmGvJA4XOSlUupfGQIJlYf1Tas9gVRp3J8MghAfwiE/+nF86Ruv
         HCMvTMnWn4G0Klx4OjwzKieAQUuycemWmNllRgRTC0HKCwt2RcfOlua/n1wHcbrzh15Z
         n5Y3rZOX+MmA3IbqgWpaXHthR70AxbViUM/11c7dbbz84qfWTf6NeMnqx9hCiNu6FBFi
         HFnBqM+i0EM1C8IYi2qPih5BqlCdcuu9yv7tLKy8rupLw5tAuwqulKmZtekqDjQx0VVn
         O+6A==
X-Gm-Message-State: AJIora9OLHS/owwBu867Stg+3Vomm9d0yLBBwOCftZOcOerXnPMIxpSc
        HN+hnTFlkn99kNdqk7WNtGaF2g==
X-Google-Smtp-Source: AGRyM1uu4akTezwMzGdR0eJQ60s6v0evsIm8YEeeL5lCapS3JSnaGoHdbdpf7uzWtmUvA52hAn6NGA==
X-Received: by 2002:a17:90b:4d01:b0:1ef:d39b:b140 with SMTP id mw1-20020a17090b4d0100b001efd39bb140mr2595551pjb.82.1657700477146;
        Wed, 13 Jul 2022 01:21:17 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d1a9:ca7d:e86f:cf6f])
        by smtp.gmail.com with ESMTPSA id k11-20020aa7972b000000b005281d926733sm8220461pfg.199.2022.07.13.01.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:21:16 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH v2 0/2] clk: Fix CLK_OPS_PARENT_ENABLE and runtime PM
Date:   Wed, 13 Jul 2022 16:21:09 +0800
Message-Id: <20220713082111.2233016-1-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
2.37.0.170.g444d1eabd0-goog

