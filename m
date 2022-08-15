Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E67592A90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241007AbiHOHeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHOHeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:34:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC67183AD;
        Mon, 15 Aug 2022 00:34:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gp7so6284727pjb.4;
        Mon, 15 Aug 2022 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=9yIm0nBgVpzjTv34ZosyZE5XsOe3I7JmQR6D+9Qx4C0=;
        b=iECKaMdN0/TpIxLum+UJ9eNKkFX2YACEwfN1QPRQHucK8u4iwinfoJ0RwG3X3JoZvO
         gn1/FLe162aqFK7LLwPxLmwEYTfpErLsfsa5xEPMCtbBBC3aFjOjVYHcr6bhhX9aQx0D
         gXEOVWA3mXoNSrOPDKu9C11MhmryNB9TAE1VC4v6/75+Z9vZSu6GOF/Loo6kgF5fahBP
         4Hv6qkusTInNNtYLPM/3wnmxIhoYDGMTfqgv37g0uKhcnMf4xdjngzb4n2qsSQSQ+HHL
         f2GXK/QutquFexpcPN7dP8aBodVM0pQKL8LYT6GGhVB47ZKbyYq4k1Y8glGrxGFL9Dv4
         TS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9yIm0nBgVpzjTv34ZosyZE5XsOe3I7JmQR6D+9Qx4C0=;
        b=jjRU9kSyctalZGbXtzZ4vggPWBzarAWCvGdvoKIziIly8IBVjqEvsCeKLw8/jwDM5d
         kOfuSC4tySBpWBhUFUXRwQRlYOux7A/V/Wv2F65Lj1/Io7Xn0SNg0HlQ3UfhQeekCQ8P
         Cq0kr2sFzNebtQeE41sNy2vGT5SFZHQcr51x+fDkdejBG8Gyh0Nem9DKpiaLu1+z9/Na
         EXngdvfdXQyNXIg5kV5me1XNIK93leZQ56RILhmPJZI8ZNY2taMmLZ71GZ6LQne9Crz0
         NO+ogvABiqw9jk581VLcisV5lxlanpbndo7OrTjNMrE0t2tZfDSDBtv6X1Z3aHu5gpfn
         03tg==
X-Gm-Message-State: ACgBeo10gv3NJigrfLnSndX2T7g6xPItTBRZud3scd8vQMgfCM1AQnLj
        kHDLyOedt1ajiNBI+Ht1EZYLPA9pkoA=
X-Google-Smtp-Source: AA6agR5D9nFjb5+cpxa4Ujkt35A8LfEIslCAzbpI0NeQD2r4p+Vu7XAMLYzuuTfFTRhusLkIez0iiQ==
X-Received: by 2002:a17:90b:149:b0:1f7:59cd:9847 with SMTP id em9-20020a17090b014900b001f759cd9847mr27150998pjb.78.1660548860375;
        Mon, 15 Aug 2022 00:34:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46b:2a3e:f57e:22d4:1ae1:ffd3])
        by smtp.gmail.com with ESMTPSA id r1-20020aa79ec1000000b0053249b67215sm6088503pfq.131.2022.08.15.00.34.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2022 00:34:19 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     alina_yu@richtek.com, cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add Richtek RT9471 3A battery charger support
Date:   Mon, 15 Aug 2022 15:34:10 +0800
Message-Id: <1660548852-6222-1-git-send-email-u0084500@gmail.com>
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

This patch set is to add Richtek RT9471 charger support.

The RT9471/D is a highly-integrated 3A switch mode battery charge management
and system power path management device for single cell Li-Ion and Li-polymer
battery. The low impedance power path optimizes switch-mode operation
efficiency, reduces battery charging time and extends battery life during
discharging phase.

Since v2:
- Remove the properties for interrupt controller things in the binding documentation.
- Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
- Add regulator min/max microamp to allow otg vbus current adjustable in example.
- Specify the active-level for charge-enable-gpios in binding example.
- Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to_chip function.
- Specify the member name directly for the use of linear range.

ChiYuan Huang (2):
  dt-bindings: power: supply: Add Richtek RT9471 battery charger
  power: supply: rt9471: Add Richtek RT9471 charger driver

 .../bindings/power/supply/richtek,rt9471.yaml      |  73 ++
 drivers/power/supply/Kconfig                       |  16 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9471.c                      | 953 +++++++++++++++++++++
 drivers/power/supply/rt9471.h                      |  76 ++
 5 files changed, 1119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
 create mode 100644 drivers/power/supply/rt9471.c
 create mode 100644 drivers/power/supply/rt9471.h

-- 
2.7.4

