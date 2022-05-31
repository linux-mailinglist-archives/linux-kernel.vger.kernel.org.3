Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FD538A55
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243766AbiEaEMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiEaEM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:12:28 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154E130F7B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 21:12:26 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220531041223epoutp01bba96e3384192e8b388df2cc3ab41d55~0FUO9qu1t0418404184epoutp01l
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:12:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220531041223epoutp01bba96e3384192e8b388df2cc3ab41d55~0FUO9qu1t0418404184epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653970343;
        bh=VwIHjVCL0WA6hIqvCVdZUNi0KWWAnDZqY3sTX5GU2Tk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MtXqTmNO3RzFs2HC5jFypDNbZsBHKURTJVMHeLgw4I+lq9oAMkjwKp6Ngo6eNcHRC
         6Zs26hm/XhtSRDjEMI3phFxuwwk1sHEIGA9vDKouIQY2o7gWJoVz1kXU9NbRqlPu6v
         rAAm8oNZ4PDJi7wsGuieZNiWyXzKGb4KUa3JbR3o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220531041223epcas1p176da52567c4a3fd59432c33936edc0c5~0FUOT-07h1123711237epcas1p1o;
        Tue, 31 May 2022 04:12:23 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.136]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LBzPy1V1Lz4x9Q5; Tue, 31 May
        2022 04:12:22 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.4C.09785.6A595926; Tue, 31 May 2022 13:12:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220531041221epcas1p3b75384fde1bb58ed834c298b1d33863a~0FUM3Xf0H0393703937epcas1p35;
        Tue, 31 May 2022 04:12:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220531041221epsmtrp13fd42784740b13855523b9959595be42~0FUM2hjkb1691616916epsmtrp1S;
        Tue, 31 May 2022 04:12:21 +0000 (GMT)
X-AuditID: b6c32a36-c9dff70000002639-eb-629595a61634
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.DA.08924.5A595926; Tue, 31 May 2022 13:12:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220531041221epsmtip2f885f7e34c093184fded8ed24ea66fad~0FUMiDILF1781617816epsmtip2Y;
        Tue, 31 May 2022 04:12:21 +0000 (GMT)
