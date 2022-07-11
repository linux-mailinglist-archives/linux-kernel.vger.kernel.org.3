Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE125705F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiGKOlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiGKOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:41:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B253E655AC;
        Mon, 11 Jul 2022 07:41:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h23so9164243ejj.12;
        Mon, 11 Jul 2022 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nd0uIbU73pBAb0SgCLc1xWjWp2BBj2QnxZmOuS9PVj8=;
        b=cfkhLXkfDsHs4qaYi+9MMdn9VWPPzXigXoi5ltx6WiJNpP/wHxFKkyBzTo5bxteT8H
         aLcq9QnKpGY9lrTDKXF35sLgcYtEh1Eh054BFPERgP5OqZHlwVGEHz6UPDbuvYIdcLIa
         KJQy9PlXxElHAwx6ciEMVFSsncR5MgmtQeQ5EbauhnsDRNVBN5cI7FkTYXOlSpEf5VE9
         +iVlLI+1XGU0pdAETMkASP9zIqpGSYGCzYC01for9pL5+XzdD5dSLf15SruOYfpSn+zu
         Y3SJAApRnHrJAPwNaDjtjU6ZHo2HBhNjhTKcHfAtjs+d291NCijZzc1e/snS54j/Vbqh
         HT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nd0uIbU73pBAb0SgCLc1xWjWp2BBj2QnxZmOuS9PVj8=;
        b=OUm7ZkP7AoQbXUKKbE9d1tCbvKn9hlEXJhfRQEhGBDoQVwxiBGJLdY9vMcUJlyI0kG
         qZOOtxmQhN3kKkRlj/Tf2uroRO0WDJgE62OXefA81JCHIP96PZ7J7eBolf3yUdpNYgKy
         YYEJA9KrJzIFEgzb942OeTLjSn72YpaINORB4xGooSzibHWYLX8x3R6+hPM11naivlYP
         H/bv1cgk55ApZ10qztR9tvARaChqBj4UxS5+phfD+anijkA5gKlYWZkMusgluLgwpuqA
         RnH9mJAerc9gM3Czhq70DTI//2bsqydlysSNV/CmQeUHeNxSynYPzKFivmlyLXY0Qdz3
         72Ow==
X-Gm-Message-State: AJIora+XOSmGBHT/PjtxCnTVb9oauH2mNTO72iYjigJ54wg8vr8ea6JC
        oKP/E0KKiaR7kuXybFy1IfM=
X-Google-Smtp-Source: AGRyM1uvZ4Xj3rLQHGpiUVwdcOIIWLFRyVLaKZCP7vuezJJ5yzLXOVX8mSRYoCHll6WgkmK8I0bPMg==
X-Received: by 2002:a17:907:7ea1:b0:72b:6d73:f588 with SMTP id qb33-20020a1709077ea100b0072b6d73f588mr1623704ejc.373.1657550501286;
        Mon, 11 Jul 2022 07:41:41 -0700 (PDT)
Received: from localhost.localdomain (89-39-107-113.hosted-by-worldstream.net. [89.39.107.113])
        by smtp.gmail.com with ESMTPSA id cm10-20020a0564020c8a00b00436f3107bdasm4461390edb.38.2022.07.11.07.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:41:40 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] media: i2c: ak7375: Add regulator management
Date:   Mon, 11 Jul 2022 18:40:36 +0400
Message-Id: <20220711144039.232196-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.0
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

This series adds needed regulator management for the AK7375 VCM.
A DT schema conversion is made before adding new properties.

Changes since v1:
  - Add vendor prefix to DT binding doc file name
  - Reorganize variable declaration
  - Change the power-on delay range to 3000-3500 microseconds.

Yassine Oudjana (3):
  media: dt-bindings: ak7375: Convert to DT schema
  media: dt-bindings: ak7375: Add supplies
  media: i2c: ak7375: Add regulator management

 .../devicetree/bindings/media/i2c/ak7375.txt  |  8 ---
 .../media/i2c/asahi-kasei,ak7375.yaml         | 52 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 drivers/media/i2c/ak7375.c                    | 39 ++++++++++++++
 4 files changed, 92 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ak7375.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml

-- 
2.37.0

