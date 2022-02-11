Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF14B2F90
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353785AbiBKVnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:43:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350658AbiBKVnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:43:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94F4C64;
        Fri, 11 Feb 2022 13:43:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BJdnos011211;
        Fri, 11 Feb 2022 21:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Siu+lxOj+6h9YF+cAoCcc+ZkKCcjok821Qs1i2eVuxY=;
 b=HxeI+AL6nP96nCh6BDv0VpXhXSeG/21fU/ejcAhBaFFK5415k6qhxxgpq1q+cAwkbjlE
 8hzlH6JwytpUfgWrwtHpLz85Ns3X61XNUx165/AZGXB2JDKvO91NwKnLUkSZQuZAHgr2
 68QeELREBLytPfDOf0g2lB/F9GVAd2eDLr7R9HRJPFJ+GvMs+eiSrYKFaU+7PiiJDZf5
 sjFFSwxRmoMP1lS59qWYpT3Hujb1w55KCzGYRx4rNCVfxhKWAi+qfXpTJ6cHWMJTU9aH
 0NLgKr6De6cy/w0FjWt6CISidD9F2SlWCrIppqrQvxmba/eSzVboVgXyAqz9o4dYU8lu aA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5njr1kwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 21:42:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BLUXq4191452;
        Fri, 11 Feb 2022 21:42:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3030.oracle.com with ESMTP id 3e51rw0cae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 21:42:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9S0WeJZZpnpN8u158zSyzJoRQcy2rOO8e+yAQP7iVQ1RtpP4WPY2i37Dd7V131EdKt4sBTPAR0aVv28IIDXmKJJcDc2HgVEyg7bp1MoGhG0NHdHArzWQCQYiVmebUbuxm7fYABvlM0xhwLT+e7B1BlBY7HC0urxCkWjZhPlivLe3czyGGPGrBiWz+s1f+7+pY1HulTx+DX9EHNEKCu2ejPiHUIyKDHKOa+tXLkmlRGxCNqHvmZAlxZBVb2KDSsoEwxHK3NhYa45V1wkbnHKGBYn6quGGnZuiYyaJC4VmrNavmnoAaInoWjYproCH1nsPTOo53oSrWEEhTs2TqDCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Siu+lxOj+6h9YF+cAoCcc+ZkKCcjok821Qs1i2eVuxY=;
 b=FpKSL5u1t1SshsvlzhgHdJ1hrwblak2GYQz+V3ben7s8TDHoQxknZ3QCppyzFUsLaoBtb8xnxFv2U/dL77v+/PBJB726NaMWBfqPDRu1EkB5LvTXBPayG9TBnordPJfMotjA+1F+D4sfuql0u4sXVdXp12QNP+H1l7HgI4yarWDKJXbFQKhtm9PRFL+LHH09Fl2/6awrBK3nkCQZqMjTYNjEAfhD778dKuTzDB6YUz40pBMuOUPrOVVgNKSd06jNW8/3XguQB0xAbgnrPW9ErIdZ2SHueqMqTs3Oh9s4aUzqOc4LMKA1OxuG4/tiib+w+gsQ61ddqCmXJMKmJyKehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Siu+lxOj+6h9YF+cAoCcc+ZkKCcjok821Qs1i2eVuxY=;
 b=gwzuaQQ2u2KIQ5u/oBy8G4PGUNysrwqEt15sZItJuTpJQUFuazak6W0OmKRuEAJlSuhLhTF22r4LHDh5WQpSBFu2pDkQqdbIf+xAhquPtn7lPB2hG5feHs8ZqmUPI7TRnYEwZ1AEASA+PKdfEHEgYZNkWAjUspCWuA2U4I0k7tU=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by CY4PR10MB1542.namprd10.prod.outlook.com (2603:10b6:903:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Fri, 11 Feb
 2022 21:42:56 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::40f6:dc10:6073:2090]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::40f6:dc10:6073:2090%5]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 21:42:56 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Michael Cyr <mikecyr@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: ibmvscsis: Silence -Warray-bounds warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czjtqdv6.fsf@ca-mkp.ca.oracle.com>
