Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5348AD25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbiAKL5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:57:47 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:11088 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239003AbiAKL5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:57:45 -0500
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BBvXhu022354;
        Tue, 11 Jan 2022 03:57:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=TK3gwren6yRkGdhxuT2CglsxS++OUsKrr+FdkRW5tBI=;
 b=tB+NEq6JS3dnN57+tHPXLAnQO93Olo+zkQADDvM9J5iV3GUbh+C3WOYnhWCIQD2ENr82
 ImPlKfLomkqn2uCEoNqos6a6uMEVkGZEGQkFYVoZj+RnNM0qlqHgoRoNvX67EPcPntvi
 1eve7q/SW9xJhSTGeweRtq6nCpNrKiqXIH2TvwRoVEPTOEexagsECm4fiDjGfUMqe0T8
 E2Rr0VcOWhQyTe4+DGSU9R4vp5vnQoDGgPCAG2uu3b6SCHaHYiVyeuL+DmtG3G+r36VX
 gJCV/TxhEwi+U54X2e5zIGGdoKT7lcx54Uk/jMXFv8wJtptiAbPjp1JgXGuLM36RgR8M rw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dggv38wd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 03:57:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHQM3R6GR9qB5lWMzx/jqcSkGj4bvFJnGvVJIl594Rbq5+pJiaBJAwylwQ2DRE4SMVyWrB2ZkcUAeAYw2+22my92FKjpSI9bG9h6YIk+oWzY3OznhVbiRYytEOlufCaUEfyS6a3ujiMHFQyWL/w2S9/Eq3roDZHryZVM4zdN5y7nmnT/7reNYWhiBuXB9PxtT9UdWNTNU076BirImguun+ADitPX8b3YMo/RU93uae34zpQwFjYCuIONfRxO9PHU0RWdgHPZmLJ3DoUU/xSKA8TboLKXJATejNYJoT4aiNyzHkP6PuzPcvW3BK0ZO73GJAw1PAyM3d1G8CoHqBh6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TK3gwren6yRkGdhxuT2CglsxS++OUsKrr+FdkRW5tBI=;
 b=lF6TKZus7QVKoThTdffUpYljRcub8lSVuovN2z5KLV+fdRAa+b599+Cg4jl/gnVFCcaoIKE5InOO6WtSgBCrmD3qAzpgpuxQURppbDCVBo010/TeiSHO8OJuk48u2HDnvJmgJPPWOay8jQyup+ohxlxN/SPnlGq13RWzZZvINbrlt0YfTpUtDRbubk4Fv6mBkDa26CwfbW/boDY0y1rNgK9BRgHy0+xowhUuN2GCzklSnYbI/YDaUMDjVj92J5wN8feCtoaSW43+FdGuyqOqRzMojMGaZYXVJ5cmoTYDfP9N0QMcXToBLCS0mqk2dg4Xul+iPT0W4rIFD9ozTK10vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16)
 by SJ0PR11MB5039.namprd11.prod.outlook.com (2603:10b6:a03:2da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 11:57:30 +0000
Received: from CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::dd33:eca5:868e:f800]) by CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::dd33:eca5:868e:f800%7]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 11:57:29 +0000
Subject: Re: [PATCH] platform/x86: ISST: do not hold lock punit_misc_dev_lock
 when register misc
To:     Hans de Goede <hdegoede@redhat.com>,
        SrinivasPandruvada <srinivas.pandruvada@linux.intel.com>,
        MarkGross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111103122.32362-1-liwei.song@windriver.com>
 <9e5fd9f2-dda7-73ef-00a8-203da3827e9d@redhat.com>
