Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC224B7FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344529AbiBPE5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:57:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbiBPE5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:57:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F40FCA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:57:24 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G4ZLH5024709;
        Wed, 16 Feb 2022 04:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TvmmZU7Zz0rwh1KmQ573DW/KL+WiSej1R4XXBTWwtR8=;
 b=JnLRC4jaYLpUuw6k4kkgV71+v5W3YQL7aPeyg9G4uje9NwQzOpk1keJHXQx+era9ElxW
 kzufO6kkQEouHg3KrfVNjLRDpSZ1o8NHIWAWrnVu23NtFWqmFNh+KSeZGjL7xggb+OHH
 1gUorCusbWjZVE0zrjThxms3v0J4oBjCJkL8oMrQphyC1K8p4xEArnCvlEYSl0HUUhtz
 8WAP1UPOGsZCd/cN+m6uE1TjbciWyxPHIibhZ92vOpX6eyc0gC5RWIRnayuxOeMa1uGk
 ox5jT8Bpy4egs7yGQv2LONJk0rC0fkbG3lUcX69fd0MEn0zey5Vhb0ZPO9yAdBmnaPSV Tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncarht5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 04:57:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21G4uApB129427;
        Wed, 16 Feb 2022 04:57:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by aserp3020.oracle.com with ESMTP id 3e8nvrxkr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 04:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9PmVa53FXwHhEm953+8GZY8G5yBAa3lrb02KeXLqF1h4X/1bStnHASP/Cq5cWMwSFLSx9tEHMpI3ci+/07E1jcBSc9QSowTPj+8jr4gU5WmI1LZDwBqKqQ5AxYXWx8WcAKhvsrmq9UtT3vLqs+bqVfMefxTnZA6z15XYJO195b8Y6v1yvVFgOz3WG6Tcv6t7BfYDjM5rMjWLBE2t6l6DOvBWJIBihCvCwTWGaeBgttfTz2lfDWCDPa2+BWVoKFgVW/zn3FYqOP97O8qonYxDVNIhYjZWIRyXUdTLkAO+CuVr4K/IoiJFwqs5ElTUvRajjI75CVFtZKFhWkhlxxd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvmmZU7Zz0rwh1KmQ573DW/KL+WiSej1R4XXBTWwtR8=;
 b=INZZTwVzHFJURzfE4sdL7/d6m0JXXSaMQ2xnpaCodRn4Z7y2DKI1I0giXsqZfOPuCXcyCPaAeJqY98zx9P8BOYNrEW+MAqLlbG8z4Y6JZ/wJM4ElLb3Q4egE7ro2/uzskKOTyORY2dVcn65n3jE0vqvGNa3B1uqF4VSe5XQnvHO3Gbu5Q8yUVG0aIYYOcu2aznBMtXGwfauCtQDXPx+2LolOvcg99P6fEXVtnqHpnO98Z5Ea9pHl/KW+Ed0K4QoBHepL6SImnkst6fUlA0vJO0rrWaaxT01DbB5JkiKNJIs2V9tXGXkRbFWJbpGUpFq3Y6EL2ChmEsj9iWFEh1GCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvmmZU7Zz0rwh1KmQ573DW/KL+WiSej1R4XXBTWwtR8=;
 b=J+gQwouX5PAadsNx8IkPC9CZzJocRO9FG4l0dyeKqWv/+VJ8EPddJTtbQ0QGhbj7fJMRj90zKggFRaQfjN0XpdC85vuKXhL+MlxiZLz5R2Icf5APmtmYzv+v4VcVsKFwp3bHlX1SMitSgk3vnHgE7K6Cf43yL6uCpz04JWnMc/E=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by SN6PR10MB3056.namprd10.prod.outlook.com (2603:10b6:805:d9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Wed, 16 Feb
 2022 04:57:17 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%7]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 04:57:17 +0000
