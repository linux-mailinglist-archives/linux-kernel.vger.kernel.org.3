Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485914E3CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiCVKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiCVKwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:52:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C5F811AB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:50:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r23so21219579edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYTrYht6AUVnHXQusTG11+67vE+GSz/eL3E7YG6g+Pw=;
        b=ANKaLn6pxoQ7ntAGRfscx+nhCUuIQg6KGgHc2SLz7Nw9rUbFNwcBqrrTqoF/VBnJcs
         8Wz6ufDb9jeQ9sNpCa5Nr8MhwBeMGvmMPk2aFVRKaPNVj4E5Vm+m/Wg9NjHvlVoK/Hk5
         f/O+f44s2o9PE3kWaZTYJWCb7oy0ZasIcJYhtS95dmdVshVkdRphmeSdvWLPn3f0TWp4
         IvFu0B+FeH5Mt74hp7eoeRs3uo9jUeMaB4NF1HzaGVXiEs+q4KEV6GKuf7TqRwhsvelg
         IY2pXwWgLE8MrzcciduF87125OQ29cHzLMy9G/M5gE6/jSwtl8LjqZHPAWiqSDGokhmK
         dQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYTrYht6AUVnHXQusTG11+67vE+GSz/eL3E7YG6g+Pw=;
        b=WK7T51Q8tY3YgJF4E4FSZ+QNQKq9+qT4uWX4dAEE3UyxssXT0Z059hpCOYC/UEOL4c
         t9e2ukSzNxTtN+8L3ag6HIx0oUjnCiUT1IUbgZs+begQJr1K6pth9pZXJPSyclpqBqzg
         8NfoSaVQOOYS19iWiFogyNYLRfLVtEzdUTrUSu0dY+KaWJSMRBk8YLdaPv4j4Dy4i3Vf
         htqKhmdy/iGU+xxll8K5CPwpOwc3tX54f62fR9BZDnBlc07sj/RXZE+GdsBa6HGW0V24
         ZhdBH0aXo+LitYa+4HUBaOWJGbTpp3mSHnJE2wMva3iPIRYSknynbkChwZp06sqLzlSv
         Ng/w==
X-Gm-Message-State: AOAM533dMaeNAIEJTicIpYdAp/qKPyjSddn/HbqJ8DNb47GwMVuyYa5T
        ARI7tgATHEBUAiCH8qos+gg=
X-Google-Smtp-Source: ABdhPJyEZZAgxNy2fD1bE8J9IveKSflMCMIFwxeBJptbSFj6LuDNtRfI8Wb4aBiasqcTiCr3z2aJRw==
X-Received: by 2002:a05:6402:cac:b0:410:a920:4e90 with SMTP id cn12-20020a0564020cac00b00410a9204e90mr27660444edb.60.1647946241469;
        Tue, 22 Mar 2022 03:50:41 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id e6-20020a056402190600b00413d03ac4a2sm7419629edz.69.2022.03.22.03.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:50:41 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH v2] ocfs2: remove usage of list iterator variable after the loop body
Date:   Tue, 22 Mar 2022 11:50:14 +0100
Message-Id: <20220322105014.3626194-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/ocfs2/dlm/dlmdebug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index d442cf5dda8a..be5e9ed7da8d 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -541,7 +541,7 @@ static void *lockres_seq_start(struct seq_file *m, loff_t *pos)
 	struct debug_lockres *dl = m->private;
 	struct dlm_ctxt *dlm = dl->dl_ctxt;
 	struct dlm_lock_resource *oldres = dl->dl_res;
-	struct dlm_lock_resource *res = NULL;
+	struct dlm_lock_resource *res = NULL, *iter;
 	struct list_head *track_list;
 
 	spin_lock(&dlm->track_lock);
@@ -556,11 +556,11 @@ static void *lockres_seq_start(struct seq_file *m, loff_t *pos)
 		}
 	}
 
-	list_for_each_entry(res, track_list, tracking) {
-		if (&res->tracking == &dlm->tracking_list)
-			res = NULL;
-		else
-			dlm_lockres_get(res);
+	list_for_each_entry(iter, track_list, tracking) {
+		if (&iter->tracking != &dlm->tracking_list) {
+			dlm_lockres_get(iter);
+			res = iter;
+		}
 		break;
 	}
 	spin_unlock(&dlm->track_lock);

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

