Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426AB4B704E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiBOOsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbiBOOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB8510610D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:47 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhjbv005590;
        Tue, 15 Feb 2022 14:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xHOLWyEuLxVTBV489q/jxBW8V9Wh9/jwRlyKVPc/pJQ=;
 b=OKgmK+GcsigpGLOwHpxORhuwN78KM0Va3ofxYcMweMs811wS1dxCke+LK9tWQZ25wl6K
 lPqorAInnnJrRQJFVZdE1VyGHtERCfzWiXXcQlXNSs7NkCJ6vCFaGEGqvhvm3/vCGDN/
 cvb/7s2c87I4sOAKvHPWiBzdzGznWxxdf08nLQ/+6tZZaqu9tcbtVrodCwt3rP/figjT
 4MaVCnruQWGRfcuRChio0fLm22Mlz7yTjUTCo976jPUfCq6uzA/4E0E0UU+XbvoBmOKt
 OZgNptr8qpGmBKu4nnCnf07rjYR+G64FsyW4nSFtWK97/zb7doIQ+uNJ+S8Du9sKW9/Q Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e88hgh4k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEe8Kx157418;
        Tue, 15 Feb 2022 14:44:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3020.oracle.com with ESMTP id 3e6qkya25g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbvRSMghx0YmR5iz2pf3GCaXRgVl5ooJSZqkEtqu7iY9CuJ5kLpdyE5o1jNrIzY7+k7n1zSuV9x8vLmGBeIiT1qlKdWdKgXNeF3RMuSBumIqnuts+Fro6END8QNoQ/YwvtQ/aw47uSAcuWfDeySpa9Ter5ylkNfM97/2+PdIAeJokZ1abuJocTN/HzfRxfkK54M1k6kchIzrUeqJFFK65CwR0vLK79W1E7b+hFXsZNLbWg4Bw3zfPlhBJ+DblUSYC8zCM+a4C6gbjvLi47mPyxjrue7DxzqbpM/TCPSsfyzqBt2x43h+v8YyC46eDjqRCiK8rQj+9IdJaPysLa9cVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHOLWyEuLxVTBV489q/jxBW8V9Wh9/jwRlyKVPc/pJQ=;
 b=AxTme7lZ9lL7hipOJJlnNsUfeh/OfnA0UUGrGerbwu47et8eZ1qYx7I8eH4yllRtvTaqxzvsNCPMgFrSmGxsQFOvXTkEmLjCMsKvicw2YbcPdyr7K3nOcQaCMpEXex6xXEJOkiXuY5wUpv8jgNjYepadQbwAmZpzcKAOrOznTfOZDUtjiCV/Umz/rlviZPD7qI9VQlXnHw9k86vlYg7gP7OqnQN9AncCKXlBOY5SJrgUQN0U2Tnvd+2QYZwxWcY1qGe5nAULkecLei25bUxFE+b2iVL1VeF7NpC0oRimg0MQMIee8ki0UXbiM++5ztvPFrQeF6Hv5ulFwDVgBRSD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHOLWyEuLxVTBV489q/jxBW8V9Wh9/jwRlyKVPc/pJQ=;
 b=WuOzgg4R/tQ8QQ/0NduG7S/b9pZY+lZbVipBsQuwmD3M/pGVde0JBZQPpI5wzSsMsFIB8s0MppmwKzjGAOb6dEThhNiAhsqgQSphkgO7m/4MWoYJstgEAX4nJeH1diHrluThq4T5jis2S3E5Q+EMigkVWusOP83ZbsRZWqXaMW4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5080.namprd10.prod.outlook.com (2603:10b6:408:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Tue, 15 Feb
 2022 14:44:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 71/71] mm/mmap.c: Pass in mapping to __vma_link_file()
