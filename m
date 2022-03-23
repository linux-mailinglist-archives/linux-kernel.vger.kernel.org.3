Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141064E58D2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiCWTC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344101AbiCWTCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:02:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7771863BC9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX8NesBbpgiAC/KwOVv+oQaUciS++FtbAowalLh+JhheN+ObTVokz7himGrYlMfxcXr/SyM4M1aEowCF864IIWbVgltHZZ4GOr/jpWsK0OkoOTTdkCAWbEW+bdhWL0ueHBuzxDMbq6saBqchFOSKo2Bd5QY0CbuC7Bcib0iwJf9V0LRkuhV0wXi0S3Rdafg9yvdCZnwT0PNxtSSVVQEkyGpnd0d78sVQfhcAulPrnOP0SHCkrlcddOreE2iZ4OPrNLX0Q5YB/agHj0fS8J7GYjDkCYI5t7PvRKfoYcp0wkQ0LVYWMoZFcYewTLCYS7fx63ozC0U5/kiME9MCrH0BlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65EBjRHI3D+MZGjiujZbSXzDewNPRv2UAPhGKRyIOaU=;
 b=Ho0ldWMRYGUvwwy+A99gG2OyMw2u66+Pc6hSMan6ilwREebDkbgYm/ZoFtEKyYq1x1QAyZIxMULAHB57ShG7Um8H4BPrIUMvvmWcQq+TN4p9+9Ugo0S2P8PplFo4rPkKZ7Bq3T7Pa0EMKVF7nMI0srmotNZ3U19CwMd+RW0Qm7rufFSHn/oJf4jsdT+li6jA4pbBqGtAwbEzRFJ2UcrhoO7OfPJtLn/3bX+DIlWqbXJxYqeqywar+xowh9YkWgpVBvHtggnZzhFIagSd75qJK52ug5rYSgu+K3iapg/2K1ubOZQLgyvIuRFknunAV93V/UB47+IZwhEr7YfYBYhLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65EBjRHI3D+MZGjiujZbSXzDewNPRv2UAPhGKRyIOaU=;
 b=qagilhxUe9vlphpVFXrP/dxu2CZEmu18wB/3+4zHq/xTFi9H9vE/crYVnNj/JdWTlSYZRSjDVlXXmUB1hJ6/C9h3oLX0pva/k2aei+7DYVhUnAc5Kb1/WPH7WCIppals9f3RCdPewPK3A3+pCjRoYDlq6Y+jOBvfrs01WR+KMfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by CH2PR12MB3831.namprd12.prod.outlook.com (2603:10b6:610:29::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 19:01:14 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::58a:6fe1:a781:a86f]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::58a:6fe1:a781:a86f%5]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 19:01:14 +0000
Message-ID: <981b55a8-b5a6-6353-97f6-f94d287cd583@amd.com>
Date:   Wed, 23 Mar 2022 14:01:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 10/13] perf tools: fix NULL point in evsel__env()
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, rafael@kernel.org, ravi.bangoria@amd.com,
        sandipan.das@amd.com
References: <20220322221517.2510440-1-eranian@google.com>
 <20220322221517.2510440-11-eranian@google.com>
