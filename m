Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA956AE4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiGGWU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbiGGWUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:20:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A5606B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:20:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so149849pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lQsjAc0YQIb9NGXs3HwZPWuZRhoPR+NwcjVw3jJIBFQ=;
        b=XbKmDZy/WMqhyN9B6r1DiEk/QAbsScJ+CPdadwH6TXX4GDj1u7aiAI7fl26RJaYYGQ
         FV81cwccRYv5EVCLSxS0nmWI5PSdob23rpAO9QjAZG+FRRv7VHpQUaS4dPfx7Hb4IS1O
         tUG6Ya1zI60mw6iAXPx15Eus8qh9MgnPMjvTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lQsjAc0YQIb9NGXs3HwZPWuZRhoPR+NwcjVw3jJIBFQ=;
        b=ZdAgZD2MGfGZprmMMp75/JWolqt4FCLpIr+bWRVcF/oPeM4Mv/QTLODY/opBenGx0R
         gGj3bCI5FUKWGH7FzUaIXdEhuofLy/vJ70AgHZ+TOm8MDAv+t0mFiDDgV8wRYqOkGJyy
         ZV03OSSpv5xzE30Edu/FbRUWw+Eo+/lDkRuWOQJ6lp/B1PRuHFP80sbvpWVLHPtLzqHU
         yIh6iblxaqyhVE2BnucMH2CD1zn71MRk+CxOlChfO6DiswFWF4MYJQ29xT9Hcs+sNBQd
         /vV4iltQX5V4ZyQNXcV11GVCx64rQGobQpwLE9J5VdTOygK9T/8zA0iHHKu3t3INauPS
         CXjQ==
X-Gm-Message-State: AJIora8natq4kq3iTl+LNG+7xUO82Fr2Xyhi+bHZgGwGiioMLMQHITe+
        GWZzV5Ibq/Jl79W2tN945TLVfk+cajoWXg==
X-Google-Smtp-Source: AGRyM1sjFfRCrP/YQPVZOHPRuRcIuvCoR1wzUjn4/i2bvcYMaksJCxhurBqN4qfLnF4xhiqZEw68pA==
X-Received: by 2002:a17:90b:4f48:b0:1ef:8ed0:df4d with SMTP id pj8-20020a17090b4f4800b001ef8ed0df4dmr7617959pjb.224.1657232452829;
        Thu, 07 Jul 2022 15:20:52 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 66-20020a620445000000b005289bfcee91sm5545657pfe.59.2022.07.07.15.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:20:52 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v3 0/9] Type-C switch driver and Type-C framework updates
Date:   Thu,  7 Jul 2022 22:20:07 +0000
Message-Id: <20220707222045.1415417-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a retimer class to the USB Type-C framework,
It also introduces a Chrome EC (Embedded Controller) switch driver which
registers the aforementioned retimer switches as well as mode-switches.

Patch 1 and 2 introduce the retimer class and associated functions to
the Type-C common code.

Patches 3-7 add the cros-typec-switch driver.

Patches 8-9 update cros-ec-typec to get and use retimer switch handles.

Submission suggestion (as always, open to better suggestions):
- Patch 1 and 2 can go through the USB repo.
- Patch 3-9 can go through the chrome-platform repo. Since they depend
  on patches 1 and 2, we can create an "topic branch" off of usb-next
  once Patch 1 and 2 are submitted, and then apply Patches 3-9 on top
  of that "topic branch" before merging it back into chrome-platform's
  for-next branch

v2: https://lore.kernel.org/linux-usb/20220706171601.807042-1-pmalani@chromium.org/

Changes since v2:
- Fixed missing "static" declarations, and removed newlines from
  function signatures.

Changes since v1:
- Changed class name and retimer device type name, and fixed
  retimer reference release issue.

Prashant Malani (9):
  usb: typec: Add support for retimers
  usb: typec: Add retimer handle to port
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
 drivers/usb/typec/Makefile                    |   2 +-
 drivers/usb/typec/class.c                     |  18 +-
 drivers/usb/typec/class.h                     |   2 +
 drivers/usb/typec/retimer.c                   | 168 +++++++++
 drivers/usb/typec/retimer.h                   |  15 +
 .../linux/platform_data/cros_ec_commands.h    |  18 +
 include/linux/usb/typec_retimer.h             |  45 +++
 12 files changed, 654 insertions(+), 9 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_typec_switch.c
 create mode 100644 drivers/usb/typec/retimer.c
 create mode 100644 drivers/usb/typec/retimer.h
 create mode 100644 include/linux/usb/typec_retimer.h

-- 
2.37.0.rc0.161.g10f37bed90-goog

