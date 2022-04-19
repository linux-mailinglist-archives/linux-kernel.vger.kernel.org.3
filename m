Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288CC50614F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243576AbiDSAtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbiDSApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEA72B274
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB7461451
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6293C341DC;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=RMoOOCvJ8rLf5lBVaGtdRjQy1T5xU64LW3gZnf1N1as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qb4C/d1MSznH1auHolIXZyhNJC0rZXdAzzMNgRy3VuSAlwCT4yCpR7xUgoAfLM9Kv
         R/M4vpaiMEGToe8SpOLU3g0teBD+YokoupkjXoxSUUezHMFJaDqpR14bPSuJhhGqaa
         4iR73xWKL482NjTDPCGUSI7d+1mdLuK98lhHLgLCgYbll6y/ssCviqenRAroLaCNaK
         b07kovPKck4fMBCF+tAvWU5wQilzNY1dZcpYUE/D9z8xOmyN3h5vNEjrXef+W83Tp2
         yAoF/H1AQHJEsEp3P5m0FftcGQdePr64sFO3/UluInJiq7e9/ebt07OU9Ovaftws+l
         jx9xb6wyN2gnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 75E1D5C3248; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 60/61] tools/nolibc/string: Implement `strnlen()`
Date:   Mon, 18 Apr 2022 17:42:24 -0700
Message-Id: <20220419004225.3952530-60-paulmck@kernel.org>
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

  size_t strnlen(const char *str, size_t maxlen);

The strnlen() function returns the number of bytes in the string
pointed to by sstr, excluding the terminating null byte ('\0'), but at
most maxlen. In doing this, strnlen() looks only at the first maxlen
characters in the string pointed to by str and never beyond str[maxlen-1].

The first use case of this function is for determining the memory
allocation size in the strndup() function.

Link: https://lore.kernel.org/lkml/CAOG64qMpEMh+EkOfjNdAoueC+uQyT2Uv3689_sOr37-JxdJf4g@mail.gmail.com
Suggested-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/string.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 75a453870498..f43d52a44d09 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -147,6 +147,15 @@ size_t nolibc_strlen(const char *str)
 #define strlen(str) nolibc_strlen((str))
 #endif
 
+static __attribute__((unused))
+size_t strnlen(const char *str, size_t maxlen)
+{
+	size_t len;
+
+	for (len = 0; (len < maxlen) && str[len]; len++);
+	return len;
+}
+
 static __attribute__((unused))
 size_t strlcat(char *dst, const char *src, size_t size)
 {
-- 
2.31.1.189.g2e36527f23

