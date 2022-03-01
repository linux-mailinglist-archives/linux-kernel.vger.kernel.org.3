Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252DD4C955B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbiCAUF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiCAUFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:05:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F715F261
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:04:43 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221JWCgO027257;
        Tue, 1 Mar 2022 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FiKBCMtQnvf1A3C4nAV2PqMmZbIyigRdGnnGoUdhBg8=;
 b=gf5e/kCJg7C1DuG2siOJMxANXy/pk1wDyIXfjXiM7+AcMcgM7QMivRIzKWVv07AfPF1k
 k4kXTUwzGgnifQD1B35/BLC4Gixx3j+qXHsGERYyJ2AhTMXmMwdCa7933B+FzdHK02Ba
 q9W1UF8bBlMil5M+6n6KLg9DsS/2hzIhBbvQA8vlYtJxz+YZCQgIdXno7dwdTokHEP0h
 I6mPaj+ej4eehAzvLv/6+29wFdhcno5PKDduF0oDMT31VJEGYzYwmf+RPjywg5L5ZqoK
 barU7d//lDw80AjshsdwiQLOQEaFM1EYcgycUaZv6VDJv8TqAsEigr2aX5qTTuZ0pgB9 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15aksdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:04:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221JtTjZ149989;
        Tue, 1 Mar 2022 20:04:15 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by userp3020.oracle.com with ESMTP id 3efdnng82k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:04:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuPrnLaPY6YU02bFtZAtBlMGNFqefNR0Y9r+CMihmHkk36mRA/soQEI3BmJsoqehk9KyLog+LiXRVyDTwVQ9v+1YQlpsqkuq/jP8HD6fKiwzasm79BZoF3qbxwgu2FTZGJXvckxB7wcT7CpTCHqXdd/9GBE93z0kv9wBx12x17lkI/WGt4Jw9cjK+dRmmjyKPKer+aEFZdLFEBssaiwe5ZTy+MQiWpYtSk2cL2WVXTckI+Jv4Fcq/M6RH2aeYxWFuLTiv50CxjBCEQ9R97I6nojRoBL8+pzv1DCfuG/U0JEwTJdvjZpIeJQ9aWChjOakgmzNTriAu0XnGpHb+LK2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiKBCMtQnvf1A3C4nAV2PqMmZbIyigRdGnnGoUdhBg8=;
 b=WxpmuwtaVaAE85DRf0F4pXVO2gttTAWq+OoJNO6xjlpTKhT5GnNi06Nov4CREJP0IPonXowvUaDAaN5lgkTGecs0nUlw/F+zoaMybk0ZPrHufAr+ebPHpn2gqRgWhTBFm77juZQ2zzANJ3b7mSLaqAZxWc2SbrOrc2Y2SUdlR1HUaw8R/lSLI/r0E1BY+wQWBfVVgcYmgorBOIwrM5Y0p5Ej2BJv9n4/6WUXl3sc1LoPryAG7ehU3w6+IzNnV+Ezf7L5tVTDyyjz6meXAAEu3q9y4rSPI3panDaVbu2z0icbjJLyagZQUBlF56Dp3vcu3hWCNQf15HygALlUt+kHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiKBCMtQnvf1A3C4nAV2PqMmZbIyigRdGnnGoUdhBg8=;
 b=EKsSO1SUr93StB1iiU5QQtkuEKz7yYWmglRUZ12gViTnnKub0zJwBJVrc2R9CgQ8HYUrPTtseY8movuOPqnBCCzvfkfkPSQH5hLBx3LJMRRcze1tNDBl7hBt5USzJeEOpkdrFTMudKy1ijEP4DqvOYK3o2g6iMt4vuEWVtGCEtI=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BLAPR10MB5298.namprd10.prod.outlook.com (2603:10b6:208:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 1 Mar
 2022 20:04:12 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 20:04:12 +0000
Message-ID: <10d67f14-c5fe-0a17-e8b5-97702823cc1c@oracle.com>
Date:   Tue, 1 Mar 2022 14:04:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 02/10] crash hp: Introduce CRASH_HOTPLUG configuration
 options
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
 <20220209195706.51522-3-eric.devolder@oracle.com>
 <YhWpF/Cj/V+Cx6+d@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YhWpF/Cj/V+Cx6+d@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::39) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 927eeb44-8c48-4a08-8902-08d9fbbea784
