Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845184AF0F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiBIMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiBIMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:05:14 -0500
X-Greylist: delayed 5100 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 03:29:32 PST
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8FAC01CB29
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:29:32 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21996A4i025636;
        Wed, 9 Feb 2022 03:06:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644397570;
        bh=r7jH8XE+VpdBYn1/5uhSsAeZkn6aGmU6l8MnKYf7Mgc=;
        h=From:To:CC:Subject:Date;
        b=X5HUI++SLlyH3VShXylZWGWJsy9v9zaRBCUfeULuq3DBg5XIkXA97TJm80JZ7q/mX
         ScLtMuVt3joV3CWwri+jlHyK4dVPI27QSedSbFFwmBALsJmCNBdG6tXv3M82Jt46Zf
         c35TFuxnvhjvRg5+kTJE6XgaONSaVtr/w18eiXNw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21996ArB112921
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Feb 2022 03:06:10 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 9
 Feb 2022 03:06:09 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 9 Feb 2022 03:06:09 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2199684N040432;
        Wed, 9 Feb 2022 03:06:09 -0600
From:   Puranjay Mohan <p-mohan@ti.com>
To:     <puranjay12@gmail.com>, <kishon@ti.com>, <vigneshr@ti.com>,
        <s-anna@ti.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Puranjay Mohan <p-mohan@ti.com>
Subject: [PATCH v4 0/2] remoteproc sysfs fixes/improvements
Date:   Wed, 9 Feb 2022 14:33:40 +0530
Message-ID: <20220209090342.13220-1-p-mohan@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

[1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20201121030156.22857-1-s-anna@ti.com/[2] https://patchwork.kernel.org/project/linux-remoteproc/patch/20201126210642.897302-4-mathieu.poirier@linaro.org/
[3] https://patchwork.kernel.org/project/linux-remoteproc/cover/20201119140850.12268-1-grzegorz.jaszczyk@linaro.org/

Puranjay Mohan (1):
  remoteproc: Introduce deny_sysfs_ops flag

Suman Anna (1):
  remoteproc: wkup_m3: Set deny_sysfs_ops flag

 drivers/remoteproc/remoteproc_sysfs.c | 18 +++++++++++++++++-
 drivers/remoteproc/wkup_m3_rproc.c    |  1 +
 include/linux/remoteproc.h            |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.17.1