Message-ID: <bfdef75d-4343-2734-2723-d8546df37c69@oracle.com>
Date:   Wed, 16 Feb 2022 15:57:09 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v6 6/7] kernfs: Introduce hashed rw-sem to replace per-fs
 kernfs_rwsem.
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
 <20220214120322.2402628-7-imran.f.khan@oracle.com>
 <YgxXh3clQqpxUPba@zeniv-ca.linux.org.uk>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YgxXh3clQqpxUPba@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0174.ausprd01.prod.outlook.com
 (2603:10c6:10:52::18) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 683f1e81-1dfe-49b3-1101-08d9f108ce58
X-MS-TrafficTypeDiagnostic: SN6PR10MB3056:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB30565A8ACF8738FBFD8CEA99B0359@SN6PR10MB3056.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kl7eFF3cy3AuF4ksEd2moB+cG9rprk+hTkwAdueai3QKpKkIJSMp+IFp6MpFH1wNbGWLWF6IDbz4OHuLxILpMA4U6uRwXKiydDyOyq/WwIWmtI+VUollZxCwOYv4qX540XK2QIji/rxhETJYYOYYnWlBnhrkM/SqcLdr0y5Qt/d9wnOSbwslYVXOD+RupSMihimbWrXmrcalqojrarK1g5+sE3DRjOu3NkzLbW61vTGne9CPHWlEr74xE89IzgxZIfjpiNcKPBcDYZswnYPgUeSqYnGvbBeP84b8YTMKzatLmg0M9VaR5Sy798cps9oL77SwmbiiD5MxZn1R5Jc4ly+yOf7LnaZ6xMKgqr56RURugFsHERCEu8wpQbrAjwiQ0bDuBQ5OpBUqtSTVulUm29yUc19OYC6hc4iL17Uie5DJBH0T4n+E04Z3na6NEhJ1zwDkQWGD/QQNPhrAyhXlWHc9bgAcOE6k0IkkrKNOXfr8QZhR5q7wJAz2BuVY10BSowzUaNXpZ31twdgaC0ihft2yapdcJqaDj0txtuNR4pu8A+q1pInrwKqlQsw05YmQqd6gew+sSlBkt1pufZRiXVVmuqudGKdIsAkzV7KPz5I5JcVBpA0pMor+G0ZG2IrLOMgkz/z3NR15BeGTLdbKyIhq4l8W0ifACx8b0xep444GmkFPaXBsTOwxeBRyjlEBlsCAgdmy7ft9MzRTve7ZN2ZnkRdoPG4/K3rWiyhykpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(2906002)(6916009)(5660300002)(186003)(30864003)(38100700002)(26005)(2616005)(4326008)(66556008)(86362001)(66946007)(6666004)(36756003)(6512007)(6486002)(6506007)(83380400001)(53546011)(8676002)(66476007)(508600001)(316002)(31696002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCszQnd3MlFncjBxVmxNL1NYYjdFVjVXSVN1eFdpQkp4end0bkQwZ1JWUDFX?=
 =?utf-8?B?OEJKSlpJNVdWNEJQKzNENzRDbmVWcEs0UWdMVmdqeWkrM013K2R4bVpsRDls?=
 =?utf-8?B?TmZlTHMySUsxVTNMSWFXeHhURWxuTmFPTDlzV0t5MVZEdnZKMHdCdzE2MFhx?=
 =?utf-8?B?NFlkRHVhZ01vM1ZYR3N0MDNqK0M5KzVKRStvTTkvbDBWdmI4RjZBNDQrQTNR?=
 =?utf-8?B?ZTMzUUplZ1A3WTBQNkVJODhwYzdaVXZtWUVocS9vb3lIUCtqOVc2aVI2YnYr?=
 =?utf-8?B?bHM0LzhLdjdyTUdnd2g0dlBYVXorbnd6V0lSbEI2ZzJqRy8wdnh6Yll0c0ZD?=
 =?utf-8?B?S1NxT1YyVkk4ZGZCeEJ0eC9UOXd4MW81RzluZXMwNkt4N0FGWk5jUE1iYnpQ?=
 =?utf-8?B?VUFQUVYza21wdnh2ZVMrS2Y5L3RSdWxlMnJZL2V3QkhjS3VrajdjNDBUR2Q3?=
 =?utf-8?B?ejRQRWdObm5uTW11QjR0bG9LUCtXK05qTXJpbzdJak1ZREZEc1RER1JGMUVh?=
 =?utf-8?B?M1lEYnNCOUx5b3ZBUmJidVZnU21NVVJpMHpLVWNLZ2N3Qkp4VldFV2N2QUt5?=
 =?utf-8?B?amtuRFFFdm9JU3paYnkwakNEUGxUZ0xFNFJ4bkdiZ2JnNFltTmVUbWswdjdF?=
 =?utf-8?B?T0FDYzU2SWVQRmkwU09GcGZSRnVScXFabnVicCtZc2xzdVduZnQ4allhbCtM?=
 =?utf-8?B?ZUFOUCtTalh5Y0tYNzB1WDAyYk1KWS9lVXdJdExTd2ozK24rSXdHcVpSc0g5?=
 =?utf-8?B?WXE1M3Z6aW5nNm9FSkpoUytvK0ZRZlFyM2JRejFVSHZzTy96YzJ1RUkvYWt5?=
 =?utf-8?B?dU41K2pDcXo4akFNNnhINnhJOHZWYUU0dktXM3pRR2t2cFg2ZkJTZDBtYm5O?=
 =?utf-8?B?Nk9aVnJJaWg5KzdrNjZ2djZWYm9uK0F5ZHBLRG1mUEM1c1J4N2VGZ2FxNHY0?=
 =?utf-8?B?d09nSkVLMUk2bVVyU2p3dVBJbk5lVXJnVVBpdFFtUFJtZmFYNmlyeTV5U1VG?=
 =?utf-8?B?VmVyaGtTb0kyRDlDM3luV254UHJoQ3NxZGdIQ2dpMGp2SkE1SlByN3dDWkVT?=
 =?utf-8?B?NmtXR1RPZVdWb0FMTWROd3JMRmJqeGNsWDVpazh3MUxTbEdBK3dzdVlhb1Qy?=
 =?utf-8?B?ODJKTGdJVGhFM2w0NmR3MTA3SlBQRkszQ3A2bGEwdHFJei8ydlVIOGhqRWZk?=
 =?utf-8?B?TEx0cThBc0tFbDFjbXJFbmxJZ3pCY0tsUFJDeWxITklBOHozZDZ3SytOaURo?=
 =?utf-8?B?ZnNpNFc2L2dpaGpRempoTHNvZ1hSTHJ4L2Q2dlNkck9jTyt5M1FPd1N3dkhQ?=
 =?utf-8?B?SWlwbmlHNndlNUE0cVhJTnpvc0RBLzJnaVl1cmN0UmtqVm82OHVlWXBWTkxK?=
 =?utf-8?B?L2hNak80NWFhbmZMaHVNbGw3N2d3emN1dUpCdHlWNTBWeGFDWjNjL0xNLzQ0?=
 =?utf-8?B?ZHlSZUVZaXZxS2tCUDlQUU1CTzR1dytLRmF5dmRDb3M0TWc2K2cwWWQzRnlK?=
 =?utf-8?B?WnRqVkdydGowemo4Q0NoblZISkZzcmlOMkpjcGxJQ240V0dvbDJOaDVqWkJH?=
 =?utf-8?B?WXBKMVFRaThuUGxULzlCWDFpT3lqcGpZNXplZWNYSStQK0tscXhha2Y2NlRZ?=
 =?utf-8?B?UWlpdjc4U0FiNHNEUGVreWRISTAzRVRLTlp5WHVGQ2IxV2hOSDByRytTV3h1?=
 =?utf-8?B?TXBaR2ROem9aeXcrWHJnT2tyZFR0eThrdENqYWFDQUhqaTNiWU8vbFF0ekdP?=
 =?utf-8?B?YzF2ZDg1aWNncUQwTFNpeUF6UXdCTjhFYUs3a3FsRDRnSHRsZis1azJ4TGdD?=
 =?utf-8?B?TjczS3FaS2RFdGh1dmdNVENPK3JwcktoUTd2RmFLYWlYLy8yUVdYRE1oUU1z?=
 =?utf-8?B?RHdBeVhNbVg0SHBvVWFGRjFIc3ZDbG42QlVtWWpSOVg0UmU2QWJCZjNCSmE1?=
 =?utf-8?B?cGJGM2RPMDFQaFlISzNYODl2TmxiNDhpdk0wSmZJa0MwcGtZNEZEWm42dlZZ?=
 =?utf-8?B?QmcxYUIrUUhBVzRkSWwrSTljbnUyV2k5Syt6TkFyekRzUTlsRjZJSkExMDBt?=
 =?utf-8?B?eHYvVkpyOVlyWmgrclNxVDFKSGhjYzNtbjhmejlRdGg5SllEMEJYdlFqYXA5?=
 =?utf-8?B?a21PN0V2dnozM1ZjdVkyN1J2dmlCdUdUazEvNTBPbXFZcThUSFhEb283Q05O?=
 =?utf-8?Q?xilwEiMEmH3e3/KuN2mdtGo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683f1e81-1dfe-49b3-1101-08d9f108ce58
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 04:57:17.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FmxnyU35pTF4TnZx+BAdNNIR7uLlCP7L9gOuco7haFB7fNs3bHa+IEOH10q0olMI+dJrwcl4OOEeNv54YbJHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3056
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10259 signatures=675924
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160025
X-Proofpoint-ORIG-GUID: JlhsnSNykCcDBTyGtS381YFagXAoZAkG
X-Proofpoint-GUID: JlhsnSNykCcDBTyGtS381YFagXAoZAkG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Al Viro,

Thanks for reviewing this.

On 16/2/22 12:46 pm, Al Viro wrote:
> On Mon, Feb 14, 2022 at 11:03:21PM +1100, Imran Khan wrote:
> 
>> +static inline void down_write_kernfs_rwsem_for_two_nodes(struct kernfs_node *kn1,
>> +							 struct kernfs_node *kn2)
>> +{
>> +	struct rw_semaphore *rwsem1 = kernfs_rwsem_ptr(kn1);
>> +	struct rw_semaphore *rwsem2 = kernfs_rwsem_ptr(kn2);
>> +
>> +	if (rwsem1 == rwsem2)
>> +		down_write_nested(rwsem1, 0);
>> +	else {
>> +		if (rwsem1 < rwsem2) {
>> +			down_write_nested(rwsem1, 0);
>> +			down_write_nested(rwsem2, 1);
>> +		} else {
>> +			down_write_nested(rwsem2, 0);
>> +			down_write_nested(rwsem1, 1);
>> +		}
>> +	}
>> +	kernfs_get(kn1);
>> +	kernfs_get(kn2);
> 
> 	What's the last bit for?  Do you expect the caller to grab that,
> then drop references, then pass the same references to up_write_.....?
> Explain, please.  Is there any caller that would *not* have the matching
> up_write_... in the same function, BTW?

Every caller of down_write_ has a matching up_write_. I am grabbing the
reference for cases where node gets deleted between down_write_ and
up_write_. For example currently kernfs_remove invokes
down_write/up_write on per-fs rwsem. This change is using rwsem
corresponding to kernfs_node being removed so we may get a situation
when kernfs_remove --> __kernfs_remove --> kernfs_put results in
deletion of kernfs_node but subsequent up_write_ from kernfs_remove
ends up using freed kernfs_node.
> 
> Just in case - "defensive programming" is not a good answer (to just about any
> question, TBH)...
> 
>> +static inline void down_write_kernfs_rwsem(struct kernfs_node *kn,
>> +				      enum kernfs_rwsem_lock_pattern ptrn)
>> +{
>> +	struct rw_semaphore *p_rwsem = NULL;
>> +	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
>> +	int lock_parent = 0;
>> +
>> +	if (ptrn == KERNFS_RWSEM_LOCK_SELF_AND_PARENT && kn->parent)
>> +		lock_parent = 1;
>> +
>> +	if (lock_parent)
>> +		p_rwsem = kernfs_rwsem_ptr(kn->parent);
> 
> Er...  And what's to prevent ->parent changing right under you?  For that
> matter, why bother with that at all - what's wrong with your "lock two
> nodes" primitive?  AFAICS, your current series has only one caller passing
> that flag, so...
> 

Agree. "lock two nodes" primitive could have been used here to make sure
that I work with same parent. I will have this change in next version.


> Note that ->unlock_parent thing is also dubious - the matching up_write_...
> for that sole caller is in the same function, so it could bloody well
> choose between single-up and double-up on its own.  Would make the whole
> thing simpler...

Tejun has raised similar concern in his last feedback and I am working
towards making use of "double node locking" primitives for cases where
both parent and node need locking.
> 
>> +/**
>> + * down_read_kernfs_rwsem() - Acquire hashed rwsem
>> + *
>> + * @kn: kernfs_node for which hashed rwsem needs to be taken
>> + * @ptrn: locking pattern i.e whether to lock only given node or to lock
>> + *	  node and its parent as well
>> + *
>> + * In case of nested locking, rwsem with lower address is acquired first.
>> + *
>> + * Return: void
>> + */
> 
> ... and this one, AFAICS, doesn't need ptrn at all - no callers that would ask to
> lock parent.

Sure. I will get rid of this in next version.
> 
>> +static inline void kernfs_swap_rwsems(struct rw_semaphore **array, int i, int j)
[...]
>> +}
>> +
>> +/**
>> + * down_write_kernfs_rwsem_rename_ns() - take hashed rwsem during
>> + * rename or similar operations.
>> + *
>> + * @kn: kernfs_node of interest
>> + * @current_parent: current parent of kernfs_node of interest
>> + * @new_parent: about to become new parent of kernfs_node
>> + *
>> + * During rename or similar operations the parent of a node changes,
>> + * and this means we will see different parents of a kernfs_node at
>> + * the time of taking and releasing its or its parent's hashed rwsem.
>> + * This function separately takes locks corresponding to node, and
>> + * corresponding to its current and future parents (if needed).
>> + *
>> + * Return: void
>> + */
>> +static inline void down_write_kernfs_rwsem_rename_ns(struct kernfs_node *kn,
>> +					struct kernfs_node *current_parent,
>> +					struct kernfs_node *new_parent)
>> +{
>> +	struct rw_semaphore *array[3];
>> +
>> +	array[0] = kernfs_rwsem_ptr(kn);
>> +	array[1] = kernfs_rwsem_ptr(current_parent);
>> +	array[2] = kernfs_rwsem_ptr(new_parent);
>> +
>> +	if (array[0] == array[1] && array[0] == array[2]) {
>> +		/* All 3 nodes hash to same rwsem */
>> +		down_write_nested(array[0], 0);
>> +	} else {
>> +		/**
>> +		 * All 3 nodes are not hashing to the same rwsem, so sort the
>> +		 * array.
>> +		 */
>> +		kernfs_sort_rwsems(array);
>> +
>> +		if (array[0] == array[1] || array[1] == array[2]) {
>> +			/**
>> +			 * Two nodes hash to same rwsem, and these
>> +			 * will occupy consecutive places in array after
>> +			 * sorting.
>> +			 */
>> +			down_write_nested(array[0], 0);
>> +			down_write_nested(array[2], 1);
>> +		} else {
>> +			/* All 3 nodes hashe to different rwsems */
>> +			down_write_nested(array[0], 0);
>> +			down_write_nested(array[1], 1);
>> +			down_write_nested(array[2], 2);
>> +		}
>> +	}
>> +
>> +	kernfs_get(kn);
>> +	kernfs_get(current_parent);
>> +	kernfs_get(new_parent);
>> +}
> 
> Holy shit...  And _that_ is supposed to be inlined?  Complete with sorting the
> array, etc.?
> 

Sorry about this. I will correct this in next version. I have got some
suggestions from Tejun about how to make these interfaces more compact
and I will make these multi node interfaces non-inline as well.

> <looks at the callers in the next patch>
> 
> -       root = kernfs_root(kn);
> -       down_write(&root->kernfs_rwsem);
> +       down_write_kernfs_rwsem_rename_ns(kn, kn->parent, new_parent);
> 
> This is rename.  The very thing that changes kn->parent.  Just what would
> stop *ANOTHER* rename from modifying said kn->parent while you'd been
> sleeping waiting for that rwsem?  It's not even a narrow race window...
> 
> I could believe that similar question about stability of ->parent in
> case of KERNFS_RWSEM_LOCK_SELF_AND_PARENT handling might be dealt with
> by something along the lines of "nothing is supposed to rename a node
> while it's fed to kernfs_remove_self(), which is the only user of that",
> but here we definitely *can* have racing renames.
> 

Agree. I missed the point of changing parent during wait of rwsem. Could
you please let me know if following approach is acceptable in this case:

1. Note kn->parent
2. down_write_
3. After acquiring the rwsems check if current kn->parent is same as the
earlier noted one and if so proceed otherwise invoke down_write_ again
as per current kn->parent.

Once we have taken the rwsems and found that kn->parent did not change
during wait we can proceed safely till corresponding up_write_

Regarding kernfs_remove_self, yes that was the idea but as mentioned
earlier in the next version I will use "double node locking" primitives.


>> +/**
>> + * down_read_kernfs_rwsem_rename_ns() - take hashed rwsem during
>> + * rename or similar operations.
>> + *
>> + * @kn: kernfs_node of interest
>> + * @current_parent: current parent of kernfs_node of interest
>> + * @new_parent: about to become new parent of kernfs_node
>> + *
>> + * During rename or similar operations the parent of a node changes,
>> + * and this means we will see different parents of a kernfs_node at
>> + * the time of taking and releasing its or its parent's hashed rwsem.
>> + * This function separately takes locks corresponding to node, and
>> + * corresponding to its current and future parents (if needed).
>> + *
>> + * Return: void
>> + */
>> +static inline void down_read_kernfs_rwsem_rename_ns(struct kernfs_node *kn,
>> +					struct kernfs_node *current_parent,
>> +					struct kernfs_node *new_parent)
> 
> <tries to guess what use could *that* possibly have>
> <fails>
> <looks for callers (in a different mail, damnit)>
> <none>
> ...
> 
> TBH, this is rather uninspiring.  I can easily believe that you've got
> contention visibly reduced on a benchmark.  That'd only be interesting
> if we had a clear proof of correctness.  And you don't even bother to
> discuss your locking rules anywhere I can see in the series, cover letter
> included...
> 

I have run my tests with lockdep enabled as well. Could you please let
me know if there is something that can be done as proof of correctness.
For sanity of patches, my current tests include LTP sysfs tests, CPU
hotplugging and cgroup access/creation/removal. I am booting oracle
linux as well which involves cgroupfs access(via systemd). If you could
suggest some other tests I can execute those as well.

Also regarding locking rules, I am not sure where to mention it. If I
put accompanying comments, at all the places where I am taking hashed
rwsems, to explain why lock corresponding to a node or corresponding to
its parent is being taken, will that be enough as description of locking
rules.

> I agree that sysfs locking had always been an atrocity - "serialize
> everything, we can't be arsed to think of that" approach had been there
> from the day one.  However, that's precisely the reason why replacement
> needs a very careful analysis.  For all I know, you might've done just
> that, but you are asking reviewers to reproduce that work independently.
> Or to hope that you've gotten it right and nod through the entire thing.
> Pardon me, but I know how easy it is to miss something while doing that
> kind of work - been there, done that.

I understand your concern but I am not asking reviewers to reproduce
this work independently :). If I can get to know what things can
be/should be tested further in this regard, I can do those tests.
Since the start of this work, I have been also running my tests with
lockdep and KASAN enabled as well and those tests have flagged some
issues which I have addressed.

I will certainly address your review comments in next version but in the
meantime if you have some suggestions regarding testing or description
of locking rules, please let me know.

Thanks a lot for having a look.
 -- Imran
