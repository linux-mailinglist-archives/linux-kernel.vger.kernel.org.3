Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5F4CCBD4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiCDCmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiCDCmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:42:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E175717DBB3;
        Thu,  3 Mar 2022 18:41:35 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2240lb4e031261;
        Fri, 4 Mar 2022 02:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=gaHYPtADkklLv6yLWzCzAeMBLky4trsSpmA6J359jks=;
 b=KsPUPbLLhBXMqbg0MCpXntxfsMQ8aT/A/kEwWSd6q4IL1NovkqfKoT/ERWJGo2kfjzIa
 S+qqLuZ+x99XX211TQS0ev0ckquOIhD4v/AASXxObNa1tvlx1MxpM+i7vBVJH8olf5q4
 mDqYgPnYcrxG6WfbzPw+TlU/eL57ma8NIiFE8uwp+mY3rwGpQHaGC/Ed3eVox5OuXZe8
 dNxO9YEU3YAK9XtSQIsI10I4BbHq6TXGtyvvMI3e1gGvID3X0oU/1DudabXON1+/TH84
 jnQssT35AKkA2K7X9iiYUaU0gLmdiYgRxdt7o0eC8PQzJ1ovy1T8lcflfvr1lYlh9PR3 CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4ht0knr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 02:41:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2242ZRKG193892;
        Fri, 4 Mar 2022 02:41:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 3ek4jfy9h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 02:41:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xmbf5Gc4cWzzbA7ZE2x25whnspF7w1ZVBUhGBywjjV1b29ViedgdCmPY6Ys/r5SVoJ3CIccKqBWrKpLyhn4qDihZLC89y/iTwJkp/8VEl1jVR0DYPSeGcxupyCtd8wsPMnTtHDEk6GrB7LmhC1uRDSR1wXG/FlfvJIxBGgglR+fX4XIkKavX+pNCeBtj9XpgivcqWsMom5sQRGH9RqLuNKYx2Rslym2zRExH12mEe4cf1xgyYCkAdTbhHD0htvGU1gOfLGF2o2vtIIkakm2xUYP9N1QUfdbxnN1n03nvRkHm25DckyK+YecMl3GGxSf194GKhKt8K6hCAEOGOS2Img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaHYPtADkklLv6yLWzCzAeMBLky4trsSpmA6J359jks=;
 b=EL05pl4Gr4fxaPX9Yub6Q9+BMYNtfppTfJXb7cIoja3xln68QpNfJeEAAFF4hSJ3QUJqy4q79YRdhT+MNhFQA5EtNGLcTAyuR/KGQFCuQHA5v7Jnob0zMn3++FUepQ5IH5Wd2sdZK5ov6il6qASvZTZXXvno/FGvyhwfYR+9zAW9HUqlaPhOmtVzGaQp3p1+FER9hG0fMPfl3XeEbt0Xqsz1llvHpDDMXVMJO5dSYOlImJpkK+NEV9r2MHTjmwvtcydkWXBf/vBPlJUEh3nA4m8EkuhCDei0T1fpFrbVKhp/iVn18frZ9mXSlz7qyQnbVb60fcPODraq9oflNxRTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaHYPtADkklLv6yLWzCzAeMBLky4trsSpmA6J359jks=;
 b=oPBNk72KgZEvTmL0n9X6CxThtzZyy3dKwx0ECxzeKmmXGRtHs005NkgKUaZN2vmq/yqeQKUfMMH+/zAwi7K5PCHTqiH2SOoR0oIv/nANIAD3li2H7gBrUIh5aW88GhDdY9os2BndjDhqeoE7EWRScyVLBvEmwUOeQ9RVYiJa780=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by CY4PR10MB1543.namprd10.prod.outlook.com (2603:10b6:903:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 02:41:21 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b51c:77eb:39b5:f67d]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b51c:77eb:39b5:f67d%3]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 02:41:21 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv4 5/8] lib: add rocksoft model crc64
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k0dav3r0.fsf@ca-mkp.ca.oracle.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
        <20220303201312.3255347-6-kbusch@kernel.org>
Date:   Thu, 03 Mar 2022 21:41:19 -0500
In-Reply-To: <20220303201312.3255347-6-kbusch@kernel.org> (Keith Busch's
        message of "Thu, 3 Mar 2022 12:13:09 -0800")
