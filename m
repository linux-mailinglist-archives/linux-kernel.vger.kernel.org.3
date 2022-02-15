Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0234B6F05
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbiBOOob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:44:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbiBOOnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB452105288
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:29 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FDunie005201;
        Tue, 15 Feb 2022 14:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Le09Yyqh/Lt4iScmunRFDbexNnWKBhNSzPw6e39z3oM=;
 b=DnqPI9CWyBBIjI0ZzprVAO+TLmPrB8pop/DyV8/4HQZmtI/j5035hy1Y+hahDKhRZ1Pr
 /3j8OOIZdwLTrBF8jv8bftCdudbjN7RhzwIu70jWtFVzCb9q1UfkcNEfz9h+1m57eNKZ
 sy4bVHqSt4qw1k+I8sFXyM5sgGUOxkrR7TdVUyM4whwXqDR2UT8BmYu55fNEXDqYcAc+
 2N0TfWYjEwFdxhICKRLXJfRNfCSUZ52A9BAdbLOMLb16Cj5tAWRmlWZJYVD26zbA62mA
 n7kJ3lFZ5FIhXB7CRPzgu71FEvicKyw4DN8FJQmWIZU5v9rEEVoReBCvNgX5KH20l9x0 Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8570shrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeUFm145877;
        Tue, 15 Feb 2022 14:43:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 3e62xeqejm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvIdFp5hEEZJyl2oI+KX9OMDoIfocRdUYMqKXW1TVpXIcBuwe3TMS0qDIWcbNh0pn/B9Y/mHMUUuD9OJqLGURJMe7Z1Qw6dvfqoefffWuihQoClrCa+zp2+X83yZBPHKXdL1fg8SKnkBi2vLycL1x9PsxizhMwTVvJ4gywIGZVm1RJHTNha0VEZnXQdptzX/eCByXgt9O6oPaus0ZQcNS/DxEt/q3osXV/tO/XDJo1ZkZO+UYDZ2Hik1GnX64aRL3L2Wjp87/IYbDbf+biaazOlHPFKfLC+AUHDbd1tMHlzpzg0jbs/YoQxlXG/zaHoN4YhOUvge3RXupHA6CGDgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Le09Yyqh/Lt4iScmunRFDbexNnWKBhNSzPw6e39z3oM=;
 b=PRosTjotnH6/8n2FFxhgecZxk7ochySvbLorNZoUwaTy7qyQfH0Jb+M+2UpbzVuCMNcvJ7+Hw58+i6icOKMQ0+b2Bs9EVADIMMYdG5o/URhQBIzmFwfkNHhD200xLbCdCI7gtduZ0PRT1fFJQqdoSrDI2E1EPYDxNesokL79sGouzszaiSBdq0yzTHmYK16y3NeIlB4YwrnkV221JzTQyLq+Lyh3PhpHdbr0UQgKshEHLRUXRzsYqfavoNbXd1+5fReeyU9h3mI9Un+zQMptl88IV9jS+Ns90v7lYghEJdPF3MKyb8ShZPAwhTDfOBj1J40hET6hK5xP1B1qEQ2t1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Le09Yyqh/Lt4iScmunRFDbexNnWKBhNSzPw6e39z3oM=;
 b=I5pjBsFrh2L7uIUXVjJl27m9ZAJ7Crk60uLt3h4lRqd4O+cel3BXSSHWDKTCQdg3H3ZwOY+hx7E4HKW0aVB3YtVAySSYN2IhCl72KwNwYUoZi8pWJvm7z2MVPvBynrcjVFOlsriErFqp7GPFCadrDHouc/X2zQHwLvtYK0VK/t0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 22/71] mm: Optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v6 22/71] mm: Optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHYInpaRgtDkE1/0UmN4fjxAjhoWA==
