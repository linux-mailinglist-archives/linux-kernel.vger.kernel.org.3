Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7509948611A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiAFHo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:44:58 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28178 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234484AbiAFHo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:44:57 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2067Y00p018971;
        Thu, 6 Jan 2022 07:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Afy2x1lOjmc6VTreUZEZzUrqu+R76EwG6+MUZuh8WHM=;
 b=HfnTNLcQHaUQXSodjT6MIww74vWVuFG9j5eusYgYHJjAIn1D8RmVLRM58bo4Zni49nl4
 UMmv5nuZMvP8/mPCHtTbQ5t9/fOcksO6qGjGillHulao3tUW9feLTIS2k31D82P0TCvM
 +rz0axZDMmEEi5UVMVhLXY370S5VCFPwU17UxpsWCbm0t+12w9CosRTbAsZfI7Gzf0iN
 T30AB2l2UyUhkJPVoVlgUY9g1OUkl4oXDimVixet31tke4joYYM7HlW72y1be+lMWObM
 3Lpab8lgoD/wLVo2/RtY9CrM7NPdYqa7lloH21LvunJFNTkqkQPpR5SAKm8IIkYuhYYk yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpp8wre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 07:44:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2067ftfE053418;
        Thu, 6 Jan 2022 07:44:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3ddmqcbh42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 07:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtkIWjsx4fgFhHqUPNLdDgF52ZLyx7sqSvE85sm8Uu1eR+Q0aWCNbZNlJpd1qlHzKLW6ZxjWccbEVgueo38QScXPcismgUkE3ZCM3r44ahQTIi+h2ncG6LOMVISgKLZCdKGnd3+B7Mesvyz3dGFIXZkLLCk9rWOiktguETMJ44p+7J7t6SL5mH15KtrHvty2m2sfsCI4AD6S1M8QgUTZZwUCtKDq7MBGjUX4ZfTmoPzXpv5qtPL1/BQhU+RbbKuYtWd2l6FO+CIEhBva6SawLyfeiL+6S4oyZwdVM2NQkz0nyNNmp7Zj/wRgOiGtB1o2nxjkaLnNqi+eWLVRKS2WZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Afy2x1lOjmc6VTreUZEZzUrqu+R76EwG6+MUZuh8WHM=;
 b=XtkB+/LakaljfwwHlQFg9g5Aa79DbEAHBdK6KEfkYcXrpLIYNq7XRlqdSAfSOk7PvN/gNhxQRqKTDTG1lvVqg+nXnwQB22peFg9fdIoTTINYWaXvMnmvhpLpyLMboBystiQS08W+B20m7vwSKS6FXAEM9C8pq28NGLFhmKFmp/DNQVDq3vTM/AqGfqFPZhHiai7M9zQe3vVSi2e3PAZvq49cRY8SaQFfJycfaopz4GpYGf/QqE7OroNleCjDtH/4hvnaJsWteDcKhve9aRrB3ZrQFLlnY5vWehS/ixZgMeJnx+DXetsyKwTTyu7IG4jL/hwnzG+n5i+IwSSFNVvJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afy2x1lOjmc6VTreUZEZzUrqu+R76EwG6+MUZuh8WHM=;
 b=fOvj3nO6oYyUf/XOgPgGzOzSRVjopuEaoiibh2wWUrUjZOqeTVsfkW5SxoiO+j/elasbDnJ2BSvYJziRpJJG/fnyjBtPsGOg2In/KhEiANYVy9/lwKD+BbbIn4IHfOm+1TzYnA/jC/5EjCR7J6CrGA6t7oldY5ggnNifGNPFSyo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5792.namprd10.prod.outlook.com
 (2603:10b6:303:14d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Thu, 6 Jan
 2022 07:44:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 07:44:44 +0000
Date:   Thu, 6 Jan 2022 10:44:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        axboe@kernel.dk, chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        ming.lei@redhat.com, Johannes.Thumshirn@wdc.com,
        shinichiro.kawasaki@wdc.com, jiangguoqing@kylinos.cn,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] null_blk: Use bitmap_zalloc() when applicable
Message-ID: <20220106074423.GG7674@kadam>
References: <3e68598defed010efb864ea55887d88ed0da02cc.1640296433.git.christophe.jaillet@wanadoo.fr>
 <c60a1750-ccbb-1f7a-12be-ac331393be80@opensource.wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c60a1750-ccbb-1f7a-12be-ac331393be80@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1078dae-6ab1-4af3-15b9-08d9d0e86805
