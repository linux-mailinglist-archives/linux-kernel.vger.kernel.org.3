Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C65490B30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiAQPJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:09:56 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:20728 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbiAQPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642432194; x=1673968194;
  h=to:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=CA5y6A/lMDHm/lY8RtnD41nakHXUSgxWC87x31t86S0=;
  b=F692Z+a4Z4hYRK4olYl8c1atMAigKFfQIWmznkLhynzucie4vpkSbIhs
   3uXn+JCoj13DAGDHsmyWOv94F+80RQRaT7EYCdZk08veqfILZCMae3HRt
   UZYFlTUUj/G7S2R+yKK4UV30jx9i8mzvDPQpA9JvwnOrDuBwXipgWX2aR
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Jan 2022 07:09:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 07:09:51 -0800
Received: from [10.216.2.106] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 17 Jan
 2022 07:09:49 -0800
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-remoteproc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Query on moving Recovery remoteproc work to a separate wq instead of
 system freezable wq
Message-ID: <ea64436c-3d9b-9ac1-d4e8-38f15142a764@quicinc.com>
Date:   Mon, 17 Jan 2022 20:39:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There could be a situation there is too much load(of tasks which is 
affined to particular core) on a core on which  rproc
recovery thread will not get a chance to run with no reason but the 
load. If we make this queue unbound, then this work
can run on any core.

Kindly Let me if i can post a proper patch for this like below.

--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -59,6 +59,7 @@ static int rproc_release_carveout(struct rproc *rproc,

  /* Unique indices for remoteproc devices */
  static DEFINE_IDA(rproc_dev_index);
+static struct workqueue_struct *rproc_recovery_wq;

  static const char * const rproc_crash_names[] = {
         [RPROC_MMUFAULT]        = "mmufault",
@@ -2487,7 +2488,7 @@ void rproc_report_crash(struct rproc *rproc, enum 
rproc_crash_type type)
                 rproc->name, rproc_crash_to_string(type));

         /* Have a worker handle the error; ensure system is not 
suspended */
-       queue_work(system_freezable_wq, &rproc->crash_handler);
+       queue_work(rproc_recovery_wq, &rproc->crash_handler);
  }
  EXPORT_SYMBOL(rproc_report_crash);

@@ -2532,6 +2533,12 @@ static void __exit rproc_exit_panic(void)

  static int __init remoteproc_init(void)
  {
+       rproc_recovery_wq = alloc_workqueue("rproc_recovery_wq", 
WQ_UNBOUND |
+                               WQ_HIGHPRI | WQ_FREEZABLE | 
WQ_CPU_INTENSIVE, 0);
+       if (!rproc_recovery_wq) {
+               pr_err("creation of rproc_recovery_wq failed\n");
+       }
+

Thanks,
Mukesh
