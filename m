Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD4A5A104C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbiHYMXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiHYMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:22:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848DAE9ED
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:22:57 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P5j0L6027893;
        Thu, 25 Aug 2022 07:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=CCuFAyZiovrExMERfDLIiYXf9KCPSBvRWYj4Qh4iCWI=;
 b=n2qwHtVQQmRZXhmfDj4HXAjBTuuVxpJP0nqLsEOiUnfSzD7/YuEvEq0iaWrhqex85Nbn
 KU3pCbJMNsN4u59jwtIGrfeNXO+CHWwqC0e0WZwxPOSrLQADz7uzu5KajDpLamZ8A58+
 1KViPkML6o1IyY934aUvy9UnZ/drTa7An7b1gA8cw2GUKpmyqLVV0Zu64lulr5RkwDEJ
 j0lrPU0ToDUGfAgETarp1hSE7PV7dvxZGiFapjcB1ZDwhhT8/wG9vlre4SLU8Rm+x0OE
 kh8kX4WRji6mrdmhcB2VdvpNMSF4E73U97RMFFkIINnObgfX1VwlXB2i7QOD95iAreSp NA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3j4dgmbu3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 07:22:43 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 25 Aug
 2022 07:22:41 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Thu, 25 Aug 2022 07:22:41 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 87C0A45D;
        Thu, 25 Aug 2022 12:22:41 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/3] soundwire: Fixes for spurious and missing UNATTACH
Date:   Thu, 25 Aug 2022 13:22:38 +0100
Message-ID: <20220825122241.273090-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PZHXXUkqqiQPa5ZAvhvNqKoIVYP3RT6F
X-Proofpoint-GUID: PZHXXUkqqiQPa5ZAvhvNqKoIVYP3RT6F
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus and cadence code has several bugs that cause UNATTACH notifications
to either be sent spuriously or to be missed.

These can be seen occasionally with a single peripheral on the bus, but are
much more frequent with multiple peripherals, where several peripherals
could change state and report in consecutive PINGs.

The root of all of these bugs seems to be a code design flaw that assumed
every PING status change would be handled separately. However, PINGs are
handled by a workqueue function and there is no guarantee when that function
will be scheduled to run or how much CPU time it will receive. PINGs will
continue while the work function is handling a snapshot of a previous PING
so the code must take account that (a) status could change during the
work function and (b) there can be a backlog of changes before the IRQ work
function runs again.

Richard Fitzgerald (2):
  soundwire: bus: Don't lose unattach notifications
  soundwire: bus: Fix lost UNATTACH when re-enumerating

Simon Trimmer (1):
  soundwire: cadence: fix updating slave status when a bus has multiple
    peripherals

 drivers/soundwire/bus.c            | 44 +++++++++++++++------
 drivers/soundwire/cadence_master.c | 63 +++++++++++++-----------------
 2 files changed, 59 insertions(+), 48 deletions(-)

-- 
2.30.2

