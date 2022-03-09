Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26F74D3DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiCJABT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCJABR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:01:17 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BCE11475C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:00:16 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229Kd8cE022893;
        Thu, 10 Mar 2022 00:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=S8RFF34OfACjlu7xXIpZpdtF6Pw1ycUBQoBAhDjzxWA=;
 b=ksbomfLB2OJFIcwA53rXt8weoqiSCm7+3wz3f9b2QFuka9lQsxBWg3QYW1pUa2RV1q55
 PktVNGgeb22UDO0d+AEKY/OQEfo1/84chLKh87xNqOLZYkmLtyKAp3lt/u+8ZrhPfkXV
 ITFlUhd9JDvvfS+obArwGbmzBfQZqoHDr7m1P773mbyulcYJYNaGFtr/i0Fkh/dzPYL3
 ZClGR6QsKVcjQ1u1inTWEkiMTRC7QDfdQhMXujwXF1wcwpBT9454lutPyfOligoEZqjS
 Yexwunb0V3NwSK1mLQD7DJY/SgLFbZi0Q9ylfvBgp9e+2miBU4ISXhin0elyAWNrUZwM Iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrau7e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 00:00:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229NfRjf022228;
        Thu, 10 Mar 2022 00:00:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3020.oracle.com with ESMTP id 3ekyp383ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 23:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh2TL/C8A4IC5CmvM5O93Hk1z2SZq4JLh5bRXBN0DvoUTQUhpsLXxteIs8oGdlMgU55pMxvn6huy5JYc0iV3lzuweMApsqydxQzOqkXV9Q73iA1PvsEZuK2HSFVAX8ykdHlU+Ml3vJAP693D5yslTjYXqz9Mqq2Rcct220AWPyDEVAwK5bPH0PoSIEIsJJkKzGzZEeB8bA1c4zaBMMSxJMg24/cHWz0OkyFhUn42YLD+uNVGoAuZl7YVIuebEgXdZWw97b5DtkqNR0ubmGEg+gm3WOdyk7IDz8938IrhpUTZrREGxg6eRHTB0SM0HrvNOYF34WnCARR5i6+O9twnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8RFF34OfACjlu7xXIpZpdtF6Pw1ycUBQoBAhDjzxWA=;
 b=T8AZ8YGjZ+vmjDJrT6LtsFjBmQthhs2l9gaEB4SLY9LgDVZNTDT2ahGa34M3V9C2Qjyva/yXmvINSRW1M9A2q4SUU+PRKWCh3Vn8v8G1iGaSsGyo1iQPWpHMJsqL9hcmY5UjY23yUxzG+BKmvoOtW3P4/Wzmqc37+aCDFROSkFDx4yBDnEqfFEKYsCCZ0rz+SQnDY7oEMtdaBsfltLL5i2OOOjAlAjlxQB9/MhwJeoE60cd2Jdlpf7sv9eofuttp9e5qGSJXJJPfklylktaP6w3ol+GpieuFHJkSjiQE78oPnjyzIni+5L1h35z2pYfcmUF+t1XXNc5dbtE70W/r4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8RFF34OfACjlu7xXIpZpdtF6Pw1ycUBQoBAhDjzxWA=;
 b=BWxAvIZBFsJKFnb9K7FFJg6Yo0CReVwZn95IAAjWWbbEGjXsVnKYh33W6qfA4yP5m+i+F1x52cLAxPUZ6MoI5DrvDXErKNjDzSh6i/qakYwrdP6N20COoaXlAs3ZpYagm6XhdBWgU2vtqsOwtVhOuaa7KihjETzrppRtHVx67Lg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM5PR10MB1273.namprd10.prod.outlook.com (2603:10b6:4:11::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 23:59:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7%5]) with mapi id 15.20.5061.021; Wed, 9 Mar 2022
 23:59:57 +0000
