Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008EB4B4FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352745AbiBNMN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:13:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbiBNMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:13:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B208F48E7B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:13:17 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EATJCZ021228;
        Mon, 14 Feb 2022 12:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RbBYBfSeYIqbWLtOj6N1bQ7yO8cqqTtu13Aty/Txa6M=;
 b=xmhrj/1WRVFxQPwpkx2vPCxwV0TKGM855MGTogd3mPdX6uwxJW2ngLg5zVzEQqQ1fLvg
 CsbPXq+l2m4LFtqYDFhK4rz1cY2nK2KdmfCIYz0B9M9CkCdOebKqcl8aM2Sp4Ow2vf2M
 ZhEYcpXL4xkIY46ue+3VCprjh5qr7gdZ6vVuv8SEB7NSUUC2w/e+U9Hz1IHZBGVc6S78
 bgRQLtSZLELByT7zl0z+2xNcCuiUSGyn/Qrn7j85tPax4uHfVgacWlZQlj8QHdvynLoH
 mqNC8r0YIJaA1tt/+5comGZl+hl5Wnf2r8fWMIJkT0TMeNRx0Ko4Qo+i5mI8SYdSGoFi bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63p24c55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:13:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EC6NtQ033530;
        Mon, 14 Feb 2022 12:13:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3030.oracle.com with ESMTP id 3e62xd0m3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:13:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9w/iBnKAjChH/1JCfJjjO+O+PkGpaEJS2/AUb8NNPc/y2lPHBfjLuZyZA7rBcykMrYh1Kq4SqDy/lDyI3RSndTy+fBeFMIWEtUtWgBHudEFyiYr5JXNMgqwVMutCYgHXEjA5Alx0dXmFtkupV1qddfQ9Gsjtpmrz7eQgeSlx3V8YvR8nj1CiKoZdDvhFCM8FriIVn89NjVoA8YsZAoq3lCsZOhrEaqaVULyCuMuaMofnqBoeH1UNNxxSt9DBXNUh1eRXAEwyhAS8LEp6jTScXqeUXIi46HO6iELCTtvnU6K7fJTiN7RuAoQO61yl6S8QtjJp0aiuOHqUT8ai9sT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbBYBfSeYIqbWLtOj6N1bQ7yO8cqqTtu13Aty/Txa6M=;
 b=G0Ggj/AmZdLfRAkRkNypZGRIA3i8I9hZXnOHwCWA1vJive1t+pnlo/3K9pDG74WkLgOlvlEum2BhNmlL7BGt/ZobysTMi7HoWRXpHRzDT5LP/m8LZ8+pOZtwzQ36PZt3YWyMcYkChc4w8H4T0Iwd/BEXRI9R6YIKFi2Ba/RxeNcM5zlZ5tNHnZAkJmmiJh7+YLDvXiRqc6jYFkPwquaQ5HXhIXJgFJNqumdF4MjL/dvrO/mht5ABDLRxv2WZ3GgzuvvP92z3bsIknPGlv29qMVML6ClcFoT1GwjrFEh5Idlwa2rjKepFAAkG029Tp6/w/8FnrNcnZIl43pUuJ/2q7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbBYBfSeYIqbWLtOj6N1bQ7yO8cqqTtu13Aty/Txa6M=;
 b=ZI8jYgoDdml+7GZuXGmoaeSxOMVBB/ItO3PFqN5fhZK80iXNsCMvSmBL582K2uWqnHOplvdoLKfd96+X0+mJT4v03l/HpZqybCvzdHvOyBQ9cuZlRbkoCj4vMQ8lxTqjgLxkQMqboLYStj/pSa4mpP/R50OXmJBcJAxvM3h2kWI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN0PR10MB4837.namprd10.prod.outlook.com (2603:10b6:408:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Mon, 14 Feb
 2022 12:13:09 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:13:08 +0000
Message-ID: <f5bec3e8-3903-b3d6-497a-3c6368c37a1b@oracle.com>
Date:   Mon, 14 Feb 2022 23:13:02 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v5 1/2] kernfs: use hashed mutex and spinlock in place of
 global ones.
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
References: <20220206010925.1033990-1-imran.f.khan@oracle.com>
 <20220206010925.1033990-2-imran.f.khan@oracle.com>
 <YgJTndUA7iK/UIao@kroah.com>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YgJTndUA7iK/UIao@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY2PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:1:14::28) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ed516ee-f46a-4b90-eae0-08d9efb35cd8
