Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1111F4A6A44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbiBBCq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55002 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244403AbiBBCni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:38 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Dgnc008551;
        Wed, 2 Feb 2022 02:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oYrJzCvJMM+yEoxk87rjWhD78FY2B9cqjOokt9Z4YoU=;
 b=dV6ByugTd6+haxcGnc4dqp9I9RtIjbeipSXfTU+eiJe4SwJollm9ZhWd3DrepY2x34I/
 6wqmtQnJFg+/gb0qqwu75ywkNOyPWgzpD+moxF9EwKYCH4Zc5FD/GdUzYhATFx7S7ZpM
 EPGKP/rZ59P2qCeSTntlvHBnsbMLRygSLzpcj6sNK99Sy8PCIwdiGplgQuIBa2xsx84W
 sU/0FkxxYjAm001j/NytFPF8eu+0iC6/6B1HFPk/pOQNLV29yrowkLltu3Q6Cme+u73Y
 E5/uFe0BciZnWCGTZS6dzBbzhd5fUdGhuKjoPuOi2baGHqluVG2lWd9VBE8mxUdEf30i tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatvuge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPVY146749;
        Wed, 2 Feb 2022 02:43:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3020.oracle.com with ESMTP id 3dvwd78wmn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hynOFsBPP8p3XkJlu/zlU5/wR40rxaUdjVYZO3cMN/D4klJ78t/KqBSRQoI1BGvD9Y9SLkrrJ4VXDtjkdeYDE63VQKJXlOvag6awGs6q8xi5dt3Yepz0Yad2hm48+FvUIyjLI1R+LRMAnlzGXVV4AnNN1nMbaUyVyMdP84cFKji13E2Qqm9G6frLEGOlfXievQE3qrZTLabFFwKhwB/fCF5tKlQaGfqdRGSZh3pvsZW0AwWt8huaBAGYnUOAumSdxASWuLSrf/KoUqME0aRZAgcoK1e6bpAUcGJ60dJPqUCk7im5T9ZzgTFljnJYmfjKzrGgtQuuMvzEZWoAwaVI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYrJzCvJMM+yEoxk87rjWhD78FY2B9cqjOokt9Z4YoU=;
 b=LNagh+XRA4/RwFMQaimbEAxo9WnuaAcbHhV74dxpkf+EKnBPws3/Yx30BzZ4kGwE2rpbCpPXQDb2KRdvte/DcnaTcxTt37peg790eg5Kt7KCuse2Yf7xsgQc0i9uJkMIudWdpTa+CX5Ywr4g5pWEqcwKMOVN6cc6xf+y17bJSCXjjA5KZqKk+EOAgMCMOXHG3qlZPbmpTPA7cjfRtb2NcVuX0jHVTq12MLHLYqh9R4+cjbFMl/p/hu99j8S2jeNrQiBIenIcHm8JmYru0Z0OYqriSZ9TWef8A+rRmDXcKxD3M2WjR4fs4CZzdeufrrAJxXXYpmJgTf+/7DyTXaYM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYrJzCvJMM+yEoxk87rjWhD78FY2B9cqjOokt9Z4YoU=;
 b=LqAS/X/+Mg66SreoDKxpAtHFTzZs84ta10UlsOI5KNvDnaaX+dohha8zap+cS/voYMeLZ48S7ABrQhtX/JnkIgOW+ZcE/fbCoTYrK2BYdjrmo1B/06Y2/Pt9/tRW1GosxppyKR9TyfcrjQNnKq+T6+f7DmjO6ONiYqhvz3uHrjU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:43:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:43:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 63/70] mm/pagewalk: Use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v5 63/70] mm/pagewalk: Use vma_find() instead of vma
 linked list
