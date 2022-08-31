Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D0B5A857F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiHaS0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiHaSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58FEEF002
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D79FA61CD9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D992C4347C;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=9uoF+g4LweCmuA8kE2/a+fIZkh1WmvOLh306TOxum+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5TO/DIxTSPXgs2wk9pcL/8e82ok9w0UGdRmWpKKHvk6mWQl/toUj7HeeJ7XRjv4q
         8Kyd3RpRGsoLgjIhI+ezj6x80BsVInfsTo8UJEuZDNrKpj+B2fRZEFM7uDRNRyDJLY
         iXKve3NiNrTPfIGtCWlgcKGcyOgijYkQmYeOx2o9M7v3A49taA3D0Kc06Km5C6WVU1
         qRSaQcYB4m6fiHNVD4ZDjaj3ZiBDw+7NGVCFY5Pez89s33zZH9RGNdk0V8YebyJEDh
         AJ6u97Y1b1xFJ9xaGjZJi25g/g8s3BOt+O6h/yuaz4jXZiMxIsPuTF7UauCCAyjmgu
         XlcLvCKkKg5kw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D53CE5C0513; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 02/18] tools/nolibc: fix build warning in sys_mmap() when my_syscall6 is not defined
Date:   Wed, 31 Aug 2022 11:21:32 -0700
Message-Id: <20220831182148.2698489-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
References: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
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

From: Willy Tarreau <w@1wt.eu>

We return -ENOSYS when there's no syscall6() operation, but we must cast
it to void* to avoid a warning.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 08491070387bc..b8c96878c9ce0 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -692,7 +692,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 {
 #ifndef my_syscall6
 	/* Function not implemented. */
-	return -ENOSYS;
+	return (void *)-ENOSYS;
 #else
 
 	int n;
-- 
2.31.1.189.g2e36527f23

