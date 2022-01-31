Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B74A4A4D61
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381034AbiAaRhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:37:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40936 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350320AbiAaRhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:37:37 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VFx2eO031412;
        Mon, 31 Jan 2022 17:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KbW5I/I37Jb8YzbYP2J+CcI0VlpcWMb9hvaRRqToNnk=;
 b=GEihL+CcXWXh4p4jjoIVi5JS4BZKq/Gsw9S3O36d0/ww3TtzBDpcXOWwBXwZc3U87mwD
 Bdzgh3tZyVKhrp5B71aSdixUAxnBxjBPSL/8iww3GwLhG14jUULQ24naKT0djzLBXolr
 JxhnvfLZjTF8fwjsbzOqkdyHqYn3LfhxOctY6GYu1uTODATqx4ZR5EkWnuqEGr9N6HwS
 tqOyr8KSdpysmvnAXqI3WY8PJpdMR4xcA8uc9Ii+n7SpnY7gMDL0EKfP/yQG49bcGjkO
 FdBc47kpQrkQiU+d5fmXRsNqJ6IX4sUL0k6HmiyEgl+1KxGoOeEVXevk0gHo37C7p0fF 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9v8gsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 17:37:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VHaFpV153167;
        Mon, 31 Jan 2022 17:37:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 3dvy1n644a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 17:37:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB6kyszQibzmqWB0EzStZw4OSb5bCspJ8Z0w8svULnwOarf+xSTk3YFNmG18rZHP4SIY/wTq0iYdRB4XARA8c3EizawWpfj/xVyCMbA4FeUh7qpGl68WLBDy9epKTl6PD/vgFgZYhlKRU+SeXSC8pzZP3c5444hb8mfcPg50/kLknMq/L4PyNXSQdqsbLq1ApXuObx4AuZAcvqr/STUr8gnseqkRTKXugllGT70WNEzxc3yfO8iRO55KcOUczMYSVW7iQq0dVW50nn9TREzq4w4tCsFcl2EdVPP3E1Befe2MxbQsSew/GN0BaszChgGKOuCq9eRs8BuE/eQOpknhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbW5I/I37Jb8YzbYP2J+CcI0VlpcWMb9hvaRRqToNnk=;
 b=bsF1hv9Eqhueos8UwO8VWoYhYDUG1mAhNoDoQ7ZO4a5eI10KsUyg+9ue+yjDrxmf5an/bUwByKE61s1F7ch46s4Yf7nwIk1zI58XwrWvJA/BOfs/iwK8kPzjcQijfrtok9RF7XexM87PEsJTtFZXPmyD1b3zw5fh/bmCrdJRaTaudR2WAtrMkZ48yPuEKMsV1ksD9y1cJsc/rLfPFSX5d9rp8bve/FAbD6aDFqvNVth/UwvlWmNabkXLKCdyXxJ4jtWX7t/1uMWj0VNt0PsMgwAS8EFn217zModhG0wtG7INVGdy2OkZCaWQHnJzz2y15li1eFBSiLvwZxZ/ycAE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbW5I/I37Jb8YzbYP2J+CcI0VlpcWMb9hvaRRqToNnk=;
 b=dluGoFBOrzx3zZLq36BYpr/tyIbQis5q61u3nhbYUSyv34sQ8pYikUaJ4iRLBEB6mYyJDflxAj5ttLnAfDEG0NQJdZwbxSyM/paoq3mJXVBBBTMoukSJEtJgzHphhs1YmqASSXhu45RSEfLo0Nhu3ACYRtBw3bjUeEnGlbFSQwo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN6PR10MB1986.namprd10.prod.outlook.com (2603:10b6:404:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 17:37:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%9]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 17:37:30 +0000
To:     John Meneghini <jmeneghi@redhat.com>
Cc:     skashyap@marvell.com, njavali@marvell.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com, mlombard@redhat.com,
        guazhang@redhat.com
Subject: Re: [PATCH] scsi: bnx2fc: make bnx2fc_recv_frame mp safe
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pmo7ajto.fsf@ca-mkp.ca.oracle.com>
References: <20220124145110.442335-1-jmeneghi@redhat.com>
Date:   Mon, 31 Jan 2022 12:37:28 -0500
In-Reply-To: <20220124145110.442335-1-jmeneghi@redhat.com> (John Meneghini's
        message of "Mon, 24 Jan 2022 09:51:10 -0500")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:805:106::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe7f367e-35dc-4f39-6852-08d9e4e05b45
