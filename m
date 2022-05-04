Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34759519362
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245223AbiEDBUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245158AbiEDBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ACF424AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LIGqB026258;
        Wed, 4 May 2022 01:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Vqiz50MO5iUbcnZL7iPPAt1f0jupXg/4AfF7zQR5jVA=;
 b=aOKxkOOrPQbvAdo0x2xo4UoA6K9oc/4zQdNmTYimQx3ezmNync9mPdmsnS0M9CvV0iIQ
 dg4FQAJGuDDH2+iFKvESqWvnZqoiigW6EtJX+C3W6BSvM62syYKXhW38Xl6Qh+yXRiUY
 Z++Oz3mYEbdX7c9SI5hmTOBPHMevRxrga/HuagHECiASNP/cqM90cIg1zJ4MzI4R7262
 BRZVbnDKSvDT+ARp0Fsz0WsmC5AM5ZWK+v/oybYGum7/ZWK30JhUvXGkkNgYUmJJdnEv
 dx+9BYt/J3bbH1h208TcJSQitZQAG/SFjYA6m1eeelS/cvXSmiJdnAJ5KXKLV+zQaZEw Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc72pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441ArPv020035;
        Wed, 4 May 2022 01:14:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hawz4LDLaO0gLbzpbepWBWJVowdaU+00iDxnzFGNV4Hh77SVOTLIKhv8dF0hWg5/rcFL+6ReIiQkZipBZTlqObOnAqSTbtimwWjZAqDJtuM8G/ZUn+WERwEeh75YinzqeUyERYM8lo6NIkH3hinAu/QW6sbq7yXi1+h0XNrLYnm2Ne4uQAXgnZn8nXEZDhBVckwqR6xNJp9GHwyxkKGAHaM1q4FL6AVZYcp5uEKMisnh/FIJnrwyEEYLAGcsb+Dq2pMAbtjfNMynLuL234lbDmwbM29I2BuAZsybBTkSUE22MEW+bKLozfy4y+m1JJevj0PIXKlTV97hUwbnJggeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vqiz50MO5iUbcnZL7iPPAt1f0jupXg/4AfF7zQR5jVA=;
 b=YV5kzNeYkS0tWlTDO2jniW5WkgmAdiZf0UWjXVPYhwEJZ4HwFud6Qh/VIndBPUzCbMH7/5Vfe7fYTEfOj8Jj863UBtXC3n7VCpjaTU3wSgyQ5k3o76nC/R4j+egMCkjG+OZtQ6RFEtzKJZTlgz5bA2if4pQ6wGTHMKBNthSx52an+E5kzgx06xCPN26Skrl5tI2aaDtqbxE+dAxuihb17KpTq4PfbhXlQMqSfTFwk2DKEZ+f9Y/xGC8dv/SnQYNUWdQJ9H1CrMlNdMBXRaKSoR4Y6oEajrx8Wd9tLpriHMrmifwVIwh5rxrtyWgK0Z42tjb5QjBaWnNE0jC8Vy5hMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vqiz50MO5iUbcnZL7iPPAt1f0jupXg/4AfF7zQR5jVA=;
 b=FxAR8S8H7RWiMB8lJzrd1CicdvddsJlMKlGRQ0VRYOa3pjRtF/aQLriVH/Sz89gtlEXXkT5vnF5vxbTYVmJdPVF1ngzzfx7mJ3SJU0KPGM+m8KhnABPFMwTafB87t3rJAELOe457g5Yfem3jFie+axh8RPbFDfd9/VuXbSKg62M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:14:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 42/69] fs/proc/base: use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v9 42/69] fs/proc/base: use maple tree iterators in place
 of linked list
