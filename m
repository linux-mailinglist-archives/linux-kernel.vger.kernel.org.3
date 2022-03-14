Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B034D7EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiCNJia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbiCNJiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:38:25 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9B3FBC1;
        Mon, 14 Mar 2022 02:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647250635; x=1678786635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MdVwgmdUdh6Hl7l0fj3J4gcCNTaRsHJ8bdLn0yNbuEs=;
  b=iHa6E9HbOM97pPS0t6rs6RF7/h5R+sDDbIlvRSaQNm/aQ+O6uBVc2ApX
   sbBxWR6Xy4R8xltWd/XLjaqCkPZPMrjBZnYAIOLewhoE7CY4N2ZIYr6iY
   ONuwhjGo4i+4Daos+HNXYBVR04tbRwGUjx1k+bLH8u42nCAcGycJDWiwx
   hu7nS6XAtr7FMWMOnjdHMtbPIlZjuHo614EVXfpey+Els8qOBgKE8NTVj
   BwCoFq0jQciLl0eseTlIbzn+BJAF4mG2GqDKMMCIhv9wrP9P09EW2D1iB
   g75tyVx+qudEhSqejl5u9RbdTg63Rjo2Bffa452NdA7EM3jgAtNvSlbM5
   g==;
X-IronPort-AV: E=Sophos;i="5.90,180,1643644800"; 
   d="scan'208";a="307248862"
Received: from mail-bn8nam08lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 17:37:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmWN24pLFgQ7JMPex2okUTmJhcFOSvwDetaAWqr72DiIdFRUeIrkDr8y68QYDaYY4498pRId6qeSnkqyhhgmN7yLbbAsexciQiG5kEqVnA70tSgr0Ir0AuzTBN3mqfyF4RC/TS0GYQJIDEGQ6Bq4ELuynigYL40qrc7KxNayQkBwuCoFRlLHnDCq+tRNp0vTii+2fzA5jWMTt/3ccGt0Wa2Sw0M7IWmpSzx+HcH2xfbS6TwjHTfwTQKlw6JbTZFWdkdz6WYjWNv3RPlEnZRIS7NbRnI4OoZCVRncvZJZcr5JwpGZLDWRqWVikrAc/HQ7YoLkfzqVDYNDjbh9vKQWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdVwgmdUdh6Hl7l0fj3J4gcCNTaRsHJ8bdLn0yNbuEs=;
 b=UIAau2nueSADW+bKSGgYnPjAsLQ88D/mEVX7miTkEUHBSSXpwJMOsAqpNBT3uB5jbfxLVwVfnXtjTNBWnRPbg7Q+maZfDJJ6O42ohnNqW6TYaVVFODE1PG33BhpPEtNMUANBUPq/lxMOyvMOf4duMX9PjK9nLH63C/Zqi2YLnkyvDCH99mJeGOklIeATcgkyFtsfNKkhro4VFJDG2qMxuj9TkqptThqSMAZVhvuyiXb+f0u12wdRKURGCrY8XdllpbXtWf5pYarh7wZOROp57hCal20JsEqOibVW36HDi1FdRyhxC+8nUbp4IjPA3zZuo5HXFokvKE/wjJScHi6u5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdVwgmdUdh6Hl7l0fj3J4gcCNTaRsHJ8bdLn0yNbuEs=;
 b=A62BZEQL2fYfu9RpEImwyChDiIOhRWRk/URke2cmvmEM+dJKtkLtTGjnYbZxdKSBCgP8OIKZV3G0bU2xvgZGgqzPtU9+zSDtgX4/15DLrJ04V2K484M6N/Nh2mxQItmUUQvBNZ5kyBKH5GD4yn+16Rb8kjVCycgTgH7vc+4/JP0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BYAPR04MB3879.namprd04.prod.outlook.com (2603:10b6:a02:ad::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.25; Mon, 14 Mar 2022 09:37:11 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b%4]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 09:37:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Michael Wu <michael@allwinnertech.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "porzio@gmail.com" <porzio@gmail.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        allwinner-opensource-support 
        <allwinner-opensource-support@allwinnertech.com>
Subject: RE: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Topic: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Index: AQHYNcu0Jgralp1XlUCNRLBRM2Fhq6y+dQaAgAAo/4CAAARTcA==
Date:   Mon, 14 Mar 2022 09:37:11 +0000
Message-ID: <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com>
 <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