X-MS-TrafficTypeDiagnostic: BN0PR10MB4837:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB48378D10B80343AFC4CA3CBCB0339@BN0PR10MB4837.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2G5ELJXIvt2uPosI6UYpHsTTAZDxoWf3sUVvGaNHb16WfZ1IkFE1FLjmmV7hBX3yGTm6yku000Bk8ZqIK2iTIxcWboQWughXSsh0ES01qhNuf6I6LVxHWKuwbIP1R3k/3JUkUVPp+xTh+3VC+2+0ix9XG1lknAvQ3Y4w042puQgu74D8iFRav2VzL61I75WZPBg3oEhBeKm5xFQWZQwLdUqacYKXRR33IGt8lOuLvti2NDBhDERKODxzptozmSr+IGlfEgjPcaBmYlnnm8iz982Eb/sJGMFqUQCQM7WItjJZ32F5Fc5M/3RbbCqpBjBms2fCf6k00CpsH0pW197ARL2kiTaFiJVRVKNHbaJlTovg5seoMdeDhojAuT1nqwoNx3pKfzck4vdcdwmwPSVnHOv09XbqtD4C3gt093yu5++KmKbav4kSDOnQsLEP2RjCn9VT7WyTnywn5vNeb1FGwYQhLJ7stZFn4Yu4w77NRffwhnIgg8VQCIXxLRZfFv7U2u+j6gWehBFi2bNgA0q7Ghm9Wu+BCQSIoQx6E8KRMLv0XLcJW4QObsfHK3aC+YVmoedIi/fHH7ZdmzmbQrDWQCLjgZOlSbnhey2jRFznAkanPthClUFeCYHcLDOiSaFW4frdMYU81q8dD5vrJVNIxeMc7QQzuJolsEnG1FVAxNsWwBmp7tMJtV9muMLB5ErbnDuHzEl1zXbWVs3+LHsahm/sR6hkjg799JAR/6yoyKNsBmdON8LsQFV4V6eJZxi7pUj+ikdhu7djSy6X+C+8EKiFhAF89fOrmtcQpBotpj8CMsreqC6jvwSdngh7dXq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(2616005)(83380400001)(53546011)(186003)(26005)(38100700002)(66946007)(66556008)(66476007)(966005)(6506007)(508600001)(6512007)(6666004)(316002)(6916009)(5660300002)(86362001)(31696002)(8936002)(36756003)(2906002)(8676002)(4326008)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDBaR281N011eDJGNytzbkVWZ0UzUit0eG5WK2hYSDJ6L2N3UDRMSmJjd1Rt?=
 =?utf-8?B?eTRJRU9YdTlFOVdlaHJaR09zSnVGNEF1TytxYUEvSjRDTGp6TjFNNEtjODZ2?=
 =?utf-8?B?WWpTMkZuZkxOM3V4UEUzV1MxdTA3cVphVXB0WVZEOXlXOXRVUmxpZHk1MElL?=
 =?utf-8?B?YmJwTGFvd3kyRWwwZUFyNUxLeFphcmZIei9ycnA4OVFpQnptQUIzMEROZ28w?=
 =?utf-8?B?eC9oREFjZ09UcVZMWWtCM1BucjNVNndHczMwZ0x4K0lKRFpRZE1WdUN2MU84?=
 =?utf-8?B?OHh2VXRBRm9tcEo2YTAwYmlVTlNBdFFZa0hTL1BMZEpNWXE1Q0plZk1memN4?=
 =?utf-8?B?bmh1KzFhT0hDQkhDNUpvcGdYOFA1LytwK29Td2FxL0hTdlNaa2dWTE9ocUhs?=
 =?utf-8?B?aDIxaUFYbThwU21URVg2YjBoaktuZkYra0tENW5nL3hLb1ltOUQvdkV0aC9Q?=
 =?utf-8?B?NUpvY1VzNElPS2I4ZUJsTmdQTjVzTWNha3RIaCtDUkJ0eWlIeDVuVlE1anll?=
 =?utf-8?B?VWUvYzVUc1cwN1ZvR0pMSElIcHNVZFZkcU80WHBuM1pjVWJXcCtvQk1xOXNz?=
 =?utf-8?B?ZHhSa3BPc3VmdXhnSTczTFBQdnVFc0hsRm9QUXFOc2tpOHJUdTgvOXI1QklU?=
 =?utf-8?B?YWQ5bnBHQS9zdkFMamhQczdCVGJQVllMY1lJUHFCbCtCbG9NK0VOeEU0YWlS?=
 =?utf-8?B?SnY5SDQyaXljZWtTeGU1c0FFN0F2UmFIejR5Wjl6Ti8vbjdxOHdqY1Q3bVY1?=
 =?utf-8?B?aWMxelgvU2Y3b3Zza2hwK0x0L2dHTTZxMmVYRTBka25oT3RwY04rd0tMRlVG?=
 =?utf-8?B?MzdjZGRnblA5MnI1cmhPNmcxY1g3OGRLMklLV1dCMk9mQUo2T2NsanhGUTRN?=
 =?utf-8?B?aThPZHdrNW9VdEVIM2FRKzFuTEFvdCtSa05RRzdpbXMzTzdBL0EvaEEzQmw3?=
 =?utf-8?B?RTZkNzlDRmN6Y0R6c1RMRHY3dTlIV1NDSjhRMjNVMFFHUjlFWFNEOEpvY1pG?=
 =?utf-8?B?UGl4VnVRVWM5ekpiOVNNQVd4L0RiaWdVV3cxQmo0aUZMYUc1RmdaYSt1M0Fs?=
 =?utf-8?B?VWxjb3d6aEhZV3V2cVVYUVp5eUY3WTBBanUrMXRyNndUZmx4TFBTN1ZIRkN6?=
 =?utf-8?B?YjgyR1IwckJpbk1OSHd0QTVudEdqb1RjSnVFRVkyWkg3TWhmMXR5M0xycnhU?=
 =?utf-8?B?bUxLdGJ5KzlIKzBNVUpxRkJ2eHJkbnF0RnF4VjZyZHQzMnZ6RUthZllWeFgr?=
 =?utf-8?B?Y0NrOTlvckNjWHhtS0Qrcm5CR0dkclFpVlVoaXdnRm54T0tOL3JtY2Vnczc0?=
 =?utf-8?B?MGdMSElERDFINTQwR2pwS2dUOUp6aldqUzBrUUhXNHh3NWJ0MHB1WkpvYnho?=
 =?utf-8?B?ZjZORXhPaFBabjFBMEZReG4zaHJDMXlZcnhCRWJaVG8wV3grWktiNkVGSmJ2?=
 =?utf-8?B?a251VTJzeUZKdTFVeVVMSkJpNHZUa25heWRaRmZZS2dDYk5FN0NQeTQ5SnRw?=
 =?utf-8?B?dmZCR3pIRHZXVTRmd2tjOTdLY29iNFJhNzdudGNYL0w2R1VjWlgya2dZOWhr?=
 =?utf-8?B?ZTI0R1FMdGlqL25NMkt0RTl5dTg2SUtCcE5aVTU4MEtTc2dMdjBBY3c0eUNG?=
 =?utf-8?B?UGRjU0hxWW5TKzR2MXY3RWNGYldtMVFqejF6eFNYSmRlV2Y4STBGelZDNGo4?=
 =?utf-8?B?Mm1nL3QyUlZMQW0reE9qOWNOemxaQTJMWkhPRHQ4OU9MNENsZHZBdjA1ckMx?=
 =?utf-8?B?NkVSZHpJaWJ0YmNWcm8yNVloR25jYTlKWjlRMTZkbXZzZmd0Y0w0S0NIMEZo?=
 =?utf-8?B?eVNGcTdSOFd4OE5ocVlvYnpram5iTGlhYm9GVjg3Rkc1bmpDKzlFWjUrQ1Vm?=
 =?utf-8?B?NmliNVJZd3hUT3Z0Z1RvME5rTTY3VUMzd2w2aFlkc2VOMDQ1aDBvYTR5M3Q1?=
 =?utf-8?B?RlN4YlhLT2FhMGU1VXpGRmVBZjZ3ZVdudm11ZlhWZlNKanliWGR5NXJ4VGs0?=
 =?utf-8?B?SmM4RTFGN0ZtY1E5R1lzMElhZDhUY3FXUTQzRld2Z29walorc0VPVWN6akdI?=
 =?utf-8?B?L3R1VDNtcDUySUFQNVhlb3FjbVpGeUo4YjFNMnoxclU0ckdtRkRLcDVhcFpQ?=
 =?utf-8?B?cjRXUVJmQ1g3ODhLUS9OYW1TNnppMHAySDJSTEVLWi9uY0lkd1pmT3M5QklX?=
 =?utf-8?Q?5N/BHQcpqlp7BMSpLPHUD08=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed516ee-f46a-4b90-eae0-08d9efb35cd8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:13:08.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0FAeZhyLBTfonv25CgRX8Yk+6ZDWtqOST5XONSNj9/vckprRkf76FTTJWKa4V1PGAdD890PvrDEBEkp0nVBdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4837
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140074
X-Proofpoint-ORIG-GUID: nTF9N8K0oUWSebbb06WHQaX96KjK_SKn
X-Proofpoint-GUID: nTF9N8K0oUWSebbb06WHQaX96KjK_SKn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,
Thanks for reviewing this.