Thread-Index: AQHYX1Q7H1B3w8l19028UEEeLDCdUw==
Date:   Wed, 4 May 2022 01:13:58 +0000
Message-ID: <20220504011345.662299-27-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08731d5a-2ee3-4b65-a735-08da2d6b5fef
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB372876719E83C18C0B33D31FFDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6HmpCynUgW7NYJAdBLwc7vUSBWHXSTwfcCHRs+ZT/hj7rAR5H8Znlp/eyjSmWHTYLhPmBEmKQVbN4ML+2j6+GrMJV1qutt1zL/VvCK1FvcwO++AkZYOdNyaSFH4GXj+EwVtxIVSDN1G9VKHV5kC/rSJUXBEsq097xiLYA348fRT2kId1mGkXEXZubdasypkyxH4GfXBLbH2shLEPHceOmkp0v6unHZEmdpswOVVqwq7P8fLCyAmFxdDYA7uj+sUV522FkjcbAzcU3i01TiM9xXXACUhGM4JeREsN/R6Wnd17aWo+dvRgM2Nsg+UCjYE+D+NWixQcHG0yfI6jWlGhuzzc0WkC+PzolBCO0lpPVIfXSIKKgtDfWMbZQBdecUFqMYC5ibKsJQ7HLAf01AHtQGPoB9c9vECz5zUU9604mNtncvF6jvzN72XmRmdXiL414CSuBB9liEqW4YFNeBScpq75Mh74QobnBJVFqJEYgfsKzxJN6gEkwjo47Uwih16knQh8wz8ulSaSPtkwAfIEPfNgI2hJoXwE0Ms6hbTELaGRX95vofQeaBWQgaBV9KrHZvp/3tEtNhlimXBw4TVGGzFg8xklzGq/0yY1XA/zY6dOFxhYsT8P+Dcg7biyhdZplr+8/bcJAubj5OWZq7d/jlRw8/fB179zMsCl2EIc2CtjitmzjPSAxenUNAbVUAPn07jOLM1G+A2Bdysi6UZcWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(4744005)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iCGiFmTkMBBpBj9PCWNfGGgRbwopBG7zc/RMwD9bggOrdpDPd9TWHvJDU6?=
 =?iso-8859-1?Q?0oI4DleICIV7Y8KoH0gXix0Mq1bPBJYkI9/4zXWo5WgIzdUPWNjddLNNP2?=
 =?iso-8859-1?Q?v3C3BtEhBunaQzqpr+CiLtbkEckpPixSjvpU1fK3c8+EeEgRFwyW1PF1AA?=
 =?iso-8859-1?Q?+tGELgqO+aiaGAkxZ60B9d3XwAhrJHATN0o2V/ve1HA0wOQOajvmtUS2El?=
 =?iso-8859-1?Q?eGsqoAioDmxq5Nc6+eL0EHsAQj4dBNvyDQDPTqZugj5Yt2Uerir8QN5fDw?=
 =?iso-8859-1?Q?o/9QUeH9k7IGvOkVBclPa7cN6YH/fky4YA87AUVayTBjOzGhnn6WPAUuuY?=
 =?iso-8859-1?Q?/Q0UfapRNsLL3nDfur8+rRP6lMh+E60KpUheSwicI6BpDyhOvLaxEUr6GF?=
 =?iso-8859-1?Q?U/2671c6fw66MF4SnNZFLjJ0RJdGAYZpkyrgi7sB5+Ht7vkW5nR1qcFWV/?=
 =?iso-8859-1?Q?fUc0K1ZmvcjITjbm+oox5i/hGxQcSN0XNZa79ZECeCoj6Jy0AuPEZBGQBG?=
 =?iso-8859-1?Q?Gd7Jd1p4VwOJCA6BMxOwSVQzSXldKmbYiup9ojOvzFHEQE1SOaPIGNflou?=
 =?iso-8859-1?Q?Zf6twZc9kB1eb4MCRxKzCLT8hPB7rnCqeKdn/jwXnEkgW3lbfLYYBkzvfO?=
 =?iso-8859-1?Q?6vh9Z6N7/pKrUCnCsUu00+rmVh+jPRvEw7dy++BTnh/qv2ftsoHsz1hWn5?=
 =?iso-8859-1?Q?PX+MoFZcXKPTBN+7o7VEpfXBKWXFP6vSQX3VMpr8pE0ezlFCiZh5NAz08E?=
 =?iso-8859-1?Q?9fRVX82Di5izQnJo22E8fejxLuyQJ2rOACTJtoelhmA7/7ttuPn/EQFYyZ?=
 =?iso-8859-1?Q?ruJoOkidn2+JtezUzmE3F1UAuw6AHRUZ0ufjp4k1W4xrlxxcIiQk2yoLo7?=
 =?iso-8859-1?Q?S7rjB2oZQcqPWDSGwTkGfDFjOjsCSvKnWgzAwSFamkDYaCSCdYD4MRZVHd?=
 =?iso-8859-1?Q?VXoBj6bLx+Q+BBu4MER5Jin2/9/l4MsnixbfndP81Twtgwcm0It6yyQb8j?=
 =?iso-8859-1?Q?68m2q8YGpe015kU3i/ycInqdu1eeSsjtljsRbl39iOh8qYLWbjlq6/whHF?=
 =?iso-8859-1?Q?3KiBFAUgDjPkmJatN2NaPdkpxoZRiGHzsPXRPomrckFVFjenG08JiextzQ?=
 =?iso-8859-1?Q?BAhqiKO0UMA6yGWpbOHC1LOV8K6G6TeVf4j1SpfswIOuLyuSRQJxKB/e+t?=
 =?iso-8859-1?Q?M/f1Tro09i7rdT5C3wLw6JORDIb2/xL/dAbm3QiqWdB73qN/+xMU439+aV?=
 =?iso-8859-1?Q?e/k7rXFeCu5umygPPe7hyncsKSqIaKBAFBLvwT62t5Ql4YqRUFAIdT2UUP?=
 =?iso-8859-1?Q?35y9jeEw9sVZnyO8XObFTw93b8gsb1uQ4loNqwfzSiCK9cGMc5/7IBV/RF?=
 =?iso-8859-1?Q?Yn3YGPn7oRb/W/EzIPXxFuxkiF+uL4qzz2SKydFyrdD5qj87xFYC1VrEFR?=
 =?iso-8859-1?Q?yopBxUZgV/9cEV4Ma4mLBAI7r/yd0ypYdtX3FzVVI5n54wZdqB6fpl4VEi?=
 =?iso-8859-1?Q?hcXOvtV4M0qscsBO/AFV58NXSgjM6rSPN44hEvflFSJH0qLVKUn1JFqn4A?=
 =?iso-8859-1?Q?WtCletq145B6LKQqErT4yADw49r8nfbsW1rk636hxnbz5rlTsKY0ikxQfD?=
 =?iso-8859-1?Q?rLizYGWE16YlV6deNK27po4jPSSAXArfz3STJowcpPqQw1O+y3NtCVgm91?=
 =?iso-8859-1?Q?XuvFRet0yizg3QQ81EQsbx0WulSEfFEr7pEo2fc8orKuux8+WsdmloHENl?=
 =?iso-8859-1?Q?g+2ZW0iFwlXIuw0MeOoVwycXqvg8eegqKZA3rw3NvL0NDkm6llAFCvbOSb?=
 =?iso-8859-1?Q?WXveKZDUGZFkm/c5+gmH9zZQlbLgEZs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08731d5a-2ee3-4b65-a735-08da2d6b5fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:58.9078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HScyu3HwA6x7wJxLumNLnlaHPOhl8mX3rguk5EmIG/X/CwZBBEyS0REwIK7OAK3q1gr3Sf5J5U9PTmW7uw3/Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: guwIYY-tALoocc_m8F5Iw2fsknPfWsQv
X-Proofpoint-ORIG-GUID: guwIYY-tALoocc_m8F5Iw2fsknPfWsQv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..617816168748 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2322,6 +2322,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2349,6 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	}
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2360,7 +2362,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
--=20
2.35.1
