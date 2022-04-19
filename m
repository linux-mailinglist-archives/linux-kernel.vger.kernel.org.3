Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC61B506742
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350206AbiDSI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350182AbiDSI4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:56:55 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69AE22BC4;
        Tue, 19 Apr 2022 01:54:12 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23J2apKu015687;
        Tue, 19 Apr 2022 10:53:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=eHr3F+Xv2EITeA1KgzRFAN3eKCVv1CZzksOJ3A+aaSg=;
 b=slpjVlI6SYeJa4otSGHIrOyP2hdTU0VBH45RXqIcEDX+NHtn/LA4Wo9z4kgn9nq3tRp/
 bglEWi0h26kYRGAIWgb5R2wEY0UEB1wlosDDi/MQZW/QSyO4UctCr6fQ7kVdN9isiVMA
 gTjEHU5NL/VhDIPeYhfxpS+wIz0D7jDWRpxzfiA+5fVMINS0r5dOdObp/gPmOvxCKy96
 71L3z6GuRfIQT3pfEsTv8PPQ8vQ5cvkfAOMOK+4Hb4GPJsK0ZDWrogxQPp7iV5b47kbK
 62kiXRhmjrRs3k5LvN6QcPjW+yJg8U2aFj0wgPE8zefW82qrKvulrw1l/Lb7sQ1pd2HC hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ffpqdmvq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:53:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AEC0110002A;
        Tue, 19 Apr 2022 10:53:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A749C2053D3;
        Tue, 19 Apr 2022 10:53:46 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 19 Apr 2022 10:53:46
 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 0/3] serial: stm32: add earlycon and polling mode
Date:   Tue, 19 Apr 2022 10:53:27 +0200
Message-ID: <20220419085330.1178925-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_03,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add support of early console and polling mode in stm32-usart driver.
- Avoid a possible infinite loop in putchar function.

Changes since v2:
- Do not add "stm32" parameter in kernel-parameters.txt 

Changes since v1:
- Fix warning "unused variable 'ret'"

Valentin Caron (3):
  serial: stm32: remove infinite loop possibility in putchar function
  serial: stm32: add KGDB support
  serial: stm32: add earlycon support

 drivers/tty/serial/Kconfig       |   1 +
 drivers/tty/serial/stm32-usart.c | 100 +++++++++++++++++++++++++++++--
 drivers/tty/serial/stm32-usart.h |   2 +
 3 files changed, 98 insertions(+), 5 deletions(-)

-- 
2.25.1

