Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B5C4613C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbhK2LWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:22:46 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50236 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbhK2LUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:20:40 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20211129111719euoutp0296d0044299864c5ffe095c7d7907a245~8AD-3X8xj0704907049euoutp02R
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 11:17:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20211129111719euoutp0296d0044299864c5ffe095c7d7907a245~8AD-3X8xj0704907049euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1638184639;
        bh=b4787yqAIG/Sm26YJGtmZU3KDAroSW4RgsR2sqn2dC0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=qqvRZlU6UKEZ86bdYvDfhhvyweB9qV4qhOoiYF5C0fKfXiLApBeSMHzK/W9GC9DVf
         yxmJWIEKaXmN6LMNvyrGiYFcrTOc07NO9kJEhVtt/es+lGh58/3YXyJMXy+p4aWqBv
         6qoXNLzDpw3KiTm/5Y/mWh4TG3PVbxfwW3KYj6ss=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211129111718eucas1p1671e76d73770a7041f6d1b576f069b28~8AD-bSplV2539325393eucas1p1h;
        Mon, 29 Nov 2021 11:17:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C2.38.09887.EB6B4A16; Mon, 29
        Nov 2021 11:17:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211129111717eucas1p1f8b73283a089fea6e64544c0bf8a0217~8AD_euorC2591225912eucas1p1X;
        Mon, 29 Nov 2021 11:17:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211129111717eusmtrp22000e71fe17e19dca4cd31e6bcdbda60~8AD_d5V000865908659eusmtrp2Q;
        Mon, 29 Nov 2021 11:17:17 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-81-61a4b6bee493
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9E.51.09404.DB6B4A16; Mon, 29
        Nov 2021 11:17:17 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211129111717eusmtip216db03b455cf4f50bfa08dff9e145f99~8AD9_Bvea3164531645eusmtip2T;
        Mon, 29 Nov 2021 11:17:17 +0000 (GMT)
Message-ID: <63be9121-18c3-1ef2-c448-f99fb861490f@samsung.com>
Date:   Mon, 29 Nov 2021 12:17:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while
 in suspend
Content-Language: en-US
To:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20211129094129.xn364czofrgtvfb4@skn-laptop>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7r7ti1JNLjZqWqxumU6o8XpM6eY
        LC7vmsNmsbtpGbvF4fZ9rBaTd75htHh/6hWbxf+zH9gdODzmran22HF3CaNHz7m37B6bVnWy
        eWxeUu9xc16hx/Eb25k8Pm+SC+CI4rJJSc3JLEst0rdL4Mp42RFUsJC/YvvO14wNjDt4uhg5
        OSQETCSadlxl7mLk4hASWMEoMWXNckYI5wujxJeGU8wgVUICnxkl7s1I7WLkAOtYdswAomY5
        o8STM9Oguj8C1by+zg7SwCtgJ3Fzy3NWEJtFQFXiza4FbBBxQYmTM5+wgNiiAkkSE07sZgKx
        hQXCJZZdOwq2jFlAXOLWk/lMIMtEBAIkVpxMgQi/ZpS4/0QQxGYTMJToetsFNpJTwFLi8p69
        rBA18hLNW2eD3SMh8INDYuKWt+wQb7pI/Pg2lxHCFpZ4dXwLVFxG4v9OkF0gDc2MEg/PrWWH
        cHoYJS43zYDqsJa4c+4XG8hFzAKaEut36UOEHSXe71jPCgkVPokbbwUhjuCTmLRtOjNEmFei
        o00IolpNYtbxdXBrD164xDyBUWkWUqjMQvL9LCTvzELYu4CRZRWjeGppcW56arFRXmq5XnFi
        bnFpXrpecn7uJkZggjr97/iXHYzLX33UO8TIxMF4iFGCg1lJhNf7zOJEId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rwifxoShQTSE0tSs1NTC1KLYLJMHJxSDUwtN6JC792uPvxVok5r1uYzlRv3
        uJ61mvLu6CVN8U8b5mwx/qyckP5PKkd8yqdlvo+bDj9c5HbxapX6Jglbp20v5r9+6aItE+7K
        FOnT53NTcUe4p/ERB0e1qqNXy/w7hSoz/Z0sG5pfT3j/SenWVN7s74uz18sYcThJRawReVT1
        3lPA0G+GLZP+n5gLidL6gh69E07aac5Qu/59qc/Bi0xGm8Vt7RmSz1zRian1q92x9sLz1OMi
        ZTaOmuc07r2da38j5ImI1eLTVY06/3bpr9gmfqRd0cAodpuGp4Xlbu7F5fp2OVuvuTTOcK2u
        26y4enWkjt+rnNZr06aq32Fg3no16mqp1/35544Vs7k811JiKc5INNRiLipOBAA4tjuDvwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7p7ty1JNLh5UMlidct0RovTZ04x
        WVzeNYfNYnfTMnaLw+37WC0m73zDaPH+1Cs2i/9nP7A7cHjMW1PtsePuEkaPnnNv2T02repk
        89i8pN7j5rxCj+M3tjN5fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtl
        ZKqkb2eTkpqTWZZapG+XoJfxsiOoYCF/xfadrxkbGHfwdDFycEgImEgsO2bQxcjFISSwlFHi
        xM5VrF2MnEBxGYmT0xqgbGGJP9e62EBsIYH3jBKH9tuD2LwCdhI3tzwHq2ERUJV4s2sBG0Rc
        UOLkzCcsILaoQJLE0wOdYHFhgXCJm7t+M4HYzALiEreezAezRQT8JPp/XWYDOYJZ4DXQ/J9N
        zBAXTWGWWPfuFztIFZuAoUTXW4grOAUsJS7v2csKMclMomtrFyOELS/RvHU28wRGoVlIDpmF
        ZOEsJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERiV24793LKDceWrj3qHGJk4
        GA8xSnAwK4nwep9ZnCjEm5JYWZValB9fVJqTWnyI0RQYGhOZpUST84FpIa8k3tDMwNTQxMzS
        wNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgUmi+ZfQjc31zUmLljBxdxnUF8fc8Xzx
        ds3kv6c53/959q+P49vJ3auL768RnV5wpWHPp3VhgqtZJa8YqZzX8plVWFt+d3ph8mZJs/ln
        je6sKshYeDpa5NkdhVWfFzAX7t9a0JJ4MkS9Ye4rfs57u7L31G3cZutltEXkQbL/kcOcYrPr
        Z3V1hO/7d/rc48AuHs+7ehOrnG4u0NUq39i2TPBRhGMZm/2jKd2ZPzyPhvjP61lnOfPczjN6
        m+vOMMuaLLG7a/WN+/3BqZv+iiwT+VN3Sb1Ted2W/oXbbt+7Jt73e3tya9mGDavOn18RdiIr
        jv1hxyynFy+Z33/SfXySn3n+5slbNHbrMkVUT7V7de3AcSWW4oxEQy3mouJEAGx5sllTAwAA
