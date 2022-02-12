Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7C4B3201
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 01:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354394AbiBLAab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 19:30:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiBLAaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:30:30 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B2D7F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:30:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFYKpMLHd6x2qFjlayDViZxgEAPTferakBgkAj13E2NPOBidCYJqZ0PPhkV/gY8w2EPW//KdU1taRxkPNogamfqJ8sHeoL/CtttkYnPudDKEXtjd5RV5jrpvf/2skh2O9AcVTSRlf4dhgcfy33wYKXfq2VDrZlMsbaa4kLO07z9jSx6bCm1Vn6asZgIqwXfr7fdNhSu+F14/FFb7ze8HtwwWWJHq1HeZ8k8a3h6O0DXfLrawW5FTJ0F3lu1CYwtY18gixbWQPNt6iaqzJ1mSQnGr9LiIttQlEyYQrpdvOXohXaHIwXhcbePrDWKi1CG3tWZs74fczcnTczQrvSNrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FF7QGMpMZGLcqBTeDjBJ3kBeh8lx8Z5hNuNEKlIqiOQ=;
 b=czvSH85zcviZgdrnZk7yMw2PL4Doh19llNtVPqU3suULSewSjUpAOjtKmtmZe8jEbZLYOREdJXO+spIC5AAifE5Pk/yLExrPfDDF86P8UCQYMXp1ND70lQlQdSmnlL+D4ONlyhdlrfCNAigsabFKtsSm6aG8dgIFLnCBtxQa10mjTRY44DXRe5wNORRr+6Bs5v7kB42US/Tfk9deV5bq8i5H1ovJYNLP4oWw6K3dwt69ogm0Ot0AiIzHxizLq8ajL6Sqr9arTfBhaocQPdRKzr0R7YWtRC3iYiJJXEedsK1+763CW1hpd5B+8xPmJ2KLGAfdQy52An+ngePMnXmvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FF7QGMpMZGLcqBTeDjBJ3kBeh8lx8Z5hNuNEKlIqiOQ=;
 b=deT2GRSUdE/tbaktvs2TyMxkC7PO0iHcDgF3yR9APO062djjS1qDlaNqp0V/YbdLKWtYp+Ga6rIpfEURWeHCOSTzjlpi5keQJ3lVqYNj21Hs08YFNKoOpsGIKcqlJY3n2VjiyzFYOkLghSD83+2O6n7pGEHuTCmsHjpipAjkSEBdxxMESrOJb6vqIWVJyB3BvC7xLj6sCe8aM6Muqy+eK8arUR9QByyvr+qlf1bIi8FJkHHMAsZD4wddDFqI6YwxKVCLHgTFs47C6ub6U873xEZIGtX5w/f5ySmdQgQF/bQzosXkGhYPKDBY0fcnPvUewLgGKfUUFMMj7lV2QmTFbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 12 Feb
 2022 00:30:24 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%5]) with mapi id 15.20.4975.014; Sat, 12 Feb 2022
 00:30:24 +0000
