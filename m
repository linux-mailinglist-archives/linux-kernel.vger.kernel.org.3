Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE9549991
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbiFMRK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241513AbiFMRKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:10:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E77654697
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:16:25 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220613120823euoutp011d591c621553cfa6b3c5a0d374d5e794~4LMieNqq13116331163euoutp01A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:08:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220613120823euoutp011d591c621553cfa6b3c5a0d374d5e794~4LMieNqq13116331163euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655122103;
        bh=QSob/y9/w6tt5AMCsUanVXl/z9x2wOV9FN7BY0bAnVk=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=HNgFaSABRyRa2kFO6Al3pYBx6gSilRNvUqiu/ob4rtZkNbK+Gl+9S54KuLqDNuBbc
         6rgtGEvuLxl4g0cFmD+5ZTcC8XP6f1DLecSb0EYGsvMnGzOnwtRs8V4zU5X8p+sFov
         6+8hxBHUTw/8av9qgjdfpz5tNsa/tKFqJXKci+8Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220613120822eucas1p1ce667b815f70a278f8b973bfdd54d625~4LMiL5UEa0212102121eucas1p1Y;
        Mon, 13 Jun 2022 12:08:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B4.57.09580.6B827A26; Mon, 13
        Jun 2022 13:08:22 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220613120822eucas1p163e0654f3efdb920b13f7451ba92ddc7~4LMhr3D051233212332eucas1p1Y;
        Mon, 13 Jun 2022 12:08:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220613120822eusmtrp1f3dba82f2197ba39eb9682a01f37daff~4LMhq4v7V1004110041eusmtrp1c;
        Mon, 13 Jun 2022 12:08:22 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-97-62a728b61d79
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 14.F8.09095.6B827A26; Mon, 13
        Jun 2022 13:08:22 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220613120821eusmtip191964802d357b561d39cb3c9f084a278~4LMgxierW1928619286eusmtip18;
        Mon, 13 Jun 2022 12:08:21 +0000 (GMT)
Message-ID: <701bee9a-a06d-8b1a-bf23-d893249c7764@samsung.com>
Date:   Mon, 13 Jun 2022 14:08:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
Content-Language: en-US
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>
Cc:     Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <31ed17e7-29d1-55e8-cb09-a750ab80da15@squashfs.org.uk>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURiFvTPTYVpbGQvIFYhiiQsYQRbJKK6RmElMXB70ARcsMqkoFNNS
        RQzKJmBBgiwFCgoRI0VRsEghJRJplEVQkQYlDQE0GBWthFZEQUDKoPL23XPOn//cm0ugwlaO
        CxEhjWFkUnGkCOdhupZfLzfo1lWEbXzS4UuVVFfhlNbwFaeyr9SjlFFfglP9VTMcKr2yn0M9
        y6zFqR79ZWry56xu0Y9wqDffOnFqfLAW2cmnixNeY3TKUzOHrtV40VpLjh3dVjiJ0Y1lVoTO
        G/uI0lbtCrr6UR1ygBvC2xrOREacY2Q+20/wTqW8zQJnixxiNeMZaAJos1cCLgHJAJj4YgJV
        Ah4hJDUAJumLAHv4DqAl4/e8YwXQWt+F/B0pMCQgrFEBYKbyOrAZQnIUwK6+eBsLyO3Q9CGL
        Y2OMXA21pY0oqy+F7UVDmI2dyDBYqrsyl3EgN8NBfcVcBiWdoWmodG6Bo61Tc00+whomBCqL
        /WyMk75QaVbiNuaSu2HO9OP54ZUwua54rjYki7lQOXB/vnYwVOk7cZYd4HDrIzuW3WBHbuZs
        I2KWo+FUoT8rx8I3X6pQloNg38sJ3BZBSU9Yrfdh5V2wusKKsJNLYK95KdtgCczRFaCsLIDp
        qUI2vQaqWx/829nc1Y1mA5F6waOoF1xeveAu6v97ywB2FzgzCnmUhJH7S5nz3nJxlFwhlXif
        jI7Sgtm/1jHdOtYANMOj3gaAEMAAIIGKHAW5r++ECQXh4gtxjCw6VKaIZOQG4EpgImfByYga
        sZCUiGOYMwxzlpH9dRGC65KApPNVbw/eCHTWBk6s9Ck4PHZZFja19/jFDotHhqhxxj+Qzr9d
        83ky19Ws5g8oNDGSQmuIse9F+OncLg9X4t25HqdPqXyNqf2auyktpXxZS/dI0Vjwet2Wlj33
        DiXeMi76cKG/t3Kv36b2Jt/ujZsQwQ5LQLJXc8D+/lSRvUfQcNz9ewdVmYHI7X2jU+nCHT/c
        p5u+5rlVxvVix0Iv6fKk25oGBhenubRRjaVrQ97vRHg/gx33ZNO12TNH3NY8VJSlGbq/xbtt
        sCs3x65CGZrH68ziXC2vi1chXnVHda/cPTuv3YiQ7jae15fxqaSRm0bvKUnPuKphuTXLSTG8
        2f15kwiTnxL7eqEyufgPxiEcfNoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7rbNJYnGcy9zGsxZ/0aNotNh96w
        WUxo3c5scXnXHDaLe2v+s1p0rLzHanG0ZzObxdVd9Ra/fwDFP+16z2px7d0ZNovvDzYzOfB4
        zG64yOLRcuQtq8fmFVoemz5NYvc4MeM3i8fuBZ+ZPKZ8fc7s8XmTnMf6LVuZAjij9GyK8ktL
        UhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJarvcxFswUrljx
        vZu5gfEEfxcjJ4eEgInE9EMNTF2MXBxCAksZJXq/TmWESMhInJzWwAphC0v8udbFBlH0nlHi
        5Mx9YAleATuJW0/7wGwWAVWJTfN3M0PEBYFqnrCA2KICSRLz9q4GGyosYCnxYNdysBpmAXGJ
        W0/mM4HYIgIrGCX+bwyHiN9hkrjewAyxbC2TxN6Vs9hBEmwChhJdb0Gu4OTgFHCWmPRvL9Qg
        M4murV2MELa8RPPW2cwTGIVmIbljFpJ9s5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpe
        cn7uJkZgNG879nPzDsZ5rz7qHWJk4mA8xCjBwawkwjv54rIkId6UxMqq1KL8+KLSnNTiQ4ym
        wMCYyCwlmpwPTCd5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M
        TD0/2eeE53Um6ff82Psgz3yGXpH/Ckn+3CtcV1yXfnA6x7bGIWdn/tID3adaDn3Y/sLpztE7
        K5tEnWwtGkuS25SbhCV5j0Wtf8+nuXj6H88LIuccDE+/cPKazztzo5DFig0Hnkjz/185b26i
        iEtt5/0dZbUiRr/2/Z53dt2MMFU524De0JK/gWy7wp/8OPI6tHT/3LRO76yzkx4y7EmRXVV3
        r7e2haPn8Ker7manHjxe+aVMcfs5B1frvYfU51g4xc6Yuf7qrppk5mnhy0w9Pr533ijP+PrR
        Fh3NmK9L7jzh/9myQNvq6pJAhtjXSunXt69cVa/l0B1fseT8v+CTM35ciT/Napv998Q059Vn
        rimxFGckGmoxFxUnAgA+T9eIbwMAAA==
