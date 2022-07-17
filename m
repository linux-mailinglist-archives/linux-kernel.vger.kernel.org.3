Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAA4577340
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiGQCrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiGQCq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551751A043
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8g35009610;
        Sun, 17 Jul 2022 02:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dHFj+u3IKwyE6aKTogfed8wCvwRJHUMoTzGouUTk5hs=;
 b=Eg1dXoQm5KCkD292eGBJvfi0YN+IP1hk+00hWrSuuaIwByX/jADHqKlI3/Jwhl5WHk8H
 ezfEThFaPqBc1Nvbe8mGCh/HAbWyq6i7ZZim9bbp2sYhM8rlT7BmDgM7FU7aslaSzlS2
 joeFZinotRoeFMLk+0ZqQJKnA8INGzZZyxnMnXAWgYeS70RvXIgHvYIMTKCrAL4ojvgx
 Dby4wAAaJ4rUGXr4P2HB22Qo/K+nUuIM+wyKwtBo1tdNOvPsNyiDasF+CHcODPEh3TgQ
 HyoNGW9VgX3dUDFdHWBJqSTlm4IjQweyTctXFpaYQJlIMB7jlUnXyYzPRJPvwm8jjpog wQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0yn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImb036151;
        Sun, 17 Jul 2022 02:46:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxXBpmsiAHRP15EY5vpQ/ptPKHREt49mS/e/df5nAbIbtr8TuSPhAt8L1vxPI7sEdPz9yfAeThAIFYcAtzg2VKNn/zIabJ2krt/+CdgU8SDGswaqF5PfLwOY5ZUhQG1a1piAV5w1ywz+d8Iuji12egokKIFyrQDl9g00uhykj5UzLWWwfn0xn514RtV14yXvxJl7Kk3tJzxe2/kIUc3nldbYTY12oUNsFsvn0CzQ846pSxnCCHooya+WhOUdT6vXDVj3Z11Ps7nOV2tq8ppFXCvi5Oxh4jN/klsjdTE4sJ4VuXw1u6ALYs8sPgnjviiiHIVtMy1+bJcdT8QwOfSWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHFj+u3IKwyE6aKTogfed8wCvwRJHUMoTzGouUTk5hs=;
 b=DwsG5gf+lPJ3IOf93y35qEE1yXm9Fw2nef9+EKYCxO/nQgzFEOMPDFTHi2VT8bv7oYM8fNCy2fnPSFhMcBMKxn1tLS4APUY4jmDJyjU97r7xsuD6YFkJ3b/yFqxexiDME0D8W7KPXiEcPJOzHA+Nk3PNuq4r833JQ5zaVqib2EoaIdR7lnGxPaiONsQ4hGI+0kZcpCk/+SKOl2TyBxEmkE9GpRDSai7ubDkKn+qjLIfChKrNuLW+vM6o3WyP5GkEicscd8MYIxGuMtEec4R3QrfTI9pRpG3n2m4ZL3XiZnZnNiL+zj7JunHz9a6qu8yAg3d1NPFnVuzg5m5TkD9Byg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHFj+u3IKwyE6aKTogfed8wCvwRJHUMoTzGouUTk5hs=;
 b=GA568ZBDzjlaCd/viwn1fTlbNUIsGEtcxaqaYOB/w9ekXdPfl80bsvYrRyos6egsFYGE4KEX3SKZ2mB99S66NFvbOnJ9QsRkrVUU2msH1WxBkKw/S/ZFTKR90crxl1Ge8Ur6HIwko00BhtW9TyVUb4gc8hMQaf2jxn9kXWxV2jU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 19/69] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v11 19/69] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHYmYdydKZaEL4iMUKumanZYpAkUg==
