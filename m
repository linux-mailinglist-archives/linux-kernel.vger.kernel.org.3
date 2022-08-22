Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C092D59B6EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 02:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiHVAOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 20:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHVAOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 20:14:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF7D10579
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 17:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B73YXSp44o+WBrWSdRou0rmXlnQOmQcYB1ouF2i2XAy/+e9yFsDnz69mqp+tYRx/p73/yVyxmMKfrCpW6SX28yWpphp9KApPYSZ4usvi21KWzofTdq+vCDlkGPwMILng6WClIO2kwyjMS6gEFk7KsyX5IgAQbbQnGqmDUyD8xKLz31hJZGuovuW9L4g9GUw8Gruk4hH+XRFbNdxRt5ScX1M72DEdQ3BadF6weuoakoAs7r1ESNnUlzjZioDsG4wDfSuQ9qDEPeqBMbKEuYkd1QtuRBhnHyt3rUOkGICeEPxCeiwis7s7mqt/aOPmvLH7294kwn9po7qappYgzz95XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na2EigXQ30kHXoM7qGFEh3KhmjobrelULDU6YTu2OJY=;
 b=ijIWByXqDNbBsv9/pnH1u9laLFxg5hcbwqYw+jGNQ1P4H0UTKTY2H+IVOLQjdhd2VsPyzIx5pYKMrfKIigcEg25jkvKkW56x5gcYjWrsuz6LhE9xBfwb1C4fDHAaiBntEXKPygIxQCYgvxoKjEgKqAaqMJ8rgQQXGzCwk4Cxxd/m33cquZ5lNqBZZn37zGmBLVktZ16dj87qRzahT7jk/bbzB7rptiN6tEOuTSgUb6bbcvymlXFzCIlmqpt8y+eYMcO7PqwngGOjX+Si1g6VVmUwvvu3+jgyh+YwAlic9JQ/7XlnYw6pzwL7c3oUhqPaqx5jrg8/kPlsWnbHj7NU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na2EigXQ30kHXoM7qGFEh3KhmjobrelULDU6YTu2OJY=;
 b=solr5Ago+d2u/r+NLx6RLGsDlBe6DDlBhv0WcaMhCPn0gYeNtUdYEjXTGI32HOXdnSyxSNvWAMw19DZHhYYwVnn5Nm+3/jTijkZgO3gwUjA/lP2DHZHmrx+PI2i2pVuVuh88WXFBiw2+TZkP4hf8eGIh2X/hG3mPVqc4Ypc1YefKrp0CTLD8TIydxUW5xLZRdRRHHbXtZGVgaxdDqt5v0JFYodOoD6i/+XSDgxfYvXZHDMUIPEutxIqDyrkCHc+p+snuzNnup6/Qyxs0VxTBuVD9Ln9oN2AOFyvssSZoqEljdGMrcbP8igl8MKCuA7OirgsquNshiLYTWo8QPY2g8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 00:14:04 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 00:14:03 +0000
Message-ID: <7398324a-2134-3501-ca81-67a56a4c8629@nvidia.com>
Date:   Sun, 21 Aug 2022 17:14:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/gup.c: Fix return value for __gup_longterm_locked()
Content-Language: en-US
To:     Shigeru Yoshida <syoshida@redhat.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alistair Popple <apopple@nvidia.com>,
        syzbot+616ff0452fec30f4dcfd@syzkaller.appspotmail.com
