Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53374D9AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbiCOLxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiCOLww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:52:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F255F506E8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afYpSFlehUVKy79FUYwbOMEp1n7+qZC+z7Si148Fd1TWFCuxGE6Fwsr/yBommLrn7ElAeNGMe3IPDD8SrrgtSQaBloupHq9p2+qH3sNsONFPkNfUIYmaLkiPwXj5kgkknMUsbx+BshR2cvv43/9RgHzvhzAGbc1DHvHsfIqmqp5HtGUNORlJI9LzNdGQs6wDaKCrsMRWDF6zM7ZMPMfSCECmS9GaOsWntYJxpg6wLAl1x8RKLcypcGGmwtdvR6Cc7UmOJzzlA+w/9t1Q5RO0efaF7uBUm34HL7cLmYilv2IrC7LTNwNyhOBj4xQB0MtFFUmCHg6Wa1TeRJQkXELu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qH+7OiKsykV8oujrtmcFqCAosR+Eum8G16LYl9HNIQ=;
 b=CtPv37Fug+0NBoM45DWiDbtELCbia3G54mvK55suH02y5ckqiTs3627fxESEUKaCKloZ4DGalfd/aV/chepcmuds5OunzgBxxhRnywsGgKWoDu9EYMxrrLCJeowVUJPlq9Eya3AGoIzCqqVgpR96IcmShkpMn6Gvy3MaeoGM9pso1RiX2F/AfpzmTvdAHYvR5VoVNnqtVMbIPcCLvqdTmot+1bJtiH4snzFn0XYzpD9wP2p8ixKVKOiDukGxuPOOGpMLf5S1WRGE3fV2oNGpT222MUIJLcCnEeorK+kxorhG5kd5Zqy5kG8pwzdu2fJrcEaO0CVqQ7GVZxI6nH0JxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qH+7OiKsykV8oujrtmcFqCAosR+Eum8G16LYl9HNIQ=;
 b=df97swGKKnn9CvCasrUt2DvaRHWFR3KcG+I/rojy2wvQi6rgQ1Xky5TU+3rKC3ckRSpZyeXIQ7jEfgvj0fLVM2onGPXhLrkAwY+4N8GnZAR7p+c9lKukZWJX37JEaZLMzDNjl+goXj4DLp785GJAgLMVTQaMPDy8B05jiWGcFyY=
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by AS8PR04MB8532.eurprd04.prod.outlook.com (2603:10a6:20b:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 11:51:38 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::1c10:3051:5818:abaa]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::1c10:3051:5818:abaa%7]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 11:51:38 +0000
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] uwb: nxp: sr1xx: UWB driver support for
 sr1xx series chip
Thread-Topic: [EXT] Re: [PATCH v2] uwb: nxp: sr1xx: UWB driver support for
 sr1xx series chip
Thread-Index: AQHYOF2S/adWZILwzkm3LHzIkI3W/qzAUe6AgAADY4A=
Date:   Tue, 15 Mar 2022 11:51:37 +0000
Message-ID: <d287a161-70ec-eb45-2d29-f32fff29f252@nxp.com>
References: <20220315111227.2388583-1-manjunatha.venkatesh@nxp.com>
 <YjB68RMXRRZqQI8O@kroah.com>
