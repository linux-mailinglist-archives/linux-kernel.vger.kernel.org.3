Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3A54B72A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbiBOOrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbiBOOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5BD119432
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:41 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhhP0030901;
        Tue, 15 Feb 2022 14:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oYrJzCvJMM+yEoxk87rjWhD78FY2B9cqjOokt9Z4YoU=;
 b=FumcYemXlrFzMrzTINL7DC/46AsXZvSc34V8TH3fLrkPHfuwc2YBXIXpXCy6hl54YkNH
 VxTvix0k/hEzTQfJN59FiQ2sQQ8GFBsvgPCpWpleZRiwigt7lbyJuDWhDE6enr8jtJVN
 b/fYbpGH1orUffVwmlp7Tg1aTySQH81lURuNl6E1b53j3vBVMTYVa+gLR0rd7AcNwkBb
 pTBX9BdRjZZPK2R2rc39hnc9xg3Y7jwT2IOwqau7BskjcFfrg1mKviI1dcOuRHr8ZBfD
 OWYaykJUkbXZ9CDih/8v8VIYSfolaGkn0NgLkyZeMt7rwAjElh+eROvkg5Awh9GMAcxJ Mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psav7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEe5VA157068;
        Tue, 15 Feb 2022 14:44:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3e6qkya227-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqMQOgDObrEF6wVrIgJw4WeylU8wbG4dXAV0BKVy1XFUtTzHl9FKaAR+UPAOScRHGH2ZipQCoh7TnBQEMKRmBXJV+Cev2T5YbZsbnjUMYg/Q9OZbjMyEUrOQXzzzNtOsQU7Ag9qujHGTT/qgruV8rt065c4hstwCQ57qzoyVUIW40TgM/J/p6d0lz2PXP1c359yCnE+9gd9yBE3xfzi+eBTof5zpRwVmyPOnFS9ij1aBY/ZyMHz/qi5kYnwNbHSeogS2q2GBakdwZUBReWozw2ImnRmT1Ikr5G8eyvlq12zOQH0RQZ9lwF0lWIJ+v9DRNYUtNghscv4HbOiCHSAofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYrJzCvJMM+yEoxk87rjWhD78FY2B9cqjOokt9Z4YoU=;
 b=fB8A5GeSwIoZI7z1rEMr3pWPtYf+O8PK0hLToLQ6ipyvJ4orB8hDZv86gzGgnMFL2C6tdOD373Ahd07TlGOa1zsxL2TZGtPrP1oWgQE6je8l7fEe/RHtt+wkvnJG2vJrSoiCzF7mGiEIER8pa8p3w9Dh5CAfjmBPkEhVgzEq3K1aXeee3P1ppAEqFmWfy8MYWpO8TlnThIkdJk5MCh8bseT+XD8r6FbWkh75vGD+RFBKLOP8hRfcUqj5b7dLbUZQKtplP2WkaXB3N/LKMXkIwO1N6wRzg1iHMjTplk9VPekwehRa08D8po4gl6EfPvKnxv2qa0KBkEQ/DjpOZKwBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYrJzCvJMM+yEoxk87rjWhD78FY2B9cqjOokt9Z4YoU=;
 b=0OoOxTrmZC0gNZL4qkX2TumM7y7aWOUUDx7CXBGn7bcfZXz4VzsH57AX+x65/yIe5Z3SkqVm3mVqolsWPeQjpfj/iAX8E23tM8x8Euz+8YmN4zj070NxCIaJYcVPEwSwAdjj4+wFLoSR++3Z2e5OKd7MeEMcPTz7T6SXdZrSb/o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 64/71] mm/pagewalk: Use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v6 64/71] mm/pagewalk: Use vma_find() instead of vma
 linked list
