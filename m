Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA06C4B9869
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiBQFph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:45:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiBQFpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:45:33 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4F127FB8A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:45:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVo0Bj6P5IlK9BI0T/N/BqTJXLvkLoADwT+5omHiELmRlmYLigMGTfWE/vBsCQ3leFgOrxo7ZjbO7rZcKtZrLIF5v0ifefvjGzV/+G5ruY9Ql+5/pp/OntZrjeL+KqLJ6yfg/7qa32UGb9remstxC4X9LSpcTXLILOLTO41DD/y0oeG1wUPvDrcCbONO8UF8bpPk2YOdVg82kBuTX4A0HPKOTslX/muVNLzpHc7l7QPYlnjP5akzrud8yKmptm21lsElr/FU1IFQ5BHtRfZ3BguEvHIpXpl7VisjQu71dSwvEVOmt8iGdSQVbWmu8eN4Z9lce3Iqy8A1iSz/WL9JRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxezJ+eQ0t8nsp/JeJLAdcYADxuWyL78MpFKSt3CetM=;
 b=O9Zm5VdVVXFmpNddqPSoQxgy2mgYDgU6so6SkDlIuk1gfjvNxyTGf+VPgzA/ewkE0OkB8HTZ3j23n543BQUVn8Scg5LOxXCQS+f4lVVxmB5wU1sYa8+OR3ANx/Ip+xw53qbk/gxcqrVtZiwpOxw2NXXMtSbVMVThmmhH5SD2RdQQqzELIVFOyX/dP3drrvpYGFjjhoiMGCOFY2X3WRvx1W4ZlTRhaPOYUfIWVK97xrX15y4W6kl7S+kln3FnJ6xHNpS7QVXLdsTEre22ocVG3ynz5r6rSjSKiTUdBvknWLFZHhRl8fmTCUUZGwULLoLLgF6UT7qr6L9lHQn5ZH9o4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxezJ+eQ0t8nsp/JeJLAdcYADxuWyL78MpFKSt3CetM=;
 b=qGpr8HFJ56x42ISVStT85BQ7cWaZvKOs7mLBtO9Keg4Azotak48pi5ehrdVn+Pkeq87NbBEx5+cgokL4DDS/ru1PIfZ8x/3wXGYDg2I6tluddr29pTyyjGjcfFkrIXOmnEZWzEAoEm/DwC7AAAu9XGd4dTMth72ZNDrYrYYuqwJcQkWsbyCYQaqIMCqinP8o1LghTFXt7ai/wNQW/I+6qKr0KAH0duUQmrj8eMD+M8Q0BW7qAqOOcWx+vw22UfKHS2wcK52mAnzLHfkYr/Jlg5gfHt1LCLOeu4DyzAkf1Ukh5ZALiemrjTPyUrInmZuFWXNJF2H1GtLs88y4QfkARg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW2PR12MB2348.namprd12.prod.outlook.com (2603:10b6:907:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 05:45:15 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%6]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 05:45:15 +0000
Message-ID: <0c71b2e6-894d-8a36-533c-f5ff8b5e2683@nvidia.com>
Date:   Wed, 16 Feb 2022 21:45:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 1/4] mm: Don't skip swap entry even if zap_details
 specified
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
References: <20220216094810.60572-1-peterx@redhat.com>
 <20220216094810.60572-2-peterx@redhat.com>
 <da98141f-c8d8-f796-d8ec-352d9b2abd6a@nvidia.com>
 <Yg3TKD6i9JjoRe80@xz-m1.local>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yg3TKD6i9JjoRe80@xz-m1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e324c137-2d3b-4d2f-3666-08d9f1d8ac13
