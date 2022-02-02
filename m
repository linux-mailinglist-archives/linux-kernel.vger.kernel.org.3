Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C2A4A6A03
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbiBBCmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35964 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237321AbiBBCmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:09 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211Nsv8t022152;
        Wed, 2 Feb 2022 02:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xlk/9tp098Dnij0NbZuamMaSXh5ZCVZsZFEpsM+cGh8=;
 b=SGqSLcu4mXgf7I2gBukmSEXhz9MV5sMEhCl3zBcwiCTAOZAvz0xeh86Yo5q4j7Khvh+N
 RM4nNT4WrhAyrCEkaZb7ZLXHKTF2TZnwc6avOLk0bcCNfOgwS8OmzsM7DLLyO7vGxWTT
 lDu0QH/Vdu5wlSFNV8Lm+cYS3VgQowdKyogurzeefb2Fp6DGtSQ/lRDBWFCYtwwa/1uX
 4pOp8e49dBobXo+yc8iMKWPigrYkYb2HKEhIU2lLCpI1Ciu3+e0IWISotZcsw2Y3yC6k
 1Iq0eSceSFGo2v9zeLBcMHqfYB2TjgaXfXuiW/Nt2SuCZEx2UwvdQ+TViw4kzcSHqWvB Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPE9146731;
        Wed, 2 Feb 2022 02:41:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3020.oracle.com with ESMTP id 3dvwd78vk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3lJTpzICBsVJIBp8uXdeZqBG20d3wldi65qzBUZVGwpyIsRI1beEu1vs6Nm3FAhGWKvNLtdhsflrmSG/GeW4SP9Yb21PJcKxlBPq0sPnaLtLuXNjpLufZUfcp1P5dY1CnhUy4A9VRcNRc6FmYuXfCV9sniGkH1OdoX8OHSetxX1M/9jFEnmq540LpigriPTIHcVEkAHANBMsn9/Q6iyQR+jWynHHNvGf0gyfT/omEO5b4hcq0nOD/9MhISwhYvk/4PHHUFCA6yN5jmrGqi18Tzj2cTIbBjQ9eSd2O6imfaXS25J63GauVzjUXE5l+WxMmZVX09J+nvbtnhXr7DvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlk/9tp098Dnij0NbZuamMaSXh5ZCVZsZFEpsM+cGh8=;
 b=KBriyiv/M6KKVfiQzoecIsMQrzRPBD7Eqal9o2847QtecR1gxtyt6U1IWS4dCXzLvS0bGzt2aqWdn8xoBwa/hYTV5tYZg/dYXeExfM/xOrdPpA0FhSucleTdAbujuBFMHbQkuCOj6oz/EyRL20UuW31q7TL5Qad8OxvxEslM5HeuqqxQjcYX5Ma9U668TOuMFURHUmGM8cgKuqDfweceO93rfaHDs0xUsB/ght4S6DnT0gS1AfX1M1SlIr88bfr+BIlkVCdlbN8ewLgmDteTtIytz7poIcOcwHTOrMkm5Kd+XFVFH/HZPXkNHbBKAhtnncm44llY4RQzCEtsR207hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlk/9tp098Dnij0NbZuamMaSXh5ZCVZsZFEpsM+cGh8=;
 b=GY6K1kkj+Q6hZ3+Ny+QCKmuvIm4Xh/AdyXUy/7WiXnc7YdbBYW4Juywuj/pnIQ2jx3FMfBkSLs+6xIyWJ+JLXUP5rO0H65UwLnGuzJ1rwuJtPrJzbTkFJQiBJt12gDfzOUC4mWeWd6QZR2Bpd6sZ0trEwqzOT/HQmRHIDN1jJ54=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1325.namprd10.prod.outlook.com (2603:10b6:300:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Wed, 2 Feb
 2022 02:41:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:41:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 01/70] binfmt_elf: Take the mmap lock when walking the VMA
 list
Thread-Topic: [PATCH v5 01/70] binfmt_elf: Take the mmap lock when walking the
 VMA list
