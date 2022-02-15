Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0854B72E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbiBOOsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbiBOOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09062106107
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:46 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhv1s022185;
        Tue, 15 Feb 2022 14:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yP8KcdvD4Iz3Zo7pN5x6PNoSXuWYD0dJncgyn16h+MA=;
 b=XscVwHS9oaxrDzu1ex1hIwYlz+Gk28GP7gNfJNg67UT1fad0vAxV8kgIUlWgn/618TKl
 vhpO5itoOpN8BcLVBchBCklEOFMxbZ64tGCBHCZps7AIXTZaVJzZ2y7W9TVyShFRpzcp
 yRmm9b+izTN78707HpUba1hytRus/HrASkQaOSdNVgVW9/acKplM+YpuaIoLkQFc7zM/
 Ym2RftqtxO5zxHnzKiUFIXb98jbICvT6643cD4znkC2k3kx4FxuasgUs8p/aYR5kjKZQ
 SSISfCwiV6/larui5Cgcxq+6GaOAfWXybmSp6Ol/tuxY8pYopXNwyAN/QGQF0PhCkdPV XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEe5VG157068;
        Tue, 15 Feb 2022 14:44:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3e6qkya227-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGQEB1/U4ewGI0/8I03go0UMtMtT8gShOJe0Jnu7sxeER9bzOP8n6sKbyyvQXYODqRlSQ9iUdzy6wNGdkq+qH2FV6q/O11LHSVaxQSkiBOb1q0wHiUnbkKIQO8zr8hPBfbkzSYpsSEDPjjFSEWIncCb+pZKAlO+UruXxHW65bHFwk3Se9BAH7BuJsXasXh/JUN/YAbvD33An0pMfnvr2jBSydnCiKIF0K/RTvukwwlW7p+jJ7KEEyD81b1uGm6mZk/2RyBVCCuRw3jTOO/y63pZPzLOMnyyRVBG5HZ1MERdn0p9so0WY3bL3dXlCEd5Sev+NcLp8DmNYuaKIjVUVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP8KcdvD4Iz3Zo7pN5x6PNoSXuWYD0dJncgyn16h+MA=;
 b=ScQ88/yDQynp2QV1ejRi5vvdk8xnlQBzYZaZ0R29Th9xdFXb8/NOIoJIQwev3ZgsrdOT2H6AwV2ssbaeBLAGT+HNT0j7TFs4nogIg00irVCV9wcZ1FUsnoqU/Qdk60j37x6ppMpnAnCTwKpW3qn5aQ7mIEKY8kSIkznPngkT2o8anbmCkkmwmt0WCHDcR0DLlWRVPpHRIjaaFdLqShNXk0aeoy9T3fV0/wfLoCiz1AvQYRESWTVVw7ChGsQ3/hcnQtVs1fJME+AW43cBu+ez8VAMTh4ju6QUYTjenpptZvwrzG1TPuR5rdIQnb8y+F+elwPvmpAJtXxTbwTRrNERXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP8KcdvD4Iz3Zo7pN5x6PNoSXuWYD0dJncgyn16h+MA=;
 b=h6JJKQFl2q8AexA4iyTRd8bEvr7kUOhrAMXIrjS5uKFVon/eyYBXlQGzMmUYUQ+/1wcEotfP3V0RRwWF1uAI0FUbChTeCPjLMEPQcZ1IU/x9yOG/0fQNE11n4UnsRum9YjkLxdgcd8cfMuf97XBj3nvQhnYirydqhyYEuXm5B7U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 68/71] riscv: Use vma iterator for vdso
