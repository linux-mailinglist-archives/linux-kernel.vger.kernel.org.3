Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C0C4EB8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbiC3DqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242337AbiC3DqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:46:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892081CB08;
        Tue, 29 Mar 2022 20:44:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U35sKB016587;
        Wed, 30 Mar 2022 03:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=R4QaUTN3R5QNyAl72Oo10MSPoLRuzxRDFceWjE2CsXc=;
 b=JhEJYKlTsdNWoYnJastvoKOtlkP+/4dYfEJqTzhxe6sJ8/C2fjCN9Tj0MZrFwF8kyaku
 zOiFlg4Gqpma8q7ofs9tI/BNis4f/ElsMJhMvED7lUJedryEl8v7ArMwaKt6uA1d+d6f
 T4vamlPdvmzCUV0P7MBksmRkpS9jDYWLkb6nJ03f/hAFql2fg6UZWNIf+kSTEeZxYQVh
 xUNBNv1oh69o0c2J8EFGQRC79FENPfi1uPDXiAbArOsjlcu3x/pn5ax+D1xK6p7uIhxs
 ZZ3/lXvry//cyNnpITi4kraj+CI9usqAhiK5SIZ1Dq39N4VQH4MM+noYsz/oMtBOE2JD 6g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctrd98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:43:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U3hvj8189941;
        Wed, 30 Mar 2022 03:43:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3f1qxqgfvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dizKvKGiQuYTn6J4/4WYxSvpxIb3P3Gi8tBqvS3CLFgo3SQG9QnRHSfUxYHSr8fFhpH1lWmB2S5pBsD4qezjN3hQ5zM+Gz+j5FAsMr7qTnZUI5/XVema8HxpiFFUBoY6G0QVXE0qdYXtsBtOFhaFazt1Z0F5PWlI5deyKRyr2PYRt8iMZ9uGZmqpLQw190/uTsV5nKhrLLbfoIRyyKXT7J3NOeWSmr8QcYw1N86b7hB/diPj+ejA7g+qeVsqgEj377ULruulC12cETUelMukyiB/KcL9br2O6tNiMFwYcO8ZPwKfEuwNVoK0thoMEau5gPULS66QmFqYIESipdag6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4QaUTN3R5QNyAl72Oo10MSPoLRuzxRDFceWjE2CsXc=;
 b=jwa+TnpYKzDYp44ce1+k+Actn03nBUsxknQqTqXITkrJ7HDRD5qU2KSznEGrLTo7Ouk+uRWtLieWYoV/ZQAFVw9IDFOVueXaUvpUUcSXvACfBYKWskPv7dLYtqX+NvkjbUD8juIb4M7drUTeI+h/lciCbHsmqudCrAur7j40KxC1aJp2hVE57xWId9Tk2xeBlwh3R3xTcidVp0F9cMxGNVFLaxf4mhoWjR6OwMTToQZYLfBQcvBveTst4nlYCcyIyKFPg1GF3dDea491dOgFJw109aXt4k0CD+3ocpuwJN7yj23BXY6mPT4bPysFUiBuqnvCnMRNuxAuJ6QY1wRpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4QaUTN3R5QNyAl72Oo10MSPoLRuzxRDFceWjE2CsXc=;
 b=Fd4z6CdclrMnYB+4oBtndlduIDgCumjqp7eA2E6cCwUsHdnVCgqvNMwni5SufIXzg7exKI3LSHMcIK0juXBE+rqWdHADZAyg8YmqbUKzZfJE/mNSWgaGvY+8mdYtyblnL70iB+lyv0RkdL1GVJDLfpU1N3bfcDlzeH8hZVd7iEI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB3691.namprd10.prod.outlook.com (2603:10b6:5:157::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Wed, 30 Mar
 2022 03:43:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 03:43:54 +0000
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     "Juergen E. Fischer" <fischer@norbit.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aha152x: Stop using struct scsi_pointer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k0ccumtu.fsf@ca-mkp.ca.oracle.com>
References: <bdc1264b6dd331150bffb737958cab8c9c068fa1.1648070977.git.fthain@linux-m68k.org>
Date:   Tue, 29 Mar 2022 23:43:51 -0400
In-Reply-To: <bdc1264b6dd331150bffb737958cab8c9c068fa1.1648070977.git.fthain@linux-m68k.org>
        (Finn Thain's message of "Thu, 24 Mar 2022 08:29:37 +1100")
Content-Type: text/plain
X-ClientProxiedBy: DM3PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:0:54::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23ad9862-434d-4b4d-46de-08da11ff834a
X-MS-TrafficTypeDiagnostic: DM6PR10MB3691:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB369179268C930DF04554514D8E1F9@DM6PR10MB3691.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vFQJOxiVd9U/XXEbrDkVJLCPV8reBoBlkjqA+FyLBGuOudA8SL6U6clXXZ5wpUe1rr0l8rxgAiFZgwbN7akLJqwOXru1ld0zvw7+Vm2L0DR0jdyN0ibmfBavUoKdMm6txMQj97V3ltQcYB9BSJjdo4dudd87P6oy4FTa3kdMT2htzmJPBmCRqz9Yn1z+TFDjD08Fd19KyiU110cJUgA1GsPjE48ZrWpxhRe9KK37d6C49ZdIkJ8OQWB/tguvWpvxvbq+v37wZfOzjVo2xBaOD+/LNhCw9rDGw5iMHnkjjWYQHg6T60IViECPsq9c4qZK4Hfbb4/nVKSvw9W9ot8SzgduGP9b6DAnnZO4Bm2+5u2MRAmCltM2dMVe6cqMzVR7inywCEo2iZT2p7XeQWvFa9rf3KWSFzpvifVGzFGfrFUIOUl3PPXG1CKHmqyv2FOesEeEXSSKETedaiMu2W2K5eZiM4Ij6ZwKx4aizxQcsRD6GzPs+NEQMu6iz7oR4sWJMWEQ6OlvCd4gDkVE6jawAmjI9YmSUCdbBwlb1fX1/FX5XZCNnZ5ddigkwxYy+lAfH/+LeXU9quOu5QpMkYr9oFPVGPmjf0VEgg5f7gXZg44B9KTBFJCkVSlK0349IuLj/b+4ScJldGGSs0YFvp3NerK8/1TDxD27YfjNRgI2FICF0xc+4VEF9JdvXrdSQ/00ueLMBeXYkQgtmiiFGW9Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(508600001)(186003)(6486002)(26005)(52116002)(6506007)(6666004)(6512007)(558084003)(2906002)(86362001)(36916002)(66946007)(316002)(5660300002)(8676002)(4326008)(38350700002)(54906003)(38100700002)(66556008)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mBzBDXwWwP9fCNeJ3V348Pfhx3sBJtJkoW6XvMM+BnCNdHOQbcCHnhZTkBhJ?=
 =?us-ascii?Q?JuoZZJWJ0mXAhI63qiQuRijSFudy5LbdSKheqlNLfuJ+DygGTq1wACx+XvSm?=
 =?us-ascii?Q?GZRHeZXs6UUbJpOogC27wF9vznzQgIzXVLQnuyGw11DvQioFu6OkU5IEy6VV?=
 =?us-ascii?Q?1dtNOYlfDw6m1Zh22h19d7lJLTk4XHdD/jO/uCwsFYihoaHHD19GVqofBGIV?=
 =?us-ascii?Q?ajnf5OPalCnuenGWwp8k2OZ81E2NOKOpR8dslBKPc1EXwD1nmrcVHc6UMsgA?=
 =?us-ascii?Q?/ultqx8pqfKg1vgl4KR8NjLbzkaKeLjRr9eMVPOB4ylzl1NJ1eKyGEBg3wXY?=
 =?us-ascii?Q?UWVrLAN+JYTSM1rPLMPXlzIW/KTHzW85oXM1dxNBwvR7l2AqbxEGdFgzyRqw?=
 =?us-ascii?Q?PbRe2ge0u/ryqLottPlsX+C+7bfAFquX4a4ksJlzniE90NcNuuhuVXgUB8A2?=
 =?us-ascii?Q?kh+cMjtrBLZnSlhizGwNP0ISUFTnZtU8m00MqcwIbajpeB9orW/DZbVVxyTq?=
 =?us-ascii?Q?CWrUPI2/DpC1RQbWlB81bQ51AIakLp2hbPCsYWjCYydXDpj6twMh05+s15io?=
 =?us-ascii?Q?u6YIB4P8AwQKFeBYdJLDzCj8P7PWQndzGFoPfzusnczoNH0Q/ODsWl2hwFu6?=
 =?us-ascii?Q?5i3Pobs6v6iL3Z8VfzlhD7EoZPNgPTG7l1r+Osv/79wNB9fZgibp/PDASC6+?=
 =?us-ascii?Q?TxKrkMtY39wg+FPualbba+oq5yu7Crr/LGvBCboJfcWfS2821vQypIu9iYiO?=
 =?us-ascii?Q?gXuxcDI7I9ruvHl+TWmzS2NxhesxDEFt6f3877VkOUt2AvSMNDFm6kwxdFvf?=
 =?us-ascii?Q?qVxqDT1TiP03PsTjOBvbHO7Yv4ZZFwm3AGuFRjogJJGT9SVmQtnYDfVkWYLj?=
 =?us-ascii?Q?K9caF8sRFIdp5TBLHISlBBnNdUylh8lH4ZRwty0HQ4CviWsk5vIxLtD0nEQj?=
 =?us-ascii?Q?A/j5WZpeKs0zdKd9y6ReS/ISBKEFjcYXQlVIybiVCRFVQlYmKK8FYpK9k7B9?=
 =?us-ascii?Q?vTVgyhIB2y93orDVJDwiVNjikzG7bnCF0+w3XkatjFQ0gsBH/w8HJYH6Xblb?=
 =?us-ascii?Q?Pu+TrrJmObx/uudBOaO6e0RoPZoGTVZUf9QjZGEAEFlyT/SbTracxeViX4sZ?=
 =?us-ascii?Q?v5YAwNMmKMrSoGEs9TbA43nGzZMNXK00W/jBUiBxzPdyU7Q9UsIEoBvuPAWQ?=
 =?us-ascii?Q?NBFSe+huv9I+7NNT+NuiiSciPgBwnM96A6+ITV8/ipMPbnuyWYtCaIjkVA7c?=
 =?us-ascii?Q?x4qm14hkGFSc25VF1NVsG7yv26yDUDRkIbVkTVhqVCIupc+wJpbhLwtMUcQA?=
 =?us-ascii?Q?yHQ7lbEXbS85rAdaqR7y3QavrMLJeM3dMkUhZFbUeV2+cxvseYMyNJLjc0TO?=
 =?us-ascii?Q?UzS3/SfNFe/UIPjy0cNzARkzKu6Xno7hyB8xEEiT6S9f3NpZz5Mf2jEvxm+3?=
 =?us-ascii?Q?IjBFhYlLVO8qHhDyuEsWrns2Hmwn+4CMo/r677OH51lyYW9qiFeIjBPy27JO?=
 =?us-ascii?Q?ankY/k/VaM/eR2IxJnIF9XPd5P8fvlwPPGrrRuDEz98kz5/FqKVQR5gmmW6J?=
 =?us-ascii?Q?Havk6JMsalmUIQLcjh/PuoEY2S5AXOZV4tVBzCzspQNPxx18QGzOLWbeWggo?=
 =?us-ascii?Q?9ta4IwjOqNDGhD9JSPgIEqzeGKWS0tdR4JAXQkxGQJQh1bXF0ZBSFrRzA6rc?=
 =?us-ascii?Q?DfmIuKFpC8yK6cSmOG9LpISVhSO7oNd04S1o30teRPA4/AdQyGViHCuNbwPK?=
 =?us-ascii?Q?QcsOygwPholVmjQeyfrVKMUOGLDOt+4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ad9862-434d-4b4d-46de-08da11ff834a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 03:43:54.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0kho2bXOmQ1vqy/DskR3nV6TkUIJhOpYwACv4KHRf7Aq1H4mcGO/AUYsiqxYxegon+dfhBc9Z6hZ6FOAXnrqJEh3MsAakleDzFpjTV4/2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3691
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=774 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300015
X-Proofpoint-ORIG-GUID: B93fBJKw2SNlYI3ufctJuWCvHUH29JW9
X-Proofpoint-GUID: B93fBJKw2SNlYI3ufctJuWCvHUH29JW9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finn,

> Remove aha152x_cmd_priv.scsi_pointer by moving the necessary members
> into aha152x_cmd_priv proper.
>
> Tested with an Adaptec SlimSCSI APA-1460A card.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
