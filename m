Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BCA520054
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbiEIOx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbiEIOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:53:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEEE24D630;
        Mon,  9 May 2022 07:49:24 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KxkTk0NJ3z67Yv4;
        Mon,  9 May 2022 22:44:42 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 16:49:22 +0200
Received: from [10.47.80.57] (10.47.80.57) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 15:49:21 +0100
Message-ID: <fd2cdc06-5d88-306a-3ee1-7aef3e3b8921@huawei.com>
Date:   Mon, 9 May 2022 15:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     "Ewan D. Milne" <emilne@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Doug Gilbert" <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <james.smart@broadcom.com>
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
 <2a88a992-641a-b3ff-fe39-7a61fff87cb6@huawei.com>
 <4c3be5b6-50ef-9e9a-6cee-9642df943342@linaro.org>
 <7b3885e3-dbae-ff0b-21dc-c28d635d950b@huawei.com>
 <c121430b1b5c8f5816b2b42b9178d00889260c90.camel@redhat.com>
 <b6af3fe8-db9a-b5dc-199f-21c05d7664a2@huawei.com>
 <Yl+wJ7xSHzWmR+bR@infradead.org>
 <d09faf74-a52e-8d93-cf26-08b43b12c564@huawei.com>
 <24bfb681-faec-3567-3089-9cd5ee182710@linaro.org>
 <1bb53912-c5c3-7690-e82f-cf356ca87404@huawei.com>
 <6f28acde-2177-0bc7-b06d-c704153489c0@linaro.org>
 <4510c5dc-3d7d-fc5f-cb80-34da7dbaaa8e@huawei.com>
 <d01c29c1-bb5a-281d-ef71-9c7b39e28d23@linaro.org>
In-Reply-To: <d01c29c1-bb5a-281d-ef71-9c7b39e28d23@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.57]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 14:20, Krzysztof Kozlowski wrote:
> On 09/05/2022 13:28, John Garry wrote:
>>
>> For some reason I cannot fetch your git due to "error: RPC failed ..."
>> which I think is a timeout. I seem to have this problem recently
>> whenever a linux.git clone has branches based on linux-next.git . Maybe
>> a git config issue for me...
> 
> Just to be sure - the link was not a git remote, but direct link for a
> web browser. The repo is:
> https://github.com/krzk/linux.git
> branch: n/qcom-ufs-opp-cleanups-v2
> 

OK, I'll double check. Regardless I'll sort my own IT issues :)

>>> However this does not solve the problem. The SHT has "module" which gets
>>> incremented/decremented. Exactly like in case of other drivers
>>> (driver->owner).
>>
>> Ah, I missed that this could be a problem. So we have this member to
>> stop the SCSI host driver being removed when we have disks mounted, etc.
>>
>> But isn't scsi_host_template.module just a pointer to the local driver
>> module data (and that data gets incremented/decremented)? I am looking
>> at the THIS_MODULE definition in export.h:
> 
> Yes, it is just a pointer, just like 'struct device_driver.owner' is.
> 
>>
>> extern stuct module __this_module;
>> #define THIS_MODULE(&__this_module)
>>
>> However I do see scsi_device_dev_release(), which does:
>>
>> sdp->host->hostt->module = NULL
>>
>> I am not sure how necessary that really is. I would need to check further.
> 
>>
>> Did you see if there other places which set hostt->module dynamically?
> 
> I think all SHT set it statically. 

Incidentally I did notice that the ata ahci driver does not set sht->module.

> Then it is being dynamically
> incremented when needed and in scsi_device_dev_release() is being
> nullified (as you mentioned above).
> 
> I guess this SHT->module is actually duplicating what most of drivers
> (e.g. PCI, platform, USB) are doing. If I understand correctly, the
> Scsi_Host is instantiated by the probe of a driver (pci_driver,
> virtio_driver etc), therefore the SHT->module could be simply stored in
> Scsi_Host.

If you check scsi_device_dev_release(), we try to do a 'get' - if it 
fails, then we nullify hostt->module. I think that is important as then 
we call execute_in_process_context(), whose worker does the 'put'. 
However, the 'put' will get upset if the refcnt was 0, which it would be 
if the earlier 'get' fails - hence the nullify is to avoid that 
possibility. So whatever you do needs to handle that. Details are in 
f2b85040

Thanks,
john
