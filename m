Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE8E49F331
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbiA1F5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:57:40 -0500
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:51680
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235697AbiA1F5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:57:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khVusLSqsGhn4+J0tcf+sTgMiO8WRAFLAT7i3c7euve7XIUErgPDSwqZZsM5YET1tFWQ0Wb9plf5USzTut1fD78waY26xRDORS4SZzG8zYxQhDg+/q8IjB1OQNd3s99KQ06IhWBPW5GtNkI1lTb0Gl1vQmIhqylbvJlXnTKPnxHJcTN0lWXoVEmQAIppzoF5BFI/lZHP+6rh/+lyY3OUmNbonz48UQCRAnHku8bbp0gs4pI8691JXlmsOIABGH5bQt2p2WDUCvTw+ImBlngT8c+huVmW4k8r3bIl2e4iW5wdw75b8fEXmdGLnB8dgRB6nqF5OFXzHO19cl6E+WQVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D6pygb953/hAQIcWVwjix61zuelumHdZyc7GrYy608=;
 b=Z94+XjBI94zk3pEiTBDbAwaoiyOAVex1F4NuwqnkDK6g23uyaSV0z2scNApschqZtOfgoT5IF0jU7J3mvqdP50whZT+7D8zjw5K0KWOsOaf5MkEquAMyZt3Pex4kl7ZYxomOS1bIrgmCMKDVTg66/TAboDajQXZUtLsVjTdpPaKPf7qZxKqh8tVGzJ/bd2rDUvh9ciUj0O6/yivM6lCmrcaKQ4CTt9FSNJyaker53bmGlzCU7uyRvWbzlXdHIvjg6T96BUarU2Fl7AJQw+KtID9R10ZEnOadqhnzNDSSfm2FLq+wW8DRhCH7q0QvF0KSFd4yTCm06spcLoI7Ka6wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D6pygb953/hAQIcWVwjix61zuelumHdZyc7GrYy608=;
 b=PtUrN7F77w0zxEkaIDUXinsBJrabTe3vRy7rAmv1SvgHRU7WopVRyTrhZSEC+3VARRHMh8BH06UXU7SGrZwWfxHgDNdlO1dMrPU7zfMr4Jv+R4CsVRu9nEs6V2dJ96Tg4kYD7EyBMXWdbtv/POUyP/V1urWo/HnugukfTCUFbsciPZXVYUTa673S7ib+Bs2cBugAVm4qWfwANtIx3oGXUswsG4IyabwqeRgdh9ZFSGxImm4vrYfF2B1U1QUQAleDVbBKX7UoQtxLZk8oHMkHkxcwYtIwBugmWc4MKHppGzK2LPJxDFzFrLBTWMoikocslCshBhoRmr6psUGU48j3Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3160.namprd12.prod.outlook.com (2603:10b6:a03:132::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Fri, 28 Jan
 2022 05:57:37 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 05:57:37 +0000
Message-ID: <b773a0ab-e226-6acb-eab5-24036b0cf6f4@nvidia.com>
Date:   Thu, 27 Jan 2022 21:57:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: Fix invalid page pointer returned with FOLL_PIN gups
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20220125033700.69705-1-peterx@redhat.com>
 <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
 <20220127004206.GP8034@ziepe.ca> <YfJjhop3senAUjue@xz-m1.local>
 <20220127152538.GQ8034@ziepe.ca> <YfNIjqPpty0YkLJP@xz-m1.local>
 <20220128023127.GR8034@ziepe.ca> <YfNiWHDYH0dtj9rK@xz-m1.local>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YfNiWHDYH0dtj9rK@xz-m1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6886bfdc-12d5-4747-cd13-08d9e22315d8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3160:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3160ADB59AF3525737B0F8D7A8229@BYAPR12MB3160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7mspSG3Y+k68WOj76K1FLp5LewzvfBE3ijHgBhs4tzHQPe7D2zDP2967KRvc8cnT95FY1t4Kn1xTmpGGN5JN1NCCIoejy5p5Wvo5tswkKnGE1PlOZt9px4qzGLV/hOHTiyNdhXwNY0SUxEOndnoNP6O9zO8Uvh9lsErigXgO3LGnrcYA5O7Ay9LRJue5Sv3muCsuxH7jIuwIxNsqOXiVpa3vvitzSd3cDnZ8+TVEJgqXSRg7NQHKCULGkcz6v6Cz5h4+r9IDD4LyJGbVNIXeogp16RLZDuXkg1Ya8JDe0b3V34cNmo0YX/valmmEIrzSu9iJ0tA477sEAOawQApeC4I5BGpOlo1u40LmhH51UnHMi7ihlBvQ0Od50mG93RJqcVfGGVu41UaqqMkcPUPrpa1M5FtIv9trsdCQNbQHwrbiNGIvUUDvZtxQF8R0k0a3A54olyBG5IH6ZjZKG9vu+Ml4KIh+rPlfD9apG/eVF0TTcGvnErEQw9NtNqqs5YXxB3mTEfNXyb1FevPAJX+Fc/ADbMBvoJ9Fo/IsMnOQ827UsB6SdVX7Ozk8UCiOTouZC/iKubv8QQyNa4VV+7oeZpzzCUd+zl/1wKHpEOOSGTQkSU3riK8uO7o86ObIfu3rvmccdC5vLbknL1Rg5x4XEhYAeYkoGT4+RElWy35xvWaHLYp25QGik+rmxwH4M14N24xgHqiv4hiBmSJ+KFm9OxwlWmkD8nj/dC3My179Dbjb8IZiWwfE/yGTRJDboVb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(2906002)(86362001)(36756003)(53546011)(38100700002)(5660300002)(6666004)(6486002)(83380400001)(4744005)(508600001)(31696002)(110136005)(66556008)(66476007)(8676002)(4326008)(6506007)(8936002)(316002)(6512007)(7416002)(2616005)(186003)(66946007)(26005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ZvMXpWMnVkY01jd1htdHlvVUEyUjV5Yi9jRXBNRHAzbTZrNFltanYvSkM5?=
 =?utf-8?B?UG9TYzQxSGUyUmRIZUtaKzFLdkgwNE9FUG9vMXgyZWtIYUVJSERTamljVVlX?=
 =?utf-8?B?cjA4akZZcXVwWUhpN3B4eitzWkJQMlN0emM5NVVDaVI0MEFyOVkva2RPb29p?=
 =?utf-8?B?K0t6VW9sUERIRWZKKzZxWVo2ZVJyeW5QRHRVeWtlWTUxVUtKSHE3UGNVRk9V?=
 =?utf-8?B?ZlJUMk9WbVprcHdIWFdwSFMwN3hlUThXTjhVdVhxbjFaYmRkMkZ6WFlCSExz?=
 =?utf-8?B?NDN6RFIyS1U2WlozZTY1VjUxR1JkSEZxQTZVZUR5NEFHVVhJRVZQekRyc08y?=
 =?utf-8?B?T1I5d2lyK2krSllPM2dTUG9NdzdEeFgxK01hMUNiWjdIbyt4K2JSc3QzOW9B?=
 =?utf-8?B?b2N2SnJGUlNUTTV0dEdnMEp0SnRlMWIyN04vSkhCanBTM0hXS2o4bWRlSzZq?=
 =?utf-8?B?MTY2WnQ1dlQyM2FnbGduQkg4V215QzdkMkQvUmw4UUhMOE96MFl6NlRxQ2RO?=
 =?utf-8?B?U2V5S2V5RHk5dDlPZUZxZG9IOVc5eHRNelJGTGpmOVlVQ3VTWE9WNC9vWm1m?=
 =?utf-8?B?V09QblZtaE1aU0thaGt2b0lYYTBWbGJ2UWk5QlpGRFZSM2tjV0tTdTRrV2VC?=
 =?utf-8?B?UHp1WnlTSmR1UTdyV25YdjJsU3ZrMG5oMWM1eFNoZlFNa3l0ODBPckZkRWxq?=
 =?utf-8?B?aUorTktsYWxMY0ZGRm5lekYyWVpkeG8rUFNqazgveWVZRXZSSzBUanlFei9u?=
 =?utf-8?B?Y3pxWitxdWtINy91YVFkNUIvRXNyb0FibGRJZlVTbStDaURKdWFPUm4zdmMz?=
 =?utf-8?B?UFUvMXIrTm05SWJBYUNyeGloajhENmFTU3RiTlJlY1o2MzhaN1VmeDkzWVlx?=
 =?utf-8?B?KzJFNXo5OEJBTmJVQThqd2pqTnRUUE1jZHdtOTdoclVyOG9UdE1LanExamQv?=
 =?utf-8?B?WVJZSE1RTi9FTi91SDdXWE1iQ1dyWlk0Ulh3d2ZKQW5reHNaN1NvT2RKWWVX?=
 =?utf-8?B?T01hNmhXN1lHRVNwWXFCK2pNZ1VFMmFjVTBtV1YrNkFLM2dVcjRNR1VDNG5R?=
 =?utf-8?B?aXVBM0xNMjl6U1l1cUxWTUtjQ2JJMm1JMkZMTUZUYUpJSzAyQTVjc1FTSTFq?=
 =?utf-8?B?d2plOE85TUlIQ294SmhmUGoyejVWTm4wbEdxZnFHclZrVTBsYitWQ3lCdUVR?=
 =?utf-8?B?VTN3Z0ZqdWEyc2dWMGZadC9Ud3BUTUJQVG95T3BSK21vNEg3YnZFNXpIU3FN?=
 =?utf-8?B?ckRVOHVTK1IzM2hvSnRGV0tsVkVuMy93WHdRVlpsdWVYb2ViV1lKWHloMDNU?=
 =?utf-8?B?cEdOYitqbGlrZWdmczdXamtGNm9XeGRZcEFMdDVodzVVa0YySlZlTDM2ajJn?=
 =?utf-8?B?VDFaV256TzdMODVmYXNpR1JkRWFxQ0I3OTVrS2kwM3BZbHZMVGxha3V2bWR1?=
 =?utf-8?B?MS9oakFnU0J2THc5RHU4Z1dFaWlNMGlGcU9FR09VM3dVK0xsVUZZRDc3YTRn?=
 =?utf-8?B?eE5IN0dhczZBUitMV1dYZ1lmYVNJNHRWc1g3RWRLcEpZK2tUd3hOdHk0MUo1?=
 =?utf-8?B?bFIvSE9kbHdlY2hZZEJwL29BbG5SRXZXbFl5V1llUG94bFRpWmtOOTlWUkx5?=
 =?utf-8?B?STFaQ25id1hOOUdNSnhnRTB2ZnBPaGlZMUNnT1lVTEdlQWk0a0dYVXBBK2dV?=
 =?utf-8?B?U2VwbUk3UjQzSnk5R0FrcUhXYUpCN2gwQk4zWkpEUEdMYy9JREJZNjZ6VEs0?=
 =?utf-8?B?UEFLOGFZVGljSGlnSS9zMTZrYjNmRGZ3bVYxZEhycWk0Q3c2ck4rNEtSUDZu?=
 =?utf-8?B?Q3BPMEV1c01zb3dUbHdmUkdDVUVxV2dLVlNyc01KSTJBWGVRWmJWNy8vcW5L?=
 =?utf-8?B?VCs4ZE1ZWUZBQmlTVnhJR0MvaWMrbzlxNFR0YThKU0hHNUM4Y2dOR3hmVlJR?=
 =?utf-8?B?VnU4bWR6SlYycUl3QlpFelRqUG0rUHhCOGFURjRCcVQ4RlZJNjE5SDlicTV3?=
 =?utf-8?B?MEFhL0ZxRXhPMXI5eVVjeDNsVENFM2tja00wQndwVXh4c3RhQ2NySXFDYTIy?=
 =?utf-8?B?WlRKTUlWVUdiYVNkVmF0Sk15YXVPMXBLeWtxWHVvOWtUOERuTXRHZTYycEd4?=
 =?utf-8?B?VEhEbkozT3VZSmg2TWtCb2FBVHhRbjlsaVFKRGRYZ254VnNnWXJtN0haK3pN?=
 =?utf-8?Q?9j09BKwhWxY7J8M2OaDoLpA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6886bfdc-12d5-4747-cd13-08d9e22315d8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 05:57:36.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjXhotrKpUjPzYkBr1TNJyZyuUu69WtSnCnnCgd3z/qRX5i7Jepl7fLKu0V8+bdblZDpChb0acgOn8woSp9pJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3160
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 19:26, Peter Xu wrote:
...
> I see that both you and John has a strong preference on at least the
> WARN_ON_ONCE() in the patch.
> 
> Do you think it's okay I repost with only the one-liner fix, which will keep
> the Fixes but drop the WARN_ON_ONCE?  Then we can leave the rest as follow up.
> 

I think that's OK with me, anyway. You'll recall that I initially requested
that you split this into two patches, after all.

Would you like me to post a follow-up that does the refactoring that Jason
and I are requesting? I see that we have some fundamental differences in
opinion about how this should be done, so rather than drive you crazy with
debating, maybe that would be smoother?  :)


thanks,
-- 
John Hubbard
NVIDIA
