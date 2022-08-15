Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6695929A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiHOGhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiHOGg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:36:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66CD140C6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:36:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z19so5661907plb.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fENEN34IT/T7O956m7l86FcgYrM9sywQ94rNqD2QyzE=;
        b=i98NnWxjozZ59t+dRaFmVAlXBybfgyFrZ5UnP4Yr7gkA/2bQ1+uLtDBF6WFexl6RqD
         2V582Wf1NmC7A2NYhywly4bif+z7sse3dbSdr1iTEN0AqrNGb6DRPQtKsaUFi0s96OBt
         0XV6q61uVbarfAPyAdAKtxxYhvTnuQpeIYGIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fENEN34IT/T7O956m7l86FcgYrM9sywQ94rNqD2QyzE=;
        b=zsfgT7b793DqEcdd9lpmCryDXiuYp041t+mclmKrXBdi0o3VSfIYTdcDSlsqvdI5K6
         1t47xMVdKQhqBf+Fk0CSUnEnTlbuxvGAS3cFyE6NCSX8IHL3xPy7s3JboEctrgI8zoEk
         Q5SdlDMxDji28ystY7RxgMlKZR68ddUuTvXCFmh6YtJc9ghBSz73IwVlhpO6NvvG75RA
         pzLHpt5UdFB3NoFwYzVVw6Zh/Wk4iyxBa4CCmQJqdIbZjKuufLZC38irYO/1JQl6CT89
         4wheDmKDAF5OBZXR+bctt4PrWJRX06bg9bUU2uIy1wenopFy/mkKLYYLSLpx1q2r/EkV
         9E5A==
X-Gm-Message-State: ACgBeo3zZSU1OzDQshyi7gbwxoHdrg7yNX77tS3HwRYwWja+KJc/3VzF
        VXrnCtZtCwwgc2FyKzMBPrLTXAEF0JQ2oQ==
X-Google-Smtp-Source: AA6agR7t8Co7+xGl827bxRP0nRPyfmh8nLZeu8WhuAZ10rNRrS8iohPRVc/KY9hpwLfxLeXsxxLVMA==
X-Received: by 2002:a17:902:d551:b0:172:55a6:bd34 with SMTP id z17-20020a170902d55100b0017255a6bd34mr12173075plf.13.1660545416245;
        Sun, 14 Aug 2022 23:36:56 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id 200-20020a6214d1000000b0052db82ad8b2sm5988233pfu.123.2022.08.14.23.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:36:55 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v5 0/7] platform/chrome: Type-C switch driver
Date:   Mon, 15 Aug 2022 06:34:15 +0000
Message-Id: <20220815063555.1384505-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
It also introduces a Chrome EC (Embedded Controller) switch driver which
registers the aforementioned retimer switches as well as mode-switches.

v4: https://lore.kernel.org/linux-usb/20220711072333.2064341-1-pmalani@chromium.org/

Changes in v5:
- Removed first 2 patches for retimer class support, since those were
  merged in 5.20.
- Added missing ACPI Kconfig to Patch 2/7.
- Updated patches 3/7 and 4/7 to use new function name cros_ec_cmd().


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
 drivers/platform/chrome/cros_typec_switch.c   | 332 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |  18 +
 6 files changed, 406 insertions(+), 7 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_typec_switch.c

-- 
2.37.1.595.g718a3a8f04-goog

