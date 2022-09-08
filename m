Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE945B14A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIHGe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiIHGey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:34:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF23D582
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:34:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so1539105wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 23:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tLJi+1w8MGj6nplunwfzLCX3uDNlAZf3MHgDHEZL7Y0=;
        b=ViX7+BLaUNPNjuus8Uy3mY8zMA8xwBvhnAt7lISD+fG1MbEQHdxoQFqE8eWQzmNLSB
         Q18yoMXueyqrFpQaJ+XKhiUlOtv1FTnU+7Gm24QDP1SMd2pqnBoaY8llHZA3T72i6GjS
         9oP5NZdd36MOz74OQDmwHTgMLb458ju+f49bxUTB2lnVuQWS2oF394OGuDd1LF+7eav6
         0/EAM5IU3acuhA+7rXT1G7YsWrma30SUIN7bnrpYpUZaKn/SNM/dd8JvX61eJBCspLLu
         Y8IyH6sSMHvlyj1EtBvzBnnw6mEY9JosZaWiZq1MbklzeprFr+EzHwAiHWoVPX1wAT/X
         8XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tLJi+1w8MGj6nplunwfzLCX3uDNlAZf3MHgDHEZL7Y0=;
        b=k+0uLJQKdBArjuy800iwPiZzenKw0k2uYRhO7s1OEzwGpn2iWe2tdjFYXglfsInWCF
         21EXD3jjVZR+uz9crJ/YzsyEywWnJ2dCpBcA66WZmkfL9XCYwuy2B8/4tVFtghz+Kq3b
         xa/02aGASnGmy0818HHRWY9TIJw3/Yf4DShmshmJo4QMXKulnurODwJgZ3ZJB9QeDnIj
         syRaRi38EzQRAueORpYtrq5+vHyFu85o5rKmqQ29WVmAqhkq0MBzJNwvsqTx9cMtxV4A
         rWWM0mUXTV9WX7A0Z2iHxYg01+xM9u2cjj4lGWmpJsld3CfZ1WqmwyLtf7zrg7up+Lyx
         MyPQ==
X-Gm-Message-State: ACgBeo0k1jlg4ZJPMI8nHqc2eUS7geEnoFQgjkwLeGXKxg+sjhU9H4uz
        Iqjz3NUMjqTQnAtWDUixmK4hQw==
X-Google-Smtp-Source: AA6agR6s//9gR1fHhZrBCiqxjpoMfwFUfUsDvdRjpzedhvYN3EZbN7hnJaY5j8CiNI4QI2dCOqI7Cg==
X-Received: by 2002:a05:600c:1c1b:b0:3a5:e6ec:d12f with SMTP id j27-20020a05600c1c1b00b003a5e6ecd12fmr1106946wms.2.1662618891588;
        Wed, 07 Sep 2022 23:34:51 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c4f4300b003a2e92edeccsm1549598wmq.46.2022.09.07.23.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 23:34:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/4] ASoC: qcom: add support for sc8280xp machine
Date:   Thu,  8 Sep 2022 07:34:44 +0100
Message-Id: <20220908063448.27102-1-srinivas.kandagatla@linaro.org>
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

This patchset adds support for SC8280XP SoC machine driver.

First patch moves some of the commonly used code to common from sm8250 machine driver
and the follow on code adds minimal support for sc8280xp.

Currently this driver is only tested with SmartSpeakers and Headset
on Lenovo Thinkpad X13s.

Support for sm8450 is tested and I will post the patches soon.

Thanks,
Srini

Changes since v2:
 - put SoundWire specific symbols under IS_ENABLED check as not all
   Qcom plaforms need SoundWire that use common.c

Srinivas Kandagatla (4):
  ASoC: qcom: common: use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
  ASoC: dt-bindings: qcom,sm8250: add compatibles for sm8450 and sm8250
  ASoC: qcom: sm8250: move some code to common
  ASoC: qcom: add machine driver for sc8280xp

 .../bindings/sound/qcom,sm8250.yaml           |   2 +
 sound/soc/qcom/Kconfig                        |  11 ++
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/common.c                       | 173 +++++++++++++++++-
 sound/soc/qcom/common.h                       |  35 ++++
 sound/soc/qcom/sc8280xp.c                     | 157 ++++++++++++++++
 sound/soc/qcom/sm8250.c                       | 152 +--------------
 7 files changed, 386 insertions(+), 146 deletions(-)
 create mode 100644 sound/soc/qcom/sc8280xp.c

-- 
2.21.0

