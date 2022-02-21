Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584734BE5E4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358639AbiBUNLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:11:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358609AbiBUNLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:11:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220EC1EC59
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:42 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id p9so26966323wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmju7T8l5cjpjfMcYV9GyQ+faFiFa5fab7CyUuOg12E=;
        b=qtMgF8esbXrSOD1/RGSdSaMPZQBu6eqWm0IzOK1TFEEH9fqLGnbomg0E3DafC8rTAK
         ezivsrYSoEs02yuEDa4buWFnQQUybuVDfpwDoARvOo6KUJDuVkhr2XghRdsiR0oP6P58
         em8mZdfaJvXF7v96IHpgYeZ+1C0mDJUPx5KpNPhShAvLSqjTUUr5glb8vRBBPDXtaic3
         Aa1qeDx/ai+6UVZyAtXXblEORCgFzBKPh6TXJ53k4kxRPFQMEJ4/2LpwrmrZJP9VLA58
         NpkdeHm1MWkVZBlSYIBuWYeNHproxubOHGdzzIfc+XgCJokE1C4K9NgXXVPi/1H/LJ7d
         7s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmju7T8l5cjpjfMcYV9GyQ+faFiFa5fab7CyUuOg12E=;
        b=e0morBgqEZeUIwkjTaiCym4R4xb4u6ZJUXfKk146fSKxJWIZ4QxrLHiZaRjef4H7eD
         iSHYXy2INGcx7KN/BqNL7azWROoOkOEG71MS0P8qQoQXNRBLhM2tvEau7UjiGsRqtWVM
         ta0I5QnSjVtjVJbvitGic33wyxUl9aCiTMarMEU7hHXR91fPSm4Gdool8xGBhPlCyPgl
         Se7k0/ZdNtlQgk4KGQtuIt0nWtTH8VmCc3+/wbZoCNT4gNHdSPKKrlS6KldQOs0NqrN4
         h8+S7LC7Qks3I+8yUn0H3QtXxWwPfv4UiHmLz+cAUOhj3NreMOXjo6PWgpe7tuUoOyx2
         Eq+Q==
X-Gm-Message-State: AOAM5310l+ZMhtvCM53LJJwnpdK0peDTPJBsKX7pttRKDGe3nYCMVtGP
        L3nBRUeL4LYOEt9zdFYMLFTZcQ==
X-Google-Smtp-Source: ABdhPJx+Nwif8L9DJPdvertRKu3XLrN1K3ocaB+yfSE5aF5k5X4RWp9aZfXRgvqFrTjjFL339yolrg==
X-Received: by 2002:adf:e8c5:0:b0:1e4:7c8a:21a7 with SMTP id k5-20020adfe8c5000000b001e47c8a21a7mr16004022wrn.516.1645449040742;
        Mon, 21 Feb 2022 05:10:40 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:10:40 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/10] ASoC: codec: add pm runtime support for Qualcomm codecs
Date:   Mon, 21 Feb 2022 13:10:27 +0000
Message-Id: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for runtime pm on tx/rx/wsa/wcd lpass macro, wsa881x
and wcd938x codecs that are wired up on SoundWire bus.
During pm testing it was also found that soundwire clks enabled by lpass macros
are not enabling all the required clocks correctly, so last 3 patches corrects them.

Tested this on SM8250 MTP along SoundWire In band Headset Button wakeup interrupts.

Srinivas Kandagatla (10):
  ASoC: codecs: va-macro: add runtime pm support
  ASoC: codecs: wsa-macro: add runtime pm support
  ASoC: codecs: rx-macro: add runtime pm support
  ASoC: codecs: tx-macro: add runtime pm support
  ASoC: codecs: wsa881x: add runtime pm support
  ASoC: codecs: wcd938x: add simple clk stop support
  ASoC: codecs: wcd-mbhc: add runtime pm support
  ASoC: codecs: wsa-macro: setup soundwire clks correctly
  ASoC: codecs: tx-macro: setup soundwire clks correctly
  ASoC: codecs: rx-macro: setup soundwire clks correctly

 sound/soc/codecs/lpass-rx-macro.c  | 49 +++++++++++++++++++++++++--
 sound/soc/codecs/lpass-tx-macro.c  | 45 ++++++++++++++++++++++++-
 sound/soc/codecs/lpass-va-macro.c  | 36 ++++++++++++++++++++
 sound/soc/codecs/lpass-wsa-macro.c | 43 +++++++++++++++++++++++-
 sound/soc/codecs/wcd-mbhc-v2.c     | 26 ++++++++++++++
 sound/soc/codecs/wcd938x-sdw.c     |  1 +
 sound/soc/codecs/wsa881x.c         | 54 ++++++++++++++++++++++++++++++
 7 files changed, 250 insertions(+), 4 deletions(-)

-- 
2.21.0

