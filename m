Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC824506162
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiDSAtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbiDSApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8E72B19F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB6D261452
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A36C36AE9;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=3FXQ32nSYAhkONYRR8LBpPari/rW5ikRtvS6E1okCoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkTirV9sFtf9VVLJ6cIZQctJ1H2M7H4swyK+3jGrzRiEIznh3PhULCAR0H3cwbV1E
         jXF4jhinu+h/LeCeFjGfn8riw1WdkiqGhv/8gAHuS/UA3XH6LrH0tRmgCA8vlBRgE0
         ai27XDluI7csc4/Hc4ZLh9GHiP3AQWoKfS8EHhsSFZyoOzbbbn84Z0pjt0qWst4c13
         wfkFloQZzbk0d8iACUH6FmKO/eZfiin9BIvs8LGadZ2kG1QH/lIvt6Ap6ClLcTF4A7
         JjHW2ROwzkSqmLIKoYqgWmVX72v9d7QPHfXju8mwWNpo0g764II8qT6aG8vPTGxoa2
         M0jk6XdXausXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 722175C04BD; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 58/61] tools/nolibc/types: Implement `offsetof()` and `container_of()` macro
Date:   Mon, 18 Apr 2022 17:42:22 -0700
Message-Id: <20220419004225.3952530-58-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
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

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Implement `offsetof()` and `container_of()` macro. The first use case
of these macros is for `malloc()`, `realloc()` and `free()`.

Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 357e60ad38a8..959997034e55 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -191,4 +191,15 @@ struct stat {
 #define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
 #define minor(dev) ((unsigned int)(((dev) & 0xff))
 
+#ifndef offsetof
+#define offsetof(TYPE, FIELD) ((size_t) &((TYPE *)0)->FIELD)
+#endif
+
+#ifndef container_of
+#define container_of(PTR, TYPE, FIELD) ({			\
+	__typeof__(((TYPE *)0)->FIELD) *__FIELD_PTR = (PTR);	\
+	(TYPE *)((char *) __FIELD_PTR - offsetof(TYPE, FIELD));	\
+})
+#endif
+
 #endif /* _NOLIBC_TYPES_H */
-- 
2.31.1.189.g2e36527f23

