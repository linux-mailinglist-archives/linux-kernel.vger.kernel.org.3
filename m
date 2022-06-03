Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4332253CCC9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbiFCP7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343547AbiFCP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:59:05 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233A2C111
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:59:03 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220603155901euoutp016b3830dd8598edf4a6b86209394d6cb0~1J5DxWmuW0852708527euoutp01E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:59:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220603155901euoutp016b3830dd8598edf4a6b86209394d6cb0~1J5DxWmuW0852708527euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654271941;
        bh=Y2ntu47kCMtNZvS3cwLiwDSyZbHLNNAFAlZXcops+c0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=K630aHoovKfJJUj1i64FtB/CMRsDtGwUpCZ5hjA7lnW3ZeK+iLiwW0eeS5NhvhCGB
         MFytSbpCflNvXeI9qwhUWH41Whhqw98TcIwMyEktUjVyF7U3mKssW6sCclMPlp1+9Q
         ++ouNPyZuWqqyHsCMHUzZEBVFVwOEKd0/z+iAQIM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220603155901eucas1p131dfecd7103cfb770788876db51817a6~1J5DTSKHW1817318173eucas1p17;
        Fri,  3 Jun 2022 15:59:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D7.60.10067.4CF2A926; Fri,  3
        Jun 2022 16:59:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220603155859eucas1p1857158e8524df567437c2b62590cd86a~1J5B86fi82553725537eucas1p1x;
        Fri,  3 Jun 2022 15:58:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603155859eusmtrp1d45d04e83a1350a0a40e874b322372c5~1J5B8LSEu1938219382eusmtrp1D;
        Fri,  3 Jun 2022 15:58:59 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-7b-629a2fc49959
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DB.7A.09038.3CF2A926; Fri,  3
        Jun 2022 16:58:59 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220603155858eusmtip2c1095376f5b0d975e230c4ce4bff40e9~1J5BJHPed2407024070eusmtip2Z;
        Fri,  3 Jun 2022 15:58:58 +0000 (GMT)
Message-ID: <aa54b4cb-e8ee-8c1a-c826-8016f42a5da1@samsung.com>
Date:   Fri, 3 Jun 2022 17:58:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
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
In-Reply-To: <Ypoo4WrVx5/YvaXx@casper.infradead.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7pH9GclGSz7bm0xZ/0aNotNh96w
        WUxo3c5scXnXHDaLe2v+s1p0rLzHanG0ZzObxdVd9Ra/fwDFP+16z2px7d0ZNovvDzYzOfB4
        zG64yOLRcuQtq8fmFVoemz5NYvc4MeM3i8fuBZ+ZPKZ8fc7s8XmTnMf6LVuZAjijuGxSUnMy
        y1KL9O0SuDJW/J/IXDBVsqKx7xBjA+NekS5GTg4JAROJDzP+snYxcnEICaxglHh6fw0jhPOF
        UWLpt41Qmc+MEt87XrLBtPyZcIMdIrGcUeLB8gvMEM5HRokJl9qZuhg5OHgF7CRW9KuANLAI
        qEhs+/2FBcTmFRCUODnzCZgtKpAkMX9bKyuILSxgKfFg13JmEJtZQFzi1pP5TCC2iICPxLMZ
        a8CWMQtsYZaY1jYXrJlNwFCi620X2EWcQBd1v9zHCtEsL9G8dTbYQRIC8zkl1nTeZgc5SELA
        ReL7Al+ID4QlXh3fwg5hy0icntzDAlGSL/F3hjFEuELi2us1zBC2tcSdc7/YQEqYBTQl1u/S
        hwg7Sqxf/pkJopNP4sZbQYgD+CQmbZvODBHmlehoE4KoVpOYdXwd3M6DFy4xT2BUmoUUJrOQ
        /D4LySuzEPYuYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZjUTv87/mUH4/JXH/UO
        MTJxMB5ilOBgVhLhLZs3M0mINyWxsiq1KD++qDQntfgQozQHi5I4b3LmhkQhgfTEktTs1NSC
        1CKYLBMHp1QD06ZTAWqv5jiV89aECHV18WSdsdzVLSQzKaxnlcaqh5Pik7jOfV/Mrr8u9v76
        Z6KWmRc97rzem6Awi3un9gH23RUXjIIne70xfsQScrlw7qv2HMGf1U4Li6yKJvfb/du85NGL
        B8l5aeqda7yXGCourVKr7Fgla68yW3m2b9RmN2WT/XLBN6zX3Vd59XVj+J+nfPf61ndN1N1R
        f9jq35VDfx1m/ayrT+gSb293vbXK60JS4qGX5U/n2teFsu3saF/+mkmvctkLo/TvPppv6v8+
        O1TLXN5e07F/1oH/c5bvFr+ddZFffb6/x5tLH4/8cFg8n2Fq06VfF19orXI1X+q9ue7Ol9JD
        jfpLVK3cPz6tmK/EUpyRaKjFXFScCABb3cTh2QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xe7qH9WclGVx6IWcxZ/0aNotNh96w
        WUxo3c5scXnXHDaLe2v+s1p0rLzHanG0ZzObxdVd9Ra/fwDFP+16z2px7d0ZNovvDzYzOfB4
        zG64yOLRcuQtq8fmFVoemz5NYvc4MeM3i8fuBZ+ZPKZ8fc7s8XmTnMf6LVuZAjij9GyK8ktL
        UhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJW/J/IXDBVsqKx
        7xBjA+NekS5GTg4JAROJPxNusHcxcnEICSxllFj7YhYbREJG4uS0BlYIW1jiz7UuNoii94wS
        d9beBOrg4OAVsJNY0a8CUsMioCKx7fcXFhCbV0BQ4uTMJ2C2qECSxLy9qxlBbGEBS4kHu5Yz
        g9jMAuISt57MZwKxRQR8JJ7NWAN2BLPADmaJvoXTmCCWHWGWuHxoJ1gVm4ChRNfbLrDrOIHO
        7n65jxVikplE19YuRghbXqJ562zmCYxCs5AcMgvJwllIWmYhaVnAyLKKUSS1tDg3PbfYSK84
        Mbe4NC9dLzk/dxMjMJq3Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuEtmzczSYg3JbGyKrUoP76o
        NCe1+BCjKTA0JjJLiSbnA9NJXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFM
        HxMHp1QD07zi57OLK/rSve2ifv37VfWvefe1+F8WHeuP9h+2Zr8xyXKB1OHTih1TYo9tqXJw
        niHTPaVY4E6A7D/hGx+3nndc3vxg86vF0/XuLm6dvWzB6sYex/QrbtsnKwefi5C9LBvCw1RT
        8eHoR5vt5rzp3Jf6OpmW7/v7lt3PRSrp44p3gQ++Mh41/rZO48nsts++95wX1x8LWMslzf9n
        s7QQU+QKqcQvxQm6hstm7rlts/eBm+tkkw0GOrNen9n4yCfLU63AYpK1hJrZHvWAlL/z57pK
        FlmoaLLXaqjI3bj0MfTN1QAFu55ji/r7T1h6HotcaHL9/XKLy3Hurvtbqu1Tfby2neF9Ld49
        dYlocWPsDyWW4oxEQy3mouJEAFHs1FtvAwAA
