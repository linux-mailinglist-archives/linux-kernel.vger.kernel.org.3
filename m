Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ADE532A63
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiEXM3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiEXM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:29:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B074B93981;
        Tue, 24 May 2022 05:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFTU1yGC5hMGgi5FER4LxwnRNwHlzoXLdo6h7UjJPMJYqe/CotEPpdCGeI57RphpP11MHNGBuzOfIOSO40kwQauRS/QSJxgbg47n1nCW00HZvX4cBR18VSdjkNJi/2k73a+htNotmD6QdAesizsniJQyZlASWKMlHPrjouvMYoeb394mIdc5FezEeF6geX2JIVasOOT1PxHowJi+Mrf+tdUSEonNTC+Sgx8bEqqkxaduZz4RorbFFNsINcOO6D0Fc3gjmIIel76pUozfwkfCt75rTnBxcVN6jeocd7LUZk9HB4FsUB9/45x9zrnHKoplDkoFnoDLXUpu7744him2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0GtVYoPr6JYD3zk0GBLaGrLFaKWmxjG0vq/8l70OHk=;
 b=erG4PfKZbgUa9jRf/HzIyv5N9DqRZEiriSL2foylzxDIJzmeNr+AdpkyjC1Iftxn3R/Dv4fhGZ3BLYRvuiQn37oto3QJC7YEdSjTdacXn6r7w9VJIs4g69aH+Ib1UpRxVKcozjHQJCtVH6nySjHOjKh3c/QwSwuaYaWzWVbdmDCIbrhpo6sxhRWfrSA6ab/XLfzNkAD/yEN5rBDVaLvIS+MNqf58Ib2a4tVmN4CDvXK8zwfBtHLPYkzOI4ilhjKLuEmEj7Ls3QNZvKr7lxYY2ITBtk5zRDKrbU//PcrdEgZmHzZfG5JJG5XHE5LmXgTo3M4HgpPX/Y8EN6IdleNzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0GtVYoPr6JYD3zk0GBLaGrLFaKWmxjG0vq/8l70OHk=;
 b=sY5vtR3ntn8BJ6JrPQ9ofukfQ6eb1qpxOo0W6R6IwLfjsImCDC8DzlIH2FugB4h4xeXGKue4Tm2qrDLV3oSpeFqSl6D2bMwFPTCi7R6TbtzjTwT9yiFXAQ5srtAtK6SN9Rf1ymcDZvVFer5wmEhVU/N9KFQSa/ehe7wjvKGm1O9TNBfZvo072Na2CXu3FXyqfF8nIYg/4PErvguxUwsq4kq6GEjPdlCNqOAKnVZA5f6c8rbkGMJJLWD9TjFO7yQS3zlNvXSG0WMpq1tRDc3afBFUMG/oBmo9uH3cMuDR0TGAsvsjTKc9ARcRi0zaAsoG+hvtlTONlXUtCHrpQy8DJQ==
