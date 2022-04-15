Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114EF502DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355921AbiDOQqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355918AbiDOQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:46:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6786DCE23;
        Fri, 15 Apr 2022 09:44:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k5so14785420lfg.9;
        Fri, 15 Apr 2022 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBWwF27MwSuL5C7aP5ZZTL4T7IqFoYwfQe6tUlw2pWI=;
        b=TkVr8aTJFS9IbJCuBrXCpGEPamxYbyEAMjEiJu0qXzB9gw4xbchJ8On8xUp6zkdSHX
         WOA/TmTPa3pnldsg+uUpMzSQ4UMHROtPuaxMDZZftMNRw5B+GUNr9UGGgFlXmuRxpiqm
         kFOB5il2AXyWD19g/EQrck/K0nQTTyytvYBNKvNXQrpJg6qClcEAmmkGdC/hzFpDKlni
         /iv9VUDudkTEgw4vtPlsES43r2Ji7ln9dEz7i+Ad94DKFjiuM3S2Sdovq/F752kul4Sz
         WolbRwGQwtcTdGVtBDMG7UOVU1XCgu7NXDbJIDhZdfz9I0s8v79w1PG5Smq61ivAHwMr
         Kr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBWwF27MwSuL5C7aP5ZZTL4T7IqFoYwfQe6tUlw2pWI=;
        b=mWXuli9AIaFqg7M/osNuDvH9qoxKlmU/OTiGbIvRKVXv4AtvGYDCSMaidvcfTfi1bw
         0xLHO++2NIAKiP0PpZ+b05jPwReywFHXtKLYKw5UN8Wrgj/WENP/GSK0PKVto4PV1uxB
         lFdSNHdPZ0qW7ooSio7i05l5wav/Odg4UEobfk6aFoq1xhJqQHG1aXLVhFo1T/E0ZoPo
         uyBo2FGOZ0PUI8o9OhIl/nVmfGlq4eVduaoTxkEjjQ6Hl8nycrdp2nctJHiyQCm4CsAR
         C1d05Dvamtb2144BOLa8wUTopKN0qTGCwM8x5C98yYoiBN7H/aOk+70hs9SWT7Uvn6DR
         pHoA==
X-Gm-Message-State: AOAM530Mx0oMU/9ykBZP7TW3NtnmR/Bv5agZ32L6cQGwngWzMWlZDFk2
        qKPe28Uezf57cxYST1jDpNdizltLlew=
X-Google-Smtp-Source: ABdhPJzGuwNvorSCO5VVz/QXWE6SE1/vY+Z2IZvVpYBCS+XgK0zpRShss1brS9/434H4FFsuCPrOIA==
X-Received: by 2002:a05:6512:686:b0:46e:c9cf:7112 with SMTP id t6-20020a056512068600b0046ec9cf7112mr3065146lfe.662.1650041043829;
        Fri, 15 Apr 2022 09:44:03 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id h22-20020a056512339600b0046bc4ceaeb6sm383787lfg.27.2022.04.15.09.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:44:03 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 0/4] Add support for Silicon Mitus SM5703 MFD
Date:   Fri, 15 Apr 2022 19:43:51 +0300
Message-Id: <20220415164356.25165-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This series adds support for Silicon Mitus SM5703 MFD and the
appropriate device-tree bindings. This only adds support for the
regulator module, leaving room for other modules implemented in
future (code for other modules is really not ready for submission
right now). Silicon Mitus SM5703 is used on various mobile phones,
mostly Samsung Galaxy (J5 (2015, 2016), On7, J7 (2015, 2016) ...).

v2:
- mfd bindings: add "SM5703" to the title
- mfd bindings: indent the example
- regulators/Makefile: sort alphabetically
v3:
- mfd bindings: fix an error in example: there should be no 
newline between #size-cells and #address-cells and the node

Markuss Broks (4):
  dt-bindings: regulator: Add bindings for Silicon Mitus SM5703
    regulators
  dt-bindings: mfd: Add bindings for Silicon Mitus SM5703 MFD
  mfd: sm5703: Add support for SM5703 MFD
  regulator: sm5703-regulator: Add regulators support for SM5703 MFD

 .../bindings/mfd/siliconmitus,sm5703.yaml     |  91 ++++++++++
 .../siliconmitus,sm5703-regulator.yaml        |  48 ++++++
 MAINTAINERS                                   |   8 +
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/sm5703.c                          |  81 +++++++++
 drivers/regulator/Kconfig                     |   7 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/sm5703-regulator.c          | 162 ++++++++++++++++++
 include/linux/mfd/sm5703.h                    | 105 ++++++++++++
 10 files changed, 516 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
 create mode 100644 drivers/mfd/sm5703.c
 create mode 100644 drivers/regulator/sm5703-regulator.c
 create mode 100644 include/linux/mfd/sm5703.h

-- 
2.35.1

