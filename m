Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB9C506103
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbiDSAq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241209AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05BF2315B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22037B81148
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BFEC385C8;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=Rr5DHLrOuEqdBkc+qgPwuN4SXQHozI5fyVdTHY9LHDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qt51eV+qPXPHyl4qfKIJSHjfhhn6gVODPCgpDVcwt/5XaCnFGRiuwwLf1tyN8QKrb
         4owRFhCPLsLxtEBM9Cl/kQrov++qve2aukq7fFgasZMenfZcgnQkXvYIilkpokPcb7
         z0wWH16wiPquGHtVZvDTzipE6z+/RXYcwZ5hpyctErqh+Q6sfpAd4JsdHb3xHaFhkR
         JwkCqWRxt0vlU/hjQE3VVKk+wQVTcpuajem3NnfpgN3wrIQKXZj6QlPGuDPxYV9nXO
         PRDlJy+k4CppLkuYFOd7A4k8gDDEeCnUXyS7OR5AFexQICfy4I8c+ZvV4WuW7IYoOl
         iv1dSS4r4gdww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 36E745C30FC; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 26/61] tools/nolibc/stdlib: make raise() use the lower level syscalls only
Date:   Mon, 18 Apr 2022 17:41:50 -0700
Message-Id: <20220419004225.3952530-26-paulmck@kernel.org>
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

From: Willy Tarreau <w@1wt.eu>

raise() doesn't set errno, so there's no point calling kill(), better
call sys_kill(), which also reduces the function's size.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdlib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index db47362a750f..4cc1fdf6791e 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -317,7 +317,7 @@ int msleep(unsigned int msecs)
 __attribute__((weak,unused))
 int raise(int signal)
 {
-	return kill(getpid(), signal);
+	return sys_kill(sys_getpid(), signal);
 }
 
 static __attribute__((unused))
-- 
2.31.1.189.g2e36527f23

