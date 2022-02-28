Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34954C6FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbiB1Ohh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiB1Ohc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:37:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CB67EDA1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:36:53 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SD2D1s021527;
        Mon, 28 Feb 2022 14:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WP/4fYp4zloAtsXqHg7jrhU1qK9GBPvSpMA7YBGxZIs=;
 b=c/z0UIt2fKTwWisW7IRIe2FlrfzeVo45k/8eTrTuWr0j5XkedBGnwztQSHhCIlUdG/LV
 TROoOyvvoneNXHw9hXMr60yDwrIiCIY/IGkBtZKpdh1yIk9Io4oJiIGVT4sdMoWRnLk+
 3Q2Ixm0W2YmmNvbbSebsqZPI9OuIsq8aC9WH/DAQqQPTx8rMYUm5Qdj1pMEp+iDtbxHb
 G30FYp5dley7eiVa1etNDCgnoOJuaiKXV6lRS4PeykCLQbalgTBWzNyZ/kReUpwFF3no
 3xAKcH5yGjW+hnAcpyQzBq+U8cDyX8vfjZbNIH4mQqiRc7uT1POshgIU10W1H1FfUIfC sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efat1vdnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 14:36:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SEa0jn164378;
        Mon, 28 Feb 2022 14:36:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3030.oracle.com with ESMTP id 3ef9avk9hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 14:36:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1wz/9KLWqnpTMvROn6hTYsiRWI1OAehUrZR/Mpq5A3B/3VHA7T/o20ZkRFy57OkOjKsRYfp0bQaZ/0evZzhIONWH+gSkOBauVvCO4x5/BE+dnBWqz6i8tf3w9hkPem4gjQ7qnhaBKG0bobJybJW8JwmFKBzA8bp/Z7evcX54sO0nK7iks1JTvt2+vSrnBqKX6KwHBy8DwYKes6LoHzlrPIS32N2EPS4DJs8Aq9XUXVPFBnPgDxHA2qTBmtm3anECQN10wgoEtkOiZwGFUvMMffYeLYGO9sD7lhgQu1NcLky3VVjMB/5m6C6sUxkhLnbZLodyzzgkN/aQDC/sg33SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP/4fYp4zloAtsXqHg7jrhU1qK9GBPvSpMA7YBGxZIs=;
 b=mc4aAMHR91xlK3v7CyjKrZLHGdJWblaSgADiAhwtI1qE71YKv2vKOsTUwZFfa3CneE7whJsYtIu0ON8+nVxFxWr4e6TMMxQgyhYAUH0mC9Agfiz/qgt9syST1h6x/XCi9P/dcNjU6l1ik73QsawffFBpnHOeGVVHpqxxG7iw+q8Ul9w5rkLpTCY+ZKV+ImO7H2DtUInf3jD90YpO5SsVnp9VPxSXffq0TDDde0coQAep5m+ft+mubCnFJfBSpc5DbRZkRJQOzQF/WMbhh6O4McNcwDbn/SPqTgUZKrUOxg3HKdH2heI/I8iX/2IGXurkyDUSle5njzu3H12wUYIU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP/4fYp4zloAtsXqHg7jrhU1qK9GBPvSpMA7YBGxZIs=;
 b=fkepiy8y/mWdWPdDb+7QBzGvSE9edPFjpdrFFUi1OPv4pKmomP+yNbIwZn5OMgzIbnwmeCrckAUkb5oJYDy3W+Ixgh+5CpmQo9NMuqMfzQlVae817AKRlmi8aCxFiimbEHQmQ5V1c+a6By/RVJ4iBndESiTbp/MNkWhKs6P9RE4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4378.namprd10.prod.outlook.com (2603:10b6:5:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 14:36:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 14:36:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v6 08/71] Maple Tree: Add new data structure
Thread-Topic: [PATCH v6 08/71] Maple Tree: Add new data structure
Thread-Index: AQHYInpU/hKtaWQ3X0yDuzeh55NMz6ymqQwAgAJzKIA=
Date:   Mon, 28 Feb 2022 14:36:40 +0000
Message-ID: <20220228143633.r4zoemgtmrq4uzvb@revolver>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-8-Liam.Howlett@oracle.com>
 <your-ad-here.call-01645924312-ext-0398@work.hours>
