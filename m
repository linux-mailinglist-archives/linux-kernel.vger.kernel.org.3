Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D8056AEF4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiGGXQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiGGXQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:16:16 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91869675B3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:16:15 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-101b4f9e825so27274945fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3GtFLT5VlHIMmMMlLDEGSWPueKfPOd59FonXvTzyyE=;
        b=HaK0sV1wqReBsLI5fYuywyIsK7IX8zq2V0C3U4KAcNkLTQILSU0CP1lyPlfvHr/WjE
         ml4+0viUos4z0FKMiUTBEsAoq8Ap4hrnsoMbZ0HSP7e2jfzz3EkamK/Xh1IpCL4rNM4N
         Dg4wb7cLNpQ1RoXtxw3Jy84B5I77DPJiLZGzZe/bafVfYgYzcth9XVL9Xd0SX/n6CQGL
         4PR+uqHrcTllvDEvJnumD1+mSOyMkCyyh3Oci8R5OBrliZA49RzOfx249nS99Cyeq5rN
         GDrP6FHYvFgDoQBvMJ6iZ4gXG0MdSnSQIJc2886+NJr+7Ivvx1X90mqi595it9vWKc4+
         MnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3GtFLT5VlHIMmMMlLDEGSWPueKfPOd59FonXvTzyyE=;
        b=79x1hbOS/pBxY6O24RCJ0aO6aQPIybSWGNqc4yCIk2dguReCVswaSeuBKu7SqgftbD
         QFDwOjCvyBT6zX+WrXCzMfHq4ocN4ePZSLK+Nr+AgryRzVVvxEdpqh3TGc4gPVlAUTNT
         vHYnRmNFGEVA6taCFINajjIAWyWWJoPdqwytr8HSkDvtKZybrx0mMgYPT7DdW0CIcU/V
         3pF09cyRX5qOlh5Xu+qHawYTcydrxIDdn1hpqR5Jcs6y94LXTh1rO8AE8Ai3GDKULItk
         1ri+FDjhE+4rj3IVv6Dk+3RDqLcA8EQ6dBL8bDP5sbNoxF+qJoiN/Ed0s+4z5/EYJwn6
         8Ilg==
X-Gm-Message-State: AJIora+yjmGXeolpfwFKdEVfI+1elNApvgdxJmrTTulSICmDiA4+lhzI
        rPTl9yvOPyTW+damAcE0BeNntA==
X-Google-Smtp-Source: AGRyM1uog+T7XWwPK+NaACTq1k/xU9UmzU4HnRc/BXdZwD6n3ZAmkFK6NlgZF1pL5XX4Au8NK3SRUg==
X-Received: by 2002:a05:6870:a70c:b0:10c:3bb7:ea15 with SMTP id g12-20020a056870a70c00b0010c3bb7ea15mr3640528oam.69.1657235774716;
        Thu, 07 Jul 2022 16:16:14 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cg10-20020a056830630a00b006190efaf118sm2177606otb.66.2022.07.07.16.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:16:14 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>,
        Fred Eckert <Frede@cmslaser.com>,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com
Subject: [PATCH v2 0/6] gpio: Implement and utilize register structures for ISA drivers
Date:   Thu,  7 Jul 2022 14:10:02 -0400
Message-Id: <cover.1657216200.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Implement support for the Intel 8255 interface as a new gpio-i8255
   module; common code among gpio-104-dio-48e, gpio-104-idi-48, and
   gpio-gpio-mm are consolidated in the gpio-i8255 module
 - Refactor the gpio-104-dio-48e, gpio-104-idi-48, and gpio-gpio-mm to
   utilize the new gpio-i8255 functions; this greatly simplifies the
   changes for these drivers

The PC104/ISA drivers were updated to use I/O memory accessor calls such
as ioread8()/iowrite8() in a previous patch series [1]. This
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

[1] https://lore.kernel.org/all/cover.1652201921.git.william.gray@linaro.org/

William Breathitt Gray (6):
  gpio: i8255: Introduce the i8255 module
  gpio: 104-dio-48e: Implement and utilize register structures
  gpio: 104-idi-48: Implement and utilize register structures
  gpio: gpio-mm: Implement and utilize register structures
  gpio: 104-idio-16: Implement and utilize register structures
  gpio: ws16c48: Implement and utilize register structures

 MAINTAINERS                     |   6 +
 drivers/gpio/Kconfig            |   6 +
 drivers/gpio/Makefile           |   1 +
 drivers/gpio/gpio-104-dio-48e.c | 224 +++++++++-------------------
 drivers/gpio/gpio-104-idi-48.c  | 123 +++++++---------
 drivers/gpio/gpio-104-idio-16.c |  58 +++++---
 drivers/gpio/gpio-gpio-mm.c     | 177 +++++------------------
 drivers/gpio/gpio-i8255.c       | 249 ++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-ws16c48.c     | 119 ++++++++++-----
 include/linux/gpio/i8255.h      |  34 +++++
 10 files changed, 575 insertions(+), 422 deletions(-)
 create mode 100644 drivers/gpio/gpio-i8255.c
 create mode 100644 include/linux/gpio/i8255.h


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

