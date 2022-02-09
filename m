Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398604B0084
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiBIWmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:42:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBIWm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:42:26 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5973C0302E5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:42:28 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219IO5Eg014382;
        Wed, 9 Feb 2022 14:42:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=hMQiRqs/KjGpK7jQuOojlz/5QGP9b+/SM6lN1Yitsxc=;
 b=Tq4JIa4kgIjdc/wcC/2yQGtsULxi3lmmv0FGc3hVBqs+Z2QYGvlAkSeDhwhAEY+rLq3x
 oWhkLPcw5OqFgn5hIODj2Z+LB5wIydZt0Yv9wmnJft+1hTc9ih2pImapBWwJXKZz7u+f
 5OxaJ3u7ZDgKeyoCFS4mqM8BjBOhItmAUIyPw3JF4B+NkTIk2GIiw0Fe8mFwojWLJcPY
 QTK2cJdjzT3YNVzWeGgyX8dEh9ojqYkpto75HSlnOJei8ufiUx22mM2oC/VH4X5AHdQO
 i+iiIzN9m+FykyAlrAJQ6qEhX/OHyyaM1DMIassQf2I5YuhtFu1emrZunN+oMCMTEfw5 GQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3e4am93bx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 14:42:20 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Feb
 2022 14:42:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 14:42:18 -0800
Received: from rchin-dellt430.marvell.com (rchin-dellt430.marvell.com [10.85.176.141])
        by maili.marvell.com (Postfix) with ESMTP id 462283F7092;
        Wed,  9 Feb 2022 14:42:18 -0800 (PST)
From:   Radha Mohan Chintakuntla <radhac@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
        "Radha Mohan Chintakuntla" <radhac@marvell.com>
Subject: [PATCH 0/4] soc: Add support for Marvell OcteonTX2 SDP block
Date:   Wed, 9 Feb 2022 14:42:06 -0800
Message-ID: <20220209224210.153907-1-radhac@marvell.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0CKBYPenCv9z806NvRbUz0UovrAR5ish
X-Proofpoint-ORIG-GUID: 0CKBYPenCv9z806NvRbUz0UovrAR5ish
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_12,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell OcteonTX2's SDP block is a interface for sending and receiving
ethernet packets over the PCIe interface when OcteonTX2 is in PCIe endpoint
mode. It interfaces with the OcteonTX2's NIX block queues.

Radha Mohan Chintakuntla (4):
  soc: octeontx2-sdp: Add SDP PF driver support
  soc: octeontx2-sdp: Add mailbox support
  soc: octeontx2-sdp: Add FLR handling support
  soc: octeontx2-sdp: setup the SDP channel configuration

 MAINTAINERS                                |    7 +
 drivers/soc/Kconfig                        |    1 +
 drivers/soc/Makefile                       |    1 +
 drivers/soc/marvell/Kconfig                |   18 +
 drivers/soc/marvell/Makefile               |    2 +
 drivers/soc/marvell/octeontx2-sdp/Makefile |    9 +
 drivers/soc/marvell/octeontx2-sdp/sdp.c    | 1556 ++++++++++++++++++++
 drivers/soc/marvell/octeontx2-sdp/sdp.h    |   81 +
 8 files changed, 1675 insertions(+)
 create mode 100644 drivers/soc/marvell/Kconfig
 create mode 100644 drivers/soc/marvell/Makefile
 create mode 100644 drivers/soc/marvell/octeontx2-sdp/Makefile
 create mode 100644 drivers/soc/marvell/octeontx2-sdp/sdp.c
 create mode 100644 drivers/soc/marvell/octeontx2-sdp/sdp.h

-- 
2.24.1

