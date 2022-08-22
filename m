Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BBE59C238
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiHVPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiHVPEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:04:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB7A3B942
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:04:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEircK017906;
        Mon, 22 Aug 2022 15:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=zHpcc9MNaz123cKeXTnW0kR6S1OJM8YF/NwC10bAy1G4tPXLpzy+7MhlYcElaLHoKFCq
 uXHTfaZXDmcq+L7yqzVsV46EzPDpu2vdpvmB61hat9Ei1VSW5qAYSDGpwpyaZ8xrtE+z
 P3D7ffFNK4pe99YlUCFlkGjVp3OQJLiNhx/40HZjOngu+f70bkQxiPSbigbvXbkYtlxP
 bwuoqvUOoctFzmsjW9fsVwFfr9iw1O4xz2/HmyCGgliAXtRcJ6xTjm3YVs8ngbl4aajq
 gh/47JVZMUy0+z1MbV44r75Uus5mKtIVTDo2sr/EQRZJRa6+D6+kvxIbeL+TQW35uYY+ oA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt03y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:04:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NYe031854;
        Mon, 22 Aug 2022 15:04:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd366k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVFek01k2vzQk+Pg8KIhpuwmkDMP+JUIlYMF6hwEcLIAi0uMpW6pWPuJZTRQS0NRUUMM63/AGt1I0zldunOchI1KLnSKdztaWM7qgFrJLWpgbAuLB9eXApaX8s/8BZOF62u0rPIzoRSA8gwd584AHk/DgswKTRCMhu5sRP/dphJJOvbCn/kcoOkslKftJ/UYwnwyLqR7OJJhNY9zQArlibcuVUeK2jNTCMCckUAmDCBUg35nU2rxPd/9K4VtXmgfT4SsskM0J59x9doqqqApfRVc/0iRktSkUrovMPf9b6uWYlc8MvvnWax8JDLC7Eyq7Zspa3XdnK8bmxsqNgPL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=CYxoRjhO3Lbo5BCC54M0uIfXVhMSdQ8Z2GUh6etJFOxhizFAT96j/oSEfMs0j3hZtVh8sKgIL1Oy2ZcAxSwD3OxeVawnP6qMfG95dPV/47NsgVAPX5Jn0zCbMEjxH5GjQw3velNnzh/WIqqpR1Kn6w4tMRtd6IrTOLh7ZkDkNN2MQd15tCdr2RepPTYNN+xDKTKeQKDfDpb7wjiX2jTMhOJ7Mj0xEwaCw2gkQrDLnfwj8PSXXomi6tFBHeU5RQhG25iKg2BvJgFhT03aXDHeWQtkqYp7gnyeSC2HL3iLgOqDYUPUAr+pug+eYYwwUbz5pYG3YC6aFXiKjiiyXnhL/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=U5PT7q3GQ/CNl9QEZdJlrJsEqotZm9yLyHSVm6afxLOW4o/sxd60KCUHw2q95xn8DNdZTJKrMWTg1CpLVZpcOa/KezSK6wDakhnajzC4k+QVDUE4v4/Z1LOxF7H5B+7jb8MuW8x8atOU3ucCaL9C2qZm4MirCMpPRyav5lJv9hk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5418.namprd10.prod.outlook.com (2603:10b6:510:e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 15:04:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:04:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 19/70] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v13 19/70] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHYtjh6zC224z6azESjqsRKkjMvyA==
