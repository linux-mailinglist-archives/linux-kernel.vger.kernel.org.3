Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9EB53A652
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353385AbiFANwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344238AbiFANwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:52:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA232F3A9;
        Wed,  1 Jun 2022 06:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYUKZ0i/kAE4QEMT0A6qm8Y6FDJTssHzesz+/jQLbdPDs4Ut9f8xJxoJJRxQXwZLn4x4S+gG1mY3IpNJq8JjnQKCyGi7cj1N6Q676n2CJmtchlfOCxSm7wlX0yUk9H4D92y6dzXZ7FSzz+YF+5K0Om1/9ViJSZ6fH9qVkeMjR8J9SRjv3kx+65rg5ZV/TA0Sv/VSa/6XV21rBWH3AxtkOIaXkoai6Mvo+P3CzT6QzPYgFVUGvdo6O6KD1ZqeoVCLbYTBmMyEUAd8897GqFBRcBCZWwTkzdZ8EAv11DOH13tJ/4spAB2ZZs13wfjO4co4uO/xqaGGAOGk+PEgGczXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX2L5RWvIepWAAkaBLitv2XeMCpG+NFVl4GVIinzA14=;
 b=hMMhiKfwQIWOuFCvdy/uMMX2cTYYIMTpC3tkEPeS0UnmwMZPJjm0M+fkuGwwt1ho1tMAmK0npQOO6IjmyDgx3Xfd436ClBnzbkmtYcqfJKNkgkXbnnmB+PNNxsa6umIhcSrbGYv/dUVw9Ymvz4X0cZUEjjfnTLREFdwlgX8oP36TuxhAaloxgYumjns7LFQZ1oSyfGuy+4vKWAMwH77wX7qZ+doBgOcqGpuygSuy/qINqPad5TD+ETOOb4xP6mjde+b7iU9rHcbHJ5GTkdeusxcmUpTvYu5Ra5XtIBLcOpLSvuam/OFcXZF9hnEk5SFizdqNcYqnm7sWeo0SRUIkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX2L5RWvIepWAAkaBLitv2XeMCpG+NFVl4GVIinzA14=;
 b=LM0baPwWExJpjaf06aTpTv9TIaNwlQzx7eu57s2aAKan0Apo97g+evyiJCLYz3YY6r6Fd8G/9KJ2hVD0B+NkYJVxkmvk9+MdC6sp372AnOk0b0Neml8NXFsgiaCSA0fvDsriQ1sQbDKUyBeMgiKaaggtvJerJRJz3raLKNJuXdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 13:52:16 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%9]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 13:52:16 +0000
Message-ID: <0c795f97-c582-8059-fcf8-82b43239f0d1@amd.com>
Date:   Wed, 1 Jun 2022 19:21:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5 2/8] perf tool: Parse pmu caps sysfs only once
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        peterz@infradead.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, james.clark@arm.com, leo.yan@linaro.org,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
 <20220601032608.1034-3-ravi.bangoria@amd.com>
 <47584a6b-20b9-9a3d-3125-d9fe848cea54@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <47584a6b-20b9-9a3d-3125-d9fe848cea54@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eb5a831-2c12-4493-c5f8-08da43d5f003
