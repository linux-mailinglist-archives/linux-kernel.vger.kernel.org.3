Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304365A8579
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiHaS0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiHaSZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639DFBA5C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C4C2B82275
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B220C433B5;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=nNEzh9yptkWyGVGTNGnwj/QZ/DlDOZpEjF3yTgBo8vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMnDNVNxWh37xzFyn2SrR0BhE+uv0Vc4Uxki6au7y/gH1lspujGeOBnLqPIzK1Jjv
         Dn4GMm6dYqHJCxUTvZS18tUBCUADxMVrtUqAoUQVGIBIZCHCVfrC1Cm81W8DbmEfih
         7ohz0ZrsCMYtcEY+WOuKhuKejvuGE0UqKynP+UctXusRUOsrFFBBsUjvaHCx3sVaXO
         o6I1mg1hRT7AltbA2/V8HUYVqhA13YOTsPrqASjCsqPfv0bfG75h8VPah12kFJ/idP
         +pAoeCaiwkeaDQMhiPzCkoQmy2jsPOcY2AbXNC2p0j0R63EXbF0WpO8dXQIcmMvK76
         m1sFC6vRoVjcw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D712E5C06A7; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 03/18] tools/nolibc: make sys_mmap() automatically use the right __NR_mmap definition
Date:   Wed, 31 Aug 2022 11:21:33 -0700
Message-Id: <20220831182148.2698489-5-paulmck@kernel.org>
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

__NR_mmap2 was used for i386 but it's also needed for other archs such
as RISCV32 or ARM. Let's decide to use it based on the __NR_mmap2
definition as it's not defined on other archs.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b8c96878c9ce0..ce3ee03aa6794 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -697,7 +697,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 
 	int n;
 
-#if defined(__i386__)
+#if defined(__NR_mmap2)
 	n = __NR_mmap2;
 	offset >>= 12;
 #else
-- 
2.31.1.189.g2e36527f23

