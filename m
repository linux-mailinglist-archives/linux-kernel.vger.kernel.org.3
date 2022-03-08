Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73524D0DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344298AbiCHBoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiCHBo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:44:29 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140072.outbound.protection.outlook.com [40.107.14.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB2639690;
        Mon,  7 Mar 2022 17:43:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbCBtTyCxQ5T0TXHJyBAwt6oKz8kQWOvlgUde0qgONz7jBNgljU+kd/DJodQ3HKwHWZQHquqZVlyOvFRkH0qh5ly3l+Ykis2BKiZGy+6AUJfhLWupU5C9+HYXUiDGFBEs8H5c4YWkCDFQVIHAghg7eX3VRG2FziXuSNVyslP2GOzNDJYDDGvXKz648Tnrw6uUq+eAwvilOC8BQ1p0zsS8jx5yr0QH0CKELhkuPe2Z6Eof8DPcH2L0cttxtKNUzmhwqA94crXU9mQJRIktd7PMcbF+pJKau2y0OrONPL/IjHS2SmwoXQriirZiC+9vygj/iSYfTeiu/6+71dTkCRUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmEoqZ1OMwDq0drHGBO037AL/4mMoGFktvwtPO93TVY=;
 b=FnfFdK6GrwWPR3Ma0epvTpsMT2NbxfNU0urf/zpOXPrVdxAMzdDXuRkN89DyhX8Jf8XwfhbkS4leJsljecmqaBhodaTYGtnJx9aRSAh1GIqwKT5DuUxFXdPcb4o7pvd0ELtOBZbyqOJHowDA1h9DIYKtu0fr0JXpYqiyowl0fNRPFCGno8r5IC/WimuCA+akRIg5jO9VnrvtQvM/bs5emPK0feTaWisACOiVOTh0+WzYIv3Kh3bvhfKDYEkmeiiLGiGf6goGyThfaARQQyI7qnHJgbFYqSPRLXgEIdqsOnpAXT3AUiT5DP4qBFxh/xM/wXVw0H7+lAKOwi78ZyZWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmEoqZ1OMwDq0drHGBO037AL/4mMoGFktvwtPO93TVY=;
 b=YsIQbFbXWyPbNb930TZvVzrOai4O6bW8s3orOnVMWG+VsEmC7+Alk+G3aCRrjBWseaMLWExVAnPPoqXLlA/+9ynePl/pBkoNw8eaZnLVf+l4BmuV0iV0Cx9JCinchpuEpuHkCxOFiDVMpdTq2NPOBStL5YxIywaJYl2uPSyFKlg=
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9)
 by AM0PR04MB4145.eurprd04.prod.outlook.com (2603:10a6:208:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 01:43:25 +0000
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::4da8:6419:c67:3ec7]) by DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::4da8:6419:c67:3ec7%2]) with mapi id 15.20.5038.026; Tue, 8 Mar 2022
 01:43:25 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Alifer Moraes <alifer.m@variscite.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "eran.m@variscite.com" <eran.m@variscite.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        mcontenti <marco.c@variscite.com>
Subject: RE: [PATCH] input: keyboard: snvs_pwrkey: Add key-release-only
Thread-Topic: [PATCH] input: keyboard: snvs_pwrkey: Add key-release-only
Thread-Index: AQHYMi8jzQ/Pq1n1Nk+pJDS5pnj7say0r25wgAAGeWA=
Date:   Tue, 8 Mar 2022 01:43:25 +0000
Message-ID: <DB9PR04MB8412B8A94B2221D5151A135787099@DB9PR04MB8412.eurprd04.prod.outlook.com>
References: <20220307142442.28206-1-alifer.m@variscite.com>
 <DB9PR04MB84120F45E6F1E283B541FF0A87099@DB9PR04MB8412.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB84120F45E6F1E283B541FF0A87099@DB9PR04MB8412.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bef95816-d620-4e10-39c7-08da00a50988
