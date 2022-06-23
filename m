Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2265572F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiFWGVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiFWGV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:21:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44954326EF;
        Wed, 22 Jun 2022 23:21:26 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LT96G5lFRzSgy9;
        Thu, 23 Jun 2022 14:17:58 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 14:21:19 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 14:21:19 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH v4 0/3] crypto: hisilicon - supports device isolation feature
Date:   Thu, 23 Jun 2022 14:14:49 +0800
Message-ID: <20220623061452.40732-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

1、Add the uacce hardware error isolation interface. 
2、Add related implementation in ACC driver to support uacce interface.
   e.g. Defining the isolation strategy for ACC by uacce sysfs node, if
   the AER error frequency exceeds the value of setting for a certain 
   period of time. The device will not be available in user space. The
   VF device use the PF device isolation strategy. as well as the 
   isolation strategy should not be set during device use.
   
changes v1->v2:
	1、deleted dev_to_uacce api.
	2、add vfs node doc. 
	3、move uacce->ref to driver.
changes v2->v3:
	1、deleted some redundant code.
	2、use qm state instead of reference count.
	3、add null pointer check.
	4、isolate_strategy_read() instead of a copy.
changes v3->v4:
	modify a comment

Kai Ye (3):
  uacce: supports device isolation feature
  Documentation: add a isolation strategy sysfs node for uacce
  crypto: hisilicon/qm - defining the device isolation strategy

 Documentation/ABI/testing/sysfs-driver-uacce |  18 ++
 drivers/crypto/hisilicon/qm.c                | 177 +++++++++++++++++--
 drivers/misc/uacce/uacce.c                   |  41 +++++
 include/linux/hisi_acc_qm.h                  |   9 +
 include/linux/uacce.h                        |  11 ++
 5 files changed, 244 insertions(+), 12 deletions(-)

-- 
2.33.0

