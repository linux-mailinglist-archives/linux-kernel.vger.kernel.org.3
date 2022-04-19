Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FF6506128
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiDSArQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0767275E1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B8E161407
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D75FC34113;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=O3t3g5HbvuQIzHO9g06u/EQUfsdMQbT37ToUSJz76Zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJqbCVocDgE0c+9GLWCAHxqzX1vOZzFxhDm8QNYu2igtKWlxpxeZh1AYV7PUmo4pO
         ugWpm/cdaD9nsTZLiEr6IDwdHQSqLK5OPYCviO2NBsq2vCimtfKEZLIZIGAJHj1Vxl
         WOVJeszI6yFElvXp+cvf45vaHUK5x93xtl+Cl5f+iIfdedSbEUB8tBOI2fa8J6sams
         OEKIESUuwzf2WlncnrfoD8mZ61j2yAi+VQWT0tGRumwtuRmVVGoNl1gP0pRRmUfFcK
         +yvzVTnGwNyBnyVbt//LxpYpB/9zlv42SVn5zcocr98pHv4At/TETv/qDAE8EkPHCw
         tY6IAnV4NEV+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4C5425C314A; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 38/61] tools/nolibc/unistd: add usleep()
Date:   Mon, 18 Apr 2022 17:42:02 -0700
Message-Id: <20220419004225.3952530-38-paulmck@kernel.org>
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

This call is trivial to implement based on select() to complete sleep()
and msleep(), let's add it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/unistd.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index 87b448ff2191..1c25e20ee360 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -37,6 +37,14 @@ unsigned int sleep(unsigned int seconds)
 		return 0;
 }
 
+static __attribute__((unused))
+int usleep(unsigned int usecs)
+{
+	struct timeval my_timeval = { usecs / 1000000, usecs % 1000000 };
+
+	return sys_select(0, 0, 0, 0, &my_timeval);
+}
+
 static __attribute__((unused))
 int tcsetpgrp(int fd, pid_t pid)
 {
-- 
2.31.1.189.g2e36527f23

