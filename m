Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3102653734E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 03:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiE3B1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 21:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiE3B1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 21:27:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A401338BE;
        Sun, 29 May 2022 18:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtJWrYJbPG0qibw9n1PvVbpJPP0jsoqLS4j+YJBdsc+n0lJcMXiTDjxN/SpxpeM+e4/ZxcfamFaewPHH0VBVodYFcCUFnRS1A809uUZoGhUwLNmvY1tLCSb5V817ewo4ujmrI+IaA/sNw2pimduLQgRBli/ICHkL/tmZPM/zef1nJsmW0HDM9WMfrbUa/iJLMz8p+Shjw1MJHRn5EzCz/KnurXOwe6EvL/hB8lEwUD87KVVuYHl7kPmjZI99/0DJHHE+iYCw08c2ThoMFhCHT4+kR/zvuh5VTmMANKxCajwk26erluZNo9fDcM/JrS9DQSoZXvkTQC8WODHftQ18NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj+AcT7HOENJmL4MImIQ8MQA0ZAcHwcP40buq6TNdlc=;
 b=OBFlz8ZgmJBfBjMzuzyO5KZb6XM+S78ZF7mbvp9vFIik5q3iMzb9+Eqgff+559vYEf7/MRiTir3g00N6kAaU/tw+69bLQtDsn15NO2NaHR+b+U5tSle23yGDX/3WTNQYuToYHlSIz+XUtiWWt9Nq2V4Rf0xAumY/+j8Q+yCE6nogdufNgcXtSdVBXhpOsQ9v9AP4FHQaALtAghctt6zf+hQzrmpfAS0+k5CZrwjFIgss/hQMj2/D5cdJ1AWkynYZddA5hI+GhaWoTX3JFZFAKDKJMCvsCuqQLX135hpdbEDtsoTlpyHEA6e4VOBkCZ/E8oXSwtPJ/QqiQRQyB8wFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj+AcT7HOENJmL4MImIQ8MQA0ZAcHwcP40buq6TNdlc=;
 b=OWQ1kskfub1/H18mfRe4N/BuCDt/YfpSUeUEjPZw8gvaYG47Bg8u9eYKN/t1oLnKQyenzOPIutK9q8bb+oEq+GiDPVVXb2VxKmw/TkbsuATfJD6fY/ylMYeyiJGIqsTgE9WSYqaWboMkeKhlol68bXmdpV+OGhp/cOiaqf1L7fDw4clO7IL/UG7jL9dJhAEjZvh48CNx9N6HjHIhvOKG/qS6sZGpXL+ZXNqYWXJMDVA37T/Rlq9PMg7KLvOHr6U96W03VewmeYObONVs0+7KuNspA+JLHUB7ONe6Uf4n1cbegAIRr8NQ7I01PBr6uY/bS762dsHEbkjD6jUYnwzvww==
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com (2603:1096:404:97::16)
 by PUZPR06MB4659.apcprd06.prod.outlook.com (2603:1096:301:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 01:27:32 +0000
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::7847:b601:7d4a:1625]) by TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::7847:b601:7d4a:1625%7]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 01:27:32 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Felipe Balbi <balbi@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Li Yang <leoyang.li@nxp.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>
Subject: RE: [PATCH v5 2/3] ARM: dts: aspeed: Add USB2.0 device controller
 node
Thread-Topic: [PATCH v5 2/3] ARM: dts: aspeed: Add USB2.0 device controller
 node
Thread-Index: AQHYblFwkNTSfgr8wUWHa8m4woyq0602rC7Q
Date:   Mon, 30 May 2022 01:27:32 +0000
Message-ID: <TY2PR06MB32135A0DAA9F152E2498CD1C80DD9@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <20220523030134.2977116-1-neal_liu@aspeedtech.com>
 <20220523030134.2977116-3-neal_liu@aspeedtech.com>
