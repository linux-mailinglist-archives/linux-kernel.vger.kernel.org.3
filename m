Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B845469C85
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358458AbhLFPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:23:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4214 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345322AbhLFPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:13:33 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J76Jn5y48z67MmS;
        Mon,  6 Dec 2021 23:08:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 6 Dec 2021 16:10:01 +0100
Received: from [10.47.82.161] (10.47.82.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 15:10:00 +0000
Subject: Re: [PATCH] scsi: libsas: Fix a NULL pointer dereference in
 sas_ex_discover_expander()
To:     Zhou Qingyang <zhou1615@umn.edu>
CC:     <kjlu@umn.edu>, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211130171629.201026-1-zhou1615@umn.edu>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b757aabe-5231-64bc-8ad5-cedac79b0f43@huawei.com>
Date:   Mon, 6 Dec 2021 15:09:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211130171629.201026-1-zhou1615@umn.edu>
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

On 30/11/2021 17:16, Zhou Qingyang wrote:

I'd have "scsi: libsas: Improve error handling in 
sas_ex_discover_expander()"

> In sas_ex_discover_expander(), sas_port_alloc() is assigned to phy->port

"sas_port_alloc() is assigned to phy->port" - the function is not assigned

> and used in sas_port_add(). sas_port_add() further passes phy->port to
> list_empty(), and there is a dereference of it in list_empty(), which
> could lead to a NULL pointer dereference on failure of
> sas_port_alloc().
> 
> This patch imitates the same error-handling logic in
> sas_ex_discover_end_dev().

git grep 'This patch' Documentation/process/submitting-patches.rst

> 
> Fix this bug by adding checks for phy->port and sas_port_add().
> 
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.

Who are these researchers?

> 
> Builds with CONFIG_SCSI_SAS_LIBSAS=m show no new warnings,
> and our static analyzer no longer warns about this code.

This is all implied by sending the patch in the first place

> 
> Fixes:  2908d778ab3e ("[SCSI] aic94xx: new driver")

personally I don't think that this is a fix - the code is old and 
already had BUG_ON()

> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>   drivers/scsi/libsas/sas_expander.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index c2150a818423..7530b1773d6b 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -957,9 +957,16 @@ static struct domain_device *sas_ex_discover_expander(
>   		return NULL;
>   
>   	phy->port = sas_port_alloc(&parent->rphy->dev, phy_id);
> -	/* FIXME: better error handling */
> -	BUG_ON(sas_port_add(phy->port) != 0);
> +	if (unlikely(!phy->port)) {

no need for unlikely() - this is not fastpath

> +		sas_put_device(child);
> +		return NULL;
> +	}
>   
> +	if (sas_port_add(phy->port) != 0) {
> +		sas_port_free(phy->port);
> +		sas_put_device(child);

better have a goto error now as we're replicting code, including what is 
already there for the sas_discover_expander() failure error path

> +		return NULL;
> +	}
>   
>   	switch (phy->attached_dev_type) {
>   	case SAS_EDGE_EXPANDER_DEVICE:
> 