Subject: Re: [PATCH 10/31] devfreq: exynos: Migrate to
 dev_pm_opp_set_config()
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <d9a96812-fd4e-cf46-cbe5-63f0e1d373a1@samsung.com>
Date:   Tue, 31 May 2022 13:12:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <9d492494-4a0a-f690-6a80-2bba5d8633b9@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmge6yqVOTDP7P5bB4MG8bm8X58xvY
        Lfa+3spucbbpDbvFpsfXWC0u75rDZvG59wijxYzz+5gsbjeuYLN48+Msk8WZ05dYLf5d28hi
        0XHkG7PFxq8eDnwem1Z1snncubaHzWPzknqPLVfbWTz6tqxi9Dh+YzuTx+dNcgHsUdk2GamJ
        KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKymUJeaUAoUC
        EouLlfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM5Z+vs5S
        0OdQcWrNbMYGxlvGXYycHBICJhJzOrrZuxi5OIQEdjBKTJrXywbhfGKUOLVxHSNIlZDAZ0aJ
        znPJMB39WzZAdexilFjwuhmq4z2jxK1P99hBqoQFAiQm/H3PDGKzCWhJ7H9xA6xIROACo8TT
        nfNZQRxmgQtMEgu+PGcFqeIXUJS4+uMx2D5eATuJR5e2gXWzCKhKPDv5nwnEFhUIkzi5rQWq
        RlDi5MwnLCA2p4C9xL3Fu8BsZgFxiVtP5jNB2PIS29/OYQZZJiFwhwNowS1GiCdcJBb/3M8E
        YQtLvDq+hR3ClpJ42d/GDtHQzCjR8OI2I4TTwyhx9FkfC0SVscT+pZOBujmAVmhKrN+lDxFW
        lNj5ey4jxGY+iXdfe1hBSiQEeCU62oQgSpQlLj+4C7VXUmJxeyfbBEalWUj+mYXkh1lIfpiF
        sGwBI8sqRrHUguLc9NRiwwIjeIQn5+duYgQnaC2zHYyT3n7QO8TIxMF4iFGCg1lJhNcqYmqS
        EG9KYmVValF+fFFpTmrxIUZTYAhPZJYSTc4H5oi8knhDE0sDEzMjYxMLQzNDJXHeVdNOJwoJ
        pCeWpGanphakFsH0MXFwSjUwVSxR2MPOWLLHtPTEa5ctV4+7rcmvqg1nbf0lLiXf6KhTte+O
        zJxJ9hd1Jb6KV3+ekuf7Tqkyv/ZU5U+NvzUV6zo9QvtMjO/8XOr68G/qFCvph+/lI+6xVW+4
        te2ayi2B/E3Hevb35x2duyxtAafKlp6JfSLL7nBPqErVO8C8p1GHV1Qo7E/akxDpuWqzF1+R
        KangeGei9sU8ZtmrjjdMK5VVotoZ17JtMuvTn/Mo1i31gpfmvmWs4cx7UvRenFK4WD1jqVDj
        JvX5Fk/uqEyW/7XtKIfiByY+hmmzHJ7L2zJ8EksN2fq8WHvG5bqt8bZMHcrcO80CfjJ3d3zZ
        cPPNTJ+ldjcWOkxmfntQKE5RiaU4I9FQi7moOBEAgEnh8VkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7bCSvO7SqVOTDJpPyFo8mLeNzeL8+Q3s
        Fntfb2W3ONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWtxtXsFm8+XGWyeLM6UusFv+ubWSx
        6Djyjdli41cPBz6PTas62TzuXNvD5rF5Sb3HlqvtLB59W1Yxehy/sZ3J4/MmuQD2KC6blNSc
        zLLUIn27BK6MpZ+vsxT0OVScWjObsYHxlnEXIyeHhICJRP+WDexdjFwcQgI7GCWWXXzPDJGQ
        lJh28SiQzQFkC0scPlwMUfOWUeLzzyssIDXCAn4SD79dYQSx2QS0JPa/uMEGUiQicIlRom/6
        MjCHWeASk8SKL0cZIdqnM0l0PHzOBNLCL6AocfXHY7B2XgE7iUeXtoGtZhFQlXh28j9YjahA
        mMTOJY+ZIGoEJU7OfAK2mlPAXuLe4l1gNrOAusSfeZeYIWxxiVtP5jNB2PIS29/OYZ7AKDwL
        SfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcKRqae1g3LPq
        g94hRiYOxkOMEhzMSiK8VhFTk4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5Ykpqd
        mlqQWgSTZeLglGpginV4omPnclupZHfyzRZTlo2+ksouxvdatc9k+i+VqFfvsXUq0Fgrd5Zt
        ulWAwa/wre2+6YH/v5jVB2xdYjtvUr33p1UNHu7GWWdTRZsPLDhQ9tLKZuOdb1dfsXTaN778
        kNhu2XQnpFTiT+WjfnFBtY7Sbs/6lyVhzLKr5FSexvOvZJ+fJ8Sw87mbLkNi6M3j8soTotZf
        njPVUq3W/n6D4/cu5tXSRicfThWxtTbd8fj8Atmo4F2/pi6q3M3XdXSip03sug2vUsUC1lzj
        /F4fp3b3nvvFtftZf/1ievLwpQDLtwpp5cmbQ/bM1dzPdn5qZafNntez/xqe5LK+WKytxXrC
        PcNqwRPvWnefk3eVWIozEg21mIuKEwGN7q7GQwMAAA==
X-CMS-MailID: 20220531041221epcas1p3b75384fde1bb58ed834c298b1d33863a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220526114410epcas1p27ad1ed594737423fb967f92529a1abd5
References: <cover.1653564321.git.viresh.kumar@linaro.org>
        <CGME20220526114410epcas1p27ad1ed594737423fb967f92529a1abd5@epcas1p2.samsung.com>
        <052c4937ce408a01de5cd7d7e359d333f9b11e57.1653564321.git.viresh.kumar@linaro.org>
        <9d492494-4a0a-f690-6a80-2bba5d8633b9@samsung.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/30/22 6:45 PM, Chanwoo Choi wrote:
