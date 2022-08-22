Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585E859B80C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 05:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiHVDjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 23:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiHVDjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:39:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD0C1EEDD;
        Sun, 21 Aug 2022 20:39:03 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M9yhY2l9xzXdYd;
        Mon, 22 Aug 2022 11:36:45 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 11:39:02 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 11:39:01 +0800
Subject: Re: [PATCH v7 0/3] crypto: hisilicon - supports device isolation
 feature
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
References: <20220806022943.47292-1-yekai13@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
From:   "yekai (A)" <yekai13@huawei.com>
Message-ID: <cffec511-dff2-5951-264a-1e82bb71e183@huawei.com>
Date:   Mon, 22 Aug 2022 11:38:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220806022943.47292-1-yekai13@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/6 10:29, Kai Ye wrote:
> 1、Add the uacce hardware error isolation interface. Supports
>    configures the hardware error isolation frequency.
> 2、Defining the isolation strategy for ACC by uacce sysfs node. If the 
>    number of hardware errors in a per hour exceeds the configured value,
>    the device will not be available in user space. The VF device use the
>    PF device isolation strategy.
>    
> changes v1->v2:
> 	- deleted dev_to_uacce api.
> 	- add vfs node doc. 
> 	- move uacce->ref to driver.
> changes v2->v3:
> 	- deleted some redundant code.
> 	- use qm state instead of reference count.
> 	- add null pointer check.
> 	- isolate_strategy_read() instead of a copy.
> changes v3->v4:
> 	- modify a comment
> changes v4->v5:
> 	- use bool instead of atomic.
> 	- isolation frequency instead of isolation command.
> changes v5->v6:
> 	- add is_visible in uacce.
> 	- add the description of the isolation strategy file node.
> changes v6->v7
> 	- add an example for isolate_strategy in Documentation.
>
> Kai Ye (3):
>   uacce: supports device isolation feature
>   Documentation: add a isolation strategy sysfs node for uacce
>   crypto: hisilicon/qm - define the device isolation strategy
>
>  Documentation/ABI/testing/sysfs-driver-uacce |  26 +++
>  drivers/crypto/hisilicon/qm.c                | 163 +++++++++++++++++--
>  drivers/misc/uacce/uacce.c                   |  58 +++++++
>  include/linux/hisi_acc_qm.h                  |   9 +
>  include/linux/uacce.h                        |  11 ++
>  5 files changed, 255 insertions(+), 12 deletions(-)
>
Hi,

Just a friendly ping...

thanks
Kai

