Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF1F4B3D52
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiBMUPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:15:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiBMUPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:15:21 -0500
X-Greylist: delayed 139 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 12:15:15 PST
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D12532DE;
        Sun, 13 Feb 2022 12:15:14 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCnLN017971;
        Sun, 13 Feb 2022 14:12:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644783169;
        bh=fXdzgJr4bmKoEdXDCQvT/8aohJq0rCxwYgWBdYInjpE=;
        h=From:To:CC:Subject:Date;
        b=f9k9O9kA5pKDBbfbfWvc0mkMbCiYi1YlvIM3KmgKrlMwiXx8DjnP9tDtOPCJvlQzY
         T06g8DxrXHrtfaSh6/VbR/PrXm6m6Kmw6du5EXPTTsk6m5ET2t2oZNWOH8UQqKl9Tx
         f6mkgBZjiyHsBwUJmrqj4y8qvsxCR37oK7byDqUU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21DKCna4112350
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 13 Feb 2022 14:12:49 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 13
 Feb 2022 14:12:49 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 13 Feb 2022 14:12:48 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCn9a022100;
        Sun, 13 Feb 2022 14:12:49 -0600
Received: from localhost ([10.249.37.221])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 21DKCnul002408;
        Sun, 13 Feb 2022 14:12:49 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Hari Nagalla <hnagalla@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 0/5] K3 R5F & DSP IPC-only mode support
Date:   Sun, 13 Feb 2022 14:12:41 -0600
Message-ID: <20220213201246.25952-1-s-anna@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following is a revised version (v3) of the series that adds the
IPC-only mode support for the TI K3 R5F and DSP (C66x and C71x) remoteprocs
covering AM65x, J721E, J7200, AM64x and the recently added J721S2 SoCs.
Patches are on top of 5.17-rc2 (since rproc-next is baselined on rc2).

Please see the v1 cover-letter [1] for the design details of the
'IPC-only' mode functionality.

The following are the main changes w.r.t v2 [2], please see the individual
patches for the exact deltas:
 - The first patch in v2 "remoteproc: Add support for detach-only during
   shutdown" is dropped
 - Added a new "remoteproc: Change rproc_shutdown() to return a status"
   patch as the first patch in v3.
 - Adjusted the K3 R5F and DSP remoteproc drivers to invoke
   rproc_detach() in the case of IPC-only mode during teardown

The following is a summary of patches in v3:
 - Patch 1 enhances the remoteproc core to return a status for
   rproc_shutdown() that is in turn returned in the sysfs and cdev
   interfaces. This replaces the flag-based logic in v2 and is used to
   return an error for K3 SoCs that don't supply a .stop() ops in
   IPC-only mode.
 - Patches 2 and 4 refactor the mailbox request code out of start
   in the K3 R5F and DSP remoteproc drivers for reuse in the new attach
   callbacks.
 - Patch 3 adds the IPC-only mode support for R5F.
 - Patch 5 adds the IPC-only mode support for both K3 C66x and C71x
   DSPs.

I have re-verified the different combinations on J721E, J7200 and AM65x
SoCs. AM64x currently lacks early-boot support, but the logic is ready
for Single-CPU and Split modes that are specific to AM64x SoCs. J721S2
doesn't have either early-boot support yet, and the dts nodes are also
not added yet, but I have tested locally using additional patches.

regards
Suman

[1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20210522000309.26134-1-s-anna@ti.com/
[2] https://patchwork.kernel.org/project/linux-remoteproc/cover/20210723220248.6554-1-s-anna@ti.com/

Suman Anna (5):
  remoteproc: Change rproc_shutdown() to return a status
  remoteproc: k3-r5: Refactor mbox request code in start
  remoteproc: k3-r5: Add support for IPC-only mode for all R5Fs
  remoteproc: k3-dsp: Refactor mbox request code in start
  remoteproc: k3-dsp: Add support for IPC-only mode for all K3 DSPs

 Documentation/staging/remoteproc.rst      |   3 +-
 drivers/remoteproc/remoteproc_cdev.c      |   2 +-
 drivers/remoteproc/remoteproc_core.c      |   9 +-
 drivers/remoteproc/remoteproc_sysfs.c     |   2 +-
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 208 ++++++++++++----
 drivers/remoteproc/ti_k3_r5_remoteproc.c  | 287 +++++++++++++++++++---
 include/linux/remoteproc.h                |   2 +-
 7 files changed, 431 insertions(+), 82 deletions(-)

-- 
2.32.0

