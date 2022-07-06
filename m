Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76FF568103
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiGFIWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiGFIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:22:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6221E32
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:21:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so15070040pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GqB+pMEeOX9h0udH1mNyDv5eJ9rhofvXzOhjJhiuvEo=;
        b=f861gyIxenkTm+IPNvjX90TJpK8xwY78UPnvHnHpBQkEmmP3Pakp40vpyQs76NTHSq
         Rh8X4FpXt9QVv7u8+RGbIWr8ewjvWoTYUnuwD2ZAWkWD0BLeIUh1pMmIN/JW4Qat1dwS
         0t3cPjwJA+b3yyScwzC2WyIGy/SjfidVMC9h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GqB+pMEeOX9h0udH1mNyDv5eJ9rhofvXzOhjJhiuvEo=;
        b=OtFQ8fwLBW5d+BPA+kTrHwKgdUkMgBV/2W0CvfWTD5vi4mNUKCK3/ZvQp8HQbo0xyv
         60oBm4OqNwJA9SYccYoyP4/ssLvCsCmDoiaMY9KlNPuFtU+GHV44KDQzWDdf7Pwid4q1
         TIgToCn8nPyH+VM4SED79RYRe3H5/Nzj2X46b0DB3cO5DfFxOwWn8p+ZFdWVPosd2EeD
         KjHaUqKDiSFbZRrjUBMvITxD/fVQDnJr0sQOXeyeGIB5p+grBVYioeDpvpV2Qgys+Uoo
         XAos2iGlDihJhCxO/u4e1/PJ1cL6oFtlQdNtaZvQfdA6Tc9SMfYTEZITe2Oi97iGgqo5
         A/3w==
X-Gm-Message-State: AJIora/lUVhFqKjQbEOa3wquhZ4BZ0onJZjez2aoo7sUt84kIitluidW
        ahn+I8et0xhzTU6Yf5AsAc4kizqwwoCr4A==
X-Google-Smtp-Source: AGRyM1tsd4xWLnRQhFWsHSq5ng2txHr8cKx03t+O3C5k4KZzMRDXo6+93OUir8+OQCbeF7eGyCMN2w==
X-Received: by 2002:a17:902:b586:b0:16b:ec53:a660 with SMTP id a6-20020a170902b58600b0016bec53a660mr11343900pls.24.1657095717673;
        Wed, 06 Jul 2022 01:21:57 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74a3:a7a4:af57:d7f])
        by smtp.gmail.com with ESMTPSA id rm1-20020a17090b3ec100b001ed27d132c1sm20767040pjb.2.2022.07.06.01.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:21:57 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v2 0/6] media: mediatek: vcodec: Fix 4K decoding support
Date:   Wed,  6 Jul 2022 16:21:32 +0800
Message-Id: <20220706082138.2668163-1-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of the mtk-vcodec 4K decoder fixes.

While testing a backport of recent mtk-vcodec developments on ChromeOS
v5.10 kernel [1], it was found that 4K decoding support had regressed.
The decoder was not correctly reporting 4K frame sizes when queried,
and ChromeOS then determined that the hardware did not support it.

This turned out to be a mix of different bugs:

1. Frame size enumeration on the output side should not depend on the
   currently set format, or any other derived state. This is fixed in
   patch 2.

2. TRY_FMT on the output side was incorrectly clamping the resolution
   based on the current maximum values. It should not. Fixed in patch
   4.

3. The default resolution limit was not set according to the default
   output format determined at runtime, but hard-coded to 1080p. An
   S_FMT call is needed to override this. The instance resolution limit
   is rendered useless after patches 3 and 4, and dropped in patch 5.

Other patches:
- Patch 1 makes stepwise_fhd constant.
- Patch 3 drops redundant aligning of default resolution
- Patch 6 moves framesize inside mtk_video_fmt, making it easier to
  access and removes a list search that was added in patch 4.

Changes since v1:
  - Added patch to const-ify stepwise_fhd, as Nicolas requested.
  - Dropped old patch 2 (media: mediatek: vcodec: dec: Set default
    max resolution based on format)
  - Dropped old patch 4 (media: mediatek: vcodec: dec: Set maximum
    resolution when S_FMT on output only)
  - Made max resolution lookup for TRY_FMT return stepwise structure in
    patch 4, which helps with the last patch that moves framesize
    stepwise into mtk_video_fmt.
  - Did some style cleanups in patch 4

This series is based on next-20220705.

This was only tested on the backport kernel [1] on MT8195, which is the
only currently supported SoC that does 4K decoding. Hopefully the folks
at Collabora can give this a test on their mainline MT8195 integration
branch.


Regards
ChenYu

[1] https://crrev.com/c/3713491

Chen-Yu Tsai (6):
  media: mediatek: vcodec: decoder: Const-ify stepwise_fhd
  media: mediatek: vcodec: decoder: Fix 4K frame size enumeration
  media: mediatek: vcodec: decoder: Skip alignment for default
    resolution
  media: mediatek: vcodec: decoder: Fix resolution clamping in TRY_FMT
  media: mediatek: vcodec: decoder: Drop max_{width,height} from
    mtk_vcodec_ctx
  media: mediatek: vcodec: decoder: Embed framesize inside mtk_video_fmt

 .../platform/mediatek/vcodec/mtk_vcodec_dec.c | 54 ++++++++-----------
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c | 29 +++-------
 .../vcodec/mtk_vcodec_dec_stateless.c         | 30 +++++------
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h | 20 +------
 4 files changed, 41 insertions(+), 92 deletions(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

