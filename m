Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D03554F136
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380351AbiFQGrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380358AbiFQGrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:47:16 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354C65C871
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 23:47:12 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220617064710euoutp024c8bd9b0e9292b075efcc6e199752f30~5VZOVALtk0704707047euoutp02f
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:47:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220617064710euoutp024c8bd9b0e9292b075efcc6e199752f30~5VZOVALtk0704707047euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655448430;
        bh=een82VKDnqFNGMLU70JcfFDIvtHY5EZzNOJCeSzNxBA=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=iAAlqGJOjAiF217auWutyHwZEC065ssRQNgzDS7AvuVLB4zp+jge0b3p25DWmzazz
         2aWW7fpzjQYaRt/zrzzxHQ16XVbyxVkc1g4bOWbZXpmpFEU8IQaMsx03+OhUco91TU
         HjMtl8qCsZ88jYBCydKvabdsaxD4aj+hSQOQOn/I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220617064710eucas1p2e62f26bcd719fd07c121d000f13253a0~5VZOFw40e2116021160eucas1p2q;
        Fri, 17 Jun 2022 06:47:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 48.AD.10067.E632CA26; Fri, 17
        Jun 2022 07:47:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220617064709eucas1p10e6e72f0655c42d00ae4c2275297bffb~5VZNoDYOu2048020480eucas1p1U;
        Fri, 17 Jun 2022 06:47:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220617064709eusmtrp26bc55ed0228cf66805137e12c33a80f3~5VZNmrEgW1689716897eusmtrp2F;
        Fri, 17 Jun 2022 06:47:09 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-1c-62ac236ede72
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8D.3D.09038.D632CA26; Fri, 17
        Jun 2022 07:47:09 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220617064709eusmtip1d15f57ce6b2b2b0b469d129719b52fb8~5VZNC_KxB0652206522eusmtip1X;
        Fri, 17 Jun 2022 06:47:08 +0000 (GMT)
Message-ID: <09fb9691-828e-1f53-6eaa-27ed9a113872@samsung.com>
Date:   Fri, 17 Jun 2022 08:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220615160446.be1f75fd256d67e57b27a9fc@linux-foundation.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87p5ymuSDP79Y7aYs34Nm8XTT30s
        Fpd3zWGzuLfmP6vFjqX7mCxef1vGbLGxZxKrxeSXKxgtZjf2MVq8m/CF1YHLY8GmUo9NqzrZ
        PDZ9msTucWLGbxaP9/uusnmcWXCE3WPrLzuPz5vkAjiiuGxSUnMyy1KL9O0SuDJmrN/GVHCY
        u+Lb11WMDYz/OLoYOTkkBEwk5l54ztLFyMUhJLCCUWJD+29GCOcLo0TP1C9Qmc+MErMmvGCH
        aZl4o4kJIrGcUeLJh5nsEM5HRoktjRPZuhg5OHgF7CROfXIEaWARUJVY/uk8WDOvgKDEyZlP
        WEBsUYEkifnbWllBbGGBQImW98fYQGxmAXGJW0/mM4HYIgJeEhvf3mEFmc8ssIlJ4sGBNWAN
        bAKGEl1vu8B2cQp4Szw7LwzRKy+x/e0cZpB6CYFuTonze/ezQFztIjG78ScThC0s8er4Fqhv
        ZCT+7wRZxgFk50v8nWEMEa6QuPZ6DTOEbS1x59wvsFXMApoS63fpQ4QdJeZPmcMK0cknceOt
        IMQFfBKTtk1nhgjzSnS0CUFUq0nMOr4ObufBC5eYJzAqzUIKk1lIfp+F5JdZCHsXMLKsYhRP
        LS3OTU8tNspLLdcrTswtLs1L10vOz93ECExbp/8d/7KDcfmrj3qHGJk4GA8xSnAwK4nwmgWv
        TBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOm5y5IVFIID2xJDU7NbUgtQgmy8TBKdXAFKyw94Pm
        XU0Gz2crFE4uW9gT4HmtnuuY6O0pV5PCnj/261feuZBRs2v9/JMlkkyMd2OPL5096Vmf3ap5
        +u6Vf4R6Zz3M+lMt9uKbVsoHlTjHFVdkeTbeStGomlz/9JHawtPvMvaWTLE1iRHIvGuu4LHh
        jHKqs56yzVFNNhbXoAhPOfYDycHn2/4GPhFa51/5fL5F8eNQ1f/a7HbpVtclpy63feb2/NiG
        2zzPz2lxvnji781v+mS/wYQElXs5Uw6YtK15Z5e+IezN3SjOeYLzvQK5rApc5A7+eyfmIreG
        mdWm5HlHrue6xXqSBlMsGzZM2XlNd9nxF59NAlucPNb/U9EO7KgMX+Lr4Vl4NfK+EktxRqKh
        FnNRcSIAFnyIxMoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7q5ymuSDBb9UbCYs34Nm8XTT30s
        Fpd3zWGzuLfmP6vFjqX7mCxef1vGbLGxZxKrxeSXKxgtZjf2MVq8m/CF1YHLY8GmUo9NqzrZ
        PDZ9msTucWLGbxaP9/uusnmcWXCE3WPrLzuPz5vkAjii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJmrN/GVHCYu+Lb11WMDYz/OLoYOTkkBEwk
        Jt5oYgKxhQSWMkq8PhkFEZeRODmtgRXCFpb4c62LrYuRC6jmPaPE3f9fWLoYOTh4BewkTn1y
        BKlhEVCVWP7pPDuIzSsgKHFy5hMWEFtUIEli3t7VjCC2sECgRMv7Y2wgNrOAuMStJ/PB9ooI
        eElsfHuHFSK+iUli9e8KiF0HmSSu3G4Aa2YTMJToegtyBAcHp4C3xLPzwhD1ZhJdW7sYIWx5
        ie1v5zBPYBSaheSMWUjWzULSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBkbrt
        2M8tOxhXvvqod4iRiYPxEKMEB7OSCK9Z8MokId6UxMqq1KL8+KLSnNTiQ4ymwLCYyCwlmpwP
        TBV5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1Mbv6rvv/1OBfD
        MYur/w7H9K3W8Y+39RpUh61Ik/i77tuL9o8pFx469qwMiYjoKPdfkL51RiCbRc5iSRn99wJu
        zI5bO08vVTQoat724f4rDcnt7X0GF99KL3lUf3TCzK+R3LtY5txdPTfDgkVg0kqZt04nolWU
        XYrW7ozau9FkpaW7+IXWlz1sJ/cff+z6ZNfXs6rXvq0L+mpToF94SbdHQOiviuH3/ZphXDwy
        bU91E4u/Gf7RW5byuamXS/CZgt62+DXd93/KM+e+d/jj+7MglmV7v+I5syOcLnfqovxeTn+e
        +4Xv3fMbC45/jKlr2XRR4Lp4bvwEXf3Qb8Kn3sz1Mr9mG8dfuWDPLIPOvezGSizFGYmGWsxF
        xYkAh6zTJV0DAAA=