X-CMS-MailID: 20211129111717eucas1p1f8b73283a089fea6e64544c0bf8a0217
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c
References: <20211102110204.3334609-1-sean@geanix.com>
        <20211102110204.3334609-4-sean@geanix.com>
        <CGME20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c@eucas1p2.samsung.com>
        <21092c0f-e11b-ac16-ab96-2a0556c0e30a@samsung.com>
        <20211123125012.ibzqu44ixmykbhkt@skn-laptop>
        <20211123140715.280b2f70@collabora.com> <20211129101908.6f1aa715@xps13>
        <20211129094129.xn364czofrgtvfb4@skn-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On 29.11.2021 10:41, Sean Nyekjaer wrote:
> On Mon, Nov 29, 2021 at 10:19:08AM +0100, Miquel Raynal wrote:
>> boris.brezillon@collabora.com wrote on Tue, 23 Nov 2021 14:07:15 +0100:
>>> On Tue, 23 Nov 2021 13:50:12 +0100
>>> Sean Nyekjaer <sean@geanix.com> wrote:
>>>> @Boris do we need to do something similar here to what we did with the
>>>> mtdconcat stuff?
>>> Absolutely, physmasp subdevices are never initialized/registered, so
>>> you can't call any of the mtd helpers taking the suspend lock on those.
>>> I guess it'd be better to call mtd_suspend/resume() on the concat device
>>> in though:
>> Any chance that you will come up with a fix or v6 of the series anytime
>> soon?
>>
>>> static void physmap_flash_shutdown(struct platform_device *dev)
>>> {
>>> 	struct physmap_flash_info *info = platform_get_drvdata(dev);
>>>
>>> 	mtd_suspend(info->cmtd);
>>> }
>>
>> Thanks,
>> Miquèl
> Hi Miquèl,
>
> I'm not 100% comfortable in doing this.
>
> During this patch series I have mostly been Boris' tester and
> implemented his ideas :/
>
> I'm willing to give it a try, if Marek shares how to reproduce this with qemu :)

Frankly speaking there is nothing special in my setup, typical options 
to run ARM64/virt machine. Just run recent qemu (I did my test with 
5.2.0) with any basic arm/arm64 rootfs (I've used Debian). The qemu 
command line (copied somewhere from the Internet) I've used is:

qemu-system-aarch64 -serial stdio -monitor null -kernel Image -append 
"console=ttyAMA0 root=/dev/vda rootwait" -M virt -cpu cortex-a57 -smp 2 
-m 1024 -device virtio-blk-device,drive=virtio-blk0 -drive 
file=qemu-virt-rootfs.raw,id=virtio-blk0,if=none,format=raw -netdev 
user,id=user -device virtio-net-device,netdev=user -display none

Once it boots to shell, just type 'reboot' and wait until issue appears.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

