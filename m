Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2024B16DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbiBJUUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:20:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiBJUUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:20:52 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD27273F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:20:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoZbtHfo0jRdSwsK5MY1C/ZbovZL3reH64CGFBRu0ThZKxjKD0S0jRPYjievv3g2QIBs8JCluNVfhW+0dQqcq91B3IvBWWm7z0OCcWlg5UWpkAKYYf72apXjMcdjWACcZnO2q6/XDcBaLjUixXjUjte8OdSUW9S/nL232qMgvg1T7G8KFD16Ja4HWxt8mAuVKSrGOP392hoTFFBO/gIXSiZO1GB6AZH8WczOx2GFXsUS+zj/2O3VklfPma23QrCLCBIc06LGopCQbnzGOGoYg0PrNKnBVgqxHAVqXD7d8m/TQ9X3h3Ldm6gIchjv73m9TThQ18baPEMR91UYOCIMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAgkbzPsVwy2/0zwzi3v6Yo5lFMD86v7rDSm7IT8urU=;
 b=cqRPGHKx3MhIKvR01wA6WKGihgUAb1Wq42pKS5tHDPFKdSkK0z96C2AzuMSaKMfuCdB8POrsXylMSZsfeNx4giWeOsJFaaKljNxkbP2DxAUh4n72/Ys5oiTaU0pgbhrGtwuDu0OXAFNKuzNw5hwjeVgZLWkRPnp6Fmo2XtU7+SzFy42d3bXWCysBOfs98zs3oZwA6RdDdLXInqh3OAuphhwEbHTwZu1lyHfxVJALmbNMfxdY329dxPjFgbBVq9P4o/XY4D/7MoYhbgn3heuy80Mov+lgiQrZ61yhQWpe4SzTYEb7WCzLFKNsaFKq12oq5W7+pz0QE2ZYMNSx7H5SHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAgkbzPsVwy2/0zwzi3v6Yo5lFMD86v7rDSm7IT8urU=;
 b=WtUY7z7A+X/Q12atiih5DCp+S/gYdJ0K785M0xKKz9EtWPWpxodFD7DdU+6Pj7VTKhHp5DKY05uHPY64CaiC8VwLnvvuVxfTd3TSbeY0Qnlu+Txwz7wnNkgMvuVhWrw4ggVPVR+Mkihe4vQzmO0UNmW0dtfT7R8uB9+P7ow9A8vPSGMzC8VwrcKnA0SOF0zZKo2LUJKpGE17LibAjdUnxNw/k3Qy0lCNjwuOlRjuOPImZCXEwBK34Z0YGeSzAHUcpmlM+x1+PCjtSB9GEdbbYxcqavbiKV07SFHkzyCUdX0PDgCtDb55oI4NlmBUeManU0RMyT1m6RzFhpsE5vYi9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3447.namprd12.prod.outlook.com (2603:10b6:a03:a9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 20:20:49 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%5]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 20:20:49 +0000
Message-ID: <f79a2d94-9877-90aa-927c-d765fbdda7b2@nvidia.com>
Date:   Thu, 10 Feb 2022 12:20:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: pin_user_pages supports NULL pages arguments?
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <YgVkxwYtLov6Z5WZ@google.com>
 <7b19b521-01cf-fafb-e616-21deced2cd5b@nvidia.com>
 <YgVntJO3E+8ILRDV@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YgVntJO3E+8ILRDV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::14) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4a549da-62d7-4617-9acb-08d9ecd2d3bf
