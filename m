Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE5359C2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiHVPhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiHVPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4015A10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661182659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OR0r/hyXZ2PC1LIRo6zlU9kEOJ14T8ubT9gvOTsTo74=;
        b=QFVFVVJwYWLCCDjEb1GmQkcvnsnwPBMSoucUCTd55dFiJjEBuYS3mTZD2V4yUdWTv+UdmC
        apKwldJlbkyZcXJZGAnh9wTdUFqkcnnRiffkY19HCTFeqWsaMNhioimpHR3qeJCqokk7ON
        jG2K+1hTzAK0Irv68VksDmRfb8+i7OA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-104-sv0_HsF2OaOmwFsoZGg6Tw-1; Mon, 22 Aug 2022 11:37:33 -0400
X-MC-Unique: sv0_HsF2OaOmwFsoZGg6Tw-1
Received: by mail-pg1-f200.google.com with SMTP id z22-20020a630a56000000b0041b98176de9so4908649pgk.15
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=OR0r/hyXZ2PC1LIRo6zlU9kEOJ14T8ubT9gvOTsTo74=;
        b=7NxPwdQ6gMdox1LRO0RMV/eyTIy5/JSZZM9LbSUoBVoqA7IbwF6QORLolHtGx8hC1h
         1jMzj5WffNFANcIIGtQS8WBtc1gkKvYEUAawzqI92758I1CrtpNN7ov6zOicy0TQOmqs
         Ahq08bkfhEeZyS8ggx9dFlTXxP0auoDTon53H3OZUbVFp4wpC7o6fBvD352a7yNDoQQ3
         5odaWF/umvjOPbRm5BzhnoaL3ns5nTm3Bl1SvKH0wkJITYJOEOar9664EtRDXfKal471
         5CKkdilp0/CVZRiVJuroZIXkijiFFAVN/Dp7fAGZMEwMvtl/ATGH04yK+bNXN4qa48+s
         Z3Ag==
X-Gm-Message-State: ACgBeo2WfL8WtlXVTHyPOVYS5ap0fkCGGWOXhVVQU80sDp2SFWuo247D
        8RWFb6ACfxM30GxFGi+a02GFOqmsxBY03/OWxDkbG89hVD0+VmIC3RnKGREUSf9wxpgAF/bXX7V
        hZn7eww4UbhZibPfE6PoI9P/m
X-Received: by 2002:a17:903:1248:b0:172:614b:234b with SMTP id u8-20020a170903124800b00172614b234bmr20958657plh.169.1661182652163;
        Mon, 22 Aug 2022 08:37:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR77/YgfYoTiAXy9cei6n6/IzT6KunvsJ3FhzcknN+tbDbrGWJdo/32EEL1ITjQ+hmNGeJDXMQ==
X-Received: by 2002:a17:903:1248:b0:172:614b:234b with SMTP id u8-20020a170903124800b00172614b234bmr20958645plh.169.1661182651913;
        Mon, 22 Aug 2022 08:37:31 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b0016a0bf0ce32sm8628503plg.70.2022.08.22.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:37:31 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        syzbot+616ff0452fec30f4dcfd@syzkaller.appspotmail.com,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] mm/gup.c: Fix return value for __gup_longterm_locked()
Date:   Tue, 23 Aug 2022 00:37:13 +0900
Message-Id: <20220822153713.962904-1-syoshida@redhat.com>
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
requested.

Fixes: 61c63c2076d9 (mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes)
CC: Alistair Popple <apopple@nvidia.com>
Reported-by: syzbot+616ff0452fec30f4dcfd@syzkaller.appspotmail.com
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 mm/gup.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 5aa7531a703b..66582203220a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2068,22 +2068,24 @@ static long __gup_longterm_locked(struct mm_struct *mm,
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
+		nr_pinned_pages =
+			__get_user_pages_locked(mm, start, nr_pages, pages,
+						vmas, NULL, gup_flags);
+		if (nr_pinned_pages <= 0)
 			break;
-		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
+		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages,
+						     gup_flags);
 	} while (rc == -EAGAIN);
 	memalloc_pin_restore(flags);
 
-	return rc ? rc : nr_pages;
+	return rc ? rc : nr_pinned_pages;
 }
 
 static bool is_valid_gup_flags(unsigned int gup_flags)
-- 
2.37.2

