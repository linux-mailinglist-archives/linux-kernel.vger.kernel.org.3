Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129D049F476
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346841AbiA1Hiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:38:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61644 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233478AbiA1Hix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:38:53 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20S7Bhlu017933;
        Fri, 28 Jan 2022 07:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=BX3TE56U0VgY8sm5Q3tH0gQcgaW0h8gYRb62J0aW5Vw=;
 b=Q9KN2owaLx0dhapjlSNI4pHdxN5KvV+bR6Fb9xqgW4t9JVI7cfDF3+YbFyuE6HsDn/jW
 8FWmjdw/byVAtO+38etPIwHnlUYUgNrm75jnVt9/8SI5P5KfmV0lpCYGV9tTahWc+53P
 NYntI5RaKbh+akD/2eBsW4o8TkqyfszfAYntP75Vkr3Vzfng3g2ztRlTEOWBmks7FQ2w
 QTsrw+r7ReGaVG6Ktrc7+VBA9FvU5LiVaX+zGi0B07mgALQCtox12sAbdxgYQVKONNHb
 RGwEIt/+M9XjgB+IJbC5jF5envM/wCaVotETzKwuwzF0Lio8W+WEl/d2LFUgZPp6ryc3 CQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvquthuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 07:38:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20S7ZQDM035399;
        Fri, 28 Jan 2022 07:38:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 3dr7yn9d01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 07:38:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeiSWAdnXorUUMwwVPO4uZnD+Zj2lwRLJx/95WTz7VGo+sVqVh8TlZmPlzoZNHjE7CEm9YR0O4qxCqN0Pob0pOPP01tH8pM3EsE1y+qB9Pt+Ms4bz/yEK+RTVnA4ZuyNNOCeixgvXfWvb9W6F18bawXAnrLl+nhxdvcX1gWpp14Uo/+NCGVkLD1/xou4iBIiNHUDfvMPs+gbC+8FhvZ0vbWTKt5wqT3bj8mH/fHmJzcrC0lxCcBbr8SkRS5cabEWWE7Akv8sSXKTRvj6zv2T+T5tR2oilvXTEajzNuHlEbyKo6cgi7nvpHQkSZWwkxeGkHjHpQvoDSvOniqdIiudMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX3TE56U0VgY8sm5Q3tH0gQcgaW0h8gYRb62J0aW5Vw=;
 b=JD5+e+Wg8D2bkDd+kDkPzB7Msx+XGQS8Vz/YWy3WzhNuQWYbhTK/ZX5sfCtu6jZwAAIi1CQo7QzsqD3Et96AL8UgNGfPkPUab8uaZ2dG1uSrR+doR7swrbj8tmNmJSQ2MrJJqqWit4LvaMjsrE8yve9c/vTzY5YhPTb9OOWMyjMOzj7RiBDj4MRxxCFOJdso5KxfCYihen6n1y0HYyXrvsf5eaYcC1q+svUY+eB4a9HvEaHFhFuPux3jxNxbvNsxtXnedRB3OXOUBfDz38zYG7qq5mpHqntXeRrCv+E8rBL9axgVOz+5orn36BPCau+9lir+U67o/7rAThIVnSTR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX3TE56U0VgY8sm5Q3tH0gQcgaW0h8gYRb62J0aW5Vw=;
 b=mEzN1ggyK7Zwp0yl49eR5Bon984G1gBD1TW6lrPENBMIkyAZLZvTDcSHZ2UrnwjnffbuUp5jm0bBSPkcgWIttfkgNQwxrsSh9NQKyBymUSh39SQVKiJNZ4b3Ku04M+QzZ0OBgux5DhnpD7u8eb6Tg8WjQNm3yZU0iIizsqPEf0M=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by DM6PR10MB3657.namprd10.prod.outlook.com
 (2603:10b6:5:17e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Fri, 28 Jan
 2022 07:38:36 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052%5]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 07:38:36 +0000
Date:   Fri, 28 Jan 2022 10:38:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: cadence: Sierra: Add support for skipping
 configuration