X-CMS-MailID: 20220613120822eucas1p163e0654f3efdb920b13f7451ba92ddc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75
References: <20220601103922.1338320-1-hsinyi@chromium.org>
        <20220601103922.1338320-4-hsinyi@chromium.org>
        <CGME20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75@eucas1p1.samsung.com>
        <c017d992-2746-045b-47c8-c5b9c3025f1a@samsung.com>
        <31ed17e7-29d1-55e8-cb09-a750ab80da15@squashfs.org.uk>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On 07.06.2022 09:35, Phillip Lougher wrote:
> On 03/06/2022 13:54, Marek Szyprowski wrote:
>> Hi,
>>
>> On 01.06.2022 12:39, Hsin-Yi Wang wrote:
>>> Implement readahead callback for squashfs. It will read datablocks
>>> which cover pages in readahead request. For a few cases it will
>>> not mark page as uptodate, including:
>>> - file end is 0.
>>> - zero filled blocks.
>>> - current batch of pages isn't in the same datablock or not enough in a
>>>     datablock.
>>> - decompressor error.
>>> Otherwise pages will be marked as uptodate. The unhandled pages will be
>>> updated by readpage later.
>>>
>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>> Reported-by: Matthew Wilcox <willy@infradead.org>
>>> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
>>> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
>>> ---
>>
>> This patch landed recently in linux-next as commit 95f7a26191de
>> ("squashfs: implement readahead"). I've noticed that it causes serious
>> issues on my test systems (various ARM 32bit and 64bit based boards).
>> The easiest way to observe is udev timeout 'waiting for /dev to be fully
>> populated' and prolonged booting time. I'm using squashfs for deploying
>> kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on
>> top of the next-20220603 fixes the issue.
>>
>> Let me know how I can help debugging this issue. There is no hurry
>> though, because the next week I will be on holidays.
>
> Hi Marek,
>
> Can you supply an example Squashfs filesystem and script that
> reproduces the slow-down?  Failing that, can you supply a copy
> of your initrd/root-filesystem that can be run under emulation
> to reproduce the issue? (I don't have any modern ARM embedded
> systems).
>
> Again failing that, are you happy to test some debug code?
>
> Thanks
>
> Phillip (Squashfs maintainer and author).

I've just got back from my holidays.

Is this still relevant? I've noticed that v6 has been posted, but I 
failed to apply it on top of next-20220610 as mentioned in the 
cover-letter to test. I've also tried also to apply the mentioned 
'Squashfs: handle missing pages decompressing into page cache' patchset. 
On the other hand, next-20220610 seems to be working fine on my setup now.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

