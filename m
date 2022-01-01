Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B86482719
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiAAItx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiAAItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:49:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0196DC061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:49:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a9so59612144wrr.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oc4vHIztuApNOLOp3YEk7PmhXqir0UKoefFYx9DVldY=;
        b=aezyM6ppLiaomO/tHGsfgwGLHO/RUl+UFE7NWmOcjDt1qhRnn77H2nOLj4s+bkVXHE
         9k3pgcY2Re9qJH2DM0uLylFVKyFhT1BqYVBoXfyCuMhs97mLTyjLyOw6YozKzAUjedt8
         GUkevTOZ1KpZEKvkveNghuMW15kMra7RXyqIU0raPfr+rsT7+uFOFWdReRNDvwwXefKY
         sr/RG3V30hQ+DFh76nnI8rdM8FQ8B1albaARNU6a989kfvBdwhZ+LxbEYRqoFalD18xV
         AixBvjzW0amQ7KlvE1CVo3AqIEyypXv0Gy5R1YD/Gg8+CcphrHoNXuWPerjzS6O/5ofm
         0mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oc4vHIztuApNOLOp3YEk7PmhXqir0UKoefFYx9DVldY=;
        b=jEh4KinmW73XGsjzxA5445mxqflA8aWxhnNdsqrTaoIWfe6qn4WcSpaIhcaHRhNgo1
         VmCW1ITRpqBw1Oyi+yzPvJ9IrUyU9fOplTh6OgwUZwJ57JgRnNDvFKTG7IYp3wz0fXxF
         2GoGsCzKGzp94ju8It4+1grtrrAK+60kN5dZtXDamYeq0d06RZC7MEOLLm7AQ3V0UTSS
         BrcnwndHUyk9AQWQGUk8w5+bGMlgUEeGoTOc3v9xAsi3MeUqTnlaOfzxdt5NeZIoe+Q5
         JQ7QPa4x+NeLA3zeRPjGite5mU4Epm3ACBtFBwyDVdcDspMuVaQP8GQdh4J8LOKpaQty
         tAyQ==
X-Gm-Message-State: AOAM531JqED2CuabnUsoRbq93P/WLOs3tu+igQ2l52HkculSmh0zJTvJ
        NebvujPyC6M1QqTE6MlM3vM=
X-Google-Smtp-Source: ABdhPJy7kwNOt2BxTMLYLRflTbLwdF7BcFIRxttt6Rc/XktfO5A63LPCX5iAlReoH/i+U2QeEbUxGA==
X-Received: by 2002:adf:df09:: with SMTP id y9mr31376047wrl.594.1641026989128;
        Sat, 01 Jan 2022 00:49:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::d7e8])
        by smtp.gmail.com with ESMTPSA id o9sm14806578wri.97.2022.01.01.00.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:49:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 0/7] staging: r8188eu: clean up struct hal_data_8188e
Date:   Sat,  1 Jan 2022 09:49:30 +0100
Message-Id: <20220101084937.3411-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unused and set but never used fields from the
hal_data_8188e structure.

Tested on x86_64 with Inter-Tech DMG-02.

v3:
- Remove INTERRUPT_MSG_FORMAT_LEN from rtl8188e_recv.h.

v2:
- Remove interrupt_handler_8188eu() since it does nothing now.
- Fixed typo in cover letter. hal_data_r8188e -> hal_data_8188e

Michael Straube (7):
  staging: r8188eu: bRDGEnable is always false
  staging: r8188eu: UsbRxHighSpeedMode is set but never used
  staging: r8188eu: bTXPowerDataReadFromEEPORM is set but never used
  staging: r8188eu: bAPKThermalMeterIgnore is set but never used
  staging: r8188eu: remove unused fields from struct hal_data_8188e
  staging: r8188eu: IntArray and C2hArray are set but never used
  staging: r8188eu: FwRsvdPageStartOffset is set but never used

 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  3 --
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  8 +---
 drivers/staging/r8188eu/hal/usb_halinit.c     | 15 -------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 20 ---------
 .../staging/r8188eu/include/rtl8188e_hal.h    | 43 -------------------
 .../staging/r8188eu/include/rtl8188e_recv.h   |  1 -
 .../staging/r8188eu/include/rtl8188e_spec.h   |  7 ---
 7 files changed, 2 insertions(+), 95 deletions(-)

-- 
2.34.1