In-Reply-To: <your-ad-here.call-01645924312-ext-0398@work.hours>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24ae9e7c-2b32-4bf0-7650-08d9fac7bbbe
x-ms-traffictypediagnostic: DM6PR10MB4378:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4378D2D79B0888E1BA8295A1FD019@DM6PR10MB4378.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zgs9JaOvbv6idN4Hldxt4i2Q3YRvWc6HHk6wrg5Ebq3FdFHzdLG7JVWONdQWHxsxrp/SyyXAoBYwpbGrXqX9fvFajKAZvShMji1RMVPwlU/51hNWsPam/UIsJsES432hyxSHCu+nYXZcUXgGlpRKjwsFovxhjRqrBwQUc9xZspY7f2GWknwUuP3a+bRRGQEV35mP4YhR2MNL+TrO/O8Yn38H6mqem5oQxhaeKsI4sOuukQAVVvoULXgCX+YMrihP82kr8LFlu4HMFfrQAheOqFlLlqRCzQUqM8IgsvRepDoWKvCbwTwKQMnj1N3p8aKU8r3/zdfA2sk5ryHcP5KkIvEHYBLiD0qbsRlpqR8GlpUc+cDwjNOoo+Z5C6Tuebx0/8K52IcncNMlLkKgvCI+mXzOj0V04hKLtXv2fG12gGkDcdYDXiJBBLTFjcGZyCBb19f8zjcOX1QRTP5uCqNM+VSUNb8ZHsJx2viJJ9kR9WbM9rMCdv8W5K8o5EPTclfEPTOLY1ZRPc4QwBmBPLZesogTxcWj23CtmRkcMX3HfgHJsRZ7+tBb+T0AXObhdaSlGjxqRBuIwjbQYN63ChGqWwZbeMEmoYWTPZ7sCpCpEPUSRc1K4zoYezaa/UtyQgHSzvL/OCPMGNQ0V8bXIPEUh9rY9QcOZdH+QHbXxL6SZ9UpRgI4xR2rNbamiHeyTh/frImA1rJqGzff5Dhyo/LndEQKidwqOeX+eirplyDqZ7k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(66946007)(76116006)(6512007)(9686003)(8676002)(4326008)(66446008)(66476007)(64756008)(66556008)(8936002)(2906002)(86362001)(5660300002)(83380400001)(26005)(186003)(44832011)(38070700005)(33716001)(71200400001)(508600001)(6486002)(316002)(54906003)(6916009)(91956017)(122000001)(6506007)(1076003)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XlFwgarS+k1WJ8C5m2bBEeZJm2E9PeAveGD75ztsj0QOFDhLnyzRuBttpEAj?=
 =?us-ascii?Q?pSmnOB6QDpzfNtOMPO0gQmH8ysjMBdSmlxygNXg3vi7SuKIYtSgCPTSafOeL?=
 =?us-ascii?Q?5Ku+LXbeyd4SuNPpYo6JTcybUCVQPHdJ7JHRfae63PMW064OdjEbbMkV2WSq?=
 =?us-ascii?Q?7x2TRRo7Fzdj3ihjW9cngp37/s5NCSkycjN1YZnhNHMdlKq8AkWmQa845xFP?=
 =?us-ascii?Q?5rJU2741RPPyrM73TX1WI91THxBMLR9TvNxyuGHUs4F6YWGKaLcY1/cWBokQ?=
 =?us-ascii?Q?Dm8wPxa5S3xXi1AyHR+nfeKD4UEBbVqMcPQVX0YsXWlJY3ULa5F/G+yV0K4Q?=
 =?us-ascii?Q?2J/kz2GXnwdZkp/hqx+1Rfd8zO6rNCzDz6TRFgZixEiMW061FFs7gX+/3xCK?=
 =?us-ascii?Q?1o8x7dJmGDc5ieCw9tEyBOmHfXd/n0+L/KFOAndXwwdNk1c4tFGwLX1DoF88?=
 =?us-ascii?Q?7fJgv0Y8iaS6GXaiyv0ODL0TbZPURecu6u6L3MpQvLB/wLyH6e33ggidpaVm?=
 =?us-ascii?Q?uGqtNK8NKawk/7gwNhwDaK2Z7ks0H6J8QmUQPfa55pqTkLAET0ZEFDXeiROO?=
 =?us-ascii?Q?LAajCVfcauKQHZYXUyluGhIY3O97Hjb0QSU49dLl7SJF2x0UJZpqInN1Ams2?=
 =?us-ascii?Q?NrhdkIfyqp05L5GaO/lcr/U2eCHbqTjJXiQv6kx0Q0q1FHYO+K6iLaV6BWaP?=
 =?us-ascii?Q?VfXGsVDc6TAVqcKRVBzHLW3A1XwUlMqpwD4K507hSlu+4D3RIEKVdBD1SYOb?=
 =?us-ascii?Q?uqHqLJDLOUhz/UQ9mu5vW/Rj24bUm6y6bZ9Uum8LDRRG+297BS/gpC0onTGZ?=
 =?us-ascii?Q?PaY0YYBe6r3juUXJrlCkZWZZLBHkkANYn5FRs20ZKaqc0sdI1VbrJ7OFt1Ux?=
 =?us-ascii?Q?KW1e3o7RmGMSWXClRN5yp8FGTAMAAC1MgzXnn+ixUhBLzQ0YYFeFkEjDXSDz?=
 =?us-ascii?Q?dJO9bolAcWlmY6Z46eBSwGFmHGJTaisKR5vHIsf9181+yfu3G/JOrjbs14Ot?=
 =?us-ascii?Q?yUn4+8//mxyU+TwsXN60vV5FwBmACp9hbtmeTAO/uLrMDpeJNivwwrWpmeSO?=
 =?us-ascii?Q?OK6uSdDasfyJ5MNXggcLFAZP7EKlA5WlU3xuXmCRkGRlKXtSflcErXE5AqGt?=
 =?us-ascii?Q?GJPA2Hi0l51jCSd5lsOFoARcPktNF626TU1IA4snD6AgCwwSGu/3r6EbOF4z?=
 =?us-ascii?Q?wOBNXxh0FuiKwINoNUj4+meCb6oP+4xOUGXHgZciHvaIiGmt2xEEpMReeR0e?=
 =?us-ascii?Q?YKHPEUF3KqKhonbOrWfs6GWBXWRdBBgD6/uQRrN5HxuUzfcSOqLKW5vyqR/K?=
 =?us-ascii?Q?KqUM9qScAGRmFkgNKgcTC3CNHjFKmnSVH+NWdkVvbapvmw7pi3xgTmnIKCmz?=
 =?us-ascii?Q?/1b1xCld1u6R+YDjmXUNcENwD+mu+9ja8CiNoP0MvPHO9EspLjJitTYEG7vD?=
 =?us-ascii?Q?WtJ0scybSIsTTjeivYelbgDnMQF8Bv0q7NvAuFzeCxo70ey2jAMtWpg9DzWI?=
 =?us-ascii?Q?6g6HK6OwbgFK87MozVF437cnH//4VsXzlw7QpNEQ8/xJNxmc2SeSEdZDNiyQ?=
 =?us-ascii?Q?aqSbxz3/vXUJ7wZpsvOsW1rPnYs5jcdOM8ak+pJOptXsS+90pFmTENCKeyeJ?=
 =?us-ascii?Q?9xq+br5zSENCbeeq+MJi+1k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A31279ABE3FD9D408BC30255F6A1C137@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ae9e7c-2b32-4bf0-7650-08d9fac7bbbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 14:36:40.4112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYY6SKI0fzRMiMd8XQeXyTCpnQPHBXE9SAsyMbyhvRzuNRylRp5Y3xwdcinmh8hknRousS/UF4WYA02Dx5Tk0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4378
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280077
X-Proofpoint-GUID: b1-nuQb_r-xfxHiIuMHXsBsi-bFqIr7j
X-Proofpoint-ORIG-GUID: b1-nuQb_r-xfxHiIuMHXsBsi-bFqIr7j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vasily Gorbik <gor@linux.ibm.com> [220226 20:12]:
> Hi Liam,
>=20
> there is an endianness issue with maple_metadata. This is broken on
> all big endian architectures. Tests are crashing. See potential fixup
> below. Feel free to apply it or fix the issue in your own way. This does
> not resolve all the issues with the patch series though.

