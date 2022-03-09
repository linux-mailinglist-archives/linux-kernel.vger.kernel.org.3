Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5534F4D2A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiCIIDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiCIICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:02:53 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1DE14ACA5;
        Wed,  9 Mar 2022 00:01:51 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q29so336823pgn.7;
        Wed, 09 Mar 2022 00:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=9NCYkSh7WOOrI18nt+bZr9iw0Fk5iZ5BLxbcbUOhkXI=;
        b=U/jET7sO/NExyFRaWRibiTJ+8oeoHq7sETxqJeQpSDONf935uV6TOOXjtgJAbwuMea
         jfqTxMW4r/MyJbjR9ZI/lcJswrjmXClm1VUX1Co4+y/ZmpJz1nnBLnhJXSFNKFKLRKIw
         gM8e8Z9+rEudkzM3dojRTuIa+5RtbOMbg5s6jtVCIl7M3tyic36fiKh5p9yvQaee+1iI
         2ebxeR/MPfalVSkl3MKkr1P2La3av9sWkyB8TnLb+AEu3GeabbGIOHgqPL1uzFbrXt3G
         mnk4LLyYoKFSZQ96rkWKfE761I1kSSz8+Ek14kvVc2XL06UdpVBWsbnkQxKtRKz0SCYh
         Hnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9NCYkSh7WOOrI18nt+bZr9iw0Fk5iZ5BLxbcbUOhkXI=;
        b=uftaobII1FeFJ02ph2ZvkaVxUkLaPW99jaaYbRuQUyqSInCZ+KB4dNzd9of6Oycd4l
         Qi+nePFuSrfb0c6YZviRxySAixbEvBBqxAalP/a966lLlC8QiediKuDWuEYIE5qhrNP+
         TLC8IpHyuIRDum9ECkHtCIL3D/MP6sIc/gcQwN32NcJJ3aqYhrg+SZSkV4X6o8hX7QgP
         oqARyHIf9F2WIMdttHUn3YTeG6Lc8/HlfErJKulhSsC3X2KF+TXi0PdcANiDbQJrQdLt
         CBlkDzmwmUBGXxDHaYEUAOlhnf2wDlZ65k6h6h4Bku4ZL1wWvrUO4ffuMTmqQHFcKjUJ
         lw6Q==
X-Gm-Message-State: AOAM530lzGVfPpDHBAvBnNZDKoDwx2a6HgK1mqyrM7oB72KGTT2ZaL/C
        DC1R2J8AHeAHYmIrWsTQSUI=
X-Google-Smtp-Source: ABdhPJyAHTOyodUFhv+sthTnW8YLvaPjdwpeM6UGkV/VWqBAwzUrCZ1pwbuiSBE3jtuSS8AVL75kyQ==
X-Received: by 2002:a63:6b81:0:b0:380:4fc1:ee7b with SMTP id g123-20020a636b81000000b003804fc1ee7bmr11601711pgc.298.1646812910588;
        Wed, 09 Mar 2022 00:01:50 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:486:47ca:79e4:f285:9205:e22])
        by smtp.gmail.com with ESMTPSA id ay5-20020a056a00300500b004f6d510af4asm1489873pfb.124.2022.03.09.00.01.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Mar 2022 00:01:49 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     krzysztof.kozlowski@canonical.com, lgirdwood@gmail.com,
        cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Add Richtek RT5190A PMIC support
Date:   Wed,  9 Mar 2022 16:01:41 +0800
Message-Id: <1646812903-32496-1-git-send-email-u0084500@gmail.com>
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

This patch series add Richtek RT5190A PMIC support.

v2:
1. use standard bindings regulator-min/max-microvolt to replace
   fixed-microvolt property
2. change dt-bindings sample node name from rt5190a@64 to pmic@64.
3. add dt-binding header to defin e the opmode mapping number.
4. refine 'richtek,mute-enable' description in dt-binding.
4. due to fixed-microvolt property removal, use of_regulator_match to get
   the regulator init data.
5. fix checkpatch warning and error.

ChiYuan Huang (2):
  dt-bindings: regulator: Add bindings for Richtek RT5190A PMIC
  regulator: rt5190a: Add support for Richtek RT5190A PMIC

 .../regulator/richtek,rt5190a-regulator.yaml       | 141 ++++++
 drivers/regulator/Kconfig                          |  10 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rt5190a-regulator.c              | 513 +++++++++++++++++++++
 .../regulator/richtek,rt5190a-regulator.h          |  15 +
 5 files changed, 680 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
 create mode 100644 drivers/regulator/rt5190a-regulator.c
 create mode 100644 include/dt-bindings/regulator/richtek,rt5190a-regulator.h

-- 
2.7.4

