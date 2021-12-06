Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1802C469531
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbhLFLrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:47:04 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:9000 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbhLFLrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638790832;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=VjRF/8qBPCLb+EzO9JtX3LOx1wqS7Q+1A9+Qj2blz/M=;
    b=BHVhZvnlXHC2aUa2woZKMgaQNJ+IvWS+nPIbyA52ffZ2JzArh5P9mnnBYZUvG7Tpdz
    8m+g4h3XYjou85B88psxPJjT5AYUWMf/HfQPII0PHQZfZYnT7VXv2ziOud5lej0rpWND
    e+bl66k2FHJy5Vz8hrPPPnFMDrBQgIA+2i3CjYgjnWXWlJYmJnHlGUpu5gl5+40ahcbf
    aKIL88kVobT4IHCHyxVFn7EfG9Qz0+qcXXIYYOWIim3bYwec1CFeT5amsipA/btIQq5x
    yTHngVIkqpSjgzpJjGKJMrGedO5jTKgcGvVIBbTGeZXltCzJ0fCNnf/wLDHd8nJ3dy22
    SFuQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fyL2mYw2"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.34.10 AUTH)
    with ESMTPSA id j03bcbxB6BeV8H5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 6 Dec 2021 12:40:31 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] soc: imx: Register SoC device only on i.MX boards
Date:   Mon,  6 Dec 2021 12:38:28 +0100
Message-Id: <20211206113828.42523-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, using the ARM32 multi_v7_defconfig always results in two
SoCs being exposed in sysfs. This is wrong, as far as I'm aware the
Qualcomm DragonBoard 410c does not actually make use of a i.MX SoC. :)

  qcom-db410c:/sys/devices/soc0$ grep . *
  family:Freescale i.MX
  machine:Qualcomm Technologies, Inc. APQ 8016 SBC
  revision:0.0
  serial_number:0000000000000000
  soc_id:Unknown

  qcom-db410c:/sys/devices/soc1$ grep . *
  family:Snapdragon
  machine:APQ8016
  ...

This happens because imx_soc_device_init() registers the soc device
unconditionally, even when running on devices that do not make use of i.MX.
Arnd already reported this more than a year ago and even suggested a fix
similar to this commit, but for some reason it was never submitted.

Fix it by checking if the "__mxc_cpu_type" variable was actually
initialized by earlier platform code. On devices without i.MX it will
simply stay 0.

Cc: Peng Fan <peng.fan@nxp.com>
Fixes: d2199b34871b ("ARM: imx: use device_initcall for imx_soc_device_init")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/CAK8P3a0hxO1TmK6oOMQ70AHSWJnP_CAq57YMOutrxkSYNjFeuw@mail.gmail.com/
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/soc/imx/soc-imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/imx/soc-imx.c b/drivers/soc/imx/soc-imx.c
index ac6d856ba228..77bc12039c3d 100644
--- a/drivers/soc/imx/soc-imx.c
+++ b/drivers/soc/imx/soc-imx.c
@@ -36,6 +36,10 @@ static int __init imx_soc_device_init(void)
 	int ret;
 	int i;
 
+	/* Return early if this is running on devices with different SoCs */
+	if (!__mxc_cpu_type)
+		return 0;
+
 	if (of_machine_is_compatible("fsl,ls1021a"))
 		return 0;
 
-- 
2.34.1

