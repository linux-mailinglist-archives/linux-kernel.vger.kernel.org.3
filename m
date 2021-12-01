Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C896F464FB7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350044AbhLAOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:35:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35862 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349944AbhLAOet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:49 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E16mA002526;
        Wed, 1 Dec 2021 14:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fUV++k/w4ivQyyMW089a4F3C9a/R6IqoSDxYptHh4Tc=;
 b=xwq28TpuT/iwGjmjnAgPaIquiacMKC+AAdMR7oqm5pG/vTPhO4DkshpzB63pzGy1+NdH
 bO5eDmlFIeRja1pCI+6LHZ09fp31FSChVap2uxOROQHO2+BBJmfwu66G5xyt0xd7lFza
 RSEhgzlu4Au4kOW8Xmd8LsLnX6QjZ2E/UHIul8RyN19/RPMko1fiAHkz8ciDQKkPfYwb
 iCoJpdlXrTnUSujhqloBPpjWEa0AZ1sCcaFps1Y4IsBErM/E09dH8BOmCxQ/3M5ouA3e
 7KCbsKOGZwJceeFlP68K0bb/7SyVvBnliO6z8MIPbVZGD/f1KKl9phXyChiJqSG2ROCK Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBMFQ049269;
        Wed, 1 Dec 2021 14:30:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ckaqgkcte-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ioz5Owhv7l7NDF7ZXSRvjSDp0RsaC5gKwyUez6ylePag6cvB/i4QDsZN6//MBg97lGP3dwaWy+AGLKMZrBGxYJGvMwcNbSl0Ja6nIJ1zUb0OQEhK2PFGHRmxHE76UhgijtsZAw0c8df24a4vNLBpStuomK1icDmmehj7365mP9dA/e/7JZg7HI0qNhXO17iOSKTirteFSzBbmmtAE3diE58zilseoY2QccXdhMNPF9d8OMO48bT7De7+Z/sgn0ODFslIjET+PQWtYB2aF0LSxfAk4OhsXxsmWyDFj1zZjI75CcFK9blOLBMB4P0it0oCqJy5DXSiVakWsZl7sVbSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUV++k/w4ivQyyMW089a4F3C9a/R6IqoSDxYptHh4Tc=;
 b=lPpZMwOFUJHGuE7owf4+FQY3iEOBYfN0kRXvIs82aAh3sg+h5EoULsnoDtkkKnWm0keu4XjZlmdB71NNGwUJAe6hoYiOLdQBfNRGMEZ0sXIGChLstrf/WLeHTgAjjz3taV4J4E/rQN8BkipKAdOTAT2dZaFC8j3+eyj/EViRi9L60hDVHmeaq641sAQkFJCz1KRg8GC2FRh2WF23sYM0/ooSl5/UJAHEqKkAClqVZCg5Jv3y5pFbYiUHxqx6MzI2NGIbp0eeVddwjZO9zGDWjE49fLwqy6GUPVSV4DnWsKnbOdzhsh/75qrbkUhONw9jgP417OVt84QhicW12DDwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUV++k/w4ivQyyMW089a4F3C9a/R6IqoSDxYptHh4Tc=;
 b=R8aYz4p5BmUYlkUI96yXFAyQrf52YJUN9gMI/1xBnERfZSFG8GtGAeYw7vl5wpfqpTMKUrBiBCIIOB759lAf1Mp/9Cs9gdur6tGqGDi8y1oOiKDvG9Cje51EpMaqQDn57TREmBPdrMr03W30OnlWy6XAVLC3uqHzGESLbmFh8ls=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:58 +0000
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
Subject: [PATCH v4 19/66] mm: Optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v4 19/66] mm: Optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHX5r/q/MDuNCMomEaKcOJazZmUdA==
Date:   Wed, 1 Dec 2021 14:29:57 +0000
Message-ID: <20211201142918.921493-20-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f71c219f-923c-454c-a54f-08d9b4d70d16
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB276833BD2FF9D527CE7405B8FD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y/gISvxHgA6735wvmc3+nQd3Tb3i0edJKTnINKF26dCiwZhDa1oOpOqHfTx/tqa8jFS4TflRtaP9bJq+jaz6ic4iKB0NhySMz30bXNw0cwlbVLSHKF2Fgk7hBC06O+HJHUqrPuG5qCovmHF56DNrTsHAnzJ8SjRtip2AR0lTdx2u0qrdVffMa07hQMc/b4t+jAMlzl3qzdkFeWp5npPge2jd36HUnjzX2d7zqHuGd1bLr/MahmD1ANar5omiex0uO6MHQxdZj7GeYLWP2Bfc3urTZSd9Jvmo7mdmWrHDSWvcYoMtq3JG8pUFdzuWaWCnz3JaafYIeA4Tx3GiM2eLXgcgUI1SiLsragmQgKz7/9dXmVpUjsAVfTrdSq7J0/RYNWsG1kATstTTP/EcvpYgCRwJklcZi5sb1nqodo3MUFzzrLH/Meq3HqMWKhN+Dottlt+MxinUgd2epzH44PJHMDYQM2P9XhSc2C63qzbEtuPFR55aGSAxKT2aFvA6XHk3L+doFur0XtUFERB3tDhIum1BbPHV6GuOCliIMvBxm7AMEcqDJV/iK1aRCJg5FhSylb5azL3QYnebo+yS8FSljzCEP5aViWoYiZySuayoMv/ufOdiCK88yGw2kSMvoPvtI/jFa7dnmrIZMSoAlsjRTkRkI0qjdwd+f0s+jWbjXuWBCj8G5ozwJxLu0xWrUv2X19cBxItFXTsp09d9Y6ZovA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(4744005)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QeQF8ZRL5YjBM6USQ4bjhztzL31bj2jr9QPCBXrujwVnRDOKv/ZsOuV9MQ?=
 =?iso-8859-1?Q?ICqp8MAIzf3c/2H27c6/5XVW8gdneheJz1C3A3BvzGsZW4R2xXJSCiDddQ?=
 =?iso-8859-1?Q?/n8UGzUKqI+F3Ji8iY+GeMtPSkpfEZlgt7vFrdDvgPT5uqHj0SIcxo4y7X?=
 =?iso-8859-1?Q?6uGDuHO12PySBVr+PRRPRsAkq6LU2iERlPfc038F6k28AHxptbAnYNxMHs?=
 =?iso-8859-1?Q?tEYaqb3mvyZ0C17sNtJHfdBXRnGH+KoC/Er37R2fDcTFvXiMxLo+cNUhPP?=
 =?iso-8859-1?Q?gWaEOq4YN+w7DsBMdxMHpBZK72DDlzSmSneBphT9x7syQyhdDp704TZ0Py?=
 =?iso-8859-1?Q?37x/Az5q8yN0FaY0RGYUbKObvGls4JdKs5lM7luKtFlnrUk9Lm4bPopQmf?=
 =?iso-8859-1?Q?Jm8nYHW8NnCmrgxjlxANFw4Qykt+6Dh2bd4GFdXgce7wak2PDSQyGRm0OV?=
 =?iso-8859-1?Q?z5YnEg3SQZS8N5DiY8JOl0SdkJ0w0H77Yf7MppxIyPlY3gEKVMoyPNMIEl?=
 =?iso-8859-1?Q?kuywYyk8QBLEP4HHXZefZUnEjjj43YiBOIHKXWzbYZA69Tzr/CH/G8ylJz?=
 =?iso-8859-1?Q?ausHcQmkyxOfH5VT6YbXFYZWoPuxrMOwOUVdWebX4kowr6Eoa5xiyM6+sU?=
 =?iso-8859-1?Q?hEQr6igHLieyrL1j+B+t73xPrITtZ1UKm+5xf8uVeT9zJGQznrhSi8+LcN?=
 =?iso-8859-1?Q?EnET06rtCFT3VEW+fDreMIe+tFqk1Xpt5aFT48t2Ktf5Q4YrxKg/nqyCir?=
 =?iso-8859-1?Q?gL7eZNmyJuM4LStTegVHDXlyyF8oEHBHI45GbK3KPc1Ons4mNFvukEK6fb?=
 =?iso-8859-1?Q?gvkUuvJ6UcNgsfkFfCZffCqc46Bnak0uR6OFwFF+Lalalo60OsuoYk11rH?=
 =?iso-8859-1?Q?3F+c0ZH944k7iDxr3NBAdKfCFrB1T5nfZw7nz6SVUaibif5/Ng3WmhLwJB?=
 =?iso-8859-1?Q?6+9ldI1kl5q0s7r6j6DXeyqL7iCSO2ZDXg++L1ccfeQ+0UYgbqrUIVWeja?=
 =?iso-8859-1?Q?lo/A5AK/8WzseDZC8TWo5ylSGWEFHEinCXW6ERFzuXonLESUvWAYrH2pVx?=
 =?iso-8859-1?Q?qcqAd2bZLj1ADR9miInJz5c7YgYySMHB6q5jZol9fzBF1i5sMzMjs6Rjcl?=
 =?iso-8859-1?Q?49cKx0EUy1Nr34exbbos8uaUoueBpsaB525itRKQYINPUTgEtJuVyzOq0I?=
 =?iso-8859-1?Q?SZTrV10zACQck/ugD7ZJzuErN9VAyAyOreFCPlpD3IFvBnf09me9PNTWOf?=
 =?iso-8859-1?Q?NutpEMcUns5HOvwI1Jc+r45oXY0ntJ7kOnCrwTtsTlkYDrFd0GR7uxdRIg?=
 =?iso-8859-1?Q?RK/kgWibeeaAkw1nu8qBEDFwDgFfGqivkEh0dOieYGqZxgYbbbBUpuwZ/2?=
 =?iso-8859-1?Q?0d2S1pJlJIzKQ2QhyiIG41DZyDhcedHRhXr9HQSj4NqmA87Pw1Zt09eKyI?=
 =?iso-8859-1?Q?AtoOMxPGQjy/npiBJJVOzsi69HY34ZtpCkIsov0RAhiMXSw+Pg0MjHfw57?=
 =?iso-8859-1?Q?vOmVucjcoES5mmZX5QO0TKrw7Sc/F6D+KIoiqw47Aqb/1OKUVsCD3/jP0P?=
 =?iso-8859-1?Q?/a/KrBwJcXCHerzl78w6rNNNTferx1aA+tGqEdmcIn0QnF26xAkt5M9w54?=
 =?iso-8859-1?Q?ZUYIJ1VMy6iQfK5bOBGVb/Y80ZI+7/9W2MXZdw47VTfZWCJjORwISyXiYE?=
 =?iso-8859-1?Q?dage8KhX6Y7BCt6TJfA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71c219f-923c-454c-a54f-08d9b4d70d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:57.9382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbY+rQ1zwyP8N8EzsP5cLEUUKzQqMowM/aMWpyUAmmZ7cB+BJa2xuTKWGbIkRpUQovTQ/+bm1cME+iwmq7Xteg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=703 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: fJ5ZHeaq2aDQHp3b1O1BZO-s0OZ2Rl1w
X-Proofpoint-GUID: fJ5ZHeaq2aDQHp3b1O1BZO-s0OZ2Rl1w
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_lookup() to walk the tree to the start value requested.  If
the vma at the start does not match, then the answer is NULL and there
is no need to look at the next vma the way that find_vma() would.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 784f8fec3b65..c08f6d541b8a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2879,7 +2879,7 @@ static inline unsigned long vma_pages(struct vm_area_=
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
2.30.2
