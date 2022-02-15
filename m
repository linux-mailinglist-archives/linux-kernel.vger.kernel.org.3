Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE51B4B72C0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbiBOOtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:49:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239274AbiBOOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762CC117C87
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:31 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi6AX027424;
        Tue, 15 Feb 2022 14:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=z5GkGZxF/NMP0n8yPlIZA/7TqAWku/UUEWIq9kXgI8k=;
 b=DX1mW/Ry9kAieLBDp6GPqhkfSVXqFZN6wDfTYNUjSTdr5KMZwwP6YZdYmGNvHm+oVNNk
 BunnbXgP0sWft/zEM7+38xiiLkAOYcIChWCpoG8+bbiOhot9MV5OJA7BLYxfMuwjlOln
 8IRRC24oFECxaOTdVU1rbwcA7cNohiucgbYYfivGo0rbYUfoPJj1IYqKDHsxprxTsW0m
 UY3OFtXO9VyPoKu7rU69oSpso4oW0K8mGLRBgOy3kmkyVFXOCe9gzxeZNRGFjvqWvmhB
 x2Z1WKL5e3ezpvUWBD4MN2wq19pZmpV4Vu3+vc4lxWlUn1iJfMWfEU03pSx4CQsyjcFj mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e820nhxxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf96r016330;
        Tue, 15 Feb 2022 14:43:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3030.oracle.com with ESMTP id 3e620x7vhd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGppckxVPsG1T2D47ZeKRKtgCOunaIX6dXrOtZ6TGvxkiqBPnXb8nyqiO4GvUItZL3zJkYuGuff7qWtuqbMQppHP8M1X8JF9R7nUprKdWspIRwYQt0FwJHObOa0GF6h4DOXmgs8rA54iVsk/Dl8nmlb893TPSFFoDm+Zu51SF4rkHNqqa2xILVKeBx1OOFaPQWvZURuwERDLNLv7OP8s50aCVK4aNfZEAw4WPCXwirSfonFvSuWWiJFuMteN80eaKtY8jALg3errjawQOfTx89i6YJgM46oNOzT1cwCikc31mk89aIFEbFrWx2GSarJvypytE/KPDcJNbXBUo29Frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5GkGZxF/NMP0n8yPlIZA/7TqAWku/UUEWIq9kXgI8k=;
 b=h3it3MrSKzBuecXFhN6uHmQ0NwnkIIoHuJz5EX4ts4TxKqhSDIGA3n/niu1IhGoBHBiG8XnejkM23mgG48E8QAC6U9QP9d45+DBjFo2+rZljWhph2tMZPfCWOQL94ra66/+UtVNiJEdSR/u9/k/xJN0o591jmJvDSSKKkkQgHCTJc29TADuvvCloCxMY2gxc3mpohgorCUGQDaAgxZPCrpBIAs4S14Itm7w5YrIo7UVfmP+j7csoVdnvkiYGIYYwH7g20bcNUIIspz8BQjYxpma/geGioe+SlOVnbBZXMUw04Hs6vNEXdRCehOUdRWhcXbk9KrQYQSqukgAM5qVhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5GkGZxF/NMP0n8yPlIZA/7TqAWku/UUEWIq9kXgI8k=;
 b=pjuqWwWjTlKgynmXdCzs7sp2JrT5nizTkQNEk67Pg4PtIuHQqBzitwTdJEAviUIbat0eZS3wCU5kSqrLSVlJd1qbFfISFiwDjssa+6AOf6g2h5SNsc+BPy1iVhnNcQlP83UYIKrV1pV3yNQOyWUoG2/Pu1rmDVVVkdQnxXxUUiE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 44/71] fs/proc/base: Use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v6 44/71] fs/proc/base: Use maple tree iterators in place
 of linked list
