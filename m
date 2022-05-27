Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B52535793
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiE0C36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiE0C3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:29:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEDBE52BF;
        Thu, 26 May 2022 19:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nd2We91IiAutqXa7W9m2kX4LjFiHuLrqD03WVN4m8ei+wrWHZMrbkgXGxqieDPrprCRif6NI+5xDS5TZSBpqt/zTzRGjSL4n6KfItRhumRG1IYi0SfAVxLltI3+iHmoFilQsDkAG92itIrBvbwBdjD1Gsx6EHOUdfXb3G68SdcYg25ZOoG6xHpZl0c0vo8ONBNoRt7fgXYM+9V9zZAs53ChbskOnpmbf19EcvX4MXn4TrxZaGoTLA5wOrHEuWX8fMn4XdEumS2Q69ofRQT50IVLA8k4y2AnsAgBEuOQeN62CYXIQSR+/Ze2smILHy3MWzrk39KYOBu0TqAA9V7w8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taAb844CzXAnwMVxiU0CCJXxpTisqGHhA+O/iSabAZk=;
 b=X71MziBWqkZfV0uVlZqGoK3n4KoduAYKpD1KV5KgNXc8eFrBt6QwPmpWN1a/FJ2IL1o7WajzjF1Jski7GDQ4gOZQFYBZg8CWB7SiTUv6wGvLJ9encn1Qg3ej5xwAA08fT7KhL2Xw2WU8DJzQi4y2YRF+faMI+8dhggo6oPzO2VVihSgHVCW5vmtjZUEScfqLs9bzp9V3uzZndtVo2+LKHHbeF6xXhVQxe7b8c6+g+8m9wb8r305bXHmHVPMt+zFSRnrrXS+D3KavhX6Lv673sVCab0ald0+VLb8j6reDm9cMDTQUKHEDiqE2qgCRWJe0ebZ9Ig7w1flXqqVMuKS5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taAb844CzXAnwMVxiU0CCJXxpTisqGHhA+O/iSabAZk=;
 b=y9bG4Q/toOUH0R5xzg09ecyFEzP0DYN0ou79/PDTogj4EbWs4r4GeIElWOE6knaUAxPRlMiA89YshYB3QbaDVUKI0Yp2Pc75U02Km8caoN6Q4XRTDikfgaDUBdmCZxX7tO4KkZaZI+xjUuPl1TiIFX02PUb5uWDq1LBz/8djTGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 02:29:51 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%7]) with mapi id 15.20.5273.023; Fri, 27 May 2022
 02:29:51 +0000
Message-ID: <de389d34-22c1-5c62-d6c2-bfb256924a97@amd.com>
Date:   Fri, 27 May 2022 07:59:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 3/5] perf/x86/ibs: Add new IBS register bits into
 header
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org
Cc:     irogers@google.com, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, james.clark@arm.com,
        leo.yan@linaro.org, kan.liang@linux.intel.com, ak@linux.intel.com,
        eranian@google.com, like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
 <20220523033945.1612-4-ravi.bangoria@amd.com> <Yo+hbx9c/9FoaiJN@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Yo+hbx9c/9FoaiJN@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2be73a95-c592-400c-5974-08da3f88c6da