In-Reply-To: <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f19829c8-dbc1-49b5-f66f-08da059e3769
x-ms-traffictypediagnostic: BYAPR04MB3879:EE_
x-microsoft-antispam-prvs: <BYAPR04MB3879B339368420DD32AC85EDFC0F9@BYAPR04MB3879.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: syMZMOh9tETVawwFXLD8gXX3Dj0H4/ovF7lLNQfEz3bhwNmIJhtzw7NsOmP+5apjDVrx53mbMblRvdiZRbz9G08Dwfw08IQYM5BC3oYjIhVxoOqL8p0cb/e/1v7rSzkKoZOPfYThFB+LAtHvGZzoJRB3UGcc2RyWygvfKAKErWJSCdH2VqVhd6+MtJavNvIMCg9kPnrMWwneFYhASYkTOnvnNy3UhSBCZe7GUf6ceIQGEidLGYODvNKWF4mk7pz1CCDxE4YEZhzLBdrNXsj5IM4xEddyOfKZPNXJ5mvu5H3nRQD3g7T4OJ8NVX0dxodtp9QPlKpQzyOcUXS5CjEAkTrLVeH6H7xTjj5tFfkc5nUxdUFEda6Krb1ojuNBM7+CCviSbSBlRLu49HIepvdVKw1oVtCaRET1Y82p8yZNu+CSYem4Ma+b7rep1S90VrtyW+V9+mD8iWARSac9VfOIgdU0JujnGQzM3OzD/+KWVstBgmb0Bmw7DsJFZBEYZGKD+dqsmnH06JtXeEsolN5Qmx4Jjizka9ROKgSNxiBu8JBroM5Ns6wo2h/V278W782xbLE/z5YQ/r8i8mu8dhNlq8pJjNo/IpWlg/w5u9YY3NQUSXz7++Gl4i7XS3G3hs84OjdkoTVW1W8AsHwgRjgwL8c+lQ7mUYSqhoF9lG7uqxcB5wKIrYaTERDG088mIwZyHtMEUGt1p0ABtHAVFMoR3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(71200400001)(122000001)(82960400001)(38070700005)(7696005)(2906002)(6506007)(86362001)(53546011)(38100700002)(508600001)(9686003)(8676002)(4326008)(64756008)(66946007)(66556008)(66476007)(66446008)(76116006)(5660300002)(52536014)(8936002)(55016003)(83380400001)(54906003)(33656002)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0NPL2lNZ3k0WWFLUGJDQkptb2JSVFpoVi9qZEdTWktzS0tzSkJDclRlZnlF?=
 =?utf-8?B?ZlYxVW1QUGhCWG5pa1M4MmpDc216UTNQeE8vOXkyZ0xqdzRBbmJQZXEyQWhN?=
 =?utf-8?B?VjhRWkhmekVnRmlqT1FGVCtiaENZbElxcFpXdDNZckpkZ3ZYYS9IQnVnemNl?=
 =?utf-8?B?cHdKdGQ0ano5ejJOeWpMbnE1ZDRhbk9sNWt4OUwxTjBabzRQSkFXbHlkNGN1?=
 =?utf-8?B?WW1ZZjZCcUVRZThiYS9DRnJ6RjFYRUMwVHdjdndzS3ZpTzdrWjhCS1NUb0gz?=
 =?utf-8?B?aDFNRVpuVzUrZHVPZmVwa1VBWEdWdEwvTGJ6N29zM0VPSFkvS1BFenlYLzdp?=
 =?utf-8?B?UHdkNUpuU0hnaU96azRKcElGdGIrSGlNcWtRV29oVVNkOVNFLzhUc1Npa1Uw?=
 =?utf-8?B?dk1tZERiZzdQSmJpMktRbzNuVThrOUc4NWw5SEdtWlRjaVk1TmN1Q0g1UFhI?=
 =?utf-8?B?blBhYXBoNE5pRERmTUFIK0lxWnYzR2lsc3daWitiNjNqNmpDbWYycG1LL3VD?=
 =?utf-8?B?MmZWUVREMUYwcGNaOVhQY2xLc3ltWDczVkFwbzRDT1lMc3lIYTkvajdZMEJ0?=
 =?utf-8?B?VG9XOXRWMS9yQjR4U3liRjZlZ2srSU9rcnV5ZnpxMFd4ekJ1NHpTR2FCaFRJ?=
 =?utf-8?B?emJzSEJnL0YzMXByY0hTd0NsdkhCUzJDa3ZGVmhYcDg4RTJ5YXBSYUowSmFZ?=
 =?utf-8?B?MU9qdnVnSElYbFBWZG1RcUZBVnpzSU1vMzVZYjZ5NUYzWktWdXZNaHU3MDJa?=
 =?utf-8?B?UlBEa1d5NE9iZnpla1pPUDhUMlJudlYwL3pBWWZIKzExWlgvcUgyK2gwcVVK?=
 =?utf-8?B?cGpvTTBoN2RSQ1kyQW11VlBmbVZQQS9tbzY4dlFCYmZObzlJVGp5ekcwT0dI?=
 =?utf-8?B?WWY3Q0lDQldlRHoyNC96UkVJemRJcTBVQWxTTXphNWt4bTVtNDcwemU2UWRO?=
 =?utf-8?B?djFGNEdjRU41YVRRRHdxbVNhNWlVTHc2K1Qya0FMOE82VGgzOTMweUt2TDAv?=
 =?utf-8?B?eHh0YVl0bnZORjQrV211UTY1RElrVXRLL001L0syOHErOGhXZVV3UDU3cmVM?=
 =?utf-8?B?NVVNSmJIdW9PM3BzTUNONzNKeXNpWkpqL0IvWk5INEhyazZDQmUxNlhsWVRn?=
 =?utf-8?B?V0gzUzkzdTFUa1pacHorOTlYa3JVaVRZWkE4V0w4Q2JBVkFVL0VqOFhjRlJ6?=
 =?utf-8?B?aUxjTVI1NkZUcEZONG1CRHdhSk1JbzZvRU1TOTV4MGh3eTZTcExSMXpXUHJy?=
 =?utf-8?B?bHlaZy8xYlFvZkFUTzdCNlRDMUh0aVFyWjBTbW4wUklnYnBXVC9jQXRlVFZQ?=
 =?utf-8?B?QVVrM21yTVhOV1ovQ3hRcTFwbjJjRG1mN0NDQitoa210bkVuTlZwK01Ebndm?=
 =?utf-8?B?bWtTUnJaRTVJTGtuVWdwWm9IZ2tSa2JUcXlXdkdYdWx0a2Qzc2VoL3AxRmN3?=
 =?utf-8?B?ZmRiTWRzam10NjBUdjNSd3V6U3JuaWV2b09hSmp3QXFwbHpySU5LZGRBdWJI?=
 =?utf-8?B?WVNFK2QrRjdkUHhoaVA2Qy90QTdObktDQjFwM2pvc0tPR3Nyend1UlBRMjk5?=
 =?utf-8?B?ZHhQZHVCYXJmSTZFOGRxU2paMmxGa2dZMXViVXNQNlQ3T2lodG4rOUF2OHMw?=
 =?utf-8?B?MWo4dnhRQ21sWnArdGZ1L21uWHZjcnlFL2VqNFgzL0VtRW5yV3o2V1k0TjJ5?=
 =?utf-8?B?N2w1WWQrai80eEIxK3hNbGRxNXBubGZzQWwxeDVkaFFSVlVwYWFRQ1kyZXRV?=
 =?utf-8?B?NVVRQ21OTGVsVkI4TFA3N0p5MjFBR2NTSXFhRnd3aHpoRnptdGJGalBlTmdX?=
 =?utf-8?B?RjVpRS9XMU9UMTgrVnYwZFh1Qk1LUmVSZW81TVVWWXoxZjJUdkRFNC9tZk5k?=
 =?utf-8?B?T09HZ0dWV003MTJpdXJ0WGdmNy9BSVY1dWY0OXppN1BoVGUvbGFIMW5LTlBN?=
 =?utf-8?Q?jYVf8UesWoUzKid4HHTDzWTjGsOiNKIC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19829c8-dbc1-49b5-f66f-08da059e3769
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 09:37:11.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3rb3ugJfYaqKyI3wX1fIzjhcgOcdirCSxieqpJKthImtY6ykpCsM0tbXvttXw0riZntR9tcmYC7IdvBO7gfBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3879
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxNC8wMy8yMDIyIDE0OjU0LCBBZHJpYW4gSHVudGVyIHdyb3RlOg0KPiA+IE9uIDEyLzAz
LzIwMjIgMDY6NDMsIE1pY2hhZWwgV3Ugd3JvdGU6DQo+ID4+IFRoZSBtbWMgY29yZSBlbmFibGUg
Y2FjaGUgb24gZGVmYXVsdC4gQnV0IGl0IG9ubHkgZW5hYmxlcw0KPiA+PiBjYWNoZS1mbHVzaGlu
ZyB3aGVuIGhvc3Qgc3VwcG9ydHMgY21kMjMgYW5kIGVNTUMgc3VwcG9ydHMgcmVsaWFibGUNCj4g
d3JpdGUuDQo+ID4+IEZvciBob3N0cyB3aGljaCBkbyBub3Qgc3VwcG9ydCBjbWQyMyBvciBlTU1D
cyB3aGljaCBkbyBub3Qgc3VwcG9ydA0KPiA+PiByZWxpYWJsZSB3cml0ZSwgdGhlIGNhY2hlIGNh
biBub3QgYmUgZmx1c2hlZCBieSBgc3luY2AgY29tbWFuZC4NCj4gPj4gVGhpcyBtYXkgbGVhZHMg
dG8gY2FjaGUgZGF0YSBsb3N0Lg0KPiA+PiBUaGlzIHBhdGNoIGVuYWJsZXMgY2FjaGUtZmx1c2hp
bmcgYXMgbG9uZyBhcyBjYWNoZSBpcyBlbmFibGVkLCBubw0KPiA+PiBtYXR0ZXIgaG9zdCBzdXBw
b3J0cyBjbWQyMyBhbmQvb3IgZU1NQyBzdXBwb3J0cyByZWxpYWJsZSB3cml0ZSBvciBub3QuDQo+
ID4+DQo+ID4NCj4gPiBGaXhlcyB0YWc/DQo+ID4NCj4gDQo+IEhpIEFkcmlhbiwNCj4gTXkgcGF0
Y2ggaW50ZW5kIHRvIGZpeCB0aGUgY2FjaGUgcHJvYmxlbSBicm91Z2h0IGJ5IHRoZSBmb2xsb3dp
bmcgdHdvDQo+IHBhdGNoZXM6DQo+IA0KPiBGaXhlczogZDBjOTdjZmI4MWViYyAoIm1tYzogY29y
ZTogVXNlIENNRDIzIGZvciBtdWx0aWJsb2NrIHRyYW5zZmVycyB3aGVuDQo+IHdlIGNhbi4iKQ0K
PiBGaXhlczogZTlkNWM3NDYyNDZjOCAoIm1tYy9ibG9jazogc3dpdGNoIHRvIHVzaW5nIGJsa19x
dWV1ZV93cml0ZV9jYWNoZSgpIikNCj4gDQo+IEknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIHdoYXQg
eW91IHJlZmVycmVkIHRvICgiRml4ZXMgdGFnIikuIFBsZWFzZSBjb3JyZWN0IG1lIGlmIEkNCj4g
bWlzdW5kZXJzdG9vZC4NCj4gDQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV3UgPG1pY2hh
ZWxAYWxsd2lubmVydGVjaC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvbW1jL2NvcmUv
YmxvY2suYyB8IDIwICsrKysrKysrKysrKysrLS0tLS0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4g
Pj4gaW5kZXggNjg5ZWI5YWZlZWVkLi4xZTUwOGMwNzljMWUgMTAwNjQ0DQo+ID4+IC0tLSBhL2Ry
aXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiA+PiArKysgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2Nr
LmMNCj4gPj4gQEAgLTIyNzksNiArMjI3OSw4IEBAIHN0YXRpYyBzdHJ1Y3QgbW1jX2Jsa19kYXRh
DQo+ICptbWNfYmxrX2FsbG9jX3JlcShzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQsDQo+ID4+ICAgICAg
c3RydWN0IG1tY19ibGtfZGF0YSAqbWQ7DQo+ID4+ICAgICAgaW50IGRldmlkeCwgcmV0Ow0KPiA+
PiAgICAgIGNoYXIgY2FwX3N0clsxMF07DQo+ID4+ICsgICAgYm9vbCBlbmFibGVfY2FjaGUgPSBm
YWxzZTsNCj4gPj4gKyAgICBib29sIGVuYWJsZV9mdWEgPSBmYWxzZTsNCj4gPj4NCj4gPj4gICAg
ICBkZXZpZHggPSBpZGFfc2ltcGxlX2dldCgmbW1jX2Jsa19pZGEsIDAsIG1heF9kZXZpY2VzLCBH
RlBfS0VSTkVMKTsNCj4gPj4gICAgICBpZiAoZGV2aWR4IDwgMCkgew0KPiA+PiBAQCAtMjM3NSwx
MiArMjM3NywxOCBAQCBzdGF0aWMgc3RydWN0IG1tY19ibGtfZGF0YQ0KPiAqbW1jX2Jsa19hbGxv
Y19yZXEoc3RydWN0IG1tY19jYXJkICpjYXJkLA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICBt
ZC0+ZmxhZ3MgfD0gTU1DX0JMS19DTUQyMzsNCj4gPj4gICAgICB9DQo+ID4+DQo+ID4+IC0gICAg
aWYgKG1tY19jYXJkX21tYyhjYXJkKSAmJg0KPiA+PiAtICAgICAgICBtZC0+ZmxhZ3MgJiBNTUNf
QkxLX0NNRDIzICYmDQo+ID4+IC0gICAgICAgICgoY2FyZC0+ZXh0X2NzZC5yZWxfcGFyYW0gJiBF
WFRfQ1NEX1dSX1JFTF9QQVJBTV9FTikgfHwNCj4gPj4gLSAgICAgICAgIGNhcmQtPmV4dF9jc2Qu
cmVsX3NlY3RvcnMpKSB7DQo+ID4+IC0gICAgICAgICAgICBtZC0+ZmxhZ3MgfD0gTU1DX0JMS19S
RUxfV1I7DQo+ID4+IC0gICAgICAgICAgICBibGtfcXVldWVfd3JpdGVfY2FjaGUobWQtPnF1ZXVl
LnF1ZXVlLCB0cnVlLCB0cnVlKTsNCj4gPj4gKyAgICBpZiAobW1jX2NhcmRfbW1jKGNhcmQpKSB7
DQo+ID4+ICsgICAgICAgICAgICBpZiAobWQtPmZsYWdzICYgTU1DX0JMS19DTUQyMyAmJg0KPiA+
PiArICAgICAgICAgICAgICAgICAgICAoKGNhcmQtPmV4dF9jc2QucmVsX3BhcmFtICYgRVhUX0NT
RF9XUl9SRUxfUEFSQU1fRU4pDQo+IHx8DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgIGNhcmQt
PmV4dF9jc2QucmVsX3NlY3RvcnMpKSB7DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgIG1kLT5m
bGFncyB8PSBNTUNfQkxLX1JFTF9XUjsNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgZW5hYmxl
X2Z1YSA9IHRydWU7DQo+ID4+ICsgICAgICAgICAgICB9DQo+ID4+ICsNCj4gPj4gKyAgICAgICAg
ICAgIGlmIChtbWNfY2FjaGVfZW5hYmxlZChjYXJkLT5ob3N0KSkNCj4gPj4gKyAgICAgICAgICAg
ICAgICAgICAgZW5hYmxlX2NhY2hlID0gdHJ1ZTsNCj4gPj4gKw0KPiA+PiArICAgICAgICAgICAg
YmxrX3F1ZXVlX3dyaXRlX2NhY2hlKG1kLT5xdWV1ZS5xdWV1ZSwgZW5hYmxlX2NhY2hlLA0KPiA+
PiArIGVuYWJsZV9mdWEpOw0KPiA+PiAgICAgIH0NCj4gPg0KPiA+IFNlZW1zIGxpa2Ugd2Ugc2hv
dWxkIGluZm9ybSBibG9jayBsYXllciBhYm91dCBTRCBjYXJkIGNhY2hlIGFsc28NCj4gPg0KPiAN
Cj4gSSBzYXcgYW5vdGhlciBtYWlsIGJ5IEF2cmkgQWx0bWFuLCB3aGljaCBzYXlzIGZldyBkYXlz
IHdpbGwgYmUgbmVlZGVkIHRvIGFzaw0KPiBpbnRlcm5hbGx5LiBTaGFsbCBJIHdhaXQgb3IgbWFr
ZSBhbm90aGVyIGNoYW5nZSBoZXJlIG9uICdpbmZvcm0gYmxvY2sgbGF5ZXINCj4gYWJvdXQgU0Qg
Y2FyZCBjYWNoZSc/DQpQbGVhc2UgZG9uJ3Qgd2FpdC4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0K
PiA+Pg0KPiA+PiAgICAgIHN0cmluZ19nZXRfc2l6ZSgodTY0KXNpemUsIDUxMiwgU1RSSU5HX1VO
SVRTXzIsDQo+IA0KPiAtLQ0KPiBCZXN0IFJlZ2FyZHMsDQo+IE1pY2hhZWwgV3UNCg==
