Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14964A6A00
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243899AbiBBCmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32930 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243870AbiBBCmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:06 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120687s022144;
        Wed, 2 Feb 2022 02:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sqe8IuvA7gq6O4pyFA/597HFCPbJXLgXKUqrcPe7IR0=;
 b=YwpzXNNqr3Kz7E6jzqvRr0kqEYMfskivaSzDClK9UQMjPAWFzRhAx8tDnYzOWS6s4zzY
 lflBv3/QjSBH6rQH1ocM2KvYcC5uwYpHfuUbgNJhIqgEWafwLWBO0ssA1y73EC6UAHNz
 Nm726XGaN84CnNEeiO+OJhsKd4KdNDnEUa5gH5r45qq+mlt7nhaTCuaLU65KD21TuBoZ
 uAYPjwiUyvbXhcmRDmGhdlTxYey86sfHkypnQqV6OKCkeU05nrNWmEp3ibH1f9gKpnpC
 IDpMVrILGZDp2JufD2AmckdApteVadgn/DC/2/kCeYfexXcn4saRjnRrqR5MDVgvA/qO Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPED146731;
        Wed, 2 Feb 2022 02:41:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3020.oracle.com with ESMTP id 3dvwd78vk5-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUzsos5NR52luWTtQlerTJ6RDEc2Mg+eFz7hZPEErqHmqneqC3TtEzws4L4jgGbr1Btn9x5yKmD3gwpH1XFlV2Xtm+YbYDJ9FGoubHYVvNj9GEzHs1dWN6E84QDEjrWTHIofInJHtlMQXvu0r4QQ6E4jITe+vrt4OIAnfZmEu1vtXODZZjY6MbAlztP59uudaochmYELoQ6C5Jf2Iq1F2tF2nItPitcPPTh0wsocbHJOytZzjDb1AtTmYTF0QjFfeM1yOhAIDGUYy7KbtHP4M4mhEfdJidcy74Opx01ZMhhMUrrOk/WrI96J1IulJQNzz0QxS2i3ZVGPbS+o6G18zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqe8IuvA7gq6O4pyFA/597HFCPbJXLgXKUqrcPe7IR0=;
 b=VnvLO5UeP4tA8D3y+jnEIc1TuTFOM53tLqAaxdLTpY18zgzLQhsvuVf9T8wQfuqrLbGm39pbSElERYq1AqwSlJqtThlsNOM9YEFkVDVUQEzzfLW1H/B3ADtQbEk8SqF7SGH7qXGC5uF8S1DTf16aizSKBTVdO0TMTJ7EqMacFgFrsxPaQmTbn2uhbnCsBRQjgmXY5VATBXsPoK+Y6c+9fto1+TcyXFW54ib1u9k4Wn8FydhOoAxaHH/tJ/e1qfYffgWSa+03oA+3LMizUlonrJdGeGrxcQLU1pS1CwDayDYecix8aL37YckNo4m3MBQYWri1dAb90pdIyywCu6ixQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqe8IuvA7gq6O4pyFA/597HFCPbJXLgXKUqrcPe7IR0=;
 b=DbMLWoJzVyB+NqJXFyeXttbH7GYTwxtX4CEQbjedo0IO3p0SxgP60Ie4I+EvZUjVvFsL5BJlTFAv2pFF6TSXbMBPzGnTGoU1TtA7fvCn7FcpJT9DNKhEdTaP9qewzccjEz8o1orjs2wmasYzuyyYodj+5d4hUdMTzWnKiFOulGs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1325.namprd10.prod.outlook.com (2603:10b6:300:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Wed, 2 Feb
 2022 02:41:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:41:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 03/70] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v5 03/70] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Index: AQHYF95wFkWnwXaFrUGUKi2o+PA9QA==
