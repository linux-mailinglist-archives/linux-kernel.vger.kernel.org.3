Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00A14C1340
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbiBWMxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiBWMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:53:55 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2FD91AD0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645620807; x=1677156807;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=hDKTmx85+is62TviafHoQ6ixrMmVk+VEDH/EMNVBMqA=;
  b=NAYkFZRDQoiEodLPGT/6uAarOt9+9q+inX/jTg92wchCs7hcrYz2bp7A
   ajdGlDLGyT6GPnAHaLsW82NtUn88TADqO0hFBNAgaLAJUFBpJRDNTcReg
   h5pvg5BEO4OBhiFNaGCWt16HhgqWvStp/oFDbbniMw8/VnRXkYDGYptL6
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Feb 2022 04:53:27 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 04:53:27 -0800
Received: from hu-rbankapu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 04:53:25 -0800
From:   Raghu Bankapur <quic_rbankapu@quicinc.com>
To:     Jaroslav Kysela <perex@perex.cz>, <linux-kernel@vger.kernel.org>,
        "Takashi Iwai" <tiwai@suse.com>, <alsa-devel@alsa-project.org>
CC:     Krishna Jha <kkishorj@codeaurora.org>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>
Subject: [PATCH V1 0/1]ASoC: compress: propagate the error code from the compress framework
Date:   Wed, 23 Feb 2022 18:22:49 +0530
Message-ID: <cover.1645618332.git.quic_rbankapu@quicinc.com>
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

Propagate the error code from the compress framework for the timestamp
query. This error code will be used by the client to handle the
error case scenarios gracefully.

This propgated error is used by direct client like Audio HAL through
IOCTL -SNDRV_COMPRESS_TSTAMP response, further this response is sent
to upper layer, based on this error audio related usecases related 
to render position and presentation are handled.

Raghu Bankapur (1):
  ASoC: compress: propagate the error code from the compress framework

 sound/core/compress_offload.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.17.1

