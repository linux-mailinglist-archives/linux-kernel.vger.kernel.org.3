Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1669E5990FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbiHRXMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbiHRXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:11:58 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D59D075E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:11:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id p5so734528qvz.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JxopBh8HkyBkhRSXNYJZ9c/ibzZWN5l/rUoK8TuOX2E=;
        b=iC+fZT3dlJvUKuKtlV48BgZMVi5cgLckf98h3Odsln7D0P1vjmxRyrmDeTJuYXy8IH
         EQApL5yeY0dyQ2tsCWKu/NzConaTwfRZk1kM2sH8PfORdch+wfEAOM52CN0HS59+BT8N
         06YZ6tQcs3XhGRJCpDxzjlQohUrimOBJa+PTFyoSeKj6H8q8M+fquSoZzz8GYwfELBAb
         DzrHffMKlr8M7i+XxKFObuJxSvTpg+MMj87vIHIVobjd1m54YOCsq/ADZwu0SAzuauD7
         PSsmaq/EGBdwZqv3jcNT22E6xojVI14ljhVNOA0BcW0CjyXrDATAUA0twA1Q2JOeGeIJ
         kdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JxopBh8HkyBkhRSXNYJZ9c/ibzZWN5l/rUoK8TuOX2E=;
        b=d8FWmxJxzD+SN+kAvlLCWJBCIN4KnSs5GSYI3Ti1MPLKVMBTuhx/hocmKCQKfe3fsD
         UeZJf6EljjyCm/fKb1Qe/DkqCSKG7A5vqgwWrxqMRX1wEHE2Jx3AO/vX/DV4+DynHH7H
         WAvnb74fZKrTJdI184FX+4eY1BXutopIsylBBtlktM9b/7P67LqjdlCxpV4oFf+0qsez
         +PYS5gekJgC1uAAymTcmnJiiuup8Y0+ZHp2iS+HaFDvlgeAeb3YwNuJYfB4q6tzbSGFs
         Vbth6o1ZLP9lFu7Ulvpjs6m2Sn4wytnVHj7UlK+8s3JExtLd5H2enTProLUj1wKvn0Jx
         ayGQ==
X-Gm-Message-State: ACgBeo29KMWvX7qf8oFUUlEhNMw3vQWVPqQf65NW/gUTzUrrbW3gMudd
        lWjQcKcDyuqVRnf6QPwVH3bg8A==
X-Google-Smtp-Source: AA6agR6JFebgufNISDLa/5GzivziP1PbzXx5oI5c8sUtOaFjejEBHcQqXYr+1ptbJBY0I7zCalGLcw==
X-Received: by 2002:a0c:e482:0:b0:496:c63a:a3a3 with SMTP id n2-20020a0ce482000000b00496c63aa3a3mr113741qvl.28.1660864316805;
        Thu, 18 Aug 2022 16:11:56 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a245000b006b5f06186aesm2864801qkn.65.2022.08.18.16.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 16:11:56 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.or, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/6] isa: Ensure number of irq matches number of base
Date:   Thu, 18 Aug 2022 12:28:09 -0400
Message-Id: <cover.1660839809.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several ISA drivers support IRQ and call devm_request_irq() in their
device probe callbacks. These drivers typically provide an "irq" array
module parameter, which matches with the respective "base" array module
parameter, to specify what IRQ lines are used for each device. To reduce
code repetition, a module_isa_driver_with_irq helper macro is introduced
providing a check ensuring that the number of "irq" passed to the module
matches with the respective number of "base". The relevant ISA drivers
are updated accordingly to utilize the new module_isa_driver_with_irq
macro.

William Breathitt Gray (6):
  isa: Introduce the module_isa_driver_with_irq helper macro
  counter: 104-quad-8: Ensure number of irq matches number of base
  gpio: 104-dio-48e: Ensure number of irq matches number of base
  gpio: 104-idi-48: Ensure number of irq matches number of base
  gpio: 104-idio-16: Ensure number of irq matches number of base
  gpio: ws16c48: Ensure number of irq matches number of base

 drivers/counter/104-quad-8.c    |  5 ++--
 drivers/gpio/gpio-104-dio-48e.c |  5 ++--
 drivers/gpio/gpio-104-idi-48.c  |  5 ++--
 drivers/gpio/gpio-104-idio-16.c |  5 ++--
 drivers/gpio/gpio-ws16c48.c     |  5 ++--
 include/linux/isa.h             | 52 ++++++++++++++++++++++++++-------
 6 files changed, 57 insertions(+), 20 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.2

