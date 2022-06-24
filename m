Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F735596E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiFXJlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:41:34 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45DD7946B;
        Fri, 24 Jun 2022 02:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUfN5BZjLnkmR/i0/RAV1PEQhiIBjxTu/XMRvs4l8ADcS30NR9TMMjhsLYUjxjB2ffxlrtDDPfsbAF2XDqyZ9Om68DKCjspr6b+K2eWJ6cvPkOxF8ZSyiKnhiz0c8cjm23P8m7+eg/uQrIRLFVkSxpZvE2sFRPOskPv9vVV1oD83SaoVigIWcCjfTMDkuVio5ukif9xyLHMicJOEiNmb7G+BysFi7dF0ZCeU2qU/7fumMnFrXIERqbtc1UpD1tJYbc01jrp+CeO4uJ85TLkRPuK1XuMiG9gTuAZpsdOepuXzvOAbP55/6aFe0ixCFPll5SPOB+rGoN5mBjZFMu1wtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W4htjHLIQGJFXAAjecD18EIBzxrj72q0xEnlTGMTbs=;
 b=EKggohMeayG9y6J0GoKj6Dxs0av9FOLw+Hsc1kGY9GB3NbKL0DN4Db24fcJYKW/SAXeWKjCacGEnLgtHcw+CFOO0CiwpNz/ESbQc0747Ql2cW5fOyyKBDv1VGMXJBhpgfWTgvWFq621TgApJgJQSJYecTgr7qfo37tKepnpPHUEIqSPc66AntZeeOmFboBcRotBugrcjbWpz9ok3RuXVNwxZOlv3yLc44zjmoy200ss2HsdAaftH6DZ7oR5vHECT3XVsPji2DNPh7p9Q7FmiLKJZyuV4ssKMEkFq75cvx3oPAQZdoeIb5w4SHLTeyOKbYa5PldhbLnPZSvZJwqM+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W4htjHLIQGJFXAAjecD18EIBzxrj72q0xEnlTGMTbs=;
 b=VhEyUwz0EdugOFq2eMmW2B29sNE3+r3BbWne4xLVuErxE4evLJZaMf4MiIWX7/oRycMP4tPpbe5uZGxKDk7nr0KqLBLZWG4LalPchBpqNxHODgYqd4UMVbUets9fkL7Uc9Ln+cKL6+aXhoyxHbdQLXxudjA/pHQu+IVTNTn1OFLYsRC3EDNtxAAKwdTh9qeAVh+dsc3I2jwci+DYg/4piAQFeecjplkfmuAo1FRQTgM4Z5AE6iw2x7bIUK0Y14njuyb0bLnO3PxdLqqXGKLnbQaaS+7H7ROGaKG7FJflcl87573P6WWu8k6gXWL192POl2cri2DaWP7aK5K83U+8Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BYAPR12MB3269.namprd12.prod.outlook.com (2603:10b6:a03:12f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Fri, 24 Jun
 2022 09:41:30 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 09:41:30 +0000
Message-ID: <2517eea1-47e2-56d2-737f-f7d1499f693f@nvidia.com>
Date:   Fri, 24 Jun 2022 10:41:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 08/31] cpufreq: tegra20: Migrate to
 dev_pm_opp_set_config()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <4b38ceed657bfcf87ff9ab0dd69dd1f2f5658b24.1653564321.git.viresh.kumar@linaro.org>
 <793e49ea-aeb0-a47a-9fe8-742a6397bb35@collabora.com>
 <5c0e697e-abca-bcf0-cf68-d9c240d82527@collabora.com>
 <20220624053821.e6emke6gortqn72a@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220624053821.e6emke6gortqn72a@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0275.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 775d1a65-07f0-4696-f329-08da55c5b785
