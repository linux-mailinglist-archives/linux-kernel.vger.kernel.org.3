Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9D6469A93
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346148AbhLFPIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:08:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57462 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346572AbhLFPGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:06:45 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6E0j5i012705;
        Mon, 6 Dec 2021 15:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UBH8KUSZAhknUbXk0Az+52KwxyZKxkF9uz7Wq+tUA6U=;
 b=qeyfCOtikGbr62K919AUOhLrybm8cGb9ly+PUnjVc+rEuVtQr3NdVa1pyAVa59FWqOvq
 xtPhvq5/B9iKTYbeSqDBrZ2bFg69hDHs2JFe8CuciENeXkQ28jvoh7plywW46H/2io73
 /qvBBSu5CURTL4d5vu7aIm9gOc9kvVTGnLP03T8I/9dzATXumh0UxMtCIh3Xe98UEjo4
 xNs4gYMdNA4/DF3kbmcTt8iX0L6DDmzdCfJfFf00GpUAtadP/4V7Ku/57JZon6CBcUkO
 2uMZ9YL2bOW3iqvVE5c4BoJw4dKo1TYL5lsXFR7jm0OMwzPSDAYTiMY6ZubRrpsuWOvP eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csdfja807-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Ev91e065229;
        Mon, 6 Dec 2021 15:02:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3csc4rvn0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYV+8QAZfwOa7Rwt4Zdk2NdPn1jnmYkutyyrS2sAbcOliVxxUxBW4FtAzcrj1KbwSBeLFiIaoZdjalH7muSqFqTVFZBUpN9ozkCi+aVbtz0k3bq23DLFDFeflt8irt9glq5NdJhRHFuaegprXXPIImZ/EQB95EOBAJA5UqG3vf46LHzMWGUVHbgbcQDwd3Vm+kU9T3XvDKajtQdUipJ2EtcxoXQLDhWoY1KLlnC1NN7VyyNaoF/twJ7/1BoFlT4gnWCaTuj/sDrvfZGwfKGPpF6tweOIdFb31CdopbFJ2GXzRmvbLoHmSPoqN92DTlzBfxP95lR7oHZ6R8VK+QgR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBH8KUSZAhknUbXk0Az+52KwxyZKxkF9uz7Wq+tUA6U=;
 b=ROzYTnOUnpjRCuoaJ4SeFzv2eGd+5pgcrOu2KbKfpKAsnf8gmZ54zHScfDxEYrRdioomqaVt9u/I6o1EiZkmfIhwwBvzZsb7OFjzm9dBJBxnWYRcjYBVhGeyjVjCHyk9gypTmGvFLeUJOzDO2Ma9qXMAuOUJ78WqPj0R17A1/u5wxyIBQ81ri+wixVmpTZt/aO+nInqhZA0EBX6X94CN5Btsj3LVtpKqUwzlRzLb+fj+TIyTueDX3srknmbnxDYdh6MLUNIYNjKooTZfcKhY4yyO6spAHf+80B0Q011KDPJtaK+CSI2ct/q+4qo6JC2p7hXmC6jv3OZZWmIw4bzOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBH8KUSZAhknUbXk0Az+52KwxyZKxkF9uz7Wq+tUA6U=;
 b=wE+WppdwwrlHtNEZi+7uGUWxlR5/TnjmGuWanFLFp0jcT/qquXZRUCVrWXwqYDeJpZYeFhovjF93AzlPCpUrVRqvCE+mjF/2E6qTaVSWi4swc3bvZ33S3ty876deAYozFMTf5xfxLYiU7hnXiixsi+ylxzjdHiEDySPjZrHxsts=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 15:02:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 15:02:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/6] [ARM] mm/mmap.c: Check length of unmapped area before
 allowing MAP_FIXED
Thread-Topic: [RFC PATCH 2/6] [ARM] mm/mmap.c: Check length of unmapped area
 before allowing MAP_FIXED
