Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC16B4681F0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 03:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384053AbhLDCW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 21:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhLDCW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 21:22:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2F0C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 18:19:03 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u17so3304953plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 18:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=119nixz5wqDPjb6GHxuJGyOiwK7q6RFXR3RKZpsye+A=;
        b=BUVmAmsbLsSXqaFbJ+8sF+JGLxzz81tfarondwu2O/bcl5T2KS14wAK+9TrcW/4m7A
         f+DoQyQyPjFZYETvdxd3WPeiqoHfejJQd9ZxYbLy+nHCGBYosddmge5oLpWuUcze7BKh
         /djOlLnRZUk4bAcB6SIg7hoRKo0bnZUH+mqOR96IrZBlgWY7fbKI8go43By6UEZj2yVr
         wpfNFYkEdw+zf7QRDxt8R4U/Pv8jcLeFAauTdyZf13uMmSnhqfavLjBqSzBekhTLcN3l
         E2x/Pbg2Wci3WLcDJCT1stF+0t5lznSPleW7LLHRBdCBujZldiL6c2h+yBp0IRqQ+hbp
         BjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=119nixz5wqDPjb6GHxuJGyOiwK7q6RFXR3RKZpsye+A=;
        b=dn1Uy/9YnkoemnACmlg5Scd1xo3gfpr+9njQ/DzYq6BWJj57w1rahVQpFjPw1fjWW8
         YfRBOQ9+BYcFzjtEkltecW+t12Obx1CkGNSXxyUjLzvq422/U9QSIbmARI28LGChfRDC
         kAhBrSvHE95/fQK7rCq+Tx33SC3pM9fmDBnTpSxEeMp1LGEqOb0h4Hj2isXpxl64Nsm5
         S7LEykHdZmjHjkWZzPRFT/n5v2At8TOabFnpG4gRiyLwmrmmQqJFGv2YttkNRMF2YWxd
         /DfjMCC9Me4HTXitouadAUUHUEXt5/C2uB8NyoqxJ57f6qtq11e4NcknqvIdcIATDt5F
         nA+w==
X-Gm-Message-State: AOAM530DEM1S3y+RQd+QMzB+lgC8kUzEFBaLlc/cESZxotoNYo2KIIGI
        sQw+FoeXHQB4sXehhWDVgUBsQsiXj/0=
X-Google-Smtp-Source: ABdhPJz/aOjP+uKqlWX8Ogmjv8dFSRlrGGhFV6K2vsQ9J79rq+tVUn1oU5Hcui6dZW5ZtogqRLDdeQ==
X-Received: by 2002:a17:902:f209:b0:141:99d1:7cef with SMTP id m9-20020a170902f20900b0014199d17cefmr27407930plc.70.1638584342206;
        Fri, 03 Dec 2021 18:19:02 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id m10sm3396102pgv.75.2021.12.03.18.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 18:19:01 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/3] OpenRISC Switch and Clone cleanups
Date:   Sat,  4 Dec 2021 11:18:39 +0900
Message-Id: <20211204021842.1853549-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are a few patches that came after auditing the OpenRISC switch code
recently following the discussion with Rob and Arnd and the clone and clone3
wrappers [0].

I noticed a few places where OpenRISC could shave a few instructions and also
that we need a ABI wrapper for clone3.

[0] https://lore.kernel.org/all/41206fc7-f8ce-98aa-3718-ba3e1431e320@landley.net/T/#m9c0cdb2703813b9df4da04cf6b30de1f1aa89944

Stafford Horne (3):
  openrisc: Cleanup switch code and comments
  openrisc: Use delay slot for clone and fork wrappers
  openrisc: Add clone3 ABI wrapper

 arch/openrisc/include/asm/syscalls.h |  2 ++
 arch/openrisc/kernel/entry.S         | 27 +++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.31.1

