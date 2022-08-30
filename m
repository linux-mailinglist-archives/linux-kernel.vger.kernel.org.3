Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CDD5A6C16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiH3S1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiH3S1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:27:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C180548CBB;
        Tue, 30 Aug 2022 11:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJUxCFBfeuNs5rafndypNG5eel8QvYhv33nDzA8DAX9J4TQBAfnH0oEddLoOQinu+GrO3ARf66zWz3wwmYMxEf9NOR76Sr2nF93DfEa/OKK6jwVgmeacHTRViSlaqw5RzNyD1FBvF6t3vBCiB/h2/sHCmIzFkfC9wmZtCnK2U5qCWmYYq9SJYCi3U6auX/OEuVIx4KuoKUZoXZi8bmJnU46LYgCmUH0PeWESNp/lRCKRIamYovogrX/A/a7SmHmMMc6MNMlGEydFuMc2mIrlu5V7Tg0jPQFAGcJ9A4kGc7zWIVcjJlnwFQf6Oug5balPqgI4WMrsAwKXeMI6A05vVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GOAuvZvoGlEC9049kM9eiyY5Q1dMOWWBRZkd9eJQjw=;
 b=chCSDxWLmIdi5h1YFGQ3FXsCTAmqk1Gk89lAC6r+dKaRvODTiSGE781kynKXihtQ3ZTcP+dAAb9zB5RVyglBR+ypX4Z0r4N65zGHqlmdkHeFIwmED7Vv1OqD/tzVdKaCAon5yXvuKogFFZvLOwS1UwWLdvDt4IjLTBnoVca91vZ47LBE+gkeRtCDnHT5fXVWt2KeyqgJCOBKsqH9t8ce4QZTSzxRpoYyHeKxWGGXh0i4ojQ5iCMjg+eGVo+BD9LLVih6pciU5McSp7lHJV/0GDI8xKrtTxRjwfb+Y4HpQmBVT5wFrBquf35SpNMStg4z+HUZRWe5usggYUpOExivcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GOAuvZvoGlEC9049kM9eiyY5Q1dMOWWBRZkd9eJQjw=;
 b=dn88gtDg0PBxoDFgyp3yf1Wa4TE92AmsceUMdcXuUGXauShwZdQEbcdRwgxq05usGiSNCGcCO7cXJHisW+pMUFr3ta8PmlgzRt05YEwgU5UNL3Ycog2UpL4JH3oXis1k3IqjzReUNp1KZgqXVx/N1oVR2Aq7a5W/18vKKLxe1k8=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PAXPR04MB9005.eurprd04.prod.outlook.com (2603:10a6:102:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 18:27:16 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 18:27:16 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v1 1/1] usb: phy: mxs: apply board calibration
 value base on chip trim value
Thread-Topic: [EXT] Re: [PATCH v1 1/1] usb: phy: mxs: apply board calibration
 value base on chip trim value
Thread-Index: AQHYvI0vZTIOAlUH+EGm6JIzs6EiNK3Hs+qAgAANhMA=
Date:   Tue, 30 Aug 2022 18:27:16 +0000
Message-ID: <PAXPR04MB91863CCF4D1AC2F3F9DC0A9788799@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220830162538.2845274-1-Frank.Li@nxp.com>
 <af1dd205-149b-034e-5f35-727ac1d151f2@linaro.org>