Thread-Index: AQHYF95v8rQXPYT4EkqXvxYFLhjgiA==
Date:   Wed, 2 Feb 2022 02:41:53 +0000
Message-ID: <20220202024137.2516438-2-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9e6c10e-9b05-44eb-47da-08d9e5f59284
x-ms-traffictypediagnostic: MWHPR10MB1325:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1325703F9F54C16288AA828CFD279@MWHPR10MB1325.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M0UUCyKQ9hL7fDt8oBNqS0+fHVI4NvIW0YSLbetWTGPXdod9mWO71em3Xym97hbch208iq27r7hGfB2+pqyZCZ8kBlHS53agMQSm8LF6lkHM80svyK0pEKyN/hUGFGE9G5GWFsFa5koRNpHQpoqWHJyun5/D3spPa3AKuHYGi4IBrnyNqS856JdbU88jtlrwjmZXRQCYuPHHAu+/rr+Z6ZQUn4UDPPhdf/O2o07w22p4skxuyNsB87ahi2ogdkeci0Wjmy9PNoJ6b1i39vE8m7kt//E2D9vPLPhnNh0MR0ajVkewW5bJ4GRnVxBvDBlntzXzqm24PndnAUp+HAh2fiY3iUc2B6cGJtEJNnuZlF4upmKJLF+nst0/UvKz/f78fj1SR7VKSj0mFwk6XzA0pd7bPhPmaITKx4By0axBXk69lPpnMDuRYSNo0aOqUtPMfmXqQwGS9ubsnYDzPUpuZFF6QgbrM40np2s3hPIpT0YjFCbJTJ9cb9I/hdEzlh1YXUE79pGMEFKC8Vx2Hby/FxhIm2ZoNpkV5vgjOveQGc4EWs3IKg4nzcwcknF0h3fTrti8OI++ri+95OM5aHK9+dOWVXSU/ERBW0/IyLlsSw9LNAANz5XN2rzNSLPbEpCMiPgkTjnIgmFF7TN0NC3iX+vKwtrFeLt0nJX+aOCx0TvXsvBFb3mHYBuS9vwfWVQEh8TGWXNEiQ1DH/LOgyn6lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(38100700002)(110136005)(86362001)(508600001)(6486002)(6506007)(44832011)(91956017)(66946007)(26005)(38070700005)(2906002)(122000001)(71200400001)(66556008)(186003)(66476007)(66446008)(64756008)(1076003)(8936002)(76116006)(36756003)(316002)(2616005)(8676002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FCIUsQbwO+rI+VM2eQKPEQzZjfh0r/IUkezxvG7xj81AImAeSC/jv8tm34?=
 =?iso-8859-1?Q?+HIO94cuJ/5v3A8QyZjp+qvQjpmsXnmYQKhKZRQS+2JI7Lq3bBCTt8Yzcm?=
 =?iso-8859-1?Q?r9ZqD22zYwWXBwv9OMnKIRdxXFmFqsP7fmqd+dAUr3BN58C+vsoB0We20+?=
 =?iso-8859-1?Q?PM4PRx7udTggK3gMLaseF6yoX7v0SQUwRhiosWdkPEjCp6mqsbxV9Jaw6J?=
 =?iso-8859-1?Q?TWsBGIQ2stFYV7Fh3V8HgXP3Qk5KJ2lg7mqogyXHIgGKfK8c0bfMHqVoSd?=
 =?iso-8859-1?Q?YGc+Wc1Yf8dWPNBRwLb1Q6ecFyTdX/BrNd75ms2N155puALl1YWKHi+/z0?=
 =?iso-8859-1?Q?wFb1dA2v9UMsloQPu5rvkoQ1NfVznnI5letxPAqtkNf39SOpKAR1RzurrL?=
 =?iso-8859-1?Q?4Tu1DBJ2VEmLZz0Pz4WptQTpHCgGF+XC1vlCxjcv5Cgg8LbYECY2sZdtaG?=
 =?iso-8859-1?Q?8WtMPZC26tUKUh6Hb/+c62eBtm+cDiPLoAAnIifR+yPvOYEksvlqF6CMFn?=
 =?iso-8859-1?Q?atA14vfNuURAnITKxxyzicuX51tQOnNPKCw1MpFuPCDBcCz66orb7/IzBS?=
 =?iso-8859-1?Q?HaUVG9r59X/kVurIm7Cpfm/YKt4qDvt3ENVYUy/jrPkwH04L9M6ggLnEr4?=
 =?iso-8859-1?Q?+fL3JoyY14luVReQkYb/m1LYPRB8sFww3Wa9/O1TqiBDfrGuKOyOZ607gV?=
 =?iso-8859-1?Q?naeBuNZObLrXveEKOi32bdTyeqpxMrR11nRkg0yjoUjzrE2EnExovSwCnG?=
 =?iso-8859-1?Q?plmDTsfgyQdtCBqe31YZ4+HLR1IMapWaz3qnORY+GgFd7pHfbbo76mo5Wh?=
 =?iso-8859-1?Q?PJgXYvk3vzE1UPAfBtvJ7ST+qVvh8yTY6IphUArggEXDT4Dbo6CIDIlMyz?=
 =?iso-8859-1?Q?p9I77jSMjHStYnnl3QZr65tm45/sEyKqQ4zepgqp2UU7Nbxru5YFePDEAy?=
 =?iso-8859-1?Q?V65qGQcxqu5chY2ZqJwTs1bRbvIWuqy/0o0pQJTEhpcbDHLp9ZVZIIt2tm?=
 =?iso-8859-1?Q?t1Vldk28ONmtfkMSMcUn74DLqjtF6uZ6TJ/fqgn2/I0Mu3BxNj4t5Orvsg?=
 =?iso-8859-1?Q?Mb0vtnHVIkTR83kP+UaKoVQu7E71YF1jtYnJALaZ6dC1EVXq+wFoeJ6kdc?=
 =?iso-8859-1?Q?eMA6S7zlmZKNaLvgD3lFnjzMdEfZnuZSt67UPaaejWitYs+rQ/VHI5ZwHG?=
 =?iso-8859-1?Q?UPM5cRlh1z0HF0n8Q+Mpug0aaXm3GRzvEqNfmVPXkZ2hUET20oz7GiD441?=
 =?iso-8859-1?Q?067msHBFjuqEDHt5TdGO1QCeLiWY2ZEnKqWy1B+WsB3+y08pROd6s4OKZP?=
 =?iso-8859-1?Q?qn5m2nzxECohi8Rv/K5btwqjF1Y3o6FfcWO8uioC+OEzU+nQfK3TzWZ6Qu?=
 =?iso-8859-1?Q?NMWw24k/EomguKXMMy7izttq+3P6c7D7Tcq5A4QaPEDnI+XYzx+n/OzQ5e?=
 =?iso-8859-1?Q?J5vhFbgUuhzti0qBX4xVOdc/6dv9Dt5hE3HzHcY2JdhHrOCEQSUCPl1LTs?=
 =?iso-8859-1?Q?gKi58lPaKi2wNMEMcpapKtRdezbc4IcBy0WJMAFN3DUyhVeymZ3udeCjs5?=
 =?iso-8859-1?Q?S75p27640iXcFc/urcCMZNmSagCOw8e9qkpil1nDKSU/Hawx4chRe8m8yR?=
 =?iso-8859-1?Q?WPvPMJ/fSvYXraeEIbVAklrOQgMKFcB1zL8DbQtJBDtzPP/WaU0Xt60ank?=
 =?iso-8859-1?Q?QvMzrvYy6xKrqHuX3d4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e6c10e-9b05-44eb-47da-08d9e5f59284
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:41:53.3152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwKe9c6t6szWme/2uGx+FX5jCzPkSM2qT0ssZO6h/S+dmDfnoAm1NteArHNgDJE6A8SfQPRXvqpdat+LamBR0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1325
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: Sk8oIF88f0UftVOrqKl8tRmhUufHHK-s
X-Proofpoint-ORIG-GUID: Sk8oIF88f0UftVOrqKl8tRmhUufHHK-s
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

