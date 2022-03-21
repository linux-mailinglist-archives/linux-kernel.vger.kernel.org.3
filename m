Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF41A4E2787
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbiCUNdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbiCUNds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:33:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8755A15878F;
        Mon, 21 Mar 2022 06:32:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LCw8RN010792;
        Mon, 21 Mar 2022 13:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RBK2h0/2HD6m/12NwHJyuiG07uwo69AAZRwvpxS5F3s=;
 b=GamJ7DmPZXC9eRsDIL6/QScKKWhfBmKJORZ/jfkVYgMmGNCadNsjn5obO7CfAtjw9gmS
 /DxCBEYZHmjJ6X9DqObaFT9AjshstsV15ezPTn5Ix+SUMsIQev52SJZY0uThb44L259b
 OvQUaFtCW9hvINweMxagEQcri33cnSPB9VMVnTvCmLs8cAAGNN7pVeLP0fhS6omkx8pV
 78XyqGPJCro6HBOJlguO+Jw0H3aNpQze/PwR8nlqzdH60CGeCsSNlDx5XdMPTC4VbptY
 OjdqYE41vQECcEK32KmEKHTTQq8Fzn2osADNlhMTX2OOD735Vy6VFI1SRYMqiHpvJ1ez Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y1uad9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 13:31:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22LDFmCu137865;
        Mon, 21 Mar 2022 13:31:29 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by userp3020.oracle.com with ESMTP id 3exawgrr6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 13:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMoMfnh7sj5XoipS7HsBSmphx0Lf6XyvIDiRctLfb0RJTyBi6KILpX36JZgadHdZZ6O3O0GV/hQ76eP7X3hVIct4NgjAz8qe2OhCQw6CJsJLG/wCHv0cKY88BPIwPbLlvlnNXJ55SvlgHGLKHVkkoXNKG119NJqPFre3r6Yj/gNSAz1whI2Xg162rkSARgKLe2cnjlK1331ViVJ15fQ1SQtD2Umsnhe3ENKaba9XoVVk3+tIWmI+UGf0qvNeshM+N4Zwrs0ABxLOorWu8dS2+Qbe9/02L/sNVcsaN5M+8i5wahsJCEVoAUpRvWKDotsu5EeeXo4BBaCcWWhXsTdRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBK2h0/2HD6m/12NwHJyuiG07uwo69AAZRwvpxS5F3s=;
 b=hrgZhhg0LOUyuX59r8APQxVoZzMbac11ohwSKe4tIlra10vejcTy19TAmsySnh/xpt8CNj7BuzNNDy7QdcjiUebiIRjB/qWxa4Rwzdeq1claox/UTUpGFpe7jYFnZY95TnRcox0aUOHVUlU4Kk4h2MT6gOFc5nia6oSNXyBI+D0zHtnpoGuE9c0iVJzZoU9/yZ6Ic/42HvRz3+OE3f5PFwIA1VPYGjalP4SY2YYdoJlV9PtHXkcNMMtLCm+2iZsTGEDf+ZZn2VsVdfcsPLOahgSY24IWqXO2xoH8TaThB0RfHLLa7D0Ts94J0/EtqA6mB5b88TrS2228T1rCBNlLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBK2h0/2HD6m/12NwHJyuiG07uwo69AAZRwvpxS5F3s=;
 b=yVWukN3UaG9UIaSrdpjumnSR8ZgGx4t7xBVBlZ1XiALk8XF9Z/HBTfeN5GdGG8UOW9/4ULIdlw52fXhV1+m3IVzQc3s9zD2argA8XVKv3N5KElziALgHmYGiqUGTwY8OExALdpvgSfAV48sYDDPTIAEPEs3BEDIW7KXOryD8EtI=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by DM6PR10MB2825.namprd10.prod.outlook.com (2603:10b6:5:63::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 13:31:25 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4851:6096:3259:2f9a]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4851:6096:3259:2f9a%7]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 13:31:25 +0000
