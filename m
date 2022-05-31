Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4DA538B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbiEaG3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiEaG3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:29:22 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D266ACA
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653978561; x=1685514561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M4Rg0ZyyxbJnHEdsOkdSEJv83ADIxaBkmdXmyny7TJY=;
  b=glsU/2q5wwLwuXeQka8D0Ych2/AexG7+MLOV+d3m5b3CrHEBIIzhfg9e
   enz73PhCuYioR7NRfPKMH2Ee07OqlrHaukU3NKVugPUH8WEtXGMqyrvuM
   xTRaDCQOhq3iG1/vKaBlq7UiCYgpup9oHFLdS/lyoyO4v3eRXgfEuh84p
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 30 May 2022 23:29:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 23:29:20 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 30 May 2022 23:29:19 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 30 May 2022 23:29:17 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v3 1/3] tracing: eprobe: remove duplicate is_good_name() operation
Date:   Tue, 31 May 2022 14:29:10 +0800
Message-ID: <1653978552-18637-2-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653978552-18637-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1653978552-18637-1-git-send-email-quic_linyyuan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

traceprobe_parse_event_name() already validate group and event name,
there is no need to call is_good_name() after it.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
v2: drop v1 change as it is NACK.
    add it to remove duplicate is_good_name().
v3: move it as first patch.

 kernel/trace/trace_eprobe.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 7d44785..17d64e3 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -878,16 +878,12 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		sanitize_event_name(buf1);
 		event = buf1;
 	}
-	if (!is_good_name(event) || !is_good_name(group))
-		goto parse_error;
 
 	sys_event = argv[1];
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2,
 					  sys_event - argv[1]);
 	if (ret || !sys_name)
 		goto parse_error;
-	if (!is_good_name(sys_event) || !is_good_name(sys_name))
-		goto parse_error;
 
 	mutex_lock(&event_mutex);
 	event_call = find_and_get_event(sys_name, sys_event);
-- 
2.7.4

