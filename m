Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167FE50610A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242530AbiDSAsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57792CE30
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A240A61426
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744C7C3411C;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=QdhjjxhJ7SHpqY5mdpkVbTMHi36forprWYIZSJUVTUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXlVRfSzb+anc4S3lOIYVHiLxrzgRwgawPoevA95ykPOFgD/8jWpEfPXfORtnab36
         bt4alEe+xSuKwMXdxmsCOuxdC1h9A98vHdw3QS2dikLJC5GnKCbGFeiLvgxl6bO2PX
         XJ8bHMLtVLgWfFwop6OqXbiGV3Sjry4Mkva0VJu1/UXZRJAiRg3/WUuArNSwLtJef0
         jNgxcJvnw++TCGFoN3bKnLfxrH+atK8Jl0AfZR0HX4k3P4aIr8nQ2Bcm7uVtJB7pV9
         KEL+4d+kUC7wBeWmCbJFz32wYevUthVSoIWhLgbMVvypfLzbsz2wIyMd2tT0d1SsY5
         bDTDrCUetCp6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 554FC5C3230; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 43/61] tools/nolibc/stdio: make printf(%s) accept NULL
Date:   Mon, 18 Apr 2022 17:42:07 -0700
Message-Id: <20220419004225.3952530-43-paulmck@kernel.org>
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

It's often convenient to support this, especially in test programs where
a NULL may correspond to an allocation error or a non-existing value.
Let's make printf("%s") support being passed a NULL. In this case it
prints "(null)" like glibc's printf().

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index cb4d3ab3a565..559ebe052a75 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -220,6 +220,8 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 			}
 			else if (c == 's') {
 				outstr = va_arg(args, char *);
+				if (!outstr)
+					outstr="(null)";
 			}
 			else if (c == '%') {
 				/* queue it verbatim */
-- 
2.31.1.189.g2e36527f23

