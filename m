Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B024C428E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiBYKki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiBYKkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:40:35 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E1768F95
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645785604; x=1677321604;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=mudAdqXMqc4msOewE4p+yyZWAmcOkujoS1WyKCFB/IE=;
  b=FFt9T0WqV5lV0JWgsvtJ5hCpdEe5PSWe8/tEotcquxQW/KPePRr2bvB0
   qPjSHDobENEcom6S6D+/E08H5kHBdIsyA1n4MKcmRe4lV7iZ9OTD+EytG
   08lVcRtSxizWRemLnpW+RY/s0JD7eHLnUyOCKTskEQR0vlRLtrkP6mrQg
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Feb 2022 02:40:04 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 02:40:03 -0800
Received: from hu-rbankapu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 02:39:59 -0800
From:   Raghu Bankapur <quic_rbankapu@quicinc.com>
To:     Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        ierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>,
        <alsa-devel@alsa-project.org>, Zubin Mithra <zsm@chromium.org>,
        <linux-kernel@vger.kernel.org>
CC:     Krishna Jha <quic_kkishorj@quicinc.com>
Subject: [PATCH V0 0/1] ALSA: pcm: fix blocking while loop in 
Date:   Fri, 25 Feb 2022 16:09:31 +0530
Message-ID: <cover.1645784757.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When period interrupts are disabled, while loop in snd_pcm_update_hw_ptr0()
results in the machine locking up if runtime->hw_ptr_buffer_jiffies is 0.
Validate runtime->hw_ptr_buffer_jiffies value before while loop to avoid
delta check.


when runtime->hw_ptr_buffer_jiffies is 0 then update of while condition 
hdelta > xrun_threshold will be always true because hdelta will not
change. This will lead to infinite loop causing lock-up

This issue found during stability test, below log explains CPU lock-up on CPU1

[ 922.249028] sched: RT throttling activated for rt_rq ffffffc0f9970778 (cpu 1)
[ 922.249028] potential CPU hogs:
[ 922.249028] **FastCapture (11426)
[ 922.249105] ------------[ cut here ]---------

To fix this lock-up issue, added new condition to check if runtime->
hw_ptr_buffer_jiffies is ZERO or negative.

Raghu Bankapur (1):
  ALSA: pcm: fix blocking while loop in snd_pcm_update_hw_ptr0()

 sound/core/pcm_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.17.1