x-ms-traffictypediagnostic: AM0PR04MB4145:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB4145D3400602F4FBAC12E6C587099@AM0PR04MB4145.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9jY1PYq8e9iPw4GsZYGIMq18YUED9KDymbWUjnTEqF4pOlRXjlXB8RFsi66jo0k5hhjw7xUBzSV0zTVV42PHWplmIDpXAJa3dhQ+Dt7nCyNIWC5wZZrel4VW7KX23VqoTehrg+Devk/S0r5IiF09S7SDg57nf0jVgWugNgpryKM17IwTYAasVv3yMs3q6hp9uPUbL8SB/tnG8+144zUOmyymB0ld6dnNBvy1HYTuVRGuW7T3+Q1p6mCxnpbY66gbD20TL9P7oXwHcO7eHJ5Cn3xUBGtZ/5XBS2T1n/ZcB4jhjqaTelhl/ycElFZHm2RHsDtzA8ZfOpcEm2ctRDVs8MX2GVNwn7Ax/4VmkZGs7z4trrqylIBU0ExycWIbemL3Kopi18+uo9B/KAfjFNKSdNx81h8sGT1rNaTiri7CZ+9mNOxqlQh1HB3BLqMiIqR716PYzlPvm0P5Q6re0eHMchJtguEQeEgA4f4hqmFvoVue24hMrmI16LCMjHsZSdpTykfapoFgONJhD2E210lnkP7JvHv7ZTeKTQnP6zBKZyw61fgTv5vE68jOhb7t/t4ADonehXBX1ipL9xh69HfG8j6wjVPxcZgYNAqSl2CExmN1J/fYQ9BHcd+fqT78GaU6pbxAIhi4e4By+3beujfgz3+e/Ad5l7Ws19GIKi2llzfh9i3ifz5SZUpuqCAbNOsa8BPja1nGINeVLBq7Y2yk4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8412.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(2906002)(7416002)(38100700002)(122000001)(8936002)(52536014)(5660300002)(498600001)(9686003)(86362001)(38070700005)(66476007)(66446008)(8676002)(4326008)(33656002)(64756008)(66946007)(55016003)(76116006)(66556008)(83380400001)(2940100002)(7696005)(6506007)(54906003)(110136005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0RqS3ZnTUV3dHZSSDI1NjRlNlVKSFZVRGtpdW8zTStRdVgwU3F3QU9qRGhS?=
 =?utf-8?B?SzA0eW1LYitDRlZNSDFvc0xreHlscEpYZUVjbW9oMUI1V0JFcXFvV0hqZzhq?=
 =?utf-8?B?NXRHR2ZJUmJsYnhobVIvZjhtdHdjNHE4c1JhSHg0MmJrS0J2eGY3MGR6MW9B?=
 =?utf-8?B?UDd4VkJRYXlOVVExZTB1N29xSVAxTmVWNmNxdmRPUFM5WGNYay8xTGJQZ2E2?=
 =?utf-8?B?akJoMTJWYU9rZk5zdHU1WVJlRUZHS1oxOHJpYjQrTnUydVVtYXZiOXVJQW9N?=
 =?utf-8?B?WGdVZkJEUGZEN1ZodzZ1RTFud2IzUHFlMjI4K3lJWXJhOXk4ZlVMdURlYnRl?=
 =?utf-8?B?N29vUGUwTVZHMzUyZVJlNjhUSnRMU2dkK2o3ZTVNamQ3aFQvMmhJTmJBWGFn?=
 =?utf-8?B?VEc1RG9sZUxxMlJ6NGIrdHhzMFdWbjYyaDlqRmVIZGJhaU9KaElJZXBnaEVB?=
 =?utf-8?B?T3ZscXdTazNtdEt5ODVjeGZ5TXJwT2JEanhxUE03aFdLWjhzc3g3aW9SblFJ?=
 =?utf-8?B?cUNER09rRTRkTzhvZms4b0tBVDdXR3U3Ty8zSTRCKzJKTExVc1VCVGMzODUy?=
 =?utf-8?B?amwxdjR6ellMSVJiWFFjdEt4Vk5OZml5T3JGTU04YlBVVDVpNUh2NmwwZHVr?=
 =?utf-8?B?MUYzeDFydy9YYUdvOElqMlBraXRHSDlJbDJiVFFFVERIaDNFUWtJczJ1R1k1?=
 =?utf-8?B?ZnQrMFI4VUtNeGtPYlRkOWVzcWQvUVh3SUFGd0FVSFF1SnpyeG5vRnJvalpW?=
 =?utf-8?B?S1FsYWo5SDhORHlZR0FJSlpYbUJGYytaSFBqdW9uZ09WcExFUkJrUGVpQm03?=
 =?utf-8?B?bk9qbFowK1BaN0RnQTJSVVVIbnUvRGMvbVoraWp3bDRhK2M3Ymd3OTF4alJk?=
 =?utf-8?B?ZXcxUHZ0RnBrck1taVZ0TDEyQU9QMG5uZGQ5bkR6eGJPQTY5a3RiSkg0a3h5?=
 =?utf-8?B?elQxbjUwaGZDdnpnMEFOYVRYV0ZtejI5UkdCdFU5UVV4RzBBcEh2eUphYjZa?=
 =?utf-8?B?SWdsdjBjMzhBK25pU1BWTzBXcVZQWit2cjNpVjlkcVp2dEtRR3RDNVV4cStw?=
 =?utf-8?B?OW5HVzFnbzEydGdoUTVxSHpKL1RTS0JFa2VGUFUzTkVIa1YrUG4yTWYwZTJP?=
 =?utf-8?B?MmZoQlRqTkV4d2FkL2ZjYmREU2FGK3Z5Rm5kYkE1SkZMRDlmOEQ1K1A3VnVs?=
 =?utf-8?B?d1NQU1luSXNsT0NtTnh6bU9SNmpLTStiQkhwSGZ2NjRGZHpmN01BeFFTYURK?=
 =?utf-8?B?dVFTeFdSNngzRk5QNkkxKzljakhnaDVJR09QTnBxN2trUUUraVJ4dlUxd21S?=
 =?utf-8?B?dEdCT1JtQ01lN2czVWZuUlNheGxDeHIvdEVHQWtjK2ZtalhtaUhyNTRHQ1pw?=
 =?utf-8?B?aitod1ZhdkNUUFZKTFU0aktPZU0rcGlMaHl4MFduRkF1YTFnOHhVdFhSc0lx?=
 =?utf-8?B?Sml3MGlqMU0rcjN4SVFHMFFqNms0d3hqS3crZ3c5WXJ0MGtoclhBWHY2dFpy?=
 =?utf-8?B?dHpmcEt4TzhQbFhmMVBWL1Y3QnRsRzhWYk5Ca25GTjIydmxBc01FTU9YQmI0?=
 =?utf-8?B?aC9WQmJrWTdZRk1DeGtoYW1OQ2h5SStONVBPd3NaK05aVkZIMUVKbk82WUQv?=
 =?utf-8?B?NjIwcmtCRHpmQjZSbWNWVkIxUzQ3TGlNSGNHV1dxUDkvVW5ZellCKzZaUnpS?=
 =?utf-8?B?N2ZzbVZQMUZkS2lqeDFLbWFvVlRGM1o1U3pEREZrd1dBc0UzTk5QbkJRUmJF?=
 =?utf-8?B?MTBBSzdEbEdGUk8zVkhOMlU4bnVmQ2FOSnFGQ0Q1THJ0d2pGRzRvOVJKQjda?=
 =?utf-8?B?ODd5N24wWnFqM3NBUFMxUXBTU3hIOWN6NUhIOXdZRVU5cC9jOUNrSCtOdC8r?=
 =?utf-8?B?dWNDYUc1M1JGenpuVEptUUlKdnJnTGNrTkg0S3hMZmxNS3I4NnN1SGRmZGJO?=
 =?utf-8?B?S2JUZEl4eU8xVnJ0dms4ZTlMcFQwUHN0SnJvc0NCQkpBZWYybTlXczJIMWNm?=
 =?utf-8?B?QWhNQTJlKzVrTW9YV3lmb2F4WW94WU9pN2FFNzUyQW03U1FMYVlsSE1UQ1Iy?=
 =?utf-8?B?VlBDaUIvU3hQdUc4aWJZdkdKOU92elM1UGxmS1g3Q2xJWTIvVHloazRIUi9J?=
 =?utf-8?B?NTUxSllMWjdzanNibzJpUHBJWVBuaDVRZzRrbWcydzBRNEQrSkpGR3kzSEhT?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8412.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef95816-d620-4e10-39c7-08da00a50988
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 01:43:25.4779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N81sPUVZ6GOZdOXbeRhbB54AVoiKMuXR0oTib/WR6lOAYRnVfkHcw0Suql056iOC2mkycG4pPL0/w/GLZET8/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIXSBpbnB1dDoga2V5Ym9hcmQ6IHNudnNfcHdya2V5OiBBZGQg
a2V5LXJlbGVhc2Utb25seQ0KPiANCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIGlucHV0OiBrZXlib2Fy
ZDogc252c19wd3JrZXk6IEFkZCBrZXktcmVsZWFzZS1vbmx5DQo+ID4NCj4gPiBGcm9tOiBFcmFu
IE1hdGl0eWFodSA8ZXJhbi5tQHZhcmlzY2l0ZS5jb20+DQo+ID4NCj4gPiBPbiBpbXg2cWRsIHRo
ZSBpbnRlcnJ1cHQgb25seSB0cmlnZ2VycyBvbiB0aGUgcmVsZWFzZSBvZiB0aGUga2V5Lg0KPiA+
IE5vcm1hbGx5LCB0aGUgZHJpdmVyIGlzIGxvb2tpbmcgZm9yIGEgY2hhbmdlIGluIHRoZSBzdGF0
ZSBvZiB0aGUga2V5LA0KPiA+IGJ1dCBzaW5jZSB0aGUgaW50ZXJydXB0IHRyaWdnZXJzIG9uIHJl
bGVhc2UgdGhlIGtleSB2YWx1ZSBpcyBhbHdheXMgMCwgc28gdGhlcmUNCj4gd2FzIG5vIGV2ZW50
Lg0KPiA+DQo+ID4gQWRkICJrZXktcmVsZWFzZS1vbmx5IiBib29sZWFuIGR0cyBwcm9wZXJ0eSB0
byBhZGRyZXNzIHRoaXMgaXNzdWUsIGFuZA0KPiA+IGNyZWF0ZSBib3RoIGtleSBwcmVzcyBhbmQg
a2V5IHJlbGVhc2UgZXZlbnRzIHdoZW4gdGhlIGtleSBpcyBhY3R1YWxseSByZWxlYXNlZC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEVyYW4gTWF0aXR5YWh1IDxlcmFuLm1AdmFyaXNjaXRlLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBtY29udGVudGkgPG1hcmNvLmNAdmFyaXNjaXRlLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGlmZXIgTW9yYWVzIDxhbGlmZXIubUB2YXJpc2NpdGUuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2kgICAgICAgfCAg
MSArDQo+ID4gIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvc252c19wd3JrZXkuYyB8IDIxICsrKysr
KysrKysrKysrKysrKysrLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9p
bXg2cWRsLmR0c2kNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRzaSBpbmRleCBk
MjdiZWI0N2Y5YTMuLjk4MTFlNmJmZDhlNQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDZxZGwuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZx
ZGwuZHRzaQ0KPiA+IEBAIC04NDUsNiArODQ1LDcgQEAgc252c19wd3JrZXk6IHNudnMtcG93ZXJr
ZXkgew0KPiA+ICAJCQkJCXJlZ21hcCA9IDwmc252cz47DQo+ID4gIAkJCQkJaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gIAkJCQkJbGludXgsa2V5Y29k
ZSA9IDxLRVlfUE9XRVI+Ow0KPiA+ICsJCQkJCWtleS1yZWxlYXNlLW9ubHk7DQo+ID4gIAkJCQkJ
d2FrZXVwLXNvdXJjZTsNCj4gPiAgCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICAJCQkJ
fTsNCj4gDQo+IGR0cyBjaGFuZ2VzIHNob3VsZCBiZSBpbiBhIHNlcGFyYXRlIHBhdGNoLg0KPiAN
Cj4gQlINCj4gSmFja3kgQmFpDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQva2V5Ym9h
cmQvc252c19wd3JrZXkuYw0KPiA+IGIvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9zbnZzX3B3cmtl
eS5jDQo+ID4gaW5kZXggNjUyODY3NjJiMDJhLi5iNTU4ZTZmODk4ZmEgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9zbnZzX3B3cmtleS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9pbnB1dC9rZXlib2FyZC9zbnZzX3B3cmtleS5jDQo+ID4gQEAgLTY2LDYgKzY2LDIyIEBAIHN0
YXRpYyB2b2lkIGlteF9pbXhfc252c19jaGVja19mb3JfZXZlbnRzKHN0cnVjdA0KPiA+IHRpbWVy
X2xpc3QgKnQpDQo+ID4gIAl9DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBpbXhfaW14
X3NudnNfY2hlY2tfZm9yX3JlbGVhc2VfZXZlbnRzKHN0cnVjdCB0aW1lcl9saXN0DQo+ID4gKyp0
KSB7DQo+ID4gKwlzdHJ1Y3QgcHdya2V5X2Rydl9kYXRhICpwZGF0YSA9IGZyb21fdGltZXIocGRh
dGEsIHQsIGNoZWNrX3RpbWVyKTsNCj4gPiArCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0ID0gcGRh
dGEtPmlucHV0Ow0KPiA+ICsJdTMyIHN0YXRlOw0KPiA+ICsNCj4gPiArCS8qIGludGVycnVwdCBv
bmx5IHJlcG9ydHMgcmVsZWFzZSBvZiBrZXkgc28gZG8gbm90IHdhaXQgZm9yIHN0YXRlIGNoYW5n
ZSAqLw0KPiA+ICsJc3RhdGUgPSAxOw0KPiA+ICsJaW5wdXRfZXZlbnQoaW5wdXQsIEVWX0tFWSwg
cGRhdGEtPmtleWNvZGUsIHN0YXRlKTsNCj4gPiArCWlucHV0X3N5bmMoaW5wdXQpOw0KPiA+ICsN
Cj4gPiArCXN0YXRlID0gMDsNCj4gPiArCWlucHV0X2V2ZW50KGlucHV0LCBFVl9LRVksIHBkYXRh
LT5rZXljb2RlLCBzdGF0ZSk7DQo+ID4gKwlpbnB1dF9zeW5jKGlucHV0KTsNCj4gPiArfQ0KPiA+
ICsNCj4gPiAgc3RhdGljIGlycXJldHVybl90IGlteF9zbnZzX3B3cmtleV9pbnRlcnJ1cHQoaW50
IGlycSwgdm9pZCAqZGV2X2lkKSAgew0KPiA+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
diA9IGRldl9pZDsgQEAgLTE3Nyw3ICsxOTMsMTAgQEAgc3RhdGljDQo+ID4gaW50IGlteF9zbnZz
X3B3cmtleV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJLyogY2xl
YXIgdGhlIHVuZXhwZWN0ZWQgaW50ZXJydXB0IGJlZm9yZSBkcml2ZXIgcmVhZHkgKi8NCj4gPiAg
CXJlZ21hcF93cml0ZShwZGF0YS0+c252cywgU05WU19MUFNSX1JFRywgU05WU19MUFNSX1NQTyk7
DQo+ID4NCj4gPiAtCXRpbWVyX3NldHVwKCZwZGF0YS0+Y2hlY2tfdGltZXIsIGlteF9pbXhfc252
c19jaGVja19mb3JfZXZlbnRzLCAwKTsNCj4gPiArCWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wo
bnAsICJrZXktcmVsZWFzZS1vbmx5IikpDQoNCkFuZCBmb3Igb2xkZXIgaW14NnFkbCwgdGhlcmUg
aXMgYSAiZW11bGF0ZS1wcmVzcyIgcHJvcGVydHkgdG8gaGFuZGxlIHRoZSBzaW1pbGFyIGlzc3Vl
Lg0KV2h5IGRvIHlvdSBuZWVkIHRvIGFkZCBhIG5ldyBwcm9wZXJ0eSB0byBoYW5kbGUgdGhlIHNp
bWlsYXIgdGhpbmc/DQoNCkJSDQpKYWNreSBCYWkNCj4gPiArCQl0aW1lcl9zZXR1cCgmcGRhdGEt
PmNoZWNrX3RpbWVyLA0KPiA+IGlteF9pbXhfc252c19jaGVja19mb3JfcmVsZWFzZV9ldmVudHMs
IDApOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXRpbWVyX3NldHVwKCZwZGF0YS0+Y2hlY2tfdGltZXIs
IGlteF9pbXhfc252c19jaGVja19mb3JfZXZlbnRzLA0KPiA+IDApOw0KPiA+DQo+ID4gIAlpbnB1
dCA9IGRldm1faW5wdXRfYWxsb2NhdGVfZGV2aWNlKCZwZGV2LT5kZXYpOw0KPiA+ICAJaWYgKCFp
bnB1dCkgew0KPiA+IC0tDQo+ID4gMi4yNS4xDQoNCg==
