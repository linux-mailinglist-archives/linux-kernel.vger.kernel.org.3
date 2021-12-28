Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC548083C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhL1KLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhL1KLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:11:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D52C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso9699687wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lu4/fHAfh41aETiOWVku5MFHqWQLQk6Fq5oSTsjrPzw=;
        b=PSCPMwpvMkPUP3bOXCV70UftvKStO8rHjRG3ouV0rLXVBAz+y3VfCZaVv+0jdkhO7I
         nEJLcJhkSCePccyIzvp8xwo2o7NgIdDiH2/ZShgX0xZwYcXQynIMjh+LPuZHtUJ6xwUo
         dW0swwdvKszGh6ykNxkIO4BTfxErv9Sh1aNaUzEUt5uLefZTAGVglqpyR/xHq8cPEVID
         01qFYqkZHd2aPorsU9pbPZOyHiR74Vi6XXFH9Ui50gUC2Q8ogRRzmED6ZFeCEHEGWDv2
         l/mOYqqLvE4mA9/d2CvmSS94suGk4mbhqjJ9Xaq9opvY7Jh3jfN3lereZ2FF4ciUsMYu
         iQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lu4/fHAfh41aETiOWVku5MFHqWQLQk6Fq5oSTsjrPzw=;
        b=Wzknof/rbHzu1EZBtYPXIz3mkQ5A7GI4To+QSAw9gwV+FC+gUH0TXDU2i9V1uB4fvy
         qIeuWjGupSfZTbxuH30xiQ2G8r/ldGV4UclGT1S9I8Eda3WJ08d31+Cjuyh6sM0P+3Nw
         INt5usyNowVDZAQrA027E9dvwZGZNVEcUaW8Ru/0yj7tKIwKbT14PVa4AXeRCozWc7aj
         dmSGClWCJcpcs/eJdwHZOqM+FPky2pRS0+o+VizhXPTrmzpqv/WkC51InVGNoJAaf/oH
         YxlFGGGuRIzaXdzCdo3uPfcasYKUr6f1XxhnlHTAr7Q6NVrRVKPoUWUGmVl6+W3QAU1U
         umsA==
X-Gm-Message-State: AOAM531J0WO371GvbV6BDLcqZDh3jtQcljkv7DxneJeiiNOZs3SSEY2Y
        G5UTz22uLi1pa7Zn58L7oeeqpDkuo7Q=
X-Google-Smtp-Source: ABdhPJxOadgYueHDEYGP8U8DNVklkbgPfi495a2cA88dHFw4ejnCV1gUTiBhd1UImtPLRAuP5lLPvw==
X-Received: by 2002:a05:600c:35cf:: with SMTP id r15mr16579717wmq.106.1640686303125;
        Tue, 28 Dec 2021 02:11:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id d62sm21160984wmd.3.2021.12.28.02.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:11:42 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/10] staging: r8188eu: another set of cleanups
Date:   Tue, 28 Dec 2021 11:11:10 +0100
Message-Id: <20211228101120.9120-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set contains some cleanups in different areas of the driver.
Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (10):
  staging: r8188eu: DM_PriCCA is set but never used
  staging: r8188eu: remove GET_CVID_ROM_VERSION
  staging: r8188eu: remove unused enum odm_h2c_cmd
  staging: r8188eu: remove ODM_CMNINFO_ABILITY from ODM_CmnInfoInit()
  staging: r8188eu: remove write-only fields from struct rtl_ps
  staging: r8188eu: FAT_State is always FAT_NORMAL_STATE
  staging: r8188eu: FAT_State is set but never used
  staging: r8188eu: TrainIdx is set but never used
  staging: r8188eu: RSSI_test is always false
  staging: r8188eu: merge _ReadLEDSetting() into ReadAdapterInfo8188EU()

 drivers/staging/r8188eu/hal/odm.c             |  7 -----
 drivers/staging/r8188eu/hal/odm_HWConfig.c    | 16 ++--------
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    | 19 ------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |  9 ++----
 drivers/staging/r8188eu/include/HalVerDef.h   |  1 -
 drivers/staging/r8188eu/include/odm.h         | 29 -------------------
 .../staging/r8188eu/include/odm_RTL8188E.h    |  2 --
 .../staging/r8188eu/include/odm_interface.h   |  7 -----
 8 files changed, 5 insertions(+), 85 deletions(-)

-- 
2.34.1

