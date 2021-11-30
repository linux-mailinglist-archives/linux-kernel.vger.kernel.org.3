Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45755462E02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbhK3H7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:59:48 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54756 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234396AbhK3H7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:59:40 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AU14EoV015278;
        Tue, 30 Nov 2021 08:56:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=Mqq3ToCWT52GJRNMbo7GVjoMhMpJYG/ELdwFs13UoTE=;
 b=LY+sMtQkCt3Co0M5kC4WWBvizO0flWpZl/ltsBl/vIC++pIxawGmvs9a98nvMoXRiNjc
 FCthpBhrhebf2PpM8kwnHhETF29LS6ayp6YjFd4uOqVUvL4qmn6Mg+JsOKS0y9P2p5rm
 KT+o4NqNnxXgf0grWnJ2ZVuTC7G4/jT9kImzqasOM7JY0olFRueGlx5bNePW+GC6mM/b
 wzYLI/n700GCacm9htXdkeaLlYf8E6DmRVpzsw8Jmj5VDSgruCEm3B8kdCgqsp0hpP8K
 9cAHKCyENpJ+KxBRNGYYRw8B5WjTUzjsoTSrc/CMPAxUF3G/7TpaFW3SYhabYPjBZJU+ qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cn9y7sj0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 08:56:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CFAF310002A;
        Tue, 30 Nov 2021 08:56:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C757521A222;
        Tue, 30 Nov 2021 08:56:07 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 30 Nov 2021 08:56:07
 +0100
From:   Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Marek Vasut <marex@denx.de>,
        Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        <linux-crypto@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/9] crypto: stm32/cryp - fix double pm exit
Date:   Tue, 30 Nov 2021 08:54:58 +0100
Message-ID: <20211130075501.21958-7-nicolas.toromanoff@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130075501.21958-1-nicolas.toromanoff@foss.st.com>
References: <20211130075501.21958-1-nicolas.toromanoff@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_06,2021-11-28_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete extraneous lines in probe error handling code: pm was
disabled twice.

Fixes: 65f9aa36ee47 ("crypto: stm32/cryp - Add power management support")

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 06c03db0d11b..3f71d927843c 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -2141,8 +2141,6 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 err_rst:
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
-	pm_runtime_disable(dev);
-	pm_runtime_put_noidle(dev);
 
 	clk_disable_unprepare(cryp->clk);
 
-- 
2.17.1

