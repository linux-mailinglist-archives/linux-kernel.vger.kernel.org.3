Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B065451A24F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351389AbiEDOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351353AbiEDOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:38:40 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140104.outbound.protection.outlook.com [40.107.14.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52A20F5D;
        Wed,  4 May 2022 07:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMuxWwWxQgbywrJ09c2H9/V4dVt4iJ5Thx+/GJ6T2+kUuezQKJyfckF1VNKOQFSD4/ZzS2G23g8Pvxoa7Fe24m7sS6KwIdIBXxNq6gmyRe/JUvt1kC4iqZx3m4I1UXWxgE1FpBIvv75SV5wEoMfGPQ+wKRyw2Q41G6/ZqyHRJL1HwVn5I1qKzJ/pHQAFuIeo+fvGjWvHExEMVCRN7cze8wqJxzij7HFhB5P+6L4/CbHNzsHe0wcdWj9ADdengg7KHa3qZ2KQvuuM0q9rwT4DTVzq9wpP4sb7VTixV9hzrqIV+4lF34NmbBiOiigIlYA1BXWucQN0/t6uMXRPMirBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5zFajrsSdqWAYdUycQJ6g7xCznNeY8E4Y46hsgrwrA=;
 b=RW/ldpMGL8Z3D8vH5tQWkJO27VSX6ExCDocpOg7ArdHCqJP4ERdUoU4pnAF4Hq4ra044px50QaVG15MGzeEIQ/RRVwy8cXACZoO+V/Pl/FkpKbTicmooDKPRkGh9Lzou54BjXqVwBKMWljR3mHKAL6DT8avzTy7XhUIGSEnZ/IFM2Ff+9KdOqh83bj2XTZtfZX+5MKx9Pkl3n37Rp0ss3IcXZuC9GdLyC3HODDywxBZXiFwQHISAi6IM7+H7IGmUxP+1k8glHi52UUjXsvBGf9imrsC0Vi20lWEjnw8GxK50Ub50K3RyguBCJqVtS9r0U4zFVO3V/kY8c3BXwCH9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5zFajrsSdqWAYdUycQJ6g7xCznNeY8E4Y46hsgrwrA=;
 b=XEd1jBi8zGQVxOYIPv8nMKpno0hpJcTZ7F+ortnOXgI7sgzWRorcM6QY2P5sQkS+aiM3k9abaYxChGg/WqA8tkw+G7yt6NzrXV7n2rlnUrBogGiy0b0M2AWdDobGb/fd+p7nYG1Vp3BBLkQVvrD5EMp8NCb61Do2q9cDHMNh+TM=
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com (2603:10a6:20b:3aa::24)
 by VE1PR06MB6095.eurprd06.prod.outlook.com (2603:10a6:803:124::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 14:35:01 +0000
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::8134:c1a1:e76e:69cb]) by AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::8134:c1a1:e76e:69cb%9]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 14:35:00 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH V3 3/5] iio: accel: sca3300: modified to support multi
 chips
Thread-Topic: [PATCH V3 3/5] iio: accel: sca3300: modified to support multi
 chips
Thread-Index: AQHYX7v4bVOKaOhjskeAv8mb3SYOX60OxKiAgAACZbA=
Date:   Wed, 4 May 2022 14:35:00 +0000
Message-ID: <AM9PR06MB7844E8FE0EDF712C769271DAD7C39@AM9PR06MB7844.eurprd06.prod.outlook.com>
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220504133612.604304-4-Qing-wu.Li@leica-geosystems.com.cn>
 <CAHp75VeseZ2ChtbafmbgVavS4KvCvrQ4+XSRkeiJSyqr8__dSw@mail.gmail.com>
