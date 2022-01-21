Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF59495E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344794AbiAULND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:13:03 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43412 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231467AbiAULNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:13:00 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LA1t0r029629;
        Fri, 21 Jan 2022 03:12:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=FJF3UNT0Gfz1FUi1XcF7EOtUsmL/+M6KbfUo65TkHKY=;
 b=iQyf14Vn4aV24bfEhN9mC1gaQgIibD2lzj6MphUQj5DEMEAP1KoYvXF/Of0UCNeoAev1
 OTOhwwen0bdZgymJAUCjpCqfh33j/n7xPhMrQGaSgDnP6d3clnIvM782jX9IQBQ+sZWB
 VIesG2p2LUpblaczfAtdSX6xcr/PvjfHY5hjhLqzvFfvIDup2Wi/FBcDN2T42hbemZjB
 gvfU3glUDiIw8+yg4+1vnW/urH5twPRzFLmyEYnmsa37XQQ8qQwgtJb5ZCo1kdLA4Ggx
 vrjzZ/yYTTXFYJwNBOA/MG526ebqcnfXxa82ATyhDuZpmLA1ggZl4KlT4BL8oRoHH+vE Pg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dqj05hq67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 03:12:48 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 21 Jan
 2022 03:12:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 21 Jan 2022 03:12:46 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
        by maili.marvell.com (Postfix) with ESMTP id 081FE3F7097;
        Fri, 21 Jan 2022 03:12:42 -0800 (PST)
From:   Shijith Thotton <sthotton@marvell.com>
To:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     Shijith Thotton <sthotton@marvell.com>,
        <linux-crypto@vger.kernel.org>, <jerinj@marvell.com>,
        <sgoutham@marvell.com>, Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: octeontx2: select CONFIG_NET_DEVLINK
Date:   Fri, 21 Jan 2022 16:42:32 +0530
Message-ID: <41b2f0754d958e2659a88e4c8d005267ef428302.1642763325.git.sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UQHgiLycYaRxusDuZi2NwzkBkfZSmQoO
X-Proofpoint-ORIG-GUID: UQHgiLycYaRxusDuZi2NwzkBkfZSmQoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-21_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OcteonTX2 CPT driver will fail to link without devlink support.

aarch64-linux-gnu-ld: otx2_cpt_devlink.o: in function `otx2_cpt_dl_egrp_delete':
otx2_cpt_devlink.c:18: undefined reference to `devlink_priv'
aarch64-linux-gnu-ld: otx2_cpt_devlink.o: in function `otx2_cpt_dl_egrp_create':
otx2_cpt_devlink.c:9: undefined reference to `devlink_priv'
aarch64-linux-gnu-ld: otx2_cpt_devlink.o: in function `otx2_cpt_dl_uc_info':
otx2_cpt_devlink.c:27: undefined reference to `devlink_priv'

Fixes: fed8f4d5f946 ("crypto: octeontx2 - parameters for custom engine groups")

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/crypto/marvell/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/marvell/Kconfig b/drivers/crypto/marvell/Kconfig
index 9125199f1702..a48591af12d0 100644
--- a/drivers/crypto/marvell/Kconfig
+++ b/drivers/crypto/marvell/Kconfig
@@ -47,6 +47,7 @@ config CRYPTO_DEV_OCTEONTX2_CPT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH
 	select CRYPTO_AEAD
+	select NET_DEVLINK
 	help
 		This driver allows you to utilize the Marvell Cryptographic
 		Accelerator Unit(CPT) found in OcteonTX2 series of processors.
-- 
2.25.1

