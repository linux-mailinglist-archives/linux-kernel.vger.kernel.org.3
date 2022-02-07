Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2364AB63B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiBGHuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238895AbiBGHoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:44:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ECFC043181;
        Sun,  6 Feb 2022 23:44:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21752HvA011697;
        Mon, 7 Feb 2022 07:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=JmNj+ZQZf4vAIfUzyv3cH7wFzzCbL5ULkRnpIZ4W58Y=;
 b=UdLOikwk6RQN7Ki0SPbwYUlFeq7qPlQQKPMSRLwzFmenorD9P0nVF2OYRCwLzetkks1D
 x9hAfFNWpFEPqygbMmrIyMf7hgOYvmgAhXWYhk7vxV9Vxyvh3tZfVBO+XHIX9Y/qWsYN
 3RAGofcAagSMxEa9EiNUttSFf8NTNfrNi2oo1Ol+2f0xHyyYasgj2p1tAKlSnf5eCHFM
 KVXi1gMoHB8l7HXehwlqf1vrMbCz3JwFNEzM+S6juvGAqVb/QKEMiF26X4tzPvYGLB9t
 HAbQ/P1Vv5zwM7owTnDz9U4L/vQoGLp5obfLwHW9/O72Bo1DT7GuHHTfd8SuqyYyERkc CQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1hsu54y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 07:20:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2177G0ev131083;
        Mon, 7 Feb 2022 07:20:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 3e1f9cybyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 07:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/ML9toFzQcl8vB4wds1Aq4uBY+kBntWcOmoeABWZiFAju/NCaO2rmYhA1ysXa4Po39OWZFckG4GG9EHnYHGySsORk6GwSda4085Ic66hX10CNDxVeOte3xbzOXnSCComPnDNQkgQNX4DO22UDBshwSefVJK+SEvNQIC//e+LgbElk8srCBaXhv5PnM3kD6IQ8BcEzb/7aa9PB72khdvuzNzedTuijGB5gFl1jz72L7GYJk9dnvzdEndyh/u2lW2uK4lUUd5+pTLtZN/w/AqaQdovURPAYeXIwEwDFl9MrPc0kHMSDRAjvY7RIGwanzLs1Slm/8ZQXIgzYZl8kgOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmNj+ZQZf4vAIfUzyv3cH7wFzzCbL5ULkRnpIZ4W58Y=;
 b=Lq9iG3+pK8E5H/kbKx6sNKBC65pa1trcLf9PVzJUoDEuvkhzsM9CKChqfxUsY2r/ZMX2US99y8IM1U1XxXc0Y9dtn18mZNrJu6TzgF/3hEisd01s8KMs3vS1cRZO0ph4tKEnHK2qTEC1piUP43IVh2Fq+sOBr+EJFIPZpt0YsH7i33Yz08WNXKKWIWv2xrv/MwvfFjehhJN2DRnXe8om7OKhiafglFyGXod0GJJI081KD1KUVnfeAeUAsgLK48xwSP9poBsj9tQ+Gw6MG9eUE7YUxR6CJbceVRpupHhcUj5YB5EVtToI4PzPnlDh6RlskvcDkfVstIA59dZmzBbUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmNj+ZQZf4vAIfUzyv3cH7wFzzCbL5ULkRnpIZ4W58Y=;
 b=JrM0ueyzTZj+e0MGrHCpl9RmF2U2wN+N6pwgJlr3SxXrKC8PD28I8RSldU89j7oliZ7Bz6H8bNzbzWCKisbd32xQs5H0zAfwAekF1pRUmwczahWgeEN4wqTNGhA80Yoq66bYbvXQ4vLst/TO0PXvj3jAyLjRculBiIlOIwuhIZ8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4570.namprd10.prod.outlook.com
 (2603:10b6:806:11e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 07:20:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 07:20:25 +0000
Date:   Mon, 7 Feb 2022 10:20:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] staging: gdm724x: Replace one-element array with
 flexible-array member
