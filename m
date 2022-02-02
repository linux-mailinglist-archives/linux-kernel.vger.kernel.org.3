Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318D24A6AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbiBBEmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:42:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3572 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232288AbiBBEmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:42:20 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120HC0L011409;
        Wed, 2 Feb 2022 04:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=VJm6a3exZ+wj2/Q03D+dT0cECBI7kzdN99ghBTcFCH4=;
 b=oAx/qhnCDO3x5nHRKX0HXuDogGiHffvwlbYbtM9ULZ/MxL0UNDumsQ1cLfzk5iY1foW+
 meGuhYZ8tIXsqyjXjryyKGGLW5C19kI5/1r+BgWrU+88E0iJubmNJD1sakQMB2vBu0UQ
 geOln5WxTsA2DnuM4q9kmR43fX7lfXAxkZBYVxX8Iy0sdbVap2JaUZgbwJKv72TXuK7G
 n7PY6Zv83QHJ1JY/gLyRZCT1Q6N5z/cLlhgTV7lANbsZ7M3+ARWzTvHxqLMybn2iBI+J
 jdFEEE1mIEukHagAKGJ3lJpEc8KhJN68mnVGYQy68cNK1D/OcNQwfnNRMEnJmL7S8rp8 ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvwc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:42:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2124fhaq137074;
        Wed, 2 Feb 2022 04:42:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by aserp3030.oracle.com with ESMTP id 3dvumgm5w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:42:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwZDaApKgXazFLDuCf5TFO9MabSt/grdYveyoYBuwXxBNexi7mZzsgixKJcrKXc6AaeBbMRMprtanyP2BZZu0WuWSnP5tikMy6cs8tHKbNtc0d9bXZLJpQsDlfjIAst2xMjkg6G9Ch8lDwwT9/VWb66iBtjgP0a/WADd9/JoOxZbX/5rs3b5hh1ITM9PqCKPuO27iAZ8aebVkHru2E+d2Bb4fAmlSFaCEOKbjrT0psKzA1VH5skzZYDA1Z4aHU6A9eLcwHtvUnO1dz7J2tdPRI617CCeUhmyjzhMxOjBNJF+UdxLWmXSIXHVp5d/+hySldur34dycNkd6TdXD0KhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJm6a3exZ+wj2/Q03D+dT0cECBI7kzdN99ghBTcFCH4=;
 b=KfRnoKaP1rQ07rRW2GdQdDe3ecDOWSj4wsC3gnLBwFScMDdlG1LFN8+KIzLaqc7YzHBqNhyW61V7C5CCwjbWwFDnl4QZGoo0fhFMaYX7IQQPLfTk2WQ8EqDsPZIPpsKfMttvjptX/9I4dC6zsBMxdtHnIfaE7/wromuPkhRT+YNDQTlBHAPi9RRBP8SG1k+wxbkWBqGKsiSt++jVP1Sz6oudU46afc6WfFxMJwUp+wj4aJyelYxXXT9T2EVs/Xk/qV3XLA2+zfWIegTICOhttm1JnnYohdn0IsFd/QIsG4OETzMVWEst8ehgryyIPIwGatq5Y0iMMr7xXfDtXqdQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJm6a3exZ+wj2/Q03D+dT0cECBI7kzdN99ghBTcFCH4=;
 b=mtvDic7iplDrOyWxPn5vFmOKb/NUR1n0QVJt13AtgxuppR9HAjyJJEs750L1TVMle0H/ylSvcAb5XvYddgLQZp1fTvccNDsTfseVpiDvBaA4jdZtV7+czYqekeg2GayzPk8ucrxQT2pkUDQbD397YoerEik0c33ngag0nTQdGyM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO6PR10MB5651.namprd10.prod.outlook.com (2603:10b6:303:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 04:42:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%9]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 04:42:04 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv2 4/7] lib: add crc64 tests
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17dad5180.fsf@ca-mkp.ca.oracle.com>
References: <20220201190128.3075065-1-kbusch@kernel.org>
        <20220201190128.3075065-5-kbusch@kernel.org>
