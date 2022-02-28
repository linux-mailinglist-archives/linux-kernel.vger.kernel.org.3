Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5964C72F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiB1RbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiB1RaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:30:06 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E74F471;
        Mon, 28 Feb 2022 09:28:16 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21SFwZIh005113;
        Mon, 28 Feb 2022 11:28:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=t89hC57npduwQLcBV3r9nbt80Vt6eUmyKFdTHvx+Nbo=;
 b=SChsN/oyUxJogKRIB1fDInhsKLxrY0Dyov6N+Zy8p6cDB9QP115Sbz+nNuWh806VPNEK
 Pd8b6CjOm9ZV1Co1AF7c4GceLRgONHxWkrPYXPHW8K8/BR26VFHDKe6TrHX0PUxjuooo
 ZFQgnmIDDHLNIC7Cf7+6ssHoKi3SS1GCILKm6gxigpPztGqYvisY4ITAdBF+XKifyXMg
 VBd9fNvw0WLQDJ/79m0E1AdcNiNvd6Mb3l0HrKI3VaaKxN5KUMOdtR6ujIwTSMjr6aW6
 r659PP/0h9X/LF+Vavmg37fKssdsoQ56CGhKNd5miUzvsw5AKFUPCxxVAMPSVi1CrhBp Xg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3efjg5thq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Feb 2022 11:27:59 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 17:27:57 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 28 Feb 2022 17:27:57 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.213])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 099CBB06;
        Mon, 28 Feb 2022 17:27:57 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH V3 0/2] ASoC: audio_graph_card2: Support variable slot widths
Date:   Mon, 28 Feb 2022 17:27:52 +0000
Message-ID: <20220228172754.453783-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TRZtSh8x4QpWQs5UXd9lvOBw-rZejTc2
X-Proofpoint-ORIG-GUID: TRZtSh8x4QpWQs5UXd9lvOBw-rZejTc2
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

Changes since V2:
- Change property type to uint32-matrix.
- Put min/max ranges on cells.
- Use per-item description to document the tuple entries.
- Add a slot count to the tuple - it's unlikely that this would change
  for different sample rates but it's trivial to implement support for it.
- Minor tidying of the code in asoc_simple_parse_tdm_width_map() and
  asoc_simple_set_tdm().

Richard Fitzgerald (2):
  ASoC: dt-bindings: audio-graph-port: Add dai-tdm-slot-width-map
  ASoC: audio_graph_card2: Add support for variable slot widths

 .../bindings/sound/audio-graph-port.yaml      | 20 ++++
 include/sound/simple_card_utils.h             | 11 +++
 sound/soc/generic/audio-graph-card2.c         |  4 +
 sound/soc/generic/simple-card-utils.c         | 97 +++++++++++++++++++
 4 files changed, 132 insertions(+)

-- 
2.30.2

