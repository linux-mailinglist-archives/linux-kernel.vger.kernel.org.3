Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50E54ED4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiCaHpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiCaHoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:44:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4D9D3AD8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648712587; x=1680248587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mkM93til0d8Xf/m5G1Gpq08peWjVfBoK2vAxwR/OFjo=;
  b=LvAIvXbjTznGAiCJId/ZzTf8Zy7mBMH/ZNzOy9vYwM9kNTtTwjQU4r42
   xPK7UipXtf980vXsehxe3z0IIK00ms9H9A0imq2jVYJ6KgEAmzE2VIqK1
   Fjz4TSX3elM0ev5ZVWBpxmJLOrNBTRugPR0iHxwQKze574IrNiq2R0qBv
   irESvlpqbmB8imHo1SXIq/HUvhJs7ob81Op07er9OLPNjGVMEx9c9bhrZ
   BDp42iXW4bVsqET2E4AtQhz/wdd2DU71552rTwldf2N9fngUw49ve9mnX
   ikRQXDi6IVjCxlUB0EcxNGbpBQA+eHXKrhtPizYk45wbV0VohNlCYNpJI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="346184992"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="346184992"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 00:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="566239933"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by orsmga008.jf.intel.com with ESMTP; 31 Mar 2022 00:43:05 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH 0/2] extend svc and rsu drivers for new RSU DCMF status feature
Date:   Thu, 31 Mar 2022 23:42:36 +0800
Message-Id: <20220331154237.4158001-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4ab174c2-8772-d543-9784-31b4660efd82@kernel.org>
References: <4ab174c2-8772-d543-9784-31b4660efd82@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Patches have been internally reviewed by colleagues at Intel.

Extend Intel Stratix10 service layer and Remote System Update (RSU)
drivers to support new DCMF status reporting.

The status of each DCMF is reported. The currently used DCMF is used as
reference, while the other three are compared against it to determine if
they are corrupted.

DCMF = Decision Configuration Management Firmware
RSU = Remote System Update

Kah Jing Lee (2):
  firmware: stratix10-svc: extend svc to support RSU feature
  firmware: stratix10-rsu: extend RSU driver to get DCMF status

 drivers/firmware/stratix10-rsu.c              | 131 +++++++++++++++++-
 drivers/firmware/stratix10-svc.c              |  19 ++-
 include/linux/firmware/intel/stratix10-smc.h  |  21 +++
 .../firmware/intel/stratix10-svc-client.h     |   7 +-
 4 files changed, 164 insertions(+), 14 deletions(-)

-- 
2.25.1