The endianness isn't what's causing the issues.  The slots hold a
pointer.  Either we can use the entire slot or none of the slot
space.  You are just moving the metatdata around in the last slot.

>=20
> With current definition of struct maple_range_64 on big endian systems
> metadata end and gap fields are aligned with the most significant bytes
> of slot[15], rather than least significant.
>=20
> (gdb) ptype /o struct maple_range_64
> /* offset    |  size */  type =3D struct maple_range_64 {
> /*    0      |     8 */    struct maple_pnode *parent;
> /*    8      |   120 */    unsigned long pivot[15];
> /*  128      |   128 */    union {
> /*               128 */        void *slot[16];
> /*               128 */        struct {
> /*  128      |   120 */            void *pad[15];
> /*  248      |     2 */            struct maple_metadata {
> /*  248      |     1 */                unsigned char end;
> /*  249      |     1 */                unsigned char gap;
>=20
>                                        /* total size (bytes):    2 */
>                                    } meta;
> /* XXX  6-byte padding  */
>=20
>                                    /* total size (bytes):  128 */
>                                };
>=20
>                                /* total size (bytes):  128 */
>                            };
>=20
>                            /* total size (bytes):  256 */
>                          }
>=20

You may have been confused about my comment, which I believe is
outdated, that talks about maple_arange_64, not maple_range_64.  I added
maple_range_64 metadata and use the previous pivot to see if the slot
contains data or not. If piv[14] =3D=3D 0 or mas->max means we can use the
slot for metadata.

