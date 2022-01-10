Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6672F488F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 04:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbiAJDwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 22:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiAJDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 22:52:03 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF06FC061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 19:52:02 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i6so10853402pla.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 19:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PAvG8D3Inyp/sgIhRNvq2JrQif2n8c7Fqe5EJWWRaBI=;
        b=2/ar0G5+FYyUMpoFnsHSG5TabDwOQBU9NpCC+r+0W8u94UawaOGuynAifvr5zX9aia
         zwHPWCl8JnJ15v1zbydOjJ6fm1JVNWz2pOAHTdE2/OJAI6sxTjjXvVTINonbtHYzcEoX
         tKJstdvOopxubpWF4j7KMIcNOXo6Eca8M5nx9JzPOvqsKvtxRgIoIvgLGJQH+e5dMPB5
         Dz9/supPxQege0wjKbxYc4XSkYDgRYKi9nEHnVguHutdegCCY5Dgt0qbWNLyB2Kj7Akx
         OmfcJKkCsnnWCUJmlS0kRzK+HZ9Zl+9I0brt6unxGzEOrWej8f50GgT38Ls5Us6DdQke
         yP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PAvG8D3Inyp/sgIhRNvq2JrQif2n8c7Fqe5EJWWRaBI=;
        b=zQqiALVMKzrloqO2oePa35XWZZMrORUcXAJWkP7HPrhzQdTE0eAuJDoJ+0mNcQguik
         Y5M6HbHl+UEVS0E1NBbwU9sacbc1FhToVqU6ZiXT/6CFE8tH572Ijqy/h9Nc+nmmNTsN
         Vpbqm+B2I9N/iB9ep+l/qOL6HS7VAuydKD7r7vBex9wDGYnQ0IKyGbvIcXxd8WSVP0p2
         bz0sSdnhIZAnRbOnhY3POqGoZMPhnV8s5vDK1FxIklZWJOHyaHo8zDMYzadkBOAL0x8I
         2E1eMohzy4NAg1W2AoKVj9fR5ofWGLVmaKAx7WJ0AE4cAKy4DkV+RI4hfqNiawYn58xu
         YQEQ==
X-Gm-Message-State: AOAM533U36KlnbNqf8mKBrR3RUaoIn0leT/xZXoP31xjURIsoh2TDGkD
        IyQSU3Rfa/BVySHTQFSbWJWHoA==
X-Google-Smtp-Source: ABdhPJz3HDi3p8Cyv2kCwbk9c2Gn8hmSeJeq6WMWip1pm3Vmydv7ftgLsq1xCmaeSl0hYzmJ/f7kOg==
X-Received: by 2002:a17:903:2493:b0:14a:766:a89d with SMTP id p19-20020a170903249300b0014a0766a89dmr12886053plw.112.1641786722468;
        Sun, 09 Jan 2022 19:52:02 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id h3sm6772748pjk.48.2022.01.09.19.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 19:52:02 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH v2 0/2] fix blocks allocate issue during fast commit replay
Date:   Mon, 10 Jan 2022 11:51:39 +0800
Message-Id: <20220110035141.1980-1-yinxin.x@bytedance.com>
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

---
v2: add comments for behavior change of ext4_fc_record_regions().

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

