Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E400D4DBBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347539AbiCQA7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbiCQA7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:59:33 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCEC12779
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:58:17 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t187so1443554pgb.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fEiIQq/+MOx3ePleZyRnWSsBiCDIwdwlXulJMg5j/dU=;
        b=ZVsb4IAerwlksFkFTiTBppTgLDXwo3YbWwf6u3r/vAIo88oQ2UCDC1FgVVqqHUIZnZ
         L/zbUUB38+uJ4VrxZNlGL6qlO777DWxW3bVI/stdj64lOb/d6hAOvPSYtAOaaJF93ZvC
         SevGZCWI9eBHOrHZcmAV75OSRk4YzDESwsOPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fEiIQq/+MOx3ePleZyRnWSsBiCDIwdwlXulJMg5j/dU=;
        b=IfdL14lYglvPR1b4LmEmMTA8VU8hgf9Ds2tAPbT7VFdLdEkAyNNTpfGwPXsJfWAk5d
         qWXz301pVjlihibI0zn5KxlGUP/hN44M2y1JiPuPwaRY0MiejCs1gMTA0TwoS4u1f74m
         zYwdFgRuLOWP4dbzGJEdM+cbI4mCOkA7L2cP57dsviXYe69U88xVgjBIfYczsJ3cCh0+
         OWJCvZX4wI70v5yVlAhnn7KKLkPPiqQbEQfHne34ue6kAn+Bf4rHDJRdlDMbcIbMETJc
         SnS3QHv8TFHCXBF96vfvLl+Rchd2WP/okRX8hdh5HxbASxHP7n15dXn7kuC7igOwo/ir
         1WJg==
X-Gm-Message-State: AOAM533nRweug1FXdAiVGGvx3KR5iEQ/HQ6TC4/wIvjbZo+zPTg9YTK3
        zBzy/WzVGRCRJ7RrGNgt2drq5w==
X-Google-Smtp-Source: ABdhPJz9glq6TQM7GOOPVAx81AqOWt/UlQ9XNEvnwyjw33SzLieR6JBTwjoQR821DFRC/3bxvWAEPA==
X-Received: by 2002:a63:d306:0:b0:34e:4330:efea with SMTP id b6-20020a63d306000000b0034e4330efeamr1720091pgg.174.1647478697208;
        Wed, 16 Mar 2022 17:58:17 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:dec5:e3f8:cbd7:f5a7])
        by smtp.gmail.com with ESMTPSA id l20-20020a056a00141400b004f65cedfb09sm4433445pfu.48.2022.03.16.17.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 17:58:16 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v2 0/3] Update cros-ec-spi for fingerprint devices
Date:   Wed, 16 Mar 2022 17:58:11 -0700
Message-Id: <20220317005814.2496302-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces a DT binding for chromeos fingerprint
devices and then implements support to boot those processors during
driver probe if the BIOS hasn't done it already.

Changes from v1 (https://lore.kernel.org/r/20220314232214.4183078-1-swboyd@chromium.org):
 * Properly do the boot sequence
 * Add a message that we're booting and delaying a while
 * Fix typo in commit text
 * Change binding to not spell out reset-gpios and indicate that boot0
   is about asserting boot mode
 * Split device id to different patch as it's a different topic from
   booting

Stephen Boyd (3):
  dt-bindings: chrome: Add ChromeOS fingerprint binding
  platform/chrome: cros_ec_spi: Match cros-ec-fp compatible
  platform/chrome: cros_ec_spi: Boot fingerprint processor during probe

 .../bindings/chrome/google,cros-ec-fp.yaml    | 85 +++++++++++++++++++
 drivers/platform/chrome/cros_ec_spi.c         | 44 +++++++++-
 2 files changed, 126 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml

Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Craig Hesling <hesling@chromium.org>
Cc: Tom Hughes <tomhughes@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>

base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
-- 
https://chromeos.dev