Thread-Topic: [PATCH v6 71/71] mm/mmap.c: Pass in mapping to __vma_link_file()
Thread-Index: AQHYInpl6qRHkABv60+nHUF7l/nGtA==
Date:   Tue, 15 Feb 2022 14:43:29 +0000
Message-ID: <20220215144241.3812052-71-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1188481f-dd9b-4f60-dbbb-08d9f091b13c
x-ms-traffictypediagnostic: BN0PR10MB5080:EE_
x-microsoft-antispam-prvs: <BN0PR10MB50806F03ACD26E8933E2BDEEFD349@BN0PR10MB5080.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d0NyZ8P2S8J3HnNzP+roAmwPth4loU/QlN8VbV/PZr1S21mxx0bFm9JJt2XbX2WMgIeycVWk/W/jcjZV9C5xQyCh3xNlm19/14ogyJEDaof2ydcrQOXxiiN/mP0rnqtIvX6/u5YkuMchbmGxHolBGaohizpKQqCOSojYaF24xFGcVdvdDx9UZHNjX3MS9PyHNCkmKWy52y+XlM0LREMXnybmNp6xhHb00bHmzWcJK/icpXlWGqUGG+RI4yrK95CWBWQ/YOQrr+ZERaYSeLmttwwrX4DwCvri0zEmJ+41AH8x1mUcgb8/un6L/DGgHqeWWRGrKour+0UDSU+faP4t8UMUp9E0XjNLJn2zATD5FL3Hm061nQAcELQdZ8kdX2U5439/AONec0VZHVJhMqtTnTCO0y1nzhRaP09aKzBva5G//xiH0PYdJCNyLvEELDlYDa6xQ7TxpZkThVYHnqsCcB0IKtzFrGvA+TaBUw1AFGCabf5WQIgAkzZjx4NJLt3FtRF0e21hQChzJ+4t56b5TxGPQfg5XdCCDREnarB43VsRhheGLI+6s1xIH9W8+zwhbZ54dzLSswSpz6E79ylzetp/xlKZIkRnCIY+ujDgEHk5IU5ZWAZQZP9UvKiYnbPnaDm7EKjl13yavsOzgQ/C3UQZRgwqHqAHDZ2HheVUrK22CSw5xBHGa2D5F6m1Gx6wA9e3a9CVHNhpcB167plFbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(91956017)(66556008)(26005)(6512007)(6506007)(8676002)(1076003)(66946007)(110136005)(66476007)(64756008)(2616005)(6486002)(71200400001)(6666004)(508600001)(66446008)(86362001)(122000001)(316002)(44832011)(83380400001)(38070700005)(38100700002)(8936002)(5660300002)(186003)(36756003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EB2QFnnrtxY9Zh2dpehkFBSBsMFsechbcazayjvFfM/Xr6uIHA4/jbLTqF?=
 =?iso-8859-1?Q?1cu+UcQI4fzh3oFSStqRux+hl+gMLfqWz+80lzwRkgJULOynHsK/YJOlEs?=
 =?iso-8859-1?Q?XNPi+0SpV8J/iowChGxYn7ukRlZtOmHmpnWmPgvQ+xy0ff8w49dkz5t8TS?=
 =?iso-8859-1?Q?Usfl4NSbx87r0x3X7sS705R11PM6eMJLc1+7MIN5V3U0aBS8x3nxkGXIUz?=
 =?iso-8859-1?Q?egdxoJOIfU06uvJWh58tvNJAIx7fs5fSVSgVXhqrIYstZmvNdA8iXcpV8U?=
 =?iso-8859-1?Q?5AjxOpdzZ0HY1awZIJ5XzKGnLWHbmB4Xew2WVZZ4l8vieCA7N5iRiEb5SY?=
 =?iso-8859-1?Q?8xcXhouMoF0JgTRoQp1rPWivyn4x1VAcRN6UySyutktZRtgo8Aq95ZnH6Y?=
 =?iso-8859-1?Q?oCFY++y4Txfx1xdsdp4O5RCAUMg84oRYUZu5GHXxwuh/Nvp7kgIT3t2ttP?=
 =?iso-8859-1?Q?+OKwUeyKI324vI47jxttYbRUR5jg/qr1ixOh4L/RhKA4+woTI3qqWXp4dW?=
 =?iso-8859-1?Q?i4wogMM/Mhg5cx2jnvFU3khxcw5wMx59NjfT3ve1xmSNtpVnVlcSNy/gtR?=
 =?iso-8859-1?Q?SGEmahYjwa2/xMnQOtxE3xbZxDxjgGTTkT7b7fc9dyznEolqM0YEUqjutw?=
 =?iso-8859-1?Q?bkB9ptRmkaMLC54+O4U7SFqX/v8OXmhit6G8e3mMHeyv1x8K8+PxRnSvWa?=
 =?iso-8859-1?Q?NSZYcBmkhswVmRXafElrMn+A0ie/KzGfIUQ0ps70og/le1Zwgyr+9OploF?=
 =?iso-8859-1?Q?cZWm2NtqTHOpDALLfa0Ql8WSf7VPoi/vWp2vFJFlNxwWGZsIkghnyYhGG4?=
 =?iso-8859-1?Q?6i7rS9tcSri7+K6brbsnYLhHChQyxbr5mDp59D9lIq6Z6VMVMUTmEYTmhQ?=
 =?iso-8859-1?Q?u40OuLnS2C558BMJWgzDKDmOIjZRdaWlmOSzCaX+9RqaXqJeSlT/x6V1vt?=
 =?iso-8859-1?Q?4dZRxaBFFaugR5uVV/jm+V74aDsGALdfvwtakYdNW7jwI5rdfN8ZzTPJ7m?=
 =?iso-8859-1?Q?wj2g3jU+r8fkYgu3z7iDDxRqOWOxc1YZuqd5cwoZ9/vAUsLfhMZnR6q3lP?=
 =?iso-8859-1?Q?2aGhGymNwAqoQfvWf/r/uqXf+FajPTK49fpcng22RBOnF3UfD8RWQuyJsB?=
 =?iso-8859-1?Q?xCdXIPaPw49uHdYceIgu5wC7HIfOcYICq2xH6M9JzBDr3jL8Ibhh8FBCEf?=
 =?iso-8859-1?Q?gsVFk0zw0OdtpTRCa6+K8jtObzJACLYDUGTVCO/XYABUkJtTOvQm7S7zdj?=
 =?iso-8859-1?Q?uqpImuFwIgShkmEJd2Md+PY/NxJ3X+xotgiI0csq365EdoUz10hzNzx93L?=
 =?iso-8859-1?Q?RYRRlD1RNCSCGdAdkwWjz7mITdL0pRe3H3XnlwqGOhXZGO6623w2S9nQKd?=
 =?iso-8859-1?Q?eW0O1yEYC0d4X9LOH7xCiOkKSJCEHiqphyTiK06C5XSN2n5S79+Hd7hHnn?=
 =?iso-8859-1?Q?sWNffmEArJRMnrzerlrkwuXEA6i5/0LfHW2nH5HafHGL5BUQOktjOwq16T?=
 =?iso-8859-1?Q?sVUrBJDapbUNCvSXqsHZoriKOUvNVvRkyTu8/C09D4SCW5po25gEfAFRcI?=
 =?iso-8859-1?Q?q+xLfDOgNIH3Npq5btaEoB00ci2kKzyZSgenMeONiRb7t3EV2LNwcUDuTD?=
 =?iso-8859-1?Q?wW3Pj5Z7aQFa1aIe9+AzUWKCzNANKicDkyjn7bpBQMnXEz9S07DsuPvaVZ?=
 =?iso-8859-1?Q?cLj8T27ybk+0dcGDPzc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1188481f-dd9b-4f60-dbbb-08d9f091b13c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:29.6349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXiELKyQswh6R1RnpsQfcGSpuW1sh5aoQWDT2u8P1Ukk62070AQp54MOCgz98vjxU6w5HNOEUtZj8OZ58fnUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5080
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: dypsouNDrg6BEYDOYLl90V5rZLW7wJil
X-Proofpoint-ORIG-GUID: dypsouNDrg6BEYDOYLl90V5rZLW7wJil
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__vma_link_file() resolves the mapping from the file, if there is one.
Pass through the mapping and check the vm_file externally since most
places already have the required information and check of vm_file.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d40caf26b018..1b3600152f6f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -449,21 +449,15 @@ static unsigned long count_vma_pages_range(struct mm_=
struct *mm,
 	return nr_pages;
 }
