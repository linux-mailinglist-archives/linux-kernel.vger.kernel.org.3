Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CDB4C6350
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiB1GpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiB1GpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:45:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA67144740
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:44:38 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21S6hrdf030174;
        Mon, 28 Feb 2022 06:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=NNWN1LA0BuYAzFedR4wvNwRswOcseHSI47bL0TmA3JU=;
 b=DJo3l8rnkBWKQU6+72HkDyLm4CRXk1j5FXNBgSWvmsRKQz3G3GMXIUCXL1MPZDXK8eGN
 yqRSYIuo0In9Nhpkci56FDEo6ZpW9A49G8pGlMb7WmvDW+FSVX13AO8hcdc3XwESsML0
 5NqGR9XqaYPtRg6Yp/HYRy7S8Bif8pQvKxAZnkAScBAngdAmuM8RhgGuX87ECFGFfDzb
 SxUv8ra5cgSn/vO0RnkkEkJsbyygXGIXjSoBt/0njnUEd48ezAmYpiReED+YHShi/ZG1
 yW9qn18GuorixVX+wV18uvvswPsg12cWf10LiAppSCNj6RN+IRPDzlHPpo8y6iyfRcxH hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efamcb8us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 06:44:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S6UknS022597;
        Mon, 28 Feb 2022 06:44:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by aserp3020.oracle.com with ESMTP id 3efc12kgbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 06:44:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky29U7WpeWz9KeUo4vuzYARyG+c8vpdX4z1rkMWCQV5TOzVm8heBHD5J6ds9I5nB2ZZ+93quIofMyHsNPGCLt7qddIDS++T3rG1J2gtK369cQCU75l8MzrSykuDNV6a1+7c+ih3pRe7CV4qARswOZsQANLufLGY2LszxwG52qD7jsadI0Ztck6f63rgVFeZSDjNth2PlUUjU2gES0z62U7vdVxlBgLETU3wb7QMz3fJ1aXr74oKmq3I3khHkbs5ZDFXEFGmJvfAJzTUsLKBtuEYxkCSiGFGTVW5qP1vPujedHiQoF3RNdSE8SH+2uCjZcJCCrr0YtX4MT2jT3fM03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNWN1LA0BuYAzFedR4wvNwRswOcseHSI47bL0TmA3JU=;
 b=QFyDYXLF4njZfFRkweq0EYldlySmsMVjd/MBTnDWh91G53HQnJEtMYq6sZ4IOdTsMPnfHooNEW6+stXD82wahHvYhCk/edAC+qoXs8E01icxS/7qqumXYaTYmy5xuHm7NKId6CUiTLNaZOqnX37Gq6hm74QeSW7KKppSSKi9fEvBsCsDanoChTI9H6T0dBooqwrHiQ8fyQE4ike9osljRpkMUYoGgDcbh7UN+ohyalX8AAI7cmSS+HTwlpA0fXrb19oDumami5FFq9U2WU7WdGbuRJ6SjKhSxdNAyYsxFXCX6OhlkkepwgNoey8kHSsQajElumh1/I5WpcZFhqHuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNWN1LA0BuYAzFedR4wvNwRswOcseHSI47bL0TmA3JU=;
 b=TSnPOWioeATyDgfsmJKb/eJE4LXlG5VdZsL9SMWverotD13taPNqsIYm/kSoPjWnALkD7ywUuBn6j1nftD6oL6SLzKAJ0ju5ELaTS/OaxhOf1Ybs31T0U4wNChIVMEdvTJgiVhR55z3Z4szjd0aLUfSBZ7VyIkI991tmjXtDHrs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4009.namprd10.prod.outlook.com
 (2603:10b6:5:1d6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 06:44:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 06:44:31 +0000
Date:   Mon, 28 Feb 2022 09:44:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: prevent uninitialized data from being
 printed out
Message-ID: <20220228064415.GB2794@kadam>
References: <Yhmruyr2BUn0+3O3@mail.google.com>
 <593b1840-aba1-3fcb-daef-9cc0011d0805@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593b1840-aba1-3fcb-daef-9cc0011d0805@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CT2P275CA0035.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:a::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3224ce89-f201-479c-330b-08d9fa85c632
X-MS-TrafficTypeDiagnostic: DM6PR10MB4009:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB40093ACCDE030F3A735F00748E019@DM6PR10MB4009.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHEAe7HbQgja5r2/nqc+Bd6rVNiqRBBUy+J8lTDMBPEbyLqyN7sfUBXzLNpnbmjrORO/6ZRBzf+sTypv/JnWyps7UckVEJ93v+Z66n7x9fnOn/Y4nT/InNayzkn4Fdwm6o7bmqp6+Ljk8HmJsEtK283Hy0Cjb39x511fioUHXUNfEYSXx2vZq6Ub3AEfvuvHVzx4K8RYtOkIhIkQK+lgnIKDCGsekzih+Mzrs0iftAxYLJ+yvcJbeY5KZmpBZLDAjw1GJw++PaNalgUaYbQealLtOSEaWfNn6fdcKY3lqvblJ2UJ/F3Xoe92/CzNn5f3b9G6OANc6cCKInGe2kQj0Pf5cAgGemyUeevieDmSyuY9uhXRvBy43JnHP6WxKmBQRTym50Ye/oJ+zJDIOJ80C4PjlGLooEXQagmFJ928d7Fsf4xUMA6fUJFnQH8Uj8/nYyWElsswZnKzOU3N/TgW38tJ902IbHsWjfIkomunwU990n4xmLb8xqiSfhAVrEPzs09rxo7XW2p//6jLa3294cGDRM+FOTTkQ/W7UDSg0Schh4ODIi+58kfc8bjY4E82IWBrX1ELIYfoJOY68q6fENawc1tGIS4Jyqt3Ob+8ywL4T4gnSW43OTC8NqSHA+5iiW6jufvlDC/kgyJX2g4wr+FmKwKpbmJz+yFxynX2dwyTEPsrEAiZQYi5vg/zgTRXmgJwltzAWhiZ+xITVmubcKqdXk1Zv93dxAssB4rbmkYOSgncHRYueUMCarV8M7NuzMNmVwjXKaE6rMDKjKZvhOKlIJEMqnxO1R3DXrJGAGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(33716001)(8936002)(6916009)(316002)(86362001)(66556008)(4326008)(66476007)(66946007)(5660300002)(8676002)(83380400001)(966005)(508600001)(38100700002)(26005)(4744005)(38350700002)(1076003)(6486002)(186003)(2906002)(33656002)(9686003)(6506007)(6666004)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mrTNQDOGnukL5vZZHI0t2dzZT5ZLEni6Y6OBFXLNY4qj9psHFzOwrUabUBoK?=
 =?us-ascii?Q?kdqNKvXjPBmtmS3l6Q3OIxCnKczdE0B9QOHpofR4j4FMkX7g1ktoeENPxq2j?=
 =?us-ascii?Q?8fcx1R2KJfOhy8UPUbRTJXSXQEOwZ1ueF7w/BCFTH5vX+oKuW1Z4Cw5lYsmJ?=
 =?us-ascii?Q?JIOQ8ipn/67EvJysjWKjwoTAzxuS4GXdTDYMGk7bPAvhEnNivOS86wonkn7S?=
 =?us-ascii?Q?5zJFSr24uo1hl8/yTv6cHKg9Kxef9ZiRS9AM49k8t4YgkKZIIzAMOW754RGH?=
 =?us-ascii?Q?4Q7TGw4PsMYlNoiReD7wdl19FsrPH7GMgxdZCJcIN/CMtR7ybPChCLyZkLr8?=
 =?us-ascii?Q?P20RKUoBWfDJeisRjo8X3UvkB5YKX15GcxJ3Bl09JQF22lDQSEMuAKdPd1jO?=
 =?us-ascii?Q?sJJ7NMFdUcMaxmEOYSwauL0ZhdP3mrQg+lv7ayR7MwubypcODm/IV9H5GmRr?=
 =?us-ascii?Q?VQW98BhyZhqi8RXouvfUHl6f9qSWJCQbpAs3bwpHgmuKr8GUCLPYnz7uU5Od?=
 =?us-ascii?Q?Nnj8FeEH/TD4E8c0HqPZaxCdivJN7+eqWN2Nm0es6jEbJvMwRtsRvVEx32WC?=
 =?us-ascii?Q?EDZiJW+y3LCjp9MOUFIk79Wr4GL7sn8Oz0VRRlYvc4Pfg4LloQZf2h790iIG?=
 =?us-ascii?Q?IDwHZ9IznDEu3hyoeFl4btJcjjCjcO6kSzhJOdylllQbwPLT8nhiS2IN1zba?=
 =?us-ascii?Q?ASTMmPNI8iM1A0xka0je+2sXvcyRZIvUF6F+MlYYEegAoXjavsz6N3TZaPRl?=
 =?us-ascii?Q?mWcKVm1Vglz9+tDm9/5KILNy4PrjAUfcuvWsnDt5AXf434WbJHcuvCaAB2Hk?=
 =?us-ascii?Q?JsZdzNCUaLaodUSUVFLfL1Gq9aWMvVJ+Aa4OUCnE+1+04PQyAvZsAphc8ERx?=
 =?us-ascii?Q?qUo29KKxlDQeJoa25NsXKwgZQRKKTttWaDzNEa4hixHEbUjfahTV3+ci9Vzz?=
 =?us-ascii?Q?tZdPee+Q/wgUj7hFTIb4FoS8orzZw4/7XGtBIYyMEkJTahs4T6QDTRHd2Tf0?=
 =?us-ascii?Q?/y9U8UQhdZrk7tNyYRmYj1sQlcnrCBvCi7exFIIO8IhpoiUgb6/0nltsN5oY?=
 =?us-ascii?Q?vbYVhWkrxjDAaC/chN9o526YkkbD9rUrgpqbNgTFpX8QDfrKsjG1QJSs+Urn?=
 =?us-ascii?Q?8isWdlqrbDBxAbFUH9lUVtcZTwmby4f73BbM5nZTwi7fpWnJFKSERHeOqKaM?=
 =?us-ascii?Q?zp35zFfRRHDtBnw74IuAE08X+/qHsdQyf/HfcDH2vWxq/nzOJBoMfFsHUcHL?=
 =?us-ascii?Q?q632+I7Ub4DGdonIx2ukkNHv0WcrcErEmpSXSH7qWogpHYRJii4PVW6TCj8E?=
 =?us-ascii?Q?WmAo41at26gsHtmBV/JFSSirl3/LQwTK1hCleXA/uxacr2fGoFSKbhZIyEJD?=
 =?us-ascii?Q?seiJ1rIXJ51d42jafgIPSPv0Q2dDMuoatHB9zLssvTiw+KHOmJ6M0gcBhe4z?=
 =?us-ascii?Q?W7CLUDwJT4d5R6yHp06Nr2bZlgQA8vjLonFJdWj+3MjjU/0pv0hgR97rTC/E?=
 =?us-ascii?Q?7ukcyjAWjsKyrdBQ8d+QSYUZcfh1Ral+Nm6j6l4pF0WTDEXQVqjDkkxVOr5I?=
 =?us-ascii?Q?JuZdQSbjMbNGNySMlZfGqUgkkqSAxAa8bnBN1EGKUsvNwy2ZWyVNuXomm6fo?=
 =?us-ascii?Q?/eGc3kTI3s2C3Gizpdpx5CSYHTXduTriLXMqrWuyiUx0n+uwnO+10fkbpiMM?=
 =?us-ascii?Q?VnpoLA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3224ce89-f201-479c-330b-08d9fa85c632
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 06:44:31.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ea/9yMtwBpVDt3GcqEHeR5IiAjPqw70sAjyyV4/GpMHzkfWBgL2z/91IRBZuNBg9dtxlFMGCfecnGQhAE3Fc6ahoz0Yflf9HrpkCKXTBeIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4009
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=915
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280038
X-Proofpoint-ORIG-GUID: iT7usiuUqdn0egqLICCct7Ju0KPJnxDH
X-Proofpoint-GUID: iT7usiuUqdn0egqLICCct7Ju0KPJnxDH
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 04:08:48PM +0300, Pavel Skripkin wrote:
> > Patch dependency:
> > 
> > - this patch depends on the following patch to be applied first as
> > both of them change the same file:
> > https://lore.kernel.org/lkml/Yhla4a1Clpguoo2h@mail.google.com/
> > ---
> 
> You can send all these patches as a patch series with proper order. It will
> help maintainers to not break the order while applying.
> 

1) All what Pavel said is true.
2) In this case the order does not matter so this text is confusing and
   unnecessary.
3) Greg is going to see that and he is *never* going to click on that
   link.  In staging then we do not care about the order of patches.
   Everything is applied in first come first serve basis.  If Greg finds
   out that order matters and it is not sent as a patch set then he
   just deletes all your patches and asks you to resend everything
   correctly.

regards,
dan carpenter