In-Reply-To: <CAHp75VeseZ2ChtbafmbgVavS4KvCvrQ4+XSRkeiJSyqr8__dSw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf2c5860-d1ac-412e-560f-08da2ddb4510
x-ms-traffictypediagnostic: VE1PR06MB6095:EE_
x-microsoft-antispam-prvs: <VE1PR06MB60951EE25176463D10B50BA7D7C39@VE1PR06MB6095.eurprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xEZ2dRsVJyMQMjiZcQMoyKNtERZROPhbhyKLsSyCqqSKWgDky8mvPgJYraYmSKsy1mlr0SwnZYMxzNWjLS2dxCbNwsUlbfU9Kp5+LZClw9iJnKaOIcZJm/DbhqgOb1lewheYV3/tVeeprbZRXY0CisyEnRbzI0lfLwP8mtLIPgcE1Umw9yo1F/BYZ3wrDbnu12tVOxPguCo1qIWTmHL3q+dcvHxWo2wcafJs+A+qq2aqvG9eO6SdAx0uH+sj3a6RaEoJv2duGMvxTAK9FGMItHoVUEWXBpTcnx8wJY+y5C23D8HTjlDuCjehov+xYEwu5rxnjQO0ZC4QrKh0IT4nwzA8vSERlZGLv/Pd/tAfectckuzWm22Ba/GHkPbUrDJvn3FRFcMPdkN05RdYHWD5nrTdy8lWYGvH5Bpu9PSiQpWXJxyolxL7ZgldxkPwft/utMOAB3POXiDzcrNoBB1dNf96f1qtAhGPG8/oRfO3UFU25TALnWhMMmsy/eMLMxDNWNKXmdko98xfGWMRNd3QNZpcJOZEjxjkZIJBEDq5nwCb3mgrGdzKiIQBCSmBkeAuNnKoZoa9xQM8cPqtUHeZweaZuBDXjS4/0x4UvYYN6YsOMrsm4ALErAhq0Kw0HMWI9O+D3nVzzeRaWp64xOyRTFM1JvVRoVwhWPJylXCrpllLf3ys4aEbmWAHZ0pAr9Ocnt7CHXAaJJ7IicYdg0BarQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7844.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(54906003)(26005)(33656002)(9686003)(2906002)(8676002)(508600001)(53546011)(83380400001)(38100700002)(6506007)(66446008)(66946007)(66556008)(45080400002)(64756008)(55016003)(66476007)(316002)(71200400001)(76116006)(38070700005)(52536014)(8936002)(122000001)(7696005)(4326008)(86362001)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mkp0Zkg0MFdCVG4xSzlLZm50THJhUW1aU2RhdGZYSE1WMy9oR2ZOclJUblZW?=
 =?utf-8?B?RlpCMVF3RWNBSWl1SjdJT2M5cWJUWldybDJpeXo4L0J2eXUvSS9aa0YrekxH?=
 =?utf-8?B?YmU2enZyUmF1RWJqQllpQTNoRERtREJTNC9CbHIrRWU1c1Q3Y0Q1eWRoQUxL?=
 =?utf-8?B?YUQ4TVZzVURTS3BLV2pUMGpDT1ByM1BEdERDSDd0dmpxSnh4YlNsbnhRQlU3?=
 =?utf-8?B?TkR0Tm1JaW1INGlFMEVrUjJrSzlXVEpRRnUvNUU0eTYyaWJhbEZReWUxR2Rk?=
 =?utf-8?B?bFVLeStxRXIySDlkT2JYS25BWGltWTVuVXJlaUF3MG8zRUJTZlJmTkFnSEhq?=
 =?utf-8?B?R2xkUFpjRnBQY0R4cVNiYmY5Y2RlNUFGRkJvR1ozVllJdUpHZXZwNjZkVEhO?=
 =?utf-8?B?QlJ0dHRFSkNoUWhtUlYxUlNkRXRzSllvRDlCaTlXMUNqVEs5VnlyQ3RLS2g3?=
 =?utf-8?B?dXM4QjRNWDNUS0pUSUdJK2dvTGcycGF4WnFZeFI3R0diMFd1RDhGOU5xWFVt?=
 =?utf-8?B?QjBDYkhWbXVZM0Z4VnN0cldRZFQvQ2hkejNZVUwxK2pSaUtTREpyNjdDQkVq?=
 =?utf-8?B?SXZVNW9mTlNvY2ZXVnIvYVZodEloYS85MUZWaGRhc1BoUU91WWRYaHJKUEVR?=
 =?utf-8?B?NjZHTnV4VXBRaWlJVFM1QU0wL1ozTHdsM2FYVXdQekJRYlN0NE1TR0NjWHpx?=
 =?utf-8?B?SE5qbkJDd3hpOEE1Mm1OaXdkaWRuNlNHemVIbThFanI0T1VocjlHRVZMOWJH?=
 =?utf-8?B?YVVnM3cvZzR2RDYwbDNoVHYxdnM0d0N0RjJzNWgrQ1pnSU5Pd0h5TkczaTM1?=
 =?utf-8?B?VGQ5SE4xRUFzQVA0QnJGbjRDMFVqbUYzMWdsMFJwdi9iS3UxUFU0UFhZejRN?=
 =?utf-8?B?bnpqNVhpa3h2OHhXU3Q0bmJhTHRkZHM5c1lNei9wM2ViMG1yL3NhS2NEYm1K?=
 =?utf-8?B?RE5zSkU0MXNiSkIrTzN2Z2JXby9ueU9xREwwZkZsekxxR3QrbmxwWnM4ZFBU?=
 =?utf-8?B?b2Npa1hTSXE1NDNWN2xyd09IUzFTbVR5VnhwejdxekFYN244c0Q1YUxVWXpS?=
 =?utf-8?B?aDBPUDRJKzlHRHdYaGluYmhCSGNzWkl6K05TS3JHaUNyYnB2NjB0eFBOMkpz?=
 =?utf-8?B?dzNwRWVObXlXMlZLM09pVHI3Vk9KZ2oyQVBoQjhoSDd3UXFmbjRKeHhxSmJN?=
 =?utf-8?B?Uy9oM3RtQzF0Y0JCV0g2ZGhMc2QzT2pVbWU0azFvbWxOY01OVjZ0TnA1ZWMw?=
 =?utf-8?B?S3d5YW44VWZOK21ITVc0YVZyb2xNYjFiNExzR0VyRUpnNks4SXRhcUZ4eTUx?=
 =?utf-8?B?bkpWTkhKR1dIYVZGRHRrOThhSnljQllsSHBndXlrRDVmRTN0UW5CZmlXZEVJ?=
 =?utf-8?B?Q3VLTUg0d2wwUzN2QXBVUjUrZW1abEpNS2lJSUR1dVp0T2xiYVA2d0t3Qmo2?=
 =?utf-8?B?eDcxTmpINDVDUWJWajllNGlxRThWYjdjMzYvR1hEZEtnMVBTUUttUnFoT2lO?=
 =?utf-8?B?MVc2REZnQTF2WjQvTmtBMGI0eTdhZDRNUlU0RFJ0ZFFZZDNNRWNacUtyOGNC?=
 =?utf-8?B?SUtHVVVjMWN5OFN1V25pVUtBN1hUdHRrUG5NREdVbnVKd29ra2MzelJuMTlQ?=
 =?utf-8?B?Uyt5eUVHRTV0WUxTMHlFNGpkQTdGSFREOHhLVlM4TUIxUmE0RDJYT2Q5THlL?=
 =?utf-8?B?d0R4WXBmQ2hSdDZVczlyNTA4MlJ3dytvbmtDRmV1ZlpGcGloT3ZETjBaTDdK?=
 =?utf-8?B?MFhUT0lXeGt1OVJ2MWFHK3VQMEFmVVNRSWxraTBTZjd5dFBnanE4bHhPTFIr?=
 =?utf-8?B?QWdnVnNlOFdJMHYyeUUxTk5DdHFWNG9PamtuUm1adDlYZDhJanNtbVpYYkhV?=
 =?utf-8?B?eklGdVM2VHl4c0J4VytYMHgwQk4zREcxbDdKcXZ6Mm1PR0hFZE9QYUFDV0ts?=
 =?utf-8?B?VUQxYmgwL2xZdzk3R2U1MUF5MUlCVWljc0xuem1HVzl6VkozNmJRc0Q4VTUw?=
 =?utf-8?B?Z3IvRlhlT2RkTE04anNVQU81bmpKcXRhUWFHeGQ4L0RKSGllMGpCQUFKT3Mv?=
 =?utf-8?B?bi8zcFF2NThvZlkrM3BCRVl6dDNCUC9najJtTkZvSjRmcXJtcGZjRW8zZWlN?=
 =?utf-8?B?RXR5WVl2R1MxRzNqcVVBdzJtVk5QM3BjOVJEMmFzcUNIcmlzVnVvQXFEaHBt?=
 =?utf-8?B?RzA1U0hMQ2FZbjIyWUZiazB6dkJrL3hmWU5pdk1ySENucmhWdWE1RTZmK0or?=
 =?utf-8?B?b05ISy9JdG1XaFNrbUN5Sm5TVGhnOWpQQlJvWG5kMnFPSXphZWZzenpMMWdv?=
 =?utf-8?B?YVlrYlBMTEFZRWdMTnliQ24za0dZTXgvdTNhSVlSeFdTT0J6RjhXNFhHbk1y?=
 =?utf-8?Q?x7dA6GZsBe43bVXe8D8G9BohDP1lBv7SaidXt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7844.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2c5860-d1ac-412e-560f-08da2ddb4510
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 14:35:00.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCDCJY6vh0iHw8dDluETmuhyX+Y9Q4GpU0mgPsSdbE8m3Vm5YzpLeFvSShMB+wZ1ismlnzuSSMrVbNTeXazDeZ7o3poxm8vFNMkD4lo6NBChW1oL9ovD+M9OydGhtjQV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSA0LCAy
MDIyIDEwOjIwIFBNDQo+IFRvOiBMSSBRaW5nd3UgPFFpbmctd3UuTGlAbGVpY2EtZ2Vvc3lzdGVt
cy5jb20uY24+DQo+IENjOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgTGFy
cy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+OyBSb2IgSGVycmluZyA8cm9iaCtk
dEBrZXJuZWwub3JnPjsgVG9tYXMgTWVsaW4NCj4gPHRvbWFzLm1lbGluQHZhaXNhbGEuY29tPjsg
ZGV2aWNldHJlZSA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eA0KPiBLZXJuZWwg
TWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtaWlvDQo+
IDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMyAzLzVdIGlpbzogYWNjZWw6IHNjYTMzMDA6IG1v
ZGlmaWVkIHRvIHN1cHBvcnQgbXVsdGkgY2hpcHMNCj4gDQo+IFRoaXMgZW1haWwgaXMgbm90IGZy
b20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJlIGNhcmVmdWwgd2hp
bGUNCj4gY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9yIHJlcGx5aW5nIHRv
IHRoaXMgZW1haWwuDQo+IA0KPiANCj4gT24gV2VkLCBNYXkgNCwgMjAyMiBhdCAzOjM2IFBNIExJ
IFFpbmd3dQ0KPiA8UWluZy13dS5MaUBsZWljYS1nZW9zeXN0ZW1zLmNvbS5jbj4gd3JvdGU6DQo+
ID4NCj4gPiBUaGUgZHJpdmUgc3VwcG9ydCBzY2EzMzAwIG9ubHkuDQo+IA0KPiBkcml2ZXIgc3Vw
cG9ydHMNCj4gDQo+ID4gVGhlcmUgYXJlIHNvbWUgb3RoZXIgc2ltaWxhciBjaGlwcywgZm9yIGlu
c3RhbmNlLCBTQ0wzMzAwLg0KPiA+IFByZXBhcmUgdGhlIHdheSBmb3IgbXVsdGlwbGUgY2hpcHMg
YW5kIGFkZGl0aW9uYWwgY2hhbm5lbHMuDQo+ID4gTW9kaWZ5IHRoZSBkcml2ZXIgdG8gcmVhZCB0
aGUgZGV2aWNlIGlkLg0KPiA+IEFkZCB0aGUgdGFibGVzIGZvciB0aGUgY29ycmVzcG9uZGluZyBp
ZCB0byBzdXBwb3J0IG11bHRpcGxlIGNoaXBzLg0KPiA+IEFkZCBwcmVwYXJlcyBmb3IgdGhlIGFk
ZGl0aW9uIG9mIGV4dHJhIGNoYW5uZWxzLg0KPiA+IEFkZCBwcmVwYXJlcyBmb3IgaGFuZGxpbmcg
dGhlIG9wZXJhdGlvbiBtb2RlcyBmb3IgbXVsdGlwbGUgY2hpcHMuDQo+IA0KPiBJdCBzZWVtcyB5
b3UgbmVlZCB0byB3b3JrIG1vcmUgb24gdGhlIGNvbW1pdCBtZXNzYWdlcyBpbiBhbGwgcGF0Y2hl
cy4NClRoYW5rcywgQW5keS4gSSByZWx5IG9uIGdyYW1tYXIgY2hlY2tpbmcgYnV0IGl0IGRpZG4n
dCBwb2ludCBvdXQuIA0KTGV0IG1lIGZpeCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiANCj4g
Li4uDQo+IA0KPiA+ICtzdHJ1Y3Qgc2NhMzMwMF9jaGlwX2luZm8gew0KPiA+ICsgICAgICAgY29u
c3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNoYW5uZWxzOw0KPiA+ICsgICAgICAgY29uc3QgaW50
ICgqYWNjZWxfc2NhbGVfdGFibGUpWzJdOw0KPiA+ICsgICAgICAgY29uc3QgaW50ICphY2NlbF9z
Y2FsZV9tb2Rlc19tYXA7DQo+ID4gKyAgICAgICBjb25zdCB1bnNpZ25lZCBsb25nICpzY2FuX21h
c2tzOw0KPiA+ICsgICAgICAgY29uc3QgaW50ICphdmFpbF9tb2Rlc190YWJsZTsNCj4gPiArICAg
ICAgIGNvbnN0IGludCAqZnJlcV9tb2Rlc19tYXA7DQo+ID4gKyAgICAgICBjb25zdCBpbnQgKmZy
ZXFfdGFibGU7DQo+ID4gKyAgICAgICBjb25zdCB1OCBudW1fYWNjZWxfc2NhbGVzOw0KPiA+ICsg
ICAgICAgY29uc3QgdTggbnVtX2F2YWlsX21vZGVzOw0KPiA+ICsgICAgICAgY29uc3QgdTggbnVt
X2NoYW5uZWxzOw0KPiA+ICsgICAgICAgY29uc3QgdTggbnVtX2ZyZXFzOw0KPiA+ICsgICAgICAg
Y29uc3QgdTggY2hpcF9pZDsNCj4gDQo+IFdoeSBkbyB5b3UgaGF2ZSBjb25zdCBxdWFsaWZpZXIg
b24gYWxsIG1lbWJlcnM/ICBUaGUgbGFzdCBvbmUgaXMNCj4gdW5kZXJzdGFuZGFibGUsIGJ1dCB0
aGUgcmVzdCwgZXNwLiBwb2ludGVycyBzaG91bGQgYmUganVzdGlmaWVkLg0KQmVjYXVzZSBJIHRo
b3VnaHQgaXQgd2FzIHN0YXRpYyBhbmQgaGFzIGZpeCB2YWx1ZSBmb3IgZWFjaCBjaGlwLCB1bmFj
Y2VwdGFibGUgZm9yIHlvdT8NCj4gDQo+ID4gKyAgICAgICBjb25zdCBjaGFyICpuYW1lOw0KPiA+
ICt9Ow0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgaW50IHNjYTMzMDBfc2V0X29wX21vZGUo
c3RydWN0IHNjYTMzMDBfZGF0YSAqc2NhX2RhdGEsIGludA0KPiA+ICtpbmRleCkgew0KPiA+ICsg
ICAgICAgaW50IG1vZGU7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKChpbmRleCA8IDApIHx8IChp
bmRleCA+PSBzY2FfZGF0YS0+Y2hpcC0+bnVtX2F2YWlsX21vZGVzKSkNCj4gDQo+IFRvbyBtYW55
IHBhcmVudGhlc2VzLg0KPiANCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+
ID4gKw0KPiA+ICsgICAgICAgbW9kZSA9IHNjYV9kYXRhLT5jaGlwLT5hdmFpbF9tb2Rlc190YWJs
ZVtpbmRleF07DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIHNjYTMzMDBfd3JpdGVfcmVnKHNj
YV9kYXRhLCBTQ0EzMzAwX1JFR19NT0RFLA0KPiBtb2RlKTsgfQ0KPiANCj4gLS0NCj4gV2l0aCBC
ZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0K
