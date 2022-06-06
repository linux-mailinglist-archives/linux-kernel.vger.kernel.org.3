Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E831F53E79F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbiFFP2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbiFFP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:26:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C5A328EC3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:26:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z17so3016194wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oggV4sOjieyiC3zjEdHQHSt2OuXT3mEVI982IJ/c+54=;
        b=NaB7ujjGsLox+28AdLK9IidwX+NJOkUleLjf4urIgEJUy6CHXhH2EePr22m74qQdEA
         79mv33qy/xswvfwMxz168siPdwUK7Krz2iUEUbL9+0RK6LltHN1Qqo1e2xXu3s9VCK/z
         NIJWNpW8d1FTfwhqQ7UccQcdKWY7CLUuNH3z7hTLi+k5MVHte1kWZZOptTtRM2sWmlwW
         pXAtWMrUN74gUFYtK/9l2Xp7uV0zy5f7NglOI//BfmebbOrBcDQL5jVG6NmVlz/J+oZD
         dLBPOOPbqxl3xt2MG/bFypavTjAOyw++V0cBBF7Bnu8/rcewEjYER1C7DDYUalMDV95C
         IAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oggV4sOjieyiC3zjEdHQHSt2OuXT3mEVI982IJ/c+54=;
        b=WsuIHjwaDBR1Y3DmomNg31ZD00qgx18+DL8ym0nkNTWQSwEvtZfpLOLcxqstjKMB/o
         4mRhu5Gau11NCuA8pkIiH5i1XVnicJUf5+nBt4IXBqzJQSo6shF3UruaYo/IH7WrB7kh
         ibX8T9Jaj/+f3O3zGyUZCdjpKg9FReafBga/EsKQ4l67gQ6XWkCFf/9+hr3LCNyyqf8M
         T3IWi94Ud0uw1yvPyA4wO84kv1SrddNDMAZhNyawXrv0FkuXEXcGNe61orPPxyUbi00w
         /1AnRxz76ysQn0UtfU5OPD4W/e0oJl/Iftw6aVyYm/1ezbrMGXcyaoXOkdyhgyiz5rLm
         JuzQ==
X-Gm-Message-State: AOAM532JwMgUfXhrNLydMa1qzlMn53SKppifEu8/qv+B9bCkOZGZbmis
        SSsrs8/mWNtihRSam7jsoFPXxg==
X-Google-Smtp-Source: ABdhPJxQXtq89heOMKFlrzvEzPMju6ZggXxjIjVWhm/vncfRX5ffcbpunfZrkktl/6NLqBfuUMH5Dw==
X-Received: by 2002:a05:600c:5021:b0:397:54e1:8274 with SMTP id n33-20020a05600c502100b0039754e18274mr52631051wmr.15.1654529169099;
        Mon, 06 Jun 2022 08:26:09 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id h1-20020adffd41000000b002103aebe8absm15623944wrs.93.2022.06.06.08.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:26:08 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Atul Khare <atulkhare@rivosinc.com>
Subject: [PATCH v2 0/4] clear riscv dtbs_check errors
Date:   Mon,  6 Jun 2022 16:25:54 +0100
Message-Id: <20220606152557.438771-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
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

From: Conor Dooley <conor.dooley@microchip.com>

Hey,
Couple conversions from txt to yaml here with the intent of fixing the
the dtbs_check warnings for riscv when building with "defconfig".
Atul Khare already sent patches for the gpio-line-names & cache-sets
(which went awol) and will clear the remaining two errors.

Thanks,
Conor.

Conor Dooley (4):
  dt-bindings: mmc: convert mmc-spi-slot to yaml
  dt-bindings: i2c: convert ocores binding to yaml
  dt-bindings: mfd: convert da9063 to yaml
  riscv: dts: sifive: "fix" pmic watchdog node name

 .../devicetree/bindings/i2c/i2c-ocores.txt    |  78 -----------
 .../bindings/i2c/opencores,i2c-ocores.yaml    | 123 ++++++++++++++++
 .../devicetree/bindings/mfd/da9063.txt        | 114 ---------------
 .../devicetree/bindings/mfd/dlg,da9063.yaml   | 132 ++++++++++++++++++
 .../devicetree/bindings/mmc/mmc-spi-slot.txt  |  29 ----
 .../devicetree/bindings/mmc/mmc-spi-slot.yaml |  79 +++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 MAINTAINERS                                   |   3 +-
 .../boot/dts/sifive/hifive-unmatched-a00.dts  |   2 +-
 9 files changed, 337 insertions(+), 225 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-ocores.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/opencores,i2c-ocores.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/da9063.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

