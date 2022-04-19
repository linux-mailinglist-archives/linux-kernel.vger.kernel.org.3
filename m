Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A31850726B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354213AbiDSQD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354210AbiDSQDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:03:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE6A2CE3F;
        Tue, 19 Apr 2022 09:01:11 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f5so13531491ljp.8;
        Tue, 19 Apr 2022 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g5W0YL8VSF/J8f5S29hX7dhSZXx96g6al7WapBb1sto=;
        b=myKlJo+7KD2ezGYPXf7wQ6W+gOuAQzWg4i+wIB82DEoTXQRtcn2oSjhHspvDqJeH7u
         utPpZdC7rTuhhRD0zJb/Mlm1V8XerHMDOzg+fEVJPZXXjkSDc80HgwWUgc0ty00+jvrW
         XOLetyvKDgGnaAs0ytBFN0r5dneg6dufoWJrcaNWqmJwL15CMbb7ok7sJLHduQVcTLFV
         +nuxVTtEICEWpRGG6EdiX7Aum/h7wMlSWp4rKA69q+1t9YcpJ9BQX4YW0zYBXkwEZt71
         7uZP97UGuLIqk+xs4EgCmFymj9PMF9KHE0kxFzXDGngou2ZVsUYEcTOoqQ82paw2q4kH
         r4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g5W0YL8VSF/J8f5S29hX7dhSZXx96g6al7WapBb1sto=;
        b=b1t9e/3n04n2z0E8ZD5GAnwB2S/rmx6lUPLhSUVhPp6l9OWkJFR7QuJwsPKtsWOisI
         HC0yasLqzhGfLEnRd//6G+uwNstR7XSODYupteo8diNgrlyBMtkDjp77wQ0n3GlB9BgP
         eU3vtkAORHna9ruCa/9TRF+2W8KMmhsrFARhbquji79kIYOvNqZET67oFIbhJfdmD/GZ
         RI8lUeOpem2sFHFbERAzfHCjM1zI0qJf1mN7GmyEAPG5tu9jAv+rS+CMlRfp5wEGkpmB
         Q9lrKTq3feFX/2xV8NP/VB5+1lVLSUnyMOHtUOre1xS2ngnb0IY3Z1klbTMxdyGdYYAb
         gvOA==
X-Gm-Message-State: AOAM531F0VDBJM+TelwNhE+196djqtspe52+lBaJo6DzpfRiexb/v8A6
        O0kq4aceH5zPalq7F2/6NZSDTuLWhto=
X-Google-Smtp-Source: ABdhPJxLqM8lmkJIyBkCg3PtyljTfJnbDpcjjME6uqH372hEw04T7li75e7dujnC5iyTH7RIBpWz2A==
X-Received: by 2002:a2e:a548:0:b0:24d:626e:f382 with SMTP id e8-20020a2ea548000000b0024d626ef382mr10578989ljn.93.1650384069083;
        Tue, 19 Apr 2022 09:01:09 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id m5-20020a194345000000b0046e951e34b3sm1506663lfj.24.2022.04.19.09.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:01:08 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 0/4] Add support for Silicon Mitus SM5703 MFD
Date:   Tue, 19 Apr 2022 19:00:53 +0300
Message-Id: <20220419160058.9998-1-markuss.broks@gmail.com>
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
v4:
mfd bindings:
- drop the -mfd in the compatible
- change reference path to the regulator yaml to an absolute one
- use -gpios for the reset GPIO
- make reset-gpios a required property
- correct the example node name
- correct the example compatible
regulator bindings:
- add unevaluatedProperties: false to all four types of regulators

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

