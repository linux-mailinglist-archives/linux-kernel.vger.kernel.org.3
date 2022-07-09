Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B638256C866
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiGIJpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGIJpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:45:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54301655A0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:45:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ez10so1349646ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qS7NXICXrYzuBu2snw80niT0A4edSVecKeyrASDHwuM=;
        b=GdQW1oqRvMc3yiC7ZNvWSPLUsJxkUXwqRI1bpd0hHdW0x3QGrYY+A53OSInxYU4ZXK
         CiWf0ybDuPhOorntfXXdJiQqxTJ7YSzSMSzTllbUh43LVq+C6g/XgLNkOOGSvxl/9iPw
         6egTjXkmM8yO3EpRBd9gM5+7EbU/9FBG2D328FZcsCh8hwCJOB1OTknngASzKTbBP7Fc
         B4WrZ3pkGPDWZV8hy0eCy4JdRvmjXH/6/za6j67nLnA4ul8tSCMcFzCBVIfOF6DV/Hy7
         /++/BsXWND9tg7WRxuJ/BRsqxWNXRbUS+8piVFV/gqnuYhdRLhscD/flqDFer2VqlZJA
         OM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qS7NXICXrYzuBu2snw80niT0A4edSVecKeyrASDHwuM=;
        b=dwduxkKyLcrpvrPIfwDbdR2/xQ1yOPbRBSgCBI6hbnrCTVqpague783Lu/h+qT5HYC
         sVjiyQky0TBcC1HIsnZmXe529/SqifM+dnNqA8ro09nxhLR9bYnuxHITrqktw75qiCEB
         bivODCgkmdqtf/UWujA74cHXGcVZV4hHvF5Dd40ZKJ+wt9P4I14yTAnJD6iD2zs1XgTT
         hfXxi4N+NnLq+GlupOdhxdIjliBhddNeZIFIxWOAlFt75eej81jQdghxsAmz1VUHF37f
         mTFU8J1pnJ782eJ2Eyo/NadXiau4PaaV/rQ+DWUSiXbrxhT3dlRLTxveMW3mxrHhDTn+
         Lpeg==
X-Gm-Message-State: AJIora9XauagAcpeUBXCNp0Cawq5wEI77yvk0movNMTuQS5HLTj+Uy8o
        vs6qmwRkvlq1ezjFLJ/bfBg=
X-Google-Smtp-Source: AGRyM1vnx4HdESYKOr7xrUNQ2ey1+/7ybWYZyOf69dfDAJGDkNnO3hGU0PNdhyxkn+kjPRqpEjSnuQ==
X-Received: by 2002:a17:907:a421:b0:726:ee5f:718a with SMTP id sg33-20020a170907a42100b00726ee5f718amr7985663ejc.368.1657359907891;
        Sat, 09 Jul 2022 02:45:07 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6f.dynamic.kabel-deutschland.de. [95.90.187.111])
        by smtp.gmail.com with ESMTPSA id hy10-20020a1709068a6a00b00704757b1debsm441521ejc.9.2022.07.09.02.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 02:45:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: SetHwReg8188EU() cleanups
Date:   Sat,  9 Jul 2022 11:44:53 +0200
Message-Id: <20220709094458.9578-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.36.1
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

This series removes some more cases from the unwanted function
SetHwReg8188EU().

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (5):
  staging: r8188eu: remove HW_VAR_BASIC_RATE from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_DM_FUNC_OP from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_DM_FLAG from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_DM_FUNC_RESET from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_DM_FUNC_CLR from SetHwReg8188EU()

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 25 +++++++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 51 +++++++++++++++--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 55 -------------------
 drivers/staging/r8188eu/include/hal_intf.h    |  5 --
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  1 +
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 10 +++-
 6 files changed, 77 insertions(+), 70 deletions(-)

-- 
2.36.1

