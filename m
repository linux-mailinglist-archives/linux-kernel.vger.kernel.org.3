Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC69B51ECD0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiEHKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiEHKKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:10:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0302BC3C
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 03:06:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so14596084pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkaLJePYyPZfYRnE3vYCNwqas5gjiv8Fw2OTZAyZSTU=;
        b=WyRe45IjI4f7k6v9TOHqVw+/3gvH37e+n/6jtuTD30lMBZ8Lj6OToL+ClmBk7s2XXH
         rwaCEMVIz6Xlt2wlQ/dey0Lj77pKID/cQLRNvmqeqUknFOZSy0t/oSclgaTLZZTNV5NL
         k8zSH1wwhuxopco7Uhaj0GCZ8lx17bPFjnzeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkaLJePYyPZfYRnE3vYCNwqas5gjiv8Fw2OTZAyZSTU=;
        b=L6nwbyUSXn3ZzF45jw70fEYCb/Ot63xUlS8lXx1DDI1hm25f2TMahu4II35ayG29xb
         iImMUuWrbUwly/2oCsN0J30lcj7X7ZE98XVwU6IjZoOmyshCbIx7PRtJPWxOL2lIBHZx
         jSjeyLLdHaX6TcTZvw+i8IO4ig3HSVLpmljftHQdnCoskVH76IWW2qyGtT2c03PwuKfD
         N9sn+5wE83nSCVqmNjSYWWlE9ihf+06ngD7wph5rAzwEizC8EcV6mFNVj8GAXyVd8CRh
         W9y0JK2ppef+pwq1pq5y+h07eWyHdJxrlOk76XBn0GvUX+1iROzDX+xzc98GdfH2Z622
         bhGw==
X-Gm-Message-State: AOAM530hirGc0Jp7yhhqIAa4rds8xP5AyNXYPNEeaBb9aTCGz5CIvhVW
        dOpHBr3Ecl0RdO0p6fXjgx5xTA==
X-Google-Smtp-Source: ABdhPJyVC/VMs0K9YmHuiLbSJVevGigliNxeL4wfFf6BuBdcmtu/fPeGr/6rs+1qLq23kmj0WhKSsg==
X-Received: by 2002:a17:90b:11d1:b0:1db:d99f:62cc with SMTP id gv17-20020a17090b11d100b001dbd99f62ccmr12962161pjb.200.1652004394407;
        Sun, 08 May 2022 03:06:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 67-20020a621946000000b0050dc7628190sm6473067pfz.106.2022.05.08.03.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:06:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bill Wendling <morbo@google.com>, cluster-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: Use container_of() for gfs2_glock(aspace)
Date:   Sun,  8 May 2022 03:06:30 -0700
Message-Id: <20220508100630.2642320-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3735; h=from:subject; bh=FOaCbdpPkuASD3dMupI7kZh1ObuZvCfUVlaQempQE5I=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBid5YmhjmmxY4dlNl3Yg00NpZgETPyQkRbBwdZZYsZ P/YqH4GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYneWJgAKCRCJcvTf3G3AJnvUD/ 0QrCOlhMPuCLn6t5gkSWTHClT8iEbrktkDASTiiV9NsCddMjoYH7HzpwhZS1cTgRUJaJyffjkcT8kU ziPsb6jJXrbAGDqoW3ugGOeX8cbpOhxXBRzg1mHvuMS7+bOQBCNYry34jICEZca/3snx0fQ65kwZxl PQnUxShhB2TdYgdQhK1Zn4jwQ4yeR0FIVjR3ms9B4l39dOtWi1DUt2xXReRs0/H9Ith/1QQ8+2qojU 7WE/58EjmKoCh0V6/cNFvouoquNbHEPhf0LCjwv32LZZrRSfKrf6xPUxzwxN8OKOIJx3FAKEzPtn0i I3M1o9eKi5E/Di5xUvtA8fkAOrCmORx24xW/ZAWCdPDwPdWnItsqYDR3Kl6fkaN920ayI4zjdnTI/Z iJ16yYT2S/2+WtcJI6oRa1w2DlMMaJijb/QYwVAY2KNDTG21AqtBECuFYBB5AHQBa5MHGCwgQqmU8m 2ckadWoQmueMRVYCO8D2qHX0hzd70qNzBEeczpzF+x1iDJg26KEXeTyy4E+Q+PxlpgidQmBuXJVxeI Q7lnrSpF/n+BdGb2znvvZ9JArWh2YMC+31Gb+e+sVts9B8BYC+I+oEaQeLytqjNmH+iOAswRro6inj 7wAnH6a95h57dIG+qx7dii0hb6Uf38DdRebsVdKBYCGqhPrPj3f3qUqSsyNw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang's structure layout randomization feature gets upset when it sees
struct address_space (which is randomized) cast to struct gfs2_glock.
This is due to seeing the mapping pointer as being treated as an array
of gfs2_glock, rather than "something else, before struct address_space":

