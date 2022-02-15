Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959DB4B734E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiBOOrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbiBOOpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77CE1168ED
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:19 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhxck006513;
        Tue, 15 Feb 2022 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=A0HnWIGT/rG1GbnjraYQx+b1pevqHIpGDry9oirHVS4=;
 b=QgX/Z2byNLfUz4x5G5lZS3yO1k3bNhO7NejTkHj+JPc1Y3kVSYjfhYC1Q3asxLa+8jW+
 Hz/AkGDrQATWx/dmFZCPeg/ZTzHUHODdWDCBYs5NXiDGfjIaSRQG7CvG/3k3hsLpsRaV
 Od8IwphLHsTofjJ+7lvz53GfmpEez4IYeCINWIPUeEDApzHjVFgotX8/GdempsKqoSuJ
 kgi238rP4J6eXg/TE+tueGi0Te1qRJ+VOlHecWISmBR2cyrJAT6f1Vyxn7LIkAFYs9Pr
 vAnGfQc+IbPO7p/amkNu+VVFkNDY3ekU2U7fqfvDvgrVWeX9xezCMy8tJnv19uTI4TAn Gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0hgdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8lp016243;
        Tue, 15 Feb 2022 14:44:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3e620x7vn0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGeP5INN/l9lzPEm2dOeFygDYC6jS5ZmdXTCnzPiHsmqd5u427vrnDQB/JAHthD1s9joVMiHn2qJUjxzrtxxPxypDEyYORXrZtOQiwilOggsqP9wPAJ0edDybH6zReYtPWeh2Tv18Pmjm6axrZhQTPuLdky1HOEGvIMGJHyIHUVRnWq/wfA5VwlXblvbXUC5JZ1mfxjdAInBaor5qxX8HY5faGXgFPw6XquvkYrI9dAemMu8IJ11Si12kZsR4ZvCpP8Dt8VV+aj82paELfOpccx1E3j0vsTE61PWWGRimwcU/We/NJJk2ApYoENvxXu+8PChLcnfC8ZrDuj8L88Vwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0HnWIGT/rG1GbnjraYQx+b1pevqHIpGDry9oirHVS4=;
 b=M+tkFX4DRG0L8Bd5e2Gg9ZiK25uXj9t5gWEFJAN9JAHfDuIQz7r+/f7LRGWAoK9aGrHfIj4v8+QHWdnEs3WBzCi+dKUi9l8vuBwVqj4FMbDcteKrjhv/9KMcbxml50TGKq37QgcXHPwEEanH1ZyZ5M/5wVI+/PFS5l59UKxGlMPpDjW3CAET+mVu9CYlCv//g5TmefvQyEZ+mbXgiLz96j+qvpM53ZNefof4UYKPNJY6/U1YHCxAKAPvDVcCJkTd1ZypUpMMvdv6pzSgpebD4Eg3snRyvHChwfIvpgo1xZLNcAH2dbihQ95P9eaX/p24ehJPEIQ9F98DpUGfKbMZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0HnWIGT/rG1GbnjraYQx+b1pevqHIpGDry9oirHVS4=;
 b=QkXxwx+7Xke2nZjGNW8LMB7Q7yzBstzEcOHD2qCvoxVsJu73yVMuKIC/bgpUGsaH3SQRCl1LyggCTPDSGnBWJcwvhBWJGdpeBYdKU33BPwxUnMJQBlBkHr29EsIpVnAf8oBpFNCM4aWC1eMxk+ZxFsNJw3uxlw5ufojPctfumdg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 56/71] mm/madvise: Use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v6 56/71] mm/madvise: Use vma_find() instead of vma
 linked list