> Assuming we don't want to end up with smth like this in a code which
> otherwise relies on shifts and endianness independent.
>=20
>  #if defined(__BYTE_ORDER) ? __BYTE_ORDER =3D=3D __LITTLE_ENDIAN : define=
d(__LITTLE_ENDIAN)
>=20
>  struct maple_metadata {
>         unsigned char end;
>         unsigned char gap;
>  };
>=20
>  #else
>=20
>  struct maple_metadata {
>         unsigned char unused[6];
>         unsigned char gap;
>         unsigned char end;
>  };
>=20
>  #endif
>=20
> rewrite node matadata access in endianness independent shifts based
> approach as well.
>=20
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  include/linux/maple_tree.h | 33 ++++++++++++++--------------
>  lib/maple_tree.c           | 45 +++++++++++++++++++++-----------------
>  2 files changed, 41 insertions(+), 37 deletions(-)
>=20
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index e808794e06a5..e0c9f356ba4e 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -76,21 +76,6 @@ typedef struct maple_enode *maple_enode; /* encoded no=
de */
>  typedef struct maple_pnode *maple_pnode; /* parent node */
> =20
> =20
> -/*
> - * The node->meta is currently only supported in allocation range 64 (ar=
ange_64)
> - * node type.  As a result of tracking gaps, there is a small area that =
is not
> - * used for data storage in this node type.  This area is reused to stor=
e
> - * metadata related to the node itself including the data end and the la=
rgest
> - * gap location.  This metadata is used to optimize the gap updating cod=
e and in
> - * reverse searching for gaps or any other code that needs to find the e=
nd of
> - * the data.
> - */
> -struct maple_metadata {
> -	unsigned char end;
> -	unsigned char gap;
> -
> -};
> -
>  /*
>   * Leaf nodes do not store pointers to nodes, they store user data.  Use=
rs may
>   * store almost any bit pattern.  As noted above, the optimisation of st=
oring an
> @@ -110,8 +95,22 @@ struct maple_metadata {
>   * subtree with an entry attached to the value whereas keys are unique t=
o a
>   * specific position of a B-tree.  Pivot values are inclusive of the slo=
t with
>   * the same index.
> + *
> + * The node->meta is currently only supported in allocation range 64 (ar=
ange_64)
> + * node type.  As a result of tracking gaps, there is a small area that =
is not
> + * used for data storage in this node type.  This area is reused to stor=
e
> + * metadata related to the node itself including the data end and the la=
rgest
> + * gap location.  This metadata is used to optimize the gap updating cod=
e and in
> + * reverse searching for gaps or any other code that needs to find the e=
nd of
> + * the data.
>   */
> =20
> +#define MN_META_MASK		0xFFFF
> +#define MN_META_GAP_MASK	0xFF00
> +#define MN_META_END_MASK	0x00FF
> +#define MN_META_GAP_SHIFT	8
> +#define MN_META_END_SHIFT	0
> +
>  struct maple_range_64 {
>  	struct maple_pnode *parent;
>  	unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
> @@ -119,7 +118,7 @@ struct maple_range_64 {
>  		void __rcu *slot[MAPLE_RANGE64_SLOTS];
>  		struct {
>  			void __rcu *pad[MAPLE_RANGE64_SLOTS - 1];
> -			struct maple_metadata meta;
> +			unsigned long meta;
>  		};
>  	};
>  };
> @@ -138,7 +137,7 @@ struct maple_arange_64 {
>  	unsigned long pivot[MAPLE_ARANGE64_SLOTS - 1];
>  	void __rcu *slot[MAPLE_ARANGE64_SLOTS];
>  	unsigned long gap[MAPLE_ARANGE64_SLOTS];
> -	struct maple_metadata meta;
> +	unsigned long meta;
>  };
> =20
>  struct maple_alloc {
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 7ebb34964c68..02be5a5314de 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -868,15 +868,22 @@ static inline void *mas_root_locked(struct ma_state=
 *mas)
>  	return mt_root_locked(mas->tree);
>  }
> =20
> -static inline struct maple_metadata *ma_meta(struct maple_node *mn,
> -					     enum maple_type mt)
> +static inline unsigned long ma_get_meta_raw(struct maple_node *mn,
> +					    enum maple_type mt)
>  {
> -	switch (mt) {
> -	case maple_arange_64:
> -		return &mn->ma64.meta;
> -	default:
> -		return &mn->mr64.meta;
> -	}
> +	if (mt =3D=3D maple_arange_64)
> +		return mn->ma64.meta;
> +	else
> +		return mn->mr64.meta;
> +}
> +
> +static inline void ma_set_meta_raw(struct maple_node *mn, enum maple_typ=
e mt,
> +				   unsigned long meta)
> +{
> +	if (mt =3D=3D maple_arange_64)
> +		mn->ma64.meta =3D meta;
> +	else
> +		mn->mr64.meta =3D meta;
>  }
> =20
>  /*
> @@ -889,10 +896,10 @@ static inline struct maple_metadata *ma_meta(struct=
 maple_node *mn,
>  static inline void ma_set_meta(struct maple_node *mn, enum maple_type mt=
,
>  			       unsigned char offset, unsigned char end)
>  {
> -	struct maple_metadata *meta =3D ma_meta(mn, mt);
> +	unsigned long mnm =3D ma_get_meta_raw(mn, mt) & ~MN_META_MASK;
> =20
> -	meta->gap =3D offset;
> -	meta->end =3D end;
> +	mnm |=3D offset << MN_META_GAP_SHIFT | end << MN_META_END_SHIFT;
> +	ma_set_meta_raw(mn, mt, mnm);
>  }
> =20
>  /*
> @@ -903,9 +910,7 @@ static inline void ma_set_meta(struct maple_node *mn,=
 enum maple_type mt,
>  static inline unsigned char ma_meta_end(struct maple_node *mn,
>  					enum maple_type mt)
>  {
> -	struct maple_metadata *meta =3D ma_meta(mn, mt);
> -
> -	return meta->end;
> +	return (ma_get_meta_raw(mn, mt) & MN_META_END_MASK) >> MN_META_END_SHIF=
T;
>  }
> =20
>  /*
> @@ -916,8 +921,7 @@ static inline unsigned char ma_meta_end(struct maple_=
node *mn,
>  static inline unsigned char ma_meta_gap(struct maple_node *mn,
>  					enum maple_type mt)
>  {
> -
> -	return mn->ma64.meta.gap;
> +	return (ma_get_meta_raw(mn, mt) & MN_META_GAP_MASK) >> MN_META_GAP_SHIF=
T;
>  }
> =20
>  /*
> @@ -929,10 +933,9 @@ static inline unsigned char ma_meta_gap(struct maple=
_node *mn,
>  static inline void ma_set_meta_gap(struct maple_node *mn, enum maple_typ=
e mt,
>  				   unsigned char offset)
>  {
> +	unsigned long mnm =3D ma_get_meta_raw(mn, mt) & ~MN_META_GAP_MASK;
> =20
> -	struct maple_metadata *meta =3D ma_meta(mn, mt);
> -
> -	meta->gap =3D offset;
> +	ma_set_meta_raw(mn, mt, mnm | offset << MN_META_GAP_SHIFT);
>  }
> =20
>  /*
> @@ -6590,7 +6593,9 @@ void mt_dump_arange64(const struct maple_tree *mt, =
void *entry,
>  	pr_cont(" contents: ");
>  	for (i =3D 0; i < MAPLE_ARANGE64_SLOTS; i++)
>  		pr_cont("%lu ", node->gap[i]);
> -	pr_cont("| %02X %02X| ", node->meta.end, node->meta.gap);
> +	pr_cont("| %02lX %02lX| ",
> +		(node->meta & MN_META_END_MASK) >> MN_META_END_SHIFT,
> +		(node->meta & MN_META_GAP_MASK) >> MN_META_GAP_SHIFT);
>  	for (i =3D 0; i < MAPLE_ARANGE64_SLOTS - 1; i++)
>  		pr_cont(MA_PTR" %lu ", node->slot[i], node->pivot[i]);
>  	pr_cont(MA_PTR"\n", node->slot[i]);
> --=20
> 2.35.1
>=20
> =
