Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC954A57FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiBAHng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:43:36 -0500
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:45153
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229975AbiBAHne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:43:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGjGp4WJhU/QUmJ37qy81UWoc05YuluPwKnuuJZqBy/MG/YdzuOeenIXa/eSqfNsDypORFVIiSvC6IZrOlPQabZrTIyDMcZAel1rygCW0yGClwbhOUutceBeRTL1PvWngo/jZ3uLF1JfhIopdyFY/WncmaYKqRMQjOm3ozs5/swfOYtbq94R1nmXLwIE5Mz7YYqsZtROHKf3ii8dCWR118phLcgq63VdpQ/s0ilByPVfq0PAMlI7pJ3TVEuQZFuYpDmTU/ZzS2sHS93dsEBTw0mxXBTT7BPX8aUaFfN3QgsncTkjlV+UPN9s4Gx6IKvxlem9KdPj2wcM4LHlRZ9WiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+NmqeFZLDxEVUIqwcxC/vNIBlUqbZJ5YQC/VBnfM4U=;
 b=Tj+2uSudEOu7BPh0U/Ysfi3LfBKzM319HG2g8IMibkUygFkcdzXT3QyMbzuWAetB8xehNXNybUEc0owCut/3dLhdOB3w7TRKIuucGZX6cOPxZ8CwVkkl0aFd671FKi2tWg+mg8Pmpv53VnfnfAaNokx5p0v7JLbisySAdlHXpPE8fS+g/9BqZq/BzDwUFKOS8wwDpnQsWq6RSfv7YuLTC+btPTLJjpxPoKmHnauYo8yhLBLIPcuEJZ5NbPp5U7nvl5zuOJeiD4FtGJk+Hy/tT+I8XcBFIlLVJSpYx6RQy1312Z6JV892KLfZe04aRnYrgDN81I392I8l45mhEqnO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+NmqeFZLDxEVUIqwcxC/vNIBlUqbZJ5YQC/VBnfM4U=;
 b=oJhd6v1qZ3OO+taQSscY0f1rp9jjlSgMorSfSQdVEh0xwnOpxy15qCfZTUZRE6PrT2T2Luv3LyL7pvzbSz0dVXafDx+TYHJk1St3LVDALWzsK5qVgrleEHQaU8lCGJvtKITuQsSkjuXOKPOVtx+BbY+6Tp7R8a1jZ5KBwXUqRWOE5mtGzqR8uF+A8te57qIVF/ZkIWPFl4A4Z1WV6na26/U4w+9Vjhi0clRyodxsL60zCTGpbBcyOKmZ8dxKMO+lNZjtOYKXEcwHCkwYpNEkTGJhJqhDqQc/b129iq7QacWoWLsn2aDLF22XpbcNupHOxfAxm5/8NRgTIl1QJgg22Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 07:43:32 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.011; Tue, 1 Feb 2022
 07:43:32 +0000
Message-ID: <93a8440b-a5f5-1ddd-0834-57808c26d9bb@nvidia.com>
Date:   Mon, 31 Jan 2022 23:43:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 1/1] mm/gup: skip pinnable check for refs==1
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Will McVicker <willmcvicker@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220131203504.3458775-1-willmcvicker@google.com>
 <27e5f98a-0709-1a80-18ed-e4ccaaf39fe6@nvidia.com>
 <YfjhGKCkQ6h5H5uI@google.com>
 <36068cbd-2020-1961-5034-866a4c7b20cf@nvidia.com>
