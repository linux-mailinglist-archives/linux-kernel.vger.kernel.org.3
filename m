Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94E64D6D30
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 08:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiCLHI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 02:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCLHIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 02:08:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E874340C6;
        Fri, 11 Mar 2022 23:07:46 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C48vX8031067;
        Sat, 12 Mar 2022 07:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=268kICWJVG9psMO7YFeIghs3ogUISG5utdaE3/Hkmd0=;
 b=i2sEqraC4Oub0NftHYb+lkpNDbJ1GUW2UXIcDI59BsijSNiX4x6jBOXxrHd6SEOkeu9w
 WGJZpnEfkog1Mjr1OkTNGh1uUppPu4SvbeDgkJPOLtbhd7++GMvGU1nW7kqpMmGL0DBS
 iEOQQMTfcHsuegqMvqDJ75ApBjQrYkThvvjUt6v45rH6+5di1a0i1MtpsS4d89vlZY6R
 EB/8JtR6NxihBQnGilpK231gdLsO0/yoOgmM0KV1/PEiaWEvhoRnUT/et82K7/3HuDh9
 QiM/y+6iahh82S5vW2ud+gGMjKh61bSH75ftJiFdlvyYz4iQ3vUjfKgvHqyXjjn0tOjP 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3erkd9r5f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 07:05:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22C70Z0g195619;
        Sat, 12 Mar 2022 07:05:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3030.oracle.com with ESMTP id 3ergmqyc72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 07:05:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvdHQIMkcAHUGiM0cxbidhvHDPJTZ432+XYXe/1fYp4ZAK+bjeXkbsnhUtsoQiYh6Dz5VQmqHWJqegHLwajZkQLHcXGi/Po+w6XHzEYrrIPWjtI5bv/3SDPbldkZ79ih3It8h1M+q4w7ehIlm8f83101Lh57nXNfYB5o0/HarIKL1KZLPRIyuvh82OV9r8Hgkk5UGsCRkNxU3ec5dPZI5yvn7kMeMYDOJ9RRt46ZNcSJu+gtyd1vMYMMhz3LDfg+MEiXqFFmAcS7cPRu4tcKD7qM3jdKYtKpjCMY8CU2wEsc0EoWuag48DE+DIWdSRtwGanazUvN/+5f17H8/LAmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=268kICWJVG9psMO7YFeIghs3ogUISG5utdaE3/Hkmd0=;
 b=SiFf//Nxi034Mi5Zsb+kH1R8J6QXPIgaayl/4WsmNyJUCgo0+w5H4lMpXSnhcgxoStomxuvQkj/gnTyP0Q8jOWByL1LzvWoTgJQi+RgtEqdV7xZO3Gz8GjnOI+omSPD+jAjyALg2S/KT/vZijo4vliGWqYIyr51KbrslSiR5fA8s8SubmEeTckJhKe0NsVPcI6mCsGvWrd45aa40rA1claNKQuLFuEwVQEZYejhk4eGnheLpUMNgqhfRAWqFTEAzggd82a6OaU1XiDHp5AEawgc3gDz/LxTlRey1urwYqyFufSMTwr0bAoupaU0kT9P5iM55BXTgHmipWxs62Zlnpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=268kICWJVG9psMO7YFeIghs3ogUISG5utdaE3/Hkmd0=;
 b=cB6dbUC6XGE5+7yOEgVZy6Ty15PmU6f8JN4VM3P0XqIucFaDhl7I30GZu57w7T8vYjRKQ1GPlfdCDdUazianBkjLreuYGFOagcC0AuGK/qvH/4mvK/cfPklbztfmKZCF7NXb2vEZjBmpCpjIae8c7Yv+Q6nYm+JOvmdU28eXiHw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2218.namprd10.prod.outlook.com
 (2603:10b6:4:35::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Sat, 12 Mar
 2022 07:05:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Sat, 12 Mar 2022
 07:05:34 +0000
Date:   Sat, 12 Mar 2022 10:05:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: vDSO: fix return value of __setup handler
Message-ID: <20220312070515.GO3315@kadam>
References: <20220312042144.15470-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312042144.15470-1-rdunlap@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b484ef8-4dd5-4c5e-782b-08da03f6b41c
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2218:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2218EAF92780E3B1A9192CB18E0D9@DM5PR1001MB2218.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwG2jQw40KbM16SMhHBWR6UDizX0nQuoLsjKxVbvm3Cl5yu0NIqOJbdWyKV83qElyL0yJlxkrfh/T2Cdq+FmW7UUynKbc56s7Rh9PqimRhXnUZK5fQwqjQ4L5v6GFs9hkYyWmoYkbFIvjixTr4Ob5LMzq/SVxsysBFQGlzX9DLktu/YZYgy4G8i0mGb5VSanQPT81kVNBvB4stcGHQUtV3z/BHxhb4h3U9/Qish8Fg8K+9i0kDvWvWnCiEWxhlkJ+Qa+c+cehWyFWCNBVWopGZMCJ7OxTnHF56CJI0xh/H3ZzUSx0xzCbYcqVjFa/wMTio17zpn/faupL50m8y9ffqNapqGEba2i1jYWda6Ftex8jE5UqOZmeZE9LOIOBx7URPEE1yNvfG28jas+1kac0BVnkJq+2Y46gAlSZY3hpJ1MD7xek6ECfh5MXrMhyHioz5Mb//qln5nu5K+ittlj41cT+17Bnic/nrAgjvVW4vCaGACsGskVwVMBVlAHQFXru8vKw1aYXDXB4ARmBMU9WrGxHP9XrQ3l13aUgxi7grThxfjdnsLAvkDraJKyVa5EvbGCPgbm0KwHo4eKAkNMFmXOSuGtNpni16te6UTokmlI+tU/hLVJT74mpZcXRKPR9nDUpPpb3cc78L60dHpcMGNKCfa9lApq9Js0GxkEWw2etqddsZBqBM/28z83CozkdiR71gRRjwUIHoHmQznwPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(38100700002)(6916009)(38350700002)(86362001)(33716001)(316002)(5660300002)(44832011)(8936002)(4744005)(66556008)(66476007)(4326008)(66946007)(186003)(1076003)(26005)(6486002)(83380400001)(6666004)(52116002)(508600001)(33656002)(6512007)(9686003)(2906002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XVc6G3rV4HY/09LuRW9dDnjPbWCZ57gimCNo4tpjuUAkZOE3ekol5ps88Ksr?=
 =?us-ascii?Q?7po1eN8lE2oUia7uNU+E1YoIuTwZRBMETOTbJYCY0/dNMe8YGl7zvHy9bX1+?=
 =?us-ascii?Q?mHzwiPua42TWdOmh6wmVQFarnWz2f478z3mrlgcQf0zpQFmbqpZRoHQ8WOwJ?=
 =?us-ascii?Q?vcLlU1pcFL5ozvgDNx2Fkz5zkOK8gGuhNANbD31zVSZ3OT0LQCZyTU+CRAD7?=
 =?us-ascii?Q?Jq7wH/NYs7lnKpU402Bq9QGbnnwe14Ig/MkzlQTDy4U93HQ+/L9EB47NoGJy?=
 =?us-ascii?Q?6WVI9gmEdAi8rQqn8c5w5KwuXBrxXRhrY2HRQSJ+kRQT9U1tYQL219LRI/0d?=
 =?us-ascii?Q?lvxRSEGlluwDGGn887FHtj/vV0PHMWokMiUSXxGXvLTdscJVj+OSaiNUtu6s?=
 =?us-ascii?Q?JAaljntXJIXzW7yKv4Dbvl8i7+0C/U+KfYUSonHP0Lp+uomUvimxW6BcMOOJ?=
 =?us-ascii?Q?trje+WuLHZjs+2POpi6KK2yNJvEwKW2R1iHonuuR2EbCsB9MEzToaAPoMAQl?=
 =?us-ascii?Q?f3ytQouAhd+jjNDyZynTlHWgWwMihlpEfMCDptU5wL5H/t9dM5SyfKbP4Nvb?=
 =?us-ascii?Q?27rExAWSuJV7oYZkIhfZSK48NaznNzczbUDOB14rYVIgnEc4ps0HG37tEKj7?=
 =?us-ascii?Q?4thuWxmLNMwfYb2hbkGvC5stE5EGDf+Y/R7JoP6zCNokEuRpd2NAeSy3Yqys?=
 =?us-ascii?Q?vgpOVf0q9TcWzcAvllVFXRDfHuuYlTIqoOGH7IJ5bpBd5cj5pexqAjw8wQuZ?=
 =?us-ascii?Q?mpN8MVUJqC436EbiD829nJsLj7PfHoYqJglmLZb0mNa4hvK2V58Z1yt8jbHE?=
 =?us-ascii?Q?AGLPY56W8uy/dnMBqSTAPWzXDT4zx3kQc7eXendN1xdgBRdwXIH7setudLyr?=
 =?us-ascii?Q?m3s7doSoZmHvEt6QnO7ONv9Q2LnbugSMsvSZQV2/JRfqVHOFpHueZiw7YLg4?=
 =?us-ascii?Q?C0s0lb91LRWzl0eciCzkdZb47YEXgxxVYJnB/16EJffbbrEnzS5xs37CX0sd?=
 =?us-ascii?Q?LtyR3TaQ7RXq6vAc5nqVS+ar5aFbNTHOfTSq4rHkW2TpMG2R3/4frAZOCzfh?=
 =?us-ascii?Q?OCW5NapBq5TOS+KnNHFbHF6xmjVcwgkVm2ZTgtqyD+lVTIkvNCnSwQBMgiI7?=
 =?us-ascii?Q?8ybjugvgq7OcKzdOMS3CuMQDVW/8ka9WDIww1emvjeQJc78y3amLyyu2qXd9?=
 =?us-ascii?Q?/IRgGzcFhiQ9ixd4dIzRHm969GNBiuFYVC738OneJVTXdWE4woaZFe3KEG9x?=
 =?us-ascii?Q?1qDVC5HAND04oFx34PJ7xCoAwx3IZDyoFpDEMMpJjfYmT90xN79cb+9F/cOI?=
 =?us-ascii?Q?4r+/gT820ON3bs4I1bK7E71Uy/Tip5HyGUkPylZ5cJOReFpoGPevnnUqVAgU?=
 =?us-ascii?Q?HNOc5bSiVnBBgJ2ELKBn/KvJWC+7r03tVrT/plPZk+F1Ggh7aIf3C5NL7Fvp?=
 =?us-ascii?Q?gquhhR7WpAhLkSWHe/ck0nP0ewZLXkbEEJfa8mHNpJMi11eLfQo7s5I+8AqC?=
 =?us-ascii?Q?P8qs92MXGiCet9LSl2fbFkajSE7osdSfSPdRMKRnafg8r3kLt2On39X8ILf1?=
 =?us-ascii?Q?whcMdCsT835vshXS/webteFIdQujrAfcxfvfAofn18tSWfngn/lQdgT3YNhB?=
 =?us-ascii?Q?t95GeEOl6uDLnv01GiGIpJIn/EdlWpDaFcDVB0pX1CTp5XFQQK9CD3dnFIzO?=
 =?us-ascii?Q?cCIq5Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b484ef8-4dd5-4c5e-782b-08da03f6b41c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2022 07:05:34.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IS0ivV6/6ZVJVE+axV5dIIOJv/QwnV0LE2PgWlzvLn+bBdWd+UuS/8n99jci+HPwrP11PpNc17Zv/cdz7SgI8DBz/KWA5irGbSAwLqVnFxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2218
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10283 signatures=693140
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203120040
X-Proofpoint-GUID: B55LDdnTSNM2ku9lgUHejNOCp8avztMa
X-Proofpoint-ORIG-GUID: B55LDdnTSNM2ku9lgUHejNOCp8avztMa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 08:21:44PM -0800, Randy Dunlap wrote:
> __setup() handlers should return 1 to obsolete_checksetup() in
> init/main.c to indicate that the boot option has been handled.
> A return of 0 causes the boot option/value to be listed as an Unknown
> kernel parameter and added to init's (limited) argument or environment
> strings. Also, error return codes don't mean anything to
> obsolete_checksetup() -- only non-zero (usually 1) or zero.
> So return 1 from vdso_setup().
> 
> Fixes: 62d6f3b7b85e ("sparc: vDSO: Silence an uninitialized variable warning")

This fixes tag is wrong.  My patch did not change the return values at
all.

regards,
dan carpenter