X-CMS-MailID: 20220617064709eucas1p10e6e72f0655c42d00ae4c2275297bffb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a
References: <20220613125622.18628-1-mgorman@techsingularity.net>
        <20220613125622.18628-8-mgorman@techsingularity.net>
        <CGME20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a@eucas1p1.samsung.com>
        <e1c73640-3f29-bf57-b98d-84b1800cf4e3@samsung.com>
        <20220615160446.be1f75fd256d67e57b27a9fc@linux-foundation.org>
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 16.06.2022 01:04, Andrew Morton wrote:
> On Thu, 16 Jun 2022 00:48:55 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
>> In the logs I see lots of errors like:
>>
>> BUG: sleeping function called from invalid context at
>> ./include/linux/sched/mm.h:274
>>
>> BUG: scheduling while atomic: systemd-udevd/288/0x00000002
>>
>> BUG: sleeping function called from invalid context at mm/filemap.c:2647
>>
>> however there are also a fatal ones like:
>>
>> Unable to handle kernel paging request at virtual address 00000000017a87b4
>>
>>
>> The issues seems to be a bit random. Looks like memory trashing.
>> Reverting $subject on top of current linux-next fixes all those issues.
>>
>>
> This?
>
> --- a/mm/page_alloc.c~mm-page_alloc-replace-local_lock-with-normal-spinlock-fix
> +++ a/mm/page_alloc.c
> @@ -183,8 +183,10 @@ static DEFINE_MUTEX(pcp_batch_high_lock)
>   	type *_ret;							\
>   	pcpu_task_pin();						\
>   	_ret = this_cpu_ptr(ptr);					\
> -	if (!spin_trylock_irqsave(&_ret->member, flags))		\
> +	if (!spin_trylock_irqsave(&_ret->member, flags)) {		\
> +		pcpu_task_unpin();					\
>   		_ret = NULL;						\
> +	}								\
>   	_ret;								\
>   })
>   
>
> I'll drop Mel's patch for next -next.

Yes, this fixes the issues I've observed. Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

