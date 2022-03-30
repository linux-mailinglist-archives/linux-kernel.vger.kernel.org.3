Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B7B4EB926
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiC3EDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiC3EDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:03:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342FCB53E5;
        Tue, 29 Mar 2022 21:01:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U3TIsb011958;
        Wed, 30 Mar 2022 04:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=w2ObsZZRHJAuWcmOLzCFYGMM0cNW7DKN5nUbU3rOqwM=;
 b=jL5l6t1nPS7N/leoA/P3db6gPoBU7QpgFIlGQ2aDhiqwxAjpc0FK2bCEzNZY5pvf85be
 i+dM7pP6JuxBQUv01+GrmpN991CQeriemfsw6v4crW6m7qfbjejFUjU1d1K8Xvre2VuC
 2t/6As3f+qvSmticoJQVIXfPkr95/uHoIE7tTVNnIfzp5iBc3gUA2FIyNRvU/eVqVAox
 juH1d1Fi/N+fweIZDN1gdZxxPz23gfcOns6ZAeRo68J28epKIPJhUTPER/7CFJzpRk02
 I2YjZdHamFtyDSZjEWkhDtxcUt4C75GWMOe14rYwGU02sRNuI5f7Y/BneKqKCvWWULfE pQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2gbax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 04:01:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U41gME009463;
        Wed, 30 Mar 2022 04:01:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3f1qxqggj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 04:01:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXmhM3FVxNWfJ4cv9qa91vbNZ8kDUSQKUomd2AIk1rEqz1I5AgAeIX0iXYlYg20U1h7xU48brm9cHRhj+u9OV7JpxYOlRXZgzx6StwRiIAx0AEPJCMF2WqGCx5CJS9aOsh0UyZy/DwJTbbPU2o+D+KjyP6AENOgeuiF5NWRWDxmxZRq6QkhEZS+VdSf6z63YZTx2ZP+QXZkxnVbgtePuv34hrsvxlWHjcETfQLVWJmNqO841i9A0WAUVK21xY98GIchw0QXjgljSlX9kho/wGdlsEXaBQMlkaqs0Znl7RkQjPEIHm06vIkpPqSHZi4WCTv0jTJPDONfxq/1bmCLR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2ObsZZRHJAuWcmOLzCFYGMM0cNW7DKN5nUbU3rOqwM=;
 b=He8aDK5eRurLaPIXVppoeRfe283iCAzumwDK/USdUolYZfP1tHYT7RR4OjCk/oNsipgP384Z+aOFCFV7yC6wwnpIPe+zAFKy29I8sIYQLMLt4Q2E+0PdcSaxgJeqstcelBHFmWu/RpO9LwG94PRyBy/rN+7LZZUuepNWjmenEDa9feePZZUqW9nML2qzomf3Clr5j1/wQWHindQvc+pOvgkYQcWX7hJM219k7L+Zg/geYRMdufN7EZOieo4/h95kNw85U8rQtP+M7KIh+FATGebjZKh4bhEk/zONqkQXlRZ1HU3U4CGQ7f8w6SUWxgsl7ctMjcWts0mzyF3JQpycEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2ObsZZRHJAuWcmOLzCFYGMM0cNW7DKN5nUbU3rOqwM=;
 b=nunAtsZoHEK9sCm/aXTiPtgSUToHd11kDpQ4R21cN7BLfIiF46hn9NaWEavK2hmguu4ky06OSTbzu+TpZ94DPAtq5fEpd7OY9hYMjQs6AsWtYcB0A1/7jz5HlrBdtzpW35di1lfcUPsNYdp/KboruHKPzvCbey7lYcyPQaJ6xgE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.18; Wed, 30 Mar
 2022 04:01:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 04:01:40 +0000
