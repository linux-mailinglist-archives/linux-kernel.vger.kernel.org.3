Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D8E56507B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiGDJLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiGDJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:11:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF61B1D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:11:53 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lc0P417w8z1L8jd;
        Mon,  4 Jul 2022 17:09:28 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 17:11:50 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 17:11:50 +0800
Subject: Re: [PATCH] bus: hisi_lpc: fix missing platform_device_put() in
 hisi_lpc_acpi_probe()
To:     John Garry <john.garry@huawei.com>, <linux-kernel@vger.kernel.org>
CC:     <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220701094352.2104998-1-yangyingliang@huawei.com>
 <d393f22f-4cf6-65ec-e24f-49d41b36e6ee@huawei.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <98537957-1446-bc2a-4db6-9c66233937f2@huawei.com>
Date:   Mon, 4 Jul 2022 17:11:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d393f22f-4cf6-65ec-e24f-49d41b36e6ee@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/4 16:01, John Garry wrote:
> On 01/07/2022 10:43, Yang Yingliang wrote:
>
> +
>
> Please send any updated version cc'ing Rafael, who kindly offered to 
> pick up this patch
>
>>
[...]
>> @@ -503,13 +503,13 @@ static int hisi_lpc_acpi_probe(struct device 
>> *hostdev)
>>   {
>>       struct acpi_device *adev = ACPI_COMPANION(hostdev);
>>       struct acpi_device *child;
>> +    struct platform_device *pdev;
>
> nit: please maintain reverse-firtree ordering
OK
>
>>       int ret;
>>         /* Only consider the children of the host */
>>       list_for_each_entry(child, &adev->children, node) {
>>           const char *hid = acpi_device_hid(child);
>>           const struct hisi_lpc_acpi_cell *cell;
>> -        struct platform_device *pdev;
>>           const struct resource *res;
>>           bool found = false;
>>           int num_res;
>> @@ -571,22 +571,24 @@ static int hisi_lpc_acpi_probe(struct device 
>> *hostdev)
>>             ret = platform_device_add_resources(pdev, res, num_res);
>>           if (ret)
>> -            goto fail;
>> +            goto fail_put_device;
>>             ret = platform_device_add_data(pdev, cell->pdata,
>>                              cell->pdata_size);
>>           if (ret)
>> -            goto fail;
>> +            goto fail_put_device;
>>             ret = platform_device_add(pdev);
>>           if (ret)
>> -            goto fail;
>> +            goto fail_put_device;
>>             acpi_device_set_enumerated(child);
>>       }
>>         return 0;
>>   +fail_put_device:
>> +    platform_device_put(pdev);
>
> is this enough? As I see, this invokes platform_device_release(), but 
> we would still need platform_device_del() to drop the pdev resources. 
> hisi_lpc_acpi_remove_subdev() calls platform_device_unregister(), so 
> it seems proper to do that here also. Please check it.
The resource allocated in platform_device_add_resources() is inserted by 
platform_device_add(), if platform_device_add() is not called 
successfully, freeing the resource in platform_device_release() is enough.
>
> Thanks,
> John
>
>>   fail:
>>       hisi_lpc_acpi_remove(hostdev);
>>       return ret;
>
> .
