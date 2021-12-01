Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B49464FBD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350110AbhLAOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:35:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41856 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349948AbhLAOew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:52 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E7UVe017207;
        Wed, 1 Dec 2021 14:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9ObRSYk9lsRnVNBTdeTxR3LZiTEewPZwd6ohngB/Qc4=;
 b=lwo2AfbItl9CzswO7pBkZF43BEWvTuZexYHA54QeMv2iiRgfM0gzo54l3jxd4kiyvkd9
 arveWJ5t1xg88YNb9DoRw8sGfWe8dtpamFJhMbDLCqCP7jK5ceduu82YpowxkgIeQiuQ
 FKnngu5a2WvAco2CEIM2i5BF9EOEsu09KliAtEq1TFjm6808Gr9zRauLG0GFHPDIg/Xq
 QDQ/Aw37h/PK2zS9rgunodNOy4V38U5HKqs7+oiFh6B86w6SX60cZGXCKCweoa0jhYK8
 fod+lufdn/EU/2/yidG3zprnWOG2lvBnshv6BSYJaPCh3OitXp1/oO3FS9DfCZO303vW VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7weh2qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBMFS049269;
        Wed, 1 Dec 2021 14:30:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ckaqgkcte-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfMs0iPbQTzhQcMRFlEwUc1nHN7g5XPip5jdekz1s0IPnBCxLI895moMMml9530t8qYBCGagzuVXzFDQRRPlSW0qllH2wfvcFoFAH4dbZtIw3G416Cod1jYeUujgzpqEaGfKmFWaa4oPQ4/q3oGJfVy3MGzHLrzmWTtGqRdVyItf+MCFk2R4nXZZG7gV73wUg8BmRQ0Zc8JOO8JOlk7DeZuzzQzNlRzHap2VkMTeCPoTgU+pSYGDOm+mF0ryq+eXPDPUkokf3+l1u2JEilw18IYWuSf4SZfdp6bNtOJ0Q12xIPMEJEkxEZuWLMYBKOsrMiPXe93l+tDAZy7sFOjoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ObRSYk9lsRnVNBTdeTxR3LZiTEewPZwd6ohngB/Qc4=;
 b=Cjne+uSMcQ8xgaRf/dIfdjPjeLYYv9Sc/CfPmpidekzy7IkfG+LSQ6HqSR9dgC11kdXNFkiJPCUiYREdgbCZ6UfmYZHZly3iDrYcva56ZkYTzJZoyLQrqBpZHmQjgeGhchnpU5DLwOaTayhM2NrYgCpdU0pYZ7Km92/MGPRwQQ9Tc7h6acaaZaLG1WPHoQFrcSfEfkWVDitxzme+vHZF0Px7SJovUfWkYzfOs5hMwBjlKOLF7MvpZxpUNlThkrA4RPkE5hFXtC44/dfgRXuMB/YLb10jK8OpyLmjNej1KJftoudRq/mMpWPM1yDqisJqTxi2r4+LJnP5jiMh7HxaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ObRSYk9lsRnVNBTdeTxR3LZiTEewPZwd6ohngB/Qc4=;
 b=wcnCcQ7bzej9iCWFWuE65ojvoDmwzgCbpEimvaCC6i55tV64i54LmFKVBx/71L3vTKxOxjcx0agiqmSQeXKwrJkIaxFIJf4qYYxIAyVQECOjVd7sP8Fi3mvAS+Og45zPntrFQzDMxewLl0G8nSONJt+yppV0XL6413hO28CwLMQ=
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
Subject: [PATCH v4 20/66] mm/khugepaged: Optimize collapse_pte_mapped_thp() by
 using vma_lookup()
