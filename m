Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F431591863
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 04:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbiHMCiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 22:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMCiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 22:38:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E47B7B9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 19:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M02Hd47OGUrdegrXFOAwgvikNvNV7CmTbcW9CELKAY49u85aTPhq8Q29KLN3tySijoZBLDFGUGpTIJKfxwvVMoxhRompnZx7AjTvbDTYCHdDTb3k+5CLtZcmwtOJIiYV17Gpa71nekLYPI5XrA0YLYZDWPcEBRhi5RxtXzxTEIWcmD5vFCBHqSM7WY3mJ0cwGPBsm/InxEaCRY8y5UKfr0djpLStAuBQNAEkxy5jLLuX+RwBjOGwLxy9zIVuhVmCkuV/EvT9zwUzNslZs1ePywSWSb5JyWCJs3VzoIlWFGYAL0Ukbxp2iGY+EUFdc9QDIKcpXBBdpLon1uW+P3vAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTv6UmJg/inMKKszgVdvZmr+HxsKc0+dXgG+pV8PjUs=;
 b=B3JteBw6XGLuuVpuLQMCVla0Al/HKP6BpvVsWJgQhicy/fPsFuPjBpSpvI/3uaSB8QLwUKQTIqnCG+eGhACv2b2WRwuN+8gJlaEcelj83lbRmf56bnZKqi3AxP2rfcKC9fnS+9lT+ZjBofzKpw1bHA4GEdjMclduijhZXZiLZzNg9b5h3CYOqKkcExLM1hpBw7dhdU/P76AO31wm4sWPRC5ZM4Hq/ctVbtD7/n0u8q+fvYNYDO+uuixdtQz9ukT5sZBQdBZ40iAUAuRYf+/0kJoWCCZhbS5R65k3sllKYQ/XOw7pe6su/5HtHKEJJZw1owTF1S/rMl8tHtFdLtZtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTv6UmJg/inMKKszgVdvZmr+HxsKc0+dXgG+pV8PjUs=;
 b=bVUbpVSXC0eBlr4SJkLjJoSx1kb4RQKFsbqR9omDUQfrgeWkLjQXc4r1hI5Bw5vfHrukG0S7b0ddIMEpCNNVqIb7/cPOOLT6CxXyIhWab1I71RPrs4gJCncWwWj6S9vGkm8tp+5aKQJj8Nwcbq2BB7sLOAk4hJmlwZAk+HVxmZ3vwb40NDrlQwk5Fw7J0AKvKY7720p4iI6+67BBi7WplbKoOZ7CYc0YrKtvBd6gvBinzjXoSA69EnTwdPSprOriXJhWwbkoxCbdwL1HsaEbezENafjp7ReEICqN7kh9arlUi4E6X3udTUr2mzmvdoYe0nJqa/FKirMquRPQv20RkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BN8PR12MB3265.namprd12.prod.outlook.com (2603:10b6:408:6a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Sat, 13 Aug 2022 02:38:11 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99a3:41e2:da9b:57f0]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99a3:41e2:da9b:57f0%9]) with mapi id 15.20.5504.025; Sat, 13 Aug 2022
 02:38:11 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 12/12] mm: make MAX_ORDER a kernel boot time
 parameter.