In file included from fs/gfs2/acl.c:23:
fs/gfs2/meta_io.h:44:12: error: casting from randomized structure pointer type 'struct address_space *' to 'struct gfs2_glock *'
	return (((struct gfs2_glock *)mapping) - 1)->gl_name.ln_sbd;
		^

Replace the instances of open-coded pointer math with container_of()
usage, and update the allocator to match.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202205041550.naKxwCBj-lkp@intel.com
Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Bill Wendling <morbo@google.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This another fix uncovered by the Clang randstruct series[1], so it'd
probably make more sense to land via my tree. Do you have a preference?
[1] https://lore.kernel.org/all/20220503205503.3054173-1-keescook@chromium.org/
---
 fs/gfs2/glock.h   |  8 +++++++-
 fs/gfs2/main.c    | 10 ++++------
 fs/gfs2/meta_io.h |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 4f8642301801..2607c7d26640 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -138,6 +138,12 @@ struct lm_lockops {
 	const match_table_t *lm_tokens;
 };
 
+/* gfs2_glock_get(), "glock" must be first. */
+struct glock_aspace {
+	struct gfs2_glock	glock;
+	struct address_space	mapping;
+};
+
 extern struct workqueue_struct *gfs2_delete_workqueue;
 static inline struct gfs2_holder *gfs2_glock_is_locked_by_me(struct gfs2_glock *gl)
 {
@@ -180,7 +186,7 @@ static inline int gfs2_glock_is_held_shrd(struct gfs2_glock *gl)
 static inline struct address_space *gfs2_glock2aspace(struct gfs2_glock *gl)
 {
 	if (gl->gl_ops->go_flags & GLOF_ASPACE)
-		return (struct address_space *)(gl + 1);
+		return &(container_of(gl, struct glock_aspace, glock)->mapping);
 	return NULL;
 }
 
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 28d0eb23e18e..984bd60d01db 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -62,11 +62,10 @@ static void gfs2_init_glock_once(void *foo)
 
 static void gfs2_init_gl_aspace_once(void *foo)
 {
-	struct gfs2_glock *gl = foo;
-	struct address_space *mapping = (struct address_space *)(gl + 1);
+	struct glock_aspace *gl_aspace = foo;
 
-	gfs2_init_glock_once(gl);
-	address_space_init_once(mapping);
+	gfs2_init_glock_once(&gl_aspace->glock);
+	address_space_init_once(&gl_aspace->mapping);
 }
 
 /**
@@ -104,8 +103,7 @@ static int __init init_gfs2_fs(void)
 		goto fail_cachep1;
 
 	gfs2_glock_aspace_cachep = kmem_cache_create("gfs2_glock(aspace)",
-					sizeof(struct gfs2_glock) +
-					sizeof(struct address_space),
+					sizeof(struct glock_aspace),
 					0, 0, gfs2_init_gl_aspace_once);
 
 	if (!gfs2_glock_aspace_cachep)
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index 21880d72081a..2e2f88cfb7ad 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -41,7 +41,7 @@ static inline struct gfs2_sbd *gfs2_mapping2sbd(struct address_space *mapping)
 {
 	struct inode *inode = mapping->host;
 	if (mapping->a_ops == &gfs2_meta_aops)
-		return (((struct gfs2_glock *)mapping) - 1)->gl_name.ln_sbd;
+		return container_of(mapping, struct glock_aspace, mapping)->glock.gl_name.ln_sbd;
 	else if (mapping->a_ops == &gfs2_rgrp_aops)
 		return container_of(mapping, struct gfs2_sbd, sd_aspace);
 	else
-- 
2.32.0

