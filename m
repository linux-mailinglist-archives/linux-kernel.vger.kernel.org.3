Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336594A6A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbiBBCnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44114 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243910AbiBBCmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:17 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120687v022144;
        Wed, 2 Feb 2022 02:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HqEzxfb7vYcsBLxA1MHbi67kU0vkdosDz4gDWGEYaOQ=;
 b=j/KoMtGIowmHywbnPwFNlUBq2hJqRvwcnDia3SgqbELUsARjYF2Mzkqc5VEAvpDp59ix
 L6C79cHkza3FVYynNXLkeCEEYAc9pe6VlywE5u/2f3zr3dIzHy84Pvxn7t8tPzkDdtwQ
 8gFwVp6D52SxVVc2gPtJEQN6k3fhkFLVtpjm+tzwWoC4d756Nxj9UXc3qQad4nO7RNz8
 N8kUdsmP6/wqx5oneLJH2tGfHxaVis5m00/UuSDkeqHgBY07Zpxh2uXyEbNREoYriO5Z
 /lYNYbo/OFfLVzYAKH6UD1rvWjwryziihz6sfb5WVnB7BujrkWWRVXqwm5HSbrkjjRbX AQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvkT015152;
        Wed, 2 Feb 2022 02:42:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3dvumggtjf-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/6uQPw3Djzw44JYX6ayDby1piOSvsCgXiuXPo1vvE8Hr9PXJmIFJmMzccSGzxQycHjg1bfnd4bRKGt2BHWX7Tk2k3c5kb1y1hANgt9uLEK4aWy0ifvjomd3O2Kqh8LSrMSY3TC4gfkiMHpeiBdgqZEMTZqwIWYmG7Lon3n6gyRtlrgq46kSC1mn77yMZhdXkuQyJPjQwPm3lajDFOD+Fj5FOTmWnKLEkMDx1MIU74Re0pQy12mFtHdgqOQ1ptsw4GVFrkInvsqcQIqheNpNbvlAN3+jWTdFD1bznlF4bcT/BaijiVRYd1PbCgeFTjYdPtuMRFiBl6aAJNl/bjlz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqEzxfb7vYcsBLxA1MHbi67kU0vkdosDz4gDWGEYaOQ=;
 b=QQzKdwl6LJ1Lhbnklwgu8QfdV0HK6bKKCzOxGX1IM5k/xoQd7NiAo3w/cJTczJKZPo1y5TyLKwl7tsyoSyNKZTscjiJMS4hveupqH3nBQN5igfhFimWJSaeIkCjNqQRbh1bbX8mhtENbKI/dptt2bis1aCO4NPpCO7jmwIpSJoC6RNklxtV3pbcSiCGEqj+RZgeXshfm/fhHTJxzcLFWpjmI0oWUuFab16Ha/0B+SNPEVQLE7ouS3TONuOj5H5lUPtvcgnIvj+UbRqyWKf1ili79tzbE5gPNU9w9hlTIRtrut2KqNzPP1vQyQvtfbDaBbLIgFnOiLRNxZ2UVqLgC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqEzxfb7vYcsBLxA1MHbi67kU0vkdosDz4gDWGEYaOQ=;
 b=uYwFyzuOiag1BhjSRsbpEBx2gA93fdgvICh0Yi9gVPhlY67Zr25MjkAb0no0iks3uL488gSCMTar2/jl7eYW1Xrvqm6j6+dLHglqwdgn9wVMnoxufsNISraF9UceD4Tgy51UgZIyfOiR/OLZUMbk92YxxVXpPjvuERbwXNLSOPs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 02:42:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 20/70] xen: Use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v5 20/70] xen: Use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHYF953TGHnARpCZEWCZevncfPd2Q==