X-CMS-MailID: 20220603155859eucas1p1857158e8524df567437c2b62590cd86a
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
        <Ypoo4WrVx5/YvaXx@casper.infradead.org>
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

On 03.06.2022 17:29, Matthew Wilcox wrote:
> On Fri, Jun 03, 2022 at 10:55:01PM +0800, Hsin-Yi Wang wrote:
>> On Fri, Jun 3, 2022 at 10:10 PM Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> Hi Matthew,
>>>
>>> On 03.06.2022 14:59, Matthew Wilcox wrote:
>>>> On Fri, Jun 03, 2022 at 02:54:21PM +0200, Marek Szyprowski wrote:
>>>>> On 01.06.2022 12:39, Hsin-Yi Wang wrote:
>>>>>> Implement readahead callback for squashfs. It will read datablocks
>>>>>> which cover pages in readahead request. For a few cases it will
>>>>>> not mark page as uptodate, including:
>>>>>> - file end is 0.
>>>>>> - zero filled blocks.
>>>>>> - current batch of pages isn't in the same datablock or not enough in a
>>>>>>      datablock.
>>>>>> - decompressor error.
>>>>>> Otherwise pages will be marked as uptodate. The unhandled pages will be
>>>>>> updated by readpage later.
>>>>>>
>>>>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>>>>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>>>>> Reported-by: Matthew Wilcox <willy@infradead.org>
>>>>>> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
>>>>>> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
>>>>>> ---
>>>>> This patch landed recently in linux-next as commit 95f7a26191de
>>>>> ("squashfs: implement readahead"). I've noticed that it causes serious
>>>>> issues on my test systems (various ARM 32bit and 64bit based boards).
>>>>> The easiest way to observe is udev timeout 'waiting for /dev to be fully
>>>>> populated' and prolonged booting time. I'm using squashfs for deploying
>>>>> kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on
>>>>> top of the next-20220603 fixes the issue.
>>>> How large are these files?  Just a few kilobytes?
>>> Yes, they are small, most of them are smaller than 16KB, some about
>>> 128KB and a few about 256KB. I've sent a detailed list in private mail.
>>>
>> Hi Marek,
>>
>> Are there any obvious squashfs errors in dmesg? Did you enable
>> CONFIG_SQUASHFS_FILE_DIRECT or CONFIG_SQUASHFS_FILE_CACHE?
> I don't think it's an error problem.  I think it's a short file problem.
>
> As I understand the current code (and apologies for not keeping up
> to date with how the patch is progressing), if the file is less than
> msblk->block_size bytes, we'll leave all the pages as !uptodate, leaving
> them to be brough uptodate by squashfs_read_folio().  So Marek is hitting
> the worst case scenario where we re-read the entire block for each page
> in it.  I think we have to handle this tail case in ->readahead().

I'm not sure if this is related to reading of small files. There are 
only 50 modules being loaded from squashfs volume. I did a quick test of 
reading the files.

Simple file read with this patch:

root@target:~# time find /initrd/ -type f | while read f; do cat $f 
 >/dev/null; done

real    0m5.865s
user    0m2.362s
sys     0m3.844s

Without:

root@target:~# time find /initrd/ -type f | while read f; do cat $f 
 >/dev/null; done

real    0m6.619s
user    0m2.112s
sys     0m4.827s

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

