Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F614A6A31
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbiBBCpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43042 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244214AbiBBCnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:04 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120HCjV011409;
        Wed, 2 Feb 2022 02:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1iddMsrU7wXPcCSAkd63DcvwVjqMlZL8nSgrTfos8rg=;
 b=fTHrpbNoND/X3ihqLd84d086m1sx41rSoju+jWF6py+Uuql52rzWm7JLm9BSoR0VtiFK
 fQG3ZTuz7EIQvO1TVcilyplpqqK5P/QD4k1nCSx5xBBdM6xLT0GPXAmg89L9XlIDe7Yf
 XhlKyeywf3u85W3rUSc3sCZ4Hib6GsRwwnPJUnalqoRJj4FL3rpjogb/1BZnLl40KkOr
 WSO4AQ4gUlrmFMNIIAEHp5oOgmw6E8Tdrfqb/EdLa9kxaQxuxLn4Kdg4qHQWAPMriRFw
 QpaCAuhIcpeZcrgBjR5rLahXOypiSuKCMmB8s8jQfpVjbUiEhO/WsbV0QQa1G3zqrDKY Uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvsej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvWj015147;
        Wed, 2 Feb 2022 02:42:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3030.oracle.com with ESMTP id 3dvumgguct-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izxkFitV+UFfY+8t8/jINRrQ9gKbsqY42t5tgt3fsK12jz3cXdXIjb6XY7wLrbp4VhELT92LVEfRL+oz0q+IU7B/Hzl4xS4epPukgm+okUvSXHREWIvkVp8422KmXsA2L3AQNhIT7zbsEqYYXpjj7IAD0s726Er3C96S4vs0ne8T1Ve0BykpdZdwrQoaZffzAmBzhzCtZRXprH9XmxKsZLkDI4EZG1Wuo5K3MJSbvZb4FJ3kw1Lp+pKpvqwmwAoYd+y6ZBfQ+J6dcNogEHX8xyuoRm9x10IYdULInZWHCXjsmkEYrV9RcDR1fwCRR7MgPMpZamFB9/c0Cn2LpPAp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iddMsrU7wXPcCSAkd63DcvwVjqMlZL8nSgrTfos8rg=;
 b=keK5K+Z3l0x3YIRXkDZYVa78EjggNKuaB3oJHdLoVIDd3lW6RQ4Txn3Yx2aSdgecKoDg0OlwVTGg/cYeGqaQjgtKj40fbjqByA/vmMDOzV23K0tJueMOn51OJMa48udLXExA5WCxPd34yF9zxFfvyQ4+lLFMS03hJQEFW3OO5MNDhtj/68OspCaZIDcXctY1ZmfrBP2R7UqILZztNtoFZVWH7I382Z8H3YsSznPHh0USmUOo8g/pynNfCH9DB7FBnQlY3q9gmcOo8C0nCZ0No8HJcKsVWJIIeQ8EGNdP4JlQMZhIKJgOOC0OtycWRkNyLLNWD5CgyZaMarO3BICYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iddMsrU7wXPcCSAkd63DcvwVjqMlZL8nSgrTfos8rg=;
 b=v6KT96Z2wcNdWnL0rqxOTL9cUwLbUdHyW0Fr7ac1Yk6fy0nD2qwwtzkPPUqCD151Naa3HAktXCo2ZIn503ankYwpkhYkzKAeMKSzdUwTzPeHubDikmWySGwIiNCckEukAKpK4sT4o7awtrtwzeapwsJpYiW4fhTDxu78CVjzWvg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:42:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 52/70] mm/gup: Use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v5 52/70] mm/gup: Use maple tree navigation instead of
 linked list
