Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C245254F0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380219AbiFQF5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380207AbiFQF5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:57:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB47666;
        Thu, 16 Jun 2022 22:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkpyhkVWvxrc6rApV7t9/sjeHcFprdn5sbnjjGFRnhlqxJUtOUJuDSFBcRzlky2cTmliV681s/tNZxO8JOWPv096NboZGx2g6ZLvW0krqPgWQGRKO10F8oGf3/nBtCrBKqxFOymITAcSdsLYD9qbGPMAgEgT2NGaRmZq4uwJtRf17vrnIF9zv74oqTUh+J9UDt4jr9XcpTjCMuFqxcnJlhEvYtt23xISPcfUUk7tanWlgHfDPC1sP3eBqpQRCg5Del6ia6whi3ZTbS6Q0GyDJfCnhPPMcFRpmSllPoGf/J+l5tSxR8svf0rlimT2kP6wPQaMLv3DdUDPFa2WqiGWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfA8e7H/B6zRG23KL7QUFHIuuOne2GmdwYAF99VJk+8=;
 b=KgAO/2cP/gY/prLuh9tvDab/4ezqwbfqd+5RLbq8P+McEYzCJoIJSCKi42Vs1LJeKkz+M5i0Q5USTGZebPIT5qjMcBnYkulpfiuuHz6GSM61zohEUq6rxRHw8QzgnELnK/uktqAxWmIgUrEmRpZithDLuGGbdec7irei69OZEC+wGe2LY2oIKMB6OYkDBFHlZX1pw/uQiXYDl7zR8l1zU8i4y66kfSoB0/ZbA7BzRIgwOnEBUPMTIgesVfnqq8insG8nfXBfMoafGX/3dePF181FCOOxZBesrA+LCjyX7xPHleUE6pr1fsPZrGLPow41/ShWimiu2PoYxQ9x02BsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfA8e7H/B6zRG23KL7QUFHIuuOne2GmdwYAF99VJk+8=;
 b=QwT4RmaFrea3hUWEu0+Yvnmhr01DnhrChUKEJv/Q2lZ9im1WMjRdr+s9KENB83ZY/FrZB9FehDK4ydYZJKOyUdbucIlla1/iLsY6k62ye0aI2d7W+PtSSGnRZhj6FbLrRnFth3oWSwRHB40CIkvKIZg+puIfH31cshHPIXg5wi4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by HE1PR0401MB2266.eurprd04.prod.outlook.com (2603:10a6:3:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 17 Jun
 2022 05:57:39 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7%6]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 05:57:38 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v12 09/13] PCI: imx6: Turn off regulator when system is in
 suspend mode
Thread-Topic: [PATCH v12 09/13] PCI: imx6: Turn off regulator when system is
 in suspend mode
