Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B7F56CC29
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 03:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiGJBbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 21:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJBbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 21:31:33 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCA61571B;
        Sat,  9 Jul 2022 18:31:32 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id bs20so3155873qtb.11;
        Sat, 09 Jul 2022 18:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rvs3bBJgUuXh9p9MH2g5C/crPm2FyvtziQSe7NaPEyk=;
        b=cJDoSkmLNZNiC+3wjuERRXc7DLwsLbn9E+zzQVvZCueHDawcku5eNRPVwCd3SazAjd
         SLcjbNGrzIm5+23GJZHHb1nISFXoNCFzumr5kQvS9AtG8BTrc4jdOeq/b8t218Ubh3Ia
         DoY8vJsciUSsliqH1cSpLSiBxfNKeTVHI0FSYGldUk4H3wgksxHuWWsesPFV81k+yxQo
         10+tLMiKf27uv6oMU0QezVydmRut3vs31lqeOkpGbmClLsQiaShw1gSSsi8VkDPq5LZy
         xOtACiRyCo20ChWO9iJt+plsFhp4/idpZ94z0RlgnXjl6eZXHacvuDSm1sDygZ5zkI7Y
         iIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rvs3bBJgUuXh9p9MH2g5C/crPm2FyvtziQSe7NaPEyk=;
        b=GeEJyV3VJGxRKfYVTtEWE/w4PJ0kIDMhR8EtbIaVQt2J7lUXqII8Fnhw+ABFkVGqqA
         sZpNR6pFX8Juc2gvEumztghp1XMFTKE/vg8JXcxfN4BEBSa5mWZHwtz3N7Zy+jORgIzM
         ivEzfJLmOzh62gNahlJoPMBceGlagcUKVWXWLkfl6YRtxVK7v+bURyoFoDUHe2sSsT2v
         AM20AVtZLBNXXtrPYWFHXXtKuMwOUTcWLdLtNye9BdfZwxrESc0d1fGuSXx7urYqqtBd
         0zjP70Zz6RXrQsWqEyZ3QQCgTanvHO6r/92mF76ni/iHLPHL/HrDa0rQ7Uj4rKl7h68R
         CADw==
X-Gm-Message-State: AJIora+c155CDFqc153wEAuohWtFWrQGhuWFW19V05XPk9ZcYvc3T27x
        EqUChb+8o9G3X3TOBzxkydo=
X-Google-Smtp-Source: AGRyM1tUEMK3OJRMx/bm0vWkHhw8jDTI1Gi19oJPZAaQ5/7esvyMvxUnA1hls+UXr1qNHHuqBRcszg==
X-Received: by 2002:a05:622a:1314:b0:31b:4e2:750a with SMTP id v20-20020a05622a131400b0031b04e2750amr9151258qtk.415.1657416691792;
        Sat, 09 Jul 2022 18:31:31 -0700 (PDT)
Received: from shaak.xiphos.ca (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a410d00b006b575a9775csm2137258qko.45.2022.07.09.18.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 18:31:31 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, jic23@kernel.org, geert@linux-m68k.org
Cc:     peda@axentia.se, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] Add module build support for KUnit IIO tests
Date:   Sat,  9 Jul 2022 21:31:04 -0400
Message-Id: <20220710013109.3349104-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
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

KUnit tests can be built as modules allowing to execute them at runtime
by simply loading the modules.

Module build support is added with the following steps:
 - add MODULE_* in the KUnit test drivers,
 - export namespace symbols from the iio-rescale, and
 - drop Kconfig built-in only constraints,

Along with the module build changes, this series also addresses
minor touch ups such as:
 - rename IIO_TEST_FORMAT Kconfig to match naming conventions,
 - use tabs to indent the IIO_FORMAT_KUNIT_TEST Kconfig,
 - drop ARCH=um mention from the IIO_RESCALE_KUNIT_TEST Kconfig help
   section,
 - add IIO_FORMAT_KUNIT_TEST Kconfig help section,
 - update dependency on KUNIT_ALL_TESTS to match the documentation.

All these are done in commit 05/05. I could rework the commit, but given
that these changes are pretty minor, it seemed okay to do it all at
once.

Cheers,
Liam

Liam Beguin (5):
  iio: test: rescale: add MODULE_* information
  iio: test: format: add MODULE_* information
  iio: test: format: follow CONFIG_ naming convention
  iio: afe: rescale: export symbols used during testing
  iio: test: rework Kconfig to support modules

 drivers/iio/afe/iio-rescale.c       |  2 ++
 drivers/iio/test/Kconfig            | 26 ++++++++++++++++++--------
 drivers/iio/test/Makefile           |  2 +-
 drivers/iio/test/iio-test-format.c  |  4 ++++
 drivers/iio/test/iio-test-rescale.c |  5 +++++
 5 files changed, 30 insertions(+), 9 deletions(-)


base-commit: b1c428b6c3684ee8ddf4137d68b3e8d51d2a700f
-- 
2.35.1.4.g5d01301f2b86

