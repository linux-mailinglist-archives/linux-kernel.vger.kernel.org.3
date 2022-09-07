Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015715AFA3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiIGCut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIGCun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:50:43 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEE679620;
        Tue,  6 Sep 2022 19:50:40 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d16so6937378ils.8;
        Tue, 06 Sep 2022 19:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=PTbgBQFoCpsL8V4bWZ9yChUr0r7Xt+cfSz7f0GdYkmA=;
        b=IXpCcwdJQpo/8agJzZPu7AR2DXJnJSYPLVdBJ6O1AnxNcG29CepqkPjQdexNTYBzaE
         PSY8f15AI+vkn9jiKVDnW4YXCQxtQ/cM2Ogurq/Sk+uLKbk+HWlL/ixxfsLcxmk70LcQ
         3BP4WxjRd3aMHX+j/KTi+8IdR5CzGlbVK9ODdCixWWmbs7iRF3eCxctdE3hqThDn/ORz
         hLi76NWMApFUYzTnJzJ6lGcXJeUmcGVgJlp0NSJWypn4CdexoP+SkqL6+iCBKPxqc3zH
         kFIF766utGZ+0IhGz+bmR3X7WhPnquwDD0lb1F+8IGePxH5JfFmxCz5GYNqXd+1pZFCJ
         Q3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PTbgBQFoCpsL8V4bWZ9yChUr0r7Xt+cfSz7f0GdYkmA=;
        b=41mnjjygRxzJFG2+3+k3P2wgLk+Qz2rOnmjlWwXXYcF9yXlhoMwDwvtXqKm91JErDc
         SDjdp1D0Lq6ks/ja2wHlMkd+NJgHQ/IkfGl9DOglTglgdSXncbdHGHE6kpfVq4V71ig1
         kPUFnaut9998bXAR/Cz0S6e46XOdgAwEW0iAI80DLdTu534JPweO2n0Y3a7Qh0CJZHTf
         B9IC8qz1MwIY8TQ8m01RBkEAKJ1WCs0VUjZT/CReb5PxmgHucXa9rAIBGEMtmK2ETxrY
         AT21iLhsoB3oB6/rKz+9nzr4Jllz84Nm/zihxeqGd6NeR8kS2Iw5HBusSIzc+C91DJep
         UoFQ==
X-Gm-Message-State: ACgBeo0TDmsfoB7RV9TbkQSqYTUiK0KuW0xOMuxC7rpsKlH1UoeZX836
        rf2vNGm0ttZPhQGiBnOn/5XeKMeCJ8w=
X-Google-Smtp-Source: AA6agR5z8xqo9YfX9eJy1Mm90l/HE8qG9kBwDI2stTzw2/DOYF7Kb6/UGA2Y1ehYoK4QEUXnzjFZMQ==
X-Received: by 2002:a92:c8c9:0:b0:2e7:1d41:2091 with SMTP id c9-20020a92c8c9000000b002e71d412091mr844241ilq.100.1662519039893;
        Tue, 06 Sep 2022 19:50:39 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4aff])
        by smtp.gmail.com with UTF8SMTPSA id u63-20020a022342000000b00349fb9b1abesm6490966jau.106.2022.09.06.19.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 19:50:39 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in
Subject: [PATCH 0/3] SDM670 Global Clocks
Date:   Tue,  6 Sep 2022 22:50:32 -0400
Message-Id: <20220907025035.15609-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
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

This patch series adds global clocks essential for features of the Qualcomm
Snapdragon 670 (hopefully) cleanly into the SDM845 driver without doing
runtime fixups like in Google's bonito kernel (see patch 3).

This series (mostly patch 2) affects kernels made for Snapdragon 845 and
might need some further testing on SDM845 devices. I do not have a
Snapdragon 845-based device so someone else will have to double check if
it is necessary.

 .../devicetree/bindings/clock/qcom,gcc-sdm845.yaml |  24 +-
 drivers/clk/qcom/Kconfig                           |   4 +-
 drivers/clk/qcom/gcc-sdm845.c                      | 405 ++++++++++++++++++++-
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |   2 +
 4 files changed, 426 insertions(+), 9 deletions(-)

PS: This is my first contribution to the kernel so I apologize if I do
something wrong.