Thread-Index: AQHYInpiaFXnhZD6kU6bUyhlP1XzNw==
Date:   Tue, 15 Feb 2022 14:43:24 +0000
Message-ID: <20220215144241.3812052-56-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48bf8e76-8daa-42ce-bca9-08d9f0919aec
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB18632D50B4941EABF67B7D39FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gmd7txVp492qZHrMeGS/9AqRN0JafcJ/O4DCsBdICAFoVNXH9XGpPTQ/5itnjsay28tXq/ItsWb42L/LwxQFFc8aeT8Z93HvYQC9uOmjF9k+bsLTCdM8CYL/3VVaiPvB9vlnsI0TIyIuMFccpYOLTCy4DY4TFwJqykNeSMusYnsFozn53OyfuRag6uAGjXEDGWlg8Dc+0DNQm1xyiQ4viD3PxPL2DFayFelVroN0OryIGSGy90womhIjdZh1pnATErX3qnBVSXgR9Fe0PHdtxV22ZwzSiIQ8mShbeDsBmFKvfTfIfBtu4rDQMTbJOpFjDPenYAEhq0uK3koRNdRRkGdOcCTJL+Jzh3ac99zuZh/Wprr4EBDaHewrDj+YZyGiqhPr6qYCVtlBNie8jNl45n7Coqlg8aohRp0kSgQ2lIQfivLPlw/14ziEkp0h6gf6XLWOt8DeQYRcI3AwPNTrIp7q/Uc6Ejfp5qD1H29Zyh2FUWZFQoVGk/Ao0I17v/OF149SiCKP/XncyWe+WBgJfjmXPDwI010Ua9X8L0f1B9uLD6XglUTzTO945vu2MfAV13yQrgVeTzW9WYICcx81QuydPz7XrA5KvjmcF3eq+ePAXQxif7r3bDoGNDZ181KWPPR8vngHkgR/TnYAmZ2nrNNo1X2TxltXF0orSu4kNGq6i9qj/zgIcmQLopHYKCOLgv2Ip5TiQ4l8FWK/u1sAHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PYSIHahfP3qDm6RKkiVNTs/zvjddqq9vog9Z6ichkXLxK9vskfsRxm5m0Q?=
 =?iso-8859-1?Q?uZZs35CLo0iHz8QR16h7UEnWYgdTiiQKoi9zhgZ1NdRw/Dv1BkLM7idrLO?=
 =?iso-8859-1?Q?+UC0HEw+qL/QeVaj+7tSndO78cCboia3H16Cfgd7HFuG11STTEkrzencNc?=
 =?iso-8859-1?Q?zweFcHPvE/JNJC6MYvrQoliAgnnJCyjNlnWsWIRqQK3QkoHU0zQFlnH/Fk?=
 =?iso-8859-1?Q?U5EBjlIfJlRLa4+ovA/+6hCA7qoM7tdPFtuCPfWNmPFvBzuRKserhQanjg?=
 =?iso-8859-1?Q?j/i1JVf87lRmp18SrQ++oEJCBQDmc8sBjib6W8Ee8nxCxZmNdP4iSeoTXa?=
 =?iso-8859-1?Q?SAdr+Kit+r4Ll6a9sO/pyHp2pZ4gYXLleukjA0K+n6z1m/YB9fCihpD1Be?=
 =?iso-8859-1?Q?4qnJBmgKQsk319ad60s7tcv5QqKLCLF1bLWCq2u5KSRDQJzaAQMMyfHPaw?=
 =?iso-8859-1?Q?ttQdQxrgaVNN5HbEQ/qFXDlZDPmCRIrQ7F+DMT+BkMoTu7wf+hQZl5h3J6?=
 =?iso-8859-1?Q?9LRVgIM061QgB/GiDJeofgQEqN3f38AgZalySnF0Jy3vTj2pte3dwXJ9lG?=
 =?iso-8859-1?Q?0714P2PqlfCHEmjFtmINdIL4WxWh9CITjW61Xj5vCdacK6qb17JTpbsZct?=
 =?iso-8859-1?Q?BAQr8SYrmieUiNeasxDEoGth6eEHGmvdZ/43pQfT37M8Xy7DczP5ATpVn4?=
 =?iso-8859-1?Q?1dfNv1lmA+5aBMmAo96i+4HsxF3uNVtRID9phmcbb0XsO0ga03JxQeBEe/?=
 =?iso-8859-1?Q?e3g3CnN14wv/cYWlvoTBAv1np8Vd167+5Zx/baRJsp6dof5ggkrtQa8gIY?=
 =?iso-8859-1?Q?5EzuNmEQdWpb43gws2dMVQnp0/MDshiMe4ElpniSeBvh68MdszJO3aNheW?=
 =?iso-8859-1?Q?ztnJD2SyQcXdCASxbW8AjKgnhTtoiOg3b4PksOrD2VoeM0K30R5zJFSkgK?=
 =?iso-8859-1?Q?EFWBUCxmX1fzPdmbPov/umjCTRMarEUUirUYVdpPOAtK35cjLqmrQUd3N4?=
 =?iso-8859-1?Q?UAOhm6vWGdEQra2NWenTZUFOOlALLHD0T6GznSDqzaqsrwhhw9Fds6LmVd?=
 =?iso-8859-1?Q?tr4GQd0zsZ76NOGVZzxmRCoKB29DoXg1UX8EPbNAU9cbzuFs0Xc/IYNLw+?=
 =?iso-8859-1?Q?sbbmv63dpaz1yWZCvxN4WabPnRLPLRD3bk65z+7G1xneSYsPiySHZ6q2GU?=
 =?iso-8859-1?Q?GrimpKj1Zgwz2HszsCEPgX/q2wmE/mncFx10c/NlOXfmaChlFiI3oz3gZ9?=
 =?iso-8859-1?Q?PwvTikq3wkj7PUW/nB9Y6pVVL1BR1YfdJPi3CQ3Lzw7KlMtM7SqTj5+oIi?=
 =?iso-8859-1?Q?89SQobEjmJmg2iqdS8wuFg9ZsjiWNEaYzW8uwwGHpMm7H6oCrmtgbqtNq7?=
 =?iso-8859-1?Q?+el22IrHWh1J27wDMA11fO+yIB6yfTrAZnHkp984GHk0khRdy+/AU/p6QP?=
 =?iso-8859-1?Q?rB25Uem8AyQSLS+fReEbKFHxPxzbN9eXLeuaQ0Yu5Z6wciQmgNsymL9rR5?=
 =?iso-8859-1?Q?u08t4iUiudNI8YuG3qFMaqw4ar4e+v4kGZG5MEspveMkSdKKVL6BQa+3c3?=
 =?iso-8859-1?Q?oKbsHNC71jIUM2mpB45uy6Ir1H5qlHTzZP3vOEy3UxVPYWUt7vuil3+JuT?=
 =?iso-8859-1?Q?Ut8Q+sy/2OwabPmnQGT6loh6b5HUhbuUkGSnChtzhYy9mhXke/uDVG7mIT?=
 =?iso-8859-1?Q?Mfiqh1PX1DiKvaSieH4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bf8e76-8daa-42ce-bca9-08d9f0919aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:24.1353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uMvJ0boJG0w5oMlk2645w5lVCC3Zv5xrWIXtTetvcAH4oE8VIoStrL6Vl+evrfqYhhXRllGF/FwndiaZ1Gylw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: fXzWO46wAXq8-OgDuVZFEDs3WwkOA_xp
X-Proofpoint-GUID: fXzWO46wAXq8-OgDuVZFEDs3WwkOA_xp
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

madvise_walk_vmas() no longer uses linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 5604064df464..2d3210e59826 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1213,7 +1213,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned =
long start,
 		if (start >=3D end)
 			break;
 		if (prev)
-			vma =3D prev->vm_next;
+			vma =3D find_vma(mm, prev->vm_end);
 		else	/* madvise_remove dropped mmap_lock */
 			vma =3D find_vma(mm, start);
 	}
--=20
2.34.1
