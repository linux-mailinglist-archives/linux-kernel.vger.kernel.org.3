Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61AF46CFA3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhLHJGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:06:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2240 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229648AbhLHJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:06:38 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B88x49l008523;
        Wed, 8 Dec 2021 09:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=P27JKAryydYanIe7ISNoCsDN3AoJMWVQfEetrj9zgJg=;
 b=AxNTImybbhJobEyad+bnvsCWJ7ht/0uY6J65tDoYbaiATOilPIsSBx3bDv5/Gr53bKe3
 R81SSXvKT7gds5A8AKmEawhscPFpLgc8W9DrMKO+1c+pHH63kbG+c5+qIxAuhxUXD4Op
 gBcx37wfHLQ2V9YVgBBeHq+6KlTaw34zK/vmSqi3+Y/qpPlB6HYO/jus14MgMbZIJJTR
 70LDHXf1zP8GtRIqJ2swV4HS7o717Dblo1tXDxOk9DcKdPydCzB9FiRIrcPFzpuYhCgz
 XE/Qf+Bcbggn2r5odu45mz0ufwBwcjCIXRPfdp1aOuLBDB0limDtOmMOCeLSWuXlV0G+ TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csd2yfd0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 09:02:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8929PV131901;
        Wed, 8 Dec 2021 09:02:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3020.oracle.com with ESMTP id 3cr0563g5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 09:02:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDSQiBVK3hsc/6oncZOQf4I0ckZEnCr/9cC/s9Ma3l71+PM8dVQ6nMVMmSbB6jYiySlm/wouTfqZCfQsn8GVwr7MV/IOsIslIxnkdYAsuEAn+fh8PMGvM48l5O5vcSQSp8PS4sAOSQrfhRmIkemaXYyQBx0YA2qRovXrLAkakDVleAYHS/wt5cwfY7YuwyIfA7dYSWGjjcmcohaXMLbgGXtNfwnwbvJYTVgvZ/iIE/VzvksTrndU/TYa6Td9JeN2Uz4IrsLgmMr7uqp788rW3N0ptZVWIsxpKN/ryDXmKklwl5Xs8VdkBS5MitdHnymdajBcQocNq+r15RMdM4STyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P27JKAryydYanIe7ISNoCsDN3AoJMWVQfEetrj9zgJg=;
 b=fFHPLf1lnL0fBq0T0zjbZN6PNIaYzhgiz+88j2HKiQ/iD1S16QSrQNa44A7aNZc7TB9Eo8+LT1OWc9LYW6YtCbYOD2LbrKspu2XY8bA1PPxImsdEygDYN2inR07EWIZN+FI65mJbPWlbWtUXYp+u0uE7h3BB99GULiK2E+2YJGPzgrOU6n+pgtJWf75IsBENwMTUtgiPTqCJVFQMiv8DmQNRuQykIXcz9l0Fnb2bGr0jEEY4hS/5xQiiNge1eOQFoNeFsaCUS4sVrHcLVbJhpCxSSKh4Tw9rtRmdMCQFC4zaRMuEEL2IML25GNlnLIaP4hykTmnxABtT0xo8lunWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P27JKAryydYanIe7ISNoCsDN3AoJMWVQfEetrj9zgJg=;
 b=JjBLHdI/mDmHQt3rWB+EXcQHZBaX6ubZvHnOTnyGlKEE3eSrODBONz/TLZMx8FKAGDBykhjTWg6Yn33SQqGBG2RY5r0BJZXzcsE1qIqUBO8IConFfAU2wr/s5kL90QFvpGdndaSXLudAK6KYpWilng4jhsipDbHKnSVcn+q6ivk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1248.namprd10.prod.outlook.com
 (2603:10b6:301:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 09:02:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.024; Wed, 8 Dec 2021
 09:02:49 +0000
Date:   Wed, 8 Dec 2021 12:02:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ngo Tak Fong <simon.fodin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8712: Fix alignment checks with flipped
 condition
Message-ID: <20211208090229.GH1956@kadam>
References: <20211207212223.GA70594@simon-desktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207212223.GA70594@simon-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Wed, 8 Dec 2021 09:02:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c29212b5-39da-4463-add7-08d9ba298254
X-MS-TrafficTypeDiagnostic: MWHPR10MB1248:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB12489A6627F663CE3BC7523A8E6F9@MWHPR10MB1248.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJXo+atEFo40JDJPteClNPHMQjfGHDZ7HkHRckCx3ux3N5zpgMIul1WQn1EVMOJhyIgHDryP/u2VGGZXPjA68BXCSL49wkuM2k+d23ZBpcbim3bfUaq2EgvacGCx3ZVAhO/YRE9cTSWo0CAJj53rO34fA8jMwMk3rRroOCKFm4J9yzPnHeXed/nnoFq6CBJSNNERu61IvKNRmuARMbS6IpufH+qfvW6Vc78076/CDw1UI5AlcsfkO1x3kpYXopWoTNeLMxxXM14NOSdnUXxtkwyI6zonmeeeX/R37nqO6UbM1w9a6Z7VFM6JBcRpHXX2NhZPgqsaMIa9OOOh0ECVoPIaUkPWgeiUZRF4Re3jxgxQRNj/Jowzgjwey8vNmKe6Aa0Cua0Qqm9r+SnwkxV6bJbciQgIh2zsegRe7ZJ+K/zxFxQGLkYtmU/cy5Z4O+GJrmj+F/bmG6/S/w4mAelFKVr64fqCa4VhUtyQKiL0YW+AIMY2K3GxOoTA86dcWcmdwWWPM86u30zOWNSKP69F2HNyMeNlAcjTn0ItztiIeuAp7ugw8UdYX9l7/JmXw3OgFZ2xr1zQ72vFWVbT5NbLf/6J8ZT30KiF9f1hq1MxDtQITLePaEHm5vhbcNyrPT20NGEldc8ZhLDl/TjOmjGt+r3pd5+fqBlscpj9bZyAiJHm/2TPX9RhMLs2HGY4aBtYMx/j6vpaMoYfRNF22Vrnaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(44832011)(9576002)(8936002)(9686003)(1076003)(55016003)(6916009)(86362001)(66476007)(4744005)(66946007)(5660300002)(66556008)(8676002)(38100700002)(2906002)(316002)(38350700002)(33716001)(508600001)(6666004)(52116002)(6496006)(26005)(186003)(4326008)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eeYC9+HsqIg/iQZQh5A040jFeXh177CYaduX5CyLz4DWT+j5+yJ3GHwZYKOP?=
 =?us-ascii?Q?2s1Lo8s48MEuUoYE9Dw9+UvWZeVael/YpAophzjKSRsHpttBsVNiC8TvJQhH?=
 =?us-ascii?Q?mOtvWZolTcqLAdo1Y/LlSs72+rPawyUM96hEgRyzNcDWfLRzxYh4rb8neMxe?=
 =?us-ascii?Q?ozXr3SRQQeP1B3l+a7ktmWj23KsTGttmEsZf9DUXfRTJQqO+rO6VNtgKYv6X?=
 =?us-ascii?Q?dRaOAsItHAi5d6TNHYY8Xs6FWmgLbap15mYdi7pdMTtiPbuG47vG5b9S3Ejf?=
 =?us-ascii?Q?+JpmkcdIwKmWRg4fW+21mx0l/ap+S3ZZftFrieHGy2J4ZZQQpPBWThL3vA/w?=
 =?us-ascii?Q?YJpwOxnc8k89qONisaUypErUtC2+16x2l5zFAxkcqLI+tFccdOvzbPqfSMB/?=
 =?us-ascii?Q?HmPazobkeZQqowPVcrDRjd7ccypUtlc5fP+VKBQIIcTXPYGJDZ3Ca6PniA29?=
 =?us-ascii?Q?N3XNxrJAk+mZa4c3jyvZu/laiUcWAeB7zUS1pMOPFWbvJhMjJcch/IdjzkYT?=
 =?us-ascii?Q?Q3eBmYt9MySg2JjyDTl5pXTJ3QUa4DLOn4cENpEsTgZCzkdCMy/Jzk6whbW5?=
 =?us-ascii?Q?EJOZKFRFt7AgKKsQja/RpfyL++FqQWsd5CoSGprU3WQ6Nq+D7NdLuv6Rs39f?=
 =?us-ascii?Q?DqAp7F2cmOeLqm/63MuUq5qrdOvlcPrTOlopmr1+KmZmXVQu7NBwkq4p3ISN?=
 =?us-ascii?Q?dOIMDVlAyZN7Cy+9G1fIUW6uSiR+PYJJmR46quzXcWGuraHRXtUiX/ZBSqS8?=
 =?us-ascii?Q?KhYt2yRGrgAkDrKuTxYSTE5nIwnqEwxTU4pCL1p2rmTkrNSU+ribJaZGecpg?=
 =?us-ascii?Q?6QPNd9eliVweK2DVZrtg723GxSYFQ5jlIo8XBGHG8hFoja+p6noVJ2wE34zG?=
 =?us-ascii?Q?dkOrrV5cPYjbUxUj25O3oEJny2hzGwEO6c05quW+FldwEyrJ7H7mQHC+844Q?=
 =?us-ascii?Q?ZY2CVuW692Jr2RGX6y3vnZ9OIqf8fekcMlYKs53hgRR05SGXLCRoDrASDmH2?=
 =?us-ascii?Q?Yc9bgxKov3Kwz8ioBYgP5gBNgRFyQER3ia7n0edrM1FE4NC1s9JkdHGMfxQO?=
 =?us-ascii?Q?unBl5pQb10dguZSLa1juDKj8lsJElN61wU7Wz7rBkactjZQXEdCytBispfHR?=
 =?us-ascii?Q?tITWQQkKuXnuJmOmdU6uwo7RTneulrKxFqPL0Mokw6TNc+n+/8mnelKUxF0j?=
 =?us-ascii?Q?z0iUedV1ZJBY98K1qfP9UjZRiiqPYIPY8u2UBEeODwV5czU33ZjswxeD6IsR?=
 =?us-ascii?Q?sM4Utc5go/LLKzdGEVH3l7KgzED5IHgY7Nhe+wxP7tM/OZQEncX1XIqGcTa7?=
 =?us-ascii?Q?Ev3zhv1R/KCJm7l9UQZCKPbMLU68YN2l33eXhSco00gZHVjpFPki/BkMI3RQ?=
 =?us-ascii?Q?eulxKiJRDizaipxS00zWeGKWqjbbWDncDZ/+MjxMq2Wy3tCMryF1BzVwNWsr?=
 =?us-ascii?Q?XIi8iBbYdWkNGT/PA2t2gXLAy7nhXtKoofIpLKx5x6NWSRTjYLvbASRHMPjr?=
 =?us-ascii?Q?d7ulBdXbkz1lyYM+g8MwhMrqP5VPbibdL5DIDBl21KCzd9K6gEUuPn+VqXNz?=
 =?us-ascii?Q?ghrcrEdZAKZxxpOyEarw+rcID+VafywxrnvK4io0qkk1KdD+3O5c7dVX9N6i?=
 =?us-ascii?Q?Jhw8+1kgmJRFzOfKOjpFDoXCcOJ6AxAHLIdcDxqfUJm2PEwYRSyigoXfDR4Q?=
 =?us-ascii?Q?BZN7dyaR+EQis29wMN0Qrr0Ghls=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29212b5-39da-4463-add7-08d9ba298254
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 09:02:49.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWdkUB6euTdtH7u5MZr5zDXbvGIoMdZY2HpzD1NAFSodZBnUM/tZU3MaB+lxzX1LNZjxUnWlj+0IkM1RutkJ6eWYtfoZNAXahsBt/vS2u8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1248
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080059
X-Proofpoint-GUID: AJ8tzeicB4O6QcarxlhokAM1klWwnmBQ
X-Proofpoint-ORIG-GUID: AJ8tzeicB4O6QcarxlhokAM1klWwnmBQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 05:22:23AM +0800, Ngo Tak Fong wrote:
> Fixed two CHECKs of Alignment should match open parenthesis and flipped
> a condition to pull the code in one tab.
> 
> Signed-off-by: Ngo Tak Fong <simon.fodin@gmail.com>
> ---
> Changes in v2:
>   - flipped a condition to pull the code in one tab.

Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

