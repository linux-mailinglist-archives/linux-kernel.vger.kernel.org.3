Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F26A4C957B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiCAUNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiCAUNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:13:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5330864C2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:12:34 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221Ix7LS032608;
        Tue, 1 Mar 2022 20:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1zKUiVjouU1GyIXVsuPrQfm2r4ZSr3XoOeRxq0cSrhk=;
 b=ztISyoZ+B2vXWSHl3MNZzdKbvBLZyQqHUiIQBXoF+Cy5+hDojgSmbhV3E/K71wMQDtaw
 mbRtL9sNAFbae68JIeqWBlcQ9u2pqOxnzQ1XOd77w5K8oDQYRCnzt/GE0xpv6KpwJSqX
 Yu4UN4YM8Bibx13gcb7RassXKKJLD9/J9stdHBtSk8jqYG2EX9QJLH7Fiu/ma014VZZ6
 UpYIL+oeUfXS4rMUMuwd2/KEuhStsFtes/fkqWB19NXCCxCaI/6GMHviQvjhUS867IV8
 VWgGg/1y0dU0pueKUnJV7f4+OZ6cg3XbUH6Sqm1pOy7zJW2pYjGYzId6s90ZpYqRWmBM 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2ehqaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:12:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221K60fg034257;
        Tue, 1 Mar 2022 20:12:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 3ef9ay4y4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:12:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir3CYiruSzAFE0oYE4CrD2g5WpO/AVIAWv6alM4/VIEx/NVy457hWmImRrP+NFjCdueoJpZdNB+wEHaDFWrU+cMZyEtERiUdX88L0pchbcDpac837IG99bjBcrIFe+gRDQueOTuhn/ElwNK9tt1FL9c2hqissOx43hUZ6WYMl7yX+lRfZYmo65GmalQT+69q/6kjjfveWC7si1OccD14jzHTB3GvOppOk1iaCXzJoQEAOBuV4/9bfECArq5l5jkpifLj9bDuOJ4WP+KK0WwXrjDvFmnoRIUoNZWkUNiRv25GWt5Bv1bGh+peOCLf3A6PH9Ue7zSLp+75H7N13LFRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zKUiVjouU1GyIXVsuPrQfm2r4ZSr3XoOeRxq0cSrhk=;
 b=IfCJUviZ4W/37Ni90keGRPzo7a6StilrYY5bTyhV3+UwrlnTkk65SOZHAU2ATTX2ce8G5V0qL8oK0S2kxMPHwHqM//9Cqm9cgWjt/mCrxjXkvteNgxgNbh0dEq62pInva5i2wXqxx4Op3e3adc+03CdA/Fkrk1GE41+bZOpcPG1TQUKTQeoNs/Z9q57yeeHPAmL149sml7OWFi+Rl4bCMNiuO2st7VO4aUamAqZIYJZcRcztww5HqjNkrNXwIUPLeOtbvRTAoKxa+gCF0ujS4vPQ+/FjdOd71DsMUM9JdrlYStKfXPzRWvIHg/lKf4Yyz114LucI1+b3J6IYQrLTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zKUiVjouU1GyIXVsuPrQfm2r4ZSr3XoOeRxq0cSrhk=;
 b=zWvRF/8JcPx4dlTcHiFCZMuKFONr84ekxxNoJIVION+F7ISqddR4WRfWuYWjjI0GxPS7KolJF85ARIXpBpHqY/pjo/Yatkru26Uqr+sgnZQwW2Qdl2f09CCgEgeMc2/Y/VT5WVWR389Gf7PgmLCHcTZg9yS/TVeHdUwP0QX+bII=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BYAPR10MB3399.namprd10.prod.outlook.com (2603:10b6:a03:15b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 20:12:08 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 20:12:08 +0000
Message-ID: <e2e1c555-603d-0834-c9c5-06b75c590ab6@oracle.com>
Date:   Tue, 1 Mar 2022 14:12:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 09/10] crash hp: Add x86 crash hotplug support for
 kexec_file_load
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-10-eric.devolder@oracle.com>
 <YhWzy87O4Y66LHH1@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YhWzy87O4Y66LHH1@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:5:174::25) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d675634e-2172-4338-c17f-08d9fbbfc35b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3399:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3399AF4D7E4CC9BDEC88E2D397029@BYAPR10MB3399.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aw4WeKsF+rEI8nwrSxu56YdbBLqyxjs9d5A4G/YiLeqgS4dp1dzy+ICNaIoIjd4HU7mBK0lg/36CmY+iGQrGmvPDw8/6SRPuvujzP2HXx/ZBqqF2sAmp605RP/7Z0GnSRXDpM9c0xpMDUu/XAQu4vYMLe/N7emuPjARtFbx0TxdI32Gc9GFTwCh+kIqiq+QxJmrQVO4Bciy3J+OWzylawVIAc00NlIrHyunkFsyTsOnwb9xkdpFJjTGbT+sXjN7CUCBwVv52xV1u5EKZQfPhBzxCkl++3QWaopTxy1d2N3edDCTgXlJLyZTWvwHZW75UnnH2YQY+WHzgAPDkqI45vbtLa8k0dfv4SXR8+5j8l81Dfl53OHp139I+JyCpDtC9kVJj2hmTnogyAP16IrbkR5A8iYTNFM9ZbZfU+9ig0jgpMBfyrIPITTJ0Va6kFaCnCyRmBfZn3oN+7Ww+J0iocAdVo282E5JrhVKbW8h7HyGOQnI2Shf/73lcxVr/jCpfmxBSbXl71KZ1CV4kujCiPJjPEchk1hBDSwbizczYXZemPrUsJsoQ9XsjVffBxuesWHvCD5OEQIGMC3l9BUs1UpzZLAftJVFORCB+aYiPjZNEKegSm/U969eHAIUMy2mupbX7o+KL32mo9WPMU/ld7sw69dfy3IIWfDtx3+E6aSLh8/64NScfR1xIi+CFNpwhAQ77bdWA0cAFK+zMl2rhLoxE8/gfHHWnibkZNAPp6zAAsGRylKQS7iynT1S6t4DG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(8676002)(36756003)(53546011)(6506007)(316002)(6916009)(4326008)(8936002)(66476007)(38100700002)(66556008)(66946007)(107886003)(6512007)(186003)(31686004)(6666004)(7416002)(86362001)(31696002)(2906002)(2616005)(83380400001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDdrZm5zSExsQk5WQnR5bUtyY3IrZENxZkRzbVdDMGZ2amdnemRMSHZTd0I1?=
 =?utf-8?B?STBZa3BLMldMU29TWjU5VlFKbDlRSGtKOWJZTDNZMXl0aEdtTnRnZDI3ek9o?=
 =?utf-8?B?dkdibXQ1ZHc5REF5cGhQY29uQTI3QUJhSVcxYWxZYVdGQUNRTU5uVHgyYkZV?=
 =?utf-8?B?Zjdta3dublcxeUUzM1JKUjc2a3JmenBpWVEvWURjVGNyTm1nbGhwUnFNVWk0?=
 =?utf-8?B?SkpBdEZHeHg3enZzS1F3SlNKU0pwb1dxWmhDM2U3MVFxVzEzZndKM2RqOEtu?=
 =?utf-8?B?dmh1bVVneDNTUkNuK0dnWnpBYjRsTXJZWFZERVd5NTdpM3VwOU9BbTZUL2V1?=
 =?utf-8?B?SjRqd2tvMWZwVm9IeXNlRDZ0THlmTUxZNkp4WlVZWDBteHppWjFCT3E1T3lX?=
 =?utf-8?B?NzFZY0JtZHA0L2R2VUtxeWY2WHdlOERkclk0K3lOUmR6dE44R1BvSmNuc0pn?=
 =?utf-8?B?WGNhbzNkRjhKYXU4V3pJZHVEbklYV1g2eHl6d3dFL1B1Vk00aFZPNVFHdlZv?=
 =?utf-8?B?L1BXWU8wZzFDcDZuUU5mMVZIWmNpK2NiaGFYcVUrdFFJRlc5ZU1Xa2JvaTRx?=
 =?utf-8?B?dWpHVjRkaGFMeXNSb3l1M2NFNjdmcmRGeVk3cnRydS9Cc1ZTY1VhSHRnK3ht?=
 =?utf-8?B?ZE5iZWwyTm0ydmZ0KzJZQUZaZ3NzU3pnVjBlRFh2UXNiTVBib3Y0UmJKbUV0?=
 =?utf-8?B?ZnluMmYxNE1wT0FzWGc5bFMxZ0NTSzMrNDNscUptZDJXbVlYak12eCtjWmdV?=
 =?utf-8?B?RFZ0SWdjSTVUSUpkRUFYQ1hZQ3plM2JwaWdFWHBWWDhTemF2TlFRMUZoT3lF?=
 =?utf-8?B?ZG9mN2FjNU4yRnRiTkNRQ09aSzNTRFRFc2haOTc5bUhHZmp2Sk1yRkFZbmI2?=
 =?utf-8?B?cXZWQU1BekRPS0pVMzNaT2Z2c3huN01MVjVwUGVSVWpmRGJoQWFXT2xIY01j?=
 =?utf-8?B?aVBxck1MYVd1aWlRbmhNZDNZQlRtTSsvS3dkQnlVa3pTV2VFQTRrNXFwbWhF?=
 =?utf-8?B?dE84OEZ6a3Y3R3RQNzlicTVYdEhMK1k3ZlFTMXVNVjl4SW1JRkNrVmJqQkVY?=
 =?utf-8?B?V2JwUTlramlwQWNUZ3U2TTBJQVZGTnk3aHRiUGdTU1lIalFLOHdPTm1teUor?=
 =?utf-8?B?eGJKTGd4cmJKMXN6amJsMkNVVTlyeW96czFWbENBWHF5a3lSVUtWVXd4Y0dB?=
 =?utf-8?B?bmNRZ25nZkdkNnR4bjJWamt4KzE5LzlVdjJnV3IvOXBwdS9HUU1xdHNiK3J2?=
 =?utf-8?B?bnBsOXdKRThxeHZlT1h2d3QyMlhZVjBRemhXWnNpd3pab2l5dThUZFpITTlu?=
 =?utf-8?B?aUdCWjlPaWRpSUtwdGNNWmVnejJqcDk0dzdGanIwQ2NIQmFWd1c2UFlvSFU3?=
 =?utf-8?B?OG9rbnF5VDc5OWNIeG5nNXlnbFF5YXBaaEp1WlpBMDQ2MGdzd2NIZ2gzeVcw?=
 =?utf-8?B?RWgyeUR3eDNxR2Q3bytXMjEwcUptTmNKZVVoWGZveFdKRWkxck9ldjVlWTJL?=
 =?utf-8?B?cDU0RGhWQStVaWpZdzQ0ZVpibE90aDJyemdUOHYwcFhUa2VnazF0N1pyTFRS?=
 =?utf-8?B?dmRFYStBL2VzUlpEdGRvdElNMFNncDNuQktlWHp4eUxNMEVpWHFsaFBkSGEv?=
 =?utf-8?B?enhmQXZxd3ZEYjFGR2R6ZHdzRWsvUVEzVnUzL1RiR1pDc25POE1qK1dJWDRy?=
 =?utf-8?B?RzhoZDVGTnFGSFU4dGN6STJNbmxqVGFFcUNtY2dld3ZWMGYzRzdjUDhZVmNL?=
 =?utf-8?B?UzEzcnM2dHFhUzZoSFJPZEZLTEhabnE3NGlqTGcwK0hvVE5jTDE2ZXRHTnY3?=
 =?utf-8?B?TmpoTTZWUjBBZkZlVHQxUTdGSkc2VXNpNUk4MXJSa1B4ZlBkSFpzNkRzTVNJ?=
 =?utf-8?B?U2VaWFFhQ0VaRFRCZjhFTWVQNEJZejlQK25NZTFCdFlvU3dCbHM2OFZxeC9u?=
 =?utf-8?B?YmJaeUxrcVEwVWluMXQvQ2hPK2lHNFRTUVpML3hhcnZhVksxT082OEhueDBY?=
 =?utf-8?B?WHYxOEIyVFBlcjVDT3VuNG4wNUJ0MWpRU1NtbmJBS01DRUg1Ry9rb0dDbkli?=
 =?utf-8?B?b09ld1VXcUVpZEVYWldpZWdTbFdDRXc2dUx5UEVxUFQ5VkJGSDNrdjlsU2VC?=
 =?utf-8?B?U3dOZUFLT3V1SkdJQm8xMHBOdVU3SHVXQnIyZUlLZGtDYW0xUHJkbnFSeWkv?=
 =?utf-8?B?U01NNmxsc1VYRFdlS1I5MllVUFowOWc4N0lUSDl6UHFCbVdEVzRiKzhwbXRa?=
 =?utf-8?B?bnFlV1IvZkROdHlZb1B3M3FCMHJhTkdhSUE1M1Vyc0JWNHRSUDh0OC95emxD?=
 =?utf-8?Q?kF2EOnPAL7eBWOaghR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d675634e-2172-4338-c17f-08d9fbbfc35b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 20:12:08.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztoi3/XFnRxRZ6c+myS8M1yzQQ8bo7xyc/VPdEBBmILMRYIGy+0FjIcLQefHiIPXP0ooFjYHdx3+3CWBAqYQ3x6lzjoNeoJfYU4q4fvaTUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3399
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010101
X-Proofpoint-ORIG-GUID: AwB7gPVfw7A7iyQ7lVLeRKP_WGWQv93Q
X-Proofpoint-GUID: AwB7gPVfw7A7iyQ7lVLeRKP_WGWQv93Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 22:10, Baoquan He wrote:
> On 02/09/22 at 02:57pm, Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
> 
> Please mark the patch as X86 related by adding:
> 
> x86/kexec: Add x86 crash hotplug support for kexec_file_load
Done!
> 
> And also update other subject to reflect under which component the
> changes are made, crash hp is the feature name.
Here's what I have at the moment, is this matching expectation?

pick 891fcff41a8f crash: fix minor typo/bug in debug message
pick 8f44e0d695be crash hp: Introduce CRASH_HOTPLUG configuration options
pick bae60e9db6ad crash: prototype change for crash_prepare_elf64_headers
pick cb98d1d923c8 crash: generic crash hotplug support infrastructure
pick 40e4434abad4 kexec: exclude elfcorehdr from the segment digest
pick 75039922aedc kexec: exclude hot remove cpu from elfcorehdr notes
pick 0be483dadeb8 x86/kexec: Add x86 crash hotplug support for kexec_file_load
pick 388bb5e4bf9a x86/kexec: Add x86 crash hotplug support for kexec_load

> 
> Otherwise, this looks good to me.
Thanks!
eric

> 
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and if no errors occur, it is
>> installed over the top of the existing elfcorehdr.
>>
>> In the patch 'crash hp: exclude elfcorehdr from the segment digest'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.
>>
>> With this change, the kexec_file_load syscall (not kexec_load)
>> is supported. When loading the crash kernel via kexec_file_load,
>> the elfcorehdr is identified at load time in crash_load_segments().
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/kernel/crash.c | 92 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 92 insertions(+)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9db41cce8d97..6215c51919db 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>>   	image->elf_headers = kbuf.buffer;
>>   	image->elf_headers_sz = kbuf.bufsz;
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
>> +	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
>> +	/* For marking as usable to crash kernel */
>> +	image->elf_headers_sz = kbuf.memsz;
>> +	/* Record the index of the elfcorehdr segment */
>> +	image->elf_index = image->nr_segments;
>> +	image->elf_index_valid = true;
>> +#else
>>   	kbuf.memsz = kbuf.bufsz;
>> +#endif
>>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>> @@ -413,3 +424,84 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +/**
>> + * arch_crash_hotplug_handler() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + * @a: first parameter dependent upon hp_action
>> + * @b: first parameter dependent upon hp_action
>> + *
>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories. The new
>> + * elfcorehdr is prepared in a kernel buffer, and if no errors,
>> + * then it is written on top of the existing/old elfcorehdr.
>> + *
>> + * For hotplug changes to elfcorehdr to work, two conditions are
>> + * needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources. See
>> + * CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + *
>> + */
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned long a, unsigned long b)
>> +{
>> +	struct kexec_segment *ksegment;
>> +	unsigned char *ptr = NULL;
>> +	unsigned long elfsz = 0;
>> +	void *elfbuf = NULL;
>> +	unsigned long mem, memsz;
>> +
>> +	/* Must have valid elfcorehdr index */
>> +	if (!image->elf_index_valid) {
>> +		pr_err("crash hp: unable to locate elfcorehdr segment");
>> +		goto out;
>> +	}
>> +
>> +	ksegment = &image->segment[image->elf_index];
>> +	mem = ksegment->mem;
>> +	memsz = ksegment->memsz;
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources. The elfcorehdr segment memsz must be
>> +	 * sufficiently large to accommodate increases due to hotplug
>> +	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
>> +	 */
>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +		pr_err("crash hp: unable to prepare elfcore headers");
>> +		goto out;
>> +	}
>> +	if (elfsz > memsz) {
>> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
>> +			elfsz, memsz);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * At this point, we are all but assured of success.
>> +	 * Copy new elfcorehdr into destination.
>> +	 */
>> +	ptr = map_crash_pages(mem, memsz);
>> +	if (ptr) {
>> +		/* Temporarily invalidate the crash image while it is replaced */
>> +		xchg(&kexec_crash_image, NULL);
>> +		/* Write the new elfcorehdr into memory */
>> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
>> +		/* The crash image is now valid once again */
>> +		xchg(&kexec_crash_image, image);
>> +	}
>> +	unmap_crash_pages((void **)&ptr);
>> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
>> +
>> +out:
>> +	if (elfbuf)
>> +		vfree(elfbuf);
>> +}
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> -- 
>> 2.27.0
>>
> 
