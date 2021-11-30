Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D09462DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbhK3H66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:58:58 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55354 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234260AbhK3H65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:58:57 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AU19X2u026836;
        Tue, 30 Nov 2021 08:55:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=dlwPVVRahJrJmHZdOXPY3D0sp6m5nmpBi68pJQ85Loo=;
 b=I63soly/CBnRrAFwCS0BSEgNgk2FstguC28JdZF2gQ7YwzCwX/7XmlbQCP4fd7uY5b2p
 +KxkQpRr0i4GZ87rugQ6Hsj5pxoM8jy84PD8epYtXoYP6tDn0/c1S3JvjBt5SWyxmQvl
 u1GyWpaNd2UaGH6UYckT10hB5SrlzyuJumEXjJcx2GEQJaNsIqkqvNbZm/VrSRlldRO1
 L2+4vvfIaVVhZKsspHSp6r5E+Yv9q0DbfL5muuxEWNpHfrSVAG8LxZBni6haYLUViKY1
 VxbPIGxCDNOmejrgU8F+h867tN9LHtJD03542qizl4g5Om9j+25cjC+5/g0gxA3lzZwM ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cna1yshsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 08:55:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 60B4910002A;
        Tue, 30 Nov 2021 08:55:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 19B6B2194DA;
        Tue, 30 Nov 2021 08:55:13 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 30 Nov 2021 08:55:12
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
Subject: [PATCH v4 0/9] STM32 CRYP driver: many fixes
Date:   Tue, 30 Nov 2021 08:54:52 +0100
Message-ID: <20211130075501.21958-1-nicolas.toromanoff@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_06,2021-11-28_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This set of patches update the STM32 CRYP driver.

First two update about EPROBE_DEFER management.
Then many fixes to success the cryptomanager EXTRA_TESTS.
And finally we reorder the initialization to set the key as last step.

This patch series applies to cryptodev/master.

v1 -> v2 :
  - use crypto_inc() in "crypto: stm32/cryp - fix CTR counter carry".
  - more explicit commit description.
  - with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y all tests pass, at boot
    if built into kernel, at insmod if in module. (as v1)

v2->v3:
  - fix smatch warning (that was a bug) in "crypto: stm32/cryp - fix bugs
    and crash in tests" add missing parenthesis in mask/shift operation in
    stm32_cryp_write_ccm_first_header(), was only visible in case of aad
    buffer bigger than 65280 bytes.
  - add a new commit to fix lrw chaining mode

v3->v4
  - Fix sparse warning
  - Rebase on cryptodev-2.6/master
  - rework 0004-patch: with v1 correction, the xts extra tests using
    stm32-cryp were still broken.

Etienne Carriere (2):
  crypto: stm32/cryp - defer probe for reset controller
  crypto: stm32/cryp - don't print error on probe deferral

Nicolas Toromanoff (7):
  crypto: stm32/cryp - fix CTR counter carry
  crypto: stm32/cryp - fix xts and race condition in crypto_engine
    requests
  crypto: stm32/cryp - check early input data
  crypto: stm32/cryp - fix double pm exit
  crypto: stm32/cryp - fix lrw chaining mode
  crypto: stm32/cryp - fix bugs and crash in tests
  crypto: stm32/cryp - reorder hw initialization

 drivers/crypto/stm32/stm32-cryp.c | 987 ++++++++++++------------------
 1 file changed, 404 insertions(+), 583 deletions(-)


base-commit: 330507fbc9d8c3bc4525ea2ae9c3774738bc0c80
-- 
2.17.1

