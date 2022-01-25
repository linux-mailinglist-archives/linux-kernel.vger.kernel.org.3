Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653E749B6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580712AbiAYOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:51:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42556 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1580320AbiAYOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:47:55 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PAxbMg020683;
        Tue, 25 Jan 2022 14:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=EunybVC4HiZkOyWnulb/8W5Kd2Mm/SvRu5FtFX79JEM=;
 b=Gp91rc9NeU2MbUeirgmaq5/jHpVq/erQPM9Npz6GyuoqsU14myYqyOjlZAhx1MxLJFQK
 n5GHGuCO2G4mml9ZSA5IMfvoMqX0u8wm2tABxC/I4Td4x51DD8XighFYd6dpuRpnIbBt
 HL1dR4sWGhwqLAhYUj8sHCvaizI8J1e2onTXRwfotIEjTrdSAH0X28mNv4fcpZsJGeeM
 nYnItZ9gn0nJ8xZM5hokXxyb8uSltVca+fQvgTRMNc9QpYa1pjEZ+PE+dB3jHezRhx3f
 0zaQhr8skVh0UySxUI9m+apuHAlSr/gG0A1RoMkya/eXlsavaRmLi+/X+Hkiwy1U8uZ+ fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9khgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 14:47:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PEfIRI150002;
        Tue, 25 Jan 2022 14:47:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3030.oracle.com with ESMTP id 3dr7yg00a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 14:47:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xpu4kPDsSAjWQefPWy2web5IfW2QjFByOj1KfftGAUmuU/rNpw3Kick7yW82ZDrjy1FhU5vTNghs4e+rSF8M1NoG3pauJo9eyDW+8dD9xcMlKSqK07poN17GHNfDZ/eCngormK+1AGcsxJwSSFXEGowZVEJ2RpdVx7nm2soIg6AIWoy5rtkSIlyqVxk3EBvTKLdjcjhyhkxfvgSxMWjluJy0Z3AnwXBt1fOR+jZA6/6zpz3s0d3RFZKDpaEJitqO5cwIy/q+7H/NCyAV8L4/TNTpdOk9PCIndIds4z++/xjLPbsCik3r7MpYJaRM78OKS3o27COXvIeylwtghWWYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EunybVC4HiZkOyWnulb/8W5Kd2Mm/SvRu5FtFX79JEM=;
 b=EqehtS+qOiSk2BEHKS/MQe5UozpAWVjVLq4u0RjQzfSv0kTP0Rw8Gdtqqa4W8vacZ+KAjMNuP3ypoiB7WNabagCG3VlPScyzjBTA4JN1GnIpb0MSC9bGs5CDWA1NTUp5qWhGwL6FkhCZZieipDQB2cUt3cH09baVSBui+Aio6GUrS8zG6HDuRy3drWQ/QknnHohIfUrcYbpZNYydg9cHkbomEARvAig3veIbkyyTa/AsYNRX2Fy1KSrCwwdWflyVYU7GpOCtgrYRqdDg+goqa2Px/N/gSFse6CgPpkcK4hALd+A+U2aWxkg9EsfPtHJttVgPbxK0IS727YNtmlZwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EunybVC4HiZkOyWnulb/8W5Kd2Mm/SvRu5FtFX79JEM=;
 b=edSpl/CvdwsapZB6vkZhSyYJu13JXsChSmTwZPNBx7ji6wPmzv6ghbIE45s+s83+rHovoySqiwAJqKF+5oVB1iQbm1vuKxK0R4YIYL7V4Q8NEUccuRTDfJrAIPNlPtM0EK0qXoM9Ny7ICZ3clVLAygD2e27MlgFzZ6RQn6IPv3w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4442.namprd10.prod.outlook.com
 (2603:10b6:806:11a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 14:47:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 14:47:33 +0000
Date:   Tue, 25 Jan 2022 17:47:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: net/kcm/kcmsock.c:645 kcm_write_msgs() error: we previously assumed
 'psock' could be null (see line 585)
Message-ID: <202201220354.fJ3VzqBt-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff7d890e-60d9-4a20-fc86-08d9e0119ec1
X-MS-TrafficTypeDiagnostic: SA2PR10MB4442:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4442DD6DFE8CC28C9150F3618E5F9@SA2PR10MB4442.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Ktbz5/FgHvMIyatT46pPiIKFYP4vCO8AcbqR0x8s5SQ+EMj1Awwn3oZemQ1SgWdUU3ZVdWFIYGP00T5HiohjVtgrOV1nlFYXhOKdD8rJmuzTRyGYvlFXzKgnax05LvYo0Uv/qjKZWHR2SKuEfF8kslFr0Y3nvzvQzDZUqrL7s9kIQyK0+YeaqbUKGVsAuRt/pyDX7ym8IuFJLPheRcrOohISkUIJzp0qBupi/J0HFbV9RsfzzffUh2iny62/I7e+IClb3xWDUjyZ0Z7JszEDk1UdJAyhM0G4IVCK9WC2zSSs72iHGfjI9puTVsVJc+5PTqaAnTzwoTiAVlQeHHQTA5TKNEYvl2lIVkS+5quxKn2F5ThzT/ElHHddM16km5AhCN0hD3D59EJ6puPQho3sFz6TAmnI1ZY0J2P+363wJKmCAYlP5P4YD/F2R13SFkqd/+zkhooWbbrAC9f1+9c/MCi5PHBleTO7fz7glENku76S7DtfRlM5Z9u5x5cPgDdYNrd7SHIjmSwMi3W4XQzwpc/2i5E/akk6ylpJcP4P9rF/VEybxUA433Q4zKsRFblLO/DvAdT0y9H8I0lylqJlpM6eObPzt+/RSDY1CreC83tB5+3xbpk0H6nxMlYdZiIV3KGdyiDnpVWCn1YaAB4DoXgECbRXUV4XZS7LHn3u6CcYZLKVmzt6//LVD96vRBrDy8caFtvPEbduAUIOhBJCk9CyRfGJeqNwMoTTHa0VY1ipmN7KJIaWWGhoZufVr/NHeLqGTPhWcN1mDnm+qZolMTZG9tijjlWyM5IeC1f0s0G0LnAKDSJNpnYeu7ZqhGHv79UU8szTmeWHPfFfGWmyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(2906002)(1076003)(8936002)(83380400001)(38350700002)(38100700002)(36756003)(186003)(508600001)(6916009)(52116002)(26005)(6486002)(316002)(6666004)(5660300002)(66946007)(66476007)(4326008)(66556008)(6512007)(9686003)(86362001)(44832011)(8676002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSFKJIrmZYp6B3F9pCUH12Ik6QWa7V7bXOMUR6HCdNTuodEiBK+oCRYK7VS1?=
 =?us-ascii?Q?CrN3FuzjV8AtpF5HFvCIUjKd7OWec00G4Z/bPmanyIq6c2Gn1Zjx5xonCXsd?=
 =?us-ascii?Q?tPML3/u2iMpk8OAniZcSXdbC7ILRR9FByRRBY0O8dVIqKVWuA1uaPMNSldc6?=
 =?us-ascii?Q?IGmifaJm2TD3mTfrONySh30/D+KBgJMIIXXkvBTdNSAo4eIvK2TKJBhlPnm3?=
 =?us-ascii?Q?4J3eooKpj1Rla8s90244qpKgKV+MKrjrNdQVssTkQey0BgEr6J8Z8vpRi/tu?=
 =?us-ascii?Q?ApVMHTzTRUe0bcz3Eee5Mc36EFn7gwgUGvLzCuyaVxOVlbkStixR2MZ4aYRG?=
 =?us-ascii?Q?hpyYUN3hH8zHGVDfhE81ruwEyqt1ZUluQj0pQ+M05YuXprONfbZNBJ6Qu2xh?=
 =?us-ascii?Q?zc/b+ZtiqjvYY6t1MMtH7OyBZqIWqUL02jG8vS3m0AE8MyeAIsfCZ78ZRGx0?=
 =?us-ascii?Q?O7HusDeP+/BCxWdr2wuXS//voUInqYWsBagCQxoZlsU3VYjmOutMnVuA8M1Y?=
 =?us-ascii?Q?JT+AjF4pbK2CDCBPo5VV8i4A/8mgGrrce3F9e337Da7jMdixcaF5eDMZxJuC?=
 =?us-ascii?Q?yhaOJTrorunm/9LtAWf/4OKkZFF4a1BxFBJ9eVtpvo1elKU/rMILlkVToD/Y?=
 =?us-ascii?Q?Bb6jZ7k0Kuh1wFnPFVBw8CNYXu0jCdTwPH/1bPK6K0n+Td15Act5clKXnOMA?=
 =?us-ascii?Q?lIWPDA/j1vedArsHpSdFYXaSjrSS1pTaEVpmccFgOsnXAaJvwwv7rp2mwnAY?=
 =?us-ascii?Q?bLG0/CC55Z4NXhoKliLUczrbIvNJthiwxuPdbzHbnXqfEB4mDA59hIBOWl6r?=
 =?us-ascii?Q?O/7CStSWtk/jk4AarTnbJP6weqFFEb2M6SwWFLBFtRy4r9FkiC+rXxNyQ/Se?=
 =?us-ascii?Q?jxsUpZqFOsv2Y0MaCk1Dy9eifW6qEE7RfJFAsEgKf3XJRLPgLwkzBSfsgj/w?=
 =?us-ascii?Q?NW6oc9uKCcXqUtcSSNVmn0teUorLLKsBORsPmt3usTgLCY1DYsLGOaHdKmLC?=
 =?us-ascii?Q?uCR2sDbLs6/UUKk9+9Mlyi48iDe83Lah8roLsHUF1RriOBWjz7PRBSpjTK6o?=
 =?us-ascii?Q?MSlHaJnH9IDbiGdMbKrOIhZGQvI/hb51z3foNEXYs8M756ttlK/DScXFLVG5?=
 =?us-ascii?Q?wDY+Nq6qomHXd6TKAkGLakUuu0Y3fSgLXX40y2DgWLzVEXvbkm1vDfp0ddHr?=
 =?us-ascii?Q?/ncxE37xcOiy4Rat6lXXa4NS74k+/wjxScFE0vNcSXcGQcn7A54rJNJ7Kk29?=
 =?us-ascii?Q?SyLx8zNqQIqRGNEmQhygu7UEnlyIxeNBPtoFxpNZEuu4rrhf0Z08neS0JGQm?=
 =?us-ascii?Q?OAI3gR0sx95fcTRPeb9iR6fnDHfGnC8o5gd7/cTjoo+r3YNeq7Y3279CXnlO?=
 =?us-ascii?Q?KyRdRirpRGql22j2t4ElkBSSfXIYhJqSE0NeTodoTAHPyJZ3uvnAsELaDVTT?=
 =?us-ascii?Q?2A3Nanu4OUiaeYi2G9Zs3NwUBY8Qv6S8RbOjBtjftY5itYiE/uouGphD+Nn0?=
 =?us-ascii?Q?7aCKSmbHEJ6SfHkDHJTPkGuZFGdFFhaPMMweym7gncueU63j6Sy7lq4gtvqt?=
 =?us-ascii?Q?4zSMEx2ru3ead6lIpWpWEZGjElqaQteOrzINy7Fh2qvaK4WKNDhN5jO+EYUs?=
 =?us-ascii?Q?L/A3l7SwD5TbC0oo23CDt5N7UCKkpsKFqVOVk+Pv0Vzj90NOm8pP0fBa/kWv?=
 =?us-ascii?Q?0uNNJ/YTvBrj610d6YjRiatYO3w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7d890e-60d9-4a20-fc86-08d9e0119ec1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 14:47:33.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3R9+onvkdeSgtz9vOkxQO79iYr6koeYCMsQVeWpMmXlFYp9vpayFK+MPi56MJOKRLCfjQ+I+CncNhXyZfjw4WNuLWpU45VNRqiTYmz3GLG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4442
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250095
X-Proofpoint-ORIG-GUID: Cjs8PznjfiWadx38NlIMxZK0QwPsF67R
X-Proofpoint-GUID: Cjs8PznjfiWadx38NlIMxZK0QwPsF67R
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b57f458985742bd1c585f4c7f36d04634ce1143
commit: 1e688dd2a3d6759d416616ff07afc4bb836c4213 powerpc/bug: Provide better flexibility to WARN_ON/__WARN_FLAGS() with asm goto
config: powerpc64-randconfig-m031-20220120 (https://download.01.org/0day-ci/archive/20220122/202201220354.fJ3VzqBt-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/kcm/kcmsock.c:645 kcm_write_msgs() error: we previously assumed 'psock' could be null (see line 585)

vim +/psock +645 net/kcm/kcmsock.c

ab7ac4eb9832e32 Tom Herbert             2016-03-07  589  		unreserve_psock(kcm);
cd6e111bf5be5c7 Tom Herbert             2016-03-07  590  		kcm_report_tx_retry(kcm);
ab7ac4eb9832e32 Tom Herbert             2016-03-07  591  		if (skb_queue_empty(&sk->sk_write_queue))
ab7ac4eb9832e32 Tom Herbert             2016-03-07  592  			return 0;
ab7ac4eb9832e32 Tom Herbert             2016-03-07  593  
ab7ac4eb9832e32 Tom Herbert             2016-03-07  594  		kcm_tx_msg(skb_peek(&sk->sk_write_queue))->sent = 0;
ab7ac4eb9832e32 Tom Herbert             2016-03-07  595  
ab7ac4eb9832e32 Tom Herbert             2016-03-07  596  	} else if (skb_queue_empty(&sk->sk_write_queue)) {
ab7ac4eb9832e32 Tom Herbert             2016-03-07  597  		return 0;
ab7ac4eb9832e32 Tom Herbert             2016-03-07  598  	}
ab7ac4eb9832e32 Tom Herbert             2016-03-07  599  
ab7ac4eb9832e32 Tom Herbert             2016-03-07  600  	head = skb_peek(&sk->sk_write_queue);
ab7ac4eb9832e32 Tom Herbert             2016-03-07  601  	txm = kcm_tx_msg(head);
ab7ac4eb9832e32 Tom Herbert             2016-03-07  602  
ab7ac4eb9832e32 Tom Herbert             2016-03-07  603  	if (txm->sent) {
ab7ac4eb9832e32 Tom Herbert             2016-03-07  604  		/* Send of first skbuff in queue already in progress */
ab7ac4eb9832e32 Tom Herbert             2016-03-07  605  		if (WARN_ON(!psock)) {

This warning is a false positive.

The new Power PC implementation of WARN_ON() is written in asm and
Smatch can only parse C.  I don't have a cross compile system set up so
fixing this is going to be a big headache.  :/

ab7ac4eb9832e32 Tom Herbert             2016-03-07  606  			ret = -EINVAL;
ab7ac4eb9832e32 Tom Herbert             2016-03-07  607  			goto out;
ab7ac4eb9832e32 Tom Herbert             2016-03-07  608  		}
ab7ac4eb9832e32 Tom Herbert             2016-03-07  609  		sent = txm->sent;
ab7ac4eb9832e32 Tom Herbert             2016-03-07  610  		frag_offset = txm->frag_offset;
ab7ac4eb9832e32 Tom Herbert             2016-03-07  611  		fragidx = txm->fragidx;
ab7ac4eb9832e32 Tom Herbert             2016-03-07  612  		skb = txm->frag_skb;
ab7ac4eb9832e32 Tom Herbert             2016-03-07  613  
ab7ac4eb9832e32 Tom Herbert             2016-03-07  614  		goto do_frag;
ab7ac4eb9832e32 Tom Herbert             2016-03-07  615  	}

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

