Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA84650289B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352546AbiDOLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352554AbiDOLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:02:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD347939F8;
        Fri, 15 Apr 2022 04:00:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f5so1595378ljp.8;
        Fri, 15 Apr 2022 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUc60b57AhT9SFx2Mlbuf+JCyo5Rl/gcGLN6jImms98=;
        b=oT2vaK8vkcD9aZoHG1fs5rnbpk6gWuSygwsymd8jXQgJwSLD3/fK7gH8izABVNnsXk
         yEZ4qlCulBFQf7x9NVAQhugIHliBw6KZiLIxzacZ7gHXx+bZAd6Mi2EktVuccdj2QNe6
         hlUlEUKWXjFSPswfLQ0AU48y4RxdOYGYd9HSNBRr032uzLH8dAOAiDLOXx1mXYFtEUAV
         j2GP5yNU81yfV6o+odOPUf0ouWkJRLr4gEJaaUFXjRh+PXNzw9SEuGWPk73+E0fjhea7
         IYezGIoQ1xVid4S+8HFUhk6PrG2v8KlTmJnMtYcA4RNxdxZLkhJFYASTPUT8q/HIkm4d
         PpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUc60b57AhT9SFx2Mlbuf+JCyo5Rl/gcGLN6jImms98=;
        b=vnTYD5rwMfBd9uyQKpqB9P7LrKoBvamMbnRUC43VQDT+KAT6LDVID+ZJlfOd2q+UF/
         zqni02ddMI61f2VI6JJyMCyhCMKFTfrI4jBI2Y3R7jNqmaknS8C4oOVDFuKLA5JpL1on
         4Z0lcnmYeSmlcY+aCbeUHYkrnQkx/GPFvwj7ST4Z9qSy0yZ/Jim3vetM0AUxBhNMBk+2
         UdilDuUXDII9rrGD3NnjBmi5CdvKOe5U+i2cU5Bcv4ypQt73DgdLp5fW8UyXnHHzevgz
         hQu+lKGb3Wxv+hILTJF+LXjDRc6r5fq5rb0aZllj5fHaCuEYCDuFqOa9O1k7hZK2pino
         etGQ==
X-Gm-Message-State: AOAM532ZeO/WmjOtl5TpfC0XYsITZJhRb1MQVi9caAfDPjg1e5OfRsxG
        KgUylk3hBEfRosru+CK5a/49bc3fQPc=
X-Google-Smtp-Source: ABdhPJxO6Q98HyjaAAm8jmNlSeKD0VRsxNyr2G9+Vrh3iG/UbM3jKzHl4mnBGHAqWvjj4u77sEU2wA==
X-Received: by 2002:a2e:a548:0:b0:24d:626e:f382 with SMTP id e8-20020a2ea548000000b0024d626ef382mr4094220ljn.93.1650020420697;
        Fri, 15 Apr 2022 04:00:20 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id q14-20020a0565123a8e00b0044a7b26ae1dsm292341lfu.109.2022.04.15.04.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 04:00:19 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] Add support for Silicon Mitus SM5703 MFD
Date:   Fri, 15 Apr 2022 14:00:09 +0300
Message-Id: <20220415110014.7384-1-markuss.broks@gmail.com>
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

