Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CAB4B82B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiBPIMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:12:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiBPIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:12:51 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BF5B0D2C;
        Wed, 16 Feb 2022 00:12:39 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21G8CaVt091592;
        Wed, 16 Feb 2022 02:12:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644999156;
        bh=KAQc8YkqRT1ouuazoxPakEAsSCwiMEHewqlC7GzcM50=;
        h=From:To:CC:Subject:Date;
        b=AyF6sTSNWEzgqtcXMnga5yQDzHPqM9OAEyaCt8WEXZtXmVgunHJNypfs1416z57GU
         x+8Pp1PtPVX70kTB0fe/mM4a7CyS0L/udhpK/0Ebxmb/R9gYtWjxVIbxEW+TKtRIuC
         qvsgnfNcVSA+ltIDkG3KuLyltDVctRkNcdSiWDt0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21G8CaoA064513
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Feb 2022 02:12:36 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Feb 2022 02:12:36 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Feb 2022 02:12:36 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21G8CYtC032917;
        Wed, 16 Feb 2022 02:12:35 -0600
From:   Puranjay Mohan <p-mohan@ti.com>
To:     <kishon@ti.com>, <vigneshr@ti.com>, <s-anna@ti.com>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Puranjay Mohan <p-mohan@ti.com>
Subject: [PATCH v5 0/2] remoteproc sysfs fixes/improvements
Date:   Wed, 16 Feb 2022 13:42:22 +0530
Message-ID: <20220216081224.9956-1-p-mohan@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

This is a refresh of the patches from an old series [1].
Patch 1 of that series is not required now as [2] serves its purpose.
Patch 2 has been improved and is being posted here.
Patch 3 is unchanged, it has been rebased and posted.

The features being introduced here will be needed by the recently posted PRU 
remoteproc driver [3] in addition to the existing Wkup M3 remoteproc driver.
Both of these drivers follow a client-driven boot methodology, with the latter
strictly booted by another driver in kernel. The PRU remoteproc driver will be
supporting both in-kernel clients as well as control from userspace orthogonally.
The logic though is applicable and useful to any remoteproc driver not using
'auto-boot' and using an external driver/application to boot the remoteproc.

[1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20201121030156.22857-1-s-anna@ti.com/
[2] https://patchwork.kernel.org/project/linux-remoteproc/patch/20201126210642.897302-4-mathieu.poirier@linaro.org/
[3] https://patchwork.kernel.org/project/linux-remoteproc/cover/20201119140850.12268-1-grzegorz.jaszczyk@linaro.org/

Puranjay Mohan (1):
  remoteproc: Introduce sysfs_read_only flag

Suman Anna (1):
  remoteproc: wkup_m3: Set sysfs_read_only flag

 drivers/remoteproc/remoteproc_sysfs.c | 19 ++++++++++++++++++-
 drivers/remoteproc/wkup_m3_rproc.c    |  1 +
 include/linux/remoteproc.h            |  2 ++
 3 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.17.1

