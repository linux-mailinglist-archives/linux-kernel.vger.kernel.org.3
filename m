Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B074649D0EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbiAZRi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:38:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9814 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243822AbiAZRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:38:19 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QFoiXt029667;
        Wed, 26 Jan 2022 17:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Z7X/EjYx6HCPlCal4H69ozBf9t5e2gt7ieIMCe8cPUY=;
 b=sBrT77IiUjkQkfLUCvrIVGDb+LpInFToe/jLn7n0xVtqpeKuPLLvSFboIklmf36NNZ2j
 ZuegCL8bjXYcey8/xAmIypv/9OFU5mIoTrj5+uad22QyMBN1locgWa/NHBb2nW3HHZgf
 4Vl45VFNotEPPNOAyium/rluqhdBiFkOOwBlWN3o5dTuborJzgdm5i2Ine1ATeD3yplh
 js8SaOHwkvkEDJJkZ7Ij4esuwdCWfoPlUArdpvA7gCq4gGVdgczEDidqeFEJsmXTi/rb
 RTMB4HBGmmWRP314NI3USUQ7P9ABrdBhUKpRr2DDpQl7t/OkfpwVqTGTE1SU4dRqAf5E Sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfpkjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:37:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QHUVGP069574;
        Wed, 26 Jan 2022 17:37:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by userp3020.oracle.com with ESMTP id 3drbcrm55a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:37:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO4r1lgSwpxjPQGQF4AZy9Y1DDp5zjm+BuVk5H+0mwCcrJrLiM7dCZritnoHeOTqWR4sQR5BZ/bJD/pr9JyDPuYBX7iIboAPTjXOOc8YYUdq0v6s3doxaLSoX+m+5WXNDkIUGKs7DV4BxOY6LkiPRqxnYkJWj9wUtk1PTwPb+h0hdB7EF+qAM6KM5qSBM/FEpU6wJCCsf1HM6z8ksV3myrp/bxMrLJvBd70xLjkC9GYKuT+I64q1wGcy8ElzOzj1qptODVQ4TZnG8rEUg8ammYYe97Nv/2+0ge2+Chmf1GBBSXH/gkfoBXlSbM7cPMSGP/EUuF67/1nfMCRS3iWSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7X/EjYx6HCPlCal4H69ozBf9t5e2gt7ieIMCe8cPUY=;
 b=MR6xFzwbLGTAiJ0+sW+82VOw9xfhA/U/2ixkzbeg4n2NS7eBuyWI/czo2+c734dmppyA8PxuU4QyIRsojRxfdhH1EAnQcKBdr/YxpJapWBVWIZXI/CEZhi7om5p6B2cGoWVmpwbKC469JjulvvKpzo04+LoLhsxyjatAeH7JJUZh5mKYP0XnklaSlQEtiS9NsVNdnBD3k5bJC17x2ZTtJ7Wh/8UbNAoKk+1ykYsoFHLK2O2U1aUzsBgfNNnJBjqyR9rsblHQdFXh9iXf9PMTLr1wghepLPb2lgeiTAW9d6RrRg/hfcs8g6fv6YESRd+P3y0NxFyD944euiGhChwr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7X/EjYx6HCPlCal4H69ozBf9t5e2gt7ieIMCe8cPUY=;
 b=qpBSrXWg4tlKwZYtoN3fvig6cDjYrJ0r/IppnVcwM1aqcLTzZx2dt3FYkhwdaCdtB0XJhd4+vzJNgYkY3vnkL0WPDC9JWluhVz6XSdeKThp/0oMNMlrUAaNF4Qqz99HN/Uu0WPimUMSguC93tIuGaAde0ldmnQgdWezH2L8kf8Q=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM5PR10MB1881.namprd10.prod.outlook.com (2603:10b6:3:10c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 17:37:50 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 17:37:49 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] panic: Add panic_in_progress helper
In-Reply-To: <Ye/jhjBaN35L76BF@alley>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-2-stephen.s.brennan@oracle.com>
 <Ye/jhjBaN35L76BF@alley>
