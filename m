Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DED563365
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbiGAMSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiGAMSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:18:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E946813D1F;
        Fri,  1 Jul 2022 05:18:37 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LZDgs0S2vz6H6sf;
        Fri,  1 Jul 2022 20:16:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 14:18:35 +0200
Received: from [10.126.173.51] (10.126.173.51) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 13:18:34 +0100
Message-ID: <df8c0a5d-e950-1726-5d30-80dcc8b20ff9@huawei.com>
Date:   Fri, 1 Jul 2022 13:18:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher>
 <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
 <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com>
 <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.51]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
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

On 01/07/2022 13:05, Andy Shevchenko wrote:
> On Fri, Jul 1, 2022 at 1:54 PM John Garry <john.garry@huawei.com> wrote:
>> On 01/07/2022 12:07, Andy Shevchenko wrote:
>>> On Fri, Jul 1, 2022 at 1:06 PM Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> On Fri, Jul 1, 2022 at 1:04 PM John Garry <john.garry@huawei.com> wrote:
>>>>> On 30/06/2022 19:13, Rafael J. Wysocki wrote:
> 
> ...
> 
>>>>> However Yang Yingliang spotted a pre-existing bug in the ACPI probe and
>>>>> sent a fix today (coincidence?):
>>>>>
>>>>> https://lore.kernel.org/lkml/20220701094352.2104998-1-yangyingliang@huawei.com/T/#u
>>>>>
>>>>> And they conflict. This code has been this way for years, so I just
>>>>> suggest Yang Yingliang resends the fix on top off Rafael's change.
>>>>
>>>> Wondering if Yang can actually switch that to use
>>>> platform_device_register_full().
>>
>> Maybe that would work and simplify things. Let me check it.
>>
>> BTW, when we originally upstreamed this driver there was some ACPI
>> platform device registration code which you/we thought could be factored
>> out later. I can't remember it. I was looking through lore but couldn't
>> find it. I don't remember it being so important, though.
> 
> My suggestion is definitely not for the fix itself, but as a follow up.

FWIW, it works out quite neatly:

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index e0fee1f863e6..70198d5644c7 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -472,9 +472,7 @@ static int hisi_lpc_acpi_clear_enumerated(struct 
acpi_device *adev, void *not_us

  struct hisi_lpc_acpi_cell {
  	const char *hid;
-	const char *name;
-	void *pdata;
-	size_t pdata_size;
+	struct platform_device_info pdevinfo;
  };

  static void hisi_lpc_acpi_remove(struct device *hostdev)
@@ -505,28 +503,36 @@ static int hisi_lpc_acpi_add_child(struct 
acpi_device *child, void *data)
  		/* ipmi */
  		{
  			.hid = "IPI0001",
-			.name = "hisi-lpc-ipmi",
+			.pdevinfo = {
+				.name = "hisi-lpc-ipmi",
+				.num_res = num_res,
+				.res = res,
+			},
  		},
  		/* 8250-compatible uart */
  		{
  			.hid = "HISI1031",
-			.name = "serial8250",
-			.pdata = (struct plat_serial8250_port []) {
-				{
-					.iobase = res->start,
-					.uartclk = 1843200,
-					.iotype = UPIO_PORT,
-					.flags = UPF_BOOT_AUTOCONF,
+			.pdevinfo = {
+				.name = "serial8250",
+				.data = (struct plat_serial8250_port []) {
+					{
+						.iobase = res->start,
+						.uartclk = 1843200,
+						.iotype = UPIO_PORT,
+						.flags = UPF_BOOT_AUTOCONF,
+					},
+					{}
  				},
-				{}
+				.size_data = 2 *
+					sizeof(struct plat_serial8250_port),
+				.num_res = num_res,
+				.res = res,
  			},
-			.pdata_size = 2 *
-				sizeof(struct plat_serial8250_port),
  		},
  		{}
  	};

-	for (; cell && cell->name; cell++) {
+	for (; cell && cell->pdevinfo.name; cell++) {
  		if (!strcmp(cell->hid, hid)) {
  			found = true;
  			break;
@@ -540,25 +546,13 @@ static int hisi_lpc_acpi_add_child(struct 
acpi_device *child, void *data)
  		return 0;
  	}

-	pdev = platform_device_alloc(cell->name, PLATFORM_DEVID_AUTO);
+	pdev = platform_device_register_full(&cell->pdevinfo);
  	if (!pdev)
  		return -ENOMEM;

  	pdev->dev.parent = hostdev;
  	ACPI_COMPANION_SET(&pdev->dev, child);

-	ret = platform_device_add_resources(pdev, res, num_res);
-	if (ret)
-		return ret;
-
-	ret = platform_device_add_data(pdev, cell->pdata, cell->pdata_size);
-	if (ret)
-		return ret;
-
-	ret = platform_device_add(pdev);
-	if (ret)
-		return ret;
-
  	acpi_device_set_enumerated(child);

  	return 0;

> 
>>> And for the record, I think the Fixes even for very rare bug hits
>>> should go first.
>>
>> ok, I have to admit that I was going to feel awkward asking Rafael to
>> deal with this fix by having a v4 on top of it.
> 
> I don't think it's a problem as long as we have an immutable branch /
> tag with that patch. Another approach could be that Rafael can take it
> as a precursor for his series and route via ACPI tree, but let's hear
> what he thinks about this himself.
> 

ok, fine.

Thanks,
John
