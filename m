Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6535130D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiD1KI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiD1KHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:07:07 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1808143EDA;
        Thu, 28 Apr 2022 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651139799; x=1682675799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K4dbklDrBN0007czk1A8uvXlWciPzpruZ8ED1Gjwyzc=;
  b=pjeXm7i8HlSqZKXWo3WusB/QFY7tzD8GTzFzYFzWLyKIIuwSb+EIBisU
   GptuFA/bNBIwZ1v8HHhZmLXGEICb1DsQinE9I+LouK0RXBP3TaJj9kbJS
   y86vXXGlFsmpR2a09arBMBgX6PNacJBYkzsCftjR/lAUB2yP4OmNTe3kE
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 28 Apr 2022 02:56:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 02:56:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 02:56:26 -0700
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 02:56:22 -0700
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCHv12 6/9] KVM: arm64: Add a flag to disable MMIO trace for nVHE KVM
Date:   Thu, 28 Apr 2022 15:25:29 +0530
Message-ID: <1517201c3424214edd2d5385eeb10ac106b67d1c.1651139070.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1651139070.git.quic_saipraka@quicinc.com>
References: <cover.1651139070.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic flag (__DISABLE_TRACE_MMIO__) to disable MMIO
tracing in nVHE KVM as the tracepoint and MMIO logging symbols
should not be visible at nVHE KVM as there is no way to execute
them. It can also be used to disable MMIO tracing for specific
drivers.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index f9fe4dc21b1f..87d22a18b7a5 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -4,7 +4,12 @@
 #
 
 asflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS
-ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS
+
+# Tracepoint and MMIO logging symbols should not be visible at nVHE KVM as
+# there is no way to execute them and any such MMIO access from nVHE KVM
+# will explode instantly (Words of Marc Zyngier). So introduce a generic flag
+# __DISABLE_TRACE_MMIO__ to disable MMIO tracing for nVHE KVM.
+ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS -D__DISABLE_TRACE_MMIO__
 
 hostprogs := gen-hyprel
 HOST_EXTRACFLAGS += -I$(objtree)/include
-- 
2.33.1

