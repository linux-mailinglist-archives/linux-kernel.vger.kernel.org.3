Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00C53BC5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbiFBQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbiFBQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:21:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4430568997
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:21:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252Ao5gC026091;
        Thu, 2 Jun 2022 11:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=9g6wF6XXOcEFnnrKMq7H5eD/0w2VbCNXrRcuyQ7orXY=;
 b=NpvpFZ3MtzZ6GK+80lTyOSf8x//XPPTImFKidxYG+M/B8keFIE6HY//NKRTRkJQ9NgYZ
 hHwBd/1QQFZYm4QhYeRhQ3ijrduv291Xfgv/U9EDWDJhlPAHB6+8H/hZsL8h3mz2cfXV
 DlL9mkGcIgTn7L2n47iteDwdkW1WONKbgq1U5UfgicQaiac6uok3qjVlJxpJbgXOUS1y
 sDVYN0ktwdbZ2p8rgz7zm+UNrYPVBW0s5PSgdlNdB2Ax1/caEHESywXfA8zd5TEk7hXv
 zrovMC3hzl5eS6CPPe1pqrWAB8+zaWLKM0jND8XavdTswhpwMxu1XLzmoRqQIYRy30jn YA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gbh51nq0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Jun 2022 11:21:21 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 17:21:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 2 Jun 2022 17:21:19 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1A4ED459;
        Thu,  2 Jun 2022 16:21:19 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] Fixup Cirrus SX control usage
Date:   Thu, 2 Jun 2022 17:21:13 +0100
Message-ID: <20220602162119.3393857-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EcFLfLUIrSXk9lr5iPMpLZKeQx19pyIU
X-Proofpoint-ORIG-GUID: EcFLfLUIrSXk9lr5iPMpLZKeQx19pyIU
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly the usage of the SX controls seems to match the lowest gain
value + number of gain levels expected. The one notable exception
there being cs53l30 as David noted. However, there are a couple of
other places where the minimum value/TLVs are slightly incorrectly
specified.

There are two I couldn't quite work out yet, any input on these
greatly appreciated:

SOC_DOUBLE_R_SX_TLV("Speaker Volume", CS42L52_SPKA_VOL, CS42L52_SPKB_VOL,
                    0, 0x40, 0xC0, hl_tlv),

0.5dB step
0x40 - -96dB
0x00 - 0dB

This one is weird, the datasheet says 0x40 is the minimum, which
matches, but the datasheet also says 0.5dB steps to 0x00 being 0dB
which doesn't match with 0x40 being the minimum, or 0xC0 being
the number of levels. Some clarification will needed from the
hardware guys.

SOC_SINGLE_SX_TLV("Beep Volume", CS42L56_BEEP_FREQ_OFFTIME,
                  0, 0x07, 0x23, beep_tlv),

2dB step
0x07 - -50dB
0x00 - 0dB
0x06 - +6dB

The minimum checks out at 0x07, but rest of this is weird. The values
in the datasheet don't make sense, based on starting at -50dB with
a 2dB step, 0x06 should equate to 12dB, over 31 volume levels, not
6dB over 35 volume levels as stated. The control specifies 0x23(35)
levels, which takes us up to a final value of 0x0A at 20dB. Again
some clarification from the hardware guys might be needed here.

Finally it is worth noting I don't actually have hardware for most of
these devices, so mostly this is just build tested.

Thanks,
Charles

Charles Keepax (6):
  ASoC: cs42l52: Fix TLV scales for mixer controls
  ASoC: cs35l36: Update digital volume TLV
  ASoC: cs53l30: Correct number of volume levels on SX controls
  ASoC: cs42l52: Correct TLV for Bypass Volume
  ASoC: cs42l56: Correct typo in minimum level for SX volume controls
  ASoC: cs42l51: Correct minimum value for SX volume control

 sound/soc/codecs/cs35l36.c |  3 ++-
 sound/soc/codecs/cs42l51.c |  2 +-
 sound/soc/codecs/cs42l52.c |  8 +++++---
 sound/soc/codecs/cs42l56.c |  4 ++--
 sound/soc/codecs/cs53l30.c | 16 ++++++++--------
 5 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.30.2

