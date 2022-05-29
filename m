Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10696537064
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiE2Iui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 04:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiE2Iuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 04:50:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E0F814A0
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653814234; x=1685350234;
  h=from:to:cc:subject:date:message-id;
  bh=TVvfrb426JQRLdfpmF2aegH10RqSqA1HLV5cXGROE2A=;
  b=IXtUxGuk3EMg2Libs0EgQg96qj+o1eCUIJ+huMVq1w1lxSUtzeqTXzLu
   e4UL7by6XTTrpwZ1HQbEUIXo7uBlA4MK0YrBE+yT7CT/Zf6zX2S6DvlcI
   dBH3/GBDCR6utLbCnJm+ktqEpgpT2VkrkQJbYNBKvVbNUD/kfq7Dro+C+
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 29 May 2022 01:50:34 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 29 May 2022 01:50:33 -0700
X-QCInternal: smtphost
Received: from hu-rbankapu-blr.qualcomm.com (HELO hu-ub18template-blr.qualcomm.com) ([10.131.39.233])
  by ironmsg02-blr.qualcomm.com with ESMTP; 29 May 2022 14:20:22 +0530
Received: by hu-ub18template-blr.qualcomm.com (Postfix, from userid 4079802)
        id 40055800995; Sun, 29 May 2022 14:20:21 +0530 (+0530)
From:   Raghu Bankapur <quic_rbankapu@quicinc.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krishna Jha <quic_kkishorj@quicinc.com>
Subject: [PATCH V0 0/1] asoc: msm: use hashtable to check kcontrol
Date:   Sun, 29 May 2022 14:20:08 +0530
Message-Id: <cover.1653813866.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use hashtabe instead of linear list to check kcontrol before
adding them for improving early audio KPI.

With this changes we see 600ms improvement in start of audio

Raghu Bankapur (1):
  asoc: msm: use hashtable to check kcontrol

 include/sound/control.h |  4 ++
 include/sound/core.h    | 12 +++++-
 sound/core/control.c    | 92 +++++++++++++++++++++++++++++++++--------
 sound/core/init.c       |  3 ++
 sound/soc/Kconfig       |  9 ++++
 5 files changed, 101 insertions(+), 19 deletions(-)

-- 
2.17.1