Received: from DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 12:29:41 +0000
Received: from DM6PR12MB4074.namprd12.prod.outlook.com
 ([fe80::511d:9ad5:184d:31]) by DM6PR12MB4074.namprd12.prod.outlook.com
 ([fe80::511d:9ad5:184d:31%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 12:29:41 +0000
From:   Michael Shych <michaelsh@nvidia.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/mellanox: Spelling s/platfom/platform/
Thread-Topic: [PATCH] platform/mellanox: Spelling s/platfom/platform/
Thread-Index: AQHYbz4YvuP45suigEKI3qCuIQeSXK0t9OhQ
Date:   Tue, 24 May 2022 12:29:40 +0000
Message-ID: <DM6PR12MB4074E6EB06A72AE8DBA99C4AD4D79@DM6PR12MB4074.namprd12.prod.outlook.com>
References: <9c8edde31e271311b7832d7677fe84aba917da8d.1653376503.git.geert@linux-m68k.org>
In-Reply-To: <9c8edde31e271311b7832d7677fe84aba917da8d.1653376503.git.geert@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ad18290-0210-48cf-3756-08da3d81134f
x-ms-traffictypediagnostic: MN2PR12MB4157:EE_
x-microsoft-antispam-prvs: <MN2PR12MB415700EDB6B118CEBCCCD274D4D79@MN2PR12MB4157.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zVGK5qeGXaFwGS7tuTP76WXrRs+tTHleWa155SMl6z1ODlGW8jIedxQiEFCKHHEyK4JX79EdTo+H6FeLY7NGJFZMu/Tlb4w0sjM4z9txxJFQA6+KwGytykvls7GNfsy4nXk1EGQEve8PnGfkss9Xunz/69lS4Q+XdFfgO/tnk+s8UVG89X8LdmmomPNsCRgrq2EZs1CO0vd0giQjTY/OMwCwUvbWiqZ9OZzHpTpxeE0nJj4NgTsHTHh1RSiFHm9nwgRoeplwmpPxL4STcMFhU/h4TZqQdMTR3V5jJ6g5TAot1/QcMG39TkV9ACa5AswkRlJr9x40ItkzEugVZkT7Ok+pmG6CdYnJgSGJWJ8ni+UcrlOGwV68bjqDVKOWUXNbx0A2KYDwBggSuPGpw35drTJOrMOeMaA0Ui0Aw3SU+DB847+XPxbfSivEc7zOCk7tfZSn+yTdpvvYbj21jvJ3edh47WqiixponWRchhzfU5tQ4+Wv67e04falCQQ/pTm5uCR5XuRQNW0+jH1zzV2WFSghsjeIU5No3w/jUk6vKWMHY94Hb2rErnmU6tjY+d+bkcy5AWDAQys6YXca7O/cQ8pkDmjlBVh5XFnDCa1qB+tDCFwthEAAR1TDbhz0tV/FOWZMTx3SGJfB7L6lt2Ls/nQPuKpp12UfyS+1mPrrZkWPoPzoJVC5WPgvySFWrC8L8hMTgV4KxgMZjk+X1auX0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4074.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(316002)(6636002)(110136005)(5660300002)(26005)(8676002)(66446008)(66476007)(86362001)(4326008)(64756008)(66946007)(66556008)(76116006)(38100700002)(53546011)(6506007)(7696005)(55016003)(122000001)(508600001)(52536014)(9686003)(38070700005)(2906002)(186003)(8936002)(83380400001)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vNPBtuVWRCHSKLYBqGQVSn+NcytrKYA5sJSEMlAXQNJgJnSHCj03oonKHCE1?=
 =?us-ascii?Q?4+8F/n54yAWrE4sUafZ5tr8cJn7qGrTUXSetgG93Zy0lvXlSbkasM0ACBwE5?=
 =?us-ascii?Q?Cfo8cK2UYs0mjyWf/un6LiU9S1IYqWOrwnyS+0hv3LdTURaMEBQ/qXZwCNEp?=
 =?us-ascii?Q?MC1mn6UKyFVPXR+eLlsAwvqmjasDsM1NUjDwLwSOvweLZopcdBiTxYenVuIj?=
 =?us-ascii?Q?ecJTPnIr4pKJisaUkXN0JkdJ84iiU6mdAmPQxhNiOt7SvaARsJzgkzR6Pnvc?=
 =?us-ascii?Q?0vnV/CH1XgA8mFMrarJARBfUPD3Yxdt++uZiEyxn/20Y7m02iybXd3+7vagW?=
 =?us-ascii?Q?8FM/kEKkclIxORMT8sKXewF1ZXVN7WwPGDiN8Ar08rDfyv0Sl8uvDpeO0Mw6?=
 =?us-ascii?Q?+KYKsVlDAvPszvaxQPd97GhfErzeuiyEJX6XSdNNA2DCqF3KDJQa7lSq6quw?=
 =?us-ascii?Q?CbK3+RTz0M8Vp0BEXeyjCNMS7z034DoWpG3ELJNoDXmwX9fNSbB5KczLoPKj?=
 =?us-ascii?Q?Ql93dG8hwK2IhAJQixExc3TfBO3lqNeLA+0mBjkTMh+cMN0rS4SV8wGuCGjv?=
 =?us-ascii?Q?CUYrirR+eXnSQuv2+feG5MrQqeyasSAyXokfVN3Z/A1Rz83vMrpgri68H+E/?=
 =?us-ascii?Q?qz4bFBggFIo/UX5fwO6SvDNCBwktAWoWGqgpK3vBRbD7YODCoGgEqfwBJvtW?=
 =?us-ascii?Q?0lmFca2sHmnMKE7QO6shlHnTmvg22GgTiEhiQ1cN9AovJv/5IvpyY67YlBfT?=
 =?us-ascii?Q?h34cxdua3MJiZAEEj4xJHBfasQqTMRyTV+v85nYJSCpstlflD9t1jA5uJjAE?=
 =?us-ascii?Q?KG8mRPcrFVcaIqjop7k+/oNBD2BGcEPwx6/9hKxV9J1BswCptryXwx3xmFNm?=
 =?us-ascii?Q?Th2kIu+Nuy1orRLZiCC4T01stcmnmVpHv8BrB68QUMBq3iO77Qbdnhl0HdCR?=
 =?us-ascii?Q?Or1diTQAVZiHSN7vbFu6ePKsgpdKWd8tN/ES1ej18nQoGyhoBr83OBK6bwUm?=
 =?us-ascii?Q?GSW14HzfNrpPv6XiyiSWJ5324IxToW10WXwU1KeHBzshJ3ApMSmFHvB2X4cM?=
 =?us-ascii?Q?1kP0GnYhQWa6a8yiAt/02Z1GWfMwmCuYQQvbWQmhiRW7jhhwnV4VWo+f/dnC?=
 =?us-ascii?Q?ii2Ce5W2UyGA/bdWP0KqTsYDfFzkUcIuzWapZ+jhIYKUn+EpLuEKJv1+xbC9?=
 =?us-ascii?Q?xYMkLC6tt1DKVdKOBBJhN+17qIi8w126SkqSYcSbc4xV+UGIkwICUg4vRjZI?=
 =?us-ascii?Q?ee2z7kdphNtj65UyA1E3ARUxUCS0EDwUtXqloupwwpHTB+RCwaE2zmU0pdjX?=
 =?us-ascii?Q?hGlKzC4Mcp/h0WpYxu0OwHXy71Y3QbdslOBZ+r1f2IOKixovJQ9ZG8WiG4aF?=
 =?us-ascii?Q?y+NHJEGGjxBUMvHos7PIaphtAlTYiTXbfW9M869SgVhrARCL6NXmauXb0YeX?=
 =?us-ascii?Q?WDa7xAX1LL2kEtEqrD2aAGkUOindoYqYGn4Gwyd9gxGzgcwCLPtHkj3NPhFF?=
 =?us-ascii?Q?CODF9nVNDlBAf+6JZi2SthQXDOwVBRWwlyeO32YmspKBIEjthGd0RfdfuW0I?=
 =?us-ascii?Q?7MmCRw1vm8SeLi1DxnisPRB+CGJDwwPhm0qC4Bl1aJ/SEBWTcNiYMuguako0?=
 =?us-ascii?Q?Tr2HoFHe/m/I0D3siv41Vb2lz13szPwhVHpJZpQBnosAcZBCJQditWCcxhFl?=
 =?us-ascii?Q?0fNneoqHL/0HPCltgNKgPxJa7iUioRXscx6QyQssiiNlGEhTJPmkh1pVAAOB?=
 =?us-ascii?Q?46SXu5tz6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad18290-0210-48cf-3756-08da3d81134f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 12:29:40.9911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7TtMCYQFzekRnEGOZxkbtraJ3xdOSB6dkQzYV3FZMuGxff15t8XaOVgs2wZ9VxZiyPLp+UuMGns3vecNGf8Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Sent: Tuesday, May 24, 2022 10:16 AM
> To: Michael Shych <michaelsh@nvidia.com>; Hans de Goede
> <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>; Vadim
> Pasternak <vadimp@nvidia.com>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> Geert Uytterhoeven <geert@linux-m68k.org>
> Subject: [PATCH] platform/mellanox: Spelling s/platfom/platform/
>=20
> Fix a misspelling of the word "platform".
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Michael Shych <michaelsh@nvidia.com>

> ---
>  drivers/platform/mellanox/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/mellanox/Kconfig
> b/drivers/platform/mellanox/Kconfig
> index 72df4b8f4dd8b5a0..09c7829e95c4b037 100644
> --- a/drivers/platform/mellanox/Kconfig
> +++ b/drivers/platform/mellanox/Kconfig
> @@ -85,7 +85,7 @@ config NVSW_SN2201
>  	depends on I2C
>  	depends on REGMAP_I2C
>  	help
> -	  This driver provides support for the Nvidia SN2201 platfom.
> +	  This driver provides support for the Nvidia SN2201 platform.
>  	  The SN2201 is a highly integrated for one rack unit system with
>  	  L3 management switches. It has 48 x 1Gbps RJ45 + 4 x 100G QSFP28
>  	  ports in a compact 1RU form factor. The system also including a
> --
> 2.25.1

