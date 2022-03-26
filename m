Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3824E81BD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 16:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiCZPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 11:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiCZPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 11:11:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF296C905
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:09:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22QDEv88014371;
        Sat, 26 Mar 2022 15:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Olf3oAAddyZOaTnS0/Bj1ES9HeiSJ+pfiqGcQJt4SeE=;
 b=zVLXv08vO71P0fy0DisBgeDZEBjhbyV9zwlIOLpvofPL67A/0mP0GhK53ySJNaxBXz2c
 Pt2aFv0yjHF/zFEEQzXuBM4NXotu2OF1qmEvTrzBrw0eh2KUSCxX98G3bL+05kqFFAqD
 bY00RpGYn12k4UrX42+A44FeKlGcJP15CORerzGa9OFVDxD5GBqPy6emTcgLRIztlPam
 HK2qirk2kQbCqNSIkXb6q4R2EjMEqfSi8haxeK01bpKWcGTM1WEBy28JhA9j2tq4bztE
 ColMpOAgamNjv2EUkQejkPBIIUsWUgxwNgAZJsD35GRN8kahIEEdxAvCRtn2CIZSacb8 Pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cgm4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Mar 2022 15:09:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22QF9XiS110750;
        Sat, 26 Mar 2022 15:09:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3030.oracle.com with ESMTP id 3f1qxq8qc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Mar 2022 15:09:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRFq4+NIxQvNVIb5q8YUZPISyl5Q1V76+aFLZbWIpYWHM0D8LXIg1pxjft2k+Tx59fKRvYNfn5MG+oEaQ697Lqcs+CGX/E2fv9Kn24AVow1rEDnDPxUhqledcpH1c7iNh7ajL7IpIVSE9X1AKdZfuBplptZZT0fA6ehcaHmIWakISpA88b9ffHX/2O79hou/CDUkvOdoCyNmrV5Jpz0FKoLhft+ODqCxunHmRMmrXt2u/P78yIvkphx8LTda+7LYMwMdTfRr5AqEdvWa702mGF69jrmfUxBXCwwWAjr/irLkjG/wFVV0QXVjGP0y98pL3CwxoNrvvdiHjOZQmQ2ptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olf3oAAddyZOaTnS0/Bj1ES9HeiSJ+pfiqGcQJt4SeE=;
 b=Jbs6HSsJXEfXJtK1C3t5UvDAUZFR7V3dSDBh3LGpNRx/NoU5FFEsReCaUkS5/ETs2zMl9fZOVWcWQwGKoDocPuRGW1oD9VL+KI9Vj/Mz48YgYhBzlNli6nu7toZ1V9o5A0k1D90QELNf6sxpxB/DifHRv4sLX8AoHSFwy7hhM3kkPtPEzKC5FZ5XicqqGygBHmgmUrKac+6mA7Yd/2wsrIDdb1DyJ5Mod5adp1kX/Wf1EVDNOTEfiqGSGajN48L1Rfda+mTQmAPInFDe8StYJfbSqOSle2sowFT1PjKBvbItjL8rHGuZOoRb0wPyYA/qvuFK+ODJW+zsehDdX8P0fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olf3oAAddyZOaTnS0/Bj1ES9HeiSJ+pfiqGcQJt4SeE=;
 b=rKUd5Zs95j/XNrnQDEom3EPTGQG57WxAk2EZ4rUM40AmINOKBLYz77KIGTFwDU9XQcGSPh22Y/04eZpCC/6NTR8Lp5nX7GyhxIsJJjhb94XFwxOTFV0hxmXSIyzh4Y9gZ+DhEdBTF6SK+qVFn8cz1xYfnjKidlmi7i3xe431PdY=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Sat, 26 Mar
 2022 15:09:30 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755%9]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 15:09:30 +0000
