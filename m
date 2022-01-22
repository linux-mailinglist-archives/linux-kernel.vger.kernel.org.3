Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629A7496890
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiAVAQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiAVAQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:16:23 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEAAC06173B;
        Fri, 21 Jan 2022 16:16:22 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ah7so4286471ejc.4;
        Fri, 21 Jan 2022 16:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVxyJXWhy0tpu5DrmtdQpzgyw4D9rKCj49KBU5En5c0=;
        b=YPgHxz4KYdEMjVZXsY40brCFiBjTCg7+LfPl/LB+1nzbrZrbQXaH3ZvYquTdwM3Fvx
         3quIxLVTPFCEe/ihjfLfoVQwTxuN0fqios4CtQx9LriARL22G+o3gsXhEbeKnZkeAjtc
         aLMckvTwMo0MGNnXPN8iaeqC2qDp/Sfm7WBG10GgglYqEaW2uYfiwo9WePpM1LKBLc8r
         XDSN9EhssaUEhNwZv5cVy8r2BCIM5MG3n7Vx3BwgvyL87fOZl9Lhf/JYtNsBsaDUztFO
         zPa34idV5qyJyOTACmvkjHArxYyUe+RfySKOizyUqzHNgB4Y1yJiwj4egtojSfB0KRaV
         5t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVxyJXWhy0tpu5DrmtdQpzgyw4D9rKCj49KBU5En5c0=;
        b=rJfYLSzgPmNkzzhbaTGw8DMI+qk55ahh8rpg59wsUxP7IrV7/M3qTG7ny8v3bfvqXJ
         aKYi32zNi+HWaI1xtvYKxj0KcFy7aJyLUaWulUMck1My1i8pj3xks/246b5xlVqw906X
         Sr4Hlb+oZrscOhX/D/MFGpdOH3GI4MKZ+zsbgh/XjXiYeJ8h6hCZXIzeNfG6yzyU81MJ
         1QZOCFnEbuVnnR5Hpm1AkLKxgWFKXEV8HjkffYaulkt7W7R2koAQK1yOgpN/bBsaVz8Y
         TAfJ33ZixsO27UqM3TPVzZiHPAQCluYpNVG73X1M0e9mIj+ipsLZbifCj6Hj3Q+k0rSl
         m+iQ==
X-Gm-Message-State: AOAM533AHkKld9T0f61ceAF8A4BkFMdaeZAkDi9/BL275SeILSC9qWTH
        9SvSsxBnpJFN1oPXT4Gz2h8=
X-Google-Smtp-Source: ABdhPJx5dxEYFlHchVgEksbnO7od2Q0Ctk+p18N6AR1Sv3jJcEcVrQ7bBnsb5yXCXyius+quJDBbEA==
X-Received: by 2002:a17:906:3e8a:: with SMTP id a10mr4941679ejj.352.1642810581047;
        Fri, 21 Jan 2022 16:16:21 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d8sm2445525ejy.107.2022.01.21.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:16:20 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add QCOM TCSR driver
Date:   Sat, 22 Jan 2022 01:16:07 +0100
Message-Id: <20220122001609.15904-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another try of the long gone TCSR driver needed for ipq8064 and
now also ipq4019. The first (and unique) proposal for this is back in
the 2015. After that only part of this got merged, to be specific a
variant of this got merged to support gsbi driver on ipq8064.

All the "configuration" part was never merged and without this ipq8064
SoC and ipq4019 SoC require custom patches to be configured correctly.

The driver itself is really simple. A syscon driver that configure the
system based on the passed bindings. All this stuff can't be moved and
handled by another driver (for example dwc3) as it's global and has to
be set only one (we have 2 dwc3 port for example)

This is necessary for some devices (especially ipq4019 based) that
require some special configuration for the internal WiFi chip memory
configuration.
Ansuel Smith (2):
  dt-bindings: soc: qcom: add qcom,tcsr bindings
  drivers: soc: qcom: add TCSR driver

 .../bindings/soc/qcom/qcom,tcsr-ipq4019.yaml  |  93 ++++++++
 .../bindings/soc/qcom/qcom,tcsr-ipq8064.yaml  |  47 +++++
 drivers/soc/qcom/Kconfig                      |   8 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom_tcsr.c                  | 198 ++++++++++++++++++
 5 files changed, 347 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml
 create mode 100644 drivers/soc/qcom/qcom_tcsr.c

-- 
2.33.1

