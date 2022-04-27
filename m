Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C665111DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358514AbiD0HEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358509AbiD0HEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:04:20 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758AD24BD8;
        Wed, 27 Apr 2022 00:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PthoKqzhAacZpXUXAmyidm4RZU8p3+iDdnofLtO5a13KLeCyddCQ//cRgi6V6Vg9hV7WTiwJDWRdHFeStTMPu+gICwrAqu2kozaaMuCP7cVHevATztgzyhd/5pzLqg7pCjXNqqFSdH5MxhJngmmCU3e+PAcg/+lpqt2eH1C9kToXntfLjcyLHUFFQJ0wmRBhLJsSZwPQpeFew2wBBYHYLVW5AgbYzmiZ9ewsOfyxYICR6ecpR6RM8kJVwgaxRKrX1r6GQaqfGjCLA+ei36aw17j+DGVZd2le6YOGreIJXMMMOzx+VSOXeK2uHE8y84m3yYHEBWHiuLMtVdrJGYiW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuCc5KvRTgBwtklAlLsQoH8XE4uvJBtnA3tN56qcF94=;
 b=VG/nPTC1ugqx4LiYaVtb2341UX1CmoHeezro4SivAIqRnl+1vVFrTs2UpJmIRNhzNjNW/+7lf2auaBxSseq6Jfui6N6BrxOMoK21YjFFSFQMCHjRJWIXFlt+HamUw2F2Na6+kCGHKC5nc5swx/V8YXOlw7IkF9I1sOpeAKCfqbaeNp5vEUolVBXB/1QjQXr5AqsASNBAwYZvmqV/X1UMqr9kJamRvU8U3FlffhCnFX8CYBvf7WCmJ3j4DeqFNze0D+VcH/vbRRrDPAotjZls0BCJQmjtUb/C0HQbOpwmhfz7Np6NxNnLF/XxAoSqrFj5saU49sQAWBsVmOGxbRn0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuCc5KvRTgBwtklAlLsQoH8XE4uvJBtnA3tN56qcF94=;
 b=ZcCty2Gs7z+LOJYmgit7kQDoq7BdGr+Jd3zuYa1uDf5DoMGky88KuyQuPeEdupwzbR7wsjyJMjgTJ6w2sd+/wbGRGmTR4GVfT/zG6pu8yKV4iYrND9hyky8mAPCMQnjh6S8Yy6ORqOaIYGDBdIZgXr5XjHMkgwIOFDklQrReoKc=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR0401MB2513.eurprd04.prod.outlook.com (2603:10a6:203:3a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Wed, 27 Apr
 2022 07:01:07 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390%6]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 07:01:07 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: amphion: ensure the buffer count is not
 less than min_buffer
Thread-Topic: [EXT] Re: [PATCH] media: amphion: ensure the buffer count is not
 less than min_buffer
Thread-Index: AQHYPcbr3LBobsXolEi0GfOdZM0tnK0DhyYAgAAE+pA=
Date:   Wed, 27 Apr 2022 07:01:07 +0000
Message-ID: <AM6PR04MB6341DAEF2FCC3CB48A7F7E19E7FA9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220322082859.9834-1-ming.qian@nxp.com>
 <3cdf47f5-ad38-44ca-1720-d70a96432045@xs4all.nl>
