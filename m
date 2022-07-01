Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936075633B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiGAMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiGAMuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:50:11 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCACF31355
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:50:04 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220701124959euoutp012316607ea9254cfe9fd74f90872e8432~9tYAZOcVX1177611776euoutp01O
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:49:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220701124959euoutp012316607ea9254cfe9fd74f90872e8432~9tYAZOcVX1177611776euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656679799;
        bh=lC7l7ShORdeHUR50h1I8x8Sjs+TM+jdEK7iT2+C8CLs=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=GEe3l+AoGjgkdoz4wkuJWLgwtIueavcmxM32e8Ud9p/N8qcfwZlhP9BKqBkL83Bhd
         aBr9luGqerwgSmjp2bIaz3LkVsmkQwmG8Fb+rmFmOaRe0hJK89pbo3NIajTjRLjN7c
         vv2B/WfNfUsH2cSq2nC34hiHnG7GD8x0zCd77ePk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220701124958eucas1p29fe5870880a4116aec107527508c2d95~9tX-tU_I33066630666eucas1p25;
        Fri,  1 Jul 2022 12:49:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A7.02.10067.67DEEB26; Fri,  1
        Jul 2022 13:49:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220701124958eucas1p16ded64c878c71f46b92955be0a95daea~9tX-XwZ030975709757eucas1p1j;
        Fri,  1 Jul 2022 12:49:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220701124958eusmtrp2f4194b655761707b9274b3d06f7f6ea6~9tX-XH0jL0109401094eusmtrp2_;
        Fri,  1 Jul 2022 12:49:58 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-4e-62beed7671cb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.60.09038.67DEEB26; Fri,  1
        Jul 2022 13:49:58 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220701124958eusmtip29a18dfab9fcd5ec55964ec18a29f11d6~9tX-BfIwx0375103751eusmtip2Y;
        Fri,  1 Jul 2022 12:49:58 +0000 (GMT)
Message-ID: <ad06d3c3-7878-9106-e118-f89e2de91a1f@samsung.com>
Date:   Fri, 1 Jul 2022 14:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v7 2/4] kernfs: Change kernfs_notify_list to llist.
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, tj@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <9e95f138-9ec5-90fc-7ea9-cf8cff8bf180@oracle.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzned2yt/uSDHq7TS2aF69ns/g+6Smr
        xeVdc9gsfi0/ymhx/u9xVgdWj02rOtk89s9dw+7x8ektFo/Pm+Q8Nj15yxTAGsVlk5Kak1mW
        WqRvl8CV8a+vlbVglnzFgi7BBsaJkl2MnBwSAiYS/4/cZwOxhQRWMEos2QtkcwHZXxglvs18
        xgjhfGaU2DZ5OStMx7UVK1ghEssZJWacuglV9ZFRYtGB8+wgVbwCdhLtl58wdTFycLAIqEg0
        3y+BCAtKnJz5hAXEFhVIljh39irYamEBd4ml02+AxZkFxCVuPZnPBGKLCORJTJr7HCquIPHr
        3iawI9gEDCW63naB9XICrfr2/DZUjbxE89bZzCD3SAgc4ZD4fXk/M8TVLhKnW2axQdjCEq+O
        b2GHsGUk/u+cD3anhEC+xN8ZxhDhColrr9dAtVpL3Dn3iw2khFlAU2L9Ln2IsKPEpWeHGSE6
        +SRuvBWEuIBPYtK26cwQYV6JjjYhiGo1iVnH18HtPHjhEvMERqVZSGEyC8nvs5D8Mgth7wJG
        llWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBaeb0v+NfdjAuf/VR7xAjEwfjIUYJDmYl
        EV62eXuThHhTEiurUovy44tKc1KLDzFKc7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTAZ
        zfY++9GzamUKz6TlEtvnO1x1V7wQsTaH+YSbanrN7shlE/6XfVYUnlvPkLdkxZ4JSkc0U1f3
        Npmm3fD2twpemGNULXf6St/KCFEPmaSNBxg3FfBObK1zXJVzKkujlJNrR9E/O92jTTVv1k1V
        qE/4eu1mbc28huWrrbvvvcz9FuewL+HJpuezL2x9vCqwotrupeKxZZuS9py6Zuf2LHRJefk+
        300c+6+0f0i+U6KxIfo4a6G9ze/u4pr1Uel7Vi5VnPDccWqBsV3Ek/u/C2uUH/IFOfibN/9p
        /Jf3rrX6RunDy6aLHX5s5ZJY+OnVvH8cBg1GrJPuydQXsfbJtH6oeX9ucxFLh2fc42W3JS4r
        sRRnJBpqMRcVJwIAc5u0iKIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7plb/clGbxpUbZoXryezeL7pKes
        Fpd3zWGz+LX8KKPF+b/HWR1YPTat6mTz2D93DbvHx6e3WDw+b5Lz2PTkLVMAa5SeTVF+aUmq
        QkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexr++VtaCWfIVC7oE
        GxgnSnYxcnJICJhIXFuxgrWLkYtDSGApo8TrLavZIBIyEienNbBC2MISf651sUEUvWeUuPt4
        NxNIglfATqL98hMgm4ODRUBFovl+CURYUOLkzCcsILaoQLJE85ZDYOXCAu4SS6ffAIszC4hL
        3HoyH6xVRCBP4t26MIiwgsSve5ug7lnHJPGopYcRJMEmYCjR9bYL7DZOoLXfnt+GmmMm0bW1
        ixHClpdo3jqbeQKj0CwkZ8xCsm4WkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93E
        CIyubcd+btnBuPLVR71DjEwcjIcYJTiYlUR42ebtTRLiTUmsrEotyo8vKs1JLT7EaAoMionM
        UqLJ+cD4ziuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYCovuLX6
        4Iw9dgcK7hVI5UrqPrhaeEntdryRG/+zf8YhDQ47NBKDbut8WuY4TfG1fzdfXZ1Yg/r9wpV8
        WckLavSX8T2eLh8Xp9Ce65u4grOH0XzhFJbsXWcnafaqzWARM08V6qn311HqS7Pz8TJyLNyw
        NGLRAavQT6osBvOeVfDNePX8iubyZZ6X2ax0H0zJ6eI1aKr4eX7hbu+oUx3C4qo7Vv2Ocj1S
        v+zdDslpyz1LerZxx61p7uy5zifTtpldM/+molP0U79VDbdNF2wrWljHu/XeqcdP2yROzel2
        /hYVFcfU8y5st9SFO/umxcSaSSqz7fvc4rXsduiiWenvT/x74NSYvvCKxYR4lXWlSizFGYmG
        WsxFxYkAdbUEhDcDAAA=
