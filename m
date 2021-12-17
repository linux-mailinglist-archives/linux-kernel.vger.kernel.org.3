Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9484781EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhLQBJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:09:04 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:56400 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhLQBJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:09:03 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211217010901epoutp0362f20d7c7433ab67e4576fdcd85969df~BZYBr4UiR0554705547epoutp03z
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:09:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211217010901epoutp0362f20d7c7433ab67e4576fdcd85969df~BZYBr4UiR0554705547epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639703341;
        bh=64+sb0x84cnuhFi2hvopvmRPJOEX1nVTHzV4z5VhkmA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XsFrqpchyFfyh7Z9O3NhucIDX2RDmyZg6KXK7yrrCg0sPHM3hH+3Sbolm7elRTKV5
         pRkz4w0I/Btp08nJnlaGKkSOh8EkOXCep2ne/GD/+PdLitG+xTU+md1iKaprQmEZTR
         a5bhipXo80SEN3ecSGvSLIWqq6uLy4FNmWBrC84o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211217010901epcas1p1aac532660ac79a097d7214bd5ad2447f~BZYBNIutk1654616546epcas1p1n;
        Fri, 17 Dec 2021 01:09:01 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.237]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JFW8N3ccXz4x9QN; Fri, 17 Dec
        2021 01:08:52 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.64.28648.F13EBB16; Fri, 17 Dec 2021 10:08:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211217010847epcas1p2d44a4b1a5fa713c126a48697305c80b3~BZX0XEIHJ2372023720epcas1p2i;
        Fri, 17 Dec 2021 01:08:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211217010847epsmtrp2a813a03c1dc761672460a3f9f72a6cff~BZX0VH9pq2114021140epsmtrp2Q;
        Fri, 17 Dec 2021 01:08:47 +0000 (GMT)
