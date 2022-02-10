Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F4D4B0476
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiBJE1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:27:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiBJE1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:27:32 -0500
X-Greylist: delayed 659 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 20:27:33 PST
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B179A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 20:27:33 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21A4GW6N117624;
        Wed, 9 Feb 2022 22:16:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644466592;
        bh=wl1jodj5fPjhC0yPo2D/vQGD182csag7sbFSOi/fqOg=;
        h=From:To:CC:Subject:Date;
        b=MYybBAegyUmaZbHatHONTB/CbC8paJhUdZ9k7d791Oiua1fVrQ3/TpsW/i6uG3E1L
         Cn7bIsuf4Ds/Gy226l3dtQ9p1sbZwLReByt6cN3YpBEvIkDlkWXzU5qsxk4HjtwFUj
         KAL8Oa12oF9DskFJA4vWmsCwRsihHRrkUGltI/fk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21A4GWa1122746
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Feb 2022 22:16:32 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 9
 Feb 2022 22:16:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 9 Feb 2022 22:16:31 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21A4GV4U104906;
        Wed, 9 Feb 2022 22:16:31 -0600
From:   Dave Gerlach <d-gerlach@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Dave Gerlach <d-gerlach@ti.com>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 0/2] mailbox: ti-msgmgr: Use polled mode of operation during suspend
Date:   Wed, 9 Feb 2022 22:16:29 -0600
Message-ID: <20220210041631.26767-1-d-gerlach@ti.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This series switches the ti-msgmgr driver to operate in polled mode
during system suspend rather than the current IRQ driven operation.
This allows users of this mailbox, such as the ti_sci firmware driver,
to communicate with TISCI firmware without the need of interrupts, which
is critical during the system suspend path.  Currently, the
ti_sci_pm_domains genpd driver will send messages to disable devices
during the noirq phase, so this must be done using a polled
communication layer. It still makes sense to use IRQ mode during normal
operation, so continue to support that as well, and only switch to
polled mode during low power path.

This is accomplished by setting a flag for polled mode in the system
suspend handler that then causes the driver to immediately poll a
mailbox RX channel in the send_data mailbox op, which will either
timeout and return or follow the normal mailbox flow and call
mbox_chan_received_data before returning from mbox_send_message.

These changes do not affect the normal operation of the ti-msgmgr driver
and are transparent outside of the system suspend path. The suspend path
already sees timeouts with messages sent during noirq phase today and
will continue to until a follow on patch for the ti_sci driver is sent
to make communication completely safe during noirq, but this series can
be merged without affecting operation.

Regards,
Dave

Dave Gerlach (2):
  mailbox: ti-msgmgr: Refactor message read during interrupt handler
  mailbox: ti-msgmgr: Operate mailbox in polled mode during system
    suspend

 drivers/mailbox/ti-msgmgr.c      | 181 ++++++++++++++++++++++++-------
 include/linux/soc/ti/ti-msgmgr.h |   8 +-
 2 files changed, 147 insertions(+), 42 deletions(-)

-- 
2.35.0

