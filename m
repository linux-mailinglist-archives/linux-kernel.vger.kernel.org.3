Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ACC4C8037
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiCABO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiCABOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:14:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0D360D5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:13:44 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SLbqlQ009568;
        Tue, 1 Mar 2022 01:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2HlA/MkBeyMmAXza7r8wQDGkcjEGujS3m8i7RNCSAp4=;
 b=ZRozH0PuRE8RupYbwD+7JxrLbV/StaYGr/UeFWXVHonVPrL4NR8Zt1Gxlk6gfQTXnACh
 QPM1qZzxQCNMbxPAcwSvqVutDnlRMx0mXsRetadqSt6oTFWAJuZYe8l84h7rTT6KYEVa
 fc+gl5Jtbf5t+hLo12NZyHTo8lKcV0eDgUppXSBno/ty59U9cfD4fgO+ClL1nEr/CIjt
 enROS8AmkBoCe6DWZcxtOoMivECrEgSSYUbnkfW85JYePcvcuJ+C0xAG2RKSXs2SSUU8
 3TE1QLa+/NWN6u8kCPHrwMFFYiHpkPGxpSDP8araPKqjecFmd6ELx+uK273AcnKeZoP3 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efamcdusx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 01:13:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22111Icp172748;
        Tue, 1 Mar 2022 01:13:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by userp3020.oracle.com with ESMTP id 3efdnkq6d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 01:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niqHuoaxoH82lZBlUf/zWqdr8yk9B3yXxplSumJ7v/l8ZZ/C4r5PsnLMyq8OUclTNdO5qRmgC0GBp/zwxHSQ8fUa2M8sjo4B3PKcCfqLJt1uVw2PFGji+lmc4bmH0+CVQPqAAFmEMwbcEi+UU3Y3RfQUpLxrgyEENoxjNeA/RVUxpLOiLGqRVW7YkMJALjKImOW8elE+Ly+7yGZ10GeqHm4DeXWsmeftCK8L5XNc67b4O7JLphZ2CilvO/UqEPICTjLsOXMX/HhsG7aLo0E2btvCfErKrQBoiuarFLK7swvZPmSgP2Brp76iRe2L+/f+4hAvlijhHnvZr1MG/j1wNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HlA/MkBeyMmAXza7r8wQDGkcjEGujS3m8i7RNCSAp4=;
 b=VIZTSwBbsnqrrkK+Z0W+Ucgm3+sTpBDlJrH57qRHU4g1Cub44xE1ek2siE6Je4UAGJ6fxgf+HRLYRlZEeyW9morIx+4bbbuwMhJoBooB1sarqTIl/AIVnPXpqax01GjsFGwuMTiOT2jml5ME7b0f/G2BaI12LM+Hll30gWlrshjXcpumZHnCQLQtv1CqRZx/WPGaW5byg2izpjK0FE6ytxbQPlYnD1HAV1S+L5hWyXSpdIiPk6I/F27Th4An7ZUCgkGzLDIpYbeGyIPWfRquJ1SDztk15lYv5izucrB6J/HmsTzGsmuHmHOpURVkJ7DWLGNX+n1V2UYJmLd4RNK2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HlA/MkBeyMmAXza7r8wQDGkcjEGujS3m8i7RNCSAp4=;
 b=vZsLJvMhAjADWdSiFXBdax6/MgL4gEVg+cXkTGY3TQOpIHsKx7eWQf7l/Hs0R2TUItZVSqXCifhlr6hVkCT9URvjaky126qphk/Xl4EV6l274+jkiry5eHHZq/M5hRX6NKS+lf3R7dDSKUelbmS+Ieig6Ihpmfh4Ti6U3wdWuAc=
