Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2258848465D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiADREK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:04:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44908 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230253AbiADREJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:04:09 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204GJB7G014889;
        Tue, 4 Jan 2022 17:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UsfgvgSwoVgqW+6vAySJ7ebtOY1BLt5+PoIBsDBtvwg=;
 b=PtUkVQydiJ+TGE8ga3f8vCfsY3j8CmdJO0x03dmHzKiPdukdEHvTgsWYQ5AOWiDnCcic
 1AHoQyzX60tSmOP2TfTQ1+wSabQian8AOTnaFlaysRF4SZAPnbGRs1PSBgJXfAiUtouN
 GzenuOIrVTC/JCiHkoYEMXYyHgze4yQJXD8EB40w/5TSWou2Z9l4cn7+miTy07PUp+2Y
 49Stl2mwT9ze110uDycKE1KuVa9jxZzQxoRDkzh8rxKeRinT+OpgJd6eS2AaK49tPi7g
 f5QsEGXOJRneoWY8JfUvRGJ4hcfbwrwauMk5WJ6st6TZyOdULwKGdZAwPdWG9FscfKqr IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc9d91wd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 17:04:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 204H1koY180747;
        Tue, 4 Jan 2022 17:04:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3dac2ww38k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 17:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loyN5mYYCkvCaeIXRpaEbDxBWUa8CR4dsCp1VKhKJB6MYgR1PUiKePIlCPVZe6hgM+BoOzLmR+bm4fIapXANmiYNwtTwxsigOCfLBeXlH2ziBUKPIKIFitj7cCnc8QbrR+KUfIjtB94gG6+tMfaQ86G2Xo+ngRBGA7oEo07UWtsbF35Ir/exEMHcGV866I/PweAWk/Ad6g1y8hVjBLh6HVFS+B7VGZQRHUErDshQWSr1zpsm5SmUqimPxgLUsuc4SHwEsUUGBxRb75RZ34jpSSHAhNPTT691gN46j7BWlEV3yU9PUI6B376q9FbM2nXReAHigc6Y2OKYmPbpXgLtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsfgvgSwoVgqW+6vAySJ7ebtOY1BLt5+PoIBsDBtvwg=;
 b=B2WsGjjmZOBIJauVBGo5xHUiG0jdPmXfOVHGfekq/WW1UQCoxqG6xTTg/1pzsIcj67GWVy9fjKezPnj2pRxkSrrhhbBLxGFWmr9lvOket7fmL5UfMWhz8ZLlMeZcdA/yuEiK1fYKHhsANHY8tbGrypshr6JQsM5CDu210nJxX4AuUOFga6mLX30X+aSde7DDkk1oGUfOqwzViQd7L2y5C3Mfdjny+vs+AIupsBWQTeIzt1RWzut6hdHhUUdCq3FXwghU85KX4q386OHCY82lK22NhwAlHam37wQ7dWLcEdPa27UVHdELGjW6UvFhnMlTbwWNcIiuNrsIJKy6FyQWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsfgvgSwoVgqW+6vAySJ7ebtOY1BLt5+PoIBsDBtvwg=;
 b=hyVSl+LOzZ++2imkbM1j7ObOhiDz4jBgj4gEZJfPJFZo/lkOYn0a5+aM60JZH3KVUn0G8h5/6xd8hdpWLEYkN7zYdg9SG0EdZ0P8duqvRVja41VJqxCm9IC80vhCohzYnxbSO/6CE6ARXXTS91bUpIMmqrBEgxrkaqIBhXyEXhE=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4302.namprd10.prod.outlook.com (2603:10b6:208:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 17:03:59 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12%5]) with mapi id 15.20.4867.007; Tue, 4 Jan 2022
 17:03:59 +0000
