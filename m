Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7D2539C44
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 06:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349473AbiFAEZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 00:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240934AbiFAEZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 00:25:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524869E9E6;
        Tue, 31 May 2022 21:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGK+0HExnbFPs3n4gNo7c8NpIAqIp0CIIv/fxxzheSo5q893GgoOkKfyvLsh+LzWVTg2U1JycWf2mQpDqvJtBMb+rk7Cx/CHoxewSfHGuQTMWuuGt5IKeUx8Zym3cDtay9/5peWxyKGEYT3JU7ghhVNlyO3lJCNJlN9n+XJqGqFuBPxRzSs/amAy/hEzwQiEqnHOuVF4QkAQPVjoC3XVx5fApQbtH4S7EjVD0WOPGyFw2JxfuLqAzlMgV1ILo0ERYRIThVBelW8RXj8ehLGr8kCmhNtujF9fxzimZccdvPW8bq7Xch2kQvHIKHhI/xzwObOqGQRGA+a1oEH7eCwl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw1q7X6oXiSKh0FQj5RUEnW6c+E2y6eH2s+V68teA7g=;
 b=f0xVxBzQZ+WAnVjS5Ck/eb/pgZihStxqPxaLzGKUXsSECkye+UWQEC+HYDOyk8eTAtNZ1EBj4G40U0/4NNIsedBTcd93kvtNkGJrBiFAnoRuQVLvc5KEw+McCALplS+LOIfeyQeLuP3qCKY/Gtsqr1q+3A5l6KG1GaPPbGoVHxcWFWPVpcu29INT4t+wMsdwQAkHjxRJzIE3tVsW9OvxdqFvYEL9bMxs848dmwWCXHQus/1uvbPy+KeTm5so8rWnT7SPBU3prXw9nkYBnQettLA9Ytg/s8p7y2xxF0b2L/8chC7zvMSHq/wyxeNlZmjEoob/tZ2hSIrw32yqfmnphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw1q7X6oXiSKh0FQj5RUEnW6c+E2y6eH2s+V68teA7g=;
 b=a9tlH9Gw0gMznesLfeB9DCuSeoQuRkSDHqFUpaJ7XPNCn63gDV9dvoKIMOUvLIjWyFjm3VFDbKsIHAfotslqfynD33y7/fEq7ie7LhrQSLTSqMv/yPsMJsjPRYefsHleLKqYr11f4uD2QVqMKTXlVZ4mRvsMl4v3bZCBHd6aPaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Wed, 1 Jun
 2022 04:25:34 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%9]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 04:25:31 +0000
Message-ID: <089a240d-7419-527c-9d99-261920bc654e@amd.com>
Date:   Wed, 1 Jun 2022 09:55:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 02/13] perf/x86/amd: Add IBS OP_DATA2/3 register bit
 definitions