Thread-Index: AQHYInpf/H1lFf7vp0SZPmX0P54tJw==
Date:   Tue, 15 Feb 2022 14:43:19 +0000
Message-ID: <20220215144241.3812052-44-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00991387-bdfb-46a7-3d9f-08d9f09197d5
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4689B310A32794D6F9E6196BFD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fhn3v9Vl9t1TOYjMhqkR9A0YYeelLaOEqsNQRne9rXfJpBPTGaj2xfJD90iPp3H7wtFQKynmVQGevUjTVkEJznwkPe76vqwqj0hkK2PZ3yv/QDuEfgN6Q6uf9lqLgDMbTcqvidw21jlK0fkjxtpR6uPJU47sF9MjZi76w6R1Tw5728NKxkCANK8oBMJQjzq+85XgZhfWQLulQaaQxUj2JD8dqiqdj1/apaH6bdG55PW6Wjji/r6gKcx56HUUDf+gS7O8gRw1JHg1ryMaQTiMnP/cNTo7xuK13xOqiqftaERhG1G5HzTQjV8+5wWVu/9AwUoFnH1uvdzFQ+i9RWd3zfOlBk4ih51qZKzF4kA/ljSCSuCH4bUyQZJZWify2fnI+ZZgUkvrL5ih9w4DZBnCqY6bd1FeX6oV4HA2t4r68gPIuaK/NJmQt5szISd65vQR0KAvdAl+oxvde6LPh+Tw/K/Jkes0vwqDq5ICmWf7P0HiC/WJutMXs99V2G8LGGnq6JZefjDrc17ncR4OpHh/Zc/iBtHLg3/30eFrMfxUqvmwFekhA8fhwXPqzqFrBG85HRMKeEmyd5YmMj5H0H/oFImvNc7ILB8XScH7HGnkPAzJsmhLY7Ml82ycwvWstFtnXM+InDBI6spBnmZn+/3eiiABm86TmesvI2xXD88iJoeo1BQeW+2r3eI5e9UWhg6rCU15Ohv0rn4EaoYbtRjAqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(4744005)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r+M51WdrAlQUmzIqgYZ14Y2yslfo0s91Wg4lAJYRSwHXRmRO7Ho2cVKD8i?=
 =?iso-8859-1?Q?YYPHG66vuPGrsfu/TgmIMgGlNuyIgoOjU07I8t1PIcJR1vzwt7/kI6+aXs?=
 =?iso-8859-1?Q?c+aAzdhuHTiiy6uQvupPlW+/0kQLl7JDWXjMXdXL4rHpeHREENjq/t/JLN?=
 =?iso-8859-1?Q?v0O5GEMdwU+ChvCkEohhFelme0uAA+hJB84yxPkE0w9nkqIAmQX4ov6sJK?=
 =?iso-8859-1?Q?k3LxazYMmiTYTmmIl5TS5EeOZoRY4x7thltoWlAHkENwg7Z5Tosiqs1CE2?=
 =?iso-8859-1?Q?E4ELLEuAyZdy4z9Xk+RU+v5lh+w2/L+qqJ6ZnopfdeT8SyauLc+w0K0mYA?=
 =?iso-8859-1?Q?iRfgd/WLT0vWGVfnXx1XYXaO7JtDcfhBj1vkStEzfxMuBpmzRP44TcVOcS?=
 =?iso-8859-1?Q?oEbDxI3fqcUFwOdnbDvNTWmvmKSd01xRDy1sYiPRGJRGxq6WHY7kJ3R2Qc?=
 =?iso-8859-1?Q?mrS5XR4N8kFkZGcLjg/vTjWLKRcIPOeAZqWjeDF/ILMkZ8BmImcFTS8tEN?=
 =?iso-8859-1?Q?wQ8gagb5zFLgkfaTSI1zeHreLHDJzot2Q1QQTuvHt0XRH0FoQTMig8dBiq?=
 =?iso-8859-1?Q?blGgAWYEfluCyiFySHkGmqn64+FRzIblF4FHKpzEBeZ3/kheLorrFznDE5?=
 =?iso-8859-1?Q?pwXW6SXKdVnaXc0V1U77G7slR24bn29K33jeecP028DMwz8Hae+L1vg4Vt?=
 =?iso-8859-1?Q?SXDxf/I1/Ggr03p/zJL/9MZiFNo/H9iMtBEHyA99wW9qJ5cqd9pMRsMUpB?=
 =?iso-8859-1?Q?qDFbOXTsdQAzOWH7Oa2L2UUVMYJkbTWuwEumi+t8T0iuemlN4uHbTgDCRJ?=
 =?iso-8859-1?Q?L2Dko6cAhxxuVJWrbRYie3QkTns1yHjTDmRx2dgeRJh4A8IwgE4M/y5RxK?=
 =?iso-8859-1?Q?0Kz2oKHaOSDiln00rTMGvjNFg5es/+3KC9RhOE8UccZTq3cP+kmBuplBKb?=
 =?iso-8859-1?Q?JBxeDumNVfwTO/NcY6Kjoa+1qC1zc22UyTWjwAv/R8/MTWFTDZNIAotUTH?=
 =?iso-8859-1?Q?POPlimKpOjagn7nsGzVKy/wsJB7ZZg7xqfhIXVN/utHoN7Kz/kiThF1CZ/?=
 =?iso-8859-1?Q?sgZIQqDJ6AHrczmXVa5OWKZCjjd+LsbQbOtGC2bLPXDN5OYpD90ThrzVBZ?=
 =?iso-8859-1?Q?PFDGT8nhOpursbLd7ZMGhfwSGt2gTFqU/P/zuQqYSfuolC48hRN81ENH/i?=
 =?iso-8859-1?Q?sJgI+WEyCQ8XBDlbHMbGPOu90TumSFl56rPUgphblSP/rtUx+uJzPeQNJw?=
 =?iso-8859-1?Q?jZzw33V/AnHZguau55wBMoT96yxcXfEJ47RToI3YlCieMh/QcHJZvgxNJj?=
 =?iso-8859-1?Q?S1w0WW3BHSX8MLfDAfhNkN8y/b3B68HkdEcPv4M35sRlbbm78TA2IK2rmv?=
 =?iso-8859-1?Q?NuIr6tqwp/1j+NCl3n4rTZ7x7ohkSXPd/FIYo6DYug+zfOx0rTHrp6N5hf?=
 =?iso-8859-1?Q?Y0hvlKec6Afg/yTA4Oo3y0NXRykoOngh7h/CJhOMGgmd/feLPJm2vhFv+f?=
 =?iso-8859-1?Q?WYYGJ9bsVUGrbKAf4l5+YV+EaP/kPmsB86JXp6VHYtCeRX44pqUZIP0TrY?=
 =?iso-8859-1?Q?ARiKKpLrd3xs9tOBef7vrKGfB5ITmTCkAA5tptmhR3GZCFVZp21r2xLkrX?=
 =?iso-8859-1?Q?+9LkzSuybFapttOOWbH1KrxJDM3TUSYlyeFXoSOF2HhxQ20Nnb8EGK9WVU?=
 =?iso-8859-1?Q?PV7krBtXIQTk7iwwofE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00991387-bdfb-46a7-3d9f-08d9f09197d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:19.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79tPk46vuTarMojB92rdHNJ8ASoh54yJmNS03JupKuh2iM7skQjAxn2s3krP62v9hd6+0XJSS+uGadcBS74rQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: uXSbR_W2Ivmuy7-lGgOfWW1X3224GNLg
X-Proofpoint-GUID: uXSbR_W2Ivmuy7-lGgOfWW1X3224GNLg
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d654ce7150fd..a62851782aa5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2323,6 +2323,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2350,6 +2351,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	}
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2361,7 +2363,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
--=20
2.34.1