Date:   Mon, 22 Aug 2022 15:04:30 +0000
Message-ID: <20220822150128.1562046-20-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5383b63a-32e0-4299-6be0-08da844f9d5c
x-ms-traffictypediagnostic: PH0PR10MB5418:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xCjqZUNBcD4WbLclzG0JtaAbapvF8gq8hizSDvt+pgUJYQgMTtrUvmwCMnlsaL7Db+6kFa7NP8w+9aWNBrnPkLsTGcKWK4h/BBKyl0LOoWBXIrKuxxmKujuNQcGpNclK99q2DNYcRsIp2hchjTisZvNL+6akA1+wrE2wQdHLrUAf42LhbX3Cw1r13lbu3KPrBq2l4hwEGH8dkivNIkoFTr5a2KdH5MX6dCta3/1nyr8VRnDlHulhZsD1x6SSdz3isKHNk3kiuOZm1ardfGQksJro29R54nUx83g231TOc2a+JPQE3Cw1ksThMtADbkfupH0fNS7UgGbzLbY9M1pCDCuZhhBApkkvst+fO7AKh9yC1kFbKfYisNUUWNW3lChBNv+F4ndljucTUD/stfqbjoGj6jIkdmUE86bqDtcQV0Lu6bUVl9bcitvhSNu1oE2OmOl4TuOzXgGDc5jnTUNlB5W7wCfKf51yg2lmo1z+Za6Ng1GGVFmhb4XWLhZKe/hVrgW8qcC/v/Pn7FRezGPg3MAI5GtbDhX0FTsF+Ab3i7M2RBpa4c31Nux/2rPlsko9Tj7gAPoDOgiZdK2Fr/xZ2tK+Kx4XE/gGw3aKBQeoODoGC0+fWmHLrKQ3JRK5X0j7AMYmJaUjP8anOeFwfsLb+qaDdo/EMfL4T/Rfa8ZTDRdT37d1TR+0DWeqsx1tW09oKidM4IXXHVZP2Ar8S9fqfUH6LS2synp0WOWnoZH8pyGM5BNwS7T1Ahwq2LzD7GQGM3n/iwk1kWwvT/ydwbTjtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(136003)(346002)(366004)(83380400001)(6506007)(6512007)(2616005)(26005)(2906002)(1076003)(186003)(38070700005)(86362001)(8676002)(38100700002)(122000001)(6486002)(4744005)(76116006)(66946007)(41300700001)(44832011)(5660300002)(316002)(478600001)(36756003)(54906003)(110136005)(64756008)(66476007)(66556008)(66446008)(8936002)(4326008)(71200400001)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DlPRiFDqqwRxa/qZrjaWYLWazWAfGrTuscdkrBaWp8oTV/9TvhGl1IJKyF?=
 =?iso-8859-1?Q?y9YRDSM3/C6TPGZs2rzz/6gssxcqYtqm78dQMu2+YiviJvudFti0deZPjo?=
 =?iso-8859-1?Q?O+tg/XNA3PgIB8MV9aaOREr2+cfCXKHTMTGzpwgjPL2JSBS5K7SsRgiuuF?=
 =?iso-8859-1?Q?6+o+AZX3v+0oJiz6EGstch/neg18zU0aYpUtEYK6bJkW9jweq9aWWGNCe7?=
 =?iso-8859-1?Q?ZKGEf5csmuEeiBVXdtvDHpJeE63LgmtqfG/pRAWFxigAs1hJaSCqAlpN8W?=
 =?iso-8859-1?Q?13rPj+OJh07mkyMOhJxoKjbQ0WUWLDVNy8O2hcruZ8FeDhkPBgqkr5y1VX?=
 =?iso-8859-1?Q?t9kCYV+KDM4Y8h0z7OXEAyztoctBRZ0aiwDsFX3je/C2UUZkXnBI9OLXfU?=
 =?iso-8859-1?Q?D2qUn4HWOyvRHNNpzYuUeMMfufwivpkPP7T8rJeB4+mam1d237jEzQ5odd?=
 =?iso-8859-1?Q?zaCsTrdCN2aWHGusRt/HQgyALWZC0Ut/9KWzvQsPfLhubKG0HZFTcj8WqQ?=
 =?iso-8859-1?Q?Ty7Wpxc/qO3DYdPj4MnMQJDgPh82p4q1L5P/mE+57v4UtN91jjtRbbILQO?=
 =?iso-8859-1?Q?T7IKpegcI2RlQixKGxiu6CPPs4MHtWeLclIXtg/C0/nUfW7XYtjTiuSyrC?=
 =?iso-8859-1?Q?C7VplE3M1a0OMbR530u59UZO8RudWAq5deBmk6tIHAATFD8t67tCypJESn?=
 =?iso-8859-1?Q?ROnlhvYmvkZtQaSw7GDvQ2eO5GA4iYcUhiUOaVqUnv+UDsioghQdmU16CW?=
 =?iso-8859-1?Q?h7DLuWZ0c7WLURdBxw6REhGQVBvga35e0+5DVfaFT1HIGfYPrGh7r5I+l9?=
 =?iso-8859-1?Q?egIls29UfsuLGpoade7y3d31CaXLeEAYUUFAvcwxR5hxEmYKecEgoJzoZ8?=
 =?iso-8859-1?Q?MYHPBIZp3C+V1VU2ks+uFlpTcA9xiweZ6gBf7lj6aa/i68yJo7AzRnKgUO?=
 =?iso-8859-1?Q?w/wP16nzBjQaObfw7vE++DE5mIJwDIw7m4cocLGkSIuUfnQFDUIWCC0zun?=
 =?iso-8859-1?Q?/nIQF8UbFg1Offm5JgHX1jc5XvJYBS+/H0Zc/7E4j5Da3MekLelwV7AKDQ?=
 =?iso-8859-1?Q?5Qtxxy+O2CHWJr3TCllmKgGK06GnI55xVCpMont1yzl3mK31rD0rWJqSdH?=
 =?iso-8859-1?Q?aerSBtXQJL9RRyeFIkNI/OM1msO6ytMq1nekFi7K3cRRA87nJ+4BqE2ozu?=
 =?iso-8859-1?Q?UEfesRZ2hWEdnDne0xOja5n3tchoCdrZZDgPbsNi0xg8I88PhfVM1bEHXX?=
 =?iso-8859-1?Q?b3oNWwWGB3UrRVtplIXQOKB7g7GpA8kjj/kN0+Omg2UiO/TAMm4owIRsUf?=
 =?iso-8859-1?Q?BOHcxpsc6Z+A1I4XvaHiJtEcqAtlgC7O50cKq14b8DofjuM623lFa8zr84?=
 =?iso-8859-1?Q?WKxRUXyHfxp1vd98VcpbRcMCZhuKY7lIEMt5i5py4a6GnvRiLcroeunzZB?=
 =?iso-8859-1?Q?9HiSMHOrPDkCqUDddJeYSb/pOAOohg5rtz987jTWiIVACphn6YcLGPeREs?=
 =?iso-8859-1?Q?aY8Fiwfu2W7Ht6JZU1jCLIBk+keI2xs524jtPQiWDtQ4TxrWWsNvZyEQv7?=
 =?iso-8859-1?Q?hG/jsiqgDJDcQFRx7oVx74eCLG7t16JEo7PiG93fBDCZmQ/Yx1gvRczAst?=
 =?iso-8859-1?Q?AUgWWSvRJhtdecg4qPLgH5xFXdFBkhLbLcR132S6tugbCsMrBkywQjOQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5383b63a-32e0-4299-6be0-08da844f9d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:04:30.3084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4KiNCAcU/B4xzpC7fq7XlB9z7zyd4DVpsk47zdergZoWtP6po/dOAnyA+i39SEGcfL+TK0ZxR0flIPFDii80Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=997 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: 24590r8ozxF19o6GfrZSIvq5d-sRAFct
X-Proofpoint-GUID: 24590r8ozxF19o6GfrZSIvq5d-sRAFct
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value since privcmd_ioctl_mmap() will exit
the loop if vm_start !=3D msg->va.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 3369734108af..ad17166b0ef6 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.35.1
