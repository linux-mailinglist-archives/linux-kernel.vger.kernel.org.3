Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F89A4C07BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiBWCVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiBWCVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:21:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B083C3914D;
        Tue, 22 Feb 2022 18:21:20 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MMo6mO018680;
        Wed, 23 Feb 2022 02:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aTJkaJRi6CouSW7LHg5gtrKefG/896fm9A6MrICW7/o=;
 b=HeyEUIOVcW2QQQYjW5gKgOhgCyRmjlPsrMXsKOjqe4X+XI2UbOU8TC9H1dJTDDxXSNnp
 WoMN0Zw65ZbSlZZbNENIE3+lcX2jEkQE32HCyCvIhglfIcEy3Z4i/DbDBTpIAslU4ps+
 gBgbTI5OTPPuyZHTHI6hsQW72eLUNbNaI9fx80shBtr68eGBXaFGvEm9x6g0fns5gbGt
 6ABx6znGl2zUrKUTETN2PFkcRIDOass6GKaaHWGh9Oi2Jjm81st3H8pMqocD3LVQkHcV
 L6D+bPTk/PmmiPTj6tS198vt01vRLze31abNpWAHhnPelVEmhUkrPRSPFxLMlnxL+MRj Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx2uj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 02:20:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21N2GheK021622;
        Wed, 23 Feb 2022 02:20:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 3eat0ntg96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 02:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0ERuQ7DzoECOqlFlAL8AOtYmJy5EqPKd2/u8PJFwiCi3fpdGkFC0iCprKOaGQlNWXE2ApMzdDsZ/uw4I6UmSR+8cN1x7Cz4MzskJFgFSlNBA02DmzUq9HNCi1aA+ImuBcpMfiv1eycoZkJYYe6i0wqpR8NZIaRU1B+xhL8cdRz5gK2s4bTK5YpkXahR5n090MX12v1mzSsvzuUW9OBdKea+iihN1G6X81v2QoVODhwaRwySqQbWVJYPO+qnHIIjzu1bepYMxw/Yubydeqe85l47iCdc04gWg0/NcTKMfbYSzso0Fuk88ZBm7e4gXiX1/NURNd1dTjAgZ/ldrGWajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTJkaJRi6CouSW7LHg5gtrKefG/896fm9A6MrICW7/o=;
 b=gqQgdkE+nUL16XRj+QOPt1g4tjM7pqek9u0c8mZ+LJmecEdSxPPEALOR7vy9awRaNOTyj7QeiORUjhW0FKbYN1LGtdJo6glylDS0Pb+14Q1fn4wl9waHmlaWP2S9VV7xtHdTzORM6nz4Y9Vvfbdl/KOTep8oZVtBAvcycfFyJ7KJ5ijDRoRc6CLvgGlWOmfBzKTAat3iyqq7gqSNhVWRNU4Xjerl1dwHL0gFAZAIOkzSZ2KJg6TnZCkPIUU0BobL0vj3Be6dfKLl8nbILfwNZNUzgvFjCl4eqCjkEvnO3H+aiBxwionfGpOVsLT01j6Cie37d6cjEagYjlEcvcNn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTJkaJRi6CouSW7LHg5gtrKefG/896fm9A6MrICW7/o=;
 b=SMp68XABnaXoNtp0v9uFEL4klFoRS6Yug8NttAZ85csSjLGhmcWpRaCf9AabAnYm1t855UsLzEqmMr4UUbuqWJzEJey+0kvOxJ3FaM1XdjI9Mp03ynBU0BavqtBetmIY/+iI2JTs6z8ueEpyQY0pqK+8w31qwOBZ918xPBm5Ur4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 02:20:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 02:20:55 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <damien.lemoal@opensource.wdc.com>,
        <hch@lst.de>, <Ajish.Koshy@microchip.com>, <yanaijie@huawei.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <Viswas.G@microchip.com>
