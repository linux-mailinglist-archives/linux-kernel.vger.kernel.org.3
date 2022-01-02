Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7595D4828FB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 04:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiABDO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 22:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiABDO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 22:14:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C66AC061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 19:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0OmwI/HgqLi9ly/+dAStKB0Yb9UDWz94oKK0pUueTkQ=; b=Z8iBJeJBtEhr+G+YTd/IXdxJAn
        4h9/El+ribp4sc/Yt2MBKKJyz306Dw42IqYUonlalAcBL0tThv7vCYbL9QU1VDJl4/wRDJM/kBkqz
        mQqSM9zm9hCOKmqbv4ApISUXbSq4t9wqrUluVjd5SqgDBznu0324NLz4a7Upmu0HuwD458N6cKw2g
        neZp+dqGygdt36t7lo9nFOXwMBYXCtJrmOonPpx4VFSBC2UTAyqlfS/xa55LcMHXte+KZ0I5WGA2b
        qGCweK/LRmVxq6THClHNEHka+jI5am4BnVMvDVePXh9atJWjH8i+C/HqBcnw/10BQOkeM+J+Peb8y
        d5Q/LttA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n3rKE-007WJZ-5l; Sun, 02 Jan 2022 03:14:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] get_maintainer: don't remind about no git repo when --nogit is used
Date:   Sat,  1 Jan 2022 19:14:24 -0800
Message-Id: <20220102031424.3328-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When --nogit is used with scripts/get_maintainer.pl, the script
spews 4 lines of unnecessary information (noise). Do not print those
lines when --nogit is specified.

This change removes the printing of these 4 lines:

  ./scripts/get_maintainer.pl: No supported VCS found.  Add --nogit to options?
  Using a git repository produces better results.
  Try Linus Torvalds' latest git repository using:
  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 scripts/get_maintainer.pl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211224.orig/scripts/get_maintainer.pl
+++ linux-next-20211224/scripts/get_maintainer.pl
@@ -1718,7 +1718,7 @@ sub vcs_exists {
     %VCS_cmds = %VCS_cmds_hg;
     return 2 if eval $VCS_cmds{"available"};
     %VCS_cmds = ();
-    if (!$printed_novcs) {
+    if (!$printed_novcs && $email_git) {
 	warn("$P: No supported VCS found.  Add --nogit to options?\n");
 	warn("Using a git repository produces better results.\n");
 	warn("Try Linus Torvalds' latest git repository using:\n");
