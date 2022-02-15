Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998664B6F55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiBOOnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiBOOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB11A10335B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:05 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FD3HbY007107;
        Tue, 15 Feb 2022 14:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7twbJOg3RZ9c//6LGtibNgsCqJ/adUeQ7uuHuaxBTPk=;
 b=egPuw12gh1A3BThk4/GG3nVexZTrGn1H3Ruok0AfciFPDLlCI3zVPDz6tCWnhbbpNc20
 kkG0/Rv/G/+AkXYaMjWbxtY4Z/Y/lbNU0TVkhUpfZ6N9zcCrl0VAmwQp1fsSJSnaxNOM
 07+Un8j4/nkiEceseFVJdODhynVzFweeRpF/VjsVQdcEd2TPFR6D4iTW7340NVj4Oo7T
 YQ4r97sBQyH2XIM8rWtqQPhwHesKj0C7cvOzVIkP9r/hHkgAHgXp+NchcjRdhf2UH/Sk
 mkdoy8bdYEldYwdtmZwM2ZEqUHlh5OFEalXerkk6QthrBfl8d0jZKAAGWJnjIo0adaTn qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:42:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVcW085745;
        Tue, 15 Feb 2022 14:42:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 3e66bnpj23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJB//0mOTcEQM5yd8MWdanDPJMNzga3eT/qQzcWhDENHLI6L3dbmOz9DRsQ/x8qdv3qc1nrC4gLhnPuMkAl87xmwSOwRZ7MjKmPzl/0qXPR8e1ybMJFMF+FJ0uFUHmJs+ZejHVBK1gqpWiDUVnVAuiitLv0422fnI9wPeiytxW4WUum9/JMUkD//ethvizQGHsv50w04qdjGA5Bywsyc/TjCIoWSMPxe8pUGs8sLehFzLFlyrQS1E6rCPSEQpw/BetXgyiArj09vnACvAlXcYZrF0Rgt28d05GPsODI1kvSoU9dhxFGC53jPtXSEG+P7nL6E1WzwBlKUtsd0r7LhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7twbJOg3RZ9c//6LGtibNgsCqJ/adUeQ7uuHuaxBTPk=;
 b=mcw1dVkp0q0S9KIYNJpF5nxFHbHdsQbq5KSuibk7vQANK0eYZEmnUKtmeR21Mi9FnYSF5PcJAe/fm1BpxbW4tJBqa/d91peclDURh8FA5Jq+XWPuGIPmULaNkk5GKw2/VhpzdikIv55IaFFKDV6W/JB9mE4QItiTQwyaGscVN6mw+go1FXKDfgDmlioBtFwi86f0SvwHu/cF96LGYUvAt1nmEYCvd2NFFYhyYlYxFrK5/Kr1gIdRhJ9XY0rbIX3U76Alm2AaE73jyipen+ZDSiHgICOWKIrQwkRlCouv1oSyewkHkM7B6RJqheTUkszGdBF97CEAxlfJwk6EhtLxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7twbJOg3RZ9c//6LGtibNgsCqJ/adUeQ7uuHuaxBTPk=;
 b=if/nM+w8Up6X9gY2cxBthWsHB/PXXMf/FsN73Tdd7YKoajnHKGDhYjD09tOy9qp24iPjurClu59YisyXeYo4ZLVgsxTfXshkrubnLuK+wVqku6nZi9aIK6XXf704qQcPMWhAiFDAuwMpm1aJVX/NhP0llf1e7XBU5WlpAcSMF5E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:42:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:42:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 01/71] binfmt_elf: Take the mmap lock when walking the VMA
 list
Thread-Topic: [PATCH v6 01/71] binfmt_elf: Take the mmap lock when walking the
 VMA list
