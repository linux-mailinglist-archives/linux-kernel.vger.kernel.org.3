Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A048B44F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbiAKRsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:48:47 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53816
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241290AbiAKRsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:48:46 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3882F40036
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923325;
        bh=qlkFuTgP9uFlSrp3JI1NgXZW8hFQsnWbyi8YbpE5nEo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=pwnhnl1U/iLonrDI7gxMLDkea7xGL/WsRxA++ifrqBD+uolHx3hvsVW7uNsgTrWbr
         tV9pfmyqrJ8+3feiuHWkegW+zDgjIj4UHTLU5pEJZkBS5NHu9X5S1LLhuspPDHpRLP
         4QJqwYF2HMatbESwFL7X1wJzJQuOlJtwgnHO6ikqwgD2bnJfua+usCDPb1oQj0K+vN
         ZbqDqWoPpptnLZEeyHamz1YWRAmpft48nMC00F14mh9+Fenj/t2biCBm0m6UHO2pud
         XAS0YzFNNq/pwRsXrybOFn9MS2MMIAbk5Ax2FhuGTTja+gU+Nu6OavmAvuXjZKnsOS
         Y6GkXiNSvnXwg==
Received: by mail-ed1-f71.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso1348604edw.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlkFuTgP9uFlSrp3JI1NgXZW8hFQsnWbyi8YbpE5nEo=;
        b=OLTwqwPpc+dQRrsluTRAapQ00lN+a6UlK3QzZo3xcIqO2wp/qeEBZBFbOhdns7aKE8
         +hn0qCoZHLOm37Er75LnuYdFjaeeSpxdiYXOPTzd/ZDU+Chl3OV+nw5Kvy7pZ48xGsTA
         nrpis4OmVyQAhIMxJeZTeM6YQ3VJlLcxAyi6l0j6zlDVXu5vOqqJyMXymAs4PQA7DsBE
         6IBLzUOv0DFybb8LbVF2g9ZXN8UhyFSFr6SOhMWgitJytZa7lIYkPuJIP5HED1qBK/pE
         CyjT5TUnDZ7fMcxMIMI6C9vPMmB2r9XH3xBfGno/neIzH9Hw/mc+jJW1ij9FWMh5/X60
         9spw==
X-Gm-Message-State: AOAM532yf+pQd4BK6VHk38VjrZyUgiFR+dZgVeRgczgM699JbpYGikj3
        Ao9rXdcyx2JgAc38PBPtJ45DAwf58zcD/+T6rrSHWVngj22KzM72IBncYdiv8nwATVwecu2xJEj
        TEQ1qRNUvMtjciaRBsTnxeC9RHKET18Gbg0zW2gFc5w==
X-Received: by 2002:a17:906:8497:: with SMTP id m23mr4753318ejx.158.1641923324853;
        Tue, 11 Jan 2022 09:48:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxb58uW6q4CoABAvbfyA0wd/q1tfVO+WKMqFjxCPxPu4yfFAUnJzVfOAaa/7ysx+M62NXkyjA==
X-Received: by 2002:a17:906:8497:: with SMTP id m23mr4753302ejx.158.1641923324673;
        Tue, 11 Jan 2022 09:48:44 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i23sm5224489edt.93.2022.01.11.09.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:48:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 0/5] mfd/extcon/regulators: max77843: add dtschema/bindings
Date:   Tue, 11 Jan 2022 18:48:00 +0100
Message-Id: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The max77843 shares some parts with max77693 but it lacked bindings.  All
its compatibles were undocumented.  Add basic bindings for max77843,
matching existing devicetree.  These are not complete bindings, but
rather reverse-engineered to match current state.

I do not have access to device with MAX77843, so if anyone else
volunteers to be the bindings maintainer, please join.

Changes since v1
================
1. MFD: Use absolute path to schemas.
2. Regulator: mention all allowed properties,
   additionalProperties=false, add min/max values for voltages and
   current, don't use patternProperties when not needed.
3. extcon: Use absolute path to schemas.

Dependencies
============
1. Patch 1/5 (dts): nothing depends on it, sending here so Rob's automatic
   checker won't complain about DTS.
   I will take it via Samsung SoC tree.

2. The patch 4/5 (mfd bindings) depends on regulator and extcon, so they
   should come together (2+3+4+5).

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  arm64: dts: exynos: Align MAX77843 nodes with dtschema on TM2
  dt-bindings: extcon: maxim,max77843: add MAX77843 bindings
  regulator: dt-bindings: maxim,max77843: add MAX77843 bindings
  dt-bindings: mfd: maxim,max77843: add MAX77843 bindings
  MAINTAINERS: mfd: cover MAX77843 by Maxim PMIC/MUIC for Exynos boards
    entry

 .../bindings/extcon/maxim,max77843.yaml       |  40 +++++
 .../bindings/mfd/maxim,max77843.yaml          | 144 ++++++++++++++++++
 .../bindings/regulator/maxim,max77843.yaml    |  65 ++++++++
 MAINTAINERS                                   |   2 +
 .../dts/exynos/exynos5433-tm2-common.dtsi     |  17 ++-
 5 files changed, 265 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77843.yaml

-- 
2.32.0

