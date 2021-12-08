Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3646CB42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 04:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbhLHDFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 22:05:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20418 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234660AbhLHDFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 22:05:16 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B82oc4q028622;
        Wed, 8 Dec 2021 03:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=EOaBfWPvM0nyLt3EgM4mN2W/uPZj9OpPvAIT7v+W0eA=;
 b=EbrVMkypkiEP8sllExrGc5DaeJwAexHhn8hXPaJR5q3Hl1dAZSFziFL2vKLX7rx7ZJRd
 QSnMBjaF6bbLiZRQt2Ff1BIsarxUVHymYJSsx1h1B+k87W2ErJVMWRUUO+M3T9hitBRd
 FQyPx7gx77cvskMI+Q38LaLrIRDUkNc6xnYFYOBMVQ1joH41NgJcOQKzHfvDVF16RttA
 DQQzEwrwydCpUvNb1T7lMN5JqzVK8WLSHG6FdjOKsqbBi32/q6TH9LIyh3YCGjzxoj09
 zairjcdkYKtwQ5z6RsLGdvGv9Izb3f9QPYxbpkXeStIRZwhfSx++FreLqXXH3uXjJga9 gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcfa39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 03:01:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B831BIp169474;
        Wed, 8 Dec 2021 03:01:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3cqweyrcvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 03:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OheZAMAyOpsJRZcngULPpr8Ozo6GwoyavBSMQs6mgNC8UG54JyMKq9LrYZshwg20IYMIjaKDXJeBhuWRoiBwHDmtMuAtarl5GDegj7xzDEvNOM5dkaoFcYtnY12uBnXLksisSx5qqR20ANW6umfdcfKjXPJuNHxOoctmSCZr6q7TNymX9nMv7SSmgqDTTKJxPsOOyjb6jFx+8RkpHvL6j5NSuXWWpaLm0oiGZ4tAdRILq9eSFISxWLz6VhPS/Imff4uMcKoXrcikeD9xo/4PaIiy8lEBAaActEX5TB7wswlm3JfX+RmKPKMQ9X/Id3n26E3EucAA+z93wFBc9c70oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOaBfWPvM0nyLt3EgM4mN2W/uPZj9OpPvAIT7v+W0eA=;
 b=T8et7twj1P5CMYPG7jT1CcYdyhLiPTBKWiceut9Hx58rdJSz/7wZZF8L5WQ/zSw+b4bkZ8WESjq+UCdu8c70et3pCAYg3H3IulL7qmjKNF70aYSkb3QqLDlrfxDePsbGmEKjcssaby2e4ccDtkzAwSIVUmlMtGFp7EoMQMgz7mePmJwXXeg+TH4rDHBCgQytNhOELD13oReCqU5a6FlWSzBVx08AI+caOJUuMTI2a0d1krh+5+2diT9O5xkZdDV3adgTW0J9M0lDonJC2X0ldl6PY+Qd/n6YjOEccQR4ISkPT8QnKj53aItxhQfRn31czdy70Nc5w7zxVYO4SVrTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOaBfWPvM0nyLt3EgM4mN2W/uPZj9OpPvAIT7v+W0eA=;
 b=aElXDfSm/YuMZ0W6gRrqtRhB6mnxaqFG+VGEKUUit4qQ/KXaDpt6bnYEe4gpLVhLk08575aVADEpZmAAbt03w7+F0zfWbOvpdYnAQmHHfdmFoh0Ueo1W0ndqtlVNCmlLhaMVL6A8KJdlMFf0J02db5JM3YJv7B6PPjI6NhW8q/A=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 8 Dec
 2021 03:01:38 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%6]) with mapi id 15.20.4778.012; Wed, 8 Dec 2021
 03:01:37 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] docs: consolidate sysfs-block into
 Documentation/ABI/
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17dcfu7hk.fsf@ca-mkp.ca.oracle.com>
References: <20211208005640.102814-1-ebiggers@kernel.org>
Date:   Tue, 07 Dec 2021 22:01:35 -0500
In-Reply-To: <20211208005640.102814-1-ebiggers@kernel.org> (Eric Biggers's
        message of "Tue, 7 Dec 2021 16:56:32 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bacdbcde-c2d8-40cf-ab42-08d9b9f70d1d
X-MS-TrafficTypeDiagnostic: PH7PR10MB5830:
X-Microsoft-Antispam-PRVS: <PH7PR10MB583079728CFE5DF262E694758E6F9@PH7PR10MB5830.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9TFKlFGvn1qJgNqU3d3kvMQV4x3dwXdFwOcJgSPDscmpbBpoa7NzZFQbQyxqtM1YllGtCxl4lj5a+dY3Kyx1LOmJ2rYVIkQQ0h/p8WGDie/ITyJUuxnPr5EpOjgE3Y2qMX8LQSyPTBpI6x9+Oh0wG9y+FN2DMazmPG80WZDDCyxH85NdG/fdjwwkU7rhcZHGm7BlOuo3zCq2WXDXcYCa3Cj1Xe2CHzD6ash83dbDFT3Dn0dCVebeLGJMl465TVw2broGVPsJsIJEG/EGhPvEpzgdYkn62qDDT8G+w/idG6Z2RPn41Mk/jPEctozEmi1CBzV/cY301he2iXvUUcKD8d3g09Z6EO5OjuSDRwpzfPK9aEaJ/t7iQzVWFXEduFv5GVdxgDeKe6oxjE5X5k2tcg3TSUJ2lDe6HAoLlKKsfNkfvHH6LhOLK80erRYUpB1W5MVvEubzoAOOEDWygSy7dBcDM4ZajcfwNA7nfc6IPZzIbhLljwaCU9yX/VXc9kdPBw/7ndASvl/UbEaXqVxEquSC/sVFXTWTvZdDcKIzgFSDQ7z5aGco8z5w3VxkYav/aPEMnWMLd3NJNix2GjlG9RZ1JPMHc3PROLfMWWI3nr1BKRZAYae0jh+5ve2ONp+icV2qWlpbsRufywfhlvZhzdVADCtxV9bdo82Hh45Ckl43KD4ETbkW8F0G3/06JoXLYNWMhyoTuviOo51TouHxwwYoV9qjTKwRc25koXHfLSTkaeEZ7WhEaPm2tAvWMkaqLs+T26Z62E8KxyAM2xCnYEsqwcOECisbSZbY8N3Ya4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(4744005)(4326008)(83380400001)(2906002)(86362001)(66476007)(54906003)(508600001)(8936002)(38100700002)(6512007)(66946007)(5660300002)(36916002)(66556008)(6506007)(6916009)(316002)(6486002)(26005)(966005)(52116002)(186003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aea8LAbeZAjulCYL7kt2ZLk+mxmaJfakfEhCndgqJ+DM+kQHy//TOF6WhJJH?=
 =?us-ascii?Q?v0Pm89Wz0gWZS1o8xfb8qTJUnfcJNknE9iQk0gXzecGo51vx/KrvxyDrz1qu?=
 =?us-ascii?Q?4vADMzvgQjHajq8We/zw5Bt9ZVOtZ9v4duXQ7Bt9Jv14Mjtwmz6cLRZ6daFo?=
 =?us-ascii?Q?vHODHN7qLpkapMx6wqsTKeaIXTy/psOVlXrQE3NjavAxBucaKCqNiDLs3+mE?=
 =?us-ascii?Q?Sh2XElziey4fQJVxcEaqjYBlOtC9s/ilNKcI5lqXsoEUIe4IRt5si7i2oZv4?=
 =?us-ascii?Q?3qtZiWCM5/85tF0W1oJxD1z2I/4Q+BjkJjxS4i//KD9ScBOU1JHBEsKa9o5g?=
 =?us-ascii?Q?Dr4cDoNsjA1tBqlaJ9XDpSEUZ8lGUwK+C7CfN+uiN8Ah0oGUeUxgFdsraGlf?=
 =?us-ascii?Q?whT5kXLazjpzNZPTv+gGQzajHb5LhLPIRX0C84/f6VkldAltafKpvcRGZCUN?=
 =?us-ascii?Q?CKWkHwiui3nuyaBSwc9kKLbQzarBylBBhwj01OVATMnTdgqLsajRDBkN7Tbg?=
 =?us-ascii?Q?rxZ268qzAwCshLeuuFtiZw1ALch+stYDPR312SWVi+L2A37adG/sSNR1qqkK?=
 =?us-ascii?Q?8BLwsberG33sTIpQ2kIcjCrXjHQL2rNANDwkr7UYcymK9V6pyiLeB2Rgbxhq?=
 =?us-ascii?Q?59zL1T1IpnsKv+p5fWQHxEJp4JaGRRpIEltrl4zB5NZLBQ4/JjwvGA1BeXTB?=
 =?us-ascii?Q?diPrerF2fFnxf1KSg0qt2bb92S6U6ocFm8gXs8tCdoEsUJxVD9LDXu4cReub?=
 =?us-ascii?Q?5uQNm2umzy/sIzjSKDx8vTJ+QOkZYWfOnDbvcuahab0s/gaLZmKow3w8hK3q?=
 =?us-ascii?Q?9Mwl1R1zWtDpYsB8Lw0ZERPjFNp8pX1klgG5a/j8Z72sxpDU2YzMB8Yoh1cQ?=
 =?us-ascii?Q?wJoT04MOTIKKjxLAztvRnXBX79R0MZoYSkhIaNvEAllJF9q9wIZ8tIEqTzI+?=
 =?us-ascii?Q?NMZ7kneI/rsl91OBV4yNzEPNIkCSte8lxWbWMUu1CaVqI/DkPr5MEbly6HF8?=
 =?us-ascii?Q?bA/Omfr4CnEkzCK+HB7AUQWI0XA3z+5Ei6oBv2tS+QbyZTlarwzg9up7gH4y?=
 =?us-ascii?Q?LIp+0ddVoqRT78chEvaKBEQg2NXW710tGrLyn+0UKqC1vcijsFqb+P3/Lr2T?=
 =?us-ascii?Q?gLhpm7HlWx5mLI+e3pBXc4ac8425dRygOrsWFzad9qjz/9Jfgtm7RevyDaDS?=
 =?us-ascii?Q?B26Jny0mVxsuo+7BZiiddHWcPoAE+1cX6N7k+WgkudX86UWY4VzV/0P3jAqm?=
 =?us-ascii?Q?dqcrGMpPVkjOyXOxUtJzaiPOta2E2m9j5+YGZAOS6+AduvlT1GW5RUxgPTQm?=
 =?us-ascii?Q?YPazxotPrdAq6DeqYGE1P6FrLI96IE1wZP/NyaRRDPMHAedwf5q5h3YOKQMo?=
 =?us-ascii?Q?SrbjRDuixdMvAlLJEJb3SatTr8p4MoKIlhZ8BoBrZDcsNZHtRaZho2FeSqm1?=
 =?us-ascii?Q?g+iMk3IFfwHemGo9HbasgnPuNoz9qoCCN6EM5CrQbxZ0hR7Tosykdafakosr?=
 =?us-ascii?Q?419o/wqJ3KCVnAcYxqyWjFyf1AjlgtJb5m6T+mkHQq0SudhHPo7XQef5Z4OX?=
 =?us-ascii?Q?JWdnP7/DTjmOvjB+cWFbhtQwBGjXZehsQ6Y9dJKEBkG/YzNxeYxyO/dBcyvR?=
 =?us-ascii?Q?EcP+LuLvA65pJrfVZKCta5UjOOwf35leJN+8jRfb8azmWH3xFHjwky7Syl4w?=
 =?us-ascii?Q?MScPNg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bacdbcde-c2d8-40cf-ab42-08d9b9f70d1d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 03:01:37.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icbbl9YlkcZHRXQBntIaRI0ShWTc/4PlAt8F8KyYvYP/z7lXIe0UyV+YvX6Rwp82FJdWeKc7TCjJUF3NzZGpCvNOh3QtYhYEvW1DTaePrZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080020
X-Proofpoint-ORIG-GUID: tqN2PI0rAFS_VqFXmndmtY7HpEy54Z7t
X-Proofpoint-GUID: tqN2PI0rAFS_VqFXmndmtY7HpEy54Z7t
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Eric,

> This series consolidates the documentation for /sys/block/<disk>/queue/
> into Documentation/ABI/, where it is supposed to go (as per Greg KH:
> https://lore.kernel.org/r/YaXXpEAwVGTLjp1e@kroah.com).
>
> This series also updates MAINTAINERS to associate the block
> documentation with the block layer.

Looks good to me. Glad to see these entries moved out of "testing".

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
