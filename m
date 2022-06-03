Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6422D53CB58
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244740AbiFCOKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbiFCOKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:10:33 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EE919C1A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:10:28 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220603141024euoutp01d750bbd55dc34ad54ce50d6ca12e6539~1IaOQF9SL3135731357euoutp01N
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 14:10:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220603141024euoutp01d750bbd55dc34ad54ce50d6ca12e6539~1IaOQF9SL3135731357euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654265424;
        bh=whma9mCP6VNv/JU5q1dJuWBFyoiR3FSC99N+p5+8j6Y=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=gKKij/upUy2V4ohipkVI4+Lb+OzL88pkptQzOvtpo0NIOM3Gcfn4mpxLp7tD7y/Gi
         8LCtbFY4YvTWE6qc5xboHOMQRbFm8c74kokk7sHEGLGggjRIqI53L3HZaFuDIwTCD9
         IT+YBBXDj3A7jGVuS2X+ZsGwmje7pskTFEwseQO8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220603141024eucas1p2858ccb1a59a73269029758a798f863e0~1IaN-hKRO1811818118eucas1p20;
        Fri,  3 Jun 2022 14:10:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0C.C5.09580.0561A926; Fri,  3
        Jun 2022 15:10:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220603141023eucas1p130b688cb64002397afb1cbfa94bbd749~1IaNgl9rR2700427004eucas1p1t;
        Fri,  3 Jun 2022 14:10:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603141023eusmtrp12154fd96413c64e02382cdabcd2a3a34~1IaNfw6up1645316453eusmtrp1K;
        Fri,  3 Jun 2022 14:10:23 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-ed-629a16500a15
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 82.32.09038.F461A926; Fri,  3
        Jun 2022 15:10:23 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220603141022eusmtip2ce7c04922aeed93af10f16079c36519b~1IaM2CEWo2678126781eusmtip2C;
        Fri,  3 Jun 2022 14:10:22 +0000 (GMT)
