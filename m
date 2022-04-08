Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135E44F95B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiDHM3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbiDHM33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:29:29 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38B633DCA7;
        Fri,  8 Apr 2022 05:27:24 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2389niGA022034;
        Fri, 8 Apr 2022 14:27:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=dTAXQp+cFjdIWlRb6J7G7W0/qZzdDyJ57D7J0I+JRLE=;
 b=2kt2tzQ0xJEwsVv/p6RD8AeVwBts83H5Zwyswg20qjAYuGRw9iUTfj0NW5l1Api1G+Rg
 5XFIUrVWGmpSqKnNdLP7+NNVjCw0EGCWcYEyAPEOmBVGFtc5SWpMA0qBHHDlt2Kd1PFe
 t9yeyWEVKAWzoheBb1/e9DJkwHICxxx4v4wetnX03dmcSmAhz/qMluxOC1AtUWx2Zxrz
 hC10JAYHoAoeaTU3HBQQSP1L45v0tkw+VaukveEvMzcqz6OZIQvVumaumNJl9ZMS7Y1a
 kljROp4Jh58qsRZO2P14ZCwFU5nFu8GS4YZeMAT+2MeaQZUPMPKo7t0Kid330teRwMiV Bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f8x9gu5ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:27:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 04F8C10002A;
        Fri,  8 Apr 2022 14:27:03 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F1FA121A21E;
        Fri,  8 Apr 2022 14:27:02 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 8 Apr 2022 14:27:02
 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH V2 0/3] serial: stm32: add earlycon and polling mode
Date:   Fri, 8 Apr 2022 14:26:33 +0200
Message-ID: <20220408122636.505737-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_04,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add support of early console and polling mode in stm32-usart driver.
- Avoid a possible infinite loop in putchar function.

Changes since v1:
- Fix warning "unused variable 'ret'"

Valentin Caron (3):
  serial: stm32: remove infinite loop possibility in putchar function
  serial: stm32: add KGDB support
  serial: stm32: add earlycon support

 .../admin-guide/kernel-parameters.txt         |   6 ++
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/stm32-usart.c              | 100 +++++++++++++++++-
 drivers/tty/serial/stm32-usart.h              |   2 +
 4 files changed, 104 insertions(+), 5 deletions(-)

-- 
2.25.1