Message-ID: <84f27dae-43ce-f623-84ed-90ecbb3a6b0f@oracle.com>
Date:   Wed, 9 Mar 2022 15:59:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
 <CAHbLzkrmHS+nPbw1YZj-rE-ECgRr2nD40d-ZbxPvf05o-rmNcA@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <CAHbLzkrmHS+nPbw1YZj-rE-ECgRr2nD40d-ZbxPvf05o-rmNcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0031.namprd18.prod.outlook.com
 (2603:10b6:320:31::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 079a622b-b665-4ddf-3cca-08da0228e9e2
X-MS-TrafficTypeDiagnostic: DM5PR10MB1273:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1273B6D3C0D9EEBC24B08777E20A9@DM5PR10MB1273.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApUJmT/eL+E2Q+WX2Wyq+60VUwbq0Ojkp8BvcKra3qLkfj1szZq0igNsgzjfr23O1lhRaIp4ft7uZmU4wJjfVf5B/tOp+0zk2L8nE/V4iYzAndy/dozhQYsVfXt1d/GP4UVfO7006BaGWufn9jIQnGvbUcGj60R01pDb2YKKdNBuM9vzqYosyITvYyVuZVoSj7vw8FUPVyPsmeDQFdDY8UtBR+AS3vGNzw49RasUBzo0ERYfUZHTrc8JuJofL7VSGXd27D+kfPgl0Ai4JaDO6zDgX5YbUuYbsnabIQlthfR8aSj99GeNdK6PFbAc1LYUAri0Dxq9QoMRqTqofh4hVMaodArdc7RRa18tG93S5sBsvSixrPtU8dtIyZoNK4L7LXko3GOfVFItHLxI+nIfsOHfyOQStUKWOKQHfETiXT2QSZJpBgl6d/v6TrxRwWUPDjoEpy8+qt2QJOK49Ni/qvqohvEoy5GMDg0E1N9B6w2hP7jwxDi7kmNg/FLSuitkklhDIiSoBDpT+jaHVNovXal1XwdRR+Af8FbuAHZJSo+yujNRED3phfsNcHd5DV3x6LvtOm6naOrrDUZ5xstab2m+B/tImDmzyu5duPueRAWf+hExY70FA6DYpBNtrAF6a0oFq0eCxUBc04W09AkJbmygvjgtDb7IOaiAYapjOTaTc0mGgq3yGR1NfT/Fi/1yEsB/f8+V7OBCzJHOp/22s0SLPDk01Cn9SRX9M30CQdmhbG4HP/uxW1+Kygh0SY2W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(44832011)(8676002)(66946007)(66476007)(66556008)(83380400001)(4326008)(2906002)(316002)(186003)(36756003)(8936002)(38100700002)(110136005)(54906003)(38350700002)(31686004)(508600001)(86362001)(6486002)(31696002)(6512007)(53546011)(52116002)(6506007)(2616005)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZVdTI3TWdLQ2NGVlVVTStEWENFZFNWWE4ydHNvTlZRRENTTkEyWUZ2eUk2?=
 =?utf-8?B?NG9VbGJscTdJRlpNczZnekovVUR2bHdVS3VmcmdJaS84K0lYU3pwaUpacWNV?=
 =?utf-8?B?VTNaY1hXWTJoQ1JMVmc1TG1aY2JYVitiZ05HWUNZM2pqVktZWVBuTFEvOUJl?=
 =?utf-8?B?NjlxcVdManhKTnRCMkJIM0pIbGRYZTN4QWk5UTZidEZIZTBYdkZzSWdGYnFy?=
 =?utf-8?B?eUhzL0h5bk5UdHlKcmhxa2NsQitUVnNid05uUEFWRzg0dXhlMWhycnN3SWlU?=
 =?utf-8?B?VEdYa1JDNC9tcXh0K1ptVUs1ZVpoa2FlTXBZWWJpdkhqTEVCbGdZdzFkdkVV?=
 =?utf-8?B?YkQ1VVFvaDhyNTZuKzZyUnZsK3NWTlBqUlVXT0JJWmlsUTlydVZ2RjE5Zkwz?=
 =?utf-8?B?QStiRFoza2FSMmJucmZSTGo4WWhhc1VoZDlLNmdRVUZ5eXNCdndsa0NvMjB2?=
 =?utf-8?B?WE51YXZQUjFOMUI2d1daVk5NdUQvc3g0S25CanNKOGlmMEFJa0hQTmlPM1No?=
 =?utf-8?B?bk40V09UYmRlSkY5cjJKYjNhblc5bzlnd2JpUTlxaHFUSkVGN05vR2JrZTFp?=
 =?utf-8?B?d0VBbCtkbmducCtUNU1jR0oyazlGRnk2UGlRSDhxbE95YjFYVEhTWjhMaXZx?=
 =?utf-8?B?KzJEUkxvNGNiVUxWaTVGT2owMEhraEF3NkpRZGsrNEJIQlZ5ZTdoemhhcFFI?=
 =?utf-8?B?S0hwd2VZZDBQb0REWnljdmJuMDJjajYxYWhMaW5IV21zREpvU1FBZjBGWHRs?=
 =?utf-8?B?M2o5cGJjYnlGT0tXTW5jTlhFVDNhK1YzK1NSdmQwUHNaV3JwdkNkTTZXOUIx?=
 =?utf-8?B?VHZRWGs1bVNQaitXWkhad3dnRzU3eTlPQTJ4K24ybGdBaTAzZWV2QVFDbXVm?=
 =?utf-8?B?S0pBL1M5MXdLUHdpeGpORCtpaE1jL1BKU1VSSWcvSkE0SXBzN0IzdmZyeGls?=
 =?utf-8?B?d2wvMUlDMG0xMWdpN1greWRuOGc3bmxBWXlPRHhTZjFzMTlUbHVtK2JaVzEw?=
 =?utf-8?B?cEd2c294bnFWUWVJK1RybENMeGtGOENOMlVNSHR0R245WFFQSE5UNENkSzVw?=
 =?utf-8?B?ajgrYlByMkVCOGJSTURTVEhTK1UvZVpWNlJZc2pOR3F1bVhtYVRnUjJlOUtO?=
 =?utf-8?B?K1BYYlVFUXJyRUR2TlJPZUZWbnBndGk5RVBwNTZXc2UwQ1k2M2wwYWxqOVZ0?=
 =?utf-8?B?dVl2YnMxN0tjYW1zMEIxMW5adW9pc0VWTXVna1h3SXZGdUViblk2cVlSTlNu?=
 =?utf-8?B?UDZBN1BlanNBUmVVU3FDTnZFS0NDRmtrQkY0OGc5OWNQRjJjbWRqcnV0bTF0?=
 =?utf-8?B?QXVZS0ZXTm84S2hQYk5jRFdueG5jWE9jUzcyWFp6Qy8vM0R1M0pNd1hxcHNK?=
 =?utf-8?B?bW9EbG1abE0ySFExT2QwVXc1ZFhLbjlJSjI2QStqWllQQXkxdnBNNDQ0QWdB?=
 =?utf-8?B?ckllckRkMGFqczJtelpxc0I5L1ZYVkhHSEQwNXZlMjA3RE5hTTB2OFNUZFhG?=
 =?utf-8?B?S1dLbFN0YTRDUjkxWGtoaEhOdEpoNVVJSmFJSU8zRE1CaStUNFpDUkFzMjAw?=
 =?utf-8?B?dm40VlRVSGlGS1FmME5pcXVuMWtEUkFFeExFYk43TG9JU2h5UGRNM1JWUytW?=
 =?utf-8?B?bmwvR3VsRHBLTVRGZHhNOFRWVS8vUlRxcHd3eVRhTHpxcWNySndQdXJuZzAz?=
 =?utf-8?B?NUZJU0FhV1N0WllURzV6US9GakZtSjRITWJ2eDh4WXNYckdVT3ZNbFFqN09s?=
 =?utf-8?B?ckhwSDdEcldjeEJtc0dkRHNBb3NEanBHTjMzelRmOTlaSDJtM3FVZ3pDejdV?=
 =?utf-8?B?SklyUlRwY0FJQmZCUHNRVlR2aERHTkpyaFJxWVZGcE9xa3Rhbm5Oa2xtUHNo?=
 =?utf-8?B?MjNodWpYV1Fib21zdERIN1JramhXNWZIbGhROEQwd2d0VWdyUUVPaWNEVGxC?=
 =?utf-8?B?V2d3bE5LeU40THNhd1d4d1Y0YkxzUzdodnJXbTFJZVNmRnloNlhiR1FNVTJR?=
 =?utf-8?B?UTExUmpidTFDRmdRODJOdWgzVWMyZit4QzVpbGJ3cXFrRWJHQnhubzM3SDhX?=
 =?utf-8?B?V2E1dEZMaEVta3VzaGlmalRnbVRFdHNjNFo0Q0V6WUVwaFJFSjgxNGE0b2Fl?=
 =?utf-8?B?eStESlBqaXhXWG00eGxzTmNsU2FIZlJ5a2QzRGlmejBmV2ZRKzU3K2sxSGVw?=
 =?utf-8?Q?C/MprRPtvk1BJ/bg2JAmPD4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079a622b-b665-4ddf-3cca-08da0228e9e2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 23:59:57.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2RImW9FEkKd5jgQXoFWbTr2Ajv5VMf0XMlX8MHOxMXvpc9Zd2rJAxdp6NQVrN4KqcvwNIxVu1q9l+FhuIO4hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1273
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090115
X-Proofpoint-GUID: 9cylmeiCcELLhVyMuMbl3dYgtXLNWbV_
X-Proofpoint-ORIG-GUID: 9cylmeiCcELLhVyMuMbl3dYgtXLNWbV_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 13:55, Yang Shi wrote:
> On Wed, Mar 9, 2022 at 1:15 AM Naoya Horiguchi
> <naoya.horiguchi@linux.dev> wrote:
>>
>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>
>> There is a race condition between memory_failure_hugetlb() and hugetlb
>> free/demotion, which causes setting PageHWPoison flag on the wrong page
>> (which was a hugetlb when memory_failrue() was called, but was removed
>> or demoted when memory_failure_hugetlb() is called).  This results in
>> killing wrong processes.  So set PageHWPoison flag with holding page lock,
>>
>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> ---
>>  mm/memory-failure.c | 27 ++++++++++++---------------
>>  1 file changed, 12 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index ac6492e36978..fe25eee8f9d6 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1494,24 +1494,11 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>         int res;
>>         unsigned long page_flags;
>>
>> -       if (TestSetPageHWPoison(head)) {
>> -               pr_err("Memory failure: %#lx: already hardware poisoned\n",
>> -                      pfn);
>> -               res = -EHWPOISON;
>> -               if (flags & MF_ACTION_REQUIRED)
>> -                       res = kill_accessing_process(current, page_to_pfn(head), flags);
>> -               return res;
>> -       }
>> -
>> -       num_poisoned_pages_inc();
>> -
>>         if (!(flags & MF_COUNT_INCREASED)) {
>>                 res = get_hwpoison_page(p, flags);
> 
> I'm not an expert of hugetlb, I may be wrong. I'm wondering how this
> could solve the race? Is the below race still possible?
> 
> __get_hwpoison_page()
>   head = compound_head(page)
> 
> hugetlb demotion (1G --> 2M)
>   get_hwpoison_huge_page(head, &hugetlb);
> 
> 
> Then the head may point to a 2M page, but the hwpoisoned subpage is
> not in that 2M range?

That is correct.

It is also possible that __free_pages(page, huge_page_order(h)) could have
been called during this window.  So IIUC, head would have an increased ref
count and pages would be freed to buddy when the memory error code drops the
ref.  At that time, head would be marked as poisoned which could be different
than actual page with poison.

An increased ref count, or page lock will not prevent hugetlb page demotion
or (attempting) to free to buddy today.

There is already a patch in Andrew's tree to not demote hugetlb pages marked
with poison.  This at least makes the demote code perform the same check as
allocation code.  The race which started this discussion has been there for
a while.  demotion opened another window, but that is now closed.

IMO, it would be better to take a step back and look at the overall design
and decide how to proceed.  There is also an effort underway to provide double
mapping of hugetlb pages, and one of the target use cases is memory error
handling.  This effort is in the very early stages, but it will certainly
require setting poison on the (sub-)page with actual error rather than
head page.  Perhaps something like what is done for THP today.  Nothing to
address yet, but I just wanted to note there will be future changes in this
area.
-- 
Mike Kravetz
