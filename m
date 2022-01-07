Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED064878AC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347483AbiAGOIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:08:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54288 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238405AbiAGOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:08:20 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207A8Waf031918;
        Fri, 7 Jan 2022 14:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=DGF8Q5uDP9APjI4LO6vKTilZcbknZPvaOe5WXdGZDKc=;
 b=01gDOFWK5OrlwW9hSvo8KU/9aMe3bp4MES/Qhz/C8hmr8ay5d/HcwsxLw2KBttJy5HLb
 Zzl4L9ORSjrSV3Z/YUeB5uKt6rsP36UwZ9J/SAkB3Ac6Wti2GaQEBPmDmNIlfFEp2A2f
 AgYW9tBCYRemUBWTzOOg7QOZBMc4T8nrhOC7OdUt5WIPurGqFVdldCfN+W9oQAVqfOr7
 pSnEdytgaWUyJttYwWlFmM6oektPR1Ue9pSewxayjRdl3eY34DHwJ9qAU/6GRThFFp/G
 qgJC0bVV1kXcJTeJtDjISvCZEUcPepVKxzPWT3O5o2aJ3cqbcpeSnTPefaHn8CiCTHV4 /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v922pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 14:08:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207E5P1D054213;
        Fri, 7 Jan 2022 14:08:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3020.oracle.com with ESMTP id 3de4vnqunk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 14:08:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOLxnrSdnrI8VNe62qs+nogtG2uxySVo3YGTmuQ8nf0OzZ69f1REJ5WAaHCxtNUsXo8hnlgYzmUC9e5HgMqvMdtjXJwParEtoh7PaxDV4FOZyVM2kyAjhkZf9SOIKIh35TefmRjZCCcyrBjq7yly5gpPYXx2o+lPuQemsBrezkRUpCRGNmtExk6mJmbx4VXR/p+xqbLbkpnj9YmBUGeBUwYs+JN868MWAPqnoAh7HC7MSazykY4pDFiyTNcXcjy5HZ3KIn+kUygQ1Bil1/JWC4/t1Cr2rgHAmIwln6HT0wbnqVwWBWcH8LONNA8+K5Tax4HDUb/U0C47GgEvnJPNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGF8Q5uDP9APjI4LO6vKTilZcbknZPvaOe5WXdGZDKc=;
 b=KKFQsnrYkvXJ1uz8b/RNmEX2Dq5mMlaC31lKU4TifAG5JD2ObefLmwCbMmTsd0wEzoWm1++wlJ5tzYhBVyTLi96HtgCxQ26iyydR7JzKKl/ez4YTtTejeSybBSjUO1qPpgD9IAsRPUi9cuQjUAhKeVfVZy1vxOn063tAZ/HOzE/fNAxwjYrVkjzCpZO1ODWnxPYyXGhvK9qdwItf6hhnSnIcCJ7sE7QzChPvIh2RKIJI622+xqSGMEZvEVT9WA9bCQpYgi0bjXFmhTm6VAbFG6ao3Gvn0umO/bXJqKhId7zAlZWep3Fdb3PLwsRdx9fQtYb42MJjQoVkK8EVkv65eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGF8Q5uDP9APjI4LO6vKTilZcbknZPvaOe5WXdGZDKc=;
 b=G7sOYy9QO4n+2wPYrcJpjdzVrrJtqfjNsYWHw0T+090+J1VgRpobcR6KlQBPIihxGbGq6bsLzFU1q1FL2YkLO+bRhZLcfbnLQ62JmHy+VxIpIg8lySpi0pGYCGEbr0xfPL/pl+fFo0Ozy0LiG6fcK6HQR1olcJSz0jxSWLAq4qI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5531.namprd10.prod.outlook.com (2603:10b6:510:10d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Fri, 7 Jan
 2022 14:08:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 14:08:01 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA
 Information VPD page
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mtk7wsmb.fsf@ca-mkp.ca.oracle.com>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
        <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk>
        <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com>
        <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk>
        <yq1tuek347m.fsf@ca-mkp.ca.oracle.com>
        <alpine.DEB.2.21.2201032324230.56863@angie.orcam.me.uk>
        <yq1tuej1j22.fsf@ca-mkp.ca.oracle.com>
        <yq1lezty169.fsf@ca-mkp.ca.oracle.com>
        <3cb24d6e-d52c-827f-7905-8e17411b23e1@opensource.wdc.com>
Date:   Fri, 07 Jan 2022 09:07:59 -0500
In-Reply-To: <3cb24d6e-d52c-827f-7905-8e17411b23e1@opensource.wdc.com> (Damien
        Le Moal's message of "Thu, 6 Jan 2022 14:21:24 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:6e::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af22abe6-152c-4209-16f6-08d9d1e71d73
X-MS-TrafficTypeDiagnostic: PH0PR10MB5531:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5531B30E7BE06B3A7B91A71A8E4D9@PH0PR10MB5531.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgdCDmFYWfe86kxkfcP5fsEZkD6Ug1vm8aToZWjm2Uj9fpE16MKHRRvwMeoXUOG+YVhLAuITQbYupktMWhfnxMIaPjsP4V/GryAHmq9drszEgU7GJmotLG4/b0fkvZ3rQ8d7TDZlxOv7mKXkYPuPgJJC0ezzjA9AZDASWKz5yYTADBJf0cqH5qa92ARh6p/W6J018cDklSZsgpkv1p0hiG0cvjSbzjLnxmE1a8+EGBCk1NeJfLYJ/yIaZozyGfBszn2I3nMsIyn9kRqguXJ7HIDkoc4azRElRwqci42qSrNkjzJFEld71gyMw4fUBBLAhUV0zsw9gzxMr5YxOGsJ4YgW4uzLocqr6nyHtnmHDd/G03U7c6NN2a6MVL3hFrfKWkoif+3WUuOjOBMHvGVGtP8PU9Zp8fg7MNjZF0ecyFsxUsrOt2Lw2jWi/shW+UT3F3munG9uIGVTFQTX9YaUWp+Yomx9XZbJ309YLEfDQTs4ynV4GgSrLx+eUQvOME+N3oT+iFodqZCVxpJeuJjb7qR1up/EUt2PecvLbLjD6Oc3H9DMTe3STbevyn0sH5TlXDkP58HLadrTLy+upFG19xAxrALSI+DD/BfsMcDXXzZBBhWrork8tAhyu5pRQruM1TZ3AXbZ78SSmN6Jrsf57AMnAUADBRmHeOh9LsuXTS4Wt6zvM4qKVOFdKQTduHtKJc3s44BdYK1Yvdbe9gXVGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(83380400001)(8936002)(6486002)(4326008)(38100700002)(316002)(508600001)(38350700002)(6506007)(36916002)(8676002)(52116002)(26005)(5660300002)(2906002)(66946007)(6512007)(66476007)(54906003)(66556008)(86362001)(4744005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JL16YncUNL/iORzzRtgaQ6Uh2ClGJDABCsaWp6pdCimamyEW1P4xenwOvmJV?=
 =?us-ascii?Q?EiEZqdThdui7+K2Gp+njbD7MJeGBf0xEHlwekOPOoKyNOPg6vgimjPrXwpPj?=
 =?us-ascii?Q?oVSjlrjElNmP8kw1SUx69p8aaHV4HOwfOxdOUFuzg+ikvz1yCfdJtnaKWiYO?=
 =?us-ascii?Q?1jb04NHbvW7NMijU0G1zGjk1nYYW6rjKYUa3k9KiSnI123DZfOo6yranRIu9?=
 =?us-ascii?Q?jlTO9MVAwo9Zg/I2x0xN1kSAZI5jyWtSEeziibxQK/bXEWSfQVATS7rd53YA?=
 =?us-ascii?Q?pVOeVKnDEOlW3iHMTgEve88YPB+4Ki/o/m59E04YzOtYlMqb7vKYGYKKqopu?=
 =?us-ascii?Q?BvK8L8bwM0XjUeAfnkkEQACVytbz2BMF9qjnh0Hx4cLFwYnt8byY4SekS5Q/?=
 =?us-ascii?Q?HV77VZnHZdiEtnqqPMj+2so1WEFxmvsWDGJ4TELSeqWLHFmf9r8yPFJbRw44?=
 =?us-ascii?Q?ZU6sX1VV7/uLhmV3/hnP1zNsd0EAULs/+n75rtObdpRUC0YvyjS1fqPcK4IX?=
 =?us-ascii?Q?OCWXy6oLXEG8RsoVkKAcgw8pFOKguf2YqB/T/9N/L8EUsRyiX0QJW/aFAR6u?=
 =?us-ascii?Q?jONJYJ4ZH2cGnRWzmMxZBfU2sii896bngM3MKb8jXFmp7ZUX3IenceJw0DQC?=
 =?us-ascii?Q?AhgbkMDk+k/rnGlYOGRmztpIvKcaE15ahQ9G1viOUzkmgKL8DQNUtQZaDt/v?=
 =?us-ascii?Q?ZxxqBTKZmka0qt8Yyv6o1WEiAgaSiGbKcmoWXx3AphOhg31iafYKpKiIsuxy?=
 =?us-ascii?Q?qSR+xj/DfTbLiFy8nZCIbbAPycneq4B2B93pqqE97PDoVXVIa5P9aBwSWpaa?=
 =?us-ascii?Q?eLzAuHGTF1+iRxz88EMt4L0lWT1Yi6s8HT+6/VmInSfCnC2SkwsoPJeNTcUz?=
 =?us-ascii?Q?7/cHjXdgmqyy+UOzGIHYZjTS/3rGekdJnQrHZL/2wu79j8cUzpEYAQy+U034?=
 =?us-ascii?Q?2FqfrnUPNA9GV8njdsalrHl1GXV69rFAJKB7V/vB7i+bRqiFFhGWZxo0RSbo?=
 =?us-ascii?Q?obsZWXK8Pply5BRmFvVA8cMewV0C6NwlFd8U/cEJLlrN2DJKTi1I2TAfleSg?=
 =?us-ascii?Q?p978SCcGqVUyGmaB6ewYLplO0tofnocJhiIl6TS6XgrjRARcPuFhFfZ5yKsj?=
 =?us-ascii?Q?RpkrnOtMb0dZw5ZbwO+ZVG8ARnORURfTce9yasYw4pKhYSy7i24m5RizSblg?=
 =?us-ascii?Q?OoutBB8D8gN2ghvfMMb+PQfui3NhxOWNfiJY/85LSGZnA0ZBApNf5SnvZI0L?=
 =?us-ascii?Q?zGXlkVes4MYupmLlRTFEZlBsDlmBKMwRotvYhYpq6cVoEdPV7wL+yzdOlfL+?=
 =?us-ascii?Q?RH08MeCMk0BacBoG6F4QMGB4JgyWUc61dkhZmkqITGKsTm0oqS510Gw/4xmw?=
 =?us-ascii?Q?qs3cz2edzAwpcgxeY64M68x1YVuLib1Bu5qo+rxbln2nWjks95XiaF9u4mTa?=
 =?us-ascii?Q?1PCBKvUpxC2vgJI5S/NWHwDZhssZAX+MPagL+FnIrvrrF5iMdKU4Xfusn9QC?=
 =?us-ascii?Q?ASWUh1Kgj2BhJgUcr/MUKCFOta9Vmvi/q+J4wY1/3/1kYNBMBrovf0+HsyVF?=
 =?us-ascii?Q?Y8bD54ph1O5FazMOwvQ4wmnnBd47x+0wA9Ib1uqFFF1Dh+tu4uA47R9vRPkc?=
 =?us-ascii?Q?4KFx89gUINN8dC4OeME5n8u9esqnkIIv/NLog8H6boRGJ/m8+4WBlsuaJMpR?=
 =?us-ascii?Q?tGBwMw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af22abe6-152c-4209-16f6-08d9d1e71d73
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 14:08:01.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iMV1cQCdkm6PPn6a8eTxU9VOLVRml6p5KaFmiJRp67b+AhyCLUEjMoep9jSsRvwACbbaoXQaIdycerxqFxPPz68qXil8GDJynYtWOE66fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5531
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=933 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070097
X-Proofpoint-GUID: kLkoGmJpZbYb1WtuyB9FM1pOkcX9EB4e
X-Proofpoint-ORIG-GUID: kLkoGmJpZbYb1WtuyB9FM1pOkcX9EB4e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Damien,

> That said, it is weird that scsi_get_vpd_page() does not call
> scsi_device_supports_vpd(). 

The first patch in the series already makes that change.

I noticed because the allocation for sd_read_cpr() is fairly big so it
stuck out in my test runs while reworking scsi_get_vpd_page().

I didn't remove the conditional in sd_revalidate_disk(). While it is
superfluous, I do like that the "fancy" protocol features are
grouped. Guess we could switch it to a comment instead. I'll think about
it...

-- 
Martin K. Petersen	Oracle Linux Engineering
