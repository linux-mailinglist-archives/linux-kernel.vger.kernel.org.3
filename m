Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78AF485EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344952AbiAFCpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344936AbiAFCph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:45:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB048C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:45:36 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so6879484pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 18:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jn+S9BAI1OCc7CICvkheWrMxG/LQav/G3Nl3L/CdSmM=;
        b=WWPWZz+hAaAOW388U+TlnhsHQDTCJz2O/5Bnv9uleUbfp/SlCZWtwjmPGRxSkK8HXk
         0xHOu2OeEhDR82/wzo+dvwMYGID1RK+N0b9+4lh6TZAFpZeNUdtIXIykl6+ztcI+DopP
         JG3YfgRQPDc/c8GrPL539LA7OAQp4baSiO0Wdm4/kh6rbGLVxTunjcvL+mLTl2rVuIRw
         59ReI6ScjCC8wsTFX3w7WqcAXrOMBHZ9TJYVEcVMSEjeF1d5+YvzfR81IgCaA5sKFhJL
         TNIYIQG0PHV0EuRhiTMVydm1BC0HDgZkzzXZtkd+jM7xD2/kxLP2Mj0Dy3brgp3OMN3u
         U94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jn+S9BAI1OCc7CICvkheWrMxG/LQav/G3Nl3L/CdSmM=;
        b=igThM2Es1IHV8bJEHCr6Yr4dxM75Nk6G3ZqfPncfHhR4swQlCJdbi0C8K5GTOfcNSN
         45JHwGJ2dUKsmIwJIJXwk1l2jCS7RcwQoDgzrTdn0+j23JFsrpDFiwWX2Ca64RdZmBE8
         Xeea83ZWtA9YYuE80AWVI9AHpoBHLbqUi21Y7WLwxrZg4bgmi8ZMhhu4Q3xkSrtKvJKQ
         LGDoQzWbl9DUtlq7pdCvyY8k8HBJ9RS722Snp8HERQipajSJLS1kxif5Y98DF8VBXBcc
         CLa84/gI+yZpHr3ogKmTVofSkDl1PvxGvU/wmdwijloiHkrhNXS9J4yUJRzsNaE2tsl0
         DZrQ==
X-Gm-Message-State: AOAM533vPrbYMtjHkroteJlGqVYo82LhH4KSFwzX9BQLWM9G23kYgm10
        6iwWsFJBZ73feAaf5Nk2KK+HQg==
X-Google-Smtp-Source: ABdhPJx5YJWOeTZpLWTFL3XTGe/k9q0J56HQoDLk1X9Sir76u93Z5EiiDnRAaNOq74FvP6yKVAYeEA==
X-Received: by 2002:a17:903:246:b0:149:e881:9e36 with SMTP id j6-20020a170903024600b00149e8819e36mr2893311plh.26.1641437136510;
        Wed, 05 Jan 2022 18:45:36 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id p12sm414244pfo.95.2022.01.05.18.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 18:45:36 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH 0/2] fix blocks allocate issue during fast commit replay
Date:   Thu,  6 Jan 2022 10:45:16 +0800
Message-Id: <20220106024518.8161-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when test fast_commit with xfstests generic/455, one failed case is 
after fast commit replay, fsck raise ’multiply-claimed blocks‘ issue.
one inode's etb block may share with other file.

fast commit replay procedure may allocate etb blocks for inodes, but
it may allocate blocks in use. This patch set fix this issue.

Xin Yin (2):
  ext4: prevent used blocks from being allocated during fast commit
    replay
  ext4: modify the logic of ext4_mb_new_blocks_simple

 fs/ext4/ext4.h        |  2 ++
 fs/ext4/extents.c     |  4 ++++
 fs/ext4/fast_commit.c | 11 ++++++++---
 fs/ext4/mballoc.c     | 26 +++++++++++++++++---------
 4 files changed, 31 insertions(+), 12 deletions(-)

-- 
2.20.1

