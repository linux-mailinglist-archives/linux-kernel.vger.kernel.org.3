Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A25825C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiG0LlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiG0LlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:41:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892D42AFA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:41:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RADNWg010349;
        Wed, 27 Jul 2022 11:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AnejqQzOQuO7N9upFbbHF69NE/UIoiM6yH8btHL2flE=;
 b=AvhA3tWgsUHi6XMLyZdK1CRjtNJZeCfEoCEof8GzuphV4XZr/Sx0sR6Qto/RnNnVSUHp
 iHkHEAYD4O5ZJ0L+FWOrfJh8M9Lb3HpwOLC6BB1oj3c84bJzDizphihmjYvbmvSGAEAR
 SctotKyZEdqkELRfaG49iddJSbI72tyKRO10zzzlG+vKsId+xyMkjNlMfb/njPsPbPwi
 qrEWApxkJOh2T/tjqp5EfTdIHpOmQ4spGynl7j21rxE1qB1VKSRHXdIKBAtXT3JJbp55
 9FOG/93yFrJT/rqLaxt8ectW7oEpl5dFg5zU/fCj4n23L8vuxwxAiVtOZFf2motkauHq tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9ha9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 11:40:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26R9eitZ020003;
        Wed, 27 Jul 2022 11:40:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh6393xx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 11:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRQP4bjyNa3rarxYU+60HC3EDKTblr44G572DanlXQkavWgXurPxm8y6z0jPRzvYOra5eIJShVxS+8Vty51+dEjI+Cl2sg4i29JkTRI/3zh1Id3pRC+1pPsIzwESXavFfOUFhFzBJspriZcuO3fUqbw3ewQafcf99ggeWdOWvjPR4t/7Lg8p1IAZCbYDAOpNIwABUezHNWq5MVLW/Fsrg0uUCtaDYrcHGo+UFdD/fr8SfRPndRIyCQaheJgymtZ3C1hBkkP+3aM3psrzeLi+Z6RW59+gSHhXJ1LBZd1c+MhCR9bKrOucY6fetwk9HcvCIxer/ad1NM34K1EaIJkdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnejqQzOQuO7N9upFbbHF69NE/UIoiM6yH8btHL2flE=;
 b=WBsrSkOO+cAv2frA8SWo5BSRsjUpdjgKImHIolaMZQvG8xZB7n5HZTy++hJmSHNLCCu4ioEwwPOwd2eLF0H2vPavPa527ZCMzTcjPPoSATEqCWwoxYLsZ1IQoYogvrg8cH6Nko9UxMCQzSo+COTLe/GHbKQqXzenGUvkHBHPmVTxSEYAjZ4NQCX1Zf+BEnL8RYZhOA+U/0m7p3OxOsEC9RI7OthA03oIS3XATLTTILMqlgnZrasB+GnHndX0mMWhTNT9wk8KBI3lIuOmdqZUpahk9zuyIlsGCaaN384opq7viShDkJ8yIhPpzhLxAuruKeY7DNB5w2YiJRJKjZzbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnejqQzOQuO7N9upFbbHF69NE/UIoiM6yH8btHL2flE=;
 b=DMmgQzEg77HUUcNKEuJKPeDW8TBuqeJ8yyN8XfKb9Qwjy7B2IfbKpKm63kR2X3AFK9PWZLThON3Z8An8iIr8VnpdSli9BR/wNVCxmkkSv/it+n7+NWfQMmFLLufcbr7tArGRk4tp3S6IXhjh3YzP/2++Cixxf4xv3BhzQsWso0o=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by MN0PR10MB5935.namprd10.prod.outlook.com (2603:10b6:208:3cd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Wed, 27 Jul
 2022 11:40:38 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf%3]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 11:40:38 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Yongqiang Liu <liuyongqiang13@huawei.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm/folio-compact: fix potential NULL pointer in
 pagecache_get_page
Thread-Topic: [PATCH] mm/folio-compact: fix potential NULL pointer in
 pagecache_get_page
