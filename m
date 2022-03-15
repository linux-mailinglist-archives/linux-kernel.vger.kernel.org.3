Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52794D9375
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 05:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344824AbiCOE4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 00:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbiCOE4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 00:56:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6945419A4;
        Mon, 14 Mar 2022 21:54:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F38NwU019883;
        Tue, 15 Mar 2022 04:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rukfrvnxupp9XWv6ytTbusEF1nAghaOq5zWUP4KHDaw=;
 b=AR81XoU3jGJM+cV9b05kyLWYdHjkDZNAvY+oUepPSWwYCQeL9iyP0/uGvSq7ZDCm3zOT
 7vK5FhNnk1q+x/GSmF97Nbtq9Epsg95nC1Sc2nEM+KsIr6XKLrsQ+40x9Z6X8UbbmPNI
 VUSRtpKIoNWS/LZvpma33ZrxiF+clVFP6Pidkxa7ShCg0TbKXteJkXEmywZt6SMV6/fW
 PhMgzhSnrwcgrR2gb4YLaJ1vDXI078+LrCoAgoylBECp9vQR6vrEoz8bRTuctA7gIwfa
 T54sUMz18OP/qgSqfz5+OYQo+JMxi1xVpn+fHKZcdnU4xbO5Qn+Xpb678qedhCPJFHIi 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwhy7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 04:54:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F4q4Yc100049;
        Tue, 15 Mar 2022 04:54:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3et64tcqv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 04:54:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIaCVdZd5FOZo/P1YXRpghbLKGxA5jQvet++grmrRsY2EOkXlyLYE5gzZrA2d0tv5FBjaKFVx0VppOkhLSvmMpxOXDbGwCEGNY6y2akhQQTj9Qz3EzlALne0gcCaaVWE33VkX2pjrnHRRQ8G9g33aAeVZ9koV+I4BPF+HOMzPVIf7GGjGpzEDNNSJUr74IkNxI3LDNAsJwzYprIQJsspFgNsQafDZF4YYIg36qS0gJQClTvsNGvfn10j/ZpwzeUBEtwJVBqqgz+jONPwKxmll9jauFW+rkdotdtHcrgPbuw+9ulKqVgNJUj7UUkWpc5R4ht9w3HM137toaxUCH9shA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rukfrvnxupp9XWv6ytTbusEF1nAghaOq5zWUP4KHDaw=;
 b=JMXKtLwohW1dndlT5XWE7b+Q2zUvnevsKJwzd/IgwZ0UfZvdkwNcat8g3yGpFB+abN4YRwAnotcNio6q3IeR1KSaZgRoEjLPGfNRGYPCj6NYzaovWGYh+t0PU1QmqsGM7OKeVKO/O6PDHwFuRQYB6h2uWSp1uEqjCPcfPgdPnQQ4WKZbD2chKmBvNMkAntKWTwVI0Q5Kos+rz6uwz0Sd4buIMq7avdGUISRCXm4+4Yujkd7rRCU6kEpefClvKCkiMvdJO0j+QfqFGduMuRcOxg+oKjxjhxbgFHQ5c0YzUGty8ITmCMg6p1fGEaoaj+FSt5uOE7j9zvkZxE/27MzCfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rukfrvnxupp9XWv6ytTbusEF1nAghaOq5zWUP4KHDaw=;
 b=xLAM9Q8n4BpgK3DcX/03DLFL4jg1J6naJOhWuti8Jf/V1YgLlZrqEAibHQ6Qt0NmkYLxQ9UJkpa9PETJHN+xyxpxS2/5DUn6RDxcW9PYDCj3/u+6Vbv238icUfkpuybP12plidgWHHQ/aiCarHZA8FASa/5Sde+cNlcrtWDjSrc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5676.namprd10.prod.outlook.com (2603:10b6:510:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 04:54:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 04:54:44 +0000
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     James Smart <james.smart@broadcom.com>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6 v2] scsi: lpfc: use kcalloc
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tubzbyt1.fsf@ca-mkp.ca.oracle.com>
References: <20220313141847.109804-1-Julia.Lawall@inria.fr>
Date:   Tue, 15 Mar 2022 00:54:42 -0400
In-Reply-To: <20220313141847.109804-1-Julia.Lawall@inria.fr> (Julia Lawall's
        message of "Sun, 13 Mar 2022 15:18:47 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b9ff713-d219-42c0-c5f5-08da063fec90
X-MS-TrafficTypeDiagnostic: PH7PR10MB5676:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB56762E511B07578A6CCD50408E109@PH7PR10MB5676.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziDjYeD2mAzvm/sthDiBQOp/d6Ippy3qH9NlSaVz6T0Jmk6hAeklEnEE3YALZ92qVSG1ZQQCrUG/LgBHS9daYFMEn5Hq07snpkSwQT8K7+4b1kHBB+Xs+kS9hgcOQD5Vndozhme9pQ1n/SiWjtuDH/XiqaNTjlZaH0EsXIQ7Ebbd8JzllJ6u1l11ymX15/wlT7AxWgA7WnPaAq3ouH0K6D9zSjCZc6Yp1MTRvsFuB6mAQVUNXghbw93+jzk8qm/awy7NewzOwmIGZKQZut0gHXJ6u7rw+MkGhBHlLz8+wvp7fjzugghTifJvY40OkA/2qzpXcE2x37Ytx8AE6f6JOOyUFKZxYdFkTC7JIoKeDLYx0vNKYdpVeQ97kgxxX2LJukVLtQT9IZQsLcgndWawdLNOKPl/qQnq/a0f+7b994DV/ZRJosjUaDxogqhzjHqRrGRd1y7NIk7/WAYIeHlLUyLYsS/UE/iTJxhK7cidjJ1IAx1YO02Fll9wqaZWVC67Fq7GAjy1CN0aTGl2p5o40m1VKwEQjsRc255DQufumGK5PJUsNdhqnHPvJUjxHFf8bWvRlaoDV7CVOVgom1ytXY6W13uxeBM44JBP1ea2N4w8getq9i6U2ZLJCSz1nKZCoqBMxoVwxFaRext0N6xt+Joz03ZVz4iK7NSkU4Nd4C/4osgy+uxGFJM52pBXmTBRBL/lUAXPCMHQTx+VbFQktg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(186003)(26005)(558084003)(508600001)(6486002)(5660300002)(8936002)(4326008)(66476007)(8676002)(66946007)(316002)(6916009)(66556008)(6506007)(2906002)(52116002)(6512007)(36916002)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MrD7sNwUwzlyl13THCw1x6uiME5t4g/Gx9DwFsmupZFzTkudsIZBnADJl1vO?=
 =?us-ascii?Q?+2x1L52eENAVsVIQke65w87ERo2tUc6sl/HeDFeEMygHdY+2/0qNe94YZgBv?=
 =?us-ascii?Q?0hb9tW2MN4c10i+9L1z6cmiW4sh9haV74EBUV6x40eOLnLz0aIfimd+Hircm?=
 =?us-ascii?Q?Jsnj9uGSNCeHsvyzlfmwtSHoPax4oWcJXd1hhBTb83GX0VZ/pPMxDguWiSRz?=
 =?us-ascii?Q?jYRHtHijE0bnHHegEbxmbWcBDPm/bqggJ9gdqFOGZOGUJA5f4ZVWoPdhRUG2?=
 =?us-ascii?Q?IqAUTe0FsV9yXDA194D42+O4HDVhh1KwEkhXEkaDBws4cdplBrvgAb5YrUJf?=
 =?us-ascii?Q?ga6H54rBX9G3KbiMhha/D18ByUUr7VKvlNdf3vK1X6ZESALiLYBmY94xG6q6?=
 =?us-ascii?Q?AqrYuZcCGy4Ezftu7HBfCTfqSLSCpRMv888YAAvZv2yC8pSt/eRtSpJ/mBxE?=
 =?us-ascii?Q?EOwO2d58K2U3PaxUF6ssbVJAoqipFnkpJ4xv281RZ5nFcvhrQJ7408Hhgfym?=
 =?us-ascii?Q?knv/5daGalGfNsfckP2e0QyNUMViJtyQkw632sBGNWdcWO0bZtT4Fik2uQFV?=
 =?us-ascii?Q?FAaLDo98dMtpEoTsMfJfmhajw8b04p9N3dG5DVrISVkrO5+OYyu3e/8OU7qm?=
 =?us-ascii?Q?sfGKujknXqcLRgohAd+JUvGZxHnEawCC2ChMCkL+tnYD5WwsCiatIrxlyzgC?=
 =?us-ascii?Q?BAX5kmphUqCz8NNJgLQTaUJzBfDC4ALUUIr1rdf55MY8aYxNeMYNNclJLKTZ?=
 =?us-ascii?Q?RMgau1kxKLc6DiyDUSTqD/mDcmpetdjBFFHjPi+wrIef8NOx+sAEYZpUbieC?=
 =?us-ascii?Q?hVcXbn3waFfVauRYFTS3joCKbRqd9JixgZ0tffSABf8fPodi3zgYdYjg8zDl?=
 =?us-ascii?Q?w4WulHIEvClua6bdmw+LdrIRqB5s4pVIdJ8aOtDPuMVbZtdR/VtBQdbnj43j?=
 =?us-ascii?Q?J4YgCIs0EKDS9HFl+Vy3gzSto7CMIQViAR5bfpL/0BDU9/jxyN+hLVyOyFnW?=
 =?us-ascii?Q?bFobkljPXJTu/X80Se6PLpiahSDa6o1+QkT5JJHc/Tu+vq1zHHKvPoL76/jV?=
 =?us-ascii?Q?tvAYZl4yRuH6EyWGr2N19jJo8jCPIh5tNtR1l5NVgMji5iflIIkMEG9K2tdQ?=
 =?us-ascii?Q?Ke23QR60f5bB8NdMNdN728yM134rQpQfF6GM61i4O0b+XXYAFZg956eZyyHx?=
 =?us-ascii?Q?zE8fnHZ0uRLkaL/6Gb910R/COgBzufvTtb4vyw2VOEzmo6arDhnGFDbdoYsj?=
 =?us-ascii?Q?oaW49C8qHvClr//yPmEC8pp1l2Kx+EAuC+NapyaQtSKPV2e7hpuRbO9W+x5p?=
 =?us-ascii?Q?6aeatBJPiZ9LLmlF9phgS5qSIuUThcKMl7M9oNzLi1omgNj/Lo9UcEzzGPEP?=
 =?us-ascii?Q?0QFNT9i4ViV/udm5IRl9O5nrvZ8PQ01YHTZf81aw67HHDd4vGMr7uYeSeEvW?=
 =?us-ascii?Q?X5/IX6jlJVkwZFazY1m4619EkaOVEcJlSZflfkBCeZ/gfbPrt0d/AA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9ff713-d219-42c0-c5f5-08da063fec90
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 04:54:44.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ki0CJzj6tkMvL/rMHQ6Z8qpb3Ax84UgX+Bzlqy3J+o5nGKj+P8xgqtIR0bk30C4zPC9vOj+epYUQDCeAhlYZdyNIG4a540Sb4lMugl2YHQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=629
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203150029
X-Proofpoint-GUID: uaRx0rH_USOxzxe4HmmQyHSklJQd1sud
X-Proofpoint-ORIG-GUID: uaRx0rH_USOxzxe4HmmQyHSklJQd1sud
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Julia,

> Use kcalloc instead of kmalloc + memset.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
