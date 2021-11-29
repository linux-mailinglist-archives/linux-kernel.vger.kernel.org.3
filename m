Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5176B46223D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhK2Ucc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:32:32 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51084 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233622AbhK2U3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:29:37 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJVckM000940;
        Mon, 29 Nov 2021 20:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zmuF+kBCjrTKCLO2d5OTWFSR7abQSL9PNw4NWZVLMwE=;
 b=DSF7F4M9o6pA7VneutTmZIP00OOOzNdIraQPZRqr9UlnReO64wva2qxglAIROTDzpTXQ
 O5C4XKC1OEM8V8AEKYU7pdPgWxNpTFLa7nBQ8NrW+LtINJ8SogQVmZjI188n8BJVFksl
 pM45z942gQFceyTgaR1yw6H3n3v2TQqCRvLu4407Di6p05IkJYHi8P2+A6vavVVUaTlO
 ikWa2v31eHZWO+B3aCWninagkZOds92qSKhmCtsj6/RRUNmn42KwO4TsRJOsbmxcV3Lu
 kO4h0uU3WxQ8WtzmrCUcOhLoCB4Wl0Zh8tZNqdC3g42Gihb3ouA/YJ+sGZ6aiWXJCMH5 mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmrt7vq2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 20:25:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATK5ZxW074519;
        Mon, 29 Nov 2021 20:25:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by aserp3030.oracle.com with ESMTP id 3ckaqddx88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 20:25:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMbMdRP8OAaPABwn0mpp/ukv18TGqBvQZYzyNaNBMg+BhO6A/QxXSYFzAlYYyxf6HzZqup1wz0wX2YzoZAZLN+lOB5NMJuaaIVoP8y0/d/CC4irIS6KpcACN6cLa78mmTIa28O8aI0T00bmNyhtCCFYwzqMkKCU7MERofG/3fanOr8D18vmUlpBLmsDYxikj+5+Mih7Np5t3lmfVPJK4f1UvJLqNWeUOEKLwdP2mrmxjJ4Rol2UpM8kcac1wWLEAO1qn3rcY6xFhznWdyUDqdeEA4LbVNysXaJrLRt9CfTL1BV06m/L8g4vd8Ufw9DHXwT6DhRAT0/eCxwx3LNVWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmuF+kBCjrTKCLO2d5OTWFSR7abQSL9PNw4NWZVLMwE=;
 b=YyE9FzShjhQ+lYRckEjSHHn40oi3MGPor00wdqJ8VHALF19Q0hWEh3FL94zd0Mojxfx/+Bi+hmP/8sywdRPUgpUYrqGQdw+lGJuJuVywsXusL5b+mYRen73LhpoU0nphySfGct/swdI4eVY9FFMoc6MpM5CPRUKBNndg41T+aAYPkZB1pFS6n9iq08S2Nw5RFAMYIzLcxDT65xrPeFcnYKqc3sFe0P0/0Mr0B0y00UrRuo2p84PeiRUnshHgFb9C8JxPx9wZ2xJ8s+DknOL0n3Xh0F1xVz4Rz76KkzKBisDokDNzW+tB1pgSDJJGjaZeRZ8zazyAnmGk0K08uLh8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmuF+kBCjrTKCLO2d5OTWFSR7abQSL9PNw4NWZVLMwE=;
 b=IL54+LoLEHwMGKX1BT8oSdBngQkvsDY29A0alyAfh/M3T7bSQ3+UADPStI4LqpPfJDUVKi9LiMaqzhNnW9DbmPQpptJIUW1bg97sKVF4GkvvHoLZTP6ZxIVMIFq2Tpg9MdND1srad68ZOIlDt2cMks4UCvDV1aB7iE5dfaIuY4w=
Received: from SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17)
 by SA2PR10MB4793.namprd10.prod.outlook.com (2603:10b6:806:110::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 20:25:07 +0000
Received: from SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::780f:3623:53a3:fcc0]) by SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::780f:3623:53a3:fcc0%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 20:25:07 +0000
Message-ID: <37fec78c-57ae-e1b6-661d-be9c6e1e69f1@oracle.com>
Date:   Mon, 29 Nov 2021 14:25:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v16 00/11] support reserving crashkernel above 4G on arm64
 kdump
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
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20211123124646.1995-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0122.namprd11.prod.outlook.com
 (2603:10b6:806:131::7) To SA2PR10MB4665.namprd10.prod.outlook.com
 (2603:10b6:806:fb::17)