Thread-Topic: [PATCH v6 68/71] riscv: Use vma iterator for vdso
Thread-Index: AQHYInpllYX2DgpAw06DS4MJGsJnEg==
Date:   Tue, 15 Feb 2022 14:43:28 +0000
Message-ID: <20220215144241.3812052-68-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f9bb0e1-6289-4ac7-ffed-08d9f091b038
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB18639B6A520F172D932D6D34FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qubkQIwgZLK/R8SHd31ZVpls6IDIwPdjWHlZP0BKtK3Ran9QNqTDatumo4YY6fXRFJeRxCYezuV0KJbR0Pounv528tgNOIfCku7xln6qYSgX/Kg84m7/1EygHz9A53TjObBWYDOpO/AfhRLe08OzrZTEK9sMl2Dx09j+TWog7reAGQITD3kr6bs/YatLZGgRh5ZiHpEqon/PFAfRTSqM9BqXwgw+tApEBjurEs88ixBjbP5lCxWSAa8OB1/qzSupCbm+fJ62E6K6CBJcSJUCcJrhtmuXuBXGUJR0U0HtL13SFUnGk9w8LBrZ8kFvzuRu1jdcl4vphVlN2v/WDfcooWbaCx5Bb0KAoWQeH3lJFRkmaR6Lo1UQZagt3BP+ibnGTJrU7zFLD9bLLx/3caiCBP4sPZ/CblB9HYHBuxx0UJpSqnBOcsMiYMnXx3xahj9sR920Emh1SlXUZLr2rpahBRi0QGGRJI2918jNxz0qf5a61H2p3QS+f0bAI/WZ1kYBcrOsDz0DTq/2QshmR10rXlyu8lq8lKaAtkk26I0BOn7S6eSZoVAdJVx08EM91oVLBO1D04rgD7Kt6yDAnHxBz0Ggw7FOHTQwjP/Xo7EkXFFg/IjipqxonrOE8Ea4ltSMzPWdQSolv1JrYU7OiUkdglnPoku8Q1/qtTeWxCDAdoUAs0PUxh7tbsJ+s9ZqcZqLfJmtY9AEzKL8LzUSX/+UtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XeF/ua8iMTmDHXGgNF9BQkFLB40/u9tFeG9GrhYynF0GnfEOcqfYGo8vNG?=
 =?iso-8859-1?Q?AVYttNOMrLW45riHrVyYEH6NKSMEEltav4iHnwTELxvs4GnpFmRO1wQX01?=
 =?iso-8859-1?Q?bSN3t6XGphMK5Nk+yfLtSV9jOI+NBu5Ft6FrBZ15QBnv7LzBW4plOfJ97j?=
 =?iso-8859-1?Q?YPIO3D9oCe+AWJLP1/W72H4eWReSuU5vU7fF4mYx4oqvwoUFh7VjnGzZDr?=
 =?iso-8859-1?Q?GO6aNnQrupSrHHSye5rAyv8yj8/Ig7AYnEHuQbmMVq+Mf/r/GTgl63o2CA?=
 =?iso-8859-1?Q?IR3CeeC5swJXHDuaZ/n/4A24sIjUYNA7zHfnCAGoUiHtYfQpuxaIS9G/Su?=
 =?iso-8859-1?Q?9XzTO8VCjNnNY1GpAB+FriMFFv7K4ob4yrIx88JOA6DO0se/3k2UGjFrDK?=
 =?iso-8859-1?Q?ZSNLrptNTI0IdzI5j4sRq/H0dC6wNikPopKzizepHcXvwUDPQ2Qt2M2+Pj?=
 =?iso-8859-1?Q?yzVK5feVAgiGC40XhSvWiJJjNvOHQ0MATBhIJz3yOkBCaCerNkbqdE/aol?=
 =?iso-8859-1?Q?cglzySrIpyQw0JX8suqjWNHcBoPbGa+iO7jeLNgRSjRMMV/yCkz+mW95FH?=
 =?iso-8859-1?Q?SNOHBi23+wZS/YX2lLHTX0caxrGvk89zDb4efdzJEJl2eRoW6GTplHG76M?=
 =?iso-8859-1?Q?dBiRNjDe9Kby/4Pgc4j6heo9iLYrUV+uY10hnljSi8Je7MuN0lToxsYaEh?=
 =?iso-8859-1?Q?Du/X8GIUUcl92pri5xAfyTCK8o1UDI5Tj8BK26vdZjLmUINJa0rloKrOdY?=
 =?iso-8859-1?Q?J+wGWhW5PWRrILh0Y4g1GFiPK821NPJMYIQRLH68YNfkDpEvZXEyY8f5ta?=
 =?iso-8859-1?Q?GzQPPqfHmtYJGGWjVBXsR6eIz/2gZtgzTPBuz8qX9TMl5najCNrJ5/7Nhh?=
 =?iso-8859-1?Q?Xp9wccmyg+A7vkhc96b/MXYdPgrrmbji/crvBwlV9YUHkS/FTtp4qZkOGF?=
 =?iso-8859-1?Q?DgAgwYi3viWpqwxod54vj1vdqk9LBjAVA+Uc3XD0779v5OTExNsayRPtGL?=
 =?iso-8859-1?Q?r6IGNRlfjFVajKuGVb74TZrAi5ZxQrhPYengxEzf2w/L7/T5xG0Iulev8h?=
 =?iso-8859-1?Q?SwKA+oxEfqLIvh3XJPNjUPZ2LIwrCnTjoibzTuLBt6HhC/pr3dqGx0UXUk?=
 =?iso-8859-1?Q?mA3z7ed8VD/w4fvl4tbONRrbaGA28KbHwecvPLz4Gb44uhpmBdspU+jmHL?=
 =?iso-8859-1?Q?ZBQC/8WizmYT6skrHDdyZUI6+aUMXwkqfS2dzaQsRbapsI0kBqcQ3kao/e?=
 =?iso-8859-1?Q?ywChb9ptE81Sy6xMlKLu8AhiJriAbToreXK1/XjV2TnbAylHMiopzuaMxo?=
 =?iso-8859-1?Q?EiL+pcb8VfhDQ7kT3TUc02xHdNrWDrUQHRJ02XRKHFSId4Gqiz2eKEwIx9?=
 =?iso-8859-1?Q?oaV4MT3ajVyL4yszZjbEdV4ZX8F6tH6vQn3x6DfR+aJKIFRrHj/4YtaLlG?=
 =?iso-8859-1?Q?ZE0sh4Q7T2bA6HW6Mgx2Dc32HjHcg81GuYQeDNChlLdZy6pjBQUZtQoXvY?=
 =?iso-8859-1?Q?+vIsZ/I9c8koWNbhTuskUQqpcE5oAaE59WDpNbKmaDzwOIj1qIjTDsFso/?=
 =?iso-8859-1?Q?lC7+3YC1iB2zNeN8bf7EgMIAZx2wxFdIrmznwrOlgS2TaxJIR7OI4Uoj6T?=
 =?iso-8859-1?Q?i/QDJ3ohMA3GjDTXDVpiGAGOLeRoWYliVge3bKh+mY/FTh06QU6O6qQIij?=
 =?iso-8859-1?Q?/WBu18sV+mXyX0E0V7s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9bb0e1-6289-4ac7-ffed-08d9f091b038
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:28.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BH/021K7szt1TlSCI3/kHGroFjh/E0Ij5+vIFpDNNiepsZffTlce29Vm+36SP+fDYmHRchYYFeY+TMWmuNzrrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=901 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: QwGokZRouQvP0z1TuBvXHSaAdrYRAAGQ
X-Proofpoint-ORIG-GUID: QwGokZRouQvP0z1TuBvXHSaAdrYRAAGQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the linked list use in favour of the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/riscv/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index a9436a65161a..5dcc80f92587 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -116,10 +116,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, next) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info.dm))
--=20
2.34.1