In-Reply-To: <20220523030134.2977116-3-neal_liu@aspeedtech.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 460bd8fd-3579-4183-422a-08da41db9183
x-ms-traffictypediagnostic: PUZPR06MB4659:EE_
x-microsoft-antispam-prvs: <PUZPR06MB46591680A9EEC598C063C07880DD9@PUZPR06MB4659.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IBm0pTRpzjzv9fw2HuSYLbCfAw3LoKhRciELsbm8bY0bEVroynNFUiIYiLeKddbOo6gfiAdC/SwUVw6tmWH46dCeCZJTmDnaTKbp2EVbs4AaIzdyP4KqwNTAFfldDcIqvjXZvpxDAO+vVZ6zp49K5dg+BLmvFq5k3+0lpF0+NKuyjpCoueoSWHilz+YRzXKFdlcKgEqUUlpHKdrZcWbQ9LpJS7QivSFsU+1F3KGYPFOaSPxrbeWCAE4IdvxeqmZhGxpuop8GsTmWwC4Am7UNsHQge7PHAHKoQkzJCW53c94mnG9+5+p5/Q3BXfrVCXHG5NkCra0rZUPJhfUhT2+W8nz0f9Q4LxLKnAxlOhQfP6a0oyo2lx9F78C0FqWil23z+S7sWgHEhZrrrxvwgCVLAnqJeb+aTfE/bnDF2rwL0WF6G211GCKmoPVR6ldVPEAjOw/o17C4vyXBpyUV75jzhEP/2/kyl+MDJT0WQlB/HIV1M+u9ff+NJExt97LGykGoExNO+iq8UnqcW/sg8KX1smAij3blJqnrj6VNW6bdAvGoJdMXrRoeSa8I4bTXVSfurhsLT2NOshZAP3ocFFzgPy4GtBQgsTiov1Nonjx6RMVtjH7qs8Ymu3FPmKiXG5FVG/645zZgGbxjW1cEc9WHBa98cRtMLulDKkJCTm6pcmsS0KezsnK5UmjMWEXi+1uTrgMku5YABYfuunosrJhkwOxLBxnN70mi+M07UrmAHlk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3213.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66574015)(186003)(38100700002)(55016003)(54906003)(110136005)(4326008)(316002)(8676002)(64756008)(66476007)(66946007)(66446008)(76116006)(38070700005)(83380400001)(71200400001)(8936002)(66556008)(52536014)(53546011)(7696005)(6506007)(86362001)(7416002)(508600001)(5660300002)(33656002)(122000001)(921005)(26005)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vGo1T6Ncv4kk4XQ21MEeJr5aHctU/8pRs9K4XXAvaCP9ruY6FW7A6tSeqd?=
 =?iso-8859-1?Q?SGmh5GQ9Trw+ohNDPTRjD4wLQsuNwpb2oCNMOl1hPvdvQtiC41tiMTyA4v?=
 =?iso-8859-1?Q?kE/FU3h8MGb80erBrC6bFeEVEJz8TKGKRT34Vc3+4w3Mz9M7Y6iRlkfQy7?=
 =?iso-8859-1?Q?OYfF7eg/qZJLuriJTIdQE521+b/KnwOnDOdOaSBQe4a3uIw9tOjgvjcvw5?=
 =?iso-8859-1?Q?/7/dUjmBztnku//wCJOwzHnRxIAXjuDadOEuGR9U+4DxFCkZXPT6GMYib3?=
 =?iso-8859-1?Q?EZTYST0hkBspO8sNMhetnz3Qcx+k8HLLxjPIkuJ3Kx3EPsuLEB1tQ5DM2p?=
 =?iso-8859-1?Q?fsSGGII3SDbbD2lsmxRPA/CSJDbnnDfs2KNGZ4oXshtAiGclCLCEDtS1Nn?=
 =?iso-8859-1?Q?YIAInalf8rICveCJgu763J0ibJZf1Nm0NOZdHjSNDHiePTYTIhdrDw59x0?=
 =?iso-8859-1?Q?XRN0Dxwzsj5VgDFzSBnRdwK4i7vIhSCnTBnr8d6srGl+j/cp2W/Kof9pT2?=
 =?iso-8859-1?Q?Evo8plwGYifTVoyKdrG5ofowFH5RtNSxOxPCMxm4VdWwr0/KCqt8H1Tdjm?=
 =?iso-8859-1?Q?omzL7sgbT4empMTKq4CCKKBaFNXpC1aE/l2W+3GnC5M1ePiZibSC+fh+PT?=
 =?iso-8859-1?Q?FiEOXKSB6tUcbaDYKPdglZgGy6fiuTYR1A1wKarJwyLTDed//NOew2+mWq?=
 =?iso-8859-1?Q?AOXFoIUU9RWvobEouM/kd3f3xPbjcPNvrDRrFo2501hs5NQ0ysxKtFnLef?=
 =?iso-8859-1?Q?TibnyE1mAOU+P8UujIgjd5de2TYGs9TOp8P8K8yIhkIRyQd00nw9nzPoMR?=
 =?iso-8859-1?Q?fupuImhHFv2To3n1sDsYSJrBGkCZzwsgGz45AKYTuxFeD0J3KaT9pAaS+2?=
 =?iso-8859-1?Q?qzkQAIQqJXX+FCkE/OAXVmWS2BX728ZqvgqqTL31rs2Ev0eKmekgFlofnN?=
 =?iso-8859-1?Q?QhGt5M9ml7wYKxWXqqvR694LP09vhcfz6T3rDtI5JtKnlokCjRWvSTlirt?=
 =?iso-8859-1?Q?OE+HQhvTv4zhUWzT90PFH85MfS65bImB+7T/bpLY+vmRvpKMI4XN2BIUqP?=
 =?iso-8859-1?Q?VSzfYnVh4Zau59+td5Xoho+nOHaZdw6+wl4NH7CXdcFqyyNiG4B+us7Q8a?=
 =?iso-8859-1?Q?GE+3FOYuixl1lWX0wyzcZAwKlM9jqTBAQXB0H8ZYIvtbQZxuBq94B4mZSV?=
 =?iso-8859-1?Q?r4ZPNdQDQPezNPgCVu5LkB4CpYj+2W0dljDNSHn1PO59tzIOpsiWihZIrO?=
 =?iso-8859-1?Q?i1CmpQ9aeZkVXccv68PHz0mXgXoGMaF6zVoYKXCfLNgaydXZrKAXs3f3sM?=
 =?iso-8859-1?Q?pYzOreSS/3jg/yMuqd+faZyKHU4mVXRbht+SHqDr8FIE3avN6EUpJ5mXyD?=
 =?iso-8859-1?Q?VBIBQ1uQsI6xXci2+vtl/sCFTa0Dg6RYtWoeewi3eaBk5OJ3eatk+rw2si?=
 =?iso-8859-1?Q?dcwAV1HEoOSY1QUJ0hT2jam6sS1GnMJaR8szobuUtDg/4MX7wJswGkMDQT?=
 =?iso-8859-1?Q?lEQuRIVUVD6fxiv52bjjSnJbq7lEoNuH/byRbJODn1BdalaB+jfcj9IAxs?=
 =?iso-8859-1?Q?p9IDCY5sdq+33QIO8U+2X6wY8itgErIcpvuPMM+JUfSnbb68TyEz6yfq8k?=
 =?iso-8859-1?Q?fTNc4+9iqOdvtEvFGL0a7zqSGNEeKGXWyKrwLlqh2Iul5Tomt8nSXIPaY9?=
 =?iso-8859-1?Q?9KZK65nIZQ9m0JQCdMUiUN/IO6DqTaBCza29m+GURkmFfeHkqrZzx474JB?=
 =?iso-8859-1?Q?nSE9VuzsyAVnLLP2jyHd4A0ZbjCvLfVbzFmeTNjo8c9p/DKAY6XyRo+BVr?=
 =?iso-8859-1?Q?LTiRYN6M2A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3213.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460bd8fd-3579-4183-422a-08da41db9183
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 01:27:32.1131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exLNgph+R3/+hvwlmnHdrGFf6Mqelh8Qkc/9fRYiqcSaZfBxSmuacAZdM/P0sbtzAb99j02Cp49JdmCgR1yqmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB4659
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping on this path, thanks.