To:     trix@redhat.com
Cc:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [SCSI] aic7xxx: use standard pci subsystem, subdevice
 defines
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkxot7fx.fsf@ca-mkp.ca.oracle.com>
References: <20220322144648.2467777-1-trix@redhat.com>
Date:   Wed, 30 Mar 2022 00:01:38 -0400
In-Reply-To: <20220322144648.2467777-1-trix@redhat.com> (trix@redhat.com's
        message of "Tue, 22 Mar 2022 07:46:48 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0035.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::48) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54b3899f-8bc1-40f8-42c4-08da1201fe9a
X-MS-TrafficTypeDiagnostic: DM6PR10MB4170:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB41704BCB1CE446E924F1D45C8E1F9@DM6PR10MB4170.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuabrTLIUHgHt1uhT+o21VR7pSvfbh1qtEV+epIVylEEjr7glpLJlZkw7ZAIsuS1HhxWKPqkpuzkNAgQP0ElKKXrGRQYCPDg/9vtri+Llx7k92lQ4QuI81A3957aqJ3BCCnOLXxv0pWeK2uo7rmBxzAMFyky9HoDdu9F1H4bCx0uI0GzGEwAlBoKba43Foe6NuWkYsJC3k9FGZFpDTaAOMPfFC/sC+io+hT6FoXO8UeaYVwRObfAXNXirjMU7BBzoW2qOSl3ulW/xWXDHJbYlkSlZXzufFIWJZtfzcrGPTt+7RIVINrWg2kFT4lpCaDk19aUFTS50F3nKvD7etDtivLyIOF2EfrGTPrFnDsTIGB+CtVcBKu1xwFE8uOdVj0BnTC/mwNNVZopF/hmhLbyZ3TYULVUZ6yrNKbyd1eWGt+2FA4tO/TusMC3NDTi7B73CrB4tjyqsG7YU0WLTx/jV86IY3GnWDcKqz2Xad+244m61OUFe+ulxX6eub8Y4peR/K+2PUNBq4h7wBohyItnztd4EoJoI/9ON0h6au1wfmEmnRGpvqFTwV4348aTVdhaeV9o/xEKytfocGH23DVZN0vsG/KyIy1CHnF4qT5eVyLt22B3eZx+vDNCejW143QZQc6zGsvepAJvaU3aciU39R6c0IVKto+9AxP9dObyPARbo9mQ8p9irEd+BycQ2G0UJPoJOuGD9YY7qWHkgu0JKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(8936002)(508600001)(38350700002)(186003)(38100700002)(5660300002)(36916002)(6512007)(6916009)(66946007)(66556008)(66476007)(86362001)(52116002)(8676002)(4326008)(6506007)(6486002)(2906002)(558084003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZubMPjA5GAbq/FDueN69kP9Qjdk48YWyBpy0POhwKfz97l1YdXCml/YGNJMv?=
 =?us-ascii?Q?1dcEbHok59ligpmoVSyE3lN9AKoZmTevEbgnro7JIdDDYLKHpPdH5nXuXA6o?=
 =?us-ascii?Q?l63vSHGsRN89RML852jbr9Uq+XFzAkSTBP5Kxgd5GKkreAQmiCXuOvI44z0b?=
 =?us-ascii?Q?IO+9ArSYNvKQTsXBhy6akQs7m0VpHmuRLBUqfGO30tbOtYzvbkoZd5nlE4/I?=
 =?us-ascii?Q?EdzRjgW8+Vv1UOvgpA/L4A4oAHNkSkMwT2jK/tmaNu74SB+TAXEbsgNlZrPB?=
 =?us-ascii?Q?cwm3HdNaTUKenSjFCb5ndBw/rncOFtmqG2XHI6PR7qA4th6ntJ6wi4ctBlZz?=
 =?us-ascii?Q?rwXAQIeg+zbRmRzN1RX763fWwTWh8nTbrmoE+O2oHCt9iYMtz8ptYlKomhVy?=
 =?us-ascii?Q?MwXSjhl4gcZFNovTV/9d4JjEl6O7vxhcH2T6EHSiIbbSDF70VyurDuYGicr6?=
 =?us-ascii?Q?X51gPyKCsrReGx2826AWLAR8Fp0zNnaMboeQBMjCUq8bvkSSdP1dFvAktY+G?=
 =?us-ascii?Q?64ETnAt9o277xwyzl0YyTByQWEz2TSYN2mnWq9hluEt6PFjS/JvF5tJdB4yn?=
 =?us-ascii?Q?0M/GqvnjXEvLR7wEkfKkJ5HnCIZDFcrbyKvpdCAK0Y0U+MOg4ec6kDrA7gV5?=
 =?us-ascii?Q?LkXHk6Alnsx1P/0otMxN+AmKNWfkdrYNJttUCTPc5NPRIGiDuWZs6wu0gEC7?=
 =?us-ascii?Q?fsZpOhluitmDcAmMQVbFRr14jJgXwdP07mCplmeMDe0mK/Nr6MvAJfbADTO8?=
 =?us-ascii?Q?81XExApdJ+fl5E+xs5+zyqyWy7ldA9xep9YEevE9DvvOtbuVVr4EyzYdWwmP?=
 =?us-ascii?Q?YmjbNW7ECKRwpkxTVgnPgxfQjrAkvBrLLmpSYCPRiuzj9+5u602w1zQNe8Ut?=
 =?us-ascii?Q?329KpX2UH+d1SKSuMc4CLOy0CPFNM19UI1ocM5pfAHqNgLuTi2MqVzHAriKf?=
 =?us-ascii?Q?wgFgKHkvwIydXoZBazCx26aeYYgiHGr2KvwK77Yr9ssyVE51/X7JTsFnNL4O?=
 =?us-ascii?Q?XNUlidObWeGz2ocE87jyVVSn9Gjat+0t0qtla/LO+Nq1KekgIYkjYZCexyFf?=
 =?us-ascii?Q?YeP5JDslh5SOPZViXpDRWdml0jP+a/VgfCyYkZP65az4cV7sFCLUnnVwZSxO?=
 =?us-ascii?Q?HGD26Da1DVMp16KR49Vfx9L1x6Ne7RnQab/nwGvNTmDG6xeYSoC0jY9wNxCw?=
 =?us-ascii?Q?oy3ZuBHdMjgI2Knh4QAQNfSRzZ3WpP5vTmMXIz2N8dG7GeRK0TEObSoqi6xQ?=
 =?us-ascii?Q?cO0ETYIMXY34L4tb9QjxjF0JCUjSHbWSSU+qQOrTV+RWhAyQZAqcNfhxTNBp?=
 =?us-ascii?Q?wbHc5Zl9OF/eH1CxLu5S1wjuljOdgBHt3XbHNlJ8DoHBbcpQTDni4Nq9j/iD?=
 =?us-ascii?Q?qjFJO9Q2yEqWJ7GPlxnGguuG/2Wrx8DNzBqq1Wvex3mAoG70nVa7kDALYnKY?=
 =?us-ascii?Q?5eve/tofcSjhmydGt/qpOO/TeZbbEVtK3yCEgjWdKC4RPyVXg9BdlfIzd6ek?=
 =?us-ascii?Q?zWxh8Zy5Cm2u8wsDSSoqIzJPY7g/5z2+SV76n0Utfa3QduI1VxiG8ihu3HXf?=
 =?us-ascii?Q?G+1ggkopO/tOTIVYJw4HhMCAcnquZX75ffXOoD6djqGO+rrJi3y1GhxvQ/Cy?=
 =?us-ascii?Q?VJXMn1TQ0TI02PHCOqCSKU12FyMuhJ7pqgOUxhrgcCNP1YRsACei1ewxXtR1?=
 =?us-ascii?Q?+++ZgC/039ZXmGXNVkrXpct4w5oV5jK9+eNwQk7UAFot6xZ+7bWJyMYq5EVQ?=
 =?us-ascii?Q?41wFo2g8+K0CD4UlSM8BGqaxfkv76aI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b3899f-8bc1-40f8-42c4-08da1201fe9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 04:01:40.4167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFlmkoXMeNv6FzVJ8fWPx9A5xd7Zyxr0o1//1K68Bn1pN16cFJ5C47XS7mYUfvibukzj89b/69dyowGT6SljBWJs1y/Db6PBmuyavZ/xDzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=624 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300018
X-Proofpoint-ORIG-GUID: x_qwHQwqUXIhUoHRx9hUfdpln7BM4uNx
X-Proofpoint-GUID: x_qwHQwqUXIhUoHRx9hUfdpln7BM4uNx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tom,

> Change and remove these defines
> PCIR_SUBVEND_0 to PCI_SUBSYSTEM_VENDOR_ID
> PCIR_SUBDEV_0 to PCI_SUBSYSTEM_ID

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