In-Reply-To: <3cdf47f5-ad38-44ca-1720-d70a96432045@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c709739-e4da-4a24-4284-08da281bb3cb
x-ms-traffictypediagnostic: AM5PR0401MB2513:EE_
x-microsoft-antispam-prvs: <AM5PR0401MB2513B8812B0FE2B5E72947F6E7FA9@AM5PR0401MB2513.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBBvRY0Mje4xsDNR2+mgSH5llgujy1AgqH6nYqsLhgy//iaMAElRNIbOlEuOQ/Q5WFlgUdP0AIqfSHzsst3qxMS3BhvVRPYET6UZ7z3YncBBW8ndpBPtvx3BqoFePPg5gygJlA8ASUa6GuBaOArjdwXiSROdmgld/7vrye6eEG4XxrtDxt8V32HZdGJSsyejjWlU2VLXyuz+3PcYiZMiTaj2WdcTKSdfvkaFTUsdDtD4JHQEz+uHSbHYA4xcYrkaTzMSXSe/wVTnx5slrShhkaZtp/eWBeY+lDODhno1RV+CLFHnwb/BsC4IAWwURIe9ltQz3HWKXjjKOatoNCVULm+9jcchyu0s0GnawPEHgS284bqeSqBl0jYb/m5UxHzrs1t5aI3Tef2kfnZjn8p9MRr4x3xc167SltZT5MEzTfrb94w/bUTsq8kqVxCUjrCRoeXTHW307LA753ic1gERhJhvXEoEz1A3x0Ri2OFWxhiXrTKfYjcpUNQTlX9t5PnKtaQf+I1bO8F49COLbwTZ5G9W2ZS10mWYL5p7A3w/yB70mS8mrnyjEKOdfgU7szztepsp9zawwoTt4o5FM4egxaz/i9AJdalRdjpQ4QddzVosAzdulqrbAnAqgci229OV1eSnoYG4Tb2mFwesFVBkUw7zFGP/tp2TDIr1nDGL29M23t5V2gbyzEw7V4L/XTwCTcFkOi495ivvuOv22G2wBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(33656002)(8676002)(4326008)(55016003)(64756008)(316002)(2906002)(54906003)(44832011)(53546011)(86362001)(71200400001)(8936002)(76116006)(66946007)(66556008)(5660300002)(52536014)(7416002)(508600001)(7696005)(186003)(66446008)(66476007)(83380400001)(6506007)(26005)(9686003)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NCtiUkh1RU9sVmIvM2ZKL2M5Rm5naWExOWJKZEtDSDllVmlwTU9qQ2hRUHR2?=
 =?utf-8?B?RU9hMjY1MlI4UWlWKytObHdjdUtMWmpnaklobmxYckdhclFXbkZNYVBHM0o3?=
 =?utf-8?B?MGVzeFVLMW5ybmxQOVc4NTlMTUVqUWs0dnBjTWlHa1h1Vlc0QzJkSEZpYkZK?=
 =?utf-8?B?bi9FVnNZay9jWStjc1cvYnZ3QlRCSFpBTEdBWEtWdW1xYXZsY2pLQWNNdC9W?=
 =?utf-8?B?QzBHQWZDTnJ4ZjNZLzd0OC9nVWdKU2ZIVHd3WnlvaVpENlN1YVlQRVVlbmxO?=
 =?utf-8?B?U1pVNTRwK0pDQlZ6Nk1HRXg4VUpibk9HZExlNVBFKzBNeHlOLy9yMjVSeGta?=
 =?utf-8?B?b1hFYm1QNTlpYW55KzRSZ3Z2ZUJaYWZqOGVGaStuVzBsaHVqME1MMEdEVEUy?=
 =?utf-8?B?eUhjZEEvbW9hY0EwMVVDRlFTcDRzamkvcGFGK09OSUp3S2RaM1lzZ0VGTkVK?=
 =?utf-8?B?SGdEZDZiZ2FKalVRWG5vaUpobktzdEFYNklxVkpwbDBuT09zZnRmM3dEUmcy?=
 =?utf-8?B?dW41NHhmTW9JRFhmMGN5Y0ZWdGE3cjZKNU5ucFQzRTF5dmZxU1dMRnZXRmFW?=
 =?utf-8?B?Wm9vQUhscDh2NThKc2x0OUhJbi8yVFg0TGlSM3FBV0NvZEYxbGtkSHcxZnlB?=
 =?utf-8?B?UU43SWtEMFM3OVRqem1nblMwVk9CK2ZXcWFsVTRwRXZIbTZDSGJSMlZOWUd5?=
 =?utf-8?B?ZGs4WFZZcHp0Nnd5QVNVbVhKQk1ZUTJxdUpyc3R2WUUrckdMSHBTYTQ4dXB5?=
 =?utf-8?B?RVdvdTF6U0t4cERuVm1lQlJ1ZjJvLzVsTzFWaXVOdFhFNnZhUy9IN2V6WGlk?=
 =?utf-8?B?eUFUZmJ3TTJENVNqL1g1Z21aUXlzaDhsU25LdWRXWWZhTWkremc2L3JPR213?=
 =?utf-8?B?NWU4Y2ZRS1JFOHRMTy9SN0pKbEN3SStJOTRwSGd5YW41VGdzVlZWZFFiVUhp?=
 =?utf-8?B?eGRMU1BPSm9SckFsL09tTG5DSHdVUlJpeVBSemorTktjNGdRUG0yUWFOdys0?=
 =?utf-8?B?b1k1Uy9ZZERoS2tOdWJzb0c5WjNIN2FCTmV2dnEybFo5cVAwei9wN3FtcWEy?=
 =?utf-8?B?SEkyWEUxVkRTMERKV2h0dWpoQk5NczdlWUowd21CRUIxQzhWM2pQRjUzWURo?=
 =?utf-8?B?Yk9PQmpGWHFLZUtrR1VmWENBd3dJR3dpK2x4dSt5YVR4N082MUhLMCsrN0Jk?=
 =?utf-8?B?N2RVWDV1a1M0OTJDSUpZOXBDTEdHYlEwRHQwME9rSHFBYU9OSWtKdkxMT2pH?=
 =?utf-8?B?WkNlbjVGV0FBMWtTR3JNQld6RFNEM3l5ckV6VzBoc21GU1dQejJlb1NOblBQ?=
 =?utf-8?B?dWllWm9IdFU0aHpObUhTdm1XOE91YXFIZXE2SjRsZjZJKzR2MzN6VUlOS1F3?=
 =?utf-8?B?MS9LNG9NeW5ER2tYUGZoWGxuTXI5SDVzbjNja0N4aDh1N1lQd0p6V2Z1RWRn?=
 =?utf-8?B?aGkxWXMvbmxtNk85VHVvSzZ1NkJoWko2cVhzWjdjN2J5cndPN1MwdzdMVUJn?=
 =?utf-8?B?MkJ5dm5qbHR3Yk9mMzdtZkwydW1vTVd5aVpNbHkxazU0NXh1K0h6VTV2T1Vk?=
 =?utf-8?B?MGhTTU1WcTlWN0ZLYUYweCtRQmx4clFBRWZDVVEzVVJrVE8wM1VZMWNZa05w?=
 =?utf-8?B?RzRKZ29mU3pKcDNzZlRXTU12MWF4SnA3bm1ZVWphT2pLak1xOWE1VWpVWk5N?=
 =?utf-8?B?Q0E1QzlWZUVzRFU3TGpsLyt2YitrRVo1SENyM3dvRjQ3bE51OHFSbmJCM1RJ?=
 =?utf-8?B?L3ZDSDJoME9SUFprSkpKRmZuQy9oWFJUSGdYQ1NhcnNWbXJFWm1hbndzUU5z?=
 =?utf-8?B?Ty9oSEZlZ2VoUDQ0TENPMG1tOUZDKzRrYVErQ1g5R05MV2Q5Z1R1RVhwSUky?=
 =?utf-8?B?WWgxcFA2emJNcnJrRzE5bFVFd2RIN2hEL0hyN05WVzNoSHU5d3VOQlhJd0lh?=
 =?utf-8?B?VVZrVHAvNkc4UnpFN21YRE5jeDZ2aGxPZ1FPVzhCcWNlbGlMRE00bE5NNU1m?=
 =?utf-8?B?bzNYSXEvbGcwWUpJYXlWbDQxbURkY3ZrTzQ1cGNOUUpuZjQxTXQ2Z1NySDdv?=
 =?utf-8?B?NmIxK2tlczVTVkR4VWV0ZXN0OFU2bytteGxSd2U0a0RmMms5emM4dGlPdzhw?=
 =?utf-8?B?KzJzZllBZytnZlA1cUhMb2JDbzMxNndoc0JrUXUvTjRtUnV4QitzUXVJT0Jq?=
 =?utf-8?B?YzFSdGY4OVYwNDFlMU1heWlaWVV2YkQ5Wkt6dW9YMURPRUZGaDFVMVZpMHcx?=
 =?utf-8?B?NVNpd25ZVkRJN0VHNytwSjlQY0xoeHRvSFhNOTRWeVBIQmQ5dllmckhLTU4z?=
 =?utf-8?Q?/hwc4qwV9zwWJXiPvk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c709739-e4da-4a24-4284-08da281bb3cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 07:01:07.1704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijJpW7kNEegbQtvIOriColXlJiGAHrWLeQfxukuJvUa1i2dkC++rGIqkACapr9lmY+SMRhfeF9GyW52hx2p0wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBIYW5zIFZlcmt1aWwgW21haWx0bzpodmVya3VpbC1jaXNjb0B4czRhbGwubmxdDQo+
IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjcsIDIwMjIgMjozOCBQTQ0KPiBUbzogTWluZyBRaWFu
IDxtaW5nLnFpYW5AbnhwLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2Vy
bmVsLm9yZw0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEFpc2hlbmcgRG9uZw0KPiA8YWlzaGVuZy5kb25nQG54
cC5jb20+OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJq
ZWN0OiBbRVhUXSBSZTogW1BBVENIXSBtZWRpYTogYW1waGlvbjogZW5zdXJlIHRoZSBidWZmZXIg
Y291bnQgaXMgbm90IGxlc3MNCj4gdGhhbiBtaW5fYnVmZmVyDQo+IA0KPiBDYXV0aW9uOiBFWFQg
RW1haWwNCj4gDQo+IEhpIE1pbmcgUWlhbiwNCj4gDQo+IE9uIDIyLzAzLzIwMjIgMDk6MjgsIE1p
bmcgUWlhbiB3cm90ZToNCj4gPiB0aGUgb3V0cHV0IGJ1ZmZlciBjb3VudCBzaG91bGQgPj0gbWlu
X2J1ZmZlcl9vdXQgdGhlIGNhcHR1cmUgYnVmZmVyDQo+ID4gY291bnQgc2hvdWxkID49IG1pbl9i
dWZmZXJfY2FwDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcucWlhbkBu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1
X3Y0bDIuYyB8IDQgKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV92
NGwyLmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfdjRsMi5jDQo+
ID4gaW5kZXggY2JmMzMxNTYwNWE5Li43MmEwNTQ0ZjRkYTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV92NGwyLmMNCj4gPiArKysgYi9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X3Y0bDIuYw0KPiA+IEBAIC0zNTUsNiArMzU1LDEw
IEBAIHN0YXRpYyBpbnQgdnB1X3ZiMl9xdWV1ZV9zZXR1cChzdHJ1Y3QgdmIyX3F1ZXVlDQo+ICp2
cSwNCj4gPiAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsg
ICAgIGlmIChWNEwyX1RZUEVfSVNfT1VUUFVUKHZxLT50eXBlKSkNCj4gPiArICAgICAgICAgICAg
ICpidWZfY291bnQgPSBtYXhfdCh1bnNpZ25lZCBpbnQsICpidWZfY291bnQsDQo+IGluc3QtPm1p
bl9idWZmZXJfb3V0KTsNCj4gPiArICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAqYnVmX2Nv
dW50ID0gbWF4X3QodW5zaWduZWQgaW50LCAqYnVmX2NvdW50LA0KPiA+ICsgaW5zdC0+bWluX2J1
ZmZlcl9jYXApOw0KPiANCj4gSSBub3RpY2VkIHRoYXQgbWluX2J1ZmZlcl9vdXQvY2FwIGlzIHNl
dCB0byAyLCBidXQgbWluX2J1ZmZlcnNfbmVlZGVkIGlzIHNldCB0bw0KPiAxLiBXb3VsZG4ndCBp
dCBtYWtlIG1vcmUgc2Vuc2UgdG8gc2V0IG1pbl9idWZmZXJzX25lZWRlZCB0bw0KPiAyIGFzIHdl
bGw/DQo+IA0KPiBJZiB5b3UgZG8gdGhhdCwgdGhlbiB0aGUgdmIyIGNvcmUgd2lsbCBhbHJlYWR5
IHRha2UgY2FyZSBvZiBlbnN1cmluZyB0aGF0IHRoZQ0KPiBidWZfY291bnQgaXMgYWRqdXN0ZWQu
DQo+IA0KPiBJZiB5b3UgKmRvKiBoYXZlIHRvIGRvIHRoaXMgbWFudWFsbHksIHRoZW4geW91IG5l
ZWQgdG8gcGxhY2UgdGhlIHdob2xlIGlmLWVsc2UNCj4gdW5kZXIgJ2lmICghKm51bV9wbGFuZXMp
IHsnLCBvdGhlcndpc2UgaXQgd2lsbCBtZXNzIHVwIHRoZSBWSURJT0NfQ1JFQVRFX0JVRlMNCj4g
aW9jdGwuIFNlZSB0aGUgcXVldWVfc2V0dXAgaW4gaW5jbHVkZS9tZWRpYS92aWRlb2J1ZjItY29y
ZS5oIGRvY3VtZW50YXRpb24NCj4gZm9yIHRoZSBzb3JkaWQgZGV0YWlscy4NCj4gDQo+IFJlZ2Fy
ZHMsDQo+IA0KPiAgICAgICAgIEhhbnMNCj4gDQoNCkhpIEhhbnMsDQogICAgSSB3YW50IHRvIG1h
a2UgdGhlIHZwdSBzdGFydCB3aGVuIDEgZnJhbWVzIGlzIHF1ZXVlZCwgc28gSSBzZXQgdGhlIG1p
bl9idWZmZXJzX25lZWRlZCB0byAxLg0KQW5kIHRoZSBtaW5fYnVmZmVyX2NhcCBtYXkgYmUgY2hh
bmdlZCB3aGVuIGEgc291cmNlIGNoYW5nZSBldmVudCBpcyB0cmlnZ2VyZWQuIFNvIGluIG1vc3Qg
Y2FzZSwgaXQgd2lsbCBiZSBsYXJnZXIgdGhhbiAyLg0KICAgIEknbGwgbWFrZSBhIHYyIHBhdGNo
IHRoYXQgcGxhY2UgdGhlIHdob2xlIGlmLWVsc2UgdW5kZXIgJ2lmICghKm51bV9wbGFuZXMpIHsn
DQogICAgVGhhbmtzIGZvciB5b3VyIHJlbWluZGVyDQoNCk1pbmcNCg0KPiA+ICAgICAgICpwbGFu
ZV9jb3VudCA9IGN1cl9mbXQtPm51bV9wbGFuZXM7DQo+ID4gICAgICAgZm9yIChpID0gMDsgaSA8
IGN1cl9mbXQtPm51bV9wbGFuZXM7IGkrKykNCj4gPiAgICAgICAgICAgICAgIHBzaXplW2ldID0g
Y3VyX2ZtdC0+c2l6ZWltYWdlW2ldOw0KDQo=
