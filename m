Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5632B49C367
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiAZGA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:00:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32558 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234275AbiAZGAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:00:55 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q4dCFB010061;
        Wed, 26 Jan 2022 06:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=q2j2MqwTytob6dbo9dxxK4qCBfabKdefJv46Mri5PxE=;
 b=fdwjHKCfsauDTRkJbqcAVyQlXTvMs1VUI+rUsR9qlLarl1S+Xs+B2r2JWfH7Vesl2z22
 DNxfl8PXTGbg//owUIXQENXZYjBTQm0G2WGurG6bV9vz5fCGxLcxSRNoAw6HNTwXkXUr
 PhySN6mX3ax3g/ICi8BoU0fcUb6DmjSA7Dc8vU4cyhwfhln49clBgDktbFnclVHwRZcO
 pkdU8AMha5jShE3Ne6QU816GOM22K3GwmeeUgX9Yx0M9+2qWzE92sjKZ4MZd/MurGRxK
 wUWzpoccfJKvG8QMXh9nymsUP7BOgAxOkeE1uva1cuOe3I65p+buIdayFFcFC+wG0h9F VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfn2a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 06:00:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q5pKw0181428;
        Wed, 26 Jan 2022 06:00:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3dr7yh5h9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 06:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGayL5BR3vv6g+W6To6iNTJdR+beyc0w8kWL7tXHlZMYklPOH72ooEnOuuLTOKdfGmnAmaRISyjsQwlTsxcBlzRkPnrsrPIXBDTQwanPn3/dB2dGoG3T7xlM18HRH1x3t5HZQiYl08EQ22YGE0EFaiJ+nzdUHLnqfMVIO4e3qGmsFXLRIv5vX8F+zsShAHCBhne4K5TWrrhRsDjeZzWAEcnGa52LniOFfSLtWde8mKGWC8zhH+ZCPqWQ/QcRD4lhDJ7LgGCf4fJkBm67mGSZJ05KspEE1s4i9bG7/4zieMGXos8OAYDQgSDpWHWI/w3QZoS73+SAxKJA2Glb2/yJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2j2MqwTytob6dbo9dxxK4qCBfabKdefJv46Mri5PxE=;
 b=kdKtJ/HaOqdQcOpFQM05rb6mRVUMdTvn4RiBCh181M5wltKVvic7inTK/4gUaQksULue6Gw0Ev3Fx+jm6/r2QCG0lDNXa6EuSWzAjzO02GvfQKsrwonA9hBx2JfWeHtAwoW4q9I/GUY0xMro2WYYR0hyd0iNL02h9UBkClz+BNcNztGxLOIGTMzMp0NSHCrBZlYjMCPJc8yWRiBvJkkiQrBC1s9VVqHnlwZpRuty7ljjl4QZLMC0swIOBtHvrSj44GcPiKEpwy1fWcG3tfWe+rmnUuLuYalxJoQrEniNaofb8sptt7/r2h00Cv70JE1Pj1nCggMGxxLz8ofTP+CPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2j2MqwTytob6dbo9dxxK4qCBfabKdefJv46Mri5PxE=;
 b=NF7MNF+HakTkMrdlhqtHYDXP4yE2lx4MdAd3EZSfWyd9AhMOmqTfGHcJI1RpsDO/0nijqffOgUmzavRLBE3i37M/iZGKNeDTkmpiI245pCXkkp35CMUxX4OCB14qM2IdBzKS72KpSv7o5cQSUdhTVODMoY6U8fBn5TzvtXWhzGk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4713.namprd10.prod.outlook.com
 (2603:10b6:806:11d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 06:00:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 06:00:37 +0000
Date:   Wed, 26 Jan 2022 09:00:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: Re: [PATCH 02/10] staging: r8188eu: remove smaller sets of DBG_88E
 calls from core dir
Message-ID: <20220126060017.GU1978@kadam>
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-3-phil@philpotter.co.uk>
 <20220125090233.GR1978@kadam>
 <YfCbw3ENI/1tEdwi@equinox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfCbw3ENI/1tEdwi@equinox>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dded115a-9bf4-45fd-d692-08d9e0912c4b
X-MS-TrafficTypeDiagnostic: SA2PR10MB4713:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB471345AEBDF312C3C136E49A8E209@SA2PR10MB4713.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbATF1pa49HI3rAhvuUwbAsRwrG3LVY/Ia2M2FggnhYTD+n0j+Jax8F7nDvxFw81alx7KiUL5KIC84TlQMgtVP2aTWmCS2xIdBl0szuocYrhNKEJbfsijf7v/dZBCgmPdQIplIKDDxLG3ltXK+aB+YLlwttKYILMrDvjsBiNiMNKg124MoB2pzSEMx/kq+BMHpjwkDzWvoGlgXylnDK/yYiXKsCvLqgTjebAArYwqcyYh2bxmDdKX+BfX+68xgStcRIOIiwq40xslYE37AJyePxL/dT3RsYC57eX8tVPTeEAS4GWYax4Cy6r54BQFQ0CEkeAg17gKy3A9UsbPHU0CTC0cUU9JVajwlkblMCRoCz9gpOse50UuhCA53Xkb8YAw3Jx70rNONDtVNfDpiQJ3on8/tUoi0HoogD20JrPKu8Hb9zMi1zrtp3Ai73vta21eBzQOG3JtXCp2yTyPxz0ge8XReTmh4Z5NfPrVfiL4mTdkz+fwy7fCG9/463830l8+k+S53SVvB/97T+QmSXoVblHC+ooEhXU5nLXbN/wgAyHprWj6Y8+6ETrULCW0rHV1srjKic1IKY7LNgj1st5YjjIeOOdLQHOJY2ySXwqPUjQ5GZ+thduaE/6FlYTkd8lxnj8lPAFryyVae2KnX2ztYZkghfTbEZ5EDoENkAaUfprbytcK6heT7ix7niBosilEXBuZwgEWzSRKUNGZ+QDnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(316002)(1076003)(8936002)(86362001)(8676002)(66946007)(186003)(26005)(33716001)(6512007)(44832011)(6666004)(508600001)(5660300002)(83380400001)(9686003)(52116002)(6486002)(66556008)(6916009)(4326008)(38100700002)(6506007)(38350700002)(66476007)(2906002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DEldKCibHmkMgx8V8hxhr3vRvudUbFPGg7xNhQr9HCU+7EKhoJExWpQR1eOm?=
 =?us-ascii?Q?vPXASGYm5utfjvvZVcZH4aTo3a8NwCKoDNrGLy5EJMyC6TXJGJKV/To8Nk3+?=
 =?us-ascii?Q?JQHQPXaPo5+l3Mwf48oURUtln8+sPvd8HjeL9eJZV7QtbqcHcr5+4CfLCD2o?=
 =?us-ascii?Q?UN2Kc1Rr032e7W370TfFpXJQWWIpu+TcoF7psGKgZCZbSr/lvb7RaMuCjgn1?=
 =?us-ascii?Q?1a1oQl4N2ujdFABsXR5LwQq8RiffzNIOFc+GpoSJA+GVjxkaRlXuwOXeKGIF?=
 =?us-ascii?Q?rUH9QfyD/RAQiDOCmPO+B1sDGiNppcsPJhZ6N4tQsZTeBaFr19RpgEXgKA4N?=
 =?us-ascii?Q?oMo9Cl+3us2wFZnzLt95DI/GNhbBmJGBfLbvKjggD9qQVsjNRWkmjskq50Oj?=
 =?us-ascii?Q?LIut8nsptUKpAJ3i8Cbptte+QF5i/KipTn3VhlAf9LOoejbw1f60I7ZFV9xm?=
 =?us-ascii?Q?2Ri9yFvcvy6DThSceCpDREdzEPLaOK8e+wKxJeu3o3g7CMNJk+5hS0OPPOqq?=
 =?us-ascii?Q?gAqwSp/ejBqihCeUyja1KN1f5NlUQVqnMaMTNytqw+LP3tSl9nMag5k1M6Ll?=
 =?us-ascii?Q?sITDUAfhkfiw0tUvDUxeFpaUg0h3poDF4EXvc4UsgNKDESIb0AnNJzpcAm8s?=
 =?us-ascii?Q?7LNJIHzdfa8lFiC/cNXoSoizxGtTVTEQZGsuJkJL7EQDlUvk87brJkxsBqs5?=
 =?us-ascii?Q?pcgy7ft2KGRmjS5t23zCvUmCjhI0+r3ioj+JR+Zr0kpExAXKqCrxw5Dy8d0g?=
 =?us-ascii?Q?DZhG/TGHU9h75FvffXw5WBeKepuT4ci6icfvPOnj3yRI/EHd5m9jcKuGEqJy?=
 =?us-ascii?Q?NVDVqtGGjF63bctupFLNcbFNQ4AEpKLvxTisKXhF9ODKZdnLOosMloPgiUoX?=
 =?us-ascii?Q?DSzg3TlGnum2GklIyzBQB/VnCWX4e2iAamfZai/xPld9KQVX7nvavzUaxB8I?=
 =?us-ascii?Q?6ZANm2RYzt9empkpKzwJzl0Jtj+QAm5Hnf6A2GsYDQIAVMdJEJFRAC+4IAZ8?=
 =?us-ascii?Q?Il0FbNN+YhIs/6JqxRTbwCaygl3Owtqj92eMYC1BAToTA7m8tdAwfJZ+EoQc?=
 =?us-ascii?Q?JDYnQvhE39sY4R8xC9N+2GtGp2OQYtvd9Tpe93qwCKtlWB12DMyHEaWVE8n8?=
 =?us-ascii?Q?L1zz2VZtaOT7HWefG21jymfn22JU7jQZdK98WvfN/9czJOpdCLsoho7S14Iu?=
 =?us-ascii?Q?nHv/gQDrMA6qCahXUUD9PYyBIt6YwwyRcQQE5Ctrq/hTsOFRJQSPqemA9tRB?=
 =?us-ascii?Q?8MIJkERPFiE7FU/Yiziq1sDScIdWugtmnhzMNXASciDo4Yb0t/zmApvMaYk/?=
 =?us-ascii?Q?iBiU7UDXe0a2NkeKdGUY8eF8pKBcFsxIHjSvINFdWuuSVVtdecO8hFlIOTkj?=
 =?us-ascii?Q?clQN6lno76r7xyvJ5wcI8Ghax+85gcKkW3dlbT26n2y+1TJ4ua0Y7RyLIJ7u?=
 =?us-ascii?Q?zQ8yq4TjqdMfGlVlkGb4Hz6qEQRGPPo/hXEIdxWu/LKDv2R6eIadv/TnoT8d?=
 =?us-ascii?Q?Et3pPm+8hXUjdQ/Y9wwi5S6hI5Dt4BcT5QxDKENOBUhVOoU8NxEPPOvZ/10p?=
 =?us-ascii?Q?fGZyasXJLFkNUMldaS8GtSXQzdY8rMyP+/xpz45RLAHIAQwlK5/bwseFPWgf?=
 =?us-ascii?Q?TG5qHSVcP+5gipA0wECPas8r207qsMzzT35aGczScbGOnjBgG7MG4SOmkozC?=
 =?us-ascii?Q?BOs1+HjtUVrFLUv5b2LGqdY9RBI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dded115a-9bf4-45fd-d692-08d9e0912c4b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 06:00:37.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ptlaXOML1jLayoX8E/urPTozbdpFe8hlwZJuVDZy8GDzl4Iryr3zb48+2+PdW927YyfCPPoNS/xS+xOGRm+CIcwiOvZUAYtGH+GI2dEuW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4713
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260031
X-Proofpoint-GUID: sJ7BMzSuUQrJiazPLtstABhICkR8kQMx
X-Proofpoint-ORIG-GUID: sJ7BMzSuUQrJiazPLtstABhICkR8kQMx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:54:27AM +0000, Phillip Potter wrote:
> On Tue, Jan 25, 2022 at 12:02:33PM +0300, Dan Carpenter wrote:
> > On Mon, Jan 24, 2022 at 10:44:07PM +0000, Phillip Potter wrote:
> > >  void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
> > >  {
> > >  	if (*sctx) {
> > > -		if (rtw_sctx_chk_waring_status(status))
> > > -			DBG_88E("%s status:%d\n", __func__, status);
> > > +		rtw_sctx_chk_waring_status(status);
> > 
> > In a follow on patch, can you just remove the rtw_sctx_chk_waring_status()
> > function?
> > 
> > Looking through these warnings, a mass delete is the right thing.  The
> > debugging messages are garbage.  Use ftrace.  Some of the errors are
> > debug level so they will never be seen.  If you enable printing error
> > messages, it print a debug information but at error level so that's
> > useless.  Forget about it.  Just delete it.
> > 
> > You're going to need to redo these again because kbuild found some
> > build warnings...
> > 
> > Normally we would say if you're deleting a printk() and that makes the
> > curly braces unnecessary, then you have to delete the curly braces in
> > the same patch.  But in this case, you're changing a ton of code and
> > deleting the curly braces makes it hard to review.  I would prefer it
> > if you just deleted the printks and fixed up the curly braces in a
> > follow up patch.  And please don't fix long line warnings either.  Do
> > that in another even later patch if you want.
> > 
> > You do need to fix any build warnings about unused variables etc, but
> > don't worry about checkpatch until the end.
> > 
> > Basically as much as possible I'd prefer to only see deleted lines in
> > this patch.  No insertions.
> > 
> >  12 files changed, 66 insertions(+), 472 deletions(-)
> > 
> > There was one function where you removed the padatper argument because
> > it wasn't necessary.  That's great but do it in a follow on patch.
> > Keep a notepad app next to your vim and write down notes as you go:
> > 
> > 0) Re-run checkpatch and delete unnecessary curly braces
> > 1) Delete rtw_sctx_chk_waring_status()
> > 2) padatper not needed for frob_whatever()
> > 3) Fix long lines
> > 
> > regards,
> > dan carpenter
> 
> Hi Dan,
> 
> Thank you for the feedback - reason I removed the padapter arg is
> because I was the one that added it. To be clear, you're happy with this
> and the brace changes etc. as long as I take them out within a separate
> patch at the end of the series?
> 

Yes, please.  It's not normally what we tell people to do but with this
kind of mass delete patch it makes things easier to review if that step
is done separately.

regards,
dan carpenter

