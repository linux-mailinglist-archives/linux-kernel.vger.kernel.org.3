Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB54B009E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiBIWto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:49:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiBIWtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:49:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BAE01977C;
        Wed,  9 Feb 2022 14:49:44 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KHRfU013515;
        Wed, 9 Feb 2022 22:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LmT54csrbmGDixQ/cankU6wOPGWLnR12v5it2l8/dBY=;
 b=K45OkufKR+uzhD+pKJ0cySm+TDQesWEVAi6BdaIn29unTn/aOWlF+UeQC4cADicRAJEf
 uIpldziGWL7+1umzcJfAfImjHLQSxCyhx6Rlfwf02c1PAHhArVXfhbNVfrurfGefychR
 3ZVBps3rgGO1Spn3EmzNeftt2MFbaTk+rvmENg6VMVGwDwLsrw6mmBeGtrO7mgqKHha2
 ShadK/MdObXOxfzkZbKadmQD870MnCBeY6EFobqYAgvScU7UqoUh0OIz3u1u5JbizEos
 MJSwjpfI8rsC7GPOQ9mEM5jaYbMxPlNOO1CZBYpONlxXg8VGVGb0NMDado0CKlTCTqJO Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345sqxvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 22:49:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219MkQgS165206;
        Wed, 9 Feb 2022 22:49:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3020.oracle.com with ESMTP id 3e1jptwdat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 22:49:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl5uBIvk0kvsQ6bnFkFgKSR2gq8jHvjgzmQNCV6Zyo44fOOeRHlDB0t8zQ9yXn82N9tpCMLnUaogQvibHQwhaqzGBBWLHh/6xtC37oHBrBuQzxzwGUywYYd6Z2J+XXt5UNbS4AB61BMPwqxPS1Iw0ATmisj0q3uLTxVKS5EvBHk1o5FC9M+SyEonVa1CFxZij1oig4IqE8mNtXZEFxCiax85RoChJOA8aVC7xg1qXQHSsDW3sEDrtvx0aVo/cwdVNMgJ5ltVyqEtGwvGEPowPmFtPDIqSPgULtj+qGM0cqg6f5mj31VhZdm6ffGiz3Bdt4T1hEilqtmkwmeFdEsanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmT54csrbmGDixQ/cankU6wOPGWLnR12v5it2l8/dBY=;
 b=LcTdg7T7LgXpvRCasfFSHl4O3DTOihMumfYQmP1lz8Z4l/zsJymD1VupO9lbyzMYSNJJaFa6kWLei4nWWJfK3Oba6eaGz4aA/1Z1Cx0D7LTtz1R9GHfq2qolBMC1jPknpXJmLIsnFsx75dL/hsY7NeU2456Ns8BRlavvKGFRwj/yGjeVhWjCXd/NhG9ko79R1T5EHilvK7+SB2HIFwYaWpEmWgdFmiRV5tx2lPnqZr0sD3OcDtu8OrUKpf06w+5B/CPHovGWNYXeYXb85SiUrgnk3DuLsX4z4kWme/meDM530E1lG/4a+8lJ/Kh9AnAuMz/gb/aQ7U6Yqt+bOQz69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmT54csrbmGDixQ/cankU6wOPGWLnR12v5it2l8/dBY=;
 b=BhIuk4O3Zw5+MnB62y22VOFsY7iHgH8xzdd6Txy1sOW0gq7TRZZxRglc1afbiDlOpHS4ke+7f54JgwB/6uwDV5gBoDeXCXvDoWR5ff0rjEDrJqCAuh47Tec6+buz/K+HlxRYjWdQBwlqeSaUKp4bnh9jhqDFKomPyXhKFzx39l4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR1001MB2384.namprd10.prod.outlook.com (2603:10b6:301:2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 22:48:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4951.021; Wed, 9 Feb 2022
 22:48:54 +0000
Message-ID: <fd4a237e-7494-9bd5-1952-164c22896c43@oracle.com>
Date:   Wed, 9 Feb 2022 14:48:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 0/5] Free the 2nd vmemmap page associated with each
 HugeTLB page
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Barry Song <21cnbao@gmail.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jue Wang <juew@google.com>
References: <20211101031651.75851-1-songmuchun@bytedance.com>
 <CAMZfGtUeL45=WG3ceaZ_tALMGZTLtuD9jbfKEzeQv270OnaLYQ@mail.gmail.com>
 <35c5217d-eb8f-6f70-544a-a3e8bd009a46@oracle.com>
 <CAMZfGtW=e___8kpe1B5a1rK+SV63bP_Nwucj89QKaX4ZOMUpaw@mail.gmail.com>
 <CAMZfGtV0JKcjVL0qGoYCQJ-LsXdng7Z2UjBym5hf_WM0LcYi=Q@mail.gmail.com>
 <20211123190952.7d1e0cac2d72acacd2df016c@linux-foundation.org>
 <CAMZfGtW+DoKp_gCcPSy33Urc86A58rRp8HJ+-GOuW9vFP-BwxQ@mail.gmail.com>
 <CAMZfGtV-ODDGQ6dUuo_eSEDn2kDSiUjNDc=nyFwoRRSxNLsTeg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <CAMZfGtV-ODDGQ6dUuo_eSEDn2kDSiUjNDc=nyFwoRRSxNLsTeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR11CA0031.namprd11.prod.outlook.com
 (2603:10b6:300:115::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 208111fb-40df-4f22-c94b-08d9ec1e594f
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2384:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23844493983551FD4FEC3933E22E9@MWHPR1001MB2384.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUzys4jY6B4d36tz2uoMT5x4AfeIHoifYyZxeuv8se8nVXk8t4HZH3qJ0FNatz0ZzA2+nDjRPYpIxw5XdV1IhIudol1OnTDEEvve//Togxkby/jZ+J2h1BSN0ZvWNCPwubOHpqo0J/c8Gact1rHsfwFKOd0N4Q4DEqhpfdDr2Yvxj6s88XU5mZBpa7TElfnmqXFDYbcRRsPn3c0/NJtk8ziRwiEACES0EoaTQAP0+E3Omyenob0mTmAJsnlKLbeWu+cV9Vd0k/17dT4tA+TPc6XoB7eKRwNWyPUioyq4yOHR0BECiPkDlzo6ZePbbVWbDDmcZGp8QFGiERbri+lJ0nf7i+vap9eVzO09a3j3f2HSxRdwgGscKecBfYBNMUekwOeYxsn2NgnwdUnESf/F9BannKhz0NDIE6wdxHcoMwI448eKkXxNJjjRciWj+Qtsr5+fsAoLncLyyLQn5vfL/ISYFnybgIw1CjkRXaf2Kt5Eeukf8fBwGFXDthg7pEJhvawhU3ZaSdyv4NDBF3StTVKzFlX313Z1LtnSxxfvcPdkSN/BbOnQByHI/uFcpHMYWFawahW2W7kx+dOV2f6aZDo7Wj6II3BI5rbAZRqS6lhJfdWh6Ujj0EJ1DvR1YNA2vXFRV/zAKL0steRgtyI7KMPG0RkP35+KvritoQxc77nyv9Usf51Tt1/YpalvvUiD7EKKRmQgxOuAmZZYuoJaVZT+CDaOtfTyq46WaWvCCJ6HKMORWZhIbHklihDqmeauKGezPNnXqvKzRnTLlJdWIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(8676002)(6506007)(4326008)(66946007)(31686004)(5660300002)(26005)(186003)(7416002)(66476007)(6666004)(8936002)(2616005)(6512007)(38350700002)(53546011)(508600001)(86362001)(36756003)(31696002)(54906003)(52116002)(66556008)(316002)(110136005)(83380400001)(2906002)(6486002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXk2cllwajF5ay9MMXJqclVzWktIVFI1RzNBS0FJZ29yRUdlcG5PMVhzTjEx?=
 =?utf-8?B?eE5iMmtyWnVRd0RDZVFEMmcvNUk0SUdmZ1FzT1JJc0FhZkJoL0lueEo4WXB5?=
 =?utf-8?B?QTl3MmgzZXlwWi9WSUdveUJhMFhUcExuS3dyeTZQeWo5SjBwT0tsQWNiamFV?=
 =?utf-8?B?QTdGMmNrMGo5NUVYanlONXljcE01Vy9sNFdwYm1NMXVjcTFkSXNFM2h2Zjdt?=
 =?utf-8?B?Sm5IS1JWR2U2dW9wLzVnUXpXa3krZ1lqUlRMc3BoMUk3bENwRW1CNWxHY0h0?=
 =?utf-8?B?dFM3MVorNzlXNGg5dzdYQVg1dU1TQUFQUU5FTGZqa3J5bFhaNGRTd0JuMVdO?=
 =?utf-8?B?TzFOaFZvWVFpNVp4WUExSW5STlE0T20rMEV4UFpHWHRFckJ6WjIxbUIwVXdF?=
 =?utf-8?B?K3ZCZDE0VWRnOVBvcmpIV1B1bjdneW03dEYwbWNFclNNa3plZExKT2lKdjFD?=
 =?utf-8?B?YWF3NWxReFlBcmJoaXNqRmRWNUkzS2FlNUszb1NRWHpVUzBzUmxvSGZwLzlo?=
 =?utf-8?B?ejh1QW9wMU1oc3B6TkNNaTh1SmFZbVNhS3crRktHbEtZR2doRlpwNE1JN1Q1?=
 =?utf-8?B?NVdRVlo5WVJnbUF4TWhrUU4xMkpPYWtIeS9qd1J4Vjh0V050VFFMcmIzb1RY?=
 =?utf-8?B?bUMxeG56bHhidnFIamN6N1lVQm4xUmh1eXpHRzFBejEzL3U0cUY0dU1ERjdp?=
 =?utf-8?B?RnAwbjJ2RWcrNWxJRW5KUnUxWVB4YjNxdmhzNFh1WStVNmFoS0pmdEhXcXlI?=
 =?utf-8?B?T3RQRTZ1cUw4RTBLTEZQTWJOQ1VCZjhaTzBvTUt2b3VmWHM2ejhVWjZadExD?=
 =?utf-8?B?Z1lNN3doWWdmMTJjYTNjSHNqcGxldmxwVVh1bjl1dFJXRXlUT2dHK3dleldE?=
 =?utf-8?B?MndDQVR5OFBHaWN6ejh2Ni9CZ2JzRnNXU0tmYkxVR1JpL3ppczk2Vm9WYXpP?=
 =?utf-8?B?UE41UmJrYTlXODNxNnBQYUtlUGFmWi9aVWEzME1USjBvMXV1NWMramJRRUxn?=
 =?utf-8?B?Zk1oZHQzWWd3UTVlSDRFc3JldHhEOWxqRWhrU2t3RjRPMy8rV1g1MHJUZDJj?=
 =?utf-8?B?QWw5ZnhGODBJTVhwenN4Z0owQzZsb1Jwdnh6Tys0eVlqazd4Nk9YczRVbDhu?=
 =?utf-8?B?QjA1RVN6cFlJM1NNaUVpSXdQNVB6NlFxbzRaTHdnZXF2cUhjeFE4U1QwZjFY?=
 =?utf-8?B?RU82REthcTB0UHVSUVhNdVZnekFEcTQ1YlVsMmdDeHl1NTV0T09mcmo2ako0?=
 =?utf-8?B?KzAyV2pTSm9vcHNQVWxBdkVJbDdOK1lYeEdzVE9RZmEweW5PV3ViVGFxZ3Ni?=
 =?utf-8?B?MGJMb1Q3V2NUMmJSTVczTHhjd2tuQmNzWmhndEhoTHJzeW13WWd1eWVmTDRI?=
 =?utf-8?B?MnJFV2d3OVdPejVSMzVTNkttZnlpbkYrQXhGcWpYUStUazVxbDRnMXdaelVv?=
 =?utf-8?B?VUxRMTNvS0NLc1ZlYjkxTUhDVlVZVGMzTTcxdVk1T1RibDEwTTVVclBjMFNh?=
 =?utf-8?B?SEN6eVora0NUVThFTWlrYk9xeVR2a0pvNFBNaEZNelpBVVBBNjBWT0VFM3NY?=
 =?utf-8?B?ZmFPUk9EbHI2VkZlRXFyTExKRlVEbU9naGhYRGs4K3V0S2REdmlJOVVDY29u?=
 =?utf-8?B?eC9EYUs4VnVsdXdHOTgvUFJYSWRmdDE0Z1diWG4vUVpSb0ZHNEFYNm96a2dr?=
 =?utf-8?B?WkE4UXF3ZXNYaG9zWWpVMXJwZnFJSWNhSDJseUxXVWFGOTBlbTBRVHhMeUlV?=
 =?utf-8?B?Qm83VGU4aGVkUE5Kd1VpTUYxYk1oM283Vm9ST2xpR2VONVN4Y1FIcVhxT1ZS?=
 =?utf-8?B?eEJoK0djZjBNaklmU0JxUTFDZjU5VnFVZEpGNkJhRTdyd0NqWHMvT1o0YS9v?=
 =?utf-8?B?MFJ6alcwZkt6bmxMSzY1c0Q2OTNMOXg1WDhoWUwwdGVVQmNpYUVrZGVNNURL?=
 =?utf-8?B?dHlzUzdzNVdlRWlBc2x2Y0trMUhuMlZCa29hR1dkTEJTbHY5dm1uNDNGazJ0?=
 =?utf-8?B?TnhiM2dLMlRHQkJCakQyajVEUGpSZ0ZIbEVKZDJBQW5HRVpCQkI2SHkydkhX?=
 =?utf-8?B?WkZSaDNTdFlzZ0lSeE9YSUlkTjFMeXZRV0xrM0dFOVg4ZnlvRW16bW45Y3Z2?=
 =?utf-8?B?T2RPc08zZEUwY1VFdEVMSEFpNXQ5c2dFS2lpQjMraDhUSEJsSzE5YUNLSCs2?=
 =?utf-8?Q?tB//7sc+b/7xf3KJpqPLG3U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208111fb-40df-4f22-c94b-08d9ec1e594f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 22:48:54.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b9Jc4+a5KMloZMSpa26Ktjt0+iW11kcVpZegrE1is4ZdJ7lbKM0N7jaHi/xXD9PVr9Su8G6JDHqV7XE9ikemQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2384
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090118
X-Proofpoint-GUID: tzsQlv_gsMos4mFp-7Hf1AUa0DGts-r7
X-Proofpoint-ORIG-GUID: tzsQlv_gsMos4mFp-7Hf1AUa0DGts-r7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 23:44, Muchun Song wrote:
> On Wed, Jan 26, 2022 at 4:04 PM Muchun Song <songmuchun@bytedance.com> wrote:
>>
>> On Wed, Nov 24, 2021 at 11:09 AM Andrew Morton
>> <akpm@linux-foundation.org> wrote:
>>>
>>> On Mon, 22 Nov 2021 12:21:32 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>>>
>>>> On Wed, Nov 10, 2021 at 2:18 PM Muchun Song <songmuchun@bytedance.com> wrote:
>>>>>
>>>>> On Tue, Nov 9, 2021 at 3:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>>>>
>>>>>> On 11/8/21 12:16 AM, Muchun Song wrote:
>>>>>>> On Mon, Nov 1, 2021 at 11:22 AM Muchun Song <songmuchun@bytedance.com> wrote:
>>>>>>>>
>>>>>>>> This series can minimize the overhead of struct page for 2MB HugeTLB pages
>>>>>>>> significantly. It further reduces the overhead of struct page by 12.5% for
>>>>>>>> a 2MB HugeTLB compared to the previous approach, which means 2GB per 1TB
>>>>>>>> HugeTLB. It is a nice gain. Comments and reviews are welcome. Thanks.
>>>>>>>>
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Ping guys. Does anyone have any comments or suggestions
>>>>>>> on this series?
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>
>>>>>> I did look over the series earlier.  I have no issue with the hugetlb and
>>>>>> vmemmap modifications as they are enhancements to the existing
>>>>>> optimizations.  My primary concern is the (small) increased overhead
>>>>>> for the helpers as outlined in your cover letter.  Since these helpers
>>>>>> are not limited to hugetlb and used throughout the kernel, I would
>>>>>> really like to get comments from others with a better understanding of
>>>>>> the potential impact.
>>>>>
>>>>> Thanks Mike. I'd like to hear others' comments about this as well.
>>>>> From my point of view, maybe the (small) overhead is acceptable
>>>>> since it only affects the head page, however Matthew Wilcox's folio
>>>>> series could reduce this situation as well.
>>>
>>> I think Mike was inviting you to run some tests to quantify the
>>> overhead ;)
>>
>> Hi Andrew,
>>
>> Sorry for the late reply.
>>
>> Specific overhead figures are already in the cover letter. Also,
>> I did some other tests, e.g. kernel compilation, sysbench. I didn't
>> see any regressions.
> 
> The overhead is introduced by page_fixed_fake_head() which
> has an "if" statement and an access to a possible cold cache line.
> I think the main overhead is from the latter. However, probabilistically,
> only 1/64 of the pages need to do the latter.  And
> page_fixed_fake_head() is already simple (I mean the overhead
> is small enough) and many performance bottlenecks in mm are
> not in compound_head().  This also matches the tests I did.
> I didn't see any regressions after enabling this feature.
> 
> I knew Mike's concern is the increased overhead to use cases
> beyond HugeTLB. If we really want to avoid the access to
> a possible cold cache line, we can introduce a new page
> flag like PG_hugetlb and test if it is set in the page->flags,
> if so, then return the read head page struct. Then
> page_fixed_fake_head() looks like below.
> 
> static __always_inline const struct page *page_fixed_fake_head(const
> struct page *page)
> {
>         if (!hugetlb_free_vmemmap_enabled())
>                 return page;
> 
>         if (test_bit(PG_hugetlb, &page->flags)) {
>                 unsigned long head = READ_ONCE(page[1].compound_head);
> 
>                 if (likely(head & 1))
>                         return (const struct page *)(head - 1);
>         }
>         return page;
> }
> 
> But I don't think it's worth doing this.
> 
> Hi Mike and Andrew,
> 
> Since these helpers are not limited to hugetlb and used throughout the
> kernel, I would really like to get comments from others with a better
> understanding of the potential impact. Do you have any appropriate
> reviewers to invite?
> 

I think the appropriate people are already on Cc as they provided input on
the original vmemmap optimization series.

The question that needs to be answered is simple enough:  Is the savings of
one vmemmap page per hugetlb page worth the extra minimal overhead in
compound_head()?  Like most things, this depends on workload.

One thing to note is that compound_page() overhead is only introduced if
hugetlb vmemmap freeing is enabled.  Correct?  During the original vmemmap
optimization discussions, people thought it important that this be 'opt in'.  I do not know if distos will enable this by default.  But, perhaps the 
potential overhead can be thought of as just part of 'opting in' for
vmemmap optimizations.
-- 
Mike Kravetz
