Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A512048B3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbiAKRbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:31:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39788 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344252AbiAKRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB34261709
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C88C36AE3;
        Tue, 11 Jan 2022 17:31:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzL-00329M-20;
        Tue, 11 Jan 2022 12:31:15 -0500
Message-ID: <20220111173114.895305189@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:30:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [for-next][PATCH 09/31] tracing/probes: check the return value of kstrndup() for pbuf
References: <20220111173030.999527342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kstrndup() is a memory allocation-related function, it returns NULL when
some internal memory errors happen. It is better to check the return
value of it so to catch the memory error in time.

Link: https://lkml.kernel.org/r/tencent_4D6E270731456EB88712ED7F13883C334906@qq.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: a42e3c4de964 ("tracing/probe: Add immediate string parameter support")
Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 8a3822818bf8..73d90179b51b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -356,6 +356,8 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
 		return -EINVAL;
 	}
 	*pbuf = kstrndup(str, len - 1, GFP_KERNEL);
+	if (!*pbuf)
+		return -ENOMEM;
 	return 0;
 }
 
-- 
2.33.0
