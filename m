Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5F05378D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiE3JpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiE3JpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:45:16 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F6E5EDD4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:45:12 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220530094507epoutp02f1b7231c956c9a858fee07722ee767b4~z2Nduj8ej1980419804epoutp02B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 09:45:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220530094507epoutp02f1b7231c956c9a858fee07722ee767b4~z2Nduj8ej1980419804epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653903907;
        bh=8+52DnZiYU3rB+V0mmA3r0E+/RKJ8wdV1PfNvn7oF7w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=t2mAjcJXbMANGHn37fAI8c/DMk4oHNVkbFpD8Y0uAR2ApnYKAc13UZy9IWQyUo3lt
         JPI4U8czqxB97ZQaO1ud/GWM00+oOmMqxPikRnxNcbHMp4urH2GLWNWtL+5WmQEvjD
         5zDA0V0PXqIQnOoEPHVd57nogzaNd2Gw/gBdA2eo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220530094507epcas1p3d151f238456f3f7d18fbe9907ffc4981~z2NdOlmH01098710987epcas1p3l;
        Mon, 30 May 2022 09:45:07 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.234]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LBVrL2zHJz4x9Pr; Mon, 30 May
        2022 09:45:06 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.18.10038.22294926; Mon, 30 May 2022 18:45:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220530094505epcas1p10692b4eb678ed6c180c0689b532a45e1~z2Nb3_frF1784017840epcas1p1T;
        Mon, 30 May 2022 09:45:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220530094505epsmtrp29df48301a4e16d6882d1760966547866~z2Nb21n-B2066820668epsmtrp2O;
        Mon, 30 May 2022 09:45:05 +0000 (GMT)
X-AuditID: b6c32a37-111ff70000002736-d7-6294922250ba
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.BA.11276.12294926; Mon, 30 May 2022 18:45:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220530094505epsmtip210c5d217c5065b6472e1087b165f193e~z2Nbj9RfE3184631846epsmtip2Q;
        Mon, 30 May 2022 09:45:05 +0000 (GMT)