Received: from CY4PR10MB1463.namprd10.prod.outlook.com (2603:10b6:903:2b::12)
 by BYAPR10MB2504.namprd10.prod.outlook.com (2603:10b6:a02:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 1 Mar
 2022 01:13:20 +0000
Received: from CY4PR10MB1463.namprd10.prod.outlook.com
 ([fe80::6d8a:c366:d696:1f86]) by CY4PR10MB1463.namprd10.prod.outlook.com
 ([fe80::6d8a:c366:d696:1f86%10]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 01:13:20 +0000
Message-ID: <e598fcf0-e858-db7d-5d8d-8da62ad1bf20@oracle.com>
Date:   Mon, 28 Feb 2022 19:13:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V8 0/8] Use copy_process in vhost layer
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
References: <20220209232939.9169-1-michael.christie@oracle.com>
In-Reply-To: <20220209232939.9169-1-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::34) To CY4PR10MB1463.namprd10.prod.outlook.com
 (2603:10b6:903:2b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d4ff5d0-3f79-4a0d-ecd3-08d9fb20ac3c
X-MS-TrafficTypeDiagnostic: BYAPR10MB2504:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2504A6B78CD3EEA6C3C30797F1029@BYAPR10MB2504.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30gkkIW2EJYwIUNjsVu4SNVgY1z5mK1KUiN7xB4gWFP1g5PKhdn9MCwN8VTkXapTWKc0UBqfGysVHcqLz32MQD/odWLdZ0Z62qPdEZ4zqNVeb+ch7926hVaVBnCh9yjuuKtoP3UenCHuaYXBH+QzpLvtxbU+GBkHLVbH71Lrmwu1VxG+aqIH3KDJZWtEhC6M0i3DtVfudrYnG9UuO1cGi/URTdH7RFAFUaB5DlbIJm5W3xdzZOoE4zbVm7p8LjSFGr1nRxHjuZVeebYh66pia8jpW+mMqxoghJD/Uvw7nhF+CZlFwARP3VqghiixN7RmiufSvrUEpmqZ4SNn7qbzymM6jZ3nt5/W4X08JlU597MsOZHIdJIIv/GwZVB9+w5zP9KumlGJaQxnxWGWQObdz6e+jwcf2zaea//+FJBafZWauyiSOekhKuWykxvZ+RTtq+lv6baL55cmDfX8lP4KgVbykajmFVyKeutRFWzxgRlAJs5F4ZXYjIRLT3UIopHqujXWxFs6jEheHes/D8zPBeW7ZqlkxTV7k1oIfhFrxmfVVOc/3Lr5sQCb7qHNCdb8SBa5mWgbipv/k+jXHLPO9UkHJtQlUBQ00zapQZ1E7609hIAoohFH4pLR3lz4k/qfMSuO8JdKlwtQOTQ4DwR5vRRxInyPHvsYkzlp81RW0yz9Ym+zL7ljecWP7uQ4PSpwmP0OCIeiL9KFrLokln0CyVk1BD+lX2MquM5u8TFKXw2hw9nC6b4y6Eq8yBcr6EC0lqqKQ4Wz8Zz6CPMUtxfVmtvXv7wAbL6RQ9gtmjcnVSxCcvS05GFcCMx1HSt6gBvqb8LFfQwkIsuu3SNYZA848IJ/NDtgysvdZPhG3ju03vlcUYvcJDmtgO/N0qVRaPps
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1463.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(66476007)(2906002)(5660300002)(66556008)(66946007)(8676002)(8936002)(31696002)(86362001)(36756003)(38100700002)(31686004)(921005)(316002)(186003)(26005)(83380400001)(966005)(6486002)(508600001)(53546011)(6506007)(6512007)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVRRczFHNXNYQmc4eGJjc0JEbkJFZEg2M3V0dks4MzFhWVZTaSsxQlg2Mkhz?=
 =?utf-8?B?Rit1dEwxbUlzRW1YcGg3aUFjWWR2VklNcDlyOTJTWHJiUld1aEVaTmd6b3ln?=
 =?utf-8?B?RHhIU0ZpeWZmSllwbE9pOFdNVitxVEN5Z0JFSTd5T005aDhyUlJ2bCtpSENz?=
 =?utf-8?B?SWZnK1BpQUdoRzBhQWVrQ3pQVHNZbzBPa056Y3d5NnI0MEFoNWJ5V2R4SVJ4?=
 =?utf-8?B?YjMrUXU3NHdxZ3FQWXFWemY5Z0UvMDZiWDE4MWp5OFRrdHF4empqc0lmL1p1?=
 =?utf-8?B?dlBETVJtbnAzT3VxNzRIMTVLYWhibmwwZG9BYjJYT1BhQjJ6VkIrNEpTUW1y?=
 =?utf-8?B?d09pYjBYYUpycFkvZ0RmRjRqK1VWSTZKZG52eHVseUJ3NmxTblM4bmR3dG9v?=
 =?utf-8?B?WGdIU2Z0RngxbWlwK0RKYnoxUXJKMzlNdHh2WENNQXRMam4yVktPSjBiREJK?=
 =?utf-8?B?dDhMYmdpcE1hNW5CeEdFTzFKOHkxRDl3TlN6ano4ZmpLTjFJamhJdFRHU3p4?=
 =?utf-8?B?dHQ0THpaYXc3UE16OHNIQWtESmNqb2tFRDZWclVNQkFHTWFjb3d2Q0YwQ1Rh?=
 =?utf-8?B?NzJlWE5ETXpiOUt4TW43TVZPeXQ0TkQ2SDVMNmxydnk2Qk5QSUQzelFDajJ1?=
 =?utf-8?B?UCtXL2tpUFljTmw2MUUxcXpIK2doa1hKbU1XemlRNXdnWUhydkNiT1R3S3Q3?=
 =?utf-8?B?UEpEdDVUQ01sTldHbkY3eGpQcitiWFM1b3g1c0JMQnlBYnMyU0ZRZlpaN01N?=
 =?utf-8?B?UEExekIvU1V4aGx4aTNMNERxWW9TNEU1VURaSksvYkFBckN4eHJFb0t3NFVM?=
 =?utf-8?B?dE5iUzZwclZkMWpoT0xmK1VEa1YrRngzVFRkNDRHTlNKUjI1NzRaZm1RU0Vx?=
 =?utf-8?B?ek9FTVJqMlZ2T0I3bnppSTlrRXgxT0VGcDFpcHh5eTVoVGtDYVZjQ1ZHOXN3?=
 =?utf-8?B?bUxOWEh0aWNETTAyNVY4dktqWGRmUGZBSlVQMUZDVVY5TTBMamJXSkJxdC91?=
 =?utf-8?B?ZEdCQlozY0x6SUdRTGdpdUJqU0lQektKWWZVRkxNdGluS1M2eFAydDZxeFU3?=
 =?utf-8?B?R2pMNGZnOTNYSFppT1VOUENtRmFzRkxReE1rWkNvb0RJQmtZRU8zNERJVkd5?=
 =?utf-8?B?V2RmT3dKdm5ON0VJcU94TW05SUcxdm9xSjhHM0QxVkp6alJURTZybmFNOXlB?=
 =?utf-8?B?dTJyUnh0aW5GMGV6VHdwYWJiUkdWZnRVQzBVdHNNWDVJQ0dXak5pY1d1YzBW?=
 =?utf-8?B?SjdKVW1SMHpXNHpNOVZrb3hMOTJGeUdvaWxqc1AyTDQwN0Nqb2hWby8wSzlu?=
 =?utf-8?B?dm1rblo4VUk2bERwOXVwajJ3TXhhbTZyK280WlFGVHNNN25pZVhvVGtGSTND?=
 =?utf-8?B?eDY0ZS93K3JXV2tKZEVCSmFoVUZxaTAxb2FPZkhVNDg2SnFBeklQT0F0Tm1q?=
 =?utf-8?B?Ym5TcUVWbk5ab2JESDhuV3RjcURudXpyNklialdobEJTWVVaa2FtRG9GQnR4?=
 =?utf-8?B?dERZcW00L1JLUURadDl1dytDYys1ZFFDdUtDVHRBN3VEVVpqSHJuUlhmYWVI?=
 =?utf-8?B?ZVZ5SjNqY0pwamlWb0xmUm5hRGtjMUcxWGgxblZTczZBaFM4U2o2ODJtS1Ry?=
 =?utf-8?B?QlgrbFlNdWRTb1dBRGY4MENWbUJOVGh4VjByam4wTG1DUnQ1YVRkdjN4TjF3?=
 =?utf-8?B?cjFvVGNEVlhPQmk5ekZ2M21pNlYzUDJNWTJ4U0RqZFoxQVVJZW1aSDFuNGV1?=
 =?utf-8?B?UHV3NVpZMWFSeXFtdVJPREtCRUtTMmZONVV5STlyVjVSckZyb2FpNDZHdmFo?=
 =?utf-8?B?dWFKaFloY3I4TE8wWHlYOGJ6dTRGUHhtRHpmV29COXAxM24vaXhuV2FrdHFO?=
 =?utf-8?B?K2pyQkRUUjVYOStSSVFxK0VieGxzVjlnZmNYZ3ptWjl2NzJnblF3R24zL3B2?=
 =?utf-8?B?bXNONENiQkZINE5aamlJL2tUWHJtYjlyeGdWc2JZSVBxNWF5T3NWVlBudEdL?=
 =?utf-8?B?VVRGcUc0UCtDeW9PWk1CaWdoZmF3RjluR1dkK0M3K20rSnZ0UC94R2ViTW1W?=
 =?utf-8?B?YjlvU1hZZlZtSW1CbjdnTjd0WkIxcXJQMzQ1RWwxQzF4NDRYWG5HU3haWXQ1?=
 =?utf-8?B?MkZTRFFOc05LTmlubFVTdkRwcy9LVGdGQjZveXVabThPcnpYWHpZZkhBR2dx?=
 =?utf-8?B?WitOTHQyb2FiWE80SEdMbkdDSmF1T1RIWmFvOUIzR243WHNCaVJVOHl0MU1n?=
 =?utf-8?B?V0FOa1JSRjBvVG92b2dGMHBDWGVBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4ff5d0-3f79-4a0d-ecd3-08d9fb20ac3c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1463.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 01:13:19.9334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WK2xGr0OvxI7Rt/inpj2G7QuFwqQJH35ziWfsPTQ38aWKMLSjJpqLwdpZ8JBbNzdb9VKvJ7uRAiL78ww4XhKJHALUZs5ITMp7noyCk+VLNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2504
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010004
X-Proofpoint-ORIG-GUID: Yii8R-QV1ygDLZ1tz5YtWi6D5iiwk4LM
X-Proofpoint-GUID: Yii8R-QV1ygDLZ1tz5YtWi6D5iiwk4LM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric and Christian,

The second patch now has a conflict with Linus's tree. I was going to
rebase, but, I wanted to ping you guys to see if you have comments or
issues?


On 2/9/22 5:29 PM, Mike Christie wrote:
> The following patches made over Linus's tree, allow the vhost layer to do
> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
> io_uring does a copy_process against its userspace app. This allows the
> vhost layer's worker threads to inherit cgroups, namespaces, address
> space, etc and this worker thread will also be accounted for against that
> owner/parent process's RLIMIT_NPROC limit.
> 
> If you are not familiar with qemu and vhost here is more detailed
> problem description:
> 
> Qemu will create vhost devices in the kernel which perform network, SCSI,
> etc IO and management operations from worker threads created by the
> kthread API. Because the kthread API does a copy_process on the kthreadd
> thread, the vhost layer has to use kthread_use_mm to access the Qemu
> thread's memory and cgroup_attach_task_all to add itself to the Qemu
> thread's cgroups.
> 
> The problem with this approach is that we then have to add new functions/
> args/functionality for every thing we want to inherit. I started doing
> that here:
> 
> https://lkml.org/lkml/2021/6/23/1233
> 
> for the RLIMIT_NPROC check, but it seems it might be easier to just
> inherit everything from the beginning, becuase I'd need to do something
> like that patch several times.
> 
> V8:
> - Fix kzalloc GFP use.
> - Fix email subject version number.
> V7:
> - Drop generic user_worker_* helpers and replace with vhost_task specific
>   ones.
> - Drop autoreap patch. Use kernel_wait4 instead.
> - Fix issue where vhost.ko could be removed while the worker function is
>   still running.
> V6:
> - Rename kernel_worker to user_worker and fix prefixes.
> - Add better patch descriptions.
> V5:
> - Handle kbuild errors by building patchset against current kernel that
>   has all deps merged. Also add patch to remove create_io_thread code as
>   it's not used anymore.
> - Rebase patchset against current kernel and handle a new vm PF_IO_WORKER
>   case added in 5.16-rc1.
> - Add PF_USER_WORKER flag so we can check it later after the initial
>   thread creation for the wake up, vm and singal cses.
> - Added patch to auto reap the worker thread.
> V4:
> - Drop NO_SIG patch and replaced with Christian's SIG_IGN patch.
> - Merged Christian's kernel_worker_flags_valid helpers into patch 5 that
>   added the new kernel worker functions.
> - Fixed extra "i" issue.
> - Added PF_USER_WORKER flag and added check that kernel_worker_start users
>   had that flag set. Also dropped patches that passed worker flags to
>   copy_thread and replaced with PF_USER_WORKER check.
> V3:
> - Add parentheses in p->flag and work_flags check in copy_thread.
> - Fix check in arm/arm64 which was doing the reverse of other archs
>   where it did likely(!flags) instead of unlikely(flags).
> V2:
> - Rename kernel_copy_process to kernel_worker.
> - Instead of exporting functions, make kernel_worker() a proper
>   function/API that does common work for the caller.
> - Instead of adding new fields to kernel_clone_args for each option
>   make it flag based similar to CLONE_*.
> - Drop unused completion struct in vhost.
> - Fix compile warnings by merging vhost cgroup cleanup patch and
>   vhost conversion patch.
> 
> 
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