Content-Type: text/plain
X-ClientProxiedBy: DM5PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:3:101::21) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aafb5c46-6d0d-494d-2d6e-08d9fd887786
X-MS-TrafficTypeDiagnostic: CY4PR10MB1543:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1543CC2959FB1320D33D904F8E059@CY4PR10MB1543.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pY/zbSBpbP8oMVNVyJMWyAims4WYN/u+Mh8AxN1rxwoJ4SmBeZs6wyXT6gZjI84Eb3qZn3u5YAhTi2ejmcliAz0Mikj8jxogWEbDOeRBrkogbGC+N1zywYMBHK+B4QVQpE2t/c9j5QLYzdL1k4FC/BGPhk24uU+6p5hKdev37Fze/IBdRkyY5UzvGDn93wrq7Hxt9eMtL+U41Xv/KQ924s5Bh2UpHYkVv4Zz8kkq6DbjxGsAQ0TwA2in5A6/t7yzXoiBq5X7unZyyPJQIdsV/KoDuaWSPFB59esCguhpxY6oLI1bGW4Ct2Tcw2kkw2QA62gxiORDCiSpRzrBriuyoiObosvXbMVsdHCckEFRFvTX0O63OpJNEyXE77JU1TPsJVdwRokf66w15TRUN90sZsDVGoaVt5FzByIX6jRMX+FHbWIRFA+TR0dFJZ6sDuEbh0edRYMHWuMsX8GarLwcvj6migTlumAqwycp7Rf46MoC00DVV3+GdEpEKE/AdzbOWPyOhCTf0T5tm5CFEM/K+/jg9HO6jGd0PQ4dYSR8irBzNxaYVlWULhBMPT6xz3UiqL3HGGx1cO+cZx9+m2lDZGYnQgXXwlt5PfsQAAEFy5vhzx9Pd0ES852850cYFPq5Cr3pfA63N2sOa6bkVlzTq5kTV2C+EylpDf5KhozLdqYf+8NkB0TJUNP5e2wwA3mqXlHsEzTvV0mGLhQHq5DqAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(316002)(8936002)(86362001)(6916009)(6486002)(26005)(186003)(6506007)(5660300002)(36916002)(52116002)(38350700002)(38100700002)(2906002)(66946007)(4326008)(8676002)(508600001)(66476007)(66556008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pOq0UQLxfSsa+uD56klBxjiNyUfFEtOLWxBgyFCsnioGyN2besEcwesP0Nn1?=
 =?us-ascii?Q?MgueAvkcOJVvE3Ih4FoPfjvSjFPG8wFJ6ez0yUIM+KzGbmNoP8hLtBmB4baq?=
 =?us-ascii?Q?AuuZJ81f35vQRp4l/Lb73qO/4giRHFKBkboF45edYFmSlp5MmpnrwAXJCOvG?=
 =?us-ascii?Q?oKMwHZlrF6WnkOfogwqkfN6fXOvX2YOZ2aMoVXkvI6K/ULUTphbL7K9CL0j3?=
 =?us-ascii?Q?jrQhDhSjpBoeW7cH7QNagnfQK7bj0DYX0+EB0BG2TXkWJtMltHXJ/cAtEQmW?=
 =?us-ascii?Q?+YWqpKCr/17j2HqVGYSQbfIiRDgl2qW6BcKYScstW5Y4v8lLN8PRWGuQdtRB?=
 =?us-ascii?Q?vuRoSQ3WvImc+EpekMyc6bzfuHl/2yQi052p1qctcM2H/YcEWTOsiqK2dmi+?=
 =?us-ascii?Q?rmrarSWqgrxah4fldY6Ri18mO77a/NfL/ZtexlZyIFGmHPVj/+5QKNuQz4Z4?=
 =?us-ascii?Q?QDFuAnYE7/1gpTX/quVtsHI53pKkigjZwbE7Ya4azy95b7Xa/NZSWahjKpQh?=
 =?us-ascii?Q?vpMb/eFQlrrmx8BP2fBoQap62+90TlkLl/t1s4VdZJxh2l05hVV6oaQUKwFn?=
 =?us-ascii?Q?1jeardrKGBoxlWBmRNpMCeG3fG2r3T5aTK1Ujd5AtMIHHjwUZDBFEIFqvWOj?=
 =?us-ascii?Q?0O6bFJkGmfhByt2jdPm4yFKadmqPR21GdtfNZAG5hvv4FIJ4R8KUyrlSaxa4?=
 =?us-ascii?Q?80WJFtTOiFuOe912pA22fBoGjogsfdETSE4xwpWslwfB3DTTNgAlHbKDy8sa?=
 =?us-ascii?Q?EQHe7/ZwjOGXFrSNXOteRZvsPADeE8i8iDpSiVRcZOmEs9/BdYPhdPwmeJJT?=
 =?us-ascii?Q?eiUJ5tqykTCbxJhIjmZfiucRzLadSO+h7JlxnkijI1QfjhzWyyrLLCnykWIi?=
 =?us-ascii?Q?99djuXfGDGAbjdXCAngCAJmWiQOQNua9n0SYI1NGWJGLfktcDTOZNWe/nR2h?=
 =?us-ascii?Q?pYBjfCXMU8pAvurgRdJXsxsCDQNeGQ+60mVxLuieXy4zgh/GgAgJH2xZ8vq5?=
 =?us-ascii?Q?FxsTwgwwQLZQrG8ZGK4dZB+UajEDfdXSZ31tcW3FhB7VpVQoxyKa3QijIkVd?=
 =?us-ascii?Q?bV8tUrubn4HxzOqf/9/BouTuL21Tu2tc0uv/N44TN0NqNef6zaqLZR4UPLAX?=
 =?us-ascii?Q?/xsAqFoHfj1SKIOsBDKZnug+FCll6azZRzFSoMrLvHMMyVAA+aG/0ITPHcrK?=
 =?us-ascii?Q?eb2y3Wvn8qDjJKMrdDEeu7zusFIvPC7O81nMMGZQqiv55FaNf5Nf1XVcj/oh?=
 =?us-ascii?Q?X1OpoQYBFOIa3Y5Hvm10rT0OL7yEYxtRf2s8oVTGBj4DqtVR2Y2rk1CK/jDR?=
 =?us-ascii?Q?71SKJYgiB8PU57MsLO5BLUhds3D1Dpke09VSDL+xeyzfcf7mva5hDSzeABxU?=
 =?us-ascii?Q?e3xS4FBYg+E1hxcs0yOZNECtjacqaAcObZ0YZDEPnWduXEc15cGJ0uAHJ8We?=
 =?us-ascii?Q?WxRiGMGRRCfZn3Zx/aU/8IZbXqORZxiXPUFuAkfzkFgZ7QwmUNOYfhfV0zQ4?=
 =?us-ascii?Q?z3JLzsGFAya9TqLpzlR0iLYgZ2Y++o5nsfx7dzDJ7V+6lUbFEcJKv1B3JsmT?=
 =?us-ascii?Q?RE5BadgoA7oqQ8jiMxiw/eGeboVsapVxLhqBnDnXWlcPCODfaFtnRSxw0DdI?=
 =?us-ascii?Q?EoX3BSAtJPyQP0QUZaBT9FBk2Xsd7sw6Xjicbg8wBydlFSmK6pgfwFAgJ51U?=
 =?us-ascii?Q?TxFwCA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafb5c46-6d0d-494d-2d6e-08d9fd887786
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 02:41:21.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xmmdLIZHnKFjdTOW5QXQ2gnmL6kWCjOVQbUxn8EKhtkssdFeXeElkcAW09d/H2QVOT0DHHH6QlNixKVwol9p30WMlohVUtHEyx4OhjCmvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1543
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=847
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040008
X-Proofpoint-ORIG-GUID: ePUWW_sg7JEkEgfnwKg2yggdMIgKD65u
X-Proofpoint-GUID: ePUWW_sg7JEkEgfnwKg2yggdMIgKD65u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

> The NVM Express specification extended data integrity fields to 64
> bits using the Rocksoft parameters. Add the poly to the crc64 table
> generation, and provide a generic library routine implementing the
> algorithm.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
