Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB674D1899
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbiCHNEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiCHNEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:04:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8855ADEEE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:03:15 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228CiLWJ015371;
        Tue, 8 Mar 2022 13:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=EGbJ85CYYS4pyE412jW3hvHqZOlJmkHzFOf0RF4icto=;
 b=nAEFtlKVBGd/G+EbMf+UWMDL67ZWvLNHIFQWse3HtViF1Bzc/e0f1SU/1J8m6TU9n3/W
 3GKgdR04vrM4XIsA/j4oHxUqtKz4mmsHV4MyM9vNGenRx7tB9/YMHmhpi50mVu3cE8nG
 YooSq3aQ4yFj7VyTArndGXkKTCK1h3A+9kio0I2RB1TO+ds1KtSZWrYezuScTBHzyT2T
 5koUtdvCuHoxiszMPObQK5+Jfsie5832rbdzjG1wvUNnmxDxY/uSOxSuZ2NHuSHeCN9O
 eIM8Z3xilCNRWjWr8lD5GQFIOKgg9fsGvNfl/RyyJ8AlPylxHUh80TIrN7sLImugahx7 zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyfsew0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 13:03:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 228D1Bhv049299;
        Tue, 8 Mar 2022 13:03:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3020.oracle.com with ESMTP id 3ekyp253wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 13:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCEscRvwpAUhREmlzsTwuVprB4Lt4wiFAbiQMMYppaZOt6wQtMs5TF/XqC3HakZBdUEL7lmoofbaPrdfFNZdbB7hBMb34OZF0yOeloViX//Ff4iI9AD3fffW8QVsZjl9vfSyk4/lwI57fLZI0sIueJHfRyQIjlijpUqCY2SHMmwD1Fb9mvQ5AZboBn0KKBbvWsFjZv8FfweuqJXrRqZ4AnLWlNNv1rPT4RiGTl9Cu3wyW5PM4BP1c8M7WqtnNEhkjrcQxMDX2mOkUjlnMZg70bhbDrMMBJ5LbW78gyCtNtqT62DVKC1dVcwdMLabzWps6mCpG0UoiakYHPvT/wXuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGbJ85CYYS4pyE412jW3hvHqZOlJmkHzFOf0RF4icto=;
 b=Hq33dB+BEWir6B5j9VxSY/Yn0VvjHiAhZ90JqUZn9FGE16fWvoUG+qBTEs/tdVA+eGiJVnTTFtepKLVCMFJhO/q4OZbwwgiXSkEztHfVaq2ZlyPHqsLfezKjBZvF+PSP2pFsvPWHBXkUgZHT8wfdchgNasBpgiNHCJONjx4Z5XP5K9wgst0PE95luaWF//FB3Kd7Xr1R8RqftfTR5wIsHX1GeAsZpfFjLMOHXykU9nc2R7G43P/Rc71EZyYugv/K91Xbr6asQV0+Dvyx92T/O3FBZIpUl3MQkPgpI8fYRsjDDP2dC3tQAij4rvB2OdT0prnbg8hRf0JYr4w5duoykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGbJ85CYYS4pyE412jW3hvHqZOlJmkHzFOf0RF4icto=;
 b=dxMCfNBVMNp9odnlbNsKTzmNJ4Kfnw2nU1iZ7ozqIooJxbimgcFq9uRXZSHGiT2L+AmPmv/tYflX8HqCI9Gh0MbMQ7zZomiQ5LRMQbNf8M2gUBXhlBuysgkhrC7Fky/X2NX4kUtD8oIRSBjKgW4ALiBFdlyuOSB1+XO4j66oNh0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1730.namprd10.prod.outlook.com
 (2603:10b6:405:8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 13:03:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Tue, 8 Mar 2022
 13:03:00 +0000
Date:   Tue, 8 Mar 2022 16:02:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: formatting improvement for multi-line
 bitwise statement
Message-ID: <20220308130241.GF3293@kadam>
References: <YicRpmT2xMupVp4h@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YicRpmT2xMupVp4h@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39e7779f-2be8-49b8-026b-08da0103f8d7
X-MS-TrafficTypeDiagnostic: BN6PR10MB1730:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1730C3A6921AEDAB6DD1CB278E099@BN6PR10MB1730.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 571X/BbzV3mPlEveRGlTwGz4FfPEw/wltsOc+Igks5GHqGNAJM3GQVMA3lb8C+6woX4DBp1r3ks2uSSbUk6NPKL9BqLV/NcvJ5sZ3sDnV8BoS6vIMi4VUY1Nx3flqrR3YQSYbya4IIs2OmoE+q2tqDxLxu7Cg8cBeBU04SwEHRHs9u8jDIsQirRTI2S+qx7F+fuHZzZN880qwiTADoZ4F7WQn/u4ciXYbyrLtRybZJ3Vj21WYdacxP+MYIjvmKLqf2+zbmHG4o23Hv7SNk0mptAXv97egix+/MJu27Ma9XXLgdaOoTJwz5TdiF2TWyRDHeFggqiGFh6ucITXbZzwx/J64OzXJ6eI1wOATicuPec0r0vnWR2Ic66QRQdTb+LuS2QJqMEnA0pmDhLcaPUTJ66N84Zjmw6IAgDpvgfs2CJ76Jk7CFoAEzxg0N7jmJG+nv3kn3Qb74tO3lU2pQeffKEPi100wAlYKOnRfmnqvpilVfrrMtjrGFgxyYWevj6YxPd59M1gQBxfJ82mqSD1RtvLiXXYIOCeLeMbTlBhKWUA+jv82F3+hydoq5eHCLjR9V6LBrUceDDZ1H6/yIaEIpZAbkW6W2KSfoK73rw0YCP+Sx2D9u6IZF91bGuitNEdXWz9mbUxLMto1rweZqIlpr+EzGZNZG7nHcqvt1dqewAQK6qFaFsS1KXfe55+ePAYMKk1xqt8GksYm09TQJj8TDhT2Shq8mDVBQrQjf+XvsWQtmdK/lDoFYJZ8OGUZ5v7ON5yI4gO7DknN0vKIorL4A5UO8oE9H6rdcnw0hZaFME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(26005)(966005)(6916009)(38100700002)(6486002)(6666004)(508600001)(44832011)(33656002)(4744005)(5660300002)(38350700002)(33716001)(8676002)(2906002)(4326008)(186003)(86362001)(66946007)(66556008)(316002)(1076003)(52116002)(6506007)(66476007)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SKtr18g1Yk24Xt7I+oAc2ORD5vRKuegzJy+qzwWJwky7DVw0ZtFC6N75mFOJ?=
 =?us-ascii?Q?3mRBs14TWu2hSksGxhfdl6LwVy1kmk/MW/lggf5xebpB8TvWoPAHImzVViFn?=
 =?us-ascii?Q?x/SI5lCDQ8n8qLNBmk5wy+MJB9f/3uHQcVIX2FG29LToSdVDwoEZl+gSS7bN?=
 =?us-ascii?Q?IFcVNoNNPH5ONmMybpJy2GouThwvnFuin2+DfnZElRXPix04TV+nIXDNp3lj?=
 =?us-ascii?Q?BFE+BsYk4iDi814F1LDstXBJfRfEu98ZRST+Rw7/OvZ4ono1USXu8kK+v7Sg?=
 =?us-ascii?Q?u6NB2scEi/Dq0MarzTbQuGbdebhHIUdElR/Vbd+5SciYbHiPKUdU9w4m1TWM?=
 =?us-ascii?Q?wgBOFwCJI6FugqT/B6lGqW6mu9txPefQOaHD63RT6xBOMYYWLIKxJ/oeROu2?=
 =?us-ascii?Q?0mW4X+PsNQBQ1YgkDFRf3nki1lL+L45UcDvQMMMa7koriw86GEQm7k5hT1QB?=
 =?us-ascii?Q?nB/GsuhIJknJHvEuxFXE7HIw3CaBqBEzHq6+oe11gDrAqcJY84TDdeJSIH59?=
 =?us-ascii?Q?qRhbREKuKVaosoHmx5aLMpgt1siLGfCdIZbIwJD8S1Unn1/jY0KOpKsRGN1+?=
 =?us-ascii?Q?5ee2/nFKft4Kb5xUbLhAdvzostHLGWhhfk8afayuRU5R5vgcVSLz0YaTARH4?=
 =?us-ascii?Q?F3TAC/BKdevG7df+6YInseBkUoCIg783U5fRyVxboqgp1yOMFSJ5sILcC18A?=
 =?us-ascii?Q?sa/OsDCBlQ1FL6KEt2rVLFSr/cnPLR/OAAdfTnyb/xVs4aq6hjJVE49TlIf1?=
 =?us-ascii?Q?8rB6UNjA2gJRIKxbLS0u1KSNTYgSsX1s+hpxHLcPNwLs84NT/o9GrzB4bBI9?=
 =?us-ascii?Q?Wc5ywHYS/1A5N9qTtwzzxchmEmAU6PZYSvV+3XdL1OTlhZNP7PO2by8higNu?=
 =?us-ascii?Q?Deq2trPPPSqI1ymDp121h46uaekOHrnoifYACNRvknKbP7HJRWrznBG5M/Ny?=
 =?us-ascii?Q?zowzsvrTI04H1j++vzfkWiKv4ygOrxtGkMEIrb4jH/ODxY0cgcD+9wyDAFrg?=
 =?us-ascii?Q?OJ/5BKEy908ntwbyRUiu0+/X4nPrxZFM7mno6xDnTMo1JZOutsUoDnNRL0R6?=
 =?us-ascii?Q?vppyLgne1eyDLaU2cuYihjY8r525C8kblkU1SdwKg6QOF0QhrUzVoFYBigYm?=
 =?us-ascii?Q?AnX3RfBZ3ydUELz/ypZD5HAzEDugzw7TPpS0XNRFEOfmc4vmCjGquUrQdMPY?=
 =?us-ascii?Q?2QidWwJ4fXvzMldMFHOa32W+y7mIYD5DdsUgYTc2qWswwBoMeXnPgGAb1sg7?=
 =?us-ascii?Q?2ldQ2Na/vTUNrAHZkac3dMMy/hg+SkjyMJ8gr/GuAzwyzQpHiC+iMNgilcaS?=
 =?us-ascii?Q?w5aIbVzawhSfsRXx8hNiT77NxiuA83QRx/vcb9L8zCqG4aFFvRYsPIw1uiWi?=
 =?us-ascii?Q?AGBx+QdthAmKg5SXrPBIG/2QjQA6BEU2CSHPvMIl7PFyNuirO/HK7X93JYCx?=
 =?us-ascii?Q?cd8E3PGwRepkEbtZkJYblIkGI6HEV6dikFHSJDqikiKwy3jQ2FWjXFPJwj9c?=
 =?us-ascii?Q?gH3gfLNq9kbF5lpzFpWz2MlKLg7ArrvLeoLT2Ty47/CBz5cV8vLg8rS+46sx?=
 =?us-ascii?Q?eLApWrTa4zbRA8gEgigVZ53OV1sYhVbaOGnjJUblkeDWTPLZm5FJrc2QT2i0?=
 =?us-ascii?Q?2g/qwvfn28Z3RKQs55alp1YEGS2uyS7EtvnYQkytROgxEC6hurzeduAO96So?=
 =?us-ascii?Q?zrof3g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e7779f-2be8-49b8-026b-08da0103f8d7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 13:02:59.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHgUuHrkO0WcJos8r8808S4dfNWlstT10AN8fuIjjbmJTBSUfd1xUNLjeTztMKellYiFRSKYDIZ2bqpzaA/AA7SD2NBjUArLOEE1yEd0V4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1730
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=930 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080069
X-Proofpoint-GUID: 3hr1YLhzYWdA2K_44vOb7diz97WriWQW
X-Proofpoint-ORIG-GUID: 3hr1YLhzYWdA2K_44vOb7diz97WriWQW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 09:19:50PM +1300, Paulo Miguel Almeida wrote:
> Move bitwise & operator to the end of previous line for better
> readability
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Meta-comments:
> 
> This suggestion was made by Dan Carpenter in a previous patch that ended
> up being merged:
> https://lore.kernel.org/lkml/20220228063238.GA2794@kadam/

Thanks!

regards,
dan carpenter

