Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D25AA843
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiIBGql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiIBGqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:46:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552A6BC813
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:46:38 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJpJ63Cl0z67Zm5;
        Fri,  2 Sep 2022 14:42:46 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 08:46:35 +0200
Received: from [10.195.34.23] (10.195.34.23) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 2 Sep
 2022 07:46:35 +0100
Message-ID: <e6ded6f5-7132-e6e3-1f91-12deeb3b12ff@huawei.com>
Date:   Fri, 2 Sep 2022 07:46:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 5/5] bus: hisi_lpc: Use platform_device_register_full()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "xuwei (O)" <xuwei5@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <1662030871-182688-1-git-send-email-john.garry@huawei.com>
 <1662030871-182688-6-git-send-email-john.garry@huawei.com>
 <CAHp75Vcg79sZjv24DD3ZhYf9aC-zoEZ59gfagS1Jw1-GYhpQug@mail.gmail.com>
In-Reply-To: <CAHp75Vcg79sZjv24DD3ZhYf9aC-zoEZ59gfagS1Jw1-GYhpQug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.34.23]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 18:47, Andy Shevchenko wrote:
>> +                                       .name = "hisi-lpc-ipmi",
>> +                                       .id = PLATFORM_DEVID_AUTO,
>> +
>> +                                       .res = res,
>> +                                       .num_res = num_res,
>> +                               },
> ...here and in the other cases you have a lot of blank lines, can we
> just get rid of them?

ok

> 
>> +                       },
>>                  },
>>                  /* 8250-compatible uart */
>>                  {
>>                          .hid = "HISI1031",
>> -                       .name = "serial8250",
>> -                       .pdata = (struct plat_serial8250_port []) {
>> +                       .pdevinfo = (struct platform_device_info []) {
>>                                  {
>> -                                       .iobase = res->start,
>> -                                       .uartclk = 1843200,
>> -                                       .iotype = UPIO_PORT,
>> -                                       .flags = UPF_BOOT_AUTOCONF,
>> +                                       .parent = hostdev,
>> +                                       .fwnode = acpi_fwnode_handle(child),
>> +
>> +                                       .name = "serial8250",
>> +                                       .id = PLATFORM_DEVID_AUTO,
>> +
>> +                                       .res = res,
>> +                                       .num_res = num_res,
>> +
>> +                                       .data = (struct plat_serial8250_port []) {
>> +                                               {
>> +                                                       .iobase = res->start,
>> +                                                       .uartclk = 1843200,
>> +                                                       .iotype = UPIO_PORT,
>> +                                                       .flags = UPF_BOOT_AUTOCONF,
>> +                                               },
>> +                                               {}
>> +                                       },
>> +                                       .size_data =  2 *
>> +                                               sizeof(struct plat_serial8250_port),
> I believe this can be one line.

I think so, as we're exceeding 80 char width anyway.

> 
>>                                  },

Thanks,
John
