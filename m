Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAA24F4C94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578931AbiDEXZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443105AbiDEPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:38:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DA4BC857;
        Tue,  5 Apr 2022 06:54:39 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2356jiGC029879;
        Tue, 5 Apr 2022 08:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=D7H9GzgzNTUv2SxZBu6ky5Mhjq+9FrGLu3EkwWXFSIo=;
 b=g2jQs73Qjk38eI+fMIuqbIBkeVF1/x//BzW1DoRLUX5JKXvc1TCbFH5dpjQt+gYWNDZk
 FaJgSd4VvUCtFWgHk0DaLA47+Liqhj5ThoQ7VPA/KteyHZtY7wWYN2Be4QEwXjA5LXvB
 yLGM/hdATnIsWHrGXd/XF8TITzLS/k0Gwh1y4dJ1P2CI8RaSgB0i4dfTROnDjao0SLkO
 hkyVn0i85Nn+Ef4PLpUFaXBH7Y5h/wXOXHkv8bwZ/MDcoZbD039JKg1vguafOmJeZCIV
 lreIJZhiNE4ex1PsvTswd2iTMMLi74qVeCD86CX1GTmtMe6RQwLE+WGuERHK9tnJpTNu 2g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f6kw2brws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Apr 2022 08:54:25 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 14:54:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 5 Apr 2022 14:54:23 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.88])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C644E458;
        Tue,  5 Apr 2022 13:54:22 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/5] ASoC: Add a driver for the Cirrus Logic CS35L45 Smart Amplifier
Date:   Tue, 5 Apr 2022 14:54:14 +0100
Message-ID: <20220405135419.1230088-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cJo1vpfXBTPYhRk3hu6TOOHFtAt-ZQXd
X-Proofpoint-GUID: cJo1vpfXBTPYhRk3hu6TOOHFtAt-ZQXd
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds basic audio support for the Cirrus Logic CS35L45 amplifier.

The first two patches add two generic helpers to ASoC, and patch 3 is
a kunit test for patch 2.

CHANGES SINCE V1:
Patch #5:
 - spi .remove callback now has void return
 - use new I2C .probe_new callback
 - force boost-bypass mode as default

James Schulman (1):
  ASoC: cs35l45: Add driver for Cirrus Logic CS35L45 Smart Amp

Richard Fitzgerald (4):
  ASoC: soc.h: Add SOC_SINGLE_S_TLV() macro
  ASoC: soc-utils: Add helper to calculate BCLK from TDM info
  ASoC: soc-utils: Add kunit test for snd_soc_tdm_params_to_bclk()
  ASoC: dt-bindings: cs35l45: Cirrus Logic CS35L45 Smart Amp

 .../bindings/sound/cirrus,cs35l45.yaml        |  75 ++
 MAINTAINERS                                   |   2 +
 include/dt-bindings/sound/cs35l45.h           |  20 +
 include/sound/soc.h                           |   4 +
 sound/soc/Kconfig                             |   9 +-
 sound/soc/Makefile                            |   5 +
 sound/soc/codecs/Kconfig                      |  30 +
 sound/soc/codecs/Makefile                     |   8 +
 sound/soc/codecs/cs35l45-i2c.c                |  72 ++
 sound/soc/codecs/cs35l45-spi.c                |  72 ++
 sound/soc/codecs/cs35l45-tables.c             | 202 +++++
 sound/soc/codecs/cs35l45.c                    | 693 ++++++++++++++++++
 sound/soc/codecs/cs35l45.h                    | 217 ++++++
 sound/soc/soc-utils-test.c                    | 186 +++++
 sound/soc/soc-utils.c                         |  45 ++
 15 files changed, 1639 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml
 create mode 100644 include/dt-bindings/sound/cs35l45.h
 create mode 100644 sound/soc/codecs/cs35l45-i2c.c
 create mode 100644 sound/soc/codecs/cs35l45-spi.c
 create mode 100644 sound/soc/codecs/cs35l45-tables.c
 create mode 100644 sound/soc/codecs/cs35l45.c
 create mode 100644 sound/soc/codecs/cs35l45.h
 create mode 100644 sound/soc/soc-utils-test.c

-- 
2.30.2

