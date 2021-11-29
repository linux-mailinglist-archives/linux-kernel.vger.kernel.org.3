Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8892D461013
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349771AbhK2I3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:29:20 -0500
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com ([40.107.237.80]:49886
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241276AbhK2I1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:27:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEl4r4vP56GFM/rY1h79CKoGDsLZ5z9yzqYPk9LZ9v3FxFFHeIJQX8Iy2Ardz+CHH1JyHcGwwiUmOWuc8AB+TDAJBl6eYxzAlsxxmNDhyUHH4wEh7f0E387fhh9iXY8tCFqXEtWp3TRk0UY6bmh/wxEW0YcegPsJJFZOWdkqNECFfNFTdbRxI/zRullPNGiMDWu9KvSNy18atFD8gqe6yup5Ir7IJPkECIKCSATsFVjzkvH95gSkiuDwTN4CI9FqaQ68dtuhUxewbDqVsqrSFIZstaYRUs5z4l7FYcXFDr1GGOpv+OGN7Mzgb3+TcK0dcQ3MCGpo2T5Z1pDahjxkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1n2MxdNZlp7BHnP4Gmqp/was+fXsxt8L4MZihUE8hk=;
 b=DHC75ht2OKIehnWVcrScUVcR9Y+N0Ers0HJvclHeqpaz2QE35/Vn4p4ccaaw+MGQ4sPagHm2cdL9lIVbLUZbvEqYs+1eLcT03oVQSxnB6RLZWsiByvVYhEF/eAAD7qjcG8+LkGIq4Nipfw7DmyqqrWHGqT3E5Ai7f1VymV6clzGqdGF98VseZFNws38dAZdiehMbJeqOUf/Ie9/qYEs4bv6sP780I7NjfsOEFmikSfvhErSkdAdvXwwY4mN9j/35h0N7I7gGrPOqLa48AwKrY4eSu+OppNgVZNv1d4IRua6xcyuzxfnxMZyZKo3mgAJr0vfIrqv1tXcuV8XyeqyfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1n2MxdNZlp7BHnP4Gmqp/was+fXsxt8L4MZihUE8hk=;
 b=eUxC3c0fC7RoXI4fDMEIVPcOqvC/Ne/j+htbdBcxN7iYjSb/jN5L0E2vRquimCSEyeAJi3Utk5ZMbcTwxn4zQOJL/XkQ1Pqsfzbo27Leid2HonCLOxvLe7a/GBxzu1vDIDLYW3FVn8eiYYiQdGXs+tZ/UUyd/CB3A6+b6ZfdyzU=
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 08:24:00 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::29fe:44b:80f5:f343]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::29fe:44b:80f5:f343%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 08:24:00 +0000
From:   "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
CC:     Sumit Garg <sumit.garg@linaro.org>,
        "Rangasamy, Devaraj" <Devaraj.Rangasamy@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Gary R Hook <gary.hook@amd.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] tee: amdtee: fix an IS_ERR() vs NULL bug
