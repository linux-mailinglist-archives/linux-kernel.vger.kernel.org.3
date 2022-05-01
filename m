Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370A4516374
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 11:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiEAJhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 05:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEAJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 05:37:51 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E72C38780
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651397666; x=1682933666;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7pWNRy/qH0xZEVU7QRJlcd1HXB8xOjLEc55yiSeZ3Fo=;
  b=l4NFPTBFgDl37+o5D0pSrVuVKss1l5QXqzQHIUmV0LyE7HbVTDtw2iC8
   sPDOfnaxa/XBK3UKMoP7XXYMclNL9iIIyEeQsEBYkQaGXqck9D2WzqTBt
   uCdpjYcIAjibWpxBcaoIW6BnMcwB9ks0vCWk9oTMkV4iRtFJMhmHRrHNt
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 May 2022 02:34:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 02:34:25 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 1 May 2022 02:34:25 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 1 May 2022 02:34:24 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH 0/2] tracing/probes: allow no event name input when create group
Date:   Sun, 1 May 2022 17:34:09 +0800
Message-ID: <1651397651-30454-1-git-send-email-quic_linyyuan@quicinc.com>
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

siliar change apply to eprobe and uprobe.

Linyu Yuan (2):
  tracing/probes: auto generate events name when create a group of
    events
  tracing/probes: make match function safe

 Documentation/trace/kprobetrace.rst  |  8 +++---
 Documentation/trace/uprobetracer.rst |  8 +++---
 kernel/trace/trace_dynevent.c        |  2 +-
 kernel/trace/trace_eprobe.c          | 50 ++++++++++++++++++++++++------------
 kernel/trace/trace_kprobe.c          | 21 ++++++++++-----
 kernel/trace/trace_probe.c           |  9 ++++++-
 kernel/trace/trace_probe.h           |  4 +++
 kernel/trace/trace_uprobe.c          | 17 ++++++++----
 8 files changed, 81 insertions(+), 38 deletions(-)

-- 
2.7.4

