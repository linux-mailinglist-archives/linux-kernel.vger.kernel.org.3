Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4B4D649F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349252AbiCKPcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiCKPcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:32:06 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE5D1B8CB5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647012663; x=1678548663;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=PF6Eg9uUIzx22Jx9LT/iohqhCZ1p6IWaB9RmrqgpzxQ=;
  b=wqcwFTGZNDsrt9hLHRavxiZ+alxGveEAoC9pgfEOX8a05qfdIXdRU4/9
   ZGUi+2A7xWIocpKoM7cB0YBFju1CLXPhDHtWU8QkY9wQ2DF2pCmn7Lnbn
   f/SKv3PodQMRtnwRB4u9JmLm0cpqrdjSurS0XtEEb18JOSziNKTgLdjLt
   k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Mar 2022 07:31:02 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 07:31:01 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Mar 2022 07:31:00 -0800
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Mar 2022 07:30:56 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <surenb@google.com>, <vbabka@suse.cz>,
        <rientjes@google.com>, <sfr@canb.auug.org.au>,
        <edgararriaga@google.com>, <minchan@kernel.org>,
        <nadav.amit@gmail.com>, <mhocko@suse.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V2,0/2]mm: madvise: return correct bytes processed with process_madvise
Date:   Fri, 11 Mar 2022 20:59:04 +0530
Message-ID: <cover.1647008754.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

With the process_madvise(), always choose to return non zero processed
bytes over an error. This can help the user to know on which VMA, passed
in the 'struct iovec' vector list, is failed to advise thus can take the
decission of retrying/skipping on that VMA.

Changes in V2:
  -- Separated the fixes returning processed bytes in case of an error
     and ENOMEM handling of process_madvise() due to unmapped hole in
     the VMA, as per the Minchan comments.
  -- Improved the comment for ENOMEM handling case as per Amit comments.

Changes in V1:
  -- Fixed the return value of process_madvise().
  -- Fixed ENOMEM handling of process_madvise() from do_madvise()
  -- https://patchwork.kernel.org/project/linux-mm/patch/1646803679-11433-1-git-send-email-quic_charante@quicinc.com/

Charan Teja Kalla (2):
  mm: madvise: return correct bytes advised with process_madvise
  mm: madvise: skip unmapped vma holes passed to process_madvise

 mm/madvise.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.7.4

