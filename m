Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F40F555101
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376372AbiFVQN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376571AbiFVQNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:13:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A71E25E9F;
        Wed, 22 Jun 2022 09:13:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c13so20139110eds.10;
        Wed, 22 Jun 2022 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cE/2OYYz5mN+xKGqyzZkM7i8jyDkRjpQ6WY0c9nnpkI=;
        b=nUQ08BYK5oFMjhuwIdhfb68k27dg61OmpVwaXYMS2hbVZ9fdyf4oALt66tdaAUL1B3
         rWBbo4MtyGKruasxn6e7dLhgHxT7LvmG0Pv//40q50rgMdT2GxH75jMdCs2hmJWfoBAA
         b0rday1T6F/TkSeyE2Q/HBQBDt5gmvhgDjldLPtLkUD1T2+gjpW9bvme1SJnwqbMN4Pg
         m2ToIWwJfj8bYsPP2DD4hddV+T6+336irst/x0Qkk+OmjsdYvg5Cn72N7wSYlVDKsKAv
         t/xheAfXiJoPoZL/hy7MrwiCT23C/OylmEHjICTSiQq0MSMLxXIvM87lGKoLoy7Ag+0e
         aYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cE/2OYYz5mN+xKGqyzZkM7i8jyDkRjpQ6WY0c9nnpkI=;
        b=rG46YWwaT1ZlnUHJNnYLBqCAUBAFOrl0Bo4tqoiIA6nfJEBFaAH0oO+IX24llsGIZ5
         7PxtQKcjjiUUxsfj1CIeVKnXb/XjceUonDllX9UDFBRi4qjLiWrdp26BW4hHhZxZGDOD
         Byc17Iy9d25cPo08+uTExJUPLJC5i0R79N+vPjAAqMuRI6oGX0reEkQs+fqfGOQxe/un
         2X7YMOhFupeFHiM2vjFVSxS+xNKLD0F5e3vpLQQFlxJxf6ENJSZ4zsXsqdZCieRjj0/r
         YaKQdNbeqtWsdH75fe1oEX8LpFqU8/a29XkoOFJg73HxsEg+g7Fr9Sybe8kzaVqNjqU0
         al+w==
X-Gm-Message-State: AJIora88chQXhsgato30gS/5kiZ2wq3b150Bgf6g9wBkUZdij4pbv2U9
        zm//uvMfSB3Q319w9PyFZCs=
X-Google-Smtp-Source: AGRyM1tWD6g6LO0qhLnaY9KN6b/00f7QxioRtjLEKur7v1cPD63I0UcdtnaoF4NQCs9CgxoC6rjd9w==
X-Received: by 2002:a05:6402:348e:b0:435:a912:355f with SMTP id v14-20020a056402348e00b00435a912355fmr4947487edc.326.1655914429451;
        Wed, 22 Jun 2022 09:13:49 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
        by smtp.gmail.com with ESMTPSA id sd14-20020a1709076e0e00b007072dc80e06sm9576036ejc.190.2022.06.22.09.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:13:48 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ASoC: dt-bindings: Add bindings for WCD9335 DAIs
Date:   Wed, 22 Jun 2022 20:13:19 +0400
Message-Id: <20220622161322.168017-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for WCD9335 DAIs and use them in the driver as well
as all device trees currently using WCD9335.

Changes since v1:
 - Make header guard match path
 - Maintain the alphabetical order in msm8996-xiaomi-gemini includes

Yassine Oudjana (3):
  ASoC: dt-bindings: Add bindings for WCD9335 DAIs
  ASoC: wcd9335: Use DT bindings instead of local DAI definitions
  arm64: dts: qcom: Use WCD9335 DT bindings

 MAINTAINERS                                       |  1 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts       |  5 +++--
 .../arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts |  5 +++--
 .../boot/dts/qcom/msm8996-xiaomi-scorpio.dts      |  5 +++--
 include/dt-bindings/sound/qcom,wcd9335.h          | 15 +++++++++++++++
 sound/soc/codecs/wcd9335.c                        | 13 ++-----------
 6 files changed, 27 insertions(+), 17 deletions(-)
 create mode 100644 include/dt-bindings/sound/qcom,wcd9335.h

-- 
2.36.1

