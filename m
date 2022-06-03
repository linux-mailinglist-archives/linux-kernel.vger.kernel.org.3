Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4DF53CC08
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245352AbiFCPLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiFCPLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:11:21 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E833393FD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:11:16 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220603151111euoutp01e62be51b86be8b4b13987ef91c4cddec~1JPSo_1D42909329093euoutp01e
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:11:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220603151111euoutp01e62be51b86be8b4b13987ef91c4cddec~1JPSo_1D42909329093euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654269071;
        bh=v2T37rlFE2CMfUMl+duH71R/RYEVVTZdUzJd8Rr66Tc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=GY2/yeamdC6ZFH3LHjP6rs56BDHoz5cBuwl7xaBIkWxvBtxs6GpFy+4fnkDTvhyN7
         NICmcrsaFfO2kKvj20sMl9gCUWwLH6ZiVSRg3gRkwlS3zm3YOv4R4qSEBciofxKgbp
         8EzSF5WexMYs7moqyq7I1qEGwnm2ACSa2cDxc4OE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220603151110eucas1p2e503daf8d171b7e73149b01ed6f6a863~1JPSOnn_31666116661eucas1p2S;
        Fri,  3 Jun 2022 15:11:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 76.AE.09580.E842A926; Fri,  3
        Jun 2022 16:11:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220603151110eucas1p2b4bd47b123dd88c446e4784b51c775a0~1JPRwXiV-1666116661eucas1p2R;
        Fri,  3 Jun 2022 15:11:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603151110eusmtrp135dcfa5d2e20640cad9eef52705832df~1JPRu861_2050820508eusmtrp1R;
        Fri,  3 Jun 2022 15:11:10 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-62-629a248ed1a1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 39.C7.09038.E842A926; Fri,  3
        Jun 2022 16:11:10 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220603151109eusmtip1fca24cf6d9e43528f30e443154081c84~1JPRH_Hwf3034830348eusmtip1V;
        Fri,  3 Jun 2022 15:11:09 +0000 (GMT)
Message-ID: <b4c3d09b-5d7e-83b0-348e-7f5d367bc96e@samsung.com>
Date:   Fri, 3 Jun 2022 17:11:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAJMQK-jDwchHokDZw7k24rGdy7OeUmiVWUCfxBiu1E1dZwuy2Q@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87p9KrOSDL4vN7GYs34Nm8WmQ2/Y
        LCa0bme2uLxrDpvFvTX/WS06Vt5jtTjas5nN4uqueovfP4Din3a9Z7W49u4Mm8X3B5uZHHg8
        ZjdcZPFoOfKW1WPzCi2PTZ8msXucmPGbxWP3gs9MHlO+Pmf2+LxJzmP9lq1MAZxRXDYpqTmZ
        ZalF+nYJXBnrdr9hKXgkUtF1dBpLA+NywS5GTg4JAROJu3O2sXQxcnEICaxglHh5aAEzSEJI
        4AujRN/OAojEZ0aJ7X0v2WE6dt98yQqRWM4osWnfE3YI5yOjRNOf70wgVbwCdhK/Jl4Bs1kE
        VCReXtsKFReUODnzCQuILSqQJDF/WysriC0sYCnxYNdysNXMAuISt57MB6sXEVCTmHrpL9h9
        zAJ3mCXmndkF1swmYCjR9baLDcTmFAiU+A/0OkSzvMT2t3OYQRokBGZzSrzYdowJ4m4XiZ1X
        1rNC2MISr45vgfpHRuL05B6goRxAdr7E3xnGEOEKiWuv1zBD2NYSd879YgMpYRbQlFi/Sx8i
        7CixfvlnJohOPokbbwUhLuCTmLRtOjNEmFeio00IolpNYtbxdXA7D164xDyBUWkWUqDMQvL8
        LCS/zELYu4CRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgWjv97/jXHYwrXn3UO8TI
        xMF4iFGCg1lJhLds3swkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzJmRsShQTSE0tSs1NTC1KL
        YLJMHJxSDUy9q7msVa5cnat/fWmHekr9QsaXRw7abljwy/hHpaT7TMsf7/fdmSCY0J3n7NBQ
        orDHrOQq37eWcla+dT8CPYM1py15ypi+06E9V8vgYvvcjuCznY6n1nIsfy6Vs2L+nHma0hcd
        NI62fU/mPeITa3awp9RUR6p6VZtdmsXMZb92p33sNJtQrh0QefOT9RbBpzV9rgdnLHizPmFl
        /rS6PrssjuOPVoZIbPW/p3yS/63Rh11OrKduRx+coir3PqD63q6YXccutB4Sm1FxfFmlflfP
        74dXPn0+N2lRQ97t3ZzitgujXKsCvwVrpy+eznynIkvc98z+0FMb75e2NFow3zS59nRif9qV
        yS4rNH8zd+1UYinOSDTUYi4qTgQAD58gLNoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7p9KrOSDHYdFLaYs34Nm8WmQ2/Y
        LCa0bme2uLxrDpvFvTX/WS06Vt5jtTjas5nN4uqueovfP4Din3a9Z7W49u4Mm8X3B5uZHHg8
        ZjdcZPFoOfKW1WPzCi2PTZ8msXucmPGbxWP3gs9MHlO+Pmf2+LxJzmP9lq1MAZxRejZF+aUl
        qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnrdr9hKXgkUtF1
        dBpLA+NywS5GTg4JAROJ3TdfsnYxcnEICSxllFgy/RQzREJG4uS0BlYIW1jiz7UuNoii94wS
        b2c0ghXxCthJ/Jp4hQnEZhFQkXh5bSsTRFxQ4uTMJywgtqhAksS8vasZQWxhAUuJB7uWg/Uy
        C4hL3HoyH6xeREBNYuqlvywgC5gFHjBLfNi3F+qkWcwSH6/uYAOpYhMwlOh62wVmcwoESvwH
        hgjEJDOJrq1djBC2vMT2t3OYJzAKzUJyyCwkC2chaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi
        0rx0veT83E2MwHjeduznlh2MK1991DvEyMTBeIhRgoNZSYS3bN7MJCHelMTKqtSi/Pii0pzU
        4kOMpsDQmMgsJZqcD0woeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwc
        nFINTPM5vJR5t095+kbp5DXGfc3hzIonmddWnBf3fsoXIX9736Ll81+usj+5a43NxIPWMhzd
        Ex3vNfg7WM8oPJVnramkc1F15+u1S1QkY1malK8tPyZw7+2VavdV8mXccd9rQnO/hVXsXftw
        oolNUNoMRb/U9Lcbdws5x/i89GNY1zJ5gd4jZb/q48/yXpYH9b1YrMtpLLxG4aotX+ob01Nn
        ZDpu/1OS2Gz4euF1swsK/3anqba9WvFWOXdJOatITHPCCfVTjmFbH1UccAno85jzKe8934Iv
        M4yv2M5ZX3pl++mSA2ydycIztx/KsjSS5GznYfv3i2XnfjY9I6ez/VxzDuvuXzzDQ0JMjlFi
        /junGCWW4oxEQy3mouJEAFtENKBwAwAA