Message-ID: <16260904-c1ce-dc18-224b-03a131a92007@oracle.com>
Date:   Tue, 4 Jan 2022 12:03:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] xen/x86: obtain upper 32 bits of video frame buffer
 address for Dom0
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <a3df8bf3-d044-b7bb-3383-cd5239d6d4af@suse.com>
 <bfab8ff9-9762-f90d-3f25-b57362f05b0b@oracle.com>
 <17df4307-ace8-8798-5bce-16f4843ed830@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <17df4307-ace8-8798-5bce-16f4843ed830@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:806:127::16) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bba41c0-7504-4f24-cfc2-08d9cfa43329
X-MS-TrafficTypeDiagnostic: MN2PR10MB4302:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB430262F81C212462D164453E8A4A9@MN2PR10MB4302.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4KPGjcvxUZQWT7we7IPxfg7ia8CAY2LT0Y+qXqZGznk0pX9mN59oh2Zd5O1Goia0V6bKj0qZYyUZ+74kf67OV6wGEH58ax6X1ThHmnn/XesycBy2Nd/M48c+49EysVLa1pcdpyHUdWszKOns4jBIihJCVX5DroMREme/doJPBMNakqMkk9yHFnj6ylSVv01I02Q/jQ9nqjHBwH9NGuojfgdUw/sJQr3k18pR6BGC5+jBmJpp9EPfS0aS/ICKzVvg4nejpw1n5urNbGHgDT+lnA/0wywwMo5SQzUzjNmalq1IeONgWzJBazDLIZXWVbB5PM7NTNojMquVzYwpIAjyEzW0cDBdJr1pytD+mg4LqZnbLiKk+y8hoYgXFRs3rxaV75o2i9QX9G50p01RRLkZJIDAzP39Glf845kOV8u0YffbccNCPtrgsefNjGcdvgrJuZk4OX4cZK9YxKPyZNd6u6GLzOG48wvcXehlbcbEC/XJPK6A4n+Z7h/Te0HwmbL0D1rDrtp9vWO0UxHLYvF2u+m1VL1gKsPm7xzU5+Ui623y08y6tJFA6TGt7BamS2d5nfBY5R7VSnDQYZOxUy3eq+tQUhIGbxugP1IhIrYLBl8HVAliyk3OfCPBsTC7teLVfuSD1S5IuNbdTe4pHhUE7aEjcrZfZKmf5a7zdrMSneEs3aSybykt7bTU/vt2uSJQanVkjPtAvAP0uM6jmlOo68vIiFZmzsttrwnyw3Ls2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(66556008)(8936002)(31686004)(186003)(316002)(8676002)(6512007)(6506007)(4326008)(66946007)(66476007)(2616005)(53546011)(86362001)(36756003)(31696002)(38100700002)(2906002)(5660300002)(83380400001)(44832011)(54906003)(6916009)(26005)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0xxdDc1bTc0VjVDOER0dUpaeXNTY0NrTlJCOERRc3FScHdpdTZ4THp4VmJ2?=
 =?utf-8?B?K3RyTDNmUG5XelREajN2SndtOGEyUVVIaVE1TElHbnJOaVZ0VUNnbER0T3pM?=
 =?utf-8?B?ckRYVWl2bkVRUWNvQ1NZZEZQSHl5WVFxT2RrWWtOdlc2VXBEY2NlT3Y4amM4?=
 =?utf-8?B?TU8xYkNIOFI2SHhWZGptdFVXSWlXSnZCenowTzNnSmU4SmFUa3FCSEYraXZ5?=
 =?utf-8?B?VlYyTENFSzZXRnpSTDJ6QmJ2T3FRQWNwR1A3SWxHWHpmQ3ZPYk0yYnA3NkJ4?=
 =?utf-8?B?VnBKWkRoSUdONFhOeFQwbnpRWlRqYVlrRWsvd3lyMlpNWDFicnpqU0UyL25Q?=
 =?utf-8?B?QkRnQnZld0xKczErQjMxbUtta3lJRmRDZlNLWmdVenJNQzY1cmFuMFd1MDdU?=
 =?utf-8?B?NzNFWUdhbzhtWWpqRDJaZDVFN0dUU0cwbHp1clNMU3prZ3gzejBKaENQNnBU?=
 =?utf-8?B?Qk9vRXBya1cwbkdLUG5YbG53MTNTZnp3K3BlT2hmWC9LVjZlM1N2V0hxY2o0?=
 =?utf-8?B?MklBMHpLcWlGNGFDRmlQQktWazlQd3Z6RFUrclJLYjNEZjh0SUl5amVrNGZr?=
 =?utf-8?B?bUZwV1grUzJrK1B2R0FsMXVYelJRTER4R3B4d3gzem9DTFpJTmxvbmdTK3ht?=
 =?utf-8?B?Q0tvd2FFV3h6OWFTVmh6cU5RZFMvZVN6d1JSYWFVY2RRb0FwaGFTc1lvT2dY?=
 =?utf-8?B?VEpCdUE2Tk82dE1BMUNSYlVCOGh4WEdyeFA0WEdmT2RUcG5kK1JodFcrdk81?=
 =?utf-8?B?b0JoWTNDRUhyWS9YYm1HZzdUZnoyQWNWbCtDbW40cWkzYXphR0tWbTRwSGdC?=
 =?utf-8?B?YU8ydUdNUTRqbFRkT3BQcDFMOVllcGhMZHpXeWJnWjQ3WjBTcWVMcjRGbUNa?=
 =?utf-8?B?MkorM0kxb2R2dkdjTHRaUmJzSTNwNGE0VGR6M1VDQlJna0U2Z0s5RVZXR2RF?=
 =?utf-8?B?M2tqV2ZUUVFQNVBWT2JOVHlvQkVjY09RUnpHRnB2R1QxRmpjWnVpVWppYlpC?=
 =?utf-8?B?c09DSjJzYkc0YWFKUUZQa1MyL04wb2ZnVERMZVBkM0Jaak9xVklqWmpzcGVB?=
 =?utf-8?B?MzRTRWR5eDA4RWRZTHh5UHZBL2w0TE5yNmVxdEtVbjhGenhodUg0bkdBTUdJ?=
 =?utf-8?B?dHNzc0NRejZLOUdIeWdBVWp3aW00TnNQOWhDNG9IeG5scjVyMU53aDB1d0JN?=
 =?utf-8?B?WmhNcmI0dkJhRWhFNHFQRkhnR29pZnVycE1acEVXVGpJdXBlQWlKK0pIMENl?=
 =?utf-8?B?aDNYeEsxdWJ4ZkQ5aFU5UXBXT0d6VE8wODlMWjNuMzR5NjgzRDZjSCsycmxS?=
 =?utf-8?B?TXl0Q0ZDZC9sV1lKV3BHWE5MSmgwUlEzeWZNSXhoRThvOUE0TkFCcFYxSjRF?=
 =?utf-8?B?RFBKUUxVajVLcDF4ME54cHgvS2Iwa3puT2NZdlNndnFQSTV3SXl0ZjhCMWRx?=
 =?utf-8?B?M1h4VDlUNTVzYmtINkU1aXdTanlmaVRzYkJ2NlprUkgzR0h6a2ptRzJDdEF5?=
 =?utf-8?B?NENNM0VnS0hJSWRSWU1Pam43NFh0U3gveWV6L1h0RG51N1NsdEorV3N1eHls?=
 =?utf-8?B?RHBWOXFySmYvcm8rNWZWaUxFRVRiS0owTlZLOVpSeTZ6TEVBdnUrVHFzOU1P?=
 =?utf-8?B?MHhYcWduTVdZeWk1NTlhUHVEZnJFcndvS1RjZFdEZFRTeGFFc0x4bDhoQ05V?=
 =?utf-8?B?Nk1ETmIwcXpIRzB6UVFEaVN3eFZRUHZpbUNKYlBpeWh4UlFNQk10ZmZ4OWhD?=
 =?utf-8?B?RGE0eEtCeWRVQmw3aElUTE0xUXMzYW90RFgyUWtjcVRNQmc4UkhXTDZyWTcv?=
 =?utf-8?B?dzdIdkpZcHk2ajI3VkpTTWFqWXNWcmFuRlJEQkE2OFp4c3M4WHQyUlFHME94?=
 =?utf-8?B?OTNKMjR0TnZCUTJ1dDVCelBobjQ2WXV0SURHNTBrS3RnTEYxczZMRVNZdXpp?=
 =?utf-8?B?RGg2NkdXU2k1dzAzN3kxaGV5Q2FRdnp3NVovZEZLRk8yZkJrTEFUMThIdnpS?=
 =?utf-8?B?MTZHQnBqdzM3UUdTbUhPU2dzSG9jdWZZUnB5RVpRcmk1WEJLOThjdGNwclNT?=
 =?utf-8?B?Mmo4YSsxNTQ5aDBKZHI5MzFvM0dOL0RRVDR6UzVLd213RXVqbXNyWFBRWUVM?=
 =?utf-8?B?b3dFYVpILzV0eVhuY0NxRk1PZnFPQk9ob2lkdEFGOVVSY0Y3N1diYTNYdWZ4?=
 =?utf-8?B?VUo2Sk9NRE1mK3VzdVFpTG9FSlJEb2N0aXNLdjF6NG8yTXFYM1J1cEVPUnJM?=
 =?utf-8?B?UXdMT1VaeTZsVkZTU3FkUVY5YjRRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bba41c0-7504-4f24-cfc2-08d9cfa43329
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 17:03:59.1322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMpFlOCZFgxmBNUNUM/s20J4j1+PqcenaZ1a3x97dFqqd45Ds53s77RiaWZqHJbCufvDK8fgtmw7XsP8hu9UO0H7PYUu/pecydIsxPRmmFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4302
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040114
X-Proofpoint-ORIG-GUID: t63ILhanXgBp-89bdCO9U-rVeHXLpeQJ
X-Proofpoint-GUID: t63ILhanXgBp-89bdCO9U-rVeHXLpeQJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/22 11:54 AM, Jan Beulich wrote:
> On 04.01.2022 17:50, Boris Ostrovsky wrote:
>> On 1/4/22 3:46 AM, Jan Beulich wrote:
>>> The hypervisor has been supplying this information for a couple of major
>>> releases. Make use of it. The need to set a flag in the capabilities
>>> field also points out that the prior setting of that field from the
>>> hypervisor interface's gbl_caps one was wrong, so that code gets deleted
>>> (there's also no equivalent of this in native boot code).
>>>
>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>>
>>> --- a/arch/x86/xen/vga.c
>>> +++ b/arch/x86/xen/vga.c
>>> @@ -63,13 +63,17 @@ void __init xen_init_vga(const struct do
>>>    		}
>>>    
>>>    		if (size >= offsetof(struct dom0_vga_console_info,
>>> -				     u.vesa_lfb.gbl_caps)
>>> -		    + sizeof(info->u.vesa_lfb.gbl_caps))
>>> -			screen_info->capabilities = info->u.vesa_lfb.gbl_caps;
>>> -		if (size >= offsetof(struct dom0_vga_console_info,
>>>    				     u.vesa_lfb.mode_attrs)
>>>    		    + sizeof(info->u.vesa_lfb.mode_attrs))
>>
>> Do we still need this test? All 4.0+ hypervisors will have mode_attrs.
> Perhaps this could also be dropped, but unlike the capabilities part
> I'd view this as an unrelated change.


Right.


>   Furthermore even a new hypervisor
> would be free to omit the field, provided it also sets size low enough.


If this is allowed, how would we deal with hypervisor dropping some other random field here? Have we had a precedent of this happening?


I think it's safe to drop these checks. In fact, most of them in this function (except for the last one, obviously).



-boris