Date:   Tue, 01 Feb 2022 23:42:02 -0500
In-Reply-To: <20220201190128.3075065-5-kbusch@kernel.org> (Keith Busch's
        message of "Tue, 1 Feb 2022 11:01:25 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:806:125::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b4734b9-c6c2-4de5-d7a1-08d9e6065c53
X-MS-TrafficTypeDiagnostic: CO6PR10MB5651:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB56519BE090D695831D349BCC8E279@CO6PR10MB5651.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SHrNjmCGYc7fUqgrAHArGXl8Hd/PquhaMpPjf/dPr8kCYnhEFbBuutXwRn8yBZUX2U0w+HSWRthcS0CF5xmGGJXitp5Uq6EPoMHncGNihFHIgKvEjeRoq8sDct7JMKY1+VABmHH6lg+cMxVhvc/Lw/kPVwWATJ0rYKfMcwzhbrm1lGsP2P8w5M1/wHeKNosjvVmeVfDijojV68BRRe8sD5lx+63xN+p8MPx+K/L1jsmgUiHv+VA9+u0r2zuZt/Vuu4vr/Eg1j9gFflp14ubv75fiVYygjWH/uNRcnnaaESx5G+gsQvWIAsputZgqwgE+nJLw6mJEvUiaofKrs9L0EFYPRNRkppBFcJov3UISUpNnAGPf7zu7uBzh8OwORj48py9Jx8g2/kWbteASkOUOQTCVDAAd8000kH6uFMpS5zI2LPorpj4WdYhZQYNr9fogY0Pl9qkskElspWwLOHQoj3ZCkBxXqSyo3kQfZ3wKOgSeAMEHMIDAcFwZuz19ef/Z+TUPmuRY9heYrGaqBPt5YyS6Tze7OixJW/QGKkYsBAm8ZJvtZ1HvRLau3QoFZCXocZRHYXRpD4rnzH0OmWPMLf0Enw4lhnR32vloQgxsTeRKtj4fv2N9PTtR/kC3PGuvbXa5QeE0fnQaqZdXhu1z62CXFzIIUZG1NcCDtDOJS3NT7rQrTMUf+LpUvHDZROb6TSBoluMCNfV6rgCYIFdMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(6916009)(6506007)(38100700002)(316002)(558084003)(36916002)(6512007)(6486002)(52116002)(508600001)(26005)(86362001)(8676002)(4326008)(5660300002)(8936002)(66556008)(66946007)(66476007)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4297aDN6LtaSyG5u+FMBPpwUbm1ETXR2YIubW2HP/mBpM8XioU/JWVL0ZGz8?=
 =?us-ascii?Q?8D7KddC61pHFSboUTegRMW2EcLykisWTc1y6TNL6yiPM6EaGHjAJ/9AnZBEH?=
 =?us-ascii?Q?Xm5sXKFkzHoUFu/XG76fCYlG+3jK61/fLiUvv+EXJDBidg+EBfP2TM5F7Qw8?=
 =?us-ascii?Q?QiTdL5ItHwmTajPSvekDINtk60scBYMuATCKgxhi9BkM+JHZFxL9ocHYo9NE?=
 =?us-ascii?Q?5gTRzC/YSZ24ceCGKfdSwqGTbz3eNBtQV32n+vmUw59aNb6uqWVdtOfjHL+g?=
 =?us-ascii?Q?+lkJhNry6MqVguY0sru0qI6xVIkzFuXU+RwMmsxnr5GjhHSGlAo0jQV64oX1?=
 =?us-ascii?Q?uCnk3eKCZVHjct206t+4erwTzeaXz4v+/MkkeicHxHQG44iQIHcB6+UOshex?=
 =?us-ascii?Q?M1+f89H8FaYK4lNS4+ZMrq2AVNevsGC7QiW+qTyddgUFjTtSTQQnKpoXB1eK?=
 =?us-ascii?Q?sujyLi9RGIe6JLTxgUjz0FyxWzsRqOIizUiU7LW+lv+sygBZFykuzYgo52wF?=
 =?us-ascii?Q?qI04e3FqZzxQ+EYjQXj+iEtZXX2ilTw/O4NTWEy4MtTk48UUIfDMIP9OibwT?=
 =?us-ascii?Q?wCXlW12wYZQCms1inE+0eok7mNUCtKBPjMd4lpmzDsIL+VEl2GyjQ7yTtxWm?=
 =?us-ascii?Q?ZcojA+C86kKlzVMYefTIteqrh6aSacsGRalGi0LHw5X8Uzjpb0u67IPsPpaA?=
 =?us-ascii?Q?BMl8K7Fvc+UQjVmQmChd7CRyl4298DIXmSJ7ov07GksO/76HlYKRXyNk868E?=
 =?us-ascii?Q?zJE12wP1vBteZnX4rhM0AsHu11izF2McFKLrSkj/Nn+Psvf4+3HCRBmKnZd1?=
 =?us-ascii?Q?2BF/1dAYRBs/R/g7T6vULqL9/XCUYDK3xi0cmfrV8z2l/662f+2BoeNsxewp?=
 =?us-ascii?Q?NOfC1RlLjNdxHOtqiB7WoAHFZBgg3bxr4gRMFRtuDQQt6WEUdYlrIs6tHfG7?=
 =?us-ascii?Q?G3TDw4JCE038rjsZyf2xDLJ7MO0lVJJLvE50nY6Z0KHCQNjjXyeHZC5oZ/Mv?=
 =?us-ascii?Q?x/Sb4r/sNj7yQ3TTFdcYg1uguLnWEBZTtLab969Ze1necRGXfeV3stmYpHwE?=
 =?us-ascii?Q?XcJRQFpbXtvMAWoS0JkufIXKybvXzRg+3hwTuQSTIFHm0qSbxGLuZ1LpN31y?=
 =?us-ascii?Q?OovVLb2Fbreq8Kec8JoBwMgw/sHCCy0xueu/hYiB3nfxu5/5SIa1viEqXqEs?=
 =?us-ascii?Q?CvmI4ZrjmaZKoc8xBBSU0gNtnb57mNa6nAG+kyNlxTNCfA9HZ8+nrEKCUE8Z?=
 =?us-ascii?Q?Ip/NwYwaJP3/j+ZQe6JIPxeGQ4k4Ar52pa613FfH/cbkVi1Tag799vpxd6AA?=
 =?us-ascii?Q?BfgeVoZslhUt+V639/xiT8amq6Ssav8W5vDlAEu5V241XWejP7JKLBVWr8bg?=
 =?us-ascii?Q?dKesj9I5Ttl4rErWuq2TEtai0GBHgHHCLrk/cpyoE2ZRzAsnW5H9HKYtUrKW?=
 =?us-ascii?Q?wmsctta3iUFESY0MTUsiQAxLCLgYSvoR2Puaub0t+2hEV279h+v6f+cFTukw?=
 =?us-ascii?Q?Thx2oaJ4+aXVCl5zY17iUPgrMj+uAamhBnUNPXjA/fUwQ9PCGZuFSS1x26Tp?=
 =?us-ascii?Q?x4YLb/2nI6mjPWdcT27IjUmNvMlEHEXNhpjXZSqQdHjUPfsDsIkPEO1BkqgE?=
 =?us-ascii?Q?wpQieMveTixz9pnr77sKLreYs00wYmMj6Cd+VHAb/J7qjYk6CTiJDMooNK35?=
 =?us-ascii?Q?bCg1EWROKb3DM+tMJ33qBQAesYo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4734b9-c6c2-4de5-d7a1-08d9e6065c53
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 04:42:04.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkEFFMNq9LaDe9SqbC5NbPXfpxRhE0ONcIyzOpaOD2zPO4wiazKaPGhSEDOU64FHbqZSY36vpjgS6ZHgNaJMDN1nL6uKoRkpfIYGF3OPu1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5651
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020021
X-Proofpoint-GUID: XauJLsLmc_ETL6b9dAQhirn1e5N2OMt0
X-Proofpoint-ORIG-GUID: XauJLsLmc_ETL6b9dAQhirn1e5N2OMt0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

> Provide a module to test the rocksoft crc64 calculations with well
> known inputs and exepected values.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
