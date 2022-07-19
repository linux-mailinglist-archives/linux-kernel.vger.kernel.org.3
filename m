Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2D15791B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbiGSEPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiGSEPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:15:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC77F5FA6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWHvUJ52KDOOr4JPTWZqEaFE4we9XbDW6sOT6c4g9xG/xTFeFziR2dh9PmmwI8mE+ZVqIg16Xo+OAFEAkeshOzckokxysWSKNp9blND1rIgf6ucT+EqUacYkkxgkdlHaSaDoMGuvxw/Ars/TYjQ0uxhJpD0exIRPiehjTPP1UICAKLOPaKQPFkN5J2bnBFvW1B59B/XB8F6uU5x7rXQbRB9Oz6ibaWEnPFXanLhtvHDrba0pG2OSVHSqDZMYy+LbafDcpZah7HuWOSMcpDodNjJKAIEIRDNcXDww+prITJ+JEp5mDDFyIPXOLEWWWnaAZDIF7E0dirgaYlM3VTnvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1s4WiG8zS1U6Xgq00fjDfMhow8GdlRvfGJcxvPRjykg=;
 b=dETQXCtTmq/dkUWpbyN8eXl1co5yUTW8p+IY7FXm32K89+JG1cFdm6mkl9+1wzegU6rzB0mRUGBqYiMdYeKwEUAPIzMqTQ0OuRtSJLqYhb8y5zHMM71Mol7j6JtTuj7MmqXdu3bwsIRIh1fAB8VPSlt0wgS6CvQ2HDt5x+cYJ14rgjMRcIagJkmP1GGZqgpSGWxE9R1xZDG+zGdHJjWqSqS8b8iWZLLoVjf0gg3nRnWtYbAZn3JAVpBH2pcxNZrWWdBeGrp/TocCi/JHkbHO8xNZnXOTTGpPPL9AH6YoOLwjOGv/4PT5zNXM7tD2pvUv2o1L1gJgpWhFXlqVY6ogYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1s4WiG8zS1U6Xgq00fjDfMhow8GdlRvfGJcxvPRjykg=;
 b=gKiCi5OhctciUXa7JoNjxG5SFqGBYcWZ1uuAVLHhyu1CE7wHGCizG0Y4qcNwafI03e5Rv7TmXnuWAMuffJTpIf44z3Pe+VrQK2AW39h7LQpIjz9YdOyRzmo1szC0Fh5eqO0ARwRFEYQv9IoFInO+Ymudh3el5aFu/4miViBCEcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by BYAPR12MB3032.namprd12.prod.outlook.com (2603:10b6:a03:dd::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Tue, 19 Jul
 2022 04:15:41 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::9dfc:d340:841f:a6fb]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::9dfc:d340:841f:a6fb%5]) with mapi id 15.20.5417.023; Tue, 19 Jul 2022
 04:15:41 +0000
Message-ID: <24ccd22f-6708-3265-4012-66f01108ff22@amd.com>
Date:   Tue, 19 Jul 2022 09:45:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC FIX PATCH] x86/e820: Stop kernel boot when RAM resource
 reservation fails
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, dave.hansen@linux.intel.com, nikunj@amd.com,
        hpa@zytor.com, Abraham.Shaju@amd.com
