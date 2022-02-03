Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6924A8F4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiBCUql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:46:41 -0500
Received: from mail-co1nam11on2085.outbound.protection.outlook.com ([40.107.220.85]:20705
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354476AbiBCUpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:45:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaoJWwHXkZqemutE/Al4AF1z0Os2evRlaRoVgnUsEcMr5+vEOxHEr4C0fU83hYQyTHIMthgFs5amuiZbEusl+7+MYqW6Uv0ODQtzPfTbcmZJtwKVSrF0pxvnySoGJXWNf2HVEudTpSRucKM2c0aWzCa3lUow9yXlvNzp/rpbq68DJIJTJCRm5YxH16LpSCUkLNzzKpS9a1SdJ8edws9dUhaKGFC3tpPs9y27TfYvo97yyIZNih8XWzKCoSQUBz4N0JxE8PQM/QT8jwNPMyDzjc5Tj/g6+N85TZ1Wk+2qLs139H6Uwhfes6AX2G8lCieFuZnDnGUBm/UhI7bib9ZAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9dp6qj9EBRpjVYAQswNbY/UDXwkEactFn6io1PTOuw=;
 b=hnKAgSwsSeFZyhANSM3iWT1ruZrWv/5zPlI/wC4hq9paVDOiXLKa+eSQCIWlvKXXqUGw/oisw7hdDvLOEq8Bb39/gYjJOdt3w9CS0bZ7uQKlK9iVkYqDwM1t3P11lCxnmQx1Fyi38QEtfb+qtWJ0z+qZO+jzHnaIy7Cdvza42t5QFBACXBLSITfF8IQK/a6ivYjf2/rDuNGB1pR2OY1kMc/09IgsGcMUln7bmIjLaTJC20D3v4AE9PU5zO+Qw4KhGyEWiWe/EIWf/ExBv0CHLP2SnNxKxx5HJWZyZ6Zs9l11Yxy5repDNNtcJ948USnXtbw/QQfzfTUcNxQ5DKcLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9dp6qj9EBRpjVYAQswNbY/UDXwkEactFn6io1PTOuw=;
 b=BriYmq8+NfqNm9mpqvIa1P1LeVs2AF5Ppkq/aRJQWyzxT6JgOdt8X9F117wUbw9ThzWZx0yIdPbhNtMnCJlW4p3fYX+HDSVvFlnU6ZfdOOZb9UyqGeWQqW7oBrrai/2I53yFZ78ohpydiHRD8FhtRQhuwdzikoPQrXjZoq0TirUoS6jw3rXE0GIuCVBimlMpJ0Od45rf+3L2f4uPE3+NUUbX9TGmgdN0AV2ji6U6Q85HO9Tr86FcH3SLQ4DqUfv7v0kY+WyS0REnY8Omrmtu/O1QAOUVGQVweFRs8yDz1XVg9Mk9u4Gter8aKz4TTAVsMa0CqmsXH6vQ6N+ZLqCrlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN6PR12MB4750.namprd12.prod.outlook.com (2603:10b6:805:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 20:45:00 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 20:44:59 +0000
Message-ID: <222e01e6-bb00-51ee-a94c-089b43cbaf42@nvidia.com>
Date:   Thu, 3 Feb 2022 12:44:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Weird code with change "mm/gup: clean up follow_pfn_pte()
 slightly"
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com>
 <6d38ed2a-72cb-3eb6-5af1-caee61d94005@nvidia.com>
 <20220203130137.GZ1786498@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220203130137.GZ1786498@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::39) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f49a6f7b-bce3-40f4-9afc-08d9e7560b92
X-MS-TrafficTypeDiagnostic: SN6PR12MB4750:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB4750FC1AADEDCBAF237CDDD1A8289@SN6PR12MB4750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7BwvQ/ZBdrefbSBcrSLd1eOxku3x9iCCifg5djmGR8/0krVFPBRMmFbjZ9SzHhymVuOCdK63QI1spXwVw7XDSKG0cPqIud6TarGruT42MDcJOHoH+ZC9WBEmhgVC94130O9Tp7o/vrSIa+SIg4TJeDZQMoPzGj7CmUYB/C+D6pBLsjf9IQ172d6diUd8ML2WIPrDKzle/r/mO87NIQdCspvngCZ52lc7CsNu5ZZ1QNHf/3u2gFNi13YcTun7ZhplnQvrhI3e7FOkHZvfZmFm13GCw4ctZ4HFOUHyNf5ih2YTXN6p7bs84Wo7jeC1pwfgMFNZ2fixYINNJR7W1/nAE8DzWX6o6W6AgDjDVX/5Jlkv8iH8L5gA7VGwTkxbDAxAIdkBYDBwALN5kTybZ4EjPvcL95iT0s2FckupDenFt0+u6/F4WXM6eBXxbBEjhPSsWv0WE8m/1HKEbI+cy9b3tG6gAxmQlbE27nmtTmp6swZoO3DeL2vA3rRcqJkHySeZAUQILQAZ1B113qOQ4l3pFjuO/jWkogmRW9al85/D+1WTR51qPOoBa6NRyhuVEEF/CweBWH+MbLOS9/IBiJ6vBaUKi4vqGkC9Xf+KQpQfXreW7HceonR9sLY03XjanPVDbGgmqprLir493EkkIB4z/6nZ0F/zgUKKctNjq2LXVY/Tu4g8Tk9u7nn1PktIg6aAHGzd/L9VV2A9Mhntwo6eKuGRGABxSjFgrJyY3L/lEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(26005)(186003)(38100700002)(5660300002)(86362001)(66476007)(66556008)(66946007)(8936002)(4326008)(6862004)(8676002)(31686004)(36756003)(2906002)(6506007)(508600001)(2616005)(53546011)(6512007)(316002)(6636002)(37006003)(7416002)(6486002)(54906003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDZsWUpOV1lEMDRpNEpZb0Y3eHdET2VBZCtGZ1dJZ3dKMmMwOWMxZW94Ukdt?=
 =?utf-8?B?cWxHUFVkbkM3Q2c1Qy9rand0bE94cENGdEV6eXBQUEpKNThPNkY0Nldld3A3?=
 =?utf-8?B?a2NoK3lqZFd4TllPY2ZDaWRqTFg5eTNHRFVCSXQ1OXRPdlBsVGxpcmxJWkdF?=
 =?utf-8?B?MnBuUGdTZ1lpKzBtMElFcExCaTFQQVBXbmVqMVoxektSclVFQXlqUXRvS1hQ?=
 =?utf-8?B?cUtGenhYK2lYdFI5QmFjQ1BITWZxYUdwdnRFZzFNcWRlSmlkSTRmTVhCU05Y?=
 =?utf-8?B?RWI0TFc1N2M4VU9HM2djZkVkd0E4anV5RFNmL1U0UlZIZWh3RE9sUkZaZkJP?=
 =?utf-8?B?UC9XTTZ1WC9DWVkzWHpYL1pjdFBSbGM4ajBsTXF4OGhFV0pBNmR6KzVzQlBJ?=
 =?utf-8?B?OW5kYlc1SW1pRG9oTVZLSW5xd1VZM01mZkJ0MjhVK0kyU1hJMjN6THNVcjlW?=
 =?utf-8?B?RTl3VHBGMjB2czRhZzhrUk1td0taeXpkQkh6bkloOElhaFhNdXdqNzNPYms0?=
 =?utf-8?B?c0o1eG1tK0JJOFNkU3B4NmxFbjZkQ2J3ekIrS0ZaTHZJMkRROVU3MzdGRjJQ?=
 =?utf-8?B?cm5MU0NpUGlwWFlJTzdoa2ZJd25SK1k1OUxaV0lOL0JuL3l2OEN0WEViaFY5?=
 =?utf-8?B?QU8xRHdGTWRNN2o3WDY3MEgxR3lyWEpWcEFBdFZsZlNCZEdSS2ZnLzZlNnha?=
 =?utf-8?B?dWR5Snl6ZlhjdUZrdjRyTTEyY080OE11bjNFVEl2c2dub2JGTUZQN29EYjc4?=
 =?utf-8?B?NEU3c1BGNlJMdXNobGwyQzBBYkc5OEVFb045aE9PZEpRNlQ0Ky9Yd0hlY3By?=
 =?utf-8?B?cE1rM2Y2ZjduV0tyUTkzR2g3RUNGRmUzbTRFTDlXOFA3VmVOdjdnTUhCYi9Q?=
 =?utf-8?B?OHdCVzIvOFhhMnlaZ1JrZ0xWUkZHYU1lSXZxazlwcENuVFVOb1F1ZEtHeUN2?=
 =?utf-8?B?UUlzbi9lVTQ0cW5URGtPUlkvSWNzRXdTMXlvNHV5cU9qVGs3MjRVSTl6QjVu?=
 =?utf-8?B?bEdVZ0NQMHJUQ2Vvbm9Mb01oOUIzcklDekh3bDRUaTAreCtWRVZJcDBCTjdz?=
 =?utf-8?B?Rnk4TVh5cC8ySkxEdkFrZ3FqMVk0am1LZ29DTkE5d3hKanZ6MGUxTW5OR3J1?=
 =?utf-8?B?UnE5N0o2aGx5TlFZMVZNQWdtQmVnbTNWN2k5N245VUhTcXhPR2t0WFl3NDRG?=
 =?utf-8?B?SGFwV0puS1cwUE1CRTdnNlZ5THZWMGFFZjBEVVlidlRkdmlZeW9LSjc1ZWZR?=
 =?utf-8?B?QmZ6S0xRMWJlbVdaeTZDWEJvZ1o2ci9GUFNqbExxTHYva1VEOVRhbi91ZEor?=
 =?utf-8?B?djFDb1EyZ1NWaVVRZlBRa3AxVXNHSGhubCtjcnlpSEZhSVhjbTJTOXQ5MjZY?=
 =?utf-8?B?dFF6WHAvRHlaQU0yNjB3VXl6dmIzem9TNldwdVlDeHNlTFB3T0pocGZjQUNK?=
 =?utf-8?B?ODZDUWlrV3R5OCtaeDhIcnZCeUM0UjBDNnRid010Y1cySU9qN1AzUlFyNTA0?=
 =?utf-8?B?d256S3RhandhaHExMVpYcDhxUWM4aHNkaCtWdWE5M3FSOS9EcHZrTVNKS3Zt?=
 =?utf-8?B?NGdaK0l0dmJUV3BlRVk5ZEQ1bGs2ek9ZVjJtaHdoV0w5MSthWEZYVGc4ZEVH?=
 =?utf-8?B?VWZjL2lUcTEreWFUQmdQcjVXVlA4K0N6K1BwaHR3RFpRWFlGaWVrTmtwMDA1?=
 =?utf-8?B?azNzbk1zZmwyZ29scGhyOVNKaW84WWpMVVBUL0gxNGdRL05DTXRndDlGNkNN?=
 =?utf-8?B?R1BVTzhkZ3lIdHVRVlo2YlZ2dGFCOEFIbldXdEEwZEFFQzQxaVJvTDcvMjFM?=
 =?utf-8?B?V0tKSnBRT0d4MWE0NVUzWTdCV1RpOGh5TlBBM3NneGRCdkJqMzNsbkRjM0FL?=
 =?utf-8?B?NHBubzB6YzlWUWQwWTNMVjc1TDFOL0l0OUMvT3p2WVg5MkNoVm4weGE3Q1ZL?=
 =?utf-8?B?ajU5Vkd6TmZoNERWUVlHSDA2U21aMGo5Vk9DNlpqU3pDbmpSZ1V2Y2RoQSt0?=
 =?utf-8?B?eGtITVN6SzRVYjNxZVZGSjB0czFkZHFVQ0ZhUW16N3dWUUZleXIyYUgzeUVI?=
 =?utf-8?B?MUh0dktvb2hoNjFOQlZHVGlQZ0VjS1FmNUt4NTgvdllkRFlVeFluRW05ZEZD?=
 =?utf-8?B?TmRkRkhXWG9jdHY0N2VoQTBENXlacDN4akI1YWs3RlBHZFJGY2ZEK0U0ak5n?=
 =?utf-8?Q?oY/pc268GebvQaS085w2LVo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49a6f7b-bce3-40f4-9afc-08d9e7560b92
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 20:44:59.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uISKk1LJqQCA5Rs1gNL8GvFy9JGVIJmNiXJINJrsQ4/1165jsJnl+V4zBquq4WXa1egXmLEF1eORlht9pvX+jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4750
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 05:01, Jason Gunthorpe wrote:
...
>>> In the new branch if (pages), you set page = ERR_PTR(-EFAULT) and goto
>>> out. However, at the label out, the value of page is not used, but the
>>> return uses the variables i and ret.
>>
>> Yes, I think that the complaint is accurate. The intent of this code is
>> to return either number of pages so far (i) or ret (which should be zero
>> in this case), because we are just stopping early, rather than calling
>> this an actual error.
> 
> IIRC GUP shouldn't return 0, it should return an error code, not zero.
> 
> Jason

Errors work for single pages, but GUP is a multi-page API call. If it
returned an error part way through the list of pages, then callers would
have no way of knowing how many pages to release.

With that in mind, the API returns the number of pages that were
successfully pinned, if that number is > 0 (or even 0, in some cases),
even when an error has been encountered.

__get_user_pages()'s kerneldoc documentation covers it. And I see now
that it needs tweaking to include the FOLL_PIN case, but anyway:

  * Returns either number of pages pinned (which may be less than the
  * number requested), or an error. Details about the return value:
  *
  * -- If nr_pages is 0, returns 0.
  * -- If nr_pages is >0, but no pages were pinned, returns -errno.
  * -- If nr_pages is >0, and some pages were pinned, returns the number of
  *    pages pinned. Again, this may be less than nr_pages.
  * -- 0 return value is possible when the fault would need to be retried.
  *
  * The caller is responsible for releasing returned @pages, via put_page().


thanks,
-- 
John Hubbard
NVIDIA
