Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E3586F2E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiHAREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiHARE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:04:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55185205D0;
        Mon,  1 Aug 2022 10:04:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q22so2870003plr.9;
        Mon, 01 Aug 2022 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=xOX9chVYPROOGAwdmaGgZcPW07GxLyOUqTmIVsiyRrY=;
        b=APqGvEY9aCng9joJBKu4D5mC2tl8a1Y345jPp7UNZbhXrBCzYzipvvUw6DJuz/DyMh
         xUwH38OxWdYI5ubyyM9eYy7A9keEqSdj6kjsrM1r0EO0opDIPanW7or/+pN6ouFdYpeE
         cUg5u+pTWdd7+6lgxaDAeWdasptlCzw/MG+OdazqsPSBJcITD1rGEZ43khcN5DYRdNBc
         mpBZbCLB+Ci36ZBqqwamfhQpbdvIK6X4S77rJX2aagCc76p1sMjOPa+Ms5vR1p1VKdCg
         THWheImhu7rAq+i/2t1MpySjeVhjTTaw0oHSWovn0rE/Yrxe8EwMIJ8mfKpklG2R6+t3
         2BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=xOX9chVYPROOGAwdmaGgZcPW07GxLyOUqTmIVsiyRrY=;
        b=pmgxu7CrZlFOdYI6do3lNpzz162PRKIMCxJAD4JLVK8/CbaIKCYz/oCZzwCLhiRT+1
         EaImf6adsG87NBgPmT17Naf/sBo7WNRqP5B3MjynUdidif0gJNGnJ/anMzeD8hDhTZY+
         4yEIiW7D7CjYpKtacj96l4y3G+WE717myrGuZR8mjRGIYAXg1fGQ3LYbtJoZ1avVZbZ8
         694EvJ/hHaIdg3KrxtM6ePa3LZFgGUXDgaRJefKM1mz1kwt37RqRQMjuTha+/j5bUi2y
         l0khlkElZfICm2HdbRheTZXx89h5NwQ/nfe3zoOq+MKG9NCRzchLBKhntlnjNE1NDcJu
         Tb0g==
X-Gm-Message-State: ACgBeo0aprPkgnv3M5Ls2Bi7js4OC8uxbDVWLCfTQvIZAh1ENJqzj/PY
        oycUo+rGx/9VEkjJ8VChM7U=
X-Google-Smtp-Source: AA6agR4Wp1sdG2ePJHPzujo2lxC4pM4up8FzRO7eHzEQfmz1DeZIq9jjtKnY1WFOjVr4/m8ni0CLdw==
X-Received: by 2002:a17:902:da91:b0:16d:3bc2:ff49 with SMTP id j17-20020a170902da9100b0016d3bc2ff49mr17520540plx.85.1659373466548;
        Mon, 01 Aug 2022 10:04:26 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a1f4300b001f2e50bd789sm11953200pjy.31.2022.08.01.10.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:04:24 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        Sean Paul <sean@poorly.run>
Subject: [PATCH v2 0/3] dma-buf: map-info support
Date:   Mon,  1 Aug 2022 10:04:54 -0700
Message-Id: <20220801170459.1593706-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
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

From: Rob Clark <robdclark@chromium.org>

See 1/3 for motivation.

Rob Clark (3):
  dma-buf: Add ioctl to query mmap info
  drm/prime: Wire up mmap_info support
  drm/msm/prime: Add mmap_info support

 drivers/dma-buf/dma-buf.c           | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/drm_prime.c         | 12 ++++++++++++
 drivers/gpu/drm/msm/msm_drv.c       |  1 +
 drivers/gpu/drm/msm/msm_drv.h       |  1 +
 drivers/gpu/drm/msm/msm_gem_prime.c | 11 +++++++++++
 include/drm/drm_drv.h               |  7 +++++++
 include/linux/dma-buf.h             |  7 +++++++
 include/uapi/linux/dma-buf.h        | 28 ++++++++++++++++++++++++++++
 8 files changed, 93 insertions(+)

-- 
2.36.1