References: <20220718085815.1943-1-bharata@amd.com>
 <E7A3FF43-C49F-415E-81C6-CD14F4107349@alien8.de>
 <be498c32-bed6-d31a-ae94-6006dd59ea1e@amd.com> <YtV3Ipvt96X/iO2J@zn.tnic>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <YtV3Ipvt96X/iO2J@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::7) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 410a5a1c-b355-430e-909f-08da693d576e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wP09MyNg3OLW39P6FMhbKenCmNXJyggTVP3CtgavvpFNmQFuBT6I8HmCC/1ok5YvwljZo4M3IzB2l+86OkL1oCmeR5axBknU/K3TXRmPflyi3Mk9aKg6zF4fx3e6l/S8AtIk6JRdHi/PYv2RzHtAUvHcepvbu8vX9ojZbWezHeae59uCjGd3r3X9FwH96HWLcCKeSEoJIa8bO/z8Tj1ZQr6x0flvowv3BbZGs3vvs9L0l3LOMKx8Pu8i2+DqyAI50wwbsMBchjreAwdj9NOqit+jyc3ZzFAz5hkoGDj4JaMzQubZL+doaBmo3frJoslPcTxxM06RZJbitz2TX/z1jpfwFizlya5Q+AF9MwDJ7xXz0z18wzJttJQyrqr1HEVO7d3o+YPy7OtD9hCmCxwt+6uGg6k3dI4EyQ8KhU4MUrlq5aWbwrIlCMkKwzMqjhegTkkY/gew4r6QVYcPxc7SqpaBfgOR0VcFnGm5FgWHJJXnendwz5arbqFj315Z9TcJmHfyD2+noPjIvIW8pqRk01HzKzLxu0FN5win+FW+BK4RpvBZA2rmHA/rdjPBBEWBTqeHW+3lfMkm4YIh3MdGG8k5NmHUUCpgKrWaHIaxuyu8YGMJ9JDDLFT9snvWKAgijqmgA8P99Ruezg2OXbtEBP2I8RlLstrSSOtqpVpug9M3D8Fq2hXYmQqgPyFfe3YV1GG4m5MtLCOgBceYn7/GGlmWkkNxmqR6lomlUt5WD/jX0P77iLQ6i5C0w/EsiqZygPKS+udKoN+i2J7jMADelRpdwsAymksLI9pesOBMLkDVcBEV2jqz+qUmpAQ2v5VS2AQBOxil6iZecq2822edzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(6486002)(86362001)(478600001)(31686004)(186003)(6666004)(6512007)(6506007)(2616005)(316002)(31696002)(6916009)(41300700001)(53546011)(26005)(66556008)(8676002)(66476007)(8936002)(4744005)(5660300002)(66946007)(4326008)(2906002)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlhjMkdJa3NIZ08rQ3d4ZmhISTh2bEhkYjFRVEtRdzJUWEp1ZXNoaU5Hclpo?=
 =?utf-8?B?V3VuR1kvelJBN1didmhrQ2tVcVNQUDhvcHNzL2tCa0VKSGNDSkZTSVpBdFp5?=
 =?utf-8?B?SDBzck9zT3YyUjhTSnBsNyswWENEQ3RvdTQ3YU05bjNxSjNTeDhDd1E3ejhW?=
 =?utf-8?B?OXY0WEYyeERYaklnOUVrZzRxaGxiS2g2d1dQYkZ4Q3pGMnBLRGxrTVQxc003?=
 =?utf-8?B?SUllRDJEUTNSVDlXbWx2NzgrTkRtd2VwS21zSGlZZXFzNy9CbnExQks5ZXpU?=
 =?utf-8?B?bzNaYWNVZ0pLQitJWEVFbzRlVElkclZsanRGdmJ4SFJhamttV1pXVnlXWlBm?=
 =?utf-8?B?RFZod0RhSDI2dUVCMnVmYW4vVWswbVBwYmpLVzdqdFhzZExhb1pQckRoKzVp?=
 =?utf-8?B?TWVSVlVFK0dsNGFQYXdzWWdaMm9QbmJ0WkxqOG1kWGhIVGNSUDBYSXI4NkVJ?=
 =?utf-8?B?eEhhaDNMRXJ5UVRBcFZpUEtFMXlQQUJrRWR5QUt4ODUxbmpoSk5aUUdXaHJu?=
 =?utf-8?B?RVdLdmNjQ0FIMUd5YTFSTUsrOHBYQ014aU10cUJwSUJTNzlZMSt4UEJwaW9r?=
 =?utf-8?B?aWpFb3J2dGkweGNZeU92UVlESFFEMzRROUo3S1hmTUFaUlBCMk5aNWlEWDNl?=
 =?utf-8?B?TFdmUUNNSzROckp1RmpsN0hDbnYzMXFINTljSmFaLzJDNnRDaVd0WHZDeEJ1?=
 =?utf-8?B?ZmxNWGFDdUYvM2U3bjVWZ3EyeDhzTWZod1RwUG9uMVYySWlBRW92WmE0LzBJ?=
 =?utf-8?B?RDNHTkc4ZlMwdzVWSHdpYWhYT2E0R3RsOXNRQUFjNUIzaHphLzJCYVA3MTIx?=
 =?utf-8?B?dTMvNDB6eDRvVS9ZNGhKemRTendkMHJOa0o1WUE0L000MksrcGkxcEZob3Ri?=
 =?utf-8?B?UkdhaTJEYjY5a1BrdWUzUDlXQkhKbWtlS1BVNGVjOFdNbnZtdlpqcVNocFJn?=
 =?utf-8?B?TC9vVzZHZzZ0QU1JbE1zbEF2T1Bxd0ttOG14THJ0MHBZYWw1dU5qRnhvYTRJ?=
 =?utf-8?B?d21idzVWRVR1SVRHUjhiSXArY1YzbENFZFhvbUwzZ0g5ZVBjNVdkcml4NXhk?=
 =?utf-8?B?Mk44NitQNFlLb3dPYkhjK2tqZGttWDFETjRsUG1KdVRWcGw2ZHdaWWxWT2lP?=
 =?utf-8?B?ZnZ6WU5rZHVsaU1JRVdxMDhwakhiZk9XT3NtYnBtdGk1RHRNbHNvdllFWXpV?=
 =?utf-8?B?ZXJJZzZlVFIrd1N1YTZObWZyaHgyM3BxbFR4NHR3M1NqMlhOK3dYVXo0akFC?=
 =?utf-8?B?ekdJd24wWkEySVBFeVNtc1NrYjllUWQrdUlDLzVXTFRadVVzeEorS3drOEFK?=
 =?utf-8?B?YzE1R1NSM0ZvZ01pWkVvYWhxMWpDZTZ0RnNFOUJ5NFg1bUZsUEJUTWVQRHdk?=
 =?utf-8?B?VmNwZzVtVHZyMnRnZ1hzOVRJVzNRVG5PWk9TSldZcmZmTEFLREdjdXY0bTVP?=
 =?utf-8?B?L21MUGtmd25zbC9vMWZkRWtrMHd3V29ZQW5SUm12UWg5aHhSSW9XZGNRRHVi?=
 =?utf-8?B?WlhpTEZ0OXZjci9WYnp1UG92QXJCYUlTTHhGQmtvajJLUC9aNWZuLzlrVnk2?=
 =?utf-8?B?Smd6aG9JU0pRdmVCcEVSbXZ2MW5rSEJqNW5GRHlhK0N5MGxxYUUrOUl0K3Vn?=
 =?utf-8?B?QWZpTWZCY1lGbm93TFIyZnIwMXBTK1Zjd0oxZ1p2RE0wb2IvR2FtSEVxWHVw?=
 =?utf-8?B?cjlZRk9Wc2VXdUlxUkRhSlB5ZkZLV1g5SEQ1dXhuTTM0aUxPV0N3QVEyWTZG?=
 =?utf-8?B?ZnVWdzdya0JBV2ovR0JYekUxUWVsbEMrMmR5M3FHa0RmVnRmV1NXRTJDSmt5?=
 =?utf-8?B?bnp4cmZ2eTBYYzBrOSt0V1ByZVduWlN5c3FmUGpSV1huTkdpamUyOXM5NmFm?=
 =?utf-8?B?UkFtQVU5V29RWU50ck5nVE51dWJ4TlFOTzN3VHE2bHFSQmVkV09jKzV1cTkx?=
 =?utf-8?B?MS9mYmx3Rmk0Q3o0MFRjT29nOW5IRmcyTzh1SGxUVkljZTVacVpmY1BId1Qz?=
 =?utf-8?B?Y1JKZWZZMWNtR3paWlJjUlowZEhqaXlRSlAxRGRWbEsrcFdWaGtyc3hCb0l0?=
 =?utf-8?B?bm5pSlBScVYyaUxmdWRIa3lBUDl0aTJjcm9FVXBUVG8ySXNJU0lpNEJCK1Ra?=
 =?utf-8?Q?QUhasAb1dUZUNuJOT3Hl5aOU9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410a5a1c-b355-430e-909f-08da693d576e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 04:15:41.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUMuHATLIaJxX2t8MqVQEMfKTmlyzSXRRtsPDR879E1ZW9IsvSejV4tm0XZRFOeuZJoMjfk3tEgOeItCJxS6dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/2022 8:37 PM, Borislav Petkov wrote:
> 
> I betcha you can generate a lot of "kernel bugs" with weird qemu
> options. If it is not a real use case, nobody cares.

I see that we will hit this problem by default when starting
a guest with 1T or more memory using QEMU.

> 
> And even if it were a real use case, panicking the machine is not the
> right fix.

I couldn't see a clean exit/recovery option in setup_arch()->e820__reserve_resources()
where this happens. Any suggestions?

Regards,
Bharata.
