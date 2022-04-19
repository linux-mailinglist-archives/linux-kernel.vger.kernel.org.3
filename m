Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B76506109
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbiDSApe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbiDSApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1998C275E1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EBF3B81136
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F76C385A9;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=VM92P/4HQXUJU5jc33yT093Wh7s0gAOxHUtMub66QDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZogACB9nf2WtmOT5IKGMZSMTeuYmUpGsFFar7YD0vuPzX/vxTcQX9ok47C4OOb9AM
         OIo7DUU6seG77pLALTW7L8H+/X6JsSflCR4pDf0aFTH7OKKAmWtcvp6Lf6fcVRtbmY
         2PmAXyYDqdvwqR4D+uAjZvUhf35OANbJZfqc5uLeiPTpTKwuoR3VK+Md9jPQQzDm29
         xPIoyJV99ib1Azc2hnVzr085d99OR0QpncYrWyZDCGZ8c8p/xLWslQRczP4SnvZmL3
         vtkIvygZf+2ljhg4BwB3XQdkGsAhKv05Tn04fl3Pa/se0dnTeZqnFBztZRQ0Tc19VR
         yNtAe++VQaH/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0302F5C04BD; Mon, 18 Apr 2022 17:42:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 01/61] tools/nolibc: use pselect6 on RISCV
Date:   Mon, 18 Apr 2022 17:41:25 -0700
Message-Id: <20220419004225.3952530-1-paulmck@kernel.org>
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

This arch doesn't provide the old-style select() syscall, we have to
use pselect6().

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index c1c285fe494a..ad23712f9cb5 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1256,7 +1256,10 @@ struct sys_stat_struct {
  *   - the arguments are cast to long and assigned into the target
  *     registers which are then simply passed as registers to the asm code,
  *     so that we don't have to experience issues with register constraints.
+ *
+ * On riscv, select() is not implemented so we have to use pselect6().
  */
+#define __ARCH_WANT_SYS_PSELECT6
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
-- 
2.31.1.189.g2e36527f23

