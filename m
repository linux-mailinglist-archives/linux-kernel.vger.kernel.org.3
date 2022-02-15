Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7294B7163
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiBOOsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239354AbiBOOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0C6119434
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhvWx022181;
        Tue, 15 Feb 2022 14:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5qCx1j+0CGYKIpc9uCbEtwe2aJKhQY3ouZEvKLAzhRA=;
 b=ULIlB1WOypjLCXlKbtGfygn4DLoQGDWAKgWGvDNtu45zIwYJhWL12hZwwFOsgyrt5m8f
 y9vQD+E7lIxrAiPrBna42Kv7E5Nk8xZnDYr1vhZXPIplMjuLc9aVN2P8dGfyLYHUva9v
 ABuHbIGOOSa8wZGWY+o8dnL2OusG6ptO4drveO9KA12osvpLlnEkXMkepqmR7M9NcAfN
 g02gzXhDds3Ub7FIv5ywnVR3TMLKzJ4ISxG8+iYXyiSn7gFU/80r0KQObwUNNgH9Xi5n
 5pj6wi7OfYxlX1dPcWlgxPljlXNgnlkt7jhwBm3499aPGspuFJocYCW8UlJFO4NGbapN Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEe5VB157068;
        Tue, 15 Feb 2022 14:44:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3e6qkya227-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co8T9nrAWlVhoEEq9MEq+lo//9X/UiNoXB0QKtOoCOXQzgqZmrLi3O7wERvftuMsvXkALs842IWGJFSS3+HIf2iiIZTitycGPNppaDikFc3BBrlhYovKraTFNe3YZSX9xzzqh4zM/FO8R7o8d6kLYgFjHwNPYVXqfDzci729TLVALzl2LjJZbFhsxbwqa1mz8e9wUhbugO53U8J+DUq7pL9XexuTTUMDsQqi+M9Gd5MbON7UYK20tBz1dJmHdGxGFJlZQCi4l6RDQGKbDLu3BeXbIs1Tn+G8L72espwB6wnO5TwFjQmbXKGeiSRL5Qg2w9E3+udvHjpGAtrt1BDPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qCx1j+0CGYKIpc9uCbEtwe2aJKhQY3ouZEvKLAzhRA=;
 b=kqdrUF9LeHEYkQ+wyc324Za0wp3oWFd3xP0+Df95HVjA9ckm1O5K7h2NZ7o/Zi2FRAJF2g0KLVPd/bqL8E/BBei872gcuYxww1by+82d5c70NR5wEGT2FbFpHCXT4F8DLWodpeeTt7hABvT9cX3UQDLmHy0Y6G/IBy0pxu4HFZnaNLF7I2kDlWS1/af3uhgCoKK4QanK6Lqtwmq4dhLhAh+J1pmnIoV+yvd9qNzEBktWnEToSLMZYg7MgTVFWZD2B3FhYYvc+A7oGbo001NTT4Jqlge0ctpbkZiBvr1YpnKnR8eVBrdDFIpf0PK6fqIafucNY2jEmpWu7GH08T11mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qCx1j+0CGYKIpc9uCbEtwe2aJKhQY3ouZEvKLAzhRA=;
 b=J3nnxOWswShHZy77e0vLGbsymAz90LntUvogjVt8pF2ddH2Ois5PxaNYb+0JMI+xRb08ODABoWv7PYN3PKXXUEJbg2gdkLr4hlZGgWnmnhDkFXCjnNPUm2+ZNf8mHjXLF2rYqMUjNUi0UU6EINMwVQXkBO+7McMHupEGGsfcbGU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 65/71] mm/swapfile: Use vma iterator instead of vma linked
 list
Thread-Topic: [PATCH v6 65/71] mm/swapfile: Use vma iterator instead of vma
 linked list
