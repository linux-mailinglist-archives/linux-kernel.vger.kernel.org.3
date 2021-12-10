Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CE246FD91
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhLJJWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:22:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50628 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239158AbhLJJWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:22:52 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BA8MGn8003616;
        Fri, 10 Dec 2021 10:19:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=GD0iSo1NTLYV7EasCiFxi5eaAvDCn7ZEjTnRKBW5Tus=;
 b=o+UG4VnFhk8QXeC4zOjkOKWogeHRU3Z49ToFV7PUu9ytngitiQHAadYAlf99xc2O1YdJ
 qTsHtmt5/IJuo9XUrDKDXonZLIgQ3nAaWjqgKK9UGo/B3WskCewOIog7i1kP60wFh+CO
 CBxothr50iptMW4QZHaa6Pt2gcgFj4n3z84/b0A4jw92e5qIwUEt0BPFDvdCigK2nKIS
 +ybTaM05cU/Noc8fj6cubz71EmnWzvf7rByGX8hZ98aE0izLJ6s22OCrjlOhtgLqcrP3
 sQqnX4PWqkAd/MjpdQIl+d23FdpcUS8r/JT0AxRmgs8g99sZ1yo+gxZX9EF7GEQOAURZ FQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cv3asrbk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 10:19:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 324E310002A;
        Fri, 10 Dec 2021 10:19:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 26DCC2224BC;
        Fri, 10 Dec 2021 10:19:04 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 10 Dec 2021 10:19:03
 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <loic.pallardy@foss.st.com>
CC:     <yann.gautier@foss.st.com>
Subject: [PATCH] mmc: mmci: add st,stm32-sdmmc2 compatible
Date:   Fri, 10 Dec 2021 10:18:34 +0100
Message-ID: <20211210091834.28958-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_03,2021-12-08_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although this compatible is not used in kernel, as we use the common
MMCI driver, it is used by bootloaders. The U-Boot driver was merged
before the kernel driver and uses this compatible.
To avoid issues when aligning device tree files between kernel and
boot loader, the ST dedicated compatible is added to bindings file.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
index 47595cb483be..eed54bee7665 100644
--- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -53,6 +53,12 @@ properties:
         items:
           - const: arm,pl18x
           - const: arm,primecell
+      - description: Entry for STMicroelectronics variant of PL18x.
+          This dedicated compatible is used by bootloaders.
+        items:
+          - const: st,stm32-sdmmc2
+          - const: arm,pl18x
+          - const: arm,primecell
 
   clocks:
     description: One or two clocks, the "apb_pclk" and the "MCLK"
-- 
2.17.1

