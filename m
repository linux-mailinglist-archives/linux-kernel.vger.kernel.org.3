Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04B4C915E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiCARVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbiCARVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:21:36 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60102.outbound.protection.outlook.com [40.107.6.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BD2636B;
        Tue,  1 Mar 2022 09:20:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRJMkLXP4uOHwjIdHGuuUhi681FsKFuIHLqk/O0R6ab5QdaNz94AB8dK+TBhXYCwg1CW8nEZeRhXuSwBTyVhJPsH53TODB7SHYOgk1rEeP5IoJDHf1ok7JDC3F3yoBl3n+qJuBFLls/WDll4zWf8EREX+WyTEGLryE+1NEKrjliAVPbVWFaVLYpA1Dgz0okj0yKjw4GW2QpAgwcfVPuZXh8Uk58OAIsbU3/qs+UWfKL6uMaMgDt9hJIULl8G3nd7gB0ufN+COKw9AWKQeSvHvwoqK7MVogSdF5PhO9ez9sPVdL+CbRNmprub69w0ydBElOrQ/qHoy3figXCag9/CEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xMbdURBhqtdqJOmGrEZEnGdxmtkWd1rfdBb0baoRhU=;
 b=f/OI+Q3P1lf85GrZqe8kKyUp4hZrq+IsqvWTjCzkVbpumHeQtMZyXIR5aDxfXipw2IzmvV94feQ1ZOphjHrpRKkiGia6KCdl6+fovs+YEocsNySHGFDOSuv61D1yeQG/5Yt7fJi2TA1aBwY88quRL+/MHjPBfMAPOTfQSyDyz5sxy+f1Bi6GBUolSverz/1OIcP2tnD7ETB4EiMghRuEeCR/v1q0dLVohcZrDusM6PYvsinFpcCr3DrKEyXLlcI45Zzc5LIXNLdKme4LsA89g0LeB5/s+DGef2DEgjUFvXQpihzs19HRclglK7kVNFqaSHW4U+I7hcW/uDpIVtnODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xMbdURBhqtdqJOmGrEZEnGdxmtkWd1rfdBb0baoRhU=;
 b=FqsWNvnQ7rJyGr/KsM3Ns14eqVfflwmWqoTfLVXE2+zmQ65t2n+bpg+VUBKVTFI4JMsNv7Z4X0tW0NxFAyRakj/3wFraKX4/H2zaLekNaVkT9VzsM7BMQzVfN3mah4OJtbFY5lT8gAkWL7ADeW1r2xMT5X8+LYRFrqPKMTcL+AA=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by VI1PR03MB4607.eurprd03.prod.outlook.com (2603:10a6:803:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 17:20:51 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e%5]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 17:20:51 +0000
From:   =?Windows-1252?Q?Alvin_=8Aipraga?= <ALSI@bang-olufsen.dk>
To:     kernel test robot <lkp@intel.com>
CC:     =?Windows-1252?Q?Alvin_=8Aipraga?= <alvin@pqrs.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] usb: typec: add TUSB320xA driver
Thread-Topic: [PATCH 3/4] usb: typec: add TUSB320xA driver
Thread-Index: AQHYLW8v7KcQSACO90u5wFrwbstD/Q==
Date:   Tue, 1 Mar 2022 17:20:51 +0000
Message-ID: <87h78h8u8d.fsf@bang-olufsen.dk>
References: <20220301132010.115258-4-alvin@pqrs.dk>
        <202203020056.igXsHYzi-lkp@intel.com>
