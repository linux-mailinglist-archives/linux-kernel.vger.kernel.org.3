Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131084DD516
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiCRHM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiCRHMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:12:25 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2132.outbound.protection.outlook.com [40.107.114.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B702B8806;
        Fri, 18 Mar 2022 00:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA8XwA1z0vFxqUH1ROx36ydAKPNJKBkSMe7TOlBeeX1Gx4kY+caT9PpLB3I71I4RkxfUV8rJjlyytHwejLmaQrp6F2djlmURwwqa0nwaTMGGTqC9wD6U+8fa/gNc8T3jIsbkOJHN9jT1Zkq0Ex5HhRsiAB4h9fXJFLS6zFZWBJSsIR89b/x4OLnPUYdH+DgGhlFlSqk5oTs+oBUxCLW8CzZjjeAiFQ3kOC806UbjpzzaJS1idEPc3CF2+QYq6ZT891bFy8cgVTofbZUwzRF8cMsycjkoj3ICPCoJu0jEzx63LduiHexcML0/SrzkxGZtzS8s7GboxHqEoRazE7xEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwLGGDJ+cqWUHqjkThHhVJ7hqO1oDAlQ+kpWvVr0c+8=;
 b=DB0ao8fEK6fDEZ+ubv6n5l4+px6aOpzyvCo2THNsaLqhrsYfFHDD/gvGmyV8Gsq88C3lfdJbrOjT18cs+SQMdqjW1Xnl8+vUh0IJ6YWIqshxxCbyGk74WUxyr5Zn88ZdEqYtKXwV1VBRxHfIphvVmIzZqmUIe5Dqyg9Kij7tlaWFFmH1Q9iMFA8Xx7kwLIdAfStcHRa5nB669S+yBPXjV8KwhI4/cBcpgWLjid/limFDg2CUmnN4bqOaRtdz0C2JmuKYu3q+DY9RgBKIMgWkkrglGMMWt3XuMNg52gyo19oXkjP2s26Yfb8FUMnWpJ+N6vfwegiaqSomnprCDIRLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwLGGDJ+cqWUHqjkThHhVJ7hqO1oDAlQ+kpWvVr0c+8=;
 b=hAvU5iBKgxRyhKafBAyy3Dhnuxn2Vfii7rZemmbXoXgOepoTF9lWY93Fvg4j4w9XLtmsf1/HrU14GdhTN+QihbEkKtQl7tfAQ4rb/ZemD1mzTdUGSyLsJj9Fr0lMzZ5pgQUYkzYFND/MERRRFMxB9KwexibfgIMOziSxYnAiuUw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY2PR01MB4651.jpnprd01.prod.outlook.com (2603:1096:404:115::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 07:10:59 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::cc77:910b:66c1:524b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::cc77:910b:66c1:524b%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 07:10:59 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: linux-next: Fixes tag needs some work in the spi tree
Thread-Topic: linux-next: Fixes tag needs some work in the spi tree
Thread-Index: AQHYOkScgsk/xj9LYEmOA37VxW3HW6zEuPvw
Date:   Fri, 18 Mar 2022 07:10:59 +0000
Message-ID: <OS0PR01MB5922ED18407C0728F09941A486139@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220318081849.71228339@canb.auug.org.au>
In-Reply-To: <20220318081849.71228339@canb.auug.org.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b25be9d-c5f5-4f90-91cc-08da08ae744b
x-ms-traffictypediagnostic: TY2PR01MB4651:EE_
x-microsoft-antispam-prvs: <TY2PR01MB46516C00926AE47F6443C69086139@TY2PR01MB4651.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 04ol+cnowkqwqfOXy2tx/qkMedQw4dOMyoet5aJEtYyE+obH89l5Ki2nxI4Dplo48eoo/6tEay4zboa2PAwTbaaZ1uvAj0je6IbnYvv+U/7UgVzZSQGlc+8YS9W9QeS9qHEK87utr8bWBA8h5GDuKcTrWXs4PxLZ5kjnbgq4kJny/64ovu3HpJFne6XQNOIm8saXH57s8BCuTAfhcoPELv9eWhjZh866JcDRdba60LCH+YzVUQDAxKhE4PL+0r07PUsrasnsA+3/zF1fNOF7ty/4Zmv29SVBOvDD+tSKmpRy+XhleB7Y5Djv9vsSZXzhBaB6TpeEDaa5yOGpCtwXEk6txO4ofn1dAOebcnVtlBsrm5TA0KtHbRYZ7RIi4BE7ojG/j2lnvgNTjX6gRtgAndZU7snPl34bgmbk6I7R8f6rH2qXgZueuzGA8GGh+q4v9y30VjgxtjcCy0IssjdsPiAX/qUWip0jTjafkmFKo7TKRJmqbt4/GqqXyzYU3Nci+h6WntZaRO53s4Xa6FlN+yhJZCMlWDartxBGoPR2PsEkKEe54Nr9T6sWSovLLgQ3nUzjxvnjV/P/vOSPRh/U1bHG2XqJyO6VrL1q0iG8x9Pa/R3nLaZtaDzivYbEwq5D2hlMiio1WtU1OBLedOVhHp4vLlhh6XLwuh19LHZRmHkPk8pENWTGNknEJ8hzsqG9mnIWemAYrJGo6a7gyUixMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(6506007)(7696005)(52536014)(5660300002)(508600001)(38070700005)(186003)(26005)(9686003)(66476007)(66556008)(33656002)(66446008)(76116006)(66946007)(64756008)(316002)(122000001)(110136005)(54906003)(38100700002)(8936002)(4744005)(71200400001)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FSs7GLS8H6WUS6tUvp1KOtU2sL5PaXWzv8SB9p6EKA53n/8w9k+70J1y6Y7V?=
 =?us-ascii?Q?YMP/Gg+8cqKQs7wjwOj4zwjWyKnZlRiOOrwqbSIZr8owpbtpS1t+mo7J+zv9?=
 =?us-ascii?Q?B5lDKtFSqV0+IT0VGbv240WAYvVkuYB/cLFaIwF5xe4Zcfg+s/6kPCAp3dXv?=
 =?us-ascii?Q?gWYWkRams4JCpUWSJ/K0aMyCPSBU5MGnuaJsj9GhPE/z74ELGdW+WhnecfX2?=
 =?us-ascii?Q?utYAlZTy8jic1TgLbqOOFQ02bXQaK7Z64vgr81PsZAZX1c0qmhx0WC+hGjLx?=
 =?us-ascii?Q?U4i62DULLPAnZVEhjPcqPqBGQCp6EGWq0qT/GTbNrLw6lB1nvJLfBpY6wSaN?=
 =?us-ascii?Q?FqYeGDC+Lkc5Om3x33eoOEXmZR95j5VR4XS2Jr3l3kz+tCLoKFZGwc6Vs14W?=
 =?us-ascii?Q?4mBAFKn5oP+FdM+LIFC4wxf97NBFbCUmaFV+zLtDu1ddmHvDV3PMIpPq7omO?=
 =?us-ascii?Q?0wFtAEUdt8MLHXvdqNJ7xlE8jUOMRyGfCKVnMUkE0uBJgeE2vMKMbwr8VuEI?=
 =?us-ascii?Q?5JVvVbZy/VrBqj4/A021651jOuoxmICyDQxX0nLJCSBKwuyBcvApbsPjLDr8?=
 =?us-ascii?Q?M7yydImq35o66/5qZUO/ToEbALTxJNDA0S7eO/DfYKijBgbgAC/fw6mcgl3+?=
 =?us-ascii?Q?JLw/yRiFyM6zqQQlEZltsrnNbGyNgb94iKOdon8Y/rH9Wytf/ozoqgzuJa1W?=
 =?us-ascii?Q?gtoOiOKXBGU1opejDCsmxgKzd4xACIxMkKa68se8g3vCKS4sg93XBwx69Gs0?=
 =?us-ascii?Q?fBfJuA+gYFoL3pbpXoAzEMeGmTj7QriuEGP7OaYsLAvLw/V7axUik6GO2x4l?=
 =?us-ascii?Q?qkCLOll8hfhJw8eRTciuGtEPaWWqF1NjukkSQeGv7Dn6YbnLPR0zDGkiRlfe?=
 =?us-ascii?Q?n41a5cmh2Z+rSSTKaybuhZjMFPgWgPEawGy8QVoNkQCgHtktg9nw9g5oUo7E?=
 =?us-ascii?Q?0rxw/3C2wlhkdZZPrMJPh1ZzoLcyoAZ3c6KIq5ZT0X+shafEpR44fzYkY8fD?=
 =?us-ascii?Q?ruEz/SzpNHfNguaIjk32rYVnrkAyge20QMF8ygQl+aIEkZ6mtPw/gpaGfFI/?=
 =?us-ascii?Q?vVFTwcFCF2sCQOajnvXpBjcKkO9KQOHbctuo4VVDxQJxePyAZelMTyUxuvHf?=
 =?us-ascii?Q?L3J30NpdoTm2xVWVs+zwbKfYMIiEfTXNlHx5J6lm7xHTl+2g8s8JYBouVEGm?=
 =?us-ascii?Q?B70Bu4ll3WOka5wTONtpqOrBDZMACvMEbqFEoEHLaqpISzjhAOZRG7gWK7Nk?=
 =?us-ascii?Q?MONo7MihOQisGrzMZ2y7oVqRTFVMyrma5wORCgVFoGZvGhoeTwOx/r4ycmSo?=
 =?us-ascii?Q?hzABlfpkCOS5lAEwVGi5VIeBFqSc/klftTe5mLFB5c2fUDEYuvSUz28ejvDs?=
 =?us-ascii?Q?QPK7UfZWBYYelvo8OkehgK/LTCKlKX8JMIM6X+PZGkSNCxFCDzeMTZfujNZr?=
 =?us-ascii?Q?sKK/qu2MX4PsMmXR20nRnFA/sJqUNVm5ziOVbBi4UG8oubad1bPO4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b25be9d-c5f5-4f90-91cc-08da08ae744b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 07:10:59.4475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eljmnQ7rFlHKGT0ZBmB8pXkbMcTWGpUlloOCtIozqeG/PQohTVgyR8qlUa9JnEEi0Rl9CbK6BPg1BgXbFe5WBwNY2S8NljeeYMJh5a7GtWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4651
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen and Mark,

My bad, I have added Fixes tag at last minute and missed running
Check patch with that change.

Is it possible to manually fix this?

Regards,
Biju


> Subject: linux-next: Fixes tag needs some work in the spi tree
>=20
> Hi all,
>=20
> In commit
>=20
>   ebc4cb43ea5a ("spi: Fix erroneous sgs value with min_t()")
>=20
> Fixes tag
>=20
>   Fixes: commit 1a4e53d2fc4f68aa ("spi: Fix invalid sgs value")
>=20
> has these problem(s):
>=20
>   - leading word 'commit' unexpected
>=20
> --
> Cheers,
> Stephen Rothwell
