Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C54D5133
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 19:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbiCJSJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiCJSJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:09:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D894B855
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:08:20 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AHrlNF019295;
        Thu, 10 Mar 2022 18:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2y5a/vllTVToZ8tYdmKF2k1bKH7kC4Iq36Dxz5Vsp9Q=;
 b=b+xcXJq4EW/TEZ4m1dJRAFsQ+CFlUaz+g2XdTj2wbVuxPXfa/84uJtwv1IqO4DAPrEaR
 QukD8HwBl9Zw54GOcWEeyepO6xioT2r/KOmYi9BrumfCuYkTqvnJBrwvDstI5CZLnmRE
 XNfsEGERg4MdexhGKeamb5UM3eluY8Uo708HJ08nPvHHIirTRbi0TjjpYjXPxVXhTuJf
 xkXL/+udLpSy+YO3N16qCSxa5cUEpKho7gE+aUiP4pkSKG/Kx9jztWPIsvIULi2Cm30a
 /Ts+2XtUxlEfzy9uOHIVXzcGe1E5XyuKFSj3HHWzSipoH8hk+O4QpsNAAs20iuVZSYNN Fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cnw9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 18:07:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22AI6cgf087709;
        Thu, 10 Mar 2022 18:07:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3030.oracle.com with ESMTP id 3ekvywwgsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 18:07:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5vWoRJsVJKySTmzDgItJmkNoQOoSzPAGuKJdODG2ZZ/erOwVqBN2oqpb0RE/AxYqeYtYY+z3f5cl5OQKbebFZXOsH8SPA/wcy/1iTlCRi4kVg1GJGE9CRxH8nnaWLqeSz+nyRac5HP9wl7UOR0vXsg1AQCaox+gVCzzIXLb/vCQVEcCOQ/mHLl2ifeG7a2YwhEmpi8WYLuk2FF39pFoyeA05KAXS7n0ZeFehMTYxDYvOV9id9uunvV3eXITpyu0+3IIbSEm9a5WsPjB0417eCYv7cvDwhb+OwKNMFs/3EuTH4hJ7cOMEsIqY2GxLzzMYAX5FGQgYvowjRExRJft3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2y5a/vllTVToZ8tYdmKF2k1bKH7kC4Iq36Dxz5Vsp9Q=;
 b=W3JZdeJHOtKA6Ff8cBrhkUihd8n2SxSaTAYOLp9GVa65x3jg3hsWw/v5WgP8rjIRTkt668VBwaLbBMpde36s7pGGvvQlkC9XlZfzgcU/Uu4+6F68Vos5AaSXZ3EMZNkkjBe8+M1QC+W7HU4giOwlo0Ag5P0T8Kwyz3N2lEgD9JKY/eMfsJEazC1tjGKrWROiu9igFounri0sP2lCDyK0b7y/ytZlrGNuq9dzS9z8stQtPu5G7+dD/l4L5O61oAYIUIWvVxebjG3pbeyPBnYHVFpxpj4QNdffsvBqQOJK9nSfFxd5U63+OYvAwtcL48Ace8QiDoYg4Xq3VXqZCFwghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2y5a/vllTVToZ8tYdmKF2k1bKH7kC4Iq36Dxz5Vsp9Q=;
 b=y5Vlk37C59lkwKIiCjQZhFrJRJYqExX/mzOEeN2Ka5LTQt4xjl67wmUQ1aObfWnQC2PPf69H7rc9lsZvSx1XUUT1pqtthN3fYSyfL0NQzBe1uFJaMtGnjA0AdW7ZMw5WdB4ZcTW67z46FOTZX4LKt5b48wOctxJwzHs8RBlrZvM=
Received: from SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19)
 by BN7PR10MB2755.namprd10.prod.outlook.com (2603:10b6:406:cb::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 18:07:37 +0000
Received: from SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::e82a:9be1:793c:1702]) by SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::e82a:9be1:793c:1702%4]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 18:07:37 +0000
Message-ID: <746497ff-992d-4659-aa32-a54c68ae83bf@oracle.com>
Date:   Thu, 10 Mar 2022 13:07:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC 0/3] Expose Confidential Computing capabilities on sysfs
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     thomas.lendacky@amd.com, brijesh.singh@amd.com,
        kirill.shutemov@linux.intel.com, hpa@zytor.com,
        pbonzini@redhat.com, seanjc@google.com, srutherford@google.com,
        ashish.kalra@amd.com, darren.kenny@oracle.com,
        venu.busireddy@oracle.com, boris.ostrovsky@oracle.com
