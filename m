Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394584D45E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbiCJLjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiCJLjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:39:51 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F6713D43;
        Thu, 10 Mar 2022 03:38:50 -0800 (PST)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22ABJ6Mu003522;
        Thu, 10 Mar 2022 11:38:38 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3eqgbmr260-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 11:38:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEv9ARC1G45pwQrQ7g7HeA+rhxEp2dQNd4Q1lXIiG7PcytC4wOUH15Vh8NpKuwMimQrxMdMQMf1q4qR2c5lihcgpBaH0sXD4kIaSPnaAGkvmABr+7sttWURNlZwBVFZGWOLrckpeAh8lp7awzsLnP2nl/KhqMRnQ8GnjvN8c1pyqqCrBvm2duns5jFjbAhMxu5N3adSQd7refIoUzdDsLH3o/8BpeddOMuiQkKYSYbUYdL0mRY/PY+9h6vtjniM4sDB7qje6RC4TyIJb5IaasrPZ2yxLyEtzgcPo0j6WHydNbm9hqIQqiA15VxNyZEwqHPpXkJYa0tpQTNLrpLUBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAAGGCbWRyhblMDzORG60I5hTcmFhzlOj/eCLM6IDV8=;
 b=V0iKxy+2XQhq9NRgshB3MKc1CSP1Ysy6f0UGPAiCbTtvQdItICryboQTGrmdqMe0JhTm4DPlhMc2y3OepXyrKX4MJXaFklHpEF4gE6vb78UxfNpXB0nYq5DVSiOz6fzZ/5oK5v3QwXpNnNShD+JX4iKHBWqXNx2VvdqtwdlItFLCJ+TjcT+Emd7V+rrvF8rVCaHIjH+8k9VFg/qlmyAEddUgxWGRBhy01WAUoPdcfilJ1ctkRdftVRngLAaXULZpXCOpbQalyQLmS6hLvSMa7RGxT/PV888/wP7mtxuVRhQTuZ+R+GDDIYzWEi9Z22kh8wMcDBSjDgFh3t0W0AB6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAAGGCbWRyhblMDzORG60I5hTcmFhzlOj/eCLM6IDV8=;
 b=L/unSBhb5C4MSTOEIx1zrTkbW/QK/KI45+2FFBpsxhZ6W1dAj+4uXnZw401qXpfMMNLgapwFchyCAK98bVI5y1X4evElJmrWLilsx2FTKFSXk8RuAD85lyrScOoSwKFMlfdWiP18q6Yp4GbIhxhkB4NEK3dgPAfbXsr629r1tlgXj56j29oF6bn6xAWMDvBcYWUI2hwkfGNoNV3+DuC2x2QQusSpX7FcLlQ56g+VtxJgWfSqGlqpuZb9oJ9BoquUGFOnDoZgVKmOYK2hp7Zm4f/QhR2db0k8D0ckByf+wObXnxJ+3PnulMV8CUwQk840//OCsFMRSH3EQXRT0Ju6mw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB7PR03MB3611.eurprd03.prod.outlook.com (2603:10a6:5:5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Thu, 10 Mar 2022 11:38:34 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 11:38:34 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Rob Herring <robh@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add vendor prefix for Xen hypervisor
Thread-Topic: [PATCH v2 1/2] dt-bindings: Add vendor prefix for Xen hypervisor
Thread-Index: AQHYMfvSuP8YiJuDk0OiMGC/BZe6B6y17mKAgAKUZIA=
Date:   Thu, 10 Mar 2022 11:38:34 +0000
Message-ID: <20220310113833.GA187897@EPUAKYIW015D>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com>
 <aece6fd976980131120456800de3558e1e2308a0.1646639462.git.oleksii_moisieiev@epam.com>
 <Yie5P/vcBz44QcPd@robh.at.kernel.org>
