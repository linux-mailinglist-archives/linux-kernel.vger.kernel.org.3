Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5468349DF09
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiA0KSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:18:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4521 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiA0KSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:18:17 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JkxNs6Bv2z6H8Vc;
        Thu, 27 Jan 2022 18:17:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 27 Jan 2022 11:18:14 +0100
Received: from [10.47.26.192] (10.47.26.192) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 27 Jan
 2022 10:18:13 +0000
Subject: Re: [PATCH 00/16] scsi: libsas and users: Factor out LLDD TMF code
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1893d9ef-042b-af3b-74ea-dd4d0210c493@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <14df160f-c0f2-cc9f-56d4-8eda67969e0b@huawei.com>
Date:   Thu, 27 Jan 2022 10:17:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1893d9ef-042b-af3b-74ea-dd4d0210c493@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.192]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 06:37, Damien Le Moal wrote:

Hi Damien,

> I did some light testing of this series (boot + some fio runs) and
> everything looks good using my "ATTO Technology, Inc. ExpressSAS 12Gb/s
> SAS/SATA HBA (rev 06)" HBA (x86_64 host).

Yeah, unfortunately these steps prob won't exercise much of the code 
changes here since I figure error handling would not kick in.

However using this same adapter type on my arm64 system has error 
handling kick in almost straight away - and the handling looks sane. A 
silver lining, I suppose ..

> 
> Of note is that "make W=1 M=drivers/scsi" complains with:
> 
> drivers/scsi/pm8001/pm80xx_hwi.c:3938: warning: Function parameter or
> member 'circularQ' not described in 'process_one_iomb'

That's per-existing. I'll send a patch for that now along with another 
fix I found for that driver. ....

> 
> And sparse/make C=1 complains about:
> 
> drivers/scsi/libsas/sas_port.c:77:13: warning: context imbalance in
> 'sas_form_port' - different lock contexts for basic block

I think it's talking about the port->phy_list_lock usage - it prob 
doesn't like segments where we fall out a loop with the lock held (which 
was grabbed in the loop). Anyway it looks ok. Maybe we can improve this.

> 
> But I have not checked if it is something that your series touch.
> 
> And there is a ton of complaints about __le32 use in the pm80xx code...
> I can try to have a look at these if you want, on top of your series.

I really need to get make C=1 working for me - it segfaults in any env I 
have :(

Thanks,
John
