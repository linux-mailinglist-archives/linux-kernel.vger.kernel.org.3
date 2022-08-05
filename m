Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8665858AE66
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbiHEQut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiHEQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:50:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E001BEA5
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:50:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bv3so3868632wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=yFyYh97IYuVooEC2yIKQXKO7OyDRqCyKCP13Fg1c4I4=;
        b=NrSGXLYMebNqXf4mU8+m7aQGcgnArFz4n1QpBagkao3kWUCAU04iwwHRMQSQgSLRnA
         O6JZq2cAbUId7q9FI+VJ7B0zBBTnKdO5gHSi2xR2O6YmVMJy/Dms3bdz3mKJ9NP4wJ4p
         jQbz4SbEwslYi7JXN1D6aAsyqXS/iIcyTaWd9JoXidiTzl3RX9rk9h1b89GzdwVfEs71
         k8qMK0e+mZC9xZgu9Kfqw/t2VAemEk+B5Uvupf7OE45Cslih9jEOFZ/kcfdrht719rOF
         IMEaHJ+6IEuLG120BP9BJLvhjCBHb1LisD0wGsnZ4E2+Q41UzWuhM+f1YZk+HB8VG87O
         hfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=yFyYh97IYuVooEC2yIKQXKO7OyDRqCyKCP13Fg1c4I4=;
        b=UtQDs7pbW52MiJRMER/nSsm3A0kt20IpIODveahUAassdAgqR5/eHPdkeCnmZ1UGt9
         UeFgOXfQwCRxPvAo3LAEsLQNtrnI3JalgY2wb0R3OAnpU9ymXO92y6PZRQjpCoaRyzox
         S1PvxxLaznyzv5NCBgUIfPcMx1rmILcSPuOKS+ghYKmFtCalP7GNmFooel4okmcM5oMN
         50qsDR6OIh9T6TijD+jSuMDRIhh921uxp3z+VQccEqXoxhVjrLACShW7Gb4IWanGqayM
         0aVdlWUMqV1Up1iv21keC5H+X2Kz+PZSwPH/La47ICBTF2ML2csiAumOoI0Tm9pEROL7
         e46g==
X-Gm-Message-State: ACgBeo1FMZW/UcelKe8+KVUEKif9wA4iaTYAyHOU2n6+4TtPH5d2j7sf
        WoR1nO/aoc8dgRmz+iTUYUOITA==
X-Google-Smtp-Source: AA6agR7rP8RAt3poO3DgHsTL5x3vNMfPJ30328j41H5hxzzcKLK2RonYR5W/ky83T7ZtboO9xdeECA==
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id e14-20020a056000178e00b00220635feb13mr4940675wrg.634.1659718243421;
        Fri, 05 Aug 2022 09:50:43 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h28-20020a05600c2cbc00b003a4f08495b7sm11325374wmc.34.2022.08.05.09.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:50:42 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>
Subject: DesignWare PWM support for device-tree probing
Date:   Fri,  5 Aug 2022 17:50:25 +0100
Message-Id: <20220805165033.140958-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is tidying up and adding device-tree support for the
DesignWare DW-APB-timers block.

Changes:

v3:
- change the compatible name
- squash down pwm count patch
- fixup patch naming

v2:
- fix #pwm-cells count to be 3
- fix indetation 
- merge the two clock patches
- add HAS_IOMEM as a config dependency