MIME-Version: 1.0
Received: from [192.168.0.162] (68.201.65.98) by SA0PR11CA0122.namprd11.prod.outlook.com (2603:10b6:806:131::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 20:25:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d5b45e3-e62a-49cc-9abc-08d9b3765542
X-MS-TrafficTypeDiagnostic: SA2PR10MB4793:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4793008119C121F3497C46F887669@SA2PR10MB4793.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwoWeEM3ixqcHDoFHzO5VvuJKYsnyxCFGgEsXJ/PI2Wh9ICOf9ERH3olXrO6pm2yCfuzk+PiTRc+xanHuDDoIENUrRVUI1Z8cVKmod88S92ff9QCJO3J/J2LRbhF76h0885Fb77J+oBITumtv6tE9T0Lhdz1//EJFF+jMUVQtxIOy3k4ZjhuXynh2UkB+e7O/3WPmpPkeEyA2Jn1SO/QJNQ+WQ8Z+cGKCMEUbaun7LZGNGQeXE2gVzhzLbhKRFztGTX2OPv9HHi91F2EOvyG2I3TFgWkdOFmUAWGvRcGvAnjGDrH4lGTiyUm/q7+ft9e+tiuu0bmbaoaLxr4kVVi0RoKvsi0lDvKi+GMllny8D/K66AzFWbqNNmquD7rHLYtcPa5SWGCXi1I4O3icMSzUJBJ4ABNzbiyOou7sP4g4D8CL+aalvXQOMQtCFzCB2q/C4UBT5cXHwFmn29nOd9wKJYRtCFcT6WH+n0/M5iMuRkCOybWBQVQOajiXUfAlHayJE1DK4k6UFUJ+HmBCM+C++OM4BwdIXqmjhrRxhR2l4GZymdxlmrQAGWYy3oVHEqEcXkaneGoo0jiPPPZhWkXiYRIOq6Xht33kutVWB6QaZpQDc3km+EwQZ+wnK4xSSv0fet8c9vBQ5HTDSnmd/u6/8aSDqU66iULkVs9jp7cThB9ldOgsO4pwxUY8QoXpnH9EOoxAyjlomJ8J1HhoOyv4DXdWJmZtri0OlVYfNbStZ+Bstm+Tfsp4gKisJpllCyj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4665.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(921005)(8676002)(8936002)(2906002)(38100700002)(26005)(5660300002)(4270600006)(186003)(558084003)(54906003)(110136005)(2616005)(16576012)(316002)(36756003)(956004)(31686004)(66476007)(19618925003)(4326008)(31696002)(6486002)(44832011)(7416002)(86362001)(508600001)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YllORytvSUJ4NmlMTzJLN2o0RVZCN255WTE2TGNzVEVDd1c0WVltQ3EzUnFT?=
 =?utf-8?B?OXVQUUx0ZE4wWFhJRjBiTDJYeEpQa2s5N3B0dTVtWXNjTkVrN2dTYjQxZHNn?=
 =?utf-8?B?OE9QajAybDNFcDIzdWxMVWs1dlU1dlRqd0pJdU9sWDdMOStmSTVZZlhXc0xy?=
 =?utf-8?B?eCs4WEpZSUtISjlDRTdqcDFKd0N5YVREMFh4ZDhsTElLMnFkckErdnFwVnB1?=
 =?utf-8?B?N2hFM090bnJsYlpJOHR5RHdFQXVTS2dJMHJ6U1FleGxCOUxBU2lpMmNVZVd0?=
 =?utf-8?B?R0VLN1NnckhhZWd0ZWVzTytBSEw1VFFJVjZSSFUwSjNqaWFLd2ExU0YxazFF?=
 =?utf-8?B?MlpwSWNCaWZrOVJvc3ZzVS9GdEovYWdZRWhlWjZBUGxHeFYwZ0krOXQzaUZI?=
 =?utf-8?B?SmZZMkFWSWs0NHB3TGtrMkNVc3F4K3VaeUx1NGRDWXJORGhjc25aRlZCb1lR?=
 =?utf-8?B?REI5Qk0vclRCcW5nVExTVTFqcnNRTEdYS1BoOHBPTlNZTWN3eTR3ZURHY1do?=
 =?utf-8?B?dHFkZUdWZ3ViNHViTVN1SFppZnVNRXNHcEQ3WGc3TVBFSVVWQU1tdjVGa2xK?=
 =?utf-8?B?czc4NzdMa1FwdVVyMTVXYktFWlVjOVBvK1pLWVFlU2ZHSDVnNWFhOEU4RW9u?=
 =?utf-8?B?NkMrODVJWmFmWnpSOFpUM1E2bDhBemRodkxKejVXdE45ZG02NDVrUmdkY1RW?=
 =?utf-8?B?QU15YXkrYkRFZlRreURxdDRUaFVKWm1zT1lsdU42YWhPb3lWL1dKUElMc0x0?=
 =?utf-8?B?M3I3cGlXRzdCWVNyUFpSZmZrWlpKaVdYZWVtR2l0V3hyUXZadkZ5L0xuN0RB?=
 =?utf-8?B?TDFveVJFeGIxclpGNEVUUzdsMlZ0dkxoTXVYbW1xdzBwdldkbm5RcXZJaFRG?=
 =?utf-8?B?RVJOWm14UWlyU1ZsbUI1YVhhSHhOR3Z2YnF5d0UwRlpYMnd6T2ZKcnlKemcz?=
 =?utf-8?B?c1p3VG10N2JTOFlQenlETU5tamVaOHNid0lhZTBBazZJV2dXb2ttL1ExOUhv?=
 =?utf-8?B?SWg2R0g4WFphamNQSUsyWmZRVDhuN2sxeTRTU1lXQlV3dzQxRFo0TWtXdVVT?=
 =?utf-8?B?ZWJXK3NwTjdkOEdYZFZQd2NPSjMxV0xSeS94NEdvOUwxYzNlZW5TdDI1a0gz?=
 =?utf-8?B?cXNEYU9raEl2NjIxeUJjVU92ZDFnWEdlZnM2bzdVYTIxUU80cWV2b0pBMzFv?=
 =?utf-8?B?NWFZUllUTWo5ZkE0L1FCOUs3bHBYa1pkeldrOXpTT05qYlVBbXhXRDE1dXZy?=
 =?utf-8?B?azZINWp2V1JRSEhVUkw2VjRaOG1OT0NBMDBUbnpZY2ZDL3NLdWE0T3R0T0o5?=
 =?utf-8?B?VlJpMXFoZ0RkazJLK05QRUZOeG1XR25ZSlFIckdLZTJ6UVFwUmQ0bW82N0xC?=
 =?utf-8?B?UWFIcHkwWmxwVzJaUkJvbTQ4Ly9ObDhMVDYxbGwwdEl1NkN5cG1FRUVleUxp?=
 =?utf-8?B?V3BZbU1uRzFxaUpJS2VHdTBrTUVMWEc2VnlDL0NtSy9IM0M3dGxyNmF2OGNu?=
 =?utf-8?B?RTV0Z0Nnbmx3SmorZHVvd2FDUmRQVWZRcWdRSGNVQ2NOcURmdzc0OVZIRjFP?=
 =?utf-8?B?cnpTQXVxUzFqT1pyczcxMkZucE4zakJiaXFlSnlxQkt3UkFZZ0l4MzlXM3By?=
 =?utf-8?B?ZjVaa2RiQjBkY2tuNm8rWDd2QU4xK21ZT0xybkdENkRGb0p2WkRuMDJybHZq?=
 =?utf-8?B?OFpPZTdFSk9WZU9xYmF5VzJpVWR2T3NRQUJuMFJhQzFIaEpySUpGcHJrQktq?=
 =?utf-8?B?R01DOTdFd2RHQk5nMnh3Tm1IUmFpd2M2V1FnK1AxbGhvY2VNdTdzdGRncFpQ?=
 =?utf-8?B?a1lXRm5WNVJTM21wcEc2NTBSUElFRlMveFA5ekFTNmhhVldHejJnWk1SQXQz?=
 =?utf-8?B?VjRUZ0k5ZXNWRlhmUm5kbjBDclNXa05URHFhZlNndXV6Yno0ODI5dnRsZXBJ?=
 =?utf-8?B?UVpnNVVrdisxSHAwK3E3UEFRWCs2bzk2TCtPNTUzdG9TM1ovbDBpalRESTVH?=
 =?utf-8?B?RVhibkx3UWVvajhPSTJ0djBYMnkwb1hUMFhob0k4OGx4aCtPeEx6U1Uwd2Nr?=
 =?utf-8?B?dlFtNUhma0NmdTE0N2RxdW1KUyswSTFlVFVZbktOMGFuSnJUOUxYWDQra0hI?=
 =?utf-8?B?cXVsazVPOUwzbW1WOE5jbzBFTkZUVlhQNXNJakpERTNFdTFscDl2Tmdtci9Q?=
 =?utf-8?B?R2FGS1poZ0hxdWpGM3ZFV0FhTXQrRkNUV21IYURpY29qUDY5NDlhNGdudjV4?=
 =?utf-8?B?QjNMbzA3V0wxWHRYd3pUUGhvSS9nPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5b45e3-e62a-49cc-9abc-08d9b3765542
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4665.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 20:25:07.0016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUhiBHqQLS0/GQWAU4QB3KODWxi3pNsksY7oKOvjqO7T2yRrmy1IUOT6MBBypMvMacMDw873+dqMT5J5/wrhSFdTQC258O3uadNANP1Ekb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4793
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290095
X-Proofpoint-ORIG-GUID: X-STXgp0aSTS_aK_WRCnwyH50UGq_C5p
X-Proofpoint-GUID: X-STXgp0aSTS_aK_WRCnwyH50UGq_C5p
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the series:

Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
