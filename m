Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124EB510175
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345869AbiDZPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352079AbiDZPKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDFE158F84
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDStxw018590;
        Tue, 26 Apr 2022 15:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=U7Rfd7WazVEwoPIRdO3F0nch5wfB790v2PU2x4TSkRATC3CL4YjsXdoIG25CWbHItbwk
 gIjm+or345WRvYSK/ftqV9I1HFAt1eV/nO225z7c88/Fg9Tc/4iuKUnJjn6B+7kwROX9
 6/EypbL6Sp/0WDIByyg8fjWgu1dBjnf7sY6IsCCy81Ij1Px6rg86/n6GJtBOslpLGt+M
 4HPTQ70xolb0sORo+GuXUuplcs1T6MQ6goZ0kbeOdO6ZWPp64Sjgp3kg11daBE0q2DMn
 T1lbbuJkenXUV4dHYXrZeTiTaE4LZjIdkqNHhDZngBeH1GjR+RGNnhr+6zQoPA/8mwE6 ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jxej2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF5552019202;
        Tue, 26 Apr 2022 15:07:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3ff1x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOoy043vM1K1D61DmQcqjEpY5zKPBXB5zeepWa43O5bsrAzal+VwDP0/KRBcjh8ZrPqJnsEuFBUZ7BbgFOHP4aL/i4TirdnoR7CN0IVqG0To6jO5Xf14vCVXPyPXWr+TEKhKOmZKbjFdU2x2mlVghJzAgwjXBdmxEWH1oF4puT4P6wFB5lMu7ZHb8qoGXWUvUCBaOuXwZ5DqepJfyUwMDsIUWxZ1WO6RxS6uepCECTOhNfzOpIBEarA2qNElb9zsQ6vuvOZIC19cRljyFh77RN+Wsy77z9dv1OJCRTGi8YPRdQmZE9KEowD78Y8pGAfHKojCbN3kriuXUodUxjv5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=YravgQeHMZdFRElsayD01HyQb1NATe/dNE1DQL1XXtHGokelzH6NsErTMDyVLv5ck7rwVKIfqCKgMN7gBOqKmJo32xm3dDAuMzHAJwA/z46FUdcVlY11tQ1RznUVuebnZNjHIGRhQVc66131qP2z8FLGb4gNcbnBBdJ+VX17W+T7STKgjAFOdtS4bTuq0cYp+AaMmXEjLy9lXKkEVNKid0/0s2G+631wc3nae9HI+/gShWrWXEGEc6dQ/l0Tuv3eK3dPgWVtRksEq6nnW21bxG18XArzpbuKj/fl8BK+EfCugBJJQXkbaXQSens4fNnS4kkudE/A9MIcfYjsFPsWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=xfuDydUxyfWg6rI6mV0HesCQWKazNaRENiefuQYuiwxg+wfcWkGY8igRkzxk1M83hWdJJBfhBL03kZv4bJfCs0/1k8ODXm6ynqSzDBccb40rE1RO/9xxsWB7rTeoBM4lIJ5qAcWe723NYkMZAoMGacJUhr3j7xmqaYhHB8dZqLs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 46/70] ipc/shm: use VMA iterator instead of linked list
Thread-Topic: [PATCH v8 46/70] ipc/shm: use VMA iterator instead of linked
 list
