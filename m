Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56138572787
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiGLUkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiGLUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C8CC01E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25BE761A87
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA35C341C0;
        Tue, 12 Jul 2022 20:39:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oBMfk-0049QJ-Hq;
        Tue, 12 Jul 2022 16:39:56 -0400
Message-ID: <20220712203956.381506179@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Jul 2022 16:39:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [for-linus][PATCH 5/6] fprobe/samples: Make sample_probe static
References: <20220712203924.060569640@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sunliming <sunliming@kylinos.cn>

This symbol is not used outside of fprobe_example.c, so marks it static.

Fixes the following warning:

sparse warnings: (new ones prefixed by >>)
>> samples/fprobe/fprobe_example.c:23:15: sparse: sparse: symbol 'sample_probe'
was not declared. Should it be static?

Link: https://lkml.kernel.org/r/20220606075659.674556-1-sunliming@kylinos.cn

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/fprobe/fprobe_example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index 01ee6c8c8382..58f6e8358e97 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -20,7 +20,7 @@
 
 #define BACKTRACE_DEPTH 16
 #define MAX_SYMBOL_LEN 4096
-struct fprobe sample_probe;
+static struct fprobe sample_probe;
 static unsigned long nhit;
 
 static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
-- 
2.35.1
