Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF042514898
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358704AbiD2L43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbiD2L42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:56:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAA1C6ED3;
        Fri, 29 Apr 2022 04:53:09 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 1so5140222qvs.8;
        Fri, 29 Apr 2022 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KV4krtbeGPg3XtA9N0Vc8Z5tufyrmUvw/0E9B0OLsiM=;
        b=bCg9/ayXoHRN9e6lsctLLef7ix2gfMMKa/r4qdO+HNeS55VwVPCYqz8uXCcjK/iA7N
         prqAXk0pQeyCk4gTT8MesUWBka9IN/hQY8Mi8XtV7w8yYW4n2jRmnQCq0W4WeoPMQEKe
         f4S7jC3c0no7ev4gGIfv3+OueOO7896ImFwOma5vS+NXamSEsABgTguZbe2AWKGYvLo1
         vGFPw76l0o9pqrpkzsD0v5JfvgbVk6h2w3HToY/vHlac6g270OsvzqIMuaMbZZvmgSj6
         ITU6mkl8Qdlznxb4LLzxe7WeZaUqqeMEBY9SsNQ+Ede04cAE1+f2iZIiLMGMpbsqc6bn
         ZEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KV4krtbeGPg3XtA9N0Vc8Z5tufyrmUvw/0E9B0OLsiM=;
        b=5j0KrbPamXnX9JMZBu2hauP5JLPUPgB2qE5Cu5+KH9rN1RLFT7QV/Ju74BZEiEEryO
         Zu8h0LRXYh7gtdln6yAV3TRv6eDx9htTX+NJloecjc+8mysvST1eUjIbqIL4/jKEyPPO
         SnDsQPcLSmG19Og7XQbsDFjHJoaCFOQnnniOvexRY+TiUjPcS+rxgXqj0ib/0I9M/7N1
         QSIUPiahmVmGhzyLRu+yd4DOA9LyTYLCrVngaTFbcBh6GLTkAETcvz3thH0fUnyvldKO
         24jhGNce7uaCCn+OF+DU2744hd1rn85qeDFH55UGVp9jukMFXjmoBrpEOhWpw3+jexL/
         uc2w==
X-Gm-Message-State: AOAM530Eq3xPw+YZiss1yLy+BkUnQo732AziEfCndRQLUHZzsvkUiI0v
        hBUpyZlWZx/e+KuAuLqNdxo=
X-Google-Smtp-Source: ABdhPJyndl9VV7x3EmnaA3IRvanqu204IsjralKYKEmODgRhfVALtn1dA1ft8TDBZ0kzHckZzoJw6w==
X-Received: by 2002:ad4:5b85:0:b0:458:1192:77c2 with SMTP id 5-20020ad45b85000000b00458119277c2mr1772036qvp.124.1651233188084;
        Fri, 29 Apr 2022 04:53:08 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 123-20020a370c81000000b0069fa408fdb7sm1382505qkm.24.2022.04.29.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:53:07 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     heiko@sntech.de, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Add support for several new rk3566 SBCs
Date:   Fri, 29 Apr 2022 07:52:45 -0400
Message-Id: <20220429115252.2360496-1-pgwipeout@gmail.com>
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

Changelog:
v2:
- squash Model B into Model A binding
- collect acks

Furkan Kardame (1):
  arm64: dts: rockchip: add dts for Firefly Station M2 rk3566

Peter Geis (6):
  dt-bindings: arm: rockchip: Add Pine64 Quartz64 Model B
  dt-bindings: arm: rockchip: Add Pine64 SoQuartz SoM
  dt-bindings: arm: rockchip: Add Firefly Station M2
  arm64: dts: rockchip: add rk356x sfc support
  arm64: dts: rockchip: add Pine64 Quartz64-B device tree
  arm64: dts: rockchip: add SoQuartz CM4IO dts

 .../devicetree/bindings/arm/rockchip.yaml     |  18 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   3 +
 .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 615 ++++++++++++++++++
 .../arm64/boot/dts/rockchip/rk3566-roc-pc.dts | 580 +++++++++++++++++
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts | 167 +++++
 .../boot/dts/rockchip/rk3566-soquartz.dtsi    | 607 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  11 +
 7 files changed, 1999 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi

-- 
2.25.1

