Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97736522E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiEKIoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244081AbiEKInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:43:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB51ECB84
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:43:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B6I2AK010450;
        Wed, 11 May 2022 08:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=+H94JXryVrmoxymAhbIh5qtReTXuE6pNSHxsKpKlcZU=;
 b=R8+x1V1LW9MeTiwhZaLRS7Muq346fVziyS1IH7jYgDeayto6Ev7es0iORAhUh5D8lteH
 eTLirG57mplXWwcpDj1VwGvNe8oGaCdXpCQR3rrY4MEhHAEi7zwQTnM8MN0hG05FtVRO
 baMxTqfNbH8jZd3BOSOxNguIdVrCjvvmfR1Fqc/1PwQg6RJlMTmUui8pclZBOI6H5daC
 3jNB62Xf5Y2nEkQtiK3fcoiVTEJHVTwXMyCxSpae5gkwDYJQuWAAKog59x2VGSly/2hM
 dD7LSWUxeBteTSCP0p9nf7twWYHuAoTuDBxtE3x+vzYZrgSMc0CU5wbqudiQT21cduMN yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6c8v1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 08:42:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B8feJS038344;
        Wed, 11 May 2022 08:42:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7abaj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 08:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blFQ++BRp41wW18cSmAkgkIU1mlw1TeMiYKvLkJUCjTyCuUYoM9qb3OhZ+YMVpYlR09vmMFv5l1jT3iVIWzFHbdRAlhcDsAMHwVOkblHevSBBqwrpanagDqlWlpFhM/KMHzKjPY7x16k05S/aVwGZynndlI8+5SWhEq2ruDhh5By3gPfeXlQv6Iif++bw4cr8RIKuxbMqfJaXj3/xhluuOm6PZMJaX/yAvUNLA+p4zSmkqtapu/SsJ1uHGcjDOenHWYWbVWwOXU/9iunEDXq+dB0BGWDuIhky2WxCDesM+vDjKK1OXOLwjxd3iUXRe+Rj0d2MKMrUl/+a+iM6vUKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H94JXryVrmoxymAhbIh5qtReTXuE6pNSHxsKpKlcZU=;
 b=FG70rpG8grXk0DY3bEbe3AMn6yOzuETKm+4BUMZCulh+wOrqT1HOBGq7bokgWNzxxYdYrIVLJqDwRZFz6V/UcyU0S4+GIiYDYrH5+oeHgMzMBCkYlNqvdxCmXamcjiz4Yniq4+VnS28atk+M3vMiegCl+JpGOvOkZy3L5xEAWiThCq5MxnL9VNS6jqS7eIOQcpV1Hq36thLmFd7FjAx6Lq7MfNKivSgR3oTkETjhsRtUfLjx5ZX/fT6vcxj56uKnxYbI39kLRkoAktEespRe1lK2mDZzgqAnEHRntjczfmNOdpkV1kCBjnoX/8eP7crBCYgkbXOMxnrocr+moIFPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H94JXryVrmoxymAhbIh5qtReTXuE6pNSHxsKpKlcZU=;
 b=CwTZzCsQ+XMnWSsukXoJhT2JwH38vMCLfYWY/Za4VY1NxaM+J2tdxsd7XvPgCoyuCSSYz/bWOCTxIFxKraqR11FEG2FQjUdbdsUgp6ZxnZpAKwKrhmr61SKPdBu4lmRsk1TD+avBdaPASPpE0ULD/UINzydThFVgcG5vAR3tn0I=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1307.namprd10.prod.outlook.com
 (2603:10b6:3:e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 08:42:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 08:42:45 +0000
Date:   Wed, 11 May 2022 11:42:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com,
        youlin.pei@mediatek.com, anan.sun@mediatek.com,
        xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/4] iommu/mediatek: Use dev_err_probe to mute
 probe_defer err log