From:   Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20220322221517.2510440-11-eranian@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0132.namprd02.prod.outlook.com
 (2603:10b6:208:35::37) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eedda8c6-3853-4749-9e70-08da0cff806f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3831:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB383147E151F8A3D24C70720A87189@CH2PR12MB3831.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9x//BpMIB7I/faL7hxQeXVcAcBUeiUi5SdkwT/WNrXojzwNLDWAdOLhA0+sM8PTPw4iClvSePgqZI0/KhxJIJZBa9784V9m8l0GeFPEkE9iiMLrOBHJzMWty4MNi2x6QDCYwI1dI0y2bR1nzd3qYI2rC3xAWWMEDGEGHbbAi0rpttb0DSxjHFKycNawoUVfFpkW6zlZ+Mi/I4eeyW02f215w7/xHQCUTwA4Ip9OlH5WzvyB9wAzv6W6guwyr5tNlINUWpfgsJq+d/kVoGlUkNYV0QIA3XWobwvAZGsX+sCcTNe10Jr5D31KRv7HcgC00T5B3jaEa/MVvDTusx47CdmFWoJok4ZZvCPXfriyU24bLwLjKTEhP9cSZMj+Ph4donH0RStECIanr3SwwGP2RVUWT1SzVEv+ynnhkG2S+Z41bWux6Beh1vYo9+unqZ4qeJJQLdacCZQ6sMZtw81cvG1y3W95+vDCQol1jxsYAXo8zepbS+T7RSvLW3Es7S7OfurkB9pYdobhxsq50oDsBpQVXa2QCBoO9CZHR2O0b5AOvzxz1ULaNV6ZhQR+VWvXZGggLnFShNNRYNfMzvXyWv4kHKWfCQqYIvtsmeZyeXqDICKtsFntHMxZRnZ/wTPJxvmSMBJ+Zp/WTuReUtJm1kIG2WjI2JREYjGwM9rNeCDHa4nfRfZXh27iHTR441v6v/G6lQdH1Z5exxgKqIKqLor/QZWFW6nSFlXran+e1PVib5PVDR3JbRg6LlvZhkfFGnt0KUmxLSeYco3bkboJPUZtLIjrdNR03P5VPi+mSN/0K4LjYFF5GylyJZSSktjhV+9ztXHI0hydz2Sln8UTyObEpv4MqNcRlX7iN9ZfiPwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(186003)(26005)(6512007)(508600001)(966005)(2616005)(6486002)(31696002)(53546011)(6506007)(2906002)(6666004)(86362001)(4744005)(44832011)(5660300002)(8676002)(38100700002)(36756003)(4326008)(66556008)(66946007)(66476007)(31686004)(316002)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDM4TDZzNFRoVkdkYjlEOVp5SGFWRmdha1ovNDFWcFA1VTVNSHZDTjJOQWdi?=
 =?utf-8?B?TVhoNWpFRVVXdVZib2RVUHcxRjRweEVrb3Y0QWJYdDRpcVJKNFMyd1RoS2U2?=
 =?utf-8?B?Zm5IVEtYanVrd2NQb1FYS0Vndm13ZUZRV25DcmNYYTVTU2NXV3ZHVTIvT0Jn?=
 =?utf-8?B?OEZBaEdPWkQxbWw1TWJBNGxtalA5VmNOZ0k1dUs3UzRid0xyK2hjMEpUUFha?=
 =?utf-8?B?T1NnS1d0dVozbmhUZFIzMXBYMzJNTW9XRHdqUXVJekdsbFJ5L3VOZ0NmVFBw?=
 =?utf-8?B?SWdOWmRjWUFHVk1wZ0M1VGhBaU9ObnRjVURkMS9tK2I1TUZSUnJGendJdWVt?=
 =?utf-8?B?T0hiQnlwc25HZ0QzOEhOcmhGcE1sTmJKbjhjTTBMSnhnU3p1RFAwcUEydFpH?=
 =?utf-8?B?dDd1NGwrZi9acWN2WHJrY25nSHBkNVVGeG92UzFtMGtaV1ZDdGNRS3VicDBV?=
 =?utf-8?B?aGY1OEI5TWtJUnhROWRmS3FRaTBxTVRMQldtQkx4SEdhN0l6bGh4cGlPN284?=
 =?utf-8?B?dWFpc1Q4ODNpeGZBR0F5dGN4aS9GaHNnc216SkxramNQaCswUnNyRnBXaURl?=
 =?utf-8?B?aEFoK240WE5sTjBpdi9ScTRnL1V5V01OTUhibzVhYk81dWtVMmxNODd0d2NO?=
 =?utf-8?B?eWprK0YrZTFQKytlOXRNemRvR0FCRlJST1N3SzFSbXZtdGVVcHJJbzNwQ29r?=
 =?utf-8?B?OENzeEREYUUrME9QK3RxaW43RmJobENOODZ6TmN5NThaTXkzUXQwWXN5UVRP?=
 =?utf-8?B?SFJkQjBodW84RVZZTlNiNHhVWnFxSTAwODBSb2Z5VFpOdk5RT2ZxMm90M1hR?=
 =?utf-8?B?ZHpoOVZ1bUE2WnlkVjA4d3UwY2V3eGNDNUlxZmsrTXhIR2hUTTdlK0Ivc2h2?=
 =?utf-8?B?U1Q2cGdxYjE4M1pRc0lqdUp1eHpWRGxuUTBKQlhIUHZrZHF1ME9nNFlhY0RR?=
 =?utf-8?B?Tm1pTTl5VnRiRmN1MWJxYlpSdXBMbHcvakhlYlNLR0phN3FBSU9FbmpqYVlU?=
 =?utf-8?B?K1hPSW5mMVNrUlRrWElLUjMzUUwrU25EMTU2T1dsTnVSTGlNalFIUGc2TDdv?=
 =?utf-8?B?NUJEdnlTelYxQUF3UlI2SXdoSHB5elMzd0dHQVpxQnR3SG1udit4d0hITXRn?=
 =?utf-8?B?YS9CaHdpY2Vlc25DOGlFL0ttNk5FSTU1b25lWjBDZXJGdG90aWM4RGtIY1hX?=
 =?utf-8?B?MUdZUHB5M0pEciszbnB0eFVyQmdpVVNlMEF6WENCQUhsaHllSXZUbGJFcGpC?=
 =?utf-8?B?ZE8wT052b0hmUHhjamQrRWxJU1h6N0lvUXFuNkZhNGw1NUpHTmxXckJ0V2Rp?=
 =?utf-8?B?M2xOQzlaSi9TaGtHZ3BFVUlOekhWY0NpaHdxSDhIWEZoajd6enB5S0svdEdY?=
 =?utf-8?B?RWVkWDJiaVBvbERHeVV1TUd3MTlRUFBNL2pyV0hENi9vMFJHQzBPUlpsbDdC?=
 =?utf-8?B?Q3NPbDVrUUFQYy9tQ1paOXFoR3kwaEkrOEVCSUI1TGhZa3VMZXJNcERoSUtU?=
 =?utf-8?B?V3JoWlhzN2tZRUtjMFV2cEVNaXdINFVnSkN1YzNZRFpEMllYMGg0R3FVcDd1?=
 =?utf-8?B?MnQ0YmxYVmRxMmF3OG9wOG1oSnF5czdGdDA4MjRsUTI2N3k0ZVRvRTNaQ0Ey?=
 =?utf-8?B?MVBtclJGZVdjSllVNDNUZ2czWmNRbVR4cU4zNVNjV3JmQ1JGRkdaV3lDVjZh?=
 =?utf-8?B?Q3ZpM0xFN1owcmdmT21XZitKaXZmRDI4K3NoQWZEYmoxQm8yNGRiQmM3WDF0?=
 =?utf-8?B?dGFoVnZSd2psMGxBOXQ0NEt6eUtDVjAzN3pRTFpGcm1TOHpEOFhYUlBvSmxn?=
 =?utf-8?B?am5sRDE0Zlk1MVJ5Z2ZqRFJLdTR4K013OG14dWhpOWE0RDE3V0F0Y0UyU3Zy?=
 =?utf-8?B?eVV2VEE1WmlLWkY1dmhpK1pqN0lkbmtuaG00cXBTUm1nZThYNm1IOS9taUZs?=
 =?utf-8?Q?Thi2Rc0nqrkJmzM7dCbEippQBSmlpj+d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedda8c6-3853-4749-9e70-08da0cff806f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 19:01:14.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+wYO6CFbzCMqcHOo2OYNyBwCIvToGP/YFGaybbrz7xio/Hgp82esInNwN5U1udhfbutnqCDOrgbbNc0FEShVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3831
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 5:15 PM, Stephane Eranian wrote:
> evsel_env() cannot return NULL. In case evsel->evlist->env is NULL default
> to perf_env. Fixes crashes in evsel__open_strerror()
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Reviewed-by: Stephane Eranian <eranian@google.com>
> ---

Signed-off-by: Kim Phillips <kim.phillips@amd.com>

FWIW, here's a link to one of the original submissions:

https://lkml.org/lkml/2022/1/26/1220

Thanks,

Kim
