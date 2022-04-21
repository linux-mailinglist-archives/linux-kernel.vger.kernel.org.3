Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CEA50A0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356465AbiDUN3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiDUN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:29:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91DF616B;
        Thu, 21 Apr 2022 06:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnRg8e06FNDKluYkXtlaTFUADlU0OcLXT/wNsHv+yJcQjpaK+dnoqr8r2ded9LsBirqGikG1q9Lgvwnub0A1mLBtt3/iGtE9DyGorJaamKTYSKUVx23Hy+mllxSgGjfWw2Yu0ukdPxKN9c7MyAmnJErv3wTW/TRMZAy7GDZ7SP8btgVMXLV5sTAD98JIMDQDHxAgL3qTk5YN8kxJrr6kHeGa4BuCAXLA2LAX0TgUtGIrlwt9ZRykS8k3Y//Q8iOTbD/EYSAEjHkW+cg+hW7nN8+zXrSf0SV4jG/ebRyvCm/4RrTfVgVYInGPv2dROj2YDml4h56fHgD9yoh/CJFC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDw7tmuGqIOzhWAlaZH8wsCGzaigwdYdwtDasyDuZOs=;
 b=YJYh5IVtruIylCP6XdaPAFzmMVZagQeIgFBwOJVzcQUumIvRf1WZaF+KsVkvMMDHMynuvjq3Wjl3Mp57Z8tFb8xDZ5RKiZE5eWdxDDFUaHJJBCeVEBrJSEb48duqQqU34HliHSvrcSyczNvdm7G3K7hNvMu7XLbICvVP6hBX573bBll6EV9E24+2t/rfhFSrhagS0SlN3mJ7ej/aA65Z1JH58sZfiBAnjMbxXWMR/PXQac8TlfS2G3LdTD1YHv/kL/AgmSGKB6/R+g9LrDyUMcAYEv9fOUkqN4SHYQwli5J+/AneVlLPz9go1W/LhBRiZ6J5eQAEERSImPBLx3hHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDw7tmuGqIOzhWAlaZH8wsCGzaigwdYdwtDasyDuZOs=;
 b=wHN93kJ3NQ24fEWqxvLi/IIlDKA8BVFVBtHZIwooFGrchJrQPfRg7+UZJPZG32b7oqQkXC5kMMsdD5UhjmjV9AZtBrFNBvtMm8IAOAqQEsH7IcLJQcs3y3RT6uyUcS/FkTSCmN1D3T3GgdbczHhYPT4pQ98JV/JV1OMVKCOmY9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by DM5PR12MB1596.namprd12.prod.outlook.com (2603:10b6:4:d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.25; Thu, 21 Apr 2022 13:26:12 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::e4fe:e7c1:736c:d792]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::e4fe:e7c1:736c:d792%7]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 13:26:12 +0000
