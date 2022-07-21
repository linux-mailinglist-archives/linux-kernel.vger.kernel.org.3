Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AE857C92C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiGUKjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiGUKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:38:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF282452;
        Thu, 21 Jul 2022 03:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7Phpx1O0w1MKHdFML7Q8Q58MMZgIsobv/WlN8tX1Jv13UbOTMIvK8wpUY1Rmap0TewwL97B1xArnJmDfbNjCQkllhXfQrNMfl73D5cNE2awJkBsz31CBwKLcnC7r298+o1wP+ikkFsyjhKJof0T98YRqu38zgx/rjtd2mAOIoCQ3Aqy3MoJ7BLLvCcTNnSIzjKpmj2Q97t2wZoSlJkci/R9oFW0Sg8nitwTorbCsnT9UIn8bKl2KA2rP4qCdVjThJlfNxGQ1xsR/C2Y57ss0OX2ihFT1GfTDcpWfPQHvetWzG8EU/3/5EqWYO0fuA+RTamH4FaQvPvDPNYuxWppjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh4X5hl+iWObExYVD/XtDFDsLHBqRXl1WTEMi3F4DBc=;
 b=LXgsXNnJOwallLv1RR38L9mf6jJGuQqE4oJ2JSG+ZHo4HQUMQwMcyLR9FfiDpDEJMZXZgeMrq/dv204Zcdxin+MyTE0GmTsfpjOwFdcp9SKDql5EtBaZKaBJcsWBziovF8Xoiou5e6TNujVNdB/Qiw/GTqE7ZDFzxZzlyCA33rUhOqj64QL4VIe2z4vpyVeZE6eyHOjq4E3gR527BiET/nae8X/teUYP5S2aJ7w1gtSkTlMFW5AFyMn+7aGDf7tdIVVW/AqPZuODDMEmfVXQ1i2pFr6ldD3ZUYQDgVt0Rg2tfbQyh6GL2AQ84tz+BTwDlVvi1lDxBu/vdTzgdFuP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh4X5hl+iWObExYVD/XtDFDsLHBqRXl1WTEMi3F4DBc=;
 b=s50Yg+W9OytG1WwPeOjNAwaIfQIapPpIbG6kBmSZRFIs47ommT6Sy1oWt0Sf5/jrKLy8uFJFVVE3UXWtkNiW4sXNXsBHOAcri3XY0kEiMNJ7wiAaa1jlEKOuJX+wd6usW8nvEzIWgEmvMFdtSaaf6t4l3XZF5KOu+9WjZFZs3L0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6781.eurprd04.prod.outlook.com (2603:10a6:803:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 10:38:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 10:38:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH V3 3/7] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Thread-Topic: [PATCH V3 3/7] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Thread-Index: AQHYmzNYr9TY0rleY0e1K+yrZnfuVa2FdHkAgAAAXsCAAJqKAIACWFVA
Date:   Thu, 21 Jul 2022 10:38:50 +0000
Message-ID: <DU0PR04MB94172A78F8E9E74FC842F22B88919@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
 <20220719055054.3855979-4-peng.fan@oss.nxp.com>
 <27ab24ec-61c7-cafb-6665-a16c58808649@linaro.org>
 <DU0PR04MB941796A54DC4932E5A58F4B0888F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <9c1735bf-3f29-4bf1-f7cf-f9e211c505ac@linaro.org>
