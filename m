Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4205A4E61ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349577AbiCXKr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346320AbiCXKr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:47:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3B19E9FD;
        Thu, 24 Mar 2022 03:45:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22O8jmR4018508;
        Thu, 24 Mar 2022 10:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=lwM3JRLAyOXwJtXxc4l1HgCABPhoLC8S95YtJ9eOcFg=;
 b=tYmDmZ4LYvJLU0z+4uI93Xrgs9PQDQGtfIWHtjPExD2tgHqjWC4tuEPd0gXfCHbHtcvK
 R046WcOV5c04tokT3XBt2Xz/7gAlryfS9mt3wogT+H3n9LYVT/coL/rfocrbVewZcdzy
 Z2Kc9dhO3yFTMK2gwuFaS1eT7grztfqjweYqKDMKFhKfl5oDvdiUIS3cTnKDpFZVfREz
 QQKrPyxSwECV7Brq8JQuF0ewHey64KtBoS+eO2EYZ872TT0am9qcAtz3XpXaVp6G+foJ
 VTnTl5OBls/995yfPdfPR51IBsBzZ9DDVoc1xx7tPEQmNo1gGa+mvVz+DjigViyJ7GXX CA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6ssc1a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 10:45:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OAeVU4189460;
        Thu, 24 Mar 2022 10:45:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3020.oracle.com with ESMTP id 3ew701r610-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 10:45:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biVFWASuw2J/VLgi52iLfG7CeXX4XQ4bsaWzZHmPXx8LrfOC8onBRIj9NAqo1YECYopadcrgeWNsb/F824XsT4p9FcFGN9b3i0y3WZejdNfBPMwoK0wN1ZQyO38LYdLDkg+ryQ5hF8At/a47bAKC6YW3wj4npO5vAz3gyNXvRGU6zacHRKgOSZl5s1YUOWCKO+DSK2gwsqqzVT7cSmzO6imgdJHQV0LrrM7Sa0Fdw/6gcEqE0+3snQYIw0O6NOq9wt4jSH4zJNmuN1LV9eC8TQhcQ3HuEHyONvGjkcWDkegBGKWyG1C2ug4b2hAA1goatkt88IhS14Lo7dNC57VnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwM3JRLAyOXwJtXxc4l1HgCABPhoLC8S95YtJ9eOcFg=;
 b=L+7GK7E4StaJgHaffCho/0G4yp7H+CS9hhehv8z8mAczDLM2HLu5SEw1dEj7FC/zLF2i0brb+s0yCMex56h7KlLkaGq0IzeG4QZMou8pRRSVf+3fGYyHjawZbNH0JQf9yJxgJXepEMF2H1M3Nlx3tlgoA/T87ozZGQjbdu2T3NxWw4wFumI7jnFTbyx9LcuaqBs9Eq0hrAcK8KAwxR7VPbNOX36p+oZuDqbpqMFQEzQbjGhwAlMYO7Eyeu9HPep6dxHHpbikeNl93HjpTQnHn19E+lpDEC+r+vN5gJ1d6AF2HQfbd4R++PfmECNWnL5217iZjhCcAh7l39NGX8NhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwM3JRLAyOXwJtXxc4l1HgCABPhoLC8S95YtJ9eOcFg=;
 b=I/N47g+kU/E7ALxBpv16ilnbJc31CLZZ32DQAlAfqmmPCXOE3BnOqb0chsG63guFwzfAIV5xSl+DB3w8ZKXo/xjIiQ8gG32gplzobdKP8X4EHledGo3AqjyAnQNtO+QLy9bSkur2QYPJQ73Bttz3Xoou0QOWK2mAmtPgJjtksyo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB3782.namprd10.prod.outlook.com
 (2603:10b6:610:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 10:45:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Thu, 24 Mar 2022
 10:45:46 +0000
Date:   Thu, 24 Mar 2022 13:45:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [kbuild] [djwong-xfs:djwong-wtf 349/351]
 fs/xfs/xfs_bmap_util.c:1372 xfs_map_free_extent() warn: missing error code
 'error'
Message-ID: <20220324104521.GF12805@kadam>
References: <202203190831.AYu7l0vX-lkp@intel.com>
 <20220321215908.GL8241@magnolia>
 <20220322054726.GR336@kadam>
 <20220322163827.GQ8241@magnolia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322163827.GQ8241@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b7ae28-22ec-4c4b-5b4e-08da0d8373e0
X-MS-TrafficTypeDiagnostic: CH2PR10MB3782:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3782B1A2C6CE551878C0DF4C8E199@CH2PR10MB3782.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOEGckaDRj5saa4pxqRx6P3lyYcm101eVBhG9GMH2bK63JsoVgqOlUGn+F45PBktyorqMXO4IgqPi1u8P+Ucf4Gdi3RNC+2mNyC2fD21QiHDKQbpsgCEuTeqet1BH10ycL6+AnZ9IDxURi87i52DKK9l7WVEj+JDHvCIvLnVtOHswiBohC97zPtnKLGSUmqjZVN/dhw5LmnrPi/vE4V2VRmFviqEAQFcsNb/NCSsQAkJunsNoMbCWOdffY5Vq5n287cOkT0Zt+RqBoI1POZGikR5Yfs7Gv7g9Br9vw6vX4qyqkNzsEYJetiXSmnKAgcznCb/JMZXDebKGAzynSWxrgcXy85SvFmeva9y1bGu+CGDpJjJsv+/xEopLOtvRqs1SrrJgj4e5R88stGfUY9U3yiL4TyHqqg24n77lF8gqhw+s9zVd8Ic8UNUGBO/YPflFfmNJ6ZudgUPjuSPtfEYjKwN6qZnIcvJBdG2skYIiFlWUqDDPJPp+ZtqqKYOWJVbBf+VUmRk2Cl3bp+3n0+xVmuBvYsh5Ot80Ah5Pbo2WQtHiB3XG5lUXiqnt80WRWcYb2h/9mMehmN2+97fo56R4gALde1dgZCEnh49ScOAo2IN6Nzg2swYPxu180lHUIYqX+JmOxtYFAUrLB6E/wydvx2nzI/iOJtOZ8b689cG/HGPy7ypfyCMJ+0kd1+DNPJeo829oyiF2MYT+AOj9ZTBQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(44832011)(33716001)(8936002)(38350700002)(6916009)(5660300002)(83380400001)(54906003)(33656002)(508600001)(6486002)(2906002)(6512007)(6666004)(86362001)(6506007)(9686003)(186003)(1076003)(26005)(316002)(66556008)(66946007)(8676002)(4326008)(66476007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7SJ9S3PWYvwAsy5cgrwHXBsKLPm3h6XkwbtAAxt/MYH2WjgH95tt9+dP8d5p?=
 =?us-ascii?Q?xXBLLNiyPG1lGfDingcUxALfu49dfL7ac7eetGZc+zxJ1JuPaYmgYyzbzzJC?=
 =?us-ascii?Q?PDqVHUJi/J7BcVVUUPGXaEgvsVIKWck67oZ4Uio8TC3GblrWULuzWWJB7pDM?=
 =?us-ascii?Q?Gimqv+wqkbKY4pZtt2lRjEGSyY9NsldVjlfeq81Z08+j7YxMAgkHRBFAIxqT?=
 =?us-ascii?Q?XoCQmEARchNATJ5ilh9Y0FY7U2Z/hxKX3NzN5sg08LdWsBEHa+7yR1j+uke+?=
 =?us-ascii?Q?PcR/NssO9OaG443ySrSLxuND2g9xaCQu12nYbLpAD41Gd9fIlYqch5RwtWze?=
 =?us-ascii?Q?X41RKxklMoso6lcrfhQlFAjC1ZXsZlUXauFpsnZjYIpiTeNKkoo63ZyWOCZ6?=
 =?us-ascii?Q?VE2Xk9JwfI7RjdsO/TenblctJ+S0RKZncoMCPrcaIHAX0ljfoV5jt+DSfAkF?=
 =?us-ascii?Q?uZTkUfxuvIeuIRK1T2ijxs0iQdj8T+Nkz6GPlu6yOnqqnZfQZXp9JaKo0HlC?=
 =?us-ascii?Q?biF/SPAQYDq6HkybvlEmUtC8violtHF4hmLEsplzwN7nFsYOE9h62hXxQcrw?=
 =?us-ascii?Q?tdTcyp1N36ipDLt7MvcPPqNNAsnrLXJUSzk8LDaZwshBpEcWZNTg/pDu9zlw?=
 =?us-ascii?Q?rBpuDld6EMTsH7/jULO7SMdW7fdoIVTwsKZrEcCPdllR2h/cumNRWA9o+GmZ?=
 =?us-ascii?Q?oxI9qIDWD34/V+PnoxaZMcbHp1kj2ftc2ZyiVj9XaD3tI0RW3LBqsZ/Rj18Z?=
 =?us-ascii?Q?MwnaZ1Gbok2iNzVCe+aF88i8Yz4mp9vGKd7nqGBgHA37vMwxY85bYVdqxI1Q?=
 =?us-ascii?Q?4Oaxx98BEHwgv9CGeyPnPil8CSRQbdYGACOLskuuAcsBR3IRpLdX03GWjkJQ?=
 =?us-ascii?Q?pXrLtdbeFua9Cu9P9bmvoxqTuTcZsW2ZMpRUh4kAtQwxJ8i8zgoLeyOfPs3t?=
 =?us-ascii?Q?g3HDQptR5K7Lcu760+zBPVQ9YVJc/4gFReaBnMIwNvGe7EOEvrgWZshJTur1?=
 =?us-ascii?Q?a0mrgDBpcl2KhY8Pva4LgDGkkvKRETqrz33DFKTuYEv0N54oXAnB0lYbnEHk?=
 =?us-ascii?Q?deeWiNVKjUFgNR+O4H4W14ox6be+UCjp2lSudfqPM05jDcn0abWYyERT46hQ?=
 =?us-ascii?Q?gW8AXk0VQMOoMI8D8UF3Db00KInkUP6cLd7dmjbJc8Y7HG4xSSQ27B0zUZv2?=
 =?us-ascii?Q?PKyOzo0RHaaaanuh69XdIcLABBkJImDwtZcoUl4d8joYGror4vdVY7eW6gjo?=
 =?us-ascii?Q?oQQmTTQkyzo4RsxZtI3QuuEE+CdOLovIwQbBNPMFpSd/IhVZGeq03WowT+Rq?=
 =?us-ascii?Q?MBYAGYXfA8llhH9XMaZ3/VGdak2b55Hrrf4z16yPohfJaPL+dLT+M0cD7tXc?=
 =?us-ascii?Q?ZUT1c4JrWM74WRG4YYAuY5LIYMIodwh6gIbxe4o8ktMQlm+LZ8MJHQVWjeo7?=
 =?us-ascii?Q?3azL7Fq90NlDnk1JCv4lYG4YMrAUWDjuSD7DWMSDJCeY2OGvLXiqkw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b7ae28-22ec-4c4b-5b4e-08da0d8373e0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 10:45:46.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmRT2rTvikxIb06zD7Pd5Lt4ZoltuHr0VVjfgMwHGof9OCCGCM2kLsLUrWtGgm5bSFgIkmpK5ezFzNyJGFPuCJVXLufF2KWuIcxDhwljjVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3782
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=857 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240062
X-Proofpoint-ORIG-GUID: 9085oreK4-7RJnSWNk0sPP8ZZP21HJPE
X-Proofpoint-GUID: 9085oreK4-7RJnSWNk0sPP8ZZP21HJPE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 09:38:27AM -0700, Darrick J. Wong wrote:
> On Tue, Mar 22, 2022 at 08:47:26AM +0300, Dan Carpenter wrote:
> > On Mon, Mar 21, 2022 at 02:59:08PM -0700, Darrick J. Wong wrote:
> > > On Mon, Mar 21, 2022 at 10:33:02AM +0300, Dan Carpenter wrote:
> > > > b82670045aab66 Darrick J. Wong 2022-01-06  1365  
> > > > b82670045aab66 Darrick J. Wong 2022-01-06  1366  	error = xfs_alloc_find_freesp(tp, pag, cursor, end_agbno, &len);
> > > > b82670045aab66 Darrick J. Wong 2022-01-06  1367  	if (error)
> > > > b82670045aab66 Darrick J. Wong 2022-01-06  1368  		goto out_cancel;
> > > > b82670045aab66 Darrick J. Wong 2022-01-06  1369  
> > > > b82670045aab66 Darrick J. Wong 2022-01-06  1370  	/* Bail out if the cursor is beyond what we asked for. */
> > > > b82670045aab66 Darrick J. Wong 2022-01-06  1371  	if (*cursor >= end_agbno)
> > > > b82670045aab66 Darrick J. Wong 2022-01-06 @1372  		goto out_cancel;
> > > > 
> > > > This looks like it should have an error = -EINVAL;
> > > 
> > > Nope.  If xfs_alloc_find_freesp moves @cursor goes beyond end_agbno, we
> > > want to exit early so that the xfs_map_free_extent caller will return to
> > > userspace.
> > > 
> > > --D
> > 
> > I'm generally pretty happy with this static checker rule.  Returning
> > success on a failure path almost always results if something bad like a
> > NULL deref or a use after free.  But false positives are a real risk
> > because it's tempting to add an error code to this and introduce a bug.
> > 
> > Smatch will not print the warning if error is set within 4 lines of the
> > goto.
> > 	error = 0;
> > 	if (*cursor >= end_agbno)
> > 		goto out_cancel;
> 
> The trouble is, if I do that:
> 
> 	error = xfs_alloc_find_freesp(...);
> 	if (error)
> 		goto out_cancel;
> 
> 	error = 0;
> 	if (*cursor >= end_agbno)
> 		goto out_cancel;
> 
> then I'll get patch reviewers and/or tools complaining about setting
> error to zero unnecessarily.

Currently nothing would complain.  What causes complaints if the
assignments are not used.  Places where we assign a value and then
immediately re-assign over it.

It would only take a few minutes to write a checker rule which would
complain about assigning "ret = 0;" if we already know that foo was
zero, but hopefully no one will write it.

The closest is that Christophe JAILLET has a script to remove
duplicative memset()s to zero.

> Either way we end up with a lot of code
> golf for something the compiler will probably remove for us.
> 
> Question: Can sparse detect that the if() test involves a comparison
> between a non-pointer function argument and a dereferenced pointer
> argument?  Would that be sufficient to detect functions that advance a
> cursor passed in by the caller and return early when the cursor moves
> outside of a range also specified by the caller?

This is a Smatch test (not Sparse).  Smatch doesn't have code to
detect/describe that right now...  I'm not sure if the heuristic is very
useful.  I will look at future false positives and see if it applies.

regards,
dan carpenter
