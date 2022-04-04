Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0CB4F1F04
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381040AbiDDVtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379980AbiDDScB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:32:01 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF124F04;
        Mon,  4 Apr 2022 11:30:04 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s72so9042772pgc.5;
        Mon, 04 Apr 2022 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sXct9/UnBXMq+1V+NeSI5DaC797wzrUVGTBB5CZgJK4=;
        b=O4n4HHZ1iTWjUoNulBokaM1Tk+bfGHplhpd09tks/e88MkgwfEChGl36kou9YP70y+
         ADqvCbYk/1DZ4uNprSiaJWrw3xFl5uUfu5BUbDCwuUZxlpOvTDNFz+jxIhOIpQqFaENv
         OyGP3+qfsUZ7vmSnDqQ43oMmYvwRyVkWWDI6eDGpIkWJLTC6DzTjIQO0pkBA4OFRV9RO
         v03btkBpjvxcpPijSikZVLV4T8KG+gSXIuB5ufpbSXdn+ylaNPh+n6CQBadxTCTW3xys
         KDpUd4grxVtLZLiU1TmhXOclexi9U3Ao6xiwwQZ7nE+wir0T5FtkA9PFo0FXeo/nLrt+
         c40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sXct9/UnBXMq+1V+NeSI5DaC797wzrUVGTBB5CZgJK4=;
        b=JK8WE0wFrdc8YMyhlKkbygyWfr38fF1usL2DYPgSkzcTF3ND6Gy4Pv+5Wst6+lLu7j
         UwVwl/7uMTblx/+ELAowvm+KQ9ltnJFgIOfdrKIvsPQz7mBuFPzANb52Ag7ee9cPCjpg
         fqdDBpsvtyfshmUaMPAcsj6G83fM7eQ4ScTcmDApf5BnsuXZ5WGPk4Beo3i9M3mhnMiW
         M7dw6x6lUWphPQH7WtQi3T67T+1+xBbAsYidOCNg6lu31FkWD0X/yVAxrVS6RXQPDbD1
         AdnWtwqbmKP0+lFyDzw02nVbOoFOoZouPNn9M6WR8pk3MICtY87w4dvAY6a6JnyvgWoJ
         7qAg==
X-Gm-Message-State: AOAM533rwEeJJlht/9v8jj5ccGxAMh/4KBRXM8VvZih2W98oaED3zOOE
        gT7vFsuHVXr6CBnFfygI22U=
X-Google-Smtp-Source: ABdhPJxUFLj8SBQkou46eeuvtSZYmCkSQT5K5V3rX6S5Ghw3vNpzc9mgyF8k18fVmDPpVyi//3hDIQ==
X-Received: by 2002:a63:b20e:0:b0:398:5b28:e54a with SMTP id x14-20020a63b20e000000b003985b28e54amr978946pge.443.1649097003500;
        Mon, 04 Apr 2022 11:30:03 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id kk11-20020a17090b4a0b00b001c73933d803sm162656pjb.10.2022.04.04.11.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:30:03 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>
Subject: [PATCH v2 0/4] Geni based QUP controller binding cleanups
Date:   Mon,  4 Apr 2022 23:59:33 +0530
Message-Id: <20220404182938.29492-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
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

v1 link:
https://lore.kernel.org/lkml/20220402051206.6115-1-singh.kuldeep87k@gmail.com/

Updates:
- Address Krzysztof's comments
- Drop patch 5/5 and merge with 4/5 of v1
- In-patch updates
---

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

[1] https://lore.kernel.org/linux-devicetree/20220404064017.68634-1-krzysztof.kozlowski@linaro.org/

Looking forward for feeback and review comments. Thanks!

Kuldeep Singh (4):
  dt-bindings: I2C: Add Qualcomm Geni based QUP I2C bindings
  dt-bindings: qcom: geni-se: Update I2C schema reference
  dt-bindings: serial: Update Qualcomm geni based QUP UART bindings
  dt-bindings: qcom: geni-se: Update UART schema reference

 .../bindings/i2c/qcom,i2c-geni-qcom.yaml      | 100 ++++++++++++++++++
 .../serial/qcom,serial-geni-qcom.yaml         |  86 +++++++++++++++
 .../bindings/soc/qcom/qcom,geni-se.yaml       |  77 +-------------
 3 files changed, 188 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml

-- 
2.25.1

