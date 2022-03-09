Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20064D30F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiCIOYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiCIOX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:23:57 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AA410855C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646835778; x=1678371778;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=L/BoiUwHfGKaBdopgfMfhmCSFdJfogltxoiz1XVAUlg=;
  b=hrBI7Pik+It/sRmusLnLpp0VLLSfGPctU/hz7mfjaqPUggtGVAjlBs42
   kq2rBojQrowxgzJl8MXzi5S+p+4iHkfOtUdp+pUtsnWoX+IiliyNpIDsX
   mEfAhNo+Y30twBFthKukt2i9A/cfs9nquY9M341+ql+/R3PZSKD9JOmTk
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Mar 2022 06:22:57 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 06:22:57 -0800
Received: from hu-rbankapu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 06:22:55 -0800
From:   Raghu Bankapur <quic_rbankapu@quicinc.com>
To:     Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     Krishna Jha <quic_kkishorj@quicinc.com>
Subject: [PATCH V0 0/1] ASoC: msm: fix integer overflow for long duration compress offload playback
Date:   Wed, 9 Mar 2022 19:52:27 +0530
Message-ID: <cover.1646835508.git.quic_rbankapu@quicinc.com>
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

32 bit variable is used for storing number of bytes copied to DSP,
which can overflow when playback duration goes beyond 24 hours.
Change data type for this variable to uint64_t to prevent overflow
and related playback anomaly.

below are the steps used to reproduce
Steps:-
1. play all clips from music app with Repeat All Songs enabled
2. one of clip is 1hr duration - 5.1_16bit_192khz_1hr.m4a
3. ACTUAL BEHAVIOUR:- there is no audio playback & progress bar was at 
end of stream, but time stamp continues to update till 31hrs for 1hr clip

Raghu Bankapur (1):
  ASoC: msm: fix integer overflow for long duration offload playback

 include/uapi/sound/compress_offload.h | 2 +-
 sound/core/compress_offload.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

