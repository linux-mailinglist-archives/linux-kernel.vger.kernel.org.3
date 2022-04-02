Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB94EFECC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 07:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiDBFOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 01:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiDBFOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:14:04 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51780189A25
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 22:12:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q142so2123525pgq.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 22:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UTM8xNHGKuJEA3ShhoH5h99TEkwNiTbrXpQiCcWtSkc=;
        b=V95uFUsXfsQ4PLUA+A/KOpaUYdBNXSckWjLscw/JJNT50MlTmwZYudC1EtAun097Lg
         ZFKFkRU7IXaVjkKsUDU5+z6QtzCQk4FHeLgtazBqGBpI2xzBGucrg3+OzcPQbgVrl9DJ
         sFrsldz4JI09hgp4Kpkv+tmN72IdF1eDpQFac2t5DQgIyCkGeLynbaxdpnea24pyXbMc
         9aWVTxL7SsrmAoLa81P9bBYbfmWDti/pf0O4e3tvk0fp7Inyrb9rckiMcNmtPIoBUyqg
         o3wu9A5CfwMtifEXGGdfsjEZ6iRg9zZUWKZI0CtXGWehvxpmN934nQ6Y7qLZ6ZidcLa4
         fR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UTM8xNHGKuJEA3ShhoH5h99TEkwNiTbrXpQiCcWtSkc=;
        b=7eD4/QywTjvBtJqKduAgEMvFy2i7jS1FsEWfAShXPEKnPypz5oHUIWdNXyeTwF65tf
         IWZi9u6eQtQN820/Un7K72AX28U7f+uzCyZdxSF9Z1cbBGW0pmTxULqrORb8Ic2ewhqX
         7ZS6RJHBorwymhMaD6g7ZRTFjR7sP8wHpYjTBOhCBf/2+dFZWaf04HGrvL0yPve5l2ma
         aNumTIvhU7mVd51Gkt4JiE0xyCv6DRgiUimhCfK29RfCpvaZEfWrlUc+kIgh5nx77k+W
         KRRAXyvHzRZNbjO6mCow7s4CYWpNW4HUvxQ5029UuHf6ZoUpovgstsioBwB1ZtYJp4Xr
         +ryA==
X-Gm-Message-State: AOAM531yPgkakWHu+ka7sxM9vW4zNLaEKL093InGbXtwWeeLO2N6HVJP
        nE/8iq8cuqxz5nTzhflFIxy0VApfB3w=
X-Google-Smtp-Source: ABdhPJzYGS3ttgJbek5s04y3iENSjmzpi42FDwtvTW3Wc7EV2Hh3du57G+cdOa4L2KXLRzeKPt2ijg==
X-Received: by 2002:a05:6a00:23c1:b0:4fa:efcb:9c81 with SMTP id g1-20020a056a0023c100b004faefcb9c81mr14054466pfc.75.1648876332674;
        Fri, 01 Apr 2022 22:12:12 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm3834721pgo.6.2022.04.01.22.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:12:12 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Geni based QUP controller binding cleanups
Date:   Sat,  2 Apr 2022 10:42:01 +0530
Message-Id: <20220402051206.6115-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geni based QUP controller currently has child nodes bindings defined in
same parent schema. Documentation of few other properties were also
omitted intially. The list becomes too long with addition of these
properties. Therefore, move out child bindings from parent schema to
respective places as a part of cleanup process and update reference for
it. Please note, individual bindings will now stand complete as
previously some properties were defined in core and rest in parent
schema.

This patchset adds individual bindings for uart and i2c controller, spi
controller is taken care by Krzystof. SPI patches[1] are required for
complete changes. Once all bindings gets places correctly, remove common
properties defined in parent as the final step.

[1] https://lore.kernel.org/linux-spi/20220331175817.GA91341@9a2d8922b8f1/T/#m2ef266d9f5cf643bb5be17f3a175c638bde3a680

Looking forward for feeback and review comments. Thanks!

Kuldeep Singh (5):
  dt-bindings: i2c: Add Qualcomm Geni based QUP i2c bindings
  dt-bindings: qcom: geni-se: Update i2c schema reference
  dt-bindings: serial: Update Qualcomm geni based QUP uart bindings
  dt-bindings: qcom: geni-se: Update uart schema reference
  dt-bindings: qcom: geni-se: Remove common controller properties

 .../bindings/i2c/qcom,i2c-geni-qcom.yaml      | 110 ++++++++++++++++++
 .../serial/qcom,serial-geni-qcom.yaml         |  86 ++++++++++++++
 .../bindings/soc/qcom/qcom,geni-se.yaml       |  77 +-----------
 3 files changed, 198 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml

-- 
2.25.1

