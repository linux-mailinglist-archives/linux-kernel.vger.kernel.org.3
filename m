Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C05672CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiGEPi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiGEPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:38:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBD0296
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:38:23 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lcmy56GL3z67Pf9;
        Tue,  5 Jul 2022 23:37:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 17:38:20 +0200
Received: from [10.126.171.232] (10.126.171.232) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 16:38:20 +0100
Message-ID: <08a2a92d-caac-2472-05e0-e6749bcdd15b@huawei.com>
Date:   Tue, 5 Jul 2022 16:38:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 1/4] bus: hisi_lpc: Don't dereference fwnode handle
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
 <ee6b33f5-c5c0-658e-8cf9-61031cd27dca@huawei.com>
 <CAHp75Vf6S0sRSKx8wyhiS6o7c+yKHU_AkYDZXhN_npMDzgi9oA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAHp75Vf6S0sRSKx8wyhiS6o7c+yKHU_AkYDZXhN_npMDzgi9oA@mail.gmail.com>
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

On 05/07/2022 16:23, Andy Shevchenko wrote:
> On Tue, Jul 5, 2022 at 5:11 PM John Garry<john.garry@huawei.com>  wrote:
>> On 05/07/2022 12:43, Andy Shevchenko wrote:
>>> Use dev_fwnode() and acpi_fwnode_handle() instead of dereferencing
>>> an fwnode handle directly.
>> ...which is a better coding practice, right? If so, it would be nice to
>> mention it - well at least I think so.
> Not only. In the case of fwnode it's a long story behind its corner
> case(s) where in the future we might switch from embedded structure to
> linked list, for example, in order to address those corner cases.
> Should I write a paragraph for that as well?
> 

If you just say that it's a better coding practice to use available APIs 
to access structure members rather than access them directly, then that 
is good enough. Or maybe you can think of something better along the 
lines of what you wrote above. My issue is that there was no reason. So 
I'll leave it to you.

> ...
> 
>> Apart from above and nit, below:
> See below my answer.
> 
>> Acked-by: John Garry<john.garry@huawei.com>
> Thanks.
> 
> ...
> 
>>> -     sys_port = logic_pio_trans_hwaddr(&host->fwnode, res->start, len);
>>> +     sys_port = logic_pio_trans_hwaddr(acpi_fwnode_handle(host), res->start, len);
>> nit: currently the driver keeps to the old 80 character line limit.
>> While the rules may have been relaxed, I'd rather we still maintain it.
> First of all, even before the 100 characters era the rule had two exceptions:
> 1) the string literals;

Sure

> 2) the readability over strictness of the 80 characters rule.
> 
> While I agree in general with you, in this case I think keeping
> strictness makes readability worse.

ok, fine. I was going to suggest introduce a varible to hold 
acpi_fwnode_handle(host) but then we may not want a variable of 
fwnode_handle* type hanging around. Anyway I don't feel too strongly 
about it.

Thanks,
John

