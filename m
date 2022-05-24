Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A15532169
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiEXC7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiEXC7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:59:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB429CC9D;
        Mon, 23 May 2022 19:58:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NMi4uQ032519;
        Tue, 24 May 2022 02:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=ZZZ8FyaglG6dKjcTsv5rPO9IFSLdf3PudbQcZg36XupjWMhX0G3YH6CMZbdH5K+/0dgO
 KT1TDDBwvaD3WDWQX0WBCcH2NbkkAzqiMIvN2B0RzT6aYiXA79Xy/lzMApEFSUHNUrlT
 gKh2Sr9YXYqE5tmtlPuZpoG7oSQNfiE1yUkcj/vCocUL+yaJDRm7nEoLDyNN0sihuP0c
 iuhNozAs0CKTmaTyhBX1a3/FXr2v/Jm4bgi0wstXo2NHo2tnDrS/oyGKi2duQJYEcZSG
 Ya6kNN7+TeeI1Pj8Dsr7/J2Ev0KQeuxKXW2yBOge2ASaqK8mEJAltSpeV8YhDFiV27c3 lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6rmtw1ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24O2u1pw034394;
        Tue, 24 May 2022 02:58:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1xdrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjUyPhqkDW96VKMcNTREkjqzD8QAR59Tf/RUlFwhKz75+ja+wmisu6X0fpNGTnM8e+IOcjGURocW5vr24oA7mJ4VFBJWPLSCYKrvAaXZMM1TvojJsSovzrAsonNst/6rYbvUQjfznQQ8x1DRlSb+2x2l+GuCF25lI2uJ/Q8LqLgU6nC16DwnYLT3wqvOUFRy63wTUE1E2YbVxrXoucPmfJc1UlRnXQG+2UWAtp6m2lqjDnyeaz9HwoFSYoSaqQQMCTHlX9jrbPPRrm/fQQlS0uXUEWDRlJeW44QRX0CMNLqCQKDfN5EZFJXo/t+Nz+AfKvnrg6CcgiO/Uuh2Tcy3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=gA3N9q3VikByRDCsWwbVhg/nyMJ1JdJHbhene71Sjcy2fMLXoW9cVyr/5PYC+w2amOK4ORgoehW1zrUzZndZ0n6nQUX/otgTH8EvzmrOa5+FqsBbmzSLjJcmC77o/uAILTuHf5SxwgU/OhniCwLebr5DT9sbiqw+TFClIY3xxPLdEhEdM6f/+g9rlSG+fTGj9I3o5QOQWcsK3a5dNBu3HrBks1sfGypLKNazEGA57lnM1MpEumAbM2ISdnX+Ld2ZaNh3hQd+YbcYzZGYgHii65DvXt2dqyssDzEDaJQ4mJyXiLai+XBNem0AM9aUKEvXlisJ/QEGevUBjIbORqWRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=sN19vizQra+6Ow8WYtreYTUdt0rsN0v4fWd+5r9/wJl303eth9uFrGsBy0G5ssQaP5KoV33PO0TkD0VPPCDuCY7G5Ys1k/Wm60me2hmJ2r5/iixkiVD/RWaX0atzwwXDBObsYn5oBMfOuIr4KfAW1pznMWebKGRtFGzPjRcYRY0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 02:58:52 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 02:58:52 +0000
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        kernel-janitors@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: isci: fix typo in comment
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tu9fhc0r.fsf@ca-mkp.ca.oracle.com>
References: <20220521111145.81697-91-Julia.Lawall@inria.fr>
Date:   Mon, 23 May 2022 22:58:50 -0400
In-Reply-To: <20220521111145.81697-91-Julia.Lawall@inria.fr> (Julia Lawall's
        message of "Sat, 21 May 2022 13:11:41 +0200")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e23c36d-6874-4bde-5a0a-08da3d31556f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4685:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB468520D058217F84A210DA158ED79@SJ0PR10MB4685.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9j+dMohzh8WfZhJkKPjzQSy9qs/Oa1Zrp8ZleqQJO6+F/O1zECx0tjmodEAAYm40r5H0LEcSsnSdeGp9lmG4D/TxZ4TYaCEqz/0LTjgiMKS3W7tLl7L/kMZXa7wPs0d5qK+lyUwRvZH3rRuwRzUq/oC+T2MhW5+3qkCRyXmtyXGBMgefSdfZQMN4tcE3jgXyHMWBBQdHiU4sUd5SrtAdIfx8rOuCWO8jkL8kPpFMALZgj5sfzAG9f7jZXVoSmf5WJwhRXZMex9SJwW1ErfWeafXio/Nz2R9m0P16Qnj2Db5IDqH1hn0vKteVTMkTraQ2outjl3lfRPnKK8nGZ+bpeEaiAw4Q+ppi7hg2mxsL+qV7CuHrtPsnF+5TsGx6HLE+j0uiwi+yV3N46p3wOtY8YTXeu2ryGIlZpr83TgKKFt2OQxfUA7L6zi/h0TouCl342t8xogCPoxfuqCO7+byfdX1hktPiCZcFm915UGj5d6D5TnUgXgzXJpeW9Ei/S37OBcKCe8M7IFBmsxtQPDXHsIVIuknqzgNOzEMNBs0VyWYTu/o9RD/caMKray82ebrngaHg+8bV1dW03zw6Lk9Gy9SjEuY+YY8F9F0kyq4reJZ2RQFbhv29GfionDzK3Ga/jgTW1hgi9H/6KgaqVjQfReX+enoujUeHkAK8Z7a9G1fYemBr8BgqkCCv951rHwb9tvwGgvokvZ+fLscKT76bdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(36916002)(38100700002)(52116002)(38350700002)(6916009)(5660300002)(2906002)(558084003)(54906003)(6506007)(26005)(8936002)(316002)(4326008)(8676002)(66556008)(66476007)(66946007)(186003)(86362001)(508600001)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sVrtbs8Wsj2Pue4iUMXJybWxp6ktrSbT6uO9Ku1+b24fseE3ehe2ZQXbnw/0?=
 =?us-ascii?Q?l+P/rS8qpBvNWb04ubnD68eTvkfI6Op8upHbOYQzV4dB7IUlr/f2tulzQMHx?=
 =?us-ascii?Q?jlAwgt35FQlc8H1SIo5Clp+M6vJv5SDZ+OSK0YF9Ss/wOnPKq7BbZN81C9Xi?=
 =?us-ascii?Q?ZlKK8N5+HWSDPf3ettB5B1C0xbWSYGqsufOT+th8j6PBmVGarWpD/V2+XjbA?=
 =?us-ascii?Q?oF8g+NSoOnFRchoBOlh/ZGCOJHfv0Aa+xZN0F1beTJeQqaN3hiTvo1tpjXF9?=
 =?us-ascii?Q?TPGwqDOgmSbYZmad5HWM2g8K2sx/9Pyg5R/mouUmkcujW4GTaiIW/kiZSaQe?=
 =?us-ascii?Q?OJqqRWPr7e5PXKY8XTOgycuEAWFPJr9uf2E3n5+gM8VPWIhKNUMtrG/hbrml?=
 =?us-ascii?Q?ZjYRfOmpc/rGmi1iyiDXzMZrXBh/Ki6NJ4fJwwoMr0WM/uU9s/3R5UV7rGEd?=
 =?us-ascii?Q?mFnFpdqvg6XABpIZ3H20F2Y8R55nn2F8GAQtKlFeb7xINSoCyAF03Q990dOM?=
 =?us-ascii?Q?bUqOeVRRoiOxrFbmrROCAbpsDnO287X9I9vHXY/rCDj91pXy4iKXgrEwM/yz?=
 =?us-ascii?Q?XWZ2sM4jT//BkpDqe+RoEzB+azlR8imP67VymQwhPJAq4moN92xXyM0gjFWB?=
 =?us-ascii?Q?YwAbHgFZspkdbeec+xYyDxpX84zmkP7KgYQ55RV32/CYXePvuu4zhMObSCGe?=
 =?us-ascii?Q?/G26fdvvs/s5/v/wDu+AMr5ltdvUTJJaxwQRCmyOrEK/q9Oj9Bp4fvPxih0i?=
 =?us-ascii?Q?UePKxjYxvf17l3aGTkz0xpRgjId6n1p2sDvhzHz/w2O/uqBBiou6G2qtI/DE?=
 =?us-ascii?Q?+QAyHQlOsI6d1kD6XLDx3l/PKvXfDIqFOPx05IP2qcRR0k5B4TZvQXluzyRm?=
 =?us-ascii?Q?IZWdc0zhhoQKMwKzMa0NrGw9bd86Rq59YO8LbEAhOnzHERNP11hhrXCmbmaP?=
 =?us-ascii?Q?u+NU0AMV3a7aXdlqfrl9GvLczej0JE8q5aJXImOKy1WXH9LIbD4meRIJLbdG?=
 =?us-ascii?Q?43pfxs7K15ZQV7MrPvbEMoqFl/NBMl5plHB6MCotAOpbk6prlhJ2K5UFgUdY?=
 =?us-ascii?Q?PpjWM8iwRlpI+V97W6Cw/QADpGl3mK5x9kvYPdHVuusksS+TZ7eEIFpTTIlp?=
 =?us-ascii?Q?ZV7DBSuwsbhyM6yIebb8+y43vo15UA4pua3tXaPkxC+LGQdv5O5TjCEa8SZ1?=
 =?us-ascii?Q?EbyifiLrnGudwsvoq+FMzLDAT4pAQ5/P2334ujPqoDLxbZ0WNs2b2oNYU2As?=
 =?us-ascii?Q?y19Da3RM0h6LOtltn9Zj4Zk3/sP8tvAcg52DUd2hp+gv1zpVyIyAN/tBOIWy?=
 =?us-ascii?Q?sB9tH3FMRJHn0vGxFr+ocIulj7IbkX1fTHftRbEPPNIG3wgxWBX2Tv7pl+OL?=
 =?us-ascii?Q?1gu42/WuD9yo4Jwvvb0K1UwPp0hFghudzaPl41fYqm8j3ycoBYX2+INROvVq?=
 =?us-ascii?Q?5Q7S6s7or0Wughen2OS3ZOy81URqwX/gant/ED7qg89m0ykzFsk9kr9WlTSg?=
 =?us-ascii?Q?5SJtbkmQlxvhrgG05mXw3h1gp+/Vv9VbOjWAQI3byrM9mpkZ5801Q3Vgj/Qc?=
 =?us-ascii?Q?z3WAnWR1kaR5pmxC2mFAgE5nVU4pwEQwop6UkyC10UnRHVCR0+s/IpFKWWai?=
 =?us-ascii?Q?dQHpVy4uRAky1+KhH08VuCFEkFbZibYEG0tQwq6n6PvfyEveSfaqtEGGKN8F?=
 =?us-ascii?Q?dKMsNhTUH2U8L4VYcaWtHa3eJN+6HlRrNagIpdX71UiGuBwgTOAsMCI+gcAK?=
 =?us-ascii?Q?l4Em9I5TvuxYgcAgGrs0tosonfnuVxI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e23c36d-6874-4bde-5a0a-08da3d31556f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 02:58:52.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKaVzQ0Y+T3hbgGn0TiSCgNMm8HC0vL69Pi/Z6A3lLKIckuMP4dIvq/Y6s3MqjK6k3E03wRu/T3nJiHYVRb+1vAuZgH0z6J8BY+msWJHcfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_10:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=840 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205240014
X-Proofpoint-GUID: 53tfGZPN_IntyPLdppmrPYSijncSNHQO
X-Proofpoint-ORIG-GUID: 53tfGZPN_IntyPLdppmrPYSijncSNHQO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Julia,

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
