Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1763E4B6F52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiBOOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:44:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiBOOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A670F1045B2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:26 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FDCkJW007116;
        Tue, 15 Feb 2022 14:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HqEzxfb7vYcsBLxA1MHbi67kU0vkdosDz4gDWGEYaOQ=;
 b=ZCTMSAjrBKWl1UtnOIQ7qzsRqKvz/m4hIIgUPIY6FPHaMJfOZiPpNdHmuTq5Fn2F9KU3
 A1aeZDExO/pCl7k18gg9zNdBEfd20K8Rv2rFOlRYVjk2/h+nCt0dsFsjopBhBUvzw6F6
 iQGnN1s3MCCg7JLmWNj9Rh/vPdTXSFONEkjY9JolGQCcfUzKw99FiB8+1IpARN7aefda
 sTMCiCUbIPK9eERvlctOmkXoRoKIl7g1OVrhmUqfqMF/Dy/cJTSWJr21uP25w7KPiCwl
 W6yZGHg/blfx4s9+aH5v0zg5/cbmaIljoKO+yMuHbp6mmIkikMo+bOeROXA80Vz4PX0n iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeUFl145877;
        Tue, 15 Feb 2022 14:43:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 3e62xeqejm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7aZIwUilPjijGLia4VD04Ui2JRXfe6/AcWkjwsffW1swqp/dDe8UqYtiKRWokKEvwoh5XVoPfSfju2qQGudn6rjOBFBBlAy4qPKK1VNvLpY1HPK5z4Zzfhi+zn216bua0cEBdhryP+nrrL4plMc7BAm4m0iS/x+L8847SFVJZC0rgin470bQyX59bkEWtgEjQBEZIyIGBBJQ/vWOhZ9irEgszi/snmzSAlMBRtS9dUA8441CcHRaD6+/eZldtO6yYPzB/CXKq5KdEWYBSctNMFORJgaJKeeHDC1f9KBSc8kkTmEmQcrabpWmj4dvB0yxbN01tasyoCapx7r1vVrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqEzxfb7vYcsBLxA1MHbi67kU0vkdosDz4gDWGEYaOQ=;
 b=DHmiVzdLjyDAHyMgKUtOewd9drnEVXKfoC6hrqvnBE1RTySuUWgXWKl8DuUcTYn6husGks8WP0pFcdnu/vyBEnQvN/tsA6cpuGgLqutCME5QbQtTARXcxfJax3vFpLZy/iyUiChD3KUOKQ/dVxS28IWzr75oB0Yrq8cz0cTTMVUkx8gwkT7JcSYXadCoBdqnECYmcKBb16xNwuER3ghhPpMjY9kXYsPW1vOJuujGsoSMKsQinEkh0SycNyfprKsrYWjfgC9dLapVWJLuKgs3kSKuOno+GGzhcsd9qOObVsqHlWl7VGthX/oCdsRdR/OpDEEM6Ryw4u65hwdcjwp9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqEzxfb7vYcsBLxA1MHbi67kU0vkdosDz4gDWGEYaOQ=;
 b=P1X4ST4PaCMxPZaEo+I8Wm+ctLQx5wksNUvi0je0fp+SHJFxjufo2kJzk429wJGcNbAAsuMm+alkl+lkmRZs+0wjV4I15oKdh2+heArwDw2EDKusPn5H4hSoK2Zbvx7HlWJvFbijfj3nvM22B00V93oCwWriMv5kDD7rlWTNffc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 21/71] xen: Use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v6 21/71] xen: Use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHYInpanv/7ctYBJE2cR7E6rRpfuQ==
