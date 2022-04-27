Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D7C511E65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243422AbiD0QpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243383AbiD0Qoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:44:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C168302;
        Wed, 27 Apr 2022 09:41:41 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KpPYW5p9Nz67PH4;
        Thu, 28 Apr 2022 00:37:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 18:41:39 +0200
Received: from [10.47.81.43] (10.47.81.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 17:41:38 +0100
Message-ID: <ae30cf68-2cf2-4486-3a10-98756fe08226@huawei.com>
Date:   Wed, 27 Apr 2022 17:41:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1] scsi: libsas: Fix array-bounds warnings
To:     Bean Huo <huobean@gmail.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
        <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <beanhuo@micron.com>
References: <20220427133657.55241-1-huobean@gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220427133657.55241-1-huobean@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.81.43]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 14:36, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Use the latest GCC will show below array-bounds warning:

Which version exactly?

> 
> drivers/scsi/libsas/sas_expander.c:1697:39: warning: array subscript ‘struct

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/libsas/sas_expander.c?h=v5.18-rc4#n1679 
is a '}'

What baseline do you use?

> smp_resp[0]’ is partly outside array bounds of ‘unsigned char[56]’ [-Warray-bounds]

I guess that the compiler is getting upset that we're only allocating 32 
bytes for a struct which is 56 bytes in size.

> ...
> drivers/scsi/libsas/sas_expander.c:1781:20: warning: array subscript ‘struct
> smp_resp[0]’ is partly outside array bounds of ‘unsigned char[32]’ [-Warray-bounds]
> ...
> rivers/scsi/libsas/sas_expander.c:1786:39: warning: array subscript ‘struct
> smp_resp[0]’ is partly outside array bounds of ‘unsigned char[32]’ [-Warray-bounds]
> ...
> drivers/scsi/libsas/sas_expander.c:476:35: warning: array subscript ‘struct
> smp_resp[0]’ is partly outside array bounds of ‘unsigned char[32]’ [-Warray-bounds]
> ...
> drivers/scsi/libsas/sas_expander.c:479:38: warning: array subscript ‘struct
> smp_resp[0]’ is partly outside array bounds of ‘unsigned char[32]’ [-Warray-bounds]
> 
> This patch aims to fix these warnings by directly using struct sizes instead of
> macro definitions.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>   drivers/scsi/libsas/sas_expander.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index 260e735d06fa..ac6d9be358c5 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -457,7 +457,7 @@ static int sas_ex_general(struct domain_device *dev)
>   	if (!rg_req)
>   		return -ENOMEM;
>   
> -	rg_resp = alloc_smp_resp(RG_RESP_SIZE);
> +	rg_resp = alloc_smp_resp(sizeof(struct smp_resp));

I'm thinking that it's better to have something like:

struct smp_resp_hdr {
	u8    frame_type;
	u8    function;
	u8    result;
	u8    reserved;
};

struct smp_resp {
	union {
		struct report_general_resp  rg;
		struct discover_resp        disc;
		struct report_phy_sata_resp rps;
	};
} __attribute__ ((packed));


struct report_general_resp {
	struct smp_resp_hdr hdr;
	__be16  change_count;
	__be16  route_indexes;
	...
};

or even also get rid of struct smp_resp holder. Sorry if this is more 
than you bargained for, but I don't mind helping.

Thanks,
John

>   	if (!rg_resp) {
>   		kfree(rg_req);
>   		return -ENOMEM;
> @@ -1688,7 +1688,7 @@ static int sas_get_phy_change_count(struct domain_device *dev,
>   	int res;
>   	struct smp_resp *disc_resp;
>   
> -	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE);
> +	disc_resp = alloc_smp_resp(sizeof(struct smp_resp));
>   	if (!disc_resp)
>   		return -ENOMEM;
>   
> @@ -1766,7 +1766,7 @@ static int sas_get_ex_change_count(struct domain_device *dev, int *ecc)
>   	if (!rg_req)
>   		return -ENOMEM;
>   
> -	rg_resp = alloc_smp_resp(RG_RESP_SIZE);
> +	rg_resp = alloc_smp_resp(sizeof(struct smp_resp));
>   	if (!rg_resp) {
>   		kfree(rg_req);
>   		return -ENOMEM;

