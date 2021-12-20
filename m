Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97ACA47A631
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhLTIqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:46:43 -0500
Received: from smtpbg587.qq.com ([113.96.223.105]:55552 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhLTIqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:46:42 -0500
X-QQ-mid: bizesmtp44t1639989968t7wb2b4n
Received: from localhost.localdomain (unknown [118.121.67.96])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 20 Dec 2021 16:46:06 +0800 (CST)
X-QQ-SSF: 01000000002000D0K000B00A0000000
X-QQ-FEAT: oLjQg92dJAVp3em8+MqWTNkdAYduA6RZTPUI2Tm3DatkpSDTMbtXLMRF7WDgn
        /4gmb8mCPZ74uq2K0cyhURJv9pXdNosk4NHfXz1+eDhhY4id/84Dpb3wtLT3pWmPXaWMniE
        f61Oo5mwaU1g6r6hUg2gzFiCLldELnNX+zlxeQ/ofQS4TNJ7CAOy4+2ndhYQKER6fUlb2SH
        Jqfl2GcGiaM724zuTHKDtcWnqSUfo1oSLWBTMpmXWTWNW/ldPyt/JCcBysqDR1Ajig4rIHx
        vuM0biExV+uTFfVylD475UA3NVbVBQMAy6gNQMp1RUduoZCJnNdZ5JiRGVAO3zYnIdtEmnF
        q4boObqsJpL4IQRhSwXaLCd8k+Yb80vxh7Hu5fw3ggX9GEuIMk=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jcmvbkbc@gmail.com
Cc:     chris@zankel.net, davem@davemloft.net, kuba@kernel.org,
        geert@linux-m68k.org, wangborong@cdjrlc.com,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: xtensa: use strscpy to copy strings
Date:   Mon, 20 Dec 2021 16:46:02 +0800
Message-Id: <20211220084602.952091-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy should not be used because it doesn't limit the source
length. So that it will lead some potential bugs.

But the strscpy doesn't require reading memory from the src string
beyond the specified "count" bytes, and since the return value is
easier to error-check than strlcpy()'s. In addition, the implementation
is robust to the string changing out from underneath it, unlike the
current strlcpy() implementation.

Thus, replace strlcpy with strscpy.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/xtensa/platforms/iss/network.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 962e5e145209..e62e31c88956 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -174,7 +174,7 @@ static int tuntap_open(struct iss_net_private *lp)
 
 	memset(&ifr, 0, sizeof(ifr));
 	ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
-	strlcpy(ifr.ifr_name, dev_name, sizeof(ifr.ifr_name));
+	strscpy(ifr.ifr_name, dev_name, sizeof(ifr.ifr_name));
 
 	err = simc_ioctl(fd, TUNSETIFF, &ifr);
 	if (err < 0) {
@@ -249,7 +249,7 @@ static int tuntap_probe(struct iss_net_private *lp, int index, char *init)
 		return 0;
 	}
 
-	strlcpy(lp->tp.info.tuntap.dev_name, dev_name,
+	strscpy(lp->tp.info.tuntap.dev_name, dev_name,
 		sizeof(lp->tp.info.tuntap.dev_name));
 
 	setup_etheraddr(dev, mac_str);
-- 
2.34.1

