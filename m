Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4C84EB935
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242459AbiC3EJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiC3EJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:09:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B382F1704F5;
        Tue, 29 Mar 2022 21:07:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U33vba016596;
        Wed, 30 Mar 2022 04:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=sWMR3t4Mi1TPIvLvq7e9gjBlOUT+THkXovonMPIAqbY=;
 b=suUDADsf9GwvfRRWSxp/89meQYTIIzzp+thm1Zg0fPitxc0c55GXNNquyLYS92FUr0OQ
 IVVsoCRL4cQFq48y9da5syKqtXr3aX3NXT/aWcI+3+fvGmDmCkvTkt+6qIufyimySgTW
 cIMJy75SFkKwHmB6E6fhRsmIoA9+QS0iu6Zn6dqira+3OptvyAWfEXO6bxNE7ABXYKZJ
 dyBUoQymkgISAUZoGAGtocOvoqHhYHgV+OCXsSGUkLoj905yQO1/XUyBhOnXFQnEmrqd
 jefF/DbcSzv8dP/1pgWzCOn0R8AQofEMDn8Wzck9aq3N1RsoG2v9KaiLSWUqyrANk38U 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctre2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 04:07:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U46lWo158258;
        Wed, 30 Mar 2022 04:07:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3020.oracle.com with ESMTP id 3f1tmynent-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 04:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iggKEb2ujmhLc8BnP50wbrYZsw3eaN7P567IHA5gFgz5F9kXzcl6I/r8MDaGWfuhSDzWFckpmD5EFHZeTPpYO+KbateaXLTsMbCCptWOEiD9IdJllpbyQ+VUgunQxlqn36NMvTf374AO1ccAQUCnhQ9n//q5CKM3KDkuJOEkufRB2YpAR5j2rVAvwodlCmwagBr8Nk89x2kswON1Ge7A4x0So3+uuI2tnYsIzY6RKuUZ1OENg4H8/2t9yS5ATvVPVsqh91lG5tK/pp0mH9653CcI9fZWU21HknCxMlURJHj4qD7g/Npc8LtJJMUoj1AZBf/aBIAbmae9zXaAX60cIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWMR3t4Mi1TPIvLvq7e9gjBlOUT+THkXovonMPIAqbY=;
 b=BZ6T0CMbP5+EndKpiBqqLnGUnAr99mZHwucdruQSdqKhVDtM/vrowbSpDzuYz+sUTdFMA5mtvzCsXqVAbCfS5eNbmxUVioPlherIK52WPyZYazpCgrEMcasrmv2hRVKB176zZk468OXB5wstjJpSkWdWRJQK3poVtwgYApUW4X5ZKxbmNNOFWAxfQ38skj2wJjJzudK1r6wRDG3vAWiiOZs7XBgB0rlA7dUhty3dg5A/Yz5/gnQ3RmIHPnV+h9j411cVFIUeeodsninq/7tOGdLn9b02EInnOjPdN+F7FGX5RB0LylMDNE8x2z1vwGyxON7N33YSqj4ndu0a5A0rIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWMR3t4Mi1TPIvLvq7e9gjBlOUT+THkXovonMPIAqbY=;
 b=fuG0Be7pRHLedRVPW8w9DQXPiST0YQ9JNQ/PAZD4R/1ofdIzwOBkVaQ9sqZ+/iEgec6NDdIU30ceLcb2A4NZluTKMbNkNfOX9dIoefFGy2wOqpzyu7IRIUmU2FjpA6b9x/LMCOEjdgx245DCaINBMSVuyOjY3LtR5RQ6F0C2NEY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR10MB1802.namprd10.prod.outlook.com (2603:10b6:3:10d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 30 Mar
 2022 04:07:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 04:07:40 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2i: Fix spelling mistake "mis-match" ->
 "mismatch"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tubgrsl7.fsf@ca-mkp.ca.oracle.com>
References: <20220319231445.21696-1-colin.i.king@gmail.com>
Date:   Wed, 30 Mar 2022 00:07:38 -0400
In-Reply-To: <20220319231445.21696-1-colin.i.king@gmail.com> (Colin Ian King's
        message of "Sat, 19 Mar 2022 23:14:45 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0209.namprd04.prod.outlook.com
 (2603:10b6:806:126::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e660ca5-ae78-4552-2f41-08da1202d513
X-MS-TrafficTypeDiagnostic: DM5PR10MB1802:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1802BCEC6F28F8F56189B2558E1F9@DM5PR10MB1802.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnVyD4zEyhAdwcfePANEbC32rdIzobHvsE+yZN0HwepMc96AScp176LkTGOfc5rFmEsnR7TQRbTdhG8kZ9Um8ufYSfGBuJJ2DEy898ZKKWSLiZjXGEvSHnp97fOyfvntzI7akXGlnjLOmXkbX+V5mVbYtd3/z5V6/ERP4BNNewXf4+NvSqp2NfxwrsjDx1lLj+xV//IuOkx8hOekwDgABZeHeDV+ubYrsCaJB/v1DxYq5jxUjKj8X7AQZxKxWv3cBUFk7iaoiq85fHTRwfve3HgguU3f2Cb2OUvKu00QQ0lrSrjscG9WgkgJIznmfhrwputYxmb5TIGMkIRTUfmITzNTFMOUBOrgSpVKhtxowP5w342jS7UvYa5KQt2Zg10Y+T7LgeDHVbLjMAklgC2YIYkbIBSQiBYKes4YZkKWx8MdD9TUX9wf32GKC6/g37r1/ydUSN648OIdd3/yE48g93/mc8IpaJDlyDHAh/aUTPdFbLER3IWRqaOqxA7lJsCQz5E+tGvLJf40ZuaglggNekDN6dwIBRZ5JMHruB6lcEWcVXiPhu0hi7WTTCb6twiaLohjuVaTGEdX/jsh/hKfuDS/McSvYcPW1+3mK1jzL3/UI4nNrtoSLV4ocZ5nwVEBktmt7NuqFWLxS0SXLtOVd5demaWDjO1vy9X7j0eriyo5zF67iNJ/9G0Yr/rEiAJmvXjS3FALBn8DlGk2G88k5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(86362001)(38350700002)(66556008)(66476007)(36916002)(6506007)(316002)(6916009)(6512007)(66946007)(5660300002)(52116002)(558084003)(2906002)(8676002)(6486002)(26005)(508600001)(186003)(83380400001)(54906003)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oP/yWWFVzI+ep6ZSQny+BQqK5uwu+uQoNVi5Si8wzaGngeP3EjRU4XGf2ypc?=
 =?us-ascii?Q?QqJCPyGLLfrg4TI6N25ONa/0WJjuHjCdaoUBFebQUtQpTEuAmC7cBCrxx2fJ?=
 =?us-ascii?Q?vfH59wStFFtK/N6Tk+hD0TD55Tjhtt4Bt+vkEibOwKNXLbezDTAMVexSkQYi?=
 =?us-ascii?Q?fgZ5tZ9qC0B53MK2z0F/YhZ50G3Q4hxQXs2KLAoulsbFEo803nmibRiQC9tf?=
 =?us-ascii?Q?pz6R35NKCfEmqSr+wHzBG+DUsk+cRsJ9RT/afWEijPChtJLfvRWyLY16rVuI?=
 =?us-ascii?Q?fyU0GoUwLotTXOvpvBXygpKEUzsGU19b8AOz3gVf/0r0ICdWEQZLj1QQQabF?=
 =?us-ascii?Q?wJotZlCPOOcTqekBIjSTmNz9KiTfTtIUSUjy6Bdq12jCXg2Stn+E0jlKdX4y?=
 =?us-ascii?Q?G+UxJ/gqIJEDK0UadZoYdpcEbizRN1XeOpDXiAsDCwDZYvNnZ3aVxhcRqfNK?=
 =?us-ascii?Q?gVX0VO77QuKBqAd/JAofVDMthJ5tpF7HKyEVy8gun2gcklkywPAH4kncF4KA?=
 =?us-ascii?Q?VkT6CAD9M7pf/AbNC0SiduvflUX4taXCewLIHQE2f5b8uQirFYvfE/N1+eJq?=
 =?us-ascii?Q?GhsOR4Q4xjAeyyPAbLICct5+G2ew30pztqLgA5pJ29RSkCSqjXP+oMf1A/6a?=
 =?us-ascii?Q?Uzq/0vPnjMYKbUKt4bu73VMwuYQ7y+WZQ1d8Efl2tpixbpwQG6fXL8cCWQww?=
 =?us-ascii?Q?Kgkqx9Q7ZNsfXADJ2FX4HUUOO3zw/iMw0VMhC1GQ9lhrWY6F842/dLrloMEf?=
 =?us-ascii?Q?qurkGts1r8HiRR/nGLlbqVjQG3zEb7qAeREIzIyctKfZKkLkptumWRVrowZH?=
 =?us-ascii?Q?vACkOUaKgSry6+/7MTpm7IlaeAx5B3o00iXoZOwD+sQqsMhZKVxk2XOBPSZ+?=
 =?us-ascii?Q?EoIprDOHkFS6fHwD7S4zZtXIjkS2aCtcF4mLsouFd5rovnBHLC4ZgWMvBlZI?=
 =?us-ascii?Q?hKn+b4iqymtBzIynZPPkVAzT4LKEYQ5X2xA6JnXdGGQ2OpPe5wKSoTD9QRU6?=
 =?us-ascii?Q?5Euxl5U9n4KJHXJvpFZQenkN0M0WLIWumuqITDbAHANiYt6Ik/+bWFgNRbL2?=
 =?us-ascii?Q?5gKBxM7npZO1zLINrWgWnEvtmfpqA6iONlgm6N+zZnbPyQidEywsWRhxtwsT?=
 =?us-ascii?Q?LFA9s105bwotxby8UKevOxUd+UC+psW4rswjiQNQRjiJyElUJ4OePLCKn54g?=
 =?us-ascii?Q?vxyonhWiUcrFYxvBq62tNPsbi4zSzdi32qEX7nHKcUD46rpGyCqgUJJ1t46+?=
 =?us-ascii?Q?B1uHK1yZy4/px21yL5n8m8mf1LEcfhoMcIw9uUepXVGwXJck2XhNZEVTLDPR?=
 =?us-ascii?Q?yi873bUu6LQ2fXDjXNTwmOqVohZ6zh4hS2b9xVXwN0r7+eEc8OpmjSfXszk0?=
 =?us-ascii?Q?fAwqb0Utl/DvNOrnwFK0yaIlGs5iFWtbFFCeR/VrRTsGIUey3DV4D5vPSwxS?=
 =?us-ascii?Q?pPIkfdFd/g8ksx0tQk66NBjxURwLsLJ/oLsmtK2rRmauz2XrdAL2UTYC3Q1G?=
 =?us-ascii?Q?0x2m44ocwZmc1/emk2jrq6XRktFtXujsoxNEqWJL3Q6+v4yjhuf7fJFQmAwW?=
 =?us-ascii?Q?PKcNLgYWpRbm1LePKSrHGXDLDq5zaS2fxUC8ngAVEyEzGnoVJFDHWBn+oYb8?=
 =?us-ascii?Q?5LMys7YdIN+XVqff2kuKj6KzjWcRZStwXGx3LHMnXjFamAPi+Y1pSyD9cfbW?=
 =?us-ascii?Q?968BoSI/J1nTfkkIdFs5qHreh+h1kVIMQ3zkjou3V3pla+XOz3d6h/VsqJcI?=
 =?us-ascii?Q?aOO0uCWoSj81F1919CqOlYeLGDFGPG0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e660ca5-ae78-4552-2f41-08da1202d513
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 04:07:40.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKKAny0SORqoEKm+b7MGbV/JLobh1mHOLKlsMK9SpiBWvpDaU7Fk/TOvbd1S3Z8Uh0r8cSiA3jQPvAmvtN4A4WJ/3PJLUwevWxN/6jT2NhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1802
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=819 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300019
X-Proofpoint-ORIG-GUID: Q9cajmuULXdHHjrNCjd6Eum-egF1uhFb
X-Proofpoint-GUID: Q9cajmuULXdHHjrNCjd6Eum-egF1uhFb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are a few spelling mistakes in some error messages. Fix them.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