Thread-Index: AQHYoa2x/5ssiZt4Vk+oe4Am08PSlw==
Date:   Wed, 27 Jul 2022 11:40:38 +0000
Message-ID: <B92F20D6-595A-4B7F-95CA-7C681C2AF79D@oracle.com>
References: <20220727064621.534528-1-liuyongqiang13@huawei.com>
In-Reply-To: <20220727064621.534528-1-liuyongqiang13@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3726.0.9.1.22)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2e13f6e-9f88-48a3-6c6a-08da6fc4d3ff
x-ms-traffictypediagnostic: MN0PR10MB5935:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YjKYNO8p5hxV5TxeEImxDHTKDJp5y9/JS+WUfrA1sfrYdUqxDbK+mcshl7G2VA1xOyRrCnFTye5+ykIjPSZ46OqT4gIhySzGaCED6UsFKOZWpdZPVXRTYXCJxDbyfqUuDCIKXM9gPcCuEXsA2kl0DIKR9JUa1yFBz4gZAzs9DSxyKBihyui8NsLfUBGtRr2PYqF/VZ811vpe44oY6FtmW5uWV9iNzPGXPU4OeMVk+VNuCYgAuxv1XO0Kj/pjw4vzZ1SOpSVvVwN+vLAP/a4GCVkqfruco+sVDAeTacqXZjIKaV+mHb+F4yMaA7Tt2d4Eqxgt2KuezG6BkUzX3h1nfrvU9ky1oOQUZ53SOAduBp7GyPF6ibii/kNAsNAmDZG8Z8+Oj+/70q/i0lWYu7d+3aWu4rKIAdfJXqUanrAh/onOv8SioHDheNZr/y8zXcjhCFH1APbIa2PQ9aZr4D94WnnUeakNQJbz4ykD1dIMJIvdiXrJRRqd52WMnh/Pu2/zfrCm9A4lupQaWbSMwI4IUsjyv8fQzF/n+O8mtL8lPNN9wm2LCg8TKUx64DU36uwtujaGDhXOMHkeONRyVV1mqNtf6M7yACYJoR+0p4XXJZBGCYsCf9RwvqwCrGW2iyAdc/41WBW3ARz2cKvtF6Le+kF5yDbNUspuX/FqDcetctlhMg94+uc2iIhAr3iuWaGVg6EUXFZ844JulPSGbcC4zKqEyY7Kpu0UJ+V7CXg7p3fpy+hJZkcvITSs7ob26ohuS9mddbX6VeHvkbAH9LttQvnaPYyC/cq6v1jnJyaK8eTL3el8cYDTRs6YT9rWxb4u5NBTjdAbjGFVcFX2e3EW8p36iNswUvQwq2ziM4c4SDo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(39860400002)(136003)(376002)(66946007)(4326008)(91956017)(76116006)(8676002)(64756008)(5660300002)(66446008)(316002)(2616005)(8936002)(122000001)(66476007)(44832011)(2906002)(66556008)(7416002)(38100700002)(53546011)(478600001)(36756003)(33656002)(966005)(6486002)(54906003)(6916009)(86362001)(6512007)(38070700005)(186003)(83380400001)(71200400001)(6506007)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BNU2cwr0dMW1hV2+JB/OxjReH5uOWHtYN/jtDcpQj7MO27JUymGNIn+uN7+W?=
 =?us-ascii?Q?926OI+SPM92FoyaaAZTqDAjNbozsU1AlYo1YrYkP04QKm6jttMp2PzbUfCi6?=
 =?us-ascii?Q?AObn9mgNYyolKFBKhMAR9l3k+JVguWMXYkmHzuSD4jzlLSic93zO4Agbgp90?=
 =?us-ascii?Q?thUOS2mFn9h75tIP+8/ekALSlPrf704Kqqm3WcIajwAz/dv8UTPmxYYEOmXu?=
 =?us-ascii?Q?W/VBK5HyPF93I7IwcrR0ZoZ8kI8AiK6HQ31cGmysha8USHJMlUcM3JM7O7Zd?=
 =?us-ascii?Q?BsI6RUbjxp0q42bJwbPohtfhQRZgYQniit32OWElkpmrshRCP65IOY6Is9bx?=
 =?us-ascii?Q?YGd8oz0FqFPIpzqjNvE1tRuooiinPPaYtjAvl4OSGkVXPU/TBJYD7Q9JjSeb?=
 =?us-ascii?Q?aw/L4JjO/bwiZru70vdNWJoXr+J10nejjQNoT/3QttWzf6J4Qg60dm+MMm14?=
 =?us-ascii?Q?pUWYyLkbXy7O5qIm2Bz7arpgvDm2S+IUTiEvWYIjT5glB1eAwGwUtlUuGF4T?=
 =?us-ascii?Q?1Po+iW+8V/kNFF1VQzXcO4KFR9zMgcgu+YiPKIze7lkXjlpQLBRA/MUTem8D?=
 =?us-ascii?Q?YE5zEO5sK4gZ2o0t2LPfFcUHGexYjAe+Lsd9Cxj/5pmUy22lYrvstthgGHQv?=
 =?us-ascii?Q?eHzci4wkC9PFz6LFICowsujVpwcJY0+rzocJq9eeTIFOUbm/ZCRYL42oj0p7?=
 =?us-ascii?Q?yaXac1PUolQB3XAc8f7v7TFOGSHzcUQiqLTPg8Zq+h0Mbjf+70sFDIOflL2m?=
 =?us-ascii?Q?FXIPftMb4ahLMuEaAWnMSsmZ842HnEAhJi5znr+iYha1fEe5pUwZ2BSCwvT7?=
 =?us-ascii?Q?ETp3hJHAKSofbna4UR4dtuvR3vT9EaRzWV7qCpMEN12WZQtKM6i/79eyM/1Q?=
 =?us-ascii?Q?JB9JWA/0ibanMSXDL9gcvat+TC9CI5H0bFLcNm9D9ShsAeNtuF2Cj8sOXOaP?=
 =?us-ascii?Q?y3R/3vhoug8JKibttMhYPSvVCDMYbCr8Ydw5yW4LSQyKG+V37+pWn1vFjUlz?=
 =?us-ascii?Q?7fbnyDSabNkOFUGt9wh29pKKj/uMVNqVBvQzMS9xcEA/zqnm8eqsMsz6JERb?=
 =?us-ascii?Q?NHZptEzbvNBnWN0Gor/nl1lRQ8OaycsOLKIxIqidwEQW0snAI9o5JVa8Be8L?=
 =?us-ascii?Q?eokOY8RHh/ebJ9nB/eA3e7Ddsn6BAfuowO8yMghOytAXjcXkkq4dY6enzQTK?=
 =?us-ascii?Q?IZkfgSUOeLM6Ex5ozrm5tICmmaI1iWAA7P6AcWM4ukAWSTTdWsd2fEGiTD3A?=
 =?us-ascii?Q?+e4VH5/BDJklPnGhg7SbHAIWSJq8dHfs305voI37RJ/t9CGcFQcMjqItx/wb?=
 =?us-ascii?Q?7oGQeXPZtiRdiFWl/kvA0y2YSG7bIhY0Lsw/haeHCPmHspZz0cspotRCL7M1?=
 =?us-ascii?Q?ZDL0DXngxfxMMxHTzrAOdKzMtbV+ghHfuE+AirIRQrB1pqzMKIIoEZYrWxCL?=
 =?us-ascii?Q?TkDVwMZJpr3u0s5lQAMBEFXYrOjYTp7EtlemfDn1jZf+c30cc8wuZIJdH4H5?=
 =?us-ascii?Q?akuIjxLXmTyWjJ5tKXmTGVL/wHXccIBcMXXmxN31A6EkKXrYIib7o0ayMnyf?=
 =?us-ascii?Q?ACuAiHoV9XJJuOb0v7lr0kYADneRAvNPwQ6YrTnDOh2Cn4cYFnNX5oV4OXYP?=
 =?us-ascii?Q?4nzDrhiqL5FrEL388o0lSzvXKuEcWkJbudwvD5sJHiTrAtdAEGArK6bgm7D5?=
 =?us-ascii?Q?COCWdg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53433F1D26FFFD46A6869BFFF09C99F7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e13f6e-9f88-48a3-6c6a-08da6fc4d3ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 11:40:38.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AheabCx4iSOWH6wPZn8wuNZWVdhO7PHUTOHojRdGjr2uiH3SUjQEK1EUjJUzjWAUYlzlpMTZU5yTmk13rAXse8VhJFJCqaXpfTSoq6BG5WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5935
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_02,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270048
X-Proofpoint-GUID: ZYz6RRVKudfYVsUuetD-LOO0gDHVp4nF
X-Proofpoint-ORIG-GUID: ZYz6RRVKudfYVsUuetD-LOO0gDHVp4nF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't a NULL pointer dereference; returning &(0->page) is completely l=
egal
as was discussed regarding this exact code back in April:

https://lore.kernel.org/lkml/YmfgqKcMmstgfz+0@casper.infradead.org/

> On Jul 27, 2022, at 12:46 AM, Yongqiang Liu <liuyongqiang13@huawei.com> w=
rote:
>=20
> When __filemap_get_folio() failed and returned NULL, we would
> get a NULL pointer dereference in pagecache_get_page.
>=20
> Fixes: 3f0c6a07fee6 ("mm/filemap: Add filemap_get_folio")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Cc: <stable@vger.kernel.org> # 5.16
> ---
> mm/folio-compat.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 20bc15b57d93..7b21393480e0 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -124,7 +124,9 @@ struct page *pagecache_get_page(struct address_space =
*mapping, pgoff_t index,
> struct folio *folio;
>=20
> folio =3D __filemap_get_folio(mapping, index, fgp_flags, gfp);
> - if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
> + if (!folio)
> + return NULL;
> + if ((fgp_flags & FGP_HEAD) || xa_is_value(folio))
> return &folio->page;
> return folio_file_page(folio, index);
> }
> --=20
> 2.25.1
>=20
>=20

