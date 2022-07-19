Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A126157A6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiGSSuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiGSSuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:50:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2226558D9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:50:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGmRWH003839;
        Tue, 19 Jul 2022 18:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=s44mhi9ElD7kP81uf7o/R1Ze5xPW6rR75jn8fuo/HzA=;
 b=qKEoOy9FLbzQ5Eu6XiR29t5dfpl1g0arNUA/QjHRHRvYiCsSSweoiXwQLKF4Q0sGPQyx
 CmatjGam7HlGwaPykWMdvl1hIN3FSgKGX8vceXgSahK03EMXNX2iyc+Iq2vAUJDSb4em
 ZCGDDRESvNe10ASKpLbm8HgAYtDKdA+ztZ2ev/hAghqln0QLvzb8g1Owm4QSFdNSHUyq
 ripAfjVFK4T7XcAsrHwDrxgUOKQJUedM73LwXeWe1BiiMWIZXJw06GNY+PkpWM1t+mJv
 YqVl1CiZZggrTGoRzr51ujHs7VuKM+U2MxdvHoYf6BPxrsfMqGBR2zjWJAxsrZsQbsC1 ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs7cqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 18:49:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JHbgxj002810;
        Tue, 19 Jul 2022 18:49:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbdeuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 18:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agBuPXZIhEewUb56B/VJ6CBWkaOM/1id910AC7QstFycv67A7WYAWsCPYTYdNLh6If8PVwoLuKysxkIn1Do4rzzH0n8IdcZL5F66tLs873LIzHGzG5Q3eq0CkZpVuMRdftknmqG+u3Fw26Ej8uVJq1QSbfA2izqGe66G15HgUwqD4u3KnmBhaSZOnFI777Et96oLYBLnYQTNCOAEednjLdBoIesfaLHxusZtpFK40GYYEZCpNtKZ2rrly/sb2rW79IXRjRht83mN+4kMz2hGALcqQeU1UjKhKKwzpS/9QudSB6L8mqXhKeiQHVfIZaOt8oDVm+wlcyT0EBBoyePEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s44mhi9ElD7kP81uf7o/R1Ze5xPW6rR75jn8fuo/HzA=;
 b=TjUxM5SvrMlfdrjGk5IEc0O0BeVUIPHg4Jjra2po+1Kvt3oiEIh74hh5KuhA64PmMmh37IVheF5HH4Akuyk+Pa5tGBFerhePqhCMS6KGXFk/WUDFDQnUH+VSEC8YWTg3ktGx16+VqUlm57qyKTH/MPO4bN9nE8dMg/lhvtT2mCf4JUXBUf0n9JUMyGzzF0gYG/rNqd55QH85XVA6mk07f1DeWoajZ/Gso0d/QG0THddtphzeb0EBiVfq+jh9HWqsnMydI0rktUkmOFRYDVLs8uiKrApmamj2cCKQg2mwWe6waWu8HL8limV94pwV9K94BGWvZ7G77Z0gSTeTy2c3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s44mhi9ElD7kP81uf7o/R1Ze5xPW6rR75jn8fuo/HzA=;
 b=uQKPTUGazoPy3saG0/Au1IBNCaqSzWnCOJ3RvA8t8bI4jAntLloNYsZ58j2EF/q0Z/FIROGVuSuta1Qo/622C/CsZuopB+OG7NzQyI4UOIwp67dB9lAPxyllf9q6N/+H/iH/GkRcy6WJq73jkWBzD4xbO4ZIxEW64AJ5zWVHEH8=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MN2PR10MB3326.namprd10.prod.outlook.com (2603:10b6:208:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 18:49:48 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 18:49:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mmap: Remove unroll from __vma_adjust()
Thread-Topic: [PATCH] mmap: Remove unroll from __vma_adjust()
Thread-Index: AQHYm6BSNtHaa9jtVUOx80QQwk87NQ==
Date:   Tue, 19 Jul 2022 18:49:48 +0000
Message-ID: <20220719184938.3359932-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1499a49a-4622-4096-b937-08da69b774cc
x-ms-traffictypediagnostic: MN2PR10MB3326:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0bpGzL2xDS9BYcqwFj4LrKlUymlh5p+BLMVm0WJmogYMPHdhGQgBxirlA7iwpojjN1RPPdWxTLGQCdWcXinDV4g1efv22tPcEHmbKI9z1JLeo4AxzCfXez0QOX+b/Bi71/E+5Wj8MTw+NiL9nGR4c4Pne3uCucnLU/1ysWVVm1Gl61S0b91vczmOpPZxrZCu47f8BdvijkvTtFJh6ypCPSU9XoWueINS4DYFyPWVixNT/Pa+GLGYnK3Ary0XpNh17Gq4PFKNxtMXYxEuiK0Uj+3J9P8Ajfnypg1I4CvAqOvbe3clCCt02gFEqj0sAhh+QaM2KPrwCYoxjSrJrpRnJZERwZldGRHXDLPi6oJsRXgWTe0Vcesyd+s3/LDSHoxtMaKKxsdOVBPPzWTaHUY/mLV9KpRPWGFOv9KZx2Nx8TKoWWVxWHVrwlC+dl/zQsnZPhCZk+hDSqCqqM2pJk43itWWN/OQRwF84P1E10WqQnUFU1nXtzb7hd9lNe36AeseDBQzisgTGaMHREccwbkiGSyHuzBt1PJiRR2AY2EgJ4wuTpnn6DVgdeXMLPf9sW5VzinwRGXxkCqIBcHSEMLqS+242NA5nI5wB6cchOeGW4t8tYrR9kimNvckzV+BLPAxAsZvANvV0EEwiO0Jl9vQ1VFniXLS3wsZCuaL+2di739CjCWVZ1iqL9/gxPe7RiAd+HYTRZtJIdV3OirvXp8Oxt0CqWoZZomqIRnx4PC2ow2JqJKwnTdPIADvOLDO774FDpN8RXv4Bp2VZvR2dYb1FIw7b/JeUIZgXYlzq5WkcA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(122000001)(66476007)(8676002)(316002)(76116006)(110136005)(66946007)(66556008)(38100700002)(91956017)(4326008)(64756008)(66446008)(71200400001)(4744005)(41300700001)(186003)(6486002)(2906002)(6512007)(478600001)(83380400001)(38070700005)(5660300002)(2616005)(36756003)(8936002)(26005)(86362001)(1076003)(44832011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vdmvg1eymFfJyi/buJPYORQ9N130kg0DQ6VB7b7va3iNhMXc50AFbmdTjk?=
 =?iso-8859-1?Q?OHUh64pqDbqdQygnTjObLKCe7r/cc0bRMdWOpEwQuw18YZJEQDYQJxuQ3F?=
 =?iso-8859-1?Q?/G9R6vm8CSgYTfT7SuDA5iOipMXQfdeGAhWZtXLj8vhV5rNBDeN6Ig3ZPW?=
 =?iso-8859-1?Q?SeKlc5+fN4VGbM2k0sxHnGjTm8+tFHCuL7diFTQM4DsyJBXggD2dN9mYxl?=
 =?iso-8859-1?Q?EMvnL0laPWS5bgOFbEL6DCHiyAgnb/rKXV1Lvn87IHegeX3aFyvERvKA8O?=
 =?iso-8859-1?Q?KXbepXkagbeWZvoElDXscl+SRTLa+6WUxzj9xIi/6EIfn3Ym7Fiw5+2NPa?=
 =?iso-8859-1?Q?bt2iSkaW7pcz02yJuLsb6P2LeOKo5j+Nt08U6Eqbz8oBmxAh2+e3PHa8nb?=
 =?iso-8859-1?Q?q9yM0j3IsO/kvp8aQa4o6PNCLP3u82pTk8YXOvzL4i68g2cj1ttn/6oVzV?=
 =?iso-8859-1?Q?jTdmwIluph8hlfIAIo2E2SmfkE2KSCeyyju0RlXSggGkdNQjG3/ebM4Bww?=
 =?iso-8859-1?Q?vG8shzzEbt2EbZan93cNigAmS0f4+wcSvFU0OldwLaainc1/C4BCUxJqY6?=
 =?iso-8859-1?Q?OoFBCSkByGAC2QNsKVgCdQnm7Fjy+O2koUmaP5EyA9Ld1Aw/7HklpYGyy8?=
 =?iso-8859-1?Q?hZuumjyq/xIV+3bJ9h+nUU5gQEDLEF9BmBjfl+fG+IuQL2h5DI4EI6sDiL?=
 =?iso-8859-1?Q?HrJ+Cy58GgvO8PTS/rV4q8vHvTTxfJlTa4TPiL5JJ8zBsyz1jkLQnMWIvD?=
 =?iso-8859-1?Q?i0QYRwIB0TVNSjusGkn6tXvECL7sky6MM0re34l0pjQAljKb/RyGVKOlFB?=
 =?iso-8859-1?Q?4nIxLQRTt6edjAy5N+8om5fKd4tAfcbdNEsKFW5LUZfho55e+RaQPCSYVY?=
 =?iso-8859-1?Q?ziucuY/M96dx1BldesulvCklGb5szjj3uXnk5Z2R2Lzbj83CsCUSANoX50?=
 =?iso-8859-1?Q?BCrvy7pptNXqXi/gv1lr60thm6ZKFLrksjDKxnKGNSY8im2oElh1W0sgE5?=
 =?iso-8859-1?Q?T/EUeMxAotF9WRwqDaDx5NFGFipVwcbdIwB6zsAgVTosx7xtTCsUftXbAa?=
 =?iso-8859-1?Q?avkXBzt5tjKf1s6ALg1HH+6K/OYTL9heBjX8YPiNickg7taTVTHUfKYCWf?=
 =?iso-8859-1?Q?KPLMGMbNwiw32v0A9+MRtoEg51Bve5wmyOVAaZheTQXT5P6zgUj0bWcygv?=
 =?iso-8859-1?Q?BNjZN4siXoBAIiUnIz1ZEEH2Sd3OFXO1acYgWJIveSIfyVhhWFYA1iwzV4?=
 =?iso-8859-1?Q?lp+v390SCkCgxpy8mw7MLS+HiTE1Rlcor4xwGCKR6OCrEyiLu/2goAyFPO?=
 =?iso-8859-1?Q?o6G9a6IwtfZzsQj+yGfkw81lf8KkDoWFTzkcLJn0u38OkiRKc057u6jHl8?=
 =?iso-8859-1?Q?nmmsVaLEoY8auj4KYVt98WWXOIMTr/nRRFa+M+zhU27gfAZi8SX6Pjm+p4?=
 =?iso-8859-1?Q?uVTeZLqnx86CFsHsBgO8nuH5Ulpc8/thPUhA6Q/1hW6OVrz8gbQ0+pMfPe?=
 =?iso-8859-1?Q?z8m+GxvwrfGMeTzDqDjkgr8zUwxxpMcpO23byMNi/0SFQmWWaRqIddwQEL?=
 =?iso-8859-1?Q?UTPzUeCtZik7IBfVfrmGK8lgFUHjgiARqmQNK2miIf/KYsKjvwOgQOFPXO?=
 =?iso-8859-1?Q?9s06xA2iPQg9t1iEKcjSWpo5GCMVufsz7fHrDjjw95GxBBrhllNkEGVg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1499a49a-4622-4096-b937-08da69b774cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 18:49:48.5383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nL6iWKQZrQDpXhsEnH+r9BDjX6B5A4ZnN26Jb1J4FwGqJmu6ePsxWcm5/eq9XDpuyAGYOngelikH1Vd5UoVu+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_06,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190079
X-Proofpoint-GUID: pFLj_gjvhAWsoeKNG3QW48vrPnOCDK9u
X-Proofpoint-ORIG-GUID: pFLj_gjvhAWsoeKNG3QW48vrPnOCDK9u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If __vma_adjust() fails, then there is no reason to undo the anon vma
work since it will be done in the caller or we have been OOMed.

Fixes: 83651ef5048d (mm: start tracking VMAs with maple tree)
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index eed9e9d96e22..87e9e78b03c8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -970,12 +970,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		}
 	}
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
-
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
-		if (exporter && exporter->anon_vma)
-			unlink_anon_vmas(importer);
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
-	}
=20
 	if (file) {
 		mapping =3D file->f_mapping;
--=20
2.35.1
