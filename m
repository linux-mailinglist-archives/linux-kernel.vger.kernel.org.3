Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C817D4C610D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiB1CS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiB1CSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:18:55 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2090.outbound.protection.outlook.com [40.107.114.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ECD50B0F;
        Sun, 27 Feb 2022 18:18:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvwXrfHKr00dB7lYAH7tZH2Wh65IYMkD50SIan6DMgaDaYAOpuh5KEUhS10uJuXlodHwiSOcc2T6JB5Vb/EMERNU/RDvZsKwZ4/nltwGyaaAkW6+0Pde1cwxOXyaJbZlOLvfwd7Ep1U/WIWolnxK1WhFtDFRbtZRHeEvm4L7wfhrU1hJf9B3Hb/o2hSJZoaOEgAg6A9lwT6Il4EOLU0zrVv7UVwkWGC40IV59ZVPAbfvujPlF8RURjJuHJ+7a/I+FaG7DYFYb1oSyd/SNAa0DCazOoVG57h1qx4Ll/1qs5Qqr3hBIjX3/WetY8M038/YuhqUWnVcicfcQA9tr9CaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ip/bj1TZ29z7sYlnqMWkdep5c34M+/uqTyGDOf+jJnU=;
 b=kZ9ceA+dC8Ya1BUsj9D5syRG88i95l3HWkL44mvExoyghVma9Y0/p8zKgDZ9ou6NOVQ4v13V7asrWiS0s7urO614Q/AsLsNRaWECyLfLfo3zJYz1Qj/vPZH06onq/Ut6lT8mtpPkxyq3mr1dtMxFNUAW57njhfrCtsjg15Jw7Js4/j3RwHUnSaGd73rYvbI115jl9soxqKwXx2SfTAV8bAVQ0TlDiifjupYViIZBhCtsk9sVY2+YijtF2DVNLOcOl+GpsPPYwQ5opk27Pbzg//A/QJcUKAGCqY9yw7vXFEkd9fkqwFK2TVkElMhFpPsPi2co1YaAMg0gEUaSVuYMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip/bj1TZ29z7sYlnqMWkdep5c34M+/uqTyGDOf+jJnU=;
 b=BvsdxNGck9KzScGsCzhkXaW5axs7buIDf+cwIFfIaSfzfiwG8XX6LhGNcP6Yuz+sjFCaF+AffgUzA++xyUXPCoYFnNlQCMmeNwQbRFDxOnZqT1K2GEf53VN06sQWicgSsAccUItQ8bXyt5fTsI+pXFt1ixlYTeB1RFtaN0Wl1bM=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSAPR01MB3665.jpnprd01.prod.outlook.com
 (2603:1096:604:58::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 02:18:15 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::458:e316:da3:511a]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::458:e316:da3:511a%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 02:18:15 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: usb: renesas,usbhs: Document RZ/V2L bindings
Thread-Topic: [PATCH] dt-bindings: usb: renesas,usbhs: Document RZ/V2L
 bindings
Thread-Index: AQHYLC/ufjTQ3VJg4UuoCutmzBFRuqyoOgOA
Date:   Mon, 28 Feb 2022 02:18:15 +0000
Message-ID: <TYBPR01MB53418B04F64031354B9ABE79D8019@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220227231531.32279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227231531.32279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a7c029f-9246-481c-6585-08d9fa60942e
x-ms-traffictypediagnostic: OSAPR01MB3665:EE_
x-microsoft-antispam-prvs: <OSAPR01MB366504CC7AD88670F94B94D6D8019@OSAPR01MB3665.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kYNkOeg1yuFTvbwaoltNC6SM3BWg0Q4D+NLsIYjZaIX9lrXSVoQV8nfBQIh/1VRxCr5KOk7xpZqHvFynlIyu0EF0sk7lfIrMJTAcNjxvV1YFMVvrLtpAlPIbwYO9UGXKz+X51iFbyUcAhTzvgykVPJKViE2F693/UTvxR1XwN9d/Dy++DUVW90/4PM+QocdUfSSCFkuzXvFsSUz4bfdTcxZWCeJNHGVGPaxHsiqIRfWLim7YM9OtbMWpwIx+DcAUB+UyiXxWCGvLsFoxH+wJ1aTQYUxiRq3T5Av2FWHOLa6Py7P3p1pPMK7z58D3ceQL1yQoCx+7L84JkSRcxNS9ykbHmqWgxlcWunuqpk4tsY3Qulfjm+bBbmRQuuyDJe3P1Q7JVaVWD6THVQ7vC8hRFO58/vi4y8nSAE62NkLZrHQ+Df7tmpNOPFOkiSgtztQ9uFGYmZxUgtMTzBtgEVFY5C+uOh17ZdcR4AHLZGzTJ6cS8+W6vtMxg1Lxec4ySroeYyEVZiS79yB3sCzvvdaft5Ugz+GgsTaAECw/ZIhlprqjD3iZT9oRXj8ZAbxMYsg9lCDacnJtHyd/9EG0XcuptBptJscrJqCruSfrltRZD63XbCFFsMVJiupWDp1XrEYL7Sorn1p4lwlUnQRx854WIrrs/zxJRMNAKkG/jtutjELlZdr+FWiUGIMQqtzU8F8KQkTJb11+JxHb5+zZW1XzQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(54906003)(4326008)(83380400001)(86362001)(8676002)(33656002)(8936002)(9686003)(5660300002)(64756008)(38070700005)(66446008)(6506007)(4744005)(110136005)(66946007)(76116006)(66476007)(71200400001)(52536014)(66556008)(186003)(316002)(122000001)(508600001)(38100700002)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZnHIaHxo0b73QvyUGGydY7n90j9nxcm4Pg5/dDNlp/NP5JVHrTvALM8HV4hs?=
 =?us-ascii?Q?vsQR0BSQgvlOvkcMiGj6NAPzhFW1l8kfygY32EmKxpbE2LSGeZyr4oPODsSr?=
 =?us-ascii?Q?Iv44fRsFowJJiWitDLN3NXNhRWRIEwHRCC7Ezxua7jc3mRvpTzgnyybGYShJ?=
 =?us-ascii?Q?Efi2wHbIfrvY5P3alYa0uQxG9NjQ7Z4IRcuI7p0yBrurh5dZO/+OGpno2lnx?=
 =?us-ascii?Q?cO61H8P+27Mxl7a6GkceCllGsSsKNE0D9UoR4NsCJ0oWGxOJLNimmBWcOEcH?=
 =?us-ascii?Q?afStlh4k3C1qkK+17VhkfB8pbJ5aguE1ys9SACutN8RDvXaW+a+792e+Z+T4?=
 =?us-ascii?Q?4WxiJ8eHChKgl/ABLNSbyK+ayvp2m+BPij8dbaJeFrdj2s2apSDqOVkl7x99?=
 =?us-ascii?Q?ZyrvbVEYCBCE7iUMlTMTrIb+pkgFdPtMQP35m7AtXBHEEE1Z04VD3HwUlKWy?=
 =?us-ascii?Q?tcZQ3x+NHaYlniyPFpsH1kHObGOT6hDWQd6HVntIWQZeVyUENiyzlqv22R9s?=
 =?us-ascii?Q?kYJaYEOZgGFCBR52cPAPZl34Z/yToNoQuFVabgeLVHSsmlBjfNyxUOGRGkaq?=
 =?us-ascii?Q?8GxIHY8jODGoaXDWLSW7n+UUwHqF4la2jOwuY4hy+1ylY8Pi7EsCQ3yAafBj?=
 =?us-ascii?Q?0EYbCpjz+/fU8cOSvtyiu8aKtOfyY3N1qP9s/IEOmUrtaH/M6I2Irt8hmrRH?=
 =?us-ascii?Q?ClCSjSYeHS1Tjh3i0sNmkWK1ZWjnGwzQ6KMBTWaN4GE/ZLCsU3So9cavQjdI?=
 =?us-ascii?Q?qmW/UrKcCgyUAIkPZzF+U8XBP9TSQezvDjhXqo3cEYC/5g8GCYM0MF3/Tupn?=
 =?us-ascii?Q?9KtqRbQgRT0MoxGXLW/+uPw5UdHGdTUX0NjtcWMVTS1pUtovxFFG7XmEpmHH?=
 =?us-ascii?Q?WBhwKoVuXpy8slmNvkxVKUB5bhE34zPHHbKl7ICF/vbNRqu8mmjYT3qKhRi9?=
 =?us-ascii?Q?rSlYiPL6ylUf2ZhwdMwnaAr/qms7LdgtOFPjA8q53Vv8EhNLCeNy9PYLNSPH?=
 =?us-ascii?Q?oidKYWqR2uQXRXvo9+XlPgf28ZV9bqT2ZTco+AKG7UPkSWNvt5KzisGDVkmI?=
 =?us-ascii?Q?/1xyOnIiqk7WDA6NegEc/8QAsREztX6iu0dHlWb3sZIVMG4BaN9j5DjNhZ+e?=
 =?us-ascii?Q?TZEjYVKedEhcUmhjYlYfwFUg/bSaa5utOyJKiH3rKTJeZ8DSfY1aPbCELJvz?=
 =?us-ascii?Q?qBfxrI/g+9Ea3O1A3+bZprIi9l2eaC5Lo5vZyux1yAVp1YcTIdtV289B9rgY?=
 =?us-ascii?Q?8n/a27F/E8ZA87iCjOSGp8UFKJVAlLm/oLVPnhCf7uE20wE1LUXDodxwnsOe?=
 =?us-ascii?Q?0RWGtHubsu8VTlAZbdWN0wckabFi20cNkdh+daZcTF2ls4MrqTqkl8DW+UmT?=
 =?us-ascii?Q?kLNSlzsJAVvC5u5vUTYqNNZQVarywFxcbfS6H8ZFsKaMesnOgReGAOYe7DLq?=
 =?us-ascii?Q?QgHrZBMKfhPnPaOV+gXIVhbOh9XqkYacKD/NWjmkNbfHPFLOLiAuLau6+7D7?=
 =?us-ascii?Q?/m3af1ACEtkP9h8hIL2iUgxIqnrIbPIvans6KBKXepXpodi5oR9xSjc0I3JT?=
 =?us-ascii?Q?FepZYFiBpT1suDRQo58MaeGyI21j8ZeKKWaf3CgP1HRK6a+L/ulJarKCd9sI?=
 =?us-ascii?Q?pBPbLj+ntM9zVJvxB2jwHOCUCPneT0jairDowFpKUnvvKmLKbVbCGbgPeQEd?=
 =?us-ascii?Q?TOyawRTSXLIeHGDfRPRfE2G3vtPoM4SciuUi7lo/2SNGGavDh86FrcsckADH?=
 =?us-ascii?Q?qjbm2k6FuFuZfydVeX1LqImuPYy3t4HZOpzfqxPrVqeGBaTt9ivr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7c029f-9246-481c-6585-08d9fa60942e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 02:18:15.8415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJcQnZNPaAWnEsJJxaWwGJCM6L0TSZzcWsVgnSB33lcu2uv95S1I2nlzsr76F/+LOvmFNRFO8lQ1IDEo5WvLChbikwUmy5gR2B/VDT3ZHSjlg64CXLhwf4sFsLnCvLKN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3665
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad-san,

> From: Lad Prabhakar, Sent: Monday, February 28, 2022 8:16 AM
>=20
> Document RZ/V2L (R9A07G054) SoC bindings. USBHS block is identical to one
> found on RZ/A2 SoC. No driver changes are required as generic compatible
> string "renesas,rza2-usbhs" will be used as a fallback.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Thank you for the patch! I didn't have the RZ/V2L documentation though,
this patch looks good to me. So,

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

