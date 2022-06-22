Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAF155433E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350037AbiFVGsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349644AbiFVGsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:48:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CD335262;
        Tue, 21 Jun 2022 23:48:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e2so11551832edv.3;
        Tue, 21 Jun 2022 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vCNv91lDUYC1ObatJgypBEUspG3u2nt9MFwNwpMHlY=;
        b=WvjO6aEPHVl6NWj+rBneUsyMVQVj8b3aFD8zeW9ZRmMzMTxTn5WeXxEAz70gQh2six
         srNyRlbCfESuGMYbwR0sgUz8B/VRB2JuglPmqNm0HJyPuVN7PMo+GCfsjgGaGqZQ1VFd
         LrifXViCqSZvxo9FLNHGSiTRrtNM6Kk9M1bmK5AmkWJnv49PhTHjixEzkpv7QGpi25IX
         96yTYmjJ0sOpglNbCaW5dSUxRR5nBprHOhTmWAAvUqhsbrJeEna9OptN3BgdYK2yGCIh
         T2pdMl9ARZoBIS4FJL9aj9s8ULztEar2KKqKm9wW2uH+k/UVlVDu2KtC3+W8m0J8K7tb
         suTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vCNv91lDUYC1ObatJgypBEUspG3u2nt9MFwNwpMHlY=;
        b=Zv8IvrflKF7usg56nYA31hPilocLBxpH+vhajr/uwfHef/mqBeun89R1032soAxDeV
         fo1oUr9g+YVXCGHwzf9wMKouncyk+qA/Rvlvn7c7vD4Vo7Nz1sxND2UZcDxtLqNEfaV0
         H2mgdvPk9YBDFJzPxDo5gRRq5XBnfoRMw8Pxj0iSPLHftejAciM2Nb165r7EVL9dRiHE
         xSQ58Q/RMDEQ1Kg+iflT1h2/l+1C4+gq2XEGAktOYFNFrTTUlBRPGQm1YwQ9kKsXPVOp
         eyqCi3Zn3D7H2O97rR8L4NOGwTr2lDeKLARAvhSsz0KurQZmRRISnCzINMg4AVQVAL7/
         UOqQ==
X-Gm-Message-State: AJIora80nuM1aLF8salRAQOmbC+wR8r7VrbLKwxyQV1E9RgdIAVUELxk
        u7ytiPuhhK+HKU/InZOMQX8=
X-Google-Smtp-Source: AGRyM1v8YkOgNlmT2qmgJxXXbW+mbt9cVRBo3XaM5Ir9A43ZII38kJ4FcYczx0jaUtyfiCbx3bTYyw==
X-Received: by 2002:a05:6402:2788:b0:431:3f86:1d4e with SMTP id b8-20020a056402278800b004313f861d4emr2372103ede.238.1655880508087;
        Tue, 21 Jun 2022 23:48:28 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
        by smtp.gmail.com with ESMTPSA id sd12-20020a1709076e0c00b00722e8c47cc9sm1197148ejc.181.2022.06.21.23.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:48:25 -0700 (PDT)
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
Subject: [PATCH 0/3] ASoC: dt-bindings: Add bindings for WCD9335 DAIs
Date:   Wed, 22 Jun 2022 10:47:55 +0400
Message-Id: <20220622064758.40543-1-y.oudjana@protonmail.com>
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

