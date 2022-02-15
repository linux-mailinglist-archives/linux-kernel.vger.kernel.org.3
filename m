Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EBD4B6F60
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiBOOqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:46:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbiBOOqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:00 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7128611861E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:36 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhhOB030895;
        Tue, 15 Feb 2022 14:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3Ar/Z8yjF+gGc+n32D1/k4TGMfpKuhRfX5pIPpPTukk=;
 b=NsvzkdPlgRmyKxZJ9E1MrTZCM8pgboxd+bClmzu+ozU9M0WedRrP8mzK2mSrxm4z0YnO
 +cFOK4UYpz4f4BXrgAtter84MdqektXUZHLASXsZHdh2KHAUHcX3n6Hxq5FYBs89YVe3
 qHEm5QuPN5DTZCUxDmXr1MW7uzygqvXd8BXcgA7fpWliYlDjafEZaZqWPMN4nrzHLj3a
 G7/K7bzlS07VmQBwfWEIOq08cWZY/qBqk0GwDr3LE1wn4nHAPKM/+lT9Ot62Sct1fNHk
 cYdC8dOvKmSxQ42/3cX1BI4lvHl4+/NjhbcvfoVLK6dDePZwlJsMZX0QKIdvbIsx5aMa AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psatp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4I145723;
        Tue, 15 Feb 2022 14:43:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/Dx/mmDFr/zGmoK4DATwZGCAXcM/P9TPURGGSWFB6skYtPffUqIarNfj+XYP9lJ1h+upKCwbRK3DtGNk46cIAkXs6a0DHIEEBqvVtFSQVK+lIE3y8Jws48flHboHXXNeB+TY5cfC6dTCcG/S4cCJN9iixv7svNOky4PJIOGHYsrreu0a+pB7aZTwTr3UyUayPkQKJW1EAn6HpFqUplStiqJUqgf84PEvPR5T6bCHtIdybGcPrq1WW7EG2L69kqAXGIcSW7XdntK1qd0ogWcdm9C0N83LO7WXLla24xwgpcxx4PbHpJXNRsYTNaGvRlusUzW8kDXjUPYI7Ranv26eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ar/Z8yjF+gGc+n32D1/k4TGMfpKuhRfX5pIPpPTukk=;
 b=a/IN+4ldyphWljTr17PTYxfWIlHWTZyYcfxh6djdHwaL+ZPgHYRVcx9aLvcPVBOFdtEzRtQHqg0Yqv/kH/4gV2MKDWVdsw+btZsIhHMgUwqVOjLtThc+G1xZy1aBfxdi003tNBzp1MPAbAXFkGcoW3MqCydGKoSPI4jJUvNA4SUKFJz25ODDLJIn8l/aO28AVwlsao3Zdloum+r8cqr+Eav6K9HOpbSvxD91xiTNeDs5zvIA3d9sRdFoVDecFMbjuUrJiFcpdddIWiOl0t5ZkMNzMyCt/RWGsrQp61jv/i5i19lwlvaGPPT03tbzlTt5l4WTz1StJgS8ZLqq9i39Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ar/Z8yjF+gGc+n32D1/k4TGMfpKuhRfX5pIPpPTukk=;
 b=B/GiT99yOm56noV2teIvk18rA/RVVaJF+imhHnVLsDAYgnoLJJH2Olug+0OElMa94dwh1KTqRzUrUSmbvHfprVi8Ph3qPVtV654BvZ5bdpNMd/2T58bRDVAzq70OiB5dfpnwNt90SuBBRPMOARmJdzVYiMKnYKzMrhMofdLMUc8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 38/71] cxl: Remove vma linked list walk
