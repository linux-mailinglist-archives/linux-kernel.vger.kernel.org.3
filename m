Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781D247E8E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 22:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350311AbhLWVGM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Dec 2021 16:06:12 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:58738 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245175AbhLWVGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 16:06:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1E40F62DA5F6;
        Thu, 23 Dec 2021 22:06:10 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HYtd7jlW3cum; Thu, 23 Dec 2021 22:06:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CDAF962DA606;
        Thu, 23 Dec 2021 22:06:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m-sTyrv93os1; Thu, 23 Dec 2021 22:06:08 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id A94BD62DA5F6;
        Thu, 23 Dec 2021 22:06:08 +0100 (CET)
Date:   Thu, 23 Dec 2021 22:06:08 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     "libaokun (A)" <libaokun1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Message-ID: <509065063.197038.1640293568550.JavaMail.zimbra@nod.at>
In-Reply-To: <7e00eda5-3b35-6d3c-29fb-664b12cca6dd@huawei.com>
References: <20211105093022.1360601-1-libaokun1@huawei.com> <7e00eda5-3b35-6d3c-29fb-664b12cca6dd@huawei.com>
Subject: Re: [PATCH -next V3] ubi: fix race condition between
 ctrl_cdev_ioctl and ubi_cdev_ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: fix race condition between ctrl_cdev_ioctl and ubi_cdev_ioctl
Thread-Index: slnxfsVHQxu1KgdXyEQFACaCLfZ3WA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "libaokun (A)" <libaokun1@huawei.com>
> 在 2021/11/5 17:30, Baokun Li 写道:
> 
> ping

Thanks for your patience.
 
>> Hulk Robot reported a KASAN report about use-after-free:

[...]

>> The cause of this problem is that commit 714fb87e8bc0 make device
>> "available" before it becomes accessible via sysfs. Therefore, we
>> roll back the modification. We will fix the race condition between
>> ubi device creation and udev by removing ubi_get_device in
>> vol_attribute_show and dev_attribute_show.This avoids accessing
>> uninitialized ubi_devices[ubi_num].
>>
>> ubi_get_device is used to prevent devices from being deleted during
>> sysfs execution. However, now kernfs ensures that devices will not
>> be deleted before all reference counting are released.
>> The key process is shown in the following stack.

ubi_get_device() in dev_attribute_show() is used to detect whether
the ubi device got detached while the sysfs file is open.

Hmm. I thought for sysfs this is not the case since sysfs does not implement
a release() method. So kernfs_drain_open_files() will return early.
But there is a good chance that I don't got all kernfs/sysfs details.

Thanks,
//richard