X-MS-TrafficTypeDiagnostic: BYAPR12MB3269:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpLxBgHFqB7XI72oAGTjJXwEwkeklTCmPZU4Y4X3vdE5fiDUbiR34CH16LVeQuBRpBvF269uBPnhXhIFXDjM0k4BySXKlhnKkAK+XH6t6bWFq4HXawR+5z+67Nn4oVLRRpp8d5Ra28tI/kTWMpQLH3yXa7Ulmols29lSHKoMXyBiS3IivJ/5NWIzIlruYvhacaBwU2My6qSBUjRCmCrv8JMq4wjxFHi0wGQFxDFjnfDjvd7zyS10MG/mNJzbUb7xOSAR7ppttiXxgHyAtwD+tez6ZbYS7UsnKY84esj8w3SuEindCcc6KYZps6ZueRAIvjm7RfrrY6iZRIJWf4tSISBoEiGMp5X4srVuG+5WBbo/sIOMUvEQHiOdXttuCNzSWm6raZMZLzhfn4QMT5aiQ7n00HeuWJ40Xu/Evc0HdWxKJQs5AsnWPjK9SkrPs92vS+Grzb8uP9EDEoAEmRcWhmEfr8ZHf6A6HIish5el9iFfjUL/p1s9H4WSq5GESfRGj059XLACMjhkOl/Kv5KZurpS7goEMQe+x+1ggi3wj9AyI73SBI4YAvUzVmIJnrbeIiKG/fxIhzsi/TGNX9/ZtLupCMr0UHZfTrUdOOX9z7OOIRvbh+Wx4f3FzsWo6DEzC6pgMF79zK22zEwsnhrPxtVQW2D2yjw9rvUi4IlX4m+nGCJ2/3C3WI6gaM6HE7+b0q9asi+urY4G6Lgu88NnvBirk9dZssEFLjE3AHSiIn82LeA/vS5xSlNtMjcfJjr9UyeVaXuspnlYlrg/2A1/+LhlFwVpX3MaVqOsVxfEaRudim7ZPbnJx1Xi26BvAh3AMa/3/wshBdAomMQ7+grR1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(83380400001)(7416002)(478600001)(6666004)(66556008)(2906002)(38100700002)(2616005)(8936002)(5660300002)(36756003)(66946007)(186003)(4326008)(31686004)(6506007)(41300700001)(110136005)(54906003)(55236004)(316002)(86362001)(26005)(6486002)(6512007)(31696002)(66476007)(4744005)(8676002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkxTdmR6eFdHTjQwNDJ1WTllTTVTUkJLTmRQNEd0RHpTWGhQWTg5K0ZlaWcy?=
 =?utf-8?B?QUFWVFFlVStmNUZlc3J2UXdEemMyNXJQdWRXblNHbitMeHFuaW4wRU1adFc0?=
 =?utf-8?B?M3o0ZTlDa2FEUlVHaUZPa0lYSy9wazF3bVgvK3NDdnlFU056TVNSTWdlOVps?=
 =?utf-8?B?cmlYczRNaXlvT3FCK3pIbjZRanE3VktGWE1aOXRNbUtKQU40ZHpGWEhmNXlB?=
 =?utf-8?B?RkJIMVUzVmVmUEZ1cmhId1pMNTgyaXdRYW5GQ1NxbHpuUUlqRzQ1K0U0OHdn?=
 =?utf-8?B?b3ErVEN6VmxZMDU0K2QwQ0JsMThPbXdPMk1qYkxYRzJCS0FuQ3lYY0xzSUVJ?=
 =?utf-8?B?bUV6dlJISTBXempRTFJVTWljK1RMQ1hQSklmTm5EM2ZieGVjNURnTnRmWkdF?=
 =?utf-8?B?OEpPTEliNFFYRm5ZSHpNa1YrWENYZnV3Q1oxdUR3SFRpTUh2V1lGRTQ1Njhx?=
 =?utf-8?B?NUpGRHlZVnJMdWZBRk81bDZNY2pCYUYwM3orR0hrTERibEFBNHZzaEJFaWVF?=
 =?utf-8?B?QVB1NlozTVVFcmNVQjJhZFl5eDZ1Z0RwSmUxcGRIV3BIMGZQVDB6VVNFV1hs?=
 =?utf-8?B?VFNmU2RwV1lVY3hGQm9tck1LTmZvM2N4c0VSRlNEcHhreHRFR2F2SWNNdy9T?=
 =?utf-8?B?a1pDK1hPVi82emlVNTFPMlE5MWlGN252VjhzNitQK3FvQzVTVWVFeXBLdW10?=
 =?utf-8?B?MFQvV3Y4cGJEVjdnRUM1T0hma3pCOTYyM1E1YjJHSlNsT2VSaFpjNlRMR1NW?=
 =?utf-8?B?UWFnOXd6VUtoS0ErL0JncUxZK3BlNmZiVkxFRmR5NFd3MFFmSHR2ZStDUmJu?=
 =?utf-8?B?bzNyRE1jRG1jWnBkS1BvSzZkWUFVT3dDOTBqbnlZTlByWkpMZTNRdG55d0ZR?=
 =?utf-8?B?a05PT28yTGN3a2dxbnNTejFsQy9QMDRGZUVhSEQ3UUNjejdWeXZxTk9SR1Zm?=
 =?utf-8?B?WUxWM3Vxb0ZQQk1VcW9pWXFFMzM0NUJsRytHN0prOEprOGRYTS8vMGtpSUNs?=
 =?utf-8?B?OUcvN2hmYnlSR09CclFTSWZTbU5UUkd5aS8xVlJFdEp3dDYyK2l4MFJvREg3?=
 =?utf-8?B?T0RLSHh4UVF6WEJXQXlDaXJocFlYQWlqQW5RQUUxSjNTZklhRW5PSDNGc2Vm?=
 =?utf-8?B?cW9KUWJIN3JSSU1VNzdWekw0VER4d2hjd3ZKV1AwWmsyb0VqVnNjQXFvMjVs?=
 =?utf-8?B?dHRFRzgveE9jNUMzSHZMZEhSL29UVFBHQnBpdlo3NjkvODg2UzhiZ3d5azRs?=
 =?utf-8?B?SnJyTzYwOEoxM3lCdzZiQURFMTNxZlNTU1hneWVsSTFBOVlmV2ZDZ3lQcitS?=
 =?utf-8?B?a2IweHZRZnQ4SUpSd3hVQ0k4RVpVMlNNMXlYL0tNK0hIZjJMTXVabVowVGtP?=
 =?utf-8?B?RzNGS29mUC9mU3BldXBJMG5lTkI5WEUzL2lYYW5DUHQ1UEUydE5rcWd0bVZ0?=
 =?utf-8?B?UjFUZFE1dHc3Z1pGVi91ekVabXhPRWV0OHFLYnc0V1lXc0FYSnhrVkN3TTFo?=
 =?utf-8?B?S3Rrcy9laVBRRnhobzZGK2dNVHAvdFZKTmlxZU5VSndTMXI5VCtVc2VIOTR3?=
 =?utf-8?B?ck9jcnhRcWZZZVlxYUJJMHhZMGlsYUJRZnhPbHhuYnAzVDdMU3Nwa21ZcTZF?=
 =?utf-8?B?TkthMmlEVGtaUGVadFByOGw5Nmd3a3JsdVB0Y3Z2WGJJZXZ4aWtNUkw5RDBD?=
 =?utf-8?B?eWRRWjBxTnVYT29FT3NjSzNBcnVPSjI5TTczMW96SDY0d1VGcXVGRlQ5V3ZM?=
 =?utf-8?B?c1JFL0dQWk9zVjlsMTI1WElvZHFVYjh4V2FyTmFJOG9FRms3K0pGSkd2K2hV?=
 =?utf-8?B?c2NHZDdPQjZJdnRSK1ZkSVRvY2pwZTlBS1h1SVJDR21wcmtld2xLS0pPeS9D?=
 =?utf-8?B?TU1VN080cmhJbENxdnMwMjRYb3o5QVNzMktmdGVZaHVQdVF5cm5SMmFFMFZ0?=
 =?utf-8?B?OE5FOWlESkZuZFY0UThvVXVPcEU3aHJpTzB3TEt3YzAvWHFPVHRvbVVXQlpZ?=
 =?utf-8?B?NDBCcmFvZjdFNFpXbnhvUVlMcUhRcnZPL3JlSFgxN2ZMS3NRNml0SHNJODJ1?=
 =?utf-8?B?SXhiUVo1cW5LcWE4dFBWTUEvN012SDNUSENjeGxRWWFHKzhhcjRKajVuY0xJ?=
 =?utf-8?B?eUJPS3RTK0NzMjk5aWRUbTV1dVFaUTZlR1N3Slc5YkM5aSthTkFZa2JxTDZX?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775d1a65-07f0-4696-f329-08da55c5b785
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 09:41:30.5086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldnWqcgGGYOg4aV/bT6GFcBr/r/0pncix5+q7tnNMSmX8FASFKUhrE35woJ3qagyNlvfEPSIeFMJ/oDbrFtsVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3269
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/06/2022 06:38, Viresh Kumar wrote:
> On 29-05-22, 19:59, Dmitry Osipenko wrote:
>> With that fixed, now there is another error:
>>
>> [    1.761945] cpu cpu0: _of_add_opp_table_v2: no supported OPPs
>> [    1.761960] cpu cpu0: OPP table can't be empty
>>
>> I see this on Tegra30, but not on Tegra20. Apparently OPP table
>> refcounting is broken on Tegra30 by this patchset. To make it clear,
>> there are no error without these OPP patches applied. I may take a
>> closer look if will be needed, just ping me.
> 
> Hi Jon,
> 
> Dmitry reported this on Tegra30 earlier, do you also see such a
> failure ? Would be helpful to get this fixed as well, if it still
> exists.


Yes I am seeing the same issue on Tegra30 ...

[    2.177437] cpu cpu0: _of_add_opp_table_v2: no supported OPPs
[    2.177455] cpu cpu0: OPP table can't be empty

And the cpufreq test we are running is failing.

Thanks
Jon

-- 
nvpublic
