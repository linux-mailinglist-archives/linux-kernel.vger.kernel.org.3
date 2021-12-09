Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6343F46E1D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhLIF06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:26:58 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:3870 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhLIF04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1639027403; x=1639632203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ET5Xox9FlofMRij2CXGZTvD+cZkMfgH0ZWdGmzoeQk0=;
  b=bkvWMEWjUehkkDrhm/P0EjUqRKaKDK+tadiUx4c70mI1KrbHZNT68Aeo
   g4cVzRYqN/z8FOn79Cv1sougsO8SMwaAuDbUfiC9P9OmoU27wdB3tFwky
   UjrPwT4ZbvfckKE1GZUvFr7lY7OBPXlFLBVW4eNEaBdMKLBVWS0yWeYd/
   w=;
Received: from mail-bn8nam08lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 05:23:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j10cRL+I1/97A8pEvfx9GWE/uD808jH80BjT25OS9fkGi0YinGFO8WqyrhR6I3QoKL/mVdB6ekaFZhPIMA5SPsJd63rFEzWjwQ0rjUddl8B6CMxTMW61tImUScTJJ7Pwbhm3VmDeFqOojSa2qjsuGfXucD71xYu3lN1NnQN5djgTTVbjnqeOJUqWINPMayjorpJHVW/Wr8EQZmzJZZVBzcCar6TuwJ9F7KPpX8liWIkycYwZUk10HaV44oM2BDJ39ynFap77UrVidquFJPqpsYs7KtO62G62Hc1mdUKGHSbvS7+bzUEqJYTIkJ6Yq5tOwxJ3uETt9CAJScpISnCwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET5Xox9FlofMRij2CXGZTvD+cZkMfgH0ZWdGmzoeQk0=;
 b=QoHalvLnlHV5mmnuzjGOdOVyiwzVxR/X6WSPc2zelsFQdUV5Ud98C4loMLCp5kG4ietA7LK6b/wsl9DxwLHKwu4XFZ6rku4OOGSDCF69lgBxvcWMWLU3UwEgbIUgwIjZ6w7BCQdjo2L3jx1xK4p2mOJVNtXmQBNC6auznZsawYSTkwNgFls5xm+NEtFWoU90KXfirPurolMGjBcbDAdSbcfqiuQHMrrsdvIAQWDZ5raWBSZopahzOa81DmBJXTvaf/JcQAnhGtwa6Z12Zmh7rfzaTaKetF3AUSwm+63/GBxeoyp6DQ1gW4L7RXcsKLj/Ic4ofwyY0c2bRJb++uz4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 (2603:10b6:806:1e8::6) by SN6PR02MB5503.namprd02.prod.outlook.com
 (2603:10b6:805:e8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 05:23:14 +0000
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::71b2:90f0:8f8e:c03e]) by SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::71b2:90f0:8f8e:c03e%4]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 05:23:13 +0000
From:   "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        quic_bgodavar <quic_bgodavar@quicinc.com>,
        Rocky Liao <rjliao@codeaurora.org>,
        "hbandi@codeaurora.org" <hbandi@codeaurora.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "PANICKER HARISH (Temp) (QUIC)" <quic_pharish@quicinc.com>
Subject: RE: [PATCH] Bluetooth: btqca: sequential validation
Thread-Topic: [PATCH] Bluetooth: btqca: sequential validation
Thread-Index: AQHX7A13DHT4CruqRECtsOsQOkEACKworSEAgAD0eSA=
Date:   Thu, 9 Dec 2021 05:23:13 +0000
Message-ID: <SN4PR0201MB8725FF3A009D033258592A1AE3709@SN4PR0201MB8725.namprd02.prod.outlook.com>
References: <1638952007-32222-1-git-send-email-quic_saluvala@quicinc.com>
 <2DFAE4A9-5101-49B9-86BB-2D82883E930C@holtmann.org>