Thread-Index: AQHYInpknuVQdM18jU6SNxtdeNL5Ew==
Date:   Tue, 15 Feb 2022 14:43:27 +0000
Message-ID: <20220215144241.3812052-64-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13625aff-852e-4a39-8a57-08d9f091aef9
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1863DE845AE77DF685F1E075FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vxAriy2yUaoan0tELgnCrxX7oaYnGJRE+UL48zMwhK+u96vro18ofNB4PIzkU4CZepfRtL0ez2rgHtworU+0ogF45SWC2kQPgo/qBk0hlXJxKQf1dO4cmCX3SVGj5KIyONpCsVzlnzcZXNXkoIZT/CQihGHqLbFAGMafLw09kFdV+H04SHAgQyyaroAABsvcm2q6ZMdORBO2U94rpIfbZfSA67J23dizbG4AdLqrpwdYioLNRTNh5kA0O34sRzuPTN8epvMDlUaTyBgz7JiRiEgM45wECfbxRaYa+QSQIbG2Y++cCLYPMSRxqre6z8e+Ji9t742HO5UEW5NRUoGqZQaObXja3DwkU73RiJhjUHDlKECqyWDKUnRKLZktRhAxs/M45SObdbiO2iBfMM9NZ27T5aFcG4HXN65XSdAtu3EqtlYe4vEd2XP2txi8GgBcGHM4zNWEN60/BhT+NESsv3WPgfYKXaqJWot4oi4bwbB4m6oQijhpAOLY0sYTeEiUhzjLhC74w/P4gqlgdDu0hcMoo1wGkxmuBjLrZxPmQASstcwfckqkKk2wLT7ACjXf+6mmyUlqbjr/CbR0T08aSrWQQMiUiDtBtNysYS1MYIVdYjQarXk1dP6qOPlNP1u00UxDMspJwzbNQHuqOIG5sATW98XMPyvTeh55srjkEGV+w69Gs+GZm3ezl6YDFFA9yjGA3w3/8D4AicO/jaFBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xDH6YC8gmr6LySohm8zHU5S5PAXKktg49KhPsqGXNXkN6s4ZyqRS1yIgnQ?=
 =?iso-8859-1?Q?2A0q/AsqLyjRO4vOP6czs+q416cWph6oV/AGX4aum2281SABvlkrpLaHuR?=
 =?iso-8859-1?Q?uWLzE/d9O/SiJRgI8udGNdQakYXW09WXRJC438ChWC+jZmuaWFH8pcw3ix?=
 =?iso-8859-1?Q?Qv38BN415xdTXP0ISkTSdRb5Bfo9xm/yE2RjX+uMseaycNo+CdyxxBMjup?=
 =?iso-8859-1?Q?Fpy5WtVdj0yHlgJNNCJCz9gFMmoX2kBZeS1f4oSAkKXn1ytSufXIxokHfJ?=
 =?iso-8859-1?Q?m5OgEa5RZyah2uMSzi4ZSdI7v2TudM1xWfFVvCONRpW69zOf94hFo+cOcY?=
 =?iso-8859-1?Q?b9F1PgPQH4lbOh7Pu1tEAvVpaet9hYzr249dpFjAnWWDiyfPRxVknBUrCT?=
 =?iso-8859-1?Q?4GERy0r3CBBUGPzM+AfqeS8IIV6LupA4GOVJKlXa+vy/cxdP+CnqT8lb+f?=
 =?iso-8859-1?Q?Kz+OMRLCw/YfGf+1ebXluYckyz02ptx7swsw0kHZuecLKndbtYpBQrg4R1?=
 =?iso-8859-1?Q?gIGn2fLLxNuGkHA//NWADu5K3H7jnhix8QugOU7EascDCd64hGuEtZSY+H?=
 =?iso-8859-1?Q?0sSnnlHj9XzKabhmnkJl0J7KRsY1+9tzAGyAsKFpiw49opGxODIv1wN/Qf?=
 =?iso-8859-1?Q?mwdlInGQmxK8Pr6zySuRXGfSyxYUDxu23jd2+ky32NOIsFu4pItbSYC5JB?=
 =?iso-8859-1?Q?063nz49EbdwawkmHrz/t3WqmCwVxZ4Z/CA/D+Q7OQ8euUjrk8WXM7Wu3mJ?=
 =?iso-8859-1?Q?N7lLKNa+dQOcQRWzLD9XKyEWaKNZR4LJrlWf7mxLM/dPkCqkckR/20fX52?=
 =?iso-8859-1?Q?6osX4iZbrOzmHDUX/EPivOKKjPoa8W7NUYTmiDfLB7JtPfNBm14+N13vrW?=
 =?iso-8859-1?Q?QeJk0mY8vpKKiiK4+VFBCR5X4hvnCOmPZNQFMSQAasE5In8EToNYNdwZYi?=
 =?iso-8859-1?Q?Cnr3wbGZimIawii7Hil4CY4CanBtmI44GNPk3xGDv7Z1is+InY0Mw0odlI?=
 =?iso-8859-1?Q?IK3sJ8q2fb9C0fg/5z3SX/uuRiBsXa3TkPvmrIhNymASt7wMtdYLG+9fFH?=
 =?iso-8859-1?Q?GnJbgRRRemUUlRTtQa/jlgCr9Mt2y8n3DeiWcD1vS/Bl0mn3C4C9FYWEPR?=
 =?iso-8859-1?Q?dTcBFHbrbX+5YVYB1PIqiczghHkOb+6RQKpXcCfghN3Zm11uq4d756BN4m?=
 =?iso-8859-1?Q?yWFidBIcuVuWACJ2El4dqVnlPrYJQqiBpmet7AYwiyxt50A2hG3r7qvoMr?=
 =?iso-8859-1?Q?4BznM4KZrT0XyTEGeofsy8t2HlKdf1JRLPgvQwH7hw/7f9Pmz00lwkPyn3?=
 =?iso-8859-1?Q?+XtiL5V+JbppDpQPkFCqB7QbKYkBWx+FI489YwPXjSS5XngWvnZthwqSU4?=
 =?iso-8859-1?Q?zstvrgAzAnvpGzTxmnJMutYcsR5ipnJ1zTtS9Hq4IIXQTLAZkKtrRF/box?=
 =?iso-8859-1?Q?vYDVn9QTTlpzXfriq5xZxyXxiQ1uI2z6kgF0PIhJG8UEPaKk5iTMWJ7HMS?=
 =?iso-8859-1?Q?f0vQDOeCzW1dxy30o9O0e4HZoX60jimy6uKsIKMMa5tFcsWvYRw0LWUm8D?=
 =?iso-8859-1?Q?VPhTO+IsATI3q8/yGbNmO0cJUEIsqGP3d7w1dtZvPzOQG5vAojHg/WyA4I?=
 =?iso-8859-1?Q?eK7t1IhZPWBY0zXsMdhC4fIXQ+2s6DmXeHz5i2Z454FYckFGgl+18IYnfV?=
 =?iso-8859-1?Q?FqIWCOArq48HooRYRNw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13625aff-852e-4a39-8a57-08d9f091aef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:27.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODkav4qz81vo7r9q9LvftwQf2ZbUqM9DjTif4Q0b2HTM9dXyUw6zGfRGAZ8xY9q/5Fg8B/7xM/auyEGD8MtkHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: 0WoleBee32oPr4DBQ_qdEhSm7WGfFSLw
X-Proofpoint-ORIG-GUID: 0WoleBee32oPr4DBQ_qdEhSm7WGfFSLw
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

walk_page_range() no longer uses the one vma linked list reference.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..fdfea080c5ff 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);;
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.34.1