Subject: Re: [PATCH 10/31] devfreq: exynos: Migrate to
 dev_pm_opp_set_config()
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
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9d492494-4a0a-f690-6a80-2bba5d8633b9@samsung.com>
Date:   Mon, 30 May 2022 18:45:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <052c4937ce408a01de5cd7d7e359d333f9b11e57.1653564321.git.viresh.kumar@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmnq7SpClJBo17RC0ezNvGZnH+/AZ2
        i72vt7JbnG16w26x6fE1VovLu+awWXzuPcJoMeP8PiaL240r2Cze/DjLZHHm9CVWi3/XNrJY
        dBz5xmyx8auHA5/HplWdbB53ru1h89i8pN5jy9V2Fo++LasYPY7f2M7k8XmTXAB7VLZNRmpi
        SmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtDFSgpliTmlQKGA
        xOJiJX07m6L80pJUhYz84hJbpdSClJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjHUPH7AW
        HLGs2L2BpYHxvl4XIyeHhICJxMbbm5i7GLk4hAR2MEo83XISyvnEKLHo2xxWCOcbo8SxBcuZ
        YFoOrbvOCJHYyyhxdMkDdpCEkMB7Rokp50JBbGGBAIkJf9+DjRIRuAA0d+d8sFHMAheYJBZ8
        ec4KUsUmoCWx/8UNNhCbX0BR4uqPx4wgNq+AncStGdOAajg4WARUJT71gw0VFQiTOLmtBapE
        UOLkzCcsIDanQJzEu22HwWxmAXGJW0/mM0HY8hLb385hhrj6DofEmwcuELaLxMzrq6DiwhKv
        jm9hh7ClJD6/28sGcqeEQDOjRMOL24wQTg/Qm8/6WCCqjCX2L53MBHIcs4CmxPpd+hBhRYmd
        v+cyQizmk3j3tQfsfgkBXomONiGIEmWJyw/uQkNRUmJxeyfbBEalWUjemYXkhVlIXpiFsGwB
        I8sqRrHUguLc9NRiwwJjeGwn5+duYgSnZi3zHYzT3n7QO8TIxMF4iFGCg1lJhLcheWKSEG9K
        YmVValF+fFFpTmrxIUZTYPhOZJYSTc4HZoe8knhDE0sDEzMjYxMLQzNDJXHeVdNOJwoJpCeW
        pGanphakFsH0MXFwSjUw7V9RziIacCn3jiZjtVutoVXSL7O+CS8zV7gtOF4ZpiLA+713Zd2b
        xBYLhbu+lz6+0OvXeceW5j03Kq6vNeOL7POvPtI3XvXGvRATaRVdc+JAXWDJ39LtCe65Bh4d
        h2yaL/WoPL77zOY0V64vT6H6/U2bLZVVDNbPLDj0wqNR7/u81Q8ZCzakzrj+sl1tWWnOHq5t
        m61PHNt/tPGfS57s/r7KFbJ/LaYm+J9IXKHh0TJF/GXIVfNd+wuaOPhl5kmyXo06qyXCdmMf
        B0uM04G75re4mM5nHOH4Uud66Wu3w2nuLce3XlvpZ9a9VkbId02oh/zpx21de28/THvm//nb
        6V+X1ByWel3xXhzgWOGkxFKckWioxVxUnAgA3sQ8olYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCSvK7ipClJBsfWm1o8mLeNzeL8+Q3s
        Fntfb2W3ONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWtxtXsFm8+XGWyeLM6UusFv+ubWSx
        6Djyjdli41cPBz6PTas62TzuXNvD5rF5Sb3HlqvtLB59W1Yxehy/sZ3J4/MmuQD2KC6blNSc
        zLLUIn27BK6MdQ8fsBYcsazYvYGlgfG+XhcjJ4eEgInEoXXXGbsYuTiEBHYzSnz7eIsNIiEp
        Me3iUeYuRg4gW1ji8OFiiJq3jBLbjmxiAakRFvCTePjtCliziMAlRom+6cvYQBxmgUtMEiu+
        HIUa+4hR4vLj92Bj2QS0JPa/uAFm8wsoSlz98ZgRxOYVsJO4NWMaK8g6FgFViU/9oSBhUYEw
        iZ1LHjNBlAhKnJz5BGwzp0CcxLtth8FsZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFReBaS
        9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgKNXS3MG4fdUH
        vUOMTByMhxglOJiVRHgbkicmCfGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1
        tSC1CCbLxMEp1cDE+u4rP+s/uYCCdyzXAtrNvR9n5nk+lhTb+L9wywbJLb4l4hGaE3ct3Jv0
        y+KpWne18/pttqs2JES/+tiaNLvbzOi3v1i5qOe049mZySzlwqIzv8hOSxWr3/vVQSut9HPH
        3NZcg+bPG4Wyts9I+mq2y71y/YrjUznVRC9bnp02qalhyufoRds6fVYqt+7rbn+5rHfCnQ8n
        ddWvPKvtPhP1tko12b2m3JN78s+H6tksL6LuzahWnHV+smPPpnP318v0vebWO2B/vjpdSaq5
        PTh2S3XU3m0yH46WTnu/MPiIoEtogtUPK9WvLj5yi9+6V1xg/LUyzOQUb/4bn+KgjtdxR1Ya
        mKzfMXnOCp2uqGNKLMUZiYZazEXFiQB42Ao+QQMAAA==
