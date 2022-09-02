Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB92E5AA8FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiIBHmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiIBHmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:42:51 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0B0A833B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:42:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so1286121pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 00:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Lfyy8dLQgoFKZtBDJ6fyaqkz/t8A+UW1YcDjEL4rq5Q=;
        b=iFCVe+5bwiCRkvsOMncfGz0ouL3Sg+txM/UTmSOJsDhP6m+4sE6FiCwQev6a1GMm8E
         1I+WGAsAdo34wOlK2mcakCqXFJ0tiX/lnzzLKUsEkqaH9kxf0JpZVR7acL+nzbFSlFe9
         B2Zzj699h1TlhVKgVb3SMLlavAnJmfL37EyJQDqrks5hi2Nh43Ye7qGlvX0gCgAs5EUY
         ii9LNmt0/EGYeiHauhhQXRwHeAt5U06pKd4dtDhq8DsKHhV2FWG8qe+RrZuIAG37Vjme
         3iAhsUu+V+M7k9saZXAA21Uaqb0bVEONgv1dzT9Hrg1MYU/as01I7hQngih3M0KLc0cZ
         2wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Lfyy8dLQgoFKZtBDJ6fyaqkz/t8A+UW1YcDjEL4rq5Q=;
        b=XqMgNjoGSzIzZHhO2AHT9ZhUWsNMHIzkukY0nC9owVP8jajSYXt54Dy7KMMXdv+8Bd
         Kl7YplFbaudo+Z4RFZ+i0xUQ+UtTkbkmziEak5hT1voV7PWVR4pQz71TbRw2vHmcUrWC
         BS127u0ikZ7bb3rfRs/4yJXQZ8X71P9GkVmD3yenLRkt2IU9EBLaN6H3KkN1DouIFTfq
         iLHkb3LgXGyPUBnYIiOW/LFcQ0Hz74ci3eKKV061pFtwo5Sem3ZkmjmIjcIsZ2Sn7KPD
         +89QeIvt0pUAfd790llhriUrQ3UI+LPybdLOyku9BgKfzrtCChJJanJWWRmCFN8wVBWb
         PRzg==
X-Gm-Message-State: ACgBeo3+oS5XgrD7dlXEvKrVbAV2mGJPlUEoct/NVLHaLskUuCgWZUHo
        +zIbPRjCblbDiXc0EDzgb0GNuspkKLAosw==
X-Google-Smtp-Source: AA6agR4mlLPaXxDGgRj5JSsMKDcIm0FTPCzwJ+oR1NS/dtcTcO5nu8/rehrHCyhQAEampHMjUbeGVg==
X-Received: by 2002:aa7:8a0b:0:b0:537:f5f1:fd91 with SMTP id m11-20020aa78a0b000000b00537f5f1fd91mr29589113pfa.41.1662104569939;
        Fri, 02 Sep 2022 00:42:49 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id f21-20020aa79695000000b005363abb6d0bsm975099pfk.15.2022.09.02.00.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:42:49 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, mka@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/2] Add a new board device tree named 'evoker' for herobrine variant.
Date:   Fri,  2 Sep 2022 15:42:38 +0800
Message-Id: <20220902074240.117075-1-sheng-liang.pan@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the initial dts file for new board 'evoker'.

Sorry about getting mixed up with version numbers. Here are links to
previous postings and what I'll assume the version number is:

v1: https://lore.kernel.org/r/20220830053307.3997495-1-sheng-liang.pan@quanta.corp-partner.google.com/
v2: https://lore.kernel.org/r/20220901061336.61386-1-sheng-liang.pan@quanta.corp-partner.google.com/
v3: https://lore.kernel.org/r/20220901091253.93333-1-sheng-liang.pan@quanta.corp-partner.google.com/

Changes in v4:
- Got the version number correct
- Got the version number correct

Changes in v2:
- Bindings patch added

Sheng-Liang Pan (2):
  dt-bindings: arm: qcom: document sc7280 and evoker board
  arm64: dts: qcom: sc7280: Add device tree for herobrine evoker

 .../devicetree/bindings/arm/qcom.yaml         |   5 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/sc7280-herobrine-evoker-r0.dts   | 333 ++++++++++++++++++
 3 files changed, 339 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts

-- 
2.34.1