Date:   Tue, 15 Feb 2022 14:43:10 +0000
Message-ID: <20220215144241.3812052-21-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ec5891f-c381-401f-e836-08d9f0918002
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4689B5E42B3EFA9ED13673B2FD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFEyAc0ieY/8Hzx3sV9VCDNZRnHuWNY6h07RErZG5aDJt1cdS8Au6whW2/SfFZBqECoNrQWWsCr61wLGPmEvL32idkj63xeR+JLGohBfbn4QWH9InLqBvDTBxuGk3U9CH/35psg/mYuFEZvwYw+ET+9RgT1syQSyGK6Qjc8K55XxH+I89zhZJobAG5T7Oh28croeYXMEr0fPZXPC9XrJkFseyzdIl9+3yekc8sBbQa8iXy4AuJslBrXecjmcyOdp2/08LffgGI4lceiVG4DTie2JJNPaDJB978azBoxDOScyY5XM58loyyhAjGqavSrZAXpOiFREmcSjpo/dYkmFeeGqyc2Vv2I6Tv2K5Hk83G9B51K+8dvoDw2hrjvhzoWKFay6mDhT209G/HSy6fCF701vXpR7GFybEmkN1uEH1AffMrM0BNZ1+Xma2JpMLcJiN9MyRi4FK+k/rARIi3RZ8B9DVhBLzYX50KpOOmlPG6j2ieV5XJMnaxp+kcKU2JVZjhXGWJwlq9fqVeZpRMcT8FyNVEffoCdWY8Ul0JJo5qCtimjUhVEiOI6iU4PVd+bGfT6I1Ae7/JUqJs3KdtaQU5pTLE1N6h9UD5lqvptjuVd7kQKNQz7Utyg8NhYfR+W514T87Y3AFEFNkXaIzbHokNP21dbUI3DpKD3paqqwqPMC+tgmLb9O/gfzk8f1WVmoKOhyDwy0EmYm37pQ0xxJ6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(4744005)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zClYyGP1KgSpRlNGGsUt2W/PZjPVcVa8dJIAfa2U5QiXpT0VfKgeMZ+ggo?=
 =?iso-8859-1?Q?tvrQ8BmJ14H2dTG7YfWagYDUf8gN6uoEKu0itGPbjMXU3ATJqQjZ1cPUeS?=
 =?iso-8859-1?Q?yeAVgP1k3M4Er4XArE7AdF3tyaa7E59Heu2TWJudx36U5zVQmzoRDqut2C?=
 =?iso-8859-1?Q?/o1HiwR8xAqIu9mb76lQ2HmtbuZyK2qpzg1x0LbrsFjN8lWIVbLmCgZO8o?=
 =?iso-8859-1?Q?TikkY/v6E/KkG+gnAFD0y6mhY1DOtOuaqNVjUiMzZUA169s6RhV8EtwEdo?=
 =?iso-8859-1?Q?jvu0Q9JECAU/gUbLcsRx2KIrihsSVvZh1UUsWYISyRCQZhYnHHHZNL4klF?=
 =?iso-8859-1?Q?WkaVzPrhcFa3lizl0pHQx1axleJrgVW2/wNeoAneNHsU0GRj6lO6NZhHFv?=
 =?iso-8859-1?Q?xEtJxt34XmL5CQ40T4ddLLJ052M5ndbRe3FS4n707yDp3Gj+nHk+VTw2BU?=
 =?iso-8859-1?Q?Che4Jasp2mmFkCZfIodmn4Gtd1sM75A+EdurSFOR7ZNYeQiYsT2AyKv8RZ?=
 =?iso-8859-1?Q?gnvq9q+lVqG8NWwM0i5w+dzrmKPVNKe0zzBQd+Bu7QBz2SsbaXEwg0v6Kq?=
 =?iso-8859-1?Q?del/v/+vCADQL24ovhE5e+idTP04rB/AHSzC/wGUfuhnlX6hIZ1Tk20LjU?=
 =?iso-8859-1?Q?YDrHT2oKvU/WbZ5Jq9L9NItBKlTuXt0EDXMekDIyDlw/bbAwn+PFb++3MC?=
 =?iso-8859-1?Q?JdPWO/son+URp8H63DBQ0Wdn4pkVE+nAYfPZO2y8W6JQ6tuacjSGBpXMdF?=
 =?iso-8859-1?Q?lCWM9RsegpFBU9kkjw0rPNawzGDpBWAStkRvcRXlmQjFfrYdFGWJvHQRWo?=
 =?iso-8859-1?Q?XuzFAWPGmc49xcKFJhzHRcQqzDYXhuF14mRMHxbEPvTUAy4nAHM5ctiLgx?=
 =?iso-8859-1?Q?0duHhNsWAOR4WVNc/L0XB1j5oiiEfpTmRu7cpa/fXe2lJediGi0kV9KBz9?=
 =?iso-8859-1?Q?MXdCGBMXEb1/jkXLoZ/cNSP+TOYbOIEeUxbe7VlJft39hxH85PwfzzJCNi?=
 =?iso-8859-1?Q?UQ4MxOXYdObRcPtlygEsHRX/4ZvIyXV5C0cmd28goHUo3uxN45o7MgPMuD?=
 =?iso-8859-1?Q?kJzFGXsZw/0PXAcw1X1QcpMXjELbdSq+KoCdImZ5unsgMAjfkulEDca+8b?=
 =?iso-8859-1?Q?be6XTB/7QhgQqaBpPaqIPYqsK/Z0EW60fOoa0Gc6P9qRFF+sn9N2MriUPa?=
 =?iso-8859-1?Q?8/LFMWrSDppDd/+dyx/QEiOtC7rUVoka+rW2YAm4y+rV38R/P6djiz3W5G?=
 =?iso-8859-1?Q?ohaVqbrA5cVB9s02eVe+e7T6b022pcVADbMJAU2TD3kLpzjZ32wq/J53vN?=
 =?iso-8859-1?Q?HOVcdnkpnUUfU3LgVbbwh9MHuaglFeBvpABVLqYz92/IeOJ4vdaG3CJivB?=
 =?iso-8859-1?Q?GVIvWz2k3hdFOyMfiWm1+gCEIgRj5vOsfjqIR1eAD7WZ8Wit8aM5VdBtdl?=
 =?iso-8859-1?Q?H4qxIRji/F9yqiuN1Cyrbo9++4lEn+ZZzfIeMMfB6jiXwnUksEKVkstTqa?=
 =?iso-8859-1?Q?B/kvLlNjmklUaj+wFAqN9tGawJWya4IrH+NFZ7sI5H4SVFwsdzWFmA59Dp?=
 =?iso-8859-1?Q?AsxuoTXNSxR9gO8h3FKeqUJuJXVIN/8dZmDsWInc9mxcDgy/ILNsuAYRAG?=
 =?iso-8859-1?Q?r2c2j6hF+cSscOoQfPfEigOhufCt8EOalp47XTj3bIzKj1lWHbPCwFv3Y+?=
 =?iso-8859-1?Q?KeCcktQuVDI/Xax3xHk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec5891f-c381-401f-e836-08d9f0918002
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:10.1050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1faxnDSRF1AOUeAqYdsZ8py1LDSVPiVbcO2iWYsBolayBqMIePJamvIPG7NhCMrb9Ul5VuvZ0pfZT4+66oCN5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: tR765zlDMCqIhVWLeAyi_OdnuXNDxQ8O
X-Proofpoint-ORIG-GUID: tR765zlDMCqIhVWLeAyi_OdnuXNDxQ8O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