In-Reply-To: <9c1735bf-3f29-4bf1-f7cf-f9e211c505ac@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0e241d4-744a-4aa9-7b91-08da6b05332a
x-ms-traffictypediagnostic: VI1PR04MB6781:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XCmv+m8IaWhpI/j35ktrUULstprpLizPrW+N6j3ZtZPorUMK3MqwQg4F9DF31HRmK6w6TESooFIIWYj9bkB9eiL/Ud63/sRLYBkdxQxg+4IASF6OF9/UdoQF93ndd5SBXzGv6p+tMoRezuLjmnm9hawbTOwF3b1sK47A61DuYo7lXrCO6PjmBT1XUNTtLmh1opmh5LMNOfUG4mqgzR+UF7nie9wVbOQSfGSQqTj1EXPrMency/65xdZgmnsNi3AfsseSpKsQ2zpR8g61r8CqrLJ2iQEcluXnnAC4/KDMt5MsdNKH5rlRNQTPxMrVMJJ9LjVGHpQEeWyBKmuzQO1y4K0gYLSKWxFfFT86PbQAE2NyYtGo6HhCTExePfs24sVhMXTI/zG9GZzFC3nUp1Acd+4Xual8jkGefcWfDIUEYsAhULP7PDVLW7h3wbnXGKmK/vsgsk8HmwKTo/VuH6xE0QJmkBS4EWyfd9miovmQs/SFgrj8xE0Za8ZRuU9HBQ2QJJNFRaNNBovLWn29xtdrRqOvMSM7FoT/e0LThW8NfGLbEhDHUd5CVAHt3Do8mOvq3pz1pPpR5L3d1gcRO9EZ8MYURWMs6fVDdUaOzIQ2KkuSXiukCPIQGZIm7JtBAvC7gE0nrBvx3q8efKffrQin/0FNriO0+RIQb3zcAPVSAz3WB5E9478zVlBvvQNm1Mjn4dgSLT7XrTEwQY7CLVslg33E1nDmdkx+K4fjnpJUelZUwzI51ApZ3fH+Ef5/Jh8qrSLZkvclDpQGO5PogaHn6JqgMy/TJTx/BTkuMkiqoVI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(186003)(52536014)(8676002)(41300700001)(33656002)(64756008)(2906002)(55016003)(71200400001)(53546011)(9686003)(7696005)(478600001)(6506007)(26005)(38070700005)(66446008)(38100700002)(4326008)(86362001)(5660300002)(316002)(44832011)(110136005)(7416002)(54906003)(8936002)(66556008)(66476007)(122000001)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1JiZEFSMlkwSm5UU3lyUWJEU0VhMXVLTHZ4bHY3dmFEMjR6NUU1Y0hqZGlY?=
 =?utf-8?B?YjBlZ0ZCK2p0Q29BalhEeUtscGlNTlkzL0lmdE9ncEhZRStpSTUxSm85NzJQ?=
 =?utf-8?B?bDBDUXpMaHpsTG4xU0w4SmNuNFNQM3I0U2VaLytKbFo0WGQ2YVZGbm5ocEhj?=
 =?utf-8?B?WEROSEtvenIwM0NvVlZuUldSVjVmYitTaEZVa2p4NVA5MEp2bm5Nc0F1WDBv?=
 =?utf-8?B?QkhxckNlS1hCNmJlUFJXdlZtM0JLOFlsajkvamdnOWRxSS94NXBPV25BaHdV?=
 =?utf-8?B?TjNLTUlSR3Vsc1ZwZ0tkeDhXTVVwYlVvWnhlajBZS2FDODUvdHhqUEhvUjVm?=
 =?utf-8?B?dUdMZVVjSU84aG9Ia1dURklScG1tNVFwVmViZUs4SENXcW5ZaDBxdk9yS3hP?=
 =?utf-8?B?WUNCblpUU0hOUW5nNG1aRHcyQkptVnR0ZE1CYStXTDV5TWU5YVVtZHVBMXB0?=
 =?utf-8?B?elJBOEo4NUV0bHpYd0dPcndjZC9Ub1hveWJobFVjRTMvSnM3cE1pcUZPVmJa?=
 =?utf-8?B?azNrVi92S1F1NGU4eXRnazJzcG5ocXkxeWRSVTdQZkpjbHhNbE1QaTltVktY?=
 =?utf-8?B?NlR4WmtWYUYrK3ZtOXc3OVZQdG01YjlEWCsxazhFazM2amo5Q3NTT216V0E5?=
 =?utf-8?B?aDdNT2VFUko1OXBoRktQdUd4WFRTWHFyaU1wNmV4ajlYamRFTU1JdkU0V1kz?=
 =?utf-8?B?cWRxTi9CcERvWFFKZnFEakY5MllwaUhhR0xnRmZ5OVFUcEI2ekxOM2QyYkRN?=
 =?utf-8?B?R3AxYzVmODhKYnRKOHdka2s3alZVN1V6Nk9xWFNueGpKNEJHaktKdTMzL1ZY?=
 =?utf-8?B?NHNzRm9ad1BoaEhYYnFZa2RaZkRERWVqV2VLMS9rUUVPZUNkbzlCZXRkM05r?=
 =?utf-8?B?cElEbGkzcG9oL0hSR3dnZ3V5MWNjZDQ1VXlZbUhkc0JQemY4ZzMzM2xrM2dL?=
 =?utf-8?B?a1JSeXpLNmw2MUUwMDNSdU1DeUZTOFp0eE9TT204ZC93SmRUTHRjQitWQ09X?=
 =?utf-8?B?RGFNVVJLakRKK1hlYlZUSmQyMHc5eVhXc04rRm42VnNjSFc0TzZWZUo5OFR5?=
 =?utf-8?B?ckM2TGF5RTdEYUphbmEzR240dDZCYzJySGlyTjI1N2dDWTZ6QWtvdFZrdjc1?=
 =?utf-8?B?TjV5SmpDYjZQUW9uNHdSNkgrTk5zQkxTN3hwVU54NFJXOUxtTnpGeUpaWUx3?=
 =?utf-8?B?VFdRZXhTY3kzUm4zUHMyNW0vTEJNVFZJMzZBWUM1NnhTV3B2dGZCTGtoclov?=
 =?utf-8?B?MjBjc0VhL1BUVDRnbXZwWEtYVUZjZ2VkUE5jdWlaSVlOR2xYdnNYNWk0ZE1F?=
 =?utf-8?B?OWtYUi8vUzd0akNVR25jWWVLM3JVRmN5TmJlZXBRdVJBeEF2OTRaS1RoSnJQ?=
 =?utf-8?B?cmd6dUNoY0lnOS8rWkxuakxsdzRQaGNaV2Rvckd3cnFzejVOYnpBUEY5T1p4?=
 =?utf-8?B?RnhZN3BRSjh2VjFFWWc1QVkwUDhmTk4xaHQ2alhXcU44RUYwaC90M0hrdGRM?=
 =?utf-8?B?akNzSWlQajRwUW14bnhUM2ZQclM5UWhqQ2xHbkJSTzhUU0pjdVIyUWtLRity?=
 =?utf-8?B?U3Z0bVNjQ3NnK2RXLzM4VHVXTDA1Mi9WRVdDdG1FNlZyZFBSSzFIcDhBQ1hu?=
 =?utf-8?B?UUxFTEgxMGgyUjVJZE5EUTd3UXRFSDgxRzE1K3k0cWtYVkpra25ldjFHS3U5?=
 =?utf-8?B?U21abVVIZ0IrbStodnpqVWNRVUFDS2lDVjl4MTlWTFk4aUJXdGp1TGxtYmZh?=
 =?utf-8?B?U3YzVS93NHI2T3pKcWtrN0JDcHBXRU92K2ZFR09yM203c28xSWx2ekpoalFr?=
 =?utf-8?B?bmdyRllXdWxJU0R2cWhuOE1VbWNjdWc2STVKeWZOV0ZLd2t1TFVPNzArcjd0?=
 =?utf-8?B?SktOZ1BQV3A1aEZJRWVzQWlmV3ZWenBPVkRGeDdhN0wrNWNvUWxhbmJYNWg3?=
 =?utf-8?B?WjdGdzJ1T3o1NS9uZDkzajJDM2RGNEE0YXZCZXA4YWtUS0JERzRPSkp5LzlH?=
 =?utf-8?B?OVhqLy9EbGdBVitiUzVtUU40eXhhYmNqY2hPbzFBWmNuSDlkQ2psMmJTK215?=
 =?utf-8?B?UUhkKzFrMDM1bnAyRGtEc3hSeTJBNVVucTJEVnpHS1FPUGNFaGVIajB1VWFn?=
 =?utf-8?Q?L18s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e241d4-744a-4aa9-7b91-08da6b05332a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 10:38:50.3152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilMDwXq6qqp1Fa/TQEEUku6jG/AopP3YFvBMI4K+zP9e6H+ZOY4nPMOYhudiYlaQ8SHqnLDbXTL20D3YxzAsog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6781
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDMvN10gZHQtYmluZGluZ3M6IHNvYzogaW14OiBhZGQg
aS5NWDhNUCB2cHUgYmxrIGN0cmwNCj4gDQo+IE9uIDE5LzA3LzIwMjIgMTE6NTgsIFBlbmcgRmFu
IHdyb3RlOg0KPiA+Pj4gKyAgICAgICAgaW50ZXJjb25uZWN0czoNCj4gPj4+ICsgICAgICAgICAg
aXRlbXM6DQo+ID4+PiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogRzEgZGVjb2RlciBpbnRl
cmNvbm5lY3QNCj4gPj4+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBHMiBkZWNvZGVyIGlu
dGVyY29ubmVjdA0KPiA+Pj4gKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IFZDODAwMEUgZW5j
b2RlciBpbnRlcmNvbm5lY3QNCj4gPj4+ICsNCj4gPj4+ICsgICAgICAgIGludGVyY29ubmVjdC1u
YW1lczoNCj4gPj4+ICsgICAgICAgICAgaXRlbXM6DQo+ID4+PiArICAgICAgICAgICAgLSBjb25z
dDogZzENCj4gPj4+ICsgICAgICAgICAgICAtIGNvbnN0OiBnMg0KPiA+Pj4gKyAgICAgICAgICAg
IC0gY29uc3Q6IHZjODAwMGUNCj4gPj4NCj4gPj4gSW5jbHVkZSBpbnRlcmNvbm5lY3RzK25hbWVz
IGluIGxpc3Qgb2YgYWxsIHByb3BlcnRpZXMgYW5kIGRpc2FsbG93DQo+ID4+IHRoZW0gZm9yIG90
aGVyIHZhcmlhbnRzLg0KPiA+DQo+ID4gSSBub3QgdW5kZXJzdGFuZCB3ZWxsIGFib3V0DQo+ID4g
IiBJbmNsdWRlIGludGVyY29ubmVjdHMrbmFtZXMgaW4gbGlzdCBvZiBhbGwgcHJvcGVydGllcyAi
LCBjb3VsZCB5b3UNCj4gPiBwbGVhc2UgZXhwbGFpbiBhIGJpdCBtb3JlPw0KPiA+DQo+ID4gQW5k
IHRoZXJlIGlzIGFscmVhZHkgYW4gImlmIiB0byBjaGVjayB3aGV0aGVyIHRoZSBjb21wYXRpYmxl
IGNvbnRhaW5zDQo+ID4gIiBmc2wsaW14OG1wLXZwdS1ibGstY3RybCIgdG8gbWFrZSBzdXJlIHRo
ZSBpbnRlcmNvbm5lY3QgdmFsaWQgZm9yDQo+ID4gaS5NWDhNUCwgc28gaXQgaXMgbm90IHZhbGlk
IHRvIG90aGVyIHZhcmlhbnRzLg0KPiANCj4gRGVmaW5pbmcgcHJvcGVydGllcyBpbiBzb21lIGlm
OiBjbGF1c2UgaXMgbm90IHJlYWxseSByZWFkYWJsZSBhbmQNCj4gbWFpbnRhaW5hYmxlLiBUaGUg
cHJvcGVydGllcyBzaG91bGQgYmUgZGVmaW5lZCBpbiB0b3AtbGV2ZWwgcHJvcGVydGllczouDQoN
Ck1heWJlIEkgc2hvdWxkIGFsc28gaW5jbHVkZSBpLk1YOE1NIGludGVyY29ubmVjdCBhbmQgbWFr
ZSBpdA0KYSBzZXBhcmF0ZSBwYXRjaCwgdGhlbiBpLk1YOE1QL2kuTVg4TU0ganVzdCB1c2UgdGhl
aXIgb3duDQpuYW1lcyBqdXN0IGxpa2Ugb3RoZXIgcHJvcGVyaXRpZXMuIEluIGZpbmFsLCBhcyBi
ZWxvdzoNCg0KVG93IHBhdGNoOg0KICAxLiBBZGQgaW50ZXJjb25uZWN0IHByb3BlcnR5IGZvciBp
Lk1YOE1NIFZQVSBCTEsgQ1RSTA0KICAyLiBBZGQgaS5NWDhNUCBWUFUgQkxLIENUUkwgZHQgYmlu
ZGluZ3MNCg0KSW4gdG9wLWxldmVsOg0KKyBpbnRlcmNvbm5lY3RzOg0KKyAgICBtYXhJdGVtczog
Mw0KIA0KKyAgIGludGVyY29ubmVjdC1uYW1lczoNCisgICAgICBtYXhJdGVtczogMw0KDQpGb3Ig
aS5NWDhNTQ0KKyAgICAgICAgaW50ZXJjb25uZWN0czoNCisgICAgICAgICAgaXRlbXM6DQorICAg
ICAgICAgICAgLSBkZXNjcmlwdGlvbjogRzEgZGVjb2RlciBpbnRlcmNvbm5lY3QNCisgICAgICAg
ICAgICAtIGRlc2NyaXB0aW9uOiBHMiBkZWNvZGVyIGludGVyY29ubmVjdA0KKyAgICAgICAgICAg
IC0gZGVzY3JpcHRpb246IEgxIGVuY29kZXIgaW50ZXJjb25uZWN0DQorDQorICAgICAgICBpbnRl
cmNvbm5lY3QtbmFtZXM6DQorICAgICAgICAgIGl0ZW1zOg0KKyAgICAgICAgICAgIC0gY29uc3Q6
IGcxDQorICAgICAgICAgICAgLSBjb25zdDogZzINCisgICAgICAgICAgICAtIGNvbnN0OiBoMQ0K
DQpGb3IgaS5NWDhNUDoNCisgICAgICAgIGludGVyY29ubmVjdHM6DQorICAgICAgICAgIGl0ZW1z
Og0KKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IEcxIGRlY29kZXIgaW50ZXJjb25uZWN0DQor
ICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogRzIgZGVjb2RlciBpbnRlcmNvbm5lY3QNCisgICAg
ICAgICAgICAtIGRlc2NyaXB0aW9uOiBWQzgwMDBFIGVuY29kZXIgaW50ZXJjb25uZWN0DQorDQor
ICAgICAgICBpbnRlcmNvbm5lY3QtbmFtZXM6DQorICAgICAgICAgIGl0ZW1zOg0KKyAgICAgICAg
ICAgIC0gY29uc3Q6IGcxDQorICAgICAgICAgICAgLSBjb25zdDogZzINCisgICAgICAgICAgICAt
IGNvbnN0OiB2YzgwMDBlDQoNCkhvdyBkbyB5b3UgdGhpbms/DQoNClRoYW5rcywNClBlbmcuDQoN
Cj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
