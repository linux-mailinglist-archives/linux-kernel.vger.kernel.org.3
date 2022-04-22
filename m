Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9421250BC72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349709AbiDVQEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiDVQEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:04:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AC85676B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:01:45 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MEIxDB004439;
        Fri, 22 Apr 2022 11:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=eGFNm16x7UEwxlj+/sSHzatTIBynBkqIUzT8BzcYbK8=;
 b=EFxyogNcWIojIPOSyVUOhs3g2JHafc9KIuQTjyqD5jfTZZE840yNcZztemOI62+H0LNW
 TlJJhLzeqQHbC0wKRbeY0lwGUVXjjS+9m1dLsy3N28Dj4mhOYPtLjHXVrIxvBgCVMvs+
 IOQHSpvtfLvbPaGVVGae37kwxCvJCWzVWej512X00b+3JTDdkoQTBXCoOxYEpdwCrRwC
 UG37hMNV6cpOS5y0blnXdhQNAbATe3yL59CHFul1ZgV7W/Z+FGt05X5VP/To8B6YNAtM
 +KRMMw4gHBeyg/yTnZ1TMzKAkjYlYofFN0gtnirEgij9vdd+PfnicV5e8FXXd0AoaDlX WQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ffu70qb7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Apr 2022 11:01:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 17:01:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 17:01:19 +0100
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com [198.90.251.83])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B3259B16;
        Fri, 22 Apr 2022 16:01:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/2] ASoC: Add macros for signed TLV controls with callbacks
Date:   Fri, 22 Apr 2022 17:01:10 +0100
Message-ID: <20220422160112.3026542-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -pcEuf_PAuXQvSGlmQj-91fNPbydsV8l
X-Proofpoint-GUID: -pcEuf_PAuXQvSGlmQj-91fNPbydsV8l
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds SOC_DOUBLE_R_S_EXT_TLV and SOC_SINGLE_S_EXT_TLV macros for
signed TLV controls that need custom get/put callbacks. These will be
needed by future Cirrus codec drivers, but are not particularly exotic
so could be useful for others.

Richard Fitzgerald (1):
  ASoC: soc.h: Add SOC_SINGLE_S_EXT_TLV macro

Simon Trimmer (1):
  ASoC: soc.h: Introduce SOC_DOUBLE_R_S_EXT_TLV() macro

 include/sound/soc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.30.2