Date:   Sun, 17 Jul 2022 02:46:43 +0000
Message-ID: <20220717024615.2106835-20-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee56d129-7e49-4bf2-e10e-08da679e9707
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2lrcwd6W3kKGUpqKte3HXnBVs0Ks+w9BCijXesx58r3iFbwAX0SLhvmj+/KzPPBclAEzbaq2D68JK3IdFcXKjsJGA5F56Xkd/ywF1FehEa5lXqiZJqnIlRpxo2iAEH1b63rxlqm/XXE9rfgHcRaLaAf9YGuft5IVLS+vjcuZ+sHOjgx2WknWa9BseWVdtmaiBI1K1jeCvuyjPWW39mPjE7Ej813eSHKxh4YnwucLhn+h9x6FgX0O/5mFXfkgpm6yezoK2ic5mRUCfMd2FzV2LA+9m+yKLkAw/vynKYF9FxWVvYnzyglOrD2WBe/QNRdV/Auq2kDT/7ZxjNdi/AEgwL+FVLAeoF5ujeVrU/OJEJYe/+Vbdc7mXu64YdkivYNw+xpz8i6eYhzfeTz17xwcmCNGcaFIapOjKS+KhD7Q0KfnHYnfo1XZXO0rGvMykPABduHuTjAMf0i+Ar7vxEuNOj4Vrs5fS+KTuuugE/B+eGrhOqBWNyen18cxr17wgb1hAKV2iljp+7PspHeXBP04nkDh5JWEnp3/1M1VoQzuj37RMkuQRwp0eEfGhSvkK8tS5xmtjuA2zJLxtcvhtm+buPNMQtrNsWR4qxXeQcRLYqTEQCUdgob0oXl4PWvlisl8FiwKe9l+xyQijdvH3w6+E/0YIKrYoazaf9eX6wfkwPVnPUldQIVzR8SLy3NRrDJr86J4W67EgTczvgYQCcJ8udvJIzr5HSkuSyfTZyxxFCqrJ9BASSHXmUjgNeGAKJa0Jl9sGrSQif/yapCVmxqiyiQGWFaxsbFvzEuAE1rVQpewHsJLvKtTG+KGShWE3kEpWiKfzR3l9kvgGo685l0msJHgWpAJzFR6pM91AId+BJjRYTt3drjfAIlLZfW127y6tCKQ6fb4f3R6ofDR+R8fA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tr968TIgftuBWKYHZu1weDgk231DIMk/ukni9uqTOVZAmEBnDoyaR9MnnJ?=
 =?iso-8859-1?Q?sQ9hhe49C6D5E5YEA0EO+QUpeD6UMG1CyS9MaA8XtlabGFLfJSLW1zjaIy?=
 =?iso-8859-1?Q?13KN4axILZizqoz4xtfI5k7OXEwm1UnKuENAJOXPaOrakrx6E09UGBYFv8?=
 =?iso-8859-1?Q?wn8ToJY9DWL5AzuM5iOBgev/MO+eZ+6Et2CggLSzDnuiGw1DNaKf5eOj1/?=
 =?iso-8859-1?Q?6UgIn3fczxwVJIAzh3ANVqMWSIDtqTJWiVFhBdYb+BVo728ziF9iGOJCRJ?=
 =?iso-8859-1?Q?YI77rVwAReH1SRRBOv2XAd414nv3mU5VxMoP/CDtg0z2Cmkw6qeijN495y?=
 =?iso-8859-1?Q?/7MDbUsg1QWUFyqWuIre0KhQPwVzXSzoH/fCv96nVsduPvTJvQ5yPEefu/?=
 =?iso-8859-1?Q?ECLR4zCWpbXnInPI6pMiG+qHUYLDoNQZ5cjjUSQo+OJ1ojMg0TfdT2EzKM?=
 =?iso-8859-1?Q?fHRcV8VCWmHHkULCf4n043rJWtPd5uJl187qGusGfaJ+ILdp9jwISdGNx2?=
 =?iso-8859-1?Q?nh/sQyCNVIt8wipbl5B3i82UYLe1QUq6oAmQJ76XfiZsmUmCLn6iT7M+UC?=
 =?iso-8859-1?Q?NQeuwXOBdu2pHCXi6Fv3wMzrDXiS551QvrsfIY5VKcxxXfiH76VLr1zuEL?=
 =?iso-8859-1?Q?XhiPNl1WUCXyUGWXd9LRrflZILBlXpCjlpmQ/Ucep5H7u6lsmVRcV/80Lb?=
 =?iso-8859-1?Q?yf88mg+eCSV1Cw+2Zi8nkbwFZNV38Hx74nVR5C4Ks1HF+WrvX3ZcJQUSKK?=
 =?iso-8859-1?Q?id5HPpCNV1DcrKiGJ3lxJjXytlKxwnefQssR5SaYJMyRzpj3HpXQXXmfCp?=
 =?iso-8859-1?Q?wy/5gHL8MTvN5C1hGTAmbpM0sgZLMPfc9w8ypszDXR+OtRSiNF6mKRrBb8?=
 =?iso-8859-1?Q?wjhtPaREufILO6XtAPYwf39D2tTGGg/NFXHuMHsAXjB9Q5u2ITJqYdRUsW?=
 =?iso-8859-1?Q?dsE3AVZzt7nysJlnt7eZ7CV3HajITqT6+roJTN51BzMQS1KI7MiWbKIbCO?=
 =?iso-8859-1?Q?8+S7FyBbzUgdTx0iyWjoINsdjvHHX74g0J0Us53aLLdUHSTsziVUFT6w62?=
 =?iso-8859-1?Q?vuVoSLvVX6UT9O4l4KstL4XuUkwv4UUDmkOdRtZC+KjGncEUPNZE05BDxj?=
 =?iso-8859-1?Q?GCf0Ro9J+XqJ6rgRLuiluhjmvQMzg9wxbybJ2rYtIV4exTo8WjEVA/KPhG?=
 =?iso-8859-1?Q?+beC7+pqtKKc2p63rXQ95YPvsqt4PX/n6JRZhGm3Kfv9EZc1OVwIn/vJec?=
 =?iso-8859-1?Q?ouwNy8kU3qGlFslRLv8/SAkWBoa/xS20M1JZOcVDwVnFZF0s9YmxB1yl5x?=
 =?iso-8859-1?Q?kaucIQuGjMSyIO/knxi+Sa3i7ASijaLndzUZftrv3A1S3lbMVjzxZY5Mh6?=
 =?iso-8859-1?Q?QqThAv9tmfB9nBmH36iEflA+Mg/BHQNYFkUYIcT4WMfdM1d4iHlbx0IhQV?=
 =?iso-8859-1?Q?Qz4vs1CpJbG2yb4wk2kSbt1/hGzKU14gCvHEebxjXoTtgZQosJVmvWuhum?=
 =?iso-8859-1?Q?7iRR1yAOcXyTQeW9mS0o7TPFJqCrB+hWksu+mVJEdq/9aDfWAmMrud1WEQ?=
 =?iso-8859-1?Q?7AdaHasfAo8loUOWbog989h2V+bWHD+BIHy+Aao1OG9HCWodTOSpPB8eSV?=
 =?iso-8859-1?Q?ftWaifucgZ2D4H1OjA6Y7NWiNkIBTqeAcSQu5euKv0ZJgA11tHcfBGnA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee56d129-7e49-4bf2-e10e-08da679e9707
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:43.0062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEjIeVgibHynZoJu+gZY79EUBYFyzYQMilTB4sCN78Ip91lw9aDHTBje/cqj1cGnHbuXs61q1RFNo/uTpqeInA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: vOLhhk8-E_nB6ARXEO_yJ8ej8FncojFq
X-Proofpoint-ORIG-GUID: vOLhhk8-E_nB6ARXEO_yJ8ej8FncojFq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Link: https://lkml.kernel.org/r/20220504011345.662299-4-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-20-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
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
2.35.1
