Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68783595AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiHPL4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiHPLy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:54:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B6F1FC;
        Tue, 16 Aug 2022 04:33:39 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M6TRy3SbYz67tfn;
        Tue, 16 Aug 2022 19:28:46 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 13:33:36 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 12:33:34 +0100
From:   John Garry <john.garry@huawei.com>
To:     <lenb@kernel.org>, <rafael@kernel.org>, <andy.shevchenko@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH PoC 0/3] ACPI/PNP/HISI_LPC: Refactor ACPI platform code for reuse
Date:   Tue, 16 Aug 2022 19:27:21 +0800
Message-ID: <1660649244-146842-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to refactor the ACPI platform device creation code
such that it may reused in the HiSilicon LPC driver. The topic was
recently discussed at the following:
https://lore.kernel.org/lkml/CAJZ5v0hkiOqhWyOcd2vjj-tcyHWB-cK=Dae-3sifhRfcbKWWGg@mail.gmail.com/

So first off I'll say that I am not advocating pursing the changes in this
series, but just wanted to share to show others how it would look.

Apart from requiring PNP driver changes, the API in
acpi_create_platform_device_ops() ain't pretty. And also the PNP change
means that the LPC uart changes from ttyS1 -> ttyS0, which would be a
nuisance for anyone still using a board which uses the LPC UART.

I have a separate change to show how the HiSilicon LPC driver would look
by using platform_device_register_full() instead, and it is a lot neater:
https://github.com/hisilicon/kernel-dev/commits/private-topic-lpc-6.0-platform-full

Anyway, the commit messages should describe anything else needed to be
known.

Please share any comments, thanks.

John Garry (3):
  ACPI / PNP: Don't add enumeration_by_parent devices
  ACPI: platform: Refactor acpi_create_platform_device()
  bus: hisi_lpc: Use acpi_create_platform_device_ops()

 drivers/acpi/acpi_platform.c |  37 ++++++--
 drivers/bus/hisi_lpc.c       | 165 +++++++++++++++--------------------
 drivers/pnp/pnpacpi/core.c   |  13 ++-
 include/linux/acpi.h         |  17 +++-
 4 files changed, 122 insertions(+), 110 deletions(-)

-- 
2.35.3

