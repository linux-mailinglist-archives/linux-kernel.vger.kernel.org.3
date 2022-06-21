Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F2555292D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbiFUCAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFUB76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:59:58 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00651706F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655776796; x=1687312796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jjKKcCiz6+zVW22+9xaLWaFc/h8mREDemTr0/eKrBOk=;
  b=Xr8mVvH017r837vP7LrvPkZBeMxlPXq/GuE5Aq9wXrY2AEOd6nnb6O9s
   qgfjVz/VP+63Uww6FJHtZMcTvL+m0UTsBuQb3jKTCm6Dy6VZRMkJNUftV
   DzyqK/rzYu3KB1u5A/dyT+KD9jkON99/4ipDofKwRDMuyQvQ90bfFnToT
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jun 2022 18:59:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:59:56 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 18:59:55 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 18:59:54 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v6 0/3] tracing/probes: allow no event name input when create group 
Date:   Tue, 21 Jun 2022 09:59:44 +0800
Message-ID: <1655776787-18133-1-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

take kprobe event as example, when create a group of events,
p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS],
according to this format, we must input EVENT name,

this change allow only GRP/ input, EVENT name auto generate from KSYM,
p[:[GRP/][EVENT]] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]

similar change apply to eprobe and uprobe.

V2: (v1: https://lore.kernel.org/lkml/1651397651-30454-1-git-send-email-quic_linyyuan@quicinc.com/)
    fix remove comment in V1 patch1,
    remove v1 patch2 as it is NACK.

v3: (v2 : https://lore.kernel.org/lkml/1653795294-19764-1-git-send-email-quic_linyyuan@quicinc.com/)
    add selftest cases for kprobe and eprobe event,
    remove macro used in v1,v2,
    change location to generate eprobe event name.

v4: (v3 : https://lore.kernel.org/lkml/1653978552-18637-1-git-send-email-quic_linyyuan@quicinc.com/)
    fix comment of kprobe/eprobe test case.

v5: (v4: https://lore.kernel.org/lkml/1654171861-24014-1-git-send-email-quic_linyyuan@quicinc.com/)
    for eprobe, when only input a "SYSTEM.", it is invalid.
    add Acked-by from Masami Hiramatsu (Google) <mhiramat@kernel.org>

v6: (v5: https://lore.kernel.org/lkml/1655168698-19898-1-git-send-email-quic_linyyuan@quicinc.com/)
    change some code order according review comment from Tom Zanussi,
    some minor changes.

Linyu Yuan (3):
  tracing: eprobe: remove duplicate is_good_name() operation
  tracing: auto generate event name when create a group of events
  selftests/ftrace: add test case for GRP/ only input

 Documentation/trace/kprobetrace.rst                |  8 +++----
 Documentation/trace/uprobetracer.rst               |  8 +++----
 kernel/trace/trace.c                               |  8 +++----
 kernel/trace/trace_dynevent.c                      |  2 +-
 kernel/trace/trace_eprobe.c                        | 28 +++++++++++-----------
 kernel/trace/trace_kprobe.c                        | 16 ++++++++-----
 kernel/trace/trace_probe.c                         |  4 ++++
 kernel/trace/trace_uprobe.c                        | 12 ++++++----
 .../ftrace/test.d/dynevent/add_remove_eprobe.tc    |  9 ++++++-
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |  7 ++++++
 10 files changed, 64 insertions(+), 38 deletions(-)

-- 
2.7.4

