Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FC5B04DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIGNMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiIGNMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:12:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F5A7E314;
        Wed,  7 Sep 2022 06:12:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bg5-20020a05600c3c8500b003a7b6ae4eb2so562247wmb.4;
        Wed, 07 Sep 2022 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ynCgB3/njUUtikJbNwwFb27dQMoAVrUmbX/w5/0BTeA=;
        b=WRVYYcfUhTkxkxAptbak95eCopWgsjEwvL/n2b/7aR6On4JZ7gXXmtPgYHvDu10kI4
         9jD6TZ87MciOTekZ7S2y8hruk/3N+bixI7WGc0sq7DfaYlnatujOYB1/62HazOZzNACg
         vKzP6MtlfyEFDmZ5t9tb08Z3OLPy248FgcZMw2TyPOelQKlmFm5msb38zn7pbZRxhDij
         TZ2FXnSv/4YAfrrPBV+VY6RKPCKvhwkPsDxkQkcnkq3MKOQ3RdtAf/+X1TtUIGlUPATp
         i+yCrj75IAJrZCc/eeNDkqzegpFRS7jJ6VhAtwGLmUojnh1wD+2bZmM0N29tA7bEKN9s
         GV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ynCgB3/njUUtikJbNwwFb27dQMoAVrUmbX/w5/0BTeA=;
        b=gCzoa4vzFVcStsidbPFxuJVi5+H1Eidv8xUGBLxjqV3kd+u3IteRaj+UEcrHykFrH0
         pzdfs8EK738FKVgDIifBM2JOYkGrDnKvv3tc5tC5hEyopWvXTE2vcN30xww4fSn93xEF
         4YF1xA8CorcPkH7sQglpUzrZPbhHdIurcsbZnHEHFoTxJqqfhb2RNNpJ5Dn4dPSyhPeW
         HU2vISI6CNrFblwZEHOeBABQaOWQK5XXUlFzij58WlVpQnrpsEkCWOzg1R0/VttZ5RrH
         WxJNgi0CZeErHuEJ60jAzkmqoOmeLSG05WFgokMHdp9XzkttFEHLi7Zvrl+DGvBzMpV/
         GqKg==
X-Gm-Message-State: ACgBeo1TEQzZWmeGg26pX+/85xFGI1D0mL16ehWU6PKeFO81+dgj9NIW
        lVaY+GrOkykX37sGUtoKx8dGQQLHIMg=
X-Google-Smtp-Source: AA6agR51blRYnP1FdPWL5S6gbaY0mteO+Mdtv37DibtneVcbmfJ/3+zkurHVXskg/s9vJ+Jq8l+q2w==
X-Received: by 2002:a05:600c:4207:b0:3a7:b53f:d6e2 with SMTP id x7-20020a05600c420700b003a7b53fd6e2mr17042881wmh.116.1662556365734;
        Wed, 07 Sep 2022 06:12:45 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id az24-20020adfe198000000b00228619a097esm15102018wrb.49.2022.09.07.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:12:44 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add PWM for MStar SoCs
Date:   Wed,  7 Sep 2022 15:12:36 +0200
Message-Id: <20220907131241.31941-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This patches series adds a new driver for the PWM found in the Mstar
MSC313e SoCs and newer. It adds a basic pwm driver, the corresponding
devicetree bindings and its documentation.

Changes since v1:
- Fixed commit message for the dt-bindings doc
- Removed "OneOf" from the dt-bindings doc
- Re-ordered alphabetically in Kconfig and remove
  unseless empty lines
- Explain and adds comment in _writecounter() (hw
  constrainst)
- Reworked the msc313e_pwm_config() function
- Fixed clk handling
- Removed extra callbacks, only keep .apply and .get_state
- Implement .get_state completly, this fixes the driver with PWM_DEBUG
  (the whole driver has been tested with PWM_DEBUG).
- Dropped useless lines in _probe
- I have kept regmap_field() because it is more clean and helpful, it
  avoids to do too much of offset and mask and shift all over the place.

Daniel Palmer (1):
  pwm: Add support for the MSTAR MSC313 PWM

Romain Perier (4):
  dt-bindings: pwm: Add Mstar MSC313e PWM devicetree bindings
    documentation
  ARM: dts: mstar: Add pwm device node to infinity
  ARM: dts: mstar: Add pwm device node to infinity3
  ARM: dts: mstar: Add pwm device node to infinity2m

 .../bindings/pwm/mstar,msc313e-pwm.yaml       |  46 +++
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/mstar-infinity.dtsi         |  10 +
 arch/arm/boot/dts/mstar-infinity2m.dtsi       |   8 +
 arch/arm/boot/dts/mstar-infinity3.dtsi        |  10 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-msc313e.c                     | 269 ++++++++++++++++++
 8 files changed, 355 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
 create mode 100644 drivers/pwm/pwm-msc313e.c

-- 
2.35.1

