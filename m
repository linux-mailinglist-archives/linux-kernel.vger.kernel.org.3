Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA824FD8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391143AbiDLJ21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381855AbiDLIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:24:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9ED56203;
        Tue, 12 Apr 2022 00:57:50 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KcyhJ1rfkz67xbc;
        Tue, 12 Apr 2022 15:55:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 09:57:45 +0200
Received: from [10.47.91.197] (10.47.91.197) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 08:57:44 +0100
Message-ID: <b6af3fe8-db9a-b5dc-199f-21c05d7664a2@huawei.com>
Date:   Tue, 12 Apr 2022 08:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
To:     "Ewan D. Milne" <emilne@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Doug Gilbert" <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <james.smart@broadcom.com>
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
 <2a88a992-641a-b3ff-fe39-7a61fff87cb6@huawei.com>
 <4c3be5b6-50ef-9e9a-6cee-9642df943342@linaro.org>
 <7b3885e3-dbae-ff0b-21dc-c28d635d950b@huawei.com>
 <c121430b1b5c8f5816b2b42b9178d00889260c90.camel@redhat.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <c121430b1b5c8f5816b2b42b9178d00889260c90.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.197]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 20:31, Ewan D. Milne wrote:
> On Fri, 2022-04-08 at 13:57 +0100, John Garry wrote:
>> On 08/04/2022 13:32, Krzysztof Kozlowski wrote:
>>> On 08/04/2022 14:14, John Garry wrote:
>>>> On 08/04/2022 11:30, Krzysztof Kozlowski wrote:
>>>>> Several pointers to 'struct scsi_host_template' do not modify it, so
>>>>> made them const for safety.
>>>>>
>>>> Is this standard practice? What is so special here?
>>> This is standard practice and there is nothing special here. Pointers to
>>> const are preferred because:
>>> 1. They add safety if data is actually const. This is not yet the case,
>>> but scsi_host_template allocation could be made const with some effort.
> 
> This seems unlikely, because some drivers, e.g. vmw_pvscsi and scsi_debug,
> modify the scsi_host_template based on things like module parameters.
>

The standard flow is:

shost = scsi_host_alloc(sht, )

// modify shost, like
shost->cmd_per_lun = 5;

scsi_add_host(shost)

Is there some reason for which those two drivers can't follow that?

>>
>> To me this seems better, but I think that some drivers might modify
>> their scsi_host_template (so not possible)
> 
> Several drivers modify scsi_host_template, e.g. .can_queue, .cmd_per_lun
> 
> There is also code in lpfc_create_port() that initializes a scsi_host_template
> that is embedded in the lpfc_hba struct.  I don't think it gets modified after
> scsi_add_host() but it seems like driver maintainers might expect to be able
> to do so, in general.
> 

Even so, I don't see why other drivers cannot declare their 
scsi_host_template as const. C would have no problem with sht not be 
being const for this:

struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, )

thanks,
John
