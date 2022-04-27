Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB50511333
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359299AbiD0IH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359269AbiD0IHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:07:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A9C522D1;
        Wed, 27 Apr 2022 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651046670; x=1682582670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PN87uTB5N57PmDywIXWDdta/w0XolTqBHw6pCaqP4qI=;
  b=U1L9qC1h5xH5lJFb8ynvbSY6uq8nV5lmuNDyDjU06T2Z64QZ9Cb5CjYv
   VERvdglxe1zdBrbFp71QNCSRFChRv7cyfrgfRbRRoZtKqqDvyvSP0pO3x
   ePSP7L5Hg1ww6L85udvwka7JfiFTQv9qca/G6HDlBY/FtE4Hjw9JvrZns
   X3R82mRg2iGAQB/GjLovbBIsSGIui2MsXgy+ezi3vdARuaLx5PjAT5h5D
   95mR4i6ya1bF+iZOKT2C4wj+BdoJxGcc4FgSUoTt5/gsMdDUyyjcJwO8A
   aSEcbFnIBT42N7yQh/mzIqj5rr+/nV7EIftx1Q4I4M+vQQKNPLcm9bqzr
   g==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="310906214"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 16:04:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABaNSvt/8y4lpWQdOD3XN9ctcUSiTn2n7bLKBHTSzV+GWv+o2iBC0T/It/XrFjRyKfwC06+t0ug1N55DuSPbMKcjPxn0WT5HSuPOxvnnV4Q41M+nxfm38I/DyylhavRNDEEA3sFKNwlYoYP7pj85n07eYhfdVdNTc+9608SsBYbOsr3ssVXRmo0+uU6M8uOdo1kURbmkCtI0GFF5liwSl/IZcu5FRhAz+g9/m94rBX0tkicPobiDcSp/o4+MPUhUKz2jfSwq0TmGBuMZ45Ao8EKXS6nXWSsGZ+ViCCoIWbEoEBwIFCfhxafGWHl3E4Wu0oCP0L3f+O+ncNK313hiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN87uTB5N57PmDywIXWDdta/w0XolTqBHw6pCaqP4qI=;
 b=Mlqux7Qk7AczwJ4B2jFBENNduxfRC3psc5ZBu7WAByv7oTTQoFKmE03FqbN2bYMuNv4IskM73jtl4UN34LKSgAcZ5jV0MOBZJN+BSd5kJfsbzbE09S57j8culseXs7OyMCQgMUWn8229+UJJ8KyC5diJ46THmLpxW35nQxp1xfK8BCyVrUsnumvC103jWQZJjHbxMQj5ZWIkDz9NUja3aQf79DKuTearGbU2zEwGKiWkw5PiInzcmEnURX2sV2fjk/LlAiMQiQQ98I0E5S38nMcq5qG4AkYVS9GyR8VJxuP28a5R/DvFYPDOIpBKI//LfSDltvtFpCq9DCOYRZC4SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN87uTB5N57PmDywIXWDdta/w0XolTqBHw6pCaqP4qI=;
 b=VBEOjBhpLhfJ8sH7BPC/5wym1btE4jG3lbKZeCAr/cciqbpvslaRoyW9YWChhyiBjePoBiwLVfP9RBZq4mPQ/wt71fYhypFNKDdVLhZK6BzufpZ5B5xSkMrs+PN9YYDj7zLIrn5ccJOBIJpC0kk3yEmmH5cMh94py9XP9r+AOhY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR04MB0511.namprd04.prod.outlook.com (2603:10b6:300:72::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.17; Wed, 27 Apr 2022 08:04:20 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3%3]) with mapi id 15.20.5206.012; Wed, 27 Apr 2022
 08:04:20 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Brian Norris <briannorris@chromium.org>,
        Srinivasarao Pathipati <quic_spathi@quicinc.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "merez@codeaurora.org" <merez@codeaurora.org>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kishor Krishna Bhat <quic_kishkris@quicinc.com>,
        kamasali <quic_kamasali@quicinc.com>