Content-Language: en-US
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com, irogers@google.com,
        jmario@redhat.com, leo.yan@linaro.org, alisaidi@amazon.com,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
 <20220525093938.4101-3-ravi.bangoria@amd.com>
 <365af18b-552e-bdcc-20ee-c6ce6e172500@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <365af18b-552e-bdcc-20ee-c6ce6e172500@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::32) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3ce1986-9082-4dcb-69d7-08da4386c3a4
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01217A07FFDF98F9FF3C4AC3E0DF9@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2z5hWst1098oahNVxXwdEj2z4ngRyxtww+y3BnXbAyjB0tJpN0ogxrYDT68ho0zwbhG1tOcEHKgn36hlHgGJAmOasvVciXJJXzbQbdniElOBNMxfX4NRKLrnm37twnOS5gLmZT69QkIP3YwJONJIXGIZvQiu+XDT8JOqXTM96AXrWPyAZrThnUH8MXw5VkhTTxo97/KACs/SII1y71SJQrtaOloNksJUp82H9JMv2NUnNlthpqjCNPaLXHCU2/H0Ti5j+FMos8j+yCtycdh+c4AalS1H3f5c0vodS7X/4pX7jnqGBp1EaUPfZJb9pPIKFqwhRSsCx8ltfWlPYGa0ckhpcIu+YKRedGdV7Wh9S4SYIOmJOQblWh7B2Ad7px5v2YaUSRyltfHK7adXLtgaMcB1MfgSrfxNv7pMMuwGcA6mkcGOrE7bCKJ35TM2YZvqjXEwnT7iKbGsc+fgd8YHYTmoSCqAn+2IdflblcMymw7fonPzYkEcJey1Xo08sv998+KK2m40PoIUzqYra4U7IrZTXXlu3zOKr8a9Wh3ZFNKD/uKCtnKmZbEL1RJaTh3BNOe9m7oPkYz/pKSvI4nvvvGb5CvIl5U0W++NeFkJqvboONwhTv1Xl8893DOeQd+E7L/BUmwhYVGlfyIsBRmAm/Fm7PqkcHS129vR9FZUk+OZFytQ7I5ttpHQzBNebdwmWk7JWRaYKfgbgYO1U4RNbVKK2GJxM/j5kCgyzejHXSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6862004)(31686004)(66476007)(83380400001)(36756003)(37006003)(66946007)(31696002)(186003)(2906002)(8936002)(38100700002)(2616005)(6506007)(4326008)(8676002)(66556008)(53546011)(6512007)(26005)(86362001)(6666004)(508600001)(6636002)(7416002)(316002)(5660300002)(6486002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skk5ZzNscjE3OFF5aTBtQS83Y3RJbmFpWk1rK3VjNXJYeVVuWHFJVTlWSjdK?=
 =?utf-8?B?VnpkQmdzVkdCdzZVU3hUbng3R1JEM25ZQjU4S2wySDBmMCtOekcwZkx3V1pn?=
 =?utf-8?B?cGM1Sm5QSXNlNStIa3NRUXFwdm1CS29FeUdad2ZSOWhXSmIzOU5ueUVVRHpJ?=
 =?utf-8?B?QVZEWEZ4UkwyRjFtdXlTUUp0MDJGWUtaYW9HY3NwcUZuSVNJWWRRaktJbDYv?=
 =?utf-8?B?YWF5enNaOEV0djVTTUpBanFHYnErTHdHUGdlc1FHVC9zYlMzN3QvRlg3OVV5?=
 =?utf-8?B?UWYwQmFjYklpM1BPK01uUmFvdkNqY0ZZQTlYYTBCWHNTQ1Q2WDJ6Y3lIdHJi?=
 =?utf-8?B?emR4RC93SzRnQ21sT3VWK0xsK3N5anVoU3ZObWdWWHFzOWUwNUVHSTh4Njl0?=
 =?utf-8?B?VDd3NEljZnduQ3pCSFRPSGlOdjFFQmdpZ1lHNVRFNUdGY2pMUFlXTVZMQk8w?=
 =?utf-8?B?VG92ZktEY3ZMZUU3RmhrYytUanFuUG1uSDF5KzJJN2VYQlNBbm5CSHdFYks5?=
 =?utf-8?B?dEpFNkVTZTlpQmtXT3lrWHhnWUV4MFczemhKeFFqcC9FU2ROeUxkMWNZTmtq?=
 =?utf-8?B?TWp1Q0pLUHJYVnJBMkhwVzZ4K0NWVjJxOVJsK3Fubk1uaXRmYVJQY244Vmth?=
 =?utf-8?B?YnBvdWQ2UEt3dkN6MlgyWWRrT0hCMkhLWnRQNkhZcnN3bXZCdkVaaGJPT3Qz?=
 =?utf-8?B?YzhKS0FNSUx0ak81eFpOMU9LMmhEaWNNODExUjJyRkdpcGlOZmhBVk1EbzdM?=
 =?utf-8?B?Qk5nYm8yVGNLazBrUUlsRFcxYXoxNjU0R2o2ZEhwOVBNTTBPVktUZWNhWDhT?=
 =?utf-8?B?ays1ek43WmZFMUZKeGtCbW5sUEtRbDVRWk9veFNZOVYzRjJicUE3STdhc09o?=
 =?utf-8?B?d0h5QTllU3BYRlNDNElXSWxtOTNLYVJ0YjVtMW9BVTJFdEZpNjQ5ZmkrQ3Vw?=
 =?utf-8?B?YW9OQlpDRkNHMU13M0pqS3Q5ZUtCcXBxVTdFY0E0Qm9Yc0R5c2tUWlFYS3Ar?=
 =?utf-8?B?MStXRUV4K2RhY0ZEM1BacUUxeXR2OTBkL1laOHNveVJTODZJcHpEWkg2U1Fm?=
 =?utf-8?B?akg5VVd6dVI5a2ZRMFBFV2VzdVlMTjVPM2tBeWF2U0pYcmZMVDFzbE43Wmd6?=
 =?utf-8?B?Rk8wU1Zxa1grdjJRby91VkwyLytsb2xnWGRBYjM4cFZ1bVBodXA1K0pORTJp?=
 =?utf-8?B?bnMyMG8xMFdxMEVGd1RiWjRQRjJSUXB3K3lOcHhHQ3RKR1pKaUF1R2hUVkFq?=
 =?utf-8?B?eXRqZGVxb3E3V20xYTlLc3BwdnBIUU1OdXZKZWoxcjFkTGpnSThybld4WjZZ?=
 =?utf-8?B?aDdlc3cySWF4aU92d2prejVJSkZKMVF6elowRk10UUZCak5UV0NZYjZoZGpX?=
 =?utf-8?B?U082TnpRc3BoVEdVa3pWT1JPTUNpb2pkNUJCY1hadjZRU0Q2OTNUUVNneDJ4?=
 =?utf-8?B?YS8zOHNYVkM3UHJiS1I1RHZrODN2VEFJRysvS1c5UVJRVkFGU1UwazJnV2l4?=
 =?utf-8?B?QWEvTGRXaExiUHNHdC9uTXhVSnBGZkFPRWJsL2ZqUmtCYXIyOE5IM1BKanA4?=
 =?utf-8?B?elNlODB5ak8zYnk4dWJ0d0hZYnhoUGVqNWFlN0g0WERSalY3a01ia05LWmVY?=
 =?utf-8?B?THczYk91NFlibCtza29xQndNc04zSndzeG52ZFd3MWd2OUlKVmJjMDRySytt?=
 =?utf-8?B?WVZ0K3NaWkVSOFpoaWxBdG5FYllpSlE4RVlDdUhsV3BSUXZkWitrNkRrc0w2?=
 =?utf-8?B?VWJnR0VCcVBhak56RWdDWmFkRDBPVDhXMEM0a0R1cFA4TzFGbnVpMXpsMXU2?=
 =?utf-8?B?alZwNDdnQWllUG1pRXdrcmdraGZOVnIxMTR2VUdURmdLdm54OEFwWUZlQ1Bk?=
 =?utf-8?B?YjdiQm8ycVlsc0tGZGxmYkZ5WStmMDZ4S3IzdmNoZGhWbkZXYk5Bd1piV3Vu?=
 =?utf-8?B?S05ETHFkSDJqbHpRM3pxZ0lycmVMVkJIQ04wS3puMEM3SXJFM0lHaENXWGxt?=
 =?utf-8?B?aksrTitDOTg0aHZqaVlyOGU2RTVlU2ZzcEw0ZGR6VGlpS1c2M0wrRXhtZUJG?=
 =?utf-8?B?bFl1aUJJVWtvaC81aHdlK0NFdlhmdTBUREJWR1orWnRRNjRqd3BZZlltZHpJ?=
 =?utf-8?B?ZTcrb0ZwdFFZVFhZK0NSdC8xZVZFR2xYVzRLb1YwUncxMTJna0NhUWJWRUE5?=
 =?utf-8?B?OTh2TkI0c0V3M0wzYWhpNEcxMnhVTTh3dlVqalE5MzZMb3RPT1d6ZzI4TkFk?=
 =?utf-8?B?aS9KRGZPaHFCR2JWTitocHRVRUpCZjZjQ0VxYlRlb3IyZGNQRlJ3VGgvbjlV?=
 =?utf-8?B?bkovSk85THhpRm1GR3JrczZ6cVRSalhZbHVlZjRoMGlyUm1OQVNqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ce1986-9082-4dcb-69d7-08da4386c3a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 04:25:31.7731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4OkDbtF/J41dZJ4NTdwFO4o2CAHc8wXn4/o6xm+ocFiCZHAXil2fyuMh/sNGYtHIIFwe7FXb3O9yHzKED+8Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

On 26-May-22 8:38 PM, Kim Phillips wrote:
> On 5/25/22 4:39 AM, Ravi Bangoria wrote:
> 
> Hi Ravi,
> 
>> AMD IBS OP_DATA2 and OP_DATA3 provides detail about tagged load/store
>> ops. Add definitions for these registers into header file. In addition
>> to those, IBS_OP_DATA2 DataSrc provides detail about location of the
>> data being accessed from by load ops. Define macros for legacy and
>> extended DataSrc values.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>   arch/x86/include/asm/amd-ibs.h | 76 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
>> index aabdbb5ab920..22184fe20cf0 100644
>> --- a/arch/x86/include/asm/amd-ibs.h
>> +++ b/arch/x86/include/asm/amd-ibs.h
>> @@ -6,6 +6,82 @@
>>     #include <asm/msr-index.h>
>>   +/* IBS_OP_DATA2 Bits */
>> +#define IBS_DATA_SRC_HI_SHIFT            6
>> +#define IBS_DATA_SRC_HI_MASK            (0x3ULL << IBS_DATA_SRC_HI_SHIFT)
> 
> Is there a reason we're not using the existing bitfield
> definitions?  E.g., data_src_hi for the case above.

Yes, we might be able to use those. Thanks for pointing.

- Ravi