Thread-Index: AQHYInpkHs0jq2aJ106LZkP6WhCj1Q==
Date:   Tue, 15 Feb 2022 14:43:27 +0000
Message-ID: <20220215144241.3812052-65-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb9e23f9-06fb-4f0b-5d86-08d9f091af4f
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1863A78E95E27B78AA5AB2ADFD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E20HD/49BfJyYALAXEUdK9qjDMh7sFOkt9ztmrAJHi+X6av/DY9AXxUAUx3UqKcJnGlt6hj2X/v5hnvG1XdxhdOlas7YD3Jg0rGiWcZxfxiLQbfnNc+cJImPVtOcwFwlWvuoUqBs3eP35S0hIwMbw00eIOJxrKW4jCi5DHiiQ2xo5YbRRiuMr5Ono6+UUjfEAN5ycX3Rg43BSpSWBJUA9dd/MXm2R18MyJbwSSEO3AR/Kd8OY+1Ex7hujZvc1TVZl3ecaeh6B4v7CurEkOMqBBhLEgVbOrlvhKdeYuCHH4Ls5S5Xriq7EAEtC0d1dcnJ3aCyxd6FveQe+xQ7ON1JhL0MLZtPw+cR+zQtaeF7THxYEMRva4J2OJdaYaYzbRYIUHR73odoBCf2UOzMldJdKMnbuWMPn5k8Ei2eZnVy/xGJGBL4FIUOPH8LPFX4tcXRYCZn36HN5qEyecwmxXhHMeoM9/Gbj9iClPyRaoPcPbcDvkNDSGQgDM7Y+FKEKFMFqy8Q5d5JFV6kDH/SEXLdlUmz8NW8kdbRvU4aWtiUlhzDmUwl6tH+UFIPzTKgd1innQPVi/Ai8duKdZ5WXSqG+WsD7+dYPwwwleKj8sbCVWcKZV/7XqBnAb3b+3jY4IbeH59H4BwyH6S87H9JCVxRsFa2IbziaXTJ1VwWE5GxZ/r8QtYMdQGXrrxFMIeutWzi+E5eMSwzhe+mshdWYELXmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SpeP8m/MNu7RLT0poDTu8ouNOH8T0Dz4LROSwY2nf01XKp8TopRzkYqQpJ?=
 =?iso-8859-1?Q?LPvHwC93N0Vth0kM3kZAUelU5Ake4hmqpwhLOrI+T8Z9WS+LO1BGnZR44Z?=
 =?iso-8859-1?Q?6p/sIV1Du+g6N4pjP7rDUn8jfbUbibTLgIFIf4QseBxZmQ54FRvVHoaxgY?=
 =?iso-8859-1?Q?9m8Kbx0TSO5TAaIL160lKUQQm5odiNbB/57xWo3A2P6MsKKEn0bvBCghGF?=
 =?iso-8859-1?Q?MRZl5wpSgC25sY+WngWqv6Y6gfjNV0w+y4ViGUkJU+lvqKelJiTYRvxHAr?=
 =?iso-8859-1?Q?ne8BGcFoojn6mr1owyhsvFSRTvKYDyrqud8x+GYFcOoP3O/wHBvuGj9jt3?=
 =?iso-8859-1?Q?XG2xpRQl/NOPChy3QHzAIZUJIC6UkwR+dtTp6gQSi3BWisAQVIvgEGdUG/?=
 =?iso-8859-1?Q?y8PgVov2e6D5atOshW7ojsQOcRmTvwK8hgrrRu/vBrbMozUm0S4JWDlNxY?=
 =?iso-8859-1?Q?OonBJtIhYdyMmeY9gHQoaOmWbfc5ZrAmKxqF95Ms8JjhTE/eqhvZkOvf5H?=
 =?iso-8859-1?Q?HUaHuDH3NhSS+tFzeIcAb59sXw9rjtuKHuvPYBu/GpkStuhpEF4jI9CshI?=
 =?iso-8859-1?Q?FF9LyAwWiU/yUgEHy+3Uj7alJlpgELXwT/Zo6g9Q7zBykaBP3SHBk/7OZH?=
 =?iso-8859-1?Q?4gDVQBmfIJXgJdzGkFLeM7RKMLWzQCaehoWSxrDZJ8pKAfW+E5FWgFwKFF?=
 =?iso-8859-1?Q?D7iPmn9LDtGmgTtE4kaBM9ZpMgWJwxMVqZOMbJR3WUU/hgSIJLWwAoAGIX?=
 =?iso-8859-1?Q?4UxVOXPKRyA5lPLmyhQigVcBWFmVfpn+ewNHWw5SyYak482i5XsjbG+/0x?=
 =?iso-8859-1?Q?kN5eEw54YwuXFL0hszK8h2xMBs+yaaecrIY20YYI6DAk23FMjUQBbpS5lp?=
 =?iso-8859-1?Q?ImYHc14ciQDwvxTLjoLICC8idJTRgiS5TdTbpm3MBlzEs4n+bUvYm4STbT?=
 =?iso-8859-1?Q?kFsdglzV38jjCOrh43OZ3Mq1cXosrs+9dwZ5q6/6iNtsHSpXZ3zp/2eYpX?=
 =?iso-8859-1?Q?+3CLMrt8KVHS+pZ8L3eBPcXMzeAeNsfm7A+8CH641bh7JkUDxJrIiYa5SC?=
 =?iso-8859-1?Q?Msf2ywuE85q/BlkBqkDxKL1a/s7um+oYfRiE6NaQrLzH0ayr+aWyAVtGfj?=
 =?iso-8859-1?Q?zsUg6K1sF0GSj9lOGlCrefJq/BDYyjTio5tyhNL62euLYe3YjVHhlPZv75?=
 =?iso-8859-1?Q?nI37MQSo2FOR68MIy53Ee6l3XlAtDyfjy2xbTutHM4pkiW6rQ6Ax65UKQQ?=
 =?iso-8859-1?Q?PlKG5Yqgj0iJBYiYxJDc94MN6VVzE0t2+RFHWqnmwPhxBdCoAE911UZ6K1?=
 =?iso-8859-1?Q?cUmh9KhYmjSd6Lg+dG3ETWZzgxZTzzaTLeDH0LoqR2Tglu4JM1+qzjzLra?=
 =?iso-8859-1?Q?5wD3eJ5VvbBz8aijK2aUuEQ0jEpjXdrFA0mpQeQp9V1KIOBsJanvdg/j9X?=
 =?iso-8859-1?Q?N8IFElEAADqkc5Wd9+dlELbqG2gibq0q0rhX1Jt9x8STY4PduFuJ83DU2b?=
 =?iso-8859-1?Q?jhk49EJd6uBMVuXJGSw969kGAkGEt+kOu35+SiYNrzlCFRccwmUeUiNxBB?=
 =?iso-8859-1?Q?xmdCcnhwQyX1QZBF3Kp7Ok9O9nIgk0u73K9Dp7XsFT7pDGZwiV1HrceTNR?=
 =?iso-8859-1?Q?XqCGHPAIDMeJqWhqyci3CNuDDTshf+XC2uXTOJyMSlA/AvJ53YPlkNbuWx?=
 =?iso-8859-1?Q?RCmWWsET4xV3YceMOdY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9e23f9-06fb-4f0b-5d86-08d9f091af4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:27.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OmA8Brx7nqHmnLTu4fpXqbpFfLxVagdfW/ruRDMAdjEYsN7Saz5zVmk6Qq4l2PojXZ4dwmhBs7fou51n6/EBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: QWtUCa4jqSu1aSmjtiOOEwlvYauFb5PC
X-Proofpoint-ORIG-GUID: QWtUCa4jqSu1aSmjtiOOEwlvYauFb5PC
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

unuse_mm() no longer needs to reference the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index bf0df7aa7158..fc17e02f12c6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2071,14 +2071,16 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type)
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type);
 			if (ret)
 				break;
 		}
+
 		cond_resched();
 	}
 	mmap_read_unlock(mm);
--=20
2.34.1
