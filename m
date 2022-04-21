Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AFE50ABF0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442527AbiDUXYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442526AbiDUXYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:24:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042314704C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0y8BP52EcDVvnI0RazGAzGUjRw6xcUNZwIqFW2U2vHNWyaM1UzKczPmBYr8iDGlrc4JlbTA9eTXPvHZMWgcIseNIDLMuTAwIDuR7a2+sixngohBVR8CJWOO/5FwJEwSM7yzFbBjRaTEGm52L7V3wMClWIR0ZnFDcf4leUZlQn2wN92NuqorPHIexNLdlqwqZLfDyf13oMOW9Q9tNgBeS64P2m01O6k0tcPb9RrkcEPE4IyJnZ+05r4R8qW3GelPVUO2MoC8dHtMQYjENhM0qzkTy//AlX6M5MTARIGsHPoRr6UZgWk1ruAJN8HaG7zd0pW7UNSX0urrL4prwK4dUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT11Z4WY48gdQwUXn1Yvd2beh630xr1nFaSko+1PqaE=;
 b=WaNewSzo5KXZU7qSn7A2hsj/9LnzzsXGKDdJeoeKaJhNyGaMi+SEVYDrFosxu2mVAUdOqFJV+GSGJPdJ9mhZJS9XSiKdBXXEe3yIdydjergiyW/moxgzrq4E2TgqACK+aAMrYGVRZZaTSiIXWOnDmOQN8doIbqjsEsC89AtVB4k9ucLVcQBbGfNUeZELvHWfrpyuNeXd+IL/UrLdqhwx73Z+N46rELqRb5omdODyW+0Lj/ELCK/sNQWlr3bLRp3qJvynhb2SrWJUn+lBj5iA5jqh2BYoGF51KyoEcXd5MoTAPpftl9hfNR7ntzciG8YnBcqwAtp6QeDwp5Qi31ftBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT11Z4WY48gdQwUXn1Yvd2beh630xr1nFaSko+1PqaE=;
 b=D2MM01eBe1NmeAjLi9XhFMSI2QE4PS+Cj354bap1VITwU9vQAd3roEasHoDw3BQ9l5uNG+SMztZ5lbAW1L7WjQfM8mpM0Mm7M5sU465HgRQ3NXIO3/CUTC06dCXN70PtCuS5nyJ3i4k6b65m79bfBcJe3yGdEou67vi8jkv2HPWZmnQR0aIZvZyJc457ZChlL+SCKUSo4VUr9/RY/cB7wrHaGxtFQvew4g1bHvUvlyjmfSKpcJiXucwWI/iOX4XAL6uDFxqOrzT4q0QCA7Dl0Qlr7qrHmzQ9g9d7QfmKcLNr8WnZgACnE3G5WoJlXp7ORdFbVgENUiLmzVug58lI/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 23:21:18 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8187:9d64:dd55:f14]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8187:9d64:dd55:f14%3]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 23:21:18 +0000
