Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8CB4F0017
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbiDBJZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbiDBJZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:25:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093B944A2F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:23:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so10446239ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLZblWMyil7t1ZX+pjvViUNPmDK+vScCeSU9xeanNc8=;
        b=ZlAMIWQvcNRF5oB5p2KFoxXtjroRWGI4xfve/37L+F063goIFXsakhExgGCPFK31Yt
         qP9zH75Js9XsyQeNbA5y6XoL5SqQWl+JAY5v5sydUbB0dcRMyNXZs18oQu9+xI8t0FzN
         sp2+gEbdh+xV0S/LZvDyXBACx/czBUm0Zvc+S4x9qK1/6ZF5V4ZrXzesGOBsbatXH64D
         lpWBYBhU6bhs5pI46OKLXSi0CWVm1Jn6nCgreAVYcsyafsIzWe8YgT1XMDAeVXiPxyso
         k7dJNnoVacpnJVUl2bcLZWR/fAiGjNfCnC5VERXGROrZh5Sr3Vta7lN1f1uhaMB2YIm2
         TDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLZblWMyil7t1ZX+pjvViUNPmDK+vScCeSU9xeanNc8=;
        b=tFURy5Alq77EEJzOMHBErAwMNi1lCT7OcCTGO7IW0isPG9HEJJkhp7OsOuqHxMwjls
         tBTDO/ed6/KztiJeh4Rbcdn+qaPMxmMYBB9w++GsRBBsDHsA466mdwCC1viNJH9gl09Q
         gCTcLNj2hC6On4x8/9fPR+t0BCVaUVVtzxjAdRNGuI89JelLV6ZHjzkaQrBEoUeHvsci
         bSww5ysPrxKSSvxf7E0sQKbkALnewLkozMY7AcZyu3RgQPHXxiaRggZHoKR0/VxcUmYl
         1oug5HhoAbFBNIq2AsgvZVPrGDXP+FJGJyGQ74qb65Pg/W8ieJDiDMB1Cn6nXtRx+lUe
         lMYg==
X-Gm-Message-State: AOAM532fONUSkSaiRBBDcOHmABHtY4kY6H6hH3ZWUuCDE99ggvUoYn3Z
        uk3YF0PDrRP7GfdPZTVjvLk=
X-Google-Smtp-Source: ABdhPJxC9qWY1b48PBnzxoAvVl4Xsv1SZLdQua9JI16v9sVSthsndtg/A+FV1gmZoihbvGwX5yyR7w==
X-Received: by 2002:a17:907:1606:b0:6df:f528:4033 with SMTP id hb6-20020a170907160600b006dff5284033mr3101153ejc.433.1648891417628;
        Sat, 02 Apr 2022 02:23:37 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id jv19-20020a170907769300b006e095c047d6sm1897679ejc.109.2022.04.02.02.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 02:23:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/7] staging: r8188eu: more SetHwReg8188EU() cleanups
Date:   Sat,  2 Apr 2022 11:23:25 +0200
Message-Id: <20220402092332.6627-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the next round of cleanups for the SetHwReg8188EU() function.
The goal is to remove the function completely someday since it is
just an unwanted layer of abstraction.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (7):
  staging: r8188eu: remove HW_VAR_BSSID from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_ACK_PREAMBLE from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_AMPDU_MIN_SPACE from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_ANTENNA_DIVERSITY_SELECT from
    SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_RPT_TIMER_SETTING from
    SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_H2C_FW_JOINBSSRPT from
    SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_H2C_FW_P2P_PS_OFFLOAD from
    SetHwReg8188EU()

 drivers/staging/r8188eu/core/rtw_cmd.c       | 17 +++-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 18 +++--
 drivers/staging/r8188eu/core/rtw_p2p.c       |  6 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 51 ++++++++++--
 drivers/staging/r8188eu/hal/usb_halinit.c    | 85 --------------------
 drivers/staging/r8188eu/include/hal_intf.h   |  7 --
 6 files changed, 74 insertions(+), 110 deletions(-)

-- 
2.35.1

