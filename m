Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCD04F7C91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbiDGKUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbiDGKUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:20:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045191275BD;
        Thu,  7 Apr 2022 03:17:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p15so8775187lfk.8;
        Thu, 07 Apr 2022 03:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R23eSOYeKnVIkjdK9W7sc64FQ0WoMp1PYcNJNNlM9q8=;
        b=LCCY2AGWZ59w4m8u4Zq3C46NPZiwUhM/BQyPVysOwHWpHwQWzUooRR7sEFOE0MXoRh
         H96HxipCICxV3kBucZhdutpHg2sj6grvReAAkY448TOB+yx9qRqqTr/7p/GeaTeFkFbE
         OOYznV/0UmyISeUOfskgi8RS62Qjmn5UDC/nFgCAbwc9uMM4j3kNTWLHway8iY/Nf5oN
         HGxLQGlEh/o9VBp58LdMbkJ0TS7YuOaTdVrnr5J+Oxgu7o/NNnYf1YJZIq0xxSIrwu34
         jH4pbMNnK0E+cr0o/X5sL2/lY0cnZ2a3VQg3/Aar4uWcogQRcmRAVCG99bK+KKp+ZglG
         b4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R23eSOYeKnVIkjdK9W7sc64FQ0WoMp1PYcNJNNlM9q8=;
        b=LdnBNx6S70iNeneAhLcH731X57vqzxs2sr4m8CaMca6+r6lSvN7mLJbutwa/KgyclG
         Sq6TqR1xgKiEKOTCcr19op9U3tJeRGBYRDxBJXCPwFVWbZ0mzwheTuVBOIpKN4xfYYOh
         RDt5vUca8WID1E6w2TrDVAYXLiOEpXHexcJndofLbZ4jK8jimLXshEazEMPCSgc+wl5H
         T4HHY0kEqZtrjf0C6rarDw/Fd4JI1VP+wpISDr+hl4ngHnJFbRRLgBCppR0cjYjK8RHG
         5Yc3AOzlFYuxu6AtmlgjBIwMJPj0SThcazKHZBtEPF71Hdr719KzbdfRZXnDy02G+QC6
         OTKg==
X-Gm-Message-State: AOAM532L9cX2mxtYCi76ByeyZ3sShD/2JD3nxckmHU2ZDu61kuOEJaRE
        NToREEmbePF+SmvUOBGkb3XB7km8AgE=
X-Google-Smtp-Source: ABdhPJxg3ZbrgiCbN+q3qlkjV//3PevfiKjzGQeO4D4J2bBOvaV9lASYgS5QozSakWrKYPqRoX6/dQ==
X-Received: by 2002:a05:6512:10c9:b0:44a:fea7:50ac with SMTP id k9-20020a05651210c900b0044afea750acmr8775459lfg.680.1649326676971;
        Thu, 07 Apr 2022 03:17:56 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id d2-20020a194f02000000b0044a2b77cd8dsm2121656lfb.105.2022.04.07.03.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 03:17:56 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Make AUX gpio pin optional for ktd2692
Date:   Thu,  7 Apr 2022 13:10:04 +0300
Message-Id: <20220407101034.13122-1-markuss.broks@gmail.com>
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

Some appliances of ktd2692 don't have the AUX pin connected to
a GPIO. Specifically, Samsung Galaxy J5 (2015), which uses ktd2692
for driving the front flash LED, has the pin not connected anywhere on
schematics. Make specifying the AUX pin optional, since it is additional
functionality and only affects amount of current going through the LED.

Also convert the txt device-tree bindings to yaml and pick up maintainership
over the yaml binding and the driver itself.

Markuss Broks (2):
  dt-bindings: leds: convert ktd2692 bindings to yaml
  leds: ktd2692: Make aux-gpios optional

 .../bindings/leds/kinetic,ktd2692.yaml        | 87 +++++++++++++++++++
 .../devicetree/bindings/leds/leds-ktd2692.txt | 50 -----------
 MAINTAINERS                                   |  6 ++
 drivers/leds/flash/leds-ktd2692.c             | 18 ++--
 4 files changed, 103 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-ktd2692.txt

-- 
2.35.1