In-Reply-To: <Yie5P/vcBz44QcPd@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27d16d02-1bdc-42ae-7ece-08da028a827e
x-ms-traffictypediagnostic: DB7PR03MB3611:EE_
x-microsoft-antispam-prvs: <DB7PR03MB3611B6338F3F321997882810E30B9@DB7PR03MB3611.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AlvqMv6CUg21B6GIImZkpdLM8vDCY9bI0R64vdgjUbLtROR3WbC1ptycY2aP+z84qwPaM29bE3xc/FpOMH4b/pQ+fZjQzJtDetkjiBLC3zuQQJK4+NX7S2sCJiVQaznrsZ42d4y9xBr+619FnX3MOa/gEvmCFVCnP4q7R+SWzFsdUTnJUNvp4rQzRnt8pNzdrjnz6ui6NfCVK+bzUCbEHtPQPfPzrOB/BLgGkDmkAO8y+8ZuerN90tRNRbyZMFXZIqRaZhu1DZ/Cjb91KXpaHrjmA2zBYCFTxBBkZbQqNCT8K9fQIGhFjB3zD/aa/R25SIqenWp4z1/CzTl6WIa+lPLcR63Or6KwDKWyZTWxFV7l0gqpmrXmxaUmFMRArR48ja38VZvmeTHRg5JhGub/xkzvg1hEO3LfvR7lRyUFiVDdtFKOsOmoRUMgfvhaigfpm0SYzOGdVfUHQdcX/tC756tOh6OsXhDIw50XvRPtPsTEO5jsbfQ+jhPjxwVNDgyA2BBCZtNEBWPA8Kkr4zgUlcXJJVBO0MGFN4ZnfI/zl5A0+QVUEmLN5geKKjQZUQiSfL+fR3i3JTbxeuWy3pxOpz/KSqE5T7E38cFw6EP+hIDLxeKKn9iOYtwo5Xs88kqOLnuLsRdWTalRoX6i/M8MXGVdTvHcy9W6d879IJmScUB5/A7FKwJpA9EeJSLYc67jxyQuYVIyHzbUgVn/t3/FKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66946007)(66476007)(26005)(2906002)(186003)(66446008)(316002)(66556008)(54906003)(6916009)(33656002)(8676002)(38070700005)(71200400001)(508600001)(9686003)(6512007)(6506007)(55236004)(1076003)(4326008)(122000001)(83380400001)(38100700002)(64756008)(4744005)(6486002)(76116006)(5660300002)(91956017)(33716001)(86362001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?98npYEttNFXg3qtw8uWvVozjpoumMfNOIBp7STpZnKdcsGjqzmy5+vxqDB6R?=
 =?us-ascii?Q?P9dyGgggmIpe0iXBYN2STDYLCeYFjVc909zI0gsTKYHdhClVsbRlrXKP5ID5?=
 =?us-ascii?Q?/hsNhm/SMmnCwIdZN8sfJchYvqwKcK1CYtOtAh+P4u+ZGQ9AqFS5X6SfZfAc?=
 =?us-ascii?Q?qiSR5EeNhdMLLbthM/HRe3YgGICZQYWvbw9L6LKzcxvfrUwVK4YoKpiljpjC?=
 =?us-ascii?Q?b4oA9q61CKDtnlFByw895hCNPvcC96sjE1m3gffe8unoJ64Qqa/fm8MO1pJA?=
 =?us-ascii?Q?ShnUtjEjPG+vyvxrRoUz4hyZFsQh+o06CdYToYSGwUGWyp7bvPawiMwi/g+G?=
 =?us-ascii?Q?zWh/GSz4jq+dP2PaKtCEB9ShW+TwgE301a+pySNZf8vDjI4kGWIk/r2Kf+YF?=
 =?us-ascii?Q?oILv9NE4J3shT0oeZHTe589oc6cjtCxd4EPUg7EGT+EE2pscmdaDJdpbguVc?=
 =?us-ascii?Q?pKLAzJ/pDdSnuvfxrXrrzBlHjTVnl1BeGuUxSNA3jAJUcouKi9l6m5cptu+P?=
 =?us-ascii?Q?ewaNhARrETvJ7eRBeLGFuAhY3n2KYgcuzgQmRkQBriMcmEfGh9TFRMTQ9Euh?=
 =?us-ascii?Q?YKu0U466ne59cXaevzwLPpvEbQNQ3LMC8htltPObLTtT2QBfTgx4VthGlLsZ?=
 =?us-ascii?Q?FBuqVfjYSvLBbqFP8Qh6VE4ZFkW+/lGs2k4i9tfaB6oen/vWFn9IZhQCv9F8?=
 =?us-ascii?Q?0g8iCDRsLfTWDMA/4jiW3o+As693ETeQxnCCtazTsxpevheuVwRh2qbns4S8?=
 =?us-ascii?Q?Oumqae8bIeOcGYB8SpWW8lIr8OAWrlkLgXyfJvrw/hIqpN36H5c5lHYq39tJ?=
 =?us-ascii?Q?xfx+VUwg9R/900l4r7/N4x+f9asqYPH3kSZ1APmdCvZ5PoyqCoJ5BM/qLYIx?=
 =?us-ascii?Q?ZNt6ITMBx88kNJ/Lalu+FYBLUBCbj39vhNFkFoeGkZNLJqv877nHw1Nvz2HS?=
 =?us-ascii?Q?YKie3/6CHsgRNl2U9feTuHRJ7UVwKoHxcyjdYpb4xsY1qgU9VHunogyqw1VR?=
 =?us-ascii?Q?ryuL4bXOG+WqOHhlOhlLWqLENqcPtMY824DJ1kj/XkO2Aa4I6OqiqzwhlbQH?=
 =?us-ascii?Q?vVXbUzGGvcrOgmkg0s52l+idsMZEMCX7RdFQPSx8URvYKcyBjfTER7Wl594x?=
 =?us-ascii?Q?B5aMyofyuIP1QoOqu5XifvRgCWWuf1QfHcyGLivKrykZbBC1lWubBCvEIBN4?=
 =?us-ascii?Q?3FQL4QvEFA6o8ZgwngqzQqW4MOu+ms/WJURacjI8sGgVGI0adw+Q2193pqTR?=
 =?us-ascii?Q?TZndZoTRSdZNo+h3bfRYewHoqZD7QHt7L7OudNjSmPRmw6oaHpeCKtLTuquC?=
 =?us-ascii?Q?f5w6eR2n2iZv9KtNdxFsIE0t4QZeW4lIlPRiz1N8j2s/MVojS/pMW9uQG8BY?=
 =?us-ascii?Q?8Q4ydDgnYbS6SKZmQld8g+zD4ItGIlgchI/Lh/7KSAIHTE18+UH81OX/NmDm?=
 =?us-ascii?Q?6xm3EcCfiCSzkvUOoyol3A+A2RcpWIYyAQr8I/X6gVlSwThdB3BZUxOOlT6C?=
 =?us-ascii?Q?8QwBJSL4nd7cJujwR/xWBeA7j/+iVsF3Lo/VNYiiT2zPyQ4VO+jOOTBCaSib?=
 =?us-ascii?Q?PFAwv55d5C2v+1C/8Gl9fd0vxJMMqPVjBBHDkvANWwuLwTNfGAcgWfrFuIUH?=
 =?us-ascii?Q?7QGoG0QX77Ljv+mn1UYFSw301pTiWCw1w7fJM1Vks3ZuEmwKKHkPG0x0X2B6?=
 =?us-ascii?Q?pKkd5AMezbK4/s7p+UN6ikrLe3Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9250671E015FD4AB2D29D151565D55C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d16d02-1bdc-42ae-7ece-08da028a827e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 11:38:34.3011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdIChTSqiYcT2J6fCidjoRj8IBs9BilYzM8I6hraMFh4INsg+VP8/4ebNnY8hTh7x/Rnrg+jjdKJapMWO/18Ym92d+He9nsiVYChytbSV1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3611
X-Proofpoint-GUID: 5R-FwF5WAlzeTJrh48RbwS5UvaPS8RY6
X-Proofpoint-ORIG-GUID: 5R-FwF5WAlzeTJrh48RbwS5UvaPS8RY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_03,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxlogscore=854 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 08, 2022 at 02:14:55PM -0600, Rob Herring wrote:
> On Mon, 07 Mar 2022 08:17:43 +0000, Oleksii Moisieiev wrote:
> > Xen is an open source stage-1 hypervisor.
> >=20
> > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
>=20
> As 'xen' has been missing regardless of patch 2, I fixed up the commit=20
> message and applied, thanks!

So IIUC - this patch is already applied and I don't need to add it v3?

Best regards,
Oleksii.=
