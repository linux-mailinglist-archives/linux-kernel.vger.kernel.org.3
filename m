Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120FB4E33C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiCUXCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiCUW7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:59:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC52C114C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:46:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LJY7Z2018491;
        Mon, 21 Mar 2022 22:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=83BE0hGmZHPCXQlrJpgu0pID2y+02xQYIzw3F8KKa88=;
 b=tsmHMg3ykYZCMZMD5mxUggxudtnLomM5voKv0iIc/uFhW91HBieCQCsmNphxgWg4hznr
 PG7oqWxl8/Y/K26e7/zOBSbkTDt/fNb53fOUo1nY20x+QUB8Hd4Q8Y+qAZnczyKbjR/D
 9rU/cfI5gNwypmDdtbAKBo/aXm1rc3V03i11ljhqvW8G+2dg7VZ/KliRJ1Bwn0cJTYTs
 FYYfT6Lkf8xkcIAAZUwF/Sj8xnjqSPbMLc2+7LXNA6ETvIx6tXgliHtMIPtnmeWJYwOp
 DSWrjkYr95gyCjjYW0/4QOqwsD/VZ4E7y2cfvVeLl6rJV9i4rrL9l5LF4Z+JCJPTC6XJ WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0mrrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 22:46:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22LMf15h095218;
        Mon, 21 Mar 2022 22:46:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by userp3020.oracle.com with ESMTP id 3exawh2c2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 22:46:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1a0g9G0kfldA0J7MqiOls3pJINOnS7jOLR7LlZHySAueYFDFINlt9dMQczak8ggoRT1wA05zYw+aAWybpf9cMJHrdw83MRT55aZ2epZpHH/Q9GHWGva6zgAL66rWH1SAZyeRYiH1a6icCyCqc5Tm6xdVQqJv7hC5SZY+FXzVkMUUlVqEqLsB/yoM4kQ9SyGzZ/0a5wqpeovNul3FtAuMt1MgeC5BKr9JNcRaCA+XDNJBJA546dGaGPSP1w87d5xD+IofsqRMwxu4pY2ZNw3YM91w+Wnw/YzhmgxtwCQo6mboq7Evc3WkJiE10z8iYDUMCgrHlvv6K8PvidJ2EiaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83BE0hGmZHPCXQlrJpgu0pID2y+02xQYIzw3F8KKa88=;
 b=lsmC1GFZcOtnSyvPTgnJgB6mro+FJvD55wRZvjp9xz8fzf7TLMGsj0BmVa0gbD8P6/7zJ2L1eZb/+kmXC3DpsWM2DaVpsKHuZcg+CfGqVADgYsyuGbjlArmFDmQbvrjHdqidq/Wpg1ik2sHfFnClmOtmHJ9W3UVPOhXM4ct9EsK9GGaIodi626xNtY8ThH/qNiLqzb8M5AQm4I0UQZ0T0lGXmFy4PczV7mI0JtHWIohfZg3OWTUHBE4/v8dqxQsm+pIcNn13zitJsy/pYkb30fHDt0FxnPB2JY73eAlbJPG8CVFTY3lMwGWz09POoDVRR9J40pdCjSeDnZhZ3aSkDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83BE0hGmZHPCXQlrJpgu0pID2y+02xQYIzw3F8KKa88=;
 b=LqfeeHTLWijRooQgikhPEe5nr+xYBcy5NDxYCzHA3byvOsNfgymYPMn7NHO7h40F3fp5yhl5q1Hoiu03kiBIOQYCIZh9jCr93wvrByKmKIuBNRrpeUaOkJZsdSMdlkM/Ze2KZ56OKGV32hgAmSc09ewkBjCm8z/eEuYN+EGt5qU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR10MB1428.namprd10.prod.outlook.com (2603:10b6:404:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Mon, 21 Mar
 2022 22:46:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7%6]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 22:46:38 +0000