X-MS-TrafficTypeDiagnostic: BLAPR10MB5298:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB52980B74601CB83760FDDF6197029@BLAPR10MB5298.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAu0mSu9XaWGR6ipMWgkknLMYh222K5xYmKrUhH3950gBsFIA6f0a1UBQt/ebNkpMuugdDKKYQdZx+JnoyOq5qtbHBO3fZqB59THAubmLfrnuXngGrFoYOv6Wzi0a6dh5vocU83e3EPCpW7DTSD6J5UmbakkLQ2FsaepEBMR88rOGXHiIJ5D5VUY6c5JXd53Wh3lEFg1/1jh5JKlGBfB4iMG5+dV1CQYnpZAT9YHoWom2RpnYkoigjRYAsqKhXtr8SwowkNV4LCY5SdF6zebXmQOU7/XxnXWB4XmOgz5SWVtJnU8t/6dJTbhhQLaHmDyUD7fc5LlQUnfBtbmT0e099HSAxggUQVOn49yR/6Pd6T4H+O2gz1MC0sPwOTbpEU1UocltRbkVBWR4S8XuGPDzSYhki6S61oRn2jmKVCarLtvIcoOJFe903XRCyXKwFqqm9Ya3h/8tOU1fznvo1MKixbMDgxKFran6+VO+lswgJXpLnhSSrE8k4gLi87sv2EK2/cuwRAgD/yp1y1FjE1a4+hkSCgrDLcYlKtSbE/C0/5nXDESgtoiWbNvbMgO4Anj/qDZS/+qnLUxtdKLQexe2VHoSa1Scd4yshmtajAYrqjqP59r4+1UJoAQFy1cwIDziCUhZhuI0zOclaCoOhNILBdR6c1Prc4PFqAVoutTvWyt+pFzdGorKnfIu/esAjecKtJmmSmAkL6VJPc61RSDxJXdfBYKZyABsTqn6SM8TyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(66556008)(6486002)(5660300002)(36756003)(38100700002)(2616005)(316002)(186003)(6506007)(8676002)(31686004)(86362001)(31696002)(4326008)(7416002)(107886003)(8936002)(508600001)(83380400001)(6916009)(6512007)(6666004)(2906002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9GaXd3a2NFLy9kSEFybzgrYkszUGxONzM1cVFqSVlSMVE0ZFNsQjEwMlky?=
 =?utf-8?B?bGx1RVRDU0xIMUJMNnhCYUpKaW1oc1VwYit5a2ZDZHFIR0xRYzRtVkZCQU01?=
 =?utf-8?B?cTByMnVkVm5XVC9SdWl3RXg3ZFJtNHRHNHkvZUtUNnpXOHdEUWFyb2JjNk1i?=
 =?utf-8?B?ZzAwYloxOVRRYTlFUmlhWVlubHFUWnRQYW1UTFRxVFd4bDd2WWRUOTdhck5w?=
 =?utf-8?B?d0tUMXE5ekVGSXNMUVh3K3FqZFMyMjVqcTh5QVEvdFRnV2NBQjFhbzhYQ3RL?=
 =?utf-8?B?b3BIaEZFTXNuQkoxbC9ydVM0dVpFdVViVGp0ZWJrS3BScmRkbWE4ZDRHQ0p5?=
 =?utf-8?B?VGdtaUx2M1M5UDVicWNnazhzQlo4aHUrSW5WTTlpNHdXOUlaN1pxanIyUGIx?=
 =?utf-8?B?TjFPZXVTaTdqK0FvTWVDeEUwdXNjVmhrT1lPTm9CN2svSFRub3ZCbnRoRkMz?=
 =?utf-8?B?TEh3TnFJckJ2MW9VbEQxZGJmZWZLNTNmL0RybVVIRXQ5dVdwVE9sejJHejlk?=
 =?utf-8?B?M2QwNE45Qk1jMFRrOGxkNmNibk5SWjMvb0tJRGNYdVRoVUJUNkIwMXRDZWc1?=
 =?utf-8?B?Nzk2ZUo0WXdvNHAxT2VNYXlZd2NraGZUSExMaVF2Tnc3YTRiK1NMaGZFMVhQ?=
 =?utf-8?B?Z2lkWjdXMlZaMkxpaVp5M0dET2NwTUNoQnNzaHpCL1R4YThteW1tQ3kraHQr?=
 =?utf-8?B?L1c1ZGF1OWRGUXZzdmdzRGhKSVh1V3BTL2Nzc25tTDZld0hwK2UwT1VGYTNB?=
 =?utf-8?B?bjBncTRvV2FGWk4zaWtvWklIeFh5UlMvSUJ4dVY5QWVsUWpDT2hsZXhDdzdy?=
 =?utf-8?B?bERzTXMzZk56YTl5OUVMZWU4WExmZkoxUkEyeGI3ejNsNTNxa0xhb29iblM0?=
 =?utf-8?B?VURFd2V1dHFJY3BHeW9LRUVlK2lhWjl0eENBMWVKZFJmU0lKVHMwZ0VFUXky?=
 =?utf-8?B?YitISGF3VG1ia2hBd2M5ZVY2TVpKRHQyWncwZkQ4dWNkb3hNQXlKd29WN0d2?=
 =?utf-8?B?MjJIL3hwVFg3bEp3c3hMRm9PRFA4ejFuZjBLVzJ4dVhZZFpiNTFMbm1mMElz?=
 =?utf-8?B?SmJoZi83RHl2K2xCQkZIWjJmK0FqdVd0S3dtMy9CNmVrZlBhTHFiT1dkS3lE?=
 =?utf-8?B?ci82YnlUbWdJNlZBUlU4QnM0eE81ZlhvT202YTFSOVNaR0t2a0FQWDFRa3VW?=
 =?utf-8?B?eG1kMkxLN3g2UW91d1BCc3V3Y0JTbjU0RUpyVTdOcERmS1dSS3ZKYVE2ZFBI?=
 =?utf-8?B?LzFxM2NXa2o5ZFRTU2hiTXRMRUg2a3drQmtUTTFpN0lhV1FBTFl4TEJDaFhi?=
 =?utf-8?B?Vmh4b1RiRDdVb2xPcWpHLzhEYno2Q1dVcUpabnFFTlNMRVRFamQyZWtxWTc4?=
 =?utf-8?B?T1VXZFByb1FsdE1NbFdrZCsxMlUyNmFlcklZenN1cFpQY2E4Y0c1OXJvaGQz?=
 =?utf-8?B?YkpRemlwYXFGZlF1SllyeGkxQ0NuSm5vdVFaWGVvRTBkMlVFOS9scE5hcDZG?=
 =?utf-8?B?SDVtM085ZmtMOFYyMmhXUHlTRGNDYnBpRTltcmlZN1Avb0l3TWZEcElKbkNt?=
 =?utf-8?B?VEEzdmZJcVpVWW9qVHoyYUNHb1hQRlREL09OMkVpT3UxdnA3elZ6M3dTMUdS?=
 =?utf-8?B?VGtPaDFrU0p5Y294VXZjZzVMTG1jOC9xdzFNbDNqVnV0VG1MbXFRTmxxQ3o3?=
 =?utf-8?B?WW9DeEdBNWVxYjJxQktlQmtOUDloeWc3eHdYN0hxdVhyZmJBRWtPVHZPSklx?=
 =?utf-8?B?cFhBcDJLRllsQ0UrQ2wzY2I4eHMvTlI5Ny9UcWNYK0JtK3JDclNFcXhVdlNq?=
 =?utf-8?B?U3NtOFh1bmt6WGdHQmgyVlBTUDREM3AwbDdYUVZRVDNQMnh6QTQ4MFFZNlhx?=
 =?utf-8?B?QWsxL1R1QzFpMFdVV0FZakU5MzZ3RmFDbHFaNU5KemtoOWpwbUJ0US9GSnV2?=
 =?utf-8?B?ZUxYT2JqQ1hkY09CVzMrL1daZW1LNXp2RWFEZmxjUFIyRlY3QzM3b1pQdTQ3?=
 =?utf-8?B?NUo4Wmt2Zmh0R2FOMURsRE1VK0NJaVNVdVlSK21kY2tPY0VEQkJyNTVzMUR5?=
 =?utf-8?B?RTBFYUZIMHV1WWZzcXc0elF6ckxlczNacHgxYXd6dXo2b0tqUTF0MTZJMlBV?=
 =?utf-8?B?ZW5ZZW5WRTY2UUxYV2oxblZmNXVLbmsxRmxTeTJ5clRiUmxlQmxoTHdKa0ZF?=
 =?utf-8?B?OFhoQnkrU2tLZDZkY0lHSGJaeUdoeTVJSzRDUVpXYmdmK20wSXptVEsxa0Y4?=
 =?utf-8?B?SkxmTzJDdmdRL25lZE1kS2gwV1NaaFZrcGJoVHZnODNsL0I4SVBnVlVVb0kr?=
 =?utf-8?Q?pinxywOIuGnSAXMDv5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927eeb44-8c48-4a08-8902-08d9fbbea784
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 20:04:12.4974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdI6RQit6f5gw0EP72TLiRmJo8KXd1GsDXkFBSZzRn6lu38KSVTcrz9acxHRP/r+C4qMSTVQ+aX5I7y1qjHr/efUyqjj1esdSjuLivQVJvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5298
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010100
X-Proofpoint-ORIG-GUID: WlyBY7BMTfmxlq1u-7IQOUX_ZdxCdUYS
X-Proofpoint-GUID: WlyBY7BMTfmxlq1u-7IQOUX_ZdxCdUYS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 21:25, Baoquan He wrote:
> On 02/09/22 at 02:56pm, Eric DeVolder wrote:
>> Support for CPU and memory hotplug for crash is controlled by the
>> CRASH_HOTPLUG configuration option, introduced by this patch.
>>
>> The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
>> also introduced with this patch.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index ebe8fc76949a..4e3374edab02 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2060,6 +2060,32 @@ config CRASH_DUMP
>>   	  (CONFIG_RELOCATABLE=y).
>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>>   
>> +config CRASH_HOTPLUG
>> +	bool "kernel updates of crash elfcorehdr"
>> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
>> +	help
>> +	  Enable the kernel to update the crash elfcorehdr (which contains
>> +	  the list of CPUs and memory regions) directly when hot plug/unplug
>> +	  of CPUs or memory. Otherwise userspace must monitor these hot
>> +	  plug/unplug change notifications via udev in order to
>> +	  unload-then-reload the crash kernel so that the list of CPUs and
>> +	  memory regions is kept up-to-date. Note that the udev CPU and
>> +	  memory change notifications still occur (however, userspace is not
>> +	  required to monitor for crash dump purposes).
>> +
>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
>> +	depends on CRASH_HOTPLUG
>> +	int
>> +	default 131072
>> +	help
>> +	  Specify the maximum size of the elfcorehdr buffer/segment.
>> +	  The 128KiB default is sized so that it can accommodate 2048
>> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
>> +	  region of memory.
>> +	  For example, this size can accommodate hotplugging a machine
>> +	  with up to 1024 CPUs and up to 1024 memory regions (e.g. 1TiB
>> +	  with 1024 1GiB memory DIMMs).
> 
> This example of memory could be a little misleading. The memory regions
> may not be related to memory DIMMs. System could split them into many
> smaller regions during bootup.

I changed "with 1024 1GiB memory DIMMs" to "with 1024 1GiB hotplug memories".
eric

> 
> Otherwise, this patch looks good to me.
> 
>> +
>>   config KEXEC_JUMP
>>   	bool "kexec jump"
>>   	depends on KEXEC && HIBERNATION
>> -- 
>> 2.27.0
>>
> 
