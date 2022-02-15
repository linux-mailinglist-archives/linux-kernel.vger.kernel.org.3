Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3E34B602A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiBOBuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:50:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiBOBuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:50:16 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2107.outbound.protection.outlook.com [40.107.114.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F971405E4;
        Mon, 14 Feb 2022 17:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfsXyQhtdYVyhix+gzWWp41cyfozl76Zdqt5C2oZAqmtZm9XnTCwaTocfAk/bEM/mLj7aLleAa8HNLBwpkcX5VrvXwnnNIj6dQiq8XeIEY2tyd+9qOeOV6whcqzl6sBqp5QWca1KJra9A5uH8hpaCNRSpOj1OcDnjgM0fsw2ZOpTlkyzeeULxQvvzBiQena0UyBR5QxcoIck2xS4WxRya8AOetDX4B9AczRrujUnE6NbAEzlI/WWV5HON/qh52WnMruaUuqXt1vNINcDMW6h2pOY17VrlADuD+h2eo5Y8mz01G0jkBYIh1sLh0V3DyuqoZOmGqk0aO+sjYSRX+zgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuJX7MvfaRPaijabiV4hJ3C1wX9UQ55stJs/PwZoKJw=;
 b=O/1JaIO9WE8QSeh+g7i7QzCi5pNIs/A/QtV9h4Md0aR13d1H41lbbhWcy9QDKzhTExHqBp0xhpl9j1rThE/mNY9phKXuXpcQKz6UNVNnU2r5+fOBNL62F1rfLO1DOlfKsgpp/1/XCguCHpkdAGAIEbmIt4bN+UalAIEIjrmbCpzSA6749hvBWxX0fTiXC6ztPpdj44Fp/7zZnMGvE8uKF7qGPX6FzIFS+ELkOS6t1diY9ttG6zuXPs6t8WMCULlTEgPaJE5tV9yREibq34CirRrgACB3TjmZ+D7AHhm4+wAmbNvE8h4rIt2gRuNi2AC4CM7bZAhDqjEcTtxB6a565g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuJX7MvfaRPaijabiV4hJ3C1wX9UQ55stJs/PwZoKJw=;
 b=MLHw1Y9XQGoCb0CA5P4m/AqUcx+IDU062i6+Ailv2bpwBE9B0487vJrx6M6/jUuOogYYGFB20qJyBRWxGVK2Jin7B1jxBmG+f1Wi7c27N4x0P+RgFoX23+Et5g9cZ6Ni2S9yq7hLi3aw0Z0KjaPdW8w3OHGWmawE7B8uJEFuEfM=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS0PR01MB6082.jpnprd01.prod.outlook.com
 (2603:1096:604:cb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 01:50:04 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::346f:1a56:ff4d:8c0a]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::346f:1a56:ff4d:8c0a%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 01:50:04 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v2 08/15] dt-bindings: pwm: renesas,pwm: Include generic
 pwm schema
Thread-Topic: [PATCH v2 08/15] dt-bindings: pwm: renesas,pwm: Include generic
 pwm schema
Thread-Index: AQHYIejx4cCufnUoqkGcsytdc5q5l6yT2JGg
Date:   Tue, 15 Feb 2022 01:50:04 +0000
Message-ID: <TYBPR01MB53419E93835DFBC730F84AFAD8349@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
 <20220214212154.8853-9-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214212154.8853-9-krzysztof.kozlowski@canonical.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ded43489-008b-4469-b487-08d9f0257c63
