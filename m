Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FBD4BA1E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbiBQNtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:49:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbiBQNtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:49:07 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583CBC7C33;
        Thu, 17 Feb 2022 05:48:53 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21HCNFGO030051;
        Thu, 17 Feb 2022 07:48:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=RXMw4ELiiPGxb1BhM1EtrpskMk8OtBkyJrUegKF5rBQ=;
 b=XRLRW4jOC2j3jgVA8macDkPJcqW9rzrqrL3Um9hPcrcXyy74QMxLqgTBuIIbcWmsw179
 SFQw+I0dF1t9IKkHpq44aDyIYB3k7nkTF40TpDcFjdTudqVz4Y8BKE3+znwjgA/qbPlu
 ktsoII82Nv+LWfJ8ejVgdGIr3dbqI0wJtd72UBt/Pwo7698T1RVKxIW71t7ex9axAEqr
 WTOuztt3CY16bnuW3zNZhzngzzT0Hd3tfavfmHBKll/PjXZ+UULzYBZ6VTIWyLaVk0CF
 SXseO1t968TVfIiCJtIj77Ld8Gn1tWG9KVqkZ+ItXNhQ5BmsjuVbuQgjF9tCKOtCwGzS tA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3e8nyda81v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Feb 2022 07:48:40 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 13:48:39 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 17 Feb 2022 13:48:39 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.199])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1641146B;
        Thu, 17 Feb 2022 13:48:38 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH V2 0/2] ASoC: audio_graph_card2: Support variable slot widths
Date:   Thu, 17 Feb 2022 13:48:33 +0000
Message-ID: <20220217134835.282389-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: E2bZm9GJmWyN-WL5TubSTxMn7nc8Cscq
X-Proofpoint-ORIG-GUID: E2bZm9GJmWyN-WL5TubSTxMn7nc8Cscq
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
 include/sound/simple_card_utils.h             | 10 ++
 sound/soc/generic/audio-graph-card2.c         |  4 +
 sound/soc/generic/simple-card-utils.c         | 93 +++++++++++++++++++
 4 files changed, 114 insertions(+)

-- 
2.30.2