=20
-static void __vma_link_file(struct vm_area_struct *vma)
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
 {
-	struct file *file;
-
-	file =3D vma->vm_file;
-	if (file) {
-		struct address_space *mapping =3D file->f_mapping;
-
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(mapping);
+	if (vma->vm_flags & VM_SHARED)
+		mapping_allow_writable(mapping);
=20
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_insert(vma, &mapping->i_mmap);
-		flush_dcache_mmap_unlock(mapping);
-	}
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
 }
=20
 /*
@@ -506,10 +500,11 @@ static void vma_link(struct mm_struct *mm, struct vm_=
area_struct *vma)
 	}
=20
 	vma_store(mm, vma);
-	__vma_link_file(vma);
=20
-	if (mapping)
+	if (mapping) {
+		__vma_link_file(vma, mapping);
 		i_mmap_unlock_write(mapping);
+	}
=20
 	mm->map_count++;
 	validate_mm(mm);
@@ -742,14 +737,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			uprobe_munmap(next, next->vm_start, next->vm_end);
=20
 		i_mmap_lock_write(mapping);
-		if (insert) {
+		if (insert && insert->vm_file) {
 			/*
 			 * Put into interval tree now, so instantiated pages
 			 * are visible to arm/parisc __flush_dcache_page
 			 * throughout; but we cannot insert into address
 			 * space until vma start or end is updated.
 			 */
-			__vma_link_file(insert);
+			__vma_link_file(insert, vma->vm_file->f_mapping);
 		}
 	}
=20
@@ -2948,6 +2943,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
+	struct address_space *mapping =3D NULL;
 	struct mm_struct *mm =3D current->mm;
 	validate_mm_mt(mm);
=20
@@ -3003,13 +2999,15 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
+	if (vma->vm_file) {
+		mapping =3D vma->vm_file->f_mapping;
+		i_mmap_lock_write(mapping);
+	}
 	vma_mas_store(vma, mas);
 	mm->map_count++;
-	if (vma->vm_file) {
-		__vma_link_file(vma);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	if (mapping) {
+		__vma_link_file(vma, mapping);
+		i_mmap_unlock_write(mapping);
 	}
=20
 out:
--=20
2.34.1