X-CMS-MailID: 20220530094505epcas1p10692b4eb678ed6c180c0689b532a45e1
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
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/26/22 8:42 PM, Viresh Kumar wrote:
> The OPP core now provides a unified API for setting all configuration
> types, i.e. dev_pm_opp_set_config().
> 
> Lets start using it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/devfreq/exynos-bus.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index e689101abc93..780e525eb92a 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -161,7 +161,7 @@ static void exynos_bus_exit(struct device *dev)
>  
>  	dev_pm_opp_of_remove_table(dev);
>  	clk_disable_unprepare(bus->clk);
> -	dev_pm_opp_put_regulators(bus->opp_table);
> +	dev_pm_opp_clear_config(bus->opp_table);
>  	bus->opp_table = NULL;
>  }
>  
> @@ -182,11 +182,15 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  	struct opp_table *opp_table;
>  	const char *vdd = "vdd";
>  	int i, ret, count, size;
> +	struct dev_pm_opp_config config = {
> +		.regulator_names = &vdd,
> +		.regulator_count = 1,
> +	};
>  
> -	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
> +	opp_table = dev_pm_opp_set_config(dev, &config);
>  	if (IS_ERR(opp_table)) {
>  		ret = PTR_ERR(opp_table);
> -		dev_err(dev, "failed to set regulators %d\n", ret);
> +		dev_err(dev, "failed to set OPP config %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -236,7 +240,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  	return 0;
>  
>  err_regulator:
> -	dev_pm_opp_put_regulators(bus->opp_table);
> +	dev_pm_opp_clear_config(bus->opp_table);
>  	bus->opp_table = NULL;
>  
>  	return ret;
> @@ -459,7 +463,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	dev_pm_opp_of_remove_table(dev);
>  	clk_disable_unprepare(bus->clk);
>  err_reg:
> -	dev_pm_opp_put_regulators(bus->opp_table);
> +	dev_pm_opp_clear_config(bus->opp_table);
>  	bus->opp_table = NULL;
>  
>  	return ret;
> 

When I tested them with patch1/2 and patch10/11/12,
I got the following message.

[    1.083669] Unable to handle kernel NULL pointer dereference at virtual address 000000b4
[    1.083683] [000000b4] *pgd=00000000
[    1.083719] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    1.083735] Modules linked in:
[    1.083764] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.18.0-11272-g7093c1f2a99c #2
[    1.083780] Hardware name: Samsung Exynos (Flattened Device Tree)
[    1.083797] PC is at dev_pm_opp_clear_config+0x10/0x90
[    1.083823] LR is at exynos_bus_probe+0x384/0x634
[    1.083843] pc : [<c0933740>]    lr : [<c09a33e0>]    psr: 60000013
[    1.083859] sp : f0835d38  ip : c1988000  fp : 00000001
[    1.083874] r10: c207bc10  r9 : c1b1a580  r8 : c160b708
[    1.083890] r7 : c207bc00  r6 : c1b1a580  r5 : fffffdfb  r4 : 00000000
[    1.083907] r3 : c1988000  r2 : 00000000  r1 : 00000000  r0 : 00000000
[    1.083924] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    1.083940] Control: 10c5387d  Table: 4000406a  DAC: 00000051
[    1.083955] Register r0 information: NULL pointer
[    1.083989] Register r1 information: NULL pointer
[    1.084021] Register r2 information: NULL pointer
[    1.084053] Register r3 information: slab task_struct start c1988000 pointer offset 0
[    1.084126] Register r4 information: NULL pointer
[    1.084157] Register r5 information: non-paged memory
[    1.084189] Register r6 information: slab kmalloc-64 start c1b1a580 pointer offset 0 size 64
[    1.084270] Register r7 information: slab kmalloc-1k start c207bc00 pointer offset 0 size 1024
[    1.084351] Register r8 information: non-slab/vmalloc memory
[    1.084383] Register r9 information: slab kmalloc-64 start c1b1a580 pointer offset 0 size 64
[    1.084463] Register r10 information: slab kmalloc-1k start c207bc00 pointer offset 16 size 1024
[    1.084542] Register r11 information: non-paged memory
[    1.084573] Register r12 information: slab task_struct start c1988000 pointer offset 0
[    1.084635] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
[    1.084651] Stack: (0xf0835d38 to 0xf0836000)
[    1.084669] 5d20:                                                       c26b3940 c09a33e0
[    1.084687] 5d40: 00000000 f0835d9c a0000013 cfd97040 df8a6280 c0e031ec c17188f8 c0994758
[    1.084703] 5d60: 069db9c0 c0e0338c 60000013 c0e03380 c1784000 c0e0338c c17188f8 c0994758
[    1.084717] 5d80: f0835dc8 c160b708 ffffffff df8a6280 c12de76c c0994bb8 c181fdd4 df8a601c
[    1.084737] 5da0: 00000000 c160b708 c1718f84 c1765ea0 00000000 000001bb c1550860 c0995684
[    1.084755] 5dc0: ffffffff 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.084772] 5de0: 00000000 0f7634d1 00000000 c207bc10 00000000 c1718f84 c1765ea0 00000000
[    1.084787] 5e00: 000001bb c1550860 c1784000 c061fb8c c207bc10 00000000 c1718f84 c1765ea0
[    1.084803] 5e20: 00000000 c061d078 c207bc10 c062b764 c207bc10 c207bc10 c1718f84 c1718f84
[    1.084818] 5e40: c1765ea0 c061d3e0 c1988000 000001bb c1550860 c17cb200 c17cb204 c1718f84
[    1.084834] 5e60: c207bc10 00000000 000001bb c1550860 c1784000 c061d588 00000000 c207bc10
[    1.084849] 5e80: c1718f84 c160b708 c1988000 c061dabc 00000000 c1718f84 c061d9d0 c061ac7c
[    1.084865] 5ea0: c1784000 c2040074 c2054bc0 0f7634d1 c1718f84 c1718f84 cfd92f00 c16edb98
[    1.084882] 5ec0: 00000000 c061c050 c1367300 c1758040 c1533c54 c1718f84 c1758040 c1533c54
[    1.084895] 5ee0: 00000000 c061e568 c160b708 c1758040 c1533c54 c0102078 c0191390 c1500504
[    1.084911] 5f00: c1762f78 00000000 00000006 c132f7c4 c136690c 00000000 00000000 c160b708
[    1.084927] 5f20: c12a2e5c c1297aec 39360000 c202722b c2027233 0f7634d1 c168112c c1406728
[    1.084943] 5f40: 00000007 0f7634d1 c1406728 c15a7da0 00000007 c1550840 c2027200 c15014d0
[    1.084959] 5f60: 00000006 00000006 00000000 c1500504 00000000 c1500504 00000000 c160b700
[    1.084976] 5f80: c0df8c68 00000000 00000000 00000000 00000000 00000000 00000000 c0df8c88
[    1.084991] 5fa0: 00000000 c0df8c68 00000000 c0100148 00000000 00000000 00000000 00000000
[    1.085006] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.085022] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    1.085042]  dev_pm_opp_clear_config from exynos_bus_probe+0x384/0x634
[    1.085063]  exynos_bus_probe from platform_probe+0x64/0xc0
[    1.085085]  platform_probe from really_probe+0x104/0x3c4
[    1.085109]  really_probe from __driver_probe_device+0xa8/0x214
[    1.085130]  __driver_probe_device from driver_probe_device+0x3c/0xdc
[    1.085149]  driver_probe_device from __driver_attach+0xec/0x190
[    1.085170]  __driver_attach from bus_for_each_dev+0x7c/0xbc
[    1.085191]  bus_for_each_dev from bus_add_driver+0x17c/0x218
[    1.085211]  bus_add_driver from driver_register+0x7c/0x110
[    1.085234]  driver_register from do_one_initcall+0x50/0x268
[    1.085257]  do_one_initcall from kernel_init_freeable+0x234/0x280
[    1.085279]  kernel_init_freeable from kernel_init+0x20/0x140
[    1.085305]  kernel_init from ret_from_fork+0x14/0x2c
[    1.085322] Exception stack(0xf0835fb0 to 0xf0835ff8)



-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