References: <20220309220608.16844-1-alejandro.j.jimenez@oracle.com>
 <8498cff4-3c31-f596-04fe-62013b94d7a4@intel.com>
From:   Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8498cff4-3c31-f596-04fe-62013b94d7a4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0201CA0029.namprd02.prod.outlook.com
 (2603:10b6:803:2e::15) To SA1PR10MB5866.namprd10.prod.outlook.com
 (2603:10b6:806:22b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 264bf79d-4d44-4fb6-6247-08da02c0dbf3
X-MS-TrafficTypeDiagnostic: BN7PR10MB2755:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB27556D9E8CB15E4CB18478B1C70B9@BN7PR10MB2755.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+pDopktk1KDn1HycM0FJ8/yZNRd7CB5rF2SE0Hp41s9TQuH9PX39UgJ7RaK+Tl6WwIL/VgdQCz4jiLkNAewTafUoIRy1nu7dwxF6T329SJM8FS1Xb/vYSxYFGmqeg4HEgROWIOPHnIl0v6aiGJIYildtumvIXJGGvPx65AObMWreeKs6+GlGgtsSIzg/MMMTM8DtTFHzf5jZZjDsrXbRSwZBqcHh7asct0Yzx51PxJRZNw7GqqtDHAjsKUHVO4SUX8Xt4PcCwUOhpCFhTE4jF213xIA35cozp+5mBi5fUAf3S5yAMmUtkT0/cUfGiO6pPWjWjQG9NIxbG1w9r6tBnoVw64uFLtl1wX/6zM1qN6GgWFgzU13YciAcsAtca9H58ClApOgkOVRsNK1Ma9osCb0Q4YxJH/ec5aCsED424aJ4QSpsJ3DnkHEUM68KQ2MdrnIdC2KjILKMjtZxXaPvkqt/qK6mrg/yZuiKNl/mx5+5Sho/O9azNIFVbPK7HzIkC87KHEUQxbYcQ+G+LulSq+Qdzgh5OlCmWpBOlOPvvwgtCRIvJVLibRy/4IUIdqiW8GIs6o2DpUOzcUnj6VMqC2PhTVDGCR6dg8kS0PcWp93IqQKU4SFpXOVNtJ9KLeQxF0G32gKTj2N6pLOnIzP00u+DZZVMUSvkgC/psC9loAbKwCRhwsVgytaJq9DR6qsFElcXlJ8hVMIJHzFQ9pqiBrOTHrZXcR+g1DUeQVsnnYYRW/JoXFxCNEKQfHyJSuJMhkITfN0rQwNSE/nQlJB1JsALNo+X+RUsQbXhfVRZu2sluYug0gAkzO4IABAm7ZO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5866.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(6506007)(36916002)(7416002)(5660300002)(31686004)(6666004)(2616005)(8936002)(107886003)(508600001)(36756003)(53546011)(83380400001)(6486002)(8676002)(4326008)(26005)(186003)(966005)(86362001)(31696002)(38100700002)(66946007)(66476007)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVLMm1FakkzbC80cUdnbWttVWhoUCtBaEYwMFltYjMwMXp1ZjRrajMxTUN1?=
 =?utf-8?B?NHRLM3czNk5WNStwamVZdFl2MHdPVVBNc016YldlaXYzamRqL2VjV2R1aWRV?=
 =?utf-8?B?RzNKcldUVi9VS3NLUmwweUQ1M3pYRUx5ZU8zaVJPNHEwVEhrZDVUbmNCUVVy?=
 =?utf-8?B?VUVhMU42TWRpb2RqTEZDaFkzUDJyQ3U3eGh4TlFKZzc2aWxpWUV1MjNObVRM?=
 =?utf-8?B?UWs3ZHkzVUw3QkZwdnBpUE1seVVNSFI5a2ZhZ0hzK0ZhTU94cVEvaUxUWnl1?=
 =?utf-8?B?U2lwdnVJaFNML01JNHMrYnFLaXB3RUh5bk1PMFB0NVhidTQrNXRtZ1M0M2xr?=
 =?utf-8?B?L2gyem11YWxuWTkwU3Zua09HbU9QY3pyRWZ2YlVGTlg4YUo2TlZZcGplK0ZZ?=
 =?utf-8?B?N1dKdVg4YnhFb3NqTmZMa2xOR2tLOXhXR0N0WlJBazhTTko3VDViRFBGNU9T?=
 =?utf-8?B?dUhlaWkwMGI4RHIweUpNNE5oR0ZHY25FNThKMEUwLy9iaytsUzI5R21RNGhy?=
 =?utf-8?B?YXo2cG9NMnpiNjRGbHBwK0JzUXZwcnI5Q0hwRG1rR2dmdlFGRDhrZmRocXVW?=
 =?utf-8?B?ZXhDRWhwVlVscmF6WmJ3ODJWL1FYWHBscElBM01CSTFGOXdLUmR0QkJZVkNL?=
 =?utf-8?B?RXNlcjU3Y1JqTzhqRE1wZEFEZHNzV1FCa2JoWjlZV1M3TU9OdURFaGx3YzQv?=
 =?utf-8?B?L0FzQnpISmtlWHZFUkpQa2o3OFRmSjZGblBTVkIrQXd2WE9hVlByVXZaK0RX?=
 =?utf-8?B?Y3BxZUxKcmpjcGNnajU1WEhxTEZuaGY4RTZQRWVyZzJMZ044dXdpUkVoYW1r?=
 =?utf-8?B?RVFBcjh4dU1vSC9ha2NqaGpEeUxCTFFoT1RLU3NWMWEwUWM3R1kwcHpPeGkx?=
 =?utf-8?B?MndoZ3JrdjJJSGprcVlYQ3lIejJkZ3ZoaTg3ZTFtQzlUWU51amV0UUkzdG9L?=
 =?utf-8?B?WHFNVERyOWFXNEYyRExtdUxhSXF3TStCUkUvZFowYktLUERnbWpic1hqVWg5?=
 =?utf-8?B?dlJ5aCt6NnppRkdZbTdQYVgxSUdaYU1QUFNEc2dwa1ZKTXdXNkwwTEpGUW5E?=
 =?utf-8?B?M0JFbDdnajJZaUNhSHBsOU9ndjNUeHJ4dFhNUmJUWlpndUFKS2hXM3o5TllL?=
 =?utf-8?B?a1dKWXQxRlNQcXdCQjRQTkM3R0RTZ2Z3cmZaYlBGQlBIT1BnQWVJQ1RybUNa?=
 =?utf-8?B?QlM1TUc4WUJUNHp5bWVOWWdQRVRzSnNkK3BzMXVmVEJyYnFXeDBxbFpPRHR5?=
 =?utf-8?B?a3RmL3l3QVdEMEZNbEdWeEFsY3ltRWdQbjNaMGl4bDloR3VVVnNkZ2s2YXhF?=
 =?utf-8?B?OHRJaEtBUnFFcXdWRXRPbng3VHFOM2dvUGFVd3huS0dEVG55ZmloVGlnV0pE?=
 =?utf-8?B?azR1NUo0Vm1UcVJVV0xRU3hVUGRmVnpRZVpFbURIY2dzSkc1WXFjL0xzV0Fn?=
 =?utf-8?B?RlBGOFQ2M0p2SXJMSlBaVTNxYnZZQkN3VGIzQzRYaDRPTzlkOFZVcy9yaStN?=
 =?utf-8?B?YTYrSGFMSUVBM2RQRG9sb01XbXJVM1RuOFF1MUxMemFyNmJOM3ZsUUVtYzFw?=
 =?utf-8?B?T1ZJamdJcldKcWFpaDQ3ZncvdTUzOXBDV3VLbWtBTWNFbWhid2cxRXZ3MGlo?=
 =?utf-8?B?MVl6d1AvV05WNkVLT1NiSXRWaVZ2a1ovRllpN254aVF4eTVMUXVWYlBHMFBH?=
 =?utf-8?B?UWlkYmViSUxvakFHOTE4OTVsZ08zU2lxenFjUXdUaTlsNHYrZExVZ1hQbWJG?=
 =?utf-8?B?QlNiN1J2VFh0dmZIL1JQK29lTm1rYTJ3QktSNENvZFM4OG54WkFNUE0ySHYr?=
 =?utf-8?B?emplczZKdXFoUWIvbEZIdEhYWVhmRUw4SkxjZm02SU9OeHVqNm0wWHBFRHJh?=
 =?utf-8?B?bm1oNUNDY3NjMldPeVQ3clBTcWN4ZDdFR01EOGJlZisrQWo3WXpML2pUWE0y?=
 =?utf-8?B?aG8vTkJ1RU1CWWVweThSVjNDR293QVh6alpHKzhXUWw4eWtyVi8wb2lGc2pF?=
 =?utf-8?Q?cawz7gBm250mFCWqTpSZZPmIFsbDmY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264bf79d-4d44-4fb6-6247-08da02c0dbf3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5866.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 18:07:37.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AtTKLxUEb4ylhgsDiPOsbtyAe9kCxucUftC56oHYMVE7LRpTe4Gu8LG2cO99WurdV3VPhDIqI/AoHrBtxEqTkXVmRWZVDc+Vc8xvAzdHgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2755
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100095
X-Proofpoint-ORIG-GUID: Z-C7-Q9ACB4nis1L-uEVYYyCwImRK0PY
X-Proofpoint-GUID: Z-C7-Q9ACB4nis1L-uEVYYyCwImRK0PY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/9/2022 5:40 PM, Dave Hansen wrote:
> On 3/9/22 14:06, Alejandro Jimenez wrote:>
>> On EPYC Milan host:
>>
>> $ grep -r . /sys/kernel/mm/mem_encrypt/*
>> /sys/kernel/mm/mem_encrypt/c_bit_position:51
> Why on earth would we want to expose this to userspace?
>
>> /sys/kernel/mm/mem_encrypt/sev/nr_sev_asid:509
>> /sys/kernel/mm/mem_encrypt/sev/status:enabled
>> /sys/kernel/mm/mem_encrypt/sev/nr_asid_available:509
>> /sys/kernel/mm/mem_encrypt/sev_es/nr_sev_es_asid:0
>> /sys/kernel/mm/mem_encrypt/sev_es/status:enabled
>> /sys/kernel/mm/mem_encrypt/sev_es/nr_asid_available:509
>> /sys/kernel/mm/mem_encrypt/sme/status:active
> For all of this...  What will userspace *do* with it?

In my case, this information was useful to know for debugging failures 
when testing the various features (e.g. need to specify cbitpos property 
on QEMU sev-guest object).

It helps get an account of what is currently supported/enabled/active on 
the host/guest, given that some of these capabilities will interact with 
other components and cause boot hangs or errors (e.g. AVIC+SME or 
AVIC+SEV hangs at boot, SEV guests with some configurations need to 
increase SWIOTLB limit).

The sysfs entry basically answers the questions in 
https://github.com/AMDESE/AMDSEV#faq without needing to run 
virsh/qmp-shell/rdmsr.

I am aware than having a new sysfs entry mostly to facilitate debugging 
might not be warranted, so I have tagged this as an RFC to ask if others 
working in this space have found additional use cases, or just want the 
convenience of having the data for current and future CoCo features in a 
single location.

>
> For nr_asid_available, I get it.  It tells you how many guests you can
> still run.  But, TDX will need the same logical thing.  Should TDX hosts
> go looking for this in:
>
> 	/sys/kernel/mm/mem_encrypt/tdx/available_guest_key_ids
>
> ?
>
> If it's something that's common, it needs to be somewhere common.
I think it makes sense to have common attributes for all CoCo providers 
under /sys/kernel/mm/mem_encrypt/. The various CoCo providers can create 
entries under mem_encrypt/<feature> exposing the information relevant to 
their specific features like these patches implement for the AMD case, 
and populate or link the <common_attr> attribute with the appropriate value.

Then we can have:

/sys/kernel/mm/mem_encrypt/
-- common_attr
-- sme/
-- sev/
-- sev_es/

or:

/sys/kernel/mm/mem_encrypt/
-- common_attr
-- tdx/

Note that at any single time, we are only creating entries that are 
applicable to the hardware we are running on, so there is not a mix of 
tdx and sme/sev subdirs.

I suspect it will be difficult to agree on what is "common" or even a 
descriptive name. Lets say this common attribute will be:

         /sys/kernel/mm/mem_encrypt/common_key

Where common_key can represent AMD SEV ASIDs/AMD SEV-{ES,SNP} ASIDs, or 
Intel TDX KeyIDs (private/shared), or s390x SEID (Secure Execution IDs), 
or <insert relevant ARM CCA attribute>.

We can have a (probably long) discussion to agree on the above; this 
patchset just attempts to provide a framework for registering different 
providers, and implements the AMD current capabilities.

Thank you,
Alejandro

