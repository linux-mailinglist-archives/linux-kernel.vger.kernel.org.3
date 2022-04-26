Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0686D50F96D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348130AbiDZKDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348284AbiDZKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:03:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AEB18E2D;
        Tue, 26 Apr 2022 02:23:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x18so24594878wrc.0;
        Tue, 26 Apr 2022 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iH1aRwQoSNWyvyr28CgUroKcq9jDojB0qtrBHnljUAQ=;
        b=IIC3Vu3EZnVI44KLx9yUyQYbDEMUqtbn+CX80FmWuE8OQVVHtpVl2vrXNTeu+N9cCT
         kq+8TSM0+dZ54Sli1vzjy+CxsiJP4ykTs+2HtrBcACB2FdMl7hQdZP1ASjtLtmycE9wG
         5xl9I9/GoD9Uk8XMkTi4GZVNeeobuygTgguXLFITEhQM1pEKDGo7oDnxMNp1wS8rQLJ2
         76wFocyeEXP3cKgDpqMgZTAE5Xa3UAXOlAxaqFUFmJXY629ZHEej4nQDTrvo6DmdhEhl
         U7jAzzmJ3goOXepDJfoYJl66jH+bEyBXBXv5+rSGI4lomybOQtJNuEs3V9I2ZzdDDt7x
         0Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iH1aRwQoSNWyvyr28CgUroKcq9jDojB0qtrBHnljUAQ=;
        b=f5xS7C7hnSJGLqgW9eGS+88ohXRjx7Ny9/GEOOzCKKoc1V1GStsbEomuMRyBWg+rfS
         Y3gkT4716GcojmFZ2kNdkcvU2NN7Uel/HExkysXdFKyN7L33y9Iw0Yz14qFeKUb0xBK/
         rvfHHahkOrto0C/+UAoWDnP6qRh3IRZST/rvbWRBwMOszEVmsgAM/Cy2OzpyNiMcDzcO
         A4ndu3eWyJHHuDxVD08bqTOLFQmMGjAwj+Ons7S0/ELLlG2/pFbqChetGTm+30gaAX1k
         8ymrcPPg9cELXgMqtoXi8k4K6M6JA7qnnr0CEAfwaRzjz2fzUkVUhNjIk70kTM4+XVLl
         KMGw==
X-Gm-Message-State: AOAM5304sVmQ4wf1GrZ2ZSNf+9f+wFQbKzKldn1MVaVE81373uwKaQLe
        cMG+v3T6yJLOAdsK3nbu/CE=
X-Google-Smtp-Source: ABdhPJxz1AoymwM7zIaDq09xsU6GJWzGE0DQq4dUUFI2oa56FB+kVFxV8tTo1tLZ6lq7mFtAKeserg==
X-Received: by 2002:a5d:6d04:0:b0:20a:be1d:20f5 with SMTP id e4-20020a5d6d04000000b0020abe1d20f5mr17794613wrq.153.1650965033925;
        Tue, 26 Apr 2022 02:23:53 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f393100d379c1e4199524ea.dip0.t-ipconnect.de. [2003:cf:9f39:3100:d379:c1e4:1995:24ea])
        by smtp.googlemail.com with ESMTPSA id 9-20020a056000154900b0020a849e1c41sm13125094wry.13.2022.04.26.02.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 02:23:53 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] asus-ec-sensors: add support for board families
Date:   Tue, 26 Apr 2022 11:23:36 +0200
Message-Id: <20220426092340.495704-1-eugene.shalygin@gmail.com>
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

Changes in v2:
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
 drivers/hwmon/asus-ec-sensors.c         | 412 +++++++++++++++++-------
 2 files changed, 294 insertions(+), 120 deletions(-)

-- 
2.35.1