From:   Liwei Song <liwei.song@windriver.com>
Message-ID: <8809e11c-191e-036a-9066-90cc316f83b9@windriver.com>
Date:   Tue, 11 Jan 2022 19:57:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <9e5fd9f2-dda7-73ef-00a8-203da3827e9d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To CH0PR11MB5348.namprd11.prod.outlook.com
 (2603:10b6:610:bb::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eecc1de-94f6-481a-7b21-08d9d4f98b30
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5039:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR11MB50392721D068DCE956641D049E519@SJ0PR11MB5039.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzVA7cu56lfbi1znGgeKPGEmUBv8Z3LJ09oQQrDHvAet4U7/IXR/0aGcP/41CZu1HaVHOpKKW/G6LH2f8eugUEfmCYXVo+JdBTGuXyuMsbdirq0Sc+gKrThuITUC8NRMORSVPB1tC/6CsJWWD6MxWKri33FqVoMyXqokvtRrwtMT8tbprvQMuQBnIe+S/CirpD+cKNXS2OzzbdVXQc42/yM8wTb595ynyR4wi/GvWRRqeobjB7pOI+/MtlwRLmO3I36W3klyK2uVoqpfzTygdfThim7lgg8oYwxY7Uzsfz0bRg2QbtSi0P2PolEHuedtxpSxd68xWLe2XbKcSsw1H/KiK5YoqflO1ZHj3pHdS/KFfCH2hw5NtVdqqh5GoIlmZCTVxdKo6S+ZkEY0EGynaxrNVH3J0JudqE1r97pjNrp9I0qmw+DH0FQabhRu/BnWPvld3u7bSQGUFI8L3lllBTfegQ3iD1kFYBsjp1S8xFAUJViswU1ICFn8jy6MX+cima5SvRlsBPqlBorSDkgRX9LZrEfJGBfnvizJQed3kzRrXJEExw2OD+GOfJT80c7s3ReMLd2X1BjeEG22U2+4BpnWjdFZa1ebhujkhlCSIEmzp4hMV08JoYz5l3SzQF4ogssocowMN09hfUdUctTmUhe+rDTPaSO6loKBKRX64VO+G9BtbhsnxawmtHlTzOMJeysmMkCPjjB8hGatD5fY4WF1PUau/slNg0ZOcnhloW7ZsFDM1o7vCXX3PV+U39NCfqJ8CAm0qIE8GYQQMl0K7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5348.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(26005)(2906002)(4326008)(66476007)(8676002)(31696002)(6512007)(66946007)(186003)(8936002)(52116002)(38100700002)(66556008)(2616005)(6506007)(508600001)(86362001)(83380400001)(5660300002)(6666004)(316002)(53546011)(31686004)(44832011)(6486002)(36756003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmhtRW5xeVhzdGJkYS84NE1XMjNVUjk3U0dxVldPVnRrdmZRN0Y5QXVXYzdp?=
 =?utf-8?B?UWNCNzhadCtYYWR1RXhvRHllK1krajZJblhQMzBaSzdjMEdmOWNUUkNyT1hu?=
 =?utf-8?B?R2VPdEpLZ29tWTdsUFc2WGVhblhFbm4rcGswNFBVcFVVS2xtREZsZmVMSHJo?=
 =?utf-8?B?NUgwUTdCSy9IcjY0RllBVi9rV0lVMENaL0hlYVB2Q3NIVHl0UHcyT2EwVDhB?=
 =?utf-8?B?NVBxSnVIWEQzdlBzcEVnQVlYQllubkxzZGFaTzdOZDAvb09wbjhUZ2hCVzBs?=
 =?utf-8?B?RmxVMzNPMXlrRUZyOVc3aU5TMGl6WHhzdHc0c2o2R25mWTF2WTl6ZWRxK0Rt?=
 =?utf-8?B?YkV4US9mejg3Zk1sejM0YitKSk1BTVhqTkNWOVp3Y2p6UGV4QVZzSHB4a2pt?=
 =?utf-8?B?cGNvVHJsakZYN3RUSTkydTFtY3psQ1ZsdndmN1h6ZlZsaXVvcS91bEI5WmZQ?=
 =?utf-8?B?NzdpbEI4bGRFSy96cGpLU0Z6djdudS9id0VvWjYvUm5BWHB3VU9zVnZZU1lq?=
 =?utf-8?B?Sy9tMGdyMkZScXpQSDBLUmJGa2RDRWhJcEFST1lmYitJY3MrdWxsTlg3bEl1?=
 =?utf-8?B?M292UVVZcjNPK25uS3VvZmR5UFExYlUxOExpY2xLakptVmYwbUFaeXA1dW92?=
 =?utf-8?B?N3R6ZVpSR1Q5NXhCSFVtdUhZcnp6ZlBhZjlJZTZ0NlhIQ3g5c1JyU0Z3Rjkw?=
 =?utf-8?B?V0tnaUl3NXN3UHk5clhqU2piL1RqcWJJWmxkcDU1bjhMZ29lSElxdnl6NnNt?=
 =?utf-8?B?Q3pHNHBERWc3WXZUUmZlNnVNQno0R1RMUEhmcWRRNjc1YjllYU1YTGRrNlhk?=
 =?utf-8?B?RXZSaWl3YlY3UlRqYU9ZVkY3TE5Tdy81VXIwTXJSU20yZzJCZ3pnaHhsWGJ2?=
 =?utf-8?B?WjIrWXZyOHI4Mm5iUFpNcm1sbnFrNUF5dFU5Y3hTZTBnM2JvbThOYjdQbkFF?=
 =?utf-8?B?Q2o3RUo3bmZXL3dMbjdYOVZmNW1DTHBLZVZTMzZ5M3ZjaE5BK1J5OXByUTRp?=
 =?utf-8?B?dmhhMGUrQ1MyMkNUVHZkYWxTS080VS8xa3NPbmU2VERBdEdCSVdpTmpEMnJu?=
 =?utf-8?B?ZmduRGhFaElBUmZmTkpjanRJOERZU1hRQ3haQitlc2k4K3A5V1h3aGs3Smg4?=
 =?utf-8?B?cEh3aENXMzRuU0lDYUZjTzhoL3pEcWhEcGZtZU5NMlJvSzJmTVF5Ynl4Y21W?=
 =?utf-8?B?eS9mc29TQk8yVTJ2SjM4d2dpVFZWbXVsVDR6VHVRR09acFRjL2JXek1wTmFr?=
 =?utf-8?B?WGlwVFY3YkgxcW5KTXI5Nm9kcFBvUlhiY1JPQ1NRMGZSY2kwWUZUUEJvUmNr?=
 =?utf-8?B?bUwranZITWpyQzVpMmhWWi9kTE9DMEpnTG0xaGxQOFlubWErckRYL214VkJw?=
 =?utf-8?B?SUsyRlUwb2l3Y2Z2eWNBVHZ5eXhRZlJSamxDVm1YSEtHaVRvVWY2OVA5WXMw?=
 =?utf-8?B?Qmh4SU5VUlpHMGVPQ1Urc0pNZmw3N3poRlgyUG10Y0VieWJZVGF1WkZLQjQ5?=
 =?utf-8?B?MFlmaVFUUUZucExUZFN3d08wenRFQnlTOVlVcEdZRnkyMlVvTUJDYnJUY0tk?=
 =?utf-8?B?dksrVmpTa3FDQmE0ekc0NERVdUxaZENiZVkzeWZwRHpVTVdFOFBQa2FSUW0z?=
 =?utf-8?B?bG5acDFPbkk2L3locGdrZFpac0VyRkNCSU9pelBBcWM5Qk1Gc2VzNFZRMnNM?=
 =?utf-8?B?UWNlRHRPbUNhWDUzUHNWNjhjSzF4OFZHaHJPTFZ0QzFtNWZnd3RqaHZ2Tmg4?=
 =?utf-8?B?OHBET1JDOHd4eGsyS090bHVOWFdPcFNQRDBPTTd3WkxZWFRSSXMwd1U0STVS?=
 =?utf-8?B?VXdwdUJpbkJzb3B5SmxIcGVET2c3bnE4NE1oQ20wS0crRldObDA5bGlqdnY5?=
 =?utf-8?B?d2t4WWY1cGE4YmxLUDJDMGlvQzN0ZXl1RWc4L1k0MmNCSG14aFNiWkF2S2tO?=
 =?utf-8?B?WW4wY0FjT0haTGJGL05WWGppOXhSYjVDTTFNZFpGcC8wSGJWejFueU15Z2FY?=
 =?utf-8?B?OTJoa09mMDRlTHFlV3RlcDNsMUdVNVBJZkZRL1ptUzZHbUl5Q3BvYzYybzRh?=
 =?utf-8?B?LzhUZEtvUUdXc3hOdVkvZ3ZFYzZ5T2J5V0tCZTMvOU9MQU5sVmxRZlFFZTBL?=
 =?utf-8?B?Znd4dVJhNDdCOUJ1OE1XbEErUkNYbVFVZnorR0pLSWlwSkhUYndza1lDbkE5?=
 =?utf-8?B?UnFwSXM2cFQxMDE0N1k5K01XZ3JFamM5U21uellmeWZHRG9TOVNyR1dndHpU?=
 =?utf-8?B?QWFaRmJnSmJPQ1Y2eUVDeXNZUmV3PT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eecc1de-94f6-481a-7b21-08d9d4f98b30
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5348.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 11:57:29.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/tWXbPjNBqkRTtUF1FA2/Y1o4FHEVXd1o3vinasq4WMpas63a3UV0lVs10j+dpyW8CkbtazqTbN5bw5eqI6NAdY+92S+Gud8Rmd7GxEXjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5039
X-Proofpoint-ORIG-GUID: 85PCODdNreVGrbHL3wXfj3PI6VZMlGSU
X-Proofpoint-GUID: 85PCODdNreVGrbHL3wXfj3PI6VZMlGSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/22 18:39, Hans de Goede wrote:
> Hi,
> 
> On 1/11/22 11:31, Liwei Song wrote:
>> exist the below call sequences may cause deadlock:
>>
>> isst_if_probe()
>>    --> isst_if_cdev_register()
>>       --> mutex_lock(&punit_misc_dev_lock)
>>    --> misc_register()
>>       --> mutex_lock(&misc_mtx)
>>
>> misc_open()
>>    --> mutex_lock(&misc_mtx)
>>    --> isst_if_open()
>>       --> mutex_lock(&punit_misc_dev_lock)
>>
>> to fix this do not hold punit_misc_dev_lock when call misc_register
>> since it has misc_mtx lock for sync.
> 
> I agree that the punit_misc_dev_lock should not be hold during
> (un)registration, but this fix looks wrong with unlocking + relocking it.
> 
> Normally things like this are done by setting up everything which needs
> to be setup before calling misc_register() and in that case the
> setup code does not need to lock the punit_misc_dev_lock at all since
> none of the misc_dev callbacks can be called before everything is
> setup (and the same in reverse for unregister, unregister the misc-dev
> before doing any teardown, then there is no need for the lock).
> 
> Note the above assumes that the punit_misc_dev_lock is only used
> from misc-dev callbacks based on its name, I did not check this is true.

Hi Hans,

Thanks for your input, in my case there are two devices on my board
will trigger the probe routine(isst_if_probe and isst_if_mbox_probe),
both of them will call misc_register(), punit_misc_dev_lock is also
used by the probe.

Thanks,
Liwei.


> 
> Srinivas, can you take a look please ? And see if you can come up
> with a better fix ?
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
>>
>> [  256.104522] ======================================================
>> [  256.113783] WARNING: possible circular locking dependency detected
>> [  256.120093] 5.16.0-rc6-yocto-standard+ #99 Not tainted
>> [  256.125362] ------------------------------------------------------
>> [  256.131673] intel-speed-sel/844 is trying to acquire lock:
>> [  256.137290] ffffffffc036f0d0 (punit_misc_dev_lock){+.+.}-{3:3}, at: isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.147171]
>> [  256.147171] but task is already holding lock:
>> [  256.153135] ffffffff8ee7cb50 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x2a/0x170
>> [  256.160407]
>> [  256.160407] which lock already depends on the new lock.
>> [  256.160407]
>> [  256.168712]
>> [  256.168712] the existing dependency chain (in reverse order) is:
>> [  256.176327]
>> [  256.176327] -> #1 (misc_mtx){+.+.}-{3:3}:
>> [  256.181946]        lock_acquire+0x1e6/0x330
>> [  256.186265]        __mutex_lock+0x9b/0x9b0
>> [  256.190497]        mutex_lock_nested+0x1b/0x20
>> [  256.195075]        misc_register+0x32/0x1a0
>> [  256.199390]        isst_if_cdev_register+0x65/0x180 [isst_if_common]
>> [  256.205878]        isst_if_probe+0x144/0x16e [isst_if_mmio]
>> [  256.209991] hrtimer: interrupt took 10370 ns
>> [  256.211582]        local_pci_probe+0x47/0xa0
>> [  256.220384]        work_for_cpu_fn+0x17/0x30
>> [  256.224790]        process_one_work+0x26a/0x650
>> [  256.229456]        worker_thread+0x1dd/0x3b0
>> [  256.233861]        kthread+0x191/0x1c0
>> [  256.237745]        ret_from_fork+0x1f/0x30
>> [  256.241976]
>> [  256.241976] -> #0 (punit_misc_dev_lock){+.+.}-{3:3}:
>> [  256.248552]        validate_chain+0xbc6/0x1750
>> [  256.253131]        __lock_acquire+0x88c/0xc10
>> [  256.257618]        lock_acquire+0x1e6/0x330
>> [  256.261933]        __mutex_lock+0x9b/0x9b0
>> [  256.266165]        mutex_lock_nested+0x1b/0x20
>> [  256.270739]        isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.276356]        misc_open+0x100/0x170
>> [  256.280409]        chrdev_open+0xa5/0x1e0
>> [  256.284550]        do_dentry_open+0x23d/0x3c0
>> [  256.289039]        vfs_open+0x2f/0x40
>> [  256.292836]        path_openat+0x87a/0x940
>> [  256.297064]        do_filp_open+0xc5/0x140
>> [  256.301295]        do_sys_openat2+0x23d/0x320
>> [  256.305782]        do_sys_open+0x59/0x80
>> [  256.309836]        __x64_sys_openat+0x20/0x30
>> [  256.314324]        do_syscall_64+0x3f/0x90
>> [  256.318552]        entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  256.324259]
>> [  256.324259] other info that might help us debug this:
>> [  256.324259]
>> [  256.332394]  Possible unsafe locking scenario:
>> [  256.332394]
>> [  256.338444]        CPU0                    CPU1
>> [  256.343105]        ----                    ----
>> [  256.347768]   lock(misc_mtx);
>> [  256.350870]                                lock(punit_misc_dev_lock);
>> [  256.357441]                                lock(misc_mtx);
>> [  256.363058]   lock(punit_misc_dev_lock);
>> [  256.367110]
>> [  256.367110]  *** DEADLOCK ***
>> [  256.367110]
>> [  256.373162] 1 lock held by intel-speed-sel/844:
>> [  256.377824]  #0: ffffffff8ee7cb50 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x2a/0x170
>> [  256.385531]
>> [  256.385531] stack backtrace:
>> [  256.390021] CPU: 12 PID: 844 Comm: intel-speed-sel Not tainted 5.16.0-rc6-yocto-standard+ #99
>> [  256.398678] Hardware name: ACCTON MOROCITY/MOROCITY, BIOS IDVLCRB1.86B.0021.D09.2111010103 11/01/2021
>> [  256.408028] Call Trace:
>> [  256.410605]  <TASK>
>> [  256.412837]  dump_stack_lvl+0x5b/0x82
>> [  256.416635]  dump_stack+0x10/0x12
>> [  256.420085]  print_circular_bug.isra.43+0x261/0x2c0
>> [  256.425095]  check_noncircular+0x126/0x140
>> [  256.429326]  ? __this_cpu_preempt_check+0x13/0x20
>> [  256.434167]  validate_chain+0xbc6/0x1750
>> [  256.438223]  ? validate_chain+0xbc6/0x1750
>> [  256.442451]  ? validate_chain+0x236/0x1750
>> [  256.446687]  __lock_acquire+0x88c/0xc10
>> [  256.450658]  lock_acquire+0x1e6/0x330
>> [  256.454452]  ? isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.459726]  ? __mutex_lock+0x79/0x9b0
>> [  256.463610]  ? __mutex_lock+0x79/0x9b0
>> [  256.467493]  ? isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.472764]  ? isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.478038]  __mutex_lock+0x9b/0x9b0
>> [  256.481748]  ? isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.487021]  ? __mutex_lock+0x102/0x9b0
>> [  256.490993]  ? __this_cpu_preempt_check+0x13/0x20
>> [  256.495837]  mutex_lock_nested+0x1b/0x20
>> [  256.499893]  ? mutex_lock_nested+0x1b/0x20
>> [  256.504121]  isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.509222]  misc_open+0x100/0x170
>> [  256.512759]  chrdev_open+0xa5/0x1e0
>> [  256.516386]  ? cdev_put.part.1+0x20/0x20
>> [  256.520441]  do_dentry_open+0x23d/0x3c0
>> [  256.524414]  vfs_open+0x2f/0x40
>> [  256.527689]  path_openat+0x87a/0x940
>> [  256.531399]  do_filp_open+0xc5/0x140
>> [  256.535112]  ? trace_preempt_on+0x28/0xd0
>> [  256.539255]  ? alloc_fd+0x152/0x230
>> [  256.542880]  ? preempt_count_sub+0x9b/0x100
>> [  256.547200]  ? _raw_spin_unlock+0x2c/0x50
>> [  256.551348]  do_sys_openat2+0x23d/0x320
>> [  256.555320]  ? do_sys_openat2+0x23d/0x320
>> [  256.559467]  do_sys_open+0x59/0x80
>> [  256.563003]  __x64_sys_openat+0x20/0x30
>> [  256.566972]  do_syscall_64+0x3f/0x90
>> [  256.570680]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  256.575866] RIP: 0033:0x7f9be4b97c27
>> [  256.579576] Code: 25 00 00 41 00 3d 00 00 41 00 74 37 64 8b 04 25 18 00 00 00 85 c0 75 5b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 85 00 00 00 48 83 c4 68 5d 41 5c c3 0f 1f
>> [  256.598474] RSP: 002b:00007ffd8fc01b70 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
>> [  256.606177] RAX: ffffffffffffffda RBX: 00005572f20332b0 RCX: 00007f9be4b97c27
>> [  256.613443] RDX: 0000000000000000 RSI: 00005572f202936a RDI: 00000000ffffff9c
>> [  256.620709] RBP: 00005572f202936a R08: 0000000000000008 R09: 0000000000000001
>> [  256.627974] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> [  256.635241] R13: 00005572f20332b0 R14: 0000000000000001 R15: 0000000000000000
>> [  256.642513]  </TASK>
>>
>> Signed-off-by: Liwei Song <liwei.song@windriver.com>
>> ---
>>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>> index c9a85eb2e860..bcbc0d508ec4 100644
>> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>> @@ -693,10 +693,12 @@ int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
>>  	if (!misc_usage_count) {
>>  		int ret;
>>  
>> +		mutex_unlock(&punit_misc_dev_lock);
>>  		misc_device_ret = misc_register(&isst_if_char_driver);
>>  		if (misc_device_ret)
>> -			goto unlock_exit;
>> +			return misc_device_ret;
>>  
>> +		mutex_lock(&punit_misc_dev_lock);
>>  		ret = isst_if_cpu_info_init();
>>  		if (ret) {
>>  			misc_deregister(&isst_if_char_driver);
>> @@ -731,7 +733,9 @@ void isst_if_cdev_unregister(int device_type)
>>  	if (device_type == ISST_IF_DEV_MBOX)
>>  		isst_delete_hash();
>>  	if (!misc_usage_count && !misc_device_ret) {
>> +		mutex_unlock(&punit_misc_dev_lock);
>>  		misc_deregister(&isst_if_char_driver);
>> +		mutex_lock(&punit_misc_dev_lock);
>>  		isst_if_cpu_info_exit();
>>  	}
>>  	mutex_unlock(&punit_misc_dev_lock);
>>
> 
