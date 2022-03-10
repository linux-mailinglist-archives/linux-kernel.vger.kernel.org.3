Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CA34D5010
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbiCJRSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbiCJRSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:18:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D80187BA5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:17:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4BF2B82705
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA2EC340E8;
        Thu, 10 Mar 2022 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646932629;
        bh=2czeYZEhYrw+eEsPeWClwqc/1LpOrFNLlEfPbHjGD/8=;
        h=Subject:From:To:Cc:Date:From;
        b=Fn9iwM4mptqfym/gS03mQe6/YlHfI28Xu6K9Uqc6I47tseIM6F8mztbUfLBRv7kUc
         SDeea/byD+MHrmOCKTBK81kUBdxUVYbcxQ4NDTkEYAjNG/LaAfZtiHa0zFSuHOnUY+
         cSJGXLdEcXAEsXhqJDM5sBtl4qFM7zElXuRZaZhSnqI6vaZCzU0gfITkxMzxXdaYsv
         yVL+C5/NkoCq1Xv8ujUwsT7suJcRD9k6q8uoaU2ckddpf6BxP1vWDQrPrMdaeuiKSN
         FtUUhd5OX9aXFn9XPFLvyGhihn2zx7gvixCabXM/9Hs5l2KtTMTHrtgTZjSeJNkK2X
         yaHSWnD1LqecA==
Message-ID: <77deca8cbfd226981b3f1eab203967381e9b5bd9.camel@kernel.org>
Subject: [PATCH] tracing: Fix strncpy warning in trace_events_synth.c
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Mar 2022 11:17:07 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0-day reported the strncpy error below:

../kernel/trace/trace_events_synth.c: In function 'last_cmd_set':
../kernel/trace/trace_events_synth.c:65:9: warning: 'strncpy' specified bound depends on the length o\
f the source argument [-Wstringop-truncation]
   65 |         strncpy(last_cmd, str, strlen(str) + 1);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../kernel/trace/trace_events_synth.c:65:32: note: length computed here
   65 |         strncpy(last_cmd, str, strlen(str) + 1);
      |                                ^~~~~~~~~~~

There's no reason to use strncpy here, in fact there's no reason to do
anything but a simple kstrdup() (note we don't even need to check for
failure since last_cmod is expected to be either the last cmd string
or NULL, and the containing function is a void return).

Fixes: 27c888da9867 ("tracing: Remove size restriction on synthetic event cmd error logging")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index fdd79e07e2fc..5e8c07aef071 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -58,11 +58,8 @@ static void last_cmd_set(const char *str)
 		return;
 
 	kfree(last_cmd);
-	last_cmd = kzalloc(strlen(str) + 1, GFP_KERNEL);
-	if (!last_cmd)
-		return;
 
-	strncpy(last_cmd, str, strlen(str) + 1);
+	last_cmd = kstrdup(str, GFP_KERNEL);
 }
 
 static void synth_err(u8 err_type, u16 err_pos)
-- 
2.17.1