Thread-Topic: [PATCH v4 20/66] mm/khugepaged: Optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHX5r/qivc99rDrbUy00nA5hJbASQ==
Date:   Wed, 1 Dec 2021 14:29:58 +0000
Message-ID: <20211201142918.921493-21-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 468a24ca-32a8-4a24-6b2d-08d9b4d70d6d
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB2768748C52D22A10AB0765F6FD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KzZKGG3ZdTn9TtfF+g7arXPPJYGdvr4EzDiuyNU8TgSLwwDq/r+zXsqsXhiPXT1nw6iYzH6hcTwHVkP1IEFwgKIj355NEtuKx7v73oBi/iTXWrj0mh5YOL5Ci1bf9sTDdZrI6aux9HfI84krMLUoyoe2Qp0XBbeWNkg8L8Amo5MlC6XtA4Beb3tAiDCumhtdFKBL1eyv9d4xzW5c55yQ8kqSh3r1u4RbUXkdDkobOHAd8syClbsNY3WJFVDZsMevlRC+FmLdBalNySw7bB0AWLXVNb08qktgD9FG2UlKl8F7gvdJlSDaHcS7myxYitIJMnCurg/Jsc6LdUpTOPoSIejyQZWGlSy56F55ICH2omgsb5OpzGUZrKOm7Z/YIvkbaLa7WlGnQGxw6iQ/bJ7kfmGds/kavLhPoN42NyirinA2aY9uoG/Jr6/13J8cg4h8KBHrUMHIMVfXRqRfx6I25o+FdCw5KHBxMfdbOdVSeHU2wB13gRh/e11yT0X3IZL/uIR3r/PsJsL76vAQjQZp6O9r7JiaGwEsPBBe8KNa6bZN9W6WzIuA4l/9dobhWc39QMuZ3qxPzb68o0uF7s2Ag0oRPvQd9zY6jFhWUmOyNxGH5qDJnh8biXAYDkngonYjg/EVd1XcxwVYMXEOxga1C1J1bIBioZ750wTboX9xEMDMLBHv00SMIRlkGxZA/E+E5Kp7WKe5taqMXwpAAmWPEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(4744005)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jO0W/3f6sVJ7phfJ+iTL4onGZmF3JkLZT3EpdTdosPq1DRMtWUuru8A2D6?=
 =?iso-8859-1?Q?Iy5z08jndI3XI+f/9pcFxRdNJnX/jCk0IHZQNLH/xT3gYxgjfaj3zyeqrP?=
 =?iso-8859-1?Q?7iPU0OMmKUYOTa8jf/z6Ygc2TGHhStJwCmwm2jbPRly5JBbKq0/40OHWQK?=
 =?iso-8859-1?Q?dSreDtKWC+heM3RjaUiZvF8OxG5xjBpuqZKZCHWpLpmhvbsxxSOyQCqLp8?=
 =?iso-8859-1?Q?+yzetN5RK2zI6xn0bFZbce29MWwFOCgJ/3XvgfD/zjfdA7TMyjSQ2LeDYI?=
 =?iso-8859-1?Q?E8ChdnPuaDQzv3yfxCCg1wTId3XguCNYwBWpeOijkpbZyYbhOSDCJs3Rvl?=
 =?iso-8859-1?Q?GU/qvixtEeRsd2g7hQp94wgIjiyHRZiI9SB95ZyxekLkGgdEqAUdnTuB//?=
 =?iso-8859-1?Q?knTfn76ym1K9d3xn7vc+r/9jq4rFBxjvrEpuwHURelgGyAS6TJz/ydNKTY?=
 =?iso-8859-1?Q?7P5fX85GUdIkFZpVtcllV6sMfWaXbjCu/jzJft6ubtJxvHSFcMEgIozKRf?=
 =?iso-8859-1?Q?Fj/aXI17QI47uOSaAradWUFl8AMg0sUJoJrGGi0jthdkw7CbA6CNJNNIS6?=
 =?iso-8859-1?Q?s7+BsVYGtX4WYXgMy91LxSWK9kNpWLXp5q8z3sNzlv1f1oP1QC3f3xa1ly?=
 =?iso-8859-1?Q?gVlRTBvgF7fqWGmA9ttM7mvhrzz244ytC9WDuFhNlkJSXLhDkpj5QU1Qf0?=
 =?iso-8859-1?Q?KL7NOssaTjx9OtLupLJAz9MletYeF6aXgGnnropIq863f4TvVJzgP1m+UA?=
 =?iso-8859-1?Q?BFyuVrFqSio3s1CYsFqgnIr7K0dWHclH4VC95Wb5ojF+FMKXk6UHnj/7RK?=
 =?iso-8859-1?Q?dMNZvPlvVgLAzXQStCHa4Es+wufLFV0Mfsjuhya6TpYwzjkPqUItVQ7WPa?=
 =?iso-8859-1?Q?cbC9JTnfRgklxPDI7RWgGVrcEm575q3eILXMBa26KiIkX5pkXRHQnZCIy6?=
 =?iso-8859-1?Q?qbdTCODixNrmpsWeg57whW/P4AzYARGni65QEO+B+hJJ/umiodDXBLLU1k?=
 =?iso-8859-1?Q?i4HK0A/YlIzK2MEJD6EG03fqpTDQ91BbC59VbiN9FJ6e4yUFLxctZ4XfHn?=
 =?iso-8859-1?Q?ND+i1OJlAvX+j8c4XFnNqh+EWyPIUahLoftlopDvDOVml95bTQISUmJdAa?=
 =?iso-8859-1?Q?UkSlAaEaul4o2fsyLC30eRR6k86m3bGLf6o+1++B4Zbj49KSsg6PxMb6sZ?=
 =?iso-8859-1?Q?i2DxkBzruunhWs3evs4dwLAoG0Tpqb188dO8YfUbeMAj0QwCK0I7lVAJa0?=
 =?iso-8859-1?Q?Se+PqnVBEwwR8iGwVdWMNrcqq7VIJEAyN1cadSst/iimNfijatPgY4Fegk?=
 =?iso-8859-1?Q?pm0ejj2m24B4lpmJkvZjgj9qiVPopwq00RDAScjuWEy+zisIFq28K1eSiM?=
 =?iso-8859-1?Q?/S6Mfpf3OUhdnGD1Sc7xVSUAXJ3QcCRYrdJgGu4qFe9RIHdMrkwAfupUD8?=
 =?iso-8859-1?Q?+Hu4rQOikHyb1lRqr84bgTNfusPgjDi08HLX9xmb6uS37Ez/Aas5Qb7AqN?=
 =?iso-8859-1?Q?91voDmxR1IqJNlceOzRcYlAbE0mq1upn8VK7IcgVy60MapyDd3wA8aGGjd?=
 =?iso-8859-1?Q?RCl0hznsi2RniznzojsZa5QDrzJByNi5uQyQlwhJRXy8+phMhTGHGoE+yv?=
 =?iso-8859-1?Q?jX0UVSyddPSRHtl6WOb1GySRCIarJPLH0j8J2lUOmxzNtkRECx6wSD3rMz?=
 =?iso-8859-1?Q?AKsF5qG5jMzA+3cAXdQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468a24ca-32a8-4a24-6b2d-08d9b4d70d6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:58.4639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +aRLcioSimdID4nKoSMvsggcV/hubsu04YH/mzyqA9vYpOYG3IHe46BgFMd8FdP2UbIpgINMpXmn+gPFHQuVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=893 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: JI6wVcooDAJd7EEh_tpLxTcrp6tO2EZn
X-Proofpoint-GUID: JI6wVcooDAJd7EEh_tpLxTcrp6tO2EZn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() will walk the vma tree once and not continue to look for
the next vma.  Since the exact vma is checked below, this is a more
optimal way of searching.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e99101162f1a..0ff7d72cdd1d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1433,7 +1433,7 @@ static int khugepaged_add_pte_mapped_thp(struct mm_st=
ruct *mm,
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd, _pmd;
--=20
2.30.2
