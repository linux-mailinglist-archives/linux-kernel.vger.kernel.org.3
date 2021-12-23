Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D978747DD50
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 02:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbhLWBQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 20:16:54 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:18438 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345825AbhLWBOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 20:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=i32l0pYwrSyAAZKj3vPDSxoH9wI/6IorT8XSw+vG+PQ=;
        b=qXcfaCONpQOEDT+1cGxzzM6O+Hq9xgQvQNC8IgioZj1aqz2RJzpIVd9gVXdwsaYtdeF2
        Wbs6geZ+rJQrZDwOeitskuB6yEJT307phjdcPERrl4yh5319nwKgycSzdK8eIrdXTHMJsP
        2WRvSeHd2hAkXxXXoRXFqjN0PVnuxcwlqwl3jOwhn03DqLVNOo9GRcOMTGmnA/D+2w0HH4
        19kbmo/+kYgQuM5ly7zyuPuB84hTmFyIJSNxL8ZyX3KI5DfNf2Xh1Osaf6KG37Ro9KkLs9
        OhdDenuGga1zAg+QNAo272WjU9JV9OKaHSUZKrHMb7E5WFeuLaUtif1AlagjVW7w==
Received: by filterdrecv-canary-69c6c696bc-fss6r with SMTP id filterdrecv-canary-69c6c696bc-fss6r-1-61C3CD5E-33
        2021-12-23 01:14:06.745349049 +0000 UTC m=+9768540.518210263
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-2-1 (SG)
        with ESMTP
        id OCg6PJjkSGCtTzrY4by5Hw
        Thu, 23 Dec 2021 01:14:06.619 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 986BB7014D4; Wed, 22 Dec 2021 18:14:05 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v2 31/50] wilc1000: eliminate another magic constant
Date:   Thu, 23 Dec 2021 01:14:06 +0000 (UTC)
Message-Id: <20211223011358.4031459-32-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011358.4031459-1-davidm@egauge.net>
References: <20211223011358.4031459-1-davidm@egauge.net>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvECsuSnE8f3tXIemh?=
 =?us-ascii?Q?Wexej=2Fxxnh78Q8DU2R=2Fig=2FtGWIowexxuZl2DaJZ?=
 =?us-ascii?Q?eO3pMmOHOyq2EoHh1bofVI1hSEEeGEYNWeW2kyd?=
 =?us-ascii?Q?6ZCZYvfEFbfjzTNeIkalXZArgwL3grsfNLk1UfV?=
 =?us-ascii?Q?07z6+bCaODMs=2FuXf+az3GmnTHMbX5qD7JQCeTJh?=
 =?us-ascii?Q?fpTeBMcoi9ttQe1Ktw0XA=3D=3D?=
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@kernel.org>,
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

Setting bit 1 of the WILC_HOST_VMM_CTL register seems to tell the chip
that the VMM table has been updated and is ready for processing.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 3 ++-
 drivers/net/wireless/microchip/wilc1000/wlan.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index a4523b0860878..cff70f7d38c89 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -763,7 +763,8 @@ static int send_vmm_table(struct wilc *wilc,
 		if (ret)
 			break;
 
-		ret = func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0x2);
+		ret = func->hif_write_reg(wilc, WILC_HOST_VMM_CTL,
+					  WILC_VMM_TABLE_UPDATED);
 		if (ret)
 			break;
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index f5d32ec93fdb9..11a54320ffd05 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -243,6 +243,7 @@
 
 #define WILC_VMM_ENTRY_COUNT		GENMASK(8, 3)
 #define WILC_VMM_ENTRY_AVAILABLE	BIT(2)
+#define WILC_VMM_TABLE_UPDATED		BIT(1)
 /*******************************************/
 /*        E0 and later Interrupt flags.    */
 /*******************************************/
-- 
2.25.1

