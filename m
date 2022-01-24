Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E509B497AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbiAXIyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:54:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39256 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242421AbiAXIy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:54:26 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20O6u9nh001908;
        Mon, 24 Jan 2022 08:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=xRcgKB8z9pUiPoykYLgzHFnu1fXz6BnYauv9cRxKwCw=;
 b=i7Wp4ZD5ZXeiNvQkmDprUWoiP/7cJr1+cbNdM7YgHHiO6Wx88TLcDNSDvgRG/N7D62mB
 nMz3RxjjockmKtI5F+SLSZC0YMeTVQJkZpO3QnPQPt8G3ODexGT8wfOwf612564qSQr/
 b3nc0yx44n8LiAiLkA6YTxffVFO8R90Ii+XhW/8jPvgiGyawmaCAviOhypUitAxieg6R
 J9TZX+qUhAezNlJkQB4jVGVqlOslJOE8so2UQPw37qZSj3r/nhAKf1P4uvGwn6TEMRqq
 2MtyE9RAuxtZ0pp0w9AMsEThJHbdyhJbG4hpOt8Yt7QwhLeoYaaC6688OGviMv2s9QmF nQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr9tb3cyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 08:54:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20O8og8g064261;
        Mon, 24 Jan 2022 08:54:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3dr9r3jrmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 08:54:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iARR8e8DVkhNthTu/Bi0oDAOuT55wWnBF9HWoN4LQtcxXZ4/TwXvmBytGwmv3Ny1yXZY3dWJ+znKfni5s1YQ4DyHqy79y1EgJ2/A9INJ+fsjdlyXnKHfhyCMktMKdU4Mwzdp72sbpc2jbQj/Bi8N895PVVm87TnmJLwyM9v6oD9R4MkB+/15et9mqfNwGLe0J9SIHzPlBbUtJoTGNptFwkP+Qz/BHT8omndRsxWwlGL0FDwfL4GdCdb2ZKrzc9o57y7RnDWQrD9WohzvaQ9941ULdOZHEALsN29+B2mYdZxad+LTtkn5CES93kkgxIDZNBsIeJd0PbWu8jbYPknrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRcgKB8z9pUiPoykYLgzHFnu1fXz6BnYauv9cRxKwCw=;
 b=T3auPnQzya5izP3tv0nSXcz70Q1VvSbjj5700gEHD48Q0Kar6mShJJE/JG11LWzHF219nvRDn4LB4m7OiMbvRis+z5blomSIYuMucEgcBBP0RwftrC2CWVMAF/IiTYODzvFV3yVZaIQVzjUZ3uA4kQYBX4PloN4M++WQ64m/A9bhGCfmX6OJHGzNnmYvREk6fGpdEiHwe22tZnEO2K08j35xy4GNnkbFgE29vSUH+VzSy/iquor3i4PZR4dZ+hPVmdnFONKTgIJXmYvlE/7ie9nAG+n9QTH5SsCM5X1Ky/znjDcFiN/Vgmb0xFNrGttICcDasVQiKe8jjGhfPBo3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRcgKB8z9pUiPoykYLgzHFnu1fXz6BnYauv9cRxKwCw=;
 b=GBq9T65TjYkLjCGlXI20v5udsTdjysZHoQRjCGYiZlv2NOlslIj7zeszahmgnZZ2gwE2CDdFdUBiASO/zRLiBnG9jZ2+NrKSvP0MqIMEebgi9x6v/3nFAZhJeaxpMG8ZisH9SGYgI7tk64UBQKhbVNPfs2HPEb+uQLtsuFDtKMA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2689.namprd10.prod.outlook.com
 (2603:10b6:406:c3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 08:54:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 08:54:18 +0000
Date:   Mon, 24 Jan 2022 11:53:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] staging: pi433: validate min/max bit rate settings
Message-ID: <20220124085357.GJ1978@kadam>
References: <20220118193422.GA3155@mail.google.com>
 <20220118230312.GA4826@mail.google.com>
 <20220119060400.GL1951@kadam>
 <20220123074308.GA79751@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123074308.GA79751@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b1b229a-e6bd-4532-29c7-08d9df171ad2