Thread-Index: AQHYF95/MHtzE3FJJ0msN2B9gK4bEA==
Date:   Wed, 2 Feb 2022 02:42:19 +0000
Message-ID: <20220202024137.2516438-53-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ef30e45-7539-4375-19b6-08d9e5f5b759
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5865AB55BB95CC6515FB6F32FD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYuHPjnB7QElRFTnRFo9pqYcRUwLN3EnTToKq6fZ9dBOyr8WgQkCU+sfjXQntHYTlPmlJWgaGaHmQjCYoUUikVWSBYlOjn61Zc93dS5qlz2RQHicSJL62FXWBkZe1i+fhDy/TD+sMsp0M31uYWNZPGaBywLnWucnpdKtuA9WXtmpSryaK4hvDsU3jM46AAzelrxjwZ0+IpniZrk5WYTtF9NmbXIQsSTUf2yfBDbpXeWYDXxjATHg9TziZK6mYgeLcIIrVTQuKfQgYooF9C/Gknejb3XCRjF9cS/baypsWrqv6sxefArm1g31ROZqZSQ8Oq5HtrQYzn4Wc+art/bGrNB0GL+c5Tl74y2kCR7RYYfkhABe0yfAVnMsuK9KRE5PWNYh1foU0D8i1yFRuRFrDU++S04LravfPR1ox5HBDwd2+zbSFuiabnbFixcvJLq7do2VUqs00CwtSKLhdpgwwRe3vTV273U+/Od+mQdMQ8hEd46OREj7y7l6ZzdCbOwckJ8NsFGr4VFCLeeGTcy+tf2EIXiELjNVyLUWgDRLtZ+rX7XnsEgG0KjH59qjZnk0XdLS4sAUMtnMN3h8/oO+5DYXI1M/ptwjGwv3T3CHTckZwKYJMGHqo6zrY2plD+AkULFpLyBrhZtiweiMeg0TIwhWGugciEb6ZaY16qnE3daRExBq+4RMDtKPUar+x5KK7WVVSkIQzXz+Sat0bAR5Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(4744005)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b03tSsqqCdPMFUYW9pqwLo0N/zvaxw/aQum/mWqsEx9RTWqCG2U2Iuy78Q?=
 =?iso-8859-1?Q?NYNSYcPqzg/oKKbM8aaU1unRHV1U8J2TZgYSQKKSiq5Dsx56tMl06fz4tg?=
 =?iso-8859-1?Q?Fe8ODSOa6F+VyN3vM6wVmoBtp6xQ/fJrwmlSE6fF0ZRjzlZQNcIlzzN4El?=
 =?iso-8859-1?Q?Ea9LLdcwQLF23zZ3rY+ywG4DoviX/FTfVHaqCUdhE1AT4jxFlJkR9Co1Pi?=
 =?iso-8859-1?Q?5+6yB105QStmlfK2oAXap2eV8lmtI3R47isa8P4b/49yFD5c1xQpywAAnp?=
 =?iso-8859-1?Q?ZIKjR9B/bdsbICuw+C0WTuZMltV6ma4FJqra5TAJ+XwFGZQbEkH1YKlDFV?=
 =?iso-8859-1?Q?uozv79tcV6hFouInK2yPGTPiomQPWenrUIsa6P0TACHeeEMd9+BTNCzbi2?=
 =?iso-8859-1?Q?8kZPbEj0EDPYiFUHe8BGcESHKxrka+UCAyOcCM4NdudJwmL5sqgfKtX/iN?=
 =?iso-8859-1?Q?UuXt+P4f4Szjc3ZezhmC4TSu17q9ce5EIPTyXm/Eo4kX8zlBXh0CrNzgsb?=
 =?iso-8859-1?Q?r7vUXJB95pxd0SgVU7nTTQq1bBaPR/+nRZj4ZPkwmIFj56PiaDP/1aIxoE?=
 =?iso-8859-1?Q?ZVNMDtg9aBIkHoY/uFbuX/LWSp98Q4cdOfkvBseabGqwr9k3HaVKzXJ2aP?=
 =?iso-8859-1?Q?atBpnJ6u7czA9mz58+HafAUm7LZox6zgB1AVrgFXa4UQQyOrjFIoCjnnqo?=
 =?iso-8859-1?Q?DrTZjOXYAQdADTvb06Uve13bHL+7dsBWvkQG0ruifNojup9CPhU1wr5ymF?=
 =?iso-8859-1?Q?zHXbz3JQ1V1lBlon+ULMONXslBGP6Y1GEycFhHHb4SbgCEONBGiZudmPKa?=
 =?iso-8859-1?Q?IfTbTB6583WsPuTHFX7ZmAva/lkg6G74YwtxzZud7HoXMhv4y1y8qkiDsH?=
 =?iso-8859-1?Q?Hd5aNUhSmfKj4+OVuIWFZ4SWMCuAKoz28pBvHXFOpTtK9zROKyrn2rzgcc?=
 =?iso-8859-1?Q?3H3LdF/OCdu837VTVZIStuelJ84Pr8QaO/DRNlI89bFFJYoHwignfR7dzi?=
 =?iso-8859-1?Q?6RESYwptVqAfoa2Qs9HmV88Mxycxtrm8Uo1UnoXFW5F71GbLdFuLpKYsxp?=
 =?iso-8859-1?Q?Qs4Tbnv1qpNuQAgwa9HRLsQO5BqCXD9SXe4Sn8H2S1+7zPK7evOAzG172g?=
 =?iso-8859-1?Q?vcIosDur6ar+6x0flgCNG44NvqfMusdSqx8XMr+Inw0lMpwxDA4c5AERqP?=
 =?iso-8859-1?Q?cwDzunezRTB52Z0utxihNNU1mjUpQIOlt1hyX2bLVrH+uiZe5ujjuRAICt?=
 =?iso-8859-1?Q?QFDuXnZSaGtRmbdeKdB9Ct8uEBcid/37NnqOG3WdXXfClwkQ5gxATRyTOE?=
 =?iso-8859-1?Q?YEwrulAag9QPQ41gTDc4F/xSzDwCwaYLMAbxQ5By/iXTWhuCHx8f3o8CRt?=
 =?iso-8859-1?Q?S69I19dpVtsC8frmvGZpu8Ak7CJnfqwmLjI8rRaJ6qEVRKV/B6PBJSK3GM?=
 =?iso-8859-1?Q?Pq3v84csRy/QKnpqYIx6fCWYGeVWr67SURACEFOvilOM+cKAVdUZkkvssQ?=
 =?iso-8859-1?Q?is+00fv0pjrfgMVBSMBabNiSwjzr71XUFxTw5n+TmrJRzPKsZ/PbvQY0d0?=
 =?iso-8859-1?Q?b9blzUSERF967BHxy85CI1ZpA5KjDYxUOl+mXpHydgOZpakoSfANtCw+r3?=
 =?iso-8859-1?Q?ts8dHgpens6h9iTofjILtm1qSqvLIQq3XDA7WQ48xgAramFH7PEdT58hOL?=
 =?iso-8859-1?Q?yi0CmQ5BL50CT2bpZwQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef30e45-7539-4375-19b6-08d9e5f5b759
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:19.8446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFK4r6NAxp5LHvK73CbQ2i5NcmTA9Orxy74bP6EwrNr8NoeSOYvlqBt1RqYq1dcRyK14cMThc6cde/CMnnpdBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: atHdqDW5DHIU7Ch-uXxQ90ln_9N-idA8
X-Proofpoint-ORIG-GUID: atHdqDW5DHIU7Ch-uXxQ90ln_9N-idA8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use find_vma_intersection() to locate the VMAs in __mm_populate()
instead of using find_vma() and the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f0af462ac1e2..0fef70bc6736 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1584,10 +1584,11 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D find_vma_intersection(mm, nstart, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D find_vma_intersection(mm, vma->vm_end, end);
+
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.34.1
