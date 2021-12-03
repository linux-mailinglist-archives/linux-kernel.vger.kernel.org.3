Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C6E46705C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351653AbhLCDB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:01:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6056 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347836AbhLCDB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:01:56 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B31qJut031021;
        Fri, 3 Dec 2021 02:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=kQ5ZCZ3ExWyMOFlz9N3O7o7Fu6f2OLVyTuXjfQVeA0I=;
 b=FvfOs3BHIzw8ZQfMWoguWM4s6mC3+zKuLSt2Bc0A1fpdBOb7cx6fCB17Y1j/uxAJx0W8
 S/VlzexSseKLZa2TZFs/EBMPeKwhrLiOWOBgy6M36VwU0Mb4A0KGA3ST3dHv1O+s7ovL
 l4cYK+rYB2i71OpVPlA3xZxBvd7UUcQePy3vL++8jzZETik3aCC0viVgc7JFlxx7U6De
 DmgHjROyBGLdpYNWRld1ujRR19xQDU3gcfRDEi5fntmxffsT6ZHhGN32w8X96my3C3zj
 Nc7PKfNUn42xB0rph1zfWRBPSteJevum50lzmceM3dhixMTMg4jsJZ7tb/RBdWHguX4b Uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyumth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 02:58:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B32pkhK051900;
        Fri, 3 Dec 2021 02:58:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3030.oracle.com with ESMTP id 3ckaqkmyr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 02:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1ttHblsaGeJ3pDDqZW5kTTxEZGMn7gRWEyX/q94lMBkkVNtpQtuHx/DVArT8XrEA6cBISfJeIokgnSrWbNDWIClpF7E/prBui5VTLKnaf0aDXkHrHgywrM1lmT7TTczyVR+R+RH9zARhgohX/xG4hgtOylsAH4DRA+gvOA2N0MvAMb0q/hp8mcDsdRcDPU0FAFDk30jdNjbXLCPY05QJj1rukx7rc4eqoIZm//IAGVBiJ9s2GIjntH9gariDtcdeh8HN5Gs1+ebeHhaQM2dBSR1J5dzMl0B/kDpLnc1WS6VX5ym3wib6xD5oTQQAeazq00tVip2cyJlaQOHOW8dOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQ5ZCZ3ExWyMOFlz9N3O7o7Fu6f2OLVyTuXjfQVeA0I=;
 b=SlpjuO6fHtkqJbEyD3OWzmsGjTQdBgZ+fu23U04wbarZxKf0yDtaNdS2BH2O8bVkNJt8jhNed09u8hh8E3IJY1U5BK1wOVV5Zat/jEdQHeFfibGqi8nHsFkGtLjobevF9o15Q04aMFyhustCYI7KnnIC2mUeVrpVbW4wRwK/dXdCEPfHEM6jTFxliPhv6X3OnhP+FhluSlMsCiF/RMXQZ+eqZCQ6pAeUyx5Himd0Wfx4AZqocD5smtu69ZNsbRzWEiMK/wTvxNhBVCVeX3w6uGcUFNaOORL8PzHaecxFMxECHwx66ObQ3SvHxdl23CcTajCGwOEAxsaVCwZJswGNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ5ZCZ3ExWyMOFlz9N3O7o7Fu6f2OLVyTuXjfQVeA0I=;
 b=o3nScaIDwiYuc9J7jBz1Sgi2wm/dZuUjEzTdbZfaMIc/porXn2kPiI9YJyXUCLvCYJTXY14ROTySVcv9v8Pd+Ja+HCkCBYxYbvfYxKrzRvBMmb2ieuDR7Hq0joDt+QW3duF9Zh1S6lb/oGpM9sjZNL8w8jF2QfGfiBGrTkpjfXw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5564.namprd10.prod.outlook.com (2603:10b6:510:f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 02:58:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4734.024; Fri, 3 Dec 2021
 02:58:13 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] scsi|phy: Add SM8450 UFS & Phy support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135nawg3q.fsf@ca-mkp.ca.oracle.com>
