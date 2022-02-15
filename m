Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B99B4B72CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiBOOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiBOOpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26423116281
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:10 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhhOp030901;
        Tue, 15 Feb 2022 14:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9Se1/CeXs4xVn28sujLq1ewtCJqDJ6IvL/ZaMkdOisc=;
 b=jgqbEtODIEiTNgI1Y6ID426688SU6MjHf/lKzP9XQKxlw9Gbcf0H6OxZiQcM5mJF3A9R
 OaUA9V+h2pVyGKWIunsAcUtD2V9TjfF1Vl2+PKtNKLgVyh8sQynvbe3ioORVvJI0O0Ak
 W3TUiSEgOwEl+7nvoi5A6u8otSDi8+dxzbIJpcDedsZ0PImBxkMXrjCcbP34HxWaqQoZ
 /deUNkS/hgMFQY5rsefnsp82arM2/F4/TMN/6l4danrNWAog3FuFKO/79FJn4XJY99qt
 VEXlQML0fBAhN6tmkCYK2SDdzX1WdohojmF728Y1vUWK8iLq2ofajM/VtUJmubyEhQCM ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psau0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4S145723;
        Tue, 15 Feb 2022 14:44:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHLmpdV9cIM/g53ZWxWcUfuNbH5RBBPWq4QzSgZe9EhlK6UQSU5H4zFeNX4BrdL0AnOx2A7GgJmFqgx9ujxysVHNXjrCa0lCI1CPeFP8Lgs8MgsdMRYcNk/YfLQWc2FBa5dfM03C+gFe7BseMcBjm2m4j/0cAD0un8cfYqCk1KHdLN1y2ucPeON/yNdRaLv3PBaxDHxn/G5Z6+i6L5Z0Br2zYW6lknmdKlTZrfpTScDgKED5RKZithvJHIS/snAxPLZz63ii2VvBZWVwbmCc1FDM0+c957EAPqB5D/Ailj2w96ZkAkmmn69jqZlWbws7jQyRQe2ZMdnnI5AqDhMZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Se1/CeXs4xVn28sujLq1ewtCJqDJ6IvL/ZaMkdOisc=;
 b=LuH5sgh75k+w7FymdvIjETvEgKFiqXkL6AOovL6XCIIy2BBwXbKJ7jKlvqlBWoB1v+4ZuIJsmd1l/2JxlNVR8Apz6FcylpDUUlZxwe7TUNopo229xTuJF6AXJ5y/awDpWFgIOsBVLBLrwCMwC6X7VoyUvzg6jkYbNs1ua7qyflFnZVtNfxN+K21lItm61OVnK6Qqm/93D/0ErSyhYwt8O31IVVneSsXbAxHzgArA/S7OTvTsXiI5vw0CB7FGNjLUhALTD2LsvPD0eKNpFYGbqUPAjJFHf7JYsq/PSXsmz4ND/AGdYs7QdHxSb8mTXyBnQ8j+yxzMQXFX3TYtuX0emQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Se1/CeXs4xVn28sujLq1ewtCJqDJ6IvL/ZaMkdOisc=;
 b=ycissMjnjqpaRQL7R7S7zk66X/EsIUpHDA5r3FM+psuqk621i2Rt/jOOf5dGDH5Z+doC3xHePQu1BafQ8oArcDZxwHP7HvOihG4mU4WgFRy85CNx0FTx2odp9NdYyoxY3HJDfYmi2TbzZ2F2ICw3NBWS5/rpfNRhl9bzEq1XAbE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 51/71] fork: Use VMA iterator