In-Reply-To: <YjB68RMXRRZqQI8O@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0b1e799-7aaf-4c5d-478c-08da067a29a2
x-ms-traffictypediagnostic: AS8PR04MB8532:EE_
x-microsoft-antispam-prvs: <AS8PR04MB8532B8E060051E0C56C1D4B28F109@AS8PR04MB8532.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8cbVsSkqMOaFKooUr8vmTu7C+yyNyhAWw9LMawTlzx4TTIM9ljjO/vWigYONNqdA066MidtDd5U9xNl8GyGtTC0bE59d28uKL5WNxjkTW8L1ayyidpveg+nkdaRrVMqFSkgx7QMlDiYOvFU+73x/xbA1SpebQwRLUkWsTVEyIb0HUVIb9MBofLtkTfXhDgRIsLHC9gVq0ELWEZ8wXYTBFwPXGZlqdortjedtpe4GEmKjkmSZLnig5cplipziR22POBJSCFEf1wphVdjab+u41POOfmg8oT/BQArpX65LnSjrT7v+kVsiqxdD3jJJiDYuSbcs3bM2WM3hDLU4RIJsjiPxnMOv4LDL2vewTBLTAejLIbYpOl/oYhBmzAP/fUFwuFzP4kpn3xlc2C6Ghl8wn4VNWRY4pLjvRmOmOHYbdNx40ElsTMtqdygyzlU+TabNTaDerSpR6bp/T3ttdU8xi61YJHmwJyQLFRartVb9ZLiT5KDQWPFewKVTYIeSnbSFbCrz+HfgQk2Hl/NhApWc13k+gLU0KrHUIBki18lxHg6U8CYkKJhn3h7Ws7PO33Rna8lgiYhzDlohS+2cleiXlppRLJZ9VqD3RkrlS8bypPiaiK3akBlyRI6MOhd+Ui3lEo+U0N0TLW57KZEi/bS1URq3keErHAGrPcPMu/Hv1fa/cr4p9XPuGzf++hjXgypHHVmzCjcPLhpCRz5PIAYsb2UjT7c3Tvu9FWqsJYJD6FrPcVhCguTZidjeJixtG/9dyHEJIfcIjAAQ0QJnttz5yQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(91956017)(4326008)(8676002)(66446008)(66946007)(76116006)(31686004)(66476007)(66556008)(5660300002)(8936002)(38100700002)(36756003)(6916009)(31696002)(122000001)(54906003)(38070700005)(86362001)(7416002)(71200400001)(2906002)(498600001)(4744005)(26005)(44832011)(6512007)(53546011)(6506007)(186003)(6486002)(2616005)(55236004)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S050QjNVbFN1Y3IzOTFNOHE2Z0h6dGhOdDdBdVFWL2FCb2YxSFJSQU85cFlv?=
 =?utf-8?B?L1p1S3RSS2M2NXo0dmhjb0oyQUdTVXpsb2RRbHhXb2Q1UVVCODZYcWNvWmFs?=
 =?utf-8?B?a1B4NlFoZjN3WEE3MTdVRjMwTXF6c25UWUhEWTZMQTR0a3lzMkhrWjRkcU9Y?=
 =?utf-8?B?VXdXYjVZbHd2aCtlNE1uRkw0b01JaTBSWnliMmt3U3pBOXNHNGlUanNUWUV5?=
 =?utf-8?B?YmQrNmxnOGhRdDNHSzJ3RGQ0LzhUWGpLSnAvSjBKZ0ExSi9RVjBqakZmYkwz?=
 =?utf-8?B?WWVBS0RFMGFnVDJOQm9lVWhnbkNnNWJSUnd6VXJiMlJQS1ZDeGVOL3JyV2pj?=
 =?utf-8?B?MXJUQ1dibk52bDFpaCsyRlpxSC9BdDVzNTE4cGw4MTZUK0tFeWJ4Vm5PekRB?=
 =?utf-8?B?Q1AwOVRVVkdvY0hsNW1Mb2t0ZUJOT0VvVlBINTEyNmpvNHpnSXhsNzc0b1VV?=
 =?utf-8?B?RzhmcEhDMGFxVTFBMjdxYTRkd2ZZbWlvdUFzbnNnZituVEFkZytOcCt6ZUUw?=
 =?utf-8?B?cmpsNEcxUmVWRkJNWHE0SnJvQ00yaUVxYzA5OWZsdnhoWEJ3SUd4VWJSajZU?=
 =?utf-8?B?MFN1eGx4YitUWEwvRUllVUhLUXlwcW1qV3BxQTNFWjAvWmRvaDE4NWJObGZs?=
 =?utf-8?B?ZzBoL2xGNzBOVlg2N2hONjFlbk1qS1JTWTZ3SmJCb1NWSXpvZitGQkMrcE42?=
 =?utf-8?B?N1d3M0JUaUU3ZWY2akFQclk1bE1Oa2NQZFh0M3N0NnVTRmR3UUNIRkY2eE11?=
 =?utf-8?B?VHF0bDNnZk9LS082c0V0QXY0OWtHSGZQK1JZRkYzSlNZT0J2SExxajV4M0FG?=
 =?utf-8?B?TERJbmxQZkUyWHA2VjUyamprTGFhUEdVTDkrTkpoeEdpamVnVXR5SEp5aU9q?=
 =?utf-8?B?TVkyaDF4eWdjUE5ZWGZ6NzhleEFqUWdQNVR3SC91bEF3b3ExSXJRVno4MzAr?=
 =?utf-8?B?aUdKT3RPTURFRWt2M21qTDAvSXYyQlFwNzlzdzFjR3QwYkhDbWYyelBKUWxZ?=
 =?utf-8?B?TndwTG4ycVlBTzBWUkJaMzhnd29Ma0FtNTE3NndFdWhWV20wTnREVFpiUWhU?=
 =?utf-8?B?RUVpRVM1WU5XWnBnMlJtZDZzbzM1WHlCTmNFRkUxSVNkeXdPY25TMlVGdWFK?=
 =?utf-8?B?MU4rSlVHQ3R2NWF1TzZuUllEQUVEQkY1WmdNUE54UnhGTXJ1TGR4a2FvQ1Jp?=
 =?utf-8?B?ZWE4RjVzdTBZMXVSOXRJNEhRQ00wVHNkVTRIYVdzdHExSllrb2JvYXhMRGpJ?=
 =?utf-8?B?bWRORHpLdUVkSVVDeG4rR29zZDBCTzhkT0Q1VFVhWFYzbkhGWHlyTUtxQnRN?=
 =?utf-8?B?UUlyWkJLVzJ2VDZIMHUvUzRlSmVDMWdFUlhMM05BaWFKcWthUzBOQk9IWGpE?=
 =?utf-8?B?RklnUjVPSEt5RFg2dW9NeGp3NVNaS0kzNWVxUUw5N0k2eUhqV3g0clhNRDc2?=
 =?utf-8?B?eXVENVlPR21LWFQwSnQ0a2xpUWRDTzNnbmM4STJZZ3BRbHo2RGpxMmVhQ3o1?=
 =?utf-8?B?TUhlYWtrRzhlVTFhOWZ4Q3ZrNGFHUE9nNmNpejlXelZaN3l1OGVQOTVHdEU5?=
 =?utf-8?B?VEpXS25wVWV3MzhmT1pyQ29IVnl1Vk1xeC9QUzkyc09WQzc2OHAraHJ4UitC?=
 =?utf-8?B?Q0RYM2k0UkUvaGowSW9OWEF0RCtmTzBKOE9uTHNQTGxxZmR5QXFkSm9IblVY?=
 =?utf-8?B?RHZnSDExMExmQStqdTBnc2R4OUJCUE45UTlBNkhQMTdtS2hCcVl4YXl0ZkhV?=
 =?utf-8?B?NDlXaWIrOUphQll4MXdCa2VlYXZ1QWd6dyt0Y012SG5QY081aTFhNHpEU2xL?=
 =?utf-8?B?MjFiMy9NVmFRZ3IrUHRLTHNnVU9zc052bHNaUkNFL0xlSWU2K0IyQStPbCtr?=
 =?utf-8?B?TWlnaVFQb0RmVWJ6elExSUswczArS3RLOVJXMkxoQ2ZiNmk5WWF4S0M1cDlk?=
 =?utf-8?B?eVl2bzRJdEt2MjJoRzZrOWwzNDd5a1Fiam16bVFzUnpCOWgrWWgwSzcwZWl3?=
 =?utf-8?B?Z2l0NHRoZTZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <196080FE3DA36148A8FE09101385E088@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b1e799-7aaf-4c5d-478c-08da067a29a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 11:51:37.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SDfWMGSN2DixHRU2CfeekD6S+3rpYVlBalMzi/4119Cxaid42BV8PnwUG6Syt5+7CZI7LPc4XfJqkGoYelo8+9qC1eAU0BxbRyzuGIKpq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8532
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8yMiAxNzowOSwgR3JlZyBLSCB3cm90ZToNCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+
DQo+IE9uIFR1ZSwgTWFyIDE1LCAyMDIyIGF0IDA0OjQyOjI3UE0gKzA1MzAsIE1hbmp1bmF0aGEg
VmVua2F0ZXNoIHdyb3RlOg0KPj4gVWx0cmEgV2lkZSBCYW5kKFVXQikgaXMgYSBmYXN0LCBzZWN1
cmUgYW5kIGxvdyBwb3dlciByYWRpbyBwcm90b2NvbCB1c2VkDQo+PiB0byBkZXRlcm1pbmUgbG9j
YXRpb24gd2l0aCBhY2N1cmFjeSB1bm1hdGNoZWQgYnkgYW55IG90aGVyIHdpcmVsZXNzDQo+PiB0
ZWNobm9sb2d5Lg0KPj4gSXRzIGEgc2hvcnQtcmFuZ2Ugd2lyZWxlc3MgY29tbXVuaWNhdGlvbiBw
cm90b2NvbC4gSXQgdXNlcyByYWRpbyB3YXZlcyB0bw0KPj4gZW5hYmxlIGRldmljZXMgdG8gdGFs
ayB0byBlYWNoIG90aGVyLg0KPiA8c25pcD4NCj4NCj4gV2h5IGRpZCB5b3Ugc2VuZCB0aGUgc2Ft
ZSBwYXRjaCB0d2ljZT8NCj4NCj4gY29uZnVzZWQsDQoNCg0KSGkgR3JlZywNCg0KU29ycnksIHdo
ZW4gaSBoYXZlIHNlbnQgcGF0Y2ggZmlyc3QgdGltZSBpdCB3YXMgbm90IHZpc2libGUgaW4gTEtN
TCANCmFyY2hpdmUgbGlzdCBhbmQgdGhvdWdodCB0aGF0IHRoZXJlIHdhcyBzb21lIHByb2JsZW0g
YW5kIHJlLXNlbnQgdGhlIA0Kc2FtZSBwYXRjaCBhZ2Fpbi4NCg0KUGxlYXNlIGlnbm9yZSB0aGlz
IGR1cGxpY2F0ZSBwYXRjaC4NCg0KPg0KPiBncmVnIGstaA0KDQoNCg==
