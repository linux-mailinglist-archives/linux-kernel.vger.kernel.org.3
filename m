Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A68552106
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbiFTPbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbiFTPas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:30:48 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B020038B8;
        Mon, 20 Jun 2022 08:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkNZDXj8oz184Llv7M82EcE0wp6jpCkERuxudQcgrvAEiMhRbczjNO1755ao93x1R4iWvNUokKAP75d61Wmh/ady/nRUkIAGS69t6CvMK/f1SN4jIn7zjcRwZAOuFfqvcFporAb3bpXrZ6JvY57x+r/PSgm0NPvVIfNfr6rg3Pb9aI9zksmRdo64rUngEPBtL1pHyXVI0+erm8MNJmoy8DB7dvsggJIh8YOkI3qf7xr43m3iNVCpR+HqsfZcyfhHsrXe49PAZ7EGxSbokc0WAOtCdFvz1lSAHsCxFP/OAiJHYxsTBri4EG0FFU4oCn73iHtvjv9Dxjn8cLV8Fs8hBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8htea4wMlEqHshHr9yweuT97UELhq2HTX4liiKaNzc=;
 b=l9WhEEPYfJH1CeYY8t4TuDJ09t3AHbYvaCfp80ucZv7e9OmpdHz7jEVspO13s978P6aoTGvUhdyC3ELMO4RPZV0Piumcwc4d9ZwRpNtc0RajoZmFp9GT+NbD4XJ8MqUik37wchdzGcUkFMaHarBs8JbOiszqKib9QxS87mFI8+OKj617f5QR0jUK6jxcuX+4T5nC5fYoP07scJjziif7bE+YK7x0wqVYPmwr9P5/inD7xdcg5PAVmpg/w0so5Pgt1X2jouuk99poKTWasAFxiArrXd2v98y0EbhfrpV8jAEyb0MXixZCGuI4NJO/NS9cdMfMirVlz1zoxC4yNEmrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8htea4wMlEqHshHr9yweuT97UELhq2HTX4liiKaNzc=;
 b=Zsgw4wmyjoRJuVgxT7ASRT43ScRK8izS0ePgF7e7hsZyjXyHdt1mLwHqslkh8nAyDmRgx9IkmS0YBSJuzv4D/eXbDBzy6fLGnlauIwxelqqDBylprSVu0++vS/VUeUIwKP20/AJ07gFZZTO1c5/uqlL0yKzoYKBs7N6vD0mpUMLssCAckrvNkzWke7jRVMmxjVnOF33Naw2QnfYqBlzuP8B55z+SonxiVHLUu/0uMZyYuRBabHHJBwwCKRww7hNKImu4RbtFacXzPHwoYhB+XhB8TVVMS0oc+THcVAjuAtxM19YjwPzRaxxiKknUMuH6ov6I6d4OcF0wCvQ1yXSZeA==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB8135.eurprd08.prod.outlook.com (2603:10a6:20b:560::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 15:30:45 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3d45:c206:59e3:6539]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3d45:c206:59e3:6539%5]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 15:30:45 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Alifer Willians de Moraes <alifer.m@variscite.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8904: add DMIC support
