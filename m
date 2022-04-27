Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2C511B51
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiD0Odd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbiD0OdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:33:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502AD18382;
        Wed, 27 Apr 2022 07:30:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q23so2790986wra.1;
        Wed, 27 Apr 2022 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61rDep7IpGIu+stwVlsWVOdIyeXLNS0Q3CFSi62k+PQ=;
        b=Gqm0fuYX6bqhl3AfoFdRL3YHFxuycncTyBYKJw/QKrYgYtRJfsavkppYLx8GJrvV6L
         PfF5Csf2Y1zQj32WrbEEkHQr3YCPExFZOGT4nT1mT1wUxymFRBbKW+G4mta2iC1k6tNF
         zcb0AcSVO+gel538s2wnZLl3dP8q8cPJz3ucLgY7HdNDRhmQVhz/kO/yP1a0Y1j4kOwn
         oyfqB9y5NFG0nQ0jtS8CDdQ3HUFi9BT5kncfN7OUsCTtHP3pGKitjwKEV9zEcek9dItm
         0PPHhlREA8M/0erHORtrRoRaSh1TMVBj2cYlnCLOGUzi/m+qBNY+sxZSwepCKwzNMz0H
         GSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61rDep7IpGIu+stwVlsWVOdIyeXLNS0Q3CFSi62k+PQ=;
        b=kLAwumsTUgPINA6koKeFEoOh5ox1M9bINepsp86iLCy6NuaI7ueOYeULj8rPwINKtD
         DbRRpdS25/Zuw7jBxdHfEkdUarsirzxKMTwu/JUAK/FzDpiJmh+UKqrN64fbDNNm6Hzx
         XuKkMYAOF9E1aCrT5n79mdmJDssQJO6i9ho0MJjsWXFtgIjECHJi9p7pywN6NsTfzQ5I
         2OhMMctlbuX5H4u4DP7vs4GR2P6WXWLSrSjYYi/BP4xpqLckwamwNw20IfjaBhpxcJ1X
         Q17pc4V9H0xv9h/5U8MpB2zTUPsLYE06W3TE7XWhfPxvcbd4sL2shno5LCQug6blFGBx
         qhdg==
X-Gm-Message-State: AOAM530OElqhN2fD90tTHyabe53zeI9ftv0IXS0pqXHo7he50AI3LbIf
        D2wYKF5+/P9W6z5ojAOIsE2UdSV0uI71AQ==
X-Google-Smtp-Source: ABdhPJwYpz3+6ERX85kOLgh1eEx5JgKJ9leQ9kpwklUYA9jx06Zg+A3FPgO3QmClaqVeBWoLsH4j+Q==
X-Received: by 2002:adf:ea4a:0:b0:20a:ddfe:5b34 with SMTP id j10-20020adfea4a000000b0020addfe5b34mr11071704wrn.394.1651069810604;
        Wed, 27 Apr 2022 07:30:10 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f393100d379c1e4199524ea.dip0.t-ipconnect.de. [2003:cf:9f39:3100:d379:c1e4:1995:24ea])
        by smtp.googlemail.com with ESMTPSA id i14-20020a1c540e000000b00393dc91e9c9sm1721625wmb.17.2022.04.27.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:30:10 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] asus-ec-sensors: add support for board families
Date:   Wed, 27 Apr 2022 16:29:57 +0200
Message-Id: <20220427143001.1443605-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users provided information for boards from AMD-400 and sTRX40 families
and demonstrated that sensor addresses differ from those for the AMD-500
family. Also the AMD-400 family board uses the global ACPI lock instead
of a dedicated mutex to guard access to the hardware.

This patchset implements required changes to support other board
families:
 - per-family sensor definitions
 - options to choose hardware/state guard mutex: an AML mutex or the
   global ACPI lock.

These changes are used to add support for the PRIME X470-PRO board.


Changes in 
v3:
 - Added family_unknown member to the board_family enum to ensure the
	 default value of 0 is not a valid family value.
 - Added a note explaining why module_platform_driver_probe() is chosen
	 over module_platform_driver().

v2:
 - Removed the case without ACPI mutex where the state was guarded using
         the normal mutex. After receiving an update from user that case
         turned out to be non-existent.
 - Removed the __initconst attribute from the board data array.
 - Updated documentation to include the special string for the mutex
         path module parameters which make the driver use the global ACPI
         lock.

Eugene Shalygin (4):
  hwmon: (asus-ec-sensors) introduce ec_board_info struct for board data
  hwmon: (asus-ec-sensors) implement locking via the ACPI global lock
  hwmon: (asus-ec-sensors) add support for board families
  hwmon: (asus-ec-sensors) add PRIME X470-PRO board

 Documentation/hwmon/asus_ec_sensors.rst |   2 +
 drivers/hwmon/asus-ec-sensors.c         | 420 +++++++++++++++++-------
 2 files changed, 302 insertions(+), 120 deletions(-)

-- 
2.35.1

