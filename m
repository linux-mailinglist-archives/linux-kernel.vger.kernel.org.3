Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E3538AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbiEaFED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiEaFEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:04:00 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4CA9346A
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:03:56 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220531050350epoutp028a103c027877eae773514fadf2b4ee02~0GBJ8oCDR0318103181epoutp02a
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:03:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220531050350epoutp028a103c027877eae773514fadf2b4ee02~0GBJ8oCDR0318103181epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653973430;
        bh=K2k1Ywgc0/YF1YoLECrBkBiSz753RyZ3uT7PR6vqfMA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TWPykm5T+Ayj0oMpHoV9wBkut0tqMU0v3c6r8i79EkmdWScvbJWAQ2ZMcBCN9Cn+i
         JgU3fBNU8EehSUFjgOXlErT/sAMUmHLwhln4Cnp9EWe+XydrdXXPsv0C2C69ovmRzf
         GzM36kNRMe67rVaCx6mI+3JdGv2B95baDAUbvc1U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220531050350epcas1p327810a1642338af39fbf513326dec4c9~0GBJSqzYE2707027070epcas1p3E;
        Tue, 31 May 2022 05:03:50 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.134]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LC0YK0c5Tz4x9QJ; Tue, 31 May
        2022 05:03:49 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.1B.09785.3B1A5926; Tue, 31 May 2022 14:03:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220531050346epcas1p218554f6c560c9cc321aa477b349c0701~0GBGJsc2R1200512005epcas1p2n;
        Tue, 31 May 2022 05:03:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220531050346epsmtrp2bda96ea5f86806e318d8121134c8fb17~0GBGIf0Pa2516025160epsmtrp2c;
        Tue, 31 May 2022 05:03:46 +0000 (GMT)
