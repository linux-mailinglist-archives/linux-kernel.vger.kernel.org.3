Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73B047E0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347567AbhLWJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:47:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:41987 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347545AbhLWJrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640252841; x=1671788841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4MeEePygCy731OJ/dgMWOY5s5/mfZtr9J852GfPywlE=;
  b=O0btLbEnPFHe2Nesm/9RTyapSGw6No/EwMmc9zK4MOOWUN03h4udVFgQ
   v5trrPCpbEwnzT4zC0X3RspcNDa85Wa6nWSwugbsy7oVBVAnSjVfe0npJ
   kKD7QlDel7KzPhg+Beo++w4h2khciNimbF9pf3YTHvpeIBG2YDoM6Uffv
   EPX4UsLKJpJE9/3E0yft84Sewx2kDM5w6CUtvq5GRQLQqQnaLEpRDTdZL
   ZkrLV9okMuavTdyaZwVz91oLBo/q4syu2ighOjm51nwUrBGVONclRSnwB
   2FeYMd6vQ6/eCsFfBxt3dh92tH17PcjMSYwaGdqVK7i+7FXrg1A0yl3pu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="239549152"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="239549152"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 01:47:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="468484788"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.141])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 01:47:18 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/2] mei: cleanup status before client dma setup call
Date:   Thu, 23 Dec 2021 11:47:05 +0200
Message-Id: <20211223094705.204624-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211223094705.204624-1-tomas.winkler@intel.com>
References: <20211223094705.204624-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The upper layer may retry call to mei_cl_dma_alloc_and_map(),
in that case the client status may be non-zero after the previous call
and the wait condition will be true immediately.
Set cl->status to zero to allow waiting for an actual result
from the firmware.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 96f4e59c32a5..22be86a205bf 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -2327,6 +2327,8 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
 		list_move_tail(&cb->list, &dev->ctrl_rd_list);
 	}
 
+	cl->status = 0;
+
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(cl->wait,
 			   cl->dma_mapped || cl->status,
@@ -2404,6 +2406,8 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
 		list_move_tail(&cb->list, &dev->ctrl_rd_list);
 	}
 
+	cl->status = 0;
+
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(cl->wait,
 			   !cl->dma_mapped || cl->status,
-- 
2.31.1

