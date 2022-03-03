Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDD14CB4C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiCCCMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiCCCMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:12:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A5163B7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:11:55 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222LxL1H013834;
        Thu, 3 Mar 2022 02:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7Cp9J//bQQUjc+F/H7wFhBgQLPh2oU3W65xAyFcURaU=;
 b=Tu3/mKpao5BDA9dIpCyC/haDg0nMNtXb21F0b59geZeEQRmzKlJfpE0pSy+uimAyzpz3
 qB48g9p03/2Tc7oyfD5ZMYhe/T+poQjlPsb/oGoI7uQB/9KfhJ7B9HeJYX9etn4rI0y4
 NLzTpqVSqhNOTHrWyW5vwBgF3pMtIecDxWa/2ipFeI9fK0oUsSeCmcUqUrgJbDyKZG31
 mb5D4UMeb7IGSm9OWhR3YCUszufQ3Qeu5+AQ1sBoXz0q7CQaewQjPneBjcvzmP1enF45
 3qlFfJKbZVKbM3jZTGHeFmkqq55ahhH+pYd8TEmEUM5RAtuso2bp5TACrlAE0XbnkVDv Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k47jgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 02:11:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2231jMFU057160;
        Thu, 3 Mar 2022 02:11:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3030.oracle.com with ESMTP id 3efa8h5mmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 02:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE0kR4lmsVCKea8ALDlasw9bh7yJ+1TVg2rKUt8AUKGpfCQPROSU/85PPyeXFnUymcQT1+xoj/3vNgmfwUwh8RshEW0zXcClxcKUmljA3u2/ai+NMcuqt1o5CNteh7OO4XKCOFXgGoN3LVtwfs3tALC0u3Iny4MwY0ieCggz7ibJYQ4NeLnV5NVxL0rcWUeaWMBm++SwI+DAtUENIW62D2CscunPZW5yhEHWP0IRxS2J25N9qP/IY7OEbI+Oeii0dSk162tPhzpk4JJKUTD3KFg4qPj5vBOieK92rACS80ufgFAp8pFfzr4Qb4TGNIyYQlWr76dasJHKBfQxXyoLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Cp9J//bQQUjc+F/H7wFhBgQLPh2oU3W65xAyFcURaU=;
 b=EePiwM2cYi467hhCc4Tr3739HmniYUrYerZO4b+iUQO8s2SVyYnANS3GUMxcHDpeDxDMC4gTttD9e7ybK1X35iZlHUHbUyRaBvcbz/Bq/yD3TJHf7kfcYrVLk7dJgGFWx0g9mWYuC5H4gSGcr696ucOtseDsxMfCa54APcEROLtjhbbVEjJgG+UbRCDE+FIJRX3BLWaEgPLfVITkJTWq6ZjW8NJ7nMA+dnGTrXpUsxs7v8/6lwCM76N1+yzKI5wWVBqVJK4DOJKoOPzjoBHcpACKIewo2FNXn13kWeESlWeJ92C7DW3ISGDs/X2pWQdLKlXT99MlLB5GilKyqZfP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Cp9J//bQQUjc+F/H7wFhBgQLPh2oU3W65xAyFcURaU=;
 b=OlNZsbifN9GNqFbo7IqmM62ZmkIZdyuQfbAfIT3zjfRs9nfaTwpO+0i1T+g/OF6c82xpBZ51g9TQIlBQv4ZW9vFbj3Fansw60a+QJv6Hn7K9tliFjPXtNUBWqvYFW90pz4utkbyMIUENjqqR1DN4yxzeChmku/Xn1ivdM9om7Ww=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB3360.namprd10.prod.outlook.com (2603:10b6:208:130::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 02:11:29 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7%3]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 02:11:29 +0000
Message-ID: <272a69ec-4cc8-f282-8499-88b24b61f130@oracle.com>
Date:   Wed, 2 Mar 2022 21:11:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v4 2/2] xen: delay xen_hvm_init_time_ops() if kdump is
 boot on vcpu>=32
