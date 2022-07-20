Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3357B19C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiGTHUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiGTHU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:20:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E4C5A46E;
        Wed, 20 Jul 2022 00:20:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so684737wmb.5;
        Wed, 20 Jul 2022 00:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q9b/iC1wjOnRSd8FlI4IMa2e7V3PAbT/u3twpIk4R8I=;
        b=M9+pMCM5G0yo/uxrB/EZ+dsXsdFh3yOyMpjFg6Xu/o8spFbs1tMk7BzoyAiuybHOqP
         2J7DPHXtCj/IiZFPPCE/JSUd36oebgawpEnoleo7hl1qzbCuGVzT05ZSJnCt/7vBfv1/
         tH0z7Cpk19dL+Sq/PRsbl4UMFh6evHAmb0YgdrQU/WG7GoBqnOV4wS5k5rKLnZfRTczK
         ru8f+RSvJhZFBIpVjKacI4Uqcbh/MhHOUT0/vyNYTJqfKguGJNDi59KY5xJgcyVb+IAE
         dCAoUi09crOekfrGhKuKgVu2D3qd+bGgRjyAGpItKviWCwh2/BN+Fyr4zqGciGC0hpik
         mRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q9b/iC1wjOnRSd8FlI4IMa2e7V3PAbT/u3twpIk4R8I=;
        b=mLf9KOnjc8rXAHFgT+LWUr5mW+HyeCEjUTDPfOFxSoFfVvvhSylw3+RstL/AMxSJna
         UX8e3Q5AU3HPgtQkZ/rS9ZnqNu3yEWkbHVCU0x4brYcLGv9KhRyXpFtgL0O44W99oSi7
         9/haLsRHpKDmm1aFyZ85hK+akG0aaGUormFUWrcLkjUq4xsItxyIFVy3Mf4eJwivoLwm
         CX+TFcyZt/xVgKw7Dyw3vq1fT2hQ90cwI+duyV37I9hqBQ6OVEMtcF48yQWEYCy+W8xl
         quH9lvu9fAFOAqLr3mDs152+71bop+IQMtwQBcJmrv9NePc7kUgV5svd1zR3GXasCPcK
         /ddA==
X-Gm-Message-State: AJIora+G1AXNAumkfYTbz/AZkFfcv1Ocx6IDbiCyiuYgn1aB+EearDpS
        +Xl2tSHd+6M/Y3tru/G4v8Y=
X-Google-Smtp-Source: AGRyM1vwAtUKKLML5RWsnJMrsfwK6oLn20E/Eacehn+h8zwlfyM/ve7BFlWGIJXnznEo6GW1SAUc9g==
X-Received: by 2002:a05:600c:4e8d:b0:3a1:2e4d:1dd2 with SMTP id f13-20020a05600c4e8d00b003a12e4d1dd2mr2553332wmq.85.1658301625724;
        Wed, 20 Jul 2022 00:20:25 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f4d210014d9122df422c4ba.dip0.t-ipconnect.de. [2003:cf:9f4d:2100:14d9:122d:f422:c4ba])
        by smtp.googlemail.com with ESMTPSA id u16-20020a05600c00d000b003a31c4f6f74sm1452192wmm.32.2022.07.20.00.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 00:20:25 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] Remove the deprecated asus_wmi_ec_sensors driver
Date:   Wed, 20 Jul 2022 09:20:15 +0200
Message-Id: <20220720072016.102086-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2: improve commit message.

Eugene Shalygin (1):
  hwmon: (asus_wmi_ec_sensors) remove driver

 Documentation/hwmon/asus_wmi_ec_sensors.rst |  38 --
 Documentation/hwmon/index.rst               |   1 -
 MAINTAINERS                                 |   7 -
 drivers/hwmon/Kconfig                       |  15 -
 drivers/hwmon/Makefile                      |   1 -
 drivers/hwmon/asus_wmi_ec_sensors.c         | 622 --------------------
 6 files changed, 684 deletions(-)
 delete mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 delete mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c

-- 
2.35.1

