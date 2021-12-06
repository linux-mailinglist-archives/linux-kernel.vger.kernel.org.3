Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29EE4696D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbhLFNZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:25:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4210 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244369AbhLFNZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:25:57 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J73wg37xqz6899d;
        Mon,  6 Dec 2021 21:21:23 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 14:22:27 +0100
Received: from [10.47.82.161] (10.47.82.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 13:22:26 +0000
Subject: Re: [PATCH 1/3] scsi: hisi_sas: Use devm_bitmap_zalloc() when
 applicable
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <4afa3f71e66c941c660627c7f5b0223b51968ebb.1637961191.git.christophe.jaillet@wanadoo.fr>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d1837f2b-2a04-0231-4ccd-1d1118afa595@huawei.com>
Date:   Mon, 6 Dec 2021 13:22:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <4afa3f71e66c941c660627c7f5b0223b51968ebb.1637961191.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.161]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 21:15, Christophe JAILLET wrote:
> 'hisi_hba->slot_index_tags' is a bitmap. So use 'devm_bitmap_zalloc()' to
> simplify code, improve the semantic and avoid some open-coded arithmetic
> in allocator arguments.
> 
> Signed-off-by: Christophe JAILLET<christophe.jaillet@wanadoo.fr>

Acked-by: John Garry <john.garry@huawei.com>

> ---
> The use of 's' is questionable here. I've left it because it looks more
> consistent this way with the surrounding code.
> 
> Can it be an issue to have the length of the allocated bitmap not being
> a multiple of sizeof(long)?

The driver does not rely on that (allocated bitmap being a multiple of 
sizeof(long)), but the size is 4096 bits, which would be a multiple of 
sizeof(long)

Thanks,
John

> I guess that there is some kind of 'rounding' done by the memory allocator
> to keep some alignment, so I think that the previous code is safe (but not
> logical).
> If this is not the case, there is a potential out of bound bug related to
> the bitmap API that expect to access only longs (which is not necessarily
> the case here).