References: <20220821183547.950370-1-syoshida@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220821183547.950370-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c43a3618-eb7e-492c-e4a4-08da83d338ae
X-MS-TrafficTypeDiagnostic: MW4PR12MB6826:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8wZJBr4nh+gKlNBxF0ZdUU7IUQeP3v5Ye7stJpznKDwqtB501IGOWpNc0xoTvNmXoXrUs0RWpHDlyjlKaY0cGQlN60EzNXrfJXXlYFKae56E0BCkwY9jzZ4W70M/dqmtm9YeFrrleYPUSOHh4aiSTz4iMbdR51w0C5revNnryhI4Vm85jv9yEWqFt4NDIXIcj4sHt3pmWXjToR96AEIJHt+3kugnxHsuWex+ImlrbUTn1P0xmZbAXEgoKqTWNzum/imfR6n9E/3XjfxqckeZSII1VctMWqhosgCojNzex0gNYPM0/ULVlAAGpnv1Gfozu8u+0J41stE1mrzWoxu0/x8C0H/gIsSoUQH8CLPVoCRLZ6VFH6CPDzc/POLbxkX6sU1YrqEChMEUHRRywZ9adwadh7A5+DpEaYXopbNur/dXWIVBJQv1K8+LjdGVAgQUFPa+jdwGttBG8bGpPHt/YYateiZVBon/FXdD+JksQIihNUjrF8QvCAojcQZJNsI5wyapyVzZlqAEwtTl4KW9mnXFvVTEjTKkz5mT9dxlp7yzx3obT2MJrPH/uYQuVfzSNbeDjm5tIXEkgy0msVcjjz4ckm5by8zGK9v3Gh8XZXOwV5ZoIM/EEMp8+agdSSiQHmXLWgGOFbO4Ux1WO3pxGT2im5i2wdy9iN2/VIH2cYcc8JkFPDzT6TAz8INkf1V5mfNAXKgszxkxJTGI4cTtEFwKTwidslLvtHwYNyYukjdsSZlLbx95Mt9+5b9GGrPeVPBXXP8mEDORzhPdOBmcpRdtD0M8TsYrZJPRzPYZwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(8676002)(86362001)(83380400001)(66946007)(4326008)(38100700002)(66476007)(66556008)(316002)(31696002)(36756003)(2906002)(6506007)(6512007)(53546011)(26005)(5660300002)(2616005)(41300700001)(8936002)(31686004)(478600001)(186003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGNVdnl0YjZoZkpRM3hkUkpRNERpbjM2MnhVcGxpNFJaTDBvWVNUKzcvNXFa?=
 =?utf-8?B?QmM4TGR5U3FybkxkZEVLZWpDd25teXo5WGZPcmluYjlRTjRHTjZtUkVJWXk2?=
 =?utf-8?B?aGY0MzlTSDlvLy9KWXo4TXhGUFR5cmUvZ3g1Uy9TN3hQZVBsOUVVbkt6RWpQ?=
 =?utf-8?B?akxsWDl4eEU4S2VhQnVRR1piUW5jL0F5aUtEcW5rMFJMc2h0Q2FiT1RUQjYw?=
 =?utf-8?B?eVRXTlJRd3d2MDVTRUc0SDZhS3lmWER2bjRSTzM3Z0M5S2F3ZVI4QzVYTTcy?=
 =?utf-8?B?RVdiY1huSmZYQmFsd0tWSzk2WWVJdTE1aXREMGtLSmlEb2tNM0VDcTdFWnlY?=
 =?utf-8?B?bUNvZnBRMjNnL3RDbm1qbGl6Kzk5OWQ0a3FsT0ZOWFJUb3R2RGI0dEF4RGR2?=
 =?utf-8?B?UVRXZXNWMURJS3NUL0h6ZDhYRnlKKy81OFVOQ1QraVRWNXZyK2wydW4rOUtB?=
 =?utf-8?B?cUYwRng2YTNCZWFaWXJWOXpTZUZkcWdNUUxweWEzMlgxOVlhWnhCZCtuVlBO?=
 =?utf-8?B?T3hRNU8yTmxRdVZxRmFCK290RDR5VjdWUVY0TUtGTzdKdDZWa3cvRjFCSFZX?=
 =?utf-8?B?YkJMSkpPbFpDMEtFY0RHRnBIS2pmdmpFWHptYVRsNzVCYkZISytyQVkwZ0V2?=
 =?utf-8?B?ekR1bVBVa2ZVeCtIYVhYVWJyL0pObU1yWnVZZ09taDdSUEQwbC9uMGJsZGNs?=
 =?utf-8?B?Q1MrV2FKcXppNjZNcWV0Qm5YV3ZjSFcrMjB1dTJWNk9wdW91VGFnakM5cnY4?=
 =?utf-8?B?clY5V3JFYUUxR1FrTHhlUFpTUVlJVndnVjliLzBFYnRBNGtOM2dHaHdrUjRH?=
 =?utf-8?B?c3F4SGdSODVIdzIyajhleFpXK3FPWENEc3RUc2ExMDhZek4zQU93dzd1ZEFB?=
 =?utf-8?B?Z2lEUXpUVGI2alRNRlIxZDI4ZzFrbTZWQUtnamR6NlpvZEI1UEFnQU9sYlAy?=
 =?utf-8?B?K3R6UHA5TTFDUU1vQmRTRHB2YTJWek43cXduUG9iUVQ2OUxwTE9qUHdFdW9K?=
 =?utf-8?B?Tm0yRGNNSmVnOEJ2OS9vWXREM1BsN3FhdEs4WXNrTHFZM1ZWMjVJdWZmSncr?=
 =?utf-8?B?SHQ2QVV6SVM5dUFLM28yQ0ZDTFppTGZHaGpHRE52L21YNjBBa0R3Sk9XNWl1?=
 =?utf-8?B?WnhrZTJHNkZ3RjRhWllkNm1CUVRvdmNRUk5hVHB3YXpURU0zVDVUL2lvZmN5?=
 =?utf-8?B?VmNLMTlTeEliSzI2V2Z1Qm5TY1RyZ01iWCtPbFRoa0szYkllaWc5RTM2NDlG?=
 =?utf-8?B?NG5HRFJSVVZGdkQxT3JDSVQ1anBMTS9xejNIeVRTQ01LQ3E4b0ErV3BZTHJh?=
 =?utf-8?B?ZFZYb3UyUCtxNzg0aUNqSUhIdEZUODd0TDl2a1M4WE1JMkplN1FBZTlGa3Zp?=
 =?utf-8?B?Q2dVR0Z6d05YaWQ1aUI4WTVxZVdxbHJqZFA0TjFlUU5OcnVNRnRzbTdWK1pq?=
 =?utf-8?B?YkowaTRVYjdkY1NwVjNueDhKZm5rV1NZclhLZGUyRWZJalNjNFUxM1ZlTXR4?=
 =?utf-8?B?UkRWakV4MXdGS3hzNmp5UzAzMjJ2cjhnKzFSU0NuUEJhTFRtWkEvYlRhRXJz?=
 =?utf-8?B?c0hKNXJ1T3l1ajVyTWhEd2tFQkpsVTJSVTFKTXY1MlZOcFIzRk11SzVUbHVv?=
 =?utf-8?B?ZzhWcXJlUXFtNCtwcktTWEZHdmNJN3dQZ2hzSzFNdEoxaTVZb3dkTGlabFha?=
 =?utf-8?B?STBQcFk2ZVNWZXY5dDJhQXpRcE9vYllKUXd3M25JMk9qekhFM3YwYVRtOWwx?=
 =?utf-8?B?Uk8rT1lySlBmeEtzYklvZytNMWd6REQwbUZ1ZjhnU2Nmd01WNndubVFWTHFH?=
 =?utf-8?B?MmIvdlJCMHcwRlNoZ0UzVTZJTjQ2eFBwUG5sWHlWelJXK1UzZU1kV2g4WFF5?=
 =?utf-8?B?cHFKNDkxVnAwMnF2Z0kzcDhRTUdScU5LR2tBYTBzdWR4RVpXVkF3aHFtc2gw?=
 =?utf-8?B?cEZUbnpWakpPMDVTZnRna2k3aEg2Y09XSWNMZ3Bna2pYMHp4R3ZwRXdqaXhT?=
 =?utf-8?B?NkZlUTVvUUYrODBlQmc2ZlVaWGxtbnd3MU1LRGx4cHR6VER2TXkxb1lHUGph?=
 =?utf-8?B?N0tLSCtjNXpVSG9VVFNJV1dXMTFtSG5WTzkxN0tWYWtrMExqNTA1MGtKNVBF?=
 =?utf-8?Q?Rc7Vus4BGpGse5ZYlzdlixcbK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43a3618-eb7e-492c-e4a4-08da83d338ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 00:14:03.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FqLmMWxc6w4zzqeA5dP0SvY20FkMWZTPYuI4lDCarCu6gxyTixqCapTPs4N6c3WvG94PzuYQ1Wxi9oa9x07qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 11:35, Shigeru Yoshida wrote:
> __get_user_pages_locked() may return the number of pages less than
> nr_pages.  So __gup_longterm_locked() have to return the number of
> pages __get_user_pages_locked() returns if it succeeded, not nr_pages
> passed.

s/passed/requested/

> 
> Fixes: 61c63c2076d9 (mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes)
> CC: Alistair Popple <apopple@nvidia.com>
> Reported-by: syzbot+616ff0452fec30f4dcfd@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>   mm/gup.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

(with a couple of nits about line length, below)

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 5aa7531a703b..542cf74c59b0 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2068,22 +2068,22 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>   				  unsigned int gup_flags)
>   {
>   	unsigned int flags;
> -	long rc;
> +	long rc, nr_pinned_pages;
>   
>   	if (!(gup_flags & FOLL_LONGTERM))
>   		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
>   					       NULL, gup_flags);
>   	flags = memalloc_pin_save();
>   	do {
> -		rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> -					     NULL, gup_flags);
> -		if (rc <= 0)
> +		nr_pinned_pages = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> +							  NULL, gup_flags);

Can you please wrap at 80 cols, though?

> +		if (nr_pinned_pages <= 0)
>   			break;
> -		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
> +		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages, gup_flags);

Also here.

>   	} while (rc == -EAGAIN);
>   	memalloc_pin_restore(flags);
>   
> -	return rc ? rc : nr_pages;
> +	return rc ? rc : nr_pinned_pages;
>   }
>   
>   static bool is_valid_gup_flags(unsigned int gup_flags)

thanks,
-- 
John Hubbard
NVIDIA