Date:   Tue, 15 Feb 2022 14:43:10 +0000
Message-ID: <20220215144241.3812052-22-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 716f7f7a-fa03-4a54-0b4f-08d9f0918048
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4689757346634658C0E136CBFD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AlfS3NwjBc5+mfGVzr3tAdtUL3VpG3gL2pXC85MS8guIWyag+APLfgQAB24TWDjIu/kIcgNpuMtqd+77mnfiLb38cLo2MI+UcZ3g4G7RzJ6WAHFcGIwuNk3rmA81kXXvkWQkrPY1u0WnU4897CqnjsBeEWKZFEUFFkHVYvyjlBZ2+0xGFJPEVvz1JCtKTmz4yVEGPPdlYoiaAHA1VsveEb8/IVB+P8OqG8t7Ln3auabST54AMzIoUuFBi7q4WfdgMq3I9KWSdzPNCWTZGifNOVYrd86uUxOSOm4z4LGAeOwvnOfazfJl2v10FX1B3Do6iVMzC7Cta2DQMu4bEIbG/BXFpa8jLz5aFPerJIQuTXyHe4eko2z0ihMF70hmDNptHX63XSMc04W4jtMm4vmgdHA9xDRsZOjpmaZJIEccr5Bt2tqBzlgs1rsFXWR+Jd2L/Yda22GswbIlYekoX4ihFDFSItwkXVJQFxO46RBiW0Ifts2K2ls3hhOU5hs2tMl+HGssSDj4rVsvpTkSoQsUIvI/ebYlw3JXZ7wGevcKnRQ7KAhCYoYBjCiXhRD7zMA5mdOQoUjcTk5Q81u1sInmJPb/CK9NK51iRm5fAiXdJsxYB0JbHjh8ZjzDfxwplyGPJU7/aT0cKSDnbI+gxD1pUrNOrOqnLt81dW4UBXDBaRxqlyAbwaPPlpr3wu0Q5pQC5njXbh4Bo1daEZ1h4tC3ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(4744005)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zUDpbFaIMa2Roe+A/3PBzMU7Y+2qy85Ssr/k91PmMcqILM9+0Ss83OLp6c?=
 =?iso-8859-1?Q?pujnzM5iNRvFZaPCBcXrgZ+cEzpY9BvrFQu2RM79grGreSfJWTBoaIpE6X?=
 =?iso-8859-1?Q?zH2OIO6+am+MDa6GZVVvfVOwW8scts2f+3tZ/ssy1+gbRAk+M4G1hQJLOc?=
 =?iso-8859-1?Q?bLg/7WChfXrZXzvtNskl62SXvl88UWnu0uaovk6riHsuWzMuP9Z5H3/ZSd?=
 =?iso-8859-1?Q?Djx1atEWSBDI1F7J1yw1Le0Sw95qQ9JV+G5Fb5q6aZFdtGLxJBMenTNDMF?=
 =?iso-8859-1?Q?igJ2P4fy4z+WMuZUhFmZ6ZSUUQSc0+hwYWcRcSeqwSLRWrr3ND6tM+PpDo?=
 =?iso-8859-1?Q?wKEK1fCqpHXdK6ZkUJt2ctikw2CJlHXsSKOcdlSYuy6WmoVqXPU2M6gelg?=
 =?iso-8859-1?Q?KHyWjbYcz271o8Mnubbe8NJwn/vwN1KPSsm2DagHzb1l2KuagYAF5HogAg?=
 =?iso-8859-1?Q?H2etjRKNWaLNUVwCtYZmOhpriJe/E11Un6czULZk6u57tl0m/nh+lrpwlS?=
 =?iso-8859-1?Q?Zfc1KkMQhIAxzoIA7RMpqUXNx9hSVSF4q7UY0HGqbZeSAuoYaAqAthfzuj?=
 =?iso-8859-1?Q?7U/07K5Owg66+lfVqMZxUM0mG7ry4+Zv547s1qeoCSv9Y6sYynDPFtzdER?=
 =?iso-8859-1?Q?XcPFAA4SB1oBk4moZCIxEDfCmb0+EzIGyFz1bQNNBkNjWFjHp1wn/cKrrE?=
 =?iso-8859-1?Q?ZCS/+tu+ysT9jJOoozNqJ+amicnw8RSzTuZ3sr6jyM61E5aVGOgRHYOwUC?=
 =?iso-8859-1?Q?zzTTqjjFSySvZox6bSW49dJfd5NqEHkrunJ9HIfU6JRPqkg2JvA2rk5i8d?=
 =?iso-8859-1?Q?ZBnQEGuPv7evFcuaOK8qBNHzaumbhkNaaNFchQ+HzcS3XFggemJz0C/uLK?=
 =?iso-8859-1?Q?zBrvV1cfovSlisiXryWgfFpHU5QOIux80Q6eoYgMf5kNxWkMdbwnqdh/I6?=
 =?iso-8859-1?Q?FD/tOY/75AyNpDXqCyXLWuuuNgFSkQtRJHuA+ZPlErx+hsgC46cTGyyQ9v?=
 =?iso-8859-1?Q?C8xQXI8QsTZiS8Grd0kliznqYXrM1KOp5qiKzOC47fAgPFpHIgXP0AlpEN?=
 =?iso-8859-1?Q?CFBngDxg/Ijlr2PPUmpSPAr4V9Ys+IYVEjCuagyggq9YNFJI0L/0QTXmVV?=
 =?iso-8859-1?Q?nmfLLMWammzLTU94GXOSKni5XibfZbJn9M4Uc3+FsR7/sEWnmEglVWXfoZ?=
 =?iso-8859-1?Q?12ZwqNXYuRf/AXcncBuIv7EZ+1BeBCmy8HdhPKIn6izV9WVowWHUbOvGmx?=
 =?iso-8859-1?Q?4+2lweffULssr4AAwLMUyPJnxzOKB/tH1pZ2BEdu229qOIV+aX026Tobqf?=
 =?iso-8859-1?Q?M9uOJKaYR4R5J16VKuojxPXgS5LdMBHiXXx4QTnqmDfRn5NfCuAzpPAZJl?=
 =?iso-8859-1?Q?nvKvR54E8epWFxejYDn9O3wOAq2VZawsZCY6AiGvrSTqqJbkfd1J4Dia2k?=
 =?iso-8859-1?Q?oD/aDuPMCKT2Vx1TG25kah91dSkIZ0VBa3V0pbVKqfl9q85nNWdBVJk21T?=
 =?iso-8859-1?Q?AyVbXNVR60tQpCqxPubwI4JqLn42hs6i2qu4bK1Pu+mUPBy9rG/h1TB7lX?=
 =?iso-8859-1?Q?uTmqvRybxBE3ggCE3WGhZCjte2jYDkK1NNCO8dg5SVhvyxcX8e3xJsRWHY?=
 =?iso-8859-1?Q?xTkYgdBZgNq4NQ6hd+CsNxHDuqjTwvEPIcboReY648XFYoZ8fo4sOw67Aw?=
 =?iso-8859-1?Q?fjwAlMvOFuDtn8ommE0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716f7f7a-fa03-4a54-0b4f-08d9f0918048
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:10.4644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ahWd20fvCDLU0Z/Z02/+8GUJMqNTpP6mn+UpBWz9+PvwMD1xf/J+Eh1UhlXKV2u4NErUq3haBsD9FwIpMaqJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=713 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: IvCIwHFyY3-xWU6YlgCvNX5BCUEHECnu
X-Proofpoint-GUID: IvCIwHFyY3-xWU6YlgCvNX5BCUEHECnu
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

Use vma_lookup() to walk the tree to the start value requested.  If
the vma at the start does not match, then the answer is NULL and there
is no need to look at the next vma the way that find_vma() would.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4c2341bcaf03..110b1dcfb036 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2856,7 +2856,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.34.1
