Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B4482B57
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiABNL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABNLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:11:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394ADC061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 05:11:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v7so64787366wrv.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 05:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cCv3/4S676AukfYIbru4mtd3r9le2+vzDRrV/TkyaUs=;
        b=pMQNTkNsPdF/It39Ma5CAfiJNDv/u03OfdvRfivEuJc5pYo24+GuVZcl9jhyw4U60z
         NWZTqBlRO01PneusDnOndm8kZQvOv4nlgHgiqLAJBrch+lnhn/MXOPCXkkCv0BBEtK1U
         9RJyAtko/jE6IMeovyzrSXFK1OApIlSuJZpBqaW9OTyxXBQOFPn40gTeAjjQGDQWBUNf
         QkWGyZ1p8SLwLlyXTFjspdJxjWKurUsef1lLum6pQwaxoYwPJOq/bauKFja/Hd5u49Ud
         1/gXrhKMXJz5SrtUfuBMAUT5spPNTGgjM8Xo6zaxW160YFFuyAclUzimIpZdl3yV590N
         fPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cCv3/4S676AukfYIbru4mtd3r9le2+vzDRrV/TkyaUs=;
        b=xG4z161TZ9p+Q5QWoGWa7/M6e9cwsJMGmNb+Gn5TOzmNUsKhXTAzSK0//VO16PeNXR
         ght34Ef5ntTyHKujW6v3G/EpFdxW5NicJ07c4gQFWuTvIYs2CJGHLQxFiNZO9GipchiT
         GIRuY2yvK23AoH+PFoeLkK6KprlG5Fuh3ajoELlgd2hn29PLIBh/9WyDJvvtuzkgHdDq
         dQFUjwHw8RWoEl04at5cyZM4/2Qz5Hor+fF/12SHz07t9oVwpe6o1HMJlH/h/iBPu677
         apQVCdUFuRDUjGBMwaOEuAMMAUqXIz4KuLACKd+7y8iVCvLWAdNe0gEkRCymJBFBNkZZ
         jZwg==
X-Gm-Message-State: AOAM532in0FjZI6MddEXAEdQxVTg/LUvuXDgBDrV7ZpcK5dggVNnbVod
        bzTGZtCg5LF7mVSLzow2LjoOCVN47gg=
X-Google-Smtp-Source: ABdhPJwMDfiuMdz/Z4S26uhP7ra1mIFGpRr58c+Augk5DKQwmrqXHPam3/r0IVHkazPxFP/DznumIw==
X-Received: by 2002:adf:d1ef:: with SMTP id g15mr36632559wrd.198.1641129113844;
        Sun, 02 Jan 2022 05:11:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id m35sm65640044wms.1.2022.01.02.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 05:11:53 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/11] staging: r8188eu: the next set of cleanups
Date:   Sun,  2 Jan 2022 14:11:30 +0100
Message-Id: <20220102131141.12310-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set
 - removes some unused structs, enums and defines
 - removes set but not used fields from some structures

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (11):
  staging: r8188eu: remove MAX_CHANNEL_NUM_2G
  staging: r8188eu: remove struct rt_channel_plan_2g
  staging: r8188eu: remove unused enum and defines
  staging: r8188eu: struct rx_hpc is not used
  staging: r8188eu: clean up struct rtw_dig
  staging: r8188eu: clean up struct sw_ant_switch
  staging: r8188eu: struct odm_sta_info is not used
  staging: r8188eu: enum hw90_block is not used
  staging: r8188eu: remove unneeded comments from Hal8188EPhyCfg.h
  staging: r8188eu: remove unused defines from Hal8188EPhyCfg.h
  staging: r8188eu: remove unused defines from rtw_eeprom.h

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  2 +-
 drivers/staging/r8188eu/hal/odm.c             | 11 ---
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  | 34 +------
 drivers/staging/r8188eu/include/odm.h         | 90 +------------------
 drivers/staging/r8188eu/include/rtw_eeprom.h  | 31 -------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  5 --
 drivers/staging/r8188eu/include/rtw_rf.h      | 24 -----
 7 files changed, 3 insertions(+), 194 deletions(-)

-- 
2.34.1