Date:   Wed, 26 Jan 2022 09:37:51 -0800
Message-ID: <87v8y6wg7k.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0110.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::8) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dfcb827-20ec-4c35-c36c-08d9e0f292a0
X-MS-TrafficTypeDiagnostic: DM5PR10MB1881:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1881DA400835A59FAD503F57DB209@DM5PR10MB1881.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYMIui4VK5ZKNY1jUwMeq1k8SpqQzQLGQpEjf/MEyRsCjx4ZMtqfotnPIj+6Q8rd3BQL8XQ+SQd6tdlD+GljnvEE/GGUb05aXcwu4UOrKg7cJMdoKHz5aWuepG/4yKmaTcArbvn4Ia9ZFy9QVrjpV+MkQpcA1/ctdpepq8mjrcaqoqyM7ZvhXqQXoxTsJpu5ST2kgF4Mp7Ugo3T9MndZ3BBTZrA3B5MyPNUaC6Dn513GkeovqLbblCiQxDYBu3IpTUG8YihxR+dL9ZaRzgWI5y+/Ks/4mtdsHQDQotGznIvwpF7eab32yKLPNCe2W4R4a9rQ7fAPIBAANHyX9cCsACBRe8eD0TMZ92AgBnaI9Nv77vFHpVybEOKboPIJ+0kObrYZxt2qAuiaxLS0KfOp8/9UG1xWAMXplnyevN/vLBk1gsuRguDcshL0euon/+mZ242hpG3WdgIQ3tjJMe4uQnVBMDGgsq4o+Kj8JVO6wgidJHMMKYB05jKBneOg4wyzFvYH/ViWB4F5XuRb2EcI+9wJxvhDq7z7/e/dHGRaay4HRLYAv7x2DKkQZ47okg3NXvVtJmNl+FGGcgflhcAOPfm5DxUx2dakYRvzZ27gpVktrC6226nEcqP8wmPbBkMRnX8Jk/xrkCyWDm3vVI9qCVg6aipE3b8C4EGNuVhfd6Wh77VcBKmSupYUKI0i4cUx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(83380400001)(66476007)(6916009)(8936002)(4326008)(8676002)(54906003)(26005)(38350700002)(86362001)(38100700002)(186003)(6486002)(2906002)(66946007)(6512007)(66556008)(6506007)(52116002)(508600001)(6666004)(5660300002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QtCjW9hyJjE58yZ1aOHRXaUy6xsW7wVarMuoM8vU3n7NR6578+VXbLi9nLSw?=
 =?us-ascii?Q?lUBTaBH0WcB+K163oKi305NwtMYGJ+XqoB3Br6NWVJ+Imal1IUzTorFJWm7N?=
 =?us-ascii?Q?Xh/343bKnoIRFVHgO/ZSLGa2DCVhytoGnjV3bK2CnO/+rHxMEtxlCEcXULsk?=
 =?us-ascii?Q?Agqs+FUqgV4eSblbhI/zLmwEL+katdzUfohwywGQSRSEh1lUO2yZ1TPQ+U5a?=
 =?us-ascii?Q?GFjTYlHc4sJtLI0F5XVuWx/F164oGXYBI3R0xKyOOu9RhowlEBIAeysV2NTC?=
 =?us-ascii?Q?T+RX9hoSuFVlw8l+3Vm/xFFlmEORC6omv6EfNOdJTcQbnJY2YffEChlHKVPx?=
 =?us-ascii?Q?EMhPiiUZIgM2iOLM880LqdGfB7dasnZm8b2Azqqw+DPEVuWS4BCqUNl8NixZ?=
 =?us-ascii?Q?PzkUvqVcVuBU6jDzNGFt3ajY53TCRwYGMOOqPYDl0I/9Hjkj0qfbbbeLKHnK?=
 =?us-ascii?Q?PGNjP8cQHJsIR2Jx1Tgx+UM8G9l03eGuYjYTOxZodRzs4GW7pal5mtteM0Qw?=
 =?us-ascii?Q?/TPK+DrPqHcXU/ixn6MzeboJUOS4z+vNE27v7tl/z2+bAzFn/HULYRi92kMl?=
 =?us-ascii?Q?MO6bQAxtqM+bBBi25Ks3w6N6CLWxEuxxd/pmEMR4gtKRxwJ/iyW2n+UUPU83?=
 =?us-ascii?Q?i0vN1FeqfQRn95znNlD0RiPeGcvIxVl9E6iat4K7viVEHIuu+2bJ6DdNPOl9?=
 =?us-ascii?Q?oT8+OTfSklTobgkUGbmcOlo8TQPkUmik73xZXHtr9y0bwjfXW4wRHZU9TKLP?=
 =?us-ascii?Q?eHbL6xGFSpK+pCd4Qs/5BGvcRIIeWatpCzQTN4gKf3bmijJ35HOGsDAmGdpa?=
 =?us-ascii?Q?y7c1ZJ1rBX2fJqSLSD+Db7V1hAF3iRI04fteKO2TeHTeFk11ei4EUBbLD/eU?=
 =?us-ascii?Q?v7F3r082aop+ibxTp9jHbA+kzTzrSKyAv0oGV/7DDRJAmNPmSfW5l5XCZJJn?=
 =?us-ascii?Q?v94rAj+l/09rDxUgXm9CmZMoBZhegKcjssiwLTuf7hLnvyPd6D01omF0iKoC?=
 =?us-ascii?Q?qH43Qwu3LPU2q493ErulQaYK8LubAzj4irqQITEgWg6woFneKnYZU/8tUSkZ?=
 =?us-ascii?Q?9yTBWnX3n4Di71Vt6c/crpC8XZlxZRQB3rzQOggAWZfRomfVVInukBUE/TkE?=
 =?us-ascii?Q?ZAz/eFJBOF5IigX7Gz+m57yV0paSD53nkw0VOc9HEvVP5QWC0ZlZaHOAimIt?=
 =?us-ascii?Q?IHzd2vJqYtOoHgzDebbZkrLS1cu8iAqabXS1lkCmF4/EwaZ5K0y6ThBL4sh6?=
 =?us-ascii?Q?1wFH45WIJk6adAT3MHiQI7jZnYoLaK0KnMLvVhB3hdwf2n3qxMMSCcwNifY3?=
 =?us-ascii?Q?3Qc8ZgMkVszLgDzSe55ECBKnJh3KniUEf23auvHUCIGjJIP/61KQ/LbNiiYR?=
 =?us-ascii?Q?OwXHhWEb08RXcxuvYsP4RQCsiT9OkITargYZIa8cVxH608Qy6WdmZ+pI1JxI?=
 =?us-ascii?Q?RsqsdtvwHUdNTIxUZA2D5NP4fITzJShc30CgP2YdcqLypWfpBSC/y7U7n/O6?=
 =?us-ascii?Q?WyBJO9sXvlNB9OA2lfcG6eLMPLeEMsH3m6OlXFTI5XdfzpbPHuxbI6hVFSTk?=
 =?us-ascii?Q?x80Is5/J5L/L0wU7GzV8lBdRjumk4VQq8omlc+WxcdP44BMeayQV3f0eGAyI?=
 =?us-ascii?Q?PR/W/FA3vMz0bfD0NfqaTJFiitHSvxUu0RcFrKfmpl0gW7ma2Q4SmTeolKKz?=
 =?us-ascii?Q?Jdr6Nw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfcb827-20ec-4c35-c36c-08d9e0f292a0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 17:37:49.9334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZFvyoyQrR7aqzkhIJVawJTCClLG7j7Po9fE0Ei6pHG7kSgF80ANIcna3a+fO6PeYCPVu4xyNmFNc5u0yeL6bfu20Z41Fupft2Wk5/oP4nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1881
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260107
X-Proofpoint-GUID: b8AUu6xozdBjSrJe9UHiXN0aK64pKS0t
X-Proofpoint-ORIG-GUID: b8AUu6xozdBjSrJe9UHiXN0aK64pKS0t
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek <pmladek@suse.com> writes:

> On Fri 2022-01-21 11:02:19, Stephen Brennan wrote:
>
> Please, add explanation why the new helper is added. It will be
> used in printk code to reduce risk of deadlocks during panic().
>
>> Suggested-by: Petr Mladek <pmladek@suse.com>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>> We cannot define a static inline without including linux/atomic.h, so
>> I just added a macro for convenience in later patches. Since macros were
>> the only option, I didn't include a helper for
>> panic_in_progress_different_cpu().
>
> What is the exact problem with including atomic.h and using static
> inline, please?

Hi Petr,

linux/panic.h is a commonly included header, and so I didn't want to
pollute the namespaces of many other compilation units. (In fact, for
stable kernels we avoid changing headers to avoid changing the hashes
produced by genksyms). It could impact compile time too.

But I suppose I was prematurely optimizing. I can make them proper
static inlines instead :)

Stephen

>
> IMHO, the define is not a real solution. The macro won't be usable
> without including atomic.h. So, it would work only by chance.
>
> But it is possible that I miss something.
>
> Best Regards,
> Petr
