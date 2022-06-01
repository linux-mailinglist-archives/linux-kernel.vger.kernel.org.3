Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE48053A344
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350503AbiFAKwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348534AbiFAKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:52:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6949A49C9A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654080723; x=1685616723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JlKLbXoT9hWnXoIRl8fZAYwcdTzn7lSBMA6ruAvINxY=;
  b=bMYeDFCWfke9flpQN5XZFPyO2dNBtY2CZ47gTXcQ7wpKgNYVqD+OGP9K
   2TgtfczoDvk39OCDys7IE73U4fVvz2E6C5KNby/E6uapvoUbNv7nU55jL
   gmaQA2QSeQREOunyRt1IJQuPWr54mrqDjTkVjlbUQxRuEG8FSLmtT9MzK
   sEQnKnIS/xSvWuFDMfcYUwTDT3IlUhSequvKgMO5MsuN3s8UiFUcRgeSn
   QusckPqDsnBQKiyKX3ZjR3205GkV2HcTJP9RW2XIgX/ctpGkL5+MP/Qvy
   zfsYIvJfmZ2lkmYexpPit/o6unyNxkYA+BxKPa89qyms39ZINrNBnYfex
   g==;
X-IronPort-AV: E=Sophos;i="5.91,268,1647273600"; 
   d="scan'208";a="200736309"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2022 18:52:01 +0800
IronPort-SDR: tyMVNQjmK3Vtit8V0UdXMP6cDgDMLMQGZouDmxuQWnoRXSnYY0OtdI5czMq7aZaC9zEb1IXC5S
 FLg9/EHRAT6G/KchQx+6QLZFUnKwz2+M8KTOZt6XLD86FQuWaccNh/JnGcQJr8a/eQxP+nXiR3
 VQj5tzN0cxNt2ABdKNPw25ZtLJM8fwWkFWA1fxfW34M75/6tfDLUc+xiFQGuJNNvcrvyIYlIGu
 cl9qcyc3q73kQP4GW251DoLzj7VZ19Ghx0MRmLWuTzASiO19ByjJ1F1KOhLI0+c7OW/7g1ECCD
 8yxVCQJVzrzrHqjgblrT+D5t
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 03:11:14 -0700
IronPort-SDR: Bvk7ynEZfxOpD+C1e+5kNvmxDSuzV+H5vpQmDoKnZQIm4K57i+QicNDXaebGkaxFxKoQXybAAC
 rhZv01fdsvG+ozFnR8a9lBSwjTfYTqgXoAcyHZfRMgXfCwY7QEnRkZWipFMGDASNINJdgP6af3
 +awhHemsIvOnwh6Te7Cz39aUnxCJPWI8dIUN/D6XPK9IH3b39P11gkqW1lf1QeG5jNHeG2ZT7s
 HUEeTZ3J4qBNyb8Hzt6l0ckPoH47iRpKeD1atdDAmDwsYcbPBOUeSOA5Yvtw8qnE2DwQRdj9Mj
 Vdk=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jun 2022 03:52:00 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bharat Bhushan <Bharat.Bhushan@nxp.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] bus: fsl-mc-bus: fix KASAN use-after-free in fsl_mc_bus_remove()
Date:   Wed,  1 Jun 2022 19:51:59 +0900
Message-Id: <20220601105159.87752-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fsl_mc_bus_remove(), mc->root_mc_bus_dev->mc_io is passed to
fsl_destroy_mc_io(). However, mc->root_mc_bus_dev is already freed in
fsl_mc_device_remove(). Then reference to mc->root_mc_bus_dev->mc_io
triggers KASAN use-after-free. To avoid the use-after-free, keep the
reference to mc->root_mc_bus_dev->mc_io in a local variable and pass to
fsl_destroy_mc_io().

This patch needs rework to apply to kernels older than v5.15.

Fixes: f93627146f0e ("staging: fsl-mc: fix asymmetry in destroy of mc_io")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org # v5.15+
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..74593a1722fe 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1236,14 +1236,14 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 static int fsl_mc_bus_remove(struct platform_device *pdev)
 {
 	struct fsl_mc *mc = platform_get_drvdata(pdev);
+	struct fsl_mc_io *mc_io;
 
 	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
 		return -EINVAL;
 
+	mc_io = mc->root_mc_bus_dev->mc_io;
 	fsl_mc_device_remove(mc->root_mc_bus_dev);
-
-	fsl_destroy_mc_io(mc->root_mc_bus_dev->mc_io);
-	mc->root_mc_bus_dev->mc_io = NULL;
+	fsl_destroy_mc_io(mc_io);
 
 	bus_unregister_notifier(&fsl_mc_bus_type, &fsl_mc_nb);
 
-- 
2.35.3

