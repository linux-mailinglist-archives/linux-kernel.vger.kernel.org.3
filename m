Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6715019C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiDNROp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245302AbiDNRO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:14:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207A29B;
        Thu, 14 Apr 2022 10:06:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x33so10252082lfu.1;
        Thu, 14 Apr 2022 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUc60b57AhT9SFx2Mlbuf+JCyo5Rl/gcGLN6jImms98=;
        b=nSu1q/CarM0qXCE4RMge9hUnG9JxgqwpOb2Ey9tTNpbiXQpS+KVzCoNVEHdMI/5tq/
         fjwzrFTAIFe0/CHlBAMn8EIrSSxMgSU43l307eVFi8SnRLYQJfE8THK6ZaAIvrE1KH+P
         YvOGo+asej4w6LP1/xXv5gW6I7pyq4VrqYjtHzKw+dnsuvJ/nxVA6XwfC9ykFOZwa2Wu
         IwJR8b3/8fLbvXKnXZm1QGJ8lyUg/5Uvn67j9t6D1togFzRbqpTJZLP+OhTA5BzRBuls
         NZXR4urtvpJL/ntcZQQCe12RDun+Opki1OUmu61dVHrR+CiuKWZBYXsYhXEGuq5UrnrW
         1jJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUc60b57AhT9SFx2Mlbuf+JCyo5Rl/gcGLN6jImms98=;
        b=l+W9etJNLtlxNeHRcMmND1Vc6xv8u4X4t9vWvAv6qCn+bArQYSrq67dpctqmMc+zYk
         FISidLeHy/gOcnpwGrVZN4T6BOzmEilnE+ID8KvSwyoVnweM+D2NqiFvzAhyKt51UeRW
         IDR3Fx5Ss3OFWJ0BoC8e3hbDy8Ws0Pevf2o6BhfH14kc6vylcseDlKdW4ub3oqCH90G1
         hsg+JALko4tZ/5yayStC1PvbPeW454hJXoT0APeHAtOk4qNxb0d35lKDbP4vzq7cbDLu
         zwZPeO/q0qS2umy52fO//tbfu2m2R+AWI1fAU8hllxi3c48nPvQDnYkEVpQvU7dezwTw
         qB/Q==
X-Gm-Message-State: AOAM5302fwXZiFTVWTe0ka0l0aJhxOHI0cX0dYMOpUvn3Zo9xrhM7ZIh
        Gz50EYHDlexxvSe08yEYwSjqjjXMZh0=
X-Google-Smtp-Source: ABdhPJzkOLtOPkWhQv+Xq1y4RfJNPKUfU1dFsJipqFgD57cdC4IUplG1D0E+ayca9RIMF8pPC4F07w==
X-Received: by 2002:a05:6512:4005:b0:46c:cafb:a0f9 with SMTP id br5-20020a056512400500b0046ccafba0f9mr2422412lfb.639.1649956004431;
        Thu, 14 Apr 2022 10:06:44 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id x11-20020a056512046b00b0046bbe5d2eabsm52216lfd.75.2022.04.14.10.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:06:43 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 0/4] Add support for Silicon Mitus SM5703 MFD
Date:   Thu, 14 Apr 2022 20:06:11 +0300
Message-Id: <20220414170616.23319-1-markuss.broks@gmail.com>
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

