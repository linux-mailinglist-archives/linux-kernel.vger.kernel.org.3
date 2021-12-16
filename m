Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AF8476BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhLPIPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:15:13 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:61323 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhLPIPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:15:11 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20211216081510epoutp02b391dc3d35fc1acf882cb154cffd569e~BLiz7KZs11317913179epoutp02P
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:15:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20211216081510epoutp02b391dc3d35fc1acf882cb154cffd569e~BLiz7KZs11317913179epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639642510;
        bh=LMoxrbyqzv20TkTPVfqQqFh9NWqqZbffNlA4jYTh2xI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QXK1YQUzXSwT0C5++zF5V7T1d30lDcmHSp+QHcBq5Jhgpo/gWrn2ht67eWOEm/FT9
         ptD19txcKzwtemDkTw0PF2upP+RW1IGYep8efIsCY+LK1MIoLmaZ1XS3/SrJFP1wgp
         r9GvR+c4dIHe3OovoFwwy4PaaEy6OvXYbZkcdkFk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211216081509epcas1p1e9ead12c5b6fa306927d4bf12bbed6a6~BLizYNhSK1324013240epcas1p1i;
        Thu, 16 Dec 2021 08:15:09 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.234]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JF4fc61kVz4x9Q6; Thu, 16 Dec
        2021 08:15:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.5F.28648.885FAB16; Thu, 16 Dec 2021 17:15:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211216081504epcas1p3ebfe072845fe7cfd4833b2b57199a701~BLiuqPFcm3128431284epcas1p3S;
        Thu, 16 Dec 2021 08:15:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211216081504epsmtrp28351954c144e9d5dabafad852521baff~BLiupWzCX0525305253epsmtrp2h;
        Thu, 16 Dec 2021 08:15:04 +0000 (GMT)
X-AuditID: b6c32a39-813e6a8000006fe8-49-61baf588bc05
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.97.29871.785FAB16; Thu, 16 Dec 2021 17:15:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211216081504epsmtip2961137dfcc552c1938690c9107d01b63~BLiuUkrE02233122331epsmtip29;
        Thu, 16 Dec 2021 08:15:04 +0000 (GMT)
Subject: Re: [PATCH v2] extcon: fix extcon_get_extcon_dev() error handling
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c8d18573-5dc1-4d45-f134-2a1dbb7590b6@samsung.com>
Date:   Thu, 16 Dec 2021 17:38:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211216080558.GE1978@kadam>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmvm7H112JBpcOa1gca3vCbvH633QW
        i+bF69ks3hyfzmTRtXoni8XWW9IWl3fNYbOYvaSfxeJz7xFGi0XLWpktniw8w2Rxu3EFm8Xp
        3SUWPw+dZ3Lg89jwaDWrx6ZVnWwe804Geuyfu4bd4+PTWywe7/ddZfPY+b2B3aNvyypGj8+b
        5AI4o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BO
        V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkC
        FSZkZ3Rfm8JWcICv4tHNy6wNjGe5uxg5OSQETCQu3OhlB7GFBHYwSpxc79vFyAVkf2KUuPbs
        BSOE841RYv2tOewwHZu7trNDJPYySmz7sIwJwnnPKPHx4UNGkCphAS+JrtmH2EBsEQEdicud
        P8A6mAWuM0v0nd/NBJJgE9CS2P/iBlgRv4CixNUfj8GaeQXsJF7/eQQWZxFQlZjW08QKYosK
        hEmc3NYCVSMocXLmExYQmxNozpe9h8HizALiEreezGeCsOUltr+dwwyyWELgCYfE/mvX2CB+
        cJFYP7sP6h9hiVfHt0DZUhKf3+1lg2hYxijxa3InE4SznlHi5axOZogqY4n9SycDJTiAVmhK
        rN+lDxFWlNj5ey7UFXwS7772sIKUSAjwSnS0CUGUKEtcfnCXCcKWlFjc3sk2gVFpFpJ/ZiH5
        YRaSH2YhLFvAyLKKUSy1oDg3PbXYsMAUHt/J+bmbGMEJW8tyB+P0tx/0DjEycTAeYpTgYFYS
        4X0SsStRiDclsbIqtSg/vqg0J7X4EKMpMIQnMkuJJucDc0ZeSbyhiaWBiZmRsYmFoZmhkjjv
        c//piUIC6YklqdmpqQWpRTB9TBycUg1MXh2CPy6/N76yW0rA7OwSl819SQdEJaKnd1+Xc/2a
        uytYbIH1KzPN6R+eMt5xcsj8EXDu7b7Nql9XXDkYtqst9rpT/FURLpFPJ67sDtjw8nS3e2Us
        x4xZ+/bMyrDdte/11+cPv3TrRO8OvTTn+KKgB/Xx4ucXGBw990Oipo/pfUB335pG/slzL1qc
        5v7r5xlforZqQ+Vr2TvM0fovbHWVpr5fn1XwWImn32xOWtV8O2P2gjMx9vl+/0Tvr3zEeyLs
        Q7Th/Y2GK38uS5z8zG/y9RfSStE5t/W+yUVsu75EqUGj3nvexL8Cq876vTHavjfFIFgpM7HZ
        W3LpX+3DBya1F/as0BOZruI0c0fczw9/xZVYijMSDbWYi4oTASnbrTthBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSvG77112JBnOPm1sca3vCbvH633QW
        i+bF69ks3hyfzmTRtXoni8XWW9IWl3fNYbOYvaSfxeJz7xFGi0XLWpktniw8w2Rxu3EFm8Xp
        3SUWPw+dZ3Lg89jwaDWrx6ZVnWwe804Geuyfu4bd4+PTWywe7/ddZfPY+b2B3aNvyypGj8+b
        5AI4o7hsUlJzMstSi/TtErgyuq9NYSs4wFfx6OZl1gbGs9xdjJwcEgImEpu7trN3MXJxCAns
        ZpQ4MXkrK0RCUmLaxaPMXYwcQLawxOHDxRA1b4FqzqwDqxEW8JLomn2IDcQWEdCRuNz5A2wQ
        s8BtZommY0+YITqWMUkcWLWDGaSKTUBLYv+LG2Ad/AKKEld/PGYEsXkF7CRe/3kEFmcRUJWY
        1tMEtkFUIExi55LHTBA1ghInZz5hAbE5geZ82XsYrJdZQF3iz7xLzBC2uMStJ/OZIGx5ie1v
        5zBPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhy
        tTR3MG5f9UHvECMTB+MhRgkOZiUR3icRuxKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkv
        JJCeWJKanZpakFoEk2Xi4JRqYLIxX61gsu2MvXvbvtg0gcMfTu7VPeP3TqWmwt6oqEjwf97l
        hQp9idnslRIl334smlWgP3/fXgGno985qyzzCs78lOR2UJ1cbRjFFr+9RNXe5rPhN8nbZx8Y
        KE3jnqAnUv5EUkVJvNlD+3rr+Rr31ykWO2I1710VcHn0smHqy/N1V6uO6tjbnnGRcClm2Ffb
        nVJ/qmDVXvPPT/mnOUc7iqyv2r5tk22Rmq2A0Jv34kI8JxM7nC956VzLbbz/YGJzpv1Sy8sN
        G+03WE/OTVm6TFzsUupZ/lRz28dPEkr9F0cpfZxieXtPwNavGaKT2uu4f91Ml0nacfcIy6Rt
        hbtnm3V8jNvbyr/9I+fWzPXPlFiKMxINtZiLihMBlgKyGEsDAAA=
