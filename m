Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5776059E9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiHWRh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiHWRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:36:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C9B7AC09;
        Tue, 23 Aug 2022 08:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E38BB615E9;
        Tue, 23 Aug 2022 15:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D8BC433C1;
        Tue, 23 Aug 2022 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661268036;
        bh=R3JCBvCuFVOcgv2cpaHqmIPuKQnLpMXkz7+RnJAPMTY=;
        h=From:To:Cc:Subject:Date:From;
        b=RUzqgFBg7s4w5fBJZ1jilhw+kO3ADxqZl5YSqKS2ZDMuFGZMYXAr+bkFL8HFANyeH
         eUmVS/M4o9dpmQrJrZ01YErwvtcEr9oP9HB9EsObVFJP/p5j+U/xuD9VXwBh9QRQ8q
         pDpCBXgMucuqCCk0nCWwZ3MaOIxK7+yYFXTDh2x+DFnD5hjJ09f9TxAFSeEO0+5y3P
         LYpkXj8BCo6+xV84EM8HO0WCDTo8bbZpXkv/JXwVXKeE2XQ1G6/OBE28aDLNrjYvzP
         5BftSS5MxAI9Sx9VR8C6SxyoqxzO/Hyodl3CF4z2nowJyHl0U8efqm+DQNbGHxVP33
         jkReXKEUibUoQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] rv/dot2c: Make automaton definition static
Date:   Tue, 23 Aug 2022 17:20:28 +0200
Message-Id: <ffbb92010f643307766c9307fd42f416e5b85fa0.1661266564.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Monitor's automata definition is only used locally, so make dot2c generate
a static definition.

Link: https://lore.kernel.org/all/202208210332.gtHXje45-lkp@intel.com
Link: https://lore.kernel.org/all/202208210358.6HH3OrVs-lkp@intel.com

Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: e3c9fc78f096 ("tools/rv: Add dot2c")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/verification/dot2/dot2c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/dot2/dot2c.py
index fa73353f7e56..be8a364a469b 100644
--- a/tools/verification/dot2/dot2c.py
+++ b/tools/verification/dot2/dot2c.py
@@ -111,7 +111,7 @@ class Dot2c(Automata):
 
     def format_aut_init_header(self):
         buff = []
-        buff.append("struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
+        buff.append("static struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
         return buff
 
     def __get_string_vector_per_line_content(self, buff):
-- 
2.35.1

