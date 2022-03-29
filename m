Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85FE4EA8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiC2IAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiC2IAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:00:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD304DEEE;
        Tue, 29 Mar 2022 00:58:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T67jUC006038;
        Tue, 29 Mar 2022 07:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=MikF7yzLJDmSk7PDPB0QEfFYKLc06c24BBZNRmB/RqY=;
 b=gx3YmoRBVw8mJjcnIHRGbMwNpuzPsJU/fqZsGXNZArX34GH7QYenXBnYRgE5kMAsD9Eb
 tzVO8Mm456gmi/PG1XiMz+8+Vikjyn98onWG8ZGoi3uHU/1sd3kCR4EKiR2d1S8RLObE
 8dgrd9w6F4Y7zdqbX8RCJB0jssIKLGnFySpf4DkYqDE+2Jh5ljgCtAq9O+uVMWEsAhNe
 gkXBFdaI3g7X1ZqUn83ty0+1jRQaNw0PxHCt0CJauC8mxG0J/IxlJKDl++u/LYcgPWPr
 hu5ygVIwJRkgzQZczWTEwJqC0RbeRUQZci4Zvy5yn7GdTLm3hjiu7hGDmy2THhwVfu36 Pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb5r33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 07:58:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T7qlVW153863;
        Tue, 29 Mar 2022 07:58:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3f1qxqdt93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 07:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWA3bab4ntM5Cjm8Gs4nGm3kjTG+ClCaNKHh6nRr/yKajRjMRtxXVfLS54L5hMt3OvjqKAb2Trl1sTEj7FgFkrwjmRoZ4eTZVmn5QU31XT4mIAhu7bi7m4q0LAmSFjjZXU91UShhMQSVq4LRhW12pKpmRJmeTxu5XIf31MufAyAGNNmSiIc9K/mfiJCDxYfi7hTe2Yll8q8hfPUTijVozesqh4P0pEq46z2cBTlgJed2Mdn7lFXWvBgUyCG6lFAoQuVn2ANW0clbbDpfpWBX6pZl3upnoHGYZwg47vPV7IXrF/Qf7km52WBLbSa2THY8DgIayQ356+YuXCVhI8voHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MikF7yzLJDmSk7PDPB0QEfFYKLc06c24BBZNRmB/RqY=;
 b=mfVLFxoFxAJXPZJWVPXISgJSCvlRbZx02bXTnE/KWaOBtUrocgLF6CQSAwU/Nl4ND1gvy65QLBGYQrwGTCgXYsh8AuLG0uNgMcj1FTnHT7QJvTKdF68z389911QlpT3LKJAZxd2Nq8OeAnIVkJrQ4Ic7b5WHOEcqoBSuGtoae/cFnGamXP89kOQAlbzumsrUVKFZmVLgHupXAhNypIzKdUm/+8Q3+mDiJRu+U9Csus0D7vfWiovYPIxU5PDnvtwo0YrRwDG8tmn7v/4RkKhrIscFCtUaKmSixq7UQCwjWLi/Jtzt7siZbryr2RnT+Q/9gt8OsnhoCQ8Ggra7NNKOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MikF7yzLJDmSk7PDPB0QEfFYKLc06c24BBZNRmB/RqY=;
 b=Sn2d8XwUEXgdKCDrBVJOxTFUkp/pYHBWCsEvI084vIUa7uyL1/XCcRJm5Ig7pD2HZqfbv/Ij2MUqh8O67S6WzhljGh8HXXarzAp6J3tyMM4QFeF7TR9UIEAf7Lm+E6/s0S1q1b+9j+Hw1uuIMKbIJF14ecvsoZT6aBRmLSlSCFw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN4PR10MB5591.namprd10.prod.outlook.com
 (2603:10b6:806:206::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 07:58:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 07:58:04 +0000
Date:   Tue, 29 Mar 2022 10:57:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
Subject: Re: [PATCH] scsi: sd: Jump to out_free_index if device_add{,_disk}()
 fail
Message-ID: <20220329075752.GS12805@kadam>
References: <20220328084452.11479-1-fmdefrancesco@gmail.com>
 <20220328143853.GU3293@kadam>
 <2179817.iZASKD2KPV@leap>
 <20220329074744.GR12805@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329074744.GR12805@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0065.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::29) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e09c2f68-cb2f-4cdb-c486-08da1159da9b
