Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF16F5634D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiGAOF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiGAOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:05:55 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEEE31528;
        Fri,  1 Jul 2022 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656684353; x=1688220353;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Lxg6Gm+nxOw+Lo2L+ApOV+sw6BkGCdksTNeeNiOTFDU=;
  b=dGh9ECiKNeBINCMUPJsuIVs1bEL7SJykGARU3S9Gk2CUbRbcGjuLvDDo
   4B4A+XwSmx70e3bVUQBf1b6fj86IQjCzF0oW6U+hDQo894r9CxrTMJkx5
   exOa0/1IMda7PdXrDJx27z38wCZkL5QfNfiRG3qv8kbu9KqiKMlfA5lyS
   G9oBcknotxI/XR+K4n7nPHnpq3bzkfcf5tO9UQIuIZtmegIXfacBVprmg
   N18A42BZf1NaB9AuY7Pn2gQm7adIh+FxcloguyTHyelREJ7602eqEUOw8
   9d8aU7DwcI3DAHU3Jl3Y6FkGcZGXFqDH6yQAyUiZE5uVMtUt5oOXrbL4k
   A==;
X-IronPort-AV: E=Sophos;i="5.92,237,1650902400"; 
   d="scan'208";a="308914475"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 22:05:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emyPg9H7svTsJGSVXSTxgKjMos/3lcoULr5G3NeuMQZYdJ0qF2oWnTpHTAGwt5WAVM0xYkE/Ak5aq/+fCxpX86TnXeg0EmynYxt3MX/FUtBDw5CAd7CqDfm27j5eRaw2B23DMlIKNHnHFGBbEz/+HupMMHXsSWUlzwF5EOj9LPAwdzyf0DNXUSJNg9RtSY2A+gLDGzWjRt3mp0n9SYZK2MfcbUwmApGWkhwoGcC7T1AJCI+IVWUbo6E8s4N1CnTi2AXvoap6Wz8jOpwdtywy+9BeSpycKdSredPtCZhafuvH0R7GFrbMaRHHNYcVEeP0M3a0W4jw76Gflt1Dk4t3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxg6Gm+nxOw+Lo2L+ApOV+sw6BkGCdksTNeeNiOTFDU=;
 b=NOvkDojOIGILONBBwmXoFUIPhiBDfkTpFb/4dl1mQRLXcE2rkEgZkqU7ggKyYcOKGGqBczEvljzLpnOhTaeQsof2u442DE7W6S2NM51QZuvdaGj6kWz0bv1wTaaIRUQnsBmd01NEMxGcl6ph214RSX7lnlSib1ESw5lyKUPRi6CmmibqW/3z7qMJISENfFECUMWUwAO1vhLsiJYxvoL6DCc4qb7q6RytB9/RvH4rzYRrPGUc3MBjN6Q1uwxNhdrVclXwFj11rnmi+M9q+m0tXAU6hnw+6OOd2LilkycT+x6LV7NTFUvv9rWrXxkSz9LehY+1MMVHpyPKfOsG/JnM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxg6Gm+nxOw+Lo2L+ApOV+sw6BkGCdksTNeeNiOTFDU=;
 b=SKl0OQTSopaldUig6f6rpmMuywyrEovnrOwEIR2NovgBpbnHEe0zTyfoj7K/UZxCHuMbbzV/p45J/7LEMUrr9eEzCKYpkN+PCWA+Ygpvvz8t9M/AE0GEGJ5QsJTtQHC7mg9dw4iqHe5W4FRXkhALoh/CCrMjgywwe2daadfZopc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7801.namprd04.prod.outlook.com (2603:10b6:510:ef::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Fri, 1 Jul 2022 14:05:50 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%9]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 14:05:50 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCHv4] mmc: block: Add single read for 4k sector cards
Thread-Topic: [PATCHv4] mmc: block: Add single read for 4k sector cards
Thread-Index: AdiNR/jT23QFNORJQg2DejtQ3jiaLgACNGQAAACxzaA=
Date:   Fri, 1 Jul 2022 14:05:50 +0000
Message-ID: <DM6PR04MB65757C787101735B6E464B76FCBD9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cf4f316274c5474586d0d99b17db4a4c@hyperstone.com>
 <5463745a-4f62-095f-994c-982e8fcc85d9@intel.com>
