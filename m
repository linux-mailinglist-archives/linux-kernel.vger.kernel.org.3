Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E657A2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiGSPOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbiGSPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:14:35 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76887545D4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:14:34 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id r22-20020a056830419600b0061c6edc5dcfso11871111otu.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zoha9mTIMakggfiI68R52rbC0zksIGENsxIUmVWIeyQ=;
        b=QYaiG5cPRORhb6h8qWgSUFIAvMesaeBIC2zWt6+wdG/SN0MGKl2AEEeRTOK2Qxz98i
         R7e+8H1Ijc27lGYissVA/wewvTQW8T0ia+u76ESiyvqYhZkqSxkioPT2MNw0j8jtGdoD
         l5FTFAKxnxfyLIhkj7vBKIg/igZ+aOW2bi8SMQKazqFJdxJ+RbeLBQBbUQzff26Nv/ic
         g5ITMxNjUto+f2ttRI457gRs+vl01iyC0s5nG71VJc0G1+ykVrSERvJOs2A4t4pJd36W
         70ZV35SQUd+wYVJU31A900kBhUscNCmfMesxOVrFutLWrGua7g0LOJ67rrqVGDPazPDm
         br7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zoha9mTIMakggfiI68R52rbC0zksIGENsxIUmVWIeyQ=;
        b=SCRUOIctAkGp1uuuSN1wXN3LRzbXCDxLbyf3ijapGlrU8JK0BxsoGN4TVkHfcAFbNa
         6yzHZdIoM3RnVoOXIziBNpcIXnSqu8cxmNytGbtrATlO0b7UI4JZXnaY3IIgc5VINMFc
         pBIagyzPA831hqT/5SQn781v4szsjF+aCPaeucfqpYBlhVRhmLlYbWoPgR78vJpmt9Av
         +QcXOggb0rzv0+Ww+6tOBsijwY3a99LGRnRSAzJnocFoJ6o/uIwSmr4ib3TdT8lH0g/r
         8e1BwCO/jffOOoOnftn0VZMopFCjQjaP0J1SEfZy/vuIqri6FqE4rBFd32Q3Aa7aV6fQ
         VVww==
X-Gm-Message-State: AJIora/uV6smr9Sz+wfcWlbo/vVZsxUZTb2JknjoP/CFc4Js+c5dSmK+
        FxCqAnCM4gnDrzQgJh5tmt12tA==
X-Google-Smtp-Source: AGRyM1viF0SYVbifqUuBU0el23Wf0gyXRIq6IypE3bPydxzkIXca4bSKIuv4Kd2vseAQ0+i8Zhs32w==
X-Received: by 2002:a9d:4d89:0:b0:61c:a0cf:7426 with SMTP id u9-20020a9d4d89000000b0061ca0cf7426mr4723769otk.248.1658243673809;
        Tue, 19 Jul 2022 08:14:33 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id l24-20020a056830155800b0061c8bca21d8sm2334308otp.2.2022.07.19.08.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:14:33 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>,
        Fred Eckert <Frede@cmslaser.com>,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 0/6] gpio: Implement and utilize register structures for ISA drivers
Date:   Tue, 19 Jul 2022 09:47:02 -0400
Message-Id: <cover.1658236876.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
 - Cleanup superfluous header includes from drivers
 - Add note to CONFIG_GPIO_I8255 Kconfig that if built as a module the
   name will be 'gpio-i8255'
 - Remove 'const' from '__iomem' pointers
 - Replace ambiguous 'group' terminology with more understandable 'bank'
 - Use more natural '>= 4' expression to represent upper nibble
 - Refactor i8255_set_port() to take more common pattern of mask and
   bits

The PC104/ISA drivers were updated to use I/O memory accessor calls such
as ioread8()/iowrite8() in a previous patch series [0]. This
patchset is a continuation of the effort to improve the code readability
and reduce magic numbers by implementing and utilizing named register
data structures.

One of the benefits is that we can now observe more easily similarities
in devices that share similar interfaces; such as the i8255 interfaces
used by the 104-DIO-48E, 104-IDI-48, and GPIO-MM drivers -- as well as
the similar interface used by the 104-IDIO-16 and PCI-IDIO-16 drivers.

A new module supporting the Intel 8255 interface is introduced to
consolidate the common code found among the 104-DIO-48E, 104-IDI-48, and
GPIO-MM drivers.

[0] https://lore.kernel.org/all/cover.1652201921.git.william.gray@linaro.org/

William Breathitt Gray (6):
  gpio: ws16c48: Implement and utilize register structures
  gpio: 104-idio-16: Implement and utilize register structures
  gpio: i8255: Introduce the Intel 8255 interface library module
  gpio: 104-dio-48e: Implement and utilize register structures
  gpio: 104-idi-48: Implement and utilize register structures
  gpio: gpio-mm: Implement and utilize register structures

 MAINTAINERS                     |   6 +
 drivers/gpio/Kconfig            |  15 ++
 drivers/gpio/Makefile           |   1 +
 drivers/gpio/gpio-104-dio-48e.c | 249 ++++++++-------------------
 drivers/gpio/gpio-104-idi-48.c  | 143 +++++++---------
 drivers/gpio/gpio-104-idio-16.c |  60 +++++--
 drivers/gpio/gpio-gpio-mm.c     | 202 +++++-----------------
 drivers/gpio/gpio-i8255.c       | 287 ++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-i8255.h       |  46 +++++
 drivers/gpio/gpio-ws16c48.c     | 120 +++++++++----
 10 files changed, 654 insertions(+), 475 deletions(-)
 create mode 100644 drivers/gpio/gpio-i8255.c
 create mode 100644 drivers/gpio/gpio-i8255.h


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

