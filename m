Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71C359E9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiHWRpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiHWRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:44:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A4E6B8D8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:32:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D695FB81E07
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0870AC433D6;
        Tue, 23 Aug 2022 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661268723;
        bh=kv7ZNDv1FBguuVmkE95CjI4JtqYhHJBmXuAD/LbhowE=;
        h=From:To:Cc:Subject:Date:From;
        b=lobSX5e6t4xjH5/Am6fGj9FTN7qbOtqS8ZtVc0h1dp4mZoJSzj0Mxq9yx2ugCllno
         xKQSzJzK555RV247wINMtB4xxRKfX7zz8EDFdUp7CGSJbgie6ljkBvpypjs8MJzdPq
         q3GdOx+3EaFaTFK7t19ORqo0uShAxluFSlyXktTyC4xieZYigLgrYzhUgY3xwW2Kae
         0Rpsn04UI7bOEjiQqL2xbBJhRSrKyTmlEo1p9/krFguIgY3UMDs1lNE2EIC4IEhEF+
         GwpJA6wWSvXow0CX3SS/AClKr9eQneE9QLY89H+ojUJuqH+05JsoCORV74M1a08AjZ
         zBl4bgT0sh1PQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Rolf Eike Beer <eb@emlix.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH -next] mm: pagewalk: Restore err initialization in walk_hugetlb_range()
Date:   Tue, 23 Aug 2022 08:30:56 -0700
Message-Id: <20220823153055.2517764-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  mm/pagewalk.c:318:12: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                  else if (ops->pte_hole)
                          ^~~~~~~~~~~~~
  mm/pagewalk.c:321:7: note: uninitialized use occurs here
                  if (err)
                      ^~~
  mm/pagewalk.c:318:8: note: remove the 'if' if its condition is always true
                  else if (ops->pte_hole)
                      ^~~~~~~~~~~~~~~~~~
  mm/pagewalk.c:311:10: note: initialize the variable 'err' to silence this warning
                  int err;
                        ^
                          = 0
  1 error generated.

Restore the initialization of err to zero so that it cannot be used
uninitialized.

Fixes: 9ce1db56225a ("mm: pagewalk: make error checks more obvious")
Link: https://github.com/ClangBuiltLinux/linux/issues/1694
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

I am sure that SHA is not stable and I expect this to be squashed into
the original change.

 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 54b2a1beeeb3..76e5ccda8c88 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -308,7 +308,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 
 	for (; addr < end; addr = next) {
-		int err;
+		int err = 0;
 		pte_t *pte = huge_pte_offset(walk->mm, addr & hmask, sz);
 
 		next = hugetlb_entry_end(h, addr, end);

base-commit: d711de4adbec4cb0b8769bcae971b13293e6d311
-- 
2.37.2

