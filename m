Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39227506118
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbiDSAsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241142AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC582AC51
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 181366138B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20174C385D1;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=TXGXxxDUWM3g7RndkKdMyxMfgFKYo/NmOYDBPkR2PO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npTj/QxtzwbLb44f/6Dil+BCDyCFtLyMhclIALEZZ3iHbeHaDhPMougDmfixqWGeU
         HDezrEwx+FWpGfAjDhr13Y1AWTdLTCMHxXOx6fILFEN3bB8BIpBXgvehoFmjgtBiZp
         XhnAUlkiIeA2YFtr0IIndBc8oYYCwMUR2usKBu6RT5zfuGdGYdFEl+lLr5GgDW1Kx2
         QdVbkzjz51L2LBUXyj9UpzkiFpSNBTNLMACvEVDsb4YO4zKH3+RQrhrtQqpTXLbd+m
         o6OwuzTtimWCeVTnIUQr4D8sz31/W1pWihYKV4G6oBOA2uR0/jXRt/cNsaWVluNCf0
         uG1/Z0HpTZ6Rw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 351C65C30FB; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 25/61] tools/nolibc/stdlib: avoid a 64-bit shift in u64toh_r()
Date:   Mon, 18 Apr 2022 17:41:49 -0700
Message-Id: <20220419004225.3952530-25-paulmck@kernel.org>
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

The build of printf() on mips requires libgcc for functions __ashldi3 and
__lshrdi3 due to 64-bit shifts when scanning the input number. These are
not really needed in fact since we scan the number 4 bits at a time. Let's
arrange the loop to perform two 32-bit shifts instead on 32-bit platforms.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdlib.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 82a4cf606d3c..db47362a750f 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -200,14 +200,18 @@ int u64toh_r(uint64_t in, char *buffer)
 	int dig;
 
 	do {
-		dig = in >> pos;
-		in -= (uint64_t)dig << pos;
+		if (sizeof(long) >= 8) {
+			dig = (in >> pos) & 0xF;
+		} else {
+			/* 32-bit platforms: avoid a 64-bit shift */
+			uint32_t d = (pos >= 32) ? (in >> 32) : in;
+			dig = (d >> (pos & 31)) & 0xF;
+		}
+		if (dig > 9)
+			dig += 'a' - '0' - 10;
 		pos -= 4;
-		if (dig || digits || pos < 0) {
-			if (dig > 9)
-				dig += 'a' - '0' - 10;
+		if (dig || digits || pos < 0)
 			buffer[digits++] = '0' + dig;
-		}
 	} while (pos >= 0);
 
 	buffer[digits] = 0;
-- 
2.31.1.189.g2e36527f23

