Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26947DE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 04:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346167AbhLWDYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 22:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346074AbhLWDYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 22:24:12 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55F7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 19:24:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso4364973pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 19:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LS8DywJ2uBotDQESRAfls6o357hbpNH3R8BA0Fi916w=;
        b=lHLwS7wAvLitgo6ES2KRcZ1GVPKcovSQnuFOpENHUp1rAYu/G1c3ZAe/gRjz/6zx1M
         LxJc2AicRtvTeVtzXWMIbRUYExSNxu3ZIh/fyaZcb/sM6e3rgOei1qiZkwA82DH8CPs6
         dNPy6K09gknxnf3ku0F/wJLcA3khMFzNAfpiNO4Pn/8ap6axdeBkMnSC+m+sw+3LkMup
         8w9PXmk64U/FnyTbBJp0QVJcevypHmXwRjKII+Na4ieHaEB0u2ag2ok93Co0NUywL/Xe
         RHMfKu1DW6ou8RKfE/lDKa4Y04X69SZ6PExHVcC2wYNbQwIrJXs8Zdo3c4ULkna5oumy
         3H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LS8DywJ2uBotDQESRAfls6o357hbpNH3R8BA0Fi916w=;
        b=xdpT2WGsYMe3i6o/Dsvdx55FJlrZd6ZnNwqQ24TkDVp5+R0V/heb3fk+pWxTIczWuo
         5l8n3Teguym8Yb3BFUMSBNpT6usQe8fJ3h22k+ImF58KMfsAw0OS2PDdcnMCzwPUNQ+J
         vngJCy8pasTCV0yZEKC+wKh5/zg4j4qdzsLBgKnw4qfSzMF1bKLHqwxMdjiq6lHx1lb1
         CFziAupOwYyBS4lMzfbrsCyDMMxzS8fczJzzJ0DqRjOSB2dW6kOG9Myg+zbAa2pU9utX
         DoIO7jFlCVDRvMZ+SY1K223ktAlF1old8YYn2k4enkYRmjvbkk6nI5G9BzW1nKG04/+i
         OMNg==
X-Gm-Message-State: AOAM531WzgPQZmo2X9JEViW8YeQHA8uPThH30zYPRdS1LPTY9ZVz+3JS
        qFI+n7jytroVAXLkL2479v8YWA==
X-Google-Smtp-Source: ABdhPJzzO25WFeEjMVlRpDbyTeU+tl2GTDKhLHGdlfQgu9owR/074xdIe33WKXIUcAmDFIAJyEUGtw==
X-Received: by 2002:a17:90b:2243:: with SMTP id hk3mr949951pjb.72.1640229851211;
        Wed, 22 Dec 2021 19:24:11 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d3sm4348622pfv.192.2021.12.22.19.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 19:24:10 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH 0/2] ext4: fast commit crash consistency issues
Date:   Thu, 23 Dec 2021 11:23:35 +0800
Message-Id: <20211223032337.5198-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets fix 2 crash-consistency issues of fast commit.
First patch change to use ext4_ext_remove_space instead of 
ext4_punch_hole during replay delete range procedure. This 
avoid replay procedure being affeced by incorrect inode->i_size. 
Second patch correct the trank range logic for ftruncte.

After testing this patch sets with xfstests-bld, in the "log" and 
"quick" group with config "fast_commit" is selected. No regressions
was found.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>

Xin Yin (2):
  ext4: use ext4_ext_remove_space() for fast commit replay delete range
  ext4: fast commit may miss tracking unwritten range during ftruncate

 fs/ext4/fast_commit.c | 13 ++++++++-----
 fs/ext4/inode.c       |  3 +--
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.20.1

