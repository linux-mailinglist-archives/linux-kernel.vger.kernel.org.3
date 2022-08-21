Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F4159B60A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiHUSgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiHUSgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5892513F36
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661106959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=03PWg65stwGYjyOpdF2SCxDfkaqjGHQjclYuR1+BMys=;
        b=YPeYzYenanXwy6y5bm+Fd5n75+ZKrDhnGfZ2vL8ZIMaV60hwHidR9/3IqBd2JOrBEX4jgs
        nqZtXEtHpnj7l04gcsr0C4Sa7QZn2/mXIDIKF/2gmdoqEPyyrYzBKsDZl4tC5NwWcRZoj4
        2Zrw0Vi7zYu+N4G3p8S/mWPm/421W6Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-AGAQk7VHM2WkK1yjippUAQ-1; Sun, 21 Aug 2022 14:35:58 -0400
X-MC-Unique: AGAQk7VHM2WkK1yjippUAQ-1
Received: by mail-pj1-f69.google.com with SMTP id s5-20020a17090a2f0500b001fab8938907so5047335pjd.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 11:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=03PWg65stwGYjyOpdF2SCxDfkaqjGHQjclYuR1+BMys=;
        b=mQ3r4DYGSAKaeQc5BwnZg7awr7eIAaz1AMIlK9hIn58+NWLKAeOLVUaTJG3NtuO9wj
         NhRr5NUiPPpVPk83U8PePIbrHtqUoPqzqirMwUhrFnuhqPl81rPmfKznoSoz2CVwke/q
         pwcjpnCU3oPKhjDnlxXWUzv+6gB/UvM24m83j6Wo7UrMF5c5UL1qp1QkPWkUE0F7tXWO
         nw4UHBGBrwOr1PiHd2djO5bG0rDzksCvKvc+Jzb+qnP+MjXSlIRV/o4yRvchFw/Q2bEs
         0yI6aQbgA9/ofoQdrkOmYCzSNEHmzkXd9BOlRQzx9h/bjrAfrx/GTDvdry3LDxO+q6Iz
         WlAg==
X-Gm-Message-State: ACgBeo0uDMe/RAdglZt8wqMbBnbieCgFmpglIHHURaJ3JMPF3tC6HKx4
        dI+TnPvOjxKLm6Gr9/2NVCGx4T8ruT+6nGW/4SEnQvjWGixhDRSpcv58l9tRSASUHt6yi1DDtMh
        GaFY2hvw9Hfs3EASIn9trPHBh
X-Received: by 2002:a05:6a00:b8b:b0:536:71f7:4ce3 with SMTP id g11-20020a056a000b8b00b0053671f74ce3mr4809933pfj.74.1661106957035;
        Sun, 21 Aug 2022 11:35:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7cOKqKMmOZIFmj+50Xk++p5bxdG74FEoDVzQ57OYjfNjsA56ll5zZNjZzEtBTS3z8BixxH0g==
X-Received: by 2002:a05:6a00:b8b:b0:536:71f7:4ce3 with SMTP id g11-20020a056a000b8b00b0053671f74ce3mr4809918pfj.74.1661106956725;
        Sun, 21 Aug 2022 11:35:56 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090a2a4900b001f326ead012sm8584240pjg.37.2022.08.21.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:35:56 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        syzbot+616ff0452fec30f4dcfd@syzkaller.appspotmail.com
Subject: [PATCH] mm/gup.c: Fix return value for __gup_longterm_locked()
Date:   Mon, 22 Aug 2022 03:35:47 +0900
Message-Id: <20220821183547.950370-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__get_user_pages_locked() may return the number of pages less than
nr_pages.  So __gup_longterm_locked() have to return the number of
pages __get_user_pages_locked() returns if it succeeded, not nr_pages
passed.

Fixes: 61c63c2076d9 (mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes)
CC: Alistair Popple <apopple@nvidia.com>
Reported-by: syzbot+616ff0452fec30f4dcfd@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 mm/gup.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 5aa7531a703b..542cf74c59b0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2068,22 +2068,22 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 				  unsigned int gup_flags)
 {
 	unsigned int flags;
-	long rc;
+	long rc, nr_pinned_pages;
 
 	if (!(gup_flags & FOLL_LONGTERM))
 		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
 					       NULL, gup_flags);
 	flags = memalloc_pin_save();
 	do {
-		rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
-					     NULL, gup_flags);
-		if (rc <= 0)
+		nr_pinned_pages = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+							  NULL, gup_flags);
+		if (nr_pinned_pages <= 0)
 			break;
-		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
+		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages, gup_flags);
 	} while (rc == -EAGAIN);
 	memalloc_pin_restore(flags);
 
-	return rc ? rc : nr_pages;
+	return rc ? rc : nr_pinned_pages;
 }
 
 static bool is_valid_gup_flags(unsigned int gup_flags)
-- 
2.37.2