On 8/2/22 10:27 pm, Greg KH wrote:
> On Sun, Feb 06, 2022 at 12:09:24PM +1100, Imran Khan wrote:
>> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
>> index f9cc912c31e1b..cc49a6cd94154 100644
>> --- a/fs/kernfs/kernfs-internal.h
>> +++ b/fs/kernfs/kernfs-internal.h
>> @@ -31,6 +31,7 @@ struct kernfs_iattrs {
>>  	atomic_t		user_xattr_size;
>>  };
>>  
>> +
>>  /* +1 to avoid triggering overflow warning when negating it */
>>  #define KN_DEACTIVATED_BIAS		(INT_MIN + 1)
>>  
> 
> Nit, the above change isn't needed :)

This has been removed in version 6 of patch at [1].
> 
>> @@ -147,4 +148,54 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
>>   */
>>  extern const struct inode_operations kernfs_symlink_iops;
>>  
[...]
>> +}
> 
> Can't you use kernfs_open_node_lock_ptr() in kernfs_open_node_lock() to
> make this use less duplicated code?
> 

Yes. I have removed duplicate code in version 6 of patch at [1].
> 
>> +

[...]
>> +	return lock;
>> +}
> 
> Same thing here.
> 
> 
Done.

> 
>> +
>>  #endif	/* __KERNFS_INTERNAL_H */
>> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
>> index 861c4f0f8a29f..5bf9f02ce9dce 100644
>> --- a/include/linux/kernfs.h
>> +++ b/include/linux/kernfs.h
>> @@ -18,6 +18,8 @@
>>  #include <linux/uidgid.h>
>>  #include <linux/wait.h>
>>  #include <linux/rwsem.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/cache.h>
>>  
>>  struct file;
>>  struct dentry;
>> @@ -34,6 +36,40 @@ struct kernfs_fs_context;
>>  struct kernfs_open_node;
>>  struct kernfs_iattrs;
>>  
>> +/*
[...]
>> @@ -90,6 +126,7 @@ enum kernfs_root_flag {
>>  	KERNFS_ROOT_SUPPORT_USER_XATTR		= 0x0008,
>>  };
>>  
>> +
>>  /* type-specific structures for kernfs_node union members */
>>  struct kernfs_elem_dir {
>>  	unsigned long		subdirs;
>> @@ -201,6 +238,8 @@ struct kernfs_root {
>>  
>>  	wait_queue_head_t	deactivate_waitq;
>>  	struct rw_semaphore	kernfs_rwsem;
>> +	struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
>> +	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
>>  };
> 
> I think struct kernfs_root can be declared locally inside fs/kernfs/ to
> keep other subsystems/files from having to see this structure, right?
> That would make this a bit less of a "rebuild the world" type of change
> and could be done in a patch before this one.

Tejun has suggested to avoid using per-fs hash table and take hash table
outside kernfs_root. So this patch is not changing kernfs_root and I
have left it in it's current place.
Please let me know if moving kernfs_root is still needed.

Thanks,
-- Imran

[1]:
https://lore.kernel.org/lkml/20220214120322.2402628-1-imran.f.khan@oracle.com/

> 
> Overall, this looks sane to me, nice work.
> 
> Tejun, any comments?
> 
> thanks,
> 
> greg k-h
