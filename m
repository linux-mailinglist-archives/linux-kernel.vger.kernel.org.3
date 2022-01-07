Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46B4875A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiAGKgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiAGKga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:30 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06C1C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j21so20393265edt.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66unC0o6NAYb1N3MoU5TQCeMb7FNDSFj5FiR3BmbU7E=;
        b=pEECgb0W4WEd8MXiCFFBi+LN8ajtK1xT65HeLPUzyxaYAXLMndztDGpJ88JA2vWQXB
         FwNKYMbB3L+nkkKPOudieSd0OvuFUx5BlZkmQd9Dqe/qTsQIBweATxm0254YffHG8PHy
         94GALaK+yO75TbPUiDxoFrcmcOblHZM0UssphI8D5a+wXD26mEcKB+Sj9slg9THoR8lN
         oqpSiNTH+CKp6yaCjAAZ8QtdJLsl/xVgWdYj5KPIndhe2uYiyxA3VRGdUJacSrp4B5J5
         vlv03lhyabMmgofead7NajmcYkY2VM+4DMPcOWGpMdEP+ASf9GOdYJNGAoY8F43sntAB
         vBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66unC0o6NAYb1N3MoU5TQCeMb7FNDSFj5FiR3BmbU7E=;
        b=0EfRW9VMNUHzNGl2R2gVwtm6MGdpb5U7SMxRAXLARhAlqkBhnSWe26foECSiXXzGne
         36467noj5OYLOqHfLAsLdpzrFoUdkVVv8aP+wzAzdZra8E1tiMmPsTQYqhch88/uoWZN
         1NFGgPrvzOx1WQn4F/JQMNekpdt9VWle+2YI34sDfMZsm0WGyGrwm5gnwWYsi+TqqOBN
         e8NWmgjSrnz6QZntbgZPp1M9VnZSw9QR+/Bpxrg7X6mTBwZU8TdUuT4Nt7xXdVpr+U2p
         Uq/eK1GSr9WOVdh4bKsadwJvFt9so7c3XCoOGDeulYjbnQB6DaYDky2xwaxCy1HpILu9
         1uxw==
X-Gm-Message-State: AOAM530q/3K2JdxV6lkAEcuL62sEXp8AWLYo7YDDGOcaJkhT2ZYaI9vE
        vE9/7RClFRa89OCqGviLpuA=
X-Google-Smtp-Source: ABdhPJxf7aBlPfvtyy5mxAyF8PAN/gPrs04OA1NVicRJd0xG7eDBW629T6SvFnY70waxhNHgsYcbRA==
X-Received: by 2002:a17:907:a088:: with SMTP id hu8mr50451030ejc.56.1641551788383;
        Fri, 07 Jan 2022 02:36:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:28 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/19] staging: r8188eu: move firmware loading out of the hal layer
Date:   Fri,  7 Jan 2022 11:36:01 +0100
Message-Id: <20220107103620.15648-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series starts to clean up firmware related code and moves
the firmware loading out of rtl8188e_hal_init.c into the new file
core/rtw_fw.c.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (19):
  staging: r8188eu: remove Firmware* from struct hal_data_8188e
  staging: r8188eu: remove rtl8188e_InitializeFirmwareVars()
  staging: r8188eu: release_firmware is not called if allocation fails
  staging: r8188eu: rename Exit label in load_firmware()
  staging: r8188eu: rename rtStatus in load_firmware()
  staging: r8188eu: convert type of return variable in load_firmware()
  staging: r8188eu: rename parameter pFirmware of load_firmware()
  staging: r8188eu: rename fields of struct rt_firmware
  staging: r8188eu: use kmemdup instead of kzalloc and memcpy
  staging: r8188eu: rename fw related functions to avoid camel case
  staging: r8188eu: clean up rtw_reset_8051()
  staging: r8188eu: convert two functions from s32 to int
  staging: r8188eu: rename Exit label in rtl8188e_firmware_download()
  staging: r8188eu: rename rtSatus in rtl8188e_firmware_download()
  staging: r8188eu: rename FWDL_ChkSum_rpt
  staging: r8188eu: rename writeFW_retry
  staging: r8188eu: rename pFwHdr in rtl8188e_firmware_download()
  staging: r8188eu: rename pFirmwareBuf and FirmwareLen
  staging: r8188eu: move firmware loading code out of the hal layer

 drivers/staging/r8188eu/Makefile              |   1 +
 drivers/staging/r8188eu/core/rtw_fw.c         | 284 ++++++++++++++++
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 303 +-----------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |   8 +-
 drivers/staging/r8188eu/include/drv_types.h   |   4 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |  10 -
 .../staging/r8188eu/include/rtl8188e_spec.h   |   2 +-
 drivers/staging/r8188eu/include/rtw_fw.h      |  14 +
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   4 +-
 9 files changed, 311 insertions(+), 319 deletions(-)
 create mode 100644 drivers/staging/r8188eu/core/rtw_fw.c
 create mode 100644 drivers/staging/r8188eu/include/rtw_fw.h

-- 
2.34.1

