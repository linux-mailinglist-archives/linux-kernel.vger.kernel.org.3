Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228DA4FA76E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbiDIMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiDIMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:08:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694360C8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 05:06:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n6so21966139ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 05:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4E8eHD2LjgOkxXkJxCrrou4dw9MQCmrHPwVfgpBx/zE=;
        b=U4qMUS2qylwk458bucVJvxFMvhPJTq4piE1OmAH5yMV1h1f0YQF63Hw7O4kpzwKItR
         92x3Cf6xIh1cm3S/AR/DaFOivECLGHYqJoMdFt8lb8rli377kUzhDl+7wxQV0TMFqXSB
         vr3u+HljDE3wH3DEK4XhIzWKSJG6IzsGz/WHf7OAhmuPSnl/HgrfxBCEPpQm5BrOY16w
         EUX4pfQjuhBAZhC9tCqeqW+bz/h8YNNi/OyYsKIytaQrPTnLQi4o5ej9swuVb9qAFkb7
         OIS6VRJbp0+G7vES7nLAwuiB4xCgF+pYEr+kAyN+kJPXBfJ65ayZIifB81zmORm19n2i
         dyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4E8eHD2LjgOkxXkJxCrrou4dw9MQCmrHPwVfgpBx/zE=;
        b=1/jGAQJLKXiFwr5VuYNQlbSzZ+JjuVmSO76c1WoNMvNp1AcfI5m60F5OhJ64qWKWjd
         WnsIYxjfxVN3AiTpOjk2shzbLUGGJ7GQCJkzdaaBvxw99J6bp5DfxamsdPklukqSs1wS
         J/pRot2pmjN1G1QKLxxHe74LTCb8WzFXo6LK3Jwn6uN31NkP6XlzqZJVscUb05V3PDf+
         Ml3z1fv4Q2zzZ/8N2p9Y9n+uJ3Wq/KHwBsdBoUdeCkQhAfR5xzIEqIylKyM/Tt59Iz4Y
         LdkEnzOQGTOUU34G7xOjQaL0Zx3KakvkeRlgOOMDxs5j+kdVXgEK1AMBBXjU8NvkzS1Q
         HJAw==
X-Gm-Message-State: AOAM533YZojsorGDQRj8vBrtScywDItZCI/pIVS2pfqRHnFtaAP9Ap4S
        NJRc6W3uIdepYRM7St5Jbyo=
X-Google-Smtp-Source: ABdhPJzeUygIiKJjYEcp1x+lnl0P6edcX3nvDH7/1QrfX8bOFA7QoBM120Eqlj81NkTrl0GII8p3zw==
X-Received: by 2002:a17:907:3e17:b0:6e7:10de:80d5 with SMTP id hp23-20020a1709073e1700b006e710de80d5mr22586173ejc.404.1649505999799;
        Sat, 09 Apr 2022 05:06:39 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm1102947ejm.189.2022.04.09.05.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 05:06:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: SetHwReg8188EU() cleanups
Date:   Sat,  9 Apr 2022 14:06:23 +0200
Message-Id: <20220409120627.10633-1-straube.linux@gmail.com>
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

The next round of SetHwReg8188EU() cleanups. This series removes
four cases from that unwanted function.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (4):
  staging: r8188eu: remove HW_VAR_INITIAL_GAIN
  staging: r8188eu: remove HW_VAR_MLME_JOIN
  staging: r8188eu: remove HW_VAR_FIFO_CLEARN_UP
  staging: r8188eu: remove HW_VAR_H2C_FW_PWRMODE

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 91 ++++++++++++++-----
 drivers/staging/r8188eu/core/rtw_p2p.c        |  4 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 19 +++-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 80 ----------------
 drivers/staging/r8188eu/include/hal_intf.h    |  4 -
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  1 +
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 29 +++++-
 7 files changed, 113 insertions(+), 115 deletions(-)

-- 
2.35.1