X-CMS-MailID: 20211216081504epcas1p3ebfe072845fe7cfd4833b2b57199a701
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211123084357epcas1p14833147710153f9606f14941ac8b0d96
References: <CGME20211123084357epcas1p14833147710153f9606f14941ac8b0d96@epcas1p1.samsung.com>
        <20211123083925.GA3277@kili>
        <562b12ff-e395-c818-787e-7fd6ee6d53fb@samsung.com>
        <20211216075233.GD1978@kadam>
        <b4d0c326-3122-c5f9-f376-b122f263d92c@samsung.com>
        <20211216080558.GE1978@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 5:05 PM, Dan Carpenter wrote:
> On Thu, Dec 16, 2021 at 05:24:30PM +0900, Chanwoo Choi wrote:
>> On 12/16/21 4:52 PM, Dan Carpenter wrote:
>>> On Thu, Dec 16, 2021 at 03:39:46PM +0900, Chanwoo Choi wrote:
>>>> Hi Dan,
>>>>
>>>> First of all,  sorry for late reply.
>>>>
>>>> There is one issue. About this issue, I already discussed on patch[1]
>>>> [1] https://lore.kernel.org/lkml/5BEB63C3.1020504@samsung.com/  
>>>>
>>>> extcon_get_extcon_dev() is used for anywhere except for probe step.
>>>> But EPROBE_DEFER is only used on probe step.
>>>>
>>>> So that it is not clear to return EPROBE_DEFER from extcon_get_extcon_dev()
>>>> because extcon_get_extcon_dev() never know either call it on probe function
>>>> or not.
>>>
>>> Currently extcon_get_extcon_dev() is only called from probe so it's not
>>> an issue.
>>
>> Even if extcon_get_extcon_dev() is used on probe until now,
>> it is possible to use on anywhere as I commented.
>>
>> It is difficult to agree this approach without any other solution.
>>
>> Basically, the subsystem core never know either probe time or not.
>> It means that this issue should be handled in each device driver.
>>
> 
> To be honest, I'm not sure how this differs from other functions which
> return -EPROBE_DEFER.  How do other functions guarantee they will only
> be called from probe()?

If it is possible to know extcon_get_extcon_dev() will be only callled on probe,
it is no problem. But, it is not able to guarantee that extcon_get_extcon_dev()
is called on probe. Because of this reason, this issue should be handled in each device driver.

-EPROBE_DEFER is only for probe step. If return -EPROBE_DEFER except for probe,
it is wrong return value.



> 
> regards,
> dan carpenter
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
