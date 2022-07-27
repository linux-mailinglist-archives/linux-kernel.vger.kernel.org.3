Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD358272C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiG0M4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiG0M4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:56:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677491D0D6;
        Wed, 27 Jul 2022 05:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENcTBDYsNvGdCqOcwLjdIVEUGaFyg8jVTRUkA40aF3GL06Spf79nZxE8SshA370krOEqcVCGpt4zzC9tsR3QeHyYxv3jB7MgtWE1l/l49xTyFSst/Rn6H2Ch45GM5hqII4J54T5Cr6M1UssCzJb00mOyYPajeDBCHFGjfrgWYqH1K7ydgr2C8BC3c87WHu/r5yYiJqgih/5QNbLAe1VuocXETdlEBm6LlzGp2zzQHBS7vP8KYoUDWrdaBwd6iQHnR23nkjsp9ty0cThv9sjY34WdwzUzZAn0Lq1ZD5VnundcWHLqI6TIIq2IfuWmByuoCBphZmjE0I7Y6YWYuPKdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRQzQYr3T/5M0EZ18a9ZRWUDWEo0jjhW+hRKPWsCuAY=;
 b=KXM1ffs7AkAhUVQ0/MOrzp+ebOpPMrA6MBhYJAraoaBM7D/uKGy2qV/0Jec70/BZY7kixNi81FNbdTYv1+h/4i9tXNJt17H4Bbbq3H5951aLnRBJX+oiSMkxa4Bjvn1IEq9waBuDFLBpCjncQqgwrBS07RKZk6JgtlYc/PoKBSVNXwNqmdWrLg6WqDFFrZMej1gZRiZDSDRJjzA+WEc7z2SPYMncUiEW00YYIslrGPsODLhTS0cYf+Pe04b7/0zYwOSQCeXHCfE0QD0R6JKwJUwmAQhDcfwwfEaaRzqDkxmizYjhP5I7WRYDa685uB3eOpy+8+mScpN5BWjB4yi74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRQzQYr3T/5M0EZ18a9ZRWUDWEo0jjhW+hRKPWsCuAY=;
 b=STEQrKppp6NNGnn9lNtfkx7faZEHfM/fLHVuS4c98yy6Gc3xuDYjYjT0h0wXxuQFHY7jmyJGgJUTEdvPp4ryDczxeaxwYCaZiHwnxUELdtuByWGyqxUM3Y17N7zXNNvSlM0400VYXGM9hmbWaJF8VL0zT7ydjuA1xncEPMO+GnU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY2PR01MB3817.jpnprd01.prod.outlook.com (2603:1096:404:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Wed, 27 Jul
 2022 12:56:28 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%6]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 12:56:28 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
Thread-Topic: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
Thread-Index: AQHYoRp+5i2kwB4v6Ue8zM4Y97KIiq2R6rqAgAADKoCAAA22gIAAAzUAgAAAzoCAABjHAIAAAfcAgAAJcsCAAAUegIAAAe3g
Date:   Wed, 27 Jul 2022 12:56:28 +0000
Message-ID: <OS0PR01MB5922FDF8CFFE44A611D3783886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org>
 <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
 <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org>
 <CA+V-a8u1VW9xaj2KjySyMuegpisLVENO_6uJOpAFZGbKziYLYw@mail.gmail.com>
 <e31e0c1f-4755-704e-8428-93970877d8f5@linaro.org>
 <CA+V-a8sX=Frs_cds9MriauTFRvcZUNCvoeZ+SaC0GUpL7L6qhg@mail.gmail.com>
 <9f32a4a9-66b4-ba2e-1713-436103c2faf8@linaro.org>
 <OS0PR01MB5922763582B836DA45CDFF0886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <80f08089-e3bb-983e-313b-45613364829e@linaro.org>