Thread-Index: AQHYgQ3uv73OABlIQ0uV4ens6/i6vq1RHbYAgAAqOkCAAOkwgIAA6FKw
Date:   Fri, 17 Jun 2022 05:57:38 +0000
Message-ID: <AS8PR04MB8676CC46A0DBFD5E18A613638CAF9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB8676919AEB21FDA9F632CA4A8CAC9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20220616155619.GA1089749@bhelgaas>
In-Reply-To: <20220616155619.GA1089749@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2cd72b5-abc9-4c9b-9d7f-08da502648f2
x-ms-traffictypediagnostic: HE1PR0401MB2266:EE_
x-microsoft-antispam-prvs: <HE1PR0401MB22669DC7DB88E1A14DBBEB728CAF9@HE1PR0401MB2266.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vjJxhvO3JVvmDZzrIRS5SGUVueelX5x0Unsecm/LUrpRNUKD06fRwOedFk2piFLbxh6QvUAWFELm5mbqt81mX08iXLUpZ/7chOX6I2WA9QSXCxU1ZCuV4uW4o0MO/dYl5JVMPeP30YivVfYmjCKDtCuHtZCtxAJyhxZ6eZqz+/q4jB5H5Sg7BBUMR5nIqXwrEPoUjBWUGnM2pmAu6eQX5+ycRWpakKzyFBvEAgILs7QeWTI74ee4Kbglp1YYGfps8xurcTdWooTTPI6ncbiF6alWDNJVqPhqsuur7WAzr92FsFU3mOaBggglDNP8igZ8dzH9tMbhOo58CBtc9H0tIaVC/zkEv/fmM8dCdoxX/QFwvqkfaUS70zOQHqpys+Ac23lBtbTIAcd0/b+Qtcs76yd91+Jyz2QkJ8tGciiOAPyg+FvNx8g8/jHAYVpTzgq4x53v6x9JXwZOkHXEGyodBYkz+Jw9pXr2mt3UNgUHeVbIKNZibUR7Mm0f1/Zo7/+Tkf1VDnkKtjBek6lcwVDzY2lJbr+sCcp/peK/+EW0C4F8Wusg0tocfyiMNpQYsLOOnxBQjn7AkhrUvPCUfwkq/GVMQNFBYlriY7UzmH1TVFRK9LdnLcZ694mrdPtGqYH6atdSatGPHSOuZK5KFWrXXTPtePUfnQsJFw95rOCJ7rIbFl5Lg7QVNKV6ApdOC9tONFqElOcf1ARbILPiJzOcRweb/VPkzgNh5cyEKk2+D8JT8knYa7Eyh+EYLsNakOEeVnK5NSMJb8HKTjZCKN92znm2TPjknGEM/oKK1nszzC8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(7416002)(45080400002)(71200400001)(76116006)(86362001)(64756008)(38070700005)(66476007)(4326008)(66556008)(66946007)(44832011)(8676002)(508600001)(186003)(83380400001)(26005)(55016003)(52536014)(966005)(38100700002)(53546011)(9686003)(8936002)(7696005)(6506007)(6916009)(15650500001)(54906003)(316002)(5660300002)(33656002)(122000001)(2906002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aXR0d0JiVm1DWUwzbGozSVk0VW5VeThMbjZPbW02N0ViTVBRbFNZM1EwRlFs?=
 =?gb2312?B?cFBmUmVhTWpGakpJMTh5bUVLZ0xjc1FCK3BZWTRuRUJGakU5QmxvOGxybnBH?=
 =?gb2312?B?QkFXeGFBMTcyZUlaWlNvR3NsUFNTR3VwbVZyOUdxOEsyYUw5SE8wRE5VTnRl?=
 =?gb2312?B?dDRyTDNWRXJHN0Z2Y25HY28zQkhQeW5jU1d5cU1SMnllUE1wbFpjY0ZnNGwr?=
 =?gb2312?B?TFQrVzM4OWhCc0J3NE8ydy9rWXY5WHRuQWMxSWdvSmU5VTg3OXZPc0dBUW5n?=
 =?gb2312?B?UjFlcGNjVHRVZWZjRE9PdE1GZmUvS2hmNzRTeTVDQ1VtMVhIYzhXYjZIakQz?=
 =?gb2312?B?QXVyNHFDZXBxYm1wOWR6dFpNSTYxOXpLNEovWlR2cElpc000c1BLRlFhc3M0?=
 =?gb2312?B?NW9HUjh4QUJMNjJXYm9PZWY2OUNxWm82cW1VUUl6MjZ2MTRFZkFqL05oL0pI?=
 =?gb2312?B?dWJCTFNGRDk3emwzYTJKUHFqMDhxZTdKelJjaGpaeG0zbVhISUNkN3BuOUhx?=
 =?gb2312?B?UGVZWDBhazVpbnJQZSt5MmpjaFJIcXJ0NEhDdWVtZGJjM3ZjVEVScTA5YXhX?=
 =?gb2312?B?NFo1MU42Tko3ZnFLWHpERVBRZmFrK25RaWtHTUtpTEpoTGdlV3ZVWHFta1Bw?=
 =?gb2312?B?aWxMM08yYUp0cCtsMHJzbzRMRXJpSkdJVXdxMnd3QXZaT0N0NmVUTDBBTzV2?=
 =?gb2312?B?WFdtVHRwY1RTRlhIM2tFWWN6ZXRLT1pvem4wVFFzVzNqdnVEMFJyUWExWDNP?=
 =?gb2312?B?cnFNSGE3NG9oU3BuNURIZEpRb2o0bzFzODVjOFVNWEVsZUp1TmNmdU5jcFRp?=
 =?gb2312?B?Wk54OFNGVWw4dXQyeFMyVmVxYUxwRzVaUC8xNGJjSHEzWndHbmtVTVlTaXJY?=
 =?gb2312?B?anVuV2t0MHdxcUVoekQxVlpDa1JaZVhGcnh2UE9EMnJneHljbVhNS3ZJVm53?=
 =?gb2312?B?L0h0ZHNMdTIvc3ovZ0cybWhVckpwOFJtU1IvVERkTjBHTGp5WEpZR2ZKNjZZ?=
 =?gb2312?B?M3NDbEVvaS9kZ0YyblN6dFJwVVErRm5ZRkI0ZUVHN1FRdm9yLzBVSTZvTndp?=
 =?gb2312?B?ZkVuYllKZHRxUE9WczZqb1k3Ti9sMnJBV25XcFhwaSt4QVhydC9oV2VTL1cy?=
 =?gb2312?B?T09oUmYwUkQvQmRkYklIS3J6TlVVeG9SdVQwMDhGVXBaVThQN0JpTHhKU0Jr?=
 =?gb2312?B?U3FxZDYrZDg5K3NaS2l4cnRjQjcvaTg1R0Ercmd4Q2lzaWdJYTc0WjVOTDdH?=
 =?gb2312?B?Q1N4bXNHZXdFRGI5blE1Z2JtYi9pRTVoUE9LbTJFS2hDMEtMSGYzVEI1Q01I?=
 =?gb2312?B?VExYMm5hc3QvaHdZRkRJYlFFUDFWaE9IdFlNN1Zua1lUVURhR3Y3U2RhS0JC?=
 =?gb2312?B?ZmJDSFNmMzk5WDA4OUl6M2doUUN4KzF6b1BMZjM5MmdYZmE4bVQ3OEpIcm16?=
 =?gb2312?B?Y3lxMU1xN1BNYTVGSlVQWGxTZGVhaG1WV3NBNkszVzNiREdVREluS1ViOXZZ?=
 =?gb2312?B?YVNVNUQvS1N3UkNzQ1FhaHBwSU9GTmR3aGVjdGxJYXd3Y2tUZDFCRWJycHBV?=
 =?gb2312?B?bWtiSDQzVEt0cFJYZUtYYXJkMDNQdktURDB1Sk01NURSWjJpcmttVElYOExL?=
 =?gb2312?B?ZnZ6NjdHQ2p2Qjl3a3QvbW1jdjBjVDVHSXNqZnJjNU9wRFpCbSttYklZbEJ1?=
 =?gb2312?B?bXRlazQ2NEtMYzI0ZFdvQnN3Y0VISy85VkM5V0hMYzNCWGJQRjhVOENLQUtE?=
 =?gb2312?B?WWZ4MStNNE5nMnBQMHVlSkJNam56aUdCWU1QQ2JsYmVGZ1MzajJCR0lpL2to?=
 =?gb2312?B?T1pQeVNXNkNYVUZZays2SGdEejFKUXNMdmVpQysrZ3NKblBLR2tZK2FENkpG?=
 =?gb2312?B?TlJnN0Q3bTZrUERpSGZrRjVkYnh2OFYwK050cUR5a1hnYVpDT2NKdjBWR21a?=
 =?gb2312?B?SDlrRVQxUW0wVWFoRXVVUGlybFZHOEYrNnlSQmsyTmUwV2k0TlFuSWtoMEhR?=
 =?gb2312?B?YXdyVWh0eEk0eW1xRVdMSzlCYU5oSHlVUTdPZWtFUnhZRTlKK1VTTHdjUitx?=
 =?gb2312?B?bmdWTVZhSU90NDlsM2d4Qk9WaHpRSFJKNy93ZVhWdGdpc2JlUUpoR0lHaEdO?=
 =?gb2312?B?Q1A4N0x4TmlLUDJGdUd3WE81c01NZEsrSlFKYnBpc0FSaHV2dmVHNDNwcmw0?=
 =?gb2312?B?NW5vMmsvaWtVank0WkxVUmppZ0I0WVgzc2NIV2NveERxSFBYTExBN0Mra2pT?=
 =?gb2312?B?TDg5SGNOdkVtUU02RUZXSkpKdnprWDBsRmdoRWdLaHN3LzdiN2pKNncwczN1?=
 =?gb2312?B?KzZzWFlUWEpIcUtZQ1BtM2l4OStMVm5RTjBuQXBhbHN6bHMxWldPdz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cd72b5-abc9-4c9b-9d7f-08da502648f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 05:57:38.8717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+0Anp2rw9NJs1Sc3KDholAXyRkgmt+Q4WwvzyAEIr+vwGhGII32VNaqtyEYsFl/8dbxMi4ukXhxovPFHLn/Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjE2yNUgMjM6NTYNCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Ow0KPiBN
YXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBMb3JlbnpvIFBpZXJhbGlzaQ0KPiA8bG9y
ZW56by5waWVyYWxpc2lAYXJtLmNvbT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNv
bT47DQo+IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbT47
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1
dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgQmpvcm4gSGVsZ2Fh
cw0KPiA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTIgMDkv
MTNdIFBDSTogaW14NjogVHVybiBvZmYgcmVndWxhdG9yIHdoZW4gc3lzdGVtIGlzIGluDQo+IHN1
c3BlbmQgbW9kZQ0KPiANCj4gT24gVGh1LCBKdW4gMTYsIDIwMjIgYXQgMDI6MjM6MjlBTSArMDAw
MCwgSG9uZ3hpbmcgWmh1IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4NCj4gPiA+IFNl
bnQ6IDIwMjLE6jbUwjE2yNUgNzozMQ0KPiA+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+OyBMdWNhcyBTdGFjaA0KPiA+ID4gPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+
OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyaw0KPiA+ID4gQnJvd24gPGJy
b29uaWVAa2VybmVsLm9yZz47IExvcmVuem8gUGllcmFsaXNpDQo+ID4gPiA8bG9yZW56by5waWVy
YWxpc2lAYXJtLmNvbT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47DQo+ID4g
PiBGcmFuY2VzY28gRG9sY2luaSA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+ID4g
PiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPiA+IDxsaW51eC1pbXhAbnhwLmNvbT47
IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxMiAwOS8xM10gUENJOiBpbXg2OiBUdXJuIG9mZiByZWd1bGF0b3Igd2hlbg0KPiA+
ID4gc3lzdGVtIGlzIGluIHN1c3BlbmQgbW9kZQ0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgSnVuIDE1
LCAyMDIyIGF0IDA2OjE1OjQ3UE0gLTA1MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4gPiA+
IEZyb206IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+ID4NCj4gPiA+
ID4gVGhlIGRyaXZlciBzaG91bGQgdW5kbyBhbnkgZW5hYmxlcyBpdCBkaWQgaXRzZWxmLiBUaGUg
cmVndWxhdG9yDQo+ID4gPiA+IGRpc2FibGUgc2hvdWxkbid0IGJlIGJhc2luZyBkZWNpc2lvbnMg
b24gcmVndWxhdG9yX2lzX2VuYWJsZWQoKS4NCj4gPiA+ID4NCj4gPiA+ID4gTW92ZSB0aGUgcmVn
dWxhdG9yX2Rpc2FibGUgdG8gdGhlIHN1c3BlbmQgZnVuY3Rpb24sIHR1cm4gb2ZmDQo+ID4gPiA+
IHJlZ3VsYXRvciB3aGVuIHRoZSBzeXN0ZW0gaXMgaW4gc3VzcGVuZCBtb2RlLg0KPiA+ID4gPg0K
PiA+ID4gPiBUbyBrZWVwIHRoZSBiYWxhbmNlIG9mIHRoZSByZWd1bGF0b3IgdXNhZ2UgY291bnRl
ciwgZGlzYWJsZSB0aGUNCj4gPiA+ID4gcmVndWxhdG9yIGluIHNodXRkb3duLg0KPiA+ID4gPg0K
PiA+ID4gPiBMaW5rOg0KPiA+ID4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkYNCj4gPiA+ID4gbG9yZQ0KPiA+ID4gPiAu
a2VybmVsLm9yZyUyRnIlMkYxNjU1MTg5OTQyLTEyNjc4LTYtZ2l0LXNlbmQtZW1haWwtaG9uZ3hp
bmcueiZhbQ0KPiBwDQo+ID4gPiA+IDtkDQo+ID4gPiBhdA0KPiA+ID4gPg0KPiA+ID4NCj4gYT0w
NSU3QzAxJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3QzhkZWE0NmQ5MDhkMzRjYjQ4MjU4MDhk
YTQNCj4gPiA+IGYyNzBlYWYlDQo+ID4gPiA+DQo+ID4gPg0KPiA3QzY4NmVhMWQzYmMyYjRjNmZh
OTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc5MDkzMjY0MTU2NDE1DQo+ID4gPiAzNSU3Q1Vu
a24NCj4gPiA+ID4NCj4gPiA+DQo+IG93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdN
REFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxDQo+ID4gPiBoYVd3aQ0KPiA+ID4gPg0KPiA+
ID4NCj4gTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT10cXpsY0NtdFNr
VU54TnpKMEZyNW8NCj4gPiA+IENSM1gyQ1RIDQo+ID4gPiA+IDRkd1VKUzROWHQ1S1JjJTNEJmFt
cDtyZXNlcnZlZD0wDQo+ID4gPiA+IGh1QG54cC5jb20NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAxOSArKysrKysrLS0t
LS0tLS0tLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMiBk
ZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiA+IGluZGV4IDZlZGRkMGI1ZjYyOC4uNTM3YjhhMmUwZTNi
IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14
Ni5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMN
Cj4gPiA+ID4gQEAgLTY3MCw4ICs2NzAsNiBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfY2xrX2Rp
c2FibGUoc3RydWN0DQo+ID4gPiA+IGlteDZfcGNpZQ0KPiA+ID4gPiAqaW14Nl9wY2llKQ0KPiA+
ID4gPg0KPiA+ID4gPiAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KHN0
cnVjdCBpbXg2X3BjaWUNCj4gPiA+ID4gKmlteDZfcGNpZSkgew0KPiA+ID4gPiAtCXN0cnVjdCBk
ZXZpY2UgKmRldiA9IGlteDZfcGNpZS0+cGNpLT5kZXY7DQo+ID4gPiA+IC0NCj4gPiA+ID4gIAlz
d2l0Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0KPiA+ID4gPiAgCWNhc2UgSU1Y
N0Q6DQo+ID4gPiA+ICAJY2FzZSBJTVg4TVE6DQo+ID4gPiA+IEBAIC03MDIsMTQgKzcwMCw2IEBA
IHN0YXRpYyB2b2lkDQo+ID4gPiA+IGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QN
Cj4gPiA+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ID4gPiAgCQlicmVhazsNCj4gPiA+ID4g
IAl9DQo+ID4gPiA+DQo+ID4gPiA+IC0JaWYgKGlteDZfcGNpZS0+dnBjaWUgJiYgcmVndWxhdG9y
X2lzX2VuYWJsZWQoaW14Nl9wY2llLT52cGNpZSkgPiAwKQ0KPiB7DQo+ID4gPiA+IC0JCWludCBy
ZXQgPSByZWd1bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiA+ID4gLQ0KPiA+
ID4gPiAtCQlpZiAocmV0KQ0KPiA+ID4gPiAtCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZGlz
YWJsZSB2cGNpZSByZWd1bGF0b3I6ICVkXG4iLA0KPiA+ID4gPiAtCQkJCXJldCk7DQo+ID4gPiA+
IC0JfQ0KPiA+ID4gPiAtDQo+ID4gPiA+ICAJLyogU29tZSBib2FyZHMgZG9uJ3QgaGF2ZSBQQ0ll
IHJlc2V0IEdQSU8uICovDQo+ID4gPiA+ICAJaWYgKGdwaW9faXNfdmFsaWQoaW14Nl9wY2llLT5y
ZXNldF9ncGlvKSkNCj4gPiA+ID4gIAkJZ3Bpb19zZXRfdmFsdWVfY2Fuc2xlZXAoaW14Nl9wY2ll
LT5yZXNldF9ncGlvLA0KPiA+ID4gPiBAQCAtNzIyLDcgKzcxMiw3IEBAIHN0YXRpYyBpbnQNCj4g
PiA+ID4gaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+ID4gPiBpbXg2X3Bj
aWUgKmlteDZfcGNpZSkNCj4gPiA+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2ktPmRldjsN
Cj4gPiA+ID4gIAlpbnQgcmV0LCBlcnI7DQo+ID4gPiA+DQo+ID4gPiA+IC0JaWYgKGlteDZfcGNp
ZS0+dnBjaWUgJiYgIXJlZ3VsYXRvcl9pc19lbmFibGVkKGlteDZfcGNpZS0+dnBjaWUpKSB7DQo+
ID4gPiA+ICsJaWYgKGlteDZfcGNpZS0+dnBjaWUpIHsNCj4gPiA+ID4gIAkJcmV0ID0gcmVndWxh
dG9yX2VuYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiA+ID4gIAkJaWYgKHJldCkgew0KPiA+
ID4gPiAgCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZW5hYmxlIHZwY2llIHJlZ3VsYXRvcjog
JWRcbiIsIEBADQo+ID4gPiAtNzk2LDcNCj4gPiA+ID4gKzc4Niw3IEBAIHN0YXRpYyBpbnQgaW14
Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+ID4gPiA+ICtpbXg2X3BjaWUNCj4g
PiA+ICppbXg2X3BjaWUpDQo+ID4gPiA+ICAJcmV0dXJuIDA7DQo+ID4gPiA+DQo+ID4gPiA+ICBl
cnJfY2xrczoNCj4gPiA+ID4gLQlpZiAoaW14Nl9wY2llLT52cGNpZSAmJiByZWd1bGF0b3JfaXNf
ZW5hYmxlZChpbXg2X3BjaWUtPnZwY2llKSA+IDApDQo+IHsNCj4gPiA+ID4gKwlpZiAoaW14Nl9w
Y2llLT52cGNpZSkgew0KPiA+ID4gPiAgCQlyZXQgPSByZWd1bGF0b3JfZGlzYWJsZShpbXg2X3Bj
aWUtPnZwY2llKTsNCj4gPiA+ID4gIAkJaWYgKHJldCkNCj4gPiA+ID4gIAkJCWRldl9lcnIoZGV2
LCAiZmFpbGVkIHRvIGRpc2FibGUgdnBjaWUgcmVndWxhdG9yOiAlZFxuIiwgQEANCj4gPiA+IC0x
MDIzLDYNCj4gPiA+ID4gKzEwMTMsOSBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9zdXNwZW5kX25v
aXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiA+ID4gIAkJYnJlYWs7DQo+ID4gPiA+ICAJfQ0K
PiA+ID4gPg0KPiA+ID4gPiArCWlmIChpbXg2X3BjaWUtPnZwY2llKQ0KPiA+ID4gPiArCQlyZWd1
bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiA+DQo+ID4gPiBUaGlzIGlzIGEg
bGl0dGxlIGJpdCB1Z2x5IGJlY2F1c2UgaW14Nl9wY2llX3N1c3BlbmRfbm9pcnEoKSBhbmQNCj4g
PiA+IGlteDZfcGNpZV9yZXN1bWVfbm9pcnEoKSBhcmUgbm90IHN5bW1ldHJpYy4NCj4gPiA+DQo+
ID4gPiBXZSBjYWxsIHJlZ3VsYXRvcl9kaXNhYmxlKCkgZGlyZWN0bHkgaGVyZSBpbg0KPiA+ID4g
aW14Nl9wY2llX3N1c3BlbmRfbm9pcnEoKSwgYnV0IHRoZSBjb3JyZXNwb25kaW5nIHJlZ3VsYXRv
cl9lbmFibGUoKSBpcw0KPiBidXJpZWQgaW4gaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQo
KS4NCj4gPiA+DQo+ID4gPiBJdCB3b3VsZCBiZSBuaWNlciBpZiB0aGUgc3VzcGVuZCBhbmQgcmVz
dW1lIHBhdGhzIGxvb2tlZCBtb3JlDQo+ID4gPiBzaW1pbGFyLCBhcw0KPiA+ID4gcm9ja2NoaXBf
cGNpZV9zdXNwZW5kX25vaXJxKCkgYW5kIHJvY2tjaGlwX3BjaWVfcmVzdW1lX25vaXJxKCkgZG8s
DQo+ID4gPiBmb3IgZXhhbXBsZS4NCj4gPiBZZXMsIGl0IGlzLiBUaGUgcmVndWxhdG9yX2Rpc2Fi
bGUoKS9yZWd1bGF0b3JfZW5hYmxlKCkgYXJlIG5vdCBpbnZva2VkDQo+ID4gc3ltbWV0cmljYWxs
eS4NCj4gPg0KPiA+IEluIHRoZSBvcmlnaW5hbCBjb2RlcywgdGhlIHJlZ3VsYXRvcl9kaXNhYmxl
KCkgaXMgY29udGFpbmVkIGluDQo+ID4gaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KCkgYW5k
IHdpdGggX2VhbmJsZWQoKSBjaGVjay4NCj4gPiBBbmQgcmVndWxhdG9yX2VuYWJsZSgpIGlzIGVt
YmVkZGVkIGluIGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCkuDQo+ID4gQm90aCB0aGUg
cmVndWxhdG9yIGRpc2FibGUgYW5kIGVuYWJsZSBhcmUgaW52b2tlZCBpbiByZXN1bWUgYmVmb3Jl
Lg0KPiA+IEkgbW92ZSB0aGUgcmVndWxhdG9yX2Rpc2FibGUgdG8gc3VzcGVuZCBtb2RlIHJlZmVy
IHRvIEx1Y2FzJyBjb21tZW50cy4NCj4gPg0KPiA+IFJlZmVyIHRvIHRoZSBjdXJyZW50IHNpdHVh
dGlvbiwgaG93IGFib3V0IHRvIG1vdmUgdGhlDQo+ID4gcmVndWxhdG9yX2Rpc2FibGUoKSAgb3V0
IG9mIGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCkgdG9vPw0KPiANCj4gSSB0aGluayBp
dCdzIGltcG9ydGFudCB0byB0d2VhayB0aGlzIGNsb3NlciB0byB0aGUgcGF0dGVybiBvZiBvdGhl
ciBkcml2ZXJzIGxpa2UNCj4gZXh5bm9zIGFuZCByb2NrY2hpcC4NCj4gDQo+IGV4eW5vc19wY2ll
X3Jlc3VtZV9ub2lycSgpIGNhbGxzIGV4eW5vc19wY2llX2hvc3RfaW5pdCgpLg0KPiBpbXg2X3Bj
aWVfcmVzdW1lX25vaXJxKCkgaXMgVkVSWSBzaW1pbGFyIHRvIGlteDZfcGNpZV9ob3N0X2luaXQo
KSwgYW5kIEkgdGhpbmsNCj4gaXQgc2hvdWxkIGNhbGwgaW14Nl9wY2llX2hvc3RfaW5pdCgpIGlu
c3RlYWQgb2YgZHVwbGljYXRpbmcgdGhhdCBjb2RlLiAgVGhlIG9ubHkNCj4gcmVhbCBkaWZmZXJl
bmNlIGlzIHRoYXQgaW14Nl9wY2llX2hvc3RfaW5pdCgpIGNhbGxzIGlteDZfc2V0dXBfcGh5X21w
bGwoKSB3aGlsZQ0KPiBpbXg2X3BjaWVfcmVzdW1lX25vaXJxKCkgZG9lcyBub3QuDQo+IEkgc3Vz
cGVjdCB0aGF0J3MgYSBidWcuDQo+IA0KPiBJIGRvbid0IHRoaW5rICJyZWd1bGF0b3JfZW5hYmxl
KGlteDZfcGNpZS0+dnBjaWUpIiByZWFsbHkgaGFzIGFueXRoaW5nIHRvIGRvDQo+IHdpdGggaW14
Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoKSBhbmQgaXQgc2hvdWxkIGJlIG1vdmVkIG91dC4N
Cj4gVGhlIHR5cGljYWwgcGF0dGVybiBpcyB0byBlbmFibGUgcmVndWxhdG9ycyBpbiAqX3Byb2Jl
KCkgYW5kDQo+ICpfcmVzdW1lX25vaXJxKCkgYW5kIGRpc2FibGUgdGhlbSBpbiAqX3JlbW92ZSgp
IGFuZCAqX3N1c3BlbmRfbm9pcnEoKS4NCj4gSSB0aGluayB5b3Ugc2hvdWxkIGRvIHRoZSBzYW1l
IHVubGVzcyB0aGVyZSdzIHNvbWUgcmVhc29uIHlvdSBjYW4ndC4NCj4gDQo+IENhbiB5b3UgZ2l2
ZSB0aGlzIGEgdHJ5LCBzdGFydGluZyB3aXRoIHRoaXMgdjEyIHBvc3Rpbmc/DQpUaGFua3MgYSBs
b3QgZm9yIHlvdXIgaW5zcGlyYXRpb24uDQpFeGFjdGx5LCB0aGVzZSBjb2RlcyBhcmUgYWxtb3N0
IHNhbWUuIFRoZSBob3N0X2luaXQgY2FuIGJlIGludm9rZWQgZGlyZWN0bHkNCiBpbiByZXN1bWUu
IEkgd291bGQgcmUtY2hhbmdlIHRoZSAjMTIvMTMgb2YgdjEyLCBhbmQgc2VuZCB0aGUgdjEzIGxh
dGVyLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+IEJqb3JuDQo=
