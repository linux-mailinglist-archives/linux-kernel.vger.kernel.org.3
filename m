Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99964489848
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbiAJMKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:10:47 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16699 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiAJMKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:10:45 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JXXcr4wndzZf4c;
        Mon, 10 Jan 2022 20:07:08 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 20:10:42 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 20:10:42 +0800
Subject: Re: [PATCH -next] scsi: efct: don't use GFP_KERNEL under spin lock
To:     Maurizio Lombardi <mlombard@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <hch@lst.de>,
        <james.smart@broadcom.com>, <martin.petersen@oracle.com>
References: <20220110111838.965480-1-yangyingliang@huawei.com>
 <20220110111921.GA91632@raketa>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <ee058886-5bf0-db3e-7d78-8bc34bfd2440@huawei.com>
Date:   Mon, 10 Jan 2022 20:10:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220110111921.GA91632@raketa>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/1/10 19:19, Maurizio Lombardi wrote:
> On Mon, Jan 10, 2022 at 07:18:38PM +0800, Yang Yingliang wrote:
>> +	spin_lock_irqsave(&node->els_ios_lock, flags);
>> +
>>   	if (els) {
>>   		/* initialize fields */
>>   		els->els_retries_remaining = EFC_FC_ELS_DEFAULT_RETRIES;
> If the els pointer is NULL you will lock the spinlock and disable the interrupts
> for no reason, maybe you can just protect the list_add_tail()?
>
> +spin_lock_irqsave(&node->els_ios_lock, flags);
>   list_add_tail(&els->list_entry, &node->els_ios_list);
> +spin_unlock_irqrestore(&node->els_ios_lock, flags);
Yes, it's better, I will send a v2 later.

Thanks,
Yang
>
> Maurizio
>
> .