In-Reply-To: <202203020056.igXsHYzi-lkp@intel.com> (kernel test robot's
        message of "Wed, 2 Mar 2022 00:58:06 +0800")
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49e6188a-33d9-4f02-089a-08d9fba7d603
x-ms-traffictypediagnostic: VI1PR03MB4607:EE_
x-microsoft-antispam-prvs: <VI1PR03MB4607052F17E4E26E34FE93D483029@VI1PR03MB4607.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8X+5jA4utspCNQMpKTsIvoRRd6lsFID0IIMGAnGhp6Z3FGV29jQ5TyvYWqqIGWX1UDxXQrrFfbWC4JIJgk4M+jUY8Pg0e9jld/qC2fAYMHygUDP4HX9TZS10qs02XLv3cx9LYuvZn2Zz4JRvFLteyU/KZAHBQal4Z3soADsnJ5+fZYD4i/sE+b+otHGWG/b80vrrEtaRwZ6e0lXJWfGbjopPZiUPotHG8a0W5BquaFCLsT9eHIyZarFVQq6U0kYQCD11FAyvqdlGMOst85Q369DtJFQfyidv8kmr9r5mn1Et/ZAYZxqJoO5/PgCegkg+Wi+nHEPlyogCps1kq6tHW4y+nMryu7kmrgMtw+PzgZxp6Frf73xQ6a8kBDWqMD1bUM4bYh7QwLzFQzJHk93SBIn0a0Z11vT87jFqKF7RvSyHDPMJXlgu3+ECoiPf2Wk2qQW5UmLCGFEL95R1Mqts9XW36r0U/iWtLvhb+vaOMRsPfu1ddp9CEayC/4sJdZI6Ia5QLLRWFQ5TW7qYKO3+WG0dFR+LwxlEwOS9QxvF5TmjdF9KObNfBKCYvO9mW4InfVz8L+K7N7R3CIWJyCsxwjYGUz5HUx8DXfAm2dzPw2f06XIiJ8/9gc0JgrEJzJF5hONfSOuBzR8laDC1UzJ2h43dUYtok10GFHz83McU0/zoz+Ek+WCAAcvaMcc/IjItxWVtqxHXpK9Ov4MEU02IQTvBYegF4L9Xo1+hukgDLZHq2x3Z8F31ENE9UGm5rTa/Y1Av2KTHNpfJ0fUtr9IaarMvwhWKj0vb7y08tnY8Drw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(966005)(6506007)(8936002)(8976002)(6486002)(38100700002)(508600001)(5660300002)(36756003)(2616005)(186003)(38070700005)(6512007)(91956017)(76116006)(26005)(316002)(86362001)(6916009)(83380400001)(71200400001)(4326008)(66946007)(122000001)(64756008)(66556008)(66476007)(66446008)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?xKkmnlzrHNQOdeu5666gLLg9fFspbVHdVsBSaydxOVFZhA5hjSETKBSx?=
 =?Windows-1252?Q?EdzXKtJAIUnA6tstYSSV7SDpmRERkJhpoffXthuR8ZHuDIdPGuEkhhUj?=
 =?Windows-1252?Q?xqJjbK6hbE3fv2DnScU2lajm3xRF3XjsQyYmV29Oxv6aa+tYc7b71+bL?=
 =?Windows-1252?Q?M5gi4fz3zlcfgLSKsyJlnjznmjUFN0i4s1WVtdkOBspXD8Bik9hgsNm6?=
 =?Windows-1252?Q?KyrA/8o5zYR8i3f/ydGGgRHKZ8DOLcsLmxxAtpios0M25u7wuiS7Q7M4?=
 =?Windows-1252?Q?76o4M3FBoYhQBLqZoYjaLfEgurq7pG0Ya25l0l1PDdCOgVSondHFGDOx?=
 =?Windows-1252?Q?s7MCRsH3j0IQvFYuNm/4G97qXg1KzBb3Wk3ApaGuhJciZ6PTn/CFRjAJ?=
 =?Windows-1252?Q?D7hzigChius/TXPD924YarRuAGRsmEwY7SPH4XVGl9QccC1kb2ak5hYC?=
 =?Windows-1252?Q?CLOxpyk4C7afQaPt5j2yHXEegdsIgxhK5Pi6iyjj1ceetxLb5p+O0/or?=
 =?Windows-1252?Q?8Xhbu2xiQZZ1VHgVsYA97aTbPVyU6h5Fl21/d7EJM2PN4va66FocOP6X?=
 =?Windows-1252?Q?FXLjplCoayAB/iM5wt6pwH2txJYJcSrglVSTmSFFkUpzc2i65/qfNhxO?=
 =?Windows-1252?Q?5rZ31ft2x2cx7WuPk6tmrl2FfBf/G/Ui5QxOkCVgypc2SnG3ytml2rk7?=
 =?Windows-1252?Q?ByTgPSur35HX8TbH2WQXBNcEnutXdTlfHC+jGSFxSPpKnwenIW4kwEXH?=
 =?Windows-1252?Q?rE3VDHrCIfLB3GZ2NCxXgIWFP4Y0ViFtf5m755EujdqryRF0YSMHTufF?=
 =?Windows-1252?Q?LZIsEm9Nx4Uuf9JDJs8MCL07FPfEuJ8AF7CglBdHEFBagwE05HgTsBV3?=
 =?Windows-1252?Q?AAmDAUCDSL5p+dTfzlL3FPYssyFq4ppx2iZpBPcWnnTsS4qwhxmQAzci?=
 =?Windows-1252?Q?pBUwXwDkw0iBB44P85R4q0KBvJ8OmOwHrtN8HJkk+sFW5EL7IHOm/dRd?=
 =?Windows-1252?Q?4Kii30smxLichFcHn2+qWuzgWnzJ9L6Nfi7wtcInQyIN5LAsM//rN8Ez?=
 =?Windows-1252?Q?2AKCMvHaOwb0+kFjtqK5oESwOSoCFiNFpJiyOa1uKZu3KAYP/Sdn+LhS?=
 =?Windows-1252?Q?nLQq6SJqkCt/UDNDkG8mr+ATx5rZJUQoODEJ3jI7vA9hWGLuoovNu5Os?=
 =?Windows-1252?Q?07Vvbha+tPU0qENePOpKEXPGobgLaV4TI7MOplOlz4VFhG3gpkxr/zJL?=
 =?Windows-1252?Q?ql2OS/XoKpqM+8KQXGMoU8XzIzMOVkgdPm3MW/sfpNVV7dJ1BBaklel/?=
 =?Windows-1252?Q?zuayavcbGnGQhXlvCWl8WEgPlA1fTYL2Z3LKXBRA0uG3e6iXFO3FCLxI?=
 =?Windows-1252?Q?gztwIjTII0Xwi2KSM5I5Z4nmz+kcZL1hMuFlWDXh0poGGB/wAatec4M7?=
 =?Windows-1252?Q?oDtKozD5WxZa/gUXfwyw6UbgHFrmTpPnSKXzHRXpUwdbqJX5CsHjl/OF?=
 =?Windows-1252?Q?5Dzw/L1M0tgw8qdxeAAf/WGQGZFroN5BhbKT0X+ssEupd6C9XA1wqO00?=
 =?Windows-1252?Q?0ljXPVtOyn6rcSZ62g/7rqnEcW7pi8ftjS1Z7QPe6eCAG/mYsT0nZ57r?=
 =?Windows-1252?Q?Up5pPXuXXmoN0lhJMMjSEWoE1D8o7aPQ1EudIHXb1tTTxg614Fp/F1mJ?=
 =?Windows-1252?Q?g8Z2CjIcMvNuntX5XGzt9vVfIptCUSGrgqmgcXxNn1Sc1jr9xyUs05xH?=
 =?Windows-1252?Q?ae4D5WJE80548hnEW2U=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e6188a-33d9-4f02-089a-08d9fba7d603
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 17:20:51.7331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QrQHKZrdpYOTDeV6pFqIUBuEapBGSW7Wqq2q1fb5u0b5/3+y3/LU1iznobvh/YQOrnAwuUAZKhjDfbIBRf/hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4607
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Hi "Alvin,
>
> I love your patch! Perhaps something to improve:
>

<snip>

>
> All warnings (new ones prefixed by >>):
>
>>> drivers/usb/typec/tusb320xa.c:407:6: warning: no previous prototype for=
 'tusb320xa_action_role_sw_put' [-Wmissing-prototypes]
>      407 | void tusb320xa_action_role_sw_put(void *data)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/usb/typec/tusb320xa.c:414:6: warning: no previous prototype for=
 'tusb320xa_action_unregister_port' [-Wmissing-prototypes]
>      414 | void tusb320xa_action_unregister_port(void *data)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ah yes, these should be static, will fix in v2. Thank you, test robot.

>
>
> vim +/tusb320xa_action_role_sw_put +407 drivers/usb/typec/tusb320xa.c
>
>    406=09
>  > 407	void tusb320xa_action_role_sw_put(void *data)
>    408	{
>    409		struct usb_role_switch *role_sw =3D data;
>    410=09
>    411		usb_role_switch_put(role_sw);
>    412	}
>    413=09
>  > 414	void tusb320xa_action_unregister_port(void *data)
>    415	{
>    416		struct typec_port *port =3D data;
>    417=09
>    418		typec_unregister_port(port);
>    419	}
>    420=09
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org=
