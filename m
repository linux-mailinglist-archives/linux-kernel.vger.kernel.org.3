Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F0553B8D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiFBMLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiFBMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:11:10 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1907E27E444
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654171869; x=1685707869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=25FsaHsj6vKULCL2ppdPZdcvTa1r4VGKLQsqrj0wP1A=;
  b=hgGmmLfFcTf+/wGghChesU7VvspYySjs1K6tLXxrYW5yco9FDetLfuXk
   273thjlMzWSDSNDOsJXQNUQiQoDsjuCVFziRWM2Sf3yQyfwkvgyKnNqPI
   p0rDU8+sdPpgteux03oU7Dpe4puHXyGgPW8UE3U7d1sGVGnhVhuXLQh+7
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Jun 2022 05:11:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:11:08 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 05:11:08 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 05:11:06 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v4 0/3] tracing/probes: allow no event name input when create group
Date:   Thu, 2 Jun 2022 20:10:58 +0800
Message-ID: <1654171861-24014-1-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

take kprobe event as example, when create a group of events,
p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS],
according to this format, we must input EVENT name,

this change allow only GRP/ input, EVENT name auto generate from KSYM,
p[:[GRP/][EVENT]] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]

siliar change apply to eprobe and uprobe.

V1: https://lore.kernel.org/lkml/1651397651-30454-1-git-send-email-quic_linyyuan@quicinc.com/

V2: fix remove comment in V1 patch1,
    remove v1 patch2 as it is NACK.

v3: (v2 link: https://lore.kernel.org/lkml/1653795294-19764-1-git-send-email-quic_linyyuan@quicinc.com/)
    add selftest cases for kprobe and eprobe event,
    remove macro used in v1,v2,
    change location to generate eprobe event name.

v4: (v3 link: https://lore.kernel.org/lkml/1653978552-18637-1-git-send-email-quic_linyyuan@quicinc.com/)
    fix comment of kprobe/eprobe test case.

Linyu Yuan (3):
  tracing: eprobe: remove duplicate is_good_name() operation
  tracing: auto generate event name when create a group of events
  selftests/ftrace: add test case for GRP/ only input

 Documentation/trace/kprobetrace.rst                |  8 +++----
 Documentation/trace/uprobetracer.rst               |  8 +++----
 kernel/trace/trace.c                               |  8 +++----
 kernel/trace/trace_dynevent.c                      |  2 +-
 kernel/trace/trace_eprobe.c                        | 25 +++++++++++-----------
 kernel/trace/trace_kprobe.c                        | 16 ++++++++------
 kernel/trace/trace_probe.c                         |  6 ++++++
 kernel/trace/trace_uprobe.c                        | 12 +++++++----
 .../ftrace/test.d/dynevent/add_remove_eprobe.tc    |  9 +++++++-
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |  7 ++++++
 10 files changed, 64 insertions(+), 37 deletions(-)

-- 
2.7.4