X-MS-TrafficTypeDiagnostic: CO6PR10MB5792:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB5792BF7117C8253578FA7A398E4C9@CO6PR10MB5792.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8Ixd4ootPKGyJM/3GaeAz1dQa+eDpFhb0WY4skEyRuQ8BpTnIaL/vyUwHVOO0TKlVW6iulW8RHqyeufRKleYjxg3ks0JwHyufUBh+YqnsZAjipahWDtCsrOzGywKlW0pgkov58mZKRUXZ7LftA4QJL3JgJiXxpeLhwWk0sgyMbbtcqBp5/tDPhy8KMUOV/4jZs7zwYk1/P/TOzvmwBSvxBh7mM/2cSSs0xe6uu1owdHWpwfW34lg97tiyBZhENwtDOAuby8/MuddznBKAnx+pyE05nMBEEElCA01xM4vivFjU2Cbu6913JqAPnuTirb8i14HwMT99Pb2SK8wx7/JWXku2yMUNx2SoQsgjyCnmpQRZg+8u73VUCv5AO5vJvQERvPSi4zA/V89lvR98G1ifSa2Sv56tDP2z1UWgELhK5qHtMWqR+C2WyQkyNzKrgbPSFR/wNgWRUeh6g2Dh5560zPVqs9/O0hwsy1YHklG4NqJSJeNB+dqKiDfMYZzPVRWqWsgR0hxeoVPXl4r1LyFhKAharQj3d80zB90tLNAb15vy8fhWRYyscCC92yi9W6AQmecljm6fySbGOb7Fh/bJlRK3cdOHEQlot5cQa7dHsJput1Oq96YkMeRIapEfMV+PmT6y6On6UiVIyyx5MWSep2tXl9St8PM5bqTIj0ungBwJT+xpY7fYe5fQ8EP0MAk3r7tDsvvXwfci8R7V98fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(44832011)(6512007)(9686003)(33716001)(2906002)(86362001)(186003)(7416002)(6916009)(6486002)(508600001)(5660300002)(316002)(8676002)(66556008)(4744005)(33656002)(8936002)(6506007)(4326008)(1076003)(52116002)(66946007)(38350700002)(26005)(38100700002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lvXVez1UMYC0tYIjW9p5g/ls3dvlLSigmiWzJ0ecGjcF/2G8un7J9gYPxgGJ?=
 =?us-ascii?Q?+b4afUMLa6XuPg1B4pkXIvP+X0Oh/R6o9Xo/bFL5Izh9kBx+Se2SW+/tEba/?=
 =?us-ascii?Q?1F167odlvZYpGqVJXny/FNgiilkHPhwXReNaSeKvTy2RUwo2kw2cTe32c+3v?=
 =?us-ascii?Q?fmNFbBUmfxH2AS8LUw/Vfhv4sErHQ1tAp3wXdNW4zZoZ8wBEo6IAJJq6SzJc?=
 =?us-ascii?Q?tez7N25/CeyuMxCreE2DGsEhfoXqhjPvOKzk6gloNfCkezRCYCN1brKukoeb?=
 =?us-ascii?Q?qWppA1eQTmyP1yapdpWOpJ0xrCCxNuGo1qjgjy/ra1ru2JPOqj9aYavF6H75?=
 =?us-ascii?Q?JpedgdGWla4cS8T5L7BLl9zdCOuTGtWUHF8KCcPUH8vqLw+QC6d9wam9AVKO?=
 =?us-ascii?Q?Cnlhi6WQRLc+D52HtD81HXCnM0H7g1vhZEIJAROz7EFF991hEvX4YI4Eq6sp?=
 =?us-ascii?Q?htDvYFa796ASFv2DxKCR0OKab7yBBCh44L+OBFglt1QeDIqbFhXIah0c2Zug?=
 =?us-ascii?Q?pkY5pMYbvemP0fKTMX+tkyagiyK/H5LK6Nr9vnftIz1lNPCywu6n4D9G8KUD?=
 =?us-ascii?Q?mth/tnN5wL5htYbNb+r3EWbMx4J0TAzcYfobufnsIV1UZUTR8yXD4Xcvd1fr?=
 =?us-ascii?Q?dOdcYW+kTCPj0poUl18jq+PL7out/lRn7L7QCZFc9tYwOiDhSVmXn8cI81D5?=
 =?us-ascii?Q?WToociAN9NpvIz/EzD1lcQjjpSCGG1fH64roMu5Doc5mk7A/foFcxVnQhFZx?=
 =?us-ascii?Q?o1Yi9r7t0mWuoBLdufC6fYNvLvnmPIHla2mj6R9OfsGqv0BjhXC3ZhrYaY96?=
 =?us-ascii?Q?b4dZrCS9YTT5unCT0BluOncf/j+2Vy3EuMi71mIYxinWcSa23XJR554a2At/?=
 =?us-ascii?Q?Eb4QU3rTbjO5/HG4m92nxhDTBqcbsZ9AJ/Kmp5yN1ZpVwJTf78swoWwo3x7l?=
 =?us-ascii?Q?8uWYjk7T0+FFab9++GScDwp0PXUnwmny3wBnS3cB3EyF8fFSc0wfHwdrB/6h?=
 =?us-ascii?Q?JDwMPAJFVJALHlK7iUivLiSEt9ne57ynpHyYiLzcpaHlcYhW0QQ5eo1XFNTA?=
 =?us-ascii?Q?t9OSwPEOFdS5X1808A2Las23h9NLGZyJlvqAq7J41F91r6540ddmIuuS0e7b?=
 =?us-ascii?Q?eDeatJWciwx8QQqFo2A5B8yMI1T1GrcEizSSUO6VKy7btin/hT30VNnqCWBJ?=
 =?us-ascii?Q?Poz+HcP5d+nx3OdLuuPvgJb/Vbp0siB5b1OVf3cGoNe4V9H5KNeSZMDI7bDm?=
 =?us-ascii?Q?v2cOKX/mRmKKp2DZcIEjLYZrySjFfCTdRiJAtbTQQjna1jR+sHeIWiRWtCgR?=
 =?us-ascii?Q?6BgJINPtjr6XFWu3QeZXmXCfl9OOFK6u911+KXrcryMEWCXLbSjIxAxvG7X1?=
 =?us-ascii?Q?GtWBcLKkrcnJvWT/YW77DHeW3fxgrCcygh8+mGOR1FX9j6xm6sTW86HImj8X?=
 =?us-ascii?Q?/j1LFnG9fLpYlAqmFn4oU+KHMIe7Ph4e8Oai62GHGVSSNl75QHev3UO5EBgK?=
 =?us-ascii?Q?/3eTxiLLPpYpXZwqUICS38rRa08zpBxCSY56KeTnbfoZsilpRVQHgl2IETIC?=
 =?us-ascii?Q?422oiSwyHTxu8HDqSDgWthMcAJeylwCr2PINu+ZKtoFA96E/BAHG3Jmpjt6B?=
 =?us-ascii?Q?BNPI/7M7kxwIc7qdiz56yjKgn6X7z6PxS/WeyN65a/FumVKYtdDmJQmI9bnv?=
 =?us-ascii?Q?jxSv0SQXVg0M3mO4k5Ndg4fuwvw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1078dae-6ab1-4af3-15b9-08d9d0e86805
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 07:44:44.7820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDIPeXz85x3SDck0Rvdgso4KKfZMi0gQq609TNrDr336NDREpUjHO0XgtpbGjOJi9RTLo+xlq84yS2JoBabS2JXbWoD0u4H53uDKCARHK9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5792
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=992 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060052
X-Proofpoint-ORIG-GUID: aIJ2r0JZBE1m69EN16uAsjaptAXrsd-_
X-Proofpoint-GUID: aIJ2r0JZBE1m69EN16uAsjaptAXrsd-_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:28:28AM +0900, Damien Le Moal wrote:
> >  
> > -	tag_size = ALIGN(nq->queue_depth, BITS_PER_LONG) / BITS_PER_LONG;
> > -	nq->tag_map = kcalloc(tag_size, sizeof(unsigned long), GFP_KERNEL);
> > +	nq->tag_map = bitmap_zalloc(nq->queue_depth, GFP_KERNEL);
> >  	if (!nq->tag_map) {
> >  		kfree(nq->cmds);
> >  		return -ENOMEM;
> 
> Before this patch, tag_size would always be a multiple of BITS_PER_LONG.
> Using bitmap_zalloc(), that alignment goes away, but I think this is OK.
> 

It's still going to be a multiple of long.  Bitmaps are always stored
in longs.

regards,
dan carpenter