In-Reply-To: <36068cbd-2020-1961-5034-866a4c7b20cf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76e08323-f4f6-459a-9e7b-08d9e5568ba4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3540:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3540D88B025B777AABBF2F08A8269@BN8PR12MB3540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wM2U5UmrwSLwAIxBv7JVF33L4P6ggAmZJE5pQFHb18rrq2tOk8PfYxGpqtIDVrIGjanRUg73itf4dPAelHEOAQD6H955NEdG7aYS89iWuI5lEmHpTmm+7dT1TqEfU0pzUsauadbDXFAQf2iiLslGrAKLJ+Q5wQl7arJvuF1xk1heEA0wwU1tOKHs4yM/8zgFS04RUNqbINHXkQ8fN0IW9qx6+oe6L83JAWkmzzgHBIaWiJ7/LPpV5EWD+/Ehdd9aQyeVZ+7dVfNwBb44AnmgUmiA67lF9X+8tRuvUROeHF3rvRrZoyoixyYSzYLj3As/0xCACQQ59k56b4zXf4XDBOXVGMuj1LAwQTpTbVwxTOIjJ5mS6jJ9gUDBGjLfKZCxiEh2BcuYPYCAn5epk81J2wDMnzh2nOm65DFD0UOXJS/PiYLr/65EFE2S3O87LAQyBLuRy04bezaKMnLdnazNVPOlZi8oLaFHmVXmUnQB6eMy6IOWvV7QeNWfS41u14r+8AP06gYAm+2eAzXuGKhRqHS99jzJHNKqnnxeeWCxevFEnYCR6fNCnd/OGr/qjVGN4qttOVVTJokf4i6xzjcnnYK2R3STpIaw5tVI0Be0Qkqc1MgeU6cS9OmL0h3hlElN/dGiCa12JKwdP7OeVKoBuRH/Xm60PH/TvVDkH7PHWXgFSaVAnQdaPKmtQRSHDzZLq8zRV4NC1fIVSmQ2N6pXJ+4UqDXxHHlrt//x4UteQrMm39aY8Bfb2zj/Pe4GMWwR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(8936002)(54906003)(5660300002)(8676002)(4326008)(2906002)(83380400001)(86362001)(6512007)(31696002)(186003)(36756003)(38100700002)(53546011)(26005)(6506007)(6486002)(508600001)(66476007)(66556008)(31686004)(66946007)(316002)(2616005)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU43bzU4SjlMTFFQc3dVeHNuVlZpaVVKS3I2RVFzZXY1ZTMxb2x2Rk0wYy84?=
 =?utf-8?B?R29MTTJieDlQSmxrUUdaalp4dTZHYWdCTkJhdVhka1BIOHNLYTJMcUF2MVRn?=
 =?utf-8?B?ZEdKOEFGTk1RaU55RDhVNGVkT2gwNEUwL2owVW44V2tBTzdFbURiaTFrcDBy?=
 =?utf-8?B?TXBVd09zZmRRek5BaUMvUkNPUHE5NEg1Wi8vd0N3bDBTWmVTKzNoM1hJcW1i?=
 =?utf-8?B?U3JWeXNIalRSYkk5YUtpaHpjWTlJVkxjMGlEdnV2bEx2RmpwT3lrU3VYWmdz?=
 =?utf-8?B?T29FVnUvZytJODNiYmxXclRaZklaenRjTDFvc1pKSzN1VHdlU042em4rZ1Rp?=
 =?utf-8?B?OVptQmlKa3FuZ0NpQkd6eHM3ZW0ya2FmczkrV0JUaVVWUERzUStUVDF6cjRa?=
 =?utf-8?B?ZjhOWkhBc0piYlllTGRZUTdIN21sQW9MQlZSR1ZjSXVUU01aY0NRSnRpcHIr?=
 =?utf-8?B?Zy82UFpVRGlVWlVTZk8wZlJ4L0pFcnZMYmZWRm1iN0xFWTRRWlBraXEvRFM1?=
 =?utf-8?B?Nzk0dlN5TDVNMlBGYXZBbmVhUFM1ZlpkT1laa25nRllpSXNkbFFqVjZ6Y0o1?=
 =?utf-8?B?ZjhjUGc5clIwRVo3RWd1d0dVa1Y3TXBhc0VTZWhNRDFMUXNGWGpVVnlBeGtn?=
 =?utf-8?B?a3FmdlRaQktrSDU2aE1rTEhLVlI0alV0d2RvUzNkZU5laklBUTN6SUU1b3da?=
 =?utf-8?B?RDIzRDMrODhRV2Q2UFZ5R0ZidkZVVGlmdlJUbEswbFFWR3NDMjNzU2RqQS83?=
 =?utf-8?B?T0pQMUZULy80Vk5BQnBmSXlYb0gvK01uZEd4andHYitvMXFYZTNXR3BRUXlT?=
 =?utf-8?B?VTRoTXhZaDF3bkp6Q2hUSExTWkRUUmo3WWxHMlFYMTVDK1pta1BOaDdMbmZM?=
 =?utf-8?B?eUlqblJGdHpGYXlZelFSWWNFbHZTN1NJVGlOV2tqYWl3Qkg3UlZ2VEw5eGIr?=
 =?utf-8?B?VDJ0S0owQndzajJ1dXdTcVBHRkl1am14SzBRbWNiWG81WTNmYTdRY1JtWFhI?=
 =?utf-8?B?V20wVUpqSm80VzYxYUVlaTBYOTBOL0NxczJVWkRzekJBQ2laU0gvTXlkOXIx?=
 =?utf-8?B?WTdPTEVsZlYxcDdBQXlYZkIxOWU2TU9uZWwwc1o1azB5akxDQ0oyVlRueGNX?=
 =?utf-8?B?QkJXRjBDRlRyY0RMZGVsMEc5Z00zTjI3MSswblFCSUJLZ1hPblpNaGc1bUlF?=
 =?utf-8?B?TUhhejRWMi9NZXQ5Q3dmcFVLMVpLMXVTdXd0QU4xbUZ4UldIalhFWnBmWkJD?=
 =?utf-8?B?OXRpNDIrMW83L3pFSEdmOThPQUdPRnhtUTEyTEdYY3hUWldvZ3NNTWNQdDIr?=
 =?utf-8?B?S0NPbmlrV3FMS0txNE1MTWplWXZBSVQwRm1EYzZPODJBcEw1d1ZGMlhyOUFF?=
 =?utf-8?B?alhscy9pZDBVYVYxUjRQa2hLQ2c0QmR2RFlIaEE1U1l3RE1jalZYbVduVzZP?=
 =?utf-8?B?ZGFNd21DWE1GQ3VqcW5RL0JhTlBaRGdiSlF0QkFkQ3VmZ1pFWW9PSGp1TnVP?=
 =?utf-8?B?SXpEMTg4a08xTWU4Mlhab0wzWGdUSlpoQ0U3dGhjdDlycnNzZXVkd3RuKzZD?=
 =?utf-8?B?MlVaZEorQ1dIQXlkY3VxK2xFV1daNnlraUszd0Q4VTVESGFtT0FmMjR4KzdY?=
 =?utf-8?B?Zm5KNjVMVThtb3B5OUprMFhYbEZIOWdPU0ZGRHdnNGErT3BFT0ZLQklaZnlQ?=
 =?utf-8?B?K2JvZ29ZMFJiaDY2VDJaKy9lV2l1MGN2T3YwZnNDS1lmR0Y2UENzSy9nYTVS?=
 =?utf-8?B?MVdJS2cvVm4xc2laSmxuWEFSTGhxWVJnVVZvdWlnaVBib1Q5dnY0dlgxZFdl?=
 =?utf-8?B?Mm9YK2toSW1TMTk1eWs2b3ZGUXJlcHJOWEkwRXlkRGJPYS9tSGRzbUhBblpS?=
 =?utf-8?B?OFZab1J4TFl3Y1ZpRjI3bG85VElKRGROMlNIOG5ucUNTeHY4TkdZVHBndEVu?=
 =?utf-8?B?K2VqQjV4eFZNQXArdkRibUFoUGg2bHQ2Z3RubjBIOTJiZVRMK0U0U1g3VU5D?=
 =?utf-8?B?dStKV1ZXKzdHNEtTNXRMaUtpTDRwY1A0cFVrTkJKNDF2NG0zZkhLczYwVTJE?=
 =?utf-8?B?cHRxK0ZIWEJ5YmlxeFoyWVlmbWVHNlRyZ0F6YmdKUWFsVmMweHl1TDJFZ3Ix?=
 =?utf-8?B?amJ4Y1p1UXM1Vzd3R0dGempxOVR6MFJPT2M1S3QrTFBWL0gyMFhLa0xtKy81?=
 =?utf-8?Q?ZWG3cagn4xlGCfPhP0LC6U8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e08323-f4f6-459a-9e7b-08d9e5568ba4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 07:43:32.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xz+1T95hSzleY/LrEr1TQDNXS+kmwpUiYppGabdBNesghgGUbSAheNUjsvDWh47mZy2IlGsqDYvw1ZlXel71Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3540
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 23:35, John Hubbard wrote:
> On 1/31/22 23:28, Minchan Kim wrote:
> ...
>>>> --- a/mm/gup.c
>>>> +++ b/mm/gup.c
>>>> @@ -135,7 +135,7 @@ struct page *try_grab_compound_head(struct page *page,
>>>>             * right zone, so fail and let the caller fall back to the slow
>>>>             * path.
>>>>             */
>>>> -        if (unlikely((flags & FOLL_LONGTERM) &&
>>>> +        if (refs > 1 && unlikely((flags & FOLL_LONGTERM) &&
>>>>                     !is_pinnable_page(page)))
>>>>                return NULL;
>>>
>>> ...but are you really sure that this is the best way to "fix" the
>>> problem? This trades correctness for "bug-for-bug compatibility" with
>>> the previous code. It says, "it's OK to violate the pinnable and
>>> longterm checks, as long as you do it one page at a time, rather than in
>>> larger chunks.
>>>
>>> Wouldn't it be better to try to fix up the calling code so that it's
>>> not in violation of these zone rules?
>>
>> I think the problem is before pin_user_pages can work with CMA pages
>> in the fallback path but now it doesn't work with CMA page. Driver
> 
> Actually, it "worked" only if the caller did it one page at a time.
> (See how the above attempted fix restores the "make it work for
> refs == 1.)
> 
>> couldn't know whether it will work with CMA page or not in advance.
>>
>> pin_user_pages
>>    __get_user_pages_locked
>>      follow_page_mask
>>        follow_page_pte
>>          try_grab_page
>>            !is_pinnable_page(page)
>>              return NULL;
>>          return ERR_PTR(-ENOMEM);
>>       return -ENOMEM without faultin_page
> 
> Yes, that's all clear.
> ...oh, but I guess you're pointing out that it's always going to be
page-at-a-time this deep in the pin_user_pages() call path. Which is true.

I hadn't worked through how to fix this yet, my initial reaction was
that allowing single refs to go through, while prohibiting multiple refs,
was clearly *not* the way to go.

thanks,
-- 
John Hubbard
NVIDIA