Message-ID: <cc0186d9-29a3-8eff-e38a-95fd4dd9c46f@oracle.com>
Date:   Mon, 21 Mar 2022 08:29:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v21 3/5] arm64: kdump: reimplement crashkernel=X
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
        linux-doc@vger.kernel.org,
        John Donnelly <john.p.donnelly@oracle.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-4-thunder.leizhen@huawei.com>
From:   John Donnelly <John.p.donnelly@oracle.com>
In-Reply-To: <20220227030717.1464-4-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::21) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c93303f3-6a90-478f-cad5-08da0b3f18b5
X-MS-TrafficTypeDiagnostic: DM6PR10MB2825:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB282571EEE016A01AEF3620C8C7169@DM6PR10MB2825.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSPZV8Fpx/EIm2DWuz0voO6/a9RUi6wxCwvM63jzd73SgjLLyHm4WmC/g9C/2bEyv3AaLFH+nYx942vIvEJn5mFn1sH2DXp6/b+UsM+1kXz2UfpxAnv9S0SA8JifOiCipDV8hpSwVIEf8sZ6HpR7/OuyDqlipcxBeRUDf+QgiQH0dIrSaxCuhd7Whf1ov0PFveQh/41yEx3k9IMusxIYzaInWOGDTiigJOOa2N/QjH9qG/QyF6aWJguhxUZi+oQOhxatTC1ZpxuOLAUCwQnklDUmwekjLugX5N1bQylcL0h+YFt43Dm0FQ6/WFxsu+c3HuuAl53fQxXvE0uqf1369Lf7bpsLK+KP1l125tjf3uqodTOe8NKs2UZ49FU/WZHzxh9bh/9OjtmfuY8pzynGafOX1avhIGfmSSxyOkupNA0Ag3nx4kMuSnVEE8Tditw9o5rJAdokOKBQK0ou4SYgSN5hlaz0DtbK1xHFg9d4ewdGzppL9XU/685lmNjaM1HN94fin/c2FtNg+3mkqUmyZWFszUgL2seMhaO9fD4cwLanzXeCRSbm4cey2D6xvqP2iifPVAJw4ZH/J9jGofIZGSDVvC/jm4DpIH5uCTR37KJeMIUXJr6dq5C/7wHX5+ktEFwFLKP7MPYPpPEIDS6GGfs5bGVwID8/YaC3wmiOSVWzZN+7IOq6liiyCYqDtVr1W1vkKMBx6OYszhKFrhgid9VyCtjafwv0onco26V/kTXC8ZAVCMfHBwRa8jiUWDV092RnGFRUIee05xmACd52HEAgyMn4/2FPe6ir954+5kU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6512007)(31696002)(86362001)(7416002)(5660300002)(53546011)(6506007)(2906002)(921005)(31686004)(66556008)(186003)(36756003)(316002)(8676002)(6666004)(2616005)(8936002)(66946007)(26005)(4326008)(54906003)(38100700002)(508600001)(110136005)(6486002)(107886003)(66476007)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1lmZW9QbmxhY2JHbUNzdHhwbkpRTklLNFdWRjV0K094emFkYzBQMnZHd1dp?=
 =?utf-8?B?QWRnN3Jkb1RCVGF4dFl3N3BMbVpuUW1kemRUTnUvalpscis2Sm5RVDNXTzg4?=
 =?utf-8?B?R3MydzJoM29KTHo0THNuc05VWFFmY3JuaEw3Wk9pNGFKLy9lUEM5dG1NVUdu?=
 =?utf-8?B?cUxHbXBDdFI2MWdaRkJ0eDRuVWlTUHVXNTVSbEU0MW5YMENRQ3poYisyd1hB?=
 =?utf-8?B?REZJZFF1enYvcmR6c05SYlFpaEd6T0h0VWRwN0ZVUjd4ZWY0U3pqOUVDL2ZB?=
 =?utf-8?B?RlNPMjk0a1hNRDBnQ1YrSVV2d1BpaHpHY2FCTnZWaXZXVWNpZFpESTNrZGp2?=
 =?utf-8?B?QWYrbkhPSG9GVnZUdGwxMExEaC9ZblVhK1cyeE1xNTBoVXZyejlLMlUvV3c3?=
 =?utf-8?B?eFdSZjY0WGFhVXdnZm1OU2UxQWdZbTZVRkxLSjJXMXA5d2dYQWRuZE5pMy9X?=
 =?utf-8?B?eDhqajUxL1hzKzNWY2xpUjY4M0o3SDdaZEMvVitzdFZ2UFF0RWZrRGk4bmZs?=
 =?utf-8?B?R1o5cTczQzVNQzQ3ak5pUDZDWXhxNmw5RVFXU1NkTnBhWW5IZXhhamNiRUNB?=
 =?utf-8?B?MXJibzZlOExlM0oxYXRkby9DUExMSlJQU1FNdGdLY0gyTEdCVnlsY0oycko4?=
 =?utf-8?B?QjNDSkE3Rm85MFRLT1dZQjF4RnpvMFdheXpWZDlTRTRsQjRia0xqUUJlOXEx?=
 =?utf-8?B?OEg2aE5YSjZJTS9nWUdmNlVtTnRZZGcyZyt6Qyt2MXZJRjFBRWV6S05OdEFl?=
 =?utf-8?B?eEJiZjJtQ240ZDJqeW9OQ0RhMnBhNHdUN3FJYjdZQ1VlZDE5SjNVREVud0lj?=
 =?utf-8?B?QWkyTzkzbUtTWkdhUUd5RnRCNldSNFNmQWQyNnRpeTBEcENwUm9lRDA5UnpW?=
 =?utf-8?B?cXZKQzhrTXRYMDlzaktWdi8wTW5BTkd6OUNPaXdqV0dkRER3bDIyZSs4c3cr?=
 =?utf-8?B?SkdtZmgrUytROFZJL3ZvdjRjcXVMWFhpRnFGb3drMXJhRXFIakVMcU8ydHpV?=
 =?utf-8?B?dkdVd1UzczZ5bHVKVnBxZVo4WmJzZmZ0bGtyZ21sd1VHK3hDaFJqcXpjVmRM?=
 =?utf-8?B?cUgzMVhLZ0g4U290VENvaTNnYjcrcGI3NFhkdXNKT3Y5ek5NWVF0ZllsRDZs?=
 =?utf-8?B?d1JvVnRXOU9lYWorRWk1WXVxaFYwZk1tZ2NlMW5ad2pmeFUrTHBNK21sdUtU?=
 =?utf-8?B?eUpaNVJ5bHh4ajhWZ3R1L2xYZ0lQWkRxbDYzaE5IOGhrbklPUWI1TkNvbXI2?=
 =?utf-8?B?UTZyMEswNFNiT2xydlp3VXlVQXNUN3JjZzFiOVpVNml5aXZkT056UDcrU2Jo?=
 =?utf-8?B?bjBxYzUweHdLTDlHR05lQmZlYXFsaXA0QXljT3lGOUJGVGJiWm5CVlliYzYv?=
 =?utf-8?B?cWQ1MHhveWdKbWpGUFd2MHQ0VDUyS2FFaGRaQ0hmR2pVYXkvdDNYWmNtQzdO?=
 =?utf-8?B?N09PTEx1N3o1MTJQYUllTFlGbWc3NjBpVUFUWmhRSE0rZk1JbFhqcUxmd2Vr?=
 =?utf-8?B?SzNQNFdlbHJDczlBckVLMTExTU55OWpqU2ozZmh0ZmxHL2o4YzJTbEw0S2Vk?=
 =?utf-8?B?bmRvU1VuOXlKYXptQlN1SkJ3ajZGaTRiTTRBVjhCRTFjaW04YzEzWGV2S3cz?=
 =?utf-8?B?VEtYRnZmSFlqYWNBTmhxbkVuNnMrK29nKzUxc1Q1N1BFckJyejEzenJXZGR5?=
 =?utf-8?B?Q3RVbzN0RXA3elB6emhKazA1eGNkYkF2a2IzYnE4ZXdmakVyeEl0TFZLQU5K?=
 =?utf-8?B?cEcrc0dCZkpGTTF2MVNvVWFaM0lMMzE1UmtEQkd5RWQrZHJSekxPRU1hc2lP?=
 =?utf-8?B?dnFkN0Z2Ukt1ZWQxcm52OEhlMnFLWVpxazFYNE9CbzhhWGdBMm8rbzN0MlFK?=
 =?utf-8?B?bExxa3JWYjBpWXdyYnpVbTJHZEdYdFNYT3NxSlNJbENVMm9OUkZvVWp1cFpP?=
 =?utf-8?B?VDVPbFg1TXdFT2VZYnR2bXB2eEFMa3RKeDdsbkJtUVordi9MdmtEUElMdjlq?=
 =?utf-8?B?MkY0c0I3RWRRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93303f3-6a90-478f-cad5-08da0b3f18b5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 13:31:25.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39trBCSxAH0DnpNuSqO47abbEiFYcX5a05kHiP1lXrz66VcGK1Et8yfbGY1oqf5XZ/UzhZFrBU3KcqJ0Xed3MH3ezNDB/1fDWVy/3xiYYnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2825
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203210086
X-Proofpoint-GUID: nj20mAKan2Xqz3PCvj3kklqNpCPyd3qo
X-Proofpoint-ORIG-GUID: nj20mAKan2Xqz3PCvj3kklqNpCPyd3qo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/22 9:07 PM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.

                         " Not enough "
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.

  We can't have a "boot failure". If the requested reservation
  can not be met,  the kdump  configuration is not setup.
