Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC634BF782
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiBVMAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiBVMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:13 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823ED156C56
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p9so32694006wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8LObSTXu1qlvqbb+LZZSTBp/s15WbJsY+tJE4L4+0TQ=;
        b=S6zirMZaeJTYUQYI2jWpRibl0LEcLY97o0F/lBgr4W2yeXj8NN1Pi/kAwyhdS2ZcaP
         3DLiquqKlXA331x2wqCsuUiFrBZ9rLzfPEdj7mQEN6h4KzbrQMVoNikBVqrz0544PFdc
         5qkFQ2t5VR0T3qvV06OeHSVvAzK5ST26dUdgbspj1CLxCWCAXDBb5zZpjXhpjMaZ0zdY
         5Wz+ibvKKAaikmbQ1jouCJeai0JpQwQgk5VKkVMlNcUrFgAoU04o77KA+mrBbPzAbq/r
         n+DYzAB47J1mBABZqg7toakfxHLVtDb/Lc6L5sHtU0JSARf/mImQZLqp5dmPvwySKgd3
         +pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8LObSTXu1qlvqbb+LZZSTBp/s15WbJsY+tJE4L4+0TQ=;
        b=pNXx5ecu8w5HpH++LY+tf3UVKNfk7eaLtpX0+yO7BZhQl21BdQ0n3OGbACLm4V/9ti
         gdXrOXXaPCNBakkUU2npXh61usp6jzGARA5hRnfa/HIhM5ltzkuK0SgcPiTFENNcQYQY
         TCtxGJgMLxlemnUb5UKIOJV741r0p+JHsbSgPlIO6YCG0yz325CWvovsS29SYaA9I3/W
         uyFG+92LIjz4tbnzdCqwTjlOi7j/GJe+HeKavvTQjI0Ee50hk3yWBuUqCHLrzbnolr06
         D8CM8ZW3IaM4uVwLMuxiewfeYuAHxqs+q3IAV91n7lTk+SlIwy6Q45Wv7/asYoFKum79
         LgBQ==
X-Gm-Message-State: AOAM5336YgT1AW7Pjbf1U4MkpxqajU7twoXE4LVNpxo2vwb1awsXHL7o
        t+3elBTK8CgCNIQEMLQqHcbKkQ==
X-Google-Smtp-Source: ABdhPJz1Enfc0BgEL2zeXIbO97OxrujoZTbIOpVYZlAuLV7/llYGqgTXIg4Ba/LIcakGF4OQzNs9WQ==
X-Received: by 2002:a5d:5986:0:b0:1ea:75c6:3d0a with SMTP id n6-20020a5d5986000000b001ea75c63d0amr4633484wri.166.1645531186102;
        Tue, 22 Feb 2022 03:59:46 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/16] ASoC: codecs: qcom fix validation failures
Date:   Tue, 22 Feb 2022 11:59:17 +0000
Message-Id: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
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
3. Fix incorrect min max for tlv controls. (I can see that other codecs also suffer same issue)
4. Fix return values for put functions.

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
  ASoC: codecs: rx-macro: fix tlv min max range
  ASoC: codecs: tx-macro: fix tlv min max range
  ASoC: codecs: va-macro: fix tlv min max range
  ASoC: codecs: wsa-macro: fix tlv min max range
  ASoC: codecs: wcd938x: fix tlv min max range
  ASoC: codecs: wcd9335: fix tlv min max range
  ASoC: codecs: msm8916-wcd-digital: fix tlv min max range

 sound/soc/codecs/lpass-rx-macro.c      | 40 ++++++++-------
 sound/soc/codecs/lpass-tx-macro.c      | 24 ++++-----
 sound/soc/codecs/lpass-va-macro.c      | 12 ++---
 sound/soc/codecs/lpass-wsa-macro.c     | 14 +++---
 sound/soc/codecs/msm8916-wcd-digital.c | 14 +++---
 sound/soc/codecs/wcd9335.c             | 36 ++++++-------
 sound/soc/codecs/wcd934x.c             | 70 +++++++++++++-------------
 sound/soc/codecs/wcd938x.c             | 10 ++--
 8 files changed, 112 insertions(+), 108 deletions(-)

-- 
2.21.0

