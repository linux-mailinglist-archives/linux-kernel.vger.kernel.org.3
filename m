Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF1D4B7C47
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbiBPBHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:07:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245216AbiBPBHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40947C6836
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i14so806998wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GD2FBr9sLiB21MTGrO6tpv3HwKNj+k41VDZUgwtrGh4=;
        b=8NIxspoAniK58zOgnJ3OKrMBGnbjT2a70mb1lLGyFnNqjkwORcyz2Zf3KyXyDRQtY8
         YEIIvdLY5xMwRhLJm7rz1VvLWODxY3f64QCt/wvsqnEAiIVf1Tt5GuMMzKR6xsDohUJ7
         Jr/MdaqSMXpX9iMxqUNPfr8VdLV5Nem3n8gSP6p99H3o2hWonGlYEceUaw4THzOIJDU2
         iW7B+JZ5HVvDvlvXBeG3Hbyj2GwLkbeyHwQkg0o6yL3RarChtLH5Yvl3ds4PFVuQQds5
         u//xyXszdOTwRt5tersPDqIWSiVjKuGts483uc8TZ4S97T2Jmx1YMt4K2+ewyn+W6Rg9
         oovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GD2FBr9sLiB21MTGrO6tpv3HwKNj+k41VDZUgwtrGh4=;
        b=NVUaPSoQbiEVMK+uokm0v28kOv4+jiyWbEMVwoVHGV3mkj/szU8qfGHFNNBPI4D9wy
         G4R9WPqqAf0EP8yK2azpnV+xXVJ5olk7W4vjtlxih2siKtDgt1cZ0Qvg6QxhyqsTuLgW
         egEV+5N2OIhXDDye1hasppjf3teuwe7mTYnDhrru/ioF7yTQwzkSzrHzUswdQwWdcm3v
         Z9lgDk9FJBT3mtCq8lPjp1+LhjPAlvrBnjUL5Pfh0/BP8bbkkw4pZFfL/9bFcrtsRuru
         z0IKOrxEf7dKgtJvUTqmbAiQ5uhxGYRZT/Q0aI2rQ7DXkIOlYYXJ3xDxD2wtfEXK1DfE
         jHWA==
X-Gm-Message-State: AOAM532UBllUnM/h7UfcgBCI4IBOV+XCtsOt/PnJXZbHR1ie1vnsLhdh
        hv+xbaoYt7rWWQnm0WsFNFmh/A==
X-Google-Smtp-Source: ABdhPJypcRIi9seVIEB+jw3hlwkkJVgNFBYDCTXX/n4OScK1p7bNiGHHALdTM8TQ2PLKZW1vHW6DXQ==
X-Received: by 2002:adf:ec90:0:b0:1e4:ae98:3635 with SMTP id z16-20020adfec90000000b001e4ae983635mr376148wrn.95.1644973630747;
        Tue, 15 Feb 2022 17:07:10 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:10 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 00/15] staging: r8188eu: Cleanup and removal of DBG_88E macro
Date:   Wed, 16 Feb 2022 01:06:54 +0000
Message-Id: <20220216010709.791-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is the second version of my cleanup series for the
debugging macros in the driver. Its approach is as follows:

(1) Remove previously converted DBG_88E_LEVEL calls.
(2) Remove previously converted DBG_88E calls.
(3) Remove all remaining DBG_88E calls.
(4) Remove all aliased DBG_88E calls.
(5) Remove the DBG_88E macro itself, and get rid of the rtw_debug module
    parameter.
(6) Fix up remaining issues and remove certain things.

The series is a from scratch re-do, as I considered this easier than
rebasing the previous set. It is rebased onto latest staging-testing tip
as of date (15th February 2022) at the time of writing, so should
hopefully apply with no issues. I've also built/tested the driver
post-modifications and corrected unused or set-but-unsed errors as I
go.

Whilst the patches are new, I've still used the v2 subject prefix to
reflect the fact that the series is related to the previous one. I've
tried to incorporate as much feedback as possible, so apologies if
something is missing. It should be in a much better state though.

In particular, in the earlier deletion patches, where necessary to
keep semantic structure, I replace deleted lines with a single semicolon
statement in if-else cases. This is then cleaned up in later patches, to
allow the review to be easier.

Phillip Potter (15):
  staging: r8188eu: remove previously converted DBG_88E_LEVEL calls
  staging: r8188eu: remove smaller sets of converted DBG_88E calls
  staging: r8188eu: remove converted DBG_88E calls from
    core/rtw_mlme_ext.c
  staging: r8188eu: remove DBG_88E calls from core subdir
  staging: r8188eu: remove DBG_88E calls from hal subdir
  staging: r8188eu: remove DBG_88E calls from os_dep/ioctl_linux.c
  staging: r8188eu: remove remaining DBG_88E calls from os_dep subdir
  staging: r8188eu: remove remaining DBG_88E call from include/usb_ops.h
  staging: r8188eu: remove all aliased DBG_88E calls
  staging: r8188eu: remove DBG_88E macro definition
  staging: r8188eu: remove rtw_debug module parameter
  staging: r8188eu: fix lines modified by DBG_88E cleanup
  staging: r8188eu: remove rtw_sctx_chk_waring_status function
  staging: r8188eu: remove padapter param from aes_decipher function
  staging: r8188eu: correct long line warnings near prior DBG_88E calls

 drivers/staging/r8188eu/Makefile              |   1 -
 drivers/staging/r8188eu/core/rtw_ap.c         |  69 ---
 drivers/staging/r8188eu/core/rtw_br_ext.c     |  67 +--
 drivers/staging/r8188eu/core/rtw_cmd.c        |  14 +-
 drivers/staging/r8188eu/core/rtw_fw.c         |  23 +-
 drivers/staging/r8188eu/core/rtw_ieee80211.c  |  37 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  10 -
 drivers/staging/r8188eu/core/rtw_iol.c        |  12 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       |  66 +--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 411 ++----------------
 drivers/staging/r8188eu/core/rtw_p2p.c        |  69 +--
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  45 +-
 drivers/staging/r8188eu/core/rtw_recv.c       |  71 +--
 drivers/staging/r8188eu/core/rtw_security.c   |  19 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  10 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |  97 +----
 drivers/staging/r8188eu/core/rtw_xmit.c       |  78 +---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   4 +-
 drivers/staging/r8188eu/hal/hal_intf.c        |   3 -
 drivers/staging/r8188eu/hal/odm_debug.c       |   6 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  46 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  71 +--
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |   3 -
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |   5 -
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |   9 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  62 +--
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  29 +-
 drivers/staging/r8188eu/include/rtw_br_ext.h  |   5 -
 drivers/staging/r8188eu/include/rtw_debug.h   |   8 -
 drivers/staging/r8188eu/include/usb_ops.h     |   6 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 377 +---------------
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   4 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  37 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  79 +---
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  15 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |   6 +-
 36 files changed, 184 insertions(+), 1690 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/odm_debug.c

-- 
2.34.1