X-AuditID: b6c32a39-ff1ff70000006fe8-5b-61bbe31f38ac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.EC.29871.E13EBB16; Fri, 17 Dec 2021 10:08:46 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211217010846epsmtip16f9ee118c19b4120a71dabc79476bd2b~BZX0Dh7us0725907259epsmtip1O;
        Fri, 17 Dec 2021 01:08:46 +0000 (GMT)
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
Message-ID: <1b4515cc-bddc-ff3d-7789-ea2eb66a2e4e@samsung.com>
Date:   Fri, 17 Dec 2021 10:31:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211216155916.GA7738@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmnq78492JBpsPGFgca3vCbvH633QW
        i+bF69ks3hyfzmTRtXoni8XWW9IWl3fNYbOYvaSfxeJz7xFGi0XLWpktniw8w2Rxu3EFm8Xp
        3SUWPw+dZ3Lg89jwaDWrx6ZVnWwe804Geuyfu4bd4+PTWywe7/ddZfPY+b2B3aNvyypGj8+b
        5AI4o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BO
        V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkC
        FSZkZyz5foG94A9Xxf4DW5gbGO9ydDFyckgImEhMmN3M3sXIxSEksINRYun7jcwQzidGiQnX
        trBBON8YJR7sXs8I03JiwzKolr2MEj/nzGCBcN4zSkx7+5gFpEpYwEuia/YhNhBbREBH4nLn
        D7AOZoHrzBJ953czgSTYBLQk9r+4AVbEL6AocfXHY6AVHBy8AnYS025ZgYRZBFQl5r1aC1Yi
        KhAmcXJbC9gVvAKCEidnPgHbxQk05uunr2BxZgEDiSOL5rBC2OISt57MZ4Kw5SW2v53DDPHB
        Cw6Jpa3mELaLxM9P86A+E5Z4dXwLO4QtJfH53V6w9yUEljFK/JrcyQThrGeUeDmrE2qSscT+
        pZOZIGxFiZ2/50JdwSfx7msPK8gzEgK8Eh1tQhAlyhKXH9yFKpeUWNzeyTaBUWkWkn9mIflh
        FpIfZiH5YQEjyypGsdSC4tz01GLDAlN4hCfn525iBKdsLcsdjNPfftA7xMjEwXiIUYKDWUmE
        V3H57kQh3pTEyqrUovz4otKc1OJDjKbAIJ7ILCWanA/MGnkl8YYmlgYmZkbGJhaGZoZK4rzP
        /acnCgmkJ5akZqemFqQWwfQxcXBKNTAF10vyfTOYGD9JustEQmLz1tWVa9YKdm9eHbNEf8/F
        A0Zua68uPhj87Chb27/TNw8oCJVvzjnGFO3mKasqOE9m4jpp2VvPROYHvZR8tofD55Za9NMY
        +/+Xb/fKaK/rdDhZv+1lw4abvowvXrUnCfaulFkouaDwivbTbCa+lcXZ/HrFZQYSUu/PTlyw
        adHH/ZN/nGS/lSCgmpkU+IvzY+zkje971f0SYrrv5RxZJPAzM3Kf47vEU4/mnwt7mxXAdG5i
        gOatFf1X2C/rufAkcL6e3P3pxKJdVofZevxa325VeRBuIdjC39m9iF0k1OIYb2q0ksTRvMDn
        eT8v/ymbZxaczfjE+1lvnHtk8Es3DiElluKMREMt5qLiRAAbvHQgYgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCSnK7c492JBrdbrCyOtT1ht3j9bzqL
        RfPi9WwWb45PZ7LoWr2TxWLrLWmLy7vmsFnMXtLPYvG59wijxaJlrcwWTxaeYbK43biCzeL0
        7hKLn4fOMznweWx4tJrVY9OqTjaPeScDPfbPXcPu8fHpLRaP9/uusnns/N7A7tG3ZRWjx+dN
        cgGcUVw2Kak5mWWpRfp2CVwZS75fYC/4w1Wx/8AW5gbGuxxdjJwcEgImEic2LGPvYuTiEBLY
        zSixomUbM0RCUmLaxaNANgeQLSxx+HAxRM1bRonGvvesIDXCAl4SXbMPsYHYIgI6Epc7f4AN
        Yha4zSzRdOwJM0THbyaJrqcQU9kEtCT2v7gB1sEvoChx9cdjRpANvAJ2EtNuWYGEWQRUJea9
        WgtWIioQJrFzyWMmEJtXQFDi5MwnLCA2J9CYr5++MoLYzAJ6Ejuu/2KFsMUlbj2ZzwRhy0ts
        fzuHeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB
        cauluYNx+6oPeocYmTgYDzFKcDArifAqLt+dKMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJ
        eCGB9MSS1OzU1ILUIpgsEwenVAPTwjefTojELjq0kEl4Y22S1uO7b6v/l0VpGpvyGMZmi6xk
        LXug+rqtXern94fKe438ldYVBG8Ue/0zWSpLJrRYcSPzCgHR2WfF1sgJGHn+aa+5zcz0u1O5
        6AVDu/n0C99uShx64vqoQEZE/Q7jjPtJk4vyNsxPrZgn83Xel82n5dfasYX5yXs/8i/afPdh
        xpvPXc8neD9ZJMcW/VHmo2tWbeYksZ0hQgXbV5k+v8wvm/zkTv3cdzOjb+38V3v+qYRAvFtR
        1pTvyoYWHuc0Ja5z2vakS5mzymuf9rLP89M9Evzx9bHNTPplV+RMF/VqbFsRqWsTt8JoaeCK
        E8zXshg3TJTar/5FYm5gQ2HHk2glluKMREMt5qLiRAAzHHy3SgMAAA==
X-CMS-MailID: 20211217010847epcas1p2d44a4b1a5fa713c126a48697305c80b3
X-Msg-Generator: CA
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
        <c8d18573-5dc1-4d45-f134-2a1dbb7590b6@samsung.com>
        <20211216155916.GA7738@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 12:59 AM, Dan Carpenter wrote:
> On Thu, Dec 16, 2021 at 05:38:04PM +0900, Chanwoo Choi wrote:
>>>
>>> To be honest, I'm not sure how this differs from other functions which
>>> return -EPROBE_DEFER.  How do other functions guarantee they will only
>>> be called from probe()?
>>
>> If it is possible to know extcon_get_extcon_dev() will be only callled on probe,
>> it is no problem. But, it is not able to guarantee that extcon_get_extcon_dev()
>> is called on probe. Because of this reason, this issue should be handled in each device driver.
>>
>> -EPROBE_DEFER is only for probe step. If return -EPROBE_DEFER except for probe,
>> it is wrong return value.
> 
> The future is vast and unknowable.  We can't really future proof code
> and we should never try do that if it makes the code more complicated
> right now.
> 
> When Andy submitted basically the same patch as me three years ago we
> worried about future developers so we didn't merge his patch.  But
> three years later no non-probe() were introduced.  Meanwhile the bad API
> created bugs in the kernel for current users.

As you mentioned, there were no use case except for probe step.
OK. I agree this approach.


For merging this patch, need to get ack from power-supply and usb maintainer.
After getting the ack, I'll merge it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
