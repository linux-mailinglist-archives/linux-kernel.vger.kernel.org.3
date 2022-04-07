Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC24F7F18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245212AbiDGMeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245178AbiDGMeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:34:05 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE591118F72;
        Thu,  7 Apr 2022 05:32:04 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 237AqVOs030925;
        Thu, 7 Apr 2022 14:31:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=owUEJ7iD+BP82fjCmjwq+zWvle0UiOQCR5A8Eyb+rOQ=;
 b=oLV1pv6MD4SJFRpyMZZrkJJgDup7pVNL85ichA6seb4xdnpQZzQE29TpThs072YbnnwQ
 gJyt65twCWQy3vM2vMCQ/GN6uwQf8Bwt7xyWwSyQnuP0WTSaQ7OiqkLlZwlPvp8D3cwx
 DfIVddAcg3/iH4egEo55BYbBJx7YNnKzeFjXhv0opJiNMRxYvZeH27qzo9ErtJmeaJEV
 p1Oabnj7wJtZkbbmLMWascUhGQrW6l9Z5usXj9JWGT1Q3y301BOY10hi0vZLIWOyRMNi
 4LFekVXMlfY3KzGqqol4hLckVT68UaTSMUGPioiuz9FGAKNQqZCMw+CpICum2DT1fb02 PQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f6du14vyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 14:31:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5A79110002A;
        Thu,  7 Apr 2022 14:31:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5351021A223;
        Thu,  7 Apr 2022 14:31:20 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 7 Apr 2022 14:31:19
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
Subject: [PATCH 0/3] serial: stm32: add earlycon and polling mode
Date:   Thu, 7 Apr 2022 14:31:06 +0200
Message-ID: <20220407123109.132035-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_01,2022-04-07_01,2022-02-23_01
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

Valentin Caron (3):
  serial: stm32: remove infinite loop possibility in putchar function
  serial: stm32: add KGDB support
  serial: stm32: add earlycon support

 .../admin-guide/kernel-parameters.txt         |   6 ++
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/stm32-usart.c              | 101 +++++++++++++++++-
 drivers/tty/serial/stm32-usart.h              |   2 +
 4 files changed, 105 insertions(+), 5 deletions(-)

-- 
2.25.1

