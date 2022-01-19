Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF74933C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351395AbiASDvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:51:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64360 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240579AbiASDvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:51:13 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INxSqi000680;
        Wed, 19 Jan 2022 03:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=0qrIOE+BmMct2gPkIC6I6HOhvDYpADRj7MBxpue1wxo=;
 b=gdn2t1GPnuIfkzBIbq9hlxvp/vDLOMXvwlR1ADpKfLeKCKuMFosJq2WjWgvQeqBMRjMl
 lur1b5blKs48hW3jQyi2xOcYu0nckT6MDI4zmOAinmydVjL1KvcjJQLHfNDr4mmiO6pB
 ciqmfHNb2gumDf7tHJhElicEMritfHL2j26REulWzLD+TCpePgD4nWJkLInGW1mvsose
 fNPXDuaWQlCx0Ed4Hj01YfQ0V+hnIwruEMtCX8lBm8AvzzDVRwvNhPTCYBMQpgqVxB50
 fgFVV3BMwRGGwz9WQtukRQ8r1xgrKoh6eBgQObM/zDSXmJOn4JkMTXRC2Iw6bQqQ4Lvv aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4vkvg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:51:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J3lDmA079043;
        Wed, 19 Jan 2022 03:51:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3030.oracle.com with ESMTP id 3dkmad0sh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkMKixmGgc2hW3Poa5V0Z6YmoFRUUtViN4ZsRcPIk7PMY94bYdVIGPULwo3zFSYSowJqM7Ay19qQhM1bZ97tkEFmGXoBwPGV2UgLK+nMuuKue1TMP5Zl3JszOM8jyury9QYyIHAU3st4URMFcYjRHNSc1TFvXZJ1w0uQniYzG/u4OJE02bhw4HYUe771mSAA1MfTtrV3dE0D0hqqDTxInWievwKGAhXiPSq/cACfL0UbAIJWZTfjMtjRqTapNI23S+i3qv6p2XclxhTKiIaBpm5YdyN9y4xuM+W9qX0CS9+17XioRQO/rXN4RdhxvL9K+FMAVoqLMQPLXu0WTHqM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qrIOE+BmMct2gPkIC6I6HOhvDYpADRj7MBxpue1wxo=;
 b=KeAn3+cnA1EHBtskrNfu/AaNGnbx5zP+gC2eCNnnGOsE9JEMGyTru0dWWR2P/GuwGsXqkZzEqtp5awIE6LHzGHTkR5WhjeH+gARTbKHhQJ8bzwGb6080yB2kEp3DtGIGhxrUgInKw6CsdGlLigtpHDroalGm9l5IZEm7il1VqbkchJ1J0b1X/XkB/gABhcW74kc1qWCnS/TYgYIZPIPUA9W4LB8gQuni8XFgpU0WnNQT1+CmpLWNJuvCyGr0H995TPVVYkDFUAsnKJNwX7dWZ6ZdYSPhRxovw8hwIstvQc82MUmZytyuW1CaAiy9xP3RVRUcPBTX9izOCJZUct7mlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qrIOE+BmMct2gPkIC6I6HOhvDYpADRj7MBxpue1wxo=;
 b=EMAbO/wkN2qNL1s58p1492c+K+9wVZGKzuV6deqteIti9073uIKhXIFDS9XN7Ft1aUXen6tPWahzv9clMAR8781Dp6qfbE2pxTqI+SeSUll8XS1pn4fCP8Rroc869P491TAjfHsALU0vJiBnOjStWBYYWNyUr1l9BLJW+j3+byY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN6PR10MB1410.namprd10.prod.outlook.com (2603:10b6:404:46::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 19 Jan
 2022 03:51:05 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 03:51:05 +0000
To:     John Meneghini <jmeneghi@redhat.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com, mlombard@redhat.com,
        skashyap@marvell.com, guazhang@redhat.com
Subject: Re: [PATCH v3] scsi: bnx2fc: flush destroy_work queue before
 calling bnx2fc_interface_put
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pmool6y1.fsf@ca-mkp.ca.oracle.com>
References: <20220115040044.1013475-1-jmeneghi@redhat.com>
Date:   Tue, 18 Jan 2022 22:51:03 -0500
In-Reply-To: <20220115040044.1013475-1-jmeneghi@redhat.com> (John Meneghini's
        message of "Fri, 14 Jan 2022 23:00:44 -0500")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac735131-3603-43c1-a197-08d9dafeeb71
X-MS-TrafficTypeDiagnostic: BN6PR10MB1410:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1410A94E883C30370B9B6B728E599@BN6PR10MB1410.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsJkAE8lVuK21MtrjMUP8HAFGX4A3tkeAYPe3ejOuYUZrr8kFE2wBFs0joOZqJ5guU/Y0hL1jaIg0sBTTaOJz71pdRsgn5TOXGOGQTYIG7me0TIc8PJbF3/V4x9Xj3/RNhu7xl+r9loVSmYyhEgbt9FKCKEjzqjZzkON1jfGDoek5DhLaSXakJPAux/CqAkpMy0nmXjzUlp3n8RWuLqbKRZg3kiFrAHn8Ji6FoYHYq3SdoXpeRVTIMIYcit24hJoSYgMBBCFVR7t+r1D5exe/Zopx9tZgVwToPeHVb/y4JUHfILLwdrwgJFgCkmjwwRVn+x5JlK6qfdnNJ5IlI/AOpXSHxUo4A6IEiNbg3mjFMZuYFN+Lsb7R3LgSt8mmnMxR/BJ7mbCdE5dEYmhIQubEo7hdQOLpO6auno5LFVYze5b73cPkfWfSar2yfIvhlnxWOX/4FZBmA3PXWnGqRE7O/TQ/bTmhIhaRMqmq82SqnoknNKDGhFPuvExyNPCZwS1//Eem3AVor9vPqti0X6Q/i2y/m9XYTHWwbrcWSemq2Lp4g8kOUCakjnFm2kastOKj9VrV/ME01M93ZH8S9NaVF5ac39fNdyV/zkY6nWirQSSL5oVrLdLDMmaZFsfVhE9+mu+HJP0lLmy2BQyJ6u09iBBN7So04IHdL0XmQd2W4vGj0CJrT9kq+4rBwjPJadgDxUknYRMG4+TYF0verCvhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(5660300002)(66556008)(6506007)(66946007)(8936002)(66476007)(52116002)(26005)(83380400001)(86362001)(6486002)(8676002)(38100700002)(186003)(508600001)(38350700002)(36916002)(4326008)(4744005)(6512007)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E7Lv2oDCa3SdiIPN8MaS50a44QVP+uJrwJSVvcHYVekrCnzzY38VB2limFKq?=
 =?us-ascii?Q?2Z/eHIRZspw1xg7EzecHMvDj9mwJgQNhcC5LAJFNglIvjricSHXUNrMOclJJ?=
 =?us-ascii?Q?/mVQV4AKNit7eJ8FZQGfKesHTdRBHx7yMOJuqQFCX/qQwBo5tbGbRpTNvCn1?=
 =?us-ascii?Q?T19IasGU0/SuOZZ1OCxJGneslqI9rINh8dZR7NN5JB39/yvttYy3AXuxWVNX?=
 =?us-ascii?Q?j9Pm4m9LkYfxllbV094ASTO9Qr4XTWPEVVrQrKi7L61uoEqM02sC3m5C8Da3?=
 =?us-ascii?Q?2GKoG7qPiFeTjJWjTSVwIFq7st0zMSC6AJjVad2mIn4kesjLcEOx6BfaE1q6?=
 =?us-ascii?Q?ipwyg6f/92eGYhwodDaso09+RPAb9K0izI+UBukpWx0PP+NvwnDz1pkhsB+F?=
 =?us-ascii?Q?mlIf2cIYf1l6wxrgn4t8s23mx0s3CwaqqKHD0G6Z8Y7xANXdGoLT4zoZJPgj?=
 =?us-ascii?Q?pnCIqq1pCMgBdgPAFvbXVkTUA8dJjDCOOqsbbZ5Wetooov2o2XVu28YRyj2g?=
 =?us-ascii?Q?52g70zNIQYGJYBz71rtJZuydxq+YLIQSgZ0jqGeLDPqb/NJwSIV0ZyPhfP8R?=
 =?us-ascii?Q?BQSjjFtxPhMA/qBWfghYNhBKWMxUMP56NsE7G5k1B3kk/9tOz8vI1MhXhNQ3?=
 =?us-ascii?Q?52GmEyqQ9gjs4tvUiglTYvBOPZ5TY8h3NVWfVENfak9T6gwq3bPBVxHApjgW?=
 =?us-ascii?Q?CNZdAlyBU0gkuFaRoDn5CKBt9uo6zhBX1hYTfN1oXNMSKkobS4Q5qK4j5lQj?=
 =?us-ascii?Q?ZXJDUUv1KoD2Chhtl//lzKk6wNkIHxtl57Nt4BQlnqNdn96DQoocuOa5/yeN?=
 =?us-ascii?Q?FZdd/gZWor1KkERUQT4nr1OUytiyxvURQKTsqkpc1Nfs4I3Iu5zM+fM/pMCd?=
 =?us-ascii?Q?ewOaDttlFiPUEm60iSEj7E0aHgapbCVSv3QImIYxQJ/Nj3U/+HmCOiq93nyN?=
 =?us-ascii?Q?hOgA6RGvyCgLKEpSvcexVTdaAb6+3FEaedcGAhBxs/mnAHku5idkaEyBO4T7?=
 =?us-ascii?Q?if61fEjcpFz7Ka8LxxWErxnbCOCfdo4fNIiiujxBqzp//yZ9NtdTpUG9wYtc?=
 =?us-ascii?Q?8S+E0n1z9V9RVqujvxLjGxzOAqL/IewZbpRl/58w4InISzXiZRdz74LIlEqL?=
 =?us-ascii?Q?cwhnEumamIelK18t6ETGI+3ID87VNB6AXKW71IrYqG8bU6WF0nDxKhjwJXAw?=
 =?us-ascii?Q?LsfazG9DtpYYBq0cn5R+V0e4eVThoSP3d9VNOZ/awKdT1HhhdPhFvm+Hog53?=
 =?us-ascii?Q?lKarhmqSahz55OjDay+5HraVRjTpUM8Sfq0ArTMpbEZ1zsknJkMPgJAaRBj6?=
 =?us-ascii?Q?rc3rVtlbN4pyvI2fz41AEnowNzkV6spbYad5haTFJqcgVEqMTd+DqX7VwCPD?=
 =?us-ascii?Q?kdnZLa+RsfN3mG8byIjwTCenskz2phnhI35OUkhyzYWU3os9voCbydLjqtuX?=
 =?us-ascii?Q?oc0ouBxTO5OHXKY0vket0ec4n77EKKyQLkWMwWOsoQujXJCNPl0G9/N2N1Y0?=
 =?us-ascii?Q?/o+Onx4sHY7nRO1LOODGPfwreX8SqDRuNrzqy7lyvXY5AdHNMAinBgv4R+Am?=
 =?us-ascii?Q?YN5bsKCb96TqhAAsTMlP3E8kCzteb6isAxWM20cUGEXszI+OVBFExXISZGLN?=
 =?us-ascii?Q?2QUk9zkJVmmmBtJdU3S/F8XawdcKQt/rzzW4EDxx+bmHMo9S4jHSpAk8Akfc?=
 =?us-ascii?Q?INwyzw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac735131-3603-43c1-a197-08d9dafeeb71
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 03:51:05.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSOvOCBQDfUJ4FOePEw4v5Rerm7TJtxlx1kT8hgLPZOvMtXyXlpAnGaNQqJ0fwDe/ueoOGOum1zeh6UmdET8UzYFVwC+hPqzfhzaWJIujus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1410
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=783 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190017
X-Proofpoint-GUID: KYnfsgk3eU-DqYQ3jPBPljJRT3NjI_SJ
X-Proofpoint-ORIG-GUID: KYnfsgk3eU-DqYQ3jPBPljJRT3NjI_SJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> The bnx2fc_destroy functions are removing the interface before calling
> destroy_work. This results multiple WARNings from sysfs_remove_group
> as the controller rport device attributes are removed to early.
>
> Replace the fcoe_port's destroy_work queue.  It's not needed.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