In-Reply-To: <2DFAE4A9-5101-49B9-86BB-2D82883E930C@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed233eae-9c00-44e4-1307-08d9bad3ffa4
x-ms-traffictypediagnostic: SN6PR02MB5503:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB55031CDAEF5974230EB8FCA59F709@SN6PR02MB5503.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYAGEG2PIU3CUGxapi3KxYCXq6FtG59O6C3XvoughZa2JcFcJmrqCUyim/4NOxSuAmBRoTDeUTUGJxOJD1L0cpx3IyYRxeuc9W5crB3pCCzHvgK6ek0GQYZguMHCrcTIdCclH8rynL0458ZPZsXpXeICfu1mbtVkupBQkKF5T1XOj7mtFYYXmQzOK2hlPOv9+2V733mqMh3UAu+AMPxQSKO1Jff3qvOxPT3g2QjHqwPMPQjzaKpdk68+OHcgQGONHUJV5+T7hwyE3KI7hUmNaaUkUwxayYlueiWXFbYiREWZd4P4ZH97GTSa4Mnikz4oAcEJXHkoGTT5pttCncqw6X5W4DNhg5LCOlpkMFSpGvvt5XEU//0CykPtNkhI0EpTTAs7WWULsF6pstLVJt/SjznZIJlrSSP4QdwR5ZBGbiJQ1aSGh5Ahkd+OD+Cg+o1Y0b/zGSEKXXbmbRVks3ol04HVxfBK/0qL2o93/kZbfODRF0EDArB7mAnS0yIszOoRtYxqrKEbzSAOPWwPEP8lBeyNU2Nf2mT7XsRCBSHy58QODH4wOeqFC1adXXu0NXfGwTegH9Gxu1YpqKCbgTyv/O8nrtAB1p/mwE9opU7WhiXaGEkBGhBz7QR8Sp0xMkaB5oortLFaM9xnP4JaJatB7YKh4pT4rH6LK0fnG9KPmCLRiquve3qmaZLPGSEQQZrWD9G2Ac45dJLjVwUMF+c1fA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB8725.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(5660300002)(38100700002)(508600001)(8676002)(8936002)(7416002)(53546011)(107886003)(38070700005)(186003)(7696005)(122000001)(4326008)(6506007)(54906003)(26005)(2906002)(33656002)(316002)(71200400001)(66946007)(64756008)(83380400001)(52536014)(66476007)(9686003)(66446008)(110136005)(55016003)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGt3VGlQN1c4ZkZRTHp2QmtaYnBPcFA0VlRnT0cwdlVaTmF1ZlZMeUV4QnVZ?=
 =?utf-8?B?ZGJyTlQ0L2pJNVBHYlc3bTBEYWlJMU9OakkrK1B3MUtWT3ZvUGpsa3hJZmg4?=
 =?utf-8?B?dSswdGJHbEt5Ny8vZE1YdU5vSHZoOXpUQkpTS3V6R08vLzhXNXZzWEpGcFor?=
 =?utf-8?B?dzVHWXpiUk1MVFFMbGs5M0R6dUhKZ29COVkwd1NySDh5RnFYcjJnYzFWNHAy?=
 =?utf-8?B?RzdHcnliYkljTlZrSVYwcXBPRlFETi9weHlwLzlvNWZZOXJ0KzJic04zZUpx?=
 =?utf-8?B?R3B1NDdua0VVRE9OamRIOEZxejRsOFlmdWpYc0o3NnYvS0ppRSs0Sy9MSmNG?=
 =?utf-8?B?SHBGcW9TdkZISHpwdzBja0NSb0RjTkY3b084VnBaYWVrZWsxZmJGdEF4YkNM?=
 =?utf-8?B?NEhBcThZSVFHSzFkUzRYQjJVc2JRRlJiS09PVW1uRkR2TzVhTk5OcnpqS2ls?=
 =?utf-8?B?TWlrWFIwVVMxTFdDT0puajlCaXJ5SVNUekVTWHp2VGowd3ErdG5Fd2ovMmJH?=
 =?utf-8?B?bFFNYkx6dmVFV1NrdmJzUHdHZWE1Zm1PaExpMThzUS9mOVRKOGJES2lJcHlV?=
 =?utf-8?B?cmJlV2JDQi90SjBZaWhFN2FoNTJSV0YyMHgzWVVSUUpnenJEaFUrWnpJbHgw?=
 =?utf-8?B?QXBJZE9jRUtaYlBENU1hRlZxOU00WjQzU21sSEFKcGZzcjZsMDZIZ2hLeEhz?=
 =?utf-8?B?UkpsM0F3UFA3RkU3NzdnVHpITGQ1a2w5MDR1eUdLMVdVRHp5WUhzNEUvcEhZ?=
 =?utf-8?B?WEhWTUFGYTN2Z3hiS2dIaUF6ZENyRm05QUJxaTc4SlNKc09TaFJOYnI5MDBG?=
 =?utf-8?B?cnR3ZGFOVS9TeXNTRkloWDVYZk0xNkZIQVJ1S2ZPMjlJRzJQY29jNWZQQkxX?=
 =?utf-8?B?aWRxMkdOZGU3SFljRmJiNTFaRTRqRTM0NmV0THpwVndqZUdGdVhwb3diUkE3?=
 =?utf-8?B?Qy9rZWtUMnBEWDRqSjV2QkdTb2N0cXRPUStJYytIU25PYXNDRVBUSk5MM3pn?=
 =?utf-8?B?MmhFRFJ6bTFuOW5ibHdjM1hGV0pXeEtnVVJVMlplTG1vR3pTNEd2eXptclZ2?=
 =?utf-8?B?QU4zckkxaG9VSi9lNjMyZ09NVW9KRFAyY0ZkMnA2elZRaFcrWld3TEtwUGRo?=
 =?utf-8?B?YXJYQ2toOEg5djJab2FEOTdPaGxLZTNnbVdlZnQ0WXl5bjV4cCs3cldjL3d5?=
 =?utf-8?B?OHR2cUFXRVROMjhtWHJCalhIeUR6L3VMVVNIRVB4RFRnK3E2Zm9rUG5zRE9W?=
 =?utf-8?B?YWFlWXhVVW1WaFNGYVNLQ3JlQU1yOGZIVktKaHZQVDd1dVAwRXcvWVJidlM1?=
 =?utf-8?B?S1V3Tk45by9BNlNCSXpnRS90U3J0UERUbUI4bGtFekFtWHI1a0Jya1RmdHEx?=
 =?utf-8?B?eG5JZWVHTFdXVzNOS1FjMUptbmVzUmQ3Q1RWT2hONlhGZXZyWUxmbGMrZVlB?=
 =?utf-8?B?Q2p1bklNTktQMndkR0NLZlZjNW1LUFBZQnIrN21KeHZtakN0SS9waE11MUJr?=
 =?utf-8?B?NnlXNytPWksyczExeVRtbDFwdXVjYVF4ZjhuY0ZvRnp4bU1FVjl3QWU1OGpW?=
 =?utf-8?B?QUVhcXhHSC9xL0tubVZEb2t0Vy9CdmZVSnFVYUF5TTdzc1lDQ2lSQkd6WUdk?=
 =?utf-8?B?NktiNjAwT2NHTW00QlhGSDhhYVI3RmFoVkxCSSszdzlhVmlEMEFzbk02bEo0?=
 =?utf-8?B?dU1xQ2NqSE1hdlJ4Y0dlVzVOMFUxd2Y4dm5URGE0Y0F6Z2xUR05QVU5LZmdP?=
 =?utf-8?B?RElpdGRKeEFZaFFNc2lhemdROXIyZ0trWnZBdkhHNXpPQWZPMHQ3bEhNRHdr?=
 =?utf-8?B?b1ZSUzdNV1lYUExuT2dUdE9HM0Q5OTVpNWxXbVFCT3pyYVkxRGJ3UC81cUJ2?=
 =?utf-8?B?WjlSNWwvOVg0MGkyK2k3Z1NkVzBVZGlpNS9GUGpJK2VRdHd4MWwya0N1ci9P?=
 =?utf-8?B?Q21MVm9yenlkS3ZLclhDckx2MWNteDh3NXJQMUlPUnRaV2RxOGR5SzB4WEEv?=
 =?utf-8?B?OFYxeVRRZUFmVHFnMExRM1d2NU12Rk5vS3NwQzRxakIyOWFpK1VXeE1NTVVa?=
 =?utf-8?B?b0ZTMTRMWXlEb0N2bFh3dWdWc0dIWGh2bjQxL01DZFZHRE1yMDRLSWVCVlB4?=
 =?utf-8?B?TmZsaTVRM2traExrQzVQcTA0QlVmeGNzN1JoZXFOc1hPc1BlU1lvRzVDQ2xZ?=
 =?utf-8?B?VnhFNFl3ZlQvdGpOUTZGbVA3Mzg4SjZjWG5oNk5nWXcxeHpEcC9RN0dkajE5?=
 =?utf-8?B?NWdyTUNUZnFDSTJreWpSQ3QyUTRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8725.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed233eae-9c00-44e4-1307-08d9bad3ffa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 05:23:13.7569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6a5GNw4twvIEi9H+FICgJ2diHfd9qs88iuZlAMAcnoY4B4FkUusEwvqT1yoLdZHOPST2xhngia6T2tL/aGKdzEDgJ4BLBOKQjyaM++uZxsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5503
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXJjZWwgSG9sdG1hbm4gPG1h
cmNlbEBob2x0bWFubi5vcmc+IA0KU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciA4LCAyMDIxIDg6
MTggUE0NClRvOiBTYWkgVGVqYSBBbHV2YWxhIChUZW1wKSAoUVVJQykgPHF1aWNfc2FsdXZhbGFA
cXVpY2luYy5jb20+DQpDYzogSm9oYW4gSGVkYmVyZyA8am9oYW4uaGVkYmVyZ0BnbWFpbC5jb20+
OyBNYXR0aGlhcyBLYWVobGNrZSA8bWthQGNocm9taXVtLm9yZz47IExpbnV4IEtlcm5lbCBNYWls
aW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1ibHVldG9vdGgg
PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+OyBIZW1hbnQgR3VwdGEgKFFVSUMpIDxx
dWljX2hlbWFudGdAcXVpY2luYy5jb20+OyBNU00gPGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwu
b3JnPjsgcXVpY19iZ29kYXZhciA8cXVpY19iZ29kYXZhckBxdWljaW5jLmNvbT47IFJvY2t5IExp
YW8gPHJqbGlhb0Bjb2RlYXVyb3JhLm9yZz47IGhiYW5kaUBjb2RlYXVyb3JhLm9yZzsgQWJoaXNo
ZWsgUGFuZGl0LVN1YmVkaSA8YWJoaXNoZWtwYW5kaXRAY2hyb21pdW0ub3JnPjsgTWlhby1jaGVu
IENob3UgPG1jY2hvdUBjaHJvbWl1bS5vcmc+OyBQQU5JQ0tFUiBIQVJJU0ggKFRlbXApIChRVUlD
KSA8cXVpY19waGFyaXNoQHF1aWNpbmMuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gQmx1ZXRv
b3RoOiBidHFjYTogc2VxdWVudGlhbCB2YWxpZGF0aW9uDQoNCkhpIFNhaSwNCg0KPiBUaGlzIGNo
YW5nZSB3aWxsIGhhdmUgc2VxdWVudGlhbCB2YWxpZGF0aW9uIHN1cHBvcnQgJiBwYXRjaCBjb25m
aWcgDQo+IGNvbW1hbmQgaXMgYWRkZWQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNhaSBUZWphIEFs
dXZhbGEgPHF1aWNfc2FsdXZhbGFAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiBkcml2ZXJzL2JsdWV0
b290aC9idHFjYS5jIHwgNDUgDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiBkcml2ZXJzL2JsdWV0b290aC9idHFjYS5oIHwgIDMgKysrDQo+IDIgZmls
ZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Ymx1ZXRvb3RoL2J0cWNhLmMgYi9kcml2ZXJzL2JsdWV0b290aC9idHFjYS5jIA0KPiBpbmRleCBi
ZTA0ZDc0Li45YTJmZDE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idHFjYS5j
DQo+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0cWNhLmMNCj4gQEAgLTE0MSw2ICsxNDEsNDkg
QEAgc3RhdGljIGludCBxY2FfcmVhZF9md19idWlsZF9pbmZvKHN0cnVjdCBoY2lfZGV2ICpoZGV2
KQ0KPiAJcmV0dXJuIGVycjsNCj4gfQ0KPiANCj4gK2ludCBxY2Ffc2VuZF9wYXRjaF9jb25maWdf
Y21kKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBlbnVtIA0KPiArcWNhX2J0c29jX3R5cGUgc29jX3R5
cGUpIHsNCg0KbG9vaywgSSBoYXZlIGxpbWl0ZWQgdW5kZXJzdGFuZGluZyBmb3IgcGVvcGxlIGln
bm9yaW5nIHdhcm5pbmdzLiBUaGUgbWlzc2luZyBzdGF0aWMgZGVjbGFyYXRpb24gaXMgb2J2aW91
cyBhbmQgd2hlbiB5b3UgY29tcGlsZSB0aGUgY29kZSBpdCB3aWxsIGFjdHVhbGx5IHRlbGwgeW91
IGFib3V0IGl0Lg0KW1NhaV0gOiB3aWxsIHVwZGF0ZSBpbiBuZXh0IHBhdGNoDQoNCj4gKwlzdHJ1
Y3Qgc2tfYnVmZiAqc2tiOw0KPiArCWludCBlcnIgPSAwOw0KPiArCXU4IGNtZFs1XSA9IHtFRExf
UEFUQ0hfQ09ORklHX0NNRCwgMHgwMSwgMCwgMCwgMH07DQoNCmNvbnN0IHU4IGNtZFtdID0geyBF
REwuLiwgLi4sIDAgfTsNCltzYWldOiB3aWxsIHVwZGF0ZSBpbiBuZXh0IHBhdGNoDQoNCj4gKwl1
OCBybGVuID0gMHgwMjsNCj4gKwlzdHJ1Y3QgZWRsX2V2ZW50X2hkciAqZWRsOw0KPiArCXU4IHJ0
eXBlID0gRURMX1BBVENIX0NPTkZJR19DTUQ7DQo+ICsNCj4gKwlidF9kZXZfZGJnKGhkZXYsICJR
Q0EgUGF0Y2ggY29uZmlnIik7DQo+ICsNCj4gKwlza2IgPSBfX2hjaV9jbWRfc3luY19ldihoZGV2
LCBFRExfUEFUQ0hfQ01EX09QQ09ERSwgDQo+ICtFRExfUEFUQ0hfQ09ORklHX0NNRF9MRU4sDQoN
CnNpemVvZihjbWQpDQpbc2FpXTogd2lsbCB1cGRhdGUgaW4gbmV4dCBwYXRjaA0KDQo+ICsJCQlj
bWQsIEhDSV9FVl9WRU5ET1IsIEhDSV9JTklUX1RJTUVPVVQpOw0KDQpJbmRlbnRhdGlvbiBpcyB3
cm9uZy4NCltzYWldIDogd2lsbCB1cGRhdGUgaW4gbmV4dCBwYXRjaA0KPiArCWlmIChJU19FUlIo
c2tiKSkgew0KPiArCQllcnIgPSBQVFJfRVJSKHNrYik7DQo+ICsJCWJ0X2Rldl9lcnIoaGRldiwg
IlNlbmRpbmcgUUNBIFBhdGNoIGNvbmZpZyBmYWlsZWQgKCVkKSIsIGVycik7DQo+ICsJCXJldHVy
biBlcnI7DQo+ICsJfQ0KPiArCWlmIChza2ItPmxlbiAhPSBybGVuKSB7DQo+ICsJCWJ0X2Rldl9l
cnIoaGRldiwgIlFDQSBQYXRjaCBjb25maWcgY21kIHNpemUgbWlzbWF0Y2ggbGVuICVkIiwgc2ti
LT5sZW4pOw0KPiArCQllcnIgPSAtRUlMU0VROw0KPiArCQlnb3RvIG91dDsNCj4gKwl9DQoNCkV4
dHJhIGVtcHR5IGxpbmUsDQpbU2FpXTogd2lsbCByZW1vdmUgZXh0cmEgbGluZSBpbiBuZXh0IHBh
dGNoDQo+ICsJZWRsID0gKHN0cnVjdCBlZGxfZXZlbnRfaGRyICopKHNrYi0+ZGF0YSk7DQo+ICsJ
aWYgKCFlZGwpIHsNCj4gKwkJYnRfZGV2X2VycihoZGV2LCAiUUNBIFBhdGNoIGNvbmZpZyB3aXRo
IG5vIGhlYWRlciIpOw0KPiArCQllcnIgPSAtRUlMU0VROw0KPiArCQlnb3RvIG91dDsNCj4gKwl9
DQoNCkhlcmUgYXMgd2VsbC4NCltTYWldOiB3aWxsIHJlbW92ZSBpbiBuZXh0IHBhdGNoDQo+ICsJ
aWYgKGVkbC0+Y3Jlc3AgIT0gRURMX1BBVENIX0NPTkZJR19SRVNfRVZUIHx8IGVkbC0+cnR5cGUg
IT0gcnR5cGUpIHsNCj4gKwkJYnRfZGV2X2VycihoZGV2LCAiUUNBIFdyb25nIHBhY2tldCByZWNl
aXZlZCAlZCAlZCIsIGVkbC0+Y3Jlc3AsDQo+ICsJCSBlZGwtPnJ0eXBlKTsNCg0KV3JvbmcgaW5k
ZW50YXRpb24uDQpbU2FpXSA6IHdpbGwgdXBkYXRlIGluIG5leHQgcGF0Y2guDQo+ICsJCWVyciA9
IC1FSU87DQo+ICsJCWdvdG8gb3V0Ow0KPiArCX0NCj4gK291dDoNCj4gKwlrZnJlZShza2IpOw0K
PiArCWlmIChlcnIpDQo+ICsJCWJ0X2Rldl9lcnIoaGRldiwgIlFDQSBQYXRjaCBjb25maWcgY21k
IGZhaWxlZCAoJWQpIiwgZXJyKTsNCj4gKw0KPiArCXJldHVybiBlcnI7DQo+ICt9DQo+ICsNCj4g
c3RhdGljIGludCBxY2Ffc2VuZF9yZXNldChzdHJ1Y3QgaGNpX2RldiAqaGRldikgew0KPiAJc3Ry
dWN0IHNrX2J1ZmYgKnNrYjsNCj4gQEAgLTU1MSw2ICs1OTQsOCBAQCBpbnQgcWNhX3VhcnRfc2V0
dXAoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHVpbnQ4X3QgYmF1ZHJhdGUsDQo+IAkgKi8NCj4gCXJv
bV92ZXIgPSAoKHNvY192ZXIgJiAweDAwMDAwZjAwKSA+PiAweDA0KSB8IChzb2NfdmVyICYgMHgw
MDAwMDAwZik7DQo+IA0KPiArCWlmIChzb2NfdHlwZSA9PSBRQ0FfV0NONjc1MCkNCj4gKwkJcWNh
X3NlbmRfcGF0Y2hfY29uZmlnX2NtZChoZGV2LCBzb2NfdHlwZSk7DQoNCkV4dHJhIGVtcHR5IGxp
bmUuDQpJZiB5b3UgYXJlIG5vdCB1c2luZyB0aGUgc29jX3R5cGUsIHRoZW4gZG9u4oCZdCBhZGQg
aXQgYXMgcGFyYW1ldGVyLg0KW1NhaV0gOiB3aWxsIHJlbW92ZSBpbiBuZXh0IHBhdGNoLg0KDQo+
IAkvKiBEb3dubG9hZCByYW1wYXRjaCBmaWxlICovDQo+IAljb25maWcudHlwZSA9IFRMVl9UWVBF
X1BBVENIOw0KPiAJaWYgKHFjYV9pc193Y24zOTl4KHNvY190eXBlKSkgew0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ibHVldG9vdGgvYnRxY2EuaCBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0cWNhLmgg
DQo+IGluZGV4IDMwYWZhNzcuLjhmYmI0YzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRv
b3RoL2J0cWNhLmgNCj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRxY2EuaA0KPiBAQCAtMTMs
NiArMTMsOCBAQA0KPiAjZGVmaW5lIEVETF9QQVRDSF9UTFZfUkVRX0NNRAkJKDB4MUUpDQo+ICNk
ZWZpbmUgRURMX0dFVF9CVUlMRF9JTkZPX0NNRAkJKDB4MjApDQo+ICNkZWZpbmUgRURMX05WTV9B
Q0NFU1NfU0VUX1JFUV9DTUQJKDB4MDEpDQo+ICsjZGVmaW5lIEVETF9QQVRDSF9DT05GSUdfQ01E
X0xFTgkoMHgwNSkNCg0KTm90IG5lZWRlZC4NCltTYWldIDogd2lsbCByZW1vdmUgaW4gbmV4dCBw
YXRjaC4NCg0KPiArI2RlZmluZSBFRExfUEFUQ0hfQ09ORklHX0NNRAkJKDB4MjgpDQo+ICNkZWZp
bmUgTUFYX1NJWkVfUEVSX1RMVl9TRUdNRU5UCSgyNDMpDQo+ICNkZWZpbmUgUUNBX1BSRV9TSFVU
RE9XTl9DTUQJCSgweEZDMDgpDQo+ICNkZWZpbmUgUUNBX0RJU0FCTEVfTE9HR0lORwkJKDB4RkMx
NykNCj4gQEAgLTI0LDYgKzI2LDcgQEANCj4gI2RlZmluZSBFRExfQ01EX0VYRV9TVEFUVVNfRVZU
CQkoMHgwMCkNCj4gI2RlZmluZSBFRExfU0VUX0JBVURSQVRFX1JTUF9FVlQJKDB4OTIpDQo+ICNk
ZWZpbmUgRURMX05WTV9BQ0NFU1NfQ09ERV9FVlQJCSgweDBCKQ0KPiArI2RlZmluZSBFRExfUEFU
Q0hfQ09ORklHX1JFU19FVlQJKDB4MDApDQo+ICNkZWZpbmUgUUNBX0RJU0FCTEVfTE9HR0lOR19T
VUJfT1AJKDB4MTQpDQo+IA0KPiAjZGVmaW5lIEVETF9UQUdfSURfSENJCQkJKDE3KQ0KDQpSZWdh
cmRzDQoNCk1hcmNlbA0KDQo=