Thread-Index: AQHYInpRQctdnN4nV0+fc4QEv9tDRA==
Date:   Tue, 15 Feb 2022 14:42:55 +0000
Message-ID: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1d53b62-f76c-4e1c-21d5-08d9f09173fd
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB21979614A0068704B9A66578FD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9S5pvYDUfUEWhuSx+h1qrFnqj4cmoaGngeRzDOrVSq6wAkRvpdQqHDQGSuPvfn/gSt7Ygg9Hxe8eHFOg5uk/pVT1SOl+B3yMYAm4VtDbaPJwe8aDjIs0UNFnNlNHG59lL7EbTDdZWDm2HNylp1pxp06s4LTa3TxygOBYfx9oOfC/AGG/iT5qh+yGLKtkoKnY0vTBWdkFI93x3dXGxJ0/EpeERBwq3HRs8z1YBUZJQtaswMOPRVnvBaRRet+d9HqpiN9GEU7v5QABWxRSOGBCbpF1VHyn9jQGwhgmMoah7IwsB41oxKnzeVJDDpP8FUM5GRyEiAryr0S7Vnxyhk35xbTkORHxgqr9b09b2oLgMJyL7zOlsMBWLCv7UMfP0J6S7gGXws1kpNVSbvH6x1Uo/QqT3eekNSVdazgkpi8Jaasm+vM8INfQw+AkinqlMwrMKmNGXWB+E7zQNTjUUbzTRmEB5npe5Lsn0OIz5Muo0oVp18s/Gjx1HFj/Pvc8W6rM5fNTJXPWvFfVVWrmnwf5EMxMiWnvViXIlFwH8/DLJ4VbJ9V1+T1kUykTVRrk8Hob+Co9/oOFx76KQoXhEt1MFQGhOR37z3CmfriLKOFpmwRppKoeOueNNhkVvhUbaAKdIHR6nGV0fpSGSWIgywktzKqZb6trcArUz8kCB02LEEksan0UEoHnx16KERwG2jxDzVODsymv6JbEU2N+k0SYbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JqBXqRryMah0mz+OJQRBUqnElP7gBi2RNdRNvahb+dmvI531kMsxxNPRRp?=
 =?iso-8859-1?Q?m4rlKeYroPt82EIMlMvZoljbG7D0zE6em9JMY7KolDOO5NAsc3YljFlsgz?=
 =?iso-8859-1?Q?SU9yaTw2guYCX0VC2vkuN5hCa7XKIQbUUah0mbP2GN0I2LyE+tdu4W74fc?=
 =?iso-8859-1?Q?7G2Nt1aFhtlPLVdlKgUNtthMOq20FCCOjXy5+NXX05pvBFlsvD5sAncfjl?=
 =?iso-8859-1?Q?HaMTEDbNt8lMxAtJXqvf8D+7GJFFlSXMqRogG8K1A1qU1ghArLkHsdqCNe?=
 =?iso-8859-1?Q?WEdt6NZqruSQ3EA7D10sXfV1VPCXSwTvZlSNCiUlpL3LhdV/qv883ZeCpq?=
 =?iso-8859-1?Q?7Ri5dmgI6lKHhVXe3a+CIH0BX0xfDZDdOSDLoO6At6P74ai+NWc5yHhAEp?=
 =?iso-8859-1?Q?Zlvpifyk/EaWcGeBWhhj4+rRPW0LyLL7xULTak+koiRuG424cYjklR7y+3?=
 =?iso-8859-1?Q?Wk9nHB/0YxBAfGxbhGIVyclI9uHjkDiQJErS6mTar21qb6WQa77sob3jCs?=
 =?iso-8859-1?Q?cW47nyfqiiUdX+i9jEe4UHhc96mKPwcZYjbdKhwcNwBO4052VGqB3Wk7y1?=
 =?iso-8859-1?Q?qnRyAt98awxKK4iFRIWs2LKcEKZOHLiKe5g8njl3twcxOumY4ssWd16t0D?=
 =?iso-8859-1?Q?aqraDws9PXkHX5Wfqt2ulBmcI86fBHmPpSiSpOm20WZrQuswQ2qGej7awB?=
 =?iso-8859-1?Q?u0qYjLBYT0CP7B/lND8Uw1kxU7zbY4YY3FOa86zpjL0QksyV3K0psRh8a0?=
 =?iso-8859-1?Q?MJbckPbcXx2MfhEy4iLe+w5PqVfjnz8/HU+5swEBmqhLEET5r0oQJlJJQV?=
 =?iso-8859-1?Q?6NVPN0rOJmUHIFesGAihsMu1MUucQwDEYhjVjCXSUMnLwx9z/dNXHT9wzi?=
 =?iso-8859-1?Q?1N47ZG8T59PA7zAjR4PWKwQCKMMQaKIIrAvAMC0SmKdFvacy+sneqng/bo?=
 =?iso-8859-1?Q?CeviNJBK21DBMG08cxUP5QOq6DDpb6CbLle3ErJ1VsEwdcn7D3rEocWHpt?=
 =?iso-8859-1?Q?YU6qWWBR8k012WBgo6X4Cq+L4t/4jnWOLP2/iOhvssl6kJTe75dbM5KWDC?=
 =?iso-8859-1?Q?CsKDTdatV7kWTZcCm4HeBUeytdX9QFPRBa3okOoZ9D9RKnrq5qLvUmOIMj?=
 =?iso-8859-1?Q?0ttczaOiqWKfJe70o+iWiMClXsPKO+YbAeD8irNYgqTzpwETql/h96qacz?=
 =?iso-8859-1?Q?cONfgUE9epkNY/ornUl3hMamgpp/q7ABb4Dsdbq8zQhvrkDRbNLK0zass4?=
 =?iso-8859-1?Q?ONwV3SBYTwLTetFMmsBNtkCVYOc7mAgomoIfONOfbY9LzaosssYb10esNG?=
 =?iso-8859-1?Q?Pf0FW4lL4Kv5Qy3qez7jWUcJ1s77JVQu1haS4MV9SSQSyUjU/Jn+7IlFZK?=
 =?iso-8859-1?Q?3ErqWQ3QE8rrsEkGg+VuAjEGvZyhwdRMr8BGr6r1SG/bZnR8K7TfF+of6W?=
 =?iso-8859-1?Q?dwEWLjfpT3tFZLxxD8VmEm/NNGXwsTjwS9FW6/+PzyBB4US+s4ke+3dNvE?=
 =?iso-8859-1?Q?UntJspz4RspcxUkDH/hq4T7KsjcxQmBEIuH3E6WuWzHwnO8JT7iquqLYWa?=
 =?iso-8859-1?Q?HbheTHeNhHi6K6ZcRnijZb6fiopwYFOlTMXqnzSClXmSqU+gCsLwxuM38G?=
 =?iso-8859-1?Q?ZJcqVRMVd9A64z/7m1/0c6OsmPNJWvgG7XYR7YDjQJwOPdVudCGqPfuD/I?=
 =?iso-8859-1?Q?cxZQGmjCu4md1RulWh8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d53b62-f76c-4e1c-21d5-08d9f09173fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:42:55.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Csme6jn2p2V6cBDpPDZ/ACQt98U4SOz0qc5TNzSW/7gk+8BNBlxhUOv5JvVaacuDkbgkaPBL+eIQ5zeKkORv3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: Z9AeMRfOYHfGrpC8M901K5tngjbb86Fj
X-Proofpoint-ORIG-GUID: Z9AeMRfOYHfGrpC8M901K5tngjbb86Fj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 9e11e6f13e83..f15efed29d3d 100644
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
