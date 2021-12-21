Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC61147C8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbhLUV6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLUV6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:58:44 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD901C061574;
        Tue, 21 Dec 2021 13:58:43 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z5so668148edd.3;
        Tue, 21 Dec 2021 13:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhfHR54p1zqpF7NId8kxEyF9NRPoraDa4HvuJbnAmbk=;
        b=bd6HqV3UMrb9sepofinLvIt3WmGL1zLxlImvORLg3MLxjF4VdIicCOoe5H/r4czjT0
         YWmTS5mwJZVhzpbfnzy6G4OiVXAdz1epYplAv8OMgDhWa0Uc647rrCFCeHTLJ1YhqXzw
         ehCWuxNzAzF1w2mNqmfwp2e8EtTfD1qrG2K02KRLKgmxz5HuE3/ABqxVpoayIMmV4Dqe
         HClwT9OQ+Hm42rODUtzgAeulz59Ej8oTAmL/tVRX/MtNzilGq0/XJt2hiOm+Es+XlOJg
         HrMAytl6vbn85HrMJHsoxPKRL8W15ONi/sanX3gytv0z2fM506ACQw6DwVLxjvODq1He
         9q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhfHR54p1zqpF7NId8kxEyF9NRPoraDa4HvuJbnAmbk=;
        b=w9/PcNpvb6l64aZg5e9pNXOU6JEF6oXLU+JyK51vdPcc7vwnpov/1xzgSAvo0S5D+j
         bLa3HkX83HyX7DF+HKBlb+HsofUFrscnk7Qiya8smOijGidQCWWP4BeVg8enAp5Gbk4/
         LMN1982B3USQnYHsTL4ySgZEsjkUTjh+CSYKyK3xz0mbbiZgxfBw1qZR6WREXu7npMFz
         gWEJriOW1eLAAAQsYkEHic8CDFUGof2sjz7BAGWBa/L9twPCCxV6h57hHb+yuPtKRZXE
         RnHVSGCSO80BBTZTLDWgeZF9ShDl/xL8Z4mR36rHHhMaJ7+mZM4k8P6ZMeDMh7F6v0O0
         mypA==
X-Gm-Message-State: AOAM531Nr7s+6Z75lhlb719r0C6eA7x58YuX4BN/dtTBu0VHyFb1ReXl
        bkwK1stIsOCQaEVnXqk3XIA=
X-Google-Smtp-Source: ABdhPJyeBIXVTijWSWWT3bHWlHikQP2eP6zx9tIYJhbsevUfsN85qkZw4V8E1PP8plVaIhlzCL7RwA==
X-Received: by 2002:a05:6402:184c:: with SMTP id v12mr254883edy.154.1640123922503;
        Tue, 21 Dec 2021 13:58:42 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id nc29sm41640ejc.3.2021.12.21.13.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:58:42 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] Refactor ADT7X10
Date:   Tue, 21 Dec 2021 23:58:34 +0200
Message-Id: <20211221215841.2641417-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1 -> V2:
 * add device managed action for restoring config
 * merge multiple small related patches into a single patch
   that converts the driver to use devm_hwmon_device_register_with_info
 * switch to devm_request_threaded_irq after switching to
   devm_hwmon_device_register_with_info to make sure that it is impossible
   for the interrupt handler to access the freed hwmon device
 * drop core driver remove callback

V2 -> V3:
 * merge patch that passes name from i2c driver into the
   devm_hwmon_device_register_with_info patch

Cosmin Tanislav (7):
  hwmon: (adt7x10) Store bus_dev in private data
  hwmon: (adt7x10) Add device managed action for restoring config
  hwmon: (adt7x10) Use devm_hwmon_device_register_with_info
  hwmon: (adt7x10) Use devm_request_threaded_irq
  hwmon: (adt7x10) Remove empty driver removal callback
  hwmon: (adt7x10) Pass hwinfo dev to irq handler
  hwmon: (adt7x10) Use hwmon_notify_event

 drivers/hwmon/adt7310.c |   7 -
 drivers/hwmon/adt7410.c |   9 +-
 drivers/hwmon/adt7x10.c | 281 ++++++++++++++++++++--------------------
 drivers/hwmon/adt7x10.h |   1 -
 4 files changed, 144 insertions(+), 154 deletions(-)

-- 
2.34.1