X-MS-TrafficTypeDiagnostic: BN9PR12MB5082:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB508267AD50762C9AACE7C89AE0D89@BN9PR12MB5082.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kd1+Pemut+Mg4scaYE4L7xrqhFNQluY1UfhoOTgkWFRpascwuMqSTLZxzH3dzujxjvCyIl2iqh8Fjav66FJ1WybUeLyP05m4RN9RKxV3H+nR4rwFiO+25jqGEDbQM6wyAD5HmD/Os144zf1jo+MrJ17mit4X2a2vHvr7YodKQSKDsqRLhdQ0a5e4QwYPFC5eLHe3834WEIhb31PfbgXCqH598QDaorCe8mmGc7YAmZaZSxJYZys3zvhl/6f0YcYH+QY+eeBSuKvypSjXKZnIZtVol09ojSXaKkFrgBJMpnacyNIShmeprfkwjF/iaNONH0Znf4aFsL0R63bsEdhPh9h5T7PS2KVi5EYm+E22EBYIh7GlrgRvdj0wiSDdbTNyOPONxXIlTgPQMwPLnHKVNGGNpHwf6XxcaC/fu3yw88+Se0xDa0K6HqQseN7wzrJPE6Jcz7xCk3giSZN0hQpQtObv3evQwdxqYKusOvbBl2Nb3wI7Dx3zqNEmSk4P0ZaScBGanzGmRtgJaz9g5waD6PEHPmQvY5WZX/dgECeZYkVVwUpcyc6ZaB5fwG8cN2buqNzauOPc3CLCrGvMvdkVSQ2A/HYqAQfso9b2RadNLcNNBFgIkgEX0lr7v5OLPpw04bMn+LiPpm8AFn9DH2Ym+5ls+FotbJzSFa9dFpmreMjk36rCdPOFeCTfJ3i4wVA7ILNsRreyi3ejKk2LqRoPqrCvwpuYFAfC1oaBSI87dLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66946007)(36756003)(6486002)(38100700002)(7416002)(2616005)(31686004)(316002)(186003)(6512007)(4744005)(86362001)(4326008)(66476007)(8676002)(44832011)(66556008)(508600001)(6666004)(53546011)(8936002)(26005)(6506007)(2906002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkl1RjhlUmZrampEaUt6TksvNC9BbFhTVWo3MjM3dmg4RTJRQ0E5aFhCTTNO?=
 =?utf-8?B?U3FjZTMzUHpDbEFJWTEwWDlOYWtGVGxVbFZnbXlHeFhWcStXYmh3Tkl4a0l3?=
 =?utf-8?B?dmpKZjJDSExNeDBZUUxEejAydjlLZDVrSlU3b2FXcytJWThwQUhMT3RxbnBS?=
 =?utf-8?B?U3pkcTgxMFZDUHBDVHFzQlJOd0VVcnByTGN1TjF5ZXljcmpQR1BSRk9HZzU1?=
 =?utf-8?B?MlVIbW4wUG0yc2puMmhsS3VmRVMzN0s1Znk2MXlXcTdOYlhqU3JoaXEvbi84?=
 =?utf-8?B?L0pkUVY3OFRNWkJpQmlXM2xLSzhDc294SHlzc0NpNVd0R0hieGptSVI5bCtt?=
 =?utf-8?B?U2JpWjNObUtPZnNsR3oyUWdaUUd6TlF0TnUvR283dDg1Mk9QZTF4aG8vZm5s?=
 =?utf-8?B?dGNNY2VzYmFFaHFoQUlwVVJSVEMyOXJMa1hmNHJrVDBjMXh4U1laT3B5Z3BG?=
 =?utf-8?B?djArLzQxMU01KzFkUENqNWNTUk1sVG91UVJBa1FjY3BLQTRPOWtxdzdLN29H?=
 =?utf-8?B?d2NIcVk5b3JIcmxpMUpmTlpLUGo5WTZJMzJNbzVQWkJVd1BwUUZOTzA3N3g0?=
 =?utf-8?B?RDNBRUFJS3V1SEhzMUZJbmI2ckpxYVNFYlA2bExPajdqcVBEZGM3a2ZMeVd6?=
 =?utf-8?B?T1duRDYxWE15N1FUd3dTbG91MGVIdmg3NnNDTVJ0aEEySnFHbmNkQ2EyT2JE?=
 =?utf-8?B?c0RzRVdkTGZ0T05JeTlKeXpQTlROVzRRZGVXUXhJSCsyRVkzakdCeEphUCtF?=
 =?utf-8?B?NGZTcGJtZyt5TStSQ3ZMRVV6SDd1T3ozK0hNdlovK1BwRTZ4OHlUYzZHc0U4?=
 =?utf-8?B?WGdDQjlwWWR2QmlYK0c2REF5YnkyVG9ZR0ZCdFh0UWVRNVpqa3R6YjlySElP?=
 =?utf-8?B?NnBNRzZpeldEZDU5RytrUDJsZmEvSWY1L0J1WmxXdEtiQ1lieS9xUjBISkZh?=
 =?utf-8?B?RlVIQjJuUE4wcGpwMlVyaG9WSU0vaVFFZmdTL0lydU1yRkFXT2gxWXBCY2tY?=
 =?utf-8?B?Y0RmUHRXbS9ZOEZjbkh5djIrdXNwaVVNN2dLa1R4SllhdURKaytsK1NUTldT?=
 =?utf-8?B?M09OT0E2ejlLNytGM2RVN0lNdnYzaWRrMHgzSXcwQ2w1S09wNXduTUh1RCth?=
 =?utf-8?B?Tk1hQ0kzdGJsRC9ETlBzU0ZSUDJFVXNGQUZNVFVsbFlxN2MwS3Qvc3JrbXJl?=
 =?utf-8?B?K1RJQnd5dWN5NytmNXVQZzROa2o3UUttMkxzcTVKN0VJemptajhCTWtNeStQ?=
 =?utf-8?B?V0U2UUNaMklZanZIMEh3dzlybEgwMFYwK0pJUm1hVDdwM21OZ1JkbE4rQ0xH?=
 =?utf-8?B?bnRGVmFIMmx1bU1jS1pOTExnVkhYSmFad0xnUzJMb3ZUSGc5YWxwazdUTDlO?=
 =?utf-8?B?K1llWnFqaE1NT0s4T0NaYjhpcWVJclV1dHNGTGI3alhnWG0vYzIrRm44bnE5?=
 =?utf-8?B?Q2czNGJzTkd1dmhreUdGTWNYQ01xWDNpbENuVnVsK3BuRlAwcEJuUDh4ZHhP?=
 =?utf-8?B?THB6WGVNOURuV3Q2ellwbWg3NFBwd05iRWNQRGxrejF0MVVyY3ozK0tjN3Rt?=
 =?utf-8?B?TkdpWWNkaXVCdW5LUkdUOCtSMDE3aU9oQ2YzZmFRdlBMQTd1dWJBbUFmdmJu?=
 =?utf-8?B?RUlBdWhOcVJDZ3NhaEdIUHBTQUNjNVNiTVFqYzd0a3UwOXk0S3loUUxWUkpr?=
 =?utf-8?B?eDZRanVVay8xY1MzZHQ2ZERsOXYxbzBSUC9mTWRLSUp6alZxdnBWSFFQTFU5?=
 =?utf-8?B?aUFPOGNGbFJsRTdUQ0psa05hYk14b1FTVjBuMHFxc3QvY3pTWEptUTVaYUt2?=
 =?utf-8?B?djlvNlRLd2J2UnRJVGtOR1pOYXhhZkVpNHdvS0lkRVc3SUVXeTNBYXhGaElF?=
 =?utf-8?B?RWxHbkpFbGNVbGNzVU9vMVFiekdxc1ljVHdRbU5IMk9KRnNyZ0NMVXNuTHdO?=
 =?utf-8?B?dGY1MGp4VVpVT29HTUpDMzVMVFZZMmF1SlRySEs2TFp2MnZDV05OOTdqNllR?=
 =?utf-8?B?Z2ZlV050NDg5OEU4QmZ0TDZ6ejB0ZjhNSWxMU1Nyd2p6YmFwVzBKYzFINEU4?=
 =?utf-8?B?MWd3ZEhxcVhtYlZ0UkEwVnpRUEFQWllsM3JhT1Y1b1h0bUY0MU1mODJuODIz?=
 =?utf-8?B?WlFpNnRoS3BGVXB2T3gzblRBc0NKVnpPVlFyUHdMZm1IQzZJNXVDZTBCQnBL?=
 =?utf-8?B?Y3Q2K215OEtqQkZiWkN2Ylp3VVYvZDVKQmNtRXJkNzVvUzRJZVlPOTBYdmFF?=
 =?utf-8?B?cmFCRnJtbCtzbytLV3QvRWwxNmlzOFNzVmdpaUYzbm1RK0RNc1d3Y3RVNUxN?=
 =?utf-8?B?ODh6TW5pZVlpQ1BDZXVyRDNlbEsvUFBvSVYvN1VmWXk0UTcxRjVFdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be73a95-c592-400c-5974-08da3f88c6da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 02:29:51.4240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3Ql9zyRZzw1Nz9QuXGBIiL4sXONBT02RXnSkWpc4iti5KnARSt7BFzeJsE8rpr95w0J6uJfhiO/7cmYohm76A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 26-May-22 9:19 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 23, 2022 at 09:09:43AM +0530, Ravi Bangoria escreveu:
>> IBS support has been enhanced with two new features in upcoming uarch:
>> 1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
>> has been introduced in IBS registers to exploit these features. Define
>> these new bits into arch/x86/ header.
> 
> You mentioned the kernel bits were already applied and this was a tools
> only series, this one slipped into :-)

Right. V1 had a single patch containing both kernel and tools file changes
and thus Peter might not have applied it. How should we pursues it?

Thanks,
Ravi
