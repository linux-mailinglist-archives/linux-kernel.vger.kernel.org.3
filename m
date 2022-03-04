Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0014CCC83
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 05:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbiCDEWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 23:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiCDEWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:22:10 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EAE180201
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 20:21:23 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id z7so6830436oid.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 20:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=59HE7Iz148pgiEGNqYTiUn+2VNuPsH2a4pfAoh50fLQ=;
        b=Zceh3p7g5dvRns9EOrhMZrsE0OdVe1veWOCjIdAPdMvc0c0xUc992FfdWS6Y8CVDQP
         qHTR946FWQERswWY+XSAqsOGhs0lM22wCxc7saIkMdkvfkXn90Sk5CCOOF3ZOW6qi/KF
         nIN9eIbBa4iTSQgiGqUcx1eSyZtzaODnr7Xm64pQW27aXp72DNH5DVchO+ccMqtzIJYd
         g6BV7+JkdsBFFyFzzi1TTtgI1ESvhwbkEsEZnzQO3GCnYgJPyyz4Qg0/Fo8sUlcfwMN4
         +I10ONcEY7Cwm2JZ4h5XclYSIpKXtgTCZsw3BsOcEuq1eD1GFiepHqTD9EgSpd42lzP0
         CLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=59HE7Iz148pgiEGNqYTiUn+2VNuPsH2a4pfAoh50fLQ=;
        b=PVPvfHLz8UjhaKC/DoCqFCRgRRuHRFBNZUrLUGk/qQpDxzP66SE5N5xuSAriE9+i5x
         yWm/FVws9vAUGNDuMaza4a8p+T1XNlbqenSVtQwvCkMJbTzgPEJQzDBg0Wh+coOTnXjo
         RTicpMUV7tVVKaIP0W1smvMyWmBbO2KoEJZt1kt+kx1honjvHDXcOgj7hUM/5tL9R3EJ
         tddLaUweHviXuiobGKsU3+wGJVUaOLnpDJ055G9eRTB19KwK1l2dE8O41uhmPk81MLVM
         oNRjiU0Qy8fdsYdjN2yoYeQ73ViU5c7+xMpDucvcF83Tzd/wAHZ1EM4mgLv41aIGwANC
         D71A==
X-Gm-Message-State: AOAM533Rrsmqz29I4AB4y5JZ4loi5AvFfpJgcLDeMYb2mbGvQZQcfjkg
        q7eFs7rsXXsGZCZ7mtle8Qhdmw==
X-Google-Smtp-Source: ABdhPJzkbTJQ5eBzE5wz9fR02Gp6652d3Oj4Br3VMGwkrGc0ZmE1pCNWUItGxSnPeXmVjpwwkmELjA==
X-Received: by 2002:a05:6808:1448:b0:2d7:dc0:c271 with SMTP id x8-20020a056808144800b002d70dc0c271mr7774402oiv.127.1646367681631;
        Thu, 03 Mar 2022 20:21:21 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t82-20020a4a3e55000000b0031847b47aaasm2005644oot.26.2022.03.03.20.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 20:21:20 -0800 (PST)
Date:   Thu, 3 Mar 2022 20:21:19 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm] mm: filemap_unaccount_folio() large skip mapcount
 fixup
Message-ID: <879c4426-4122-da9c-1a86-697f2c9a083@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page_mapcount_reset() when folio_mapped() while mapping_exiting()
was devised long before there were huge or compound pages in the cache.
It is still valid for small pages, but not at all clear what's right to
check and reset on large pages.  Just don't try when folio_test_large().

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/filemap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -152,25 +152,25 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 
 	VM_BUG_ON_FOLIO(folio_mapped(folio), folio);
 	if (!IS_ENABLED(CONFIG_DEBUG_VM) && unlikely(folio_mapped(folio))) {
-		int mapcount;
-
 		pr_alert("BUG: Bad page cache in process %s  pfn:%05lx\n",
 			 current->comm, folio_pfn(folio));
 		dump_page(&folio->page, "still mapped when deleted");
 		dump_stack();
 		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
-		mapcount = page_mapcount(&folio->page);
-		if (mapping_exiting(mapping) &&
-		    folio_ref_count(folio) >= mapcount + 2) {
-			/*
-			 * All vmas have already been torn down, so it's
-			 * a good bet that actually the folio is unmapped,
-			 * and we'd prefer not to leak it: if we're wrong,
-			 * some other bad page check should catch it later.
-			 */
-			page_mapcount_reset(&folio->page);
-			folio_ref_sub(folio, mapcount);
+		if (mapping_exiting(mapping) && !folio_test_large(folio)) {
+			int mapcount = page_mapcount(&folio->page);
+
+			if (folio_ref_count(folio) >= mapcount + 2) {
+				/*
+				 * All vmas have already been torn down, so it's
+				 * a good bet that actually the page is unmapped
+				 * and we'd rather not leak it: if we're wrong,
+				 * another bad page check should catch it later.
+				 */
+				page_mapcount_reset(&folio->page);
+				folio_ref_sub(folio, mapcount);
+			}
 		}
 	}
 