Message-ID: <09780876-7a65-d512-5478-5c0edefeb766@nvidia.com>
Date:   Thu, 21 Apr 2022 16:21:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re:
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220421164138.1250943-1-yury.norov@gmail.com>
 <92a2715c-3c98-251d-9195-872d1cf01f9d@nvidia.com>
 <YmHmC1VVxEuViqJx@yury-laptop>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YmHmC1VVxEuViqJx@yury-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::20) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee4b56f9-c77c-479f-c10e-08da23eda3a6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5721:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5721FF8720E754A607FBC2C6A8F49@DM4PR12MB5721.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DwOtxZMAaVz+ljOP07YTa9mGMSGDfDUH1r0OnAir0anuxSM05Vg4txEoEdlP2zxxOVHERwWaDwOg7ioJB9Z8Kzpm4gRg9/YDjFmIcU/snj6BJKbnHQr/+mmzMjobN3/ll2LkDuvSrneJHsQJL46dcyJsC7YT41HKYXtLmJbrRqUNJobJLJQo4HznejGWKJXnkDW6ct1b2nWWGN9aATlKIlH+m4PPlp9y8S+Lr00YUn/wsccZGVBKrO3/kt0Zjc79itYb49H/Qjr4a7YbJe4EbjpcOQswRxmW0yLSyIRI8i41uKkhqdx10kF4TIcVdOWe9m6QgtkvVPjBCoEv8MekCyK64+hySgC2RTTb7BoPLdI45YteGu8cPfbnOOS8HDSnxbiEKU1UsNx4QsSs1hKah5up6jw/bJwg/RquGiAUB6yKaEBm0KPeki9CP8fGaJheCPAozw08K5s4S/6FHfs3nl3l+WM4RZDMDM/x4IQeUcD18VW+ELkNGE7a0FQmsubjfq70PQK8puj2EcCBNCIYw7Xhau1GZF7spAbvWyaAERI3zg89ndPcR+XmbrVXDcTwp2HKDFBrJ4rUBfoaSK5cIdXsrWP+psiksrr0640ktWzacy6XLyZHTc0YAqIq/6WCqyGwgM7FHhcmyCHd+xKnQ+zms3VAT3B5dtApIXjJYi1+HAN5h83d+kprIoSmUQ41NK3nh+UDjJ7ztGrkiUN4iDSdc98CAZ/WG9ddtRg1oiDUA8wWpfJr0Z2LUM6DH98
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(66476007)(66946007)(66556008)(7116003)(38100700002)(5660300002)(31696002)(6916009)(8936002)(316002)(36756003)(8676002)(86362001)(54906003)(4744005)(6512007)(6486002)(26005)(4326008)(2616005)(186003)(508600001)(3480700007)(2906002)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmdDTkQyV1A5bldvWW53ZHJlN2dGemZaaThzckJyL2h4bGN3MlJtYkxWL2NJ?=
 =?utf-8?B?SFI1NFhBOFBEbkRDTWVSWnM4b3BudVY5TnRZQjhWQzVqYllnTlFSWCt6dk10?=
 =?utf-8?B?d1F1R3hlM3BrWmNFTDBReUt1OW1TSzliYUswRC8yK0JZU25PNkpRandZWjNl?=
 =?utf-8?B?OEdCSGR3WDcvYStGTmdmc0ZKQk9RR1JBTXZpY3gwdFMwNzhaNmhZeWtGc2h2?=
 =?utf-8?B?dTF2b2FSUEo1NXFJb0V4cG92NnVhUEF6bldHNVlnQnoyTzFBVXJISzNDWWFj?=
 =?utf-8?B?TnJZRE5IcTlwN1JYM1NDancrUGJhQUxKaDV1aTRSZ2o2bWtVYUdzcFlUYi9Q?=
 =?utf-8?B?cStvMnM3c29UY2luSzhuT2cvdk9aQ1FpQXhGaFBFYk9hc0ZnbU1HVnhQUzFq?=
 =?utf-8?B?TVRjQ1BZZmViTTRaTzM3RkNvMWZjQllUci9UMHJ4VkwwNVk4MGRoUi9Yc2E0?=
 =?utf-8?B?RDJoV21QUmtZcmR4RjJGNHU2anFLMGdjaG0zWjZPNVVBN3AzSUpEKzJRaWk1?=
 =?utf-8?B?VUdNUGZQb2dGZWpVdGRYYWo2WjRpZkx5K3ltVldJam5kOUo2WTlBL2Vtc1Y5?=
 =?utf-8?B?L3Zkd2F5L3ZpNVdsemRaRnQ5RlM4MzA1WXZRSGNQWFFWRVVVY3hNZ1QwbGpT?=
 =?utf-8?B?eGVjempuRnRnUjd4ZWY1UUxBaDdYQmhGQnhwSGpVSHJTTDhVMTY5U3JXWVlx?=
 =?utf-8?B?YVM0NGRTa2pnK3czUFlIbTR6Z2M4RWhucEM5SDUzRkdMSkNVR2tkdVMwdDQ4?=
 =?utf-8?B?TFoybTg1VTNLQnFEWXhud1ZSUHdkQW00eUZHaTRUaTFHVzRvR0dXU25VMWNo?=
 =?utf-8?B?Yjh5aWxpanlrc3BJMWFIUDhadHdOeEZwdWdhejlRN053UnhVL1NuOWFRREM1?=
 =?utf-8?B?MTlHNnQ4QnBuYk9HaS82VEZEbGk5RU1QTzJPMisvb0gyV216b0lLRXRGQVdv?=
 =?utf-8?B?cklpb0JrcnhPWk5vQkZCNzZKQ3dqRHN2WEFJRkQxMFQzU3VoM1l5ZXJqcFhv?=
 =?utf-8?B?cTRDcnJhY2lITkxMR2I3U09CMzlTV2c2ZXRXODN0d1NkallGVW1FMlkxSEx1?=
 =?utf-8?B?bDJKeW1UUDBoTFh3UnBaWFBxUGwrbDF4NGRqWlJWdnFvWnVvb1M3Wmt4bjZo?=
 =?utf-8?B?cGZpWGZDeFE2RFVzSU1FY21mZThpWU5WdWtoZzZvMHdPRitOdmFpN0JVeC9M?=
 =?utf-8?B?NXlKZlg0VFlKMFNrenVsMDRKNG1TdVRuaFdhMDJmNDg4R1F1czlDMUw4Unl4?=
 =?utf-8?B?UzR4aUR3dHd6ZFhneU9ZT2t1Q0NpUFNIVVBVWGQ0NGhnUWptYUFlU2g2WVZN?=
 =?utf-8?B?L2FrcnRScFNXNE1pVXhTcDJNL3pTTExUYlFDeDd4NmMvMkMxRGpCQ0liM2Yr?=
 =?utf-8?B?bithaXBsRHJZTlM1Y0VTT3BxRm9va3NHTTFtSnBoRXZDQnR6KzhXTVd4ajY1?=
 =?utf-8?B?Z2F2WVlScmt6YWZrTy9idG56dEpWcm5mZmREOGEzeEVZYjRkRzR0M3g0NXEx?=
 =?utf-8?B?NUp2a2dkOUZwTFphNStMbWxlUXVKUDZXUXBjeVNlYkNXTGFhZlJWUFFJU0tY?=
 =?utf-8?B?Sis4TVNWMmdmMmh4eURqRTZCSVRFcm0vWTE5Ylk1ZndjcnRaTk5sODg1d1VJ?=
 =?utf-8?B?d1BEdmkyUWx1ZnAxZy85d0cwMk1RVWFoYm1nUGpNNFdlem9GVlM4eE95Q1Uw?=
 =?utf-8?B?eERxN0J6cTFyWmZSU3VHZmV0Qk1LT3hXOHpQeGEzRitqcXBleTAvVEU0ZStN?=
 =?utf-8?B?bkd2ZmkwNVZHc0RlUW9GbXBSRnlVQ1EyMzQyZHo0dDl2OTZ3NFJCQXlNS042?=
 =?utf-8?B?UU05bGV0K0I4bk1WeW82dmI4NjFiU2YwR0hSS1ZUNzhuQTBEdUVZbnBCTG1a?=
 =?utf-8?B?U1VMMWcrdHVHVy9sVWhXcjljbVhzQng4cmNDcG9IT0dCMWN3ZVRoMmpNNmJm?=
 =?utf-8?B?R0hKUXA0OVovSjBReC9sWTVWR3dlb0gvd2kxamordm5kbGxJUjhJK3pKV2hQ?=
 =?utf-8?B?UTlyWWJYbGhNQytRMVg5YlU1MERsbkZIcVJmK2lubTQzemdWaHM4NGtsUG5U?=
 =?utf-8?B?c1ZsRVlzS25qOVcwZjRoc0w2MDQ1VklxekRBOVpYNnV6MGk3VElCTHcwUUtO?=
 =?utf-8?B?NDdjWkVpcFdjSFltZFpOZE1VZFRDWGgzL2lnYjRhZWRncGk5SlQ0WkJQZzNH?=
 =?utf-8?B?RExYZVhRbEhCdjRSQndweWRGRjc3WGNEWlRZdHdYQmQ2bEI0YkwrMkVOa3pG?=
 =?utf-8?B?cVk2TjVOd0xZejJpNi9ObWlidW5WdXVRYWR2bVhPN3VWWHE2N2lzeVRMNUlX?=
 =?utf-8?B?VTZYc0JYcWZuRDRzYUVsQ1hRRnRZZWxQWUhkOFhrUC9xd2NvMjVwM1J5ZXdC?=
 =?utf-8?Q?nVm2fMIbFtiraRSg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4b56f9-c77c-479f-c10e-08da23eda3a6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 23:21:18.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHuYijh5qXHRyBlh35Cva9ns9JkqJjxn3WKDM7bQvVXx7zbZTDqUfVWkNSgxsFYKeNLJftTknsoxMNVGtiRqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 16:17, Yury Norov wrote:
>> Let's add a Cc: line for Michan as well:
>>
>> Cc: Minchan Kim <minchan@kernel.org>
>   
> He's in CC already, I think...
>   

Here, I am talking about attribution in the commit log, as opposed
to the email Cc. In other words, I'm suggesting that you literally
add this line to the commit description:

Cc: Minchan Kim <minchan@kernel.org>


thanks,
-- 
John Hubbard
NVIDIA