References: <20211201074456.3969849-1-vkoul@kernel.org>
Date:   Thu, 02 Dec 2021 21:58:10 -0500
In-Reply-To: <20211201074456.3969849-1-vkoul@kernel.org> (Vinod Koul's message
        of "Wed, 1 Dec 2021 13:14:53 +0530")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:a03:80::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.5) by BYAPR11CA0057.namprd11.prod.outlook.com (2603:10b6:a03:80::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 02:58:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd67ac00-8d6f-4202-939c-08d9b608bf3b
X-MS-TrafficTypeDiagnostic: PH0PR10MB5564:
X-Microsoft-Antispam-PRVS: <PH0PR10MB5564887FA8A21C3FD198B68C8E6A9@PH0PR10MB5564.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2lTt98ObHXjd3mAVmmhVJc3ByKR/jTwkXiQEYSpO64T8dKY6/3Mfkqib7oC/QaIKnzQvIOSNHGSS3ZdT+8vDTLS+pnk5zeH5/ygLU9W+e7hjSF5igjVl02w5mkdFZGLTVNzHsnpfXTuGxDI+h4pZmr6jdMmNaETS39FsNQPqAxjKIulCnMVh2NsBjF2Q44aLyLWacq1rbbHD5TYEVi6RQY9+zYGeBHdB8qkKUBqeBWLSnBAKGrK7x/Q/RRKG/NVtHIP9E+fKGiYNj6ldAPkW108eCZQo+ziEoebJdCj97z++4la3pOG/F0Z5K17UAzhgB1avlvoKfNsZlGuE192jY/unbQd72/lBOokAU+PI11hIgJPS0dleR56VbCkABZXR/ZaOKQv+BuWelF+RRMwsse+b+tOAY0awasA7qAfKwQhdEnGfZ27VzdPfp8CuWmW4mENksQ1GcDLAs2zuSeNUSDhX0sivhCI6yzrOcVhEUPQREWpursFR1XAG4B6V4uBkmJbClMUApof07E/B5qh/k+Xa+G3QjozQxMUPfJw/EehS4Skun26DFE7h07AQquIoCBQCVMu9wznXkuME95n1GmxBYfSma15MQJCEqZbe1R0JLj0f0rqsTc9Ym25X8e2tsV+gGB5YYpM09VR1hquVL8LpGk2+fo5VVSwsexjrXnAL+3sBFI3THty9Ak5roTq/uxKcrnVzBzqBa3lvR6sJCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(186003)(26005)(6916009)(8676002)(36916002)(7696005)(508600001)(8936002)(52116002)(956004)(4326008)(86362001)(66556008)(55016003)(38350700002)(38100700002)(2906002)(54906003)(4744005)(316002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x10T8iKg0j3Ql82f4/XYVKZmcFBngIpYyit4g/SHd9pSgOfe8ReR52B+oDrj?=
 =?us-ascii?Q?JWnnoxHCZydXUli4VRRlsNqgxz6eFO5LvB2LvQM2xkwYJKqqAC3bGruegXfO?=
 =?us-ascii?Q?TDz7kggE7/ttf3h07BmCiTpmR/ExSAOoMs4RC94xcTVcw3E2WfQDzvr5835N?=
 =?us-ascii?Q?WUndFd/yjk8gZ5PA6bfgLTZZ/wD/brj6Hd7b053GLZMZAg/HjxCOlLY99Y/2?=
 =?us-ascii?Q?2Y10Y4OSDgj4jC4rJM7i7xddRssBTJiYuKyT83l2mS4HigQQFYD1mvKso1L8?=
 =?us-ascii?Q?nJqbQXJYVzSEXi5CWPjoL1Gj31NHmQSmtGI0YyGlDS8P5ahvk5jRavjUBbqS?=
 =?us-ascii?Q?ieSqFUnG7FIhD0cMzGTs5ezaSLj5nOn64mB0hUGcPxyansIFfHam1eESc8gW?=
 =?us-ascii?Q?Xa1RIaKLWp+teCMR91iI1vV4eyOYdeh90TTe9hdi/jUHPPjoPXeG4mkDqT9i?=
 =?us-ascii?Q?ZlGXKq8dXZkuIAxKCEXv8w6BToJna10JlX14sbiMUcW+1ilfjsQgrGcSbVWj?=
 =?us-ascii?Q?wwDZcogI8jYEgezunnaS+wb1zj5J6eIwQt4tF4TDpyRP7TIm+EDOWYJ8ufm4?=
 =?us-ascii?Q?tM1JOvOQF2gQM6xJIi6oSh3gG4vMxaKCAmVUEVHoV/Q9r5Q7R6PEih8cYNii?=
 =?us-ascii?Q?CqGheeqF5bu6QRtPvj5Bdoz9BMgkR5QLTLMA7yg1cW714luJuMZ3EQYS3Zpy?=
 =?us-ascii?Q?7r6oxisDIgip9STXI9df5CZXgwYPBRjECypjtkDvIApLhph87fLVPv/EPWlZ?=
 =?us-ascii?Q?32R9TFx+dlFWE9XHBFHtjgWnAW/PR9zvkQE4ITAlnxV7/+hWwmSh9lbbHsA0?=
 =?us-ascii?Q?CxdzC1NINHYuPChF3cCttaAJpAIjaHQ9XdevXOC62ptOQQh068eBCDALjFUW?=
 =?us-ascii?Q?agLdj7wWKhogmKSagB2dpDLRrim4URvBfzusNRUjHBGjPNvCOx6Y0v+H52s+?=
 =?us-ascii?Q?2B2lEBk18XQ2omQsmuJsY364EFeSYGKO235yOr4WALvcp56F/zHb74uVxjjR?=
 =?us-ascii?Q?i1RTWWLmoYyP1rv5zagBev0q+p87pC7XUKVLSjr8gT/9xgAK/ESnRrFFXa85?=
 =?us-ascii?Q?zWQpCbog3vOzpIDsbMnIMCOJxkprrYBm4Bo3jzLDb2OHq3GzE4FZRPwvcdZi?=
 =?us-ascii?Q?sGtmAQ/KL3BVkHwZLzF8FGvCY4rIfGvcMBWnjEWklNS4aeMc3X/md5chDJSk?=
 =?us-ascii?Q?cmwv4TNtaAXgfQ1keggCDNfW/tbo07bokDOOipFmi7+pBQaANRSOwiGUW/Aj?=
 =?us-ascii?Q?7vl6ZL71eNifKDmp5+6OrPMy5uUTT/NCOeT3oIlvnRqcvvs8w2Iptq90rnX+?=
 =?us-ascii?Q?7wCH6+s3klMn+0Bxum9z3n+wnas0lFN7Qdvt4ngjVzCvD5hN6zp6uK7w5Lae?=
 =?us-ascii?Q?VXExO7RGAfmjlzmKK/CwlphDZyXO9IPc9QXMRVvJ7Bx5LrEqje2rqkXOp7IC?=
 =?us-ascii?Q?1H/ccgKywRXhAFLztEQliNrVg2SKUgfr92tmcLCscH9ZxBwSzfoPBr0Ou1bV?=
 =?us-ascii?Q?0A9wmJwtSQZq0XIoPFIT6Kc9T93frOvwhGcdSfjfb7fYphRWFagffFFOrBHQ?=
 =?us-ascii?Q?m8Hu9+pI0bVGtVr8EiUlPhbhhcL6HA9KhSZpjJGoVw+RTKth6p1+LKXSDss1?=
 =?us-ascii?Q?ZYLiyWuE9b7n3Bq2z5ODGDV1bCn8b+sM7yfv0U3F2JhYWHeQFFxIr+hdM/aW?=
 =?us-ascii?Q?ObK1gA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd67ac00-8d6f-4202-939c-08d9b608bf3b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 02:58:13.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r55tYHJC/pvUA8Ezggkc2bEzhH95ClJ72JW2X3B6vu68ySOXS0e4U5nbDwVCYHtZQRePbh78rw8aSD0aYuoWia+G3JZy8mUvlRx7gCVoXro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5564
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030016
X-Proofpoint-GUID: Tes5hkMUtM-XcQ99BNK5NdBTUAZsEIP6
X-Proofpoint-ORIG-GUID: Tes5hkMUtM-XcQ99BNK5NdBTUAZsEIP6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Vinod,

> Add the binding documentation for ufs SM8450 compatible, phy
> compatible and SM8450 UFS QMP Phy support.

>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  1 +
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  1 +
>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 32 +++++++++++++++++++

No objections from me. However, these patches should go through the DT
and phy trees.

-- 
Martin K. Petersen	Oracle Linux Engineering