Message-ID: <83d2ab37-81c9-bace-59d6-5dcbda2e1111@amd.com>
Date:   Thu, 21 Apr 2022 08:26:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] crypto: ccp - Fix the INIT_EX data file open failure
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>
Cc:     Jacky Li <jackyli@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220414162325.1830014-1-jackyli@google.com>
 <fe209f25-6119-cc26-2608-8aaccf11ac36@amd.com>
 <CAMkAt6pyDQaqLCRzJWow6hgtyMrAtarPri9yUWBgMPPuucm77A@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMkAt6pyDQaqLCRzJWow6hgtyMrAtarPri9yUWBgMPPuucm77A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0036.namprd11.prod.outlook.com
 (2603:10b6:806:d0::11) To BL1PR12MB5221.namprd12.prod.outlook.com
 (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 194ed124-f8e1-4aa8-95ca-08da239a80ef
X-MS-TrafficTypeDiagnostic: DM5PR12MB1596:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1596E20EA4B94911FFA8B508ECF49@DM5PR12MB1596.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MowbKyt2/pM1v+Nd8XZXuOKU7m88+PtVQWzEG3BcOxJLsTrRPH5tXhlwtLUBKbE11wJ8nxYba5NhcW8v6CXzymVN8nVZpjl6PbbjRaZppJw0rduNC03HkialgKpYoGCWd9gEWN5o2rpUrT4u5BxDlVLGbV/ZZdi1H3lf+xU/PZzhrh8XLi8xvEPD7qw1pzGASdE5LWSdSmY8jAcO0nyQb92oC8XU1IK31+/5z1YRMfzPaojQ01ejhot22RULkh85bIFCdo4sUqKvyt6TFsm9kefSnvSnlXyrlUY63ErYGDKIY8O6xNw/TszdUmFZitS3WrKTZ1r1FZp8Emk3eRdAQqvYaGUPnRgQXSrM2tdISn/VT3pxIl7bgpJqjJbk+TX6vaOzz1S0l5VGLglRR+EkifOfMzPYY4FydmNXmQVHueaFu8aCsXqq3LjBNRpZU7N3fElB7xM8gcZp+pfFv4yLsLkpMVRGUzCtrk+ZqOvoAFuobM4X++N5JDxVLXm6SQhb7HWVIq9Gd4K85LIV1V6QqN0hrbp1xoSLEa1bu5D6+/y6eo7B9IohgcEDKUbTOygIwJ5jku8uGxaK0pCmK1neTS3kJ5PLwc59Agg6hk7UJI/cJuWKLEvpAzAdsy+drTTrRIQyLjX1NRDSpyXqhuvzCzmxKZ6vIY2TkRDi/tBbCL25+nhRXeHE9gwf1VvWHwApUZ0O0bg+1NNOM7SEpjN+hMh8uFh+wq0422oiiTfZlpNH4TVdDrn/Dvkydt2AQrY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(26005)(508600001)(2616005)(2906002)(186003)(53546011)(31686004)(36756003)(5660300002)(6486002)(6506007)(8936002)(6512007)(316002)(66556008)(66946007)(8676002)(66476007)(4326008)(38100700002)(86362001)(6916009)(54906003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGJhVzRWV0xCMHNJZDlCS211RmYrbWtCSVlMVXNBbUZtOGJ4UHhmTW1ack16?=
 =?utf-8?B?cW1zM3dhemJaSGlxVlM0cUxxMitRcDdVRVhFSy80aW43K1hob2cwVW8zc1RQ?=
 =?utf-8?B?bGhpbzF3VDdnWnhtVTJXREsxQmN2NnhRM3AwYU5aQ21uT1lyNlZJUS9LcDhY?=
 =?utf-8?B?RUZKT3ZhMEVaMTJOdldPWHdhcjdUcFZyeXVEc3E0RHNTQ0c1TVJwcU00Ny9n?=
 =?utf-8?B?bXQ2MGR1WE1mb0t1L1Q2NjdPdzlaZkdwR29QYlBFNXNjYm04K1l0OWJQMUc0?=
 =?utf-8?B?NC9RRjd5M2ljM3lXWHhLQ014emFoRWFyQVpuNEd3eWlIUzFCcW1WQ3l2S1o2?=
 =?utf-8?B?cmk0OW5SNGJ6Ry9zVXFiM3c2NXVzbDd6cWQzZkZsZS9ueUYzZ3JjUndqT3Fj?=
 =?utf-8?B?UHB6TFVQdkVud2U4R3RvSVZhT0hFdGs1Q05wNHYwTkpSazNkZjB2N2RqdkpD?=
 =?utf-8?B?RXhLRkJrV280cGZINHNPZ2EzQWZhMVFsTy9wM2VBREhTb2huUjJNaEpVVjFZ?=
 =?utf-8?B?UysxanVLM1AzVW9Ubkx1M0dHdk5wc01QdFFQNTFFdWgvSldtamVoeStSaldG?=
 =?utf-8?B?NHV2dHhObXZnazJJQ3VhN2lYTnJtZm5BY0ZiZWlHYWlxWFczeXhwYnF2OG9l?=
 =?utf-8?B?V0lNdkNTb3RFOWRzblpQUnFadmh6NzdlTkh3MXRUU0lHTGtWdFpQTkJYRENz?=
 =?utf-8?B?bXZISmJ0RFJKNmZ3QzdndFBjZUZnQ0hIZURrdzU4QnFHcXErTlJmZ1F3WEVI?=
 =?utf-8?B?ZDFON3B2OEw5MklWdXBwQzRXM2ovWXc5Z2FMeG1OMUxKM2J0RDFZSUJHc0VF?=
 =?utf-8?B?cXFIME9kQ3JWOTVPU1drK2RadmlUNGg5Q3h5UGtJbENtMXQvNlZ5OFdaSXQv?=
 =?utf-8?B?bUdkd3Q5UWlyMElyTW9WMGl3WWtMc2RyekpJSDFoZXdtNzFQUGcvZ2RqM1V0?=
 =?utf-8?B?YTA2dzU0dHNFSTBqMUNUSU10c25MaFhPUzk2SnpMRjhvMFA3UWgxalpHdkFz?=
 =?utf-8?B?ZVpMaCtndlhySjFBVXRDWWplTVFBQTFyYlpYc0MvMXlkUEZqQWhlV2pHVjlY?=
 =?utf-8?B?TzR1U0FZRUtUZjlYbEZVN0dWdmFGck1WVlBNS1N5c3A0aE12ZFhXay8veUp0?=
 =?utf-8?B?aitqbUVOQWw1NzlQM2diNWJsRDNTOG81eTFFV004YkttREY3N3ZRcys1a3RF?=
 =?utf-8?B?MTVtYVFIcGkxajkzYWRHSHF3aDVEcS9WeFhNRy9QeUtYaTRPRksrWDNiMW85?=
 =?utf-8?B?YUlIamNGMEltYlhsM2hJN3lPOHNOZlMrVXgvS0NDcGZwajZjbmtZTm84VXlQ?=
 =?utf-8?B?emMzZ0JWNGhwU1Z6SmI3VVBmQ0NLdmlMZnRSV2pqMVZrWno1OEk3QUhGYUcw?=
 =?utf-8?B?cU5OZmdsVE1PTkhBSy9Wc3A5bWRTclI4YmZHbEJyYm12emJWUzBCa2x1b3VT?=
 =?utf-8?B?ckZEam90TDZ3K1BjdXN5K3ArWVl2L0Z0WG1ZZzRLSER2cGRXTm5ySG9FaDdp?=
 =?utf-8?B?V25LQTVTalZiN0NEUTMrNlZzZDlnQ0FSdnlZRXYvU3lMTVMyRS9lNUJXeWVt?=
 =?utf-8?B?V1NOMkpGNVQ0WEZlQUd2WWUxMkVxRldFYmFFalhnSU5aa0FRRCtHNzhOYkUy?=
 =?utf-8?B?ajdjcWFlSlB6dEhGY0tzNzluVG1MZnhLL3ZCUGN2eDlqd2p0WGdGOVpCUURE?=
 =?utf-8?B?TnpKZUc2VHkzdThCaURySUYvMWtBNG10K1N6NE53azVlV1diSEpCZitwNjE0?=
 =?utf-8?B?VTVHZWFTck1nNWZQZGJ1UTdOQStiWEZIZnBtQ2kvZ0luTWRoYzQxUWVCUkxo?=
 =?utf-8?B?WXVReHRHM1VzcTBWNk1pOGVMcjFJYUhOU3ozRm44MnlyUGhLRmcvdHNLTjJp?=
 =?utf-8?B?QTF2VmYxS2MvMVBWSGFsWTA3TVhXZGRhT3dRWHFOaFZqK3F5V0R2S1cyR0lF?=
 =?utf-8?B?N0dvWFp6YTF4OHdtdllSem9PZ3JCTHlhYjl0Qi9TQ3RHbUNzVTZjRUR2TnVC?=
 =?utf-8?B?Ym1Ra1BnYlZNS1lIaW1panUrL0V2RjZOdXYxRDBNbVE4Q0kyRHlndGN6T0pD?=
 =?utf-8?B?eklISjZIbVJMVUJpaHUwRExpbkYrTWJaZ3NXY0M4R2MvM3psRGY5U3ord1Jp?=
 =?utf-8?B?L0lxUjdRaWJKejcvOElwVEVDd3ZQK2JUY3ltVnF3SFZlTzdJSDUxWmtKT1JI?=
 =?utf-8?B?R2NsT1RKcUtsNGJ1a3lRemFxVDNFNFVWN3YrYkNHbktSYTRSWTVQYVM4ODRn?=
 =?utf-8?B?d25aUEQxbnhoVmdUeldaYUlpRVNiWnplOFFJWEtWZjVvZDVwRklrb1JTcHRI?=
 =?utf-8?B?OU9nOGtHSTlaWFpZRU1IUkY3c1ppbytvazhtZE5DZkl6dndqOUJ5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194ed124-f8e1-4aa8-95ca-08da239a80ef
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 13:26:12.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sApIzq50T2ovVXZp2Xxgx4g16H+SenYci65sD4xx46zm+gp0zL3yuYTMogGTiVhEXHxNKv+m45INwG7uM/12ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1596
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/22 11:20, Peter Gonda wrote:
> On Fri, Apr 15, 2022 at 7:49 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 4/14/22 11:23, Jacky Li wrote:
>>> There are 2 common cases when INIT_EX data file might not be
>>> opened successfully and fail the sev initialization:
>>>
>>> 1. In user namespaces, normal user tasks (e.g. VMM) can change their
>>>      current->fs->root to point to arbitrary directories. While
>>>      init_ex_path is provided as a module param related to root file
>>>      system. Solution: use the root directory of init_task to avoid
>>>      accessing the wrong file.
>>>
>>> 2. Normal user tasks (e.g. VMM) don't have the privilege to access
>>>      the INIT_EX data file. Solution: open the file as root and
>>>      restore permissions immediately.
>>>
>>> Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
>>> Signed-off-by: Jacky Li <jackyli@google.com>
>>> Reviewed-by: Peter Gonda <pgonda@google.com>
>>
>> Looks good, just a quick question. Should there be any type of access
>> checks before switching credentials? Should we check access to /dev/sev or
>> such? Or is the capability to load the module enough?
> 
> I thought this was fine because regardless of if an admin sets
> psp_init_on_probe=true or false, their intention is that people who
> have rw access to /dev/sev can use the commands which require the PSP
> to be init. In the case of psp_init_on_probe=false only rw users can
> cause the file to be created. The case of psp_init_on_probe=true seems
> a little less clear to me but if a user can modprobe ccp that seems
> like sufficient privilege to create the file. What do you think, Tom?

Sorry, lost this in my Inbox...  That seems reasonable to me, let me add 
my ack to the first email.

Thanks,
Tom