Thread-Topic: [PATCH v6 38/71] cxl: Remove vma linked list walk
Thread-Index: AQHYInpeXEUdJRVfE0yTtA9gNmyy9g==
Date:   Tue, 15 Feb 2022 14:43:16 +0000
Message-ID: <20220215144241.3812052-38-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bd5ba14-666c-4d50-40c7-08d9f091966d
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB557815DAC68157F6302E102CFD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 08/JVcpQM1vaXY1Mznv+oHPDJFABLyAM3CYuCO6kMy8Dtz/0Ro8JGgGSM5NLL5AQCVC5D+OiuqOxWtrZZKMwPB5Y36MDv3PeHtIZXHi/dF2VD9XvwCQjOCu1cBiG/oO+Na9zYu4c8PZK4VHVjKxR5ssGQpC94yCja7mHe7BIRtt+dLVhS8XBryWt5KNaxw1HW/12lGF8VDApWAybmdXBlCcE/507zmwg1zUMUgzkWP28lyL3/AHUGLbneicj5LYC7FBfxZHsqY0xm45ilF2GoZzspDj6RARdUteD1Bu9fAT8hkDCuSNeWW/ciT/eIVxqyn8G2qOy0KgruKQ0wd9H9eycwncdBRqH6B1HQYriUiMBj7W6Tu69bcSe2rjmmxb9P+QUwNqk6Ef8bUzk5PIHp68XuAOK8BwwE/x4KDLqETklP5QoPURpbF5b6zc6dckAfcOTldqjbW762+NEWSbolRu/HZoUcyFoAUZzW4oGiW0t5lX3W5JeshcC+HfLFZlYHvTpBrSGJk0rHBP2Bwlwk39nRINNWmCs2iX7qq2IiYknPPuxm+QMrqZ2b4qPCB2ZEobehDk5w4AFeBdG3a3fk+Opu0B4Vn+RimOhKkCbiM5tumcAzaRpuYV1YQxm35PvzOm9y6b0aU3XWeRdhCuBK6EYCu1/Z94QXvvCNcuG51V6N8VDycqWEFpqwv76CrDu6ip4gNCX8fxfGs8UKz35Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AFYs/ohRUtxXSj9FFCHeNlYdm67IHlxyPieOSB93MRuePFSGd4wLo+o+QR?=
 =?iso-8859-1?Q?jKOWspSXk8dO9Pi1sEVACF8tCqDFsUfEOreiay2Ztd6UgQo5V9JSn21nLG?=
 =?iso-8859-1?Q?euDNMBbQrnNpp9U3uUmsfIE03yAUkc/JJSHPRTivaKzgbktx/4UMgRBx2r?=
 =?iso-8859-1?Q?+zLqREBLg/+e6w1KHe45PQ5NR6Ho1RXbOX/WMGx0vDKCHLn/4xgWZ5zr/4?=
 =?iso-8859-1?Q?d3SQjc6DbU5g4LnntZPbWnh8HY2JAcU5vRbHST/X6APbFaqbWZ+RErWmqY?=
 =?iso-8859-1?Q?/OXAQVnG/U3XiWaazvkEFjNT5OLTm6F2lbkpnj0bSLu6D0/umkTFQ43W4k?=
 =?iso-8859-1?Q?EXBdXeXGsbI1WZueggYEUwOD+5IrB+oHd+gOJWGkUpOPTNYHOMIk5fB5xr?=
 =?iso-8859-1?Q?B0E7ONXHMM1e5rMhBmSt1MfIFHLjR59TYgcloCqJBvnLIEDWfiQkRa8aHT?=
 =?iso-8859-1?Q?KGkZu7OMpIC/zixKjku+VdKuA7ivgGkuqc/3FKHk/kM5oqQqu18TwNZWyO?=
 =?iso-8859-1?Q?wCVgz9bDclwelQEW22AYny0I8mKNNzgxw3fTLO8rKQWU9l8ngeNRlb92T6?=
 =?iso-8859-1?Q?Y7pQVcZuPHGvOt9Rv2kZmQdC3ThXKSEfHhmCLSKPWs58qVyZdlgu7XsXf9?=
 =?iso-8859-1?Q?awzigSE4q9cRRM1uqEgWt/Ik6cucMwyDn6cO+5PPwZ1d4FMq0BVtggYzGX?=
 =?iso-8859-1?Q?uPH8Wf5VjjfQ69sGC/PUJN40C8uB+oCegxKas41DqUxO3jmg2R1w9l3le4?=
 =?iso-8859-1?Q?gJGwIFTUHyZdH6nFxaOjoQLTTHF+DDjF1QU9bdYWGn886vAZT87cQgeciS?=
 =?iso-8859-1?Q?dnHR4bJOmvnR3LIJGnpTvi9bcJBXcACAp+IhZmZ3pGOpskmlX+DP0uovCA?=
 =?iso-8859-1?Q?xpIybwzW+VWNpjt7kWA0srvyaF5jklDCVM8wLBs5twm3RpNYoswQ6CLY6m?=
 =?iso-8859-1?Q?6yqz+J46hDimbtuH/FAfXTJ8rpG45lzBT9AGAO4meFzhqCrVxA5dLZTvd4?=
 =?iso-8859-1?Q?EeALmkpQsuFKKeVgCsjJ9xtj8jzBdQnoi/nLIOHW0cLGQkpf5lEHDGJ4lC?=
 =?iso-8859-1?Q?wO1nm+W+bqMq0VZ2S1KO2D2aFTNSZf2QhxLTmdnI3nxK2NUt4xKLHL/p/X?=
 =?iso-8859-1?Q?xUAFdwfjIHFULOFe6AJkEPlhUX7Zh8MyeihJ1LvUrv+3d8UI2r4i9CojlA?=
 =?iso-8859-1?Q?GYm5/ACR3DYXhaP77MV8AWIhdfda+hpm14C/C5uk7acZYxRmsx0FQf9quq?=
 =?iso-8859-1?Q?l5KvghveWG8d59HCbM3bNi43TZYxsNmASRNCtOOBboEj5wWwKi8VC7/bn1?=
 =?iso-8859-1?Q?u1a6Vl2DBwO3vixeKsic/A3z5PEJGU7qip99XvXBEqRuKkYeaF8vdJ/VAj?=
 =?iso-8859-1?Q?jvGCs9+zMT5fga8hMt4p1Hb3jWT+BI0111KTQA/EnlwAZUXXtDmGalUsRk?=
 =?iso-8859-1?Q?2aJ9xlDUqj1hPSE9P3JQJRixcNzg3dyFCg86KYek0c7susCS/SlQ6YwLif?=
 =?iso-8859-1?Q?pwS3CUxB9ogV+0RI3/kxLs471J1N+yaUsK5fmAYVazbySDjGqn0e+ZQMlr?=
 =?iso-8859-1?Q?eizlZijRbMpiNaK39N6aamuYYYFnOIBGWjGSXgOwKgsxgCn/USBFmMI6db?=
 =?iso-8859-1?Q?QdJoaGfFXIiIJ9EeKHQg17epV9NdytI1tRZyxQX5r96RNd0MRJsoNCtsrE?=
 =?iso-8859-1?Q?D3a/70zo+j9/CR7V56M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd5ba14-666c-4d50-40c7-08d9f091966d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:17.0264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3H66jciRuTDxZUEyvSYjwaOOzaNLTSyonoGKdR6neFimcLgiOy2SnVa2iE7vvjc19WqgJdgnQIVYXr0+fMrCaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: nuOdBoUlgu5PWeHGC4Wp2FefDwQ9WVS_
