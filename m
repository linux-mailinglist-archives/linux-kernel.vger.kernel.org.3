Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C0F538ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbiEaFFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243915AbiEaFFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:05:50 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123459347A
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:05:48 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220531050546epoutp02a9b011e74f8b3cc27e2ce31a0c5015a7~0GC1hViLL0581505815epoutp02p
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:05:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220531050546epoutp02a9b011e74f8b3cc27e2ce31a0c5015a7~0GC1hViLL0581505815epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653973546;
        bh=pCfu1Bn+oGR9N1QdnKC22tNnmce6VPGrqrFeEFc4AnE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=L4AxRCFFutbIMTcqgStxw043vavc9ZE5qntnQN6I2a4vFm78UVkt7evMJqAZ1EuLu
         CXl0z56esOV7YqsyyniE/sbF6/TJgZDdnB6y1JtTj1jnetTjTubkgK0+6tLNQ9dchf
         67xv953S9WHkfttbzFNFXdPrZiP71LER+koMvRH4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220531050545epcas1p3ef1f98039b658b0a03b04176f67cf4fa~0GC1AYQfW0103801038epcas1p3t;
        Tue, 31 May 2022 05:05:45 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.232]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LC0bX5BtFz4x9Py; Tue, 31 May
        2022 05:05:44 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.EE.10354.822A5926; Tue, 31 May 2022 14:05:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220531050544epcas1p3f968f5c5e7a5e505e5311e4bb144d937~0GCzXPw3A3125431254epcas1p39;
        Tue, 31 May 2022 05:05:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220531050544epsmtrp1b7c1b5d9834c66752f361693073689e1~0GCzWYIeL1710017100epsmtrp1k;
        Tue, 31 May 2022 05:05:44 +0000 (GMT)
X-AuditID: b6c32a38-49fff70000002872-0b-6295a2285bbb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.A7.11276.722A5926; Tue, 31 May 2022 14:05:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220531050543epsmtip29bd3f34e0d9ecd783a5952797cfb35ed~0GCy65kp31220412204epsmtip2k;
        Tue, 31 May 2022 05:05:43 +0000 (GMT)
Subject: Re: [PATCH 10/31] devfreq: exynos: Migrate to
 dev_pm_opp_set_config()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d2be76c9-46c6-451b-48f1-4925e0e60584@samsung.com>
Date:   Tue, 31 May 2022 14:05:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220531043809.xfpzz6c7x6utyjb3@vireshk-i7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmrq7GoqlJBtf2aFg8mLeNzeL8+Q3s
        Fntfb2W3ONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWtxtXsFm8+XGWyeLM6UusFv+ubWSx
        6Djyjdli41cPBz6PTas62TzuXNvD5rF5Sb3HlqvtLB59W1Yxehy/sZ3J4/MmuQD2qGybjNTE
        lNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCLlRTKEnNKgUIB
        icXFSvp2NkX5pSWpChn5xSW2SqkFKTkFpgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGetfnWUv
        +CtWsfXLI5YGxvOCXYycHBICJhLth3axdjFycQgJ7GCUWL/oDROE84lR4u/bdnYI5xujxOwl
        p1hhWhZu3gjVspdRYu786ywQzntGibbLj8GqhAUCJCb8fc/cxcjBISKgJfHyZipIDbPAN2aJ
        lmULmEBq2IDi+1/cYAOx+QUUJa7+eMwIYvMK2EmcudLBAmKzCKhK/F6yGMwWFQiTOLmtBapG
        UOLkzCdgcU4BS4lt+w+DzWQWEJe49WQ+lC0vsf3tHGaQxRICdzgkPp45yATxgotE8+yPLBC2
        sMSr41vYIWwpiZf9bewQDc2MEg0vbjNCOD2MEkef9UF1GEvsXzqZCeQ1ZgFNifW79CHCihI7
        f89lhNjMJ/Huaw8rSImEAK9ER5sQRImyxOUHd6FukJRY3N7JNoFRaRaSf2Yh+WEWkh9mISxb
        wMiyilEstaA4Nz212LDABB7fyfm5mxjB6VnLYgfj3Lcf9A4xMnEwHmKU4GBWEuG1ipiaJMSb
        klhZlVqUH19UmpNafIjRFBjCE5mlRJPzgRkiryTe0MTSwMTMyNjEwtDMUEmct3fq6UQhgfTE
        ktTs1NSC1CKYPiYOTqkGJpn9ISIfi7kkdZu8jxdd45xmtYk3Lbbmu/zz/e0/0rO5gv+4ntl5
        4P8Dif21kevZ3t26clbl3bSYopbNBQta0gSuuV+3KH/vsuqLiN2Wq7KsmzQ0FTYa7ZNU8Xh6
        mlNS5VmnoqDatMdteSuCxTIELk/cF7Mhod724iy7i7pXeV5MniD6NefdjP9Ge2O2pZX8YPaM
        eLXX2V9qwtWN/BNVvpdIvBV+9Fftnk/E9DvJVhr7wlUYv0lMsvgVq/biu6lqieCMxpajMY4C
        FXcs647WlJ3OC99tNMv69ZfP5rc421cdcJ3+LGevOMepWY/3VR9cXnVlR//y2OpHD5ZWqJ3d
        IKll8Pb5tqBjbEW8vE8qUpRYijMSDbWYi4oTAQWzSv9YBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCSvK76oqlJBsfOm1g8mLeNzeL8+Q3s
        Fntfb2W3ONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWtxtXsFm8+XGWyeLM6UusFv+ubWSx
        6Djyjdli41cPBz6PTas62TzuXNvD5rF5Sb3HlqvtLB59W1Yxehy/sZ3J4/MmuQD2KC6blNSc
        zLLUIn27BK6M9a/Oshf8FavY+uURSwPjecEuRk4OCQETiYWbN7J2MXJxCAnsZpSY0XeVDSIh
        KTHt4lHmLkYOIFtY4vDhYoiat4wSlyc8YwGpERbwk3j47QojSI2IgJbEy5upIDXMAn+YJVpX
        90ANXcUsMff/QbChbEBF+1/cALP5BRQlrv54zAhi8wrYSZy50gE2lEVAVeL3ksVgtqhAmMTO
        JY+ZIGoEJU7OfAIW5xSwlNi2/zBYnFlAXeLPvEvMELa4xK0n86Hi8hLb385hnsAoPAtJ+ywk
        LbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwlGpp7mDcvuqD3iFG
        Jg7GQ4wSHMxKIrxWEVOThHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBa
        BJNl4uCUamBi7/3z5Gfnu11r97BaK6vNVl1/Yy9b5wP9ts2r23I/RMwUqZaRetixbPtlvWnb
        Js5aNeuyy4H5K5/8r3OaUvPkCccTPk9L/wcvwmdVTejp3+bl+OmJ+aMFF1oquRcyTluXkTxZ
        XG/NRfZlidWGC0U3b4o5PVP8/B5GU+lVkU94dhiE6uicSDSONNj4SH5q+K6fOw61O5ifaZgw
        1XmrdIvjSWYD5YwtvVwaQXdYO3aeOGb49+nHGf8j529aUyd+VWiJwGqDQ61XX22/27rYtOzr
        1GfLYo8xfnLjuLzmjarJnP32X+ce1mluSTyo+XbmsT9nn506pZvYxKDz9LTa9Zlyi7cIJly9
        ws4VU7edf1beoi4lluKMREMt5qLiRABz6oLSQQMAAA==
