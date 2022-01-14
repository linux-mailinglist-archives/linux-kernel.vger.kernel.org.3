Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61CA48EEFE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiANRI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:08:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52460 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243708AbiANRI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:08:26 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20EFvZls005696;
        Fri, 14 Jan 2022 17:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cU2R+YPVYqvyFggU86iq/c2pWG9uIt/g8Rx/L+I82kw=;
 b=ZDRE1eBWU1bGgvMJ+aO0eEDnU7vLNCUpluI0N5sGGxqR1sgPxq1NGi+JkjUoqe3AVHUO
 5fLbkVIxhNHkf53Qa58jE2yxiJizi8G3i/c5xGj9wNbLxOgTXdHyqnnUglTZItefqHOB
 mAfeGwwuctCC//xjZ/5u+KNGjkbn7JiMavbBcmbh5mlUV5ZbJiVLZNIMFaFdNQrTuRkQ
 rQXL+M+UPFL7WjqZEh4o6z6IctJtuovJ64hBfs+/ILA2mLL7kYtdnAX1qZe6EJoJeijp
 ZGBYpdUz15PY4eAC2VR/BnmS8//tu9eCrUK+BZ+Gv9a6oDJGbew6zqVRrlGAf7DYvE4X JA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djkwjbyyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 17:08:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20EGkK0B152479;
        Fri, 14 Jan 2022 17:08:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 3deyr3tq96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 17:08:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebDpKiX0FDKcf/h8RthEnB/4td0JFb+Qw/r+JOGMTsqW0G7Uz0FlRjV/R0GJpisOTizVodfzNq7O59LSA+lJ10DNTdaUlN8SQSphSvDRnFnYNJXsc7FhTgrwaYV3Evea+Rbgo1hWmWbk8HfJvLpIG2do+zwgxUrhb+KO1reuESsgaRsTYXscZxJvkLlpg5Bn6WaqMARme8vp8v9bQcZvv3DAqAv9LsmxTpDVt1+Be+JCqWEd8p+4qwd2p9qQ4z17CiDXqE6O4RxsJ6YWysE7+fJ7PPQdfHwfudg4g7+7fElrBgZYXjklPa+sB4wlCsTDbfaOU0fWG8K8fuWGHSVJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU2R+YPVYqvyFggU86iq/c2pWG9uIt/g8Rx/L+I82kw=;
 b=IYNtc4XXAfcZ+lhB4J01786yoAo4pxvDtrQEnnsi9sG249/0yM85lwi81g7DwZBfDQaKffN3Nb5GEmzbZei4uKgtcsf7CM/ApEloXuadmz0msn2NN4eaegeCksgEmHxQq7ri5tQzFj5VoOseIKEN9qJMmHHxRiCELmJtLWXdJzvKf0stjozJCR8ysxrKxfgIH7UCzdhrfrLBdoT3xB/pBBCZY2ME1PDkdRlech0iVA3OyDFrRmFU6t/s1Q2ARd2V4IBHgxWfu9YeXnPeQQr81ShfNIEJcNbBuGs12NedXXbWZOQ6XP/OebazZzGWhWKCjS3/v9S2SRVj2EjbSxw9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU2R+YPVYqvyFggU86iq/c2pWG9uIt/g8Rx/L+I82kw=;
 b=GgWSIhOSjB5suIJwSr2kGY3Ru2pkAsr1nUuA3NRHtw9JOjHCpXzsV70+ylbcJYxT1f/fnKOcHSv8a+zjsNoBuVQoFc7a62irJm/1OmDqcGaij2jqtGlHzZwozvEruNzCU3hak3ANstDACXVX8QJl2Dlwd+lnT7pIanbyk24ckBo=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB3406.namprd10.prod.outlook.com (2603:10b6:208:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 17:08:19 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::183a:8dd0:6d9f:596f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::183a:8dd0:6d9f:596f%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 17:08:19 +0000
Message-ID: <84861be0-519a-233d-9c6c-482f12e33328@oracle.com>
Date:   Sat, 15 Jan 2022 04:08:10 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v3 2/2] kernfs: Reduce contention around global per-fs
 kernfs_rwsem.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20220113104259.1584491-1-imran.f.khan@oracle.com>
 <20220113104259.1584491-3-imran.f.khan@oracle.com>
 <YeBWWWa030xTftWe@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YeBWWWa030xTftWe@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY4P282CA0001.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::11) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 817ee782-d316-417b-dd7e-08d9d7807636
