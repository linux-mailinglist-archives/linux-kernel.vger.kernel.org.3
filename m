Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D0D4B14C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245445AbiBJR7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:59:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242659AbiBJR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:59:07 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB41F5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:59:07 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21AHwwXi056699;
        Thu, 10 Feb 2022 11:58:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644515939;
        bh=W2eWwT4upuhk7X3RRCMm34zuY1wDQhxcweXdvMP+xXs=;
        h=From:To:CC:Subject:Date;
        b=iPyjIljVZhToZ54m5dqAyQoKPw/SlE5EQXV1KFMAOF2F2HmjUhvS8j/m4zupsm0BG
         SH8lqjbtjPf+7MqvN3VTD/b2/WHkk+hDNJnUP4omXeUkYJeXyxVVH4ej6qqtuk1Crv
         SpPqLtKG7lKahOjV/3bLmmdfBYyRCSk0oWPu7PvI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21AHwwmR095185
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Feb 2022 11:58:58 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 10
 Feb 2022 11:58:58 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 10 Feb 2022 11:58:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21AHwwOr024273;
        Thu, 10 Feb 2022 11:58:58 -0600
From:   Dave Gerlach <d-gerlach@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Dave Gerlach <d-gerlach@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 0/1] firmware: ti_sci: Use polled mode of operation during suspend
Date:   Thu, 10 Feb 2022 11:58:57 -0600
Message-ID: <20220210175858.11247-1-d-gerlach@ti.com>
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
This series allows the ti_sci driver to be able operate safely in noirq
mode.  It depends on the ti-msgmgr series here for updates to the
ti-msgmgr header [1], and together with that series will stop timeouts
that are seen when attempting to suspend platforms using TI SCI.

This allows communication with TISCI firmware without the need of
interrupts, which is critical during the system suspend path. Currently,
the ti_sci_pm_domains genpd driver will communicate with firmware during
the noirq phase, so this must be done using a polled communication
layer, however it still makes sense to use IRQ mode during normal
operation, so continue to support that as well, and only switch to
polled mode during low power path.

This is accomplished in the ti_sci driver by setting a flag to indicate
we are in the suspend path in the system suspend handler that then
causes the message handling logic to manually poll the completion used
to indicate message response using try_wait_for_completion rather than
the original wait_for_completion_timeout, which cannot be used in noirq
phase.

Regards,
Dave

[1] https://lore.kernel.org/lkml/20220210041631.26767-1-d-gerlach@ti.com/

Dave Gerlach (1):
  firmware: ti_sci: Switch transport to polled mode during system
    suspend

 drivers/firmware/ti_sci.c | 61 +++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 6 deletions(-)

-- 
2.35.0