X-MS-TrafficTypeDiagnostic: DM4PR12MB5843:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB584382A813434629BC4547B7E0DF9@DM4PR12MB5843.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODWmw2Y6fZDn/bY15HXxUUGpgCF2X6f+6No65gnjzpf61+6BoExIjAV2Hgz/1v3IqKh2QEOOhQQ8yj08Y/LPTJ3ohaiKNTe+qCFCB4XYFVEgavUMrhraD3olRN25gFXk9Ie91ykT0L2Bj0Yogr8gKSJPDjAyvnp6KbpsPAKrBAKAAKqtS27xyYHAV4E13lHiivyQ3SDC/Q95/FLAP29Ok8Qi3xVH2LwwpAVfii+7IcogE3lot2O2+V0es6n+kIvl5bve1Fds+aoHQumlh88/QEhCBtLs6m1P/oyK1UPJQ471pGi1UeTmvrFSa4CZMfTtGcfp//jJlQpk1SMJGOWmQHHuc+Z4tBDKxj0gmLk3PwBzv6g7LYCFg7rC1QBMnLDs1gzvRdPHkx1vMzVaci5flUabM6YyCZtjLMHIvZrttso6kwQok22rAsuz4qx+lm0wJgyvkAj2shSqdpEjiOoJ3pbke5vzQVWRtzds+7jLRvdibAur79VdMMvPQssYJ3q+X6+5/NmthxgCJtlSAdGHmVqjI1+p+Vguo9EJh4sLWZSACIzrsPH4s7RDo3/UW/mRjwYr3UHC/qGX6x0qaeKWe7F9uE33/BtuCRGZQKOl7BoDa/lnsE4oX872FSdN3QgiRFS55XeSV9gt2AQ2mb8ryVyUv2wJqyZMikSxSXbdnUi0xZjIjGJse2IIx+XH9yxSemBrvqFZAvX3aWTNCsRlBx6kElTd6/0WPyQw8EvmQ5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(86362001)(6666004)(8936002)(186003)(31696002)(38100700002)(508600001)(5660300002)(44832011)(4744005)(7416002)(6486002)(2616005)(6506007)(6512007)(26005)(31686004)(66946007)(316002)(4326008)(8676002)(66556008)(66476007)(36756003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzlUaUM2L0JJMjhybHVOV0ZudmpTVndVTWVxdXlUTmpYTUUrSkJRc0Q1YVFk?=
 =?utf-8?B?a2VXYVRZL0J0c2FkRUVCSG9UbWNlQjVXbnE5RjN6RW11dlRNUyt1bG5LZkVB?=
 =?utf-8?B?eWFlUEw3eUpldHp3TmZabGQvbERaWkpNK1RZKzd2Yjh0Sy9aSUdZZS9JTTY2?=
 =?utf-8?B?OEN3K1BtMUtjZ2c0TWMvY1lNa0Z2ZzB4OW5KMFRSek1XOXJtZHowTFhRZGc1?=
 =?utf-8?B?VTZncXkvZUJtcWtkNTZaM2ZiYTBQYnRoS3Y1QlQ2TG9FTFJhY1RSQWtRaGxz?=
 =?utf-8?B?RDY2bmphc2k4Rjh0QlpWWi92bEJiWEtRK01kV0F3KythcTZYTUp5ZHRBOGhl?=
 =?utf-8?B?Wk5oWitDd2Jlb3R3R1dnUzVNNlI4YkFFWUxOQ2R4Zi9JYkVQWk1LMEE0dWZt?=
 =?utf-8?B?Ynp1cy9xejRBM3p5dkszSmM1cWxFUUlKWERmQ2RpQXVmTUVaV0RHOHRCeVNJ?=
 =?utf-8?B?cXU2TkxUVVQ2NUNvTGVPSVNOb3FzQ1dxakVtc3ZXb0hadFJYcXQvTWRxZnRl?=
 =?utf-8?B?MzgyeFpwWkpKV0xUMW5QOXRFZDk5c0ZYNnhQZVpHQzlteGV0eFpDaTAxeEZE?=
 =?utf-8?B?cHJHRUtGOXRKeVQ5cnVRUFBOdkhWR3MwQzEvcDVaNkJlTEc0ei9xRFpTVko3?=
 =?utf-8?B?OElOMzBzVG42Q3FkWHc3cGd6ZWc2UUxaOXFpUlc1ZEIyZnVBdCs5azUrN0pi?=
 =?utf-8?B?QVJCVkQ1eVppUnBRb2RObXJnWGpkTXRnNW9LRHl5ZGlaY2J5azhsN0sxT2dt?=
 =?utf-8?B?cWc0enhRNi9HSjRMaDQzdkpuYU9iWW1lMnV0ZFBCWitHZVQzVUdBdDQ5UjRa?=
 =?utf-8?B?Z0FGVFFKTG05ZklaRDBkOWFrMThZampQNnFUS2NPYzV4c3hTNkRqZ3NDZ296?=
 =?utf-8?B?N2wvS0VWNFI5OUl0UnNBU2VqWFZ4SXFZT011em1Sd2ZndHdDZ0VObnhCOUJi?=
 =?utf-8?B?OHVKVHViMzA0NGU0NzV1Tkw4R2RMaStJRTNqVEFyOEdmeis5WmdObVFCNVBs?=
 =?utf-8?B?VXZYUkVPWDQyMUsxdkh0Mi9wbGduNy9lZFR3U2MxaVhCUTg0VGE5cXBWUU1m?=
 =?utf-8?B?dVFhTktxelB6Z2QrdWVCT1dIN0ltSGJndGpZcnJUc1ZLaWQ2TjZUc3FZVHRE?=
 =?utf-8?B?dHNxWWZSU2EyZnlOaGt3Vlp4OHR6V1NnTCt1WmRaTmhxWUlQRm1SVmFFbXps?=
 =?utf-8?B?cnBqbkI3Y3VqMjhuWk5CU0VDSHJJYStRUkF6bXVFbEM5dVptNm5PYmZRbU9H?=
 =?utf-8?B?aUlQYUUxWDhmMkNObjJmUnZXTHZXUENmNitmNkE5VmR6aDg4T203Y2trT1VS?=
 =?utf-8?B?L0xlbFRTS2lFSFRheUg2c3BsNmZES1lIYlF2MGE4dGk3RlpmRmlLeTJPeWlC?=
 =?utf-8?B?Z0luMDNTWGtpTnBBbC9kZXorRW1ZNlBMZWdNRkgycU05UUlXeVRKMGYveVoz?=
 =?utf-8?B?MUhseHJvUzlZN2kweHNDbUNiZU5xVWtUa0VxTDF3a2FaUEVHVVZQSklRUy9n?=
 =?utf-8?B?Y2h1dUhhWHNuWXFCc1U2UWxETXN4WkNtT25MZDh6RG56OXYvSkpiQWJRY2pZ?=
 =?utf-8?B?TlVWNXBVdzkzTVBNWmFnd2lWMktWK2d0V3J5d3RiZUFocWI3djVZMDlGeCtB?=
 =?utf-8?B?L3pFTzNpV05WSkxEYmVIQmt3WkJLSjQzK1crT3pDNW1hQis0SmpuRU5XamNq?=
 =?utf-8?B?M1Npb2o4Y0Zyb2huWU5wTDhTays4aFc5RUdQR2RsY1JGWjQ2NVJKK3BsTlZY?=
 =?utf-8?B?cHZGSDZOU01QMXpJbEtXZGR4Wnl1ZW8ybnUyMkdoN1gxcUowY3E5Nm1kZXRE?=
 =?utf-8?B?Y0lhVHVNajdmOGF5OGt5YUpoNkVwOWF6M29KamJEcFBxdE9hQlJKZU9nZ1dV?=
 =?utf-8?B?WXYyMWRhZ2tCS1hsYThEYzhVbXJaTFNVa1hWalRKWFRVRWZzNXB2aGVldllt?=
 =?utf-8?B?RGxXVUdPcG1TcHdaU2grVHZRb3E4M09vYVhKUTdZeFdvTGUvTXNRQTFGUlFr?=
 =?utf-8?B?UG9yUnZVUnp0WW5KOTRoQkk5Z2h0VWFmcmtlTjBQeEhZV1NOQmp1M1o1T1Ri?=
 =?utf-8?B?aGRkTVNCWnFwWklkVDlNM00wWHI3MEpzOXRnWEdzK0s2OFVGZ0REVnZDeHdt?=
 =?utf-8?B?cVZaV09ZUXpFbFpML1RhcTdRSkhVK29oSGVtc3EyL1NaMG9uVUJmNUorSlA5?=
 =?utf-8?B?aGlldGF0QWpWeWl5TGQ1ZlRta2hUTXpOMjVYTTFGVkszTE9RTmNFT0d5NFN2?=
 =?utf-8?B?WFFIK3JsV2NDTEpid1FtREZnb1h6MDVOTEcxQm01Y1REK0hud1lldlJ6MW9u?=
 =?utf-8?B?QVRBb3E4QlBacXJsM0l2R2Z5UDl4STJZbmRVZktGU2tBZTR4NkJDZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb5a831-2c12-4493-c5f8-08da43d5f003
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 13:52:16.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydNxI9L29CFmx3xf5P6FXDOZKOA1MKansPDmcItRAbXjMQp+2EPu5PNnu0RExIINiSphycyIck6iRcA7fpI+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

[...]

>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 541889fa9f9c..4b45fd8da5a3 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -46,6 +46,8 @@ struct perf_pmu {
>>       struct perf_cpu_map *cpus;
>>       struct list_head format;  /* HEAD struct perf_pmu_format -> list */
>>       struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
>> +    bool caps_initialized;
>> +    u32 nr_caps;
> 
> If they are just used for the cache purpose, I don't think we need to add the variables in the struct perf_pmu.
> 
> A static variable should be good enough. See sysctl__nmi_watchdog_enabled().

These fields are per pmu. Static variable won't help :) And they are
used in subsequent patches as well.

Thanks,
Ravi