Message-ID: <9f03bc45-5652-6fa2-72de-6acc3dd39028@nvidia.com>
Date:   Fri, 11 Feb 2022 16:30:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v5 0/5] mm/gup: some cleanups
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20220207062213.235127-1-jhubbard@nvidia.com>
 <6712a07b-d1ac-520d-8bbb-7539476ec679@nvidia.com>
 <20220211162734.bfd21e10ff9bb231274e39f8@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220211162734.bfd21e10ff9bb231274e39f8@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::13) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c4ae0f9-bb23-4a98-d7a0-08d9edbedc18
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53742A539E837B010F03766AA8319@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXVMMBqJVuXwSYjRyv24VSNHXKifmd7U3NnYCyPSTU28rpwtsfk9BhKvY6P7ixNphm/XTCSEJHV/1doqyL5G/7cIAkH+un7sDyiWK6xgvc9B+3s3lbytcAbI3mQoYQgB5zjC/oeVKwhrNvJ7bzggx5BPbu0pcAV4spgJPogVCalrc6U9kk/WxAfUwVbwGoumVxL4dP5RGA/tYOxkgnRDyVDdgSX3yX7r+IfC5QGU1OVMrNXizcYy6/q0G7ISVTqW0jaNd7JWGDXRG+AaYx9VEPUXlIr5em+h9EVH3JF6xePnwepo9LNUbXxp3bCCezyTjLeLd9r/59b+/aiGX/unAl5/xsOz+XaL7pfaT/M32sQve1IharSQpK9dgJhp5HjT9eY2c1v/aD6pyKUFZZuFdFKbUYzsTad1sGva/5p2EAUc2NOG+BsZKnoLCyk6lgS2jiC9FZizwqZ3JXZH1FqD6T1hJVMxoaTVCbf6P5Dp8pZLh63DkZcJOnzMak/4vuDZn3+gkun5NNjD3kj6zhchMsuy2K5EO5LvY9AVvH4fyDxD058ZSQ1JY/2nkdoiLt1gzaF9oNPzZ5AvXVppasY/fqF2VbG4er/9lHdrEVC0wSLGDuUdeQoASNBtUHn2yKnVDaaImzaN09GWGt41TTO33OhDZif6PtCyDfODDY3Ue/wmE4F5L1Ugd11c5bRnrYdVcRTQbxtR9GsCVEwgkfOY5H8lTo60A+nUjWRrtA+LlwXRTUypsqyzPB8IA0w1UOoX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(8936002)(508600001)(66556008)(5660300002)(66476007)(66946007)(4326008)(4744005)(6916009)(54906003)(53546011)(7416002)(6506007)(38100700002)(31696002)(316002)(2906002)(31686004)(36756003)(186003)(6486002)(6512007)(86362001)(26005)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5zM2ZBV3NNTlJHT1lJNjM4d28xandFKzRsVWhBc1dObER0anArZ0tGZytS?=
 =?utf-8?B?SjQwTkRsUW9tOEZld3pFVlpvV0l3dGJ0Nnppdm5hVm83dlJpdGtpYmVCY2tV?=
 =?utf-8?B?dlpNTFZMLysyc2FzcmlVVHBjRGNuWE5uRFRhKzVRQVNadGlKYmc4K3NGMTJ3?=
 =?utf-8?B?VjNGaHhqQ1VPWGU4dmhrMW5obmh1UnYrbFdmaGx1dDU3ODB2MjFQbkFlSGpo?=
 =?utf-8?B?YXYvdkpWY1VQZkJVVVNrV3VpTGtnRXEzVTdJWWFocGpvSVNta0EwQjJhckk3?=
 =?utf-8?B?TnBWZ3pXNjFWWUpxemNLWmpBb2pSL0RxR2l3SWxBdENBUTZZMTlVVUpmUDNz?=
 =?utf-8?B?ZGRYY1N2U1VIaElXMDVXSmh3QnBXelJla3RzSDZnK1FsN0tEMVZsQ25aejFZ?=
 =?utf-8?B?Y3dwQUlTdWhkRVJiV0U4SU5TK3ZJUWpIWi9uWDlpeTcyanFaMlE4S0xFWE9l?=
 =?utf-8?B?eFFFbGQ0NVpNWVVvNG15ZVJjTUtyZWh2Z2lWUFdyODdvc3p6cHBlWEtpQ1Nh?=
 =?utf-8?B?YmRQT2xRam5IMTZRTTV0amVCYythd3JXVC9jT1ZUaDhiVzc0Sjg4V0NPNExz?=
 =?utf-8?B?dkJ4Q0NQZXJCQ09DaFl2SlFMRWtpQ25xN0N5Q25OZVkyNnBTNktFTFlCL3BO?=
 =?utf-8?B?T1ZZRWZRd2RJdkdRMmk0VG16S2ROaGpnWE9mbm9reXRrS3Q1ZHdCUVdzdUlq?=
 =?utf-8?B?a1MyZjQ1VzQ3cUxyemhRSCtnWTliWGdBS0hkWXoxeU9VUEY1S1NnMTkrWFFy?=
 =?utf-8?B?MEYrQUdzbHJ4Nlc1Z1lXWU5LZ1puRUhpL2lwWXM1T005ZXFGc2pXY0Y3T0t4?=
 =?utf-8?B?R1ptWm5OclFadlQ5cVFGa1pLSVdvQjlmcjJlb3o0djJDY0M3bDFwVUpmUEFz?=
 =?utf-8?B?NXRMSE9SZUZhQU5BSDZySEh5SmRMaEEwS3ozMHN2cmltU2pwZmtKYVBGNGdW?=
 =?utf-8?B?Y0NRcVc0bngrTlNZeC9ZakNCcTVEMzYvNkxVY0tiaGtOczBKMWRlLzNQZXJ5?=
 =?utf-8?B?K2lLd2JWdzZOMmM5RFJDVjNTRTVxcUhHeTZzTXNrOHhFbXNuczljaHZMWjBo?=
 =?utf-8?B?MkhTbzhoVW9oUWc5VXdEQ2J4RXI3TCtidFRmZXE5aWxDSW8xOFBIUlRlcWZW?=
 =?utf-8?B?djNpTDFOUzZJRE0vekFINXcvYnF5aDVYcldlamFlZGtySUlQRzA3bGFjYURJ?=
 =?utf-8?B?OW1RS0wyUUtKczl0dE1DSHZwUDNDUFYxdmFEZktlV3gzRnpnRlo3VzhQbENV?=
 =?utf-8?B?amx2a214Vm8wMkNGSmt0MWR0ZFhHbXRTQ0o4c2tTaHdNblZDZHJCNGg4bGla?=
 =?utf-8?B?ellpb2p2amo1WVVQTUlBUDRMeUpGSGEwMXI2Qm4vOGZxcSswM0FDSnhVTXVm?=
 =?utf-8?B?YnJodndSY3RteEsyODVhcnVXdUo0RDA0WTNpUlM1RFk2TjB4ZUt1TkorRmdp?=
 =?utf-8?B?NGdGUlZRUk1VQWErNVFOVmM4dHdibU56RFZOUi9oVy9WSVhTcGdDQ1FUSmVT?=
 =?utf-8?B?a1c3SjRJa1RUUndkeVdPcFNYR2xxSlVzbHpFVyt6Y05sRXhRQmJLOVpNYzNP?=
 =?utf-8?B?eHIrVnlyZ3JGNXE4L3VaUkM0MEkwMk5lR1JGeWR6ck9SVGx1RmRkeUIzdXdF?=
 =?utf-8?B?UWd2dlZPcTg1bnFhdzRPeDZESHBLSVFiRUJablB5TlFxU1Z1RUVTWHBBcGJ2?=
 =?utf-8?B?dUI0SkkyYXlENjdmN0k4RDc0T25sK0xZMXNITXZIWVN6Z1pHeW8wazY0U1RY?=
 =?utf-8?B?ajU3dkdDbS8waytGVUdhZ244VW1zVnZubjYxMXVJa3VxRSs0a2NKdFZNeUZI?=
 =?utf-8?B?cDRETG5WYzk2ZVNPWWNGYjRpcW9za3FBZmJiaHM0ZGhqOU9WcnJ2bUtwYWJI?=
 =?utf-8?B?akZVN0RxSndWSHN6WnQyVEpJZk5KZ3NLRy9vemcweGdjWHMxQjhEcWRzUUxB?=
 =?utf-8?B?MkxsUU9VRnI0dHAwcDRFV0JCRE1yQ2pIa3h1MEZ6V2FTZ1lmeHRNRWJCWCtt?=
 =?utf-8?B?VFBxeVNqYXRzcjJSQlZabmtJbnN2b2gweGdRZUlyQWRtVVBPMmZET3YvOGhP?=
 =?utf-8?B?dmMvL2hlL0VpSWJTVHc3aU1lektzcG9hUEpxZm9ROHJ2MEhaNjlQYVN3TTJH?=
 =?utf-8?B?K2RQbjhZOWpPOHA1SFR6cC8wdnhKRlFzMUpsa0paYTJJc0RyNk9udHhCT0JO?=
 =?utf-8?Q?VHC/rEdE/8rphnt/LZzDfzw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4ae0f9-bb23-4a98-d7a0-08d9edbedc18
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 00:30:24.2757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sA8IIzsIjIZbIyrGUiOdxmXF3d5oS9vlbsB7ZB0D5JzkWzTbCHD077Ix18VAFvNnrjP61pjiAAz2hjuXksXYSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
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

On 2/11/22 16:27, Andrew Morton wrote:
...
>> Hi Andrew,
>>
>> Is this OK to put in mmotm yet? All the patches here have been reviewed.
>> And this small series also does not conflict with Willy's "[PATCH 00/75]
>> MM folio patches for 5.18" series.
> 
> The v4 series is is -mm.  Shall update to v5 soon...

Oh, sorry for the noise, then. Somehow I did not see the usual notification
emails this time around, I'm not sure what happened there.

thanks,
-- 
John Hubbard
NVIDIA
