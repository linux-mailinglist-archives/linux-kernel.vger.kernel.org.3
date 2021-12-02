Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2353465D9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345211AbhLBEx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:53:56 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:39452 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345155AbhLBExd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=sgd; bh=V+rt97Ma1A4UbCvm3uO5ua9m0ulcAqxqdZw+J3rZCwI=;
        b=Lx8UIrjFU4IGIZkzFgTI7JUosgizwYqwCIPY/nVYepOMj5dLL1LoPgnqbOiejr78zR6k
        xhg9ICeX6CEWjSDYHIp2ms5Gc4hCTdCrbQJwsn+8GBoC4L7lfbUuz8OVvW2RpKeGjZl+dJ
        YqkiHGSzzLLy8nIRwUGp/2zuFnNEVndy5iacyXJhM6Y/IZmJ/Yx5+3WZ+cvfSOkspQSHLL
        spvX0BcvNfrzC0QEY12kHNSApG+JMVZuPjtXmZB50o1din512B9i8Ld2O2WhsaUM6QBzmi
        u9AHxjivNs0okSgFWBcDRcIo2kJ8VFo7bIFj3Bb9VE3T4OB+obCqgMWLkQ8n2sKA==
Received: by filterdrecv-64fcb979b9-ds7qn with SMTP id filterdrecv-64fcb979b9-ds7qn-1-61A85080-1A
        2021-12-02 04:50:09.051111042 +0000 UTC m=+6843203.979711569
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-6-0 (SG)
        with ESMTP
        id Zn13KC9PRh2A2BycfNBQfA
        Thu, 02 Dec 2021 04:50:08.802 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 777B9700280; Wed,  1 Dec 2021 21:50:06 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] wilc1000: Add id_table to spi_driver
Date:   Thu, 02 Dec 2021 04:50:09 +0000 (UTC)
Message-Id: <20211202045001.2901903-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvFUO26UYtrY3fq4tZ?=
 =?us-ascii?Q?RSGLd0N8Ue0pAwWsK8z9wfwxmsh=2FJiH7coen+AR?=
 =?us-ascii?Q?S72BgC5KehvSCik7mvkEZyg3FXMvooivqFOjdhw?=
 =?us-ascii?Q?4M0ar4C7BxnET0SjNv9zOm3QmmbZv0Eo3FqTlQx?=
 =?us-ascii?Q?t1ytwJRaDMMqhjYCBZi+Xe47MrPvzqwrBnBGY91?=
 =?us-ascii?Q?Rw9aC4UDv6UMssKGmYeyA=3D=3D?=
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates warning message:

	SPI driver WILC_SPI has no spi_device_id for microchip,wilc1000

and makes device-tree autoloading work.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 640850f989dd..6e7fd18c14e7 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -203,11 +203,18 @@ static const struct of_device_id wilc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wilc_of_match);
 
+static const struct spi_device_id wilc_spi_id[] = {
+	{ "wilc1000", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, wilc_spi_id);
+
 static struct spi_driver wilc_spi_driver = {
 	.driver = {
 		.name = MODALIAS,
 		.of_match_table = wilc_of_match,
 	},
+	.id_table = wilc_spi_id,
 	.probe =  wilc_bus_probe,
 	.remove = wilc_bus_remove,
 };
-- 
2.25.1

