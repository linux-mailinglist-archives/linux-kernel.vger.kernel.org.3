Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45EF462B65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhK3EDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:03:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21488 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238033AbhK3EDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:03:44 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU3WbuQ000934;
        Tue, 30 Nov 2021 04:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=sZm6puIc+cMD7AtYegaf9iF9jDDsZHYkSdTnfzgRUQ0=;
 b=HyiV7+24Wkn365j6txSITGmuE9o9RnxaZi6GbrkXB4ziJG35wS96sfeUveP0NNRCaOwi
 Y1ZrGffXYKxKR0j/rngRTZV7OXJLV2yi6sJgsqxbXKck0NpdN3TXhBmvzHwsJ00au7j4
 ZfhEuhOWLNssb5J9t7yngQRxHv6ACI5ikfQUsQRR9kmZi8u+xf6/KTvyqcgW9sU+wWzs
 1HHyoJgFGEF/PZXzGeSFFeOYEkAsLYQR1+m5psRUHNqKoxBeyUPIOZmanK8gNkRF+px2
 SjkCeQ5b6rorNq+jX9kOSLHnLQTOZ/qKu1Nb0Ryg1GGOw21XxGpD2G1v1wDzvGG9X8JI tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmrt7xue5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 04:00:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU3q5L7052024;
        Tue, 30 Nov 2021 04:00:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by userp3020.oracle.com with ESMTP id 3cke4nsa03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 04:00:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKtnc57JmMtGf4S2kY5ofSCIL194EEBNygBVwY+ALZXHrw3zm88KH40g0zM6YCqKHR32YbGf0F+ZF2bcT0YgOtVtgjLeydvE2k2ZuSYkfYO9bpfwwuVJeLcu0JZ5/FuBriJDBxFxC4RMGd/ZCzZbPO9eih0JGchYkaqwIe9LHSWt6s8wofSSsrTZEUXjF+/Apyja6zZmlZRZ1mNa6aDzavVrFpbfL06UFNIcf4GVeW1Re+6+t01dufNUO9gSwioOMfOJFHhYXV2eYorKBFH+eTmDyUmzzvN0RtAysQRFBc+PJKzvY2m0d+ht33hjBV7fPDAePRGkhI9S1IOfTx0O/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZm6puIc+cMD7AtYegaf9iF9jDDsZHYkSdTnfzgRUQ0=;
 b=ikVxHem2mSs1BtIG23iBLoL8PwoWcjtlV5GtLLfKRSxTuWyOZESnk6AGsRlNdZbUvqsNfiS/kYKWQ7z1DKfZMJlCgxy+1r8fsptUGt8bvt05EZmZ7Rp/AGpEFyJXgvcg06P/eXTxLD2xzsKgShzuiM1G2PCXG06stfDxrYEk7bKLXYzjEyDl+FFTq+9Q4IwlAoLMvW6rduqoHE85dZh8uvtQYYFeaw83WayIc3FzX+8NmqlUuAiCjPb53Y5nivvqs79mbtGjbWqn+n1Z7ueMewavcGu0oj+cykIfMCCqa3DHt2AKjK+9VD8eqGeTG/dRUwxZa/qMlWx+38OfqizVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZm6puIc+cMD7AtYegaf9iF9jDDsZHYkSdTnfzgRUQ0=;
 b=u4TOIeURK2RImecP45pIjESUPNgybabOFuQoIFYfXFh3pt9+YTsgdaUvvj9eFBQzn9B9Ek93Lzu1yNhgO1DvM7Qt8ue137V7ZeYKgoUpnnXYglV/Jwl0UUXJZ6dQvtQrTEzbvuFPZs0W0VESyBcWQa3Vcv0d2X5UfWTpnsv3HoY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4662.namprd10.prod.outlook.com (2603:10b6:510:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 30 Nov
 2021 04:00:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 04:00:16 +0000
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:QLOGIC QL41xxx ISCSI
        DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:QLOGIC QL41xxx ISCSI DRIVER)
Subject: Re: [PATCH v2 1/2] scsi: qedi: Remove set but unused 'page' variable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a6hmz41l.fsf@ca-mkp.ca.oracle.com>
References: <20211126201708.27140-1-f.fainelli@gmail.com>
        <20211126201708.27140-2-f.fainelli@gmail.com>
