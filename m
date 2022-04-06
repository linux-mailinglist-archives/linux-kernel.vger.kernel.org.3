Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406254F6070
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiDFNrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiDFNqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:46:42 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150077.outbound.protection.outlook.com [40.107.15.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAFB5AD5DD;
        Wed,  6 Apr 2022 03:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrLF8pvYw0+fdRNXBfJ4uuewkrwGDDRMoNNvQ/076m4spncpOgHRlAlnRN4ZT9nVhXdcu4TQtxIY0lyMCTGxXjotj6VmCTxOhHWS188suHgWUarZRizKlTyNfpTCYLPUrJEjt8wVw7o0vcaU34v0lslFFb2HmdnnbxUxoOhnqiTrERYT9THS2+KWSpUTu+232aybksXtg/XNs+48VPC6/xoBTszxnobdCWK2YHar6RjNyIeFBfmiVqUUcJAbPANcKbHZccOrqxbf8t8qeaMS+6mTM/s4L7CI1abEi8Fb/NuP2IYMRnkZ/zoUXBMiwiLmbiIaxXVFfKKj0I+jK/RM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpGUaXHt/qad7uqaHdjouwUUUWTeDYC/o+sfB5CD5RQ=;
 b=mkk8uy2yCrA5r5ge2IW70pxij8+6DOZ2b0ZV/h0z0tBJPLRq79oCOLz4za4JSexbbFN3fMW+VOy92EdZZjjwdQB7EEhcKWQvVEoqhRDTVFv2SFCPVdK1+JzQk7xDdu5UHx1sBJiX3X90nYtQCDpED55b/T1ZYEIFGzCS2jbGrDMjYiAJ4xzmuAGLCuv2tLWdgn5VqPbvpYrI9YRRoYzskBoD+r417Lcrd/xyJcCyopcTYPppdtHlLkx59QoSckF9DvgiG/QFsfup6dEyo8oMJEdQGGm4G+IUNJqVX4C0OEkwwKOyGh/BGHA4AhKOAQIAe/aNx2GpVGz/WrfTD4BWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpGUaXHt/qad7uqaHdjouwUUUWTeDYC/o+sfB5CD5RQ=;
 b=JUxfJ/IZciK1jzPlit6cSOIDEr2CqERlta2FMlj1WETO+5lnGivb/4sNW+aYF1yFWQs/qHlNstBY3UUJXnSwYcnerza3WBk+5wT8YFSBV/lYR2fSW8WNH7ZsCUcDFZlqRorH9K6WfpLVbRG0C0PnKibaciqegmPBtR8xCj4bXfg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5717.eurprd04.prod.outlook.com (2603:10a6:20b:a6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 10:58:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 10:58:42 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/2] remoteproc: imx_dsp_rproc: use common
 rproc_elf_load_segments
Thread-Topic: [PATCH 2/2] remoteproc: imx_dsp_rproc: use common
 rproc_elf_load_segments
Thread-Index: AQHYPoHwmvqKFapWfUij09mR4uCn46zivpwAgAAOdHA=
Date:   Wed, 6 Apr 2022 10:58:42 +0000
Message-ID: <DU0PR04MB9417DEFA09AB85211AA72A2E88E79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220323064944.1351923-1-peng.fan@oss.nxp.com>
 <20220323064944.1351923-3-peng.fan@oss.nxp.com>
 <CAEnQRZB1LL=d3SBCgNomPErBvzEgTVtbBE_PH=V60v-_9UObEg@mail.gmail.com>
In-Reply-To: <CAEnQRZB1LL=d3SBCgNomPErBvzEgTVtbBE_PH=V60v-_9UObEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3e7a78c-3d4f-4832-428a-08da17bc69e3
x-ms-traffictypediagnostic: AM6PR04MB5717:EE_
x-microsoft-antispam-prvs: <AM6PR04MB5717A9F68EBC6D10B2859FF688E79@AM6PR04MB5717.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FGNp34nfupI29LWdM+eohbvE1XmZecu4++2dO5jpOIvhpaTl/9DWkolkCovYadqHZWJKY246wdpdfTyFIv/oAp9FYW+HRrAXH/dH1HQ+azTs/r/7YpsaiaqpTyPeI0s++5V8bTzVueYL38Z6lSOqzEhawT1QUmlH2LlGqt2s9oy1xAIjGL+Ow2YiGa7iQQWUFwm4QAGxzXCyCJblpewmTpfks1wLPxb2H4Dkp1ZEu8OjYHR/9SSz/ERyLx4SO0epLKjitBwki1QuCPQrkAhQfmGfbi+tSVmNMWIo7uweOZYpcwYuBMXuzCVlBooe+pNzZbTaedkBDXsCZ+lhpnfuct1iVkV8ueNUbePXCQst958UAQ5MxU4WgiCWHj7L+6KxV6Pmr4CcQ7Co9S7nldXC+XeWdq8wGl8epYNwkPRZC2uynLbX+GyPSm5M7i0cl4PEkw7oYkUoWAlBgzv58HIz8ydp72eD7jEJZ3bw+btK7bItdwvPBCW9z2DUQbYT4DzihISEbZf6D+5mncYNpgL2lH8CRPfJ2AEFlrhQWZw/MOqcFcRcgdONUyVIpRUBMrO0IFfhynKfLawakpYPf0/I0Eb6Q2rSsdjC4LD9bmphHtwYVZAZGB5giYLvO3LYfTx5FdhpUiXM1N5d1jf512SomouJtEhOcxRa1EgshRk+Mj/ZrskN3Kdh6/6bXWDaGs4Fr6e7BVmwFw4u+i6fWIK2bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(2906002)(5660300002)(53546011)(6506007)(52536014)(7416002)(86362001)(8936002)(44832011)(55016003)(7696005)(186003)(508600001)(26005)(83380400001)(9686003)(38100700002)(64756008)(122000001)(54906003)(8676002)(316002)(110136005)(66476007)(66946007)(66556008)(71200400001)(66446008)(76116006)(4326008)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elgzanhiRkZmSEM5Vkg1UDh5WHZkWWc5ZStJT1lwZ1BjL1psOElxZWlYbUgy?=
 =?utf-8?B?VlRRODlvSk00aFJVOVowZVBFSVMwWnIzVE9XZFhwcGx6ckdjV0lVTFhNZmJo?=
 =?utf-8?B?aGZmVjcwclVaM1RqQ2xuNmx6YmV4blZXTmhwdkNUTE1obHNIV3dYN1F6a3Rs?=
 =?utf-8?B?Si92RmJ0ci9lbzhxQ2k4cnVMbXNIclN0WGNNZ1lKRkFXb0lrUUZ6OFJKWWxW?=
 =?utf-8?B?K3RPZVR0Y3NFTkV3VHVtOWJNa25Ic3dtbHVWSXFlZjh3K0Y1ZCtSU2FBcUFG?=
 =?utf-8?B?RVp0WFhibW91YWpEK09pSXowYmd1VXlFMVBsRHl6Z3F6cEJtcG50OG1nMk5l?=
 =?utf-8?B?bTlrM3MxMS9uUXZ4Vy9yVzF0OXNlN2dKYVRZOTNBMVd0Wk1LWENyOE1BTGxr?=
 =?utf-8?B?Q2lMazlGdUN4dlZSOXlab0ZmbDlvNTFraVpXNjg5OXhiOGVVei9SeFF3NE9C?=
 =?utf-8?B?d3lRdHV6ZUZuYmMwZ3ZRczRQY0VKZDc0MGlzNzRRQ2ppdXczS01sTzRJWTE2?=
 =?utf-8?B?WCsyZlR6cnlsaXA4V3JpSCtFMlB2ZnIvL09pc25uajlLUXBWNzRRa3F5NUZ6?=
 =?utf-8?B?cksrYVZkbFR5d25sMVYveHBFa3hDTmNBSWtNM2lxQytPdCtsdnFwUFcvY29m?=
 =?utf-8?B?cG8wb2FUQjFRYzFla2wvV3g0Y0tKQWI0QVpmVGsxT3VRNTNidDEwenhzQ2Y1?=
 =?utf-8?B?aVZlNDlVRVF6OTlRcnZicTYzWElPMHFqUE5HOWt0QXNNS0dmSTNWN09FNGZ1?=
 =?utf-8?B?TVpYejNKb3E5OU1UYUNOci8xUm9ETlcwS1pRclZ3eFVpWVc5TE8xcDRqcVgv?=
 =?utf-8?B?Myt3WU5qN1FBbjkyQzBuWCtzK3M4Vnc3UDZWZUFTbExPemFYTVpLbjNpVUJY?=
 =?utf-8?B?N2FaM09VYlJldUVWLzRxMmdmSEcyMVZ0NFl5cjRtaFR1TEFiVmxEYnRid212?=
 =?utf-8?B?ME5BRDNURk5sdXB3Z0pUUVpBeERPR0FIdzJEZ3oybnJkcm5WeHFKblRoUDhK?=
 =?utf-8?B?QWF2Mk03My9KNVhLM3NtQ2x0a01KOHkway9JYnY2SlZ4S1J5OCt5WmpNcGlr?=
 =?utf-8?B?Z1BwZDAwSDhTQXQvUFErb2g5RU9HTjEyQnh3VzRwMEFvdzBPamZaQmhPUFNz?=
 =?utf-8?B?M2s3SG9PbnlmcFRrempELzNtWHhPd3ozMVJYZlF5cXovazErN3FGWHVIMXhv?=
 =?utf-8?B?SnloS0MrYTFJS3lZaE1nL0lHL3p1Uk1ObG96WmRwM2UxUE1ra0wvVjc1eWhQ?=
 =?utf-8?B?Z1g4RXhoYklyRk5yU1ViQjdMQlFOQ2wxSlJLd1ViTjZiTWVoYjJlbnFITmtB?=
 =?utf-8?B?U2dwSTJEYzFnYjlaQnptbXRtajdYVFZrZ2ovVDlDMGd0OS85RkZ2bVJ2M3g2?=
 =?utf-8?B?YUZRL0Yvd083MjVvUE4zQW56NXhoY2ZkSTVqekdzTTN1SUphdHFKTHNaM01v?=
 =?utf-8?B?RlFpUGxyUUJUWGp5a1AxOVNqYXlDV2ZpWGp1Y0dyTDlRZWRhZ2g3M3Z4K1Y5?=
 =?utf-8?B?WGFCSWpyMHZtbkZaYkpnRGhHd2dTblJxNldvUng4cmNjV2YrQ0VUaFpoQVZl?=
 =?utf-8?B?eFhTQ3pLYld3S3JBMlYvcHh0Qiswa0pDRklvUDJ5TGs1d2FITVJUWW9IV04z?=
 =?utf-8?B?dUFCTzB5N0lkODNOYkt0SzVhZGtqOEhzbG8rUjlMbm96YUtrRXVQak01amJ1?=
 =?utf-8?B?aUl4R1BQeW1KTGV6K2hXM1ZzcjhtT1d3ekdmWlJRUUtxcEk1SHVDZ0pVcXZ2?=
 =?utf-8?B?VEt4Z3Vrdi8rZXA5NTRHdkFMZlVFaVJHSmRDeVY5Z1dOczRETE5zQi94SHhk?=
 =?utf-8?B?TUN0OHJmZFJLTkVyTnFrbWhncklialg4ZDI5OUFMb1cxSGlHaTU5KytLV1F0?=
 =?utf-8?B?WVEyT3FRQTVPSW9kZVVBb3luWDB3Vk84OHhaUGZLdDBpV2FRa2xNZlRCb3NX?=
 =?utf-8?B?U1d5TklGWU5CVm9mWHBtNzduNEp6OEgyeTJMUW93WEljQjZZZHVibWdqbE9r?=
 =?utf-8?B?VmFVcmljdDdFY1luR2MyR0JNeHUxNmlXTzR5VHcxR1ZFOUtYbUxPTTQxQ3dR?=
 =?utf-8?B?U09FSkNWTVNHYUdKVFM4dkk0NUUwYysySERUS1grQkJOMWU4L01mQnRuL3Zh?=
 =?utf-8?B?a244eUNtNnpmQXJtOGV5QlBzT1ZxdW41QTUrLy9uaFdFVUxlek1aa3ZNRDg0?=
 =?utf-8?B?NWZQTTNrM1pSbld1OEJPQWxoRVZJZDM1UUFIcG0xRFpxNFljNUZQYXlockJO?=
 =?utf-8?B?elZJU2lmVjdRZldmMVc2elVIc2pDS3RYb0wzYTZsZUJ6MUM1TjNYZWJmSTNl?=
 =?utf-8?B?TlN3WElJYVg3T3E5aXhjZG9GbFVKN2w3cWxMMDZONTRKa1h5ZUo5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e7a78c-3d4f-4832-428a-08da17bc69e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 10:58:42.3201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHF5nr+XWim8iifWKGcTkjxa64z3SkqFbgCsYthcXXNesbeeWhJI1XIFxctSuOSFR1PuQrjOxqMftCcRX8UdTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gcmVtb3RlcHJvYzogaW14X2RzcF9ycHJvYzogdXNl
IGNvbW1vbg0KPiBycHJvY19lbGZfbG9hZF9zZWdtZW50cw0KPiANCj4gT24gVGh1LCBNYXIgMjQs
IDIwMjIgYXQgMTozNCBBTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4N
Cj4gPiByZW1vdGVwcm9jIGVsZiBsb2FkZXIgc3VwcG9ydHMgdGhlIHNwZWNpZmljIGNhc2UgdGhh
dCBzZWdtZW50cyBoYXZlDQo+ID4gUFRfTE9BRCBhbmQgbWVtc3ovZmlsZXN6IHNldCB0byB6ZXJv
LCBzbyBubyBkdXBsaWNhdGUgY29kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiANCj4gSSB0aGluayB0aGlzIGNoYW5nZSBPSywgYnV0IHdl
IGhhdmUgYSBjYXNlIHdpdGggdGhlIERTUCB3ZXJlIHJlYWRzL3dyaXRlcw0KPiBzaG91bGQgYmUg
ZG9uZSBpbiBtdWx0aXBsZXMgb2YgMzIvNjQuDQo+IA0KPiBXZSBuZWVkIGEgd2F5IHRvIHByb3Zp
ZGUgb3VyIG93biAibWVtY3B5IiBmdW5jdGlvbiB0byBiZSB1c2VkIGJ5DQo+IHJwcm9jX2VsZl9s
b2FkX3NlZ21lbnRzLg0KDQpJIHRoaW5rIHdoZW4gZ2VuZXJhdGluZyBlbGYgZmlsZSwgdGhlIHNl
Y3Rpb25zIG5lZWRzIHRvIGJlIDMyLzY0Yml0cyBhbGlnbmVkLg0KDQpSZWdhcmRzLA0KUGVuZy4N
Cg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9yZW1vdGVwcm9jL2lteF9kc3BfcnByb2MuYyB8
IDk1DQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgOTQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9yZW1vdGVwcm9jL2lteF9kc3BfcnByb2MuYw0KPiA+IGIvZHJpdmVycy9yZW1v
dGVwcm9jL2lteF9kc3BfcnByb2MuYw0KPiA+IGluZGV4IDJhYmVlNzhkZjk2ZS4uZWVlM2M0NGMy
MTQ2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9pbXhfZHNwX3Jwcm9jLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3JlbW90ZXByb2MvaW14X2RzcF9ycHJvYy5jDQo+ID4gQEAgLTY0
OSw5OSArNjQ5LDYgQEAgc3RhdGljIGludCBpbXhfZHNwX3Jwcm9jX2FkZF9jYXJ2ZW91dChzdHJ1
Y3QNCj4gaW14X2RzcF9ycHJvYyAqcHJpdikNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9
DQo+ID4NCj4gPiAtLyoqDQo+ID4gLSAqIGlteF9kc3BfcnByb2NfZWxmX2xvYWRfc2VnbWVudHMo
KSAtIGxvYWQgZmlybXdhcmUgc2VnbWVudHMgdG8NCj4gPiBtZW1vcnkNCj4gPiAtICogQHJwcm9j
OiByZW1vdGUgcHJvY2Vzc29yIHdoaWNoIHdpbGwgYmUgYm9vdGVkIHVzaW5nIHRoZXNlIGZ3DQo+
ID4gc2VnbWVudHMNCj4gPiAtICogQGZ3OiB0aGUgRUxGIGZpcm13YXJlIGltYWdlDQo+ID4gLSAq
DQo+ID4gLSAqIFRoaXMgZnVuY3Rpb24gc3BlY2lhbGx5IGNoZWNrcyBpZiBtZW1zeiBpcyB6ZXJv
IG9yIG5vdCwgb3RoZXJ3aXNlDQo+ID4gaXQNCj4gPiAtICogaXMgbW9zdGx5IHNhbWUgYXMgcnBy
b2NfZWxmX2xvYWRfc2VnbWVudHMoKS4NCj4gPiAtICovDQo+ID4gLXN0YXRpYyBpbnQgaW14X2Rz
cF9ycHJvY19lbGZfbG9hZF9zZWdtZW50cyhzdHJ1Y3QgcnByb2MgKnJwcm9jLA0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgZmlybXdh
cmUNCj4gKmZ3KQ0KPiA+IC17DQo+ID4gLSAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcnBy
b2MtPmRldjsNCj4gPiAtICAgICAgIHU4IGNsYXNzID0gZndfZWxmX2dldF9jbGFzcyhmdyk7DQo+
ID4gLSAgICAgICB1MzIgZWxmX3BoZHJfZ2V0X3NpemUgPSBlbGZfc2l6ZV9vZl9waGRyKGNsYXNz
KTsNCj4gPiAtICAgICAgIGNvbnN0IHU4ICplbGZfZGF0YSA9IGZ3LT5kYXRhOw0KPiA+IC0gICAg
ICAgY29uc3Qgdm9pZCAqZWhkciwgKnBoZHI7DQo+ID4gLSAgICAgICBpbnQgaSwgcmV0ID0gMDsN
Cj4gPiAtICAgICAgIHUxNiBwaG51bTsNCj4gPiAtDQo+ID4gLSAgICAgICBlaGRyID0gZWxmX2Rh
dGE7DQo+ID4gLSAgICAgICBwaG51bSA9IGVsZl9oZHJfZ2V0X2VfcGhudW0oY2xhc3MsIGVoZHIp
Ow0KPiA+IC0gICAgICAgcGhkciA9IGVsZl9kYXRhICsgZWxmX2hkcl9nZXRfZV9waG9mZihjbGFz
cywgZWhkcik7DQo+ID4gLQ0KPiA+IC0gICAgICAgLyogZ28gdGhyb3VnaCB0aGUgYXZhaWxhYmxl
IEVMRiBzZWdtZW50cyAqLw0KPiA+IC0gICAgICAgZm9yIChpID0gMDsgaSA8IHBobnVtOyBpKyss
IHBoZHIgKz0gZWxmX3BoZHJfZ2V0X3NpemUpIHsNCj4gPiAtICAgICAgICAgICAgICAgdTY0IGRh
ID0gZWxmX3BoZHJfZ2V0X3BfcGFkZHIoY2xhc3MsIHBoZHIpOw0KPiA+IC0gICAgICAgICAgICAg
ICB1NjQgbWVtc3ogPSBlbGZfcGhkcl9nZXRfcF9tZW1zeihjbGFzcywgcGhkcik7DQo+ID4gLSAg
ICAgICAgICAgICAgIHU2NCBmaWxlc3ogPSBlbGZfcGhkcl9nZXRfcF9maWxlc3ooY2xhc3MsIHBo
ZHIpOw0KPiA+IC0gICAgICAgICAgICAgICB1NjQgb2Zmc2V0ID0gZWxmX3BoZHJfZ2V0X3Bfb2Zm
c2V0KGNsYXNzLCBwaGRyKTsNCj4gPiAtICAgICAgICAgICAgICAgdTMyIHR5cGUgPSBlbGZfcGhk
cl9nZXRfcF90eXBlKGNsYXNzLCBwaGRyKTsNCj4gPiAtICAgICAgICAgICAgICAgdm9pZCAqcHRy
Ow0KPiA+IC0NCj4gPiAtICAgICAgICAgICAgICAgLyoNCj4gPiAtICAgICAgICAgICAgICAgICog
IFRoZXJlIGlzIGEgY2FzZSB0aGF0IHdpdGggUFRfTE9BRCB0eXBlLCB0aGUNCj4gPiAtICAgICAg
ICAgICAgICAgICogIGZpbGVzeiA9IG1lbXN6ID0gMC4gSWYgbWVtc3ogPSAwLCBycHJvY19kYV90
b192YQ0KPiA+IC0gICAgICAgICAgICAgICAgKiAgc2hvdWxkIHJldHVybiBOVUxMIHB0ciwgdGhl
biBlcnJvciBpcyByZXR1cm5lZC4NCj4gPiAtICAgICAgICAgICAgICAgICogIFNvIHRoaXMgY2Fz
ZSBzaG91bGQgYmUgc2tpcHBlZCBmcm9tIHRoZSBsb29wLg0KPiA+IC0gICAgICAgICAgICAgICAg
KiAgQWRkICFtZW1zeiBjaGVja2luZyBoZXJlLg0KPiA+IC0gICAgICAgICAgICAgICAgKi8NCj4g
PiAtICAgICAgICAgICAgICAgaWYgKHR5cGUgIT0gUFRfTE9BRCB8fCAhbWVtc3opDQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gLQ0KPiA+IC0gICAgICAgICAgICAg
ICBkZXZfZGJnKGRldiwgInBoZHI6IHR5cGUgJWQgZGEgMHglbGx4IG1lbXN6IDB4JWxseA0KPiBm
aWxlc3ogMHglbGx4XG4iLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHR5cGUsIGRhLCBt
ZW1zeiwgZmlsZXN6KTsNCj4gPiAtDQo+ID4gLSAgICAgICAgICAgICAgIGlmIChmaWxlc3ogPiBt
ZW1zeikgew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiYmFkIHBo
ZHIgZmlsZXN6IDB4JWxseCBtZW1zeg0KPiAweCVsbHhcbiIsDQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBmaWxlc3osIG1lbXN6KTsNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICByZXQgPSAtRUlOVkFMOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0K
PiA+IC0gICAgICAgICAgICAgICB9DQo+ID4gLQ0KPiA+IC0gICAgICAgICAgICAgICBpZiAob2Zm
c2V0ICsgZmlsZXN6ID4gZnctPnNpemUpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBk
ZXZfZXJyKGRldiwgInRydW5jYXRlZCBmdzogbmVlZCAweCVsbHggYXZhaWwNCj4gMHglenhcbiIs
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXQgKyBmaWxlc3osIGZ3
LT5zaXplKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+IC0gICAgICAgICAgICAgICB9DQo+
ID4gLQ0KPiA+IC0gICAgICAgICAgICAgICBpZiAoIXJwcm9jX3U2NF9maXRfaW5fc2l6ZV90KG1l
bXN6KSkgew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAic2l6ZSAo
JWxseCkgZG9lcyBub3QgZml0IGluIHNpemVfdA0KPiB0eXBlXG4iLA0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbWVtc3opOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
IHJldCA9IC1FT1ZFUkZMT1c7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+
ID4gLSAgICAgICAgICAgICAgIH0NCj4gPiAtDQo+ID4gLSAgICAgICAgICAgICAgIC8qIGdyYWIg
dGhlIGtlcm5lbCBhZGRyZXNzIGZvciB0aGlzIGRldmljZSBhZGRyZXNzICovDQo+ID4gLSAgICAg
ICAgICAgICAgIHB0ciA9IHJwcm9jX2RhX3RvX3ZhKHJwcm9jLCBkYSwgbWVtc3osIE5VTEwpOw0K
PiA+IC0gICAgICAgICAgICAgICBpZiAoIXB0cikgew0KPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGRldl9lcnIoZGV2LCAiYmFkIHBoZHIgZGEgMHglbGx4IG1lbQ0KPiAweCVsbHhcbiIsIGRh
LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtc3opOw0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7DQo+ID4gLSAgICAgICAgICAgICAgIH0NCj4gPiAtDQo+ID4gLSAgICAgICAg
ICAgICAgIC8qIHB1dCB0aGUgc2VnbWVudCB3aGVyZSB0aGUgcmVtb3RlIHByb2Nlc3NvciBleHBl
Y3RzDQo+IGl0ICovDQo+ID4gLSAgICAgICAgICAgICAgIGlmIChmaWxlc3opDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgbWVtY3B5KHB0ciwgZWxmX2RhdGEgKyBvZmZzZXQsIGZpbGVzeik7
DQo+ID4gLQ0KPiA+IC0gICAgICAgICAgICAgICAvKg0KPiA+IC0gICAgICAgICAgICAgICAgKiBa
ZXJvIG91dCByZW1haW5pbmcgbWVtb3J5IGZvciB0aGlzIHNlZ21lbnQuDQo+ID4gLSAgICAgICAg
ICAgICAgICAqDQo+ID4gLSAgICAgICAgICAgICAgICAqIFRoaXMgaXNuJ3Qgc3RyaWN0bHkgcmVx
dWlyZWQgc2luY2UgZG1hX2FsbG9jX2NvaGVyZW50DQo+IGFscmVhZHkNCj4gPiAtICAgICAgICAg
ICAgICAgICogZGlkIHRoaXMgZm9yIHVzLiBhbGJlaXQgaGFybWxlc3MsIHdlIG1heSBjb25zaWRl
cg0KPiByZW1vdmluZw0KPiA+IC0gICAgICAgICAgICAgICAgKiB0aGlzLg0KPiA+IC0gICAgICAg
ICAgICAgICAgKi8NCj4gPiAtICAgICAgICAgICAgICAgaWYgKG1lbXN6ID4gZmlsZXN6KQ0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgIG1lbXNldChwdHIgKyBmaWxlc3osIDAsIG1lbXN6IC0g
ZmlsZXN6KTsNCj4gPiAtICAgICAgIH0NCj4gPiAtDQo+ID4gLSAgICAgICByZXR1cm4gcmV0Ow0K
PiA+IC19DQo+ID4gLQ0KPiA+ICAvKiBQcmVwYXJlIGZ1bmN0aW9uIGZvciBycHJvY19vcHMgKi8N
Cj4gPiAgc3RhdGljIGludCBpbXhfZHNwX3Jwcm9jX3ByZXBhcmUoc3RydWN0IHJwcm9jICpycHJv
YykgIHsgQEAgLTgwOCw3DQo+ID4gKzcxNSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcnByb2Nf
b3BzIGlteF9kc3BfcnByb2Nfb3BzID0gew0KPiA+ICAgICAgICAgLnN0YXJ0ICAgICAgICAgID0g
aW14X2RzcF9ycHJvY19zdGFydCwNCj4gPiAgICAgICAgIC5zdG9wICAgICAgICAgICA9IGlteF9k
c3BfcnByb2Nfc3RvcCwNCj4gPiAgICAgICAgIC5raWNrICAgICAgICAgICA9IGlteF9kc3BfcnBy
b2Nfa2ljaywNCj4gPiAtICAgICAgIC5sb2FkICAgICAgICAgICA9IGlteF9kc3BfcnByb2NfZWxm
X2xvYWRfc2VnbWVudHMsDQo+ID4gKyAgICAgICAubG9hZCAgICAgICAgICAgPSBycHJvY19lbGZf
bG9hZF9zZWdtZW50cywNCj4gPiAgICAgICAgIC5wYXJzZV9mdyAgICAgICA9IHJwcm9jX2VsZl9s
b2FkX3JzY190YWJsZSwNCj4gPiAgICAgICAgIC5zYW5pdHlfY2hlY2sgICA9IHJwcm9jX2VsZl9z
YW5pdHlfY2hlY2ssDQo+ID4gICAgICAgICAuZ2V0X2Jvb3RfYWRkciAgPSBycHJvY19lbGZfZ2V0
X2Jvb3RfYWRkciwNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
