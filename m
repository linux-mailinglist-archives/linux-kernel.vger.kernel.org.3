Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4505A5B24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiH3FdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiH3FdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:33:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA4B2768
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:33:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p18so10052437plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=w6puNWUdmCEZz3KOWRnrYLL1CsJ0Myuynar/42oM5DQ=;
        b=TzrvAdKWiM/dm2+3A4WDCQkexEAqcEzO2tuZF+uTbWGXY0x7VbQLi9TD0E91e67H/l
         VZvAxG2RD0a5ysLIQ1PnD4w7lSe0YivrL3SGVD7E65lYHrRhPJsQwCVsfJNe6Fv8oQ0j
         smSgwf0hDbfTztjeMY/GpL3fKpa2G/tjDOkEe+kqbac0GUSjl9AuZGPC1Mu0m9sFw1FA
         2a16+4LqzlyjPzEYAHXQrWNeS7TvvRR1nvoDy4QU1rY1qhwTBR6Md6xhC7IsyvNDCoxE
         2H0KiySApGVm7HoGRQG+t8smoEjTBGbjehg+HjX1cznFXx6pahBGM9F6H7R6NpRPD8YC
         8tfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=w6puNWUdmCEZz3KOWRnrYLL1CsJ0Myuynar/42oM5DQ=;
        b=CPnbJO5m/XoZ2O1pzsEOXgnojfDeTnDorZIuJowrjf+dLGl9Qp9RZEq+fqCLTkHV/S
         SJ5jR+b0eeH57Csz5JmsnowoQN5esGcOx4EdujrxWmA47tj9h6rBteRNAPVeL0+105SJ
         QzLKZorRvJ+7SlRehZ5x/HVqM30vsazj0mu7msROW1nnpqqN9f8j8pNCylSc2tW6pwVu
         nAiQLNTE7MOjyv9HREib7s1XfTVi7+JnQ2vihWPUWnB6J83PWz9HzysWc03U9ISoscaJ
         736ZTreqFKD0PHof6ShDB6hnW0uuF0KZsegDkqlI8BbtWo6XPEHwzegVaQZPNcYOZAte
         tMPw==
X-Gm-Message-State: ACgBeo3tUbzPHX5PxXEv5iWFS9gtp1v2iZ03wsF9yRp2Mkk4rLk9CaBq
        8aLG0k6vDP6LHHLvndyp/inYMHWQ/7ZdRQ==
X-Google-Smtp-Source: AA6agR7hgWFW0HTJw7+2waYI++OU0B1ehp3NZhgbCfBdU40N12YpDSsBt1V6Zvsod6DSecQmk7WwOg==
X-Received: by 2002:a17:90a:e7c2:b0:1f4:feeb:20ee with SMTP id kb2-20020a17090ae7c200b001f4feeb20eemr22114745pjb.114.1661837594636;
        Mon, 29 Aug 2022 22:33:14 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id d24-20020a63f258000000b0041d6d37deb5sm688578pgk.81.2022.08.29.22.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 22:33:14 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     mka@chromium.org, dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/1] Add a new board device tree named 'evoker' for herobrine variant.
Date:   Tue, 30 Aug 2022 13:33:06 +0800
Message-Id: <20220830053307.3997495-1-sheng-liang.pan@quanta.corp-partner.google.com>
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



Sheng-Liang Pan (1):
  arm64: dts: qcom: sc7280: Add device tree for herobrine evoker

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/sc7280-herobrine-evoker-r0.dts   | 333 ++++++++++++++++++
 2 files changed, 334 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts

-- 
2.34.1