Subject: RE: [PATCH V1] mmc: core: Select HS mode in device first and then in
 the host
Thread-Topic: [PATCH V1] mmc: core: Select HS mode in device first and then in
 the host
Thread-Index: AQHYWU49cQ9dmnwn9064beDvvBcOZa0CfRUAgADp/CA=
Date:   Wed, 27 Apr 2022 08:04:20 +0000
Message-ID: <DM6PR04MB657515154B27EB6B9E57A3D7FCFA9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1650964532-9379-1-git-send-email-quic_spathi@quicinc.com>
 <CA+ASDXMkzrqkDdb=y4DpK5Ot=XFtj6aAv7-mSBoGP5rDJZanpA@mail.gmail.com>
In-Reply-To: <CA+ASDXMkzrqkDdb=y4DpK5Ot=XFtj6aAv7-mSBoGP5rDJZanpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3629af4e-18ca-4b50-7216-08da282488f8
x-ms-traffictypediagnostic: MWHPR04MB0511:EE_
x-microsoft-antispam-prvs: <MWHPR04MB051133F8EF9A729D811C5DE7FCFA9@MWHPR04MB0511.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rIVyxfrWq03FQMQN+bF6Gpnqwn+4eRrUEZlwmu4vOJxCoLYEQWVDzd1er5Q/u+57cUb7SXgiSR2TXnhhHNEvcHsdBToSWwL295/nbPgvVGE0UHi2M6p9seSVVySv9Q5B7ZhITvTeO8XE3wz7YE+a3hCBTY2Rud5l0b4AqFtunoZr1Qof6Clf7mzRCu+n/WdP0sOjazz3cbUevDXFWPXgZkg7cLuvyMIzQ2jwkSbGBlyiP4j+fuECO4G4t44V/zWxmrXsD1k3Xph+o3JaQQS1POGflzx0Njq16DzEGchftoo7+3uTdMoGl9342vRsZWekR948B0r7S1MflSWWyvLgaWZQH1fR51S44VDPo5dLXBtO/hcd7Z3ZP8MBgudB+QQrwsfCJz3gzeIeDVokPJAi4ZZCv6aw54nRXTz4o18PQs7icDYu1S1Id1J/qZVlDH7vhp0UCLGu19rX/+3kFP2MkdJejsN7K5gVumjtVlG7kTU1UDwtXX4v3xaLuWRBYNnZAev8Jv4PgBq8e9lcjOirVPmcnpHFoNnVgJx4+k5YUMYERAi/XX1hnbDseGRATwFCOM9KbCHPMfc8l8s3hce+UCK3o6sTyXaWYScG5CCafnUG7oRDz8gLGb/5UhR923N92j7hz7903ul9dkX4eeZs7/QdOkIId/iehz8ggXsdibBG18Io/eLzR0k/MGM2q3j/Lb+9y3qGKziTvH1StXtExg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(33656002)(54906003)(122000001)(86362001)(76116006)(71200400001)(8936002)(52536014)(508600001)(2906002)(7416002)(55016003)(82960400001)(83380400001)(66946007)(4326008)(5660300002)(8676002)(186003)(66476007)(64756008)(66556008)(66446008)(6506007)(26005)(7696005)(316002)(53546011)(9686003)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emVqQWpsVWJOYTIvbWR6Zk9wUFN1QU0zVHk2NHExUmJPYmFrajZmcHpnYmdp?=
 =?utf-8?B?cGRBMkVmT3ZOSUNmTVM1dFZzSWswRUF4enhoNGJZdTFjaS9sV21ZWVFEaE9V?=
 =?utf-8?B?ejBBZGpvZlh0RUVMY1Foc2VEaG00YjJZWHpYbnVqN2wrTzNYUldqZWwrU05u?=
 =?utf-8?B?MnNqbm45SXI5MkJ4UWZHcFdSaVgrc1V1WGlYdWFGTHJtMS9qQ3RGUG1aVk5M?=
 =?utf-8?B?SnM4akx1bmZnZEZkQ0pzMFVEcC9RTmQzbmJBZ1N2MjFJbzBpRldzdngwRUFq?=
 =?utf-8?B?blV2RElMdCtyaFFEYXlGcGpzdlBvMVIvbnpGbElGM0pybEF0TUtyc0taZDJn?=
 =?utf-8?B?Sk5nWGl2MFVrcncxaFhpZnNQNEJIeit5ZVhqQVg2V20xMWw2VzRWemlXTVhN?=
 =?utf-8?B?N1g2dUdTczlwYThXRit3dFVvZmV4UDc1czBZNHNzNHR3NVpjd3dtSmc1dlMv?=
 =?utf-8?B?aUVtaXE0ZDhWM0szdk5uOExiMCtvVlIxcURKaEVaOG00WWgxTjg5eUtKc1V1?=
 =?utf-8?B?SGZ4YnQwekxVV2ltZE9HdnI4bDhicTNKTC9qTjlTUVcvYVR1N1BiRW5XMGRB?=
 =?utf-8?B?WVEzQy9DaUY3MkZoeUVCMUVBNUVLRmRsbERtQ2xhNXk4WDMxWTNOOWJrKzA2?=
 =?utf-8?B?Njg5ck9LU1dmRnpDR084cDRPL2tYUVBhTmZXSXg0Y1pQZnNWa3FxZi95dGF1?=
 =?utf-8?B?aG1wUzFraXVtcGx1N1RDUHRpL1U3RlUrY0l1Z2JzV1UwclRvTC9wVWdSaGVz?=
 =?utf-8?B?SG5PdUFDdUR3Vjd2RWwrYXQzZkMrYU03WlBNT2UyczhqT1JNTW1iMVk5V2Jo?=
 =?utf-8?B?YXlZdUpGZTZXTVNFUDVCVDVHT0U2Q2hOUVdEZzlScG51RmlYOEdRT3J0eWhx?=
 =?utf-8?B?OUcrczMwRWluRzFMV0JqTG5kL3pIZmVTWEFPMjlhbnBzSkhUMHpRdUJncngv?=
 =?utf-8?B?TkFIdlI1b055WjJmTUhsZlplbENqR1pRMGNWc1dkQ0toNXR4alRMYVVqRDNF?=
 =?utf-8?B?dWRuMlBjWHlxanVDYTRHZDhheE9vRTN3NGxQcUo2QlUrQ1V0Z1JRZzBZRzJM?=
 =?utf-8?B?MW5MSUwvcnJzdTVwUEYxTXhEVDU4dXFQZytxMzgyVUx5cU5YUDk2QytTS2Z3?=
 =?utf-8?B?YXl2TUtUR3NHMnpJcTFleWZGYjd3OWpvdTQvcEV5TU8xVmp1R1VLZWszZWRy?=
 =?utf-8?B?SmdMVnJNRFV5cFFEMmpMdGlER3pnQTdJdzNwQ1pWK0RkTXFkZkJLUUc1cDFV?=
 =?utf-8?B?OFhyRCtCSjlNOUk3UXNBMmNIZkNLb3NNSGdRVVlENGIxTkpHMHZVYVJYb0FJ?=
 =?utf-8?B?UVNKalFxSkVJcmFNNkNaby83b3A1RWhIV0JLNUc4RzZ1R1NpaktEc2pUWm82?=
 =?utf-8?B?ZmNma0hXRmxsRGlma3IrakRwTjZLR0J2ckdmcUx3WndVZU5OSWgvRUJEem83?=
 =?utf-8?B?cDBqckl2YmJZV3k4ODBud3BTUEtNZGN6OWl1LzFrZUhOTGM4dlpEYVJONU9Q?=
 =?utf-8?B?WU54Tm5MbUVreW5naUZDZDVTSEhjMk1aMlE4eG5YWlozN3RiYmt1aU9pM1JQ?=
 =?utf-8?B?anV4aWIzSXZzQ0doQzM3clNud3hidE5QRXlIdGI2UlE2ZnlLbGo1Qy9IdWkv?=
 =?utf-8?B?Q0JadFdkU290bXkwZDhnK0JybXN2SUZmYzU5ZEpweGNoMnI2czEyZ1JSYjlV?=
 =?utf-8?B?UXU1eU5HREN3aTJNRHhLaEtkajU1QmtJbmhFdWNWWTJmS2RUWjFMVlpscFJY?=
 =?utf-8?B?TkZlQm1OR2RkODhlSzNrQ2x6QmFNVU5kUGJQUThGMVd4QmloY1A1anZOQjNl?=
 =?utf-8?B?aU14SGZMQXhTTUpGTzZ4ZG50ZnFWc0w0MnIzbjN2ckMxY0ZWZGRxb2YxTlo2?=
 =?utf-8?B?c1BsVkxkTVExa2RXNjJZM0VYaTFUUHhWdTkxdHQxQXBQWjlGOVcxNDNUV2RE?=
 =?utf-8?B?YmFTK2lPZUVxZUx5cC9HazMrUWE0QzVZalBkU1Q0eXpEZm5JYW1LU0dEWTlp?=
 =?utf-8?B?aVhwcm1NN2tlbEZuSHcwV3NaZk9yYmdxeHJjNVRoUGc3ck00b1J2SzFIcVEr?=
 =?utf-8?B?djVEdUxrNGtEcGpBUlp3clQrcG53Z2tQVDc5WjlRUkMvdG5nOEVhdVorc0NM?=
 =?utf-8?B?SFBPL0tySHQ2a0dmOGNxS2dJSHQ1cndmUzMvbmUvdVgyMExXc0R1MXZvU3hY?=
 =?utf-8?B?RWgya0IyaE9VaDRFZW50SnlwenpWcEZEc2NDQTdJTGpiRi9aL09LanNPQ25Z?=
 =?utf-8?B?bWFEUGFreVo0UmZZblkzbTVkeVRoTVY0bWt4WVB5akNBV2tyZmV0WENWbjll?=
 =?utf-8?B?N09QTE9yZHl0SjFYK2p5a2NQUmZMSTczMGo4eTNlQ2lFTG1qV25YZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3629af4e-18ca-4b50-7216-08da282488f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 08:04:20.8107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5SggXYw0qniIlrM23pXGsU88o8yFdF+qozMkjbbjHP+lBRCw5RN7jXPdLJhLQgrl1TNzKCpYKmXsJhL5En8og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0511
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSwNCj4gDQo+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDI6MTYgQU0gU3Jpbml2YXNhcmFv
IFBhdGhpcGF0aQ0KPiA8cXVpY19zcGF0aGlAcXVpY2luYy5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
RnJvbTogU2F5YWxpIExva2hhbmRlIDxzYXlhbGlsQGNvZGVhdXJvcmEub3JnPg0KPiA+DQo+ID4g
V2hpbGUgc3dpdGNoaW5nIGZyb20gaHM0MDAgdG8gaHMyMDAgbW9kZSwgaGlnaCBzcGVlZCBtb2Rl
DQo+ID4gdGltaW5nIHNob3VsZCBiZSBzZWxlY3RlZCBpbiB0aGUgZGV2aWNlIGJlZm9yZSBjaGFu
Z2luZyB0aGUNCj4gPiBjbG9jayBmcmVxdWVuY3kgaW4gdGhlIGhvc3QuIEJ1dCBjdXJyZW50IGlt
cGxlbWVudGF0aW9uLA0KPiA+IChtbWNfaHM0MDBfdG9faHMyMDApIGZpcnN0IHVwZGF0ZXMgdGhl
IGZyZXF1ZW5jeSBpbiB0aGUgaG9zdA0KPiA+IGFuZCB0aGVuIHVwZGF0ZXMgbW9kZSBpbiB0aGUg
ZGV2aWNlLiBUaGlzIGlzIGEgc3BlYyB2aW9sYXRpb24uDQo+ID4gSGVuY2UgdXBkYXRlIHRoZSBz
ZXF1ZW5jZSB0byBjb21wbHkgd2l0aCB0aGUgc3BlYy4NCj4gDQo+IEknbSBhIGJpdCBuZXcgdG8g
aW50ZXJwcmV0aW5nIGVNTUMgc3BlY3MsIGJ1dCBhcmUgeW91IHN1cmUgdGhpcyBpcyBhDQo+IHZp
b2xhdGlvbj8gSW4gSkVTRDg0LUI1MSwgSSBzZWU6DQo+IA0KPiAiVGhlIGJ1cyBmcmVxdWVuY3kg
Y2FuIGJlIGNoYW5nZWQgYXQgYW55IHRpbWUgKHVuZGVyIHRoZSByZXN0cmljdGlvbnMNCj4gb2Yg
bWF4aW11bSBkYXRhIHRyYW5zZmVyIGZyZXF1ZW5jeSwgZGVmaW5lZCBieSB0aGUgRGV2aWNlLCBh
bmQgdGhlDQo+IGlkZW50aWZpY2F0aW9uIGZyZXF1ZW5jeSBkZWZpbmVkIGJ5IHRoZSBzdGFuZGFy
ZCBkb2N1bWVudCkuIg0KPiANCj4gSSB0aGluayB0aGF0IHN1Z2dlc3RzIHdlIGNhbiBsb3dlciB0
aGUgaG9zdCBjbG9jayBmaXJzdCwgYW5kIHRoZW4NCj4gbG93ZXIgdGhlIGRldmljZSB0aW1pbmcu
IEFuZCAoYWNjb3JkaW5nIHRvIG15IGxpbWl0ZWQga25vd2xlZGdlKSB0aGF0DQo+IG1ha2VzIHNl
bnNlIHRvbzogdGhlIGRldmljZSB0aW1pbmcgaXMgYSAibWF4aW11bSIgKHRvIHNvbWUgZXh0ZW50
KSBhbmQNCj4gd2UncmUgZnJlZSB0byBydW4gdGhlIGhvc3QgYnVzIHNvbWV3aGF0IHNsb3dlci4N
Cj4gDQo+IEFuZCBvbiB0aGUgZmxpcCBzaWRlOiBpdCBzb3VuZHMgbGlrZSB5b3UgbWF5IGJlIF9p
bnRyb2R1Y2luZ18gYSBzcGVjDQo+IHZpb2xhdGlvbiAodGhhdCB3ZSdsbCBiZSBydW5uaW5nIHRo
ZSBob3N0IGZhc3RlciB0aGFuIHRoZSBkZXZpY2UNCj4gdGltaW5nLCBicmllZmx5KT8NCkFjayBv
biB0aGF0Lg0KDQpBbHNvLCBzcGVjaWZpY2FsbHksIHBsZWFzZSByZWZlciB0byBGaWd1cmUgMjgg
4oCUIEhTMjAwIFNlbGVjdGlvbiBmbG93IGRpYWdyYW0uDQpZb3UgY2FuIHNlZSB0aGF0IHRoZSBm
bG93IGdvZXMgdGhvdWdoOg0KQlVTX1dJRFRIIFsxODNdIC0+IGZyb20gMHgwNiAoRERSIDhiaXQp
IHRvIDB4MDIgKFNEUiA4Yml0KQ0KSFNfVElNSU5HIFsxODVdIC0+ICBmcm9tIDB4MDMoSFM0MDAp
IHRvIDB4MDIgKEhTMjAwKQ0KSG9zdCBtYXkgY2hhbmdlcyB0aGUgZnJlcXVlbmN5ICwgYnV0IGl0
4oCZcyBubyBuZWVkZWQgYXMgSFM0MDAgYW5kIEhTMjAwIHVzZSBzYW1lIENMSw0KDQpUaGFua3Ms
DQpBdnJpDQo+IA0KPiBBcG9sb2dpZXMgaWYgSSdtIG9mZiBiYXNlLiBCdXQgeW91IGRpZCBDQyBt
ZSA7KQ0KPiANCj4gUmVnYXJkcywNCj4gQnJpYW4NCg==