Thread-Index: AQHYWX8+F/ixUJt3hEauCgP3yVGpHA==
Date:   Tue, 26 Apr 2022 15:06:45 +0000
Message-ID: <20220426150616.3937571-47-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 935a6a43-55a5-4187-93b6-08da279679de
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB292912B332DCF747A7D6D5F9FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QLPkCNogX8ELTx/nTTOlestB9zqI9WHHAWd9kxO9y7UZC+z+iDLsTvQT3jeC+wz4nC0FjWm6xTb2fhVA+AjZBA7CMGcTuaKx5iDYPagJx09Y1pSsqMpNrtrXmbRGuCSuj4PDJKdowVxvidM+vpNvnjJIYBxujUI+UFuvyiCpXvxCZH+JL++T4weE/3nmevJGsQPhADq9CIDiwEubpd9rw89T7bdvw4au6FkvlWD4HzYF7a3Bmd5lO9eeZqBXkNm+l6Qa5Q01DAKf6F3hm1+aiJRJuDKSaIcJjro9vXWB+/QRyp7RxkcDb7D1JH2fY/CeKyku63S52xxHD8FdWXAUd2HAVGlQ0wdNHYhOMNfvnOT+x3NRnQOZzG6sTMuUqQ+Hh8HIIaelHHTt8Qoj3Ew6Z65fLYqFl4o5h1+/pB+3AMblXyzgTFB64CQUDb9/GhyofQsadKUyrpXIq60Q17B0G1Z/ytmSr0KFcXf/7555HPT5K2fnB0GRgvYHlL/WDPDd1A0LZdqzlmP8QPLP5ERSSj9HzbsWvWVQt49rkcsjVlrf77J3TtMJnwfM1e/sTNH+bAbMvYvG1YQIM9wasr6xOMLu8eHLYERuA9FEkggRsoN9p9tSiIGnWKWnqDPH07GcwaggXDL2gENYL7Oy2U3dO9dlSC3QazH/DgXI1JmyuW8FWU/ksvum7mrwo2u0d1yMUmzCJJ84m2ms8QstmWSQTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rNR6l252kfTrJf4pkP+ofVBkVS1nrNz+1LsI1SsRKwn+z/I2bh1q0smd52?=
 =?iso-8859-1?Q?e4p+q4GXzwIzctsKSwHSwNyJPiPKUZgQs7J4bSjZXaCZe6LGQUPUaJMxeC?=
 =?iso-8859-1?Q?VtIsj+NZwartWepCLr98Xc+6WqOkPQq8C+RDXuDj96akgpnnOL4ggwbXTN?=
 =?iso-8859-1?Q?CxNRtqS8jOwxu/6GUh5ctIDcILBPe3XILRqGs5XvncuO6q8Y6zP2zD4RMl?=
 =?iso-8859-1?Q?qZlFcnHWePF/r22hOpvv1lo6A5qiMeYYXfDZgmoxFBvA9aZx1E+4dGh4qU?=
 =?iso-8859-1?Q?nts1M/VGDYsPhjdDoPj9/mQqODq8q3BlnfhuJiJACThokS/tdkprrhhjsd?=
 =?iso-8859-1?Q?2G91uzy2wRvaLjyBb6h0urzuS6BoGR6J8A5JdWAwfsVH7FBd+f6SvWoZMa?=
 =?iso-8859-1?Q?xqIAsNJJIo4phvYtwZlqYqVzMGjnAFbA4wGpYxcSknpm8ssPbE8gymZAg/?=
 =?iso-8859-1?Q?LKGVW2JeYIyBL3+YOA51ZKZmi5ytF3mzWQ56fWXa1Xw59PveyXZYKJ4ZIt?=
 =?iso-8859-1?Q?vuYWn+16MwTbx5KfC//alS8YZ22SbZzIH609bcxumgCWubnfRDML4eWqxW?=
 =?iso-8859-1?Q?Jv+QE6Fyzqrhoje5eLDaNMrwmy414SBspuzPyLfrlGR8GpBQQ6nK6z7wcG?=
 =?iso-8859-1?Q?ccrslP07eRSVFnW04q4vbKmvS460LUsA4BGRAtJVuyei2n1AHS7D9YzMGA?=
 =?iso-8859-1?Q?sakTquvd0XVOWuy6nt4oVZa2HJemOTkq87eayIZXh+mIK1YCv54r+i5Zdv?=
 =?iso-8859-1?Q?8VXp+KbNGQikcilcgR3PD1OyJliONB0I3A+wrToNHAxMzANC++50jp9yh9?=
 =?iso-8859-1?Q?0DAyHPwUokYKojo5EYJnxmiyc3zXA2h4Xw6tkpbqUVhwmTNDt08+KZGVch?=
 =?iso-8859-1?Q?3wi9dSP9Ol1KEfrS+JsBKZvEOjzxpXd+cx2lvNxlDXSq/t/EfPJnSZWgOy?=
 =?iso-8859-1?Q?07Goxmewt0Tp0Wqs4r5yQt1fxaoBWTa/sFa5IoEiDBQi6P0LTTeGkTivQf?=
 =?iso-8859-1?Q?el1BCpSDQgYuYzVaogvcuCK0iSgsZY7EZWjy/jwSmgWp6r/Orvf66WKPqU?=
 =?iso-8859-1?Q?csB/TrmPWqSSUxz4tPcousO9UaG2K8w+KmmA2aUsryP6yZyd/YEpACrL6v?=
 =?iso-8859-1?Q?+xPEie6bBBgpEBp+Mro6lDgB/PjLWeMrT5ohZRvfIhhUuXPX6zD8zo4y77?=
 =?iso-8859-1?Q?290UKQMrifI/7ISlkaAVgczq8aaizW+oOYMf/B64nrEGKDt9FS1PDuFob7?=
 =?iso-8859-1?Q?Dv1c3/DBXL2XY7iRex0k3WIG4qUzTDTUeHC7nVeQxJyTvJo5qkWkw81Nfa?=
 =?iso-8859-1?Q?wdK4DV97FU/rIYxMF3BR8lhUKc+5rBj8epeXEkZAaFAvCzo9LQjLAUlMtJ?=
 =?iso-8859-1?Q?kMpelKSEuSM2mqVWfdD1yG4cvew3lXGd7fx/EwhppZj+LKcQR7Q8bDkfhy?=
 =?iso-8859-1?Q?99ASnDlVG4gTV8DUE8sxf6zdGvnhU80Uxrut8PBY6nb5/kzwXCTa6QqVXs?=
 =?iso-8859-1?Q?+TAQoPHi+bB6FSidJeZ5HSyXEv8azObDZNX5aP7FXi9JQfL3JOjgf+ClQR?=
 =?iso-8859-1?Q?VLMKI4db4P/MBoWEm+bLEOhSBrcFw5RLS2BdUTBtCPsp2ZkJPUwTkxI+lO?=
 =?iso-8859-1?Q?7dxSJGJrYKgNc/hk1ZjZOgvc6WBs3rTjWkU4ue/LuEmktA6c6YTdW/2NM7?=
 =?iso-8859-1?Q?S+TAHGfRgZgRtRFlHfR7XTgjhgNpW3TsfcSRINmgQiimuc1VWpEv1YVhUW?=
 =?iso-8859-1?Q?EIksbfDSb+sEWtEtJfN5E0ZVWL2EA3RhKHSNi5nyzF9t3JdSdSrFvOTBZ3?=
 =?iso-8859-1?Q?u+gcrqHTJpGWQpTl2orWun9lrczsLh0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935a6a43-55a5-4187-93b6-08da279679de
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:45.0207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0y9ImZVv2uHANfomOZQ8T7NA6iw7Lfym2ApldVj2vcbuzbXL/kIviDAMIa4Jt8Yyd4ZfSiAoO0Fhbw+xvtKPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: YdhNY8o_rdtAEbnlxfNjHuRghliZvsC1
X-Proofpoint-ORIG-GUID: YdhNY8o_rdtAEbnlxfNjHuRghliZvsC1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked llist, and it can be walked
even when VMAs are being removed from the address space, so there's no
need to keep track of 'next'.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 ipc/shm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index b3048ebd5c31..7d86f058fb86 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1721,7 +1721,7 @@ long ksys_shmdt(char __user *shmaddr)
 #ifdef CONFIG_MMU
 	loff_t size =3D 0;
 	struct file *file;
-	struct vm_area_struct *next;
+	VMA_ITERATOR(vmi, mm, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1751,12 +1751,9 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
-	while (vma) {
-		next =3D vma->vm_next;
-
+	for_each_vma(vmi, vma) {
 		/*
 		 * Check if the starting address would match, i.e. it's
 		 * a fragment created by mprotect() and/or munmap(), or it
@@ -1774,6 +1771,7 @@ long ksys_shmdt(char __user *shmaddr)
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+			mas_pause(&vmi.mas);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1781,10 +1779,9 @@ long ksys_shmdt(char __user *shmaddr)
 			 * searching for matching vma's.
 			 */
 			retval =3D 0;
-			vma =3D next;
+			vma =3D vma_next(&vmi);
 			break;
 		}
-		vma =3D next;
 	}
=20
 	/*
@@ -1794,17 +1791,19 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
-		    (vma->vm_file =3D=3D file))
+		    (vma->vm_file =3D=3D file)) {
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+			mas_pause(&vmi.mas);
+		}
+
+		vma =3D vma_next(&vmi);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D vma_lookup(mm, addr);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
--=20
2.35.1
