Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FAE49C39B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiAZGcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiAZGcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:32:11 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F015C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:32:11 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i8so20279372pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFV9HljKMoO/Gv/RBQllZfNyG/7KSwU8sqdiwmqzVPg=;
        b=rHHIfCeFr9lMxN2MhwVdmuYo0GW95Tx9RS6YGi7T29U43aewRhpZKl0dwvZl3g+1Kq
         MpznLmqvsUUEgwFfhPZ7zVEsRWX4OTdyf6LH8b9L2usPAyWpIkr3Sy/A+5uQnEih3ZRt
         vyAdWk1Ua+fnKlO9EM3Ez6IGjo/HaJyRoz3lDOa4qDrI9pMjXfD87xDnxn7xKxA06sNa
         opACS2Ffdr8fJCNQ5Llwq/dg3lc7Mgnd/1Q7kECcpf5D1Xru9KGi9c6s41nRFucyXzTM
         u1KFrWsI6P/i0pNS4Rjn5eHX8jpXbLELki4LVGuOvMfw8wXoOro1JFU9tlzQOAn8i4LL
         KqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFV9HljKMoO/Gv/RBQllZfNyG/7KSwU8sqdiwmqzVPg=;
        b=dpUDH1WHObBHRD4j/Tjqxv3OGpcWljuw8HcbsvD9Dr1HSPkgdLEsTbBzni8zjIzkb7
         V6ofty+dq80fOPluWRef0JMGyncXrCtMk1+HPv/RwM4zJXtv+FF3z2Wuo3H9eZw1j5PS
         g+xsmD+Nln1+6hWUa8IICR5HcoSHGiGTcWlaTY2F3bxR66oD0lW+uQI57AxEMYjEJg7f
         2lwRPvwtLhZka74/OZzhZuwtogJGkiqhKyAB1AQLsTme63AQYHkx1P8MDTouFhae98k3
         GS1QtLX/tpQJXxCJECT+Bh5uRkTMc856lCITqyQ7LA6r6MFIJX9TJbe31T2wqgtEiFbC
         h3Lw==
X-Gm-Message-State: AOAM533E1M/ME0Au+9tUKXmvyr+hOWfLgijY60wwmYgObyx85atgN0ue
        nuEikvhCvkrmKSLLABwnXws6pw==
X-Google-Smtp-Source: ABdhPJwMrKHaj3UkQOIGN91HZ1jmNkH4XivVRyJXnwGPTwata5DNZ4rKGUGsq0dUjtpeBYEuPj4Lng==
X-Received: by 2002:a63:f201:: with SMTP id v1mr9352021pgh.250.1643178730748;
        Tue, 25 Jan 2022 22:32:10 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id p20sm16349824pgm.88.2022.01.25.22.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:32:10 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ext4: fix incorrect type issue during replay_del_range
Date:   Wed, 26 Jan 2022 14:31:46 +0800
Message-Id: <20220126063146.2302-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

should not use fast commit log data directly, add le32_to_cpu().

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 0b5b5a62b945 ("ext4: use ext4_ext_remove_space() for fast commit replay delete range")
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/ext4/fast_commit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index ccd2b216d6ba..488347b4c8b0 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1798,8 +1798,9 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
 	}
 
 	down_write(&EXT4_I(inode)->i_data_sem);
-	ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
-				lrange.fc_lblk + lrange.fc_len - 1);
+	ret = ext4_ext_remove_space(inode, le32_to_cpu(lrange.fc_lblk),
+				le32_to_cpu(lrange.fc_lblk) +
+				le32_to_cpu(lrange.fc_len) - 1);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (ret) {
 		iput(inode);
-- 
2.25.1

