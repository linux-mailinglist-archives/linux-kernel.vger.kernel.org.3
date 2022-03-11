Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE2E4D5B85
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiCKGSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiCKGSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:18:38 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD42182E;
        Thu, 10 Mar 2022 22:17:33 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 6so6712712pgg.0;
        Thu, 10 Mar 2022 22:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=A7pAy++gE6Sf24glsPSuwiIhYjaba9pQjOIqVLpC6lY=;
        b=pRcYO6tJNwMTlM04j9EYiq+iHMveHk+7BaoWF0Bq6k6ihtdUuQYRWMX57QXqc/cgwT
         3soYCIiJMzJDPxP1LAxR7W/urMID0UPDO2mU5BSp19D5aRTQmOebNhAekpRFmrkJBEU2
         uw5F1LyuTQIVhzyTfFosft17eNwOGqnWyo5T5FsXPK8Ws4Aus0ueDtcHp09VuNYhu6CK
         JTHE/JkXnXD7hiqFljjEy/SupHRewvx83T/dTiDzxcRpnfnl/rkXDHxKdkLm1yN6R4gT
         V3vtNJCcNSpx87joQ9YliJ6QGCu29m9w6tcD2bvxOZXBF4yjRlv4fevpPnZ5JekVOj8m
         5Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A7pAy++gE6Sf24glsPSuwiIhYjaba9pQjOIqVLpC6lY=;
        b=iNayzeHDpdkT4rSBTgSoSRdRHHEdhRsOzWuUhAlSCKIF5wsOl/opuHuWcgSlMHKNWp
         exM3oX5ifCCyQ3AV5c/0XlMRdl3H1TD+KHxxAt8E97enNEnP8qcXEf/BrtyzhghmrfTb
         L+xa+CC3ZiHu/UY4n0+60/pGMV0kVk4BCnr1g8BYXlHwpo5ToASiBr3g3p7NqQUdsXDi
         5KoUQXDpCA1kpkL9h5DzR3yv+xg+RQkcHoAgEHUSi6Cbh5ah5QvRaq070mwm2QVC6Iyr
         9VmCT1BswvNxIkqP0w8whJSr4EGFE/K5zkYC6AoZRjVHmqK5nXRXMVIwkcKG0slrzp+y
         hDGA==
X-Gm-Message-State: AOAM532YX1eG/XTMTS/gDjXqy8Z/HcTWdSn2+2HWArpRAVwK9O24gRI3
        7yR3F3au6L97OcO2gjbjPJw=
X-Google-Smtp-Source: ABdhPJy1fJA4WkmniCGtgE/gxQ9bvOZVEhlL1C4xif5vmxgIgz7POBtlmcziW3Q4qioutsVd86x+oA==
X-Received: by 2002:a05:6a00:1a4d:b0:4f7:b86:fd1e with SMTP id h13-20020a056a001a4d00b004f70b86fd1emr8387142pfv.65.1646979453413;
        Thu, 10 Mar 2022 22:17:33 -0800 (PST)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a0010d400b004f7093700c4sm9101764pfu.76.2022.03.10.22.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 22:17:33 -0800 (PST)
From:   jimliu2 <jim.t90615@gmail.com>
X-Google-Original-From: jimliu2 <JJLIU0@nuvoton.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, jim.t90615@gmail.com,
        CTCCHIEN@nuvoton.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v1 0/3]sgpio:nuvoton:add support for Nuvoton NPCM SoCs
Date:   Fri, 11 Mar 2022 14:09:33 +0800
Message-Id: <20220311060936.10663-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sgpio feature for Nuvoton NPCM SoCs

jimliu2 (3):
  dts: add Nuvoton sgpio feature
  dt-bindings: support Nuvoton sgpio
  gpio:gpio-npcm-sgpio: Add Nuvoton sgpio driver

 .../bindings/gpio/nuvoton,sgpio.yaml          |  78 +++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |  30 +
 drivers/gpio/Kconfig                          |  12 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-npcm-sgpio.c                | 634 ++++++++++++++++++
 5 files changed, 755 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
 create mode 100644 drivers/gpio/gpio-npcm-sgpio.c

-- 
2.17.1