Thread-Topic: [PATCH] tee: amdtee: fix an IS_ERR() vs NULL bug
Thread-Index: AQHX4UMsu+mw/I6jVke3bEDVbTMv/KwaMcqQ
Date:   Mon, 29 Nov 2021 08:23:59 +0000
Message-ID: <CH0PR12MB5346CA4DBE99A795A1B6CA48CF669@CH0PR12MB5346.namprd12.prod.outlook.com>
References: <20211124145404.GE13656@kili>
In-Reply-To: <20211124145404.GE13656@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-29T08:22:11Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=94327e18-1081-4030-8460-6b4fed89a796;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-29T08:23:54Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 9be9ed5a-aae4-4de1-b0bf-11040b82fd4c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9accf90f-0e37-4466-4b5b-08d9b311984c
x-ms-traffictypediagnostic: CH0PR12MB5386:
x-microsoft-antispam-prvs: <CH0PR12MB5386C2AFD47E3704A47AAABCCF669@CH0PR12MB5386.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7XOe9IDTDnGGfrzEqYgQJl6FKQlASiPdo3RLjONzEltbLAr3iSt63X5XJpykBpVyIfuzNZgxCvPA8s/PqFcDgTnYQ8fiJniDxZkRzphsInyLFHcOskoW9JeZ9QE7XPSuWuwnWPkLOBkysP+5RwK2DcJiO0DQ0tneZoGV5XZYCBq/3n7UhJPjlC/um64oVe60+VMGjmD7CAJ15P/YRtG0goIAq1Vu647VNnoEtNeGLvPKI4E8ss8T8EjFC8kaqKT3YovDXE+ONqgyuC7c4aOTB2qsRkVNEdIaYduWHa7EfIljr/L70Ow2byCvib+bsZ8YUbVXickiSMAYKm3nxlOeHRmgqO6FyUFR0SN8b9fvrI0zOtdu4Fb2D3FIJxzJGnuiIQiGw1NOQVSHutWX4tzTRxY8h3n2TFKAHrtOJn8eWI5tGlizCDnjk/goJ7m81WyPX8nc6udQ86vWBOskVRdFus/r/r2DgpoX+5mLo1aCHBDCYKdQ4hoC7PvJ25aPfl8z5KT6IT7r4puIPyIPWX2/Qk37Oy6WGeGMBIXhzUli2wwgUh1pD804UFQ7ljmQrNcHZUPb63mAfPXKZWViS8lfXQbsoZn9dM54cTlLvOL2ZJ9CoAJwtL00gdsCKP+yZHlXNiezfHFR/aIdWUjfXhxMKRrgchp7ZM1lma/uXnGCNo0+ryQ6c2mHjUE/XPta/X5RJNowOM/ZSyL9EQ03g6eBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66446008)(66556008)(55016003)(66946007)(26005)(9686003)(2906002)(66476007)(508600001)(7696005)(110136005)(8936002)(76116006)(86362001)(8676002)(71200400001)(54906003)(5660300002)(83380400001)(122000001)(186003)(52536014)(53546011)(38070700005)(6506007)(316002)(33656002)(38100700002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2YGRhAlOWffnFFG6XDIzvWHwCJGX7H9mF2AjEHrTXAXiMvCC61rZooUgV9G0?=
 =?us-ascii?Q?JhfJDSiSWfgb69F0hgXRM2v+bZB4+cguA8lF5toTUAlkvumw7XCCUHlfNY+P?=
 =?us-ascii?Q?qXiNXFloQIiilkZvbnJJhIn3TwoVyy5rlIOXuJUTT9PY4w4DtrigkiSWXwKM?=
 =?us-ascii?Q?CmiAEB59HX2J4RLViRr8mbSJSsFUQCzXCt6grwEfF++qS6S3KXk34QvgpZTe?=
 =?us-ascii?Q?TBDFOSKvrrTo/ICJdH2/KR4uCrGHjKUHvGfa2FkGRAj3gjFPa7Adw8DGtnSZ?=
 =?us-ascii?Q?4VtwN/wU6632cJXnXnTCBV4hNpwnpVdwR/Jbz6bqvXtB67OnZAy6Ze3SJyFs?=
 =?us-ascii?Q?jNioEo+taYHuZ2JmOtvfnhD3QYeHfJCuBIk9K7llW/IJa4uZYg+cAItM8cBk?=
 =?us-ascii?Q?6DRoJ4ibgh/7hIY3cYS7dUmxBrw4U2YKcKXj0F2gXKU90PyRbTgH9iGs4TA6?=
 =?us-ascii?Q?IkoH8RwNe6QuEPqWbd5P0F4u+dssawP9p5eCVs+A5O0XonSnulqWpXxMwFp4?=
 =?us-ascii?Q?CNMLO9r8JPQfu+VEc/DukKiFzWhGXKP3M0fzcpe3Uf5OPgYQF2zXaN6W4bFq?=
 =?us-ascii?Q?YHMWH89vWPIw+c4j0+h3lmJ9kAVajHmgGNDHAZptOU0Oy4cufV3NX5yv5niw?=
 =?us-ascii?Q?diKarBZEUE0soeyUJ3Tr5+O8HRpnKbquezukMuLTpZMrbtycTcMwnVYq0suq?=
 =?us-ascii?Q?aaE19TjojiNnkaiLnseQrIshjPE5lheUZBfJC5ILDqniJt3YWgURhgw262Av?=
 =?us-ascii?Q?4FEGgOgLYv3k3/ufVGl2b/ksVJLd1A9VmnxOQ0tFOVFQ7KUkVO4261AlK9py?=
 =?us-ascii?Q?4b4tAucn0J14Pijlz+oxJPZyEA7lt9Y/QdYuXzu5617VyWbnY3+ixJ6XfX0n?=
 =?us-ascii?Q?m+LUwfXGag6yyOASDKLhVIKZjfdRMGaXelBOtRSYG3xWd1duLuqu2FoOkRZO?=
 =?us-ascii?Q?fPoiJAjZMspGd4MVXeBlXaF3jyAGdpGdm/r9qvszAK5RyyF4waiF2XrrVopS?=
 =?us-ascii?Q?Flqzilgw03Cec6vgp+kYHvxlMXyqo3EGedrrO4MXxm4tsc4CrzzQ8oeoqF2P?=
 =?us-ascii?Q?wV9OFMF1rzoKToXSenFssnBsG1YdKYfT5QevWIJ/HDbWLKd51tUWW7ftz2zg?=
 =?us-ascii?Q?2P9PIF/dvPBCxzmCNw7QKqyCUfV7jnzJETsTYQ2GSEwuQjpZiRf+KrDBa31Q?=
 =?us-ascii?Q?M71u+Zx7S1iQk7XWiMOtXrSV+vhcI5W/uE41VG1T9kaeZm2TrnYqvFOl4GQT?=
 =?us-ascii?Q?1kzEHgI2uZlFM8Lm5E4deUWYyBIeUV83lN+gQOJ8WXcPsVtRCBxZpyVleXgu?=
 =?us-ascii?Q?tJObvxHNyprkuZSf8yo6WK9zBfnUh/dI+tNKZr1Dtr83cC68wt5Jyo9E6PAZ?=
 =?us-ascii?Q?J20Y+odj5r6SChvtl5dVGm4/joC5j2iWjG1Atz2KHDxMziPFnH2beTH6ksYu?=
 =?us-ascii?Q?o3aUWuw1DBBRhOLyxRWDp/VCA7GJe6to2RAgS9y/kwUbb3tXbjJmda+yhSXY?=
 =?us-ascii?Q?X3cWEBE4Krep+Ro0BediXxyuvNxypFEkqkSWIOWSAGF3ueME2pt7QPm0gZl3?=
 =?us-ascii?Q?csNNvSa/jqZd+KxmyIBEOXyEK4XWOnnVrpzbLHjvlKM15j2oSWczLP8v/L2t?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9accf90f-0e37-4466-4b5b-08d9b311984c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 08:23:59.9652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYG4nWz9eq48nnY5106DQxNmwiNTYcLjWojD6W5SwZKSMYYqWIcGwu5HIqCC3jvPKb3J0wr9xoOXiAOt/BdIAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

Acked-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>=20
Sent: Wednesday, November 24, 2021 8:24 PM
To: Jens Wiklander <jens.wiklander@linaro.org>; Thomas, Rijo-john <Rijo-joh=
n.Thomas@amd.com>
Cc: Sumit Garg <sumit.garg@linaro.org>; Rangasamy, Devaraj <Devaraj.Rangasa=
my@amd.com>; Herbert Xu <herbert@gondor.apana.org.au>; Gary R Hook <gary.ho=
ok@amd.com>; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org=
; kernel-janitors@vger.kernel.org
Subject: [PATCH] tee: amdtee: fix an IS_ERR() vs NULL bug

The __get_free_pages() function does not return error pointers it returns
NULL so fix this condition to avoid a NULL dereference.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tee/amdtee/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index da6b88e80dc0..297dc62bca29 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -203,9 +203,8 @@ static int copy_ta_binary(struct tee_context *ctx, void=
 *ptr, void **ta,
=20
 	*ta_size =3D roundup(fw->size, PAGE_SIZE);
 	*ta =3D (void *)__get_free_pages(GFP_KERNEL, get_order(*ta_size));
-	if (IS_ERR(*ta)) {
-		pr_err("%s: get_free_pages failed 0x%llx\n", __func__,
-		       (u64)*ta);
+	if (!*ta) {
+		pr_err("%s: get_free_pages failed\n", __func__);
 		rc =3D -ENOMEM;
 		goto rel_fw;
 	}
--=20
2.20.1