X-CMS-MailID: 20220531050544epcas1p3f968f5c5e7a5e505e5311e4bb144d937
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
        <d9a96812-fd4e-cf46-cbe5-63f0e1d373a1@samsung.com>
        <20220531041505.egfe2kpi3bgb6l55@vireshk-i7>
        <20220531043809.xfpzz6c7x6utyjb3@vireshk-i7>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 1:38 PM, Viresh Kumar wrote:
> On 31-05-22, 09:45, Viresh Kumar wrote:
>> On 31-05-22, 13:12, Chanwoo Choi wrote:
>>> I try to find the cause of this warning.
>>> I think that dev_pm_opp_clear_config needs to check
>>> whether 'opp_table' is NULL or not as following:
>>>
>>>
>>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>>> index fba6e2b20b8f..cbf8f10b9ff0 100644
>>> --- a/drivers/opp/core.c
>>> +++ b/drivers/opp/core.c
>>> @@ -2598,6 +2598,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
>>>   */
>>>  void dev_pm_opp_clear_config(struct opp_table *opp_table)
>>>  {
>>> +       if (unlikely(!opp_table))
>>> +               return;
>>> +
>>>         if (opp_table->genpd_virt_devs)
>>>                 dev_pm_opp_detach_genpd(opp_table);
>>
>> Does this fixes it for you ?
>>
>> It isn't allowed to call this routine with opp_table as NULL, I should
>> rather have a WARN() for the same instead.
>>
>> Can you check why exynos is passing NULL here as I don't see an
>> obvious reason currently.
> 
> Looking at the exynos devfreq driver again, it feels like the design
> of the driver itself is causing all these issues.
> 
> Ideally, whatever resources are acquired by probe() must be freed only
> and only by remove()/shutdown(). But you are trying to do it from
> exynos_bus_exit() as well. Calling dev_pm_opp_of_remove_table() as
> well from this function is wrong as you may very well end up
> corrupting the OPP refcount and OPP may never get freed or something
> else may come up.
> 
> For now I am adding following to the patch, please see if it fixes it
> or not (I have pushed the changes to my branch as well).
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 780e525eb92a..8fca24565e7d 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -161,8 +161,11 @@ static void exynos_bus_exit(struct device *dev)
> 
>         dev_pm_opp_of_remove_table(dev);
>         clk_disable_unprepare(bus->clk);
> -       dev_pm_opp_clear_config(bus->opp_table);
> -       bus->opp_table = NULL;
> +
> +       if (bus->opp_table) {
> +               dev_pm_opp_clear_config(bus->opp_table);
> +               bus->opp_table = NULL;
> +       }
>  }
> 
>  static void exynos_bus_passive_exit(struct device *dev)
> @@ -463,8 +466,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
>         dev_pm_opp_of_remove_table(dev);
>         clk_disable_unprepare(bus->clk);
>  err_reg:
> -       dev_pm_opp_clear_config(bus->opp_table);
> -       bus->opp_table = NULL;
> +       if (bus->opp_table) {
> +               dev_pm_opp_clear_config(bus->opp_table);
> +               bus->opp_table = NULL;
> +       }
> 
>         return ret;
>  }
> 

This change is enough to remove the null pointer error. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