X-CMS-MailID: 20220603151110eucas1p2b4bd47b123dd88c446e4784b51c775a0
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
        <YpoFnROxAwdSScuV@casper.infradead.org>
        <90b228ea-1b0e-d2e8-62be-9ad5802dcce7@samsung.com>
        <CAJMQK-jDwchHokDZw7k24rGdy7OeUmiVWUCfxBiu1E1dZwuy2Q@mail.gmail.com>
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03.06.2022 16:55, Hsin-Yi Wang wrote:
> On Fri, Jun 3, 2022 at 10:10 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 03.06.2022 14:59, Matthew Wilcox wrote:
>>> On Fri, Jun 03, 2022 at 02:54:21PM +0200, Marek Szyprowski wrote:
>>>> On 01.06.2022 12:39, Hsin-Yi Wang wrote:
>>>>> Implement readahead callback for squashfs. It will read datablocks
>>>>> which cover pages in readahead request. For a few cases it will
>>>>> not mark page as uptodate, including:
>>>>> - file end is 0.
>>>>> - zero filled blocks.
>>>>> - current batch of pages isn't in the same datablock or not enough in a
>>>>>      datablock.
>>>>> - decompressor error.
>>>>> Otherwise pages will be marked as uptodate. The unhandled pages will be
>>>>> updated by readpage later.
>>>>>
>>>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>>>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>>>> Reported-by: Matthew Wilcox <willy@infradead.org>
>>>>> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
>>>>> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
>>>>> ---
>>>> This patch landed recently in linux-next as commit 95f7a26191de
>>>> ("squashfs: implement readahead"). I've noticed that it causes serious
>>>> issues on my test systems (various ARM 32bit and 64bit based boards).
>>>> The easiest way to observe is udev timeout 'waiting for /dev to be fully
>>>> populated' and prolonged booting time. I'm using squashfs for deploying
>>>> kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on
>>>> top of the next-20220603 fixes the issue.
>>> How large are these files?  Just a few kilobytes?
>> Yes, they are small, most of them are smaller than 16KB, some about
>> 128KB and a few about 256KB. I've sent a detailed list in private mail.
>>
> Hi Marek,
>
> Are there any obvious squashfs errors in dmesg? Did you enable
> CONFIG_SQUASHFS_FILE_DIRECT or CONFIG_SQUASHFS_FILE_CACHE?

Here are related config entries from my .config:

CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3

(I've used standard ARM 32bit multi_v7_defconfig)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