Date:   Mon, 29 Nov 2021 23:00:14 -0500
In-Reply-To: <20211126201708.27140-2-f.fainelli@gmail.com> (Florian Fainelli's
        message of "Fri, 26 Nov 2021 12:17:07 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.10) by SJ0PR03CA0257.namprd03.prod.outlook.com (2603:10b6:a03:3a0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 04:00:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d0a69e1-fb0c-449b-0965-08d9b3b5eae7
X-MS-TrafficTypeDiagnostic: PH0PR10MB4662:
X-Microsoft-Antispam-PRVS: <PH0PR10MB4662759B2F62F3A425991B048E679@PH0PR10MB4662.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiP0RxrplRWLKqRgamWGv7di9uyD3HS/a+ATbGgeX6+JkurXNIvDKkJJvCaHXcDFD1wuuf8k8qFmQipNTcV04AdoTehOFJ3XGWz4ODb4NAI0WXEW5Ot8mH9XPu3rcgs6k9Fn6lpK1OWVIA0dF//t4oYhc9CXm0QYfZh5QZ+GSJb98IXID4apRmPczfsut3QkJ0wwrqbhSmUW0nW70fNuuaiN1nc+XHdM73yeSZ85k/it584kOJqOUTf5RCEonkRmv2hOjwECgY3ak1lN5OsvAek3fqqJzfQWtpbgjFyhfyWw8ZehcoSuTqE73OynxYVtocM2pReIiuBz1XrrNj7Fg1Ch1sUdAsPFo+uP1FIKT8Df3UccqdHntfkGu5eNyPg2kGUDXvuBekst0BxJTGpF75eTq6Y+HhyyD/x6IlTqiRXxB2bE1Ksisz28mILRNYt3IJforfYC1xAmhPB/VLWh0uW1u5XLswaHzaXDjlKOBRFoa5v7xEhohSbf7DcaL3NtYY6qkn7IlkK5phjh7kdNFQ7XSmdmWzkupPhnUV0NXVDQ8Pu19+O38MXQvpBxYEkgMDre0+++UjaWhpjjYJdDlJ/sC8jiSLgSvfvPYS5WWjrU6G8mtE57jC0PBcM4ppYXGA2/sYNGHdHpTFPmaq5ahGFFHt6iw5a8wGTZ+7HYdLngD+iqyfg495i1r8Bwqag/EZheNo+CwOvCD0Hz1I+lsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(52116002)(38100700002)(186003)(36916002)(2906002)(55016003)(38350700002)(316002)(5660300002)(86362001)(508600001)(956004)(558084003)(54906003)(4326008)(66946007)(66476007)(66556008)(8936002)(8676002)(26005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XEezM4w1OwNwdsEPISFlC+DB2CEwqpQdJgMyhmm3bkdmkTigYyHEAwrcomwd?=
 =?us-ascii?Q?5FsjEDexEDZTWGsRpMxZk0XpJcEiJUsFfJLrfFzHLOyVykKRxyDpLc3EvyTo?=
 =?us-ascii?Q?/myzpKcQIIALSsVj/PtYBmxBSfMZOZU0Eo1NIILvx+OhrHLxR+8ftUyW02MP?=
 =?us-ascii?Q?i3IxwCLSsdtSUgewPNFMCvIoaEsvli8sItcPYWYgP4gyZNj7l3KaAlg6Lnj0?=
 =?us-ascii?Q?LX9eFuzC9MAWVH5XODbkXyc+8H7E20XKY+cBNBG48ckbOhvSLct6Pp86bU2J?=
 =?us-ascii?Q?WJVTlG4+iwAtcQoFP0L/5IYEwFIDRQ5qs+j/17q4EvLVZNIWew9pf3IFiTMc?=
 =?us-ascii?Q?h7oU8EU1mg60ZqFihFkuuMqQTFI5KDgGuBL2+tge0pY4g1vlnmNCq/PDPJPS?=
 =?us-ascii?Q?gFNH8p5U3m+6NfLen5d74PfWU3MTDTdZ6OS/Opr7HRvpwScBsT0ZHFXbmEd5?=
 =?us-ascii?Q?qlD/HUvh8AjiC/YfeYWX7sP17v2StB+3zhNZgQPnBstVud6Hyc0BL2ULNs2z?=
 =?us-ascii?Q?SBXDjAxcQjo1NOycHtT8NmVDOA0gdiyUdSPb0ndvnAr0lo7NuuCUJVVNbwOj?=
 =?us-ascii?Q?HrNwB5vFz3QbYnvT8iVMzMdUriAn9cX5h+97+ef+msCpLM/ShFTffNSMR/as?=
 =?us-ascii?Q?zpWLVYk07ojifz1JJuSwzQfYy6jLbWO1cT1aMj19wL4SFcFbM/7opSh35AxQ?=
 =?us-ascii?Q?dfawKnx8QPhWXU+M/p7zrbb8fiuKweB863wKL95zphPvCeGfxvqVNF6snQVL?=
 =?us-ascii?Q?dCJGRrL1ZrW2DzqrEmrhyl6qBXk7q6Mz+OLi3OtRh4cGHs3sP8hU1KwTjnCG?=
 =?us-ascii?Q?gb4q2rU8JYcA0dPEYduBqsURLin6MoAyzLiVwc8GYkWU+Tahecb6T2E8f5KY?=
 =?us-ascii?Q?feiN5izEmHsZT9Rk7f5c+9B8RL5Fyng2wO0FZJ8yGp/K5QgOkQ+jygxINExa?=
 =?us-ascii?Q?ld0gJHivBy9QWtvzgyq90w3rpLFMjfIoAk76fw0Gv4ctcRSDGbCSh/hrs14N?=
 =?us-ascii?Q?3bl0JXJyy5Mxy4fSMSUHkBWklfniRN1PRk9tMcZwR3RBJrWB012hV2x/qL2j?=
 =?us-ascii?Q?Q9apy6U0ctOrufGfpNRbOnioAIQzNs6azipZOxfAbEXdyMUATiucE9DA5q22?=
 =?us-ascii?Q?00dhwLDWXGKb28+hcJawit920s04EB2BSVBr6qUrmNZYIMbW1CmX18MYp5iE?=
 =?us-ascii?Q?T4XD/O+T4FhqDZlSNsbJWlu8807mqNQoCT8rD1jp5DFvwc3OIGMfxLjyk38Y?=
 =?us-ascii?Q?Qll30nN78vJAl1n+0OGkDMYsUxUf0k79K49PMBlLiEkrIh0TQSlb5F3ZT7w5?=
 =?us-ascii?Q?SbSSPNqLruqEyk8otqMJ5tSbv+5IoBKsJ4oszQg3UuudKwnM3/rpQIuWMstE?=
 =?us-ascii?Q?CUmTH3xrDl+qaZERwYJ9FMHodS3yuYl/5NmbHwPuwwvr/T3f70GSDtTaj2BI?=
 =?us-ascii?Q?kbxh6ew/0V+pFQJFvuzRAopTg2kKAwJEWfZnssaDJqwA/OaVnvdxwGhqEIw/?=
 =?us-ascii?Q?gsuKIs7iO7NjTsf99+ltV1GM1ooZ4EzPtg/ajLzxYBiQMJTwJnsaygsgebmd?=
 =?us-ascii?Q?vWKrT+LfogaekECtDrHGtr0TlFZLPb2RSOuzJvO/kPNW55vMkrZK+4s/R5F9?=
 =?us-ascii?Q?AscZv6DP+QyeyvactsPpjxlUIpQ3y19QpEvSDZfloL6YHhcMLj/ef+XOMRuR?=
 =?us-ascii?Q?nOTJbg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0a69e1-fb0c-449b-0965-08d9b3b5eae7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 04:00:16.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIjZFafX8yRmYmzLIVRvohFnZkWRpVWNyMw9+mMDEQMmWZSrPE3Yai2VXou3hn6Bnp1HaHJzga2pfBy9kuadE9F9hreQh6HR83UQ6uXQqko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4662
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300022
X-Proofpoint-ORIG-GUID: kWh9gtMiXXRDQzIhdfv6tDqWP4hqEDLD
X-Proofpoint-GUID: kWh9gtMiXXRDQzIhdfv6tDqWP4hqEDLD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Florian,

> The variable page is set but never used throughout qedi_alloc_bdq()
> therefore remove it.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
