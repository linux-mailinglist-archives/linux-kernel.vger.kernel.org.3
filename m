Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B244E8098
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiCZLld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 07:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCZLlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:41:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813B74EA2C;
        Sat, 26 Mar 2022 04:39:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j13so10711072plj.8;
        Sat, 26 Mar 2022 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=tia7fK4nc/ANrfG8lyg/ABwGBOiv7qC/2FHjWGl9d/8=;
        b=O2HpT1g/76KqlcnfA8zcoSg92GyPGII5TRrUJivHd58veRfeL5Z3M4MYOt/oy48nc4
         xAfJdsi+8SHZm++eAT362IKZrjElK7niOXYZ0ttVK6UWd97CZeoZmpTc2w8WBjAuIvgR
         +nLMLz3zViX3++38C98TudKnSpyk1vWGJz+ZI7Ka8Swr8QIyM0g8vX+F9x2veA9i3hhX
         A672sxIthWWsbtMRQH/JcQgP7LBl9jwaoyv2KWwawSj3NIN1mZG8j3f2j3869NZTGPeG
         uCOHYrPT6x5y+BoDgtW9Nf1INHr9CGnleMZxfEEqW54KkG4KZer5C7Ut1vy3QL5pq4ez
         vfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tia7fK4nc/ANrfG8lyg/ABwGBOiv7qC/2FHjWGl9d/8=;
        b=vkv2YZpPeIQedZSmsxXbi2Z5W3TgVTupGOdiHjNR8CJBoLoa3Vmp9HK2B6ULx0kHoA
         TXss3RcUNZn6s9gO1kFc4kgWcSLRCFheUbXUsTqnqQBoCdV/TKyEfT+dR39FjTOlHoEU
         piu7A/NQ2dky8UTQ8ETsHm/1C7P36O6AxLO0uxVb+2sdlZ2wi88e8UaZs2JlZr7cVaOZ
         YTyl4+G1bALfE8NEjVdn73OaCGKrswhP/RFhAPdU43JoYZ2KxknKX9ot4GN2GGjNZl1h
         7l4vEuRFxTzBx1iYhlv7UarelLexMZoi9zGKNo5B9Nof5hVPSFYr9iy4uTX7Ui3zDen0
         ng5g==
X-Gm-Message-State: AOAM533T/Bgjew79FIM977BN+YgBKyMRxIKZTMgRtC534n2QUM6slBIV
        TBhMTuwURMGTAJm+9BZeQ42P3DqC5jk=
X-Google-Smtp-Source: ABdhPJzWorglYLMrgJbfU8duaTDY2yB2zqS+A0F08KUCi0s04JZrkIN9Q+pCa6AdV0pVuYes2mSdbA==
X-Received: by 2002:a17:902:c64b:b0:153:f75d:253e with SMTP id s11-20020a170902c64b00b00153f75d253emr16554380pls.48.1648294795784;
        Sat, 26 Mar 2022 04:39:55 -0700 (PDT)
Received: from RD-1129-20047.dynamic.kbronet.com.tw (180-176-43-246.dynamic.kbronet.com.tw. [180.176.43.246])
        by smtp.gmail.com with ESMTPSA id s1-20020a056a00178100b004f731a1a952sm9884926pfg.168.2022.03.26.04.39.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Mar 2022 04:39:55 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Add Richtek RT5759 buck converter support
Date:   Sat, 26 Mar 2022 19:39:46 +0800
Message-Id: <1648294788-11758-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series add Richtek RT5759 buck converter support.

since V2
- Fix typo in title description.
- Put allOf and if/then to be together.
- Change node name to generic 'regulator'.
- Remove seperate wdt_enable variable.
- Add of_match_ptr in struct driver of_match_table declaration.

ChiYuan Huang (2):
  dt-bindings: regulator: Add binding for Richtek RT5759 DCDC converter
  regulator: rt5759: Add support for Richtek RT5759 DCDC converter

 .../regulator/richtek,rt5759-regulator.yaml        |  90 +++++
 drivers/regulator/Kconfig                          |  10 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rt5759-regulator.c               | 369 +++++++++++++++++++++
 4 files changed, 470 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml
 create mode 100644 drivers/regulator/rt5759-regulator.c

-- 
2.7.4

