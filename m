Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E775AFFA7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiIGIxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiIGIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:53:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19028E473
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:53:27 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2877rCGG005930;
        Wed, 7 Sep 2022 03:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=uf/a9j89KomDA2V4JJLKTY/HwJy3SBHW0c3kiFGZtD4=;
 b=YYMg2w6HW7yv9T6rzuCYhAux5XLisO9lQxB8EsQhznqeOG44AVIzpM66rHAgwEMZeJ8N
 12FU+mwVEwMaryytjln8g/pKnDUEMMadqy3A0HlrLi9cJZ7CgonVZe2DZrlr5j4HD46g
 orrxU0GZ772jaNXqDNhVrblf5aVIR7O9RuR7k3E/67nSSuMyswzfxsg74I9yYKjmRstU
 5DJm7NKktouIPImTRn5Quw1jkxvTh5CjN0nqN7SfSbFdJnYLd2b6tA33SO6Dv/YqdWDF
 yDUa5lIa21fL62D6qsT5S5Uqid8VwAHZeDKQDvdNdfsCwQXzJ13GRFlxDL1xwkqZBpwa rA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jc3bpw21n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 03:53:03 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 7 Sep
 2022 03:53:02 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Wed, 7 Sep 2022 03:53:02 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.149])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D0536B06;
        Wed,  7 Sep 2022 08:53:01 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/5] soundwire: Fixes for spurious and missing UNATTACH
Date:   Wed, 7 Sep 2022 09:52:54 +0100
Message-ID: <20220907085259.3602-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CbcV0LrqhBhWd3ZXDCjVKUgSfEHRbdmE
X-Proofpoint-ORIG-GUID: CbcV0LrqhBhWd3ZXDCjVKUgSfEHRbdmE
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Tested with 4 peripherals on 1 bus, and 8 peripherals on 2 buses.

CHANGES SINCE V1:
Patch #3 replaced with a better solution to the same bug.
Patches #4 and #5 added to fix some more bugs that were found.

Richard Fitzgerald (4):
  soundwire: bus: Don't lose unattach notifications
  soundwire: bus: Don't re-enumerate before status is UNATTACHED
  soundwire: cadence: Fix lost ATTACHED interrupts when enumerating
  soundwire: bus: Don't exit early if no device IDs were programmed

Simon Trimmer (1):
  soundwire: cadence: fix updating slave status when a bus has multiple
    peripherals

 drivers/soundwire/bus.c            | 40 +++++++++++-----
 drivers/soundwire/cadence_master.c | 75 ++++++++++++++++--------------
 2 files changed, 68 insertions(+), 47 deletions(-)

-- 
2.30.2

