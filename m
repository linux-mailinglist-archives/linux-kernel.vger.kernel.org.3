Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C504EE362
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiCaVmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiCaVmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:42:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C03739BB1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:40:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j15so1955577eje.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHeTV9nlew+zdF4qfMtmQQMfu78a49iEbGVCAm73+DQ=;
        b=kRsbbpuuwTewhtz1QifpoRvQvRBPsmWiLhikt3ZKkMZUsUBnwgJkOXsGaLb2f8qP0r
         qw0jGGrcQOooj4Suiw6JAqY/VctH9UXCrRFBLO4LtFPTVDfk/sXGgyuYe5MtAGafkeMD
         UnC9eJvI+n6J5X+Whjv2HJtNIofeHNLLbgfI4vaXmXSXtbOo+/SMCTUslVc1Ol3GpU9X
         cvbK6nPK4aIlH1B99BQSIT+HnceRLFH5Jbj/uNLXP8ArkXquoJVSita5tlyFnRSW4N6P
         Jv+VxnJMgxzo1UuvJtH66eihII4xe58lB2blryS/JF4DOrH52TaRKVEQXqg2I8pn6E9P
         P7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHeTV9nlew+zdF4qfMtmQQMfu78a49iEbGVCAm73+DQ=;
        b=SvfdU1vhZh6ZrP+MjIGuAqomrMa8uxhIdOiP/M/pRX5DbWW+IkUFaCikMbu977uEGJ
         Jxk9We53DzR/YS3skWaGTYDZX1oahzaURMErShNV49B69eMD8IOC6ZlVK2bN0CB/SusI
         nedbg64mek188LcjTr5/LZK/bQAbqm/qrvO/aezIzAyjAnSqu+sOueLl/3n/3AwSwrEY
         q66S7VEyC4d0ZyunnumeaQrEzd1fwyY6E69Jsxbkufu+mCTJCC0U3zc3+JQHVTMRqIRm
         G96alRYEgzPs+tCRfxx8kTS27GeBU+aAXUCYTEhb3pZzJpMLoOc6VI9kxmyX1outbQyE
         96kQ==
X-Gm-Message-State: AOAM533McFhzsOg+PD8cl8ZEPSectSxmcrI0afVGh+SN9QJ1ZmGnvX0q
        yNL245o7m7FwlCwXs5n0/tI=
X-Google-Smtp-Source: ABdhPJyHVWw0EGsvcvPjvSfhYyt7ZGjlm757pMfUQct/5z0cC/FrJ+XayYKDWu6oaXaoRAq+vaothg==
X-Received: by 2002:a17:906:7944:b0:6da:b834:2f3e with SMTP id l4-20020a170906794400b006dab8342f3emr6875403ejo.353.1648762846868;
        Thu, 31 Mar 2022 14:40:46 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm280092edb.14.2022.03.31.14.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:40:46 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] staging: android: ashmem: remove usage of list iterator after the loop body
Date:   Thu, 31 Mar 2022 23:39:34 +0200
Message-Id: <20220331213934.866804-1-jakobkoschel@gmail.com>
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

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element
[1].

Before, the code implicitly used the head when no element was found
when using &pos->list. Since the new variable is only set if an
element was found, the head needs to be used explicitly if the
variable is NULL.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/staging/android/ashmem.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index ddbde3f8430e..a1e245827cf6 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -703,30 +703,33 @@ static int ashmem_pin(struct ashmem_area *asma, size_t pgstart, size_t pgend,
 static int ashmem_unpin(struct ashmem_area *asma, size_t pgstart, size_t pgend,
 			struct ashmem_range **new_range)
 {
-	struct ashmem_range *range, *next;
+	struct ashmem_range *range = NULL, *iter, *next;
 	unsigned int purged = ASHMEM_NOT_PURGED;
 
 restart:
-	list_for_each_entry_safe(range, next, &asma->unpinned_list, unpinned) {
+	list_for_each_entry_safe(iter, next, &asma->unpinned_list, unpinned) {
 		/* short circuit: this is our insertion point */
-		if (range_before_page(range, pgstart))
+		if (range_before_page(iter, pgstart)) {
+			range = iter;
 			break;
+		}
 
 		/*
 		 * The user can ask us to unpin pages that are already entirely
 		 * or partially pinned. We handle those two cases here.
 		 */
-		if (page_range_subsumed_by_range(range, pgstart, pgend))
+		if (page_range_subsumed_by_range(iter, pgstart, pgend))
 			return 0;
-		if (page_range_in_range(range, pgstart, pgend)) {
-			pgstart = min(range->pgstart, pgstart);
-			pgend = max(range->pgend, pgend);
-			purged |= range->purged;
-			range_del(range);
+		if (page_range_in_range(iter, pgstart, pgend)) {
+			pgstart = min(iter->pgstart, pgstart);
+			pgend = max(iter->pgend, pgend);
+			purged |= iter->purged;
+			range_del(iter);
 			goto restart;
 		}
 	}
 
+	range = list_prepare_entry(range, &asma->unpinned_list, unpinned);
 	range_alloc(asma, range, purged, pgstart, pgend, new_range);
 	return 0;
 }

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