Date:   Wed, 2 Feb 2022 02:42:06 +0000
Message-ID: <20220202024137.2516438-21-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38db7e23-1863-43cb-db76-08d9e5f59b9f
x-ms-traffictypediagnostic: BY5PR10MB3970:EE_
x-microsoft-antispam-prvs: <BY5PR10MB3970082FD136DF9A1C8F2593FD279@BY5PR10MB3970.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9g+6NYK46oXBuXXvSDujDmKrxd40ZIc/XyZX5fW9yYxaqo03izfVapMZZAyYL08TLxNlOmsx9+NtYkgDh3tnS6asds/J2YkInFPnJ8yQ6QOnMPgHsU2MUhq60mf37c/yLaZayLjCy5ioh8ADRYrUsnvr9DWbWhYT+NwpYx2G7TOcQNIX/vWxGcWWX1/sePvfuKpnDtoG5zIuYcf7W8pLfsilejUK8Wbk19ip6KwzHD80ri4QenyGlTonABp24rHvniCOoW6Iyjr8uQf9Ld9tTq43NWpKfrUXDTGcE/AB+AmwBfuX2/LeoHpjvLfH0+hy/U4kQXVYbuXW+AAg++snu8NgkKv8Z+MKJKxlvNTOJ5URDkSgPxwgVwBl11yaKRTcy5+ET0Ox/EsDrn2lapWlatzC02JwOOZ5ItyiERdrdT7FlGBMdrXkQim8HS2+bDkA6wcFJCRuRzaSe5o8/l2A7BY5Dk8i28nMQ/Y4qF3tzkXTYqo3Yu4/sRCy4TYGPTi8EYBf7faQNyA3tt+FW9wXgXcnDCbCkTCwEsvcAjSzVSlG7rYyS0mkCujsl5g5JYZArHjYOWlIum/8Mf8ar7S/5ipq3N0KBazXyadLaEiBq0jOKNSPiSHAySAY2t5JOWNm0nsCuhmfKfMxS5oFa7kKuhi14S3O0PciLd5mEy6JAbqL9NiBgpf4czRBZ02xZJgQLitmwd/0RNI6IqTGYUzO8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(110136005)(44832011)(2906002)(186003)(66446008)(8676002)(91956017)(66476007)(71200400001)(508600001)(76116006)(6486002)(26005)(66946007)(4744005)(66556008)(6512007)(5660300002)(6666004)(6506007)(64756008)(83380400001)(86362001)(1076003)(38070700005)(2616005)(38100700002)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WUBugTTG85FOYcC5eLJfNt0XGcOapNZvNrukra8RH7JX6FVH52MMkN86si?=
 =?iso-8859-1?Q?kWVocUODtqzzyDpXyFcCLpCx51HNZaSQ0EJRqVElboi6AiFqo1Hk1zfcs6?=
 =?iso-8859-1?Q?SUrkyypFVFWg7UNNAuHF5lVa6yazj0CRAmogcJzZWrLIZx0NBVcmUE/ls2?=
 =?iso-8859-1?Q?WN7RNzgFT3hi2S83BejTkevMACmLtSauCKjJZb1s5HHX3NPP0/+atKoFrp?=
 =?iso-8859-1?Q?Ny17TxXjoHe9cp2MnAhIpoTULJ5meO1D6UhLS8NjM5PatvUXgXJq9wFMi2?=
 =?iso-8859-1?Q?yZYij4Yp9M/E1A/xvPfbuDmQ9RS1BMRADkKoQVwSwYdGNt3ZwPMC7SxmMj?=
 =?iso-8859-1?Q?V9t2C+CFT2UzLqUiSsazU3CzXZ56p9eZJJibKyNpK4hG09k7EItSbp2+JQ?=
 =?iso-8859-1?Q?wx6PNclx8eCB98hXpytf/Qwno3/LLqcDKNn1sCWYwIRf2bWApY/KCY4xOB?=
 =?iso-8859-1?Q?91Opfv4l4uNbaiSLdZd/++IZUeqtIavlRjLYRqGCvJmmwR8CPpW5NUalSx?=
 =?iso-8859-1?Q?3V+5pCm/N2e+8MvaR2yx31BM6t3BCrz1m7foNc9dZOJWWvg0J2QfSH0MKO?=
 =?iso-8859-1?Q?gaOVqHDVKiDQt7bx+m7NNXV540uC7EuwjHpazuHkdXTY9B7Bn2AgB7UZCR?=
 =?iso-8859-1?Q?wAHEuTzh0Jy+qWLVphgDhi5Wzzrz3mYX81EKho9qpxBTyf7rsGqYK9WiuI?=
 =?iso-8859-1?Q?mclz7IKjgE7xzbTRdYgMly3gF2OQVJGhVFDdLXNnD+2n4oJ3lGb7JXAleV?=
 =?iso-8859-1?Q?K3GV73P6daNHbPjOS4s6L69FwP0aHw2zzN9LJ9p7ZS43jewheFITkIPD5w?=
 =?iso-8859-1?Q?Tx6rOWwMwTJfOmc1oMG70BQg+gUVz5jFBH2ssSRqZRhN+pVPlYWVflLVNN?=
 =?iso-8859-1?Q?GtTJv1q6XwCrFfQNUMwb9swOgjqQpeRb541oRaUoO64yYNP0f2J5+6aR80?=
 =?iso-8859-1?Q?EZDV2htR8ZhzZt9SZd8DHuejBR3lYdgVRsqDaKXEcSZXwpHUYDlwtbTnBu?=
 =?iso-8859-1?Q?UZevbOBAH3qxGs9Ml/nIjr4/96bO3egpAXzShz2JRhYYmoo9wRIJtR0m7U?=
 =?iso-8859-1?Q?I0j5tUXr3kySanbNHS/eWczxh/0e11JuheV4hpsUsJAE82y2gBK8xmZcEL?=
 =?iso-8859-1?Q?3ns3zSmitXcxSsmvNJA3TBLFik9zP165+ln8oTCJRhTanBx142xYZ+Jgnl?=
 =?iso-8859-1?Q?9Eq/WmDao9dYUmPwK9fBpNOwB/JkJEoHtTKC7Ymm2//K7BvO2Jy0YYe0cG?=
 =?iso-8859-1?Q?nXWjasXQE3jMo6grgI85t87Z1kfjDCYIV3KGWgoFIecI3YVS2/De63oHvr?=
 =?iso-8859-1?Q?m1uBsICOkHCUOVeVOm+7DQBme3KfcN58oxHL7Vljo+9ExWKyxpGJ62Lf1L?=
 =?iso-8859-1?Q?JdNiLN3DDmpZBwjkhT7L/g7mtp25pGjHJwxXY96VwZC3r6EzuQaamxAWaF?=
 =?iso-8859-1?Q?7DzifugsfFtwv14eS+1W5ny/fhLyi4T711xcDdDKh+ZcYPFxZNJJ8vc0dM?=
 =?iso-8859-1?Q?nyxREZMvvOV0Rs5NVufCj4InCz5VPvlKt7fkxq2ornPi2eZDrMhwuYB4Dd?=
 =?iso-8859-1?Q?9DZXQJJghbrmkH782SnbymlnNHzpfAhIlAjft/Hi8vx7+v2yXwtlys4WU1?=
 =?iso-8859-1?Q?5DkWNcRS1C0fUKoYpbMBoO2ToYhqujTAOBorl2/AmX46reNVHbEzcniklr?=
 =?iso-8859-1?Q?RZ9OQ68dL1qZYhZhOrw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38db7e23-1863-43cb-db76-08d9e5f59b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:06.1580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJR/OcfgR95aX5FDBzyeMGWwrkR9ikcIsjX26PQnmC8LlR74iEemIE4+ShGj60deCSUBpaz3sXClUwAPf5SoRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: zm1M0GhgHccbhivmRufj3AatW9Vs9EWG
X-Proofpoint-ORIG-GUID: zm1M0GhgHccbhivmRufj3AatW9Vs9EWG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value since privcmd_ioctl_mmap() will exit
the loop if vm_start !=3D msg->va.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 3369734108af..ad17166b0ef6 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.34.1