x-ms-traffictypediagnostic: OS0PR01MB6082:EE_
x-microsoft-antispam-prvs: <OS0PR01MB6082D7C035F5EADC8E25FC91D8349@OS0PR01MB6082.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9wLW5++76DV3GNeN8oSnJapg3NrljW1/i04j8UNj9L3SREvaWWWF7g/zxuXoGEojRltaYZmTLA3AMPyXA/uLHslu/w7ZdvoTDJ16sLhYcMy/6FrOCoREUZDf3+ChfJCF2CqCtpJkEYROU8sbe0ZUIyvRTvU3h4XXLQ7VbVYNfyOReDVE68qEVWH7bpVDT1gi+ZEqWrwZ304jB5DsAN5d6MpoapUv0zWZY/phbw3iyewr7CUyWOJPL5ZWmfKNdTUtW4H5Uz97R5MDRhn8eKFxrZEdDTuV6jxbaNwng8TOQ6k8r3HoH1rfVsbYRpS4hJ0jbbB/qjc2YUkWLvplEvPE33EaJwoDEJyS0mR4fWfvIiK+hWPD3ZIjFaAnhzsXRWVoens8hE9xYnM69P4HD4EnRm4O+Md31IfjtvYQ4M5zxVw5QhMsIQ6miD86/pTdVe7psHtdNAjBBwX2xBaYc3gbvz/DkaNDwtNh5ywBnk6MFiQzTQFlIbuM0uFA+KYd8ZnkxMIvbYJAlVGbmTF3sqGQlPK4cdnIvp9Hndjc7HKecW/n0ZPfCVSQXrN95H71xF2hypE3uWKJC4E05mtA1gD/TeUH6bnzxYfywbtlBVykTW8Xmr5oNtcRZeA8Emb/uzzVyhxX8dnbz1/dtikfnBV0IcEsT0yCqEWZPvi3VnvULFj1F7HtbnuLZlfL/6FrFO5GHIvylcC/GbCxyfalq6W6d4lFbTL5wRwFVZeRfFRmO7BDYC6o4Sey1JhS/b7mcW26
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7406005)(7416002)(5660300002)(186003)(6506007)(2906002)(4744005)(921005)(86362001)(8936002)(33656002)(38070700005)(52536014)(316002)(122000001)(76116006)(8676002)(66446008)(55016003)(66476007)(66556008)(64756008)(66946007)(110136005)(508600001)(53546011)(71200400001)(9686003)(7696005)(38100700002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5okCqj/82PKnk9tBkuUySvgSJFXSt9ZQdpCkntRCkWr5fTOQbUNjKwGLr9?=
 =?iso-8859-1?Q?t+23lYTTW9IjeDWpcrBabbZLo2ePq4IlvbrxGqTV8aEtG/ZMuWhg+RcMD7?=
 =?iso-8859-1?Q?786dbuAFd9qG+UrmVzXWKHaluNm7Wrmrd06sQ1qaeh8nZbsPSeHqTtQsZs?=
 =?iso-8859-1?Q?t3n+iMgzkkMZ0nhMumVe5Cy2qV6RLfZD28vQF5ISK/dURUwJICZEUNjfOX?=
 =?iso-8859-1?Q?AYbk2IKoBZPiYwq6bK9RI4YPWpExZ+LeAZUsa/nWoZrDyAhMnY1QIjMl+n?=
 =?iso-8859-1?Q?+o5Nl81NbR1Wg/a0lBTuzWZuYa7vrI0eIHp+3B95sHyrKera64KmPNe/Gh?=
 =?iso-8859-1?Q?BQzj+aD7kniXCaBTU9I1N7e4IHN4oLvuH6T+voc28XpOm/itiU6bsZ3z6H?=
 =?iso-8859-1?Q?4o2IVeYe5Hhozz3NHzgB3IF7g3AIFWLBmysdCcpL0WtcaiFFIS2lHKoJck?=
 =?iso-8859-1?Q?xjn0fwKQnHJ4o3WBw7AFUKZKG2RnncgPOmBsIK79WJ3girjr7TEMzSYJZW?=
 =?iso-8859-1?Q?+2V/NA899M3p10F9O8uv2AEvaQsOcRZX4lBhTaiUNUVFkE+iiRkUiQ9v73?=
 =?iso-8859-1?Q?b0rlpbEm2wnMSfRlfurfdte5n+juZG4tRoJcNz8uThsuNFeuLzAFk90LQu?=
 =?iso-8859-1?Q?2srsgqlwQWA1puHQ4XlhW8nes1iiKN5WfiS9rMjylJ6UjxWZz6wpeKm69O?=
 =?iso-8859-1?Q?N6AwJ3BBm9KabpcdMI4UwPOO27ZOFiGoEjqTRlS49qUuZrMY4yWYGnWbfm?=
 =?iso-8859-1?Q?SG7DWeYv3Eqjz/ZZRYJ178cHVvaSme2uUDIHnmpEApqJSuAYqcQb6Nodxh?=
 =?iso-8859-1?Q?IUmbXU9zxw66+4xyYOFK5lncMxTqedcjE6s2f7Ovnj1CK/13fRc2C4I7m+?=
 =?iso-8859-1?Q?XwkdrvF6pv026rcy5kE06Vy2/zD/EkuhRcZZqIx9Vcq2v5R3TF5m3CYL4O?=
 =?iso-8859-1?Q?3vCvBMhlVwPDi1rRt3KiyR36cfLR7/1wSO137V3MH+QqR+fbpVWYkYGdH0?=
 =?iso-8859-1?Q?bkrGdRZTTS03GL6ImFjR3wr0wmCoHKM75Yv93cRmjWK6qTrAbD1yJAnByP?=
 =?iso-8859-1?Q?T2k3HBtT++OntvNcORz1FbqLEuMa7J4OrgEdiXhGyrGRwASYXy8vnw5Gh9?=
 =?iso-8859-1?Q?Hgjoke9vm5urt/rAIu179JivrIledI5lvj28ODyv+ETmhmqjFJu1CHo/Go?=
 =?iso-8859-1?Q?wPm0WdEgfuqy3Ct41BwRM65VCalEDHuD4ZVMv3nk6eXHzjRfmzQf1mbttE?=
 =?iso-8859-1?Q?iTHfkOaP3ptG7hgxcETeJ49sbNBIfxx1HuAJb5ZIWwQvcD77Nrx+neNc/+?=
 =?iso-8859-1?Q?0vTQfLM1NaYIf6AVd9Ew5Us+NO6n3qW/R8uSoAJ+uahcbEOYziZRWwSKKc?=
 =?iso-8859-1?Q?uNsdhX57qcyP7I0XFNoohFdsl8wgT7vo2PnZ59h7M3s1Ud4GrFSynOcuE/?=
 =?iso-8859-1?Q?/GGxJsL4IaZ31jfbPdiBd0Y8+pHfctpp6/yNB4GnFs97Y3dC0hWi27SGTk?=
 =?iso-8859-1?Q?+f4LYAx9aqacG5ti3z7uz0hK/WX7H7/dvKz2PbDBi6Z+K1tj3UiizhL1+6?=
 =?iso-8859-1?Q?6RHa5v1SUCDaX2+R1NeVB7XvcjmrwemQB9ovpC4p84v0zLKrydZZ5IH+VK?=
 =?iso-8859-1?Q?LpiE4bkq2kP91OV/v/oHFr8hn6LbW+l03Q6ylNo/ygE1qq24U7OBrZAaPM?=
 =?iso-8859-1?Q?Ls9udHzaYpJePKNxD1+u+d1eTicOV7k+18QmctfR3Cg4GiKS2fa54/eNPT?=
 =?iso-8859-1?Q?BVB5qUFTacTkmEgJnpkXXvuGaaaPghDEavY+7d4JjMgRxXLkcboOgNw8Sn?=
 =?iso-8859-1?Q?iWQfv5ZXWNQNCAOjfTO7vIpgQLFSf87b9Qc5c+NfcPFQX9Nlrv2u?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded43489-008b-4469-b487-08d9f0257c63
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 01:50:04.0220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaQx2rFqLsNbLYIj+Rod35NmItzxwAzLrgLM8bhtkfSquYA2SzJ+bEUXSK7UDTt22316foakzbF1u51vR9Afaq4dLQvtZ1XhiN2h97jGeMdP2QNYFuC5Ks0aBA+7oQVx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> From: Krzysztof Kozlowski, Sent: Tuesday, February 15, 2022 6:22 AM
> Subject: [PATCH v2 08/15] dt-bindings: pwm: renesas,pwm: Include generic =
pwm schema
>=20
> Include generic pwm.yaml schema, which enforces PWM node naming and
> brings pwm-cells requirement.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

