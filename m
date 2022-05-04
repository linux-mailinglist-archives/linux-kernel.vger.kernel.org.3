Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658FF51AC4D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359513AbiEDSJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377149AbiEDSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:09:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561C574852;
        Wed,  4 May 2022 10:25:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id bo5so1660715pfb.4;
        Wed, 04 May 2022 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=2EG923YunXxMIRB5AdPbZWO+gcyuZCyea6nE4SQdQi4=;
        b=ipjLggzPiz/eJEpndRj59iVwXQNoo+Vmte1xoLK0NYLOIRXddPEVmHDWoS8wgjsjSz
         8Jn2hvpiplReHzVJgb0gdXvZl755Y0qaEhs7HhWYAs0RwCB66czuh+iEo4Hw6rcJUXSP
         A/v5Act9FfskpO+LXd8p6moiRt32uSozOSJZa1AF4GQuS+6BgnVuPaOO/7MfzaAyyU6d
         baisyxawEApF+vYYRVWWSTbNscmgdtB3calgjjKOv/wjXvhM1pJShsHPnXrCUVKEglXE
         Ji0nGyXdshUrNddwwvwUFYNt71y5h4+mQj+jJUbRcUq2xWp2wMZLB/QuLXhIEml8yk8G
         6w/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2EG923YunXxMIRB5AdPbZWO+gcyuZCyea6nE4SQdQi4=;
        b=htQHhoKPWcrBDa9YsHJqt5jA2WJVaXPa3q0CcWW7VktGSZ+aJ4Lv9DETJCLQokWf5J
         wCXSY7R4ZzPnZQJFta3NjdcJbMu4o3t8CovCdSnGjKyNYKQqavO0+kI3ahpMExzbL4iA
         fz+In3gHN4WkN8CihFzoqRx/mDHZ4OVrlYuo5QZrRfk7l4jHYd2VwqLyL9OoOfmjzv9r
         qvhAtaMyM6+2a75/zZVH4/TjjeQikZj87gKxq74eLXcd64us0Meex7RDFvpE8q/7h1Ob
         PS2ZNckNHI7KtmWHUbpITVUWcRnEylUdJK31HpfaSEMj5iELVUHjRjPtZDyf02z69UIf
         R/8w==
X-Gm-Message-State: AOAM530z390b9RQtoYXrPhTZv28XTO1Ni5MHfIqP9W/2xQg20TA5yWya
        Q284edE4h7u3n7ZMYr/ucik=
X-Google-Smtp-Source: ABdhPJyzZKUkPuSHvhjneBcAXWsr5LD+ZNnP4WJixLuTMpPSRvyGQEL9cNYK3JCftPpu/yBiJz+ZfQ==
X-Received: by 2002:a63:1a5c:0:b0:3c1:9a7c:3739 with SMTP id a28-20020a631a5c000000b003c19a7c3739mr18647416pgm.272.1651685106590;
        Wed, 04 May 2022 10:25:06 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78295000000b0050dc76281b7sm8772104pfm.145.2022.05.04.10.25.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2022 10:25:06 -0700 (PDT)
From:   Justin Chen <justinpopo6@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH 0/2] Add support for NXP PCA6408
Date:   Wed,  4 May 2022 10:24:58 -0700
Message-Id: <1651685100-44687-1-git-send-email-justinpopo6@gmail.com>
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

From: Justin Chen <justin.chen@broadcom.com>

The NXP PCA6408 is the 8 bit/8 GPIO version of the NXP PCA6416.

Justin Chen (2):
  gpio: pca953xx: Add support for pca6408
  dt-bindings: gpio: pca95xx: add entry for pca6408

 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 1 +
 drivers/gpio/gpio-pca953x.c                              | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.7.4

