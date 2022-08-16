Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129C75964E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbiHPVtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiHPVtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:49:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52413E89
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:49:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so121902pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=G5Rnb6R8LxrH04YqlaaVs3BAEfiQZLlmAn5liFR/QWA=;
        b=I/IJRn+koVhgGmLgv0+RCQtbGiYLzzyOKPB7K2UgOM1X5/GwPfuMEJDfiHpVNAzIUS
         ykcuQrcS2DUhLhR4Jsa33ZkItMFbpRlzSSZFBM+UuuFyDsAY1EPgTx/qv09muzAgbNri
         haJSMhPDL1lP+INBfkZTf3t/QBmtpwJsWJJN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=G5Rnb6R8LxrH04YqlaaVs3BAEfiQZLlmAn5liFR/QWA=;
        b=qQr7C47vwld5EH/xoGaYXGq8a3xnb5+GNOHiAB55dbBBq12V6Ai6T4wNBFb5yLSQhK
         lckFc/t7mdwZIu08kw92uSkEkW0g4+/zsPvYR7RaXJznmiXC/tBLe5cADeHg+rhIYbIf
         DO0x9M7A0CEQtCGvgW1m65ywkcM/ahxIHL7Ox4suZyufZU5rLApVG5eXZ8pr1/5JxLfL
         BbRfDc5UBIIWSxCnjLGCBpJQZVIe1k+4VVuzlJoluepSrDKThrw4mCbwDu0UaySYcGSS
         IhzdjLXDL/wgKDiP6depduNZjjCIdA86kZUv+2EuRsLifE3cVtT+2G9053zEOvnu0C45
         yPJQ==
X-Gm-Message-State: ACgBeo11ZhmnF5KtlBmRd3YXZCc8xYJmNvzhhGlGCPnHhj0isA3Dt2xP
        qiRHa0xIKfc2LSbvHLmCesWW0WRFZ/IWeQ==
X-Google-Smtp-Source: AA6agR5pEws2IIXWnpsQhLgSr3fcNjIB9/QGDFB71vQ4i3WuDxmMpibaAxbriYPENctF/SPnw3d7rA==
X-Received: by 2002:a17:90b:3b8a:b0:1f5:1df2:1fff with SMTP id pc10-20020a17090b3b8a00b001f51df21fffmr570148pjb.169.1660686547767;
        Tue, 16 Aug 2022 14:49:07 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id z5-20020a623305000000b005323a1a9fecsm8916650pfz.101.2022.08.16.14.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:49:07 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v6 0/7] platform/chrome: Type-C switch driver
Date:   Tue, 16 Aug 2022 21:48:28 +0000
Message-Id: <20220816214857.2088914-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 of this series was originally merged to the USB maintainer tree, but
there were dependencies from the chrome-platform tree which caused
conflicts in the merge tree, so the chrome specific parts were
reverted [1].

v5 is a resubmission of the series with the Chrome-only parts (since the
USB framework parts were merged successfully).

[1] https://lore.kernel.org/lkml/YtadE201j+dt5jJx@kroah.com/

Original cover letter (with parts relating to USB patches removed):

This series introduces a retimer class to the USB Type-C framework,
It also introduces a ChromeOS EC (Embedded Controller) switch driver which
registers the aforementioned retimer switches as well as mode-switches.

v5: https://lore.kernel.org/chrome-platform/20220815063555.1384505-1-pmalani@chromium.org/

Changes in v6:
- Changed "Chrome OS" to "ChromeOS" and "Type C" to "Type-C" in various
  commit messages and comments.
- Added Reviewed-by tags received in v5.
- Fit some cros_ec_cmd() calls into 1 line (Patch 3/7 and patch 4/7).
- Inlined struct initialization (Patch 3/7).
- Use device_property_present (Patch 5/7).
- Misc. other minor cleanup.

Prashant Malani (7):
  platform/chrome: Add Type-C mux set command definitions
  platform/chrome: cros_typec_switch: Add switch driver
  platform/chrome: cros_typec_switch: Set EC retimer
  platform/chrome: cros_typec_switch: Add event check
  platform/chrome: cros_typec_switch: Register mode switches
  platform/chrome: cros_ec_typec: Cleanup switch handle return paths
  platform/chrome: cros_ec_typec: Get retimer handle

 MAINTAINERS                                   |   1 +
 drivers/platform/chrome/Kconfig               |  11 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_typec.c       |  50 ++-
 drivers/platform/chrome/cros_typec_switch.c   | 327 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |  18 +
 6 files changed, 401 insertions(+), 7 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_typec_switch.c

-- 
2.37.1.595.g718a3a8f04-goog