References: <20220208061231.3429486-1-keescook@chromium.org>
Date:   Fri, 11 Feb 2022 16:42:53 -0500
In-Reply-To: <20220208061231.3429486-1-keescook@chromium.org> (Kees Cook's
        message of "Mon, 7 Feb 2022 22:12:31 -0800")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:208:15e::36) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9d693fb-c98b-4d5a-e191-08d9eda776d8
X-MS-TrafficTypeDiagnostic: CY4PR10MB1542:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB154282DDE649DC27E6648FE88E309@CY4PR10MB1542.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBlj96ItastPxevjhbtxAAmndYE4hYYqThhJRljeK5TS3iO23Y0PxrY/+lRh/KPOV/XIne6hRcnJgFzh1up9XmvObGKZ6DqSj+KkbmYH0Kd2fdiJKFoiccQM95WnItjsnRX57hyCLUpuwWloGTboe/dSkcnmrkYNfrmcwLMv2If7cAtehs/h2oJ6d5q2cz4WBQE40f3E8BU5uTIk+s1kA7QB6Ui3++88BfwQ2J1Y+IOqk6M+KFjMBKBbmUWXc+1m6w/dR+PWzMXtk0y2WrFxUgKlGXrViJ5gOmLdbaaqtllKUCNd/g9Zo4CbB07uCRxF755idjXM2ltUf4d8nlbSIfRyBIgmSyaWyl/AcpsSu9tISZM/u/sDRVPI4YVT76rGQ0JIXfUySu0JP55/JmrJDXbD/qUKHGf3jDZurr/dnjf93vXYyd9fncUPMkmpjwIhB5mPj64dwkBoajcc5ioZH6xL+fNvi7HBEsMBZNuQDnFkjqJCw5TFEcVPlhG4uB3+daJ14t45AJkpWo4h6e0ya73NnpG5EqJHjbExmr6EwHEIiWzmdHHt7/Mrlkt50YV7idtNkPf6lD6jKizkpFxWejuCPs6cAyq4pDRvXQWKIMQ8Ks0/ORZ3WWMl1/NXh9gFIih1csKJc69BIZBgbQP2iBvriuyW5h3Sjv8TVcZVYOM9VDSHakE0A3vITbwNTrsYZZWWgokprtHr5Yo+RjJo3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(36916002)(38100700002)(6666004)(186003)(6512007)(83380400001)(26005)(4326008)(86362001)(316002)(8676002)(5660300002)(6916009)(558084003)(54906003)(52116002)(6486002)(6506007)(66946007)(2906002)(66556008)(66476007)(38350700002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ogbS4NdShinOFvQ1iGQ6ASecNSu8Ne2hYYHIvuK+492umv/f+XWk+hDbWBKJ?=
 =?us-ascii?Q?DJna0itrbVEvqVOGASqQ6wWuIBsf18cozwjaq61n11RIHzK8Iyz/ySgVSd6G?=
 =?us-ascii?Q?qxVZUI65dFV2s/0gYrfPpr9/zh4BBpcXfl5VgpGkrBs7ZvvukmvG0SuR5R1n?=
 =?us-ascii?Q?+GWjd90+h0n70Eb2Z0nV+SzaK62ExK94j+85XW4R7vV4PpGQekbRaCRxm+pq?=
 =?us-ascii?Q?KKRnf4fAYgvtjL32+UZhS9hSKfkLguAS5SgE+0GGnq8HgK/G0SAgQL/9Lee0?=
 =?us-ascii?Q?JQbFsIzJsPHkX9G+p8ntfTu2+2xEGz2mdZ7fvM4/7x3Xe2a4r3xAnaHH3bnq?=
 =?us-ascii?Q?HsrQ0aGWatLxmgFA8CATQ4Fec+lPxILNpi5LoWR6Ff9f396+efsl56M62z2U?=
 =?us-ascii?Q?CPjd+l1+F0gBjCC1jz3sxUNsc1hWeMMqBjG+jFk9wK+TvuJmIUvfi0SxSj73?=
 =?us-ascii?Q?fqzkmY3jQLOyCraQrtQ6ayjr+IQ+cRBbSQDoXC0VkgQ5PBwe6QTrRR64LJsE?=
 =?us-ascii?Q?q/AsqgPtVicCei4oWhhx5wW3V+bVxuCxQ4dqr6DEVZW2sJIRK5btZrOs/vfK?=
 =?us-ascii?Q?cQ5+b84cQesBS/RZ+xos4OXA6/7FLjQcos9uB/VrgcpYu7ufShxX3V1J/sR0?=
 =?us-ascii?Q?Q4Cki6qrPdEG97fK6C8DpnkZ7kUPtuTBRk71r/pRQO1tcmnuHUGrXp16HSif?=
 =?us-ascii?Q?AY+JwAPTnahfRskKGa9qYM0z2ms/H1LPWvgGoyisLriTaFGrLRLT8lDKd7Ur?=
 =?us-ascii?Q?4cNNrN3BqdEWY0K/o/DYVJQQpqyf0YOV6tdd/Uxs3pZjGO1bHdJatf1kpgxi?=
 =?us-ascii?Q?j0HUW05XYmSfSRoxIJshfVzpURoeDX3tC0DLUnm0vI63VUfSX52kkcMcGB1Y?=
 =?us-ascii?Q?ih5a1kd+QvzjTZ/9SFSB9HbGErcnAB9lg/j3w7+hid5UdcPemuofeHIgF8Ap?=
 =?us-ascii?Q?rPv5LKMBDdQ1ArcoVPypcEx0YTyx/6wPIfU4kxwSBBZdlA6cYj6qfToHMpqV?=
 =?us-ascii?Q?soo6pB4v7lskhSvLjqVXOQv3tnJyvV7IaRBK1OY1NN8paT8omY61dsyR0QPv?=
 =?us-ascii?Q?978JlWaODcNPo1nbEgDpDCm3XeKYkyYXuNv05n/I3inlHlrWuuouhiswOurv?=
 =?us-ascii?Q?qUlwMUNAaBX90KXwt4yzdsoaPiRTtTqc+Ye69Rl1jjSthgyGdvQbdvp65ydE?=
 =?us-ascii?Q?r+wOWxPsECXBP7fQL8kocFtGUvXuPnw/jW1aqqRxm481CAPW3sJoNH64sakA?=
 =?us-ascii?Q?ADIbwN7QOt6mYkTF//7kyw7yO6kqGtcBdsGdWczUgtmnvYQIJeCeBZiiiXKr?=
 =?us-ascii?Q?OypvV0yt0eIsj2gatjjTibF0p7Fb8Ab8udwBd3tUMx0NVqclBxFCQW9ZUoY/?=
 =?us-ascii?Q?Ypt9GrxAJ/VJ6QfmQK7F+zSnVLcWVge06ZzCW0EuxXiyxPAhSQzLgnNOQu2i?=
 =?us-ascii?Q?B5DR/39u9GEvvin37+DqkYZCVmmc/Ksz70dzG0vDWJeS0HPhm3IXzi4j6mjb?=
 =?us-ascii?Q?XhCOgoBZhisXB++OiUqdXbkjZxRFCiueyV/J3SovIiwe+cS6oRPxwfi0rQSb?=
 =?us-ascii?Q?nkYxA3LTrsT8cpauu0lniQOHq6yAI9sx3rt9TQ40y+I+YrSwLUPsELp7E0+k?=
 =?us-ascii?Q?t7SsHne/ZxBW/7w5h7/iyJ6HPUjT+61Pb0vQZKW+LbtR0BrWMQ/n3nReSrIQ?=
 =?us-ascii?Q?ZFs/1w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d693fb-c98b-4d5a-e191-08d9eda776d8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:42:56.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbXt4ImQU9e+DP/d7NenwgdGfRceruc7BvDz3OqvYLp4RBxIfv/I707C186yhoyAF5onBdX3SyBxRyg36qPOM8I8d2SDyuKU4+cnGHCoYYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1542
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10255 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=831 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110108
X-Proofpoint-GUID: -mwCeSNMxUO8bvsWehFzYGOF7VRQD4rx
X-Proofpoint-ORIG-GUID: -mwCeSNMxUO8bvsWehFzYGOF7VRQD4rx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> Instead of doing a cast to storage that is too small, add a union for
> the high 64 bits. Silences the warnings under -Warray-bounds:

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
