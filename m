Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6D4D634D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347205AbiCKOVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiCKOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:21:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15931C7E95
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:20:34 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BDTFtD001496;
        Fri, 11 Mar 2022 14:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AzwRPKJCYGsACE2zdpPOVzAzmw0WG+/nFrwAUQxVVdM=;
 b=fYC2omq7XJVbl+ToeC1Mk1DWFo+23NMUIxLP77BdoZb6w3xXLbCiwSJ86PTv/06Fxv6Z
 MAIvRtY2/SVtJsDZW4BWhzM6jgsgZi+XlZVAPouGzsdeVpDAYydSrWUfo610QkLZzhCR
 MYQ5aLhRyHYJS8XqDkuVqT6tFT5QTtFkNoCkhJ8RhYN7dkx/zmCRnkAxa3wsVQSygsJ5
 WPjJUuQCJwAjtjXJENpr8VWR/cAI7HcVrdQ05i+vktNr+4p5hIjpXCwL30uV6Htuq/dZ
 kfLFaZY4LDIwRjpykI4fST/c8thqVXM1PRXt+luFyWPvKLfCxtLOzr6AUHz5le+W4yg6 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf10vxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 14:20:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22BECVCq024340;
        Fri, 11 Mar 2022 14:20:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by userp3030.oracle.com with ESMTP id 3ekvyxmtgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 14:20:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuiljGe1Bzf1BoPM4f0NM4YEZDagoBkrKgf2wKIZGfcZZ/79yuL7rh6GMyVU8PVlNGlf90pWZvNn8VVXHwaFGXGjmZG+akCATQrkhY6wYLTSvW5KkeWTtzNJ9Cgy/mocw9qOFqIy4va0fCodYDDVD+Cu2R2FTrRA/UUmJ1/Bq8/sPhkXab2KjSlxb2iI5Pb/4DIwgIDdEg9Mnmyr+4oKxoTtQwPemiiNnFZKdBpRAaMbGHApOzPaEWd+/sAfgaCHPF1L5Y/vgJfdmgpixNk3y4ZQOPjV5SJyByxhRnTKoRG7ssiGhhsqfcwmPbVE6nrFkji7Y4y0tYd/wNxi1kDY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzwRPKJCYGsACE2zdpPOVzAzmw0WG+/nFrwAUQxVVdM=;
 b=WdKM/WTJqUgoI2Uhefg3yNtdZxnMgW/17SsOFvdPhJzFAh7fqEYp1hUUa+5VxbkBBmOOAL/mWcpEHBCOocgA5EXXia11P04cigjc8TsKTi3MxYIvrtH+VYtqDRpiOW5wcg9mSq1Bn6Wo8FNOHzgTlX6EziqZkvoXlyuXP1QiJCo3D9KcVcF212OU7yV6XMiNM+J5ayTwrE4pYSzFQ0s6O+Cyf4hwqMPAmE2/G953JaLgY+4dLhlE6LfQhfXVuAsv/rqCMuH9mL4ETqAsb9EcrScn504fgx8wdUnkqW/myM7pdD0bYlE9gr4PHPkfG7WtLijL4SkPJ9sXVZWE28cGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzwRPKJCYGsACE2zdpPOVzAzmw0WG+/nFrwAUQxVVdM=;
 b=D4j+rh7LAoaV8KtSHXnHnbhP1stG36W9E9YTdQufB3qFndydGnC8ofXXpfkG0rJRUiaADAa07p5Hp/NcWJBJWLXFCcLcFoIev/PNrQ6uOhwaTXzQ9iLzFUl/g8PsrdB4EUn39yyNx8oSUa/pwRv/ts8SzlEXgWEuW8vak0XJThQ=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BYAPR10MB2901.namprd10.prod.outlook.com (2603:10b6:a03:83::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Fri, 11 Mar
 2022 14:20:00 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755%7]) with mapi id 15.20.5061.023; Fri, 11 Mar 2022
 14:20:00 +0000