X-MS-TrafficTypeDiagnostic: BN7PR10MB2689:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB26891C2D34FDDF174F8D5E0C8E5E9@BN7PR10MB2689.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9827FtU31kl6/dgYlv2rWf18TVLB3u2IcKfonFaOF63p4mIpPryVGSaIKIXoTe/L/jYbWbmMlwFr1ORqlJEZJAT6ge1T122uz2sz58a/9xU3NqqMHUg2fxJOwMQykMUq3k/MHnL8bs80czpqx5xo+0uy5ssEfcPhT5Y2nvnoj1SJ06JV1gMN+pP2OCdqanoxw2dYCM1u++V3GFb4X6ZOgks9FMgmEh5cwKEK2zYElt8a8hj2aZCJ094XiN0LxgcQ30zv4Hj8YAMZbnKEM431BWgRu2kI9FV51Mmlc27skwlTdLtx6mA9zLDOfKqiGrlTbRtQTvJnh4qNeZYBTzuw5hrWFiTYenFBwZzlBOJYAQ/Zbr0qRbaZegnM5BjiY42lEYFApe5x/XJmkgx8g7/qTg2euomdFjB976+UJzQEt3nDPXNkcEsqcV382WU2TorQHQpwn0Xk3795WPokg4kTLlRK00aUnImkzkgQbs4zvxSqyzThAlbGO6TrekCCevBMjYZQmgkuIKYPWvTZutAzVdgfXNueOVusLL5DdyLsx7uUuTxG+ISYZCURx5ooRGIkzrSDnj0F0BbXGoKvSNUe/T2j0Z/IB34UJuvnJvG4dxtWKMTUq6mj8Mm7bwGqaQt9UixkQQ9jzK8F1Ro8qDwFc/9CEtC4qSpC71PlpUpd2XgRKNH4lXBbsKTWFlSqgYTGoWlVG8dKe5mt+3J4s5w20A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6512007)(316002)(9686003)(44832011)(26005)(6666004)(186003)(6506007)(2906002)(1076003)(8676002)(33656002)(66476007)(66556008)(5660300002)(4744005)(86362001)(6486002)(52116002)(4326008)(38100700002)(8936002)(508600001)(6916009)(33716001)(66946007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZL6UHnlBYE7pnIQAyw+S+y/VqA737WDa4b3sAH+bZZAoA1Py6rREPix6uJcb?=
 =?us-ascii?Q?zOH2vlueCZ/bTPc4ubvHf5mXOp/WqNPkmEVj7kjQb4Kfj5zauCDLqJPc37Li?=
 =?us-ascii?Q?1zkEczK7Jt7E1g4bAFiKMkQzJn+G5AE3BQb1cEGkhbgBt/SlQfiwZqVxyy5O?=
 =?us-ascii?Q?3Zo+2RC62BJVBR+UMhoMHAi5QjPvL+5DhSQ3+gg51NPc+umx0hi9SXF2Xatd?=
 =?us-ascii?Q?ZoYID5x8J/UhX9Qgu3dGbhUoP4hn92YLwvz1aY8dWMtsytQu/5Nfl3g9EclE?=
 =?us-ascii?Q?4rNQT/U33+JezOlzNpSpUH2Q3VRWo8c4Ps8NZ31528Z4gSVweHuQ82PP17IY?=
 =?us-ascii?Q?b1LI3PjUyaUiuuxh7+E8rhDg39dVpS8qL1vj9dKP29ZCcocr9yr4Vhmq1+Zm?=
 =?us-ascii?Q?eGZWaDYWR1nk8XieDc4+WioDikW1qzNy/9JhTF12h8yMdvPgkvZ7ZQoMN6/o?=
 =?us-ascii?Q?CEEcX+nWy+YkUHTqBC/DefwAPuaoF+YB4fEyk/Z5ZPFahOtWO7R2drYd8zjQ?=
 =?us-ascii?Q?mOvxn5llyYZ9V7c9LYD11GN7uMtAx3V1lTXJof1V0XWBvAkL5ThTHddopTxq?=
 =?us-ascii?Q?N4rZiEuA+cH5t7RCEPvFaLskF2lj9jA2pChzu288y5bXISRqy3eJPOKcPKs1?=
 =?us-ascii?Q?R4dwUUiFBEmz+iIttxeYUmP/F5XobQJl4myzu7zh8TwAqsqjKaWm0w/xWY+Z?=
 =?us-ascii?Q?F6sTCN5U9DX0adpwfF/1oZmW90fanQe4p8hx+QlG6/nGfbfuPdWfFqJre37U?=
 =?us-ascii?Q?azQcmwQdFcrOGTgl7ekqx4hNX1ddUIYZK7Is9wi38hiRLfGoHHmKidHNwU0G?=
 =?us-ascii?Q?57E4PLDpMvzHbBRhP1lxH0EWZzPQlcE5UBW9bNPUQjMqP3r2HM1lKf91ewg6?=
 =?us-ascii?Q?YXcDGdZRgnqoSt6xUspUvNb1Gf5uOIWj5zIdUWkIhZVmhLlYM1Yx4L3lWvRp?=
 =?us-ascii?Q?uf0FWhoq/jJ7xzneJnIfsZq7vvLS/fslRTeFcteYaAJnSUoKd5pOiPNedMOj?=
 =?us-ascii?Q?oFvx9groA4wrmNFnG4AO799l04Tihze7rdLrGKzei2j8XVi6RmfONgKPboJA?=
 =?us-ascii?Q?cJzxP7qCJMgbxroGsbAikgND+OX79MFkd/GGGaPgbc/nhXbuTg1QCNWyr4AY?=
 =?us-ascii?Q?cRrLd4XYtX7lt1DzNIzIOCsdzp3XwA4k3iFyX5EwQoWEjjRR084zn439GEna?=
 =?us-ascii?Q?Tqm9zQrlIV5hiJIDggJJM+Sms5dvMKCh/4V3/OkOQgLqR2WFJ3zzqMaw6wUh?=
 =?us-ascii?Q?ss9U9lLOEIX/kFuZtJqwVxhpTOSfOL8LGV/oOqLk7l7t66itzhCcjmKdkihg?=
 =?us-ascii?Q?Cs+d/+w+Mxw135RnOxLE2xQft1Z5CZhhaYW7QKQrQSAnuwUrXvthH/H00XWF?=
 =?us-ascii?Q?W92SL2OdZqBSxDvpi1OpR6AKkElNgA2sE8vCx+FgKWbmb+qMIBeQIxY2Y6np?=
 =?us-ascii?Q?tvbzQiKQq5ugjzqCQoukMt12ZgeE/jNn547AlGRDunJYySWRzdm+UUxHuulU?=
 =?us-ascii?Q?7Ki7cRqX7guekUsqzQKnKxZm24PKnzlqPzNOyAEaNIVYLk9IdzP+04HC01W7?=
 =?us-ascii?Q?5IaPnNaCTCu9pMRM9ZthkegpimMmHG1V9j0UrcFdMHaF1MbnYv41wZkuH5QO?=
 =?us-ascii?Q?2Q7waomajYN9nxy6w02YHoMXI4tKasKAbRbFzq9TBje2HV2965JColoVjwJr?=
 =?us-ascii?Q?ks0hHg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1b229a-e6bd-4532-29c7-08d9df171ad2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 08:54:18.1389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6By4dZu2P++nUzp6rIHdHYcVoogn0MMDkb8MPS7YWfmBssVAxTeYxT1HYBYDLYTq2ibiVMU52ILR7zZVpzs31ntqCY4L7C3e58dW3UgpHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10236 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240058
X-Proofpoint-GUID: xpBkUqx7aqy9-QIlBwb4pvxyzXH9Bqb_
X-Proofpoint-ORIG-GUID: xpBkUqx7aqy9-QIlBwb4pvxyzXH9Bqb_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 08:43:08PM +1300, Paulo Miguel Almeida wrote:
> On Wed, Jan 19, 2022 at 09:04:00AM +0300, Dan Carpenter wrote:
> > I'm fine with this.
> > 
> > Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > But please do add the note to the TODO.
> > 
> > regards,
> > dan carpenter
> 
> Hi Dan, 
> 
> Thanks for the Acked-by. The TODO note was added

Oh.  Sorry for not noticing that.  Thanks!

regards,
dan carpenter

