Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399F458D778
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242429AbiHIKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiHIKfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:35:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1A2CE08;
        Tue,  9 Aug 2022 03:35:23 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M28XR1LMYz67Zm5;
        Tue,  9 Aug 2022 18:32:39 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 12:35:20 +0200
Received: from [10.195.245.222] (10.195.245.222) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 11:35:19 +0100
Message-ID: <4ddd9051-d61a-3576-4647-42c88a7f49bf@huawei.com>
Date:   Tue, 9 Aug 2022 11:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher>
 <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
 <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com>
 <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
 <df8c0a5d-e950-1726-5d30-80dcc8b20ff9@huawei.com>
 <CAJZ5v0hv7nm57QrCYX+aX=fVoE0s0BxEpJfz+a8bsPzzSZt7+g@mail.gmail.com>
 <71dfc3cd-c2ae-8096-9280-67e77c21055e@huawei.com>
 <CAHp75VfqJwF4YypH3QE0MRgZAyjEMKche-4czUuiC=aTYoYwig@mail.gmail.com>
 <CAHp75VfpQfBYD-AmVhbxm4tp_1EVv8xqCChYpuuRKOC=P_Y_og@mail.gmail.com>
 <050e5a2f-42b9-f851-ec6e-e2a9d3fdbe1c@huawei.com>
 <CAJZ5v0j++HZJfL2+0uWgDRqVeZPviaZSWyL3Yn7T2Ky=bcRQMQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAJZ5v0j++HZJfL2+0uWgDRqVeZPviaZSWyL3Yn7T2Ky=bcRQMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.245.222]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On 05/07/2022 14:54, Rafael J. Wysocki wrote:
>> So we could factor out by dividing acpi_create_platform_device() into 2x
>> parts: resource get and then platform dev create. But that does not seem
>> wise as we have 2x parts which don't make sense on their own. Or else
>> pass a fixup callback into acpi_create_platform_device(). Any other
>> ideas if we want to go this way?
> Personally, I would do the cleanup that can be done without
> refactoring the library function as the first step, just to reduce the
> amount of changes made in one go if nothing else.
> 
> Next, I'd look at introducing something like
> 
> acpi_create_platform_device_ops(struct acpi_device *adev, const struct
> property_entry *properties, const struct *platform_device_create_ops
> *ops);
> 
> where ops would be a set of callbacks to invoke as a matter of customization.
> 
> Then, acpi_create_platform_device() can be defined as a wrapper around
> the above.
> .
JFYI, I'm trying out this change and it is looking quite disruptive. The 
problems are specifically related to the LPC UART support. Firstly, it 
looks like we require this patch (which was never applied):
https://lore.kernel.org/linux-acpi/1524218846-169934-2-git-send-email-john.garry@huawei.com/#t

Secondly this code in the hisi lpc driver causes an issue:

static int hisi_lpc_acpi_add_child(struct acpi_device *child, void *data)
{
	const char *hid = acpi_device_hid(child);
	struct device *hostdev = data;
	const struct hisi_lpc_acpi_cell *cell;
	struct platform_device *pdev;
	const struct resource *res;
	bool found = false;
	int num_res;
	int ret;

	ret = hisi_lpc_acpi_set_io_res(child, hostdev, &res, &num_res);
	if (ret) {
		dev_warn(hostdev, "set resource fail (%d)\n", ret);
		return ret;
	}

	cell = (struct hisi_lpc_acpi_cell []){
...
		/* 8250-compatible uart */
		{
			.hid = "HISI1031",
			.name = "serial8250",
			.pdata = (struct plat_serial8250_port []) {
				{
***					.iobase = res->start,
					.uartclk = 1843200,
					.iotype = UPIO_PORT,
					.flags = UPF_BOOT_AUTOCONF,
				},
				{}
			},
			.pdata_size = 2 *
				sizeof(struct plat_serial8250_port),
		},
		{}
	};
...

	pdev = platform_device_alloc(cell->name, PLATFORM_DEVID_AUTO);

At ***, above, we need to set the platform data plat_serial8250_port 
iobase at the translated address, but this can only be done after we 
read and translate the resources, which is now all done in the acpi 
platform code - so we have an ordering problem.

Anyway, I'll try to get it working and then send out the patches. We may 
decide it's just not worth it.

Thanks,
John
