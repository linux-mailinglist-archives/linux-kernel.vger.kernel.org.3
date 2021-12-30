Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8F848206D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 22:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbhL3Vcb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Dec 2021 16:32:31 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:37448 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhL3Vca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 16:32:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0C10E62DA600;
        Thu, 30 Dec 2021 22:32:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CDWpsNvsvLyP; Thu, 30 Dec 2021 22:32:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 15CA662DA5EE;
        Thu, 30 Dec 2021 22:32:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7LKtuEGIan3H; Thu, 30 Dec 2021 22:32:27 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D76E760CEF32;
        Thu, 30 Dec 2021 22:32:27 +0100 (CET)
Date:   Thu, 30 Dec 2021 22:32:27 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     libaokun <libaokun1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yukuai3 <yukuai3@huawei.com>, Hulk Robot <hulkci@huawei.com>
Message-ID: <1652249414.215435.1640899947744.JavaMail.zimbra@nod.at>
In-Reply-To: <b8f6bbf3-cca4-9bfa-f70a-393f04edd21f@huawei.com>
References: <20211105093022.1360601-1-libaokun1@huawei.com> <7e00eda5-3b35-6d3c-29fb-664b12cca6dd@huawei.com> <509065063.197038.1640293568550.JavaMail.zimbra@nod.at> <b8f6bbf3-cca4-9bfa-f70a-393f04edd21f@huawei.com>
Subject: Re: [PATCH -next V3] ubi: fix race condition between
 ctrl_cdev_ioctl and ubi_cdev_ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: fix race condition between ctrl_cdev_ioctl and ubi_cdev_ioctl
Thread-Index: En5gbrYa7pIAKtQJ78T6QAbo6TQZYg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> kernfs_drain() will wait 'root->deactivate_waitq' if
> atomic_read(&kn->active) not equals to KN_DEACTIVATED_BIAS.
> 
> The UBI seq_show callback is invoked with avtive cnt taken:
> vfs_read
>   kernfs_fop_read_iter
>     seq_read_iter
>       m->op->start (kernfs_seq_start)   // kernfs_get_active(of->kn)
>       kernfs_seq_show
>         dev_attribute_show [ubi]
>       m->op->stop (kernfs_seq_stop)     // kernfs_put_active(of->kn)
> 
> The kernfs_drain() is stuck at wait_event() until sysfs reading
> finished, in my local test.

You are right. This means UBI does this extra check in vain.
Maybe even since ever.

Thanks,
//richard
