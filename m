Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CADB4D9316
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbiCODfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbiCODfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:35:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605181BE88;
        Mon, 14 Mar 2022 20:34:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F35ZQ0003081;
        Tue, 15 Mar 2022 03:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lj1DRxeihzApBzQWSwIHtefSN2JQwvcfOD4rJZE525E=;
 b=KNhy87mZDZ+/lWkPEg0iPRKoiSnyU/ohFau+DfP5ntHZYBMotqy7HDaWmV5tuDFWQQP6
 BcjYjuXZVWowzk7TZ6GYgjRuCG0eKaMBBueBmPXy0mkvKOBCbj5ibz5WxmO7hDlO/BcJ
 C3JNttxIA0xHCeeX5umX2bGnce+t6aF42Q/xtEOsL7Fijsy0b+Qms9G1fBxxlzujsCW3
 e6n7DTv5nmwQcfBdgoqWwcpmP1eMySX1s5MRopj0ef3GOwEGzTgShuAVpL6bkRDvd+vP
 IAtL87ftvCF/vv6t7JDbhstTa/PpbGSWu2FV+VIfHNyZpwI3wY8YAwKfJ+fNa9aBW+4O RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu20v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 03:34:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F3W2Al164376;
        Tue, 15 Mar 2022 03:34:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3030.oracle.com with ESMTP id 3et64tbxc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 03:34:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKSnoDkJVIPqQfiPzsTimT22PeBrWTS1Pp9x6uH83PWP9aqhIkfF8isEW/EY2Yji4pOmTh8UjEBUKpyqBht6yWJY6lOjGOsaNgOcuKXclvhrFGsHyBw47D3O0st6NRtY0jghfgvVDyXsz47bIyCQ07nbWJWI5UQc3Pzmu84g/9RxCV1BTXY0/2AVQaX4yQ/NNnln2tGso1lVsQgJcY5/Yu909Np0qivJNEjj0qvbYu5bpOc6JIoAydGk2UG0ZiZWpq51omxXH7eh8pW5cpU4drOzzn/x3fcbps6VtJsN9wyeG0jRSooW8M5aakinkwz9U7ob+zCxANvAonSiRTEOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj1DRxeihzApBzQWSwIHtefSN2JQwvcfOD4rJZE525E=;
 b=DMe5QwswLUXD02r3VsguUklWWI79WdcQ3NGK9/T0V8yiyu06/g76HjIgUDYEsuTC7aFI8+9mkhv3R2mAM0S5bOC2YnF1Lhz5FapdeagoafRcITRzI2tkazKrVK1wcuCeAMLIKt64tS4DKk2Haq5Ney05xoItX5idc6wfh3rclZULrnS4QmNd7iBSnU2GDuKs2+43Q00us4KeYzwfprTyXM6bITDOgELZPHEBf9r6aKuXmabsoTbPYwYSPxcZKFyd6lfaUsm7WyR7D0iRp+mWoSB9wecLLKbKdj05t09afOY+ejDBTJUlmVAPqYbFzXFgm2kGf3zStT1JZ/fAbt7Taw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj1DRxeihzApBzQWSwIHtefSN2JQwvcfOD4rJZE525E=;
 b=j+0E2nAlLm9LOJeRnRknIKp+2TwaW/ZPlyQ4M6BeNrrZrp0seeB3XCnPl98OuM4nebfCG+fWl2Zivhh7CXJ0hsFU2P34M8zF1WlJ0OtwWhyeBMp672csCkpCwZZ/RD/G/jzRBm/GSOdgHp8ir4zr4ce05eMqSemNkZmDGpNoqpY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB3739.namprd10.prod.outlook.com (2603:10b6:5:159::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 03:34:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 03:34:01 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ajish.Koshy@microchip.com>, <linuxarm@huawei.com>,
        <Viswas.G@microchip.com>, <hch@lst.de>, <liuqi115@huawei.com>,
        <chenxiang66@hisilicon.com>
Subject: Re: [PATCH v2 0/4] scsi: libsas and users: Factor out internal
 abort code
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y21bdh44.fsf@ca-mkp.ca.oracle.com>
References: <1647001432-239276-1-git-send-email-john.garry@huawei.com>
Date:   Mon, 14 Mar 2022 23:33:59 -0400
In-Reply-To: <1647001432-239276-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Fri, 11 Mar 2022 20:23:48 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DM5PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:3:ac::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a84d6ecb-9cd1-4c54-b2fe-08da0634a5ca
X-MS-TrafficTypeDiagnostic: DM6PR10MB3739:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3739A682479DD7BEC5DB134F8E109@DM6PR10MB3739.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqgWtQ+X9OklY2SIXglPsE6RyxIjB4r2XE2u29/H/5CyG6tGwt3Z3DfVcSls8ql6e/vbIcJm085HAqA2/FOZmKgRc7xHI1li6g+gBH/8i8V5XOr33JUGCVITbkFkwKqEKPH16dac+5/eJ67vwXCTlkPgtThIfCdmv2qMyfWXxT17HHAC7yv8pe+GR2aIZgff7uipBluNvcUdVaFFsv05H2AbkbQNgYQxJL3N8LM3r6qiUpR73npgSsmI0F9EGZfOzGjIf1yqpklnSeNHhMDMM+N2heKbNjntO/cNgnfb/ZNFJE0t0uynAe4H3+9JrHeql/TFL9yTyWNiafaX3cqV39aS8KBTGNl3Hi+CzsUODpzZq9dIGHB3dACEflfdhXkX6bhc6qBs5GZZ0/RRbjINqgE5A9chlRxFrEreQkKXq+SbohiY6kgh7bzeiLOkb5LhVBE0t7UwqEYzY+JSD7cMGHMdzwE+zCqFxDAlJohpj9jfr6aN+mLP1+/qV/ToNpRwWOiIgaQ3DR2fCYrfr8wyRZ/qv7d0RhLa+RHbzHuK0+WTCWET+8luDaTxkj55ITb3gEg1hQx264e8rk0cKyrWlE12nVabF5O0ba92RbKo7f13jh0oxLo9kfYhBUccJj1UMVPLlcgE6pxogt3mlTpeh2owSmk2s6oTWGIB1FGlPsD5+Ke9gkw5u3NrZYMePCG2y/HN4F2XFc8R1Fft1tLmMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66556008)(38100700002)(38350700002)(36916002)(52116002)(186003)(86362001)(6512007)(6506007)(26005)(66946007)(508600001)(6916009)(54906003)(316002)(2906002)(66476007)(4744005)(8936002)(6486002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UxSVGrY6S4M0/0Nm9/NSGtSFN6bn5EzAnYUvYvMYBG0WLhCMlzlJ2WwQE7VK?=
 =?us-ascii?Q?MTLJ4mKQABRO2VfTyMQECniaOKwn18V5va+G5I4hm/virSK16PtqwiwlnPkd?=
 =?us-ascii?Q?sjjGSzBbPBIa4+GRGAZYEt4651+/FPTdlj0smI1WFD/Bb9v966hYdF7WEbS8?=
 =?us-ascii?Q?YM2UgUg0fRstX+h4utOE8/3arE1LRyA1HzUbvxZ3W7Em8C2gtCX2QXSsYn+f?=
 =?us-ascii?Q?LoZ47loupfFkFfLWPhysMxLGPCk/gPoMW2Ac7IFEDpEOe5v0G5siyJinhbbl?=
 =?us-ascii?Q?ELE3OSbuI5A7NMSKoHWEQoj3h/cCZNdRsUshqIgYr7JTiS7dZ3pVrRiMHpgT?=
 =?us-ascii?Q?o6+wgu5y4zL2Xm7SG5F7gykKy+NM5hmH/y19Zfs67aPXc7gR7JD9yAclhVVz?=
 =?us-ascii?Q?6C69YnjB20ihKVYyP+xrkJR05jQ3ezuGERvc5WgpGpPlMZ5ToVVBv5w3+rhv?=
 =?us-ascii?Q?Biozdg0WEEs6peNVm0605pmjBoQ+aw7hcPLIkLsmIGidqZPskoCp2XlyQZMg?=
 =?us-ascii?Q?p7KzRMM+zXNdZMY+GW2sOlDvD23HXlOeAWd5tneELjEtQXI/SzS0Ot8Bep0k?=
 =?us-ascii?Q?lObnQmI/Lz0PQeDBlY4wS/L5EMvpYLaCkaGy6I1f/n7KkkknAErmtlURrPqE?=
 =?us-ascii?Q?Hp0s/C4pzLcHx2/CYpzdy+TYl651qYm8onDCxu9JKFocGnKhVdfpa0EAEDHX?=
 =?us-ascii?Q?wytwOCaXg+m0wGmvk9V1XJ1qxWGGXxYntHcyXnq4sKcoo6BiNnt/i/4Vw00V?=
 =?us-ascii?Q?i+N0jy7hPiz7F1U88z17X9zTVUxNnrVhfBsL9MA1b2LYlEKp76XN+QOw3rMn?=
 =?us-ascii?Q?ImloVHQWrbziSAUaDKfQJcYuPEOQVGvd+0xIO0MAA+OgSDCGekJvS8FR27Ll?=
 =?us-ascii?Q?+BHgysQOlpMALWCdJEY4pL22GFM1bjGowLwDO7cozrXVv2F51H7BdvaoRWSH?=
 =?us-ascii?Q?Q+fDI6V/6F0VzgtUrt6ZVZST9lPpzaojvUGWZ2QWUe6qZSxI5jTpKpWnt/7W?=
 =?us-ascii?Q?h110ZETt+KTvy4sH2vYK6JH/br7NMgDlo5PXXIgGuq2eli89QCZnMeEdRwAe?=
 =?us-ascii?Q?+VPhfZWnQWKq9GAjinVWOlXKhsX2IcniFMupa0NQBqd3wh1QA4u0pLmkXqk1?=
 =?us-ascii?Q?aSDHKRDi2rMuOMJp0DfoXk/Y5oVLlQr3JvYssCEUZUoM6gYr3tqWHzP3rg1/?=
 =?us-ascii?Q?Av8/De9R5ZlxOM9jYRF8CEU4ef9h7KQscfpF8JLhayzKeArs9ZN5uG8oB7X6?=
 =?us-ascii?Q?iS1X0W/Ff5NEe65wOGh39ofcgPMGQ93bxaPvEHk3SS8kBInAhDC3e8YNbpcN?=
 =?us-ascii?Q?2HfibVs3x0t/ixRfhHvUjssmQM2oCFSI6FyCF0+1XFOVsUbkV2u0YeJnepas?=
 =?us-ascii?Q?JlNmd0q2vm3JB8Bnd+IFTQvZYu5wHG65j1qJ6f3qsiBi72yDpEozFjU3UktX?=
 =?us-ascii?Q?znZc0hdrWrEU/WeAU0aUZy1k/XahkRgH7iBfgEuCyXsu88zKRzWU6g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84d6ecb-9cd1-4c54-b2fe-08da0634a5ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 03:34:01.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ND1bRyFcBQaCj3gYAOGyk1kCcIirhO1tSn6mzCAhhl7du0t0QcgtKspodlDqCyHB0yuK2ssT2xgJ0s1TtNgY06Iljwe38Ti47kuTdWnFho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3739
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=761
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203150020
X-Proofpoint-GUID: Roeo2sJLITzw1Vt62JaVxSy2igT2h5Qq
X-Proofpoint-ORIG-GUID: Roeo2sJLITzw1Vt62JaVxSy2igT2h5Qq
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

> This is a follow-on from the series to factor out the TMF code shared
> between libsas LLDDs.
>
> The hisi_sas and pm8001 have an internal abort feature to abort
> pending commands in the host controller, prior to being sent to the
> target. The driver support implementation is naturally quite similar,
> so factor it out.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
