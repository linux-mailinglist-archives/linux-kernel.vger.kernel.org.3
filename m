Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAE755292E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244933AbiFUCAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiFUB77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:59:59 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769C71706F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655776798; x=1687312798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8h7utlv2HHX+rNVc7bKilbbEPYZpVQ/QFOBFolLy3NU=;
  b=VsH6Kj+TsXekwdiClJk9QwDcuVDWzMVqpTpUpJrbVL8fFZDZ0nwObHog
   Bs3SBWMb8Jbgy3wMgP7oDgHYuT5OTbfoOmxTHz2Syf8We2Mu0KLyViOF9
   JTYV9l+7znqiBHw8A6eK2KupK2L4WagsC0vWJhnun/y9IbHK7puz1lz+Q
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 20 Jun 2022 18:59:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:59:57 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 18:59:57 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 18:59:55 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v6 1/3] tracing: eprobe: remove duplicate is_good_name() operation
Date:   Tue, 21 Jun 2022 09:59:45 +0800
Message-ID: <1655776787-18133-2-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655776787-18133-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1655776787-18133-1-git-send-email-quic_linyyuan@quicinc.com>
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

traceprobe_parse_event_name() already validate SYSTEM and EVENT name,
there is no need to call is_good_name() after it.

Add trace_probe_log_set_index(1) to allow report correct error
if user input wrong SYSTEM.EVENT format.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
v2: drop v1 change as it is NACK.
    add it to remove duplicate is_good_name().
v3: move it as first patch.
v4: no change
v5: add Acked-by tag
v6: keep is_good_name() check for group and event name
    add trace_probe_log_set_index(1) to report correct error message.

 kernel/trace/trace_eprobe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 7d44785..8979cb9e 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -881,13 +881,12 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	if (!is_good_name(event) || !is_good_name(group))
 		goto parse_error;
 
+	trace_probe_log_set_index(1);
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