X-MS-TrafficTypeDiagnostic: MN2PR10MB3406:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3406C5785E282F065D3E550AB0549@MN2PR10MB3406.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Qdx5wMKQDGz4+wRkljy/c0v59uLx0zlatDFtIzFIxsx1qdy24+zeq6kJopeRzip7uzbdrlUkYLQqd7hXRaVO/iUglz1tamO0oxDBSj6mZz/tTTZq2Nj9uo8tC4CtD83Nh3cpzfV/X8ioki+eWupLhmI+AfokiAvWIyqsAmFqo/N1+VXA9OKYSgGo0qa2MhA545912rrHPlwI2o32UP8Yydi4FYXIqfXtJvGCM6KKJv/3fhIyEu3q5lWL6/6PztZ3xkDNxsU4zMjNFXkjvpjban3OymTnAtjS8fvQqSBI/StPz+o9egO+Qq/qarSTzwxbVNssvlp2dJ1OIG9pUVf/ohALNLoDVWkhyg80NJ2qLPXdJfik0h0NCXXDnnmTJ1IUEQEtaiKtT66smM1sgFAso3ajKwS0Hvjf8D4JToWNf3iX+f07EFHZE5Gl9B4hfFemeN2iOuKJuZm5dhnkQNr1HOJf5kkpZ5T3ZB4BCURhopcuFuvqc1WrZ/loUTkIRQUazreEUQUjmtCvuKba5w5cdycC6Lc66AQCmdKy4jYV4Nw46zkEkaXkzTq3iJuAw5ICY/g5BaBqhaZvPT2Vof0R1ZqwgFKm80c1MkAsN9VEkSUshhmsdRnJiboObDFRE2d6uMIz0WXlHtB6Ilv3DU6Y9AIdGm0LMKBo//3+Muku2ah7AKTQ1B3h2YDG1CgFpsQ8xDd1pjwAAA8pWy2yHXIn6gHR1f5DlEfbyhQcM90OJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(4326008)(31686004)(66556008)(66476007)(6666004)(6916009)(2906002)(508600001)(83380400001)(316002)(86362001)(186003)(8936002)(66946007)(26005)(31696002)(6506007)(6512007)(36756003)(5660300002)(2616005)(8676002)(53546011)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW9YZ0NiNnZvSTdyZlZ3ZGJxekh3VGRleTQvekQ2bDQxVCsyUUVOL2FjL3Qr?=
 =?utf-8?B?QWM0azNnelBTdi8yR1AxWWU4UTk3c3RNNlNwQnlGTk4zYWUyc09McFBUcUFO?=
 =?utf-8?B?eWJmdC9JSzBYbUZVc01VLzQ5bkFmWStpNWp6Vm9sSmk2bDlaK0RoUnQwZHVR?=
 =?utf-8?B?dmVoR0tGUXpNa29XUjQwekRmUHJlbThYVHVFVE9vL2dNcWRvdFN3MGV0T3JH?=
 =?utf-8?B?bEttUG4rTlBGcWp0NUZvYkRNOGFXa2dOQzlFZmRrSTlnQTVkcktsQ3d0Nnpp?=
 =?utf-8?B?T3daTjMwNTNTUGhXMGhvMENUdkdsSVlIWHcxYWtqMy9GeTBqanBGVkc4WDlr?=
 =?utf-8?B?bjlXYTRNZ3c2clYrMThoN2phaHFvZmhHYmxQWVJMNUxsZ09yRjl2c1Erb0Rj?=
 =?utf-8?B?TFFnNUVLN1dUOFl5bDZMRGp0Rm9UcGVBeEMzZDl4MDQwcVowalNGYUNPbFVR?=
 =?utf-8?B?b3lsVy8zc09ydi85cmIydml2S0RnL1pDM0V2N1M3dWdQVUY5S3Y5RmFSRFpS?=
 =?utf-8?B?U2wyb0QxcC80OGRCS0FzWHZzNjR2VjZoUDlhMXJZYlN4YnV4U3VUVHBwY3E5?=
 =?utf-8?B?YUx3NHdPOXNXNm8xa2xpVEJWNnkwQkp1clhCZlhzQ0pjaWw1cXJrNE9FbVVw?=
 =?utf-8?B?SkU2cTBqVVJ2WndYdzJXSzdPVG5KWFduR1BFeFZpcDFkYzJuN04zYzJVRnNK?=
 =?utf-8?B?R0lNZzdycnZVb3ZiYmlWK3dTL05rL3ozUDlsTjh6djBuWWdsQWFmREpkbzQr?=
 =?utf-8?B?WGF6anYwVkVQZWc4WGd0aG1ZK1VwVkw4b1FKMmgvUVl2TGZVRlQwVnNUMk9s?=
 =?utf-8?B?Vi9tS1RUajM5RlZ1U3psRlQyejdDakJHQVROYjNiMkNVcjNJZk1ITVNyOTRU?=
 =?utf-8?B?dzdDY3FRcGxFZHo5Tk0vL2V1MG5VV0tPRENJRjFIZXUrOGlRRmoyRUpmVEZY?=
 =?utf-8?B?RkxLS0JHdmNab3JCUU1PQ2RmSm03SkZKTHZNZkNYNFZwZjZwRTJOYk54S0FQ?=
 =?utf-8?B?ZlJhTllWMHJNZXR2d0tUQ1U0WC9iUWtHaWJWdjV3QlZMVklUTU5Sd2NZWllS?=
 =?utf-8?B?aklUTVd1RXhwKzdxck5VaXZ6UGdnN2d4c0lINFlvOU1KMlY2SXhyZTd0MEc3?=
 =?utf-8?B?WTZHVVN4QjRRb01GeTkxbGZhY29MN054NS9CK0lrdzFhQ05PNWdLQnhjd0NG?=
 =?utf-8?B?WTFCajk2cU1nSDJick1BMWxCSU1nVXlTZ0JSZmNlM0pqR0g3ZUJJTm00VXB5?=
 =?utf-8?B?T3VSMUFiTURVUGFTaGxNeXFHRUwyNURpWnpFeVZ6aXNKQXhxNWp2SGVIaldx?=
 =?utf-8?B?Z3BLUU80M1dHOXRQdVFnK0JTME1YWTJuZEVXTTR1eU1FUmlNWFA3K1dpa0Zk?=
 =?utf-8?B?YjBqbDJ6TXBZek1FNUtJU1QveW9ZTURmU2NIMVRkLzNjdE9UU3I4UXlhZWMv?=
 =?utf-8?B?WDIwNE5YN2VxUkxQYU5CT0hGVVRFUmVJNS9tZzBBazVUZjUvNmFpcmxqMFIv?=
 =?utf-8?B?cmRxMU90YUFmZFRESVZhbVhoZmtZclNRWGNNS1c1UUNpd1BmVytPVnB6RWwv?=
 =?utf-8?B?aFNZTzg4cTMrOW05U2pzZGFmVHowQzJHd2d5NzFWWFFhSGRjekRPTGpUcUR1?=
 =?utf-8?B?dWs2amI2Vlg3L0JCczJRRmlTWmtJNXZQOEtMSTR1SWRSZWlZTjFSb3Z2NmI0?=
 =?utf-8?B?QnMrTC92SllvSlY2QWorOTR2TW9XZHgvS3YxU0Q1L1VqWDg1TUVyQnZMbkZL?=
 =?utf-8?B?NXQ3TndEUkdvRU9YSFZGMTJqRWp4MDNVbmxBUktKT2cvNGFOYjNMTThCV09n?=
 =?utf-8?B?b2NhSVZFZDZPNzZYR2t1Y3Rpc3UyejZZL05zUUpwcjdmUHhzY0VUTkc2cVRL?=
 =?utf-8?B?dHBKR0owaDNKdkNXZmpPNVp0d3pGTGU4eExtUUthdUlPbHpraHZoQnp1ekZy?=
 =?utf-8?B?VG50bDlMM0poS1ZXZU1XbktONnpLSW5SMHdlc0IzYndGY053ZW9zV3lZa0ND?=
 =?utf-8?B?WjkxL3ZUOVpGV2YzcWd2OW5UTitBNHBJNmxELzF3cTJHWjBvaHd4U1hjK2cz?=
 =?utf-8?B?MzRBdkh4cXdUNUQ3RkY1QTZjS3FRL0hZUTBVaGpTbnJMRDFrUEtWekltRlRJ?=
 =?utf-8?B?NXN6dHNwMGlyeEFnNENFajhvejRGRzFieXRsSisrZGh2T3h5dVl1MEVEbjBQ?=
 =?utf-8?Q?t+yBIt/z4Y38JNZZnXdcJoY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817ee782-d316-417b-dd7e-08d9d7807636
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 17:08:19.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4aJYuCerPRuwWZxv4gbgV0oqKMjbQSGIREnLHxACosNQQQ5Hu2UeeJYNDG1hqyWlLMFI3yi+cqkFZpyQEo7SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3406
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10227 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=647 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201140109
X-Proofpoint-ORIG-GUID: RGpAeyydlHbku-eiMluwae_B9Gtwphup
X-Proofpoint-GUID: RGpAeyydlHbku-eiMluwae_B9Gtwphup
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

