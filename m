Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594594B8F53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbiBPRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:40:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbiBPRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:40:25 -0500
X-Greylist: delayed 1540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 09:40:11 PST
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA89D29720F;
        Wed, 16 Feb 2022 09:40:11 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21G6UxbD014900;
        Wed, 16 Feb 2022 11:14:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=jjPTk4ZNM3VL9GWOU4evMkLIxhVFu38hF4Z1QTq/6ak=;
 b=pJi4VBgKHeAI5hEQhnq+3j/gKTQqDCb30Kk1LVLe3Wkv+ivuWWh5b31pkI5Vac9jYxvN
 /yw1worN2Iau4LuN6Do8iSRb0jh+IGh3SBRS2e2qXo6PbK/dNvHN1xuM1RA2eX6iWxcv
 mw5nXxHZGFPjK7l/bpc4yQnDTuXXQfHWjY97IcnIEAvtxX7mfkXS60j9yDAgUWEL80mm
 iSuJusqDBUL1SOBG3i6qnkbt6pgTBUg7peRkfBjskrhrgDCzrnUdrei09BcUfbdNe1i5
 SN8Q374IRVUQ4ZB/SXDQ5Yjr/seGUpOcGOhktByAMSmxNPdym0IT0iEex3SJQ1Ffady2 Gw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3e8nyd93rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Feb 2022 11:14:14 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 17:14:13 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 16 Feb 2022 17:14:13 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.199])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2E81F459;
        Wed, 16 Feb 2022 17:14:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/2] ASoC: audio_graph_card2: Support variable slot widths
Date:   Wed, 16 Feb 2022 17:14:06 +0000
Message-ID: <20220216171408.265605-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8FYjxAhC1QBZfSXiwNknMgw_G92jTlow
X-Proofpoint-ORIG-GUID: 8FYjxAhC1QBZfSXiwNknMgw_G92jTlow
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for I2S/TDM links where the slot width varies
depending on the sample width, in a way that cannot be guessed by
component hw_params().

A typical example is:

- 16-bit samples use 16-bit slots
- 24-bit samples use 32-bit slots

There is no way for a component hw_params() to deduce from the information
it is passed that 24-bit samples will be in 32-bit slots.

Some audio hardware cannot support a fixed slot width or a slot width
equal to the sample width in all cases. This is usually due either to
limitations of the audio serial port or system clocking restrictions.

These two patches add support for defining a mapping between sample widths
and sample slots. This allows audio_graph_card2 to be used in these
situations instead of having to write a custom machine driver.

Richard Fitzgerald (2):
  ASoC: dt-bindings: audio-graph-port: Add dai-tdm-slot-width-map
  ASoC: audio_graph_card2: Add support for variable slot widths

 .../bindings/sound/audio-graph-port.yaml      |  7 ++
 include/sound/simple_card_utils.h             | 11 +++
 sound/soc/generic/audio-graph-card2.c         |  4 +
 sound/soc/generic/simple-card-utils.c         | 95 +++++++++++++++++++
 4 files changed, 117 insertions(+)

-- 
2.30.2