Subject: Re: [PATCH v3 00/18] scsi: libsas and users: Factor out LLDD TMF code
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ee3ucow8.fsf@ca-mkp.ca.oracle.com>
References: <1645534259-27068-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 22 Feb 2022 21:20:53 -0500
In-Reply-To: <1645534259-27068-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Tue, 22 Feb 2022 20:50:41 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7859c549-a9d0-4cab-fc6d-08d9f6731f15
X-MS-TrafficTypeDiagnostic: SN4PR10MB5573:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB55737395DFEE7D1FA87C14798E3C9@SN4PR10MB5573.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuTgOWUHKXeHwSzTqxcRbIAjU1xS9xz18siCNlTeftujyL2TgfjjguDawsgMKbYP0gXayInH0IhW+R8IxQxxxmcGaKbtIIucmO9yQgjzWB3eBKSyS9i2hXs20gTVpXu8uUXMzVbNMmZ4QyVSQza0RT4kstjhmv5h+EbFfYTjLmVUHBFWwQhR4ydRDzYX97qNCsNTl1+YY/6fjaokQTPq+kR4BbjzvHlaAqlJALTrO+jncUA4GyRd20lLJhDSUo9Q4n/C0KVXlCBPCfarRlkUnFW/JVwhEUM0rpVMjgKSEb6SohSTIoT5uwUP+dGLVV2LiWtj03A+CmtoX47RQ5O4JWhdCFYHOWnRIjwDIZ29bWya9i+Kk5M+yCS6CS8h/MGPu4KzyMmdrJZZ5MJCgCdB4g6mUjyOBB9csTJLmo3bbH6K0y45UHDToWXQ3fkmd5IhaSxBhP6h13UOPcwbv77kV+DfYFMQ9BnWs8n6Dcevc3Rb8lIEyqIwmBZepm4+ob/7Dwt09XR2OA4LHYMHVW+fWzkfmDcx2eJlGq7Jmr7hP0APjEYG5vhAs5SYOcfXKlnvBhZqL9tUFcduMbQrD+KrcrsBIPc/5Huv/KALX4Tp5iog+w//ngUSpEaU/hmUxbArVu9oh2x+NExBsJA86/uK929LZ4rtO8EMKsaJEKCdVj8mNt8dnAgOZnj5ShpTtCa7X7PlE5XCGZihSYDuucrIpyGtEdM0wuOVs9w6lDjarrlUIbn2BYFW5bpESZ+MnkGo+OC/CfNsiBdz0q7j2kgZIuKeJjH0SPkt9d4DAcTEL4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6916009)(4744005)(316002)(54906003)(83380400001)(8936002)(2906002)(26005)(186003)(38350700002)(6506007)(6512007)(6486002)(66556008)(38100700002)(66946007)(4326008)(5660300002)(7416002)(508600001)(8676002)(36916002)(66476007)(52116002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3yrvgN1RYIO9fh7fHCHBLQsRHmilnxabdT2g5PqpB4nKNnyQEEoDyE2Vmue?=
 =?us-ascii?Q?zpBtRS4y6wYT5ng0xINCbdbF0yoVlNX2D6IVrd1gpXoxXpI+wMqEtMqyQI1u?=
 =?us-ascii?Q?6C6pHUhcPzM+bljGRc4c5v8tdVTX8h1LsL/pPeOntZftgIDQE8mIvGI1zY4v?=
 =?us-ascii?Q?KRb1SK84cpglMDYVs2jMoCNTbstJqvkKivUyXSe03DjrXBK0YYuQfdBfkm40?=
 =?us-ascii?Q?4IkBQOmsENBAGgIbgytJpnaTVXQl7qy7XUXjkMxK3tzh8AWGrnPZC+MKqcBS?=
 =?us-ascii?Q?GQbtGqHZLfGZFiIFNdQ7dn0wrB/HEMkKTCeG4oS3b9PQgol3nLkIovufpbCi?=
 =?us-ascii?Q?Rzcnk7HXuttXSs4jfUWI6Wp8AcMVr1Cq0p0SS0PW6z7D0pWQPVMzlRYYIaHZ?=
 =?us-ascii?Q?d8wW8sw78GJ/egCdUrrmtqIF+VoPxAYNrmM26Enf1aRusHBwqxRtkHxY46Eo?=
 =?us-ascii?Q?G7e9OSDSGrtx+QXXtEC6My52tmlLAC03Hk7z21s4EaJKGU7Tn/pmvkFUeT8U?=
 =?us-ascii?Q?Ii/GZgQIas+Nuajn2OUQ7l1OF84pwri0ZTO7s/1UzCnjKaqA28BfmmRTEWTv?=
 =?us-ascii?Q?HDZfTvJEycyHLW70K7Ldd5SH/TgnVLvXK3jhr54qW9W0gpIvEFV0R09JaqCw?=
 =?us-ascii?Q?1vZC25cwC4C1pbKzY1YU+g64KabzwUQG3ZnbtW9Xa9gwszXEiqc2CrO+ieeG?=
 =?us-ascii?Q?6wN9EDf1A3g8T+aa77mDa55mrEahE/wMjQXOr+fXYoeWAWti7FCx90Xmyhg0?=
 =?us-ascii?Q?AJUVUPr4M/1I6pKf/Rt7gBI2Z4NKwOgy4SX1XQY2ojVeqcisAVXcx+6NPUzu?=
 =?us-ascii?Q?zYN0mU1voXWvd4Tpk235/bJdenLNpqk7fAjfiOKRPGtir+wQ/RHaizamlte1?=
 =?us-ascii?Q?p5kJ5OQA+tR3TdZXkJi15YsZoOCDK/Y09pIV6OmwzQC6gAafAshX6QS+60Qo?=
 =?us-ascii?Q?t37kUX18mmU6axOgAbdR6mhtUECDoDkwbfpbV79EFid4wH1KPbxJwi7rRK/P?=
 =?us-ascii?Q?Fo3STx9QGDHveHiLD8RWoRa1Xeso9ztTg/pdFg0jxZwYfl3rKFoJ/W08yzEH?=
 =?us-ascii?Q?M5dvyxiZMniewhEq5RW1dF0uDUcoqY6tCcclVJ+0KXk7UMjsEulSTF1TxAlm?=
 =?us-ascii?Q?waUdhefFIP69ydoYl5ji1q26NYcfN2qryOgeYU1D8musSpZxIP3Gp8S260CX?=
 =?us-ascii?Q?kCob2KfNNhRi4pz6heSHMnKJayGMEn7O6Ik+n9N5IrBHyv3ImejD50ho21KP?=
 =?us-ascii?Q?k+ZxmCI+DzBOnANr8h/53k5A4Awmo//x9gy9mmZwDrXPxxJXUNPykc16bqmU?=
 =?us-ascii?Q?omhhMeryAhKWg4jkwHL+zQvHJSsHzjXVTjH+n50ebeBpZLBuQvSJcIRU45kQ?=
 =?us-ascii?Q?2mn8Jwi/YOjdBeeN/3nodsOLKd7NZ2QbWvoVVrN9C6soQwn/jGCoDT+bS89f?=
 =?us-ascii?Q?eXo4stlAPHx7B0PnOboBCHxM7va0EcbKhORlYewLmTxcoXMsz7A5Lw+hlG6c?=
 =?us-ascii?Q?u1RWQ+VMaPhOrC9OnO6if7PCQKpUEL1DTElXOvCX4F9ujwIkHgcIcLubT+Iz?=
 =?us-ascii?Q?hopcSuJbnhUSjKvBudLpu3fRDpaKS5RwY2T9QedZnqPcmHwnXBtlR16ApB49?=
 =?us-ascii?Q?OwdaRRbUDnMUQxzGSFPmM8h148+PMmS+vrAn4yKDfGdHPzRnwyRHzxu5WOMs?=
 =?us-ascii?Q?2X7SpypEUSIJzR9a4NbL9/fsvvk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7859c549-a9d0-4cab-fc6d-08d9f6731f15
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 02:20:55.3935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRtVyjVD0hBam0jBiiruuQDRGYdoHL2XnvWAKn8MY4/7uFYRH3lOT8P4vPreDkNOsUOTzUYdiL1K6uRd7CkxkdqMabAX7y0evHTi7zgTJGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10266 signatures=677939
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202230010
X-Proofpoint-ORIG-GUID: KbW5uA8U-Ra5FMRZQw9cVT-0KLyZWBSX
X-Proofpoint-GUID: KbW5uA8U-Ra5FMRZQw9cVT-0KLyZWBSX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This is just an update of the series to fix a build error, as reported
> here:
> https://lore.kernel.org/lkml/59b538b7-b4c5-8111-d2bf-7fb353ecb19b@huawei.com/

Replaced patch 18, thanks!

Generally an incremental patch is preferred if I have already applied
something. Otherwise I have to redo any edits or tweaks I made to the
original series (if any, but I usually don't remember and therefore will
have to do it all over).

-- 
Martin K. Petersen	Oracle Linux Engineering
