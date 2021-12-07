Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBDF46B0B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244234AbhLGCjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:39:10 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41014 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231468AbhLGCjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:39:08 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M56st019273;
        Tue, 7 Dec 2021 02:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=VXFXs7vESWELA+v1GT6+ejRlmOawDMHhsvOVPUe4JFI=;
 b=FBn7SS1J0mdX4RGqd/ZZqwfKvwPtRbrVWtqYFi1KctFDpFNZPtHJnqlNnMgAMYyHsOXC
 9di4mHtX37O7dbxW7CbEycRph+lsTCskf5gJg1RAVIE0ve4Mrs8U486BM8v+8HqbpmBA
 jsVlLNzizcki6DigTKSGidRx+XthdPO44brzGHOJHTTewTgndB3hnrSeE39SMIcbxG1k
 4R6Md3Dk2yvFbzr3bpnmQ+a5iBB0qbAVpanEIH1suRcAXmXls99zzrf7H6NKqDh4t24x
 W9NipbSkgXfX3aH1ugwlbFyxbRqVdJ16gihYnATBmcBHnof49NSI1DD95R/u8Jcf66e+ Nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csbbqmds3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 02:35:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B72GdIJ077251;
        Tue, 7 Dec 2021 02:35:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3020.oracle.com with ESMTP id 3cr1sn5cyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 02:35:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Plgwrsly/BAFmxZ/NY2ScugJzrtczpOkhjtD/vhN4Ew9qikTomlJUzx8IP0XtsSsK5xKgSCOIAmV7W4NdNSNXjaqPFidkAGkCOyfcC8Flw+70Xqbw0XYm2REUEguKIPeQlsDdcuG06zlom47KILlFw8TD7aV2tRhNJoYGUeQ57nBss8s1qoyDHrDc6bVcREldp2bbl6sbf5e4EDJEUHGrpnAEIjMwye/fj0fH7kIgGAmyZNnAmLIbcUdLfZO+N3rNTf0BYjJj9KwWhyGjbwbK6joAQkd2wklKsFTXsnYlK+37aMvAhL5RJ59NhhIemau9zNBwhoOqQPj/XRwfClXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXFXs7vESWELA+v1GT6+ejRlmOawDMHhsvOVPUe4JFI=;
 b=lgLPEHwwBvqRZ9zX2eCwnixz1fF2wyOdUtiSX/QeuVuHlc2aTuaAMIC1lH7SY5B5b/cfxH7cKp/jv0vdjsTcxErVoV37vVRL/hm6Rk43A9mmiEplS/0wv0aAl6qqVl9jRbEEwMPXaFJhqYVhYeCQMxIUOMPGfGArdwHWbAup2HzQ6wap0ISmRmQ+xwLiTBayBmzsOmrCW4U3ZEs/Z3gCDvzN8dJg2ivzVBIXR5GHNF9Ljy+5nb2v3vFU0iI3vDohRjNfsccdb2YmboQpIJtw7RNI7bu4Nu0odKIDTscixckCvRcQEaZZF5RvY9AHcukEcUERCM0g2lfdhyum6p7TpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXFXs7vESWELA+v1GT6+ejRlmOawDMHhsvOVPUe4JFI=;
 b=TsYaECSGEUiotxeAGazAUI+9RLHUOM9FfyWI3iGmkoWtBbSsJAo9TFhIiLSBYaI3PFFFv++vFe7lpPxoWmcshUi8NBy84XzJZtfKQOTRYYiqw4Th+vQJxU4EaZhKK+o2zYNvp31pbFoyNUP3eMzQTNSeVW+ArzJfkIU+FJ32Hko=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5626.namprd10.prod.outlook.com (2603:10b6:510:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 02:35:12 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:35:12 +0000
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
Message-ID: <yq1ilw1uout.fsf@ca-mkp.ca.oracle.com>
References: <20211201074456.3969849-1-vkoul@kernel.org>
        <yq135nawg3q.fsf@ca-mkp.ca.oracle.com> <YapW+EY/IeUk1BLz@matsya>
Date:   Mon, 06 Dec 2021 21:35:09 -0500
In-Reply-To: <YapW+EY/IeUk1BLz@matsya> (Vinod Koul's message of "Fri, 3 Dec
        2021 23:12:16 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0081.namprd12.prod.outlook.com
 (2603:10b6:802:21::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.56) by SN1PR12CA0081.namprd12.prod.outlook.com (2603:10b6:802:21::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Tue, 7 Dec 2021 02:35:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e05f24c-d933-4fc7-e4f0-08d9b92a31ab
X-MS-TrafficTypeDiagnostic: PH0PR10MB5626:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB56261F967AEDF9746DBED0FB8E6E9@PH0PR10MB5626.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58zQ5vhDU3Y53T0xXEfxLFIh9UFAn7q5FVPAp3q1dI5Rxc6NoRPNDYetgFxYEO+uO1cmgnCfLpLrG1rj0pPZKk/hUp8bBlcCGy5/38Pi7tYRPSinPkVP3Z48Lk8dH5EQLejuQZbO2v62El9km7sc3J/gMmAYJzxkexrkKsBfBJkY99LdQbMUxz04MexqS3fQLMpKWbR3uiUuFWU3gM/+0nLoLv0yCmn4v2vgEvdZ+hMBUBTlZcYjjI+qRP/M7dIdUipFCafgXQr18u2P1xbayFnUWJIUNY7aguiqbXQzLcFfk7FDiQfjoaX2M4D98gfxG9KGCm5DuIaAX4+eu7r3AuSUKU4h89/JZVia4lLdS4F1aHe0SjtKLdirGkDQBZKiaNIoLm5fVGAEl0qBzl5ui1iKBVAMEM3zz7cqNEft9p0o9rw5oavVnYGUuAMJVhfjORl2fH1E4ETSlA8LfjxhxOdkCdk7W8bjv0AYsrop1DNGNWbYmtSNiJiFxhXEkX3j/u+2R4ctz4TPYPZ2GEvYOd4pULYrX5f2mwlhh++sabT6TvgNpiUWyORUQIBSAdxs49BQOdHLEcgP5QA1IpsSVllN0/mDIZeGeXSPZ10jWPGBI+csfsXATbgDYLQhQiv3sWU7BA5WM/bV5Gcfu12QNjnfWcIm0ztK6R4xbH+en8hbQyAXHhrDAW2Xej/QuFZbrmLZ/XT2tjam6rdzst0j9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4744005)(54906003)(38100700002)(26005)(8676002)(6916009)(86362001)(8936002)(38350700002)(55016003)(5660300002)(66946007)(316002)(508600001)(186003)(4326008)(36916002)(66556008)(52116002)(66476007)(7696005)(2906002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YVQrFvzYGjjLRO5bhfLEqP7NaUHsS5ZRxCgzXaDjM5bisfxyPO8xHlC6RjCP?=
 =?us-ascii?Q?/sBPzia/ZPiTDmdIhxik0ZPHslLyq+qCc/vXKGF0l2M7obmPPDISEOZsLt1V?=
 =?us-ascii?Q?7W1ZWk/bVT2Akt2c8HDOoa7zouBRvT7oNkKSTpgCuXvmYxTRBf72GPiRCD9V?=
 =?us-ascii?Q?5XHND47pjXGDKWjBNnW5mtrEvGFLYEmMXD2Wd1fn8VMfZYeLoNlZVwf64oAB?=
 =?us-ascii?Q?Qz4Xlj7Ts7y8r2tS2VXqKVcX9rykwudvZcUG65qEf+2GtP6QRicPW4lHfk1I?=
 =?us-ascii?Q?sqHsV+jI4TcwEBLQocmogrK6nt55uKyRjlfv89bQ8nWkFKYbElLNU0jGbnxj?=
 =?us-ascii?Q?VxrUcyt+GmslCMr6hPgN9ibzxcLgKtbC2vuNp9AS/xsObbD1PSpBSJCZsIW7?=
 =?us-ascii?Q?qkXDCH8U1I7c+986tjLn/248b8Mw8KN6GyzzBVySWKyhewKuslgNa6GHTrGD?=
 =?us-ascii?Q?DISS/lcHR7qUqMnm9Va5ZibgAQab4nzQZSMaikZlRMNBW7LtfSFJxRTbJDtH?=
 =?us-ascii?Q?uCJsTXHWNLUGrD0Hc/HXWSp8ZkWn0vAJhbxPYwr4UU/Dt6pmVJxEO+HbYOkj?=
 =?us-ascii?Q?Zp7uNuUQksByHb5p7ATfOJwEGnCwlI8aRNN5+7JX2khjq2FRPZjATE+91KnS?=
 =?us-ascii?Q?Jji4EMhVOI+IuoROFPhZ1ZNgJ9YtPE2tq8ucEOSWOgcmm+IHIn7wXClNeR2N?=
 =?us-ascii?Q?VNgrkshca8wRoB7u2wEh8ZurKRJY7ccvdey+lw+ZdF4S06NNDbr1cdLBijax?=
 =?us-ascii?Q?dSkP3Kq6hYOQ7owms03ts5oOTPd/h/2pPv/XD9ftYZoFm1PKHxtO52sIEjtA?=
 =?us-ascii?Q?sZllmthsqLnLveWIlQdbxH/EOC/uZFU4/lih/GbjtmUGCVWwxUTPAIdmf4rs?=
 =?us-ascii?Q?6Xv4pZQ4W8Q6Wy5ryWdYduJv7/+EeBMZDPCzwyfnYkAB6Xiyr+QJk9/vATI6?=
 =?us-ascii?Q?Q1j4Xb3fzePrOk93QWbgTRcclCjvW8won14lZq0VVk9jalAjE7JXSmS3q7GE?=
 =?us-ascii?Q?r6kLBOA5G6qb8QYTh5rfeTLgl6XDg9qwLWG/LHPqzNQvH6rx/cC9YUr2gAM5?=
 =?us-ascii?Q?by+F6L8fHqhyVxBIdXOb3i/a13mhUvW1+co2N6jT/1P0cJDS+5F8yTvw09lU?=
 =?us-ascii?Q?CBto09VMc3VB4UKcGuiPTaD5Dd/kTBgV4OkxyBO6toW+2wuz5xKp40XNoAwM?=
 =?us-ascii?Q?UzZRpT1SkoOBgROF+Ve2sdWXaliJIZ0kW2C6L5GUcBp8IFqQTa+L/S4G1eE2?=
 =?us-ascii?Q?CplL74jFUSH34GniKGzDIUDltqwHiWjKsA+GS5zmTjWqDVO73NyuINGJvEah?=
 =?us-ascii?Q?P9MrVBfdvWtQxFz+7U10DbEQqGJRi9RqzkPhxuVLolHZVcK5dPl4LFIF+4F9?=
 =?us-ascii?Q?ZH8WzY2xVQApBFw02Ypa6xnOBpNG+scS1+nBl9iVJ7XbW3FRpSyIhkF77TGl?=
 =?us-ascii?Q?UXGhroqEqoshyJdl29T6K0C75rOuM9hp1Hkp5h4KggoaLW1d37HfVs8y5AIj?=
 =?us-ascii?Q?kKs9Fwrh1Zy46F6Pv02jtWXeqYB/RVS9vK04S749LuYDRBsELOOwhyHf+nuz?=
 =?us-ascii?Q?bjwerz2EemPzTweb1GVH7SvFWu2ruWM1mSdlny22CxQAWns7MN1Wc2E+h5uL?=
 =?us-ascii?Q?g66udtSQSsyRUZVbFQY3gzeMUFt6JONHeDQQCy0NLIDnRbsPisrEwCt8iD8T?=
 =?us-ascii?Q?uRg4VA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e05f24c-d933-4fc7-e4f0-08d9b92a31ab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 02:35:12.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrGgp8+HftMlmUUI2lEQkXNG05X3/9CYzJXPHv7Tv4Fa4KEXsBHEVjhYyjRdbcmijqpANT/vTwThTEFeMhzw+1ofl95Z6Z/KxVgy2v/yRIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5626
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=961 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070014
X-Proofpoint-GUID: q4OlCSDti9b2GBVNxMdMPqao3g9aTJh3
X-Proofpoint-ORIG-GUID: q4OlCSDti9b2GBVNxMdMPqao3g9aTJh3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Vinod,

>> No objections from me. However, these patches should go through the
>> DT and phy trees.
>
> Ok I can pick these up wearing my phy maintainer hat, can u pls ack
> it...

This series doesn't touch anything under SCSI. But it does look OK to
me, so...

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
