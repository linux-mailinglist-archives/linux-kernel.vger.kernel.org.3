Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8E488F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiAJEtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiAJEtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:49:49 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952D7C061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:49:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o3so800989pjs.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 20:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bD6zeuVgCTlq+zfvzqfbER3EToA3lGW10eCyIwR7cYs=;
        b=JPgqoymjnTLcVojp7IBqhEkpgLAAh12doBI8Kjrr7fIyM8ed5YNQk5Q6ssDDfBpg7f
         MUiuesoz3dNkIPSicQzTTqGZL4KUpv2xiDlUYAbgWKj8mIZ0U+FVDmEl2q0IKCCi2gGs
         2olwFAiCrxmtugIl0H5eBHs+KrJPp0Yo+IgbxL63W/QS4hW6kGJ23+/T4KKjag9ZCq9p
         Y8NMYyGZ+dG2dIX22ZUxiUC+/XL4CKp+6MElo8iAR7iJo4HC9rcw8p77w6aVa6zeU3+5
         RGXE0glCkMT17U8sWGRX9bBRCAvAnAJybMgKh47vWZmhjdmcDiOQrv7MthTKanm1sWhy
         OkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bD6zeuVgCTlq+zfvzqfbER3EToA3lGW10eCyIwR7cYs=;
        b=ZuD9cMrR1WBnEzNaNBeSlb8wFWWdMSCc6nW+5AZmj55msREAGe6kX9LQrecm/WvQtd
         Fna5CyUeeoo72tnvF57GHDKEHMfNQ2ArlROnh0X6pVmXwZtodAyr0sWFD2E7V2eelCxj
         pMySGC/IXxL21oaTXP/vSbX1UHulUXIJhbVAsq5vD0wbZ3KfcdlvoD2ZDN0IsS03ACTD
         53yA2f+4SLGKBHaTNsb2LB7rpiIUjnBgF8xvieH7zRGC7UlTRpvSZiC4PrO9DNmE53Lp
         28Gj17jbGDzLbN9oxbHC1dDC87vF6EohDyE8DI7J5y15Shz3ujXibGEQD2JGxvROFJSC
         m5pQ==
X-Gm-Message-State: AOAM5331N3l4HOe06z/exz2hbn9FhqOSl5JgC7HYHFI3+imFNStKb3H1
        g7MsJ8F3ocXlWH758cKyqmb5vw==
X-Google-Smtp-Source: ABdhPJyV4hGH1n9h4eT5F4wnM1l0eR0t92pPMOPG8ztoW+eH1xdPBj7qfCW1cv+3dETT5Q89jluqGg==
X-Received: by 2002:a17:90a:ae17:: with SMTP id t23mr4668243pjq.116.1641790189022;
        Sun, 09 Jan 2022 20:49:49 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v8sm5449997pfu.68.2022.01.09.20.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 20:49:48 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH v2 0/2] ext4: fix issues when fast commit work with jbd
Date:   Mon, 10 Jan 2022 12:48:47 +0800
Message-Id: <20220110044850.2806-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When test fast commit with xfstests generic/455, some logic issues were
found. When a full commit is ongonig, the logic of fast commit tracking seems
not correct. The first patch fix the ineligible commit case , and the
second patch fix the common fast commit case.

After testing this patch set with xfstests log and quick group, no 
regressions were found, and the generic/455 can pass now.

---
v2: drop EXT4_MF_FC_COMMITTING

Xin Yin (2):
  ext4: fast commit may not fallback for ineligible commit
  ext4: fast commit may miss file actions

 fs/ext4/ext4.h        |  3 ++-
 fs/ext4/extents.c     |  4 ++--
 fs/ext4/fast_commit.c | 28 +++++++++++++++++++---------
 fs/ext4/inode.c       |  4 ++--
 fs/ext4/ioctl.c       |  4 ++--
 fs/ext4/namei.c       |  4 ++--
 fs/ext4/super.c       |  1 +
 fs/ext4/xattr.c       |  6 +++---
 fs/jbd2/commit.c      |  2 +-
 fs/jbd2/journal.c     |  2 +-
 include/linux/jbd2.h  |  2 +-
 11 files changed, 36 insertions(+), 24 deletions(-)

-- 
2.20.1