X-AuditID: b6c32a36-c9dff70000002639-3c-6295a1b34e31
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.70.08924.2B1A5926; Tue, 31 May 2022 14:03:46 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220531050346epsmtip155f38ff89be7c800b1566f31a8e6591e~0GBFzPZDR2027420274epsmtip1r;
        Tue, 31 May 2022 05:03:46 +0000 (GMT)
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
Message-ID: <21da6fa9-4b10-bbfc-8577-0901118388a5@samsung.com>
Date:   Tue, 31 May 2022 14:03:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220531041505.egfe2kpi3bgb6l55@vireshk-i7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmvu7mhVOTDN7+4LZ4MG8bm8X58xvY
        Lfa+3spucbbpDbvFpsfXWC0u75rDZvG59wijxYzz+5gsbjeuYLN48+Msk8WZ05dYLf5d28hi
        0XHkG7PFxq8eDnwem1Z1snncubaHzWPzknqPLVfbWTz6tqxi9Dh+YzuTx+dNcgHsUdk2GamJ
        KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKymUJeaUAoUC
        EouLlfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM7r/TGQp
        WM5dsXn1RZYGxrccXYycHBICJhKPe++zdDFycQgJ7GCUuL5gPzOE84lR4uqk6YwQzmdGiUO3
        NrDDtLTtmAOV2MUo8ff5RzYI5z2jxMJH78CqhAUCJCb8fQ80i4NDREBL4uXNVJAaZoFvzBIt
        yxYwgdSwAcX3v7jBBmLzCyhKXP3xmBHE5hWwk/j1Yw1YnEVAVeLW85tgcVGBMImT21qgagQl
        Ts58wgJicwpYSpyYvhesnllAXOLWk/lMELa8xPa3c8D+kRC4wSExa9tsqBdcJPa8esMMYQtL
        vDq+BSouJfH53V42iIZmRomGF7cZIZweRomjz/pYIKqMJfYvncwE8hqzgKbE+l36EGFFiZ2/
        5zJCbOaTePe1hxWkREKAV6KjTQiiRFni8oO7TBC2pMTi9k62CYxKs5D8MwvJD7OQ/DALYdkC
        RpZVjGKpBcW56anFhgVG8PhOzs/dxAhOz1pmOxgnvf2gd4iRiYPxEKMEB7OSCK9VxNQkId6U
        xMqq1KL8+KLSnNTiQ4ymwBCeyCwlmpwPzBB5JfGGJpYGJmZGxiYWhmaGSuK8q6adThQSSE8s
        Sc1OTS1ILYLpY+LglGpgShQ9l/jl57qnepHrb2bcOm+y9MHXa12pO4SuFm0Iyf22L9eiqvyE
        xbXzZ62f7A73/Lj11LfzxXkH/tk+33NDPPP8pdwFBT9/e+zbx3pizy/rxc43hLKb+TOfbdnw
        5KhgE8sR6/AcxUKnz6XXFOTLtGukrZrzvLdsfyMuJnH2fZsNB6/O+1OCfgcD9zWr2Xuq3Qk7
        fyC4NbEr+q+kkdC+Jfejyjxuf3Zo1g0on+oaMGuyn5mBpFDe/E2x3WemO8wMrq4Or/maaC18
        peql+TLXW+8msfHviI+PnlakJxe2fr9sW212d+SSiNbMVbGl57YEmy+1DNr0/44KQ2nByf/5
        dnILKlUNIutU4rdtyl+txFKckWioxVxUnAgAksZOYVgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCSnO6mhVOTDFomq1o8mLeNzeL8+Q3s
        Fntfb2W3ONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWtxtXsFm8+XGWyeLM6UusFv+ubWSx
        6Djyjdli41cPBz6PTas62TzuXNvD5rF5Sb3HlqvtLB59W1Yxehy/sZ3J4/MmuQD2KC6blNSc
        zLLUIn27BK6M7j8TWQqWc1dsXn2RpYHxLUcXIyeHhICJRNuOOYxdjFwcQgI7GCXefrzKBJGQ
        lJh28ShzFyMHkC0scfhwMUTNW0aJR9/7wGqEBfwkHn67wghSIyKgJfHyZipIDbPAH2aJ1tU9
        rBANv5kknv1czwrSwAZUtP/FDTYQm19AUeLqj8eMIDavgJ3Erx9rwOIsAqoSt57fBIuLCoRJ
        7FzymAmiRlDi5MwnLCA2p4ClxInpe8HqmQXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRG4VlI
        2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCo1RLawfjnlUf
        9A4xMnEwHmKU4GBWEuG1ipiaJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU
        1ILUIpgsEwenVAPTjHZ3h9V+93ku1jHuWTmV9Y5TkMKT6HZmC73ae0b/JjSnbFOfO8nvv/IW
        n9vzmnf5s3AKM97iLUhL5tbOT05oz4+MnHa9y/LE/r1dq58JMkk+ejjNc3teTMiuLykpqdNK
        lvi0nPRoutJskbhXp2la3sfrcS/V+GSTz+dXMP7aaSpla1FQ6mvNu7bEX+1q0KGK791btEKC
        b28ISrpwIVZs25fnksmpupHVKXtF3iWIcewJdDOJ4rymckT32ddAq4a+BP6tG5Z32m6rPZ3P
        fuN15YdH8y0UujnDgoo1Cp/KsGRczEv8lZWRLPR518HEC6VWM6w/LzrtYrvu6kS/Caf2tz8V
        PMC+Ut6dI/27lBJLcUaioRZzUXEiAIrtDARBAwAA
X-CMS-MailID: 20220531050346epcas1p218554f6c560c9cc321aa477b349c0701
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
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 1:15 PM, Viresh Kumar wrote:
> On 31-05-22, 13:12, Chanwoo Choi wrote:
>> I try to find the cause of this warning.
>> I think that dev_pm_opp_clear_config needs to check
>> whether 'opp_table' is NULL or not as following:
>>
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index fba6e2b20b8f..cbf8f10b9ff0 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -2598,6 +2598,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
>>   */
>>  void dev_pm_opp_clear_config(struct opp_table *opp_table)
>>  {
>> +       if (unlikely(!opp_table))
>> +               return;
>> +
>>         if (opp_table->genpd_virt_devs)
>>                 dev_pm_opp_detach_genpd(opp_table);
> 
> Does this fixes it for you ?
> 
> It isn't allowed to call this routine with opp_table as NULL, I should
> rather have a WARN() for the same instead.
> 
> Can you check why exynos is passing NULL here as I don't see an
> obvious reason currently.
> 

exynos-bus.c contains the two type of devfreq device as following:
1. devfreq device controls the regulator
2. devfreq device doesn't control the regulator

Above two devfreq devices share the same error path
because two devices are similar.

As you said, if you use WARN(),
I can change it on exynos-bus.c as following:

if (bus->opp_table)
    dev_pm_opp_clear_config(bus->opp_table)


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
