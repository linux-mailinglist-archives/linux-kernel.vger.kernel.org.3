Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413274C727A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiB1R0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiB1R0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:26:20 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ABD75E67
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:25:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r10so6113672wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=notYzvLapgrWxhvzTWLvUQkyjm1+ISszqSAt8pZdOYI=;
        b=Zgqher2oa92fGjqwuNd7AvQQL/prMgpwurC/1I0Q2XMCq12BsIydAK7Xbt2y6WEZ3d
         O83ghC4YWK0y7SASC9sfrraEmmCPIDC2yLy8LRMQ322ADA+msYp3dut1AKFazt1n85qG
         XAcHAU8f3A2PHmucP8HfrHUQW3D26YfuYfqnTBpTXna39MTgxw8uW0RpMvyPk3xXbryw
         OExK2vEy5eszJh4APgr2NWDP16vNXCINoVIVFMusBl66Q0sGeLGqCFl8uIwQ71XQCC/3
         /DD5nsu5Rn4vrpuvTBGcOQmGgf9w0hHWRJaKPGWbh8cOuLN4O78lW+e/LjUsMid3Fkdm
         JceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=notYzvLapgrWxhvzTWLvUQkyjm1+ISszqSAt8pZdOYI=;
        b=F17T1cBxvGVDD/HIHC5DcjeTbBJ4w+7ou+RhHNWpD1i+uUqeK+7vqog4Byjz9BZi50
         TJfhGWx+yQ4zTSppAEpkhqsYF8gr8GC6jxs2TcQmJuJLFAsDqtJkqinjcInW/oOxL97N
         A2yY5cWGeKyATk2LfFWRt8HYaPLWBnQn8foi3gMrkOmr8ZlDZNXZS0iSrSQJFlZXiF95
         Z5u8UGoAchIOLXImYRahsEAN2nCFIOb6/dhmUgLbbj1PhNVbjpprYaku0F40XVnEGJuc
         Yg3I2p7wZ9eeL9HL3LEaGc2IU8TjOYD4fVNID7UkFkx+mNMYBuqyP/NKiGSGBL0vbgPu
         717g==
X-Gm-Message-State: AOAM531Kh94IlY/wamTU9A9+McpgnOTm/Ef25ELOp+pzc0sZKia2CJRB
        QavLmSINWn71g4kkcuXo3/7VIw==
X-Google-Smtp-Source: ABdhPJwJ+NcsdjBxdhB1UyDeneF5rEqwUWcp9CAfrUzldwkhCgyJIZBroO5q5TvmPYAd8SU7IOWwyw==
X-Received: by 2002:a7b:cc15:0:b0:381:3fb8:5f93 with SMTP id f21-20020a7bcc15000000b003813fb85f93mr12592663wmh.106.1646069139944;
        Mon, 28 Feb 2022 09:25:39 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcd15000000b0034efd01ee16sm11514124wmj.42.2022.02.28.09.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 09:25:39 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/3] soundwire: qcom: add pm runtime support
Date:   Mon, 28 Feb 2022 17:25:25 +0000
Message-Id: <20220228172528.3489-1-srinivas.kandagatla@linaro.org>
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

This patchset adds pm runtime support to Qualcomm SounWire Controller using
SoundWire Clock Stop and Wake up using Headset events on supported instances and
instances like WSA which do not support clock stop a soft reset of controller
along with full rest of slaves is done to resume from a low power state.

Tested it on SM8250 MTP and Dragon Board DB845c

Changes since v2:
 - update log as suggested by Pierre
 - removing handling clk stop for cases where the controller is soft reset.
 - add more error checks when calling  sdw_bus_prep_clk_stop
 - update dt-bindings with wakeup-source and interrupt-names properties.

--srini

Srinivas Kandagatla (3):
  soundwire: qcom: add runtime pm support
  dt-bindings: soundwire: qcom: document optional wake irq
  soundwire: qcom: add in-band wake up interrupt support

 .../bindings/soundwire/qcom,sdw.txt           |  14 +-
 drivers/soundwire/qcom.c                      | 206 +++++++++++++++++-
 2 files changed, 218 insertions(+), 2 deletions(-)

-- 
2.21.0

