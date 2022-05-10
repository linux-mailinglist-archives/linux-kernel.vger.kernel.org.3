Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDF3521079
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiEJJUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiEJJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:20:47 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F34209B49;
        Tue, 10 May 2022 02:16:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24A9GbMA075025;
        Tue, 10 May 2022 04:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652174197;
        bh=7snpbKn5zSFuGNb0yU6RHqm+dmazdYnH7kTAEoqr7IM=;
        h=From:To:CC:Subject:Date;
        b=zC09k5H2n1JRLu8ze2oLLRtaNL4S91zf54O9tqNFXvqpUxNicxtceLdYW8aPU7Crj
         tYk5GMO/jXCL8kR+CtZ3ob9DGuwTnxk4wQ/0nY8EaIpWyQW0MBkl/74j35cEDixFSG
         gwRPjglF2dH7DIJJ1Pkb1ODxqae9Jd9JSLq6EIk0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24A9GbvC026194
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 May 2022 04:16:37 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 10
 May 2022 04:16:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 10 May 2022 04:16:36 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24A9GYeI127131;
        Tue, 10 May 2022 04:16:34 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v2 0/2] Fix cold plugged USB device on certain PCIe USB cards
Date:   Tue, 10 May 2022 14:46:28 +0530
Message-ID: <20220510091630.16564-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cold plugged USB device was not detected on certain PCIe USB cards
(like Inateck card connected to AM64 EVM or connected to J7200 EVM).

Re-plugging the USB device always gets it enumerated.

This issue was discussed in
https://lore.kernel.org/r/772e4001-178e-4918-032c-6e625bdded24@ti.com
and
https://bugzilla.kernel.org/show_bug.cgi?id=214021

So the suggested solution is to register both root hubs along with the
second hcd for xhci.

RFC Patch series can be found at [1]
v1 Patch series can be found at [3]
v2 PATCH series can be found at [4]

Changes from v2:
1) No Change (rebased to latest mainline kernel). V2 was reverted from
mainline after it triggered a race in USB enumeration. Posting the patch
(as attached in https://bugzilla.kernel.org/attachment.cgi?id=300800 after
validating this fixes the issue using TI AM654 IDK EVM).

Changes from RFC:
1) Mathias identified potential issues with the RFC patch [2] and suggested
   the solution to use HCD flags. This series implements it.

Changes from v1:
1) Fixed code comments pointed out by Alan Stern
2) Renamed the HCD flag variable to "HCD_FLAG_DEFER_RH_REGISTER" from
   "HCD_FLAG_DEFER_PRI_RH_REGISTER"

[1] -> https://lore.kernel.org/linux-usb/20210824105302.25382-1-kishon@ti.com/
[2] -> https://lore.kernel.org/linux-usb/06693934-28f2-d59e-b004-62cabd3f9e8e@linux.intel.com
[3] -> https://lore.kernel.org/r/20210825105132.10420-1-kishon@ti.com
[4] -> http://lore.kernel.org/r/20210826111426.751-1-kishon@ti.com

Kishon Vijay Abraham I (2):
  usb: core: hcd: Add support for deferring roothub registration
  xhci: Set HCD flag to defer primary roothub registration

 drivers/usb/core/hcd.c  | 29 +++++++++++++++++++++++------
 drivers/usb/host/xhci.c |  2 ++
 include/linux/usb/hcd.h |  2 ++
 3 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.17.1

