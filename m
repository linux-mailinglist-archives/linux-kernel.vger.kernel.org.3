Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E38491E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352215AbiARDug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:50:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37330 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353159AbiARDsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:48:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09138B811D7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 03:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06943C00446;
        Tue, 18 Jan 2022 03:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642477707;
        bh=YMzf0J7TGo4osL4tfYFJ5TLiS5QRWtju4uRDZy0maY8=;
        h=From:To:Cc:Subject:Date:From;
        b=e0QlkVsgMKOtxE53nySgnELzDh5PRH9DzKxvVAhZue7sug5oBbmECyFumAvSsNOvY
         nDWukECWisT6AZt3VpkwCRP3coMrloRWzp9KOYr7Ce/Rj0GUmDPjuRx+ajFf4TDLnT
         tuonX5AOV6JzrBy3nt/UA9OoCFXhaXJ4uvOCCU26m54qvZeHQ8VJRvZf6ZgcvqYN4j
         BIdO7+oKuicFIp+zb1NqGYoycNmvg56UQhB6W7GkbVmp/7sM/Dcoz1U1LrYEJfIvWC
         e9yRUwxxxjPdqRBwMO4xDSqBPGwCzgttndOlIV5p6QNsj1HPyvE03v2D5W8osP3Kem
         X5Y//7Np9P9Sg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Zhipeng Tan <tanzhipeng@hust.edu.cn>,
        Jicheng Shao <shaojicheng@hust.edu.cn>
Subject: [PATCH] f2fs: fix to enable ATGC correctly via gc_idle sysfs interface
Date:   Tue, 18 Jan 2022 11:48:02 +0800
Message-Id: <20220118034802.98403-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It needs to assign sbi->gc_mode with GC_IDLE_AT rather than GC_AT when
user tries to enable ATGC via gc_idle sysfs interface, fix it.

Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
Cc: Zhipeng Tan <tanzhipeng@hust.edu.cn>
Signed-off-by: Jicheng Shao <shaojicheng@hust.edu.cn>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f8a14b1e2ef7..699f97610e8a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -482,7 +482,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		} else if (t == GC_IDLE_AT) {
 			if (!sbi->am.atgc_enabled)
 				return -EINVAL;
-			sbi->gc_mode = GC_AT;
+			sbi->gc_mode = GC_IDLE_AT;
 		} else {
 			sbi->gc_mode = GC_NORMAL;
 		}
-- 
2.25.1

