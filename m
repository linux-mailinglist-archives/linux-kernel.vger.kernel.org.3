Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7B356646C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiGEH4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiGEHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:55:53 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9476113D1D;
        Tue,  5 Jul 2022 00:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAKay+QV+2de6tv5K6fvWsInyO/eXFuLsBA8QmWv5ad1cFcyHwMtnCaFvHXWU5s8Y8i/wtXHwdbtbb19dfLk0ag3f+XJZwWZPZfajongaNoeUZ+MyMhjnL1GKnJQV+R/497xlEeMN9zO9NSq6Z245PA3ANLGbIx8dWtuYPeG6Wwi744O+IP9ylXme7YVT2W/m7b776kBjvCF5x5Ozchq7XFJnBwQIwOYAgJawNmOpHtL54b6HOZ8Z7mXiYx0QPUTtcC9xUp+WmB2+3e171+FDR1Ha+BVYKAvitFcEbMzeJUrM1kOkQw7IkhysDY1g6jlI6slGYzDcVwwz2cVmvfRRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeYvzR0yegkanhW3HOAkPwn/4NaLXxFYRVpN3noAF9M=;
 b=drVk218Wqd3C5WxgXvfy323qHdt2CnIAOqMBVCygUhbn5FlMHXC0U28dUKYMdQdPZkweX/6hg3fRf5vg4TDfkTpTRc4bjYTGG5HuaMY7Hv7fpSrHkKpknWu3FixQRvHNHQiKLssyqW7OEATOWZcXjrSl1LAVycNL9hLbaB92Vm/xF6Vj6166aj113e4jHFd3WjwAJxo78A21wMvmUdKQsyr+rOjchGkxI44o0S1h9vrsNv765FwECTNV+P7lKDCTUtzpEHssviD8BZs1ieyuAi92w43pCSH4mVTbUwM5VXfzZZyeCVOXCuDVwU9QcjOLguNhsRnC2fI0esIz3mc/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeYvzR0yegkanhW3HOAkPwn/4NaLXxFYRVpN3noAF9M=;
 b=dw8RYMf+olpp5h+9TufznQbI4jZDlWUONgn9/5GtO9dAwEjsu600rEuheGTeclLcvNNy5TnoAumtzGnkr+kXhQyRoYnORJ1nUs/m43FPwTgFn75HP+KoHcMN/UtXtFqmXzjoTiwPj20QUvJMtEIGbEBEKF88vX19yNEFDPNGfGE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3430.eurprd04.prod.outlook.com (2603:10a6:209:8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 07:55:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 07:55:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>
Subject: RE: [PATCH V3 10/10] arm64: dts: imx8mp: add NoC node
Thread-Topic: [PATCH V3 10/10] arm64: dts: imx8mp: add NoC node
Thread-Index: AQHYjrzVKOHg0f0OCEqv+3d7lrk86q1uPKuAgAEtViA=
Date:   Tue, 5 Jul 2022 07:55:49 +0000
Message-ID: <DU0PR04MB94176FE06778DDC1EFB7A36188819@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
 <20220703091132.1412063-11-peng.fan@oss.nxp.com>
 <36d8fbe2-b64d-4997-5836-b2c32e4d987f@kernel.org>
In-Reply-To: <36d8fbe2-b64d-4997-5836-b2c32e4d987f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb78e4ef-4ba9-422d-700b-08da5e5bc6d5
x-ms-traffictypediagnostic: AM6PR0402MB3430:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LXWagEO4ZLJb9ouLFUcJeLHpi+tCAC5Wh5KM3SuYiNexoraTMbzVmROVoA9tx4UnarfVl+seDxD9N3Vq4C3oOVf1K1VllgtU+/IGZqMDtvLOxXpXzTZei5Fz/Ct+2/aa66gBcSoLWMd0ph6nGxJ8X8WtgGyvwavawGRcpG2EdU+2fnlPfV7RUb9fxFJ++wYbBUi21zDKBgi/0JabXRCC22QpDwkscAtMUZkLH4Y3nZXiNQBPW4YrN+V8nfyHLzK+WyAEp0fadHXOduG5PdCvvegZmlT1N5R/a9mAHRM+1HmpzpGin0tRiU7qaQ9BjMs/Av21qeuy0/ecJOfPwC1jzqdWKHQkgsr1F43Q2ER7MSMGmc+NkSxb3k6YUCYBkyVXEkU0vs9M5a0D9gtIXBKnz+I8KU3BK05wypYq9Ex7vLzU/Ygucjd1Y2tM5CGM/sVBk62iBaKXq48aDFRND1AKzBF+KAC4VM/McplzUJweU4JwZq3pDhybdOI0LPBd/1CI8Ezi242Xmdo9zjnYV8FO8jPxdnTCVWYZr1p4N+PNBrJCOkL2fEQkYECV/iquPIzGfVQZLz9qRZBbnmPYSxHES+nRy3iWadqtKZ3qaByWd4t3lEt808/rhVwG5Y55+z557EzJTfmkeDkR8iHDwTA0FoWEy0/bTZADabbX+Mnx0Rbpc8Y6KeHnx0QsHQVl4/MKaUOCNjUIyVeGCPkxyZQf/FrFZQmhaukrI9pJHmfBuL6hUWlsVxJDpS4tZqcCBIgxXWDS62jSz6/NvmcGdEd7UNAnW0WDZCDKpYW6laUmyi22fR/ZoCYYfYkQ5JW2cCHUePd/+jj9quhqfjZNug2aVQZJk7n1E+DkU5o75bzrrYY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(186003)(8676002)(4326008)(38070700005)(921005)(122000001)(38100700002)(55016003)(41300700001)(316002)(83380400001)(9686003)(53546011)(110136005)(478600001)(71200400001)(2906002)(6506007)(26005)(66946007)(66556008)(44832011)(66446008)(5660300002)(66476007)(64756008)(33656002)(76116006)(8936002)(52536014)(7416002)(86362001)(54906003)(7696005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R29maVlZMTRGSHcxbGY0MXdlUm1JZjJ2Q1NJcm9rcEhTOU1SNjV3Snp2MStW?=
 =?utf-8?B?Ymtxamo3ZUxSaFJLcE5vVzNXOHo2bUpyd0JBWHNNaU94WklKcnlIVGEvTnZm?=
 =?utf-8?B?YXJOYThobGhjNHd0SVc1MmdpdlFuaHdxR1c2WHBsYVNVWE8wSVZaSzNTSExr?=
 =?utf-8?B?SUpVcm5OUmM4NmcwVUU3QUlyTWJ2Y2RDc09yTXJBWi82QnBUcU91Mm1GRU9M?=
 =?utf-8?B?RURQUVNjNlJBODYzMmZ4bjNodk5tMWtOaVFOMXZGZ2FOckxmbTM0M1AwajAw?=
 =?utf-8?B?ek5IUGJGUkt5MTF5NDV5bkVuRFVLUEdvY0hHQWpzYkl3eUlYMms0NW5hWE9Y?=
 =?utf-8?B?Lzg1RnlVSG1rRENnV28vTHcxSVhjZ2MrYklmVDJWd1FTWFhxSU9xcVpyNjM0?=
 =?utf-8?B?aXlBMzdSZmxud0VLNlRqdEtTeWxwV1FocnM3VGRvVDV6UjhtQ2o4VjFnZjh6?=
 =?utf-8?B?MlE0QWIxbzRobW0wcThyRGhtUWJxWExsdE1STVJHWDZ6cFBjTkZJN04rdVhN?=
 =?utf-8?B?cUhxRzhTT2VWRW9hdlA1Y0tRNHEyMDk5RjlSaVBuQjFTUmJUUU1INFo3WHFL?=
 =?utf-8?B?dXhyYlRIUzB0cHRBeDYydXBzMWdiOGllR0g5ZkZwYjVjeVpiMDFuRnNCSEJz?=
 =?utf-8?B?ajFHVWZhUGNJUWVDWXZUelBoNTlQRlN6M3o1MVFuK0JjWVdITkJJVHpSMnFx?=
 =?utf-8?B?RENGS0R6OWhGdjFmVmNwbzhxNEdxeUdCRDdBNU0zWWlFc09OOEtIaytuQTVL?=
 =?utf-8?B?V3RYRThGTGhQSzJWSENOM1BHZCtnVnF4T0xHanJmQndGV0VycHRhc2wyYlh5?=
 =?utf-8?B?dXlKa2ZNcDI2YXZZNFI4SVRyZ1hreVo2dStqZitDY3NObm9BUnF0Z2RTTFFZ?=
 =?utf-8?B?UTdPL3JzWWtnWDVyMW5OemttWGY2aGhQa3FIbUhoemkyMXExQy9JbUkwK013?=
 =?utf-8?B?M0dYb2I1OE9STzhYWnEwWkZ1QWN5dWkwelJwejI1bUIrMXltaU9lczR4L2t3?=
 =?utf-8?B?cGZHdkdReTVFWnlVZFVVcTF1NkdaQW1tNW41Q1JJUVIwVXNFc0hGdkpRd3Jm?=
 =?utf-8?B?U011N25UeWk4ckVBdTBFUlRkMFZMT1Jnd0JaM0FPZ3htUm94VmJKU24zUG5t?=
 =?utf-8?B?WlR3VlNZUWNlbDE3Z1IxSjdZMHRaWUwrc2F0WFZsS2pGQlh1ZS9YL3YzTTFl?=
 =?utf-8?B?Q2l1RmZoeVNJWC9tVGFaU1VacEpKSDY3eER5SDNUZ2M1ODRTbmpyUDZUcTVQ?=
 =?utf-8?B?SjRLa1YyUXl0cVl5Y2N3WlRIYUg4TkxKeU0zcEFabndKNTUvZ0dEdkdsZTEz?=
 =?utf-8?B?Z1p1Tjh0d1ZMdzFSWUIvdXREWnRmMStsWjkrR1V1ZWxrdGlza2t1S2NZZjhV?=
 =?utf-8?B?YXd6ZE44dmtRRjcxRXpQVGpCdjU4ZWF3WHlFYlNJeGwvQ1k3Sko2dTdMUzY3?=
 =?utf-8?B?KzV1ZzVxZ2hPVFZ4TkdRcEZyYjF6cFF5UEVmVXpqYTJqbURTUWx4UnlEZ2FD?=
 =?utf-8?B?YU5oci9jTkl2bmptbVR5alBCSDFNS2ExYUJnVjVCM1BLMUdKck5KQkdmZzdl?=
 =?utf-8?B?bTUvbW9FZzQ3MzBsWkJvSUF6S2tyQnVkMzZPRGo3NmIzY2FWS2dwOHBwRnpm?=
 =?utf-8?B?RGFGZmxYRGUrSTZlNjBYWERsUGdsMWFhOTR4SFIzc1BJQnBwY0pxbHBOU0lJ?=
 =?utf-8?B?REVNYnViMDhDQmNEN0FrdXN2WlQ2WjRZSXVkZDNjSjNSWldyUXBKZ0VlMG1a?=
 =?utf-8?B?Qm5qQ0VzUXhGRVAzRWpCcU1PbW9jeTVDTTR0QTdHWkh4KzYzdUxBeS8wQTN0?=
 =?utf-8?B?V05lcVZ6TnhrWjBEL0E4WE5IQXEyWjVMMEdhTFA5OUx5aVFmUVNZM2tXSkRm?=
 =?utf-8?B?WDVORzdEQWx0bTFLc1dMS3B3UlBwY3lhQXB6dFNjMk1QdUlmclRlOEN6dG5U?=
 =?utf-8?B?Uk9ZVHM5TVNic3dIMWo5MmRtcXVKTm5JMG9TS2ZOcm9iTTJpek5YdXE4dXFj?=
 =?utf-8?B?MHBGVzRKRWhoRXQ5eDV4RUd4bWFSSHAwQXFOVkdvQVdVS3RaV01SMkxWeGl0?=
 =?utf-8?B?TTdSMmtBdkxPNkNjNUtzR3BCZ0NCTTFHRWJtbU5VS1Z4YnVCd0FiMk9OQmlj?=
 =?utf-8?Q?Y/wE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb78e4ef-4ba9-422d-700b-08da5e5bc6d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 07:55:49.6633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xZAWixcIsjXgJrVlMlnypiXT4RUr3++vjp9wGCNRPxi3Fzzfi3GMlQtNidtA0htFYGYe+pUAVZYd+7BrjasdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VvcmdpLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMTAvMTBdIGFybTY0OiBkdHM6
IGlteDhtcDogYWRkIE5vQyBub2RlDQo+IA0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIDMuMDcu
MjIgMTI6MTEsIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPg0KPiA+DQo+ID4gQWRkIGkuTVg4TVAgTm9DIG5vZGUgdG8gbWFrZSB0aGUg
aW50ZXJjb25uZWN0IGkuTVg4TVAgZHJpdmVyIGNvdWxkDQo+IHdvcmsuDQo+ID4gQ3VycmVudGx5
IGR5bmFtaWMgZnJlcXVlbmN5IHNjYWxpbmcgb2YgdGhlIGkuTVg4TVAgTm9DIGhhcyBub3QgYmVl
bg0KPiA+IHN1cHBvcnRlZCwgb25seSBOb0MgaW5pdGlhbCBzZXR0aW5ncyBhcmUgY29uZmlndXJl
ZCBieSBpbnRlcmNvbm5lY3QNCj4gPiBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpIHwgMjINCj4gKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+IGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kNCj4gPiBpbmRleCBlYjJk
NTE2Mjc4ZWIuLjEzYTJlZTc3ZDNjNiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ID4gQEAgLTQsNiArNCw3IEBADQo+ID4gICAgKi8NCj4g
Pg0KPiA+ICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2lteDhtcC1jbG9jay5oPg0KPiA+
ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJjb25uZWN0L2ZzbCxpbXg4bXAuaD4NCj4gDQo+
IEl0J3MgYWxzbyBwb3NzaWJsZSB0byBkcm9wIHRoaXMgbGluZSBmb3Igbm93IGFuZCBhZGQgaXQg
aW4gdGhlIG5leHQgcGF0Y2hlcw0KPiB3aGVuIHdlIGFkZCB0aGUgaW50ZXJjb25uZWN0IGNvbnN1
bWVycy4gVGhpcyB3aWxsIGFsbG93IG1lcmdpbmcgdGhpcyBEVA0KPiBwYXRjaCBpbmRlcGVuZGVu
dGx5LiBCdXQgaXQncyB1cCB0byBTaGF3bi4NCj4gDQo+ID4gICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvcG93ZXIvaW14OG1wLXBvd2VyLmg+DQo+ID4gICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bp
by9ncGlvLmg+DQo+ID4gICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW5wdXQvaW5wdXQuaD4gQEAg
LTEwMTksNiArMTAyMCwyNyBAQCBlcW9zOg0KPiA+IGV0aGVybmV0QDMwYmYwMDAwIHsNCj4gPiAg
IAkJCX07DQo+ID4gICAJCX07DQo+ID4NCj4gPiArCQlub2M6IGludGVyY29ubmVjdEAzMjcwMDAw
MCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC1ub2MiLCAiZnNsLGlteDhtLW5v
YyIsDQo+ICJzeXNjb24iOw0KPiANCj4gSSBnb3QgdGhlIGltcHJlc3Npb24gdGhhdCB3ZSBhcmUg
ZHJvcHBpbmcgdGhlIHN5c2Nvbiwgb3Igbm90Pw0KDQpJIGp1c3QgY2hlY2tlZCB0aGUgZHQtYmlu
ZGluZ3MgVjEgbWFpbC4gWW91IGFyZSByaWdodCwgc3lzY29uDQpzaG91bGQgYmUgZHJvcHBlZC4N
Cg0KPiANCj4gPiArCQkJcmVnID0gPDB4MzI3MDAwMDAgMHgxMDAwMDA+Ow0KPiA+ICsJCQljbG9j
a3MgPSA8JmNsayBJTVg4TVBfQ0xLX05PQz47DQo+ID4gKwkJCSNpbnRlcmNvbm5lY3QtY2VsbHMg
PSA8MT47DQo+ID4gKw0KPiA+ICsJCQlvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZub2Nfb3BwX3Rh
YmxlPjsNCj4gPiArDQo+ID4gKwkJCW5vY19vcHBfdGFibGU6IG9wcC10YWJsZSB7DQo+ID4gKwkJ
CQljb21wYXRpYmxlID0gIm9wZXJhdGluZy1wb2ludHMtdjIiOw0KPiA+ICsNCj4gPiArCQkJCW9w
cC0yMDBNIHsNCj4gPiArCQkJCQlvcHAtaHogPSAvYml0cy8gNjQgPDIwMDAwMDAwMD47DQo+ID4g
KwkJCQl9Ow0KPiA+ICsNCj4gPiArCQkJCW9wcC0xMDAwTSB7DQo+ID4gKwkJCQkJb3BwLWh6ID0g
L2JpdHMvIDY0IDwxMDAwMDAwMDAwPjsNCj4gPiArCQkJCX07DQo+ID4gKwkJCX07DQo+ID4gKwkJ
fTsNCj4gPiArDQo+ID4gICAJCWFpcHM0OiBidXNAMzJjMDAwMDAgew0KPiA+ICAgCQkJY29tcGF0
aWJsZSA9ICJmc2wsYWlwcy1idXMiLCAic2ltcGxlLWJ1cyI7DQo+ID4gICAJCQlyZWcgPSA8MHgz
MmMwMDAwMCAweDQwMDAwMD47DQo+IFBhdGNoZXMgMS05IGxvb2sgZ29vZCBhbmQgSSBhbSBwbGFu
bmluZyB0byBtZXJnZSB0aGVtLg0KDQpUaGFua3MsIFRoZW4gSSBvbmx5IG5lZWQgdG8gcmVwb3N0
IHRoaXMgc2luZ2xlIHBhdGNoIGZvciBhIG5ldyB2ZXJzaW9uLg0KDQpUaGFua3MsDQpQZW5nLg0K
PiANCj4gVGhhbmtzLA0KPiBHZW9yZ2kNCg==