In-Reply-To: <80f08089-e3bb-983e-313b-45613364829e@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ba16b1e-9a5a-491e-6fb9-08da6fcf6c0a
x-ms-traffictypediagnostic: TY2PR01MB3817:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RBq/hD3Z1UhSHcoxpoTmjVN6C4dJK/az1v7QpNB9BGeo9IbtzIqJaW1Fh1UWyreAl4tS83pWr8QRgyyW1+Z/85exEHGz9jI/PxT9J/73FK6hPXcmh/t/iet0hsA8bLNQBaKuqXs17YXxjUL419PujetTasGZXAvKVS61xuHdjv9DktV9hJp4GJN7w1BJtWoCNH3vzqL1r5+nnMztR6x2R5EP8R18+dYLUZjIdplHTrZ1FxkovkyqoOtni/a26M776TFrM80KNXnkYLAHdAu/w8V+pm4I4QdHIJjiMRZfcaDd5S7IqT6Ptn0oWuvrJ9bnIejYG4GTnQXopJIEgbh/kh7fYLfVFrUK9oDO95QW8tLEdeZeDxtJRDuHHTRqWfu3yiPFvITtP2lT8VYrrj+L4TuBXMarFhx7GcaaBDNebKjbMFQmZQJg9ntHRF9xi/CMyL5Pe7tJ977RKr51NjtzzKqLc8IsIAcd/tsnpyZ6+MhcwU9rzczLT7twerA5t+G6vLQ2Nrlu2aviRy+HFYLICfEINypXsDjFT+f4EE8cg2XfbiIa3vlF7zcpdia44xwG1Is6JWEOpQ4cul21iFtbahJC0NYy+r+ikkhILrFSCACpquDwnhpVsZEvAERqKCjbLYInUWLAnDueuX6XxR+qGboyAEbNoqJzezsa2ZBfc08kFYRa9cZW/8/T5sMh44B37a7zLbrvf/VAo/E9XbCGZmEBxizruvHZAQwSKyjWVIDvmxONlQy3JhD6WfjfNsXYBbradMSQaj55MPhrpIvrduAFvYzzNWS3vyq4NJ1gICk9ip2gGfwURhBDv0X+e6bT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(66946007)(66556008)(8676002)(64756008)(54906003)(66476007)(52536014)(4326008)(110136005)(66446008)(38070700005)(26005)(38100700002)(122000001)(9686003)(76116006)(53546011)(316002)(33656002)(7416002)(7696005)(6506007)(478600001)(71200400001)(2906002)(8936002)(83380400001)(55016003)(86362001)(5660300002)(186003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3ZORFhGOVVUU3hDR2c4MFFYNWtBVVJoMFU0M29IUmI2WUhKb2dCdEM3MGRZ?=
 =?utf-8?B?SzJTdkVNVDVpbGFjMVg4dEEyUy9CdEh2MU5VUkFqNEVlQ0FQLzA1YWJVRUNu?=
 =?utf-8?B?YXA5RXdKc2FLTU5BY1FjN2VXOUlld2NWYm5GK1hCS0VUZ01CNFdXOWhYL1hl?=
 =?utf-8?B?a2R2djY5R3VncFpBQWxzUW5GZ21QUlo0K3VCcjVCOWhWNzR2d3Q1ZkxudzAz?=
 =?utf-8?B?OU9QMnordnlPYmdVOUpTRTRJNUkvZE9kMUIvSDdlZUdXTmFIcnFibXk0c3gw?=
 =?utf-8?B?QkREWXlCV2xyOFhlN1ZpS0RyeUYrcFc0c2IzM28yRThaZytMait6SUZSVVBN?=
 =?utf-8?B?bU1LazFzd1kyeG1kdXhGS25RZE5uOStmTktWS2RFUnJDNXozcjNVS0VJOTI2?=
 =?utf-8?B?c01YVWZLUHdibURjeWJ1ZHc5SmNkSlBtYVJXbkp3bHo3Q09qYkdJU1FrbTl3?=
 =?utf-8?B?N0xuN1RiL1MxV0ZpdnUzL0tBZ01DZXpyMk15VDJDOWVlRUd2N05UZ1hxZGxk?=
 =?utf-8?B?RmROQXgwUjNBSWpSRHFOVjNRTUNzR0QwNWlZcFNyUTROTnk1bCtmN25GTzUy?=
 =?utf-8?B?QnBiTHkydWw5a0s5dmEyVUM2QjBBRE40M2ZreTdldjc4VmlOODM3dFRDSWFy?=
 =?utf-8?B?K3VmRkc4UW1pTEN6Yld2RUJuSi84cFI3ZnhBZ09Dcnc5aEtTZ0Z3aG5Lejls?=
 =?utf-8?B?ODhxaXpoK1o1YVBBbmZ6UnJNV2dqVEZBakNxS3g5QWNhb1V2WE9BK0dvNXFH?=
 =?utf-8?B?QjZ4cGJsRVJNYVZrZGRDenRrd1dRMXNjd3NQR2Z0M1N2OUczNnViRnhrOTZN?=
 =?utf-8?B?aFQ4dDhvUUp3MmdrbWtJL2VPL1RTcTNDY3VtRHQ4cUJUeXNEb1ZpVmxwVzhQ?=
 =?utf-8?B?cjA4OWIzV1p1cGFOcmduVHRCLzRyR1o3ZXVOdXByNGFuL3R2OWg1V0NjdGdl?=
 =?utf-8?B?WitNT29zM1pkWU1IWUtHbFBsQ21KKzVqSmd5dGhpZno3bnNSYnQ3TTRZMUFo?=
 =?utf-8?B?bnVpSmxBTlV3UWR0TE9makord0N1ZVFHMGl5UUN3UEw2TmpDNUgrajFQWjhv?=
 =?utf-8?B?SEpxZDVWNk9GSWtrd1pDaWd5bU5wRW9TY2FTTWJIeDE2a3djUTNSUTdUY0dx?=
 =?utf-8?B?UkNjM3l6UUZOSWQ2S1QxYmVBS1JuWEZkMG92dFpBK3Q1aWV1RE9MWlBIeEU4?=
 =?utf-8?B?ZW1yVmNISUtrWWdSNHNKMjdHckJoMDNQaUE1NWluZTRsMGZiK1o2TDZJdGI0?=
 =?utf-8?B?ZmJYMjVCMzZ6TTN4REJhOGdER0dsNGNHWEFVYXRDTmJaU2lSRFkrS2JSUU41?=
 =?utf-8?B?UUd2RmlsM0Y4UVlPMUp6TXNQZlRibU5BcHRCZGNFb3M0VTdTSUlnRERxdWVk?=
 =?utf-8?B?ZWVhcWVRTWlHRzhweXdGakk1QW1nVlB4NjR3QVBnamxaWUMwaHpUT1JyV2VD?=
 =?utf-8?B?Q01EVUUvL2ZVbnVERzQ5WnhwSi9LNGdrZ0xmTnoxb3ViL0VvNkNuNG9JWWFm?=
 =?utf-8?B?Q3FTOGRoTnJpd1lxejAxYjladHFxWDFqWE8vUGxTT0w0TG95Ryt1Y0tpNitY?=
 =?utf-8?B?TWFmcDZHamlQU1h6TjNmY0MzR0JTSFZJSWg5MDhqVHJ4cG9MeHdpcHlZamZQ?=
 =?utf-8?B?RE4rMjR3dzZGcnB3WEh1Y1UyWEVzTzdhT0tKQ3hhc2xuK01yT2VUZUJPSlJM?=
 =?utf-8?B?TFNhNkN4ejR3eUFEVWE1My8zeUliSDRCUTRqSElEdkNiTXpsTE5CVHE0aDJ2?=
 =?utf-8?B?N3Zmb28zbDRtaXZldU5WbXJKSFBSU0dROVBWUjg1ZUZrbTF1RWVBN2hQTUwz?=
 =?utf-8?B?RFVLeHRXVW82VG8zRkpQSU5qdWl0aW5CRDA4YnhXYXhlTHFsK2psT1VpaUNF?=
 =?utf-8?B?b29pcFFHWGVTTU1EOWdNZmNERGNoM3E3RmphWGtCRGdGcmw1NExISU5wdGUy?=
 =?utf-8?B?RittbXRMVkxPcnM4TXBtMTNOdzg4V2duQjJOOHVwL0xBdTg0ck1vbEJLZkNZ?=
 =?utf-8?B?RWlQbGZoK1pabG9vSXVuUCttY3RvWHhDclh5WmVjM25KekFhemFFVVNXNi9m?=
 =?utf-8?B?T0VEOWFGWm9Ud0RjSlM3ZFhodk5BSmJTYmZucmFIZEkyQVFuK0ZPdzhwb2Vs?=
 =?utf-8?B?T1VVVGhpS3lrTzUzb3hYTlpDU2lHUVhtQWJmcGFvS3NySFVjWkltSmxpdjVh?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba16b1e-9a5a-491e-6fb9-08da6fcf6c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 12:56:28.7414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJUFNfOWdDpmnEVh6aGLQF9Iyt005yNehF7jrtwRNvOdWtu4gsIBtgNZkRxGFRCKauuCBjdg9iKtIi76O99ROUQZA4/oLioA5+020zmg1gI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3817
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyNyBKdWx5IDIw
MjIgMTM6MzcNCj4gVG86IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IExh
ZCwgUHJhYmhha2FyDQo+IDxwcmFiaGFrYXIuY3NlbmdnQGdtYWlsLmNvbT4NCj4gQ2M6IFByYWJo
YWthciBNYWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29t
PjsNCj4gR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT47IE1hZ251
cyBEYW1tDQo+IDxtYWdudXMuZGFtbUBnbWFpbC5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBr
ZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStk
dEBsaW5hcm8ub3JnPjsgUGF1bCBXYWxtc2xleQ0KPiA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29t
PjsgUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47IEFsYmVydA0KPiBPdSA8YW91
QGVlY3MuYmVya2VsZXkuZWR1PjsgQW51cCBQYXRlbCA8YW51cEBicmFpbmZhdWx0Lm9yZz47IExp
bnV4LQ0KPiBSZW5lc2FzIDxsaW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc+OyBvcGVu
IGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQNCj4gRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdT
IDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LXJpc2N2DQo+IDxsaW51eC1yaXNj
dkBsaXN0cy5pbmZyYWRlYWQub3JnPjsgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzZdIGR0LWJpbmRpbmdzOiByaXNjdjogQWRkIERU
IGJpbmRpbmcNCj4gZG9jdW1lbnRhdGlvbiBmb3IgUmVuZXNhcyBSWi9GaXZlIFNvQyBhbmQgU01B
UkMgRVZLDQo+IA0KPiBPbiAyNy8wNy8yMDIyIDE0OjIxLCBCaWp1IERhcyB3cm90ZToNCj4gPiBI
aSwNCj4gPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNl0gZHQtYmluZGluZ3M6IHJpc2N2
OiBBZGQgRFQgYmluZGluZw0KPiA+PiBkb2N1bWVudGF0aW9uIGZvciBSZW5lc2FzIFJaL0ZpdmUg
U29DIGFuZCBTTUFSQyBFVksNCj4gPj4NCj4gPj4gT24gMjcvMDcvMjAyMiAxMzozNywgTGFkLCBQ
cmFiaGFrYXIgd3JvdGU6DQo+ID4+Pj4+Pg0KPiA+Pj4+PiBJIGRpZCBydW4gdGhlIGR0YnNfY2hl
Y2sgdGVzdCBhcyBwZXIgeW91ciBzdWdnZXN0aW9uIChiZWxvdyBpcyB0aGUNCj4gPj4+Pj4gbG9n
KSBhbmQgZGlkbid0IHNlZSAibm8gbWF0Y2hpbmcgc2NoZW1hIGVycm9yIg0KPiA+Pj4+Pg0KPiA+
Pj4+DQo+ID4+Pj4gU28geW91IGRvIG5vdCBzZWUgYW55IGVycm9ycyBhdCBhbGwuIFRoZW4gaXQg
ZG9lcyBub3Qgd29yaywgZG9lcw0KPiBpdD8NCj4gPj4+Pg0KPiA+Pj4gUmlnaHQgSSByZXZlcnRl
ZCBteSBjaGFuZ2VzIEkgY2FuIHNlZSBpdCBjb21wbGFpbmluZywgZHRiX2NoZWNrDQo+ID4+PiBz
ZWVtcyB0byBoYXZlIHJldHVybmVkIGZhbHNlIHBvc2l0aXZlIGluIG15IGNhc2UuDQo+ID4+Pg0K
PiA+Pj4gV2hhdCBhcHByb2FjaCB3b3VsZCB5b3Ugc3VnZ2VzdCB0byBpZ25vcmUgdGhlIHNjaGVt
YSBoZXJlPw0KPiA+Pg0KPiA+PiBJIGRvbid0IHRoaW5rIGN1cnJlbnRseSBpdCB3b3VsZCB3b3Jr
IHdpdGggeW91ciBhcHByb2FjaC4gSW5zdGVhZCwNCj4gPj4geW91IHNob3VsZCBzZWxlY3QgaGVy
ZSBhbGwgU29DcyB3aGljaCB0aGUgc2NoZW1hIHNob3VsZCBtYXRjaC4NCj4gPj4NCj4gPj4gVGhp
cyBsZWFkcyB0byBteSBwcmV2aW91cyBjb25jZXJuIC0geW91IHVzZSB0aGUgc2FtZSBTb0MgY29t
cGF0aWJsZQ0KPiA+PiBmb3IgdHdvIGRpZmZlcmVudCBhcmNoaXRlY3R1cmVzIGFuZCBkaWZmZXJl
bnQgU29DczogQVJNdjggYW5kIFJJU0MtVi4NCj4gPg0KPiA+IE9yIGlzIGl0IHNhbWUgU29DKFI5
QTA3RzA0MykgYmFzZWQgb24gdHdvIGRpZmZlcmVudCBDUFUgYXJjaGl0ZWN0dXJlcw0KPiA+IChB
Uk12OCBhbmQgUklTQy1WKQ0KPiANCj4gVGhlbiBpdCBpcyBub3QgdGhlIHNhbWUgU29DISBTYW1l
IG1lYW5zIHNhbWUsIGlkZW50aWNhbC4gQ1BVDQo+IGFyY2hpdGVjdHVyZSBpcyBvbmUgb2YgdGhl
IG1ham9yIGRpZmZlcmVuY2VzLCB3aGljaCBtZWFucyBpdCBpcyBub3QgdGhlDQo+IHNhbWUuDQoN
CkZhbWlseSBTb0MoUjlBMDdHMDQzKSBpcyBhdCB0b3AgbGV2ZWwuIFRoZW4gaXQgaGFzIGRpZmZl
cmVudCBTb0NJZCBmb3IgdGFraW5nIGNhcmUgb2YNCmRpZmZlcmVuY2VzIGZvciBTb0MgYmFzZWQg
b24gQVJNVjggYW5kIFJJU0MtViB3aGljaCBoYXMgc2VwYXJhdGUgY29tcGF0aWJsZSBsaWtlDQpy
OWEwN2cwNDN1MTEgYW5kIHI5YTA3ZzA0M2YwMT8NCg0KPiANCj4gPiBVc2luZyBzYW1lIFNvTSBh
bmQgQ2FycmllciBib2FyZD8NCj4gDQo+IEl0J3MgbGlrZSBzYXlpbmcgUEMgd2l0aCB4ODYgYW5k
IEFSTXY4IGJvYXJkIGFyZSB0aGUgc2FtZSBiZWNhdXNlIHRoZXkNCj4gYm90aCB1c2Ugc2FtZSAi
UEMgY2hhc3NpcyIuDQoNCldoYXQgSSBtZWFudCBpcyBib2FyZCBiYXNlZCBvbiBGYW1pbHkgU29D
KFI5QTA3RzA0MykgdGhhdCBpcyBlaXRoZXIgYmFzZWQgb24gQVJNdjggb3INClJJU0MtViBjcHUg
YXJjaGl0ZWN0dXJlLg0KDQpDaGVlcnMsDQpCaWp1DQo=