Content-Language: en-US
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, joe.jin@oracle.com
References: <20220302164032.14569-1-dongli.zhang@oracle.com>
 <20220302164032.14569-3-dongli.zhang@oracle.com>
 <bacae45c-9f8e-456b-1036-7f68e1e4374d@oracle.com>
 <0ac50fb6-0aca-e61a-1f38-8badbc8c967a@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <0ac50fb6-0aca-e61a-1f38-8badbc8c967a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77bca3cd-1fc9-401d-842f-08d9fcbb2124
X-MS-TrafficTypeDiagnostic: MN2PR10MB3360:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3360F6B4187F05F38BC139FC8A049@MN2PR10MB3360.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpxySLVN1oHHz8FMWcZnnC6iJZ/ONFFLBYUcbPT/sBgc2MTTdRvTa+tzXITym/9Che9mNBgChLyNuAbacAAH7NAKlCpHcNP3vWN7PognlTldO1Zo/kwJVSmab30BiQOdS6AgF86NIEa+LLzeuMwd3rcIuGSUhRRgkXXg8tRLLqXTbnn0JqX0z3a2x6XlDGAPxZ6RxckDqZnsqr1QzyJLR+ZMHDrQDiOfTLPDzrtds/9/nBXZ42ToPw8S6cdFLXIB1dooxA0EKDecjWhkmw0JRdJa++k8ls9TJ1Xrdiogq6CIwcZUGh/9GOB3qNYDEubLFm7ItHzcWdWxS1L6pmtW96Txvuab2iAOWR1QCAWOKX4bZdFEeXfIPYZmi7JaUnBNeZoaCFkJxfpjkGbbymsACpcxaF3aERQW692rpOOHJYMfaMK1+HfiwpsoxQeVKDyYsmho11s58GacpfM03ntps3O1B+UywTKo/i262/nmfmtbToxpMVEguMcbRpNVs0TXH7AEc1yBEez8dTS68itaNe5OeKxhAePdCcp7jNbwE7pM92u4bjB1O3b9f0BDNP6XrKveBNqSTJcTrCpxq3fPJBumvFmNU5lRCRh/u374g/uMA2w4w1kO7rU/tuhUPbDJJI/XDpVFNEeXPyMhioJAx5G5NPBVGQaCojZ1hF7W8qp0YbfBDut9QyfR+CHTW2yktWKTD25NujSxV177bdebCciFXiB1AgZvaoqmrxypSXHB385kK2ChiSbIwfEtbWQ4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6666004)(38100700002)(36756003)(6506007)(6512007)(31686004)(4326008)(508600001)(83380400001)(53546011)(44832011)(316002)(8936002)(86362001)(5660300002)(2616005)(107886003)(2906002)(26005)(66946007)(186003)(66556008)(66476007)(31696002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWdhcUVjU2k1c2pvWHp5bjJoRklMUCs0Ni9JQmVGS2tWT2NGV3NlbnhjT1RE?=
 =?utf-8?B?SG5wVEIxTkRRc1MwMlhXVHBYUWdYdnRCUkM0VmtjeEF2ZzRUc2szYTFGM3ht?=
 =?utf-8?B?ZWRWRW8xRTZZMDJIdGdwRnhtN1BqMHpDMzFmN01yNFNPZ0htYnZqM3M1WnRh?=
 =?utf-8?B?RkdoYmYvdnpON0J3WStDUEhFYWJ2U2pYRTF6dWh6MndQcnVYRGtLSzRJZDhk?=
 =?utf-8?B?QXR3MzhtZnY1M3FBR3lKdGEzQ0pZV1Jkc0dGS1lGdW13TzFGNzFBVkl5WXl0?=
 =?utf-8?B?WnBzY3E0eS8zV0JlTnNmYjZQQlN3OW1RYW15QU9Ubmd3ZE5xZDNyWndTeEdV?=
 =?utf-8?B?LzEydGZCQVVzcyticlJ1Q0tkemxBSlBrcWNEQys5bncvZ2hDL3YrTU5JMTlG?=
 =?utf-8?B?Ris3aHA0OTd2V0JCZG5zc3dDNlJZQ0pRVWVOVlQ1WnNBRmdNVHlsV3FOMmJr?=
 =?utf-8?B?V29rKy9Qd2FSSG9ZZ0RHTXIyNHlTeUkweW83aGp6eUt6NjBCZ1E1ZUFDYjll?=
 =?utf-8?B?RG5PNGtoMWJmVHp2TTV0Wmc4SGp4eTJEakc1VFdlWUswN0pUWWxEejJZazBr?=
 =?utf-8?B?aC9UNnBSc2dFTjVld2l0OWRNQXNCSmd1YnNCMWVHanJuYXpKUkRObkcwWStv?=
 =?utf-8?B?a1FmT09oOGtPYWZubjZyZGd1SDQ2THRkMWszZStSajNuWWNYYjlTRTVVUTI4?=
 =?utf-8?B?dGVVZVJmUzZFQ1JxQTZqcG5Hb2UvWFdGb2dWTEFBRXVEVnZvaHB6UTllMnhx?=
 =?utf-8?B?RTYvc0FsMzc0OU5KUnQxcDFhUW9pMXpKVm1PeEYrN05LQnFVOFRTU0JvOGxC?=
 =?utf-8?B?ZmRMalFGMXIxRFUzanN1TTZBSnBpTUJjbGowOHpzZnB0ZnFLSGlmeEs4cVp1?=
 =?utf-8?B?WkFMaXdZR1VhV0hDdTAyT29Va0YwTkpHc3FIY0t4RVZLenA5Z0ZKVERhZ1dq?=
 =?utf-8?B?V2UvNVBlYWl0UlVnbVVLNStyWkVvck5GQUV3dHJUTGt1Yms0TEh6aGZRVlor?=
 =?utf-8?B?MnNRS3B6bzVCZ1o2ZGdVYlBCdzBkUk4xSEEwQ3VnU08yU0pDb2JrUmNGVU5M?=
 =?utf-8?B?MVVadkFGcldaR25aaEJnMzAvMjhUTFBOQ09PYnA2bzB3UWNZKy96R2FGeVpq?=
 =?utf-8?B?MTRrcEdsWGNzeEJtWllGUUl0V0xuZ3lFYUJGd3J1L3gzOGthNVBpWHhYZm02?=
 =?utf-8?B?Q1BoR2N1WWsweFc5T1NVek0yMWFpSHpKL2l3RFBxRE52ZWZkMFY4YjdsYjUw?=
 =?utf-8?B?TGJDMnB0M3cxQi9CQ0lneWJHdlo0ZjFlSDAzU1BhY210c1F5MTN6QVhyYjky?=
 =?utf-8?B?Sk9pcE4rM3FOcmZpSEdqejk1NUFXYUszS2t4SFRKN2xwbHdzNHlWSzRoMlV3?=
 =?utf-8?B?dUFpbFE3ckhrQ1VsL01oNVdlMXNtUWViSWJVVzNzTWZnWmdYN2VKRU0wQVBs?=
 =?utf-8?B?VUFnZHc0bHh6Z0tMUDJSRjhvckUwTjQ1Q1FhVHpVQ0Z5QTRVcnMzS040d3Vq?=
 =?utf-8?B?WXdTZlR4UVpOSUNtOHlBWGdLUTdBRitaSEx4WXNSbWNLblZncUJ2bmhpcFAw?=
 =?utf-8?B?WHF4blluNjRZOU1Xa1RNSlEzTThncGQzek1EeERhWkF5RUg1WUE1YTRZVGp6?=
 =?utf-8?B?RGVreWwyTGIwUjdsam5XM1pmZkY3eG55d3hBZnVpejFwYXV3WEJIbm9zWWJP?=
 =?utf-8?B?dHdZM0IrM1VSNWlONWplR1NSU3MxNHltUFpvU0RFc2F1L1dzWHo0V1JWWXFO?=
 =?utf-8?B?TmJVYUtVYjRTMlB5WkVzZlQ0bytTYmhxa3VGREJ1MlE5OWVFVGVwZ1dUZ0lk?=
 =?utf-8?B?TzVzbVZqN0d1MXVQWmxOZ1p0cVJjdXBkczlhRm9zd2l1c0MyMmllZm4xN2RL?=
 =?utf-8?B?WkFmYWhCZ29jRVd1eS80cXljeERzMzlSUGxlRksyQU90emFkRnBOL2tudTJU?=
 =?utf-8?B?SzIzaEdSMnVURG5lL2IvV25VMW5qVGRLTmVsTDNrYXR4NmcvdGVtNTVoZC80?=
 =?utf-8?B?bVRyRWFvQnpZZk82amsrd2VnU3ZIUFdQUjZkOW93UjZselpnZmcrTlQxSWU0?=
 =?utf-8?B?YzFZUmtXbkgzVUZHZUtXZ0hxOHF0MzZnRzByK3JMYU5kalRLMm1qNmVNeitY?=
 =?utf-8?B?a1A3dHRNWWx1ZmFaNCtIL0pyUEVObXpwUnMrZ3RlUTRLK3ZaQ3VlR01KYnlu?=
 =?utf-8?B?VmVmbmQzNDNGd3BrVytpaVIrM0FrdU5hOWRES3ZiY0djL0YvT282d2cyOW8z?=
 =?utf-8?Q?3syYcK7kTc2R05D0bAp+fFSqYBOLw87GV/PDt1rOZc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bca3cd-1fc9-401d-842f-08d9fcbb2124
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 02:11:29.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0rI+WAK6xuLOk0GDXL9fWju2Y7G1Ur7TCVRYgCYWv0xvrobka8FDblNFf5QYMtVeD4M8beVJC602mJZCCcuBfQp7LLpbf3JnTYl6Pa96EY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3360
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030007
X-Proofpoint-ORIG-GUID: DttzqhjGrek8svkoc2W8lyuqerD0Kmc1
X-Proofpoint-GUID: DttzqhjGrek8svkoc2W8lyuqerD0Kmc1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/22 7:31 PM, Dongli Zhang wrote:
> Hi Boris,
>
> On 3/2/22 4:20 PM, Boris Ostrovsky wrote:
>> On 3/2/22 11:40 AM, Dongli Zhang wrote:
>>>    void __init xen_hvm_init_time_ops(void)
>>>    {
>>> +    static bool hvm_time_initialized;
>>> +
>>> +    if (hvm_time_initialized)
>>> +        return;
>>> +
>>>        /*
>>>         * vector callback is needed otherwise we cannot receive interrupts
>>>         * on cpu > 0 and at this point we don't know how many cpus are
>>>         * available.
>>>         */
>>>        if (!xen_have_vector_callback)
>>> -        return;
>>> +        goto exit;
>>
>> Why not just return? Do we expect the value of xen_have_vector_callback to change?
> I just want to keep above sync with ....
>
>>
>> -boris
>>
>>
>>>          if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
>>>            pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
>>> +        goto exit;
>>> +    }
> ... here.
>
> That is, I want the main logic of xen_hvm_init_time_ops() to run for at most
> once. Both of above two if statements will "go to exit".


I didn't notice this actually.


I think both of them should return early, there is no reason to set hvm_time_initialized to true when, in fact, we have not initialized anything. And to avoid printing the warning twice we can just replace it with pr_info_once().


I can fix it up when committing so no need to resend. So unless you disagree


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


> Thank you very much!
>
> Dongli Zhang
>
>>> +
>>> +    /*
>>> +     * Only MAX_VIRT_CPUS 'vcpu_info' are embedded inside 'shared_info'.
>>> +     * The __this_cpu_read(xen_vcpu) is still NULL when Xen HVM guest
>>> +     * boots on vcpu >= MAX_VIRT_CPUS (e.g., kexec), To access
>>> +     * __this_cpu_read(xen_vcpu) via xen_clocksource_read() will panic.
>>> +     *
>>> +     * The xen_hvm_init_time_ops() should be called again later after
>>> +     * __this_cpu_read(xen_vcpu) is available.
>>> +     */
>>> +    if (!__this_cpu_read(xen_vcpu)) {
>>> +        pr_info("Delay xen_init_time_common() as kernel is running on
>>> vcpu=%d\n",
>>> +            xen_vcpu_nr(0));
>>>            return;
>>>        }
>>>    @@ -577,6 +597,9 @@ void __init xen_hvm_init_time_ops(void)
>>>        x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
>>>          x86_platform.set_wallclock = xen_set_wallclock;
>>> +
>>> +exit:
>>> +    hvm_time_initialized = true;
>>>    }
>>>    #endif
>>>    
