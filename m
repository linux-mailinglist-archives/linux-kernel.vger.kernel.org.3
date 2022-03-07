Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0B34D0741
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbiCGTIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244977AbiCGTIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:08:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DFE24098
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:07:49 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227ISfrp028212;
        Mon, 7 Mar 2022 19:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zTBM5H6QyBzt/Zu9XENd6Mn0eJvRmD83jLNDwVF+K5s=;
 b=oertOQs/gNjyynItEMZNlGfbYWhGxW8h+onOns34oWuPN8zhWw33BC3Hkqvrtzy0lktn
 wYE9Oz7K4C8t5nG2sKm9EoD9mmobhWAu5h6Iy39t+aBuc7ijR5a21XWILxiiBNCnjLy0
 9NHVesTYGBBR26PzzJxcA05158rymsJUk3b/zjlTZwdfEpnrGZMGh1nOLMMTeAo+DwS2
 WkzzJ6cjC5xOR/MyxHFjXfr/AK9fJ49cDWoeYpXHrKaFcT1/QfUACp1QmsjfGRHu2rP9
 +WO2Y75KdKr+eY5nldBopLMsRXLj+EVQqAT2HXY1l71KquucuUZVn7cmar0aJY1L5ONt ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2cvrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 19:07:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227J0LCR157716;
        Mon, 7 Mar 2022 19:07:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3030.oracle.com with ESMTP id 3ekvyttge2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 19:07:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4Lf6bOUztRI9yZdCtLPNK/WJ53NDPofAeAUNSgpLGWYixRT67fILhKZMaWi50NaDvNhWZECxJwWyiAsNi/kVuuCS5yJxtI5padmqb3iBf1CeA8SCXEvVdxXg+XoOTe7SmSiopHYKJEp3V3OorFuZgNdB+MBMMWGBPMw0ZK3eurrUNfI/uOMdJRAyPArdVd/6W7HP7rrjo//KGeO9dvYqNfoThnse34GNXaSQ/met603zLpgvqsJiodKKYHI6G7tXFyagQgZByVCIUrTjP3hWsIHOKkZf8gx2GKQaXdDA0Ho03BA8IEPQhIchG4BiubPig0WcW96vezrV2cD9dICQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTBM5H6QyBzt/Zu9XENd6Mn0eJvRmD83jLNDwVF+K5s=;
 b=HU6+VBQ/dZYz64EPnbvsYf1QECV2B343oxKAP7tn4TH6s6Xl5FQ2QQ1dvV/4vAvGVe4F/sRvwB2TYkRozqJw5/sfyaGX46dCxh/8TODLlx8vw75+11mTSQgyKrVQP+VZicMM0czIVwlACjj4QEtoQxziR8ZewiVfQYMhHOb6wmxQgJyGRUFLzpSmzcFy0vFObXMX9S/rLfKfnWIy0Ann3fO0wmG2JoYgDXyytnD0nLLZCW1TMW67q6r27HoaEfpQ1XFoTqk04TDCV474Ps84aeXX73gJwsV3Ry2GedlqzwhfkPdMM0VSBCB4tfckNpG7rTNZQAYYe5H7H+936CW6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTBM5H6QyBzt/Zu9XENd6Mn0eJvRmD83jLNDwVF+K5s=;
 b=S1XonkswHcljj0WPFIzs40G+1KBTKUljPgsUqm/C5LZB/2Q//KtHuAKIwWAQI4YAJk3385DUVCH/Pf2aPkGkRbV5v7vgu9yZvXEEVWJ0ERJwk/EhepczNF8OcvybGmO05CkH6W3vV3oubCWNZcQrlDTZdl2lxgkFSJDUBojO5T0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN8PR10MB3282.namprd10.prod.outlook.com (2603:10b6:408:d2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 19:07:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 19:07:35 +0000
Message-ID: <89af9b3f-1ab9-15db-d476-574271ce8292@oracle.com>
Date:   Mon, 7 Mar 2022 11:07:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] mm/memory-failure.c: fix race with changing page
 compound again
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-2-linmiaohe@huawei.com>
 <20220304082624.GA3778609@hori.linux.bs1.fc.nec.co.jp>
 <79f79813-bb9a-bfff-0837-a24d14da0b19@oracle.com>
 <999a0f88-9465-0c93-e922-8aa80fa64f81@huawei.com>
 <20220307070155.GA591088@hori.linux.bs1.fc.nec.co.jp>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220307070155.GA591088@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:300:95::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82d84d8d-20a7-4c6f-f98d-08da006dbd2d
