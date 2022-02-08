Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C344AD705
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359445AbiBHLbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356716AbiBHKzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:55:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AC1C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:55:10 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2189srsc012748;
        Tue, 8 Feb 2022 10:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=nmfl7ChnpRlDiCuxf6UPYh1kt1S0xBJx+q96F5/nveY=;
 b=1MUNi3AWmRRmx3dCXggq/i3cUaI+TnO5I9wyddNoYQ8j1jj528s11Qmj8b3O3s8OIFQT
 BnUcZA4uI+1xVR9Voy8KhsyfMTYK4V6FMzQ8VBLLviy1ETjNmk3KA+aaiQUxsmED6rzo
 QplRyE1Cq/1Gikkx+NRH4nrPlyziv7zWp2PWN2klrGFHwYW5gtMFMKx/Cg/hlpNth+T6
 uFSc8AknPu8nNSLhDXcDSmATju7B4Mnk4I6XRzMXqOofXpXUYPTPG/mlDpyVZ+hGoD3U
 bREH/RPWYmiEBd6H//xOq+ovsC7LJHXUZZ+I4aY2TLKQO+sKkzTrmRzbfSqEfcbOGCtH +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgh46k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 10:54:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218ApXJg048750;
        Tue, 8 Feb 2022 10:54:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3020.oracle.com with ESMTP id 3e1h25w8j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 10:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmYxKCc53wTm3KxXu9CKGOnJ0wcKSz7SwgOG303KkZBzC1+2HP9XWYlNZIkyFSt96Drr/pUAzggKLgn6tJshPwtnTY5b2NKZl/B1kSt5+kzeW0icWILBQClV6HFD2hmXmTw3ywlU6YVMXLterTV+4iGeuBPzTHcDJzH9dqnubAdKn6b0m6nodQNG6TcKEbEtlhbyctjBcDTt1YTqjlZedAxt7jFf9x4KQj7d1yk1OZi7468GZ6XSKxU8uAPs8IqXWoqs9hx8uWCOHpnGl/O72/+bZ6zzUNVl+2v8XbbCyftbtpw8GjZnkqfYqzAB6C/wxIlYRk3nNleLuBdfIPya9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtifcVc/f3sSvSAuo4Gw9eM1S2ZOS3mwlxOXCR/F8Sg=;
 b=N4pvJD/hmKdhjccrkG4/g6LlLPiCbS0ivhBa30TQrIVGCING6iM74Qfh7gGnRkscgRFge33/33iQNHawfSOl2lX2xrn4RonZ6mNC2D8Q3Gu9+mdFd5mbL9b+jB5GZHz5TIjaJ0bxPya9k3cnZoetYZppQ171vyqHnqgYjG9mVa5nXBDse+1YJc7HJ6RNckGcosdDxAdqPore431T4PGSpxgnqqbWOcig5HVDHckSVe+eHFQf8YRyolNVYthpBr9TlklQ0SH5qO8ezB9JcBYzdienQomwm0s8hWXjiSmM0ycgv48xh+xLCDmQ9gOdOf274aZGVsEmC+m+7OFHDxiItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtifcVc/f3sSvSAuo4Gw9eM1S2ZOS3mwlxOXCR/F8Sg=;
 b=g/E7ipnrYQxGKBBBNJqPHWltuiejkofwSjNsIKhPEI890SQlwobZ0rInCSQqgxfQJrTiwdpIzV71I0NeQwkawLlE7nNSbaUFyqW59auH47w5i8iKGdGq/0T3nbRdoOuPkuzHYwWWBgLwiWpoesOCBdlwDXsT6GmzbpZfonE1rQg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1367.namprd10.prod.outlook.com
 (2603:10b6:903:2d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 10:54:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 10:54:55 +0000
Date:   Tue, 8 Feb 2022 13:54:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, Leonardo Araujo <leonardo.aa88@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Staging: r8188eu: core: 'associcated' may be misspelled
 - perhaps 'associated'?
Message-ID: <20220208105433.GI1951@kadam>
References: <20220207234210.26097-1-leonardo.aa88@gmail.com>
 <2122312.NgBsaNRSFp@leap>
 <YgIpMuShlOamHV68@kroah.com>
 <2023396.KlZ2vcFHjT@leap>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023396.KlZ2vcFHjT@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30592d35-4626-4c88-4127-08d9eaf17090
X-MS-TrafficTypeDiagnostic: CY4PR10MB1367:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1367C2C0601A5090055FDD068E2D9@CY4PR10MB1367.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /n3IJSrPvbPss4/LbAyYFnDsVhJLW9u1dmGSCY62R9p96sLN/pdE2sJmlh/uALGviWXdFbHsXJU7SHE9Q9aOrSrIJWbdOuMWarqzfhr+tEGLf9QNW9KchH4Q9eTkARrea101BUP2DtDpp4ds+kjZCCZKDKoARwwLSTrpGuk+InucMPukJ4CVMRJHn6xbxuQQdmu2C2VQGmhV3IWLPJYvuUyZypGFNq2m/1Qeu52qZCC4+l7ZlNd2nyn1um0IBYHHvIBXD4SbYLG2KiAs8Qm9Gyql02f5zDrhUNVns51UV2Mwc5TgFj2e+aA8VyZiSpmDM9Q3OhyPkR2bw3qPcAR4q3ESh3RA3xP04GCA9BBzdxRPGz9FCnH4jfmn6rMG7Nh2tSIlXy1P5C0rlidquNm4i/eMtpsv2YWRR3e4fTETsGZkYls7dj85j4Qp7GBPAxt2Sb0RRylkjoCAxCKL1wSucxmKcVpkRIgJ5IH4aZ4WsXNbL7/jj6NxAdIkMZlXmPgBekrZUI74fQ9xmnlcioFdvUCRVJ1G3qeGz/Iik6bXPI5Nw2x/huBPOsM6fS+91W9wz7EQX6DmfJBh/n5iuJmq3XHnjL3tmeOXytWJB/HltEqdHjUxHWRAKbm8cyBEr/iS1AFxecEpDzwbFNGL4DyGYsM8NZ96JuZjSfyZ2BBfugdCii2+gG6pTvRdpcXvNjYRugR7QF2dFnmSLq4fcSXHDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(316002)(54906003)(66946007)(2906002)(186003)(508600001)(1076003)(26005)(6916009)(33656002)(86362001)(66476007)(9686003)(5660300002)(33716001)(44832011)(52116002)(6666004)(6486002)(8676002)(6506007)(66556008)(8936002)(6512007)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BCWGKXkLNf2D5sKYD8QXkHzXVCruD/HcmXEEiz1UQA34tINEkT2x8yI/vg?=
 =?iso-8859-1?Q?xwnV6oCc3oSww3jK++TbW4M0dXPiVs4lN926MP4W7wCywjyzu1o8Je+z0O?=
 =?iso-8859-1?Q?4GD1r8yOyRGgHzCTPlWZSB9pycIeQD/t72EV42fXenFO66t8AXXULMb6W/?=
 =?iso-8859-1?Q?OTqWVzJvB/KZlRZSSszPjC4gEtyhYsuBdAD6QghYhYclbISMuUyKOcSUVV?=
 =?iso-8859-1?Q?0O5haL5AuO16hrbq4oGUNCOvivFU/mdFSrl8uDb2y8inRiL7RRAGu8wVTj?=
 =?iso-8859-1?Q?HLp+f/1rgNDJV1Mu41DFfjGNjPK9j3QdAk5WFoFlaq52nckcGpmK4lCgD+?=
 =?iso-8859-1?Q?7f39Rwq+qfWd/L1j/vhRNJiroFsdiq5sFwf6cPjJflcnaKg5qrjrm3u/t/?=
 =?iso-8859-1?Q?Vko9/BKkuZoQFHJceol2qtQXQd6qIvvC35mMEx+eShDyVL2rskk3lGZJNC?=
 =?iso-8859-1?Q?PCiKyffvI/Vy1jG2t8k35OslHpJWhIQOajOiJjLhCxcVxqfsT5Jf03eGTA?=
 =?iso-8859-1?Q?OY2FKzRP7rISERV9raMa4z4yLO8iSLGmDxteNiayU7aagDIFPiBeDjlmie?=
 =?iso-8859-1?Q?dt6NjuSOWBImbtZpviqpJ+doB4pyL1wwwm2PRL8lAPGpYyTBdssTvxOcOY?=
 =?iso-8859-1?Q?qJflGBlAWJE7kRBGgRtXPP64u+7lAZ5P41zjLtWtYD2ROz4ksEz95gmpUB?=
 =?iso-8859-1?Q?VC93++aooMT5j/s+AHuxkQxBm5BbtIQCMyPqq5GadGJvt/ym48nu3/Yi5o?=
 =?iso-8859-1?Q?G7LPeabuE1IfqFDNqrNfgONoXLU07th8O2Wqb7/YPA+ZDJlDOiGuFQbWxY?=
 =?iso-8859-1?Q?aGwGEWPpGHxT6DlwSBymOsiW7fJMFOu2o8j+MA3nW5HBiR8HP+ZhDij5RM?=
 =?iso-8859-1?Q?pJGt2tqXEtdP336WTO1g8VdopssX38E5fjQCjlv8QGNQTcnne2vttOUd75?=
 =?iso-8859-1?Q?bD47fCFjdRmf8KvRJb/5vcPVhrb68BXgW/kxHadv4cYB3U1pV91sWFdmMX?=
 =?iso-8859-1?Q?4GowqGBivhHhaiqBzQM4ZczFX1iJa/EYEvZT6CHjp/pQiWRCEVmMLE9NHc?=
 =?iso-8859-1?Q?rjTHKJUjNSTF4VfOJ9xfRhsuGJ3hUXTvxlOObQTZziv/Znz3ZhRGhdUPpQ?=
 =?iso-8859-1?Q?tNWg5I3S0v9Tczflllf/8TB2Of6jaoh7l5aJB/IrC7kO0I5O0cPwIf7R5H?=
 =?iso-8859-1?Q?4ON97YBa/ezGH5+N2LZItw596Rrwt+zI3/3AWvYBWzbztOOGt3vFSBr2Ui?=
 =?iso-8859-1?Q?JnECD3wbP6s5NJC75EF5EleejpTJvfNtdnjnCa1gTYIIyWAaF6wksktlFu?=
 =?iso-8859-1?Q?Ip2jgpLetykjpp6uHRcTsibAGWGsgqWLJ7q67hpkBYpJPejalUet06MDOz?=
 =?iso-8859-1?Q?CI5C6URL1e8kaYlG+U8IEzCyKGYBUieeRvkpA5DQp7vFh3EZnyOl7Jbt4K?=
 =?iso-8859-1?Q?dhAaolbWlPhmYsY3lkre2l+pBBh0xNMrivXgl+l2uoEdcpDpvaBhY16qo3?=
 =?iso-8859-1?Q?3zSbD7ZweIANnObDnhIb3ySrp9Ec6x7m7qaBUvlkpVVvVF7pbi6COpLiAG?=
 =?iso-8859-1?Q?bq6dqPjHAZY6lK5Td2+9HErEsg0aGn7uf/0qvty8lBAtGkDGkwSiTg3z+F?=
 =?iso-8859-1?Q?tut81EkjqhkIxg7T1PPMlsOuMsaBIhI1sT4b/1qRfmUTMoIp24mzTqig/p?=
 =?iso-8859-1?Q?kQZ/tlk4cfqCbTcXJjq7/bIZsmjhf6syDm0ThzRGqknxMzx52yDdFvVOaz?=
 =?iso-8859-1?Q?t3qg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30592d35-4626-4c88-4127-08d9eaf17090
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 10:54:55.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHV6eEKPOYBov571b6CMsnTeQQQFJ+Fsn6KQS1vHPplOyeC664pKFuOQXzf8fSEq1dZEzXXCsBpBBDy1q+YF1PFlFM2tYz8r8REBkTYqX6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1367
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080064
X-Proofpoint-GUID: 9R8oxnG5k_gr1hAD4Wo45NBiXoZ-zNeJ
X-Proofpoint-ORIG-GUID: 9R8oxnG5k_gr1hAD4Wo45NBiXoZ-zNeJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:56:51AM +0100, Fabio M. De Francesco wrote:
> On martedì 8 febbraio 2022 09:26:26 CET Greg KH wrote:
> > On Tue, Feb 08, 2022 at 09:09:10AM +0100, Fabio M. De Francesco wrote:
> > > On martedì 8 febbraio 2022 00:42:10 CET Leonardo Araujo wrote:
> > > > This patch fixes the following checkpatch.pl warning:
> > > > 
> > > > CHECK: 'associcated' may be misspelled - perhaps 'associated'?
> > > > 
> > > > Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
> > > > ---
> > > >  drivers/staging/r8188eu/core/rtw_ap.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > "Staging: r8188eu: core: 'associated' may be misspelled - perhaps 'associated'?" 
> > > it's not the way patch subjects are created for inclusion in Linux.
> > 
> > I do not see anything wrong with this.  What do you think is not
> > acceptable?
> 
> My opinion is that the formal construction of a patch is important not less than
> the code in it. However it's not that big deal, in this case. But for what my 
> opinion is worth, having a subject that says what the patch must do and using an
> imperative language is quite important.

No, the imperative language rule is pointless bureaucracy.  Very few of
us are English majors and a lot speak English as a second language.  Why
put artificial barriers in the way?  You will lose developers like that.

What matters in a commit message is can you understand what the problem
is, how it affects users and how are we going to fix it.

regards,
dan carpenter
