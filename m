Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8D50E6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbiDYRQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiDYRQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:16:52 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD86413DD7;
        Mon, 25 Apr 2022 10:13:47 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c1so11235141qkf.13;
        Mon, 25 Apr 2022 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+japc2t+wot5+BSTXiQ5huwoEirJRSQFwasvOhZa43s=;
        b=P17sJtcPbya+arEjYzIf9eJ0Vmt77u/n8PikxlHSV731+iMxLKqMw1fsDM0fxfyTkp
         ws5xYKolRE/l0fbzmjA8jsRE6khpEyF+3R6mLXlTo5i63n8sG/jUBpX3xP5LyCUH8xxM
         mVLUS/KlgpZotG+j96lvJydzF57TMfpcTy6BJT9HOguNj3sDS/0QljNyEanew1mw+2/m
         ji1afJOmx82YpEOR0TNcadGAUEbtc1gE7D2DjUx25jxTVW6Pm+uN34DUAjLjYuarnLTj
         RBrqHk6XPqjsgDNXyI5qE0K8kGueY7IpPApyKVJYMDC6As3VjGNh4Hw8/XzDs+7fcM9d
         pP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+japc2t+wot5+BSTXiQ5huwoEirJRSQFwasvOhZa43s=;
        b=4jTzh20ykGlUbHGDCl880Km2Gj+3e+uv+i2itPXBDSZRdiOPOMau9KnFoAMmAW9jaK
         xTl0EyTYdRekXRd2Un85cRWxJH7gDTMT/t7JoiO1CFDObD0nYJdbX+jyz/1eYTDkowj+
         +f1bckkEOArsuWIoLEjjyZD7BUuGtdULejS4yBZYEeIhnO+cz+8hdVj+CJkbhK1p5cre
         acJ7imskinhhKFGAQpbGF52z+Ql5oc4IiTFQLTAMnIn78ePfHz4xZhgvgr2ABmQnJYqd
         NQzEgexDN7JZdisawOYzHjYfKY998eCymR2sYep+scx3x+iiQBKP7rmFnfSlEr6OEwAC
         V0MA==
X-Gm-Message-State: AOAM532zdBqGecUKv2dND9laItTz1Uwd3X4L/0gVksRx9PjxPNfbaNEi
        oqppcNUlMV1C+k+SSFKapcU=
X-Google-Smtp-Source: ABdhPJxkllM4++LB6/9J4wC5bXxDX3s8LLt4srPcIdugcklZ6pg7vea5I8GIU8fS4b8lp8Cm9CHPiw==
X-Received: by 2002:a05:620a:2847:b0:67d:2bad:422f with SMTP id h7-20020a05620a284700b0067d2bad422fmr10702993qkp.559.1650906826798;
        Mon, 25 Apr 2022 10:13:46 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm7154928qtw.64.2022.04.25.10.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:13:46 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     heiko@sntech.de, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/7] Add support for several new rk3566 SBCs
Date:   Mon, 25 Apr 2022 13:13:37 -0400
Message-Id: <20220425171344.1924057-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series adds support for the following single board
computers:
- Pine64 Quartz64 Model B
- Pine64 SoQuartz SoM with RPi CM4IO carrier board
- Firefly Station M2

Patches 1, 2, and 3 add the requisite dt-bindings.
Patch 4 adds support for the SFC to the rk356x device tree.
Patch 5 adds the Quartz64 Model B device tree.
Patch 6 adds the SoQuartz CM4IO device tree.
Patch 7 adds the Firefly Station M2 device tree.

Please review and apply at your convenience.

Very Respectfully,
Peter Geis

Furkan Kardame (1):
  arm64: dts: rockchip: add dts for Firefly Station M2 rk3566

Peter Geis (6):
  dt-bindings: arm: rockchip: Add Pine64 Quartz64 Model B
  dt-bindings: arm: rockchip: Add Pine64 SoQuartz SoM
  dt-bindings: arm: rockchip: Add Firefly Station M2
  arm64: dts: rockchip: add rk356x sfc support
  arm64: dts: rockchip: add Pine64 Quartz64-B device tree
  arm64: dts: rockchip: add SoQuartz CM4IO dts

 .../devicetree/bindings/arm/rockchip.yaml     |  17 +
 arch/arm64/boot/dts/rockchip/Makefile         |   3 +
 .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 615 ++++++++++++++++++
 .../arm64/boot/dts/rockchip/rk3566-roc-pc.dts | 580 +++++++++++++++++
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts | 167 +++++
 .../boot/dts/rockchip/rk3566-soquartz.dtsi    | 607 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  11 +
 7 files changed, 2000 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi

-- 
2.25.1

