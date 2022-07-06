Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9B56906F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiGFRQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiGFRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:16:15 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54792A70D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:16:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id i190so1905068pge.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pWXRp5NIoHyhpRcNJ8PbAa5aXIlOP8l12Bd4AXe9kl8=;
        b=aqRws9t920RS++2cRfQdhRuZqu/9tP3h3Gm9Q372N5Mb9rqUvb1V6aNHOQHnvsdpF+
         +rian41fTpmSnWlLJ+kEBQ238DR/gvKkfVdawPUA8zI2YmZRaQPI8IvCp9WnU3RP1u/s
         IBKR0p0BOh8GiiXuW+hHREqlCSwiRtqxTAEc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pWXRp5NIoHyhpRcNJ8PbAa5aXIlOP8l12Bd4AXe9kl8=;
        b=klCt20/wmJt7iNA8LWyEvyvabjbaD+mhf76UNDoJrfiTpU13I5+1bpgOe96hEGemCV
         1tIiwOCk1cIMjNLkdQlQZQYcJ+xOXmyKEpOrSyOhlYd11rPZ+GdyGp+IXNn+vqVhZp1B
         WGfsgJPPGvMwX82xAWlNSRU3PMmAPHFYRfiDoJGeki74djq/UrkKN9pIaP42A7nAnPeC
         HV/wT0ZVyuFNWR/msU9XPURvZAleV4zJCaD9x1NEPBrJOI46wdqLDJzdSKJNRFZBs/75
         K9Hw1nAmenhrvMnKhpjl2Pcs67TrXOKcxSuekR4yBvdnT78JQjIQlGozqMNHvbecEfW5
         x5zQ==
X-Gm-Message-State: AJIora/Fu/oya+yMh+HolcHOsuFnpe184o4hk3Yk39rY+xwX7DQPqtpP
        Vg3LM8/RL81rJuLmSh6fpABEtjpXTLkT6Q==
X-Google-Smtp-Source: AGRyM1tG3SsP+RFG7E3/NDUcbQK96rM/ehX0lO+/jKnmPnExRWXzRxoUIUmY/e4pLxxS4Ckpls1B3g==
X-Received: by 2002:a63:914a:0:b0:40c:f778:9bf with SMTP id l71-20020a63914a000000b0040cf77809bfmr34337527pge.526.1657127773124;
        Wed, 06 Jul 2022 10:16:13 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902f7ce00b0016be0d5483asm7514953plw.252.2022.07.06.10.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:16:12 -0700 (PDT)
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
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v2 0/9] platform/chrome: Type-C switch driver and Type-C framework updates
Date:   Wed,  6 Jul 2022 17:15:04 +0000
Message-Id: <20220706171601.807042-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Patches 3-7 add the cros-typec-switch driver

Patches 8-9 update cros-ec-typec to get and use retimer switch handles

Submission suggestion (as always, open to better suggestions):
- Patch 1 and 2 can go through the USB repo.
- Patch 3-9 can go through the chrome-platform repo. Since they depend
  on patches 1 and 2, we can create an "topic branch" off of usb-next
  once Patch 1 and 2 are submitted, and then apply Patches 3-9 on top
  of that "topic branch" before merging it back into chrome-platform's
  for-next branch


v1: https://lore.kernel.org/linux-usb/20220629233314.3540377-1-pmalani@chromium.org/

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

