Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C755AC2C5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiIDErT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIDErP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:47:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E104D4D5;
        Sat,  3 Sep 2022 21:47:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q3so5560772pjg.3;
        Sat, 03 Sep 2022 21:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EMpOr94bRbY90FW4fuPElnBT2PerHRg5lnKxJbnwv/g=;
        b=Bvo0xBMcbCiquBH09l6xwLW2WMk9ZoRYYD+KPrF/DWM9wDuPsxR9EQc7QyMdh8XQkx
         bt5z58BZWIDPgPYRTE3Q2WvI9wS2iZ9WbkWKDHRAASZe0kUW3ZhawYZRROCBF8gJAl8c
         hRIizo1RHDjM0cJj3qIbuQjqlnb9u1ozaapp+IylpT6jsxNg9JmL/tTI494Bf7vIki2z
         3XeW3DnYdEDfG4vUWmR1U85iPPXIsFQud/kf758PxHIS05fnqQpzw98Hhumv03i4bL2x
         4ng6FhUTQGO9eCyC08U+O1jsviinyuRAqKmB5a9S8lBF1V0P1HdIhFpulw3OJqHlPre4
         r7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EMpOr94bRbY90FW4fuPElnBT2PerHRg5lnKxJbnwv/g=;
        b=YRYjqferxr3aomNHuyNF7DtxFJDCL4jG2cmEWK0BXmjBuvHeMHcHkf7VQWg2y8jJAW
         bsUXRSDp8Qr0HzZfiR0eC84kiGpo/0WYhElx4iJ9LF3Ep6VSL6AdKMXHubmqTneWi5bS
         zSS/XxVEh9+Qpepq4xWJD3S/6MtJ1kRwfG6UD1NaTej1tLl/c2mqAU7rM/QxuEUU5jZx
         IyU9DDZLJGibYwH0iftVwMNbdKv+/EGHMhJaSWYRIft9g1s3bBEpmJlRSzPvgddyz1a8
         PEcmBEGzqUQydO8nYknvuXrVX8p325lZJ5SKXcVmrshCYBFVhC9FecMnJXVqxTUoNWTo
         3aGA==
X-Gm-Message-State: ACgBeo0fp94PMrJLZdjgCZbf+jB3m1GFNG9PKw068Zp3jflVOTu42ZT2
        TZ2RFCZRdFD6E/Ws+jZK9cPjgr2GGgk=
X-Google-Smtp-Source: AA6agR7mAJ3jjRnJpZqAGd582eP3upqxb2CO+GIIf/eaYfL1TEIamUJ859hZ/CJN2IJguiyPzIvk+w==
X-Received: by 2002:a17:903:40cb:b0:176:8449:f34 with SMTP id t11-20020a17090340cb00b0017684490f34mr5387249pld.44.1662266833937;
        Sat, 03 Sep 2022 21:47:13 -0700 (PDT)
Received: from localhost.localdomain ([115.99.107.255])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b001641b2d61d4sm4572617plf.30.2022.09.03.21.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 21:47:13 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jagathjog1996@gmail.com
Subject: [PATCH v1 0/2] rtc: add Maxim max31329 real time clock.
Date:   Sun,  4 Sep 2022 10:17:06 +0530
Message-Id: <20220904044708.7062-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Maxim max31329 real time clock.

Jagath Jog J (2):
  dt-bindings: rtc: add Maxim max31329 rtc device tree bindings
  rtc: maxim: Add Maxim max31329 real time clock.

 .../bindings/rtc/maxim,max31329.yaml          |  59 ++
 MAINTAINERS                                   |   7 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-max31329.c                    | 536 ++++++++++++++++++
 5 files changed, 613 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim,max31329.yaml
 create mode 100644 drivers/rtc/rtc-max31329.c

-- 
2.17.1