> -----Original Message-----
> From: Neal Liu <neal_liu@aspeedtech.com>
> Sent: Monday, May 23, 2022 11:02 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andre=
w
> Jeffery <andrew@aj.id.au>; Felipe Balbi <balbi@kernel.org>; Sumit Semwal
> <sumit.semwal@linaro.org>; Christian K=F6nig <christian.koenig@amd.com>;
> Geert Uytterhoeven <geert@linux-m68k.org>; Li Yang <leoyang.li@nxp.com>
> Cc: Neal Liu <neal_liu@aspeedtech.com>; linux-aspeed@lists.ozlabs.org;
> linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-media@vger.kernel.org; dri-devel@lists.freedesktop.org;
> linaro-mm-sig@lists.linaro.org
> Subject: [PATCH v5 2/3] ARM: dts: aspeed: Add USB2.0 device controller no=
de
>=20
> Add USB2.0 device controller(udc) node to device tree for AST2600.
>=20
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi
> b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 3d5ce9da42c3..822f4fd854f5 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -298,6 +298,16 @@ vhub: usb-vhub@1e6a0000 {
>  			status =3D "disabled";
>  		};
>=20
> +		udc: usb@1e6a2000 {
> +			compatible =3D "aspeed,ast2600-udc";
> +			reg =3D <0x1e6a2000 0x300>;
> +			interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&syscon ASPEED_CLK_GATE_USBPORT2CLK>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&pinctrl_usb2bd_default>;
> +			status =3D "disabled";
> +		};
> +
>  		apb {
>  			compatible =3D "simple-bus";
>  			#address-cells =3D <1>;
> --
> 2.25.1