Message-ID: <20220128073814.GK1978@kadam>
References: <20220128072642.29188-1-a-govindraju@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128072642.29188-1-a-govindraju@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a62c74-1ad9-4600-4ab5-08d9e2313144
X-MS-TrafficTypeDiagnostic: DM6PR10MB3657:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3657B02EA76116E8FD1CDB2C8E229@DM6PR10MB3657.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3e8Bgo41MD3MwcsDZ8FhvBrrsPEefQZQjnAjG2GFeVVbGfRd69usi4FxQWjeCCXWxSdl85COptS0TzeEUJd22N+Si/QBX//j8K8mUpSxztmbcyP0sa7vZ4feyGxHCr0yymD0ibBURfEEZzs6ovoeI68B4NkAIvvuduJjWS0Oq2lcxTelN3SqBE2iHdn3Rzgw+4GN+uyaa3HbkNsBBGPlWU9z6ygk5FMCC/CDpR7KlaRYzLQ1rz9K56ptpyAieDKHKPJvnr3LURrbmvmIY1udekPdhUCnLOisTGySuIFBzJjy1iOPOXoW3Jdnt98sB5segAGkTQ55JG5xxOlNkw/pXjV4x32xi+CIzTqRhd+3e9WOIfHeou8WgBwEIKHpqnypaI6JKynZYJM+nFVgNIWKdNiyZp1ncfE945F/zJLvMxCoClwfVWoiKCgDBTAa2IIEM+fgS89GTgNvvN38GGu48NRnke8Ors2XI2RURWIB7i6SL4AqyVA+wWYopE8FcqydRDQpjUT7sIWp4wmhsp7c3pjCvaecqmrXglKHq5BIdrMAIbX1mgpyjTyzNE9MHYh/fzPrj896lyQw2qI2UoMPlVgER4nUgwU9O8fya18M0KFqj04JvTCp1F+GDxBUPG7r/2G6car2CA6lUK2CzYugwmkJmXVwji0ptq/BJXhB0WzQvrgyogf6MVWSuRmVOLKP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(4744005)(38100700002)(54906003)(38350700002)(52116002)(66476007)(6486002)(44832011)(4326008)(508600001)(86362001)(66556008)(6512007)(8676002)(6916009)(66946007)(316002)(26005)(83380400001)(186003)(2906002)(33656002)(9686003)(5660300002)(1076003)(6506007)(8936002)(33716001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AmsY2FHRMmf0SNRJtBgvCif02Xuk3pObP6HB4QrVBgYYeewHMjt5qjwO//zs?=
 =?us-ascii?Q?oMBhPuo5u/4Vgb+JLzK9aLvWE101vGEJ/lsYv3JMPPSnt2ypKnuni9mHHBRo?=
 =?us-ascii?Q?u3BEQw5covD/YKJWID2Rsc6vOjyt9xtzoaBmuQOaAvPeL4efVKjFzwFLBm9/?=
 =?us-ascii?Q?YCItiRMCsERzA4WeuX/TBIxb8t5hZsFcgC+VC5hBzGI7icZ8/h/FHXGObAlf?=
 =?us-ascii?Q?HJqUe7Ke2UgtfdoLFAS/BCs3BKpuawP0xtn3idrTsVcTc1ztH1jQnr+SpCpT?=
 =?us-ascii?Q?b7HGufaboduq+ZNBEMXyHY27B337bNBfG8WVE50wtGEiCWrQhX25BGClfOLl?=
 =?us-ascii?Q?wcEfASuj61r4n6HSjJkPYnF7YmziH9anDqr03R/VECF1ZbeHhdMtoYsTN6h3?=
 =?us-ascii?Q?RSVdYSke/jAiJO0uYU0Krpp4gX1oJt/GfoB7JuuDVqbEV7bj+4KG2Mca0eIZ?=
 =?us-ascii?Q?bRVbdYJVBoREoc+wdvglRAAYxgDNdvltIDLQQPr0VUhc5Ldxy0Kmh9kkwfZJ?=
 =?us-ascii?Q?jdH0UNHSdmjbatbDQ12eL57C13W5hH1Dswc2d02CEUQC9AZPfZLQy4qQH/4w?=
 =?us-ascii?Q?0kFF0TskJfdCKwruSxGCm6CLRKl5DkVxu6GpFsnsuhOUaQ7WmwQj0ESRNHPo?=
 =?us-ascii?Q?QVxZPW7sHHDweV2/cQAJVbGUU6W8XtIZZ+VjONvnyHd6gLLIXXo8hraWhn2c?=
 =?us-ascii?Q?JQSxG17HBOMNczlDX4BJM/cZ/Go/MEbN6vomERvPR0b9ZewVuSfh38tIWN/w?=
 =?us-ascii?Q?ZsHgIB2XD9ffLyCUKKFvTB+K0KOjzDnicEp5gXeHxC3ogNXI5UdwhZyP6rYi?=
 =?us-ascii?Q?j5l4ncO2aSeFo0zEBcEIAHZ7lxqvSfsuqSZnKPYEV36qXNQDwHiAipkTAaTT?=
 =?us-ascii?Q?na7HhJP2Hn8KQAiV7iYV4bSZ+FABXhbqBI2rN1Rte9GbbIHMbAzxo2lXUf9F?=
 =?us-ascii?Q?s6jBsyd9PNduHpADVHo9eh8MXCDn8eUy+P3grskNb4HodE2mczuik++rNAA4?=
 =?us-ascii?Q?FbT/0/nu0LHSFsr1FqGNkKf4SgA9RoLxcxFtT7A7H4eMw9EpncOHT62t9UWp?=
 =?us-ascii?Q?H+w4iwnM3g5eyyEJ2cChYun6piefLKYr2EJqmh+zwf8640FVEaB/2S6QCNQl?=
 =?us-ascii?Q?fXMsMb9jlIo08C67SdMZqttHct3PtB9ZrYOwAnOrPiZkMLk+g8yx4EG1wZOG?=
 =?us-ascii?Q?Kfn7GJ7dilL2SxMEdyn1srQwRoqvrfenIOFnEHw16yX430J1Oikx7PSMv3BL?=
 =?us-ascii?Q?zaVzlKzWDbHh1aVWCERzcmTYNrtbx6b6XxKvMfAUdiLuusEvh+bTFzJnEzRT?=
 =?us-ascii?Q?WAmWfLdTZwUiqFfRfxRXWOp/Prcn6DjdlXavd+QDn0oVsWRPtmYi/Tv5M3lJ?=
 =?us-ascii?Q?kAclwXzxEoAqk2u8C3nIEHL+IDFRYrTzR1CdJrs0TamCelI7PYupdScyxbNg?=
 =?us-ascii?Q?dECCpmHbEAQ2fbKE5j7PFBACIWktdLPmY1w5UjyhI3VtJ1pW2DJPh5cOe33Y?=
 =?us-ascii?Q?/mW8RYF2s9hqgpYrwv2ZIKhmwKrEpLlkbQzTGcUKCiWCnIW5juy5yT7RkqBy?=
 =?us-ascii?Q?kyRenQ9uJ4DwizvYRzrofwHTzPHHMtDCV4iYkdt1UldgGmyiBFrVSYUpinxs?=
 =?us-ascii?Q?iw+rNEf/klEfx7VA8UvpPfd/1RkYYDdiAKl3k5mQORfqnT485h03VW7IDKuQ?=
 =?us-ascii?Q?DX0kF9fRPPrSIlM0YrlPRMKJPZU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a62c74-1ad9-4600-4ab5-08d9e2313144
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:38:35.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIA9ait8t5/b8lww9ZTgBbrJrC5SnVE1dZOY4dFJCGRcWsihTyANIg/FaWuWXabcSH6yz2MsFqWXPRN5aweBwlnc34ns1Hq7e+CgxaMdUQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3657
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280046
X-Proofpoint-GUID: 6WNTLKHJ_-m_-UKyyVN3fkUh_DHF5_Hk
X-Proofpoint-ORIG-GUID: 6WNTLKHJ_-m_-UKyyVN3fkUh_DHF5_Hk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:56:41PM +0530, Aswath Govindraju wrote:
> In some cases, a single SerDes instance can be shared between two different
> processors, each using a separate link. In these cases, the SerDes
> configuration is done in an earlier boot stage. Therefore, add support to
> skip reconfiguring, if it is was already configured beforehand.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Changes since v1:
> - Removed redundant braces
> - Corrected the logic for skipping multilink configuration
> - Corrected the order in failure path
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

