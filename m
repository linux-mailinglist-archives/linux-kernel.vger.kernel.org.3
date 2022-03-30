Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491ED4EB8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbiC3DaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242269AbiC3DaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:30:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE02510F9;
        Tue, 29 Mar 2022 20:28:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U3AvZe011972;
        Wed, 30 Mar 2022 03:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Hnr/OYeYtS5FqfnwoT6aijODt4TYJ5LuhMVcqa8Ezsw=;
 b=rhaZnsDeMf9DGZ9drB7PKBbSlKDEj2vieDiuulB2KkaE4Xu+gXQOL6LEr868vh8IkIfJ
 rzAowo5bsXv0krGfHAr5H9N2uNFCOCPQBt40XaKPj0IBXclWQzi+nXcUKrcHxlf/+1t8
 zDmHz7RtcdpifAPzqTvlwq9+h2QwuIIyW9SnDVxU6OFil6QQomOAaxdddbbTLiIjlmz5
 GQtTRr1BB8OXiv7Rxx7QU0u/CuqZGYWo+vI4UJMYgpHlpQ5ggByL0Bw3aMboqhWQgeC6
 Uo32HQqCo2AtPuzxVjiurJNbaIXkktFFTGgDPCg4SOCCHgDXizzGOJqxeLwxiSEFluwn Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2ga6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:28:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U3NkO7043431;
        Wed, 30 Mar 2022 03:28:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3020.oracle.com with ESMTP id 3f1v9fjtwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CayBIoubXNEFOg1top6LPzowEgRleHox493dlJ8UqN/nP02+O3zEpENLTVJONUPod2osNQYo6Rlq0t042gSF2ne817pcsrRI5syF6kCGE5f29L2bdYvdGU+eqGLyLQKn14RfI7F9o+jpV2KvYW9DfbqBrs50XHvBPxXcjS5v3pNJ0VB5N+LjP4886KWqmiJsfyFMgGBftDvo2MSDoofZ+16j0VP74MOtu++BGZCjre9lbrFNQxfRychUAHqmv5AJMrNwQ44MM35PXz6dxxgbAQ0WihZlk7YtmYzPkvOD+tirZr5d4seV83yAAkFmhpHQCPmH6xJ1v8ZEmSx2PiVfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hnr/OYeYtS5FqfnwoT6aijODt4TYJ5LuhMVcqa8Ezsw=;
 b=JjhGIreidZfEANbSynwbl5i0CEYm2ipcz0EZLM2HXLUzg7AGi5xfkIS8dNTT0xXAkJ9yY/ByURyS2aAtm/CiTJdGfGwq85qNmon2woL60uzZ3QgIOp2ipPXT1bgvDgyfpNEqlsCtIFra+vnBNuE43Yg62iLjuN1+sORjWPkCs8EDtcKYC0TN8pKAqeVf6feTQvZMwwsLf/CqHLfm27dnw8YVj1zJ/uxeWLlTw9mPj3d03HWgb7K78pM1VmkIQynhkn2YtVNYcZXgHw51bTQiMA9+MYolUmbQ7AB5AcBIjc6dMv0CIw38EucBNanD/S33cD+ihLGuTHZgJYOjwL9QMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hnr/OYeYtS5FqfnwoT6aijODt4TYJ5LuhMVcqa8Ezsw=;
 b=B40rRGgzGXsHx5Gwcu6OSXxg4y0KdJjR3ZEbOHq4rfRae2+2L9qpDBHSEp8yfyVwjyeT0O2UtdTIovWjXgigfUm+NpbuN8dmbrNc5IRV3DjMpb7bz/QqCn2Oanej08ziHcRuc81A6mWq10odudfyrsM+pX/GvoP3DRf98a6GRao=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN4PR10MB5575.namprd10.prod.outlook.com (2603:10b6:806:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Wed, 30 Mar
 2022 03:28:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 03:28:04 +0000
To:     Keoseong Park <keosung.park@samsung.com>
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: core: Remove unused field in struct ufs_hba
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czi4w24n.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220324070146epcms2p577d43ce3e7cbd36aa964f3842e49b2ba@epcms2p5>
        <413601558.101648105683746.JavaMail.epsvc@epcpadp4>
Date:   Tue, 29 Mar 2022 23:28:01 -0400
In-Reply-To: <413601558.101648105683746.JavaMail.epsvc@epcpadp4> (Keoseong
        Park's message of "Thu, 24 Mar 2022 16:01:46 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 134a4175-1a60-4208-3ea7-08da11fd4cbb
X-MS-TrafficTypeDiagnostic: SN4PR10MB5575:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5575CBD3A7F37280DE55CCF08E1F9@SN4PR10MB5575.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ss377Jpi64l7NE+uFUTxVUkh+gCSSixmQTxvrwCfD6bMyIXKgk5mXwG8vpTnL918vlr13GSMJ1UIaH//NMgv5MCUfUOuVWwuJ1iCKba8BkpoYCUFbOB30HKbVeZR34s3qEUa0yERtXYKEhyJQ9/7Dhsd+EZ8zqfPb0+C8JBtLAGzBCHQ+Cd1HaQBuEccM0Lx3eyVM8aLJTxABg1LgjoUYDwKTKsy6padVw21xiNdzMA2fZdS9ELmspxlT3lIlkeLCONJWx/m99GT5DXjIbSPf+IFiU7W6ntDr0m8hlXdU4J/yxkpDOEdLppHPXiDsFOmmmiKDkTF7/mS0RPD0Vb21ftr513octoDJ1RGVkSA/NRniq2+A+8dMvNLmSaCsfXkFcblcONTzGGWPOUoekXfXlY4OjfkzOt0JwTApazWPLXfNlhgEl17s17Asgh1mSLH6DDxa2R2MjYfIeS6cjDRVkU2aBWieHmuXBt1ta7Ds7Dl/RTAVDz4bavBt6OiWAFg3Tm2sk1VF2eoEbOPS+umuNfB7T+hX3ulJZvxBf01jYK06hU3IjeSFUgOZJnsLImkl8eiDUeTnBvUh0zZ1WuaXLMWKBEkF1qS3jjyXS6vZBlb32jpyR/NgQVkZP4ncfG5P6VgBny9nE1z2gOK9cmBNHTLSDMsZsG6SAvNKHaHHrc7HoulMwGhVNgNRsBh6xxtOql6sH1mfBsprGDsA8dENg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(7416002)(66556008)(316002)(66476007)(86362001)(6916009)(8936002)(54906003)(26005)(4326008)(186003)(8676002)(6666004)(36916002)(6512007)(6506007)(52116002)(558084003)(2906002)(508600001)(38350700002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h8iibKqtnZnVguZdvCs5Vp4NoPzGp2DoHTqVU2pA4swsIVSSLNpKBsVPqqKY?=
 =?us-ascii?Q?6HXkkcH5gvtfukIMgn5Td+5Grx6pT6KqfyUMaa+Cw3UggiBtL7/OD5F4h4DT?=
 =?us-ascii?Q?cM49BQOh8qvFCj3MniYsAG2UbjazaE8amkO0yYzR4VXd0Dd/U4TKgJoSOsOh?=
 =?us-ascii?Q?Wd4Co//0Z1lXsHR3DkWOZD07j3/kYSdYCfJyS4ojch+vJLBPx3iGqn7ozh47?=
 =?us-ascii?Q?EJnzmUZE3qPeFAKLS2+7y9zfFMCaQm6zopzGVxHfIvA1CYL2zxwAX68R225A?=
 =?us-ascii?Q?32XwqS6lqJbXQcXNbKM4cdA/vh5MS1/iV3JHuiwkbHyWi2Z3jGiXl1eONves?=
 =?us-ascii?Q?eGd2KSDx2haBcUmu5mXoWpUCgD8t/Om3Yl5PhDfjTiQhDwTmi3N4wJ9BSmKo?=
 =?us-ascii?Q?qsyxzSL/6mFOUv3dxfVpMOvcd0rnxOnIHjPfXDUek8up7YT5j5aAtfflcP8a?=
 =?us-ascii?Q?dTzXC5cwGnILVWn7br1ZYEcvKdqxSCR5+c7TQIc5VYd3cvwoqKcBajKXmPJS?=
 =?us-ascii?Q?x2kriVueg5/9oFKP9p0ITM/+QzHsHytWc+JohZh/9/M9+ZRZj4afHy8rlr7e?=
 =?us-ascii?Q?fWC4WQKhmiS5MwlbmNBX74mxpi9WmfhzGUkdf2gFBfEddy1+HKaCWFzAdr9R?=
 =?us-ascii?Q?4/D4UAVCpxXVXeMNEzczP1ZFbF0LUxCY6OngdFm0SnovtVxbfmSXymgQUeZO?=
 =?us-ascii?Q?DHSuijJD8Ir9XoRh8EGU7wz6oyR0WhlFBJbDtCIt6ddpbFSsCxv04sXKlLLb?=
 =?us-ascii?Q?bMwhFX0zIxqtfUjgSxIzGYA2Qi7bbbYrgHr98EryK+6p+/CbmxMnPiS8MYe+?=
 =?us-ascii?Q?T+Bwmo7wRCReyWZwwfa3rYHce/roOdtLlDGQQS5UP35oWTz8bFHZSGllciW7?=
 =?us-ascii?Q?pTGpP1s81GBmzzf8YhRIMptbyxrcE4jYwbHgPMgIwVd4KwBnWLOlENwf9MOr?=
 =?us-ascii?Q?uJNM9V7c4F/GIA2JD3b2tctNx/DTgLFA0SD4Z6ULKOoBsAlks7xCN2C3A/Q7?=
 =?us-ascii?Q?h9j9h3oKBftOCLvWXw8DO07XckR2LrQyMoaU0IP2N05szDbeynahkfvcIQbz?=
 =?us-ascii?Q?0UMoAyfdG8amCwV2TG+1MJ5RvLoaq/kV5Zmcfs77VaAm9OE6P9xo7zyW/dH0?=
 =?us-ascii?Q?Un6qA7rdPlVvyOlrmoYyN5JS+wHtvEkvudaPfDt2ls/ONLcoJYz5lJpX4Y3D?=
 =?us-ascii?Q?jktb1oam5lhCYzpUVbpL8NHTej3cb4OlgwHMMJxa9iKdmKcLaSOskwQwY37I?=
 =?us-ascii?Q?tDa5JrgQ7woY4Oi3xO8Q1+dtkqNzi1uByE/SCYL90WQY4iTSD/vVZweB1KUE?=
 =?us-ascii?Q?/GGIMX35yKV3wDgxHSXRvDwcNhU7YCumOwWIuZcVYcVZTmExCwf/AYAdXCio?=
 =?us-ascii?Q?ijXg0eLUOjEtNaA5++xAUiLO/rPGycYYhy0zsIPBXFJiKVhQgtK7ximYXs1n?=
 =?us-ascii?Q?Jc7ZSxdPd+cjKCgBfdD1Dcd93AHjaixtuVbjBqnEMvRddpT6zGuwKRyUfcc5?=
 =?us-ascii?Q?8LTyCcPku5jFJY/0BsFHzNq/IvYor5BGv21kqlIQ++cCPo7Z/X8KeI/WJCds?=
 =?us-ascii?Q?YqDEkmDkbEAZMFm+hM36gFTyYh6Ytm81gCcmovxnQzKptNzPvqVrXmEyVeF+?=
 =?us-ascii?Q?A4JjBbWqdHVWHLifsMQXD953P1DyGlyzxkgkwUzPJ3AHZy66sePPh6/ok7mq?=
 =?us-ascii?Q?++z3q2uTq+GS3TwnvR1CN/L5/FbvuBysg0QbcS5SYQb5wv3UdB9jH+3HqKqM?=
 =?us-ascii?Q?518pJDuuD1yxG2t5u1wx+GjKx5FFsFE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134a4175-1a60-4208-3ea7-08da11fd4cbb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 03:28:03.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyrRv6vUFRZiRGHv8wTnvcgTMse1nU7PyzOJpqD632fr1bdpKoxAKRWxZ8UnZZO9mk5HWfnTJDjZZw/22Rw2wpRj4Z9eZo0Oo0v3GmZWrJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5575
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=891 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300014
X-Proofpoint-ORIG-GUID: W8B9Dz2FHCCrWNL8O3E8y6HTS51NYcgO
X-Proofpoint-GUID: W8B9Dz2FHCCrWNL8O3E8y6HTS51NYcgO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keoseong,

> Remove unused field "rpm_lvl_attr" and "spm_lvl_attr" in struct
> ufs_hba.  Commit cbb6813ee771 ("scsi: ufs: sysfs: attribute group for
> existing sysfs entries.") removed all code using that field.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