X-MS-TrafficTypeDiagnostic: BN6PR10MB1986:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB19867FAB0DEF080CBD6E32E48E259@BN6PR10MB1986.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7D0snYlRfmhXghprnPWMny4I/l1dB8dFXVwisqgnJYS4hvTBIfNOgNCHvL3fmmtSUTpHOGLVzNHMCNLc28ZdwW5g74AqR3IBx34RZZVdU5yuOgJf/ftJTtw+JNlbmJSUu0fP2/wujj8IiJKrVutk9gbDs6HYM9vzZu+2Q7Ks4U/a+kNyLXRAAz2Prye82bGqpT17Xi1AULLNiKp5Mkb7XoGv7r5OV2rvQZ/bT76jndLvvI92gXLrKVt7XY/FnjsgJXwCrbIkkJSE3itkrdW4tDXBra8r82EramRf/tlRoL+UtnGoVjZseVdYkVWzpqTXeDbateKRm+rtDQh3TiLCriFsZDAmRXYW1jMJYQFiiVlP5UKYlbIOKtzKfdNY+/+lfORmj57VMUvmFXZ7Q4tUOk59z+tBeRa4SfhroJxpOyGD1oU1/AW/Xa2DQscwS9FQydJkINvS2I7PgSu29TArzBoRdDrjdzVn/RF1am4wj0zmoMbWAadsEORzQCEq6NXyTntj3NDVu8jUoMyQqEtbD+UBgMrmT/HMAHafantcuq31BeXutM2/DK2ndVtSqV+T8J5TqxSjDVzrEP9DREzqH0y9icGyHeurrWHv/LpEyritbRflBem3xszOmqx5dYtA8R1KxMnhyZedC0ZFZrZyCE2p5Ub3y73g8RXtBssZbTO5cGbCFD9NRCctrZsAmD/RVZSX7dIc5Xxf7d43O9S5xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66556008)(66476007)(38350700002)(6486002)(316002)(86362001)(508600001)(4326008)(8676002)(66946007)(8936002)(6916009)(6512007)(6506007)(36916002)(186003)(26005)(52116002)(5660300002)(4744005)(2906002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lNUuNfBoNR7fZCTuZFr/pmMz5U4/mYsrcvDznPsNvF56TdHvWqUM+QskESkk?=
 =?us-ascii?Q?Qj7DWtrb3EhqW0UmCdZNRZjbp7ZPYK45rfMdl3xSF1W+clwlJYGJ2MKrEyWq?=
 =?us-ascii?Q?OOQgc+AHj3zP6fTqZOFt/ty5d5VqABu+peMsougMOLdFjVBsHk7QDrDl2Jrh?=
 =?us-ascii?Q?rQTTZpk3Cfl3EU6TiIBxWAz5K90KMzB5r9Te569je5Z2CeCyht+hnTBiyl24?=
 =?us-ascii?Q?iPFuj6rizHG+x6uW2loQdWN6Oz/dU6DV7sgmoZmJW1N8MSf7Ydxk8bQmWPx1?=
 =?us-ascii?Q?czM5ADpD27BEU0xxg5PABoS80TBJ89UjNPa4qSumcaIVlaSvObbakd17Iaoe?=
 =?us-ascii?Q?2beOBn1gNZPP4cA9yTMZLCiEMhGuoz8iboZtmq4mrV/q8g2VuISV55COXR/P?=
 =?us-ascii?Q?HfHURqvPPrDZzNBGSw/MyWLLHw0XsUqPXWGDzGeT5UBRAl0D7ibio5RBipT5?=
 =?us-ascii?Q?DDKP9od64r6CMduJTKwKeaduWYDuol0l35u570XYQ6d0tgUtyXCNatw1TYwJ?=
 =?us-ascii?Q?eVCvW604vGhQlrIr94hGJLK383e/LBQrhTG7FDGy//rJd9hDQG/8oCQ3Y6g8?=
 =?us-ascii?Q?n//4BdgigH/lWPsguCiXnIpx2YFqy/gjrj0QwbqO+GmBAF7iBliOBABWv0Db?=
 =?us-ascii?Q?kpP1bqYj3FaT/I1Gg65zcwa70rmYDaI9Xq5rN1zgRUhmN+YOinhoCLsx+8uo?=
 =?us-ascii?Q?43d5hZg0G/dpDX4Cu2QuU/0cZ1UndxZTWlCv4Aax54sHhSlj6JFR2xSZS7Om?=
 =?us-ascii?Q?9zhCYIRq7seUql6rFX/ms8kYyfJ34NAKyGOl/OKb4TvZiU0PHxz6Tseff020?=
 =?us-ascii?Q?wyVqL8Y8SFBn092FgYYdFqT/hwq/6IOIQlWlnipGn4hC82Hln31UG2/18IXE?=
 =?us-ascii?Q?1mk9NbjOTPb7PwqHr+BgZCK6AQJAGO6dBw8n9BCTO+Zlp33lXt0j1KSYCBwK?=
 =?us-ascii?Q?uM2x2ANb1z25T0pcluZF5b/hYyJk4cGYGn3VFczW7EQyNzllBsqyxrR8LeGZ?=
 =?us-ascii?Q?hGMxJ2i3l7PxShXx6UjKPi67y4Zuy/VhJA168fQDklGeV+ZgNTH8Fkioc4jd?=
 =?us-ascii?Q?awXBUgE3EzH5PZnpJFvu+RFnPzVaSCB6lEJkKBHsDuO2y1RdKLaNqvANDCej?=
 =?us-ascii?Q?n32jqe6cr05h2HVHGKXxm97Ntc+XmNsrSb+odc1qlPylhg4GLJLzsQ8gzy0+?=
 =?us-ascii?Q?4omGPxnLD7smY3gAeT5Wo5p0ips7PXySOcrYbmRQrgri/IcpI1m2HXmzj5/8?=
 =?us-ascii?Q?m+wwcPGqa2PHamRFltf1U7JtHYL7iGE973/3k6miaLcLbMWgUVCNGqhnAnrb?=
 =?us-ascii?Q?N9ZCOkMTYpkUems/PWxmvYP3Njvkfy5bsyLhG5z3qvAXegbGI3GP+VqM7JbZ?=
 =?us-ascii?Q?hY++bZT6OjJ+K4jr4c9IofPbDjhV+MnvI3Qu6NWqqL1C+9n9YXvndb8/KjLU?=
 =?us-ascii?Q?9V2xkr6gEUCxmuCAgMUJpJfXb1hW2L362yAare5E/7tnQo7hDx8VaIZe0qpQ?=
 =?us-ascii?Q?374AFZexne71G+haMJhqi/Jq9CBDYVDhpuXebRO5r42ofEa0AcmkjGnBgkoF?=
 =?us-ascii?Q?mh0FXZIQ+B6DFBGTlnJPbmyAm6/xOc56UA5H2tBRHaK7mft0rER2rUunhiDI?=
 =?us-ascii?Q?IAg72tqEHTNYKkPI+VF98RucKTZ8a/5iVvB6Gp8UzGFm4fAVJLKNj2kw8173?=
 =?us-ascii?Q?PCSw8w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7f367e-35dc-4f39-6852-08d9e4e05b45
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 17:37:30.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SM5LGU1O1Hw68lAnQMvXaWrljRlMYQ7M9JcwXY3jtfq5ksct2Gwy1EePsGotQ9tugAM8TyCHp/qoQBNSqjYZumB2djKEO/a16NILM7CqRcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1986
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=962 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310114
X-Proofpoint-ORIG-GUID: MKt9LNicrUEOQLsvpbcydFStvhptWiRo
X-Proofpoint-GUID: MKt9LNicrUEOQLsvpbcydFStvhptWiRo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

Applied to 5.18/scsi-staging, thanks!

Please make sure your commit descriptions are left aligned:

>     Running tests with a debug kernel shows that bnx2fc_recv_frame is
>     modifying the per_cpu lport stats counters in a non-mpsafe way.
>     Just boot a debug kernel and run the bnx2fc driver with the hardware
>     enabled.
 ^^^^^

-- 
Martin K. Petersen	Oracle Linux Engineering