Thread-Index: AQHX6rJX6FBp/aThsUShrgK33BavJA==
Date:   Mon, 6 Dec 2021 15:02:52 +0000
Message-ID: <20211206150231.2283069-3-Liam.Howlett@oracle.com>
References: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffb9a8a4-865c-4df7-9d99-08d9b8c97a34
x-ms-traffictypediagnostic: SN4PR10MB5543:EE_
x-microsoft-antispam-prvs: <SN4PR10MB5543AE7C412C570EAD9DF0A2FD6D9@SN4PR10MB5543.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /rt7NZzl0aI0n9eJM8iRh9F/C+EDN8/AOb1BGZO9upqVTPKYjP/R76ELvXdutjTBwkA2y1dpWzzk4XgQmxdXoMGIN/8cGH1L/GcbVbasSh9Hq6tAnA8E3OeoFZrldcpoHqjIdLEINDz7dBPLxZYGC0kC/nWfM8aCXsAheK9ANfYhRVJPYMBYxrTNXF1ndZEoPQ8SJ2yNIMWykm5uupKN/GqmXQvDhl9BCuo0xvL+aDcivu42DUBP28hBxUn7pxao8YxmlBvz/5zxmwwtD76JiCmVgEfTyqWNsN/wg9HghzIjRzNmLLFMDwKIAI2xWlGvQDpwrIJ/4VG/bFxTwTKUVtafUQzDeDLk5Qof68D/xM8dxd4GQTzK1gGCSJTbVLrr55wkPE5hlStbwgBs/0M0/mTyvbedHZaT7+bXxQFikCQpCbOOmnlnmvahaFTyG+zfL00J358YXiyTOIupeh+Svjo/pgzZMB9xSqhGYpyIgcbtZVMg/pC1XYfYf8K/qxO4EUdnhjkcU6EDwIK5+gYuDndSD/a+aRfAuJaa1hN9Cf9G5uKMkj5uitD9WOpXJaf3OvOpXfopN19SrEb37Al4pEfmicxSZJzSqZJlGNGLHNvrzOGmSkBHBInTUhen87j1zlk0fZOuVOT6tc+mvqKc8eBj5G7mzIr2BrVWNTde1jY0/tZScriHD5QwHCtwSPUABQhjzMRQfC/QNFodq5Av2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(1076003)(38070700005)(66446008)(6512007)(86362001)(36756003)(2616005)(66476007)(316002)(8936002)(66556008)(64756008)(26005)(186003)(4744005)(6506007)(38100700002)(91956017)(76116006)(71200400001)(8676002)(508600001)(66946007)(5660300002)(122000001)(110136005)(6486002)(44832011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7QJqBLRjUxceXUj8G56oNk+vsMPbfmO06fMvRQ/dV3w8BW6dfdxBTi7uTR?=
 =?iso-8859-1?Q?NnCmG34AkqvO7MZ5pNYjvG4leLdz91ZeIfjt21qptpVoS4TwrsmfHM+Gpk?=
 =?iso-8859-1?Q?cm5cADj8+ziRZJ52AeKQ8QrsxkzumT7qHFsHuQGRvhsit/01aW5Z0e8MyJ?=
 =?iso-8859-1?Q?YjTr9IHkfjHAgSkB6W4pO45Ey/y015VYhYLzFz4KmExfOHsdZnpFoTP1tB?=
 =?iso-8859-1?Q?LkyFbzUCIxGuDMn0YWE08WOjFKg7LurrvpXaOlQ0H7rXQEbzsrAbpjrCwi?=
 =?iso-8859-1?Q?mepALd6p3O0O4I6ShFUE8M3HTrO1TEsSllPGuKLpBt/IBd516EYGJ4pKNU?=
 =?iso-8859-1?Q?g638veQ66ZaA6WHbidB5QwjQA/7l3Vt+PFQltu9qNn3Z0n5xnGLD10KWxg?=
 =?iso-8859-1?Q?M0lzb8378Ym7TT25UtHwSLhR7hEJ8yrtr+A+KAEm2DOqDJMU76ojm05P7g?=
 =?iso-8859-1?Q?tlwPdUw0kUhr+hdenOfpEs8ZqcfGjQ/jCmNaJRV0tp1133xSeYbtrO9FSC?=
 =?iso-8859-1?Q?KmdXMPeWsBCoEw3r9dg6JJjvPFP6r5HJj0816pDUzjfsKU2aPylQh6chcn?=
 =?iso-8859-1?Q?k7qRdZfPKvnb3/+f3UhoFmrE3A/gHXCKL3bIRaZ2+L2KJO6Ve/AApRbK3N?=
 =?iso-8859-1?Q?+yNunXlEHApR+ZSvjmOYqQQUzsUvZHVn+u17ErRQTWW/kEMcXqKrhJIeCr?=
 =?iso-8859-1?Q?gRDCYVmhfx6eJ1/WE2crHV6MJlsUiyuiNm/J5HNcfIqFIUgp3tu6K+v0Iy?=
 =?iso-8859-1?Q?ND32U0hdCPMmlPpOT6ShftAkXcp/32lEvDzyPeegWJ+2dpCvFVSWA+yNKt?=
 =?iso-8859-1?Q?/fhGgE11KoL9mbglY5lo2t4JyKUykaehmlEZKbU2PxDwhCne9lmW0agHnb?=
 =?iso-8859-1?Q?2OV+i+C7uUYTpAr2zogogjr4r83T4wKnMRmu91Ze03slZIKw/kpknc1u2E?=
 =?iso-8859-1?Q?UEsriAvVJJVGMgxCLvgh6v7RCT7OzXkzrDDKjjRm8pbQzTWiePQ/1km9Z7?=
 =?iso-8859-1?Q?tLj9WdmsUjT2f04oQNcwgBL9grjjKi0hdHm2q6+7TvynVeg+tXtE311B8K?=
 =?iso-8859-1?Q?1o9SqZhchN8M8RAiz3cNparTiZVsB7/+UQ5ULOOEgkCtIHczEuoxxM5XqF?=
 =?iso-8859-1?Q?xXXDZyKOY1vohDgf8pob2AM6h3CSI1CHZOmrbGao3lV6CLfYqhXlAORbCU?=
 =?iso-8859-1?Q?zAH7eY1GTGwUMv0jML7L0KU//NiorDcs7zcTAyPZZqWfEVBi9keOEibkE6?=
 =?iso-8859-1?Q?iSHiTX8cpp83lbz94ERkJuKtEngYYgj6Pp75Y/PjE8rnvBFfgXF9eY+6Q2?=
 =?iso-8859-1?Q?hvJxDIjywU6KfbhoGkTc2rnASFr3eIaMqWwTCbwZFfHD8HxH8l6uEb+zOs?=
 =?iso-8859-1?Q?A/5JDFEoLhwDTEvsyhA5hg+r3clECy8CWsaFgmy0e8AhznJi+kvBQ21v++?=
 =?iso-8859-1?Q?83DAhNvSZAxo56juTg/sb+shgNbWjOvDP1KJQSkgFjKl9gaaztrewcLiRq?=
 =?iso-8859-1?Q?RQHz5qNg86uHnTdt+v6fA6w964s23jjADD+XMwiisX5hisZ/ZrpKPQjhe7?=
 =?iso-8859-1?Q?9gNZGhJYyeKE2E9XkhLOsE8g/wAcRC6BNf0A6E59KGKwA4in0nWu/flRzA?=
 =?iso-8859-1?Q?jKsZgy/s+WPY1XUTvn45iOv1isdiN2CJkhH0xcSV1VHtYlYTi0iAbVzV0R?=
 =?iso-8859-1?Q?2ufnNnDLqv34/18/cY4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb9a8a4-865c-4df7-9d99-08d9b8c97a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 15:02:52.7372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cIqlK7Xpc1V13TqJlL/HV31rw280NLXaQOfFj8sO2tcSEAtZC2jGlew7vDbs8iA1i+bD24rhUm9VedCD+I4Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060094
X-Proofpoint-GUID: lZJ1AkUHtZEcvJK3XkVpcA-IWGjrO3AQ
X-Proofpoint-ORIG-GUID: lZJ1AkUHtZEcvJK3XkVpcA-IWGjrO3AQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_get_unmapped_area() could potentially allow a larger than possible
length when using the MAP_FIXED flag.  The bound check should come
before the check for MAP_FIXED.

Fixes: 4fbe66759b2a ([ARM] Fix shared mmap()ings for ARM VIPT caches.)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/arm/mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index a0f8a0ca0788..cb135556ce36 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -36,6 +36,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long a=
ddr,
 	int aliasing =3D cache_is_vipt_aliasing();
 	struct vm_unmapped_area_info info;
=20
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
 	/*
 	 * We only need to do colour alignment if either the I or D
 	 * caches alias.
@@ -53,9 +56,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long a=
ddr,
 		return addr;
 	}
=20
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
 	if (addr) {
 		if (do_align)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
--=20
2.30.2
