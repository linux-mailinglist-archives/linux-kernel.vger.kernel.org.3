Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A055B52E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiF0CTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiF0CTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:19:22 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79279B8E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656296361; x=1687832361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VFDneq3BfQZmArCTC469T2Q2wJtQ2vo7zW/WrT+DINY=;
  b=Vl5WXeTniQ2IvzYrqGNBuSoS4lAdI9bwellX6+5X9Gu+KzAiJoTU5zfR
   r2Gd2hrOAOoZmtJcex/bsTmukROEJ6GGulvm4WiIyhXuDi/ObRmb6kmcn
   vpVGCj+gjPL2FGSMuC2yNRywArOVw4DUromYimqDzjg5sbDnVUjsrLa/+
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Jun 2022 19:19:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 19:19:21 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 26 Jun 2022 19:19:20 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 26 Jun 2022 19:19:19 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v7 1/4] tracing: eprobe: add missing log index
Date:   Mon, 27 Jun 2022 10:19:05 +0800
Message-ID: <1656296348-16111-2-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656296348-16111-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1656296348-16111-1-git-send-email-quic_linyyuan@quicinc.com>
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

Add trace_probe_log_set_index(1) to allow report correct error
if user input wrong SYSTEM.EVENT format.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
v7: move one line change from v6 to a separate patch

 kernel/trace/trace_eprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 7d44785..b805b57 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -881,6 +881,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	if (!is_good_name(event) || !is_good_name(group))
 		goto parse_error;
 
+	trace_probe_log_set_index(1);
 	sys_event = argv[1];
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2,
 					  sys_event - argv[1]);
-- 
2.7.4