Message-ID: <20220207072008.GA1951@kadam>
References: <20220204232944.GA454945@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220204232944.GA454945@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f54adef-2745-400e-3aea-08d9ea0a4f55
X-MS-TrafficTypeDiagnostic: SA2PR10MB4570:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4570CFF8C2AF09552984C2D48E2C9@SA2PR10MB4570.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vATQdFMe3L8q4mJofiH2aGJ3J/z1nig72x6Zq27Ee+Y6ETHPe13utdpsJuxb0coFqaBsNIGZUrF8UY4EmNN8u01jiwJSd80MEqhLdVqzq8tCSEi4oow+C2GJltG9YKlI7SRcUyiRPgin4LQNW8kMLUjZJreFMG5Wfa7QnsMJMOhiQbekJJMEQG8DsWmiFeGLC73hkwyt30UpLvJoY3v9rJ2ruuyYUVTDp6m7s8z5af044fT4oy1tagjO8SXHExmadxa+LO9EOSI827dnURxJzm6yiZzjmD+7K+W/3b35bqxUUTXq90UEbhQP0dTeqZ6kUIIllGiWeeSdY+crSh/J9rDUeGPlGh5GnPfEo94sWgGNYXOkxN2hL5ck151SspS9WEM/+bmpSvKRPSbY9BF5kNZ2rUj8O4OE/1uSl5yi8KHw+fgagOrSSZJQcauivyaAZzvafK8bXE+Kd61lZyohF72TN1FqY04HNzZDPaP8zbw29u/jo2NrRdGi79csbGRlbBaOLkCql2+5PHCr2Uv+RdDDHMwJZOJaK15/5YIDTf47tlOJWTdGVlLdHq++xegTi3WMPB+o/MTkHV/ZkRrMWabQhsv6fPD+NE09t9KaJGScfRleL93AeM5fSI6IGZt8GblAxYTwTvagtUcV0YZkIPSnOIMhbVEQxi+OwmJ5w+psgVP8VeVARipCpWf0Tfe7Wp/tpi9KQP7Pe1nlPPHh9ACYK9eWJMCWQ6g1MkmAjh82FAYiKxyJ9nLtse8pf6/JWzJajegS7b3Q6KgJBlfhPHOyLQwfj1Z5tgGZPFqVo/8IZRzfC7guH/STRJ9VQt52
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(33716001)(8936002)(4744005)(2906002)(38100700002)(38350700002)(5660300002)(83380400001)(26005)(8676002)(186003)(4326008)(316002)(86362001)(6916009)(66946007)(66556008)(6666004)(33656002)(66476007)(9686003)(6506007)(1076003)(508600001)(52116002)(966005)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a25oNVRLckM1L212RjloUGJUcVFSZU9LNmVBQmlwN3NEQy9VN2ZldjErdUdM?=
 =?utf-8?B?eXRmdHpNWWcwaHZIK0w0VUVSdldRUzU0VFNqVWhvdHhuOHVJQk9ZQVVSakZP?=
 =?utf-8?B?bU1rZVJhdy9uRmlZTWJXSE5ZdGhJVnY5WlBpU0ZQeTZZZTBJL2g1NEsrUDVZ?=
 =?utf-8?B?UiswM1UvS05LNTNpWCtDenBGRE1rY1FUbnkzWGJhRmRoZ0V0SHZBcENrdE9h?=
 =?utf-8?B?RkFIQzY5ZGxZL2lTaEhCV1JlSWx3WE1oTkZiRmpvTCtFVllwUUtYK05ES3Fz?=
 =?utf-8?B?WDczM0hCWTVnZHhDTHZYTzU5RXNVdHp2eStxNU9NaktrTjB5VlRWb1FSTm0v?=
 =?utf-8?B?ZG81WHpGV3Z5UUs3Tmk4OEwxdTA5b0JDWWJON1FxeEhXNUI4dDJjU2dlOWhW?=
 =?utf-8?B?cjZmMkFaUjdONzM0ZFRGR083ai95UldPWVNySkpON0Z6QmgzZk53MnRvSXpZ?=
 =?utf-8?B?NGpNK1I4aXFpeXBuMk9aa3k2ZW9SVmxMY0FlS3hoVzNOVGdwMHN0K1NPc2Yz?=
 =?utf-8?B?b2ZNcFhnRnZ0clNVaERybXY3SmQxZlBBdkpONkRqMk45MmxVRkJ6N2lhMUZQ?=
 =?utf-8?B?T0RxaWF2eTloRDZ0U04yczVJdlc3M2d4UUhKdnNEeG9BbTl6WUVaTUl5Tzh3?=
 =?utf-8?B?S1JOWW5rN1pxL3RMc1pwRnZmc2kyaU5oYWp2blg3M28vcERYR3NoUnJHZXlr?=
 =?utf-8?B?UlJqMVFaSkNOQUpGNlBkdFlDYkxHRlNxQjBqUjlqQ01XMnZabkMyc1h2M3lW?=
 =?utf-8?B?d3E1M2FmZnE1T3pPb0VySDBIdlFuOFlRay9RMXloTFA1Wks4RzJxNG4wc1BR?=
 =?utf-8?B?LzBNblVaRVFvcjhvNDJaazl1bXo5ejViNnhFS1U1aUYzMEllaHJ5U0hHU3Fv?=
 =?utf-8?B?ZllJVDdKL0hpeW1YaWpzVHdIZkVJTGxueFUvSXpmTk9BVUVJQmltUHIwbkND?=
 =?utf-8?B?aTVQY3grT1l6b2tqTXp0VnNNS0w5azJFakhnZkhkREVvTFdtditjbDBxK2ht?=
 =?utf-8?B?TmMxeWxGWUlkM0d4eDRGKzIyWUNucmJaaC9vSVNZUTJRUjFPL0FQUGV2akJ2?=
 =?utf-8?B?dXFtN24rcCtIUGRIOUQrRTNYUG9DUno2L05IQlltL1Y5S2RJcFpUQVJJdXM1?=
 =?utf-8?B?UFpBR0dRc1dXbDd3N0dCci92QnJudkhGbWovOThHVXRuRE1qZEpBU0xaQnJw?=
 =?utf-8?B?a2ZsQk1iWjZKUTNDdFkwZjUrWVlPVHRXNFB1YXRTV3pVYlVodDVHSFZyVVpu?=
 =?utf-8?B?QnBpR2NoUXNpdzRYR2hkTE54cHBXSEg5VHlHaWV4UzBFY3dIVGpQcGlTSkZS?=
 =?utf-8?B?Mjc2V2FMQ1MrZXVaWUhGTlZPOWtpdVhNNkluSWs0Kzd2TGU2Y3B2RFoyMktG?=
 =?utf-8?B?YUxOQkMwdDUwbE92TC9uWjgybGFPT2Uxc290MzN3MHNjbFdNS3pSUmJ3enBp?=
 =?utf-8?B?RlRFNXlrVkY4dlJ2dDR5bUlpTnk2NmhHTFlMWkMwMFNCMXY2V0x1T05pVUlS?=
 =?utf-8?B?c2lSektBOUovMmU4djNvU05iN1VUekhCMnBGcHdTWnRSV2NCWFZnWHA5VjVJ?=
 =?utf-8?B?SE9ZT0hTWmE0WkxRU0tuZDhSZmh6VmFUZFYxNEZ0WDlOS0dhMmdEZHcwTU13?=
 =?utf-8?B?TDBlUy9JbkkrZmlHVEdzZUZ6WHJqbHRuTmpCT2NGQ1FyVmh1aWJKanRIZkZE?=
 =?utf-8?B?ZmJqVWN0WmFKUi8zbFRqeFdzNDlzUW9MNzdGOVF0Y0NVYjVtNUQrM0huSzY1?=
 =?utf-8?B?NXpTZFlIemtlT0hCVlczTHdpNytQVkxXRi91YWZJRTM5elFjWUNrbFJjajlk?=
 =?utf-8?B?bHRJTnQ5RzlKQXpuRUJJbWJpeXcrbzFXZGxQeVlldFQrRE1hRVVPWTJldWo3?=
 =?utf-8?B?SHpzNUhNbEdjQ1h4NUJLRXpKL1JncHR4QXBlUkR2VUhDREQwaVRGYU1leVgz?=
 =?utf-8?B?ZUVxVjdEOE5yTjViTGJnZzd6d052WU9leUhsaG9oUk5mS0xiMXQ0S2s3V0M3?=
 =?utf-8?B?aSs4OUM1ZmhRZ0p4ZGFvTzhqYnArTGZWem1MUjNXY09nQnVSMU5aTGMxN29o?=
 =?utf-8?B?M21obldMRHllSVNDUnhIL3B1OG9YWFBNS1lJZ0ZTOEtRRHZGRmQ5QVhINXB4?=
 =?utf-8?B?c1NZbWl5N3Jrckh0c0NlTnNOOXpUQzdad2lGdXMvZjkxMWpCYnFDMzJ2Vmc1?=
 =?utf-8?B?MWFlRm1jbGZaYUFVcUJZVS9vYzFjYnNJczF2amRHeTU4Zk1PRDBhY3lQSk85?=
 =?utf-8?B?VXptblZlQ0t4aVJXMmIwQmM3aVpBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f54adef-2745-400e-3aea-08d9ea0a4f55
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 07:20:25.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkwW1ghO51e7WWysk9kMakiFH4re/Z+j0eNayMKLimxcI+uJS80WgRCOEgcx5r5ths8Jhnyw+IDCIOAm+uuEMEm4xe1bf68qzVCL4HigqkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4570
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070048
X-Proofpoint-ORIG-GUID: j54lMmDRCdJPK66Bn5QaKYzlNFyMCBln
X-Proofpoint-GUID: j54lMmDRCdJPK66Bn5QaKYzlNFyMCBln
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 05:29:44PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use “flexible array members”[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> This issue was found with the help of Coccinelle and audited and fixed,
> manually.
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