X-MS-TrafficTypeDiagnostic: MW2PR12MB2348:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB234870CCECA3172E9FE565FEA8369@MW2PR12MB2348.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YITM8VBt/Klr0O0i8nHnI68H4+UNm/eeAyneseij2LEmTHWXypyYZsCq58W89btrJi//6vyrzPxiN9vNf3jkAw5QQJm8IaBHF/Dl5qOD5R3uUGllNkXmBVcYaBltdKtIx7BzFZiNaYrV4EtjeRlwK0pH7kuUro6K0hrv8+rhlUq0DMKU9PTS4VqXWnwG5ZsVri6rGm6e8mc+upB+w8VvEy6XGwv1En0BhZlu+MqcjpxfXNB3LNOcelYs9cKB7jv8Fvrk6Ea0I7SgyTH639j+sESHoVfuvPFjDDZX4lDyHzUdZ5nP1GA9zLrhOcW+jwvyE2DbpmU0XDjyL8YqGR6TklZWFzLqC7mpuGbs6QJFTQn6uD6YpTDFjZMasvwJ0IHf2C1+FKMpLycuLdRynmHdhNKw6DrF/XgWf3kYYsQTeBrl2xJ+A2t9BgRb5gkFVhlsOiQz1z559Zs+h6Y62jqGqz84PVIl6Fy98yBRkNaIdOy2+kjkIEsVdDsR3o2IzqI2l6Ieij3Tn5fL1eVDQlYA5eKU1J1/5G39wMBTRMMVLHgphbkUVgNFl3WIcbc5Wf/3fNN8gYx7RUaaUxUvNvlRhacO6HUummNgUNW15PNDjBUnS2XlZMKUQB1Cc92snykMcB61WZLdfFOMdATBBP1F6rsQsmkOh2KpWlKvVnFQvWeuNuCZ11QuN3baSyg+Lt9UZMqVaslJw74IkvZJt+LXme2sAEmeW7bxypaqLy4tQlccEd5CqrZXtZq8sV/l70c4jIAuhHoLZeUqM2OEeJA8xTSebkPCxNeSCfi+KFm6hPTLr0P1RwQX2CnbN/B0RboorUYXbs8Q0s6DhiS7MJ2zmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(5660300002)(8936002)(6512007)(7416002)(2906002)(86362001)(31696002)(508600001)(186003)(26005)(966005)(31686004)(53546011)(6506007)(2616005)(6486002)(38100700002)(83380400001)(4326008)(8676002)(54906003)(66476007)(66556008)(6916009)(36756003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnN3czQ2T0xHbEx3VUlkSlF1WXo2RDQxY1NvbTFKUkxZMlRNZnZ6dTQyNzNm?=
 =?utf-8?B?TDFXQmVRUjdRcEg0RlJuYXdRbXhGZFNwR3dBemFvMEJiUzkrRE0xTjNsRXZE?=
 =?utf-8?B?YlVFR3dGYmMrbWM5S1J2MTdVNnRvdW8xaGo3NTB4QlBtbHhDbjVJWVRyRzhZ?=
 =?utf-8?B?ZWFEaVowczJuL1pXZ1pDdzdVcnhOZHhjQmZucG9wcjdDaWUzaGJuNnpKSjNn?=
 =?utf-8?B?Tnc5TUZnWU03S3ZSQlUxVjNLRHRQU0NYTG9ZSytqai9WbXpuZXVnMUpocStr?=
 =?utf-8?B?N2tRcytSYXlQREN1dDZlVnllOG5MQVdkSGdXVW5TMjU2K0o5bHVrTjNOS2Zh?=
 =?utf-8?B?QUZyWGhFSzJRZXhacmpHaFRGV2N0aUFpb3BualBrcGh1WjJvK0U1Vnh3OXlI?=
 =?utf-8?B?czhoUlBmMUJkQWIrRXdUZzQvc05UaENBTmZkL1ByR2ZVQUJSTEovaTJhTzdv?=
 =?utf-8?B?aTY5bDJrWXdhcEV5cmlmRndvSnlCRU03dU1jRjU0NkFzOTZ5MStrZnFzZnU4?=
 =?utf-8?B?VVJld3dYbHJJOU9OZ0lYRTVYT0pWclFJOVFIRXVNcEljYk1BL1kwaXB5RjZ1?=
 =?utf-8?B?TFlBRk5EMkZkd2h6S3FiRy9abE00Z1g4TE05bFp0eFE1R1EyaTJWZ2pmQWpl?=
 =?utf-8?B?L2lXZkFwNEJqQ2c5UzF1eE5zZC9VK2ZLcDRJSUx1R2F4ejlhZXJ6RENaTU55?=
 =?utf-8?B?ak9nT2JDZHZLdXc2a2sxOXdVTVN6aFJ5U2lpSVNpd1FDMVRTT3NvQ25CdnBW?=
 =?utf-8?B?TkdsNytpL2dWYy9BRlZqSm1MTE9pQjFNSVVIK3IyZnIxOVdaV1VxRXhJYlQz?=
 =?utf-8?B?WHExTFVtbUl1ZkEwS1ZMcCt6MUhKYmxKTEhIL3VML1FGVEZ3VS9oVTJONFBE?=
 =?utf-8?B?VHpPYW0yR2V2MjlnMjFRaXp4VndqSVNCZ2tqUzJqSTI2djZ6dWlvNXMvSndx?=
 =?utf-8?B?b042dUtUdy9yRXdtYjI0ZU1nNXEyeHZyWFI1aXlYcFNBT1FIanJvbW43VHVp?=
 =?utf-8?B?ZFQyYjRVcGQxQlMzM3JSZW1QVzJwOE9jVG9WYzA4UWQ3a0hOL04zRlkrUGFl?=
 =?utf-8?B?TjI5cnpQbG96czBtTkdNdXFKcWhxRmpRUUVmaXE5VEVzNk1HSllRYkplVjYx?=
 =?utf-8?B?TW83Yk1vOTBCVEU0SVFIc2VwT0xCb25UVGZZYTY4VGtScFEzWGRqN3grQWRo?=
 =?utf-8?B?bTRXMmk2a1JHekEvNFh3OVVoNklBZWxwcTF6QTg0Z21JKzNvaXMyOEJiM3By?=
 =?utf-8?B?MFRnZ201ODVqa05Veko4ejlaeTFieXhmeEJ5SkVBVm5uUHJxdDYxSjEveEFa?=
 =?utf-8?B?S1J0TlpkdkRaQ0Q1RkszK0FkQUJXWmhLcUs3Ukp3aVB4SmVqYjMxUk5VTXJs?=
 =?utf-8?B?NjZXRmdFRFllTTlaTERWb3pGaVVHY255NXpuME5YRDZJUzVnQTErSUhaL2o4?=
 =?utf-8?B?c1NLOVhBZjVwMXJkakMzRWVzQU1sZjQ2WTd4R0EvMlBBbHhTcVBwSU96ZGlr?=
 =?utf-8?B?QW1vWVFQU0FZT1pGaFhGenIxdjhTbjJSYVMyTE1tY01DUzRMTVR3UWEwN041?=
 =?utf-8?B?MlZ6RWE4aUU1MG5wT3VCNndQeWJTaDlBMzNLWkN2cS9Jd3V2ejhGWTRwZlN2?=
 =?utf-8?B?WDNkc1U0cXBMWVJsWEMvNDBndUU0cFpNVHp1SVl3OFJXN0x0VmdEQ1lVU2lS?=
 =?utf-8?B?bWFnTDQrb21OOVBUZlpvOVVsbDQ4dVd0V2Fsd1lCeFVqcjVLMHNXRkI4MTd2?=
 =?utf-8?B?d0ZQTHREdFR5a3p1ZUw4YVJxVkFBWWZ3ZmE2M3ZvbkhUc0g3SmNXR1NwaWFu?=
 =?utf-8?B?NnVLcHI0QVplVEZFaHZxZlhmUFNWeEM4YmNsSXZuT0FRcnY4NTliQ3Jlc0FI?=
 =?utf-8?B?MGpsWVRwQ2kreDhQM2RrSlJ6YUNMYm5XdHlNNlkwL1NtK2p6eGtlQzNvM2o3?=
 =?utf-8?B?VnAyMm1PVGVVUVVvbWxVRWhZemRzT21sSUlaUGZoaXhNQ3RSNWhiSy8zb1Fl?=
 =?utf-8?B?VThjQU1id3JwK3orSDFnWHBoZ0IvczJFeEFIbE9uNmpNa1pXb204MlN3TmIv?=
 =?utf-8?B?YXN2Y3kyYjU1dVo5L1pwSkM1SnVDUzNScEkvcVlvL2tITCtEZWNBMlV0bFVk?=
 =?utf-8?B?eGJTemNyYmdwVHNRT3Z2cTZ4dFgwMFZ2b2RJTkNPemd0aTQ4SkZnM3N2SnpY?=
 =?utf-8?Q?njOfJ95KPK0BU0T8Yszv6Hc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e324c137-2d3b-4d2f-3666-08d9f1d8ac13
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 05:45:15.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLFb/o/5uBZM9AfwmQeKXTuVtljQEIJHp3ufSImpq0vtCrvE9P9MHN+GstX2pvJxtYVw/bUiMAEf13oYT4m8Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2348
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 20:46, Peter Xu wrote:
...
> I personally used 78/79 col width for a long time for different projects, but
> sure I can adjust my config.  I found that the "official guide" points us to
> 75 instead:
> 
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
> 
>    The body of the explanation, line wrapped at 75 columns, which will be copied
>    to the permanent changelog to describe this patch.
> 
> I'll follow that.
> 

Oh, I'll change to that too, then. Thanks for spotting that.

> [...]
>>> +			if (!should_zap_cows(details))
>>> +				continue;
>>>   			rss[MM_SWAPENTS]--;
>>> -		else if (is_migration_entry(entry)) {
>>
>> Can we put a newline here, and before each "else" block? Because now it
>> is getting very dense, and the visual separation really helps.
> 
> The thing is we don't have a rule to add empty lines here, or do we?  Changing
> it could make it less like what we have had.
> 

I'm not claiming rules or standards, this is just a special case of trying
to make it a little nicer. No big deal either way, of course.


thanks,
-- 
John Hubbard
NVIDIA
