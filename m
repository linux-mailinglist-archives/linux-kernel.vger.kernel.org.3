Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D684847C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiADS0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:26:07 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50814 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232106AbiADS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:26:03 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204HuB6Y001936;
        Tue, 4 Jan 2022 19:25:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=x/btSr9lSMElxuR00liFCN3iHyPTwiFT9HmUB+y9nEg=;
 b=6P8WuFkRsYtiurarnviAL0U+BCJ/TbArqnMIEXeOk9jupAFpV/9EIbtvCzapuQ1oD46Z
 35lIQW+mmWIY4bNfHuL6meomn2BvvaHgqDaAJMrCmjTmf0X+GOGInHdAeOgVXV5gjX4f
 HYlNZylTawuaJa51KHqeGaalr06M4Yuxav41SYoThUffC9aCac4fKVhnEi+XeI0695rq
 blhy94iVp9HNCiwLtWtiNcXbS8T81ERsp/AJqjs/fVtCO0AF7Q34aPBMESNzmm5i5prN
 DIPf4odn1tO1BojyR7O26lG7Od5PxPcr5ZbyXUGxkPM6hiEjcq85L+YU/4uzT7wMtHqJ GQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dcu2ug2s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 19:25:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 98CF510002A;
        Tue,  4 Jan 2022 19:25:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 90CB524CB92;
        Tue,  4 Jan 2022 19:25:48 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 4 Jan 2022 19:25:47
 +0100
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Add improvements for STM32 USART DMA TX
Date:   Tue, 4 Jan 2022 19:24:41 +0100
Message-ID: <20220104182445.4195-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_09,2022-01-04_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series reworks STM32 USART DMA TX state management, and fix flow control.

Valentin Caron (4):
  serial: stm32: move tx dma terminate DMA to shutdown
  serial: stm32: rework TX DMA state condition
  serial: stm32: fix flow control transfer in DMA mode
  serial: stm32: correct loop for dma error handling

 drivers/tty/serial/stm32-usart.c | 74 ++++++++++++++++++++++++--------
 drivers/tty/serial/stm32-usart.h |  2 +-
 2 files changed, 56 insertions(+), 20 deletions(-)

-- 
2.17.1

