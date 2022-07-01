Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A1563632
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiGAOvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiGAOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:51:41 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34212CDDC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:51:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x20so2595274plx.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jkLsmDIy0AahYUW8g9Esgr6pvhc7me0usMRBZRidXhs=;
        b=ffwCwlDaoOkaH0gGVsYaT4ThDo/miD0dBxIsiG0YQ2DadoOPIzyZ+BjgxppTMHaIRb
         sojCGPgv5ZvRaEuI+Tu2VUmEDV028jJrDoaOtRAs4x9NBRjWbS4sXoVCKflouxwMCkPy
         w3haGmfWKPx0x+YQACzZQqvuGpsdQztdBcOg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jkLsmDIy0AahYUW8g9Esgr6pvhc7me0usMRBZRidXhs=;
        b=GRr2dp/NAAH78WdAKgBfC3/GbfpN8lE/LXjTQuu+dtemRp0duLD/iCMotTTel9eMis
         Glzxj8Tx+2nOr0ARgJmWdOdhN9DW15UbBq3lKFyM3T2DkPIpuC+tg8aOXREbWRdoBcys
         5BHXwvQ5Nl2v5ASpOV/HB57ZynWCNdEf4RbWBSPpxnlkbQzAlevmerYP6B/5WKgtu4C0
         e5axyB6dUE2pzPqqnlxng5Et8rSPcn2N4LM6aSmyMeFrDzAb9gVkPWcf2P1wvtMAC/px
         +VqI+Cn9gPB3pPnrKHPfjf2Z+G4w2Q/LVee66uWFx/4chBHy9Urdlp7Rf9t3flhPRdhc
         k0+g==
X-Gm-Message-State: AJIora+esf7WodzpsTuGaBC17Nd0/VBxOHjB8Bz9C3If6XiRw4NKWfVv
        g/7l//xtcdNBlCMNXbYwVg7ADQ==
X-Google-Smtp-Source: AGRyM1vMyAY5ZgoPt421IVDHIPT6UJZNTrC3UubKNP59oeP8S8flayelqZc1t+7PxEyZbImcTFD6Ww==
X-Received: by 2002:a17:902:d591:b0:16b:a170:8586 with SMTP id k17-20020a170902d59100b0016ba1708586mr13893903plh.91.1656687100324;
        Fri, 01 Jul 2022 07:51:40 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:59bf:8b47:50a0:b04f])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b0016a214e4afasm15780981plr.125.2022.07.01.07.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 07:51:40 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clk: mediatek: mt8183: Simplify with mtk_clk_simple_*()
Date:   Fri,  1 Jul 2022 22:51:30 +0800
Message-Id: <20220701145133.1152387-1-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of clk driver support for MT8192, a pair of "simple"
probe/remove functions was introduced that provided boilerplate
driver functions for clk drivers that fit a simple model: they only
needed to register clock gates. Using them reduces the redundant
boilerplate code needed for each driver. Instead, only a data structure
pointing to the clock gate array and the number of clocks is needed.

This series converts all the MT8183 clock drivers that only contain
clock gates over to these wrapper functions. For instances where the
clk driver not only registers clock gates, the extra action is properly
sequenced with the wrapper functions instead of outright replacing
the probe functions. The converted drivers also get removal support.
This also reduces the overall size by nearly 600 bytes.

Patch 1 converts the MT8183 clk drivers that only do clock gate
registration.

Patch 2 converts the audio clk driver, which also populates sub-devices.

Patch 3 converts the mfgcfg (GPU wrapper) clk driver, which also needs
to enable runtime PM, as it is tied to a power domain.

Please have a look, and merge if possible.

Thanks
ChenYu


Chen-Yu Tsai (3):
  clk: mediatek: mt8183: Convert gate only drivers to mtk_clk_simple_*()
  clk: mediatek: mt8183-audio: Simplify with mtk_clk_simple_*()
  clk: mediatek: mt8183-mfgcfg: Simplify with mtk_clk_simple_*()

 drivers/clk/mediatek/clk-mt8183-audio.c   | 40 +++++++++++++++--------
 drivers/clk/mediatek/clk-mt8183-cam.c     | 21 +++++-------
 drivers/clk/mediatek/clk-mt8183-img.c     | 21 +++++-------
 drivers/clk/mediatek/clk-mt8183-ipu0.c    | 21 +++++-------
 drivers/clk/mediatek/clk-mt8183-ipu1.c    | 21 +++++-------
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c | 21 +++++-------
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c  | 23 +++++++------
 drivers/clk/mediatek/clk-mt8183-vdec.c    | 21 +++++-------
 drivers/clk/mediatek/clk-mt8183-venc.c    | 21 +++++-------
 9 files changed, 95 insertions(+), 115 deletions(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