Date:   Fri, 12 Aug 2022 22:38:09 -0400
X-Mailer: MailMate (1.14r5907)
Message-ID: <762F50AE-E28B-4EB1-B302-14B9596B5FCC@nvidia.com>
In-Reply-To: <2e15fc72-5483-b901-5a54-d4a4529d61d9@infradead.org>
References: <20220811231643.1012912-1-zi.yan@sent.com>
 <20220811231643.1012912-13-zi.yan@sent.com>
 <2e15fc72-5483-b901-5a54-d4a4529d61d9@infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_DE4BF272-297D-494A-A53D-4639D2A38DAE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0022.prod.exchangelabs.com (2603:10b6:208:10c::35)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 855166c5-9129-4ac5-747e-08da7cd4dd7b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3265:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvdf2rFug4JxEAsdyk+6sj9WOIRxfSw6aa6KdLm3LiXPiEMI32gvT4v1SqPKMIX5KL6Gk0bBaURWvMUwrbAc4EHHDXvNEjf1wYSOVPsyP2ZlprwpZnWSxL4gejFDsL4yLlTgbHcQZhoiwGd/SLN5zrvA+PTdUOWIuH2RbfLHZjTGdbf+Uyg31ZteB/eWzpO6fbJUNRmOSD398JJX5p8Ct6qTa9aQKP8srKAub40abPLB0fx4l7rVgffElpUl6kQWavT5dSv6Rf+WsYMgK4N0OqI++eayKkU4Jg9vDEn7VfIF/NcsI8iT3iiMNF4iKBcOVBCWxr7wVe5s1Eyk1Zf9eH6/3TTvNe6g4PE1e5xhgYoKV13PSPq2UInKiLv4TURIbK8NB8gmotHzta18Dtkk8LU83dIQpE2yPR5YIk14iMt4JeuOicZXeM/+Q9UNwXVolfwM9MQn+UiDue047mLzwjzNRLEpDSPFMDtoB7y/iHpZVaMJiHfJe6FpUtWJIhvIQf5HnOcEhWXbV34h5FfSWI8NPRM33MWQCaVyMcqh3DODLCedLGkSvGdOn1/0BgDjoqYAtm9GwvQc/mSIeE1siGh/u2qqlJtQCrGDJ47BdT0h7ti1D/cSs7OLL1w3sKSfe9bb9OnHh6QfRki7ii4cU4z9gRCGPXX0qjBhilnYwAVGxv1MV8rN+oWGpqtEUCqGXDrt3BbEHVT69gxGhOEK9hKAwQ0Tl6CIhODnPCuPqJQq4mchDY+ZGtnhHscEqfirWP7s+K90OFEDr3Jm2C8rLMuNCjNR9hvm0nEE8keqTfMM2Klrm5xj9nJzSRxHsPu4Mw+tob3Iz8SvY1mMHeq3IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(6916009)(478600001)(41300700001)(54906003)(316002)(6486002)(2906002)(38100700002)(8936002)(7416002)(66476007)(66556008)(66946007)(4326008)(235185007)(5660300002)(8676002)(86362001)(6506007)(33656002)(36756003)(2616005)(186003)(6512007)(26005)(53546011)(83380400001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6xmHUAPHR6jo+fWit9IEjxkwoKh5vlPWZP69GrG59BoogHebgZiyyj9+Buk4?=
 =?us-ascii?Q?j5mS2QqK9HorXJzTmVAXULQ0/KxAwA22lmSvJiuMU2afaraWozrpiu7gTF0v?=
 =?us-ascii?Q?OEVVRI1E6nDdh9PmESvPRPSjDaHUr4/QcFSKFrECGI4SirN7nkmOW2EGWXws?=
 =?us-ascii?Q?S/LWfuMlePEuwWRL3gqqDM51nkkpCC+Ix05uMD/ubCk1uh26cKfBsiGY8GHo?=
 =?us-ascii?Q?wSoluBlcMeJjsKUA4edqRMR9GFLfa3KFw2cyVnCuWoEj/egVQJXQ3nc7ppRi?=
 =?us-ascii?Q?gSV6bZnEykoKuRoNe/DjDt+CwaIFd2O7Mgp3HJjirq+oxH7lM6YIRzAuhadX?=
 =?us-ascii?Q?LJKB42Ax5gL5OMn2vkEuJMCYwJ6vvJHY+z2UwStp1te/jQiO5CjAyKOTgahQ?=
 =?us-ascii?Q?Tki2o9nfzaviqlcQ/oS/X3J9j2NfBF5otCwFl3b6OJlidoNgyl9D9mQUKWKl?=
 =?us-ascii?Q?AowdigUH5bXzoCnKZl8MZsJRBp2l4/2/8m3+3LlUutWthQxkYzLAoh0gtWTC?=
 =?us-ascii?Q?n+lMqw8bHJU4YW/8rfZOMT+/7/a9IuE/kWXhD5ammMXGiXZ7yJwgPg5Il3eE?=
 =?us-ascii?Q?oENS0MlYKbw5IYIZPrqvVlwMPIdHIa233W8A0t5r9TDXP3RPSx1w5kuxfUMS?=
 =?us-ascii?Q?f23vvJNGhx85LlfH2N19NiPQh/Duf3Xw+3HyMfapxcuCqMxSJuAGUr8Huwvl?=
 =?us-ascii?Q?4arKjDTCDbZd+1kpc6xJ/NwETNX0KeT3dpsOvogLVLNv+zFZbMjw6xjzoaLh?=
 =?us-ascii?Q?WZHUFe0QLICSdwhmtML49xPyssORnqkjTQTHSLH+AFzcajNE4FBO9sW8H0ed?=
 =?us-ascii?Q?3OLBzgqqWdUJBTCG5w0DcL1BulGv9kS+b+/+Yyl+a1XJjdioUUEIqkIvlZIO?=
 =?us-ascii?Q?9ZEDMgS51yAo+SNA7K4H02Pp8CNkL+GLQ29wXYyVq8I1MvOgiMe3SRGGZ0UA?=
 =?us-ascii?Q?dMjyQ7WMhYqDNkkxc2yBDRaehEQwEsLWrBTka9GNrhDLGU11kp/u3UUGzgqH?=
 =?us-ascii?Q?0mX+folrbnh7qaC+DxqMjcXqNvbY9Bq2o5qeAWUYPDUHvIKwxLXhVPp16276?=
 =?us-ascii?Q?BmkXe1uh6eQxCRJiY578KMsexUoB32vZ3+BiNNn3mlZXhnJnybULT+p3KrZ0?=
 =?us-ascii?Q?8QiRdY+C9p6vHEaf3yUA9HCDIzhspvrBdIdlwa7B+Tgnoctn3EvAe8tN5EtO?=
 =?us-ascii?Q?PwzjkSjMpACX2YpZaVgXdnPbPpzNqcPxQFF8dFBo2DOWyHi5zbVj6krMKOfi?=
 =?us-ascii?Q?QPk7uz0xgzSweqQT50+5O53gpdffUADvqZX3xDAs+Oj6zuJN1ZoeydmIT+V0?=
 =?us-ascii?Q?7qbQxM1nYO38JSuxC2lxlH5V+cyXrFtdF+rfY31LfBJm6b2BxUy7NWCp6FBL?=
 =?us-ascii?Q?KeuUT6dcRCiXk5haHTpXEr5jCRTmsKoAeOMzN1eqTG7Puet3VHornpYva+aK?=
 =?us-ascii?Q?Qj4DhTOR9CLG/ANA/hME8gsxFeuxV3Kg1HcDzesOq+MBc+xhBL6DDXZ1d0Xp?=
 =?us-ascii?Q?8dS1lGCypH4ReOV40roMrMPn5XsEaIHjzuFUNBM451+EtjjHH5+UKhK6IIkD?=
 =?us-ascii?Q?SES+zbg08UcstyPPKTHz7NQupeHAZErEsX+bDQXy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855166c5-9129-4ac5-747e-08da7cd4dd7b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:38:11.8206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAAiXyMZtp56vJ6bCKSyFl/SRIxz6QHumSXalP8GbAV1AXyUCMl1bnBjiX7F06Yy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3265
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_DE4BF272-297D-494A-A53D-4639D2A38DAE_=
Content-Type: text/plain



On 12 Aug 2022, at 21:11, Randy Dunlap wrote:

> Hi--
>
> On 8/11/22 16:16, Zi Yan wrote:
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index e558f5679707..acccb919d72d 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -455,6 +455,19 @@ config SET_MAX_ORDER
>>  	  increase this value. A value of 10 means that the largest free memory
>>  	  block is 2^10 pages.
>>
>> +config BOOT_TIME_MAX_ORDER
>> +	bool "Set maximum order of buddy allocator at boot time"
>> +	depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER != 0 || SET_MAX_ORDER != 0)
>> +	help
>> +	  It enables users to set the maximum order of buddy allocator at system
>> +      boot time instead of a static MACRO set at compilation time. Systems with
>> +      a lot of memory might want to allocate large pages whereas it is much
>> +      less feasible and desirable for systems with less memory. This option
>> +      allows different systems to control the largest page they want to
>> +      allocate. By default, MAX_ORDER will be set to ARCH_FORCE_MAX_ORDER or
>> +      SET_MAX_ORDER, whichever is non-zero, when the boot time parameter is not
>> +      set. The maximum of MAX_ORDER is currently limited at 256.
>
> Please make sure that all lines of help text are indented with one tab + 2 spaces,
> as specified in Documentation/process/coding-style.rst.