> 
> To solve these issues, change the behavior of crashkernel=X and
> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
> in DMA zone, and fall back to high allocation if it fails.
> We can also use "crashkernel=X,high" to select a region above DMA zone,
> which also tries to allocate at least 256M in DMA zone automatically.
> "crashkernel=Y,low" can be used to allocate specified size low memory.

Is there going to be documentation on what values certain Arm platforms 
are going to use this on ?

> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   arch/arm64/kernel/machine_kexec.c      |   9 ++-
>   arch/arm64/kernel/machine_kexec_file.c |  12 ++-
>   arch/arm64/mm/init.c                   | 106 +++++++++++++++++++++++--
>   3 files changed, 115 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index e16b248699d5c3c..19c2d487cb08feb 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -329,8 +329,13 @@ bool crash_is_nosave(unsigned long pfn)
>   
>   	/* in reserved memory? */
>   	addr = __pfn_to_phys(pfn);
> -	if ((addr < crashk_res.start) || (crashk_res.end < addr))
> -		return false;
> +	if ((addr < crashk_res.start) || (crashk_res.end < addr)) {
> +		if (!crashk_low_res.end)
> +			return false;
> +
> +		if ((addr < crashk_low_res.start) || (crashk_low_res.end < addr))
> +			return false;
> +	}
>   
>   	if (!kexec_crash_image)
>   		return true;
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 59c648d51848886..889951291cc0f9c 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -65,10 +65,18 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>   
>   	/* Exclude crashkernel region */
>   	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> +	if (ret)
> +		goto out;
> +
> +	if (crashk_low_res.end) {
> +		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> +		if (ret)
> +			goto out;
> +	}
>   
> -	if (!ret)
> -		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> +	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
>   
> +out:
>   	kfree(cmem);
>   	return ret;
>   }
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 90f276d46b93bc6..30ae6638ff54c47 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -65,6 +65,44 @@ EXPORT_SYMBOL(memstart_addr);
>   phys_addr_t arm64_dma_phys_limit __ro_after_init;
>   
>   #ifdef CONFIG_KEXEC_CORE
> +/* Current arm64 boot protocol requires 2MB alignment */
> +#define CRASH_ALIGN			SZ_2M
> +
> +#define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> +#define CRASH_ADDR_HIGH_MAX		memblock.current_limit
> +
> +/*
> + * This is an empirical value in x86_64 and taken here directly. Please
> + * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
> + * details.
> + */
> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
> +
> +static int __init reserve_crashkernel_low(unsigned long long low_size)
> +{
> +	unsigned long long low_base;
> +
> +	/* passed with crashkernel=0,low ? */
> +	if (!low_size)
> +		return 0;
> +
> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> +	if (!low_base) {
> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> +		return -ENOMEM;
> +	}
> +
> +	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
> +		low_base, low_base + low_size, low_size >> 20);
> +
> +	crashk_low_res.start = low_base;
> +	crashk_low_res.end   = low_base + low_size - 1;
> +	insert_resource(&iomem_resource, &crashk_low_res);
> +
> +	return 0;
> +}
> +
>   /*
>    * reserve_crashkernel() - reserves memory for crash kernel
>    *
> @@ -75,30 +113,79 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>   static void __init reserve_crashkernel(void)
>   {
>   	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_max = arm64_dma_phys_limit;
> +	unsigned long long crash_low_size;
> +	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>   	int ret;
> +	bool fixed_base, high = false;
> +	char *cmdline = boot_command_line;
>   
> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +	/* crashkernel=X[@offset] */
> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>   				&crash_size, &crash_base);
> -	/* no crashkernel= or invalid value specified */
> -	if (ret || !crash_size)
> -		return;
> +	if (ret || !crash_size) {
> +		/* crashkernel=X,high */
> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> +		if (ret || !crash_size)
> +			return;
> +
> +		/* crashkernel=Y,low */
> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> +		if (ret == -ENOENT)
> +			/*
> +			 * crashkernel=Y,low is not specified explicitly, use
> +			 * default size automatically.
> +			 */
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +		else if (ret)
> +			/* crashkernel=Y,low is specified but Y is invalid */
> +			return;
> +
> +		/* Mark crashkernel=X,high is specified */
> +		high = true;
> +		crash_max = CRASH_ADDR_HIGH_MAX;
> +	}
>   
> +	fixed_base = !!crash_base;
>   	crash_size = PAGE_ALIGN(crash_size);
>   
>   	/* User specifies base address explicitly. */
> -	if (crash_base)
> +	if (fixed_base)
>   		crash_max = crash_base + crash_size;
>   
> -	/* Current arm64 boot protocol requires 2MB alignment */
> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> +retry:
> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>   					       crash_base, crash_max);
>   	if (!crash_base) {
> +		/*
> +		 * Attempt to fully allocate low memory failed, fall back
> +		 * to high memory, the minimum required low memory will be
> +		 * reserved later.
> +		 */
> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> +			crash_max = CRASH_ADDR_HIGH_MAX;
> +			goto retry;
> +		}
> +
>   		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>   			crash_size);
>   		return;
>   	}
>   
> +	if (crash_base >= SZ_4G) {
> +		/*
> +		 * For case crashkernel=X, low memory is not enough and fall
> +		 * back to reserve specified size of memory above 4G, try to
> +		 * allocate minimum required memory below 4G again.
> +		 */
> +		if (!high)
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +
> +		if (reserve_crashkernel_low(crash_low_size)) {
> +			memblock_phys_free(crash_base, crash_size);
> +			return;
> +		}
> +	}
> +
>   	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>   		crash_base, crash_base + crash_size, crash_size >> 20);
>   
> @@ -107,6 +194,9 @@ static void __init reserve_crashkernel(void)
>   	 * map. Inform kmemleak so that it won't try to access it.
>   	 */
>   	kmemleak_ignore_phys(crash_base);
> +	if (crashk_low_res.end)
> +		kmemleak_ignore_phys(crashk_low_res.start);
> +
>   	crashk_res.start = crash_base;
>   	crashk_res.end = crash_base + crash_size - 1;
>   	insert_resource(&iomem_resource, &crashk_res);