In-Reply-To: <5463745a-4f62-095f-994c-982e8fcc85d9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a380137-52f8-45d7-6b47-08da5b6acdaf
x-ms-traffictypediagnostic: PH0PR04MB7801:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFjRBaO1pF/zyTUhc8Expx2ycbfD8brzUxZhvCJtAkCKc83VA9KjpBkMUpmwNin6+zfbUXXf0+SOiMnHU+YMqlU8+nR5/WyiXT4RijI3a9qtewXK8PWHaBHGJZE+PEK5BufB4IPlIMBhQL6trkvr4ehcM5k/Poj557hgz6ZpcwssR0MPwrcUqRmQHfz2NIPhCe2D/xqs6yr/5efRNm/mUYDLJlqnb5PksbWgCRkee6GV5TJnGpPa/zLLfsdRimKUYdsDXhwmEJpoOrvK30BxSqozMyCCE3omR0FOl7K/T3DOhA5fpgAZDVBQyksktrtSmjn7bk6UhEW95SlN9xrqsVNFrEcb5sF/zl5BTT2cCu8ZPf/b90fO6rydZWGP4XyKXuDFUxVaKofdLsGMtyQZ/batcqIP4XPkek/oGC943qTsZbwgJWLPol6Fd5TG2cHvPIbjVZ1qPc7L1+tpfJlc6qhOaBXBJlV2JjJVJJzqkHHMEDXfX58san7Q2Yb5r7qYKlErL4trqHTb5moZ2vji8WrPdAGtex65w9OUOOgKd5JWt9BgWSI48R1tYPxXahWOMAOou44T2ARKjXA7IKR1oLL2Fuq5llwhuEJ+vbagwvgc3uputIe169HpOqL6/mYZRIZ3mtEkG/2Iy4NX8FhwsVjnd8CW6723MisLhPgPX4O1/nNLYtGFaZElYHW+nbegClR3xU3NYm9CFPmWZEuJT/AwDcMA1AF+vPkTwpxl4Xu4MdUwWE2yV1434Jy9Ogf+5QxmqmDPdT6VHjF+LNy5P9v5DIX6jGsO47fGWjcsGyWcRJaNEbN6gruKQ/URHUB8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(26005)(53546011)(33656002)(41300700001)(110136005)(6506007)(186003)(2906002)(7696005)(5660300002)(83380400001)(71200400001)(55016003)(8936002)(9686003)(86362001)(52536014)(478600001)(66556008)(66476007)(8676002)(38100700002)(122000001)(66946007)(76116006)(316002)(38070700005)(82960400001)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGNFWndXc2ltVDZJRW1EODczbm9VOXgrZDN2VXJUMnBBakhBUG5jZ0FmK01T?=
 =?utf-8?B?YkQ1dVM1MlFsbWZ5NVYxeHExSFhEdXQ4WU84emJ3TWV4U0pyVnFYZDJXTFMx?=
 =?utf-8?B?dkRiUVViYTczckoxZjMxK29KZjhvS0puZlRqUTNjeHlGQ2JFb2pNVWw0T2Ey?=
 =?utf-8?B?bmpYU1BoWlZkWUNOalBmYjZxYXJ5WTZ4QlU4SWVTRVJwRzVmWW03VFpiWmRC?=
 =?utf-8?B?Y1dFVlU3NmtpaisyNk9rdkV4dWZvUzM2VE5JY3h1bUNBcGxGY1l1YktleXZI?=
 =?utf-8?B?Q3hEYnJ2anExd3FqM0hWdk0xWVljSDdmM3dtK09QYXF6cjhON0wzdGl6WGd6?=
 =?utf-8?B?cGFiSmtHNElWM2oxcWhlRHg0cERFTFZydnNqOVJCbkJIREhJT3lLakx4Nkor?=
 =?utf-8?B?ZVh2aUMreEErbnpSd2FkQkR3Z28xZ2lUQVpsTTBMOXJ0NTNkS2NQWFRnbWtQ?=
 =?utf-8?B?eUtoYldIRHdXVVBsQzFHMUxsSlVZL3VvY3ZFSitwbnYvdzJHWEdnQUwvbWta?=
 =?utf-8?B?OHhxeGxIRkJ6KzlRMmVGay9ackVZWWs1STVzdkZuK3QrT3ZtWlBmZ0JmUkhw?=
 =?utf-8?B?Y2szV1d1UG1RaG9wbGNDSzZjc0Q3eDV4RXlKVTdzemVLMitRalVUZlp0czdV?=
 =?utf-8?B?Vnl5eTY2NFZFbFc4cmdpNHpSaDFDK3RrM1Flc0xab20wTFRpeDQxSG43ZEFh?=
 =?utf-8?B?N1hGRVJaRWNlSkVqZUJEVUFZNjhlWTJhQWc5RThjQjNwdlVDa2gwUWtmMXMr?=
 =?utf-8?B?STQwVVZQYjhtaG9yd1Bjc1NYcEFnMG9IcWVQVk5rYm8wTzFMT05mQkNZbnBE?=
 =?utf-8?B?b2VPNFZVSHhSTGdzM3p2UHA5UkxPMlJzeDdHT3ZMMFNBMmJXL3FNWGcrMVAy?=
 =?utf-8?B?YkFDWi9rMHk5UkNrMTJ2a3VUd3lVM0gxWHpyWWJXK0VBQ1J1SjlOc1ZFOG0z?=
 =?utf-8?B?OFBWQWhTQU9TTFE4Q0RPNEVDby8rTGFKYkRqMWlxQWZDUmRjVk1jeWxDNGxE?=
 =?utf-8?B?L2tENm5IeTk3YkZOdlJtRDR0Q3NkSWF3bCtKUFpXOWVPQWliTVlFYTNqL1JP?=
 =?utf-8?B?ZENDRHNkZklNaHREZnhHKzQwd1FlSVZvMUJBZzRXamd1N3MwenJ0b2twNDFj?=
 =?utf-8?B?OEQ3SDM1dVVjTVB6Vm5sT2tJQm5ZYzJyK3VnMHRMSkNrUzBVM3NnaVU4bnhk?=
 =?utf-8?B?N1c2bkFhUVEvd0grbGxxQkVkVExYZ0Z4Y2hNYm9oQVJaWG8wdXF3ajRNWkVU?=
 =?utf-8?B?Q2JOQ0lsN05yTGtXSWUxY05IbHNGdkVib0MzdktLV2RBWk4zTTJ6cWdRN3BE?=
 =?utf-8?B?OU1tRER5NmdmM1R2SmRkQ1NKL2YzdDBURmxiaU14aWxGemVldUN0bDNtZVVV?=
 =?utf-8?B?dW44ODRlRFZJWGhOVnVhbHVMcEVCSjF2QTg1bWFoZGdnZGNzZzcwR1VnQzBn?=
 =?utf-8?B?NmNVYWdzQWZTOWQ5eGpMaW1tKzMva3NGRCtneWh3bVBNUVVld1d1S2hqZ0JF?=
 =?utf-8?B?MWRIN2lKV0xCRDkzdDFQUzBnbEtFOHNReVN2L3VNaWlQUVBZU1hCK1IzMlND?=
 =?utf-8?B?aVVPSFNCSXlDYVQ1ZnBZSDl5UldxelFvcFk2VFdkZG83Sm9yMUh0Y3BwdTZU?=
 =?utf-8?B?OWJEOFpvZ09TcitRODR6cXpEMDI1Y0VWMHBlenpRWFdNcWJSL3RYbnVqRm52?=
 =?utf-8?B?dFpxWGh2RFVET2FwTUZscnlNMGpOVzlueXZrM0VrWHJhbDVKOHl3ZFdrNDlZ?=
 =?utf-8?B?QWlXV3ZJandOeVJtTVdGai9NOWpNRFJacEhVWGZndlNweTFYY1pZT3ZEK3Bz?=
 =?utf-8?B?dDFuMDhqS0tLWDRGZ2hUWkY1TXFLMmRXL1ZRdTFjTk9ZVU9FVzY2K3h3K0xv?=
 =?utf-8?B?clBXdndUUkZlWVV3cFY3QzlVNzRzdjYreFFTUUt3S3dkZUx2QllUUzh5RXJS?=
 =?utf-8?B?YVdzZUZLUjBEb0NLTDNWUmltMm1aVEdTckxpYkF0VEJNYS9ZYzVHbklZbDlU?=
 =?utf-8?B?NTBYckJSa2YvWlBYVjJVRkozM1dBdFVILzJZd05PTW1vRDBtQ2ZiQzZlSmhy?=
 =?utf-8?B?dDMwQzdlUlBEUWxLamhoUVZVWjkvSWNjai9UVmFXK0pQcHROdVR4MTBVRTAx?=
 =?utf-8?Q?6z7k3O4941ahiyNZF8y6Y1MpT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a380137-52f8-45d7-6b47-08da5b6acdaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 14:05:50.1677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YoLCzHtagKAEhvumcr/dJIlMD7+Ri9IksaXOC4jcEqRO3W7XtynKQ6wn+uRSiDrmH8Cfy8C8fK8mJFpb2D2wxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7801
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxLzA3LzIyIDE1OjQzLCBDaHJpc3RpYW4gTG9laGxlIHdyb3RlOg0KPiA+IENhcmRzIHdp
dGggNGsgbmF0aXZlIHNlY3RvciBzaXplIG1heSBvbmx5IGJlIHJlYWQgNGstYWxpZ25lZCwNCj4g
PiBhY2NvbW1vZGF0ZSBmb3IgdGhpcyBpbiB0aGUgc2luZ2xlIHJlYWQgcmVjb3ZlcnkgYW5kIHVz
ZSBpdC4NCj4gPg0KPiA+IEZpeGVzOiA4MTE5Njk3NmVkOTQ2IChtbWM6IGJsb2NrOiBBZGQgYmxr
LW1xIHN1cHBvcnQpDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIExvZWhsZSA8Y2xvZWhs
ZUBoeXBlcnN0b25lLmNvbT4NCj4gDQo+IEFja2VkLWJ5OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4u
aHVudGVyQGludGVsLmNvbT4NClJldmlld2VkLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5A
d2RjLmNvbT4NCg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIHwg
MjggKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tbWMvY29yZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIGluZGV4DQo+
ID4gZjRhMTI4MTY1OGRiLi45MTJhMzk4YTlhNzYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9t
bWMvY29yZS9ibG9jay5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jDQo+ID4g
QEAgLTE3Niw3ICsxNzYsNyBAQCBzdGF0aWMgaW5saW5lIGludCBtbWNfYmxrX3BhcnRfc3dpdGNo
KHN0cnVjdA0KPiBtbWNfY2FyZCAqY2FyZCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1bnNpZ25lZCBpbnQgcGFydF90eXBlKTsgIHN0YXRpYw0KPiA+IHZvaWQgbW1j
X2Jsa19yd19ycV9wcmVwKHN0cnVjdCBtbWNfcXVldWVfcmVxICptcXJxLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG1tY19jYXJkICpjYXJkLA0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW50IGRpc2FibGVfbXVsdGksDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnQgcmVjb3ZlcnlfbW9kZSwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBtbWNfcXVldWUgKm1xKTsgIHN0YXRpYyB2b2lkDQo+ID4gbW1j
X2Jsa19oc3FfcmVxX2RvbmUoc3RydWN0IG1tY19yZXF1ZXN0ICptcnEpOw0KPiA+DQo+ID4gQEAg
LTEzMDIsNyArMTMwMiw3IEBAIHN0YXRpYyB2b2lkIG1tY19ibGtfZXZhbF9yZXNwX2Vycm9yKHN0
cnVjdA0KPiA+IG1tY19ibGtfcmVxdWVzdCAqYnJxKSAgfQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lk
IG1tY19ibGtfZGF0YV9wcmVwKHN0cnVjdCBtbWNfcXVldWUgKm1xLCBzdHJ1Y3QNCj4gbW1jX3F1
ZXVlX3JlcSAqbXFycSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGRpc2Fi
bGVfbXVsdGksIGJvb2wgKmRvX3JlbF93cl9wLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQgcmVjb3ZlcnlfbW9kZSwgYm9vbCAqZG9fcmVsX3dyX3AsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGJvb2wgKmRvX2RhdGFfdGFnX3ApICB7DQo+ID4gICAgICAgc3Ry
dWN0IG1tY19ibGtfZGF0YSAqbWQgPSBtcS0+YmxrZGF0YTsgQEAgLTEzNjgsMTIgKzEzNjgsMTIg
QEANCj4gPiBzdGF0aWMgdm9pZCBtbWNfYmxrX2RhdGFfcHJlcChzdHJ1Y3QgbW1jX3F1ZXVlICpt
cSwgc3RydWN0DQo+IG1tY19xdWV1ZV9yZXEgKm1xcnEsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgIGJycS0+ZGF0YS5ibG9ja3MtLTsNCj4gPg0KPiA+ICAgICAgICAgICAgICAgLyoNCj4gPiAt
ICAgICAgICAgICAgICAqIEFmdGVyIGEgcmVhZCBlcnJvciwgd2UgcmVkbyB0aGUgcmVxdWVzdCBv
bmUgc2VjdG9yDQo+ID4gKyAgICAgICAgICAgICAgKiBBZnRlciBhIHJlYWQgZXJyb3IsIHdlIHJl
ZG8gdGhlIHJlcXVlc3Qgb25lIChuYXRpdmUpDQo+ID4gKyBzZWN0b3INCj4gPiAgICAgICAgICAg
ICAgICAqIGF0IGEgdGltZSBpbiBvcmRlciB0byBhY2N1cmF0ZWx5IGRldGVybWluZSB3aGljaA0K
PiA+ICAgICAgICAgICAgICAgICogc2VjdG9ycyBjYW4gYmUgcmVhZCBzdWNjZXNzZnVsbHkuDQo+
ID4gICAgICAgICAgICAgICAgKi8NCj4gPiAtICAgICAgICAgICAgIGlmIChkaXNhYmxlX211bHRp
KQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBicnEtPmRhdGEuYmxvY2tzID0gMTsNCj4gPiAr
ICAgICAgICAgICAgIGlmIChyZWNvdmVyeV9tb2RlKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBicnEtPmRhdGEuYmxvY2tzID0NCj4gPiArIHF1ZXVlX3BoeXNpY2FsX2Jsb2NrX3NpemUobXEt
PnF1ZXVlKSA+PiA5Ow0KPiA+DQo+ID4gICAgICAgICAgICAgICAvKg0KPiA+ICAgICAgICAgICAg
ICAgICogU29tZSBjb250cm9sbGVycyBoYXZlIEhXIGlzc3VlcyB3aGlsZSBvcGVyYXRpbmcgQEAN
Cj4gPiAtMTU5MCw3ICsxNTkwLDcgQEAgc3RhdGljIGludCBtbWNfYmxrX2NxZV9pc3N1ZV9yd19y
cShzdHJ1Y3QgbW1jX3F1ZXVlDQo+ID4gKm1xLCBzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0KPiA+DQo+
ID4gIHN0YXRpYyB2b2lkIG1tY19ibGtfcndfcnFfcHJlcChzdHJ1Y3QgbW1jX3F1ZXVlX3JlcSAq
bXFycSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBtbWNfY2FyZCAq
Y2FyZCwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBkaXNhYmxlX211bHRp
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHJlY292ZXJ5X21vZGUsDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbW1jX3F1ZXVlICptcSkgIHsN
Cj4gPiAgICAgICB1MzIgcmVhZGNtZCwgd3JpdGVjbWQ7DQo+ID4gQEAgLTE1OTksNyArMTU5OSw3
IEBAIHN0YXRpYyB2b2lkIG1tY19ibGtfcndfcnFfcHJlcChzdHJ1Y3QNCj4gbW1jX3F1ZXVlX3Jl
cSAqbXFycSwNCj4gPiAgICAgICBzdHJ1Y3QgbW1jX2Jsa19kYXRhICptZCA9IG1xLT5ibGtkYXRh
Ow0KPiA+ICAgICAgIGJvb2wgZG9fcmVsX3dyLCBkb19kYXRhX3RhZzsNCj4gPg0KPiA+IC0gICAg
IG1tY19ibGtfZGF0YV9wcmVwKG1xLCBtcXJxLCBkaXNhYmxlX211bHRpLCAmZG9fcmVsX3dyLA0K
PiAmZG9fZGF0YV90YWcpOw0KPiA+ICsgICAgIG1tY19ibGtfZGF0YV9wcmVwKG1xLCBtcXJxLCBy
ZWNvdmVyeV9tb2RlLCAmZG9fcmVsX3dyLA0KPiA+ICsgJmRvX2RhdGFfdGFnKTsNCj4gPg0KPiA+
ICAgICAgIGJycS0+bXJxLmNtZCA9ICZicnEtPmNtZDsNCj4gPg0KPiA+IEBAIC0xNjkwLDcgKzE2
OTAsNyBAQCBzdGF0aWMgaW50IG1tY19ibGtfZml4X3N0YXRlKHN0cnVjdCBtbWNfY2FyZA0KPiA+
ICpjYXJkLCBzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0KPiA+DQo+ID4gICNkZWZpbmUgTU1DX1JFQURf
U0lOR0xFX1JFVFJJRVMgICAgICAyDQo+ID4NCj4gPiAtLyogU2luZ2xlIHNlY3RvciByZWFkIGR1
cmluZyByZWNvdmVyeSAqLw0KPiA+ICsvKiBTaW5nbGUgKG5hdGl2ZSkgc2VjdG9yIHJlYWQgZHVy
aW5nIHJlY292ZXJ5ICovDQo+ID4gIHN0YXRpYyB2b2lkIG1tY19ibGtfcmVhZF9zaW5nbGUoc3Ry
dWN0IG1tY19xdWV1ZSAqbXEsIHN0cnVjdCByZXF1ZXN0DQo+ID4gKnJlcSkgIHsNCj4gPiAgICAg
ICBzdHJ1Y3QgbW1jX3F1ZXVlX3JlcSAqbXFycSA9IHJlcV90b19tbWNfcXVldWVfcmVxKHJlcSk7
IEBADQo+ID4gLTE2OTgsNiArMTY5OCw3IEBAIHN0YXRpYyB2b2lkIG1tY19ibGtfcmVhZF9zaW5n
bGUoc3RydWN0IG1tY19xdWV1ZQ0KPiAqbXEsIHN0cnVjdCByZXF1ZXN0ICpyZXEpDQo+ID4gICAg
ICAgc3RydWN0IG1tY19jYXJkICpjYXJkID0gbXEtPmNhcmQ7DQo+ID4gICAgICAgc3RydWN0IG1t
Y19ob3N0ICpob3N0ID0gY2FyZC0+aG9zdDsNCj4gPiAgICAgICBibGtfc3RhdHVzX3QgZXJyb3Ig
PSBCTEtfU1RTX09LOw0KPiA+ICsgICAgIHNpemVfdCBieXRlc19wZXJfcmVhZCA9IHF1ZXVlX3Bo
eXNpY2FsX2Jsb2NrX3NpemUobXEtPnF1ZXVlKTsNCj4gPg0KPiA+ICAgICAgIGRvIHsNCj4gPiAg
ICAgICAgICAgICAgIHUzMiBzdGF0dXM7DQo+ID4gQEAgLTE3MzIsMTMgKzE3MzMsMTMgQEAgc3Rh
dGljIHZvaWQgbW1jX2Jsa19yZWFkX3NpbmdsZShzdHJ1Y3QNCj4gbW1jX3F1ZXVlICptcSwgc3Ry
dWN0IHJlcXVlc3QgKnJlcSkNCj4gPiAgICAgICAgICAgICAgIGVsc2UNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgZXJyb3IgPSBCTEtfU1RTX09LOw0KPiA+DQo+ID4gLSAgICAgfSB3aGlsZSAo
YmxrX3VwZGF0ZV9yZXF1ZXN0KHJlcSwgZXJyb3IsIDUxMikpOw0KPiA+ICsgICAgIH0gd2hpbGUg
KGJsa191cGRhdGVfcmVxdWVzdChyZXEsIGVycm9yLCBieXRlc19wZXJfcmVhZCkpOw0KPiA+DQo+
ID4gICAgICAgcmV0dXJuOw0KPiA+DQo+ID4gIGVycm9yX2V4aXQ6DQo+ID4gICAgICAgbXJxLT5k
YXRhLT5ieXRlc194ZmVyZWQgPSAwOw0KPiA+IC0gICAgIGJsa191cGRhdGVfcmVxdWVzdChyZXEs
IEJMS19TVFNfSU9FUlIsIDUxMik7DQo+ID4gKyAgICAgYmxrX3VwZGF0ZV9yZXF1ZXN0KHJlcSwg
QkxLX1NUU19JT0VSUiwgYnl0ZXNfcGVyX3JlYWQpOw0KPiA+ICAgICAgIC8qIExldCBpdCB0cnkg
dGhlIHJlbWFpbmluZyByZXF1ZXN0IGFnYWluICovDQo+ID4gICAgICAgaWYgKG1xcnEtPnJldHJp
ZXMgPiBNTUNfTUFYX1JFVFJJRVMgLSAxKQ0KPiA+ICAgICAgICAgICAgICAgbXFycS0+cmV0cmll
cyA9IE1NQ19NQVhfUkVUUklFUyAtIDE7IEBAIC0xODc5LDEwICsxODgwLDkNCj4gPiBAQCBzdGF0
aWMgdm9pZCBtbWNfYmxrX21xX3J3X3JlY292ZXJ5KHN0cnVjdCBtbWNfcXVldWUgKm1xLCBzdHJ1
Y3QNCj4gcmVxdWVzdCAqcmVxKQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAg
IH0NCj4gPg0KPiA+IC0gICAgIC8qIEZJWE1FOiBNaXNzaW5nIHNpbmdsZSBzZWN0b3IgcmVhZCBm
b3IgbGFyZ2Ugc2VjdG9yIHNpemUgKi8NCj4gPiAtICAgICBpZiAoIW1tY19sYXJnZV9zZWN0b3Io
Y2FyZCkgJiYgcnFfZGF0YV9kaXIocmVxKSA9PSBSRUFEICYmDQo+ID4gLSAgICAgICAgIGJycS0+
ZGF0YS5ibG9ja3MgPiAxKSB7DQo+ID4gLSAgICAgICAgICAgICAvKiBSZWFkIG9uZSBzZWN0b3Ig
YXQgYSB0aW1lICovDQo+ID4gKyAgICAgaWYgKHJxX2RhdGFfZGlyKHJlcSkgPT0gUkVBRCAmJiBi
cnEtPmRhdGEuYmxvY2tzID4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgcXVldWVfcGh5c2lj
YWxfYmxvY2tfc2l6ZShtcS0+cXVldWUpID4+IDkpIHsNCj4gPiArICAgICAgICAgICAgIC8qIFJl
YWQgb25lIChuYXRpdmUpIHNlY3RvciBhdCBhIHRpbWUgKi8NCj4gPiAgICAgICAgICAgICAgIG1t
Y19ibGtfcmVhZF9zaW5nbGUobXEsIHJlcSk7DQo+ID4gICAgICAgICAgICAgICByZXR1cm47DQo+
ID4gICAgICAgfQ0KDQo=
