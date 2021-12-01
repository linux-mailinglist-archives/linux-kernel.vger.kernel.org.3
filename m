Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED416465001
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350039AbhLAOk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:40:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4540 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350005AbhLAOfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:32 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E7UWF017207;
        Wed, 1 Dec 2021 14:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BefKbS0wfGwngATHy2Ni0q1IDcgRp3hkh9demPj9Yn0=;
 b=IAh/MjWz+BKEo4IVo0JU48LTyVsEHTPBWPgbEe54bXd2XK7CMPDHaysn20plfZ2pX7TQ
 D66/z6ww8s7U3YrC+pXrxc3cHTD+7nZrM9BP8V74MMRFhOU8xF9H0Ks2D2bqKGvvwYxx
 /yymyVnpKvWKCFZiFwyurHKuMIlguTlNtvGS/ftFotU0qJIe5KIfPDNMk23GPs67Ibv7
 mswZzh/JAQaEllrHQo4bswy0X58YcNl4wPM2kFBOcgIHfmF1DFHlF68WpX75A6zFnAOY
 9Iiss3SOxt1J/F2mdbujExv+C+u5Fa2kBTk2sy/bm3Vbsg3KohnvRqeA8ayjq6kkpUhf iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7weh2w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPP108922;
        Wed, 1 Dec 2021 14:30:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQt9BHbJzhLb+8k7IB1lsnDP0TfyCiH8pknCzoQy+CqsvGCgqbr4gXxr6AxnDjCQ/SI44WUJTCFGjy44LOceaG9kd5y8yljytJLoVGzeAYn73IvInMgb1nN6/W2jBWqwy7UinMaRfHaMGhvPodVKrhZEP8HbM//rIUL+E5jK6AwX6i511cQNBQcvEeKBcPXgtVJrEIA+G0/qv7L2V5Z6VDYcp6FVv4dkSxRt15KNQaE8utkGSbe9bwB4RM+Tj3H7qULRTd0YqOF4Z8Q6YXuQK64/IYmIx9HimX/hG5vIkDna/aC/YEUEIajyHKrzPhrlS3BCcxpVlBNq+t0AuZK1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BefKbS0wfGwngATHy2Ni0q1IDcgRp3hkh9demPj9Yn0=;
 b=Grh9L5s8Gh4pA76Bt16+w+I5X3i1SwIBqrg9duRd5kDLY87jeD389HdSjNivXPcZmTAHxt5+PgjNgFKR50lVvIdVeaydGnZtfFzwQqiEKT6I/qsrOmb4ahB9M+3sFne5Aw8IYYyJe/InNuN0sn1RDLPHCnQ8df2qclLMnHUZmEzuC04He0CmYiaiDM+uSP7M50CGfPGerNhmAKn9+E7ha0GT+gM2LLPTEW2hAfMe/y2iA6EEFgbMebLp/TsAqZ0XWq2k+gJLyEygfvtA5I97XcvFBs/1ZwNEMvEuvNYmYepK/hE90sqy5OEMyJ0XVEFI7MRgFwg0CbP1xWgfbaXD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BefKbS0wfGwngATHy2Ni0q1IDcgRp3hkh9demPj9Yn0=;
 b=MuQXBFpvKCmmtCGSp8p3gIvQYFxRgGYZQOoJahBz8PB7Ky0GmxUvtQD3HrRSexdY5lM+VUK4Tu7wmv1yMH1SyotmJSu6sOsK7T2NrL9dhWtCzaqVtvKDbXGLhRiEHKcVw0X/KNrbJs0Q1/wbi8qCKBL8MNnhNZ8QGF1l4EzjSx0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 33/66] xtensa: Remove vma linked list walks