X-CMS-MailID: 20220701124958eucas1p16ded64c878c71f46b92955be0a95daea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220701112210eucas1p2d2db45881086f41b73527f7536537aa5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220701112210eucas1p2d2db45881086f41b73527f7536537aa5
References: <20220615021059.862643-1-imran.f.khan@oracle.com>
        <20220615021059.862643-3-imran.f.khan@oracle.com>
        <CGME20220701112210eucas1p2d2db45881086f41b73527f7536537aa5@eucas1p2.samsung.com>
        <270b640d-d5e8-b775-9a16-5d5d07f959ff@samsung.com>
        <9e95f138-9ec5-90fc-7ea9-cf8cff8bf180@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 01.07.2022 14:20, Imran Khan wrote:
> On 1/7/22 9:22 pm, Marek Szyprowski wrote:
>> On 15.06.2022 04:10, Imran Khan wrote:
>>> At present kernfs_notify_list is implemented as a singly linked
>>> list of kernfs_node(s), where last element points to itself and
>>> value of ->attr.next tells if node is present on the list or not.
>>> Both addition and deletion to list happen under kernfs_notify_lock.
>>>
>>> Change kernfs_notify_list to llist so that addition to list can heppen
>>> locklessly.
>>>
>>> Suggested by: Al Viro <viro@zeniv.linux.org.uk>
>>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>>> Acked-by: Tejun Heo <tj@kernel.org>
>> This patch landed in linux next-20220630 as commit b8f35fa1188b
>> ("kernfs: Change kernfs_notify_list to llist."). Unfortunately, it
>> causes serious regression on my test systems. It can be easily noticed
>> in the logs by the following warning:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 34 at fs/kernfs/dir.c:531 kernfs_put.part.0+0x1a4/0x1d8
>> kernfs_put: console/active: released with incorrect active_ref 0
>> Modules linked in:
>> CPU: 1 PID: 34 Comm: kworker/1:4 Not tainted
>> 5.19.0-rc4-05465-g5732b42edfd1 #12317
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>> Workqueue: events kernfs_notify_workfn
>>    unwind_backtrace from show_stack+0x10/0x14
>>    show_stack from dump_stack_lvl+0x40/0x4c
>>    dump_stack_lvl from __warn+0xc8/0x13c
>>    __warn from warn_slowpath_fmt+0x90/0xb4
>>    warn_slowpath_fmt from kernfs_put.part.0+0x1a4/0x1d8
>>    kernfs_put.part.0 from kernfs_notify_workfn+0x1a0/0x1d0
>>    kernfs_notify_workfn from process_one_work+0x1ec/0x4cc
>>    process_one_work from worker_thread+0x58/0x54c
>>    worker_thread from kthread+0xd0/0xec
>>    kthread from ret_from_fork+0x14/0x2c
>> Exception stack(0xf099dfb0 to 0xf099dff8)
>> ...
>> ---[ end trace 0000000000000000 ]---
>>
> Thanks for reporting this issue. It has been reported earlier in [1] as well. I
> am unable to reproduce it locally. Could you please test with following patch on
> top of linux next-20220630 and let me know if it helps:

Yes, this fixes the issue. Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Maybe it is related to the fact, that I have earlycon enabled on those 
machines?

> >From 6bf7f1adc4b091dc6d6c60e0dd0f16247f61f374 Mon Sep 17 00:00:00 2001
> From: Imran Khan <imran.f.khan@oracle.com>
> Date: Fri, 1 Jul 2022 14:27:52 +1000
> Subject: [PATCH] kernfs: Avoid re-adding kernfs_node into kernfs_notify_list.
>
> ---
>   fs/kernfs/file.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index bb933221b4bae..e8ec054e11c63 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -917,6 +917,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>          if (free == NULL)
>                  return;
>
> +       free->next = NULL;
>          attr = llist_entry(free, struct kernfs_elem_attr, notify_next);
>          kn = attribute_to_node(attr, struct kernfs_node, attr);
>          root = kernfs_root(kn);
> @@ -992,9 +993,11 @@ void kernfs_notify(struct kernfs_node *kn)
>          rcu_read_unlock();
>
>          /* schedule work to kick fsnotify */
> -       kernfs_get(kn);
> -       llist_add(&kn->attr.notify_next, &kernfs_notify_list);
> -       schedule_work(&kernfs_notify_work);
> +       if (kn->attr.notify_next.next != NULL) {
> +               kernfs_get(kn);
> +               llist_add(&kn->attr.notify_next, &kernfs_notify_list);
> +               schedule_work(&kernfs_notify_work);
> +       }
>   }
>   EXPORT_SYMBOL_GPL(kernfs_notify);
>
>
> base-commit: 6cc11d2a1759275b856e464265823d94aabd5eaf

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

