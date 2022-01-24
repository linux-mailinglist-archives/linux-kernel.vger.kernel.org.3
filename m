Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E249AB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S254711AbiAYEq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1325891AbiAYDjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:39:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C8C06B59C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:21 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k18so16354657wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZhdR7WzThndblzZsr8d03scH0vKnQACS9be2wdEni8=;
        b=r+JoXgviNYzPT9NLyF1ZN0EZpKKzUsI32D2OUkXsOXnGv/8yfSE8cHQ0ivUW/PVLqr
         rq255ukBTU4Z8NnNoucRXFPDtyjPXsYKcjOmGdmIhki0d738Y+A9H0kcW0KHPmLuQkCG
         H4513rfEGAc94GP2oaPUx7g1OHrbWNclgWU4jQVFe7kpJA3Nz/jps+AFh40Fe6vsRvq4
         k1OFO3+19YSJP2GWDPN+oCtiI4MCstHNsKPdPvgIZgudWvCKJIaNyM9Tl8VD3Xg/OPDA
         G1aBA3MPtgt6W86hwAZAiU/0ToC2ub8pATcVCdhj8EMCltPSUd+u8jiVpCzIcKMBKbva
         U1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZhdR7WzThndblzZsr8d03scH0vKnQACS9be2wdEni8=;
        b=7sSVk3oMNiu4/118gnm2KcnhNZWrtFNOleGCH4p9w7luvPoBF7dcIedIZNnVB2In6p
         YMjeWnkyoqWbME4Mx/4RZFzpblJ9VQ6uzN64kBjJIPRmTCDIpyRG6f4MDHEPXXOODavY
         fpeDz6Kv64HGLj5Zn1YMnf6W3jYH3FO5remNVwx9ZM4Ap/ogYnS92+pXFVtyE/L8i9CR
         DaTSZbKb5GGpTy/gllI+yRgbeYE+CcWNGNNOW5zrOdX0SSb+nbh0MV2KId6kvAaCiWga
         4RFNY1L+SFcPXtrLhH/U3FzNO/2kGoS76wVgZwvpFn6pk/uM8PerwYOsnV13gMhQlqPg
         ihmA==
X-Gm-Message-State: AOAM531sMhCU3U00MOCwFhZU2itNKr1Sa9lAioPUqRl/1I3xgA6FEU7w
        vBnplT4EfOmgPnQij0rknqFQqA==
X-Google-Smtp-Source: ABdhPJxcKyahmF6MlNwDoAkTtr7eAnTxLu5plcMBwLNt4+53GfA0dcQcZWzbUVK+cVwSV+DSx6JFwQ==
X-Received: by 2002:adf:eb88:: with SMTP id t8mr15408011wrn.291.1643064260084;
        Mon, 24 Jan 2022 14:44:20 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id i3sm15010613wru.33.2022.01.24.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:44:19 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 00/10] Cleanup and removal of DBG_88E macro
Date:   Mon, 24 Jan 2022 22:44:05 +0000
Message-Id: <20220124224415.831-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does a few things in order to effect the removal of the
DBG_88E macro:

(1) It removes previously converted calls for consistency.
(2) It removes all current DBG_88E calls.
(3) It removes all aliased DBG_88E calls.
(4) It removes the GlobalDebugLevel flag and the file that defines it.

By its very nature, it is a large patchset, so I've tried to group as
appropriate. I went by file as I did the work, which led to over 40
patches originally, so I've listed the largest C files as their own
patches and then grouped everything else by subdir which gives closer
sizes for the other patches.

Phillip Potter (10):
  staging: r8188eu: remove previously added dev_dbg and netdev_dbg calls
  staging: r8188eu: remove smaller sets of DBG_88E calls from core dir
  staging: r8188eu: remove DBG_88E calls from core/rtw_mlme_ext.c
  staging: r8188eu: remove all DBG_88E calls from hal dir
  staging: r8188eu: remove smaller sets of DBG_88E calls from os_dep dir
  staging: r8188eu: remove DBG_88E calls from os_dep/ioctl_linux.c
  staging: r8188eu: remove DBG_88E call from include/usb_ops.h
  staging: r8188eu: remove all remaining aliased DBG_88E calls
  staging: r8188eu: remove DBG_88E macro definition
  staging: r8188eu: remove GlobalDebugLevel flag

 drivers/staging/r8188eu/Makefile              |   1 -
 drivers/staging/r8188eu/core/rtw_ap.c         | 108 +----
 drivers/staging/r8188eu/core/rtw_br_ext.c     |  59 +--
 drivers/staging/r8188eu/core/rtw_cmd.c        |  12 +-
 drivers/staging/r8188eu/core/rtw_ieee80211.c  |  37 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  15 +-
 drivers/staging/r8188eu/core/rtw_iol.c        |  10 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       |  54 +--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 343 +--------------
 drivers/staging/r8188eu/core/rtw_p2p.c        |  61 +--
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  49 +--
 drivers/staging/r8188eu/core/rtw_recv.c       |  73 +--
 drivers/staging/r8188eu/core/rtw_security.c   |  19 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |   6 -
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 102 +----
 drivers/staging/r8188eu/core/rtw_xmit.c       |  62 +--
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   4 +-
 drivers/staging/r8188eu/hal/hal_intf.c        |   3 -
 drivers/staging/r8188eu/hal/odm_debug.c       |   6 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  43 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  95 +---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |   3 -
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |   5 -
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |   8 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  62 +--
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  31 +-
 drivers/staging/r8188eu/include/rtw_br_ext.h  |   5 -
 drivers/staging/r8188eu/include/rtw_debug.h   |   8 -
 drivers/staging/r8188eu/include/usb_ops.h     |   5 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 416 +-----------------
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   4 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  34 +-
 .../staging/r8188eu/os_dep/osdep_service.c    |   2 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  84 +---
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  18 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |   6 +-
 36 files changed, 166 insertions(+), 1687 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/odm_debug.c

-- 
2.34.1

