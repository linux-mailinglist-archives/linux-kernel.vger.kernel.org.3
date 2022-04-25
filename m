Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCBB50E120
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbiDYNIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbiDYNIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:08:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E72317A8C;
        Mon, 25 Apr 2022 06:04:56 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kn4rT6BqDz67PFg;
        Mon, 25 Apr 2022 21:00:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 15:04:54 +0200
Received: from [10.47.92.213] (10.47.92.213) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 14:04:53 +0100
Message-ID: <1bb53912-c5c3-7690-e82f-cf356ca87404@huawei.com>
Date:   Mon, 25 Apr 2022 14:04:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
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
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <24bfb681-faec-3567-3089-9cd5ee182710@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.213]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
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

On 25/04/2022 10:22, Krzysztof Kozlowski wrote:
> On 25/04/2022 10:58, John Garry wrote:
>> On 20/04/2022 08:03, Christoph Hellwig wrote:
>>>> The standard flow is:
>>>>
>>>> shost = scsi_host_alloc(sht, )
>>>>
>>>> // modify shost, like
>>>> shost->cmd_per_lun = 5;
>>>>
>>>> scsi_add_host(shost)
>>>>
>>>> Is there some reason for which those two drivers can't follow that?
>>> I think they should.  Method tables should not be mutable data.
>>> .
>>
>> Hi Krzysztof,
>>
>> Do you have any interest in going further with your work and trying to
>> change all SCSI driver instances of scsi_host_template to be const? I am
>> not sure if it has been attempted before...
> 
> I can work on this, but what about the SCSI core modifying the template?

I hope that this isn't a can of worms...

> For example scsi_proc_hostdir_rm(): 'present' and 'proc_dir' members.
> Where should they be stored? Should they be moved to the Scsi_Host?
> 

I don't think scsi_Host is appropriate as this is per-scsi host 
template, unless you see a way to do it that way. Alternatively we could 
keep a separate list of registered sht, like this:

struct sht_proc_dir {
	int cnt;
	struct list_head list;
	struct proc_dir_entry *proc_dir;
	struct scsi_host_template *sht;
};
static LIST_HEAD(sht_proc_dir_list);

void scsi_proc_hostdir_add(struct scsi_host_template *sht)
{
	struct sht_proc_dir *dir;

	if (!sht->show_info)
		return;

	mutex_lock(&global_host_template_mutex);
	list_for_each_entry(dir, &sht_proc_dir_list, list) {
		if (dir->sht == sht) {
			dir->cnt++;
			goto out;
		}
	}
	dir = kzalloc(sizeof(*dir), GFP_KERNEL);
	if (!dir)
		goto out;

	dir->proc_dir = proc_mkdir(sht->proc_name, proc_scsi);
	if (!dir->proc_dir) {
		printk(KERN_ERR "%s: proc_mkdir failed for %s\n",
			       __func__, sht->proc_name);
		kfree(dir);
		goto out;
	}

	dir->cnt++;
	list_add_tail(&dir->list, &sht_proc_dir_list);
out:
	mutex_unlock(&global_host_template_mutex);
}

and so on..

--->8---

Thanks,
John