X-MS-TrafficTypeDiagnostic: SN4PR10MB5591:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB559116A631FB6F0D047F15F28E1E9@SN4PR10MB5591.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elJy51N3r6lHsxLfUr9dPmFGAf8xnj2wWEhOYOlvFWdIHmUPfPLDDuK4uWggbsqirdOfQSkDRfIlwfz1WiNTSSc2roX0Pg2W8lR83Xm8CLm1DDXMk4ioboBaK33lTmm1FkTVgNke1m70nlKDRTG65T98SDJLEzaQHXFU+0DUEzfPEpS+SuaVYWPyHMMLYA5oN2t41yD1zdPerlz7sbwpOFfieIQGiQR6oBvBdW7TJWs4YTv+a9eqbKbymuS0Wgw0AmA5TKz+z9yAwH3qR3NFDVsec9gWVqNQJiURHYobeVKIWHC5vn20hHsgvxt25X+W1sfGFsVKo4eUb+HJ4nscgHhhYHBEuQ1KPmo/VCZ9pDHq/qvU3FRDz1HzeMR/KjUWswWDgzFBIsjK/tK5omEUm32r2vSHJnR0eJKsSpy7eeeuJih4hspry5Zl7ROEe63q1alygaXqrNsB1VxRcQD0RIzJGa9P4N5mmOrlgzOP7fNJIIzeEb2avY2uizBEni1vFQ6AU/XY8UTDmCskERcxN6uQXfUkBr1zdCPO3ie6DdDoa0zktPOPEA/W2Gfb9+ZMFb3eW5FONUQLD15kPB761VTknZMTCJ6wxvNO2r/tHsCniND7/JGsRjNQmuSWICUM+120EnUZ0U5Le3A58zrqiLwMIvNsPiGcE8gRRmNBApJhhUIHE2H3OtEy5Tj8UJgUWupAFuu4vxR5DSxcnfbPvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(9686003)(33716001)(6506007)(1076003)(2906002)(8676002)(558084003)(26005)(186003)(52116002)(33656002)(44832011)(4326008)(5660300002)(66476007)(66556008)(66946007)(508600001)(6666004)(86362001)(6486002)(6916009)(54906003)(8936002)(38350700002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s//anRaY4hRzSQgGVelCnvCo52/UrulPVPhQAWsw6xIIfMDN3xLo15IaYj6w?=
 =?us-ascii?Q?n0M2xuSaD2h4cwrIQ1zlaA9VU6Xa33MaWRkE9FrKm1fWSzFIlquL2k0E3bbM?=
 =?us-ascii?Q?g+r3V7kZb2zh/2C5i1GcuxMLp7/wpJpNUe+PxE/e1HEMMtSD/QYbk/xwPsZO?=
 =?us-ascii?Q?3EOl12rNgu8vCXyWQGzqmGZ1/3XjC1ytrYKWvNISREAxM13SkXCpNerpVDYs?=
 =?us-ascii?Q?hFGAa2t2C0Q0NTRd1d0wBKo4nzigS0UUw1vRVRh+k7cfJsdroBkI5x6EFtpZ?=
 =?us-ascii?Q?US/IrVuS7dxqTS8uj8unzqp06bDQexYawIf+n+ZD78JTuAVkVprtnt7NK0qz?=
 =?us-ascii?Q?KiRiT1GCv004awIsJVil7/4WHiKWT69DzvS6PJAQr+A73Wx/Y7DXF4OSwGcG?=
 =?us-ascii?Q?XsWs5LmWZVFzMxVaBeoSd9guYV3kMdfS5Bvvc6g6xXfJEaiOXlXsa5/Vfly/?=
 =?us-ascii?Q?2sGqvHvPqpCJE2/znS2UVKRrPmpY1pHy/paAO2BrYqNtKTq1gDjWkgiFz8rU?=
 =?us-ascii?Q?Cv6EkztO00rpP/rGHoz/IVG+ZPFcYOaX1n6rpIVWX9b7zmh9nKBvSD4xZZdX?=
 =?us-ascii?Q?e0SmF0jnNnzy/Zbjoa1O4t1JiePfJ8OBz/OofL7DkcWt1/cMb3zK2UKmdmiV?=
 =?us-ascii?Q?eI+gUEr2WST1BJpHF5hoRtt88ZiyoeJBoo4/zKh3OAX/Freg7SbG6fTc/Hrv?=
 =?us-ascii?Q?e3hE+2EbAqYfXV325Od9esqNBAHF1dgHPE0oMyIXXxUBPQZdhFbop62jZNPD?=
 =?us-ascii?Q?CUid2lVgBOOuxpgd33wsXJgpFn7vZ/K+i425yp9ZJTxImZxuRSrUvdut33Sv?=
 =?us-ascii?Q?v63i80nZ5FZYwDbdE0xasJ00zVdSyiFTRt4iegTo+SpYsA6JOChi8gr06SHZ?=
 =?us-ascii?Q?Xfo+Y85/AyUodYGCV3EHtzI+B0by06RNh5FnKkZbALh8ninKee+n2bE0iLqc?=
 =?us-ascii?Q?YwaPy3uz0LJNbPruf5yAIwCh9cPdldAzL+ctsW2zAGgKo1RcfjDohOql1gB4?=
 =?us-ascii?Q?EZX6xolK66haadxaE4nf1OBjGUU5LNXNaAhavs+Qt86E6GPERJnp6XThY1GK?=
 =?us-ascii?Q?pJyn4PeIhTWzUKMsGg4fRl3C3+KSa+EAoR0fxJ6SIVHRHKRqTCBNG3fIPb/2?=
 =?us-ascii?Q?f6mtCo9nYGT9XgudbJeyztaN2e9GEBW+hTsqOoiHBFZ1QVu8tQB8qdelAnbT?=
 =?us-ascii?Q?F6HIv0TSSaQtPzReEkVy+poH4j/ihKSlKltj6GUxDTTbgqWdDHydIG4+yn5O?=
 =?us-ascii?Q?yvLDj85dFC7WXDB1oCPcImNrcXOQWtX4dIWlb1Y6HF5+iqtnqfI4wclOebOJ?=
 =?us-ascii?Q?IajfBSF/Wxb2k6G/Ruxl94NInBh403eWis/lHOdHNrK8NdzrdnM6zbF2cKMy?=
 =?us-ascii?Q?8QEE90slOdViK9isRQpqM+ltI1fKTsFTcLU74QTbV2FG0fKns3pLSxzbLXYm?=
 =?us-ascii?Q?y+I6a4SDMObmQMcCCwshyGI4l8I7QpfF1TT9BAJbksqo+BP4sSwcUiLotPEM?=
 =?us-ascii?Q?gl46sovciEMKXa+08bk8JnLf+unBUa7ue/bt1JGrJRIAb/mxM7NfcYgEdIir?=
 =?us-ascii?Q?paMby6MA4kXnVGW1C4FBWDE5OP5T+0tYbwIzJPT2lweyfsYrxnpf6SXb/Yj3?=
 =?us-ascii?Q?VVc8J9sbK68mFX1FsYjlced1A81KACxbSkIz9grc7MczUymMWS6RS3qH2WR5?=
 =?us-ascii?Q?WYlyCn9DZa1CEP+5+MJz5GPMuiskSh8rJ7D8wXEJuyDynLnD58PKAOOKmD1k?=
 =?us-ascii?Q?YbBngERVyHvyZCLNkAWKTvXK0AiZ7sM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09c2f68-cb2f-4cdb-c486-08da1159da9b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:58:04.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKV7KnzcUcZA1ueqcGCDZ5TO8iqgxgsq2gVIk420SiwNR9kGpgrJEKr9S7+Sf/L2AtmdLPtffFi/SPhu5xG33VNNwQjjadz//Ep5+6ieb+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5591
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=841 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290046
X-Proofpoint-GUID: 8XDu1ekGihg7PXXMX6WIk_FXk1tl-Kkb
X-Proofpoint-ORIG-GUID: 8XDu1ekGihg7PXXMX6WIk_FXk1tl-Kkb
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 10:47:45AM +0300, Dan Carpenter wrote:
> No, this patch is wrong.  That is supposed to be freed in scsi_disk_release()
> but apparently that's not getting called.  Is the ref counting off?
> 

Yeah.  The device_add() needs a matching device_del().

regards,
dan carpenter

