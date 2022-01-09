Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F05488CB3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiAIVyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiAIVyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:54:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1018C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 13:54:31 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o3so23226255wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 13:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p59DSvWE9IMx8qmJZqkeAExPWC4n0KTZsniTKDZX1oc=;
        b=kLufeGGzoXH7blj6kIRfzTwYoOWF4rzNY/xapzgzTUSCKXqtgv+B+4hwwSRGZ5fM5I
         HV4bnpP5WRjZDFbx9xNeZz6x0srLVA91F9azQj8yJTj/vR5jEVBCLS0iVPqKEwCd/4xh
         6CD9BsEsvI5VLGNhXkB8g2tLa4NfU991XtVfBcQ/i84W9xsf7zCr4HzuiapJzrJ9nmXF
         X/FVAdj7atm1b7xrFT0Xvu3jFYgsGM6wJEeMO2o4JS0mdWJHUHDxTqpN/PeikmlUCCFz
         F97ay8OpfbLBPKGAjH/Qdl0U1/3Tsn5AnXNv9rvTBOm6sBwZWu6smEvDVpB2+LpXpH89
         CmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p59DSvWE9IMx8qmJZqkeAExPWC4n0KTZsniTKDZX1oc=;
        b=pGYKvpmoxFjPt9SKsUR0XOQ2h0hyeUC7PN7XD5nb4Vf9rvZQkkDzwLVWbZajgGxT1v
         R0ad5jEUylx+q8Sg7/MVt6mxDHC/DvfHYJ2eKvqyY/tebjLeThXa5Oxlpwt+5jzm1zR+
         iRP3KABHATr6hF5yUSAZMGPoqZSo5BHveq6P+I+aUcq137z1ASqf2y3FybugjkvTZnfG
         0p4UUUwk5JRoRkcpP+wlqVZwJByoKEucLOlXkuX89YWAnJ/QDGpONOyUkHmLFWniOfEg
         eiNpi9iwSw4rJL7DR4C2VRXa2jgsiaQTpvqgJioxqr6XNTkHK0PXD3U8NxzDV1T2zCSD
         GwEA==
X-Gm-Message-State: AOAM533xLJvwiPHHF6G6iuRmpKTs/Qire1qm8RufXUAn04NGVRQBOPAc
        Df7IxvZFPL8GjI8zIcL7uO6Eyw==
X-Google-Smtp-Source: ABdhPJy0Q+lQQBSx72VEsVvHyWYq9bvuUcUPot9tx4YSqIjvTvvSzmQpx2HDXDT7x0kKHTGsuluJpA==
X-Received: by 2002:a5d:610c:: with SMTP id v12mr62061841wrt.410.1641765269719;
        Sun, 09 Jan 2022 13:54:29 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r13sm5065650wmq.28.2022.01.09.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 13:54:29 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: r8188eu: further per-file DBG_88E cleanups
Date:   Sun,  9 Jan 2022 21:54:20 +0000
Message-Id: <20220109215427.887-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has more conversions/deletions of DBG_88E macro calls,
per-file, as I've continued to chip away at them. This converts almost
200 calls to standard kernel macros/functions such as netdev_dbg and
pr_debug as appropriate. It also deletes several calls which simply
aren't necessary.

Phillip Potter (7):
  staging: r8188eu: convert DBG_88E calls in core/rtw_ieee80211.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_xmit.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_iol.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_mlme.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_ioctl_set.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_mlme_ext.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_sta_mgt.c

 drivers/staging/r8188eu/core/rtw_ieee80211.c |  36 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c |  10 +-
 drivers/staging/r8188eu/core/rtw_iol.c       |  10 +-
 drivers/staging/r8188eu/core/rtw_mlme.c      |  95 +++--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 427 +++++++++++--------
 drivers/staging/r8188eu/core/rtw_sta_mgt.c   |   4 +-
 drivers/staging/r8188eu/core/rtw_xmit.c      |  30 +-
 7 files changed, 344 insertions(+), 268 deletions(-)

-- 
2.33.1

