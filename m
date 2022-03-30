Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5115B4EB90A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbiC3DtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242412AbiC3Dsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:48:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0464D9FE;
        Tue, 29 Mar 2022 20:47:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U3535w011976;
        Wed, 30 Mar 2022 03:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lz6qb2KPQizfyotNyuinMp/Oe334E/PCNVH62GI8Qqw=;
 b=ODG6vHUcNBf9NelZINT8lGct6e8ZBkD9/Gm3deUUO057hMSgTUsyohgPb4LPWJcsq7iq
 m5ipY8hOCZBGaxwwtLyqLX/aEdKc2OVHR1HSq6FBLeGnAWFi9AIcmJ9d9t6sGyGpVDUA
 /QGDEHJPmzpXI8CCaH3VReDdfPBcAufgjvPvgjJjaqPJj9ymqSgHN6FRRzx/rf5Raopp
 6CqNKdfCr6NEUNHbXJPs5CLnB3zuo7azzYZkVY0NwRIZySpIYKBNz75e1HoCnSXGMqKa
 q6CdYcXmRZKfQLIkIGOWV0/tce8mp2RKfproSfxrk8MtMvEOrExYaPPKTH0mXS7d+y8g lQ== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2gave-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:47:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U3l2ws151569;
        Wed, 30 Mar 2022 03:47:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3030.oracle.com with ESMTP id 3f1rv8e903-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:47:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZsNdgJ9l8CAgc1kZiIl6SXeyQz1WztBmm5a+xAbxB9Kzu3nGg37pAvVglGpGgJDO00Z8EXE8+Tr2ZQ5DFh5Z6X9W3/eOcUQLw2Eobyrv3TRRqFnJg+dEMeD4tDlTOF38QTQNFaFkourSvdytrXFCNVgGaV0/CfO1tu/WwrqZUqamZGuz+21XUTn26tSHyq0jbYuYeTKE6aN86gb34Je6S3oIfUt02vP8XE46sW6pApVflE875UsEzO3Tg2rnFbuSblCj5rhppaXW6rguc5SDXtYVt+xSUHSZJZQLUWQw8NRnsOadjPyVio2uRclQGm9UMRpWb2nUrhTMkcb+XgG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz6qb2KPQizfyotNyuinMp/Oe334E/PCNVH62GI8Qqw=;
 b=obbToyyqrOU69svWWn75v2sdqpA0KYgcSrHA7HsO2Dgyrrdk/0eOEJiXlttQl217GzXWiLX3+KFv07uMh3PDAD6hEQEbvEJ5Vd/jCmDzFEpEVJn3trLW4arAO7NC7DoWJsf1RpOnF2nnCTJGrg0pCFoftnGKXkLD7ZjaoQVK6Q6AMvrZMGYq9VIL/YLBRWgEvht2x9XCUYk501Dyw6kKq+XcvlbZNnhy2h8/sak6NEds3y7ekgOxp/6WBZ2vcA2ckSs5oHhbt5G35RjIeeb6jDCI8A2cSD5+JPJQLuWdQNfiz6W0hiwnOkEUN8BWrSxRraReSKw9FrIydq5hmdppcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz6qb2KPQizfyotNyuinMp/Oe334E/PCNVH62GI8Qqw=;
 b=iohdF0ZdFQeecpKQCifvA6fSEUYEZUqBiSU7U/GAw3BEd5388onTYBcUGDZoQ3XqN/g8amNntznmUuUWuWQ1EtySGpODjUT73JUYS9c+GGnMNL86AepitDEmsLpJ4xtYoVjiKtYJskq6JmDJUYXXc0seEakXwiL/caIZxcL+00I=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Wed, 30 Mar
 2022 03:47:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 03:47:01 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: isci: host: Fix spelling mistake "doesnt" ->
 "doesn't"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rssumon.fsf@ca-mkp.ca.oracle.com>