I'm not sure if the VMA list can change under us, but dump_vma_snapshot()
is very careful to take the mmap_lock in write mode.  We only need to
take it in read mode here as we do not care if the size of the stack
VMA changes underneath us.

If it can be changed underneath us, this is a potential use-after-free
for a multithreaded process which is dumping core.

Fixes: 2aa362c49c31 ("coredump: extend core dump note section to contain fi=
le names of mapped files")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/binfmt_elf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 605017eb9349..dc2318355762 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1651,6 +1651,7 @@ static int fill_files_note(struct memelfnote *note)
 	name_base =3D name_curpos =3D ((char *)data) + names_ofs;
 	remaining =3D size - names_ofs;
 	count =3D 0;
+	mmap_read_lock(mm);
 	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
 		struct file *file;
 		const char *filename;
@@ -1661,6 +1662,7 @@ static int fill_files_note(struct memelfnote *note)
 		filename =3D file_path(file, name_curpos, remaining);
 		if (IS_ERR(filename)) {
 			if (PTR_ERR(filename) =3D=3D -ENAMETOOLONG) {
+				mmap_read_unlock(mm);
 				kvfree(data);
 				size =3D size * 5 / 4;
 				goto alloc;
@@ -1680,6 +1682,7 @@ static int fill_files_note(struct memelfnote *note)
 		*start_end_ofs++ =3D vma->vm_pgoff;
 		count++;
 	}
+	mmap_read_unlock(mm);
=20
 	/* Now we know exact count of files, can store it */
 	data[0] =3D count;
--=20
2.34.1
