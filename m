Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970DF536F3A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 05:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiE2DfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 23:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiE2DfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 23:35:08 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9048614E
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 20:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653795306; x=1685331306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGlVSOwfybXCFZgxHyal61TawoAb6vp6CRxsR8ZXmeE=;
  b=jbILLlqfhWCqUhuPXl+ct0QqCnfCVL25z9TYcxv29TJm0S9uoFgtbZuc
   i/VCKjLDCFBwl4hZMCd4HlztLvTAbhCzHlrrpaKTKa85kEM7BSxi2MPdt
   3FU6r6NZZN/o8LPfq7uZ19Leddpt+UoP4kz/0STiK1S/g2LjvtOxyGKmj
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 28 May 2022 20:35:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 20:35:06 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 28 May 2022 20:35:05 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 28 May 2022 20:35:03 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v2 2/2] tracing: eprobe: remove duplicate is_good_name() operation
Date:   Sun, 29 May 2022 11:34:54 +0800
Message-ID: <1653795294-19764-3-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653795294-19764-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1653795294-19764-1-git-send-email-quic_linyyuan@quicinc.com>
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

 kernel/trace/trace_eprobe.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 13cd7fc..2ee041d 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -883,15 +883,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		sanitize_event_name(buf1);
 		event = buf1;
 	}
-	if (!is_good_name(event) || !is_good_name(group))
-		goto parse_error;
 
 	sys_event = argv[1];
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
 	if (ret != TP_ENAME_GROUP_EVENT)
 		goto parse_error;
-	if (!is_good_name(sys_event) || !is_good_name(sys_name))
-		goto parse_error;
 
 	mutex_lock(&event_mutex);
 	event_call = find_and_get_event(sys_name, sys_event);
-- 
2.7.4