Message-ID: <90b228ea-1b0e-d2e8-62be-9ad5802dcce7@samsung.com>
Date:   Fri, 3 Jun 2022 16:10:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
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
In-Reply-To: <YpoFnROxAwdSScuV@casper.infradead.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djP87oBYrOSDGavYLWYs34Nm8WmQ2/Y
        LCa0bme2uLxrDpvFvTX/WS06Vt5jtTjas5nN4uqueovfP4Din3a9Z7W49u4Mm8X3B5uZHHg8
        ZjdcZPFoOfKW1WPzCi2PTZ8msXucmPGbxWP3gs9MHlO+Pmf2+LxJzmP9lq1MAZxRXDYpqTmZ
        ZalF+nYJXBnN++8zFqzkrTiyvIe9gfEzVxcjJ4eEgInE/N/vGLsYuTiEBFYwSuxZtoEZwvnC
        KLHoyVRWCOczo0Rz9zsWmJauXbPZIRLLGSV+rnzICpIQEvjIKHF5U20XIwcHr4CdxMxV/CBh
        FgEViYa7R5hAbF4BQYmTM5+AzREVSJKYv60VrFVYwFLiwa7lzCA2s4C4xK0n85lAxogIaEi8
        2WIEsopZ4BazxMfXB9lAatgEDCW63naB2ZxA93SsPc4E0Ssvsf3tHLAPJAQWc0qs3HeZEeJo
        F4n9PTvZIWxhiVfHt0DZMhKnJ/ewgCyTEMiX+DvDGCJcIXHt9RpmCNta4s65X2wgJcwCmhLr
        d+lDhB0l1i//zATRySdx460gxAV8EpO2TWeGCPNKdLQJQVSrScw6vg5u58ELl5gnMCrNQgqT
        WUh+n4Xkl1kIexcwsqxiFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITGmn/x3/uoNxxauP
        eocYmTgYDzFKcDArifCWzZuZJMSbklhZlVqUH19UmpNafIhRmoNFSZw3OXNDopBAemJJanZq
        akFqEUyWiYNTqoGpSr//rovGzlOqxnYthfE33V+x3NpTVhwlWtn9I+KZzgN1Lb8J2ndcXXUl
        9ftuzzDedPrzjfXsGl+PZZ33V1r3aco0DhkLV3t7Wb7Xrl7NLJeSTLICdi7iZ3okc43t0ta3
        vnUnguMk9kizdxy5Zm6k87P8qcgB1X87Hn+8PsPPi0vUwqTJLG7hW2un267L3PcfaDYxidyX
        mnzqvp5iT2zG0Trea1u2nVuyMib0wBxujkg3dsE448wFrxpXvSjwnJT5Kc/lc/3trnDZh0y2
        i/cdTwp8tl3X6CjngVRl7Yn+tw+pWJkzNBhXGqmeZvx5pFQvJadomfr9Ytc3AmWScRO0XGPL
        jjx2ZJq1YV3xdyWW4oxEQy3mouJEAOtnx73YAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7r+YrOSDLY8VbaYs34Nm8WmQ2/Y
        LCa0bme2uLxrDpvFvTX/WS06Vt5jtTjas5nN4uqueovfP4Din3a9Z7W49u4Mm8X3B5uZHHg8
        ZjdcZPFoOfKW1WPzCi2PTZ8msXucmPGbxWP3gs9MHlO+Pmf2+LxJzmP9lq1MAZxRejZF+aUl
        qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnN++8zFqzkrTiy
        vIe9gfEzVxcjJ4eEgIlE167Z7F2MXBxCAksZJRb2fWOGSMhInJzWwAphC0v8udbFBlH0nlFi
        Zv9pxi5GDg5eATuJmav4QWpYBFQkGu4eYQKxeQUEJU7OfMICYosKJEnM27uaEcQWFrCUeLBr
        Odh8ZgFxiVtP5jOBjBER0JB4s8UIZDyzwD1miQnHNzFC7JrHJHFn/k+wQWwChhJdb0GO4OTg
        BLq6Y+1xJohBZhJdW7sYIWx5ie1v5zBPYBSaheSOWUj2zULSMgtJywJGllWMIqmlxbnpucVG
        esWJucWleel6yfm5mxiBsbzt2M8tOxhXvvqod4iRiYPxEKMEB7OSCG/ZvJlJQrwpiZVVqUX5
        8UWlOanFhxhNgYExkVlKNDkfmEzySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtS
        i2D6mDg4pRqYeM0/OmyTLr+80/Gyo7m1rsTNvcFRD7TLGuazvrTmO/nuiEHguwdcadIPbHo1
        X9h6C3Rvr/x3v1U9ivGdJdP5BYefXLlcXepS79eR8P6fyaccS6kKnfgHejuKlx57Oy/X4osJ
        i3qKlEV8+wlJVlYW03yz1/rr23a9uiS35s793X023skv7tp6HfxjusrBd2KK3ytnj50vM89u
        n9H5KeB8xLmo049Fm6dk1yX6cNvavepTX8F6JWND7TXd2qchC7X3C2VN2GkX93nms2PKKq/K
        Dx3X3n87a7qWt1J/9ovPSdxtOvdTrrktDrlyRmO6hYdkvsS9z8HvLhxl4WAuKTUQPvmwvcWo
        yFIqsWnzPyklluKMREMt5qLiRAAi7J49bgMAAA==
X-CMS-MailID: 20220603141023eucas1p130b688cb64002397afb1cbfa94bbd749
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

Hi Matthew,

On 03.06.2022 14:59, Matthew Wilcox wrote:
> On Fri, Jun 03, 2022 at 02:54:21PM +0200, Marek Szyprowski wrote:
>> On 01.06.2022 12:39, Hsin-Yi Wang wrote:
>>> Implement readahead callback for squashfs. It will read datablocks
>>> which cover pages in readahead request. For a few cases it will
>>> not mark page as uptodate, including:
>>> - file end is 0.
>>> - zero filled blocks.
>>> - current batch of pages isn't in the same datablock or not enough in a
>>>     datablock.
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
>> This patch landed recently in linux-next as commit 95f7a26191de
>> ("squashfs: implement readahead"). I've noticed that it causes serious
>> issues on my test systems (various ARM 32bit and 64bit based boards).
>> The easiest way to observe is udev timeout 'waiting for /dev to be fully
>> populated' and prolonged booting time. I'm using squashfs for deploying
>> kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on
>> top of the next-20220603 fixes the issue.
> How large are these files?  Just a few kilobytes?

Yes, they are small, most of them are smaller than 16KB, some about 
128KB and a few about 256KB. I've sent a detailed list in private mail.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

