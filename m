Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD7A505DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbiDRRxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiDRRxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:53:21 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA0C16582;
        Mon, 18 Apr 2022 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650304241; x=1681840241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7vgg/X3YRmaa1v+s/vbemQypwN7iFeNr7xRuJL8O1bE=;
  b=s1761x+fagocceEBSI5U+j3cb1rITLacD/wmE/fdAjVFpAjbnOygie4j
   XgOiJ9I99tTqPfCJv5NiM+C2/cSYRBgQRx+4SMZV8ErjSA1r8eRLD128A
   IMKfPgm1ip0YVgXxwyXOx+qcnSDilt/fzsJtMWesMUl8d0Xs5nOYJcAoG
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 10:50:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 10:50:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 10:50:40 -0700
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 10:50:40 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>,
        <quic_bbhatt@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v4 0/2] MHI MMIO register write updates
Date:   Mon, 18 Apr 2022 11:50:24 -0600
Message-ID: <1650304226-11080-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of MHI MMIO writes, the register field write function needs to do reads
before writes are performed. Propagate read failures such that callers are made
aware of those and can take appropriate action instead of running blind.

Optimizing the MMIO initialization function to use mhi_write_reg() in most cases
should also be done to improve design.

These patches were tested on X86_64 architecture with Ubuntu 18.04 and SDX65
attach.

v4:
Address review comments about log messages, and a missing blank line

v3:
Noticed this was reviewed but never picked up.  Rebased to -next

v2:
-Fix testbot reported missing set of changes from pm.c

Bhaumik Bhatt (2):
  bus: mhi: host: Bail on writing register fields if read fails
  bus: mhi: host: Optimize and update MMIO register write method

 drivers/bus/mhi/host/boot.c     | 22 +++++++++----
 drivers/bus/mhi/host/init.c     | 68 ++++++++++++++++++++++++-----------------
 drivers/bus/mhi/host/internal.h |  7 +++--
 drivers/bus/mhi/host/main.c     |  9 ++++--
 drivers/bus/mhi/host/pm.c       | 15 ++++++---
 5 files changed, 77 insertions(+), 44 deletions(-)

-- 
2.7.4