X-MS-TrafficTypeDiagnostic: BYAPR12MB3447:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB34473DA5674694C879F5B45EA82F9@BYAPR12MB3447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5hhRpQdPEVu4i4z6LV0odwg+sdyysP6GJtQvbeGf+Y7PtHw8PfnTBIeNrrCyHtoOntZkXo0A7x6uchP5YrExChoAakdkrfhRjVRmdG9lTLcsJ23/+w+ICgzYcgcfRnU/CSQhLDDYE3NbbezlIzK/wDjXrvr3X+GHNGH33Mg4XIqClZC56peXrtWZF2anctj196Dc4XjCZVXDA4+S9508HSZ4CJZOG8wW04jXCrZaZnvD5a2ZGlKU22i1ZVICEh01XUVZ1bGAutaoSfjt1Dna6j86/NZoJOKVtAeZUYc+pxcoVslpzz10c9dN9+VGlsGO36lYjvq2igjzvvHpyZ8pXBQ4f7z8DrVqXL/vLXbxrg6Vuu48anvfxXFlcdhoOHLt6S53YPsVbcHQa5eQJUoiYONWlK6KtCeKjmy4eitijIm/yaueemnXv8M0XxCX8Y0TbQvUUGSxYWF7hCIWNnE7uWjEcf+OlcgA+Vf7Qr4kKANmxxEhYuE6Q0Hl7vHwnHfXFXIrMzo/AMLkj4LcOvcRvOPP3cL+Csj3DjcJ40gmrtE3ZxO5Sb7Fy6/r4oieGfjwKqmY2yPhmLzBHV85pJIPFdF+b2tERQBHcpTnIdJJAnhpoVhyersoCumOaLCD61uZyMS3dSGuJjXY9xFw/INdMToVoDdKJl/sS62RcDi3RjduOznWkscJcY9EItL6zcJ0tI2wDzSZeL9gYlXXIm4BsNUsn31CeQgMLdxis+D/os=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(5660300002)(26005)(38100700002)(83380400001)(2906002)(36756003)(6506007)(31696002)(66556008)(66946007)(66476007)(508600001)(6916009)(316002)(6486002)(53546011)(31686004)(8936002)(86362001)(54906003)(8676002)(6512007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDZiWTlkajVEOHRvRVV3WWo0K2NWZWx5dGF3dmM5aE5mNk1kQnJ0RU83TVdv?=
 =?utf-8?B?Qzh2dGlFVzhNNlpHRUJ5QTJ1UGh3T2JiOHY2OWpXSkViZENUOW4yclpKbTNN?=
 =?utf-8?B?aDBCbzhLc01RUDNmU294NXh5THVxNGR0dmtYSldzeHNlQXJUU0MwaWMvOXhr?=
 =?utf-8?B?VnJpUnZYdzVMejNjWGJRZkx0YzVGaHlIN3dFV3Q0TFJiZU9mU1RQZ24yRW5q?=
 =?utf-8?B?ZTRxNlRKU2lxL3JZVVhyd1piTHRTWEFKOGlGdm9BNjd2MUZSSzdsSlEyUmoy?=
 =?utf-8?B?NkhQcW5VSW95dlhpM2pCVm5udkpxN3FHdzVFQjFwR1R6ZDJ1aGFyN0xCSDk4?=
 =?utf-8?B?TWdNblVlSm1sS2tuZVRETnJnRGh5WFlqck5QYVA4U2YwZUFsKytIdStxZDNK?=
 =?utf-8?B?U2QwS1pFVlc2Qk5jZnlvOUdCaWhVSy9qRkdIQ2NoTHN6RmVmZCtiOW9kQ0ZO?=
 =?utf-8?B?NFlleXlBM29YdUNYSHRtdW9uNTNGVUM4amJDVlJUMFMyVWNPQk1MZDdOdWl5?=
 =?utf-8?B?QjVBOHNpOEEzM0EwZ09EUDFFbmpobTZOTWVGTUV6VGNqa0RnWDV4eE9WTFNT?=
 =?utf-8?B?RSs0WUZTYTc3RS9PK3lrUDlTVlFXMGo1TXIrVjBYamJLdG1WYngvZk4wd3pN?=
 =?utf-8?B?eDhHR2VObVFwSlJGTmc4MG9NUURON0VremVUSXdvRWxNQkJJc1krSXdpZE1M?=
 =?utf-8?B?eElDVkdzRExCNCtiRTBTVk5GNG1UV210NDV3L2p0UE5Qb2NzTEwzc3dLQmpq?=
 =?utf-8?B?aEpjaTNjUlhRY1JNZVRtL0lTR1NKZmpZZjF5azMydE5UNVpsVjYyYWtFME14?=
 =?utf-8?B?cHhSeXJwU2Y0QXFiSTZWdVpPT1A4VkFRenJlanJzUzV3NjdUTnZIa3B3L2hN?=
 =?utf-8?B?M09NS0FtYXFNSy9XcXkzaTd5NWRKTmJxamIyWEJRak5iYXczNWxJOHc0T0pU?=
 =?utf-8?B?S3dTTVpIZ05OOTNWQkhKV0NTSUk1cGZXRzRSYUZMNHZRcnhFZkVvYmM5eHg1?=
 =?utf-8?B?aVR3cUUvNWRqSnVNN09xcGpQVk9DcnNmbEx3WkJpME14VlpyNkVMZm8xdjZz?=
 =?utf-8?B?dGZDdnEwa0IvRFFXamhNSEdJbVF0dm5NbS9MK2p5Skp0U3J0dDVrN3IreFEw?=
 =?utf-8?B?ZW5wRERPTU1LeUpLelVoeGtyWHZtQzFpSHhmSDExWE8rc00zdDBYZ2dvQnhs?=
 =?utf-8?B?NTBxZno5VnRYYWFzbm9CZG0xNnJlZXJyNXZ6YXRrYjBGVXZuZVIyeWlKWDY4?=
 =?utf-8?B?UTgzV1RBZzBHTVlSUU5sQk1KQnNLbEFrZHh5TUc5M1FYeVlGWFdiYkVvbE01?=
 =?utf-8?B?dm5EbUtvQzM2NEN4bEsvdXFwcVR3dDJhM2NYR2kzbk9qMFBJMWJZTHIrL01k?=
 =?utf-8?B?R2JHSG10dWdlK0hxbzZOb0t2MGRJdmM2ZUxtM2w1K2pMVkdiYjhBYzVZNlU4?=
 =?utf-8?B?bDJJWU5rWjhvK21iNEllRERqWjFZb01xZ3hQQXhWKytxNk00RmtLczJkSmNO?=
 =?utf-8?B?UUFVck1zZzJUa2YxckhGdnlDRlVQV09oZW5UaVVqTDZPS1NLZzBNVFhWeW1L?=
 =?utf-8?B?QURHNWRGN3I5Y1g2dW16MVN1RHh4c3gybVpBSTFrWXFieFhJUGhQY005UlND?=
 =?utf-8?B?b3JOcHNmdXNxU3BiRXFreVhQWStHTTFNYVNQdXlQbXJ6Q2Nhb0YwSklHc3Ev?=
 =?utf-8?B?UGV3TW1WRlR0Y00vOE5ZTTBmUVN6K29FMmVVQXRRUElzMkRlZjJ1TFgxTE1W?=
 =?utf-8?B?VnFySlNWRUEvSmRBU004SmNZRkhoMG9RMWFYeTZiUCs3Z3owbUU4YkJ4VWp5?=
 =?utf-8?B?QnFXSXlSK2pIcHR4d3AxOUhrMHhjMTZBdDVDQTJ4RVdoWWhjREd1TFN5Q2g2?=
 =?utf-8?B?SzJOb3JCM1Y1YVhOZnl1WnZMdTgvRkd5R2JDM252ZWpDQStVTDJWTXdKdjdL?=
 =?utf-8?B?MnhQMktmbHpGRjVPRm5yZnQwR1ZJK1E0VHFyZUZBRWtJQ25ZZWdUUTl3Nk9m?=
 =?utf-8?B?SG54T0FiVWppMm5OT3R4dVVaZ0xobWNDQnYwTnBDQTI5dCtRUWxaUkNWdzlr?=
 =?utf-8?B?dzB3NDdFRHB0dHM2bFBFN2wweGgzRS91OTYrRzl6a0ltTDhkSDZWWVFGbjV2?=
 =?utf-8?B?dXFMd0FGKzhvek1VcXRENlYzZFNGb1VtOFgrVTdzTXphbGJDRDRuUktvNnkv?=
 =?utf-8?Q?LdPJEefhiahnCMndi8XjlrI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a549da-62d7-4617-9acb-08d9ecd2d3bf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 20:20:49.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wcv6nkf2QNjBne2cKEpKoILU54tgFT+nDW9byh/nYt9h/sfUGUuoFFalB4jqE58o/I0eqoerk5VNzk3INbecuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3447
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 11:29, Minchan Kim wrote:
> On Thu, Feb 10, 2022 at 11:20:31AM -0800, John Hubbard wrote:
>> On 2/10/22 11:17, Minchan Kim wrote:
>>>    * pin_user_pages() - pin user pages in memory for use by other devices
>>>    < snip >
>>>    * @pages:      array that receives pointers to the pages pinned.
>>>    *              Should be at least nr_pages long. Or NULL, if caller
>>>    *              only intends to ensure the pages are faulted in.
>>>
>>> pin_user_pages(,, pages = NULL, );
>>>     gup_flags |= FOLL_PIN
>>>     __get_user_pages_locked
>>>       __get_user_pages
>>>         ..
>>>         VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
>>
>> Only FOLL_GET or FOLL_PIN are supposed to fill in the **pages array. So
>> if a caller passes a null **pages arg, then that caller must not also
>> set FOLL_GET or FOLL_PIN. That's what the VM_BUG_ON() is expressing.
> 
> Yub, but pin_user_pages adds FOLL_PIN unconditinally and the comments
> says it supports NUU pages argument. Isn't it conflict?
>

Oh right, that is a conflict. The documentation should *not* say that a
NULL **pages arg is supported. Because the whole point of the FOLL_PIN
APIs is to actually pin struct pages. The NULL cases are only useful for
get_user_pages*().

So removing that last sentence is appropriate, plus also looking around
for similar documentation claims, including in pin_user_pages.rst. I
don't see anything from a very quick scan, though.

Sending out a fix will also trigger the observation that both the
kerneldoc headers mm/gup.c, and the writings in pin_user_pages.rst,
could use some updating. However, it is also true that this can be
reasonably treated as a documentation bug fix, and therefore allowed to
be limited to just this change.

Were you going to send out a formal patch? If not, I can include it in
an upcoming gup series, with your Reported-by tag. Up to you.


>>
>> Perhaps that should be part of the documentation. It sort of is already,
>> for get_user_pages*().
> 
> I expected it was just copied from get_user_pages.

Yes it was.

thanks,
-- 
John Hubbard
NVIDIA
