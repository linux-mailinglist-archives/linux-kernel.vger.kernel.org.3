Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F31B4CD115
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbiCDJeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiCDJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:34:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC874990B;
        Fri,  4 Mar 2022 01:33:47 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K92gx2nNsz67kMk;
        Fri,  4 Mar 2022 17:32:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 10:33:45 +0100
Received: from [10.47.95.117] (10.47.95.117) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 09:33:43 +0000
Message-ID: <4b46e74b-4557-a133-3df8-57305d46375a@huawei.com>
Date:   Fri, 4 Mar 2022 09:33:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/4] scsi: libsas: Add sas_execute_internal_abort_single()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ajish.Koshy@microchip.com>, <linuxarm@huawei.com>,
        <Viswas.G@microchip.com>, <hch@lst.de>, <liuqi115@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
 <1646309930-138960-2-git-send-email-john.garry@huawei.com>
 <1a868ac0-e5bb-7efb-c1f8-eda0b040f5db@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <1a868ac0-e5bb-7efb-c1f8-eda0b040f5db@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.117]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 16:31, Damien Le Moal wrote:
>> +
>> +		wait_for_completion(&task->slow_task->completion);
>> +		res = TMF_RESP_FUNC_FAILED;
>> +
>> +		/* Even if the internal abort timed out, return direct. */
>> +		if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
>> +			pr_err("Internal abort: timeout %016llx\n",
>> +			       SAS_ADDR(device->sas_addr));
>> +
> Nit: blank line not needed here ?

Ok, I can add it.

Thanks,
John

> 
>> +			res = -EIO;
>> +			break;
>> +		}

