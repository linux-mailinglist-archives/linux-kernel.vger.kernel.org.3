Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D295E51B1F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbiEDWeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbiEDWdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:33:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F0FEA;
        Wed,  4 May 2022 15:30:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so6372384pjv.4;
        Wed, 04 May 2022 15:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=taWmHmBKBzHrmg7KZh9uiyXIEIV6gHiEkNwKxQ/MES0=;
        b=hh/olrkV6vVJdNb/Ps0uIV2urNTp/ZSrT8/Qv8bidehOazsqTe79UN7/X1Q1CRB34t
         WdhQb1A4j8/hi70O/51NpOhFBz7l4veSnO0E1/TZ+xF1x93tgdrsmBVHCsbHsNWMQeqy
         LkJ3rOabvMYQYUW/OSRVHXJu/i2K1xP1nevUuIJRAmtqBKc4PYTs4djn0dY15eWyuxlv
         xiqOcTUrOeZH5Gp6ulSiFHsiGO3+RpdTQwUSxwZX3zrlXZ39Bvg3s63pR8tSlVoXzld8
         z3hDdlwz5qM4Zo5HR/SubFSs8U1NyclFU6wsA30bPxhHMpVMoakZTPpq55u84y3KeEwF
         LeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=taWmHmBKBzHrmg7KZh9uiyXIEIV6gHiEkNwKxQ/MES0=;
        b=zK7zckbxtAA20l4eTKnA1ceSn/MA9q9Tp5g3B/lYY+MhavC98FpdUhZP7/yrTqOoS0
         zey5sgcPyeDWofnYXuamR591z8FYGkxwBNyOh9RlwN5SGOd0JbVBF8l4SxK+nxTR2kIY
         dCv7LishyKdqi05jcW3mpvbdZMau8xb6Ira/AJCXARN6fmmZPorcgMGOX32wN63iUGcz
         Suy6+dqb9da8cUgWToPP4h4Ot3RwuX+1bgI86TosxoxPh8Psr13nz1mma+WmawQzGL5L
         GCNSEDMoWTXHoh8MYlIW6YGYV0wiABQE+W9dqH4ASJ0V1vxFBxxXmlSZXX8mb7K8CKn3
         h28g==
X-Gm-Message-State: AOAM531EyeFs/LCLqsywfyV8CeQgHjXlAk9C5kowxrO6LafHh5D4MLYi
        5k//jMJVmXadSSG6VdU9/ys=
X-Google-Smtp-Source: ABdhPJzZrrnfwa2OuGVWPvNzObbnOzcy0xJ2YpADq0QZKoMO6Nl7fDxBPcPWzBxxMU6TWVYXV5n6ZA==
X-Received: by 2002:a17:90b:38c7:b0:1dc:77aa:e3d5 with SMTP id nn7-20020a17090b38c700b001dc77aae3d5mr2090696pjb.51.1651703414335;
        Wed, 04 May 2022 15:30:14 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709028a8400b0015e8d4eb257sm8882284plo.161.2022.05.04.15.30.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2022 15:30:13 -0700 (PDT)
From:   Justin Chen <justinpopo6@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        justinpopo6@gmail.com
Subject: [PATCH v2 0/2] Add support for NXP PCA6408
Date:   Wed,  4 May 2022 15:29:15 -0700
Message-Id: <1651703357-25154-1-git-send-email-justinpopo6@gmail.com>
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

The NXP PCA6408 is the 8 bit/8 GPIO version of the NXP PCA6416.

Justin Chen (2):
  gpio: pca953xx: Add support for pca6408
  dt-bindings: gpio: pca95xx: add entry for pca6408

 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 1 +
 drivers/gpio/gpio-pca953x.c                              | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.7.4

