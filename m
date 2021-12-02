Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909F0465E15
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355707AbhLBGQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:16:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9666 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355701AbhLBGQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:16:10 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B24nSN7023661;
        Thu, 2 Dec 2021 06:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ynNqWN8ek/tkhYqrr45b6+VDAFbsHHFhGV2l0HvzWOg=;
 b=pKs4VDA/tvgSmN/UYdPGIg9uictD4/WcA4RSJ4MyLzPzBrE+Khw273laKFA2qrjux9Iu
 fnoOTdA9TpMTCN5P0Kd4Sh1fcNWKQob4qjFRm8+1h0KekK3LkUlayxRHNVnedlng1eKC
 /WCYaXi1S2fPmFzTKnC8B/Vo6GplebzBfPZVct/m30zdopIm1qQuPLlX2m36a2plQqyC
 1qqSDvVzSGMn5l9ygE5xKuugO9eLQvsjw3WxQGeQHTKwelPKoKkJw41cCpQUYCB92BVX
 nUmcb0c23P/uvMG9aZfMnOyKdmeWrHKh0X+gZ64C6D39aXXmlh/na6g2j/Zxi92+6Efz hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9gknjpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 06:12:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B265nAi077043;
        Thu, 2 Dec 2021 06:12:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3020.oracle.com with ESMTP id 3cnhvfvfky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 06:12:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I92B73ZwR6Tk//bA7g6LkQIENPg0hOXhEDgJUF4vgql+JKyTwjRPQAf2Vi6QnUY6bpyNW3XL44UyhHsR1RYK0MTXJHZOHrLPxMx2qWC02/c6qD/SNVCqn/7VwBROFrKM+jfFw4lS2YMmhTXgSn+uyFoLfPpTGkO4MvCPDNgyxaZjxQ4nVExmXsfRylsz4tyigvoi3lRjTfFx0ydfVuBAg+KJy+75nD6Fjm8cPiLh2XpukpPe4uCrrxFus7TUoYfegauijWMsPbo8V0s2RspMoCpOag2FGUp5OUZV2lJ5hAvnfFvRYCisBGLz/W9BL9UAQs00erbc4AGvStn3yO/Z5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynNqWN8ek/tkhYqrr45b6+VDAFbsHHFhGV2l0HvzWOg=;
 b=m3QrXWZNn5onGztAB2ap8CB1k3bzcrCwGJWlzwlpAC1996q9tW4vtETBo8AlV6V34jJmo78LeLHraK/j31H3ofPT1UidFo4D7nuIlLWbyx0rLkvEN1zLffurRo913yVWqsZBjSqxfGpGkK/uQoMxnDazz5qcEGoV0IGXVJsPUmKIwtSIy6hzbnTLCZEhoHygwnIx8A2OxcNNokwSI0dfHui8t2x5r/jAdadJ2B/HoWjtbynGZ0Op+05J16QSZOAQRiQ84fpLJeBQawaK9fxvls8P4FTd0p8vXwARICZDy3voGhiv6Yoj7Tf4Ng7xbN0RUNlzf4oAfCqmWMlDndf6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynNqWN8ek/tkhYqrr45b6+VDAFbsHHFhGV2l0HvzWOg=;
 b=y+CeULTEIALUtDbqWOLhDRqiVohuSZ38r2etFdWuQLgpaamzaw2em7GCCNFYcXusNYCPf1zYQKFCXXejx0Z65/SBeHKSfBq5dRUYWO/68y5Js5mYWtYPr91ogsp4YMmA3GnT3B2p7fFq2mbD98WaFtbSjc3dAHTR/oHGxuCyfNY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2127.namprd10.prod.outlook.com
 (2603:10b6:301:33::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 06:12:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Thu, 2 Dec 2021
 06:12:30 +0000
Date:   Thu, 2 Dec 2021 09:12:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as
 __noreturn
Message-ID: <20211202061218.GA30793@kili>
References: <20211014132331.GA4811@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014132331.GA4811@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Thu, 2 Dec 2021 06:12:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d429a96-3bb9-4b0e-91bc-08d9b55ab8af
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2127:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB212755AE1D0BA12FA963ED5D8E699@MWHPR1001MB2127.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgc+Q/AjGVxtEsFmMUw7Nj/wZYOpSB/zQr+5+V6E+DBFyEcnUT6SCdRzkW22jKbUNFPNpEvdZK+slT2kke9RaiwLcRqPanY70a8pC2i6JfoufSx+FnHCDPQf7zY4CbcuuA2E3P7d3f7kxWq+uBrEqWaC0Q1k3E3zfb4bj7V8QoNG/PipvMpFi4A3X4uZe7MUnKevMlMeSKnb/R0axSH+g3NkiBKTQ/uiiTAzQhkEMOz4imZGY+9jMvEqRNhHSFlG28q9f2k5VcrrvmqhDVFDmYNq9l1fAicTSWpum0WAy7KEAHPAQjYf0T1gHFBR1KOx/XG6ZB6sXiNq3EUOvdrO7o+7eQaMO3SXr3mWMTh/cyTTEBcZs3HHsHzVTbPAtV04oKrRqTH1zL8Y0eK8vfQ+25atPMSRypXTbx0X7X4vsNy56WRf295WStOkZZTDf+JTZUraQLte3HMZEJw0odD8z2DpyYD5AnMhE6Vz8UM6Tua9nVp365ztktfaBB2sZxGMOuEwU0EtZQQg4e71yIGtsj5ihhiJMLRGXDxS+z6RwGDZP/PP9cOmuCSlE10tyndlKRQVwQaEVu9MK31X3hyJfAk+1qXzRU+mBWnNk7GluV81Qeif0jEPohWqY93XXx5hzkwNl7dfgQsiqG3eCZO1Yro6AkcQtQy65Gbgjqo9H08KVIU41Aqibd7KFknMme7X9b+zVqHmx682q55dKLoCC/8YSKEPTNCUFjIj5pKqnn7BlGCkXhSdfm1Q0B6Uu6tkwkwdNvzlTqvSp6BV4xXSTHZjfQ2fSoiQKBOM7VNGdWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(66946007)(66556008)(966005)(86362001)(66476007)(8936002)(44832011)(33716001)(83380400001)(6496006)(6916009)(4326008)(9576002)(186003)(1076003)(52116002)(2906002)(956004)(33656002)(8676002)(5660300002)(9686003)(6666004)(54906003)(316002)(508600001)(38100700002)(38350700002)(55016003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E58o2XRdexdXnTqfEv8xVdO/0e4RyxJ4u0JFzO42qBgttEaPym+E6bCKOR73?=
 =?us-ascii?Q?dAZv7k49FprztqS148dl6NJfEoPKMqfbpysl8E6GgSevDdPTbWLEh+etcJc2?=
 =?us-ascii?Q?dxKQOR5qHX4XO7ORX5lscdioPo79IqdxrvfN7EvYf375dO95ATzTOWvahJmT?=
 =?us-ascii?Q?I3zrjAmRj4Yl+XNRYhpWzrr/fTr8F15sydvZUcYY4SLmcVmzm7nRIJ6rzLRJ?=
 =?us-ascii?Q?UGairXxgLm+CFnzbfVJzkx07hXJb7m7D2iQftFok7MhLk5swlC9h7Wb9js8q?=
 =?us-ascii?Q?/UZ9RS80S4tGzq7+sRwqAr6Fih6mN3gxT2h2eWieMx76m5riOrH/IjfjZ9wo?=
 =?us-ascii?Q?bIHMJ7y11BTfhpnqUt6g5dBGvh0j2+3xmEbh2B3fbllAJw+lSrvEFG3Jucdr?=
 =?us-ascii?Q?eTEmoJCdqnfjKsPLsoSKQJ+sEBjqhOKnHaxT89+lPV+aHJ/UCsqRFsXvMhkt?=
 =?us-ascii?Q?MziRP6pnTmcpx91e3Zpe4daA12+6zDWo1uiFfQehsBPuWxSBMJ0VB17pB9ae?=
 =?us-ascii?Q?pU42s580zbkNSdLxFH7eYCFbIErK7s3wmkA6bF3WsbKemiTBGpPabJWQSvu4?=
 =?us-ascii?Q?Hfpfursw6Ts+nTX8HJj6kgaQkikzf7BDrn4dMuBcZHRCG4yfAglA0q+qVg5e?=
 =?us-ascii?Q?Absf59VofSVSTb58F3zoEcKK+p3UDLr6SrDpXUNV/dKMv53y42NYifK5hZv2?=
 =?us-ascii?Q?uxgL+ihEahADPEbv4H71J2mflk5zIaYk4cesuvwN9u0o+B3V1qerhuxmodfF?=
 =?us-ascii?Q?alBDQOcsYUyuh8g8noBHqAP3N0Tj3FJd99304y41NFS+lJrasX/B0N9rLN1y?=
 =?us-ascii?Q?wRD38y4ceJAcE3JRW29x7ekH66GaNk3a8P2G2qzQ9zAMqAfcvhnelZ/cCfKY?=
 =?us-ascii?Q?MenJQB0iOjIEl6EC2bgIUTcDbe3IIH7cVs2WvmDbxv5RbMbsas+9tBExTaXc?=
 =?us-ascii?Q?B56+7X3G3imRlDmXMm1FB0NIxs604Fd2OXIlIHHcC5omrFK3ob7MnG8mYnO3?=
 =?us-ascii?Q?EsyPk9eUDoxgAawlgyo4il7KmWodvPdKPvO6eAXIjXNwfrejont4y+8OAWSp?=
 =?us-ascii?Q?HVGObJTEbReBfWZztTAyV3z4UG6k3EHCra0WUpQriOTINu/1UCzjDRVoo/Gt?=
 =?us-ascii?Q?QwJ1lN2omWEl8QH10Yoh+lZkgHcq0ttib0/WovMu/27mGKEeWas2qPQtjAjP?=
 =?us-ascii?Q?3AG5PgrL+iCWpIlh7+NYitQAr438vl2o6YZBPwANqscHkWnx6RSTJJ/+eSsY?=
 =?us-ascii?Q?lgXyqE6ky8Zk9+AMf8yucDqsdvIzzGUYvamcB4gE/RB0gDeFmCECNwafnYCn?=
 =?us-ascii?Q?BY16O4bfyHskl+KezBE9EnLv7Vy4DSZ+/uEktsTu1HMWm5KIXycPQBgb/NpV?=
 =?us-ascii?Q?BzPPZxRAkrWBbRDdID4rDTM1e+IO5yT3w2+fWvqd7sbmmoME+SIByK8yJone?=
 =?us-ascii?Q?DEcd21DK8IJl9oK+K+9/rRx/Qaht1evVeVCCSABuZSLj0/pv6DcWzcgev3LX?=
 =?us-ascii?Q?ie48bb/6BwxhJOnPFLpuIdSrmUomg9aQnH3PQTTVPCCzLiRXb3xbiqFAK8hQ?=
 =?us-ascii?Q?5uYT9I0CyaZo3o9XjfXlvr8C+Fp/N9/XZ+m7IXqOhm0TjJAn2cM/kG/IZvP/?=
 =?us-ascii?Q?cTZAe4om781uqNSSAKJwWUsb3Nclc28NHIaQCCm7nYhRX+D15aX6McKbq9TD?=
 =?us-ascii?Q?VAF0KrHaAu4f7s9fQG7QVbtfmvU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d429a96-3bb9-4b0e-91bc-08d9b55ab8af
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 06:12:30.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0WsNnizNdsI81MUZydOfy8+L9Lmiv+cpfU+X+m3W1Jk8WzAxm190fSxoF8Xx+ijITjBaW838bzuropS8/K8zHYVPS7vmIBsl2X8vF+CA9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2127
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112020034
X-Proofpoint-ORIG-GUID: ca9qol357TRk4QZ0wt19SUo6RdlOS8V4
X-Proofpoint-GUID: ca9qol357TRk4QZ0wt19SUo6RdlOS8V4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 03:23:31PM +0200, Miguel Ojeda wrote:
> `__compiletime_assert` declares a fake `extern` function
> which appears (to the compiler) to be called when the test fails.
> 
> Therefore, compilers may emit possibly-uninitialized warnings
> in some cases, even if it will be an error anyway (for compilers
> supporting the `error` attribute, e.g. GCC and Clang >= 14)
> or a link failure (for those that do not, e.g. Clang < 14).
> 
> Annotating the fake function as `__noreturn` gives them
> the information they need to avoid the warning,
> e.g. see https://godbolt.org/z/x1v69jjYY.
> 
> Link: https://lore.kernel.org/llvm/202110100514.3h9CI4s0-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

This patch is kind of a headache for Smatch.

The patch basically turns BUILD_BUG() into BUG().  That's fine.

But it also turn BUILD_BUG_ON(!__builtin_constant_p(foo) into a BUG_ON().
A lot of places call BUILD_BUG_ON() to ensure that functions are inlined
and the build breaks if not.  For example, the FIELD_GET() macro will
trigger a build bug if "mask" is not a compile time constant.

   295  static __always_inline u32 cal_read_field(struct cal_dev *cal, u32 offset, u32 mask)
   296  {
   297          return FIELD_GET(mask, cal_read(cal, offset));
   298  }

Unfortunately, Smatch doesn't respect the __always_inline annotation so
now it thinks cal_read_field calls BUG() and records it as a noreturn
function.  And all the callers get marked as noreturn functions as well.

Could we make it so that BUILD_BUG() is a noreturn function and
BUILD_BUG_ON() is left as it was?

regards,
dan carpenter