Thread-Topic: [PATCH 4/4] ASoC: wm8904: add DMIC support
Thread-Index: AQHYhLj/Hf9K4uNXmUCdTum1nSiaNg==
Date:   Mon, 20 Jun 2022 15:30:45 +0000
Message-ID: <AM6PR08MB437600972B26E3A56E1190C0FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 9c204568-94a8-5e31-c6ef-c85f0262b07e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b6488c2-2314-4513-0109-08da52d1d84b
x-ms-traffictypediagnostic: AS8PR08MB8135:EE_
x-microsoft-antispam-prvs: <AS8PR08MB81359DAB52F0DBFE1A793CFBFFB09@AS8PR08MB8135.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fEhZvga/FgYjGfpkH2jUKUFGGZ6g6SwYoXFKh2vLFOxNy3545c2rXlfG58o9x86Jo/4KJ2o4QsNcJNDbdi7hLUmZRhfqYabZNd8uIgR4U5D5IYFQ+dLlrn9gzQ0kNIl1/5UjMG5i5JqI42QyWiKNg9AVtGdrK8OTbz7vIRQTHZKyCPqRbHIRckziJ6ZKkaOs7JhHcvnk+osU6Yyw0x013sJbH8k/7szf+mhOCMo4FkWH+uFKyxfZf0A3jDz/QfzLW9F08oTA5qicl/VHK0wH/BU7S4xZ4/wg8BDqU4/3GzEWQYzSOxhV/WpRaqW1NADU3crQzNySsm3oZD3R9+ZT+ve4uQtunsChPth1tiiI44l5Vn7P+7ye1tQx3Kalyihk00Zz3k1aWKMO0ffttgnuBxsSGrxR1S+ueqDPnKXYny+jtOULjfDJN7q2HtPqZW+e3YnySBXqBDlL9hc799bJAMF/LOrrxo+Lz91icx3pUjMZsJG4JZOhMB4kFEaVAfi84zSFALkxBKCjc++22FOdTHR3o5GfRMeqL9Z7Kiogy9sRu8B++QxHcpa8tBA/WDiKf23/wfGlO9KIeZWK0KXAxxUiIvAF/4lngW4520O7yejBYwc7Hr5pvyMDrXywONKOVETpT16rAwtjkhd1PrtzZqV3mDqruRE/3aCx/5TOgi/oBQ8JKd9PFsBflXiBqAeO02Gh8m3tk92NOC3WP7yPnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(136003)(39840400004)(376002)(76116006)(4744005)(66446008)(64756008)(38100700002)(71200400001)(4326008)(91956017)(6506007)(66476007)(66946007)(83380400001)(6916009)(8676002)(26005)(316002)(478600001)(38070700005)(2906002)(33656002)(86362001)(186003)(66556008)(7696005)(54906003)(41300700001)(8936002)(55016003)(7416002)(122000001)(52536014)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LvgETahlGkk79Crdw5EGPOFqpmfWbLvqzQ84cEQVk5BjfN5rQU27MW/Tt3?=
 =?iso-8859-1?Q?fcMZUSqCmbeLyJPe5RnbBcWhcxSpORPwMir0u694BEqlQQt+St18H3Nlf/?=
 =?iso-8859-1?Q?ypVCi8meaxOibkvkrAelimTT0F9sgatgihpgn5RHKF1/iBimL3EeJfQYQW?=
 =?iso-8859-1?Q?7cwOn9liQr3Q4fEeUkHaJfH8sTGHmQq/Wi8nugDFdUGqm49py0JShiRyaQ?=
 =?iso-8859-1?Q?DVa2V1cnx+zK8UmZs2TgKBjPok5CN8u4lb6fmIzHwpUpL93Ym7VdvrrShp?=
 =?iso-8859-1?Q?PisxvnfloAW43veg4HyxBpgXqpz6IJPVEPma1gABUgxlSxCgX/7tbYYHPD?=
 =?iso-8859-1?Q?rI615RdI/hQ49TYw7Lyesu3A1BysV0W6OySSLf7nc99rBQyujHuKliBlxC?=
 =?iso-8859-1?Q?tX27OCYu5OTkkE5Ogfocs3n8+pkaWctReRbzGQCbq3WE53tEtLos9mouGE?=
 =?iso-8859-1?Q?2GQ2k//yAsktjxcED0d1H9Xcpq0xEg3fcl0jS5gKct5UvK3PZNCtiqe/R8?=
 =?iso-8859-1?Q?iBJsn8H9Yy0fogm7Xqe+LNWZKsOaK9awJRThy/6r/W9e7ROQ1uU+65QIJ3?=
 =?iso-8859-1?Q?uxmmEY1nUrydgWvx177wGfa4Bh/E695Vb9RtJj6FvmuxahYnFEzqRmK5SM?=
 =?iso-8859-1?Q?mLGe1PBwDw05Pn6ZXYa2ld8yCmL2YzIucKNLRYt5h5Y5QJlRqbtKhnj/N+?=
 =?iso-8859-1?Q?saxufiJjFuLHwIO+PQbnfMICzIHblikpJoNB6oJdZgxRnRKFLhPxZU3ppb?=
 =?iso-8859-1?Q?msX/rWvnAYUX3OQ0/bjTqp2lRl3C7Q8vPpxfgvl0+6W3C8rGM+ybHAhsGz?=
 =?iso-8859-1?Q?xLEVxvpNftY5+UEXtmohgOK6ALQcEWbmkb6h4VNc+XWoNqND/bROwDmhwL?=
 =?iso-8859-1?Q?DmjIZnV8xNsjhu5V+9xQCykyzZ8jCzuBPADgFs4Jsnr/zDoUrfofoCRhBF?=
 =?iso-8859-1?Q?l/zHH54iC+xQ9/u16cxuh4WH/to3FX8bZyuh4oxQ0LcBElcG/uTKnD3zzo?=
 =?iso-8859-1?Q?lxl9fo2KcsoeewRC4h3NF76uDDHHS2/4lI0xfLcYlyAxH2r/dKKypkrQCB?=
 =?iso-8859-1?Q?Lu1UFT5lANSFPgc8TASG3zraf96sTQInvYYSPIOHoXwv6AjF8tFwKlqi0V?=
 =?iso-8859-1?Q?lXRieffUmtUEtSiRmn1hlsecGV8pOiT6ziOnPm4f+kiVjQ8c6kGvrJE5pb?=
 =?iso-8859-1?Q?dNToVTkjYj3G4uU6fbLoZAvYF+7IvTMAv9uHyS9iuv50SH3X2yEJWazm1Q?=
 =?iso-8859-1?Q?7XUYgs6JPfztF1RSLc2pf6WeRXXRjA4Y6NQtwVxxPeeGNDLxcpBgQOL0ip?=
 =?iso-8859-1?Q?E0DgPhw7e1NgG7tqZSVPfx17B2W9pOW1Y7SL350fXLLTK3sAZ+JctTVT7T?=
 =?iso-8859-1?Q?o2Vk0EbYRI+b1jQdXBBYtkDPw2cpJIsr1m9tmq9IH5qc/s6OymKH+zOskv?=
 =?iso-8859-1?Q?CGif9oOG0mpIUe6/1GDYweD960CXlmgAqAzVdWAtT6Piq8ViOrgZjuY++0?=
 =?iso-8859-1?Q?3AstAkMoF6wQnOASMQEASsbglnjpnRP+E/wXQX6zblJMFuXxgbyNBtn+Lh?=
 =?iso-8859-1?Q?YHd77JFHXczL+LT1NFT8lrEgXEh1fSnDpCk8yxr8eJXMGjOq9e+/MweXMr?=
 =?iso-8859-1?Q?qajCKfkrUqOrc1Q097M7im0UoCAvyPZmSkksVVp2/yuTTAOuxHfpr1VMGc?=
 =?iso-8859-1?Q?fiLYb9hbrkHpZdN1TSnfiWad0NEHChvMuJIGnY4a7yC94OuuMmgFHs+uXe?=
 =?iso-8859-1?Q?+gXFD0DBD+tWHb3WhMXnGr04vy5+QcMMYV4hJ9zxOgalNl6MORtz7wpuWM?=
 =?iso-8859-1?Q?vT8Ba9UDeA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6488c2-2314-4513-0109-08da52d1d84b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 15:30:45.6314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OuALXKIsdqWknT8o2pC2SJ4UXgc826B+XCG0namFpct0DCNZBdhKttyadkGbcaQC+eGRSwpC8HV+vC21V1dkEfgkDDfbzbTbUBlWhw/8vI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Via firmware description.=0A=
=0A=
> > Can you please provide any reference approach in the kernel code ?=0A=
=0A=
> git grep of_=0A=
> git grep fwnode_=0A=
=0A=
> and I don't immediately remember what the prefix is for ACPI functions.=
=0A=
=0A=
Just for my understanding, are you suggesting to set a device tree property=
 to force a fixed behavior in the driver ?=0A=
WM8904 allows using both a DMIC and LINEIN, switching between one or the ot=
her and this is how we currently use it.=0A=
Why the user should not be allowed to switch between DMIC and LINEIN ?=
