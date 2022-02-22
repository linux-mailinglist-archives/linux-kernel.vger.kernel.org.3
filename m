Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A454C0159
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiBVScz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiBVScx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:32:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCAA12771
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j17so8401054wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIDuRiJHhzu2vEL6lRXNUGBwsDBGA5IDZz729oGpCe4=;
        b=YbYnrovBwpePB9FhMDqBVWz7PyzYr8s6ua9/B8Yw/lpYx+pwvC7oEuL5eyuE08oDrO
         KeJfM+UhAV9xZBYWdyBOWU1BKWn3y/V0caEF784MTsrSHXrSj5GKtN+EwsbYrPYNgF2k
         BunN9JfH8JRswjyeCfZzwJrWlehi5zccMJEvmcpZUJh+KJrDjiaPEyU89f1Y1vX26mpm
         MRDTENWVtY/LeW8/KtXDYmIyeIgCmvFC8FpeoM9yIbLo7ugLTvExJ2Vi+5ub25C9KXdd
         PXuG2Ulnex/B2BIKMN0q7nZ72x7pLdCxX1EkDdb+idiwvN/kiWJI/k1Cbva9h6gbaiNA
         ardg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIDuRiJHhzu2vEL6lRXNUGBwsDBGA5IDZz729oGpCe4=;
        b=7NoE9EBpdMKB9CJMO1ReLV5ggzlnXDNyOF5zc47sQv9m8WzJcey5vz7Ty+bAAAljW3
         14muwj70IAk2jZsNriRulg5eTsl/3kbuREnczoudcQ4OIwjlBfbKDvylPFKi4WX6KqF0
         u8t+4DunI8s2zTc8X8/vTwtGtFvCI9P/6CZKG3KdFZORetDSlV9vYEnVxpnA2uMRND+O
         uEpBq97No4A3COaUnQNAoTxYxRaydNhcxMlhvWmQoQsbbwFpxY2NKD4qVeqeFA6vcd5v
         QnBR63SMHd2c1ZEXJaffzIEn8re1KybK85LX7pjp9d0uvgP2WuqGFxppBcZDnXqSf9yQ
         /1sw==
X-Gm-Message-State: AOAM531aFO/H8rya0voGjQVfn+8cgir0YxpFQ/Xo8Ykmd0okPUYMWsl4
        Yo1G7pIFVUoaJrcjz8ID3lS8pg==
X-Google-Smtp-Source: ABdhPJxCRvDS9UvQCjHG+xri8F/RlHkBPqMcAYkGokPlRbr1aqZABFwt7RTpdvgkEN2wmKizE8Np7g==
X-Received: by 2002:a05:6000:1684:b0:1ea:8afa:af73 with SMTP id y4-20020a056000168400b001ea8afaaf73mr3506799wrd.489.1645554746209;
        Tue, 22 Feb 2022 10:32:26 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:32:25 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/9] ASoC: codecs: qcom fix validation failures
Date:   Tue, 22 Feb 2022 18:32:03 +0000
Message-Id: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
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

Thanks for pointing out to mixer kselftest and VALIDATION Kconfig.

This patchset addresses some of the issues in Qualcomm codecs that are
discovered with recent mixer kselftest and validations added to ASoC.

Mostly these are under
1. accessing integer value type for enum controls, which is clearly an array out of bounds access.
2. Fix incorrect ranges.
3. Fix return values for put functions.

Changes since v1:
- removed tlv min max patches as "9bdd10d57a ("ASoC: ops:
Shift tested values in snd_soc_put_volsw() by +min")" fixed the issue in core.
- added checks in wcd934x_rx_hph_mode_put before returning

thanks,
srini

Srinivas Kandagatla (9):
  ASoC: codecs: rx-macro: fix accessing compander for aux
  ASoC: codecs: rx-macro: fix accessing array out of bounds for enum
    type
  ASoC: codecs: tx-macro: fix accessing array out of bounds for enum
    type
  ASoC: codecs: va-macro: fix accessing array out of bounds for enum
    type
  ASoC: codecs: wsa-macro: fix accessing array out of bounds for enum
    type
  ASoC: codecs: wc938x: fix accessing array out of bounds for enum type
  ASoC: codecs: wcd938x: fix kcontrol max values
  ASoC: codecs: wcd934x: fix kcontrol max values
  ASoC: codecs: wcd934x: fix return value of wcd934x_rx_hph_mode_put

 sound/soc/codecs/lpass-rx-macro.c  | 12 ++++++++----
 sound/soc/codecs/lpass-tx-macro.c  |  8 ++++----
 sound/soc/codecs/lpass-va-macro.c  |  4 ++--
 sound/soc/codecs/lpass-wsa-macro.c | 10 +++++-----
 sound/soc/codecs/wcd934x.c         | 11 +++++++----
 sound/soc/codecs/wcd938x.c         | 10 +++++-----
 6 files changed, 31 insertions(+), 24 deletions(-)

-- 
2.21.0

