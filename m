Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9EB59E594
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbiHWPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbiHWPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:03:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FD5F47FB;
        Tue, 23 Aug 2022 05:28:46 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MBpLF6v8JzXdcn;
        Tue, 23 Aug 2022 20:23:49 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 20:28:07 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 20:28:06 +0800
Message-ID: <d99ae719-f47d-e9fe-a8b4-cd77b4ea3503@huawei.com>
Date:   Tue, 23 Aug 2022 20:27:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] scsi: increase scsi device's iodone_cnt in scsi_timeout()
Content-Language: en-US
To:     Wenchao Hao <haowenchao22@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Wenchao Hao <haowenchao@huawei.com>
References: <20220815164324.645550-1-haowenchao@huawei.com>
From:   Wu Bo <wubo40@huawei.com>
In-Reply-To: <20220815164324.645550-1-haowenchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/16 0:43, Wenchao Hao wrote:
> The iodone_cnt might be less than iorequest_cnt because
> we did not increase the iodone_cnt when a command is done
> from timeout.
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>   drivers/scsi/scsi_error.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 448748e3fba5..d21ae0090166 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -355,6 +355,7 @@ enum blk_eh_timer_return scsi_timeout(struct request *req)
>   		 */
>   		if (test_and_set_bit(SCMD_STATE_COMPLETE, &scmd->state))
>   			return BLK_EH_RESET_TIMER;
> +		atomic_inc(&scmd->device->iodone_cnt);
>   		if (scsi_abort_command(scmd) != SUCCESS) {
>   			set_host_byte(scmd, DID_TIME_OUT);
>   			scsi_eh_scmd_add(scmd);

Reviewed-by: Wu Bo <wubo40@huawei.com>
-- 
Wu Bo
