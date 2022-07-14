Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13285574D31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiGNMNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiGNMNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:13:12 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0151A6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:13:12 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E3duVu018136;
        Thu, 14 Jul 2022 05:13:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=dRuLtSGJoQSVRfDNoSBClXepVJNHQ59wCDUFMOuKg0w=;
 b=bThDXqKyTI//EopbKzDTJxkVK2QrRNIYiZmJmoe9Sa5PiqE4qB9W56BwxxpLeIATHTgB
 9O3BFQyTb1K/7t1xdGITg3so7m6sXN3R07XTvHIF+nrErnbnGM5riu14MSLrXY2tYwG9
 3J5CHlZasFcHeGuIlh5OklDWfJRAuxIM9+ipxmHGVJxUJSpKSeupKUk/y3n5St2IQQbH
 NJQv69vbreGa0RvhE9X/b592gNhvtuzzRze9gmiKzqw0va5vS2xiCNRkDk4VBCM2TKuO
 FocFWnLef0mBuAY11xE9hzX0rOmQHqT/In5MhuakI2oNzkYVwh97IDuOTVGAUWBI9fT/ gg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3habegsk39-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 05:13:10 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 14 Jul
 2022 05:12:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 14 Jul 2022 05:12:21 -0700
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id EBF423F704D;
        Thu, 14 Jul 2022 05:12:20 -0700 (PDT)
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     <wbartczak@marvell.com>, <linux-kernel@vger.kernel.org>
CC:     <wbartczak@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        "Piyush Malgujar" <pmalgujar@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH 0/2] Add support for Marvell MHU on CN9x and CN10x SoC
Date:   Thu, 14 Jul 2022 05:12:11 -0700
Message-ID: <20220714121215.22931-1-wbartczak@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nz8yssWuLm-yU06BzGF4yuW0f1vT67Mr
X-Proofpoint-ORIG-GUID: nz8yssWuLm-yU06BzGF4yuW0f1vT67Mr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_10,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support ARM SCMI for the Marvell CN9x, CN10x SoC, add a
generic platform MHU driver based loosely on arm_mhu.c and pcc.c.

Wojciech Bartczak (2):
  dt-bindings: mailbox : marvell,mbox: Add bindings
  mailbox: mvl_mhu: Add support for Marvell Message Handling Unit

 .../mailbox/marvell,mbox-mailbox.yaml         | 112 +++++
 MAINTAINERS                                   |   9 +
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mvl_mhu.c                     | 473 ++++++++++++++++++
 5 files changed, 606 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml
 create mode 100644 drivers/mailbox/mvl_mhu.c

-- 
2.17.1