Message-ID: <c41a7822-c4d3-3589-f39a-6a2afee67469@oracle.com>
Date:   Sat, 26 Mar 2022 11:09:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] xen: fix is_xen_pmu()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
References: <20220325142002.31789-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220325142002.31789-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0151.namprd05.prod.outlook.com
 (2603:10b6:803:2c::29) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e4384f2-cda6-47a3-4797-08da0f3aa06e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44290F328EDEA4BEFCE6D3648A1B9@SJ0PR10MB4429.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlBXwuy5DqEUORN4aP7S1pLLXxKixHUq9Kr1WvQB3RNJZ42nwDdHRozz498fmvJP8KCvP3q5vsYGgY0/Y4ZNyeD7uait+Bj9WagQdq6zAAN6nQBC2U24VDFYofn5kaAk5CniVfDWZm1AYTDctOoHZHgN+QCxM8g/PGsRCy5VBJbFDMitCDPBrkk9nVy5hN9uBZTbnpd2HlJTBrA682Z1HK6/1O5FiBSZiIdDssuOtexAqV8NXJrISBeuQgIuBVWM+c6erUUtzcvLa0cZPWr60e61pHvaBB8Hw6LY7zxn/iUbnLnK9jyW+ydAMS+0uEFWDNs9/Ec7qAkJUPZ7qIoDZGR/0vbH0udyPy7GgZvfuuxagNibMm9zawv36NFpjLejwusAKzHfYeJ0TiojYEOoFlZkgbyT/0NpTPWkPgIjR38TqE7rX/46UVZ/iLCYBTiNzlwVmmSJHZ8sp0NPGDb8PljssATm16xr1ypDGmgaDXuTK+eb5AUcG5WcPjWQsylwK6L/lPJ3ccaYYtS3LZrf7vGDnYah42f1raWulUqkBVCSrWu1xwpP3ssAIBZWMZIEKzT7fcfIlv0/EELMxHi0NKjlvB7PYSA0bDEJBSJ8sxUgs5dMxDOlAdqTHKkoxM+ZrfiJCLA73bw3bvauRqtnutM4ccp2TRq2ISVUcVszuIioJnGrrc41z0J9ADIailMSNIXlG1UsvkFGY9MxLP4ENN7xJSr5hbCJGxHtRx3R8ZiXczzEJ5EvTsW7papq5Pa8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(36756003)(4326008)(26005)(6506007)(2906002)(6666004)(316002)(8676002)(53546011)(38100700002)(66476007)(54906003)(66556008)(8936002)(186003)(66946007)(6486002)(7416002)(5660300002)(508600001)(2616005)(44832011)(83380400001)(31686004)(31696002)(66574015)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJjakN2VFd2WHF2RjVNU21hMk9YL1BrcHc5dStWWnNnejFxZTZtMnVPcHBp?=
 =?utf-8?B?UTBFZW9VMmFpNUVuN2tMN2VRWi9GTC9IdkVLS0R6TFI5QmxqVm03NW5EQWZt?=
 =?utf-8?B?eFcxMnRySWhvem9sNTBJRDhwV2lqWVlBYXVLKzlWOEZtSFBMb2d1MTdpdDVs?=
 =?utf-8?B?b3BjKzZXWEZRaStyRW1KQ2Y0R214R2dSdVI1T081d0hpa1BiWENkdnc0dXp1?=
 =?utf-8?B?V1V5cmd2OXptV0I3eDUzeERoYU1JcVU0MHJBb1MwNU5UWnRKVjRUOEFTV092?=
 =?utf-8?B?YnJSdWFrc09jT3RkZW9SV3RWbDZSVUZsQjV4OVkyeWNoZi9UVFkvdFBUc09r?=
 =?utf-8?B?cE9LZGJ3RnFueUMvTzcvSEViUldDTnhQaHdtN1VVcm0yakVCL3VBZk53L05w?=
 =?utf-8?B?ejdlbjBTOHlkTWt2WFFBc0ludjNnczEvL3ZtWE9oMXRoNS8zZkJLV1ZZNjcw?=
 =?utf-8?B?V0xSOW1sYWhGVllaU2xwUDl4K2gvOVZBSkdvUnRjWTh5aW1nZU8yT01kcS9l?=
 =?utf-8?B?Vldydm8vdXBsV1pKQWlSRnkvQTdrVVFYbEVvVXc3VEI0OVp2aWpXZEVLK0R3?=
 =?utf-8?B?U3JFTWxHODJ1Sjg1bVVXQys0NFlzV1djS0xOWXJDWWhtYzNMY3FscEYxelhW?=
 =?utf-8?B?TUNJUzBZNyt0WDRjWlV6Vk5YNk1ZeXd4anZXTmVJOFNKR29waXJKenZmS3Aw?=
 =?utf-8?B?a0dJSFg4R1Z0WGY4WVJFQTFidkJYbGxDVzZnMEJGNEhMV3FvdmNQRVJ5ZmJW?=
 =?utf-8?B?bG9vOE1CWVl0TENjMUZZaEd2SzlQMWlyeDUwQnVwQ01ZeVZxazJPbHRLWk84?=
 =?utf-8?B?NVBtQ2ZqcGlnZzhCYjZDRWhZMGlPUll1L1o4dGRQamdnVVFaZ3NudVVCeS9P?=
 =?utf-8?B?cVk3Ri80d29ZNVNtS3EzM0tUeUlyTi92d0k4Zm9jZFlDeCtkN0MvdkZZelg2?=
 =?utf-8?B?elNRMmQwZXBnN0hyaG9BNElXd2JnL0RmT1lSSXpWdHJwR2ZWUVR2Y2V6Y213?=
 =?utf-8?B?Um9xNVFLVnVQNGpSOEI0MVFrWHg0bHEvZ0M1dmtkMGg3QnlodzZ4KzEya0F1?=
 =?utf-8?B?TVdDem1uSDBRUEkrR1JUQTYyYmNHUVV3QjgvVVFIR3pielFwbEpOemdFcWJ3?=
 =?utf-8?B?NEwxS3BsUnhZYkxxVG5aWVBtUm5ESmI1eUxFRVFOdnBhbXd1YmozOG5oR08x?=
 =?utf-8?B?YWJ0VjlGb0NZbGt6MDRNb0xVaGhFMXdDckRDVkM1dWxWRzRDMjczTnRDN3R6?=
 =?utf-8?B?S1c2akg5NXdxNjNHSXNrTHRONWc0TFI4WVp2MGtlc3pwbk85dmpFMFJxY0k0?=
 =?utf-8?B?SDhic3NPc1FoZEl4ZmZXbkw5dXBqM0FlRnRKbWxGd2FvY0ZGWUFtTkQzMFBV?=
 =?utf-8?B?QWU4b3h6VS9sd2pCVlJxR21aMG85cXdIVmpCQWIxRU8xZ3NDTXJoSnpOVVFW?=
 =?utf-8?B?cEgvbHNMZ2Z3N1FqUjZud0JiSXZQd1cwLy9NSVdTbFk4LzJGL09JWVIwRG05?=
 =?utf-8?B?VG5wUW5uc1RLWnZPTEJUZjZnVXdWbkhzeThnbW1sN1FnbE9CaERjVEhWTUE3?=
 =?utf-8?B?TEREWnlTOVJxZ2puV0M4M3ZJQWdxM3F4cDJ2MjNZQjVpNXF2UmNaN0hOWVMx?=
 =?utf-8?B?T0ZuNHlvNTdyRGdjVENPNXhkdE94WFNubjdCVlk4UDZFQW5kZjQrWVFvWUZI?=
 =?utf-8?B?VEJXZWtMNFRZTllhU0tNVDVuLzZ5Z0Z4ejdSOWMrb28rdDF1a2p3WHhodlhQ?=
 =?utf-8?B?a0dUNkQwMjBzOGlkVXh0RTlPakFncEw0SitoQXRsQURPRUxZaWU0eDIwRnQy?=
 =?utf-8?B?VmRuZE5IU3doTkNTQVA3eEVnYnhkVHFxa2dwdWJIZ01NZVlEM050ZHp5c3Nv?=
 =?utf-8?B?Rjc2RWVzOURheEdudENJeFpBM05SMzlrRVhvR3dxdUFDakhKeVhxZU02b2pN?=
 =?utf-8?B?MktDeGJPcHNGblpRem1URnF0cGU5MTVpdm5haXZMemo3U2JhSG5WUk9jOWIy?=
 =?utf-8?B?VHl2VlFPWlRnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4384f2-cda6-47a3-4797-08da0f3aa06e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 15:09:30.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgSwHRk3fGWC+AY8CQJnh/Edru3XqIULvkp+trZF8vklR9Q1glk7dRA28ht05R10+CsyDWJ7cuXyA6Tpd7z3QnOgc4FeXfpPyPHzFhUxHic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4429
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10298 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203260098
X-Proofpoint-GUID: D2ydAiWTgQfOiztmLZK5d2FW-1klQXok
X-Proofpoint-ORIG-GUID: D2ydAiWTgQfOiztmLZK5d2FW-1klQXok
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/22 10:20 AM, Juergen Gross wrote:
> is_xen_pmu() is taking the cpu number as parameter, but it is not using
> it. Instead it just tests whether the Xen PMU initialization on the
> current cpu did succeed. As this test is done by checking a percpu
> pointer, preemption needs to be disabled in order to avoid switching
> the cpu while doing the test. While resuming from suspend() this seems
> not to be the case:
>
> [   88.082751] ACPI: PM: Low-level resume complete
> [   88.087933] ACPI: EC: EC started
> [   88.091464] ACPI: PM: Restoring platform NVS memory
> [   88.097166] xen_acpi_processor: Uploading Xen processor PM info
> [   88.103850] Enabling non-boot CPUs ...
> [   88.108128] installing Xen timer for CPU 1
> [   88.112763] BUG: using smp_processor_id() in preemptible [00000000] code: systemd-sleep/7138
> [   88.122256] caller is is_xen_pmu+0x12/0x30
> [   88.126937] CPU: 0 PID: 7138 Comm: systemd-sleep Tainted: G        W         5.16.13-2.fc32.qubes.x86_64 #1
> [   88.137939] Hardware name: Star Labs StarBook/StarBook, BIOS 7.97 03/21/2022
> [   88.145930] Call Trace:
> [   88.148757]  <TASK>
> [   88.151193]  dump_stack_lvl+0x48/0x5e
> [   88.155381]  check_preemption_disabled+0xde/0xe0
> [   88.160641]  is_xen_pmu+0x12/0x30
> [   88.164441]  xen_smp_intr_init_pv+0x75/0x100
>
> Fix that by replacing is_xen_pmu() by a simple boolean variable which
> reflects the Xen PMU initialization state on cpu 0.
>
> Modify xen_pmu_init() to return early in case it is being called for a
> cpu other than cpu 0 and the boolean variable not being set.
>
> Fixes: bf6dfb154d93 ("xen/PMU: PMU emulation code")
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>



Applied to for-linus-5.18.

