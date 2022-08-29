Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF42C5A464E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiH2JpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2JpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:45:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A182B191
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:45:16 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T5g85k004126;
        Mon, 29 Aug 2022 04:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=0QrEnrGyT0A123XlPnuSeRTt5nZfbiGJ6EqrLxHEoHY=;
 b=Iodnet+QDKFo+xsv7jt3dabVbWQtBNdu+bi83ecNw8FLRvb1k2IEpxa+WHGWfcRzoCS+
 JSywybQFMpG+W6rBR1coRC17jI6f5lakskB3JS/ef7y37eynK2UTExwK/PPU/m1mglFw
 MpbE1Ia0x3DVmt/g4K4scDpPZFmo4olkohAuBURA5ufalpMUc4JolMTRtRbyJ15McKed
 R0sEiY6QMelYRI1maXW4M4HcYZnDEFMr9jZ584M6pIN44A8w8yp8Mx7iDyBMb/nBl05u
 qtYou8rG5nxd6C0d253ocPXWEbf0klmZFNTn5MKCqSvWPLrpUch/b42ZgP/tnP6/2sru mQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3j7fpp9v2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 04:45:00 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Mon, 29 Aug
 2022 04:44:58 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Mon, 29 Aug 2022 04:44:58 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CF6D67C;
        Mon, 29 Aug 2022 09:44:58 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/1] soundwire: bus: Fix for missing UNATTACH when re-enumerating
Date:   Mon, 29 Aug 2022 10:44:57 +0100
Message-ID: <20220829094458.1169504-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xPM0AhWVeq-oAxelvi8BAYNz_uA8Hj91
X-Proofpoint-ORIG-GUID: xPM0AhWVeq-oAxelvi8BAYNz_uA8Hj91
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an alternative fix for the race where a device that is reset can
be found on #0 and its ID reprogrammed before the bus code has handled
a PING showing it unattached.

The other possible fix is here:
https://lore.kernel.org/all/20220825122241.273090-4-rf@opensource.cirrus.com/

Richard Fitzgerald (1):
  soundwire: bus: Don't re-enumerate before status is UNATTACHED

 drivers/soundwire/bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.30.2