Message-ID: <f6f7bca1-8ba2-b205-570b-8d614a4a8f11@oracle.com>
Date:   Mon, 21 Mar 2022 15:46:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20220318051612.271802-1-naoya.horiguchi@linux.dev>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220318051612.271802-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6df8abeb-1046-40b4-86c1-08da0b8ca8cd
X-MS-TrafficTypeDiagnostic: BN6PR10MB1428:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB14280A0661FDD2AED6ABFA4DE2169@BN6PR10MB1428.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTAX3o+qmvsL84pJAk7Qk1pcDK1394e7g0satBNkp0fGMIPxac8TBfJI9pJhiekPTFujALe9Gsu82qB0It61sOZEn0Gh1KvRDjnIMCD7INY5+25eqaJY9ZZBsl7jPiIyG6+zOyED0DTbN2/Sp6fdeChwg5O9GxO0SiwknwnGI28adPGdFMfRB2yYGIKbcQz8y2SuNXjB/wQZDBPB5PFNnVAe8BvaraoyyIv9UHfhKYWbN8tkMe4dEjGtPrsc75NPBAb02jErk9zTNfDHigVYFovD0aQGkrv+qVrozKKrAjabqwNz7ZYnyD3805woDGjYc9Ku+8S7wqDum7m3XwMAGXIrwcvccxi+PQJg7qI9qv6gGG0Yr+QobmHJz8n4KqqLZbpEtIPACl/rIuY1/AZ3KLaem4kXFisjCZQbBD6JXTczzDnt02uZrgJOZoXl6nBIvZ8T/uY3XhQ1/RZFaYPQUn4h2KHobZ5lEk5UvdxSW3ulJMgmPIS0uKq4iwqOjHMGuB3VMHEc4sQQSp9xtNZVP6c6uOx2KZgT/NW8FsDeEjbv3wUv7bs2HBACt0c3mJDSBd9cCfYsERAE+BnaTXSHRQwiwJYExnH3sAcl6Jlb+6Hs6ii/O834Z8Z9BS40Z4xg21iWAXmwrdprm4R3jhMkr1povpMF4RGTV+C/a0RPWJLWWG6+CfMg25KaAy4qzyLr7fDWmZ8ROzFcKAcCOoK9nn60H5dXBT16W/inrmaLei3p/WU036ZCI/stO69SsR6Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66556008)(6666004)(66476007)(66946007)(2616005)(6486002)(6512007)(53546011)(6506007)(52116002)(316002)(508600001)(83380400001)(54906003)(26005)(186003)(2906002)(44832011)(31686004)(36756003)(31696002)(86362001)(8936002)(38100700002)(38350700002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N05haHVMb2Zoem9OMHF4WHd0NnBPZEx2WlhUNXFLbk9wL2Q0WWNmNXVQdSs4?=
 =?utf-8?B?REM4UGJGTlNIRWI5K1JXTTMwNnkyZmhaWm03eHFrMXFlRllEdXBMcXVrUys3?=
 =?utf-8?B?VkYvaFBsaWZ3dHY2VSszOGMxeGt2dVlSWk9xbDgrQTZmek9EcCtBcXpJQVcw?=
 =?utf-8?B?RTdvaDIvK01DSE9nNzZ0TmlYT1QzTW1NNHdDcTgva1BTUmlFekdwVjFXYW1D?=
 =?utf-8?B?bXd2QVNlZDFtbmtvSE43ZHhQT0EwTk9QY2t0ZXlnODhHMGxSa1FUQVBldklY?=
 =?utf-8?B?NmttbHJpeUlZNEhpQ3YvYWM5cUdEdjBUMFN5UXJ5SjJqVXNPSkU2VmgxYXdP?=
 =?utf-8?B?eWJ3QTZhMy9OWE4rUlRvbE82V2pZQ3c4dFhzS3BkQ1k1Z1lWc203RWtaVkV1?=
 =?utf-8?B?Q01KZkZCZjlPRy92ZFk1bnJyN2lFOFdnL2Fpd0JVTWQ3TDRuS1JmNnczaVpm?=
 =?utf-8?B?Qkd2aC9YZ2JFQ1k3ZG4wL2orV1BLenZXYnFpZm9ZWTZ1bHpzd1oxZ0tFK3hq?=
 =?utf-8?B?dmxXajBJZWdtVkJwTGdqUTgrYUkxNk81T24vcTZLdFBGUVAvV3B6eVQ3ajBI?=
 =?utf-8?B?L0RoVG9KK0xjRzdkMDltc1BzMnZQY0RCWkVYSGlsRXc4WFNhOHlUREVrZW16?=
 =?utf-8?B?MkpQa0JFMnZaMWVsNFU3eWRGYU1FcHFuaGVhd0pVc3Z1N3ptdHQzVXV0c1c0?=
 =?utf-8?B?aXFjbG1YVm9wWVlqQ2U3ck5ibXBCU1BHcFdFMzdEakNiNFhaMHFENWtpUzdV?=
 =?utf-8?B?R0ltelhsVnRFajlQK3A2VDZ6VlJ5SXAxUWFXUHhoRk5Xenk5NDhBYzgwT2w3?=
 =?utf-8?B?UDlYZXpIYnkzSzJLcHQ4REdaU1hUaGozV3V0UnRWNjlNa0pySmZ0TUlNazAv?=
 =?utf-8?B?WW8vK05oR0tYNFRIS0RPakJwakJ2bUszOEgycjNIaERKL2F5TFhId3dYbXpl?=
 =?utf-8?B?Wmd2SUJyM1pSYnQ1NzFIaDQ1SFFQMXAyS2hWRFZVUC9nV1d1eU5zR3NhT2dm?=
 =?utf-8?B?bDB4b2FiWHhNYnRWMVFzQ0J4REhBZFhjdEsrNHNMMXNmSHh0cHhUZGdrdHA1?=
 =?utf-8?B?TjVOSXJqUlg1a1hCbUV2NkRyY2IrYW4vOUVzL0Jzck1uYzBtSDdhK0hrcVdS?=
 =?utf-8?B?ZWlaMW91ZGRDc3RtdHJGVkY1L0F1Y2lCR09SR1p3dUhLbVQ5bEs4U2NpbHhK?=
 =?utf-8?B?NE1vTUJsUnlmSnlHcXpxKzVQUkRGdnYvTDFOejErTzU1T25kSmRZM3VSbk9Z?=
 =?utf-8?B?U2E0N1Vyc1E5Q3RPd2NscDUvTVpYM2pBVUJ5ckt1SkJTUWhlZGNBT3Y4a0ha?=
 =?utf-8?B?UjRWd2VmbHZ1aDhSSzA5TllsanRGV0dKbGMwSWYxNXE3OVRMNXVxd1JSTHk5?=
 =?utf-8?B?SjMvaFlrNG53UUwybW5DQlJpUG1YT3JXMnZuQlRjTDRyd2VuT0d0TTZNa3Rv?=
 =?utf-8?B?bFZoenpOYjNuV2hMMUhYTDQzSDdSTFJyc2NuNGFObmxMK1Jya3BteXM0U0Ji?=
 =?utf-8?B?NjNxK0QvUkFBNXpCbHRiYlNEOHNqYmxSclZIWmFOeTh2R1E5R08rRlpoZ0JE?=
 =?utf-8?B?Vlo4SUZoYU1pNnFacXlhNVZJK3VhRExxZUk4amZvc2Y5MUxBUHdjblI3V08x?=
 =?utf-8?B?d2ZjWlZVeDhuamtDejlsVTZlVU5vaTdKUmRQZDJHUnJ2K3hVT3ZFQWs5aVQx?=
 =?utf-8?B?amVVL2N5Vm9scURaQnovMUl4Z0doSUlIQm51aXgyUjdpcVczYlZwR2Y0UHhN?=
 =?utf-8?B?dkE4cDNpNnpoUnNPRVRyUTQ4S284QlovRElSWWVTREpzaVA5SHNKWk9Yd3gx?=
 =?utf-8?B?SmwrbnJCcXZzMitGL0tsUFB4Wklxem1POWJhS1o1K1RMZDIzMGRRVmp1MVJI?=
 =?utf-8?B?RWZXVWRER3VpaTVsUk5JUUUzbHlWUEZkWHdycFZUNzJvK3AzYklETzkxd0dh?=
 =?utf-8?B?SjhJRGJqTmU3dkkybUJGSzZiRk95ZWZsYWl6Y1FpSHRad2QyeXVlSGw4N3lC?=
 =?utf-8?B?dnNCUGhmVVN3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df8abeb-1046-40b4-86c1-08da0b8ca8cd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 22:46:38.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3QsJWEdWMmA6y8QT+cwQkdKPxI2A7DoE19dEkna9tLWj1e+3JH6I3aKAxY6aLm0G9Z+TNtmagD8bJcMBUl5tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1428
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10293 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203210142
X-Proofpoint-GUID: GewV-R6f4eMpzTL3mSwlHoq5kKvrJLVV
X-Proofpoint-ORIG-GUID: GewV-R6f4eMpzTL3mSwlHoq5kKvrJLVV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 22:16, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> There is a race condition between memory_failure_hugetlb() and hugetlb
> free/demotion, which causes setting PageHWPoison flag on the wrong page.
> The one simple result is that wrong processes can be killed, but another
> (more serious) one is that the actual error is left unhandled, so no one
> prevents later access to it, and that might lead to more serious results
> like consuming corrupted data.
> 
> Think about the below race window:
> 
>   CPU 1                                   CPU 2
>   memory_failure_hugetlb
>   struct page *head = compound_head(p);
>                                           hugetlb page might be freed to
>                                           buddy, or even changed to another
>                                           compound page.
> 
>   get_hwpoison_page -- page is not what we want now...
> 
> The compound_head is called outside hugetlb_lock, so the head is not
> reliable.
> 
> So set PageHWPoison flag after passing prechecks. And to detect
> potential violation, this patch also introduces a new action type
> MF_MSG_DIFFERENT_PAGE_SIZE.
> 
> Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>
> ---
> ChangeLog v4 -> v5:
> - call TestSetPageHWPoison() when page_handle_poison() fails.
> - call TestSetPageHWPoison() for unhandlable cases (MF_MSG_UNKNOWN and
>   MF_MSG_DIFFERENT_PAGE_SIZE).
> - Set PageHWPoison on the head page only when the error page is surely
>   a hugepage, otherwise set the flag on the raw page.
> - rebased onto v5.17-rc8-mmotm-2022-03-16-17-42

Thanks for all the updates!

I can not find any issues with these changes.  However, this code is
very difficult to follow/understand.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