X-MS-TrafficTypeDiagnostic: BN8PR10MB3282:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB32826237A5A9424815CDEE41E2089@BN8PR10MB3282.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9SqOnVf0I2IlSRSlLbNq9Rbm4z1cZMGKpUigOsaC95FQtvNG3XpMFHqOFXO9TPLevB9U+4fRMMjDFm4RP0uw9MA05RWgLuwYR+FazaqelUCfzpg+IEkcEUdzqJMBTbQRUB4rQN6ViZwKmJgyXMevF9lWNZI3SB9xvmQV7gOCwZ2E+tLOcEz28hSdLf3kw/qsMBIInuaLasktPvzMl6UU5BEFtWCSNagYo4q0XJEK8e4FDSrBJPhd28kFJSact8a9s5mo8x2zqZuLpsTiHQ3rtz0Ryn95efzWC1fiPaBBIWOZ8MdQoeqvqFKt5pkzpSwJ/Fba/ZS3Q9cVngk/XNQpjxrysSiQ+HWoNrSy3HS9bpwu1QgajwneEkc8c0o1FNIW4MkCtVayFfuvQgypxqxdASoWMoiKI4FXg9KWGDXbBj5RfBQ5fZtEisLx8XR0JTKl/E2lbbD0wUCyVedRvGD+Q1Pb23cSq3yIFNFb64xrhECXxbzea6gJMM1lObiEOuPii5oTVckgl830iXEyC0Hbz6TBA72KN/fvXALlr7YXuEWmjszIc6I6FXqFKemVfTI94kygNHAgfcKJC9Ul8CtTihpEit2hHxhwa4/35xq2aIPyqI3Diiw6zVs5zC0ri5rmNFlQqfy/FyyTp3vbgSZkPyAl0ADNeWRtgYNbNpdcKeJEvlJliC6puZCDagu0Xth4L00HlcERj61R/b/edMJlUVo3ALSL2ITEAGNHPLBQInOV3lv1yZXeKrUAHApOfWe1mQ9jEQ6eZHcKD8UmzMV6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(31696002)(110136005)(6486002)(36756003)(26005)(2616005)(186003)(52116002)(6666004)(6512007)(6506007)(31686004)(53546011)(86362001)(4326008)(66556008)(66476007)(38100700002)(8936002)(5660300002)(38350700002)(66946007)(44832011)(8676002)(54906003)(316002)(2906002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHIrMW82Q05DZHpkS0RaSzIyc0p5VjBEakNXQWdxZjhndGxNajI1VGhGLzZs?=
 =?utf-8?B?QVRrLzBsY3pHNFcyQXBXREtKNDRIcTVyREpLTldSMmtNMStHblBaN1FDUGRD?=
 =?utf-8?B?alBZTkFwTHJnaEthTElNemtxZEFXb1lvNklGZDdTbFpkMzgwaFkrT3hkQnF6?=
 =?utf-8?B?UGFYVXJ6VzRYTnlVZzQ2MUJnSys5bWNsUUF5d3NpSlBUM2l1WDJUelNoN0Uy?=
 =?utf-8?B?UUhuUGdOZ2hwVTI0UjBNTm1hWXdrMys3ejBHY29GYWZZODhXTVRBaDdxTWpC?=
 =?utf-8?B?YWtxcWVPdjRZc25mYVpzWEpWdkFpb0VUdDFOYlh0MVZqUGcvbTJJZS85clF1?=
 =?utf-8?B?WDgyNHNzUWdCV1lIdGFqRTlTTUwyQndOTFFBdGZoZDdBeGdjSEFwMm41NTRQ?=
 =?utf-8?B?NHJrSWtjQ2VUdjRZSlFvNHROWVBxV0ZQNFFlaEdTckJjVkV4Vmp5a0h6SW4y?=
 =?utf-8?B?alBuSG9GS3VlK21WaTZlaG4yci9lUmdwbzRNdDBEczZLSW80TFhlRE9OTEhl?=
 =?utf-8?B?TU9yaU0yT04rN1E2MmNZaWJwdWNxTFJDTnZtZTZnMkNVRzgxcUFNbVRGK29v?=
 =?utf-8?B?RGNWK3dqSlBPbWFuT2R4bkhCWUdDeEQ1YmU5NFl6a3RwaFJQOUFwZDBrb1M2?=
 =?utf-8?B?ZjFJZS96MjV5REE5Z2NQZ3h0SkVUTEg1akppWEJoUGx3aHA0aDlvQi9TS3ln?=
 =?utf-8?B?WitxSUt4d3hkQW5waitxdFRCSzNMdFRHTmVtRzltUFFPbElrd1pBdDRTbTll?=
 =?utf-8?B?YkpBeGdwWEJWSDJXNllQWGJKcXRsdkZFYjJsVUJQWTg4QnRvdVI0cGJJQ1dV?=
 =?utf-8?B?MlBOWUxGR0lIVmVLZG5RU1JheHp3MjlZZUdrT0NjOC9LTmk2aEV5S2E5RU9D?=
 =?utf-8?B?MDhVQzNkcXpzOEFEcDFIS3BOMGpqcStHK2Mzb00zNFlLRCtTeXJsa2FTWnli?=
 =?utf-8?B?T291N0c1T1BEV2JlUHNRRUJvWU9IM09tS0ZzR3lWTVNCb3RNaEJhYjc0VjN2?=
 =?utf-8?B?NjIxWXI4WGo2KzZwcFBWU1ZIRlZJd2dXanl1WDQwSlVOYnMrMEc3TFd6VW0y?=
 =?utf-8?B?SnVJQkdOcHVVUFZ5WGlXUGQxYXZYVUxJd0hCSmR4SUhiVHFVOXg5Q0RWdDZo?=
 =?utf-8?B?WGdJNVF6c3NucmZ3dHN3N2xTNCtQeEY4WDJMU3F5N1JLYkdWNkxLWUE5Q1pi?=
 =?utf-8?B?VXhkK3F5L1lmZHBOdGdQdWNZSSsyY1F6bk9iZjJMTm9JS1dhdkdzd0wrcFNy?=
 =?utf-8?B?ZExwSVhBYUc1RXBzWGpwWHkzT1hPSmkwY2Yva1VoVFFOSmZJMGRLN1pHQWtB?=
 =?utf-8?B?OWdSRDJsWmRjSG5RY2tGTnVLOW4xd1J3UXBrMlZDWk1Qb3IrbC8wSElhZ0Nk?=
 =?utf-8?B?dWdiVVkvTUdUMFV2Yyt5UDZYbmNVU2VMbS9sSldxdjN2bnhtZ09zZEFjeDgy?=
 =?utf-8?B?d2xjc3J1YkdNT2drTi82ZjZpL0NaQWh5Tk5ZOEZhNjVtY3g3V3NTUGd1WnBw?=
 =?utf-8?B?a1RHQXhxVEUxcUJ6QmFmcXRXZ2xRL2ZSdDJmdVlocmoxVFBnd2VaVUNQcnpH?=
 =?utf-8?B?SSs3N3RjN1RocXlvZnhoOEpNWkFaSmwzdyt3d2hsWHhaTkFCUjMxd3NmQ3ov?=
 =?utf-8?B?RTlpSEphdFU3ZGxWNmgzVzNYRDBPQVA0eTdkSGtSeEdKRkpVVjVXQ2RHQzRG?=
 =?utf-8?B?VGM3YmpYWDRKUTVmUzBiMWhzaGphYlZaUVZWaEJQdDI4WDhUcTRnSDdkbFFM?=
 =?utf-8?B?YW83TndleEdsd09oZ3VqV1pqTkJJaUFMQjd5QnVYNitOVndlSGFqWjVHRDJM?=
 =?utf-8?B?TVVtblp6Z1dyN0dXcXRrYlppUVVaQXZ6NVZYRW9JaFd1LzRjUWhqY2tHQ1Vy?=
 =?utf-8?B?cWo1RHl0ekhjV0tWSWVMaEFjWEZJUDdKV0pybUJ3TjFvcnYvZERVbDZscTlF?=
 =?utf-8?B?cXVoeHJDTzVQTnR3eXRaVktLWGthcVdqTENIemxWdUVsbGlNMEpuVE5RZ0Zh?=
 =?utf-8?B?b3VoczJINEl0Y1RwVDV5dHVtMUE1SXMySzBuNk4wSCsxbC9kMXNXNnRBalZm?=
 =?utf-8?B?bm9sRmJ4T1RGWXlRdyszVTZwZ1duNm8wNDNEUHowcGdkMWRKYW1jOFRHL0FR?=
 =?utf-8?B?NjJncWE3bjR3NFlGWjcxcGNndzE1WnZNM29lZm1adEpWdUdhMGt2elVxaGRq?=
 =?utf-8?Q?Q0hMu1BxpiARbUx2o1D5sU4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d84d8d-20a7-4c6f-f98d-08da006dbd2d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 19:07:35.3875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mqc7Ht+pJjv1G6slfunZyKhEfr6FHmcgT6dUbgSVJb7C0W7tslSuTiAwumaLfd3JAUqCrxYeZCj9Udopa5UHDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3282
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070106
X-Proofpoint-ORIG-GUID: TBOGPDenfjI5LumsYn5aHj1gVWs6iYPE
X-Proofpoint-GUID: TBOGPDenfjI5LumsYn5aHj1gVWs6iYPE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/22 23:01, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Mar 07, 2022 at 11:44:20AM +0800, Miaohe Lin wrote:
>> On 2022/3/5 3:32, Mike Kravetz wrote:
>>> On 3/4/22 00:26, HORIGUCHI NAOYA(堀口 直也) wrote:
>>>> On Mon, Feb 28, 2022 at 10:02:42PM +0800, Miaohe Lin wrote:
>>>>> There is a race window where we got the compound_head, the hugetlb page
>>>>> could be freed to buddy, or even changed to another compound page just
>>>>> before we try to get hwpoison page. If this happens, just bail out.
>>>>
>>>> I think that when some hugetlb page is about to change into other type/size
>>>> of compound page, it has to go through buddy allocator because hugetlb pages
>>>> are maintained in separate memory allocator and they never change into other
>>>> normal state directly.  memory_failure_hugetlb() takes refcount before
>>>> lock_page(), so the hugetlb page seems not change between get_hwpoison_page()
>>>> and lock_page(). So it this new check really necessary?
>>>
>>> A hugetlb page could change size without going through buddy via the new
>>> demote functionality [1].  Only hugetlb pages on the hugetlb free list can
>>> be demoted.  
>>>
>>> We should not demote a page if poison is set.  However, there is no check in
>>> the demote code.  IIUC, poison is set early in the memory error handling
>>> process, even before taking ref on page.  Demote code needs to be fixed so
>>> that poisoned pages are not demoted.  I can do that.
>>>
>>> With this change in place, then I think Naoya's statement that hugetlb pages
>>> can not change state is correct and this patch is not necessary.
>>>
>>
>> Sorry for my confusing commit words. What I mean to tell is indeed the below race:
>>   CPU 1							CPU 2
>>   memory_failure_hugetlb
>>   struct page *head = compound_head(p);
>> 							hugetlb page is freed to buddy, or
>> 							even changed to another compound page
>> 							as we haven't held the page refcnt now
>>   get_hwpoison_page -- page is not what we want now...
>>
>> Does this make sense for both of you? Many thanks for comment and reply! :)
> 
> Thanks for elaboration, I agree with you (I simply overlooked this race, sorry).

Yes, thank you.

> And please add this in the commit log.
> 
>> +
>> +       /**
>> +        * The page could have changed compound pages due to race window.
>> +        * If this happens just bail out.
>> +        */
>> +       if (!PageHuge(p) || compound_head(p) != head) {
>> +               action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
>> +               res = -EBUSY;
>> +               goto out;
>> +       }
> 
> Let me have one comment on the diff. The result code MF_MSG_DIFFERENT_COMPOUND
> might not fit when PageHuge is false in the check (because it's no longer a
> compound page).  Maybe you may invent another result code, or changes
> MF_MSG_DIFFERENT_COMPOUND (for example) to MF_MSG_DIFFERENT_PAGE_SIZE?
> 

Suppose we do encounter this race.  Also, suppose p != head.
At the beginning of memory_failure_hugetlb, we do:

struct page *head = compound_head(p);
...
if (TestSetPageHWPoison(head))

So, it could be that we set Poison in the 'head' page but the error was really
in another page.  Is that correct?

Now with the race, head is not a huge page and the pages could even be on
buddy.  Does this mean we could have poison set on the wrong page in buddy?

-- 
Mike Kravetz
