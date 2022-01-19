Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAEA4933CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351427AbiASDxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:53:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42856 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351413AbiASDxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:53:12 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INxSr7000680;
        Wed, 19 Jan 2022 03:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=IZmxJg06ZhoufQp/4GzGF6s+bX5hXWUqRlQyrJaXWH5SNOekA3vhbqPae2ftpUWBmmSW
 VvigUNlrOX1oQBSM97g+6WzESrHL7GwUONvqSqmNBcRE1mC3I4Sr9W00C7pf0I92yxWU
 a3hhyoCObgdVscK5CIp6mbwu0zLoZTI/66XA7+qItG60iug1ALjTQnbokgxpX5vjJjOc
 d3GMNQu0LgnzV2GQy3V0ZXVYZlAaQICy8vjR+nJS9d1bSRt2w4dI247VlmM40REVsqMw
 d1TUcE5guyZNBi9wnwFGQgOGEkayvD4BUKtyS2GGV8DLm8o/eYk23QRmatmF4JLUFiIS BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4vkvjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:53:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J3kP1Z116857;
        Wed, 19 Jan 2022 03:53:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 3dkp358va0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbZJvGMlKUqW7K9uO/YCozTA3FQV/sfU5FAHxkLTv1SQlvZ0xyPiJLP47CHVHygITXhLixLOKvaR8S7QqNUE1dSPhG929gOZiesifgm8QUPds0QgDtDL8+lagjqBAHFQfJ1gNnXppkQv4i52bIOujXGKo++UhaeMd/mF9IW9PDWX093rFnIiBkGrHvbCgOhXiDGyRIZc7OBKV1z3niZ2i+/J2yfmHSdoGxFvg5dvn0+TxpY4t3lXl1L7sIKHQ6JfgyuuQvkcnCo1+qFSyu8av0IEsQqE/f002vQ4IbJjbc6llaKU6fLCUEmRtiP5HaRQVUEQqvBFFiLAFpfVQAOktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=cs3WlXRg7UIb35dlTFBxn3WiQwvDa+tvEQcHa9h7O9tZzCfCUp8qMlh32ZTRkL0EMfUZm9zuDtNcN6TWqggGI2cQRsqNwLDawmk21lWlhSg5uA3Sd6DJx3mWprHAHU5bJM2wtnqV214gqXbxrjsBKm6ixT0rAR1LrobdqXNpdOGY0m4lawOuDKGLi6sD65otemkS58AQirsn1490kfn+J45RvGG6LbJz2WGiKqTLHIbRyfi+5aPBrezceEe2DXqORdJOKJ959PrCx3yLw82cHfT7bWi1Y/IRPovSVrCev8IeOtzvwgO18qyF1xM2W/fFJP2PQFTwJ71PVRsvmPkL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=iY1nJzCaKy7Zca6vD34MnQER0Z1dB/hldoFXnnHWTvt0OrSFhcfgxQNejKpwtN9wjsAi528LwpV5qC//9HSZQNQu9vky4J7Mcv9Z4k1KMt7i7GlEco+UfUpnvfybYW5A17na1eEP0qIeFC2fiRqSLWzzsNQq+rGk9YLw5GIBeAE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB3979.namprd10.prod.outlook.com (2603:10b6:5:1f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 19 Jan
 2022 03:53:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 03:53:07 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-sas: Remove useless DMA-32 fallback configuration
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k0ewl6ue.fsf@ca-mkp.ca.oracle.com>
References: <dbbe8671ca760972d80f8d35f3170b4609bee368.1642236763.git.christophe.jaillet@wanadoo.fr>
Date:   Tue, 18 Jan 2022 22:53:04 -0500
In-Reply-To: <dbbe8671ca760972d80f8d35f3170b4609bee368.1642236763.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sat, 15 Jan 2022 09:53:03 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d88ca82-3959-4c14-3c49-08d9daff33b9
X-MS-TrafficTypeDiagnostic: DM6PR10MB3979:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB39793A2A7DBDCEA21D3800E58E599@DM6PR10MB3979.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiSYDVC5cj2/GVuNTyl3jmjiOgpErR9B7M3jTZqIG/gM8/WcTll+AmzF5nceSzA8/u2a8iP2dkkVlSNAZPiS9aItG2qi12YQtcplDqdC9Cr/MareywaUZVJQ32EqkmAU9zToPj34NDcSs1li4FJBw8V/cqVzmJnFgbTW+5bPisFryXGe6ycZ3LwovJRxeHq0CV3K5ywGYn6JFo4QGm+I4O8QGfz3rFtQux7+9bSzrdGSKGGmmSGWhpxuYO0T4zVSZq2ZEkWmRHSb5r3ZxjCQT9J1mhYXyqNowMXkOh5Z7J+zSVqtdo+OEjpUbQiD8UNztbjUxz7rC4f0ePEH2LVWYNzrZQCL4LFgPr9vEPTHM0QOCP7RWs0cVz89aFdahtk8usB2r8F3aCqhYzkJucHdOoLN5FJw3yh8JyzZBqIm1ZT/CNBfFBddok2dHm5caUEQURS5ujODaT4SqsymIhXNz2OtGdpxKSoq6RaGO6IbKuw23bMo0GuRLevjPSPNKV8PAoAW0OCDnmNKFPrITx2E750fWyO/RIbYavHVTz3bYMhiL6WHiSmElmrY6nR7b7LXM/WnpZzl1kqm5XD9L7Ej++Di4C0bwXI2edfomSnDDJxcNpIdZq75QrdrthcbnLwYdLzoPAbLiFlppvSHXbcrOEZ72jNmtBki0YOrYih3mspbCvXAwPbcjsRMjVHdDgPoUA60Ys9XzFaH2TDEwIPN0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(6486002)(2906002)(38100700002)(38350700002)(66946007)(66476007)(8676002)(26005)(36916002)(52116002)(6512007)(6506007)(508600001)(5660300002)(186003)(86362001)(558084003)(66556008)(316002)(4326008)(8936002)(6666004)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J8Srzy/tXOPW673fTHpX68EqcCo3d6bveefME605/eFhoo55Vz46uHuG5twz?=
 =?us-ascii?Q?6DUKe8m0DzvsuH4bEDKR+9t1bJRLjgssGPbduMUK0zqD8+zGwIWWL1kBGIdZ?=
 =?us-ascii?Q?Q0OWbGdI3qYUd/g9VaDNVhFFSKrVoMw43Vql+uR43OhDfdF7t2WflWKuss00?=
 =?us-ascii?Q?sJ2FhHEbGMa1py7jHsaN0TsudOTiHZag/kcidlOL+mF9LfDowjAZ/Wqawq7F?=
 =?us-ascii?Q?zCpzFapphTdgiodUwyqQaVVOvmIiFq4u+RysGhzYZzHNrlh7XwRz6caeapoD?=
 =?us-ascii?Q?vOacKNDQ7ABJZVNzUIllGjWWVQBnadreCZRnnhTtF0jExlBfqMFuf4O56Uzy?=
 =?us-ascii?Q?zq3nhMbMvHuPESvR2arKQfEalDGukr4OtQJ5MH3Xp+1IoDijulMTlySFnmFs?=
 =?us-ascii?Q?dQ4SErg6+0h4RpKeL0AtO3dot+KS6Yr305JxM6pfuvcYdbNBIfjUso3xNm9k?=
 =?us-ascii?Q?wivP0P+O0eLPlzqoea20j0LvsF75JbAMlgGieM3cNjS6MDRJX26SgFlySXLb?=
 =?us-ascii?Q?2unOxR1g4Y+TlA9kSzVCLDHsr6wLjfxvFTrvqcdMWl74AIBHPRZQW+nMMnAx?=
 =?us-ascii?Q?bNM9N2/DvxIgt1JlhPVkJF4iBlp75jZWLGaoIb6i4iMHpXeQbeXCBVaY+iR2?=
 =?us-ascii?Q?2LhOsj0aSInsg0Yvg05JG6K5xcTKmD/oslSn7dewGRWIAHewuoYiZMTzvFug?=
 =?us-ascii?Q?kZnA18IERp9r16qy+GAIHCYjWZ49rgl/oiPlKaP/4QdmshCNQTOSE1rBaiHC?=
 =?us-ascii?Q?gYvfhQ6GAELI+i7DVuB9LmYk8hSDPBYZ3JKzoyavyBemHolEQsS2X164ypO8?=
 =?us-ascii?Q?I/y1CoqIj9Hk1jR15Pu4OiF/qf7Bp5fhsp/QA33Mv6Uz7Fk17kFhbY/5NgJ4?=
 =?us-ascii?Q?N9jQDchmktxPd8yKHWP3cjVQVhEz7Cki4dazJ3AgPJVxN6JyG7JRSRs2IAYR?=
 =?us-ascii?Q?PWGAdpmFRjfbx7KL6GhZZaZYGf7Je5sy8hNH+eey5e6NUIpzoW1HzRLuZM3c?=
 =?us-ascii?Q?J5+nikOPvkwH30e/uXPJivXsJC/zV+KReUDFvotXB9CYpNzjVo0UWIIgg5F/?=
 =?us-ascii?Q?i8KLHAQqWg4OUvuOJHSUkehmyUp0sxbcYFIAuCn8spS589Hg5uvh3VBzZD6B?=
 =?us-ascii?Q?yTw2mQLeoMX7BEJQlzAN3F9Y45jlPjlfGSeBJ6uCloSeku0FZHXCwMiqM1N3?=
 =?us-ascii?Q?g3arEltvdeYpH5xB2n1NntvaWFMFIiJCoukNv3noW/shmbeBrvl3pDpn7cyi?=
 =?us-ascii?Q?JIToaV492ZcSgKShiPTtAGkELdCvPuLexwlqa8usBT/f+WU5AS+p7/HUdUu/?=
 =?us-ascii?Q?hx5wMOodJVTopb4qk3vADF8eoVQtLeh06EOMGcBtZlKu0AYy7LtHYLGj92cb?=
 =?us-ascii?Q?67skmmdTziQe4yfxHC1WxGYYKDMN5wV86TJS132QH+8SeZbL+yg14qybzW3j?=
 =?us-ascii?Q?eIsz8lPAOvuzAqrh2EMj8Ccy1Oai9ct6P6SKz0TD+kTw4DxXBkKzmk3bvkk7?=
 =?us-ascii?Q?lkR4EPO2+QomOnA2n09CxSu92Q5d/eIwtrrxuOXAICSM+UQ496L/sNIUjGbG?=
 =?us-ascii?Q?uniIlSuIIAkWS6BlH8NqJS9aQS4KxYUh6b2UzVeAMc9+oAQspYg5C/K3nVRS?=
 =?us-ascii?Q?7iD5BxioRO0jkgfYVJrfUNfWKfsP7JHrJOmaiNI45wn9KktlIq7yL1C1wFpI?=
 =?us-ascii?Q?YU/TzA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d88ca82-3959-4c14-3c49-08d9daff33b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 03:53:07.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkQerUDvHD8/sxdb76BkRM8gS4vFeEIILrajpVl4XSPpKDGbYtRQgnD33V8WiJjW5EnYGjfqlAFHjr2JiW40L7iRfVS5h1IafUBj9whgLsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3979
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=975 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190017
X-Proofpoint-GUID: WQ0CoYkKPiCt7O01NiDsQzXGEwsO8gdu
X-Proofpoint-ORIG-GUID: WQ0CoYkKPiCt7O01NiDsQzXGEwsO8gdu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.  So, if it fails, the 32 bits case will
> also fail for the same reason.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
