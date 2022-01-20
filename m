Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3134956AD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378162AbiATXUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378150AbiATXUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:34 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A82C061574;
        Thu, 20 Jan 2022 15:20:34 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c2so14917452wml.1;
        Thu, 20 Jan 2022 15:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UcYnZJXwLc4lqt61bDMxR0ZCzh1Cztx6cNOepvk0MLY=;
        b=nTTF8cYS2m6KU1k6dDIAzQbGDUksZ5cKjfvNW29C0S2hzZ1W01qXV1KRIXsmmNYiXW
         PdiY8uwWqR7otOigA/UA/SGWOS6cNZXorhI6NtQ9SwqxmYTECjjAHmc44+d5LAxOEKTm
         BKUXfynB6E+GNcQuCOtPuLt3qRbq73N998WSH0NF8PBFZ9ftoRFLZ75V1WRe/iN5vJAG
         utPb4je50FojpMVbii3D9cN3guQzwKV/E4FqiUxISeDuNtEpzQXBjVxkZP4FNrC8lgiJ
         3pCeAlILnMG9oA0UXZET7V9zgl/+JqD/VNxb29G2y7cghOE9ioCKQYSM16m4p1t9KwYq
         cvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UcYnZJXwLc4lqt61bDMxR0ZCzh1Cztx6cNOepvk0MLY=;
        b=5AJ2aeofEuhVQFNyhdP295JCmw+fR/RoVq4YWnh7IAKiF7dvJxQuELG0ODzl+2JXnS
         8fjPujgVrxhkgElet2Y6UBWlyaWR4DDvZkTy6SuMaV9BkrfkccitIxh4SjRDTpQ3CfxW
         xb4LnhZcC/lH8G+QKMqMz7zOeS/qFjkTQVCjj5P6Ide88qOXcwzXaY/J3lSjpEycBLuz
         YyC1niAfm9czmNcnDbEbvX4YgQ4Kdtgm1x0jhmZSlIfB4L8la7Wxo18iUu+mu6X3gYVj
         BMjrjuCylVRgJojA4DwnSNL0aX91c2ZmHaCj/l6H8Z5SEpGXAx5wXIyPH/3oCe2bHleA
         IgHQ==
X-Gm-Message-State: AOAM533B6T+eH87Lg+j8HS6GRmAwfsYKuxWmKeYWT3z5/Th8avzUlTcD
        yZUK6ybt3d3gEyhTXxg/i9+qbbLv4Qo=
X-Google-Smtp-Source: ABdhPJzDbjksy4Dl+Wf8rgiRdVl1Eoz4qUD4mBjgoaOMNROY12cBUof5no8oj1J7KSBssDI+9j163Q==
X-Received: by 2002:a1c:1982:: with SMTP id 124mr7154025wmz.50.1642720832322;
        Thu, 20 Jan 2022 15:20:32 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:31 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/15] Multiple addition and improvement to ipq8064 gcc
Date:   Fri, 21 Jan 2022 00:20:13 +0100
Message-Id: <20220120232028.6738-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt in making the ipq8064 SoC actually usable. Currently
many feature are missing for this SoC and devs user off-the-tree patches
to make it work (example patch for missing clock, patch for cpufreq
driver, patch to add missing node in the dts)

I notice there was some work in modernizing the gcc driver for other
qcom target but this wasn't done for ipq806x. This does exactly this, we
drop any parent_names stuff and we switch to the parent_data way. We
also drop the pxo and cxo source clk from gcc driver and we refer to the
dts for it.

This also add all the missing feature for the nss cores and the
cryptoengine in them. It does also introduce the required flags to make
the RPM actually work and NOT reject any command. There was an attempt
in declaring these clock as core clock in the dts but this ends up in no
serial as the kernel makes these clock not accessible. We just want to
make the kernel NOT disable them if unused nothing more.

At the end we update the ipq8064 dtsi to add the pxo and cxo tag and
declare them in gcc and also fix a problem with tsens probe.

v2:
- Fix error from Rob bot.
- Add additional commits to make qcom,gcc.yaml a template
- Squash parent_hws patch with the modernize patch
- Create gcc_pxo instead of using long define.

Ansuel Smith (15):
  dt-bindings: clock: permit additionalProprieties to qcom,gcc
  dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
  dt-bindings: clock: Document qcom,gcc-ipq8064 binding
  drivers: clk: qcom: gcc-ipq806x: fix wrong naming for
    gcc_pxo_pll8_pll0
  drivers: clk: qcom: gcc-ipq806x: convert parent_names to parent_data
  drivers: clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
  drivers: clk: qcom: gcc-ipq806x: drop hardcoded pxo and cxo source clk
  drivers: clk: qcom: gcc-ipq806x: add additional freq nss cores
  drivers: clk: qcom: gcc-ipq806x: add unusued flag for critical clock
  drivers: clk: qcom: gcc-ipq806x: add additional freq for sdc table
  dt-bindings: clock: add ipq8064 ce5 clk define
  drivers: clk: qcom: gcc-ipq806x: add CryptoEngine clocks
  dt-bindings: reset: add ipq8064 ce5 resets
  drivers: clk: qcom: gcc-ipq806x: add CryptoEngine resets
  ARM: dts: qcom: Add syscon and cxo/pxo clock to gcc node for ipq8064

 .../bindings/clock/qcom,gcc-apq8064.yaml      |  27 +-
 .../bindings/clock/qcom,gcc-ipq8064.yaml      |  70 ++
 .../devicetree/bindings/clock/qcom,gcc.yaml   |  41 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |   8 +-
 drivers/clk/qcom/gcc-ipq806x.c                | 638 +++++++++++++-----
 include/dt-bindings/clock/qcom,gcc-ipq806x.h  |   5 +-
 include/dt-bindings/reset/qcom,gcc-ipq806x.h  |   5 +
 7 files changed, 581 insertions(+), 213 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml

-- 
2.33.1

