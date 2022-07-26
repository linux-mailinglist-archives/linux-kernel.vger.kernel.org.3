Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25976581C37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiGZXCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGZXCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:02:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4332EE2E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:02:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31edbd801b5so70659407b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=v35GRn0zvDL2zuEbUqMrLtilXAspyGM63ZeEqZ8QDmg=;
        b=OP77iKXmrLhzVFTPiPrlUacZaykc4RXyHfK0/vzLj7Bp94V3TPkG7/YQwQ+7twgLRG
         HSBXTY9RLK7j+2RjEHFyb1yzZ4i+ahyx1CSpKk17D9r1ncp3Kxdg3gKDMa/pKUbyvKxh
         EV5bm2LTT0y/gkvgDbUJ2mZwNGIRZ65sb/XWBmFaM6nF9bbDQx8DxvLZ4ApYccS65OcE
         szfaxpHjgvQeGpiqylZsA67Pi4AtObGZLnSigHp1lQuNUlBpYXwKRMCEsU2dma9u14QB
         Z5mylSMkQEk+secy2tv5tw5BRvqqXUUEyTl1OPFp8sLLBpKOjptyOfad0wjqxWW6ZihI
         JveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=v35GRn0zvDL2zuEbUqMrLtilXAspyGM63ZeEqZ8QDmg=;
        b=GpIfltm5DR4gFJWN6ftZamJJkitckLvoJZ3rjC9Kyr+UDIaHui2aWs8PDRlSzwWVuX
         xCxzfIFaBa02aNDTUPbDG2tYxTUXYVBJTAqnA0yW6vi1geh9BBQJP4SAc7BilQ0M1Mk1
         vW8g75kVjVFUxoJiDwnyfsXZ8iYArJZzNMnJsgoWNqexzSvw/vPVBcgSj6XEjxuU36+F
         tqLL+x35qY6TlWvZuqUTO2+auX/TP6Srzbd8HEhW4BIaw5NSfqVi08OS/viohR8g2k/5
         JR9jPODsq6MwOmRcdcCPcWWrhcTLk/3nP9a4eYSEUpQtX7Eqv8c5uUdP5PccPsqtTHi2
         /1iw==
X-Gm-Message-State: AJIora9QA5OKzoQOsTMrKlNYM0J48tSD5vqed2btiy7UOAvyyolDkHeP
        CtgeeGYnIFBhDyX48zYfSrC7qqs=
X-Google-Smtp-Source: AGRyM1u4ckeiReh6RjmBWmrb1wYImuRfgb5zE0QMfvVb8w9SNwArNn6S4Byn0t5cUuOSglUqai2vvIk=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:2e88:92fc:be22:6bb1])
 (user=pcc job=sendgmr) by 2002:a81:8746:0:b0:31d:c5a6:ad8f with SMTP id
 x67-20020a818746000000b0031dc5a6ad8fmr17064868ywf.206.1658876568946; Tue, 26
 Jul 2022 16:02:48 -0700 (PDT)
Date:   Tue, 26 Jul 2022 16:02:41 -0700
Message-Id: <20220726230241.3770532-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH] mm: add more BUILD_BUG_ONs to gfp_migratetype()
From:   Peter Collingbourne <pcc@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gfp_migratetype() also expects GFP_RECLAIMABLE and
GFP_MOVABLE|GFP_RECLAIMABLE to be shiftable into MIGRATE_* enum values,
so add some more BUILD_BUG_ONs to reflect this assumption.

Link: https://linux-review.googlesource.com/id/Iae64e2182f75c3aca776a486b71a72571d66d83e
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 include/linux/gfp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index f314be58fa77..ea6cb9399152 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -18,6 +18,9 @@ static inline int gfp_migratetype(const gfp_t gfp_flags)
 	VM_WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
 	BUILD_BUG_ON((1UL << GFP_MOVABLE_SHIFT) != ___GFP_MOVABLE);
 	BUILD_BUG_ON((___GFP_MOVABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_MOVABLE);
+	BUILD_BUG_ON((___GFP_RECLAIMABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_RECLAIMABLE);
+	BUILD_BUG_ON(((___GFP_MOVABLE | ___GFP_RECLAIMABLE) >>
+		      GFP_MOVABLE_SHIFT) != MIGRATE_HIGHATOMIC);
 
 	if (unlikely(page_group_by_mobility_disabled))
 		return MIGRATE_UNMOVABLE;
-- 
2.37.1.455.g008518b4e5-goog