Thread-Index: AQHYF96CM0oqVHk09U6y82nkXCkczg==
Date:   Wed, 2 Feb 2022 02:42:23 +0000
Message-ID: <20220202024137.2516438-64-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8898287-fe3d-4a15-0eb0-08d9e5f5cb6d
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB58650B8B70294F8A4340E9C3FD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n9D0dS8eylBF+Xdaii8Tux3lDPueIGpJuLxQLcjXh9b8VKVoB2W/NALgWKnPGrFCFGqomdhj95c/e7pzWOQsbnhDl2aEzvd/jZIPYaWCEyWfi53Fh4oBXJ5VrEFVp+/bUwO8RS+65qS7iJTv2LtMsnIvJeOsYm6VM+ugXIcOgCWjepfkVr77ibx90tcs8Kou80V2FNvgUtMCEkaVu7PMtiYGE8IzHNyPnlgbSWFJhKMNQLG4aWAycy4kcPvBOa2mVhPgk//FxXHbIb8XP5Ia3JSS0R+j2O6y46nZlu7ZeGBuSDBP5gHw27G03btHyTmQHE0i+Aj/mPKSU3yb95cPwo2TaYuw/vpP0Y65LEAHl3Asah5thi07SL6nCM3xvTLteAt3U0VVMMRYQbl0sIEWE1et5QaVk0rv2EtBbkHRzlZlD69ViL54DkT6lLpdFTBEUlY7E+JPDEZTHk6uR0C9DAG7UU3K7rKOSP/gMTg/sxP+pdLBlkj31yVQ6L03Htx2y/FVqH/V0YZfXh7pup8uFbKndHtEjV1nuxh0rKNeDtpv1hY2t0FP+pQrVme4kTk4Rdc+yw/2ZkbrxICBjJe+IfZjz+XBS2yfL8V7GIJ2k1lEd+yoUySJfIH64upizdXl+OEH9BjzrO0dnY/j8ZCRO3IwDig0HuQdtgiTqno98KsQjIDvNzNFQzOIcm3c7k/oHlXCDReRdt4yEkyiedEHFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(4744005)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KJY5dpBhPVx8uEJ6tMP9h9T8VDfSgEVctfhM7f3d+JZxT7cSF74eDUrP04?=
 =?iso-8859-1?Q?30oGLqT3YFk5wgzPbqtjnNdAZkVWSPfhJPWLV45x4qbyh6ia41X13AF5Ik?=
 =?iso-8859-1?Q?De8B8FXfWoYlZ4OuThPHI7ush5YHEke4/S+PlwnBfaCaYqpNjpW2UUH+15?=
 =?iso-8859-1?Q?i+dOuPRTrrmPEvIq1JebwNZ+6ExktEGZ2QXyZBXjBrR9gGphbAxzuCqsoA?=
 =?iso-8859-1?Q?6WgG7seB/BNbom6k2JxiSfPS2Ha0C+4isC2FM0BVH3rAU3lv22Bk14QVcW?=
 =?iso-8859-1?Q?X5+mN93HcfMUNpzTozmVDmUzaGASl1HvAQf+RwSz8ns+yDqn5GkDlHvvTw?=
 =?iso-8859-1?Q?79DXqtjN3BmgwetVRvkQ9r0gm0AW7JTDaocjB1Gj8B+h6SNuZ/uc3rhAAj?=
 =?iso-8859-1?Q?dwPj7VDQ0OwGZZUrdKRGegxM4gZI7Ln+1YSbSJjnoFAR0q0MoxT6zkrhlx?=
 =?iso-8859-1?Q?CqFohELEN2xzSTws6udA1e1zdzuA9of8O8tZZ+3SGDhmxnnZLUbn6t4rhr?=
 =?iso-8859-1?Q?fOPpB7o3Aru6/9WkR0Mc+okHCCgEgZx82ANqrX6Sr25+s6obRW9d5pjuiV?=
 =?iso-8859-1?Q?jqEcDGahykYQI0u4xQ6HWgFENKtsV9mStFVngbpTNlyVjn5R6Mzkv2Yow2?=
 =?iso-8859-1?Q?YII/SLz1HfRVK2/PUpe87ZMKaznldvh5ZGUBo5yc3iEeIGfKIuB730cvES?=
 =?iso-8859-1?Q?ywZ4KFf/KKoogtU3aL2Bx0Sv5PS3HYC/uc7mPdJZepFcGMoGyB8AsYNXn7?=
 =?iso-8859-1?Q?V72isyHEqUrYV4+WWF0+QtfnUvT4sofAVXVdQeMLtY+QJMv+iiTzvIi7mN?=
 =?iso-8859-1?Q?4cOV4PpwXqG03zZVG36BciXhySf2vp5jFMSZA0dogG05vi4QBSq4L+1vz1?=
 =?iso-8859-1?Q?cS2Ru6UG+Vnzm5fl48Ibq42fvzxo3z+At+l6Y4yyEkpOgCOBa/RjSka8gG?=
 =?iso-8859-1?Q?ospHgZXRGRE4+WuHt86HNmBFOIB/f5qxPH56LSKUYQoxksDVXVicDM3BL+?=
 =?iso-8859-1?Q?Ebfh1E2XetTdPfqucypuvcxPm58r/D61U2aTtmNMydpPguUUoJ2ruBkxzz?=
 =?iso-8859-1?Q?RKJjenQZnD7xxDfGRv5G8MUt9UKOmDf6nNykoRq+K/aA5DRlIa1P0dwe6H?=
 =?iso-8859-1?Q?KdmXz+1+Xv00Z6a5wRxUep3xG/E8w+9pR6H0g7e4CvMoT9kXZmTV4GJhL7?=
 =?iso-8859-1?Q?jJQmZpL0ekj0z+iVeFNJOfJL+VnhdelUrrKhVMfK/2SSMYpIAH1x3LSTqJ?=
 =?iso-8859-1?Q?9wWqU2we8An38SU2n9Nl4uWU231mwXY4dZekxIwWMRTiYs89+hBCN8K566?=
 =?iso-8859-1?Q?eb/fIUTUmkfTmsYW3KiZQ2Au43NQBUlsYUQOVHO2O2A/3BqSs9WG82Tf0K?=
 =?iso-8859-1?Q?LTKsxATa3fmQfpquyIA2kJ4UGU/l7eMSWqNNw8+iQFzxI9Hh5FFR6qK8NG?=
 =?iso-8859-1?Q?wYxZsPJTEOO898QFFDrMxi9waxh95drdgAWLhqudCszlcHdL8dOUA0tGsy?=
 =?iso-8859-1?Q?yjBWJVnGk3zfhOM35kaoEEdVlCU+VD5tjsXmbY2Sk3hm2AMOZFttJWCZto?=
 =?iso-8859-1?Q?Y+af7H3V2OagVKcOisntIrV7mww+O0isprFgPWLACCGP5WDyjOUUIsH+my?=
 =?iso-8859-1?Q?sxGBuW3xtAiyFKSqIF74p3Z2w4PmqEj4fO3esmKTyrdVpe6wRbxntM5iwS?=
 =?iso-8859-1?Q?B3RwL/Aia4DSQucvQsQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8898287-fe3d-4a15-0eb0-08d9e5f5cb6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:23.8912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxqrfMWxxoAgcMgHiYaTkMUfUYPNczHHJ1MKtCIbELAUP8Vc8jX8SNrbIJsRL4/iIcni5nab01z33I3rQRoW+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: zamg0LXcofSF2aNfqpdhKp5bpgttiK4V
X-Proofpoint-ORIG-GUID: zamg0LXcofSF2aNfqpdhKp5bpgttiK4V
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
