Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9166B5AB18C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiIBNg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbiIBNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAC579EED
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83E6F61F4F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B5BC433C1;
        Fri,  2 Sep 2022 12:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662123405;
        bh=HGl9Pb/xwY2wEwqJGiEKgOcUViCJqmT47gVsSgc8WXA=;
        h=From:To:Cc:Subject:Date:From;
        b=nsvDjFmOlgGYDfmS3pJhN5oHEGDJHFBDEfjiU9rM0rwL9WhCHWyXpsohTna4AnIHX
         OVsvYJTHZYWnO+dqUZ+UioiveqF0OTqmEBJeRNCfpwCeRE/VnSkHYYR3TNpNB1zicb
         OLoOoVw/8yXI5qbgYmWz/yVfQBT9n0HMmFrkMy6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        stable <stable@kernel.org>
Subject: [PATCH] mm/damon/dbgfs: fix memory leak when using debugfs_lookup()
Date:   Fri,  2 Sep 2022 14:56:31 +0200
Message-Id: <20220902125631.128329-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=771; i=gregkh@linuxfoundation.org; h=from:subject; bh=HGl9Pb/xwY2wEwqJGiEKgOcUViCJqmT47gVsSgc8WXA=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmCf2uuON1Zwc1X3R7CsCxz7eJ1cyTj560+/KuG8eUeCc8o D/2AjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIshbDbJbDjyybpHnPOFx+7cl/q/ mbpPWdSoZ5FheXHOx//unz9s8cjbJS5uedbwVsBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
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

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  Fix this up by properly
calling dput().

Cc: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev
Cc: linux-mm@kvack.org
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/dbgfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index cb8a7e9926a4..dfb6ef8c83e0 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -915,6 +915,7 @@ static int dbgfs_rm_context(char *name)
 		new_ctxs[j++] = dbgfs_ctxs[i];
 	}
 
+	dput(dir);
 	kfree(dbgfs_dirs);
 	kfree(dbgfs_ctxs);
 
-- 
2.37.3