Thanks for the review.

On 14/1/22 3:42 am, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jan 13, 2022 at 09:42:59PM +1100, Imran Khan wrote:
>> @@ -748,11 +749,14 @@ int kernfs_add_one(struct kernfs_node *kn)
>>  		goto out_unlock;
>>  
>>  	/* Update timestamps on the parent */
>> +	rwsem = iattr_rwsem_ptr(parent);
>> +	down_write(rwsem);
>>  	ps_iattr = parent->iattr;
>>  	if (ps_iattr) {
>>  		ktime_get_real_ts64(&ps_iattr->ia_ctime);
>>  		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
>>  	}
>> +	up_write(rwsem);
>>  
>>  	up_write(&root->kernfs_rwsem);
> 
> Hmmm, so the additions / removals are still fs-global lock protected. Would
> it be possible to synchronize them through hashed locks too? We can provide
> double locking helpers - look up locks for both parent and child and if
> different lock in the defined order (parent first most likely) and record
> what happened in a token so that it can be undone later.
> 
I have made changes inline with your suggestion to synchronize
addition/removal through hashed locks but so far I am not using tokens.
I am currently testing these changes (so far no issues seen). Before
floating next version for review I wanted to understand the reason
behind need of tokens. Could you please elaborate a bit about what needs
/ may have to be recorded in tokens. Just one example will do. It would
help me consolidate the next version of this change without overlooking
something.

Thanks
 -- Imran
