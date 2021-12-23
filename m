Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3659E47DE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 04:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346273AbhLWD4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 22:56:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29285 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbhLWD4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 22:56:11 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JKGZ90PsgzbjVD;
        Thu, 23 Dec 2021 11:55:45 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 11:56:09 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 11:56:08 +0800
Subject: Re: [PATCH -next] scsi: efct: Use GFP_ATOMIC under spin lock
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <james.smart@broadcom.com>,
        <martin.petersen@oracle.com>
References: <20211221113706.329791-1-yangyingliang@huawei.com>
 <20211221142859.GA30187@lst.de>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <44ff658e-4a00-ee5b-1f84-fa89f9b9291f@huawei.com>
Date:   Thu, 23 Dec 2021 11:56:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20211221142859.GA30187@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/21 22:28, Christoph Hellwig wrote:
> On Tue, Dec 21, 2021 at 07:37:06PM +0800, Yang Yingliang wrote:
>> A spin lock is taken here so we should use GFP_ATOMIC.
>>
>> Fixes: efac162a4e4d ("scsi: efct: Don't pass GFP_DMA to dma_alloc_coherent()")
> No, it does not fix that commit.  The driver did sleeping allocations
> even before the commit.
>
> But wher is "here"?  Can we look into not holding that lock over an
> allocation if it is preferable?  If not we should at least pass down
> the gfp_flags so that only the caller(s) that can't sleep pass GFP_ATOMIC.

According the comment of els_ios_lock, it's used to protect els ios 
list, I think we

can move down the spin lock like this:


--- a/drivers/scsi/elx/libefc/efc_els.c
+++ b/drivers/scsi/elx/libefc/efc_els.c
@@ -46,8 +46,6 @@ efc_els_io_alloc_size(struct efc_node *node, u32 
reqlen, u32 rsplen)

         efc = node->efc;

-       spin_lock_irqsave(&node->els_ios_lock, flags);
-
         if (!node->els_io_enabled) {
                 efc_log_err(efc, "els io alloc disabled\n");
                 spin_unlock_irqrestore(&node->els_ios_lock, flags);
@@ -88,6 +86,8 @@ efc_els_io_alloc_size(struct efc_node *node, u32 
reqlen, u32 rsplen)
                 els = NULL;
         }

+       spin_lock_irqsave(&node->els_ios_lock, flags);
+
         if (els) {
                 /* initialize fields */
                 els->els_retries_remaining = EFC_FC_ELS_DEFAULT_RETRIES;

