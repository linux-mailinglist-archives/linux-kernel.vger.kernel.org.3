Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B88E55B52F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiF0CTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiF0CT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:19:28 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B5DB8E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656296367; x=1687832367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lrXxvgDU/MnoDDeXXkn7zZSgJ7McVQVSLVnuIbYNY50=;
  b=M+HnXr+rIN0fdy7jCNl+Q6kPZU9yeqvUNobHpDrVT2ZCWl8Lq6hploi1
   P2wvoYcYRMyJCPb/7j03yi3K43sh6j6f0/UE/Gr2nYsUj8gvPt9Gd3EXl
   yQL5B6ciU4b9WxGSv+1IHMRpaUucvU3sbZZD8jGNoHgFiiRKtezKsw8m0
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jun 2022 19:19:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 19:19:27 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 26 Jun 2022 19:19:26 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 26 Jun 2022 19:19:25 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v7 4/4] selftests/ftrace: add test case for GRP/ only input
Date:   Mon, 27 Jun 2022 10:19:08 +0800
Message-ID: <1656296348-16111-5-git-send-email-quic_linyyuan@quicinc.com>
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

add kprobe and eprobe event test for new GRP/ only format.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
v3: first add in this version
v4: remove restriction of test case
v5: add Acked-by tag
v6: no change
v7: no change

 .../selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc        | 9 ++++++++-
 .../selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc        | 7 +++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
index 60c02b4..c300eb0 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove eprobe events
-# requires: dynamic_events events/syscalls/sys_enter_openat "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
+# requires: dynamic_events events/syscalls/sys_enter_openat "<attached-group>.<attached-event> [<args>]":README
 
 echo 0 > events/enable
 
@@ -87,4 +87,11 @@ echo "-:eprobes/$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
 ! grep -q "$EPROBE" dynamic_events
 ! test -d events/eprobes/$EPROBE
 
+if grep -q "e\[:\[<group>/]\[<event>]]" README; then
+	echo "e:mygroup/ $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+	test -d events/mygroup
+	echo "-:mygroup/" >> dynamic_events
+	! test -d events/mygroup
+fi
+
 clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
index b4da41d..13d43f4 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
@@ -23,4 +23,11 @@ grep -q myevent1 dynamic_events
 
 echo > dynamic_events
 
+if grep -q "p\[:\[<group>/]\[<event>]]" README; then
+	echo "p:mygroup/ $PLACE" >> dynamic_events
+	test -d events/mygroup
+	echo "-:mygroup/" >> dynamic_events
+	! test -d events/mygroup
+fi
+
 clear_trace
-- 
2.7.4

