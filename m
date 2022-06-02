Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C6153B8D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiFBMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiFBMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:11:11 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C78D27ED9D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654171871; x=1685707871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rKoLk1/PQw+igiX3/Xmc/1gcdA0fr6Nim+V/4G7ZdIQ=;
  b=u0QcGjfTyoStO9y8+tK1Kz0nCc2VYKIAlnPylG1mz6htb6A3Ohu16YMd
   wai7aq5IVqeTfQjimv8i6ids4vCPgUy62EtyvVLm5DroSziBzvrukECrd
   hglNYKsfJ98r5+dAW/PZYSQlQBMcyVWqPlOz03PHwsGX+1vCnOIuKhO+j
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Jun 2022 05:11:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:11:10 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 05:11:10 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 05:11:08 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v4 1/3] tracing: eprobe: remove duplicate is_good_name() operation
Date:   Thu, 2 Jun 2022 20:10:59 +0800
Message-ID: <1654171861-24014-2-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654171861-24014-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1654171861-24014-1-git-send-email-quic_linyyuan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
v4: no change

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

