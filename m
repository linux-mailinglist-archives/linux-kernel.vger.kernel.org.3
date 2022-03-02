Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DBF4C9D0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbiCBFPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbiCBFPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:15:35 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8F9B16C7;
        Tue,  1 Mar 2022 21:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1646198083; x=1646802883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yVKpXR3Hmsfh9FABN7IfKMDJXqjqPrUHtl12AsuWFkg=;
  b=2RDQ/w9sqKlNFTYXdLNDQQJrgBSF90lKam4XT/UV2IOhp5sjRz7Jkxml
   u8SSukXFXX7Oe93r+UFAuUebdpBmp5Fr8Tbju+VIUgK04E8VG8CiYzJlj
   gfF94Sz+BEjEltcJPPKpiYZaXyWRiUYav+8ID8IsZr5F8/+utfnAHJcTB
   M=;
Received: from mail-dm6nam08lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 05:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSjGaQSPdbrPLuY+cR/0Pr+em07ucEv9Y5T5031jq38sqy0j0f9gBasZgQXegk+dF9aa4bVJoAWrwIi8UwJ+mQbB4vDhqaAvanzwjAnMdOCPgHY3kYJSZ9apGuW5neccrJGe5vcQJZ2O1B82zLFToCZxv8XeABp/T9eAL+XUSEAEbb/Zq6k60ITd3TmIE/xGKk7UhKMJShWF+9GEZjl0hvwpZ55eFPXzp2uevRAZjZAccARrNAUF+8IwNeLHt+I1GIuVFKVXaJaVxiTFGUMEKUerwxbf/T9N+3W2evilQmgCG1dUUjERdBEKHWYPxxybFsDDy2UDDsgWpsmb3yA+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVKpXR3Hmsfh9FABN7IfKMDJXqjqPrUHtl12AsuWFkg=;
 b=EJXGnDpE/xGpF+O7Lt7zRCEK3lgwqZ4AKMmZbNVpDYWGgRb0b3rUETrXQIj9SNAupgu+HostuDhHYczvcqNgIW99LQThn+a6KwPl/r1ms5oYbaeOGaacWW4I0bSOsESz1+Qp7pq4VoXmOLfFeBeyCkHcTHupLxcMLqKrKg6Hg955bY1Ui4Pvyb+F8acRhAy+66eoaz0KbZkLfZsEYPv+0mGVavg8E+q/lg0JJDqhIW1LjoY4nbsuetp8efe1c8WaHcaDcDetw+OOL5RMwdpcWz2pB0w3256q460TrwtnUttQ5wAPYyV6kYyEZ5FkW9xuSDO5Gim2NCupFDm7q/uuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM8PR02MB8198.namprd02.prod.outlook.com (2603:10b6:8:4::7) by
 SN6PR02MB4829.namprd02.prod.outlook.com (2603:10b6:805:98::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Wed, 2 Mar 2022 05:14:31 +0000
Received: from DM8PR02MB8198.namprd02.prod.outlook.com
 ([fe80::a02f:fdb9:de98:d75c]) by DM8PR02MB8198.namprd02.prod.outlook.com
 ([fe80::a02f:fdb9:de98:d75c%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 05:14:31 +0000
From:   "Linyu Yuan (QUIC)" <quic_linyyuan@quicinc.com>
To:     "mka@chromium.org" <mka@chromium.org>,
        "Linyu Yuan (QUIC)" <quic_linyyuan@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Tao Wang (Consultant) (QUIC)" <quic_wat@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "ravisadineni@chromium.org" <ravisadineni@chromium.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Subject: =?utf-8?B?UkU6IOWbnuWkjTog5Zue5aSNOiBSZTogW1BBVENIIHYyMCAzLzVdIHVzYjog?=
 =?utf-8?B?bWlzYzogQWRkIG9uYm9hcmRfdXNiX2h1YiBkcml2ZXI=?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFJlOiBbUEFUQ0ggdjIwIDMvNV0gdXNiOiBtaXNj?=
 =?utf-8?B?OiBBZGQgb25ib2FyZF91c2JfaHViIGRyaXZlcg==?=
Thread-Index: Adgm6oYwULNX5ZnjSBCBUX6aFc31LAAADyHwAFiwVAAAH4sXgAAAiy2AAOBepDAAMTAMgAAAYDMQAC3hmwAACcEx4A==
Date:   Wed, 2 Mar 2022 05:14:30 +0000
Message-ID: <DM8PR02MB819876BA541F3C62D971EF09E3039@DM8PR02MB8198.namprd02.prod.outlook.com>
References: <SA1PR02MB86067ACF0C96F18B7306D208903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <SA1PR02MB860660B6F33011E5A97F7930903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhURQAksLKVuzU36@google.com>
 <SA1PR02MB860602E0AC4D9BD0BC4245B5903C9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhXolQDwIMbTi/O2@kroah.com>
 <DM8PR02MB81988555CA6B66BB3FD5E488E3019@DM8PR02MB8198.namprd02.prod.outlook.com>
 <Yh0UZUU9/9Hd6Pc1@google.com>
 <DM8PR02MB8198F2BFE9E933CC8F2C148BE3029@DM8PR02MB8198.namprd02.prod.outlook.com>
 <Yh5K0u3jp4jTXCPi@google.com>
In-Reply-To: <Yh5K0u3jp4jTXCPi@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 331a41f4-d23a-4732-f62a-08d9fc0b884e
x-ms-traffictypediagnostic: SN6PR02MB4829:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB48297BAE532B200BBE71B6809F039@SN6PR02MB4829.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u58BDC6Mi6iz1Ta8OkabIJF0dbVaRCPXZXiwrOhn9RqocYOlFslfSwubax+mGlT9ueQ+4zGWYYX+hNHvZYWagu0XAupdwLB6wHUOxEoTxBFqeGt4hq1+VayGZi/Ef80mMgkADlxq9TlnuURkO2oe2FcmwyBwjNVylbz266fcG+Lw7FlojERpmsX/TH7uwtQjqa+IJJjsRxKRh7qeXRioafwlq73sfj2bk8qopU1l6X0vsCh5Yi8X8zcyCC856knH4F3mdyLSVR6gl3q/jCn6ugCKq3deXAo9wQpYOyuqYWxO5qmmxC7Dlwq3D9USVL5ZdKvRWEttIet0fR4+FJhZgqLmrCRKd0bdNiJ/eRkBwMsniGI539QNE3/+JMmEKthsMSaf59z3LQzMIpBZu2vZ/1GDzxLYvIl8aBZcnfMyaTiqezUvfYl152GP+lO2HY7qLPhGrDBAzcj5zKlaPAAx81mhA5GDBHgmJh8IXI1rfpaNuZo2VdeX3qvZX8ok0toJZnZ6skJnDe8RKOieSihN10FeRBgohY/p+TRek+qUGbIh4XVPwHQzNjZiRa6np7GDU3vIPhizHOdw+ijCbHg/0TB5fiQNMvB6BhcNg4MQeWw/OVjSOh2pNA5CJGkTRJW9cfoo4RPbYthQ7MJwZSlINavNC/V/QDAPPZH+mIFeSuZhJvi+3/L0S97+mT6NRN2uuZqhEdeH9chx50TfYGYdtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8198.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(64756008)(66476007)(66556008)(66946007)(66446008)(55016003)(8936002)(38100700002)(224303003)(2906002)(316002)(110136005)(54906003)(26005)(186003)(4326008)(71200400001)(86362001)(76116006)(52536014)(38070700005)(5660300002)(122000001)(9686003)(53546011)(6506007)(508600001)(7696005)(33656002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emJaRXJDN1R2VlhHaGlsZmI3TWNVQmVTMmh4TUdVUjNReFlqbTZleWR2aUpM?=
 =?utf-8?B?cGVTOUJSQmFQcXhrSjNVUWY4bjQ4M1dNSnBONnd3WnF3ZTVxc2pEZDhBZVZi?=
 =?utf-8?B?UThhSzNJclNBb3p4SHNQTFV4MHMxMzRNR2s5c1BHZ3VSaVBsVDNjZmZ3dVh3?=
 =?utf-8?B?bXhob1dxZzNsYWVGMWdUcENVQU5RTWQ4eEE5QTIyRm9WK3dHbUtLV09hS0Fh?=
 =?utf-8?B?cWFPVjNnWFY5TjdtVFp2K0pYTWNNWjg0clRHQ2sxMXdkVlhZY2lRNGZ3WXhv?=
 =?utf-8?B?UnlBbWFvTXY0RGZhcDRaN25QbWQrZjFPU2RTOE1pbEJWam9VMjVUR3JyM0NQ?=
 =?utf-8?B?TnEwQzNZZDUxekwyMzc5UkJ1Z0pDUlg1MjR4c0FhM3JTVDZFVWYzbUgwc3l5?=
 =?utf-8?B?WWRDZE1zbkJZdi8vaUV3V2VjdzNzOEJZbkIrV3AwM0ZweFY5bWFhaVlmTWIz?=
 =?utf-8?B?ZWYzKzhYL0pRSnZoV3c1K3VvTTVPaEtPQXAwTmNTRmJpOHVDYy9RKzhVZG9h?=
 =?utf-8?B?WTczZStYOTVGNHNxSmduaDRLMUVybUp2Z2NqODBUbUNuVERRVEtRNHJWd1Rt?=
 =?utf-8?B?MFJzRnJuQm1XcVl3OEY1UlFKTVJQbFVYTEp0SGFqNlovencrOGJzbXZtdzQz?=
 =?utf-8?B?T0FnN1ZpT0UyUzdUZzV3QUhpR1BvTVNOZ0ovZXpjWGlKL0tabXU0eWtDZGlJ?=
 =?utf-8?B?djI3M0JZL01WSnp2dnowdlc3VWtrampDMEFGUmVqRi83ZmJrREg3Qmk3QlNW?=
 =?utf-8?B?M0gxdjM3eEdpeDBUemc1bXlLdDZnbUp2OEx5Z0Jybm5QRDNJKzc1NjZlTjVa?=
 =?utf-8?B?ZTFkN0psRG5oSW5yVjUyeWRtNU93SUsrMlJOZXhiNC9WRStKaE1jcGRHTXdr?=
 =?utf-8?B?L3hiVVRYem1yT010LzkvNnF1RGgwZ2lyalFIWjZmTnVLbXJqUXdPV0ppeTBE?=
 =?utf-8?B?Q1crSFc3aDV0Qk80Q3lKSmE3a3lWZmhtR1gwOVlTTVJFRmFXVHpqUk4yaXpI?=
 =?utf-8?B?SzdKblgzNUY4TXBQQlBJMUMzK0dSSDlqNURhVXgwYzFDQXNwT1p0QmFLYitX?=
 =?utf-8?B?dWVUQVA3WmJDaGk0UmZnTTgyNXk1MlNpb05hVUFiUzFqYnFDNndjejkvTXpB?=
 =?utf-8?B?b1c1MG9Bdjh4SXhKY0txM2lHcFFxSlZrZW5xNmRYeXF4eGxWUjVQdExmb1lB?=
 =?utf-8?B?d2t2UUNHT29tcWFiRFIyWnhPbXJSTUZzL25oNGhhbTZkQ1pXQTA5b1BtSjM1?=
 =?utf-8?B?enN4bytvR3l5NzN1MkcxZDdUQkMyK3lNNWJBYXh3WUFydWdSOUNYcUtQc3Rq?=
 =?utf-8?B?enFVL3ZWNG5vcmRaN3FrZ0k4d1Frd2VjZlJkMGp1Mm9KZ1VoTlhoZThoVDkw?=
 =?utf-8?B?SjhNUlFmZzJqekFIMzRHQ2p4cndpTzZLem84T25IbnJPUTV0eDh2TjZJaVRj?=
 =?utf-8?B?b3VmMnJWZld2ekdhTXhWK0ZoZDJTQjNxNmpmcEFqWEMwKzgyaW02TGhyN2tR?=
 =?utf-8?B?bmh3SzhWNVJYdnNzTmtoVGhreFA5Q3IvMCtGc1Nmd21OaVdsOFZYcXJMakdp?=
 =?utf-8?B?VVJyTzY5OFRPaGFSRHd6Qk9ZaDJ6cWY4akNBQ2puQVJKUVBkcHZKRXBCWm9P?=
 =?utf-8?B?aTVkaWhXYmZkUysxT2ZOdThNZzFONVlhWmJuRkgwY2FjWDZYL1RUK2tEMmVK?=
 =?utf-8?B?amdCdGQ1UFIwc0dqYmsvTGhEcUN1SEI5NEpXZmdSNnpIclA5RmFlbi85d0Iv?=
 =?utf-8?B?S213R01HU0NjQ0xMaW1EZng1VEU4Q3g4bFdObzZNYUJxejdLTXZYN0ZRWVR0?=
 =?utf-8?B?di9hS3dwSitZbVpjOTh6Yk8rNDFpNUROUkh1TDFKdHRUb2xBZThYekpyeENj?=
 =?utf-8?B?YlVGdnEzQ0M0MlJrZzRtTm8zbnN6bHpJN1NhL0l6ekRCTTJNV1QySzNmNWNy?=
 =?utf-8?B?UWFHcGszdUYwK2d2ZFcyUFVFSmZpekJ5d0VrLzI4cjU4VzFkTUtLRHFSOGhr?=
 =?utf-8?B?SW1vdVc1WEtwKzRZOE5wc1BoQlZqSG9hQ2RjTktGOXJDNDY3T2IvMFRJcndt?=
 =?utf-8?B?RDJIbmlYZmZjcGtEYzA2K3VPc1BnY2ZFZnhFUWZ0ZklDM1BURTVJb083eFlk?=
 =?utf-8?B?UHB6YWVtVUxTUDBEK2VWZVByc2hhM2pVVzl0ZEdXaFlJSFNwK29HR3lVY3pV?=
 =?utf-8?B?cmpTZ0QrbzEyVDN5ajA0TkhjZjFRbG5LQ1RuVVRPRHpjbjJRWGp3a0t4djk4?=
 =?utf-8?B?aThBR0t6cmVXWklBbzFtR2RqSHNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8198.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331a41f4-d23a-4732-f62a-08d9fc0b884e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 05:14:31.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Leb2w7o1m3CoNxXNtJGgDjWYPopE+iYDDPgVTxBE3aW5gvfGjq15Hx+mJDoBnIuNjl53h13cAnVXPq0O+IwM/Hej9zSN6GbYgXB14KXEo2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4829
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBta2FAY2hyb21pdW0ub3JnIDxta2FAY2hyb21pdW0ub3JnPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE1hcmNoIDIsIDIwMjIgMTI6MzMgQU0NCj4gVG86IExpbnl1IFl1YW4gKFFVSUMpIDxx
dWljX2xpbnl5dWFuQHF1aWNpbmMuY29tPg0KPiBDYzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc7IFRhbyBXYW5nIChDb25zdWx0YW50KSAoUVVJQykNCj4gPHF1aWNfd2F0QHF1aWNpbmMuY29t
PjsgYmFsYmlAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRpYW5k
ZXJzQGNocm9taXVtLm9yZzsgZnJvd2FuZC5saXN0QGdtYWlsLmNvbTsgaGFkZXNzQGhhZGVzcy5u
ZXQ7DQo+IGtyemtAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtdXNiQHZnZXIua2VybmVsLm9yZzsNCj4gbWF0aGlhcy5ueW1hbkBpbnRlbC5jb207IG1pY2hh
bC5zaW1la0B4aWxpbnguY29tOw0KPiBwZXRlci5jaGVuQGtlcm5lbC5vcmc7IHJhdmlzYWRpbmVu
aUBjaHJvbWl1bS5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gcm9nZXJxQGtlcm5lbC5vcmc7
IHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU7IHN3Ym95ZEBjaHJvbWl1bS5vcmcNCj4gU3ViamVj
dDogUmU6IOWbnuWkjTog5Zue5aSNOiBSZTogW1BBVENIIHYyMCAzLzVdIHVzYjogbWlzYzogQWRk
DQo+IG9uYm9hcmRfdXNiX2h1YiBkcml2ZXINCj4gDQo+ID4gSW4gbXkgb3BpbmlvbiwgaWYgaXQg
bmVlZCB1cGRhdGUgVklEL1BJRCB0YWJsZSBpbiB0aGlzIGRyaXZlciB0byBzdXBwb3J0IGENCj4g
bmV3IEhVQiwNCj4gPiB3ZSBjYW4gcGFyc2UgVklEL1BJRCBmcm9tIGRldmljZSB0cmVlIGFuZCBj
cmVhdGUgZHluYW1pYyBWSUQvUElEIGVudHJ5DQo+IHRvIGlkX3RhYmxlIG9mIG9uYm9hcmRfaHVi
X3VzYmRldl9kcml2ZXIuDQo+ID4NCj4gPiBIb3BlIHlvdSBjYW4gdW5kZXJzdGFuZCB3aGF0IEkg
c2FpZC4NCj4gDQo+IE5vdCByZWFsbHkuDQo+IA0KPiBJIGRvdWJ0IHRoYXQgd2hhdCB5b3UgYXJl
IHN1Z2dlc3Rpbmcgd291bGQgd29yay4gVGhlIGVhc2llc3QgdGhpbmcNCj4gdG8gY29udmluY2Ug
cGVvcGxlIHdvdWxkIHByb2JhYmx5IGJlIHRvIHNlbmQgYSBwYXRjaCAoYmFzZWQgb24gdGhpcw0K
PiBvbmUpIHdpdGggYSB3b3JraW5nIGltcGxlbWVudGF0aW9uIG9mIHlvdXIgaWRlYS4NCg0KSSBz
aG93IG15IGlkZWEsIGJ1dCBub3QgdGVzdCwNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL21p
c2Mvb25ib2FyZF91c2JfaHViLmMgYi9kcml2ZXJzL3VzYi9taXNjL29uYm9hcmRfdXNiX2h1Yi5j
DQppbmRleCBlMjgwNDA5Li4xODExMzE3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvbWlzYy9v
bmJvYXJkX3VzYl9odWIuYw0KKysrIGIvZHJpdmVycy91c2IvbWlzYy9vbmJvYXJkX3VzYl9odWIu
Yw0KQEAgLTEwLDYgKzEwLDcgQEANCiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KICNpbmNsdWRl
IDxsaW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgvbGlzdC5oPg0KKyNpbmNsdWRlIDxs
aW51eC9zbGFiLmg+DQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KICNpbmNsdWRlIDxsaW51
eC9tdXRleC5oPg0KICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KQEAgLTE3Myw2ICsxNzQsNTggQEAg
c3RhdGljIHZvaWQgb25ib2FyZF9odWJfcmVtb3ZlX3VzYmRldihzdHJ1Y3Qgb25ib2FyZF9odWIg
Kmh1YiwgY29uc3Qgc3RydWN0IHVzYl8NCiAJbXV0ZXhfdW5sb2NrKCZodWItPmxvY2spOw0KIH0N
CiANCisjZGVmaW5lIE1BWF9IVUJfTlVNCQk0DQorI2RlZmluZSBNQVhfVEFCTEVfU0laRQkJKE1B
WF9IVUJfTlVNICogMikNCitzdGF0aWMgc3RydWN0IHVzYl9kZXZpY2VfaWQgb25ib2FyZF9odWJf
aWRfdGFibGVbTUFYX1RBQkxFX1NJWkUgKyAxXTsNCitNT0RVTEVfREVWSUNFX1RBQkxFKHVzYiwg
b25ib2FyZF9odWJfaWRfdGFibGUpOw0KKw0KK3N0YXRpYyB2b2lkIG9uYm9hcmRfaHViX2FkZF9p
ZHRhYmxlKF9fdTE2IHZpZCwgX191MTYgcGlkKQ0KK3sNCisJaW50IGk7DQorDQorCWZvciAoaSA9
IDA7IGkgPCBNQVhfVEFCTEVfU0laRTsgaSsrKSB7DQorCQlpZiAoIW9uYm9hcmRfaHViX2lkX3Rh
YmxlW2ldLmlkVmVuZG9yKQ0KKwkJCWJyZWFrOw0KKw0KKwkJaWYgKG9uYm9hcmRfaHViX2lkX3Rh
YmxlW2ldLmlkVmVuZG9yID09IHZpZCAmJg0KKwkJICAgIG9uYm9hcmRfaHViX2lkX3RhYmxlW2ld
LmlkUHJvZHVjdCA9PSBwaWQpDQorCQkJcmV0dXJuOw0KKwl9DQorCWlmIChpID09IE1BWF9UQUJM
RV9TSVpFKQ0KKwkJcmV0dXJuOw0KKw0KKwlvbmJvYXJkX2h1Yl9pZF90YWJsZVtpXS5pZFZlbmRv
ciA9IHZpZDsNCisJb25ib2FyZF9odWJfaWRfdGFibGVbaV0uaWRQcm9kdWN0ID0gcGlkOw0KKwlv
bmJvYXJkX2h1Yl9pZF90YWJsZVtpXS5tYXRjaF9mbGFncyA9IFVTQl9ERVZJQ0VfSURfTUFUQ0hf
REVWSUNFOw0KK30NCisNCitzdGF0aWMgaW50IG9uYm9hcmRfaHViX3BhcnNlX2lkdGFibGUoc3Ry
dWN0IGRldmljZV9ub2RlICpucCkNCit7DQorCWludCBzaXplID0gb2ZfcHJvcGVydHlfY291bnRf
ZWxlbXNfb2Zfc2l6ZShucCwgInZpZHBpZCIsIHNpemVvZihpbnQpKTsNCisJaW50IHJldCwgaTsN
CisJdTE2ICppZHM7DQorDQorCWlmICghc2l6ZSB8fCBzaXplICUgMikNCisJCXJldHVybiAtRUlO
VkFMOw0KKw0KKwlpZHMgPSBremFsbG9jKHNpemVvZih1MTYpICogc2l6ZSwgR0ZQX0tFUk5FTCk7
DQorCWlmICghaWRzKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQorCXJldCA9IG9mX3Byb3BlcnR5
X3JlYWRfdTE2X2FycmF5KG5wLCAidmlkcGlkIiwgaWRzLCBzaXplKTsNCisJaWYgKHJldCkgew0K
KwkJa2ZyZWUoaWRzKTsNCisJCXJldHVybiAtRUlOVkFMOw0KKwl9DQorDQorCWZvciAoaSA9IDA7
IGkgPCBzaXplOyBpKz0yKQ0KKwkJb25ib2FyZF9odWJfYWRkX2lkdGFibGUoaWRzW2ldLCBpZHNb
aSsxXSk7DQorDQorCWtmcmVlKGlkcyk7DQorDQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMg
c3NpemVfdCBhbHdheXNfcG93ZXJlZF9pbl9zdXNwZW5kX3Nob3coc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCiAJCQkgICBjaGFyICpidWYpDQogew0K
QEAgLTIxMCw2ICsyNjMsMTAgQEAgc3RhdGljIGludCBvbmJvYXJkX2h1Yl9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlzdHJ1Y3Qgb25ib2FyZF9odWIgKmh1YjsNCiAJaW50
IGVycjsNCiANCisJZXJyID0gb25ib2FyZF9odWJfcGFyc2VfaWR0YWJsZShkZXYtPm9mX25vZGUp
Ow0KKwlpZiAoZXJyKQ0KKwkJcmV0dXJuIGVycjsNCisNCiAJaHViID0gZGV2bV9remFsbG9jKGRl
diwgc2l6ZW9mKCpodWIpLCBHRlBfS0VSTkVMKTsNCiAJaWYgKCFodWIpDQogCQlyZXR1cm4gLUVO
T01FTTsNCkBAIC0zNzgsMTUgKzQzNSw2IEBAIHN0YXRpYyB2b2lkIG9uYm9hcmRfaHViX3VzYmRl
dl9kaXNjb25uZWN0KHN0cnVjdCB1c2JfZGV2aWNlICp1ZGV2KQ0KIAlvbmJvYXJkX2h1Yl9yZW1v
dmVfdXNiZGV2KGh1YiwgdWRldik7DQogfQ0KIA0KLXN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2Rl
dmljZV9pZCBvbmJvYXJkX2h1Yl9pZF90YWJsZVtdID0gew0KLQl7IFVTQl9ERVZJQ0UoVkVORE9S
X0lEX1JFQUxURUssIDB4MDQxMSkgfSwgLyogUlRTNTQxMSBVU0IgMy4xICovDQotCXsgVVNCX0RF
VklDRShWRU5ET1JfSURfUkVBTFRFSywgMHg1NDExKSB9LCAvKiBSVFM1NDExIFVTQiAyLjEgKi8N
Ci0JeyBVU0JfREVWSUNFKFZFTkRPUl9JRF9SRUFMVEVLLCAweDA0MTQpIH0sIC8qIFJUUzU0MTQg
VVNCIDMuMiAqLw0KLQl7IFVTQl9ERVZJQ0UoVkVORE9SX0lEX1JFQUxURUssIDB4NTQxNCkgfSwg
LyogUlRTNTQxNCBVU0IgMi4xICovDQotCXt9DQotfTsNCi1NT0RVTEVfREVWSUNFX1RBQkxFKHVz
Yiwgb25ib2FyZF9odWJfaWRfdGFibGUpOw0KLQ0KIHN0YXRpYyBzdHJ1Y3QgdXNiX2RldmljZV9k
cml2ZXIgb25ib2FyZF9odWJfdXNiZGV2X2RyaXZlciA9IHsNCiAJLm5hbWUgPSAib25ib2FyZC11
c2ItaHViIiwNCiAJLnByb2JlID0gb25ib2FyZF9odWJfdXNiZGV2X3Byb2JlLA0K
