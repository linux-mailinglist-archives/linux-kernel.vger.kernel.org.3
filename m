Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B364741CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhLNLtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:49:32 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:36617 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhLNLtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1639482571; x=1640087371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RUaZ2Lwov9fwnPvrNY0I2TQH1CQLex/ziFFt7NqBNOA=;
  b=Op4kfX9N00AgZMyj6tEXrBQ6//95KNWn728U/9L55DGgdvdnY3M1OIzl
   7LxRep2lLLXCgS/64sNH1Qm9RVpKQlF5fUGGe04B3aBpXUw9C+gUs7uxr
   N7a0EMIEfZFGl6dFwx19Z8f7QtDUJh6oOTMcIsB1YWzN5mNTaTzmKtVT2
   w=;
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 11:49:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJBxc/mPMxk+HmTHSF5Lg56swL4EIbQ403zWARZGlO3v0BNaXM/q817jSiXgCHUAfwjGrsDg4bk2THHqch0zr/yD8nutuIiXb0Ne7h+Ak9PtxjADR+A24egmarqcec8clMeM/6TVzu+HZUueQk3LGFbREY2PzR1Ir6z0KmXjK4h2+LUeyGvwvGM6uCRGSJ0+mD7KiCqfnmO1pxkaZTfWrilD3hxHu9SGkokAPZbKBJVgTUXvmS8WaWxV1aaZeBbHd0pmXL9Kh72i35K4uxRQjF4UatXHaX7MKnRTWQspXH49JgfiBT4lTugQ8DV+flgeuoKnAxKoKEaQBH47NhHsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUaZ2Lwov9fwnPvrNY0I2TQH1CQLex/ziFFt7NqBNOA=;
 b=Q8JVwKZf2Y4hkeggLIPutx8sqXvsRVu+sm11IGxFDsof+I1fsjX+WYHXBmlSf1iFUiLqy2z9exwYVFpmRP1mRLbgSOnuVKTQlkzzZGVySAnYH69J8mbMW9My3uawBluhHO6mRkmnaqqBF+OOjvOW33z9LAQxbnT2yO3sppG3U5SkHG6ws7f/ONUFeIR28fR9FTx2Hi2nXnlsw0MC2fPJwHkIxmP0y5qq6wm0Iw8GRQWc1ZrzOcWZFJqNUxeo5s0+wkQCdmqZyq30iDBwOypAck7C/tbFMlHWRUoYzzptdyzfYPVV+USYG3PWsPgQg/A1do7CMIJjEsPOcWYHZ6mFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB4092.namprd02.prod.outlook.com (2603:10b6:5:99::21) by
 DM5PR02MB2588.namprd02.prod.outlook.com (2603:10b6:3:3d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12; Tue, 14 Dec 2021 11:49:27 +0000
Received: from DM6PR02MB4092.namprd02.prod.outlook.com
 ([fe80::a4f0:76da:34b4:3f9b]) by DM6PR02MB4092.namprd02.prod.outlook.com
 ([fe80::a4f0:76da:34b4:3f9b%7]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 11:49:27 +0000
From:   "PANICKER HARISH (Temp) (QUIC)" <quic_pharish@quicinc.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        "PANICKER HARISH (Temp) (QUIC)" <quic_pharish@quicinc.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        quic_bgodavar <quic_bgodavar@quicinc.com>,
        "rjliao@codeaurora.org" <rjliao@codeaurora.org>,
        "hbandi@codeaurora.org" <hbandi@codeaurora.org>,
        "abhishekpandit@chromium.org" <abhishekpandit@chromium.org>,
        "mcchou@chromium.org" <mcchou@chromium.org>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
Subject: RE: [PATCH v2] Bluetooth: hci_qca: Stop IBS timer during BT OFF
Thread-Topic: [PATCH v2] Bluetooth: hci_qca: Stop IBS timer during BT OFF
Thread-Index: AQHX7+LU9YeYO5pjjEyFdpSdQNr+U6wwhm+AgAFbEwA=
Date:   Tue, 14 Dec 2021 11:49:27 +0000
Message-ID: <DM6PR02MB409271A804DC2BD8DEED1AB18B759@DM6PR02MB4092.namprd02.prod.outlook.com>
References: <1639373496-28009-1-git-send-email-quic_pharish@quicinc.com>
 <Ybdhn8mPrPBp397r@google.com>
In-Reply-To: <Ybdhn8mPrPBp397r@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faa8a94e-eeff-4adc-6ede-08d9bef7c85f
x-ms-traffictypediagnostic: DM5PR02MB2588:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB2588817C1170843534384B5FF7759@DM5PR02MB2588.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jpnqK03U10uci0MQko37SQcMdu2VF68sGyk2GEKhdjWKQRsaTh2pnCa/PGgIeWkaMkAO59TDdf4mUvlfq99myzNhX8M+mcibLVRKm/OxCAndIrUE3Y2zTFA8WzwPtWE6HmpABd6cbogMiGY5+pvI60P69Q+i1vQkwuq78hMd0EFd9XaoJXfzCquRZrFRy0N/DfnDwUqeqk1SjIwI9vS8mB17+9OmmI4Csoo17/QGaSwj+hF0ajzk4SJFRaB1NcuNBnMAS85UycqWk9CiNRNepI9ddFZXc3doH6/QfbhZGd+tD9ttN19QDI2p9q1nHJR8S6Xxj8gM/mPKUMkxVpYeANqOoaRPD+9TSJ7f5kJPXADpeyWSRpb7bf4THU+MZU8HZJWLNw62cCruOlmN3D8fXEpVvAJiOHem+henoxsYYrw6sYasLdVmY1p4u5CZkgBIiqi42W5NsLq1ZOyK5etwBTLy6NoZEKwX9Fyx3w3Q0qalbuhwOdHNi+bEXezw81AjJ4VsqFII68BBxx+13SA9afA+tOMFZT7y/aC8dn09A3gAYnlS5jr3MnwTomWnYp/bubbQKHiJ6ncE/e+GmGky33jHp3KzCaPfSGROlWjG7mYtsUNKhZwe4gICbXt1C60x+skCBQTeMIqDruP9sJgy1UMm2ds6YkUNY/cqQLVofWTvVHL7jnAdLOE1g5EKF1rNRP7d1EzOPPj5GvBH7L5Eww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4092.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(9686003)(71200400001)(5660300002)(33656002)(26005)(8676002)(122000001)(316002)(38100700002)(4326008)(53546011)(107886003)(2906002)(186003)(508600001)(86362001)(76116006)(55016003)(6506007)(7696005)(52536014)(7416002)(54906003)(38070700005)(8936002)(66446008)(64756008)(110136005)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bis4b3pYMnJWWXR6S2tYUm9uY09QQUVKcGtmQXcveDZkcDlua3FJNjRLQnF0?=
 =?utf-8?B?cjRnRmdoUGN1UWRKWEFJVHFYdWdnWTYzUnNVaERxZ0dEbWt2akdtWm5sVUF4?=
 =?utf-8?B?bjdGcVRKNDViWEdjelZqQ0szcjJGVUcyeU9WZ281R2NyMkllblg1bGMzRys0?=
 =?utf-8?B?UlVNRWdlRXJDbHgyamZQYXg2bmc1SW8ySTV5eWdXZGQ0NU5YN05GWnJJYUN6?=
 =?utf-8?B?NTlPSjJITFlRM0lGSUt4eDZWWWRJMzkxcjlXTzZWZEhJSFNjc2VTWW1mYlVU?=
 =?utf-8?B?SnJFQkRyNmxpRDR3RU9pVE5KZzJlWU4rdzMvRXNsblErV20zaCtmd3lSak01?=
 =?utf-8?B?RnpCMExPM2grSFBNWkNOcmhWdmVMQVJVUnQ2dFZHQkxZRjJaNUNQd3FkL3JF?=
 =?utf-8?B?TkcwVUdMMDZ6eGd5bUc0R2pZNFZpdWhYRjIzMWdVWUhCTWl3YzUraTNBRTFO?=
 =?utf-8?B?Q0l1K2l5ajh6S2tHQ0x6T2Rvb2VENVFBdXNYTTdpK09aUFdFZExWMUdzcmw3?=
 =?utf-8?B?Tk1hWGJlSndvRjh5OUl6VkMvNEQrRGgyWDJkcFhOSithRlBGRWJQMmYyaDVT?=
 =?utf-8?B?aVlsZDJpdFcwanRlRzg5Vm84SnFpZnZVSmpyUU5lbXlnT2I4TVhSY05lZ2Iy?=
 =?utf-8?B?ZkhUYTFMVmxUUW9vY2d3UnluOEhmb21BNzdBRVNXdnZCbmp3bXVvd0p1YmZp?=
 =?utf-8?B?OXVWM3Z6SzQvbXBEYzA1UVhGTC9EV0FJbHVMZkpFaFhCYWxaVlIrcUIyVFMv?=
 =?utf-8?B?OTNja3hGVGo1K0tPT2lWUW5nZTQvSGhkQXI1WHdEZ0JjczZ3NlNUVzVwdlR4?=
 =?utf-8?B?UENZRU5TQkxHL3J2VHdjek9jTzdkU0wzR1p1TldNV3FaNE1UaWRHYU12c0hH?=
 =?utf-8?B?aTRQODgyYnlITVNaQnE4Nk5ELzlFTjZrOEhnT1U1R1FnMWRWTXhUcFlSakRX?=
 =?utf-8?B?clRsd3d1ZSttYTIrVGVFY3pxaDhFTHpIdTVyL0NFYVFGd2tKRllVdS9pTmFE?=
 =?utf-8?B?UmxFMkFpeDA1NVovZUlvcVl2dm4rNXBGeUJXM3Mza2wrWUZBelE0OUhoc3Ny?=
 =?utf-8?B?aUlnRVgyUWhNMzV6NTBHNlBwNlowalZjY1pRQS9VcnovVGwwR3VpNEs4ZTdT?=
 =?utf-8?B?VENObXVMaGFhdklTaml5R2oweU5rTFdtN1Jyc2RFUGdZd2dsTnprYzk2Z2tm?=
 =?utf-8?B?Rklnai9OUkJ2MXhDOGRhTUR3blhzbXRIbW13a1FLRGQybjJITHc1a2xSUXNm?=
 =?utf-8?B?ajdiTE1DMUk5YWh5SEN5cHRPWHBQUno3Z0RrUU9vTmpnbkZ5dlpGTHdsTjV5?=
 =?utf-8?B?RTNVaGZCcGo5Y044Rk5vMUFPcGFUV0E3T1h0d2s1T2syNG9PSElWZjNST28y?=
 =?utf-8?B?cVZOYXBFamZMemo4d1pBWDJiZUZLSFdOUXlOK1FTaHJncmtLUW12UDhRSDFz?=
 =?utf-8?B?T0x4bWl2ajFDNWphdnVWYTIrTUwxZzU1QnY5Z2wrU2RtL1p1cjM4RDZJRG03?=
 =?utf-8?B?dWN1L1lIckpOOFVKMVR5WVo0dXBNdWw5TUpTYjZSL2phd1gwcjVOZVcyOVNI?=
 =?utf-8?B?RHBsVHdxVDIzbHkvWllNRFUwWU5PeG9ST0txUjlJSUsrU2g3aUtzU3QrNnFp?=
 =?utf-8?B?VWdwRkJoQ25tTXdobVFaSzM1S0JvaHh1WG50amloWFd0T3hYR3hDZURuVjhn?=
 =?utf-8?B?VjdXOGRjRVFjNTFYQnlOdW9pS2FkZDk5LzNGR2FoTjNhOE9VREZpRWVjSEJK?=
 =?utf-8?B?OTVoK2puOW1Cb3R0TnUvdVM1Q1lDSjJuQjBCOGVFcmZWeWhMbUNBak5rUktY?=
 =?utf-8?B?YUd0Wk9nMDB6OWRlaUQwQU4vV2FvRUd0dSt2VEw4VlA1ZzRLOGhEYUhrUXlq?=
 =?utf-8?B?RmdIeU8zQ2FXUEI5YTJZaXl2aHlTUHpmNW1ldzRaS3dEaG1DLzkwdEtDV2kv?=
 =?utf-8?B?SU1wNmNOZVNXTjlsRzdFUk9ReGg3TDIwVFJYTkFZZGpxQjNvaS9reEZnNUha?=
 =?utf-8?B?aUR4VWY2ZGdKV2hOMXJXQUJXV0RjN1FXajZTNVB5TTlsTXREenpFRC83WEJK?=
 =?utf-8?B?UHRMT01Pc2ZIMDROQmYycTQ4ZEtndnhNRGJ2b0R6TTNKazI1NVFaNTkva3NG?=
 =?utf-8?B?OThaQkE1Ly9xdWNjRlBlRGN6VUNDNnp3c1k5b0JDY1I3enMyaWxrNk9MNWZP?=
 =?utf-8?Q?5mOiGOwVyWkcU5S8QfoHyvypmr8R0zkyTeqeyYwouDln?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4092.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa8a94e-eeff-4adc-6ede-08d9bef7c85f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 11:49:27.5594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8qePbBNvdQMv+Gt8ZLdvWwMCBvIH96dOoUP7NZ/vhUpqHE27k9XJ77Zkh8V64iYKBbWZupLDn3QvzImJPcg2L00dnu4ucFLKmujsFUGzYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2588
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXR0aGlhcyBLYWVobGNrZSA8
bWthQGNocm9taXVtLm9yZz4gDQpTZW50OiBNb25kYXksIERlY2VtYmVyIDEzLCAyMDIxIDg6Mzcg
UE0NClRvOiBQQU5JQ0tFUiBIQVJJU0ggKFRlbXApIChRVUlDKSA8cXVpY19waGFyaXNoQHF1aWNp
bmMuY29tPg0KQ2M6IG1hcmNlbEBob2x0bWFubi5vcmc7IGpvaGFuLmhlZGJlcmdAZ21haWwuY29t
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJu
ZWwub3JnOyBIZW1hbnQgR3VwdGEgKFFVSUMpIDxxdWljX2hlbWFudGdAcXVpY2luYy5jb20+OyBs
aW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgcXVpY19iZ29kYXZhciA8cXVpY19iZ29kYXZh
ckBxdWljaW5jLmNvbT47IHJqbGlhb0Bjb2RlYXVyb3JhLm9yZzsgaGJhbmRpQGNvZGVhdXJvcmEu
b3JnOyBhYmhpc2hla3BhbmRpdEBjaHJvbWl1bS5vcmc7IG1jY2hvdUBjaHJvbWl1bS5vcmc7IFNh
aSBUZWphIEFsdXZhbGEgKFRlbXApIChRVUlDKSA8cXVpY19zYWx1dmFsYUBxdWljaW5jLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIEJsdWV0b290aDogaGNpX3FjYTogU3RvcCBJQlMgdGlt
ZXIgZHVyaW5nIEJUIE9GRg0KDQpPbiBNb24sIERlYyAxMywgMjAyMSBhdCAxMTowMTozNkFNICsw
NTMwLCBQYW5pY2tlciBIYXJpc2ggd3JvdGU6DQo+IFRoaXMgY2hhbmdlIHN0b3BzIElCUyB0aW1l
cnMgZHVyaW5nIEJUIE9GRi4NCg0Kbml0OiBhdm9pZCB0aGluZyBsaWtlICd0aGlzIHBhdGNoIC4u
LicgaW4gY29tbWl0IG1lc3NhZ2VzLCB5b3UgY291bGQganVzdCBzYXkgJ1N0b3AgSUJTIHRpbWVy
cyB3aGlsZSBCbHVldG9vdGggaXMgb2ZmLg0KDQpbSGFyaXNoXSA6IEkgd2lsbCB1cGRhdGUgDQoN
Cj4gU2lnbmVkLW9mZi1ieTogUGFuaWNrZXIgSGFyaXNoIDxxdWljX3BoYXJpc2hAcXVpY2luYy5j
b20+DQoNCkxvb2tzIGxpa2UgdGhpcyBzaG91bGQgaGF2ZSBhIMK0Rml4ZXMnIHRhZyB0byBtYWtl
IHN1cmUgaXQgbGFuZHMgaW4gdGhlIHJlbGV2YW50IC1zdGFibGUgdHJlZXMuIENvbW1pdCAzZTRi
ZTY1ZWI4MmMgKCJCbHVldG9vdGg6IGhjaV9xY2E6IEFkZCBwb3dlcm9mZiBzdXBwb3J0IGR1cmlu
ZyBoY2kgZG93biBmb3Igd2NuMzk5MCIpIHdvdWxkIHByb2JhYmx5IGJlIGEgc3VpdGFibGUgY29t
bWl0IGZvciB0aGF0Lg0KDQpbSGFyaXNoXSA6IEkgd2lsbCB1cGRhdGUgd2l0aCBGaXhlcyB0YWcu
DQo=
