Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43944A5033
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378889AbiAaUfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343687AbiAaUff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:35:35 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D20AC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:35:35 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id v20-20020a1709028d9400b0014ca63d0f10so2413828plo.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HEysl+0+HIw/m+20ELUKT2iKO4bE+cT13hE3Duhm1jA=;
        b=SUxYirimv4gQq3ABnzJ5B0QaYJRNSGEfIPZT/dEvQHSegXWyWhXkLNUOamQcvVBbv6
         MaFafaldt9GH2lQHFgMyaI5PTxyfXC1iVQN1w6cv2eZB1hGqWU8y1Wwu9rcymWTlqRyI
         UZm0msX2zv5voyAyRpfvf0Q+zUjpKwbYpmboAbWDZnDiLyshtP27jDUpjaQcG3UEnuob
         xUEHrJUrWw3OQcytt74br0j0q2GDeK9rYh2QL6IxHxhwUA+zw19RBLpKxulUXvHe0Nh2
         bPjNO+Wk8YvoS8njtutL/nOt4LZkzMnRE35m7jQQQfNuez77Je1eOpbCOSj+fp2mXDjR
         UhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HEysl+0+HIw/m+20ELUKT2iKO4bE+cT13hE3Duhm1jA=;
        b=Yh//LIjXyGf0WLPHYhs/0U+QqBkglSEpsc34DMSbVTqaxbH2PE6ZTyK51rVwqj6rC6
         40/GzMm70cxxfQE+kCZMomrJslu9zPGtcbVLGu359+mrfzAucIjg2gWuFmTTPSQq3uPc
         u4FJwhLHhBemB29s6UWzm9V6xYnn4tgxrw3p+idZzIlen3+OO8cTuT47exHTvuoZFlgs
         lGi58PlH8NXwiNJyk7WkJ3bPXvRXpQYPC/jo5Cwvi+FjQpQpkaU1M9lO5fSEIT/e2ZBa
         I7gKfUYoE2HRNYqw0EGxkwfKc1eRLX7uMLINNpGwnJsaKaXkqaAqo1LJlD3vM2JK8/+B
         0mvQ==
X-Gm-Message-State: AOAM530u4aKd9lwjXdvwWSUlOdA785vWHi/uEFOZcPLjaWEq64R1BFlk
        HtHW0QLBJw/OV5qiw1orGkr3iFzBt25OC+XGMnM=
X-Google-Smtp-Source: ABdhPJy/BfcZXYa8lXHZT/EKiFqFtCV/5/t+HzMAv5CRnmV4FrWiZ86QTm/APzTpK045HZ4KQLqLo7tedoWL9J84a3Q=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a17:90a:694d:: with SMTP id
 j13mr36654464pjm.10.1643661334747; Mon, 31 Jan 2022 12:35:34 -0800 (PST)
Date:   Mon, 31 Jan 2022 20:35:04 +0000
Message-Id: <20220131203504.3458775-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v1 1/1] mm/gup: skip pinnable check for refs==1
From:   Will McVicker <willmcvicker@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     kernel-team@android.com, Will McVicker <willmcvicker@google.com>,
        Minchan Kim <minchan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes commit 54d516b1d62f ("mm/gup: small refactoring: simplify
try_grab_page()") which refactors try_grab_page() to call
try_grab_compound_head() with refs=1. The refactor commit is causing
pin_user_pages() to return -ENOMEM when we try to pin one user page that
is migratable and not in the movable zone. Previously, try_grab_page()
didn't check if the page was pinnable for FOLL_PIN. To match the same
functionality, this fix adds the check `refs > 1 &&` to skip the call to
is_pinnable_page().

This issue is reproducible with the Pixel 6 on the 5.15 LTS kernel. Here
is the call stack to reproduce the -ENOMEM error:

Call trace:
        : dump_backtrace.cfi_jt+0x0/0x8
        : show_stack+0x1c/0x2c
        : dump_stack_lvl+0x68/0x98
        : try_grab_compound_head+0x298/0x3c4
        : follow_page_pte+0x1dc/0x330
        : follow_page_mask+0x174/0x340
        : __get_user_pages+0x158/0x34c
        : __gup_longterm_locked+0xfc/0x194
        : __gup_longterm_unlocked+0x80/0xf4
        : internal_get_user_pages_fast+0xf0/0x15c
        : pin_user_pages_fast+0x24/0x40
        : edgetpu_device_group_map+0x130/0x584 [abrolhos]
        : edgetpu_ioctl_map_buffer+0x110/0x3b4 [abrolhos]
        : edgetpu_ioctl+0x238/0x408 [abrolhos]
        : edgetpu_fs_ioctl+0x14/0x24 [abrolhos]

Fixes: 54d516b1d62f ("mm/gup: small refactoring: simplify try_grab_page()")
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Minchan Kim <minchan@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index f0af462ac1e2..0509c49c46a3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -135,7 +135,7 @@ struct page *try_grab_compound_head(struct page *page,
 		 * right zone, so fail and let the caller fall back to the slow
 		 * path.
 		 */
-		if (unlikely((flags & FOLL_LONGTERM) &&
+		if (refs > 1 && unlikely((flags & FOLL_LONGTERM) &&
 			     !is_pinnable_page(page)))
 			return NULL;
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

