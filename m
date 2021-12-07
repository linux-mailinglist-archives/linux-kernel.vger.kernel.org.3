Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD71946B172
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhLGD0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:26:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19744 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233757AbhLGD0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:26:04 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5MYt016268;
        Tue, 7 Dec 2021 03:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ObMZ1l6HgCoPrFY21YQLx7v1UTdXciT+15+fwee2W0w=;
 b=F6tHSv/Y9JG/+zUz4T6ACQZYASiaATmZtqqkgpBwaqn5dhZyXcpkJJEV9bONFAahX0Iq
 kTIYo0cTUccmu46ZO5Cl8/LJ0eIHDsqTBdOEDDwhvUmv0OeriXHDVbf0LusrKqTy7G31
 hOA4qRzZz4inANBDMPNWI792th2GFrCLK0SOEAiQHEWZw/HCqOsZT70Ep0kuu98m2iKb
 4gpRufnEoPGYEWDy64RlxyLA7BB1XJvqEFQxMcpGoqYH8G6dng3Xf/AhncfFMNvl5VFT
 0pxpx6da1WTunkE6g/2wmwRo5lAxVRLUdEN2FHHDeucFqe/OigHUt+8d3P/8aiaRjvzj IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csctwm4rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:22:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B73BARW096313;
        Tue, 7 Dec 2021 03:22:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3cqwewyy8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:22:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVslNWjfQf8bfZ2+CackzSBWOjb0vzG40duuHC2T2D8LV1+x9Q9JklXNKfR35UqvvGhYDIkRppn/yRAhrSYD5zQ/T6Rcm6jTHS4I0dNNPTsRNG1C84wT7h7zDenMIUW8uW25q3rtTOWsPGrk3IT+5RBkS40b7rXqW/HsKsWyD32ehAV4BSdiilYpiEu7NcVt/Gj4ojlVA0cnwcdNbKqYNpLjdojvrjVtCSwpAifei441jFt5B7q7Ja+pptV/bmtL2TD4KnlxuxbT43mzwA/CEi7pcnaVyxW+PconoO2mEpQtwuFua+lT1zPs40CDGtKkX483GKotShou1FaKPC9i6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObMZ1l6HgCoPrFY21YQLx7v1UTdXciT+15+fwee2W0w=;
 b=jB3QxzsPc4bTWJkVQxuHF9qal/okYpM97eTZJjQBdU7v+lLBKfQv+y6r+htdhLa0CMOQdi8/hrMEMmFYQDUt76NGEiYVOX2LFW08ecD7oCtJG3XNiedJhvggkdU9tM3krZuhCsjhlWjl6TSotTULGLi5gaaOE+gdLYqbJFnB20hhtnKZbY92vCpukKturlJLBegbG6daJKor2RISbfDI8YbAA6ZLY/+agl9oeBHcQO++OGJqFUqzZPLwObhPlWQI5S/TOQ2HCIgiQKW99bTaFmORYHi2UO5IPhAN82voLFIVnMXK7SS4wGfbSeA6Hjqx7seC+5AW2rvz7k7KBsFplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObMZ1l6HgCoPrFY21YQLx7v1UTdXciT+15+fwee2W0w=;
 b=Ijmz/rKgjb2/yvFx3sArclOB0b3+mmVGuw3UrcRJpQOJm7PJVAhQXNw36MzkmQC0ufini9v3PnfDwMZcUEgU3KAFdiJH7iZUVzWPj38pkE50OvMc2ZQkUcctgNI+cS6Uqvm+wuxACGZVJ7rmu5ljOHY6WWONDe7u6l+1GwYsm5c=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4501.namprd10.prod.outlook.com (2603:10b6:510:43::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 03:22:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 03:22:29 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mptfusion: remove redundant variable r
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v901t7yq.fsf@ca-mkp.ca.oracle.com>
References: <20211205225901.54362-1-colin.i.king@gmail.com>
Date:   Mon, 06 Dec 2021 22:22:27 -0500
In-Reply-To: <20211205225901.54362-1-colin.i.king@gmail.com> (Colin Ian King's
        message of "Sun, 5 Dec 2021 22:59:01 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:806:6f::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.2) by SA0PR12CA0023.namprd12.prod.outlook.com (2603:10b6:806:6f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Tue, 7 Dec 2021 03:22:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 370b2b4f-3d96-49c4-80ef-08d9b930ccdc
X-MS-TrafficTypeDiagnostic: PH0PR10MB4501:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4501E4AF3CCC9D6DCA4A23108E6E9@PH0PR10MB4501.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWriwnBFNxrVs95ZweRw0OiwNC7ftWD47Evain1o5fNyf4gK8f6esM94oK8H0X2jZGEcDy0VaXQqv3pIuUn5gmrp5pae6G/MQHteqO90Mb2jzK4h3OvEcQ3b27G4qRwbdE9Zo8XrRSpMh6bgewuv7QXFl6Id/RVUte3Z809hR2DyMQz+COpNOjZlnlkGWU27oNEfT1uGVMTF02dM7eY3MbWjV3kJ60nuw014RqrRavXxCeNf1JnAdZpSU/MKD8PbOR32PzuL0ZSC7sQiGiKk1k/ZmHWdCrlSDzaP7ap+8YGXJa+KOoX3VxE846gDGoOK67nE18xAg4aJdyFBv455VAnVSqLxV09jEVfuuXexzpMBfbz+XZd5259VrLV1nAO7OzMyM614WF36byzk4Z3UuzAQZOaF65Qbv5qghlIW49c3wedpsmdGF5xeLfYcD4ruX39/vsy5BKQuy3SwLE+yzxWccqgLUhef/g6BohbCsDLOswK9Pt91Fl0AFLyLbaEDuC0FVNyPHUgdNb1YRNmdroI7sP3EMlH77nCMocXK/BEQr21S2T09fRpVB8wWhdyCQyfJM38MTQVjuLweyZbmAZByCxJGqqTtOGkYdo1exeol0q+Uf7fhAYXmcxUrHBtwjY1vGxITEUbBjEj8PaUxTffY4Tnmri3txr8XPI0t2cclFy0ycOwYs28LJzxtuDc6LWeudWcWljipa84XXlICGpncERDp1A9oc9TJkKPQwow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36916002)(38350700002)(52116002)(4326008)(7696005)(558084003)(66476007)(8676002)(38100700002)(66556008)(66946007)(54906003)(2906002)(316002)(55016003)(5660300002)(6916009)(186003)(956004)(508600001)(26005)(86362001)(8936002)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8tnaly+SlMA4RY9NbyGik6bOm9DymTkGHY5DSlTOYHduE9YKPzGFEd7HSHtV?=
 =?us-ascii?Q?x79VL63HJ3w861Ccn0bQrAN9hPknpwsGX4kITjrpKuIk7h/UXFB2YqCTFrqA?=
 =?us-ascii?Q?XZyxLRm+O1LfuOma0zctPSvhYzt4goa7jwLc3y1nZkUHhJQxlyb7EWM2rJt/?=
 =?us-ascii?Q?YLxSlXPY4xM8opv4h+xYEk0yEcwVZvLDIRTg5gRWNUCGuEayksE9i39dIKVB?=
 =?us-ascii?Q?5owNdJvHeps9bpZ2IyLi7h6b6/Eqjzz3Gb7jQom8LxeS11+ZKk2Gr68M0G3O?=
 =?us-ascii?Q?TULniXLbGxHNgWoPwOLhPkyGzpojYhsm9Kqbe2yuFEaCpE6ih4plqphMyjS0?=
 =?us-ascii?Q?F2Sb/24X6REpzzWHou/Rtpcp9IWS+tIrKE+U2sUT1IYZIQCQKIGaq4bbo/9W?=
 =?us-ascii?Q?YayVJhSbxDvcnCCabb/EoftGaCPE2z7S+IBHWnDgeHlfjZkkZXolCKEp2r4P?=
 =?us-ascii?Q?WW3+0IupXC90kO3mKroIvKq3Gb3NhuC6bGU4TrcSeVn0UNpKxubUM8cq6E5h?=
 =?us-ascii?Q?Yu/+wFla6G6iC+MEXKaSuGndaqJ9URKstA03PvErraoGBVQwNJuyDNkMT2cq?=
 =?us-ascii?Q?fhmTvMEV0eJI8gZmzunSeg0LMi3mPaWRC6XOMv8HU4qaEfeSa6xJckIyo+zN?=
 =?us-ascii?Q?rhJaKosXtLn+hrSl1rtn+PPSPAvyhaQYtIaT+aUmKJWhhVc99is/JZljJGft?=
 =?us-ascii?Q?jpqlXwAiXvKuYs8pmvfSeyMsInRxB7A/3R+IUfW+7BhBD2QVPb35k7QzzwKJ?=
 =?us-ascii?Q?BHAQtU2MLrKoL/2BWgIGhEoEoWM/pZLVwTvKXNXCykFFpPDR4eoY/WM8sRAd?=
 =?us-ascii?Q?LxJYsiyEgLOEFqDyBUuU17h8hjRbZjyzYGcN4obe8/WBpomY/mnyCcXCSIbS?=
 =?us-ascii?Q?vtEDOrSZX/deTg7bnZ4MYfWB5gf5oTivxLvaqukrHrpcef/mO8wzMmXfrlmO?=
 =?us-ascii?Q?Iu7YjGcjIa2TSL6GlnETH3QfXz4+gi/iDkpYrOwMmIe++tUK6SyErfytVUBx?=
 =?us-ascii?Q?b+f3PtkV9l5Denb8ATJ8o7zMPUfNZpmhdWSRKN4OMeJCVWCbdBdwFabJybnH?=
 =?us-ascii?Q?MkTOtq27vMN0AczJBpcGanJHbKbCTX3roejd9gOgtNWsirz35t3jbs/Ve06W?=
 =?us-ascii?Q?JJvb9Lr1ngh+U4UV9YksFX4UFXzmtm9PierU9Epm6zTUVK0jN9MJASsJLLVV?=
 =?us-ascii?Q?rKIkTPeNXHLGUW98Ei+QVzzz48GpRw4o1zF366Aj8gqJRLizUcKliZ1wg79h?=
 =?us-ascii?Q?p6LouuJ/VYKyUKw838t4g89Pf1/qFNKhH1CbVzGcni6KXu6BDiBE2sAa1Fqx?=
 =?us-ascii?Q?tKoWxnFC9TBB8mvNpptLvTAKKt1Keum0vk5QI6rvv/c8EiFTUp2leqrUIo32?=
 =?us-ascii?Q?M//41xtivE80L6TOrAoMq/Uq7fvEGO+BzEn+LPJl/7WnYAx7kzhjjFoDgPRq?=
 =?us-ascii?Q?Rz+mmwunf45GC5trIYCtppMvmfdOPpVlJQoAigoHt4NbfDKOliixHGFJnBHj?=
 =?us-ascii?Q?Wv6DHa9D935UP/1NhPCAl+nFd7GFh0oKX5a6dz5RTz7sHIg+p/bhxUhkZz2l?=
 =?us-ascii?Q?diYdnpc2tWvsWNjDIfUm4nnxD21iNSqTnxitChlUaWIv47w5XbRrXIn43jsZ?=
 =?us-ascii?Q?VMv6fV/+iOVyh9SYF9xqroT/4uo1y6YJbSdHeNnrn174eo0RTxEYrFhB2WXt?=
 =?us-ascii?Q?Le9o7g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370b2b4f-3d96-49c4-80ef-08d9b930ccdc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 03:22:29.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTwj9YYdFhP1JZVhfcrf9BMoms8zEkDMp//ATrLvmPUiuAOg/IMfslshbzU0Y4X+MyH86VBJJ39ZqYBffqYeQ1ckbPc/rVjibXhihH6hkk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4501
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=888 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070019
X-Proofpoint-ORIG-GUID: huTQnJXglOKvgMCpYoaedtwiFqo1vm2Z
X-Proofpoint-GUID: huTQnJXglOKvgMCpYoaedtwiFqo1vm2Z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Variable r is being assigned a value that is never read. The assignment
> is redundant and so is the variable, so remove these. Remove unnecessary
> the {} braces in the if statement too.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
