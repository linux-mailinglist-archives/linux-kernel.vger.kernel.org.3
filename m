Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F08752A12D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245567AbiEQMJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbiEQMJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:09:50 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60117.outbound.protection.outlook.com [40.107.6.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48BB4507B;
        Tue, 17 May 2022 05:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0pKOAYkVms2RcC+L6hCvRXYMnfiSR7O4SZMNv10t8p81WMN60UnnNhsTy729a0P7iad8cDP1jict8cb0Hb2DCuzyWNs71tTxCfZTeNk+qpAYxLnZGW5eU6dM3NnpP0NGzulNkRrQtTKR5SjlKGW7XIibMf7non7bUjenGP5ZoYqlmT9S9F00UPGYmLDK1+nHTCsXTPCNp1hgXtZIxhy4lv3SuVOhS9rm5bH2C5fKOQdum6DCcG8bGiGvKq1P7qsYiYNBhz3Mztsqj6KMpUTiCxueshgqLleuDHtDZ/fa6tZQbNk8NCYXBMkGI2ldQWIQZ7JSQ6YRE9PTuV06BlaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeciENTugQoJzX2Zy6rlx4iB1Yi4RbXSz0W9uVffotA=;
 b=D07kZ00WOa78UFedeI1Br+2D3JiSz1Cqit95ynmAXYrqVThGKbrhgkY+63ITyVOhLTxF5CSTt6lDllgdBAeyok/kgl55gtubyrS6dntccssT0KIBw51QCmWaC15/g5rUOtx1TV6HVTV4/H+DPN/dqAzFbyYqrc6tfdYHWKKpCscJdyhhBf2q26Qj2ZIuCba2ZDVSyiPhfeSzATQcOkur3YJ3WoATHo/QOrpnO7xojKHzUN2U9TYapSGqFw0OxdOZlajnYHQoEkaXp21/RfKBLaQC/O8LXndMjbCVXAUSruMS/gf9BbW9GAqSrEAOE9AvuLMp2o/P+iW43Q5OmbAKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeciENTugQoJzX2Zy6rlx4iB1Yi4RbXSz0W9uVffotA=;
 b=VqyGVnPghsUcOCxTkIlmgr7XPvyMhIp/0kHk5f8nfKy26zoz6YxvEp3fTvUTGaDYfwIo3GRANWdQxMS1rXgqEvlg9GX4ck41GyiEuLT6I9sHcSubw3OFEsokIZz5rFy3AzqcXEm+KPq1Rsf4b/d4vxfotCouj3nC0KomeVgUIbh4OdF4Pnv2m3qWKsFoltdRXX/USzK/pbcm7NaGoMOjsW0rsNU8cmgpul5ilVbrQQuiljlm9dC8ffY8nOt3cV9Zjx/+OuTELJKGYho/DQmlx//mSFEPm7x5LSEojIj+HyLdn51ixIEu4OF60mVzC92v+2qHzTEBwMOEGTbuYyA1gA==
Received: from VI1PR0602MB2893.eurprd06.prod.outlook.com
 (2603:10a6:800:b6::14) by HE1PR06MB3034.eurprd06.prod.outlook.com
 (2603:10a6:7:22::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 12:09:46 +0000
Received: from VI1PR0602MB2893.eurprd06.prod.outlook.com
 ([fe80::b9ef:2a79:1d11:eed8]) by VI1PR0602MB2893.eurprd06.prod.outlook.com
 ([fe80::b9ef:2a79:1d11:eed8%11]) with mapi id 15.20.5250.018; Tue, 17 May
 2022 12:09:46 +0000
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH] fs/ntfs: remove redundant variable idx
Thread-Topic: [PATCH] fs/ntfs: remove redundant variable idx
Thread-Index: AQHYadGjIrr1Cy/zz02Ilh3VzQbVG60iz5wAgAAqvoA=
Date:   Tue, 17 May 2022 12:09:46 +0000
Message-ID: <D8033E52-4BB9-44E7-A97A-FB1E51645902@tuxera.com>
References: <20220517093646.93628-1-colin.i.king@gmail.com>
 <20220517093646.93628-2-colin.i.king@gmail.com>
In-Reply-To: <20220517093646.93628-2-colin.i.king@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 431770ec-fc16-4194-8052-08da37fe223d
x-ms-traffictypediagnostic: HE1PR06MB3034:EE_
x-microsoft-antispam-prvs: <HE1PR06MB3034888EBD34FF6446C22AC8C0CE9@HE1PR06MB3034.eurprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IM+4NgyViWHqupBsPok6NpeNpew+X/thip/dv8TKaj2+vuBEwUCcF8Ww9JooGBhJwALwzTVP/tW2o7VxXEw1TOcx620ZLG40BEnu6SLuYQOzGEIp96hIyRy7xVXzB4VkUHCw7eD6HLxJjQ79U7Y7Zem6XRYvSR17XasN8gV4XX0L5kX4etAY1D8Ca4jK5+1aQSxY8p4Zq21FAg+mfCTON8V7CLjoa0oYV6vII0jG0+zbXuxDTSz/aXwYUgz2ix8a1PMH5es9M58NBQHvYo5UPDSE2lIMk1k6kkinYBZ62/R9Dhd4jT03rE6FuM8G7mnPBy0LGV43NTJgsthfWvGKMbn05k40gSKMOoSrBkA7OvbCGciiX8emI0m/TB2Cway8XexHZShVBnnu81MPSjC1b9ZyzQx2k3sE/Xhy5LYF5sL9ovU02ZG/OWwvkEs+7Ph6m86lwWSjxE+6cCkRxpUPe3xT/lwU0JSJ/KbU/9OZUTCpGCYnf4yiKp5bvcMnArvAiadUL8oalEGqMT7MEY6zSKoh1TFdeVXS7RAn86liC//lDp20yeQbFHS9JiTUwWxuEBY5NyDLtuSqtMmhWQejwibSj25IQbOJ4ih5aYboWkPOH+/MFu07xm1Fj7Auz9gJ3pwM/pVcIh8VKnz8t+8dFWp89T6v2Me0dLrjG2X+h6I8S83oot0fR1pZXsXK+8FTR58g4pngtgkLcqy0pvwWwjCWyN3ZctFwQ2wvop5KU0I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB2893.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(366004)(136003)(346002)(376002)(39840400004)(6916009)(316002)(122000001)(6486002)(83380400001)(54906003)(66446008)(508600001)(66946007)(91956017)(71200400001)(53546011)(86362001)(66476007)(66556008)(76116006)(64756008)(6506007)(8936002)(38100700002)(4326008)(8676002)(41300700001)(186003)(38070700005)(36756003)(2616005)(2906002)(26005)(33656002)(6512007)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+JW6I5uX1FV2lzY71BM2zMAtUty/+MaZNL/yLwoFkb41rwGoCRKhADL0cAKk?=
 =?us-ascii?Q?uQHR74zuVkhJ667bVWMnUIqk9TNyfvKyZJnZXqwmLvE5HdZOy5haWPrNeXbM?=
 =?us-ascii?Q?yQWQeEWtWA9d4/lczeHEccryKCtGs/rYZTXuQhBXovpQBWy8yGNDG2zLpFXj?=
 =?us-ascii?Q?lswItXvjMLfL9N5nJAVnoeRfAGR8NastJjAtqXqXWcUA0ZEZUXpo8f7qrLnv?=
 =?us-ascii?Q?WyQXPiVk6vFW51ifN2lzfDGr64jO8cIWVSEW74RL2m9v0cADvh/Is5rSBkFv?=
 =?us-ascii?Q?aH5HWFxHtJigMPN6Ul+jORxBiOHKazKlsSntnO0vaibvQip2M16MDMOlm1ln?=
 =?us-ascii?Q?0V1bbuJXM/Sd/it45xe4cXQ0RdWkazAynAQZ5qMqU1WVAZ6+xDji1KzE93XH?=
 =?us-ascii?Q?tTfLoWGfB/yoM+W4yIqonRr6ON168eRNPMQhnGNB8BGC/OPcEHEHO77kvuRr?=
 =?us-ascii?Q?UodVM92icFcra9lP1/6OdF+Zsio7HZ4IfEtRL8DFdfp0bTUwXtnJrfwRYTVu?=
 =?us-ascii?Q?Rm/3or6xxhKdn3bmpR8of/oe+fkYhRM7Atar00BhFFQILlISm7LPmICl0K+v?=
 =?us-ascii?Q?RaXRWleeHWZ9OQ1/kL135chwhCaro3hqdZX+LIU4a7LSViPCmY9aajDKOuQr?=
 =?us-ascii?Q?7pqqOn/Hx7lcHScU2Rm8l3zvYa+Xl2psFe3nnUk723fwyOq8D++NSBNc7Lwo?=
 =?us-ascii?Q?0yLm27pSKWaJU0fF4RfIveM3Uf1vTJkjIMwnWMT6zZ1z4TMsp4w4Q0p0Ng1s?=
 =?us-ascii?Q?H4ZLXh2UIgnG35obi9MNr57PT1hFco6OOGsNFEgl9CWENIgQW84r8mLjT8/2?=
 =?us-ascii?Q?zIegNyxId45qgK5NI/0au14YaEPdlsa8Jf46XItQdRAX35zra0njk84a/J3q?=
 =?us-ascii?Q?Iyqvg9H/26yCpD2mCTYz0o4SkPPhjpM8rbbKeG7YsSK+9C3OPzY4FrQmHR2S?=
 =?us-ascii?Q?kl2yhl1mTjMflN3N+zddgnHnKU4O8QjvZZthU1m617MVlDmtV9PIsSFRkiky?=
 =?us-ascii?Q?Y2mZQ22Sgtb0AbcwmbODELd0t6oDjXOBSMLluq0dKX1MbwNgpN5Lj/yvS66d?=
 =?us-ascii?Q?ceBb6XDvi/yz6VlWdCmeIkK2xwBxBysLixJO6LNDD4quup6CpBCodTyH2+/N?=
 =?us-ascii?Q?iNOTl8EtXexRGBgUB//JK6Wu5mdWK0b5vOdwSQEDiZei/HpLOhz4/jN662ix?=
 =?us-ascii?Q?OHav+58p3/HvX4Kc9eyTPyN3J/F9hWh7dHpZBGvQe+9Ml49SsYop5O3B5v4g?=
 =?us-ascii?Q?fy2g0B3XGs0k5/dcyFeUGAP5ABGyGiIdGbay/3l1z4kt3HYOkiDJc9ZprBGE?=
 =?us-ascii?Q?so7cOMa3hNIrgOyx4M5iL+eEzafAkO/5PbDX722hwPiWcgoUs/8ob+qnSKJl?=
 =?us-ascii?Q?lUEfbNxDuh3J2WOpqx1XEIaPeerPJRTbvl0QM64xYWvz77YRnPp8YddFAz67?=
 =?us-ascii?Q?DaClahvKiHgLdBVkpOP8dWthrGRNA+n1RUDOOo+AodhEmumHVLk33cSytWDY?=
 =?us-ascii?Q?BSc1Oa8oPMGSjEHiB23D5YBAHhOSKP8bk3t49uudHuz/huBTYLS8CALAsGjk?=
 =?us-ascii?Q?JDD3zxeIxDY05q4aLAKO1D2BSDdm/milCsFSo2tHJ2D3KN/pYaLm6QxTHSar?=
 =?us-ascii?Q?PGHHz4m+L05TsdqMC1e1BNmVoIKud2ePNYS7oWEat8NsmrAGjU3fKjg27xoW?=
 =?us-ascii?Q?M2aLbFVwDpYXrLmg7oJRmNb1ApiWtNgYqczQRz8EVpsjH1xhS6Qhos1fGrg5?=
 =?us-ascii?Q?dFJ8cMMTCw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28DB73FA10085D489EF7248291512C77@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB2893.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431770ec-fc16-4194-8052-08da37fe223d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 12:09:46.1554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6WvdmcLBJHg3BUIij47c6RKv7Gbdcr3c0/sMczX69ab1g6B5Lg4cBxXxx8jDNBCrFWjUdk5Qh+MEm+yAaLVfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3034
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please could you merge this?  Thanks a lot!

Best regards,

	Anton

> On 17 May 2022, at 10:36, Colin Ian King <colin.i.king@gmail.com> wrote:
>=20
> The variable idx is assigned a value and is never read. The variable
> is not used and is redundant, remove it.
>=20
> Cleans up clang scan build warning:
> warning: Although the value stored to 'idx' is used in the enclosing
> expression, the value is never actually read from 'idx'
> [deadcode.DeadStores]
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: Anton Altaparmakov <anton@tuxera.com>
> ---
> fs/ntfs/file.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index e1392a9b8ceb..a8abe2296514 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -1772,11 +1772,11 @@ static ssize_t ntfs_perform_write(struct file *fi=
le, struct iov_iter *i,
> 	last_vcn =3D -1;
> 	do {
> 		VCN vcn;
> -		pgoff_t idx, start_idx;
> +		pgoff_t start_idx;
> 		unsigned ofs, do_pages, u;
> 		size_t copied;
>=20
> -		start_idx =3D idx =3D pos >> PAGE_SHIFT;
> +		start_idx =3D pos >> PAGE_SHIFT;
> 		ofs =3D pos & ~PAGE_MASK;
> 		bytes =3D PAGE_SIZE - ofs;
> 		do_pages =3D 1;
> --=20
> 2.35.1
>=20

