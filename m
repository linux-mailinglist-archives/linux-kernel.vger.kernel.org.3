Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D104E4E631B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350041AbiCXMUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346471AbiCXMUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:20:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F8338AA;
        Thu, 24 Mar 2022 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648124308; x=1679660308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7ZjS4LYZriC/3WvdxBRIYzcV+IvQOztZoBfpx89Hlq8=;
  b=WZhFq2+hISsFdJuOh6JOty6TEh6dAdhsd8Rho4/konm7vRm7ng0iw3o7
   dKYiAqkhq/vz7CcCT79s5E6EqSZEkOEU5+ws2Aj0o+jBeVTzYf13ute7V
   PtQ5X7QXERmEn9LXF1FULHs1F9f0QlL1GMvWwJUkf5/1l03e10rXW1qao
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 24 Mar 2022 05:18:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 05:18:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 05:18:27 -0700
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 05:18:23 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v4 06/10] docs: sysfs: coresight: Add sysfs ABI documentation for TPDM
Date:   Thu, 24 Mar 2022 20:17:30 +0800
Message-ID: <20220324121734.21531-7-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
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

Add API usage document for sysfs API in TPDM driver.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
new file mode 100644
index 000000000000..1df2f9b9ade2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -0,0 +1,5 @@
+What:		/sys/bus/coresight/devices/<tpdm-name>/integration_test
+Date:		February 2022
+KernelVersion	5.17
+Contact:	Jinlong Mao or Tao Zhang
+Description:	(Write) Run integration test for tpdm.
-- 
2.17.1