Date:   Wed, 2 Feb 2022 02:41:54 +0000
Message-ID: <20220202024137.2516438-4-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94689b5b-1c16-4afc-0290-08d9e5f59324
x-ms-traffictypediagnostic: MWHPR10MB1325:EE_
x-microsoft-antispam-prvs: <MWHPR10MB13254EE5179D32BB24240860FD279@MWHPR10MB1325.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90NtkHvH44Zv1ujoOXTVB0rHXNFEMCtGxwSd+uSuTDYXQEg4+7y49WxBnGRgenZFkPuhw6aLVVN0mCt0uKd5WORuEbaOvKBNWdrT9CyPm0XDEyUtPExeTt1ZqDyeVdIXj/Z5vBwQALLHVyxTnfOUxNEhsFGkoFeHWTFcRos5g0uhFklAI5lPjfZcqnSsh+DfZN18254uoeYpoDUzJSggrf38DtCVzj9RTsnz9mJgq+Ke7sju0f+RlwaRthyLP1Zc/eT7VNtpkQf3w/w4Mmr8b/ws0PHvMBM4PzKATAxk10g4hpAXC1Cc+EfrfwyXTgVgorkQuuoxDXdaPtjI7Ri7z/DjaW6eyobphVjaTSu8/klJK+AxwRugkIOe4qYFSLwd9PHQ8Y2nUyH+HxIhlmIPr6FiDM/yj5qf0QzF3x7SpqxExFN0m4sslw/Ub5LRsXx2jBr4jikNbdO0ZL8y34wlLMH+CRuuI6D0zhe8zQNsln4DLDTrDsZ2rF9sDVSG7Lgoyo0MO9I0J8nKU663rIIU0Ud8oo3J/ZbFg3vnMyjL4H1TXlGfjdYu6ZHTJ1ApqxoG5GvA2tyF+X97zlokUKA91KNxpx27Ua1lWmZM8t9XBMcDDPivrHEDh2/z2sSeeCYlo81bH6I2KN5ivWW/ger01jldWTdSqUdJgiJw0ZTBL/aXA7CMkAFsV5u/5SaOSqXj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(38100700002)(110136005)(86362001)(508600001)(6486002)(6506007)(44832011)(91956017)(66946007)(26005)(38070700005)(2906002)(122000001)(71200400001)(66556008)(186003)(66476007)(66446008)(64756008)(1076003)(8936002)(76116006)(36756003)(316002)(2616005)(8676002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R+zJwH+Q5Kw9+u5aX7b4LIdhPCDuuTC9vJgLk2VjxezgQq6fSciv43AqjF?=
 =?iso-8859-1?Q?rNJU+HpKQZ/+u6oWbOfhNFizpA85KorFgRFjqr/0YCssV0QYcozn2dZUSQ?=
 =?iso-8859-1?Q?hp2P1v2cqUt1Em9aq3v5kqSdN82oevjwRKFyvk78bQTDBWJcIr3ionT8pk?=
 =?iso-8859-1?Q?witVqZi6jHt+Of1IAxwSqxFZa97mOPFruNYJOwR/u4LPOYC9lGMACHg/Ue?=
 =?iso-8859-1?Q?gJaa1ZYqYECCm9t2oYGqzR2PJaALMRATJvKeh9bwN4PoJWPDdeetiW+uIy?=
 =?iso-8859-1?Q?vtOzONC58IUh9zykMx4kAdNCGe2LKJssjm2aO/FdoU0zdhxHleFgG+PdNV?=
 =?iso-8859-1?Q?D6/uty/k0TqhRflW9hh9jGhHdoCQMjhapAOr45a5S1uSR0zToSPTBgY0GJ?=
 =?iso-8859-1?Q?AThoNkmwvQuhdkpYQqFIKNLwYMjPMT7HIuFUuLnfpl9HYWQYPJiTIBToN3?=
 =?iso-8859-1?Q?UyoaZDf9e+2KvmET7+pPrzGP2ZRM2CLW5ExtCYmomCh/Bur7QO7qQtYZos?=
 =?iso-8859-1?Q?kuE7yKLAFTunYPldZubjpc9mrak6Insp6ntyZ+Pgm6+NVrjCD2bAPwvcTi?=
 =?iso-8859-1?Q?6wc20N/dhtDpLYuToTNt3S+zFnWHY86ELBQzFxKjvf8u93gF7U+X9lKET/?=
 =?iso-8859-1?Q?S5CKtLWpm5lu/i7N5WDvb71oGqzyxPfNoDeTYkCnZFvJs4UGlJUymnjaNX?=
 =?iso-8859-1?Q?P4iRT7QriJ/+X6l2IbwAH+DK6ZWylsRyAvatlhpyJcuXKdI/dTfboSCGaR?=
 =?iso-8859-1?Q?kUPx/7R5sbPNwZX2+MIgsac0LURMH0zmV/l80y+4mjExYKz7YrRG1XVz07?=
 =?iso-8859-1?Q?gBRFz4cSj7lRBWhcdUmvgDSgEU29j48W9sQjDPlyZUpTv/1yUJbkijZr5W?=
 =?iso-8859-1?Q?S4ecm7ptXEmOap3WpHzgjD1H+sXGZmYmY0CzRCmrcLSy9f2ToFQJFUwJId?=
 =?iso-8859-1?Q?WSw5OG9k+Bpi+ues8r8/ZZXqlVgaCNDHXKfS77UKHq9dpwKn0ckbYWQlFx?=
 =?iso-8859-1?Q?d4k+XSPjmUlExsSr90uCHQTA5YHEni0RpBD5ObINZYisKSBoqKoQnUR/qw?=
 =?iso-8859-1?Q?fhcO+Sg0Zz9KJdD/Kw1iNgy3MEotZQb5wLSoLUOLnF1fiAzQZdlb8aexkS?=
 =?iso-8859-1?Q?XqY4YoWsRm5eQyuTkFkuAFzCkU9Fh9vqTMPSpswOcIuL+msarEovIem1f3?=
 =?iso-8859-1?Q?575ytsv9qcFViUl3ZP1rSLbDCE82wNQ+Opr0HNEOemLi1f7uw8olqBSJ+1?=
 =?iso-8859-1?Q?ndKrbCYfz9lqM5TSfheLcno8bVGfZyq8ZX0L2oFQ//WguIZTg0ZqSkVd8M?=
 =?iso-8859-1?Q?dqp+Yuz12F0I+bxg+v6xLmFfMl0tHnslaDArMaSMhWPbaRik4EcQ2A2uGa?=
 =?iso-8859-1?Q?oqT/EsHcAbJqAoAHF41UxyjBqg6vUXmyKp7V/9eqijVnlqvbeR2mmGGRqF?=
 =?iso-8859-1?Q?1WNcEbBWGpOPKxij7pRk0WVz57UMEv8aPPJiEeypXTKibMdFNIoHuUe7rp?=
 =?iso-8859-1?Q?hu+Ipx/7dQMTqn+bPltG4fpGIma9mr+jYpqaCdrCygABLHv+fbNoPJsMo7?=
 =?iso-8859-1?Q?qyoZ/4cWulnPoxXMbSYdZVT+4WW9/X7W1zWIgvfoX6BCEY3BObW9pz6ZZs?=
 =?iso-8859-1?Q?sM63NXvm9O82MWo3KabpTqUFveEbOuxFVsMysig+M+qApSlTtlOUW45ui+?=
 =?iso-8859-1?Q?aNP1gTmCKyPsglvZycU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94689b5b-1c16-4afc-0290-08d9e5f59324
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:41:54.0963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fGwhsFM596OGIqEZ/gerMFRspIw5vahXi9n95gwlX0HGlXKK68D9mxdYpZBgl0TMp0EQ0HM4gTofMmGvmUEnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1325
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: Le5L-JAhAI8v0kKCKBUis43N336OT-8i
X-Proofpoint-ORIG-GUID: Le5L-JAhAI8v0kKCKBUis43N336OT-8i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

kmem_cache_set_non_kernel() is a mechanism to allow a certain number of
kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set in
the flags.  This functionality allows for testing different paths though
the code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 2d9c59df60de..00ee01a14652 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,14 +24,24 @@ struct kmem_cache {
 	int nr_objs;
 	void *objs;
 	void (*ctor)(void *);
+	unsigned int non_kernel;
 };
=20
+void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
+{
+	cachep->non_kernel =3D val;
+}
+
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
=20
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
-		return NULL;
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (!cachep->non_kernel)
+			return NULL;
+
+		cachep->non_kernel--;
+	}
=20
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs) {
@@ -116,5 +126,6 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.34.1
