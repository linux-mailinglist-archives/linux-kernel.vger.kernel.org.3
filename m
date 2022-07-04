Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D3564C15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 05:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiGDDl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 23:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDDlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 23:41:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D462622;
        Sun,  3 Jul 2022 20:41:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s21so3528778pjq.4;
        Sun, 03 Jul 2022 20:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zot34Su/UJzEfLvtI5KsgZ2ZXPjjcCX/oHVe3Y9OwDI=;
        b=OkJu/yPaalIGdh19Of+/u7IZp0HIpjRq6mnNPx8dhdusfJQUWDFvF0tsoPAOIaU7FM
         GFVubWcyLEYM0obEBJdxX6Y6JiK/03yJ+tjRpY56b6j8IRgjgw+DLRdcc3y5pYDESjKG
         Ik7zRWjAIlhnNnzgW5mtX9zTEQ3UqduvU0L0rOWvXkX0Ke6UQGTY2v18ePtuEVSMnoU9
         1aTve/ZNS+dUink4jIDuvlBwk3dJ9UTshJ3HHXSsbPG8MFTxhNcRkN2zUlsd8+aSnuHk
         Zdx18MYpGle7kzeEVdQgtqmi5J+EwCjB5olz8/Ekb7Ew/jfMnPsuiVWJVsdhM7GNSdCb
         VH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zot34Su/UJzEfLvtI5KsgZ2ZXPjjcCX/oHVe3Y9OwDI=;
        b=q3fd8Tic+dlseWM1UzSPt2uiZaqqmPjIMlpgdEJFvINJl8cTjzeZKf7REXioVGOdg3
         NIHEPLHUh+8BOGgDc23LzbO9o3NMmmbQYNfUJ3UtgpoVUBsx3AYtjEuXqEkqyBhRN8gQ
         xGymceD14TnjyUxwt/LATvzrEDWnYslRsrB4X0ZasjZ1ICLmtdRhNrnUmY4Xiee5ZbVE
         Aawsv6dxg9VxN0n8cVOA8z50aKvLtSvM2Cpgo/b7KNX7TXkAopa8PQ614cUjntJP8Jwl
         ml/f8+pcB+x7jay1kGSGbsEHiR8CqNyzDsoXLxv+mwodFu/Kg/cHQQL+yeAf6DxUIbyK
         /nyw==
X-Gm-Message-State: AJIora/IFCMSSzzOrRVtS++Q/gNrzWEx1zXDskjXbmEMqdFWg4uRpQbB
        2BI+K3d4QuwlVu7HWcDsIQc=
X-Google-Smtp-Source: AGRyM1v9KHlohz3vcXGrrclX/fkxSnHkerFknyMVKuMgLZHh/yvDSFUgs9ItYXukQcHaScmoDn/T7w==
X-Received: by 2002:a17:902:d50b:b0:16a:2cb3:74f7 with SMTP id b11-20020a170902d50b00b0016a2cb374f7mr33830730plg.6.1656906083923;
        Sun, 03 Jul 2022 20:41:23 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-10.three.co.id. [180.214.232.10])
        by smtp.gmail.com with ESMTPSA id v187-20020a6261c4000000b005255f5d8f9fsm19981190pfb.112.2022.07.03.20.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 20:41:23 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BE085103946; Mon,  4 Jul 2022 10:41:18 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>, jacopo@jmondi.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: bno055: separate SPDX identifier and page title
Date:   Mon,  4 Jul 2022 10:40:42 +0700
Message-Id: <20220704034041.15448-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <YsGVa8KFmdvGY92e@debian.me>
References: <YsGVa8KFmdvGY92e@debian.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported htmldocs warning:

Documentation/iio/bno055.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.

The warning above is caused by missing blank line separator between SPDX
identifier and page title.

Add the blank line to fix the warning.

Link: https://lore.kernel.org/lkml/202207031509.DlBrHyaw-lkp@intel.com/
Fixes: ec0c70cb45507d ("docs: iio: add documentation for BNO055 driver")
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrea Merello <andrea.merello@iit.it>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
Cc: jacopo@jmondi.org
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 Changes since v1 [1]:
   - Collect Reviewed-by from Andy Shevchenko
   - Explain why the warning is triggered
   - No code changes 

 This patch is based on "Add support for Bosch BNO055 IMU" series [2]
 as fixup for BNO055 documentation (patch [14/14])

 [1]: https://lore.kernel.org/lkml/YsGVa8KFmdvGY92e@debian.me/
 [2]: https://lore.kernel.org/lkml/20220613120534.36991-1-andrea.merello@iit.it/ 
 Documentation/iio/bno055.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/iio/bno055.rst b/Documentation/iio/bno055.rst
index af21376d7a2533..9a489a79d8f5a8 100644
--- a/Documentation/iio/bno055.rst
+++ b/Documentation/iio/bno055.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+
 ==============================
 BNO055 driver
 ==============================
-- 
An old man doll... just what I always wanted! - Clara

