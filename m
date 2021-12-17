Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03264783C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhLQDtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:49:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34426 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230426AbhLQDtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:49:21 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH2NZGw031685;
        Fri, 17 Dec 2021 03:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=7drpf9nuGdZ95bsG9M9j9gWjDyaWuJWeOsXMHtL9w1U=;
 b=TXgTST2Jhw8HGFXlSPE+3W5txKAqfBqGs22JxX4VTWCHlF4xTCF0idIicFposAVJ5Qnc
 bylbCg6N/Xb/d/4SDuMnNwy2QDct8bSq2bphPUatzEuHz1pJx+Gs83Ivk/xjNaExhJKe
 UKTs4TXH0x96wDovPypI0/gOicMEWwx3irXIvURbWrQqFYXShgukTBAqzBF16X7HfeWS
 pZw5nmlP9M9GVsprsj4gm5MyC0Uvldyunevwz4xn1FZXTJQLkjEB6uiTvjJTtv7viIBp
 yvMV5gDKcG3/YLT7ORtyzttt4D9wVkaIS6XpkLDDK7vr8cpsIpol9cMlmnSoT31tteZE ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmbmprj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 03:49:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BH3jswM193743;
        Fri, 17 Dec 2021 03:49:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3cvneuxhpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 03:49:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdMlojywNWw4GLSLxHQaZ7i8o6HPTTNZQviAvcDwQbBF2tz5Q7H7Soz69hR2gV8ccIrGirvo4R/O851XNqWMhs8SM0q1EvjsqkoQtsiOvO4vDnhpjTXYOYBxyrkoCsT/cEeW/KIrMmb7TRbbQYT1pReHKEP2p5hQQtYHFetIgKBoh4B161G1VVI6FEgt2WDdtfGFKW7+2J74PX8XzRbSpfO2BEZPKzihnxqYUGncNkzWhWj/oxX0QDhvgiCZqY2l7xq1lIrswadjte95YGppakPcLcYeuyWSiFPrcpRyhfBqTa3ETW/CeZDZphIkp7XTHGZJD7BgcLM/yrD0vVlihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7drpf9nuGdZ95bsG9M9j9gWjDyaWuJWeOsXMHtL9w1U=;
 b=iUGPLq28tgS4KuWm7fAvleWsIBUd6FXbpIw/x8tc5ACSwHrM1UMhsOI29G5EiDkvf/rhYKnbQ5pIQ6mSv3YTEtPihYN/wIUcj6tfjSumJvtRxTP0KzKY8MlbNAjUmTDh1DqBMEi+ttzgcYuBrrL9ez+HvHEQ71DP7w1/E9VjHCaULGiVdWFJ3U77Z9lSRP8+1WdpjFblMUsz8QGJkjLGZYIDCpRI6iEO35HCme1WlTki63idEKpjJAcpwNjRIcg/J/zVKxSci8GUL7ceNL0euCBW7JSXy3FJzy23qa0ZYa1us60LbrZ+44rV2DiLYTDDJZ9qqBTZlsoYuHp2uwIp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7drpf9nuGdZ95bsG9M9j9gWjDyaWuJWeOsXMHtL9w1U=;
 b=YQ9RYqHDuDViQL/MxTPjpMmNrLj4Z2Gq31kfY+GeteWOZ6++FhSZdjjMrHbwCt4ajL5EgIRxI8rcm9jKpYdnXC83kPNS/vyFAVfMp1gk8FHp9BWeEMl7GaPG2yhWnJtxpQ5sRKPE4/ktbIOQIXw3V/TP45cEUrHmMf3CgfB7gjA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Fri, 17 Dec
 2021 03:49:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%8]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 03:49:07 +0000
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-scsi@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        linux-kernel@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3] qla2xxx: synchronize rport dev_loss_tmo setting
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ee6blwm1.fsf@ca-mkp.ca.oracle.com>
References: <20211214111139.52503-1-dwagner@suse.de>
Date:   Thu, 16 Dec 2021 22:49:05 -0500
In-Reply-To: <20211214111139.52503-1-dwagner@suse.de> (Daniel Wagner's message
        of "Tue, 14 Dec 2021 12:11:39 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:806:d2::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2910550-b28a-4cc3-44c1-08d9c1102d5c
X-MS-TrafficTypeDiagnostic: PH0PR10MB4581:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB45815C62D486DEF9E1BEACD28E789@PH0PR10MB4581.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2jVUo6wOgGPKnxlofcWl6RUzB5QzYID7BzoNfKehgnZXMNkTkjKCahDrdce43p3jqnl1qp0Qm3lYHvhASjxi1W9ZXcRY3KUYkWBFcrF74cro0AAixMx8GaWZsPdfQwld17Ybu1dO0Turb/U62rvxHAgWJpnDuyaUhObY3MVRT4PRDkbIUNTg+JjiHfycAaxqShMAhledDfsRjn2DBIIa2CRrdBxYDwDnTJTnU4dWPFa35Z6MsG13E56qjd3mBjAUNvpENUj1Tfgxpgi187ib8hSJzlyDBdXtA3ABuX5MT/pB9IuY0y0ZvOZgCi9sprui09VoCiqhrLz+JOtWYYx4K39l5uIH1nrNGq52lX1g54EoRLV81In09JWySvlYyWFiLpgJsxOYg2AYEXZY1aBZXfgbyGH+q9RS6zPNx+GDBDcyXwSeh25IL2FQgGg59U3vNXkbnCe7Rwi+hyr197M8fK8JEm+Z8UZGKH2XigyR8kMS26iaFyjkmd7GYrJYC2KfcNcU0DERew2Kb6JsX+J1wjfiwlDLDX7pw81sDZE1iLuRQVF1qojOkau0EfWRdeRDfmebFFaSyYVwwkCegzDKRqGqdR+vz60hRRzxTOVSkw7H3EdUDri60P9iOWn/LtAZyL1oQXa4C/z8ZAGcjKpUuGq8xYX6U+C7+awvpajkSs6UbWzOkVKR0NvEMUZPfe9NXFvKiGhGsWNOwUxKo8R/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(36916002)(26005)(54906003)(6916009)(5660300002)(8936002)(4326008)(38350700002)(8676002)(4744005)(316002)(52116002)(6506007)(66556008)(508600001)(66476007)(86362001)(38100700002)(2906002)(6512007)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZRktXDmEzrrO8QTHJUP+FWUay/tTC7OIO9RIpnwNNvQNZtdvIcruA0J/1M5b?=
 =?us-ascii?Q?yHOrOUJuBR1nIHzX9W8cBJMlvHruGVeNB3LE2d9H35l/OADzDnW1ZX+QTPrL?=
 =?us-ascii?Q?dCWO3HHQqV7QgpiH6JpPC6LEjozf43XoW/qvNwIY7UNXswmWiVkGuG3ryH1T?=
 =?us-ascii?Q?Junk/phb7XCAjXISAx3Td4sAX37EVK/KqzfxQgA0qtogmEdy5FhmMG2m99Vu?=
 =?us-ascii?Q?fKUOij+D/80ZisbxlUAC5pNQLoL+XuUMtfwL77PxMvimJRECcClRL9Ku2qr3?=
 =?us-ascii?Q?coikgtk5VUGZqWa38GzXEZeTYXEiMYM52X3PWHpQC+0gJpUucLysH5rhHL3C?=
 =?us-ascii?Q?TXOdPZTlm6MNzf55ntjNkU8GZwlIcgv1Gd+UuGC/I7ogDPFCWJMifuuc4u6D?=
 =?us-ascii?Q?JKQBvsX3vk/Ocd7wh6xRKnzAk/nTrtrr5XR8UBaZfGhm/Soya53v9RT4ppe4?=
 =?us-ascii?Q?ctV+Ps+4kkwf4mzHNIZvZWWFX5kqRyeMSNxB4ZmgDgH6oKrgIVo/xruJVTE6?=
 =?us-ascii?Q?BcyVGREMyxkwz3sQtaZQtsYJ5YkoWKXQHKfmPyUXj3H8qdfJD+/Xg2PE1mF0?=
 =?us-ascii?Q?kmEvMQ0qSwDj0L8NX4DRMJuSJXrkaUmo0qiME8372pIZDHPcqF/HMQZ23bs/?=
 =?us-ascii?Q?YB0Tg7LdTAxTg7bB27pswSBCEJfriqAPzWItlk6pztJuZSdMSv9BpNbcYYre?=
 =?us-ascii?Q?OJMIbDBeL4Zk2/LZU8Xy/MgwOSUpFLKTCo2eS+A5t9k7mBEgl5gm3AdhVsth?=
 =?us-ascii?Q?brKnW4gDKc+y/d6a7dXzRVO/BLTk8HYGH8fpsLI34oYW3hf4/PHbjezr2xeH?=
 =?us-ascii?Q?Ncs/KhIZ8Jt/BKMnSz+p/UghkU4uE136QXu+jI3tY0QyA+7JjELcNkSLJX4k?=
 =?us-ascii?Q?uWb06TmCoY966XQ40zyiB0Xsl02eZRN9zeWukHdu/xFuVXAr9/K6foXAPx0k?=
 =?us-ascii?Q?xkEvIV18vmAs6PN8XWnYV53QhF0M/WRauK/8XJsBfPhMExFmwD0oMWu6+fNw?=
 =?us-ascii?Q?k3YDr4pnB9TVMDVKXGCXvPmdm/a7te+Dm3onUgozwU8qfGfzIIUIzCSSrSet?=
 =?us-ascii?Q?N6foA7yPOA3HlmaSZ2Y2xJLdW/PBvTbDWRnmcYiiB6BbvpOLtlhWLKWkPLZ6?=
 =?us-ascii?Q?XneyTgHctiXilH9SC6AAVuZVV5ttcdGc+/BrwGvenP6jS56L3+COLsIrir6l?=
 =?us-ascii?Q?mvnX3S5/iswNz1zSxYWe965uecmPuiOFJXrkyFDgaJagrc52hD5vIDZ92rSn?=
 =?us-ascii?Q?jbVw11EvhCiOZUdrcbhfZnuOiA18+60C5R49kr/4iDVflHlN7eviY0bUz9rO?=
 =?us-ascii?Q?ACGGD/ZNF/CpEWqxbmjlK2G9ROyMmRiB4GHSYfrRLfOUSwdd7SCgpqSf7G7F?=
 =?us-ascii?Q?gjoSI98Xlyf133Hk0MCj8NXRsmFojb6ybkl5/2Y/P8nyasFQeGVOTrBiAtmK?=
 =?us-ascii?Q?VahcMUIuLUgwSTIhGRbBf6DKfiLQkS2BvXkk0QJEPgqzU8qRsB5kYHrBSJy2?=
 =?us-ascii?Q?RWtA3iua/o0XfLHvuyaJOWWXL21Y/8QUQKzeOhXpoAE23tZSbppPBDkACQCh?=
 =?us-ascii?Q?1Q3IPTY8v6Az7W4NfRf/4CHTeQ6y0qOFKAHVs+oPWx1oSUdDbDez6vVwFAJR?=
 =?us-ascii?Q?Cd7duj7ShgP9Rxs453vefDrqMIqx18YuouQ2GKCeINxo8+lnXIDjscaOF7F+?=
 =?us-ascii?Q?aPRCkg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2910550-b28a-4cc3-44c1-08d9c1102d5c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 03:49:07.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hSabp/mdpwWxlhfa1MiGKYURHfxMoa1lz3zsb3eOhq9Pl9+dqmtg6iRehTGGFw1WJVlPaxmqf07xFsTtvNRzkSf8mYrpEwXIfWIYkVkhaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4581
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=590 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170018
X-Proofpoint-ORIG-GUID: WQE5_VVvG4aaSlAO0mbiRi_scNFsW3Ds
X-Proofpoint-GUID: WQE5_VVvG4aaSlAO0mbiRi_scNFsW3Ds
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel,

> Currently, the dev_loss_tmo setting is only ever used for SCSI
> devices. This patch reshuffles initialisation such that the SCSI
> remote ports are registered before the NVMe ones, allowing the
> dev_loss_tmo setting to be synchronized between SCSI and NVMe.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
