Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5661F56B342
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiGHHPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiGHHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:15:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7962C76E97;
        Fri,  8 Jul 2022 00:15:11 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LfPb16tlWzTh9j;
        Fri,  8 Jul 2022 15:11:25 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 15:15:01 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Jul
 2022 15:15:01 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v5 0/3] crypto: hisilicon - supports device isolation feature
Date:   Fri, 8 Jul 2022 15:08:17 +0800
Message-ID: <20220708070820.43958-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1、Add the uacce hardware error isolation interface. Supports
   configures the hardware error isolation frequency.
2、Defining the isolation strategy for ACC by uacce sysfs node. If the 
   number of hardware errors in a per hour exceeds the configured value,
   the device will not be available in user space. The VF device use the
   PF device isolation strategy.
   
changes v1->v2:
	- deleted dev_to_uacce api.
	- add vfs node doc. 
	- move uacce->ref to driver.
changes v2->v3:
	- deleted some redundant code.
	- use qm state instead of reference count.
	- add null pointer check.
	- isolate_strategy_read() instead of a copy.
changes v3->v4:
	- modify a comment
changes v4->v5:
	- use bool instead of atomic.
	- isolation frequency instead of isolation command.

 Documentation/ABI/testing/sysfs-driver-uacce |  18 ++
 drivers/crypto/hisilicon/qm.c                | 163 +++++++++++++++++--
 drivers/misc/uacce/uacce.c                   |  55 +++++++
 include/linux/hisi_acc_qm.h                  |   9 +
 include/linux/uacce.h                        |  11 ++
 5 files changed, 244 insertions(+), 12 deletions(-)

-- 
2.33.0