Message-ID: <20220511084222.GO4031@kadam>
References: <20220511064920.18455-1-yong.wu@mediatek.com>
 <20220511064920.18455-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511064920.18455-2-yong.wu@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fee73698-11ea-42a2-057b-08da332a385a
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307179D7A975196D91424E08EC89@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yr5450Cynk2CzefImtmCVCO5QKxgSWFY4/EDxMWxCn1go7XdYjbpFtCSzN1BZdGUDGZUYAwb77x7ag+UVIhS3LtTSoVLDI12xnwNuRzwanonsACe3Xb9kl17F3PM7vhm2SCM++0jfLMT4Bq5Qysd8DgbmAN9/9K1m1/S+KYZ9mnNLhMY+lopzimAkvLLVuf7mCOvfAkRDhPFSwZv+YVrdSMoz0RpljlVYtwWHu0HokODs+ekvW990M4wVcJJz3NZPMVf0xIq/YeWN+1m3dO5EF85pPqGaEzzg0ue5lG7n7YjCQXGvZdkDHr7cw/w0N/V+MdVzwCLNDlHaT+XH9eRE1SpYPL2d6FA9mKCFuZaz/YOIyTxjFH0w2/EJeia6kPR0ltwJjQAbOMT/2IEwmHdsZuRySRwbWSBnkSQNf535RvNRG6g37+EFC7mpRwugcBEARkECPhqYMe5N3+TVRTYhYFx65DF1NH42OGu03+twvrSjdyoeTbnUZuEIUdygfGDziXs4ebS2cFhZPKIAQ+WZRoSn9djgPhlGwJ1WTF3SH0/1ibBvxv81scKbB0817Rj98blJBRgQWGCQI5rawiaT/9PtfedMZWoxCbRWvgR2LP9QxH1vOOdSueXHTNLjnFPMhFXtO4Rja4eNY/1RcIZZ+VLMSWuLaqFwyC6syxOsetaH48x3npAxNtAEL0MZ0h/tvLNp6lqr22a21AXyaZxAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(66476007)(66556008)(54906003)(8676002)(6916009)(2906002)(6486002)(86362001)(508600001)(38100700002)(38350700002)(316002)(8936002)(6512007)(4326008)(5660300002)(44832011)(33716001)(1076003)(7416002)(9686003)(4744005)(26005)(186003)(6666004)(33656002)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2qCRrVDEaHmynhJmsPysCQUxVSl/oFLJ6fOyiC9+WO/SxfyRwZ0MsJMNj90c?=
 =?us-ascii?Q?+QCbPAkd5iG053WmI2eO9wl7FDnNY5fC5YxTTm2UL86t1uNbUbAqd0fPO/XD?=
 =?us-ascii?Q?Y1y4UeJ00mk1edLoeZgh9xM9v3Ad3zXoECZ17toSHx8PgmNfG8GO3jpZxPss?=
 =?us-ascii?Q?3jd2/jsLTUcfp8d3Ab+erDQVM7JONMpUCv8lCZfi+ZsKo6wp5Ioy4N5OztV4?=
 =?us-ascii?Q?fzAjFheDmRGtbtUoxLIT+SwW7UhzUSlqmbwVMH6VpBwtcPCU530Z4ZgnxwSX?=
 =?us-ascii?Q?K5T1mtlYKMq8SGyFUipFjC03AwlCMCYPbLGg0+MGSCScoj9p4FnklzUfXmuv?=
 =?us-ascii?Q?aVH0gXcg86SANhWN358GG6i1q5bEGIjioqzJRBQXVchdLOhjsDhvSI/aLjLb?=
 =?us-ascii?Q?lEZ6IOhFdxSW0yM4XLASMLenYPVTunQYp0YgSdqYVJXWVwkNNMzoMV3usggL?=
 =?us-ascii?Q?0+eRsKw7BOhW8IChGILd1LfpK7G7h6wxjy7r0px0rTxuLm9jLMvZ0saQEpSO?=
 =?us-ascii?Q?+aWaTw+o/tyrZi7YQw80SchacIE7CvGI4stlWN56ya/kN1YmVo5vJLqZsoMM?=
 =?us-ascii?Q?b2P7aRo1w4RJP4VbG+fQqghcRGAKMlzSpUedFTnF48d4fakQfvEuw/t8fHT3?=
 =?us-ascii?Q?+bGouUhsracuiBFBsAO+mv1jJuXQ9FPI4MVB9+oZHtRSP4IJkq0Y77DRE2xC?=
 =?us-ascii?Q?UdhTPvNkCzVJr1utThmWSG0xlGlGhs83cyQm9uSS7ZDIWifqiCTaVeD2uZpe?=
 =?us-ascii?Q?h6hwPezNVTk8jb7ibckOIPA8OO4VycNu2k59l/L65jhmEpfmiiXhR5Zo+tlY?=
 =?us-ascii?Q?N1Y5zVcVpbu5lg9AWu9RnQokMwMKsRC+t2HIvw4+YNOSpiVw0nvs7En8mmju?=
 =?us-ascii?Q?TVJ/dFfML31vd5dX3deAtmzuuUrUZKzLn91JEnj631KYSeFTYRE9tuBQ/UOg?=
 =?us-ascii?Q?aSNhtlMWApuID8DKDrtmXeuU/RJ+aldOT6+ityXqsYcxkgVFlNXi+Ze3rI4B?=
 =?us-ascii?Q?g8uNg/8x7a2GsdGZrnN9cVROzxpGUgJIhSGTw/ny5ymkNKgxYEhpvYh0bwo8?=
 =?us-ascii?Q?rraYnCGg7v/zcw+fDVMaIMTQx8A1tKg94PW3H8JUjxcNuqnWuwfYd6ZvQS80?=
 =?us-ascii?Q?Ar58L84durAFbVEc9Bt5jXV+y5jx9IPYr6eQcb+ROiAx3KTp6E99tAtVkP0l?=
 =?us-ascii?Q?eorMilxdsKVBzsB0zISuGuGIuO+MxE1nJBVyZK30clqhlyoOdClAJmxd8fBG?=
 =?us-ascii?Q?K3lGJTSAycxNfSSuYZeWwrXazz08F6PA1QGbV/6vcCqJZUWUzeMbIPVS5pVC?=
 =?us-ascii?Q?k2/eI4rYQGIgE8MsIYDGRKbx87/BIbubTFKbRODiHYM0xKcCqvf5jAbLSGdP?=
 =?us-ascii?Q?iv2MnbpYqBKkHzrWHg5soywBi3PPsfhyCq0yzyIbszRQJwthUnuB55Vl4HxS?=
 =?us-ascii?Q?bl89yH1JmeE55UHvlTNJiEJ4UIdrVIjrACU+Trhfe2zzhRk01L8x/HqENZ5M?=
 =?us-ascii?Q?9+FXLSQ+bwbbUTk8dCCtWiSv30SKFZ09M0c8MVMt64KJHK9h1vIGHbH2S/EX?=
 =?us-ascii?Q?m4PUNW+JYUk/u8WMd/VDZK/48rXUQo6egtF6JBQ1/XVoNOBug8BhxUDInPlt?=
 =?us-ascii?Q?mLsk6HK1mi7oVO9reqRzYUpRe0Xgnb4rjD6HiN55axwwX1Uip/cJETQNFEU0?=
 =?us-ascii?Q?0oFFSID8kOVj9y3xTo6O1qt0vl0Mt4a2PVIKn9AP8zkQqSw/8Keg45pX6a5h?=
 =?us-ascii?Q?xEB4ITSrvnDp+7OJ/ufwHW+59zF95jM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee73698-11ea-42a2-057b-08da332a385a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 08:42:45.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eD9NSfofSwsv9eN4hUmGnZoSsmtVnxhOgQTnI6tG7yK7V7uv/SjE9im7aOr7anlV+J4LRiqE5nxbvRMSu3g8dpmGIgWb2P/rN5ULVQHNJ/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_02:2022-05-09,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=855
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110038
X-Proofpoint-ORIG-GUID: -TNIp_WMlBaQIRmep4cyp2vyXxmy8w-q
X-Proofpoint-GUID: -TNIp_WMlBaQIRmep4cyp2vyXxmy8w-q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:49:17PM +0800, Yong Wu wrote:
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> The Fixes tag commit-id is from linux-next.

This is fine.  The commit hash will not change unless the maintainer
rebases the tree.

When maintainers rebase their trees it's their responsibility to deal
with the Fixes tags.  Often they just fold the fix into the original
commit so the issue is moot.  Stephen Rothwell checks that Fixes tags
point to a valid commit and there are probably other people who have
checks for that as well.

regards,
dan carpenter