Thanks. I fixed it locally.

--
Best Regards,
Yan, Zi

--=_MailMate_DE4BF272-297D-494A-A53D-4639D2A38DAE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmL3DpEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUnY8P/iTwyDjjEuscfp95t5x5lsNTUHHXZKua6iWY
S0K3mBKWZFheRJMJc5AlY/0EIjUCzbJwkd5u1kUgQN6fk0pWq6VE/5qLNYIizTrt
us+4INq3Sa3gw9vX5UdhGC2COzmhuAKT8VKIbNeRjLjGItIJWY7EeYEWp8sQEPay
lTdMc2CkD8WvqjPRuSpZk8UMNF8yp4EX+aoOKcvG6QPXSR2gBxlLfeM98vNaic+b
9PZHy6ClxU+f1t/NkQVvWLSTZgyf46mRquv0dq+O+4rpTwgk6J07xifMoRKxyeN+
//G+Pxjp6Dd/jW/KAWmwu+7p/7X1NIGUtMRIefT6G9uF+jP0GUuZlXjkmcbTzJoz
2VxKAEEaElEK0TrftdltIK4Nny6YfyNBhhgozIWd/+c6bBcVtWGz2XAD7aw4pOq+
UWRCL8VXfnN6d1AJE6ATpqOJxXR6JLOKUyxb1Igkwlb1vropDhHPMn8mW2w8Xvwk
HzWIRh7oUK3ELioFjVGYQesNk2gK3lqkaGDSjCsRU9NU45kU/SvMjFgMHfDw0rDs
AjOboP8+ZTa9yLchzthp+hqD9g5d3aHgVXUxLi3liagl6CHt3LRSoBQOGdD60eCX
4sYphhEsGOWnpJtdjK9I57Kn2BE8YOx+2YADeyaOwcR7YwlXOJfQPjm+JVRnUoGh
kbdalOyy
=u57R
-----END PGP SIGNATURE-----

--=_MailMate_DE4BF272-297D-494A-A53D-4639D2A38DAE_=--
