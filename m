Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E622F4C2AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiBXLSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiBXLRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:17:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863BDF70C1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b5so1474852wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4LwzA+Ef31mwQpA9bTjYO5hYFfgu0fC7ELpcssYOSE=;
        b=hE3EJFfF6VzcfLrzRn5aJCbjjAMiK533zNKHRj+C3WitaLtKo4kAlfYrk3riLzLF/X
         O3FCI0qXc1eCJmTgeLBa9ydwwy46/9cz8N+duqK6PqUh/Hc41TnP8x+DfWejCQx+/oTi
         eMSBQaNsKND69ZrEdBH+IWCU5g/EQQymQ8DMfKh1yE8cxk7jrCbFl7YPt7lGW2ezebEI
         2u2KifVkg5ruCjwzLrzB55IhraI7vWYXI6mE1QVfg6MIoS8CArYN8Ah2jGs86e1g0MdA
         XiW/POUR4ArEHj1Fgwjw8FYL+tylHcXFXiD0RJgyjVaT8aUHGUTx/5ATwiGxOMKj2MVS
         TbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4LwzA+Ef31mwQpA9bTjYO5hYFfgu0fC7ELpcssYOSE=;
        b=24IcooSzqSOK0gXKgrHNlu7LCuAMroaWqId3A/57QU5bx0p9oKEO4tlpm+Kpj96Ka7
         KOhYIJ6cEIzDmn6co1/mgZ66Auu3dYdsUPyy1Akp0thjV9yD87JWldBfocJYjahXwTSw
         joNnuuHaauL0x2o7XwaGS0DnHm9VTYHLau6pbaAoBP3DcHYu8IIeiSI1U8ADki0FOv3W
         KoiXbkHWjF0itwfT1m/zuBxDeiSWAky2Tp8BcDYI8DPkPDBih3eVrZqVMEHQ4UmnU9Di
         KAKaIiqjfuZanTcYDJEDpMgL3TuQk3xOcpdf38QtoDVlnot/YIsAKV6N2OejtRFv5yLu
         9dYA==
X-Gm-Message-State: AOAM531fiyFJuJvjRrupz30BDXmOkYlQIYrNzWjAuOs9c990NHqT9mGH
        iRoONmtkEfC1lvnlu/4p2A4u/GoNvIqHzw==
X-Google-Smtp-Source: ABdhPJyAbKc8qelEnGbGx3dKGDG6VY7tTOq4g66Wk0gJVAM/zAwvRq07CUkhz2V8B9X8kywSZOmwWA==
X-Received: by 2002:a5d:5850:0:b0:1ea:7d9c:4397 with SMTP id i16-20020a5d5850000000b001ea7d9c4397mr1843934wrf.225.1645701442070;
        Thu, 24 Feb 2022 03:17:22 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:21 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 00/16] ASoC: codecs: add pm runtime support for Qualcomm codecs
Date:   Thu, 24 Feb 2022 11:17:02 +0000
Message-Id: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
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

Changes since v1:
- move to handing clks individually from clk bluk apis
- tidy up the clk provider side code by using devm variants
- added error handling.

Srinivas Kandagatla (16):
  ASoC: codecs: va-macro: move to individual clks from bulk
  ASoC: codecs: rx-macro: move clk provider to managed variants
  ASoC: codecs: tx-macro: move clk provider to managed variants
  ASoC: codecs: rx-macro: move to individual clks from bulk
  ASoC: codecs: tx-macro: move to individual clks from bulk
  ASoC: codecs: wsa-macro: move to individual clks from bulk
  ASoC: codecs: wsa-macro: setup soundwire clks correctly
  ASoC: codecs: tx-macro: setup soundwire clks correctly
  ASoC: codecs: rx-macro: setup soundwire clks correctly
  ASoC: codecs: va-macro: add runtime pm support
  ASoC: codecs: wsa-macro: add runtime pm support
  ASoC: codecs: rx-macro: add runtime pm support
  ASoC: codecs: tx-macro: add runtime pm support
  ASoC: codecs: wsa881x: add runtime pm support
  ASoC: codecs: wcd938x: add simple clk stop support
  ASoC: codecs: wcd-mbhc: add runtime pm support

 sound/soc/codecs/lpass-rx-macro.c  | 168 +++++++++++++++++++++++-----
 sound/soc/codecs/lpass-tx-macro.c  | 169 ++++++++++++++++++++++++-----
 sound/soc/codecs/lpass-va-macro.c  | 106 ++++++++++++++----
 sound/soc/codecs/lpass-wsa-macro.c | 157 +++++++++++++++++++++++----
 sound/soc/codecs/wcd-mbhc-v2.c     |  26 +++++
 sound/soc/codecs/wcd938x-sdw.c     |   1 +
 sound/soc/codecs/wsa881x.c         |  54 +++++++++
 7 files changed, 580 insertions(+), 101 deletions(-)

-- 
2.21.0