Thread-Topic: [PATCH v6 51/71] fork: Use VMA iterator
Thread-Index: AQHYInphniaGbHRHoE2hVS5DhciK9g==
Date:   Tue, 15 Feb 2022 14:43:22 +0000
Message-ID: <20220215144241.3812052-51-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a1178bb-af1d-44c3-96e4-08d9f091999c
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB55785907FA90071991B253B9FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JoYq7C8pXrAHXbuSKqnVKRblGT4g7fdcVWf9sGSCRwgiK0FNOAJo5cF2zZ1agIbfFqgimlsi61Hw32Uyc6lOmggaOPjuRKY7i8Nm39GmyrOBiSijw0QMs9uGW+jIBMrSmsm+FaHcmMc8qCNKyJ+NMeZXrrnMTji6P/BpijUuXrPknBnFcGjc8X8rrbx4KdumAMZG/75XBcScgvBZTzanIZcQCD79v9sTvttrz+nGCvgdyAvTbTlGVqKDSFqzs0VSxknZgPxQOnbZYs62ugWPhWiakfkxrBb+M8nIXoyVxP3wje2KOhcTN0gi9kyh2k/jXs/lgbjf3gqRzFcZ0Yzwa+J5YeJB18FlmTbjh8Ao/WTv2Qaq29Fj4lEpNvMuzOj9OVJVmcvKkxK9fXeL4fIGykRYd8HzBClKElOJ2zko+zAkaRTKw8QggAt1nlilJQoZpKmpWK3Gnt0zariJAX1KC2kSWWkAwe2R8RMdWkWb3hhSP5XlrJmVO0SwGC+K1GoWvEkWLw8w9iWJz48IZBdkrRNITUtTdYsl9vsLRP6xyyMPrZju1SuP8wzImXfYp4SMKJKh/otJEOrcqbtHe6kdSCq3v3VT34EsrxGmFv4KVGjt40ufy3Qo/L08lIjIyJ+GRvIAu+lSCa3AUeihE+NgcHlWo/3STN3858D3Boy8tW4XZie8YCTJJEIiFNXQ5cNLMRsy7kE0Cjek1q/2/YhlDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(4744005)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U+Fko3gz3ySyhS8iidd53jNjM7Hf88eksGt0vObl9SnxJ3vTX6/Ja0e87Z?=
 =?iso-8859-1?Q?S+CYUi21ycuVVaKSF5otq0H3/fPjHAhlQyzkTgowzh1Leg5Ip03yRl9X9z?=
 =?iso-8859-1?Q?9tWrCe5dUoMEOlQ9VjE3LTpdFwbGk7ZGAYyMoRRS+XhCRFtIPjM1iDpfb0?=
 =?iso-8859-1?Q?XQWFXGVY421vAAgF7zp+0RQGxGS4op382YISQYm0nAUNG95Z3ZXuspT1wI?=
 =?iso-8859-1?Q?S14jx5jaleT4I4v4YRFLEwxJ+sYTjzK4pxEhSsPbEVuc2ROgNjPSaYptFV?=
 =?iso-8859-1?Q?axnG+CZigTFyx3wGmv8cWXRCUgkuSx1/APKqWcwBX/zd0uIEkcFmeRAQhG?=
 =?iso-8859-1?Q?X5kBHmeMZgDyVnThQ8NVjt9Ve+6WmSDxoIyQwaBRgUuTyTSIZaqz7erp8j?=
 =?iso-8859-1?Q?t1zU8MQ4XAO7yT7CfuegXopMUwwA+6lIysI2YkvHDGF5cTgyrjF9GM+E5E?=
 =?iso-8859-1?Q?ERF95Mts8JTqzR/pTsE7v/f7gEtsWPu+5SofqMr4H7pAbDBw3yPEt3NA4A?=
 =?iso-8859-1?Q?mSULuZjdo/snpI9PoBIAue7Or6DeibcPoMBNPO9dLzfQ1kKceoKPomKOsv?=
 =?iso-8859-1?Q?z6Z/2NcZ7Fctg2rEe0P/7Nbi1fyUse6BLWBXe8jcxYEeDej3SlfdyxPeFD?=
 =?iso-8859-1?Q?Z731gR9BOm0+0mt6aZAzIuE3KiJtEEzRNKKf3YFTr52+bA0p0Eplf7S17R?=
 =?iso-8859-1?Q?NK7NAz9faKlhu5h58dih7uX0wasXJxJXBXBkdnPkxOU4Hd1Rnk4tfH0wS1?=
 =?iso-8859-1?Q?JC6g43T9BWtrnVDmdMAKnffBRrVjd1hVTTYXAIVN/AVf0azzMz6g4kMxkx?=
 =?iso-8859-1?Q?NKDH3N9gK52PmUdtjcKVFNzTDsHg8w7B8ybusyc7O6FEusSNZJwdMDCk/T?=
 =?iso-8859-1?Q?xFTJzv2mjPEZd4BXScMWL+psZjV1uOEELAk+PiBmjEt3MOMD+DtKZfJAbT?=
 =?iso-8859-1?Q?6pPsO9RsGYipcKPd9rP8fHYRT1NTWE488WENFzBWn91PWO3gO3FMA3WbZO?=
 =?iso-8859-1?Q?xrFwBr3EMcvTC6ms6k61kFC0RPGg6YCbd0dqKbZZpCF7VNlc+gMnxTW6V0?=
 =?iso-8859-1?Q?DEN41mdfEX+EViP+JdvwDsgD7l0/aKDZLIZrTzpUj1fi0mutwvL4hZCphf?=
 =?iso-8859-1?Q?cSb5KJJPOIU8n0JRzIE0K5lPW9kw7jEg5OE1fUs1hKe3l4wQlr9ChndlJQ?=
 =?iso-8859-1?Q?XJTsze5Dihd3DbtX6Kf/vZhWj0ac8nc6aj1PrgpLG6ACCj0VKakxOmiOPs?=
 =?iso-8859-1?Q?Y2IUFgoJgSSdp06sRnyvZh1LrOtHvpm9aWLIKNxHj+/SIrAH/EDNNwzKa0?=
 =?iso-8859-1?Q?2l4P7BAa73zQC76tWGaWv0181GtTJwmvGA3l4nBDMKeXeLWkg6s8e1TunX?=
 =?iso-8859-1?Q?QhNlzwsa78ejEXOKhkKXVBhcZhcrfHiWmKupz/QiAYdODeMuT2jZVkztFq?=
 =?iso-8859-1?Q?RspG9PlW+ZXgPTAOht0qtJqNuAwd20M16YsoHLbfXEUbpPDV5PqrCXvj+b?=
 =?iso-8859-1?Q?AY0o/c2jJ+lWqO6v3pJb7/eL7n+cxPFqGgkPifVOHJLtNs+xNlG/9M9TsG?=
 =?iso-8859-1?Q?6wK6BAg6ykFO9dIxRWFpKwTmvD63nknoTZc+m1a3nSYK0Tvb7i5mPURjjW?=
 =?iso-8859-1?Q?zUH8z+xJyX2Yc09I8gXBdiO6Y2orAyzci1geWWXb1oE8g5NhygcTJJffeB?=
 =?iso-8859-1?Q?N9LG/VtUXkMEAJ2Epec=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1178bb-af1d-44c3-96e4-08d9f091999c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:22.2448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmR8V7pI0jPtiGtR14tyvMNo1KrRUc19qVDVQzlgbzUZV5NyKz1puL7rD5gWVe8hVMNkD1Rr+UrJBsDyycPfFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: jSsWWgVKVcM6sBw2Cw7vgr-svMLAij2W
X-Proofpoint-ORIG-GUID: jSsWWgVKVcM6sBw2Cw7vgr-svMLAij2W
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

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index fd22da67e092..00d646803bd6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1218,13 +1218,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
t file *new_exe_file)
 	/* Forbid mm->exe_file change if old file still mapped. */
 	old_exe_file =3D get_mm_exe_file(mm);
 	if (old_exe_file) {
+		VMA_ITERATOR(vmi, mm, 0);
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma && !ret; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
+				       &old_exe_file->f_path)) {
 				ret =3D -EBUSY;
+				break;
+			}
 		}
 		mmap_read_unlock(mm);
 		fput(old_exe_file);
--=20
2.34.1