X-Proofpoint-ORIG-GUID: nuOdBoUlgu5PWeHGC4Wp2FefDwQ9WVS_
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

Use the VMA iterator instead.  This requires a little restructuring
of the surrounding code to hoist the mm to the caller.  That turns
cxl_prefault_one() into a trivial function, so call cxl_fault_segment()
directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/misc/cxl/fault.c | 45 ++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 60c829113299..2c64f55cf01f 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -280,22 +280,6 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		mmput(mm);
 }
=20
-static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
-{
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_one unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
-
-	cxl_fault_segment(ctx, mm, ea);
-
-	mmput(mm);
-}
-
 static u64 next_segment(u64 ea, u64 vsid)
 {
 	if (vsid & SLB_VSID_B_1T)
@@ -306,23 +290,16 @@ static u64 next_segment(u64 ea, u64 vsid)
 	return ea + 1;
 }
=20
-static void cxl_prefault_vma(struct cxl_context *ctx)
+static void cxl_prefault_vma(struct cxl_context *ctx, struct mm_struct *mm=
)
 {
 	u64 ea, last_esid =3D 0;
 	struct copro_slb slb;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int rc;
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_vm unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		for (ea =3D vma->vm_start; ea < vma->vm_end;
 				ea =3D next_segment(ea, slb.vsid)) {
 			rc =3D copro_calculate_slb(mm, ea, &slb);
@@ -337,20 +314,28 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 		}
 	}
 	mmap_read_unlock(mm);
-
-	mmput(mm);
 }
=20
 void cxl_prefault(struct cxl_context *ctx, u64 wed)
 {
+	struct mm_struct *mm =3D get_mem_context(ctx);
+
+	if (mm =3D=3D NULL) {
+		pr_devel("cxl_prefault unable to get mm %i\n",
+			 pid_nr(ctx->pid));
+		return;
+	}
+
 	switch (ctx->afu->prefault_mode) {
 	case CXL_PREFAULT_WED:
-		cxl_prefault_one(ctx, wed);
+		cxl_fault_segment(ctx, mm, wed);
 		break;
 	case CXL_PREFAULT_ALL:
-		cxl_prefault_vma(ctx);
+		cxl_prefault_vma(ctx, mm);
 		break;
 	default:
 		break;
 	}
+
+	mmput(mm);
 }
--=20
2.34.1