References: <20220316235615.56683-1-colin.i.king@gmail.com>
Date:   Tue, 29 Mar 2022 23:46:59 -0400
In-Reply-To: <20220316235615.56683-1-colin.i.king@gmail.com> (Colin Ian King's
        message of "Wed, 16 Mar 2022 23:56:15 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0164.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22038e24-379e-4c11-c1ff-08da11fff2a4
X-MS-TrafficTypeDiagnostic: MN2PR10MB4173:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB417368A9C36B53173B42972E8E1F9@MN2PR10MB4173.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SF1t7IXjHtUDi02M793d7ChtX30qdDRh4FTcvPZ85uikz6C4/bNhR8n6SP3dS3NFWyJeSyflzIp8BrktyQ2ZaETMFN0tEhsVYAmygZ6av5xv6o3AbKZvbsw3sLLeAw69aDt3/SkZ4Mqjm/hnKlHiZ7xoL9BZRO41c3atolXCqV+sA0KxfcITJ0v0ZxYqK6ZIZDOu5WG6H1AHOpuhF++97a5HlCnDdb09B3yZTg0uSnvevQhlD7jcYFVF27sxlc1CUJ+hWSnUMXFCZTT3H5/K+cTXf0+4hrttO0dwRcWk0ny/PyqErNHI2d7KDZPODngTwJZbhXoZJ18mE5YPYENr1eXvn8LjkyN8LGHPHG0X36Ay3jlzDYu9istwIDxcODNSHHHHhV1iC7a+2bqLycJBkpQMHZvXuGWLV0hGUDLKUhfiysFMEUYPtTxFEY53ws4nXjp0FsdGRkfDFL+hXy0Z/mn0c7WMibVEh55V8CvCSpL8J5NdwLMggJYleASyBFQ29URDTGy+rfijxK+WPAU6Ficj1YzMIGxZepkkdGvAsDBIIEmlg1b3XpmjXAQH5FjDdkoNA0rLyL8tgpKduYFwVKJgqncbSStoSejXR1j92YvKsFC1wQXK89wV+vPIbrYGj2fTy5KE/7O61TUl/8y5p6P/tJRP/5VOdByIw/mKEYg8IUEIivvnm81OSAoeCGcMhOQ1JIlSZueBuXN1NqdU5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(4326008)(8676002)(54906003)(36916002)(2906002)(66556008)(6512007)(6916009)(83380400001)(66476007)(5660300002)(86362001)(52116002)(66946007)(558084003)(38100700002)(38350700002)(26005)(6506007)(508600001)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H29wTFmxKEnamvhhP9HFAlAkZW1eT4ZpAAv4JIcUTS112Y/2mN3OPHDsXxSZ?=
 =?us-ascii?Q?PbOuHQdYkbDIZja3dIMBpb68b0N5JfoFZk2kHPJrGLHhf/YzlgVm7JCDLlaL?=
 =?us-ascii?Q?J2ZtiAjMmg4dxbMmAtq3uMhwlGwLfZcrEFv/qv0t1iD9XuRSqQS112VBec+7?=
 =?us-ascii?Q?IW3k0Q4yFYYV9QrQRqxPZAPZX3rfGLH6QyltLFVkRqi8+dHwQQjSY7ZrYLJc?=
 =?us-ascii?Q?k+MemCOXty+zh5BHWIUGp3SvAMTNrwb5/HDtNyOq6ilIJfmvrfkcMqJnbgTv?=
 =?us-ascii?Q?5VCENciiIeIMG1xrwzUl7a/0bbuTMuOpFc9he+1wb0zAV/Lg+jyAzZsjo0LK?=
 =?us-ascii?Q?KR0FdUZslac/eqvHGq9d4yNY1WioGvBR56o9Qox2zvE7Ew3XozD1MJsGBoSp?=
 =?us-ascii?Q?H+2qka5ARF+yNoq7BEs2dmrnE3Pfe2zu42YkasBy59hzSzfkV81zHnbjrw49?=
 =?us-ascii?Q?PAKIgrUMYTeIZq7Knfqqqa2yghpQZ3EnjM7rFqKZaerQX2noT8YoxGOozSB/?=
 =?us-ascii?Q?q4uEMDVP9tx13wPmhcuHVjD6WCsRpDKM2OoFQrxOVVY3uOpfpzBg0S+AWkXY?=
 =?us-ascii?Q?84leRLfds/Y6x4Vf/jEdSTmy3PT8/So2be2WwtvEViH3199jHSmJ3F0e2eXR?=
 =?us-ascii?Q?TZC86VlP3n0FmVTgofsdQPqhavZOTGUz1k9JsiV01KyPDHn5kdXzFASjV8On?=
 =?us-ascii?Q?P/FgPPoNRaszzywkVkW6EnNOZmPk++cofEHnigmIQkSN7C0AoXwBmWaysvsU?=
 =?us-ascii?Q?fcIDiq4ql5jKvX2VeFcTi57IBpq8hDIy7BnTI6ucjb+gXIOuOvaIqYY2D/jO?=
 =?us-ascii?Q?oLOu/U+uS1zBRSgw7oe8XRtPcoAoPhwOvksZdal/qFEEa9kNGJOVwp6iKlVB?=
 =?us-ascii?Q?OQCCegeCtZbGZuJQDk0UQMkMuKTW2vXcQE204nuRug5FPXykj/K0BHPF+6NV?=
 =?us-ascii?Q?/vgQNUxhdXAIkCnc2CGH1+e1ag8m5I04crE3rtMRKB4TC+PEdbkq++DCjw39?=
 =?us-ascii?Q?I8Lw9DR9L6lvkApL7si2z3B3ANcX1RVTJtOruBSDSB/Qr+lExqjDc67CupN1?=
 =?us-ascii?Q?SKS/iv3htJHvvBSc0BDUFiqyyn/dLPViIZx2t5kDlxzmj2FhI2nI/LvjRv5p?=
 =?us-ascii?Q?snaferOOPcg2yGHNCO1H2V6pMJQrPnyv8H8FoTZtnYh1jEaq/ZwWRNQ8dxcO?=
 =?us-ascii?Q?+mL7/cLH/nKRzCqcLc4TsDw6YM3ojdahdiJUe3OIn56oecKcGdsjDNt9WFqA?=
 =?us-ascii?Q?zbrgxtnzQi19Q6O5croB0wY5V/sJ1IieVMnj2n2FgTD5/IbekfhojZyu5Hj0?=
 =?us-ascii?Q?0/BtaK8Br3oBx4gxoNh+I9H+TDwfuoe+JLoPcTfnUUZO2EJWQP9W278Zyotx?=
 =?us-ascii?Q?wA34mn5sbka0pUaUnMz+rqfncHKfhrAWsMo4zYCYL0aGFxXPRy3XBlZ/HxFj?=
 =?us-ascii?Q?yhWIFXq6l5365cb9446633FietcmN7ohmUZIUa6FgxTq8YfFkxoE8TKAOhwQ?=
 =?us-ascii?Q?/IUdNx32udRfzZkYeDZUWFD4spetCI4Swi7zQTF9CYGZtuu5dk8wLzeFtCRJ?=
 =?us-ascii?Q?68DSU0KcjfMpXy9V3TerlyMHL/J3L5IpUohcxppDC/vvhwecG29VSJe5++oM?=
 =?us-ascii?Q?6CRy0cLf887QI85a2O7PW67r4YbBfNcry3STZDifLje0AL5C1cigWZx9+6ek?=
 =?us-ascii?Q?NHds29MAZP+dR87vZHDPEhZ9kZgbsX8265QuX+w/aeKhruGno/BWfN0/Qh4E?=
 =?us-ascii?Q?4kRLiURge9cOA4Bg7H4aK0nzWQjJmRY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22038e24-379e-4c11-c1ff-08da11fff2a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 03:47:01.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: av0XRXvo6a4KYpeJGa8B7fvTi25BxX24hvi5Vasr/MXEd+PYbX5CL3p0CTxdOguIkS2e3wta15AAmyTIpbOPyrfY69RfSU8cBxzoDDl58Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=698 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300016
X-Proofpoint-ORIG-GUID: orLJjQai0gzbY7SmFyxRuOyXesO3lZ2i
X-Proofpoint-GUID: orLJjQai0gzbY7SmFyxRuOyXesO3lZ2i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are a few spelling mistakes in dev_warn and dev_err messages.
> Fix these.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