Thread-Topic: [PATCH v4 33/66] xtensa: Remove vma linked list walks
Thread-Index: AQHX5r/vRpDQ3tKIRkGBusNvbzhALA==
Date:   Wed, 1 Dec 2021 14:30:06 +0000
Message-ID: <20211201142918.921493-34-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b5818bd-2c1e-46bc-91d8-08d9b4d72414
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508DC1F79C6096632DBA5BBFD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 65mhI1r6nbuf+ch9mWmJ2mpcECsjaqTOX/iH3KfGwQkRpJru2D8YsMJz33pouZYyouuGaQxnQxYmmLEamiGYnZwprUbDRmC79OC8Q1M4iFbu5mlJlfr99cf9LP1JN0cBmNAVkahHlK/aER5bwiywK+A/AN9XtUIA/PsiLohO0iNSv57W0YLUVuGBwKt8+8lQMRDf3Ti780Wl22EGXQe8eBuIwy1TAJDjt+b/OWOYJJy/sAmZUdDtNb/xWLa08pXe4+anxiBu5ZCfRQwTT7qVAgXicrL+jI48IoyqCF3wG3+BFzzdkzptR3R4W8k25/R0WkjnYy9DirVcZZ3Lb29Puf/DAxensWNCZGtuUbX2kU72rbaaS7BqWXpooYD5yIXfkqSbnCeWJiM0Kwh6oLKK6EgUco8lDLxddfCerYYGiL4iX0BUVOTPQf445EcDVjyHMQB1Ck9A5zwNiBQe4ueof17VKyGjuVT6dTJ3e97QRU4CTGXdt4b+GXEKuPpRjjFNqAdIZ8TIR9Qjwcrnwzb1UyDtSlZ/iqKbzbIEJoVwFN58AgPgpEIveI4mv9ZPG1GMqK/FBsDAsBehyRpobRifg8ErahsTBRJPCgzZ2He8BlKtIKObRRSYNVaTrVqQmgO0ytjas8/x541wkiocb9/NfGpaAfcg4cMHkQKDIKsVvNB/nnSl2odvKx+iTF2Hpdo/hAnBf9Co+x3BExUF6ZcdCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?viwRToZjzwZ6/vWqJXY39hlvfEuw6S5uNk/vXs7KxUE14m3MDXrDhaisc1?=
 =?iso-8859-1?Q?rWuzT3Ez5gcq+j25h9S7aoTcRa8sp1eHE4H2n7ZeNLS5SvqZ4S+jBCrJIY?=
 =?iso-8859-1?Q?qhTE3E5kkjsh50wbYVZr8VSWl893jpHF5Uz6L3uX6Acl5/bsM/+3nfMhyc?=
 =?iso-8859-1?Q?2qdphskLJFsKyTkiIzeQ8klpbTrju/cSLnLmRxTXTDtlQ9Zi0Y9/ZGOUof?=
 =?iso-8859-1?Q?Wn5gY+EmuOeX9JIX99yH1loV8zMCBy/JufqR8wU95e/thzU+EbbM3pqfw9?=
 =?iso-8859-1?Q?SH/j/bTz+hnqIjVaOqrVqDVOO290kRCZZtO2k3vch8mlgRDpa61lX8Cm4e?=
 =?iso-8859-1?Q?ud0Inzmo2Xwrv41QDEcvlrzowf/Q4JIZ51pzZ6ndrw3au+xkrxD9GAFe0O?=
 =?iso-8859-1?Q?twfnltJdwn3NWPX+R76cjqMb+b8j5AAjkuh2r07EyAdbW8fbeaUP+zLgTJ?=
 =?iso-8859-1?Q?bYLmgPIL/DNUG4lVHnBirYzwKFNQBcPvFvbid46pSIA0UH7v1zAxBZUUzb?=
 =?iso-8859-1?Q?X8Zqv6ru602GsKiiEoSONfNGo+B6sho/7SmYbIwx1x51n2OdUXH9STuQUk?=
 =?iso-8859-1?Q?XEOLWzbch8B87mdbPbxxEtOgDitKL9Wb8kFCPTHAE0A0YAwKTkWM3AC5jv?=
 =?iso-8859-1?Q?jBvY9AfosS7XU/4/gZZmcGukos8cB7SDUxKnkiyhnTQJYuhzRa2c6yW15r?=
 =?iso-8859-1?Q?GHdwIkL/9YmyTOHAdN7Q91e+rtrg3hdiX9jbYfpGoMWbdEwIqz3pT5Flgc?=
 =?iso-8859-1?Q?ZESAH0eXdN3k+qzSBFaMqROI40BRYDk/92ahoVcCjiaeeCwM7g4SLxiRXe?=
 =?iso-8859-1?Q?ZhEYPZjcLv2pR947/fT/5RdRsCUe3ODa6lE4hsExdvHo9hfF4XeZe6jcAt?=
 =?iso-8859-1?Q?Ng+zLt0MZvtavd4woAGgmEZWyBAGZU7bjUKYbFTvVAkcU39AEkPGWcG5a6?=
 =?iso-8859-1?Q?hM8HhO2sejikMcGy8PREeyM1gP/4qNfq3vTctxTj6crLlrI8YIT/OMjgik?=
 =?iso-8859-1?Q?mCO4iORyOMetKNXznqiU7p2ttDu2lqGnFmJAJUDJ8OWA8yAZjbOaPcJJdi?=
 =?iso-8859-1?Q?C0bnx16D1ud8SN1apdoJ+yuKmD4s3mmVgmrFyfTab6YW8DISHkecUHo/Fr?=
 =?iso-8859-1?Q?uHKfWe79wpixxljOERo+U+QLtWt3lGciOCRBNTn8+z2Tu41aywoZwr8K+U?=
 =?iso-8859-1?Q?31APoItMc/edCLd0WZ3NkOupuni2MXURedPfsR+INpwnGbQMLudrl+wym2?=
 =?iso-8859-1?Q?hBPGx298xpgs2lajxKQSG341iL8Y5aM3coCjsucRe8TAKLjyk/wR5RgFPX?=
 =?iso-8859-1?Q?viGOxao5aypKA9CHJ++AX/N8/f8gjrmTy2kLZG9iWziSuR9NVcczeMsQW4?=
 =?iso-8859-1?Q?Tj3KqSARKMs9y2itbH9H7VYgpl9cQHNPhyqkAqTaQZPESCAW3c12yf0KTW?=
 =?iso-8859-1?Q?eWRtMFpxN+haAh7GU7dN77gDk3WPrKLtum+fUH6bf/JgVu4i3ofJQDkwYY?=
 =?iso-8859-1?Q?ichoSwFq2tL12VpA27EZWQOt4qiuNwO4yGycOLmcwpBcSx+CnKR72NN2E2?=
 =?iso-8859-1?Q?DT76BdTRmVU0ViqNbKo1oQyxyHF3Z7ZjV2VmYP5n3BIWyPHPGON6OcUNj2?=
 =?iso-8859-1?Q?4/6gRSha/oMQYIp5JW5/7JOk5EFLmIJB2wLvAdw1jQTeDJcfU3YjnSEBsU?=
 =?iso-8859-1?Q?2Q62zNsB7TKrAYbW/xo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5818bd-2c1e-46bc-91d8-08d9b4d72414
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:06.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpOsEkSRUUhM9Fv4bKhTR/4gVWo69+rKgg/Cb7UaQTkszm5D3Wx4odu8G6UiojylMdsMoQA/LHguM2ZFX2pIIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=979
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: eBany2LKpqpzdc3Y3LAumz4WDa2cABHf
X-Proofpoint-GUID: eBany2LKpqpzdc3Y3LAumz4WDa2cABHf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/xtensa/kernel/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..20ec9534e01f 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,7 +80,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
+	for_each_vma(vmi, vmm) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
 		if (TASK_SIZE - len < addr)
 			return -ENOMEM;
--=20
2.30.2
