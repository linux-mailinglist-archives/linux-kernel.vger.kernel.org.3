Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252C9538B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244327AbiEaG3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244306AbiEaG3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:29:33 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE85674D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653978564; x=1685514564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QXg7b+Rnqya3yXGgAAyG3rkHeFxZDDW8JABm9HrsSqA=;
  b=ar+zsHAVUEoiEvSTc+u1XHuSK/lTNXN8C4CpwQyRQiTBZihjbb9EZtZP
   wads9DBXnj+Kl1DmCS+DP1/uAYyJ064bSQmAvmruwZZG+BHLdxy2vmFcE
   GR0ONPQxnal8kEflGbyjWqy1GiIEt7qc3QlIe0afl/J92OaL9gngVRoTF
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 30 May 2022 23:29:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 23:29:24 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 30 May 2022 23:29:23 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 30 May 2022 23:29:21 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v3 3/3] selftests/ftrace: add test case for GRP/ only input
Date:   Tue, 31 May 2022 14:29:12 +0800
Message-ID: <1653978552-18637-4-git-send-email-quic_linyyuan@quicinc.com>
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

add kprobe and eprobe event test for new GRP/ only format.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
v3: first add in this version

 .../testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc  | 7 ++++++-
 .../testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc  | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
index 60c02b4..97856df 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove eprobe events
-# requires: dynamic_events events/syscalls/sys_enter_openat "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
+# requires: dynamic_events events/syscalls/sys_enter_openat "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
 
 echo 0 > events/enable
 
@@ -87,4 +87,9 @@ echo "-:eprobes/$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
 ! grep -q "$EPROBE" dynamic_events
 ! test -d events/eprobes/$EPROBE
 
+echo "e:mygroup/ $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+test -d events/mygroup
+echo "-:mygroup/" >> dynamic_events
+! test -d events/mygroup
+
 clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
index b4da41d..6b102a7 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove kprobe events
-# requires: dynamic_events "place: [<module>:]<symbol>":README "place (kretprobe): [<module>:]<symbol>":README
+# requires: dynamic_events "p[:[<group>/][<event>]] <place> [<args>]":README
 
 echo 0 > events/enable
 echo > dynamic_events
@@ -23,4 +23,9 @@ grep -q myevent1 dynamic_events
 
 echo > dynamic_events
 
+echo "p:mygroup/ $PLACE" >> dynamic_events
+test -d events/mygroup
+echo "-:mygroup/" >> dynamic_events
+! test -d events/mygroup
+
 clear_trace
-- 
2.7.4

