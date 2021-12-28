Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2149F48070F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 08:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhL1HsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 02:48:17 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29298 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbhL1HsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 02:48:16 -0500
Received: from kwepemi100003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JNRTZ2K3mzbjgS;
        Tue, 28 Dec 2021 15:47:46 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100003.china.huawei.com (7.221.188.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 15:48:14 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 15:48:13 +0800
Subject: Re: [PATCH -next V3] ubi: fix race condition between ctrl_cdev_ioctl
 and ubi_cdev_ioctl
To:     Richard Weinberger <richard@nod.at>,
        "libaokun (A)" <libaokun1@huawei.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, Hulk Robot <hulkci@huawei.com>
References: <20211105093022.1360601-1-libaokun1@huawei.com>
 <7e00eda5-3b35-6d3c-29fb-664b12cca6dd@huawei.com>
 <509065063.197038.1640293568550.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <b8f6bbf3-cca4-9bfa-f70a-393f04edd21f@huawei.com>
Date:   Tue, 28 Dec 2021 15:48:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <509065063.197038.1640293568550.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/12/24 5:06, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----


>>> ubi_get_device is used to prevent devices from being deleted during
>>> sysfs execution. However, now kernfs ensures that devices will not
>>> be deleted before all reference counting are released.
>>> The key process is shown in the following stack.
> 
> ubi_get_device() in dev_attribute_show() is used to detect whether
> the ubi device got detached while the sysfs file is open.
> 
> Hmm. I thought for sysfs this is not the case since sysfs does not implement
> a release() method. So kernfs_drain_open_files() will return early.
> But there is a good chance that I don't got all kernfs/sysfs details.
> 

kernfs_drain() will wait 'root->deactivate_waitq' if 
atomic_read(&kn->active) not equals to KN_DEACTIVATED_BIAS.

The UBI seq_show callback is invoked with avtive cnt taken:
vfs_read
   kernfs_fop_read_iter
     seq_read_iter
       m->op->start (kernfs_seq_start)   // kernfs_get_active(of->kn)
       kernfs_seq_show
         dev_attribute_show [ubi]
       m->op->stop (kernfs_seq_stop)     // kernfs_put_active(of->kn)

The kernfs_drain() is stuck at wait_event() until sysfs reading 
finished, in my local test.