In-Reply-To: <af1dd205-149b-034e-5f35-727ac1d151f2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cbb908a-af47-4c93-8cc0-08da8ab54429
x-ms-traffictypediagnostic: PAXPR04MB9005:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xmmCd55seNjAL2cnJel/VrHEFOX9FZ2CBNiLavOkGKwOilzcc1xkYz3OQ4qMRIyEhrVciklhl/j0ug+8NuXjo4p8WcQZWfdyUfwaSiRGflm7VH+XKacqdNy0GHaH3tsAW52EcFY5REFGDDaDPDBbLti/BDnSngJWsmmnl6F3rhiLmD4BMh7bcu7Oe+GWjr7la4aAUAl5SnndkdHVGGGbsMJYxc2/OjCSEgO8WndvkfHiker6y0vAGpf0NDR8LNzfWhtv58wySaSJvgDYhRg/XQEx+b8/ByPbHvMQQMuS+tVhXvDiokaWgUmhq8XflVw0g97xxemx2BaPFR2Op6sdrkC4dS4VvXFgIUbl30zwmqXDMN73vaoZEgIKwu/BmtFbJRqQyaqX7MeFAklDzU6xwAtrU4f1mSi9xHGSxSa4DQUNXTaWYiXAg+r7wow54oz4FKYaIIVU/TVSdtPtLKLudPhlbhdJgJMF3zkNJmWnBuxZdr1KUMZ3PDxmEMJm9FeajI0OJpWY20jEEiapjVZeKO9t563PdWBlqj6Sp4nFMOI+lg2hDwvNeoiiJ+JASgTo9E8+lxHY4xMpeRal1zze6GcsCH8Ec7VT+fw3QESdkfuJf9Fu8j2Qg/0B3LpYtdrqI3Y87hVjFGbLECk+zRVL0hdgURh/Bu5OoQEii5J4rT1XPcI96WuYI9w3vZrhdsRR+ViA5hg2sG4KJ2Hg/jjDZSvNt/SOT0AHqM6ezd90mi//DpyiLKk6VrQ89TNknXCdl2BWXBi3j4I7dqe7NaQN04Hcl+LqZKQcerteVc8I6xA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(66556008)(6506007)(66446008)(2906002)(55236004)(52536014)(8936002)(38100700002)(7696005)(86362001)(186003)(122000001)(9686003)(44832011)(316002)(26005)(53546011)(38070700005)(55016003)(921005)(71200400001)(76116006)(478600001)(64756008)(110136005)(5660300002)(33656002)(8676002)(83380400001)(41300700001)(7416002)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1F4KzFhdHlkaVpSaXlNaHg4Z2o5Z3pUU3locGgwYjE5SGtGQ3IwSlF1Yk9q?=
 =?utf-8?B?WHpVVEN6M3VrMkRMRlBzSy9Cd3RLbnJlbkNkNkZWTVMveXFPbGljT1hGMGds?=
 =?utf-8?B?MGZLVTZPZmgwb1duSDArMk4vOWU5dkw4RU5GTGRtU2VIM0hVVlNCMC9yZ2FY?=
 =?utf-8?B?WXljQjJMc21BRVVqVE9kOUlCT0plUjdDWndYUFVid084aHlBaHF1bVplR1Bq?=
 =?utf-8?B?em1NUld1dUN3bmNaQkt1eFMycDd6SEFUWjQzZS9DTmRPd3pGd2Y1S1Eyazgw?=
 =?utf-8?B?UWM2NUM2WEpraW9NNjVGQXd4Y3R0dmZTV3VZMmsva0FTaEZYaDlCKzY0MFV6?=
 =?utf-8?B?cUtQM21tbkVIRGQyMkZMTStFc2Nra2x1TkFOU2NkRWRpcnAzamFLZlB0dEFB?=
 =?utf-8?B?V3dxVkpRNkM5RnZQdmdmU1kwR1BGNUZKWEJTaGZQV3ZiWk9GVmY4UXJuSDVR?=
 =?utf-8?B?SkVDZWo4KzlKUTlMV3padFRNb2RpRDNCRjFyUlJSNlV3cHJ5c2NKWkx2a1FS?=
 =?utf-8?B?aThBOVJLQ21zUlpvY25ubmFQeW1oL1h1TS9LNisvUndDTnFRVkR3VHZ1ME41?=
 =?utf-8?B?ak9pUExSZHFqQWlqVitKcy81NXEvT3FtTkM4b0s0ampoWXhQSnJHOS9ueWxN?=
 =?utf-8?B?b3h2cVlOTDBOUjV6WkNmcGtNcTVvSXkxRlBHT3dmMUt6REgxbHFPcHJoNk5m?=
 =?utf-8?B?V0dqdHVqTGltaFZuY1RiZW5hUUJnMkh0Y214VUNRUGVuWWpjc0ZQTzltSXZD?=
 =?utf-8?B?THFrMGlMcjlHeGNjK0U0cWw3WFY1VjdHQ1VzTWhzTWxFQldMNW13TjFkNVk4?=
 =?utf-8?B?Zm1PVkMxbTdSZUVNMk44Yld5SmJVS0NyMzFSTWsxVnpDdk9oaVZocm9HK3hq?=
 =?utf-8?B?TVNXZVROa0tBWENxUEFYZE9qNCtia3RBN05OWE1BY0Znc1dQL1dPUndZZ0xV?=
 =?utf-8?B?Zkk5elNtS2kxSzBYWEJDcU9tdmVRR3lITmp0TTR0V1pqWUtKbUdPUXlZUDZG?=
 =?utf-8?B?UFVNU2U3YzRTN1JFTFYzdTBla1ZwL3RMd0IrNDZ4S3lpaXF5REQyUWtjSGhT?=
 =?utf-8?B?UjBnSFJiUjMyLzhDZTArTkc3UzhISTNDMlJGblQrZmRuckk1NFlwemV2VUhE?=
 =?utf-8?B?dlFwS1lsQmM1T1N4akpvM1Nqc1U2alNLQ0lBVjVMNmdsOXozU0dQcE1KNDZT?=
 =?utf-8?B?ZENiZlpFU2drR1QyRHVRVk9rMy96TnFCUGtWVlExRXJlMmtYZFpXYmp2VDBI?=
 =?utf-8?B?bkEzdmkrd0szZVNmZE1JQ0JBUmQ0ZzM5MDdyVFdZT3dvU1UxNS90R2lLamlu?=
 =?utf-8?B?bE1qZjRIck1BeDlJU1ZzSGNCM3RobHBSYWo3cG5NV202QVhkRTFJcE9IbDBk?=
 =?utf-8?B?VnJhL1VWZFpRR3FxQU4rS2pLNHRlbytGdGdSV3pzL3NvLzRrQ1pYdG9MUzl5?=
 =?utf-8?B?RCtqSG1CbzNoZ3QwZGhrTzhrOGIvT1hNNGVFVkJBcWhHQUhBbXYvaGhLM2I2?=
 =?utf-8?B?WU1mSFpjMFIzbVhSbFhDUXJnbFhYYSsva0o5ell5WW0zQmRwM1l4T0xLQXIy?=
 =?utf-8?B?NU0rbVUyQW5aZSthaEsrUlVGaWRnVnhWODh2dkYyanpRT3BibVVJVEJNaUFG?=
 =?utf-8?B?SXVCaXYxa1dhU3ZiT3ZKUVd4dTIrSlhiU0F2d2orS04weU5JYWRLZ0RVSHY0?=
 =?utf-8?B?aGlqOVN3MjVvR0xSY0dCVkxKU2NzRnUyUmNPaG9QZE9UR0x1UHYvcFdSKzRk?=
 =?utf-8?B?Y1dNOUdHNWY2TFNTTExmY0drQnhGbW83UDBaM2sxZFoxS0xjeklGQy9DVlkx?=
 =?utf-8?B?Qjl0SXVSdU4ycWs5NE5iaEtiTHNCYlpRenZIazlwdlZrVXdBdTdhYmV3YVZ5?=
 =?utf-8?B?Y0Y5SEFTc3ZOTmJnV040VndLVUdYbUo3WkFVZHlabVlzZkpzdFE2RHZEK1lo?=
 =?utf-8?B?S3JwK3ByaGM4RDFiV3NvNDdzYndxdTNRM0Fjb2c5V2tlL3Zqcnk0WWs3MWN2?=
 =?utf-8?B?Mk5lMDNBaURtOGR4MDRYZ3pCMnBZK2J4Nk82dUljbmdQSzRxeERrRzFPOTB2?=
 =?utf-8?B?cnpsSWhtRzNKc3dJY2JwOXFxYWlqbWtROHhDUjhyQzBMNXFIRDUwMExNb3N2?=
 =?utf-8?Q?Vxf8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbb908a-af47-4c93-8cc0-08da8ab54429
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 18:27:16.3477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQzfR4wA9vcHBfqLRuvH/KNsYwH11WHnnLtTWpE4YRPZS59maeqyeW9S/iPMV6o/7JHX9+PglrshE+2s4NFqjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBB
dWd1c3QgMzAsIDIwMjIgMTI6MzMgUE0NCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29t
Pjsga2lzaG9uQHRpLmNvbTsgdmtvdWxAa2VybmVsLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3Jn
OyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVz
dGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgYmFsYmlA
a2VybmVsLm9yZzsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpbnV4LXBoeUBsaXN0
cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiBT
dWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYxIDEvMV0gdXNiOiBwaHk6IG14czogYXBwbHkgYm9h
cmQgY2FsaWJyYXRpb24NCj4gdmFsdWUgYmFzZSBvbiBjaGlwIHRyaW0gdmFsdWUNCj4gDQo+IENh
dXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gMzAvMDgvMjAyMiAxOToyNSwgRnJhbmsgTGkgd3Jv
dGU6DQo+ID4gVVNCUEhZX1RSSU1fT1ZFUlJJREUgcHJvdmlkZSBjaGlwIHRyaW0gdmFsdWUuIERU
UyBwcm92aWRlIGJvYXJkIGxldmVsDQo+ID4gY2FsaWJyYXRpb24gZGF0YS4gQm9hcmQgbGV2ZWwg
Y2FsaWJyYXRpb24gZGF0YSBzaG91bGQgYmUgYmFzZSBvbiBjaGlwDQo+ID4gdHJpbSB2YWx1ZS4N
Cj4gPg0KPiA+IEZvciBleGFtcGxlLCBUWENBTDQ1RFAgYm9hcmQgbGV2ZWwgaG9wZSBhZGQgKzIu
ODUlIHJlZ2lzdGVyIGJhc2Ugb24NCj4gPiBzdGFuZGFyZCA0NW9obS4gQnV0IGNoaXAgdHJpbSB2
YWx1ZSBpcyAtNS4yNSUgdG8gZ2V0IDQ1b2htIG91dHB1dC4NCj4gPiBBY3R1YWxseSBmaW5pYWwg
VFhDQUw0NURQIHNob3VsZCBiZSAtNS4yNSUgKyAyLjg1JSA9IC0yLjQlLg0KPiA+DQo+ID4gSWYg
Y2hpcCBoYXZlIG5vdCB0cmltIHZhbHVlIGF0IFVTQlBIWV9UUklNX09WRVJSSURFLCBObyBiZWhh
dmlvcg0KPiBjaGFuZ2UuDQo+ID4gYm9hcmQgbGV2ZWwgY2FsaWJyYXRpb24gd2lsbCBiZSBhcHBs
aWVkLg0KPiA+DQo+ID4gSWYgY2hpcCBoYXZlIHRyaW0gdmFsdWUgYXQgVVNCUEhZX1RSSU1fT1ZF
UlJJREUgYW5kIG5vIERUUyBib2FyZCBsZXZlbA0KPiA+IGRhdGEsIGNoaXAgdHJpbSB2YWx1ZSB3
aWxsIGJlIGFwcGxpZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBMaSA8RnJhbmsu
TGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvcGh5L3BoeS1teHMtdXNiLmMg
fCA0MA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IFVzZSBzY3Jp
cHRzL2dldF9tYWludGFpbmVycy5wbCB0byBDQyBhbGwgbWFpbnRhaW5lcnMgYW5kIHJlbGV2YW50
DQo+IG1haWxpbmcgbGlzdHMuLi4uIGFuZCBkbyBub3QgQ2MgdW5yZWxhdGVkIGZvbGtzLg0KDQpb
RnJhbmsgTGldIFRoYW5rcy4gSSByZXVzZWQgY2MgbGlzdCwgIEkgc2VudCB0aGUgcGF0Y2ggeWVz
dGVyZGF5LCB3aGljaCBjaGFuZ2UgdGhlIHNhbWUgZmlsZS4NCk9ubHkgZGlmZmVyZW5jZSwgIFRo
aXMgcGF0Y2ggaGF2ZSBub3QgdG91Y2ggZG9jdW1lbnQuIA0KTmV4dCB0aW1lLCBJIHdpbGwgcmVy
dW4gZ2V0X21haW5haW5lcnMucGwuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQo=