Message-ID: <4468bea0-4813-a0e5-50bd-ce29f23d482e@oracle.com>
Date:   Fri, 11 Mar 2022 09:19:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v4 2/2] xen: delay xen_hvm_init_time_ops() if kdump is
 boot on vcpu>=32
Content-Language: en-US
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, joe.jin@oracle.com
References: <20220302164032.14569-1-dongli.zhang@oracle.com>
 <20220302164032.14569-3-dongli.zhang@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220302164032.14569-3-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:a03:255::28) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5fb1a8f-d6e0-48c8-3e0d-08da036a3a00
X-MS-TrafficTypeDiagnostic: BYAPR10MB2901:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB29019696C848C93A3D8339138A0C9@BYAPR10MB2901.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 897TEy+1miDijRv1z61wWPURLQDKNDz0vrlPo4EkYlq9p4TtTGYBPJyIodePynxwQ81XwlIctaMujfQJ4mJYCEROgDIpYeuI0HdRMaG7Ai3KmaZulE+ZketDtxEr57BdEXycwLlTm6exPp6FmmAtG4BdgW7kTVtCv0knp1549DLrgV8AqjMfiX9i/xphVP/c9GyqrP6HAUJuYgtKcUCu1rAFAslJA1Chx6ytq4EkpO/njKFpjZoPe4PeiQZ+5w3x3M+tecx0DvRsGLTVd4tNjrVK60xwr+KOnNoZLkpca28YlXCqwGtqSynevDVeusDvxNyENaJHKpwTErhPa+oIrt5E9vRLIbhgEMoEJ23OUP9FAfwKbdwqHSpZaJg9IRZM8S3woYN4wpqDz4NLxrvvN2Y8SKQnUD1NWDUFPj9ws6bFIiHN6u8JureQVuNRmKs7EyTj0iDTjCsuVe/vR0N5ic2P+8A1JD49ROO9DPfbxHqLRrMHF74go43bW47DXrd7r4AaQNiHrTuaXQQCC/Qrn5pqHnbpRqfE5VXrvySaDFBh6V6vOXzGtIt3VNkY7V+w3QFH19hoZAAv17pm9BlLnZZJDLnovWuLS+bNXI7FxUf2lUONwveyxUcU84+fjyKNNr977j3v+6nb0mvbcs14JqqS31NuQUzjuWTEqsQIjVKlm2P9TJZVe+JR2/MwIqp9TufR4qjLsbzDaX5NohoOksIVLgdfMNlkPhxlOfU2V5IFRFnE03i9PPzvq99E2W7h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(4326008)(66556008)(66946007)(8676002)(107886003)(31696002)(83380400001)(26005)(2616005)(186003)(86362001)(38100700002)(5660300002)(508600001)(6486002)(44832011)(31686004)(8936002)(36756003)(316002)(2906002)(6666004)(6512007)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkhHbUlTQVZNVlFMVTJ1NWlZUElCaFh3ZjJtd1RJYW01RXpZUnhHd0czRnAv?=
 =?utf-8?B?ZEVRU2tTUkJ4SE5abWdzd2lpTXhXNWZoTHA3QnhVemhzNEZkOGVuNUVjQnZn?=
 =?utf-8?B?aWhybC9xaHFsUFZPTlc2YUE2T3FOYzRwUkFsNjRMbHVFbUhqQjhybXM2M0Qr?=
 =?utf-8?B?T0JPZU1xYUNlMG9rNkJwZ3crTWIxTnJ4M2Zla2RjcXY0Q3ZoKzhibU1hNXhH?=
 =?utf-8?B?OVZaMjkwTlh1N1pTN3R1RXJsL1ppTVZ6VktMODE4TDFnVkFYYlREUk82MXQ4?=
 =?utf-8?B?NHRUSkpaZWFoQXZpWWx4eGlrMndQOThBMy9UQVFXdWlmdzVzVnRQRHovcElt?=
 =?utf-8?B?YXRBcWg3QXQrTXljVzRzL2pQUnFLVHV5cDlUT1FHYmdGViszRnA5MnNRcHBs?=
 =?utf-8?B?Z0loYVBuQ0dYMnBsYjVNa1J1MmJmUXN6K21VVm9mMGZVZUVtYUxJU1o0cElF?=
 =?utf-8?B?S0U3N2NJK2NUN0pSYTNCRVFMUXlvcTVxWmI4VHl6Nlc4VG9uUlRzVTgzSkFq?=
 =?utf-8?B?SkgzUk44Rjh3czNPUXlBeW5sSS91VkJzTm95NWZDUVJWRzJzczlTd3I0dERR?=
 =?utf-8?B?emhtVWcwRjU3bUJRWW5ySE9TTEdlRlA3blNHV1FyeE5rWHkwUm9zakZIN3o5?=
 =?utf-8?B?dm1yT1p5V21udUxDRmdNdlRPajVSdWVzb0tNSlU3eENNWFViRXNGam5RbzNB?=
 =?utf-8?B?MkJLNEk2dm9qWmVOSTBrcXB0SGZrTFdKS0JyQ3ZCOTVmdVRIOUVKdGxpM1RD?=
 =?utf-8?B?WVRpdG15Qm1KNFRMVGN3N3FSV2thdDVUMXYrNHhjUndVcUpLeUtLZ3daZDlq?=
 =?utf-8?B?QkY5cmZsSURqKzEwc21OQkduLzlnenBWd1MrVlpSbzdEc3N5TnFXdVZ4aXhk?=
 =?utf-8?B?Uys5WTlpZ1hNTzRzVTR1YkNUdi9FcGYwSUszSkpjL3BsMm4zaDkxd0w0eXpn?=
 =?utf-8?B?d2VVeDhIcit6bW40eXIzNkNIa3JtMEQ0WW5KTko0cWlpWUtJNVFpM2hmK1Jm?=
 =?utf-8?B?VWdHVzFocGowY0ZhOGVBR3p5OTQ1MGlHZm9TZ09iY21xRFBHcy9nSStIOURM?=
 =?utf-8?B?VnpxbUVrVytFSnFsNkJWUWg5YXJ2ZHdZcWpzek83U0xKVC82NnNuVUFnU21i?=
 =?utf-8?B?TmllWWVYWWVpLzZlQVByWVBzN284cE5mTm9USHpLRXVrWFZiVDA5azg2a3Zs?=
 =?utf-8?B?OXZDV25XQkI5a2FIcHFFT09DZ3ZwTEVIMDF6RVpNY3dVSkpOWUVNQjQvTmRi?=
 =?utf-8?B?NGxteDZYUGVVaVNoRGx1UldBUHU3VFRhVlRIMG5xYmFMSlBtS3pOa3B3cS9i?=
 =?utf-8?B?b3A1NTFVRExGN1c1WSttdnZISTliak1Zc2NhdkFkczhTaCtKcEFIS01lNlFI?=
 =?utf-8?B?Q3VYSHlRMHdaL2dZWnpSR1Q0SXdlZTl3OGp1cWNLeWdiQkpCV3JJcU1aZGlz?=
 =?utf-8?B?OXkxYWFROVEyZG9tWW04cGFiT0xjaWcwaFpkT0Z0SHFPWWN2VFhlWEZRTmpQ?=
 =?utf-8?B?dFFMaXQxU1c3WEZ1YVpHTHlvb2RaZ0E0N3UrWTBOZmRrNUU2VlExNjZvTnFX?=
 =?utf-8?B?bURzZ2Q2K3F2WUljbGdwaS9Dd3owL1hTK1NDUmtaS0ZqMk5jOFdjcjBsSlZX?=
 =?utf-8?B?SzFYSlBQWVN2cCtUQTIyOXYwNzc5V1NtWEVuZDF1QjUrK2dxbTBodzFaYUlL?=
 =?utf-8?B?ZnNCNmRDb0orQWZLUjJRUDBjRmpTb1JPVGJKQjRtd2NIVGl3RU85eEYwemNu?=
 =?utf-8?B?WnZkb3ZKKzg5US9obVJQYzN1TXdsOHZua3FUcklKcW10dnR1ZzFiR01hMWFp?=
 =?utf-8?B?Y1RBVjdUU0t5LzNIeGlSeDhqTWs0c0FnVXVBUnd5S05HeG9TQW5oWTlub2Zo?=
 =?utf-8?B?UzVKTW9HZW1RbWIxSWtoYzhHbmYvaXhtb1VpbDJvRVpBWUtFVzR0TXRWbjFU?=
 =?utf-8?B?UjVSdVExOE9tRFlaajdZalR1N0N1cnI2alZodkJHVkVOQWRoaVdrZ2dIbEly?=
 =?utf-8?B?K1pnUUVaV04xOUN1cTZHdEI5Z3FnRTE1MUREZmt5MkI4YXpCUHpkc21YQU00?=
 =?utf-8?B?NG5TNE9NU29NOHo2UHJsOW93YlBOMXdobE5Ud2N5T2liZ0VTY3lDWjVRN2FT?=
 =?utf-8?B?bmErTHFKVUdaQkU3dUZEczBGZmtaWE1uRVM1TXdPN2FMUkxJRWgyMXg5L3hO?=
 =?utf-8?B?eHVpSy9TUGVuR0FnR1RSSmsrYXNHREw3TGtFMmIyd3VIWjhNWDI4NkpwOUp1?=
 =?utf-8?Q?GcucaNYV4XrnvENsjfB2zxs05ewZJ1VRllojvpLbG0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fb1a8f-d6e0-48c8-3e0d-08da036a3a00
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 14:20:00.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuG6uQMihY5O8pwaI6jNOQov8Fam9heglhq8T9fFeA0w0v1D4G4Dtj0+jrEkU3AV1uCSacyqNoBiD5hDJw8eZdzXA/BguLN4NDnqb264Y7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2901
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110070
X-Proofpoint-ORIG-GUID: r-PoXcf__L-nhKstcdDA2yG-XqCcJhZy
X-Proofpoint-GUID: r-PoXcf__L-nhKstcdDA2yG-XqCcJhZy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/22 11:40 AM, Dongli Zhang wrote:
> The sched_clock() can be used very early since commit 857baa87b642
> ("sched/clock: Enable sched clock early"). In addition, with commit
> 38669ba205d1 ("x86/xen/time: Output xen sched_clock time from 0"), kdump
> kernel in Xen HVM guest may panic at very early stage when accessing
> &__this_cpu_read(xen_vcpu)->time as in below:
>
> setup_arch()
>   -> init_hypervisor_platform()
>       -> x86_init.hyper.init_platform = xen_hvm_guest_init()
>           -> xen_hvm_init_time_ops()
>               -> xen_clocksource_read()
>                   -> src = &__this_cpu_read(xen_vcpu)->time;
>
> This is because Xen HVM supports at most MAX_VIRT_CPUS=32 'vcpu_info'
> embedded inside 'shared_info' during early stage until xen_vcpu_setup() is
> used to allocate/relocate 'vcpu_info' for boot cpu at arbitrary address.
>
> However, when Xen HVM guest panic on vcpu >= 32, since
> xen_vcpu_info_reset(0) would set per_cpu(xen_vcpu, cpu) = NULL when
> vcpu >= 32, xen_clocksource_read() on vcpu >= 32 would panic.
>
> This patch calls xen_hvm_init_time_ops() again later in
> xen_hvm_smp_prepare_boot_cpu() after the 'vcpu_info' for boot vcpu is
> registered when the boot vcpu is >= 32.
>
> This issue can be reproduced on purpose via below command at the guest
> side when kdump/kexec is enabled:
>
> "taskset -c 33 echo c > /proc/sysrq-trigger"
>
> The bugfix for PVM is not implemented due to the lack of testing
> environment.
>
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


Applied to for-linus-5.18 (with return path adjusted)

