Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19948AB75
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349092AbiAKKeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbiAKKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:34:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC731C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:33:58 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s1so32083762wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlvnTPe3lASdFY+T2t68uKlxKrbSmUU8V1J05NQSw6U=;
        b=kFZHjxBqak04QecvDE2NLpVra0DHWksVsM+UYYxryGtHYHXrRSQWq1/xX9A+ZsO93M
         rhwTwSrvVZrQkeHIRa1TxI4azHBBS0Zk6HLOjRdFBHyJHXYIMKAwOCchTXp35Qd2V8qd
         /cZJXXl9E0B7ZMWaCVf19hdhB/drQhSEuY9rEEvWE/0HNNhg+4lJTlV+Zg4PoRCxVR1F
         gt0qdlAskSDXGLVhdbk5nwi2G/xccxm/5fH6oLS+tZv8cMQeI6H+wTzrZ1pchceJj6Jk
         x0croQongRyfddXEMEK0VaxWIeQQqMSMvF9X2hIlxWqCN0BunojhMGYG/77YcYElVabB
         laOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlvnTPe3lASdFY+T2t68uKlxKrbSmUU8V1J05NQSw6U=;
        b=0e/BZk0vZGEIJ65YIWaJHr2QLh70K1n9y70ZTGH6wxJDBg6HbMrJEQ6R/MW32m74Mc
         G0ZfIRHM/Kr1K80i1eCFcaSY/YilM7U21eQW2iN+we00Z/5GVYOIJ36+eqvoq1qIcrQg
         x9KlLxPkGpKskI50Bvq0vgWy9W0yAeCanTCJnSNlIZ1WscOvuSb96uE9BnzLk8YXjw2l
         H+gdKllbYyJJhyuaybcujtZPQKI2u0rw7gL4f+Ow0b3KTPbvWhGLv424pjWH1dFebxKO
         7cCN9CgJwy/EuJ6zTpp6nWG/djFO6E8X1lF8vaik595GBBsqC4C2ZmXDY1q2SDorrUE4
         e28Q==
X-Gm-Message-State: AOAM533xTD5GxWyDdKF+69EwbBC0C2KIrJ3J0EOEozNRCq8R2F33rDBH
        ASODko0hrzz4pptuadM3Qb07Bw==
X-Google-Smtp-Source: ABdhPJwTazpdHrgr+MgipqzrdPRu4Vt8uCoZ/sH/0PYCwESlfQYlVUTG3LeTI2N/8eVmiKSo9w/aEQ==
X-Received: by 2002:a5d:588f:: with SMTP id n15mr3282791wrf.279.1641897237487;
        Tue, 11 Jan 2022 02:33:57 -0800 (PST)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u16sm8803470wrn.24.2022.01.11.02.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 02:33:57 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v4 RESEND 0/2] Add a generic virtual thermal sensor
Date:   Tue, 11 Jan 2022 11:33:44 +0100
Message-Id: <20220111103346.2660639-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add a virtual thermal sensor.
It could be used to get a temperature using some thermal sensors.
Currently, the supported operations are max, min and avg.
The virtual sensor could be easily extended to support others operations.

Changes in v2:
- Fix some warnings / errors reported by kernel test robot
- rename some struct and functions with a more accurate name
- update the dt bindings: rename type attribute to aggregation-function
- factorize a little bit the aggregation functions
Changes in v3:
- Aggregate thermal zone instead of thermal sensors
- Use try_get_module / put_module to prevent thermal providers to be removed
- Update the bindings, to be more accurate
Changes in v4:
- Fix two warnings reported by kernel test robot

Alexandre Bailon (2):
  dt-bindings: Add DT bindings for the DT-based virtual sensor driver
  thermal: add a virtual sensor to aggregate temperatures

Alexandre Bailon (2):
  dt-bindings: Add DT bindings for the DT-based virtual sensor driver
  thermal: add a virtual sensor to aggregate temperatures

 .../thermal/virtual,thermal-sensor.yaml       |  86 +++++++
 drivers/thermal/Kconfig                       |   8 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/virtual_thermal_sensor.c      | 218 ++++++++++++++++++
 include/dt-bindings/thermal/virtual-sensor.h  |  15 ++
 5 files changed, 328 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
 create mode 100644 drivers/thermal/virtual_thermal_sensor.c
 create mode 100644 include/dt-bindings/thermal/virtual-sensor.h

-- 
2.25.1

