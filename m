Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1600648B045
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbiAKPES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:04:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39380 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240338AbiAKPEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:04:16 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BDBtL4019436;
        Tue, 11 Jan 2022 15:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VBAn9GmpmF+nkAmMrgs/brG9lHBl+XY/LyxeQmn6OBA=;
 b=JNOpTLpLmJi3FgnBhXqWzAQi7ljYFrEd9xmehHLpKsghv/Fc3QUy0gF/dEiFXZ4C1Mdw
 0yBIbNCPH2Iy7Zl68rQzx9s1g/0xjtK4/SDSoVlAlSrVn5DTgnzvI+4eEVro/+4z/NM2
 QshTCIbYfYxlwNYTP4gnpk9MmaFbrIAclMm8bgtCBOOg3YJT21rC9Ga86mZvqIfSOKNO
 hXkTmxQN9wyLeLap/pP1ilZ/21j4kGp8ZmcADGNvKx99YSTXS3M2q2VuMUiAcKlhLHzv
 EifMQaKfuQy6JaPbcOx+6Luntya7NO/4Gx2ICbg/7PshcmxC1e0LxKRtZPbHfOJARItp Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74b776-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:03:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BF20pc065813;
        Tue, 11 Jan 2022 15:03:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 3df2e4vw19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:03:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrjaFDzaLx/iCKzRPdl/ujzTBVuRiNCwtxNOM4elPy3is0aLNmHcaGOAXsNyCfvNxyLM711lOqfM8c3A+CMw5QkWNe4FTUGSZIA2BjdHeKo51jtnIjxpVU+ci98CKss4Gp2mCiVC4BheDvCjJCDfVL5qWYFW4EOd3JmeDqSRy9E6232QcZeklBwOYZUaUR6zCy6wvm5wJKlQ7wOdJqsCmjwW4alEkyXBjJngBNZKH4oTos/m81p0ozNV2OutA8cIwRvBm2151LfikMuXj5DlXkbWyhm8gr46K0HAYr/abBSvme2RL38Ml3qHa2Mt9E93ee5HsorxsEmn9abBXI5CKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBAn9GmpmF+nkAmMrgs/brG9lHBl+XY/LyxeQmn6OBA=;
 b=W6JZKvXfdqFCnVaE78TXCvrbE+j+ahpEQzp/3uvDRXKRW9ekk5d/JclmcYFBU+5wA87OgdHc6VyjUUjNOcnnyxwqAo0+5rPHCv+AGkRJGw/7sIeoidAe6VCR04Qa2MXWBZa/cv+NLhvq6HFJV+1n8lBXqkVaHiuNShRisi5v+ZNLdbiaNLER/59J26eWg2XbCtYd5xNqGfTdAquUQv716zXuf5FHdIaNlvuXGAP+7uD8uuoWXBacqpR7qvvZI1kPwgyPuOnpAxigrizdK04Is1cqBONEcFwdb9FMhDBBkym3JKILJG2nQDJLWkCg5DtWOv2aYlirXmsUarMrUqOVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBAn9GmpmF+nkAmMrgs/brG9lHBl+XY/LyxeQmn6OBA=;
 b=Ut145/F7FD2CD29M65dRmYYj+2cli71BNC/5nPCWyRXT0FkUNAVnua4GJvHjxNQnIJ/wv1FAHuHMnoeLMFX468g7gYxIbnoex1Y7buP29vVDyNHAz52HQBG6NFSSmknNisELdkgzl297hJHZ4fJtDAfAbDyi10GRIPvkRXPu0PU=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO1PR10MB4562.namprd10.prod.outlook.com (2603:10b6:303:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 15:03:38 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 15:03:38 +0000
Message-ID: <7f420af1-9fce-5a36-5788-8de52502781f@oracle.com>
Date:   Tue, 11 Jan 2022 09:03:22 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v19 01/13] kdump: add helper parse_crashkernel_high_low()
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-2-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211228132612.1860-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0127.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::6) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd636c8-2a6a-4cd0-ccb3-08d9d5138b9e
X-MS-TrafficTypeDiagnostic: CO1PR10MB4562:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45629F30404CE6788F7B8D80C7519@CO1PR10MB4562.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XekoRyW27++tWPhpT6YOMUlA4COc4mjHNPsEX5VmZJliyuPNipGhCkDHGOIuxd3x5Veo3xrK1BP6W5aqDJZ5dEZiNKHTgTa7mmYGLB5kKtUAnK5glT7mBtzAU+xayChR99ZJpIrC4dVFZAYYP7hHedq5jQDZNi3gLtHiVpIVMawgT+/A4J5Y3S/969jfVpqye+iPOYtymRM/Ov+sEm+9StLNSEBtKakKIMI64wEGKWycAmNhAjXBuZAanYC6XPm/LkPJQkJbL1eFgQHJRKkbN76UCJ08nKG+SvbWZSJNaFr/T7AqZdtzdnHkYkyuRWjBUoJ02Sv+ZkdSbYeLJw/VzLk/+ip2XPFzK2K2Ku189ficUfoyzp9OdBEtj05Uy86eM+cae8APZJZU2KmPlpkWuyyFhyeXwFZzUtg6/E5+Qc/MLzgkl8MBdG3DGXG8He6cTu0TyuNHwJlGizmK4PvdXW6bJH7FeotaH3Tuqn8uOHFRJrWUpa6MStFVB1sWqkLI9OGBQrAO3qjqgLEpHE5L5X/r3z1OybhYoyYieQRR5SJh2iXEyqxGLTc4DqNelfh1bzx4g9xfB0usdmAkP3h7848MwYf+x2YZXfEii+vCxCXrth03eRQ+XGkv/JmDQdUnJTZNvUeteF8B46pgVBFDH0Z4rsz1yydttLVt+4hnioJynefYeHuDRp/Bp3D3GPWWerEEV489Haaue08O+l/qYroU186qSZwNWK7OarV9ORU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(54906003)(110136005)(66476007)(6486002)(5660300002)(921005)(508600001)(2616005)(66556008)(316002)(36756003)(86362001)(4326008)(38100700002)(6666004)(53546011)(31696002)(8936002)(26005)(7416002)(8676002)(66946007)(6512007)(31686004)(9686003)(6506007)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzgxYVg1Y0lxNmMyVnpHZTFHa1FMbUxNSWxib1FjNzZMZ2pnczFxVzNuODhy?=
 =?utf-8?B?bEJ4aDZ2OHUveFhXVzJtL1VhMDFhQUVjendmMEZKOHoyVDlEa3N2clU2Yys4?=
 =?utf-8?B?T214cU9HWVM4S2lwOXp2azlqazNXMW5VcFVMeU5PYVphUmdxaHpDd201Rkhi?=
 =?utf-8?B?ZU02UXFEK2JSSThLVEhhMUNqNk5iaXdQRlZSOE9PUXo3aENzT05IZUorUXBT?=
 =?utf-8?B?YVQ0c0NIUUlPTE5aTEJCd3JVcDdjMkNFK3BzWEM4d0RSRFhqenJ6ejJHd1Iz?=
 =?utf-8?B?aUlTdXVyUEMvY1VtZHZOL2RwVUlYUUZOZ2tkQkRIYUhtMXllZ0QwUmQzMmFV?=
 =?utf-8?B?NTd3REw4YlNJVlVnOVdMckl3OVdzUzgwbkl6ZUlkZk5kN1NkSWJDOHo3bTMr?=
 =?utf-8?B?V0c3VW0rR2syZ3VXQXFyM1B0VVkrNUk1UUpOUzJtaVVobGREbVZ1T0lXSnd5?=
 =?utf-8?B?ajBlTVUyUU1GRGRyU0RVN3puQmNicU5BWUd3MGRaVlp5Y2lNTTJyeUtTRWpv?=
 =?utf-8?B?emRhQzQyZG1nY21YWG51YVJOVnNkei9VY0p5cUVJUjlaR2VuZW5TVnMzMVR5?=
 =?utf-8?B?NUNrMmI0TU9XMUo1cDNwWDZVNnlHV2dJQkJ4dm1wZktBb2ZtUHMrYTFOWGhl?=
 =?utf-8?B?RXU4MFF3WGIzUHM2Y1N5bWkrS3pIR3JxSnBqN3EyQXpNNGYwNVVJK1pQZTV0?=
 =?utf-8?B?V3VkcStBVFRKQXZIQVg3ZGxUL1RDQUo5TDA5WXBlQmNUaXRjNWZSMWRELzZG?=
 =?utf-8?B?cW1IV3pTenEwL01XVUtibFRDM0hCMTZVRGtSSUNzTngzYjJlb250WG8yekRr?=
 =?utf-8?B?UGduOFFCQXBCajN3elhmUXNoclZXK0dpZkpsMkdUL1JIa0s0ZW5BQU54TTJF?=
 =?utf-8?B?M1QwWTR2WTBPZzFNdWVTTUxlZWNpNURLSytqMnM0M3NsMCtNMVpTT2FLb0hh?=
 =?utf-8?B?a285RnNKeDlXb3lyRVZBdUpOU2pOWlFISEwzVjdhWS9pNWpPdld3Wm81eUhV?=
 =?utf-8?B?aUk5bGZJTHNTTjNVeFdGVzNsam9ObGVSU29WV055NW1EMDUvcjA1Z2FsUHJW?=
 =?utf-8?B?QVdnYkY3OTZsd2tlc212MitNY1dUanh4Nys4Ym1iQ0hpY0tOT1RQR2RQZzYz?=
 =?utf-8?B?VDVqeS9XZlNxOFhrZXkwcjdsVUM2NE9udnNFcVlhT3ZhNFFTWnc4MnBUQkxs?=
 =?utf-8?B?TzdkZVhEd3YzaW10OW94MnoxQXVqODVPK3ZjSEFRdlBPWFNIU0c2dlc0NHVG?=
 =?utf-8?B?eEZyVkFOYWFCTlZ0RVR1M2JtMmtaaHloY0xmb2N5bjN0SndKNnhwd2NoS2JE?=
 =?utf-8?B?b2ZhM2hXWVhNVU82UkI5UmNzSUwrSFU5NkVrSjdnMmF2bUFQM2pYWkMrMmxi?=
 =?utf-8?B?WjJSMmNhNU01VWxNTW44Uko0MUhIcjNhdE5CNWxlbkZ4eWJSbTA1QXlld0pa?=
 =?utf-8?B?L3htK1JEN2NGNDUrTE1OaWtUWDZ2N1RPRHlaUGRIVDlEdlNLSjIxb3dBS3pr?=
 =?utf-8?B?cTJaL2htS3N3QUlYTS9ETXVCNVFRZTdZWVVWcHh4eFpTYVZ0aForbndXZnBB?=
 =?utf-8?B?WmxsOVNrYWdZbFFiZkIvNU1paHBMMnR2ZlVPbnVGYnhURkllclRTMUJGZzd5?=
 =?utf-8?B?UXRQR2F1aERDWjdNWERWRW9qVnY0bkNBc1FMaVJITkYwZkdOOXdHdkI4MU94?=
 =?utf-8?B?Z28vWTA0WVhrSnJTUjJKa1BIYk1MSUNDa2k0UlZ4cVdHVWMwR0VYZzBqYlUx?=
 =?utf-8?B?ZWhzR3B5N1k1MVNSZDNQT1RhR3ZhQWZqTGJwZTNHbjJlOHVCSXowYXduRnlz?=
 =?utf-8?B?Z0hOWnJ6aHdzMjdRMzlNVjJIWTBkTFQrMUR5cnNPcHB5VTUzRE1HZ1pzRkhj?=
 =?utf-8?B?UHpIajBNMGpIVm5IbTJQWGFza3p3aFF2Vm1CWHR0LzVsemxKWkV6cEpNSEN5?=
 =?utf-8?B?WHlNZ3lNWWd3Z2xFMzhac2cwVEltWnBmTGhWVXo5MDNhN0lDanhXM2hQazQy?=
 =?utf-8?B?bHhuVHFFUTFXd21KdU1lQUhOaWVGZnJyd1ZmNktaREVseDgrNkVoMkw4RE5j?=
 =?utf-8?B?c1hJQ3l4bk50TVFqREhvQkpTTVFaU2RWS0owaFRXcFZKaWdRek1LV1EzNkY1?=
 =?utf-8?B?N3ovN1E3T0hocUQ0Uno1OVRoeTUxbk9tM2dBb2krK0dUSWxEdzVUeDJOM2Vr?=
 =?utf-8?B?UFF6VkxhenkwT1hXS3lCbjRtaStFWXFBMWFFdkY2NGt3bmlCUW9uMlRSU1JG?=
 =?utf-8?B?WW1RL3ZXSmU0QXU1OXBSZW9yODh3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd636c8-2a6a-4cd0-ccb3-08d9d5138b9e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:03:37.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtBhydoKYCgNg/JjSshknLiQ8KJiIpWdiV0cOB4ogMrGrtmD5+0KoYQWP2eUii4mV5IHqR3X/fVBmWtfwnmrXueIy+24/EnTlPNDrkWfPtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4562
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110089
X-Proofpoint-ORIG-GUID: l4IiQfj8S4PZG_Wx-idRffAGkxJRrazU
X-Proofpoint-GUID: l4IiQfj8S4PZG_Wx-idRffAGkxJRrazU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> The bootup command line option crashkernel=Y,low is valid only when
> crashkernel=X,high is specified. Putting their parsing into a separate
> function makes the code logic clearer and easier to understand the strong
> dependencies between them.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   include/linux/crash_core.h |  3 +++
>   kernel/crash_core.c        | 35 +++++++++++++++++++++++++++++++++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e7db..2d3a64761d18998 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -83,5 +83,8 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
> +int __init parse_crashkernel_high_low(char *cmdline,
> +				      unsigned long long *high_size,
> +				      unsigned long long *low_size);
>   
>   #endif /* LINUX_CRASH_CORE_H */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index eb53f5ec62c900f..8966beaf7c4fd52 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -295,6 +295,41 @@ int __init parse_crashkernel_low(char *cmdline,
>   				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
>   }
>   
> +/**
> + * parse_crashkernel_high_low - Parsing "crashkernel=X,high" and possible
> + *				"crashkernel=Y,low".
> + * @cmdline:	The bootup command line.
> + * @high_size:	Save the memory size specified by "crashkernel=X,high".
> + * @low_size:	Save the memory size specified by "crashkernel=Y,low" or "-1"
> + *		if it's not specified.
> + *
> + * Returns 0 on success, else a negative status code.
> + */
> +int __init parse_crashkernel_high_low(char *cmdline,
> +				      unsigned long long *high_size,
> +				      unsigned long long *low_size)
> +{
> +	int ret;
> +	unsigned long long base;
> +
> +	BUG_ON(!high_size || !low_size);
> +
> +	/* crashkernel=X,high */
> +	ret = parse_crashkernel_high(cmdline, 0, high_size, &base);
> +	if (ret)
> +		return ret;
> +
> +	if (*high_size <= 0)
> +		return -EINVAL;
> +
> +	/* crashkernel=Y,low */
> +	ret = parse_crashkernel_low(cmdline, 0, low_size, &base);
> +	if (ret)
> +		*low_size = -1;
> +
> +	return 0;
> +}
> +
>   Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>   			  void *data, size_t data_len)
>   {

