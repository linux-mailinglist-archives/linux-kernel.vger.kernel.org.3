Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0352847959B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbhLQUm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:42:59 -0500
Received: from whuk3.redbackinternet.net ([109.203.107.222]:55066 "EHLO
        whuk3.redbackinternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLQUm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:42:58 -0500
X-Greylist: delayed 1474 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2021 15:42:57 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fbautosys.co.uk; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T090J5GWkAQucJQ7sL3rRUigyVw/j2wBxWDDYEUvlP0=; b=t94NE8jNjd8x6FaY/mehs7u9F3
        QYz4hNQgWB7fPFdmvU8lKPM1xrop0JI/nptrknt5010LuDySKY1JhlJN2g0pLi2gmmv80hX6Q1Ii9
        q3OSF0y1cmVd6bKR4/hAH+5aEbRBwjMLXSCqAHyN2pZPk1bHTMYVFXpjFfqhsHImntmZQlDR5oU9x
        /j6HYlHL20yuY5GY45O1GDot6vmhA8ozevh1bIRZE+96Lq9B2c86LCTmC1RXSl5rkNPsSUCIb6rY+
        WxUgkjCsL92fdb+Q5vh5qA7ZooNZKMYq0tRaCsFIO0rgE6W90lKFqeADSQsjTzQY9vp3U1HFZQrJ/
        5WYP929w==;
Received: from 24.54.187.81.in-addr.arpa ([81.187.54.24]:28253 helo=kernelcomp.corp.firebladeautomationsystems.co.uk)
        by whuk3.redbackinternet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linuxkernel@fbautosys.co.uk>)
        id 1myJgN-0001AJ-Bb; Fri, 17 Dec 2021 20:18:24 +0000
From:   linuxkernel@fbautosys.co.uk
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org
Subject: [RFC PATCH 3/5] Added setting of writemap to formatted write
Date:   Fri, 17 Dec 2021 20:17:56 +0000
Message-Id: <20211217201758.1743750-4-linuxkernel@fbautosys.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217201758.1743750-1-linuxkernel@fbautosys.co.uk>
References: <20211217201758.1743750-1-linuxkernel@fbautosys.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whuk3.redbackinternet.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fbautosys.co.uk
X-Get-Message-Sender-Via: whuk3.redbackinternet.net: authenticated_id: linuxkernel@fbautosys.co.uk
X-Authenticated-Sender: whuk3.redbackinternet.net: linuxkernel@fbautosys.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>

Added regmap_set_work_buf_flag_mask to _regmap_bus_formatted_write
to ensure correct write bit value set when writemask defined

	modified:   drivers/base/regmap/regmap.c

Signed-off-by: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>
---
 drivers/base/regmap/regmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 07d6d804c4b9..ec91eff52465 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1964,6 +1964,9 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 
 	map->format.format_write(map, reg, val);
 
+	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
+					      map->write_flag_mask);
+
 	trace_regmap_hw_write_start(map, reg, 1);
 
 	ret = map->bus->write(map->bus_context, map->work_buf,
-- 
2.25.1