> Hi,
> 
> On 5/26/22 8:42 PM, Viresh Kumar wrote:
>> The OPP core now provides a unified API for setting all configuration
>> types, i.e. dev_pm_opp_set_config().
>>
>> Lets start using it.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/devfreq/exynos-bus.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index e689101abc93..780e525eb92a 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -161,7 +161,7 @@ static void exynos_bus_exit(struct device *dev)
>>  
>>  	dev_pm_opp_of_remove_table(dev);
>>  	clk_disable_unprepare(bus->clk);
>> -	dev_pm_opp_put_regulators(bus->opp_table);
>> +	dev_pm_opp_clear_config(bus->opp_table);
>>  	bus->opp_table = NULL;
>>  }
>>  
>> @@ -182,11 +182,15 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>  	struct opp_table *opp_table;
>>  	const char *vdd = "vdd";
>>  	int i, ret, count, size;
>> +	struct dev_pm_opp_config config = {
>> +		.regulator_names = &vdd,
>> +		.regulator_count = 1,
>> +	};
>>  
>> -	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
>> +	opp_table = dev_pm_opp_set_config(dev, &config);
>>  	if (IS_ERR(opp_table)) {
>>  		ret = PTR_ERR(opp_table);
>> -		dev_err(dev, "failed to set regulators %d\n", ret);
>> +		dev_err(dev, "failed to set OPP config %d\n", ret);
>>  		return ret;
>>  	}
>>  
>> @@ -236,7 +240,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>  	return 0;
>>  
>>  err_regulator:
>> -	dev_pm_opp_put_regulators(bus->opp_table);
>> +	dev_pm_opp_clear_config(bus->opp_table);
>>  	bus->opp_table = NULL;
>>  
>>  	return ret;
>> @@ -459,7 +463,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>  	dev_pm_opp_of_remove_table(dev);
>>  	clk_disable_unprepare(bus->clk);
>>  err_reg:
>> -	dev_pm_opp_put_regulators(bus->opp_table);
>> +	dev_pm_opp_clear_config(bus->opp_table);
>>  	bus->opp_table = NULL;
>>  
>>  	return ret;
>>
> 
> When I tested them with patch1/2 and patch10/11/12,
> I got the following message.
> 
> [    1.083669] Unable to handle kernel NULL pointer dereference at virtual address 000000b4
> [    1.083683] [000000b4] *pgd=00000000
> [    1.083719] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [    1.083735] Modules linked in:
> [    1.083764] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.18.0-11272-g7093c1f2a99c #2
> [    1.083780] Hardware name: Samsung Exynos (Flattened Device Tree)
> [    1.083797] PC is at dev_pm_opp_clear_config+0x10/0x90
> [    1.083823] LR is at exynos_bus_probe+0x384/0x634
> [    1.083843] pc : [<c0933740>]    lr : [<c09a33e0>]    psr: 60000013
> [    1.083859] sp : f0835d38  ip : c1988000  fp : 00000001
> [    1.083874] r10: c207bc10  r9 : c1b1a580  r8 : c160b708
> [    1.083890] r7 : c207bc00  r6 : c1b1a580  r5 : fffffdfb  r4 : 00000000
> [    1.083907] r3 : c1988000  r2 : 00000000  r1 : 00000000  r0 : 00000000
> [    1.083924] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    1.083940] Control: 10c5387d  Table: 4000406a  DAC: 00000051
> [    1.083955] Register r0 information: NULL pointer
> [    1.083989] Register r1 information: NULL pointer
> [    1.084021] Register r2 information: NULL pointer
> [    1.084053] Register r3 information: slab task_struct start c1988000 pointer offset 0
> [    1.084126] Register r4 information: NULL pointer
> [    1.084157] Register r5 information: non-paged memory
> [    1.084189] Register r6 information: slab kmalloc-64 start c1b1a580 pointer offset 0 size 64
> [    1.084270] Register r7 information: slab kmalloc-1k start c207bc00 pointer offset 0 size 1024
> [    1.084351] Register r8 information: non-slab/vmalloc memory
> [    1.084383] Register r9 information: slab kmalloc-64 start c1b1a580 pointer offset 0 size 64
> [    1.084463] Register r10 information: slab kmalloc-1k start c207bc00 pointer offset 16 size 1024
> [    1.084542] Register r11 information: non-paged memory
> [    1.084573] Register r12 information: slab task_struct start c1988000 pointer offset 0
> [    1.084635] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> [    1.084651] Stack: (0xf0835d38 to 0xf0836000)
> [    1.084669] 5d20:                                                       c26b3940 c09a33e0
> [    1.084687] 5d40: 00000000 f0835d9c a0000013 cfd97040 df8a6280 c0e031ec c17188f8 c0994758
> [    1.084703] 5d60: 069db9c0 c0e0338c 60000013 c0e03380 c1784000 c0e0338c c17188f8 c0994758
> [    1.084717] 5d80: f0835dc8 c160b708 ffffffff df8a6280 c12de76c c0994bb8 c181fdd4 df8a601c
> [    1.084737] 5da0: 00000000 c160b708 c1718f84 c1765ea0 00000000 000001bb c1550860 c0995684
> [    1.084755] 5dc0: ffffffff 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.084772] 5de0: 00000000 0f7634d1 00000000 c207bc10 00000000 c1718f84 c1765ea0 00000000
> [    1.084787] 5e00: 000001bb c1550860 c1784000 c061fb8c c207bc10 00000000 c1718f84 c1765ea0
> [    1.084803] 5e20: 00000000 c061d078 c207bc10 c062b764 c207bc10 c207bc10 c1718f84 c1718f84
> [    1.084818] 5e40: c1765ea0 c061d3e0 c1988000 000001bb c1550860 c17cb200 c17cb204 c1718f84
> [    1.084834] 5e60: c207bc10 00000000 000001bb c1550860 c1784000 c061d588 00000000 c207bc10
> [    1.084849] 5e80: c1718f84 c160b708 c1988000 c061dabc 00000000 c1718f84 c061d9d0 c061ac7c
> [    1.084865] 5ea0: c1784000 c2040074 c2054bc0 0f7634d1 c1718f84 c1718f84 cfd92f00 c16edb98
> [    1.084882] 5ec0: 00000000 c061c050 c1367300 c1758040 c1533c54 c1718f84 c1758040 c1533c54
> [    1.084895] 5ee0: 00000000 c061e568 c160b708 c1758040 c1533c54 c0102078 c0191390 c1500504
> [    1.084911] 5f00: c1762f78 00000000 00000006 c132f7c4 c136690c 00000000 00000000 c160b708
> [    1.084927] 5f20: c12a2e5c c1297aec 39360000 c202722b c2027233 0f7634d1 c168112c c1406728
> [    1.084943] 5f40: 00000007 0f7634d1 c1406728 c15a7da0 00000007 c1550840 c2027200 c15014d0
> [    1.084959] 5f60: 00000006 00000006 00000000 c1500504 00000000 c1500504 00000000 c160b700
> [    1.084976] 5f80: c0df8c68 00000000 00000000 00000000 00000000 00000000 00000000 c0df8c88
> [    1.084991] 5fa0: 00000000 c0df8c68 00000000 c0100148 00000000 00000000 00000000 00000000
> [    1.085006] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.085022] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [    1.085042]  dev_pm_opp_clear_config from exynos_bus_probe+0x384/0x634
> [    1.085063]  exynos_bus_probe from platform_probe+0x64/0xc0
> [    1.085085]  platform_probe from really_probe+0x104/0x3c4
> [    1.085109]  really_probe from __driver_probe_device+0xa8/0x214
> [    1.085130]  __driver_probe_device from driver_probe_device+0x3c/0xdc
> [    1.085149]  driver_probe_device from __driver_attach+0xec/0x190
> [    1.085170]  __driver_attach from bus_for_each_dev+0x7c/0xbc
> [    1.085191]  bus_for_each_dev from bus_add_driver+0x17c/0x218
> [    1.085211]  bus_add_driver from driver_register+0x7c/0x110
> [    1.085234]  driver_register from do_one_initcall+0x50/0x268
> [    1.085257]  do_one_initcall from kernel_init_freeable+0x234/0x280
> [    1.085279]  kernel_init_freeable from kernel_init+0x20/0x140
> [    1.085305]  kernel_init from ret_from_fork+0x14/0x2c
> [    1.085322] Exception stack(0xf0835fb0 to 0xf0835ff8)


I try to find the cause of this warning.
I think that dev_pm_opp_clear_config needs to check
whether 'opp_table' is NULL or not as following:


diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index fba6e2b20b8f..cbf8f10b9ff0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2598,6 +2598,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
  */
 void dev_pm_opp_clear_config(struct opp_table *opp_table)
 {
+       if (unlikely(!opp_table))
+               return;
+
        if (opp_table->genpd_virt_devs)
                dev_pm_opp_detach_genpd(opp_table);


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
