Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9804DDF05
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbiCRQbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbiCRQbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:31:15 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E8B195302;
        Fri, 18 Mar 2022 09:29:53 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I7cSw0022149;
        Fri, 18 Mar 2022 11:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=bZOlEfRg8T9t1B79/9gI2BtOG0E7AxmmrAD8lfrQVfY=;
 b=cxK65f2/uAOtvEX3R8Rj+f4it+rm1WasLXI5OQ8Nj2ndlwpHKYqHZQ26BJb8/ghDOZ+g
 rSQuQeTFdH84eYj7FxUDatE3iw8Aj+IZEc/DWhi8iyPCanlmIKyt40qxD54W/PRuxwlm
 afEOLkDx6J0d++Iar4W+sVSxPTUSLWQ9v9Mb+m0tiVn4KVSblQwIJKsjaQRYqYnhQt/9
 ofI+Ixpa45WnFRUfGKBX0Nn25xp2jX0i/jp7tjth0rCUS9f1h1geHx2unuOSBpNJm49V
 xee1/+MrY8Wj9YdWpr4lig4/Zvd+dmPvJ3gPaRAbv954jjoqvEuiPmz6t76PLq9UZARA sA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3et642efpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 11:29:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 16:29:44 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Mar 2022 16:29:44 +0000
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com [198.90.251.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 450F37C;
        Fri, 18 Mar 2022 16:29:44 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 0/5] ASoC: Add a driver for the Cirrus Logic CS35L45 Smart Amplifier
Date:   Fri, 18 Mar 2022 16:29:38 +0000
Message-ID: <20220318162943.1578102-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: D_bFfSzULB-QA3qo-yHPCgAOR5Wto9Mw
X-Proofpoint-ORIG-GUID: D_bFfSzULB-QA3qo-yHPCgAOR5Wto9Mw
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds basic audio support for the Cirrus Logic CS35L45 amplifier.

The first two patches add two generic helpers to ASoC, and patch 3 is
a kunit test for patch 2.

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
 sound/soc/codecs/cs35l45-i2c.c                |  73 ++
 sound/soc/codecs/cs35l45-spi.c                |  72 ++
 sound/soc/codecs/cs35l45-tables.c             | 202 +++++
 sound/soc/codecs/cs35l45.c                    | 689 ++++++++++++++++++
 sound/soc/codecs/cs35l45.h                    | 213 ++++++
 sound/soc/soc-utils-test.c                    | 186 +++++
 sound/soc/soc-utils.c                         |  45 ++
 15 files changed, 1632 insertions(+), 1 deletion(-)
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

