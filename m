Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA534DB3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356687AbiCPOxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiCPOxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:53:52 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA65F4C6;
        Wed, 16 Mar 2022 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647442358; x=1678978358;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=VRz5sDewhztqmscIqCEvKiuq2dZuU3QTC0fe7baP4x4=;
  b=v0JWZGTpQhpRE8zl9rEicTGdpN1sNDl7TUiR4kdnqfGBaubFCjInYrYX
   0fY76xZeDFau9f2R87ls03t23efkLLA7UVOnAeQyboKTcXjBrReOVNsNQ
   OwBxV63IaAn+sb+0VoseU0uccaj9DQmuRjfluvgQR2vSDSfJaaLY7Ryfe
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Mar 2022 07:52:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 07:52:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 07:52:36 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 07:52:33 -0700
From:   Charan Teja Reddy <quic_charante@quicinc.com>
To:     <alx.manpages@gmail.com>, <mtk.manpages@gmail.com>,
        <minchan@kernel.org>, <nadav.amit@gmail.com>
CC:     <linux-man@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Charan Teja Reddy" <quic_charante@quicinc.com>
Subject: [PATCH] madvise.2: update EINVAL return info
Date:   Wed, 16 Mar 2022 20:22:00 +0530
Message-ID: <1647442320-7261-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_COLD and MADV_PAGEOUT advises on an address range which includes
locked, Huge TLB pages or VM_PFNMAP pages can return EINVAL. Update the
man pages accordingly.

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Charan Teja Reddy <quic_charante@quicinc.com>
---
 man2/madvise.2 | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/man2/madvise.2 b/man2/madvise.2
index f1f384c..ab98a87 100644
--- a/man2/madvise.2
+++ b/man2/madvise.2
@@ -505,6 +505,16 @@ is not a valid.
 .B EINVAL
 .I advice
 is
+.BR MADV_COLD
+or
+.BR MADV_PAGEOUT
+and the specified address range includes locked, Huge TLB pages, or
+.B VM_PFNMAP
+pages.
+.TP
+.B EINVAL
+.I advice
+is
 .B MADV_DONTNEED
 or
 .BR MADV_REMOVE
-- 
2.7.4

