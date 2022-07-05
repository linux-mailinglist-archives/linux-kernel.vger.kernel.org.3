Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9CE567294
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiGEP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGEP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:27:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DAF18E28
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:27:15 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LcmgP2Y0mz67Zy6;
        Tue,  5 Jul 2022 23:24:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 5 Jul 2022 17:27:12 +0200
Received: from [10.126.171.232] (10.126.171.232) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 16:27:11 +0100
Message-ID: <5cd65a67-4289-23f7-3bec-c166e96aa9e2@huawei.com>
Date:   Tue, 5 Jul 2022 16:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 4/4] bus: hisi_lpc: Don't guard ACPI IDs with
 ACPI_PTR()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
 <20220705114312.86164-4-andriy.shevchenko@linux.intel.com>
 <f85d13df-b3b9-5cde-6f4c-a68507cedee9@huawei.com>
 <CAHp75Ves4VZHRWGW9hP1cz-Cytx_c2GsK3BHuNiCyRqCufB1Hg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAHp75Ves4VZHRWGW9hP1cz-Cytx_c2GsK3BHuNiCyRqCufB1Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.171.232]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 16:15, Andy Shevchenko wrote:

With a change to the commit message along the line below:

Acked-by: John Garry <john.garry@huawei.com>

> On Tue, Jul 5, 2022 at 5:02 PM John Garry<john.garry@huawei.com>  wrote:
>> On 05/07/2022 12:43, Andy Shevchenko wrote:
>>> The OF is not guarded, neither ACPI needs.
>> This doesn't read well.
> "The OF is not guarded, neither ACPI needs it."
> 
> Better? Otherwise please propose how it can be amended here.

How about "The OF ID table is not guarded, and the ACPI table does not 
needs it either."?

> 
>>> The IDs do not depend
>>> to the configuration. Hence drop ACPI_PTR() from the code and
>>> move ID table closer to its user.
>> Do you need to explicitly include mod_devicetable.h, which has the
>> definition of acpi_device_id?
>>
>> I saw a similar change for another driver and it was claimed that
>> including mod_devicetable.h was required.
> Strictly speaking, yes we need mod_devicetable.h. But of.h and acpi.h
> include it.

acpi.h does not include it for !CONFIG_ACPI, which is the only one which 
I had checked. But now I see that of.h always includes it, so what you 
are doing is ok.

> 
> What you have seen is probably dropping of.h and/or acpi.h completely
> from the user.

Right

> In such cases the mod_devicetable.h is compulsory.

Sure

Thanks,
John
