Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B755282C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347514AbiFTXSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347131AbiFTXRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CABC22523;
        Mon, 20 Jun 2022 16:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE680614FB;
        Mon, 20 Jun 2022 23:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33909C341C5;
        Mon, 20 Jun 2022 23:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766810;
        bh=1Srkx65V0c9fIsN8Z0dMTBAwhSk2DBTXR07RMoGi6c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dq2ZBHdfTiwpVgxDlLftqae43xY/guqf/ZId2SSTTmCVujCRb4I/S7+GrshWoUVzh
         6whwK6x/wNXmcXtC+GV5i57GpmUpyJd4O/yFN2TfrEWWMqbNXlHWlWAPqhqZXw2kki
         ASSCpnRW+9DNkYYZEL4ypv+wuMV9EyA+JwkrPc1OhwQsoj6pAWSmxQhRrCqF6OY9+y
         fo/4yxLbl70olO2g895b60j7zi8y/eJzDJi/WyhweTueQa3Hrh8BIG8AicwaBx0JmS
         K5tZUVS4u69Mc6C+P/tpYvohOsbTd4JRHRamFKzQlOXQFV9vgg56LvVJ6VCanY3sZC
         WTAQuYgFGKySg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E18295C0A33; Mon, 20 Jun 2022 16:13:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/5] tools/nolibc: make the default target build the headers
Date:   Mon, 20 Jun 2022 16:13:27 -0700
Message-Id: <20220620231328.3845126-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231325.GA3845036@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231325.GA3845036@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

The help in "make -C tools" enumerates nolibc as a valid target so we
must at least make it do something. Let's make it do the equivalent
of "make headers" in that it will prepare a sysroot with the arch's
headers, but will not install the kernel's headers. This is the
minimum some tools will need when built with a full-blown toolchain
anyway.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/Makefile                | 3 +++
 tools/include/nolibc/Makefile | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/Makefile b/tools/Makefile
index c074e42fd92f5..e497875fc7e3f 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -78,6 +78,9 @@ bpf/%: FORCE
 libapi: FORCE
 	$(call descend,lib/api)
 
+nolibc: FORCE
+	$(call descend,include/nolibc)
+
 nolibc_%: FORCE
 	$(call descend,include/nolibc,$(patsubst nolibc_%,%,$@))
 
diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index e8bac6ef36538..9768819abd55d 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -29,7 +29,7 @@ all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
              sys.h time.h types.h unistd.h
 
 # install all headers needed to support a bare-metal compiler
-all:
+all: headers
 
 # Note: when ARCH is "x86" we concatenate both x86_64 and i386
 headers:
-- 
2.31.1.189.g2e36527f23

