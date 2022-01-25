Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60A549BB72
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiAYSmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:42:13 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:46025 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiAYSli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1643136097; x=1643740897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6IPDphdWResLnTU5qLNy0xUCahQaHRAFrslYm3EPIVY=;
  b=Vq8csyIuuzE1FK3iKiPQ19BzQ/SZitPmv8E5HfCFuCaqdALBY8KcRCng
   5z8Boj+94expfeLS32Po6QzjfwA8GqCnu2+/S7vxuYIKMFIs+P+uj1vO7
   Ccvg/IiGpn/CTZTm+GYyWnJuu7xsd1eAV/WwDOKYji+6ATtNM3FfyEq9K
   I=;
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 18:41:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMeA8TLe9GfQseGqJAhaQMK0T7hUKeIhJ2iRwObR4LIfk5o32VeF+5BUe5svkMkZ0fMJTfcpni1V4gOGaeS12RBilRgmnlkKcDrCjNyw+UmndvweyhG81LwKW8cLRIFOoceeyyxTWebcNz4/bL5NKtFmpDk1b4c1T7vxCzvbJumbmS0mBU/x0Avu3FMV7eqqhBF6J3cyrvY1tueYTsXnQG/NXidtNpKaHIp55MP41lL+s3c/SEeuo2EfCCRg86m+86Ib+xeOI3othHki7cn7/QNo17WY445Tg1ftXwlGYd4hUTUA0tVrx3XiFSv4XPA+B4kLFH/de7dZYubSJogsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IPDphdWResLnTU5qLNy0xUCahQaHRAFrslYm3EPIVY=;
 b=ZbLRLEwFLFJy0dmeb9CBDMiFR/Jh8igt1dIzKDtrTuzzY/hpIZTdPokeRGR7QkDz87QOTNBZcn8WXjGWioyDeCHhy4uD1HUGJ1LdzK7kWVs8urWU0j2jtSTE2xZW83XBmONz5LH63JdFKXvBaE4jB9HpMYlELCh9h9QV6aLO8a+QoCOtA4SZSrQZak1F5FiMcgL2q9hm3IyoXp/X0Km3/VvKj4LfNXNhJWe+k1jPSlnzimkrn24iTAzJuTqnKg31eo1Kl0yGHfa2EsYRBC3YVwjBjYbnLweNrk/Qe/2j2nBsId7c8qlP5IXqZBVpTILfGhdSmXS4XVz3JrP4HNWXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by BL0PR02MB3633.namprd02.prod.outlook.com (2603:10b6:207:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 18:41:32 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%5]) with mapi id 15.20.4909.010; Tue, 25 Jan 2022
 18:41:32 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "Asutosh Das (QUIC)" <quic_asutoshd@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>,
        "nitirawa@codeaurora.org" <nitirawa@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        Liangliang Lu <luliang@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: RE: [PATCH V3 4/4] mmc: cqhci: Capture eMMC and SD card errors
Thread-Topic: [PATCH V3 4/4] mmc: cqhci: Capture eMMC and SD card errors
Thread-Index: AQHYDiL3Jty/xlZBLES4/23Rs8yToKxtI8iAgAb2RoA=
Date:   Tue, 25 Jan 2022 18:41:32 +0000
Message-ID: <SJ0PR02MB8449F16700C223CD5F6EA4F4CD5F9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1642699582-14785-5-git-send-email-quic_c_sbhanu@quicinc.com>
 <ba814e99-6c36-04a2-ca8d-0ba8473309d8@intel.com>
In-Reply-To: <ba814e99-6c36-04a2-ca8d-0ba8473309d8@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c46b64e5-eb5f-42f5-8c91-08d9e0324eb2
x-ms-traffictypediagnostic: BL0PR02MB3633:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB3633144DA64FC3973F3B2F8AB15F9@BL0PR02MB3633.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nD9Vs22Rm499irCbxVsLSDTVmnFLuFaUGu4PrH19+cJmTmGZ/oEB5LYSMcsUqQKjs/Qs2IbmizWMyoKMjUj42RLeV2r9Mx4quwpfXqWVgCi2BgXqBVoBuNJRCIpINo4OsdqiBcorsi99tbxVQJIrmQkiq9NHRWBCciOHgrstNMslblGcRElGsbOHYNOAzJAsG0k4IwrPkx78C5jU67vkh+LoCiTcaOGovWx+gtzys13GGPFc8weBDFio4eozxWq6Ch7P1WG6kg8sUW+Noco9SAiBikZ+/cuXIk0Z8e7B4Avb20AOSU4gdXiC3WuZJE6y+Cp6p80+GQVkQ72S8/1rRIO36Yfc2aMJMqMxV8XZgoDJrBPAhXYbZOEksHV3T6DBnZDg5CprMzY+iRtJuqo4YtbeuDKX2rPDGP/lc4VW00s4rRNdp0XFQYm14cetWDpNLN4Mrt9lMMGOP+/7ra6w/EsSP4Xc881jbvRMw41bCr322obNT1QtUlQfw+M1Vsz6ITu0CZEbhr+FpfzJlNItnjNQeAkSp0bi/9bmkzXbmmxUFiJZq0CMH2Idp/Pf33iY8ER9IzAWwUPCW2bGiMJA0BloJSxHmL4CnnkhYSrBtzvWMQ+Ogi+DCFTyufYylsAWjlh4tgJ8rsw6lum7ElfDp4GGbWj0ECDHIfwfeGQbUsVBcTE8W5XkCip6cYelsYy2nK2QsqBKKwflLG653qDfTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(122000001)(9686003)(7416002)(4326008)(8676002)(52536014)(5660300002)(53546011)(38070700005)(55016003)(86362001)(2906002)(38100700002)(8936002)(110136005)(83380400001)(508600001)(54906003)(76116006)(66946007)(64756008)(26005)(66556008)(66476007)(66446008)(71200400001)(186003)(316002)(33656002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkF6QVNXZ082cEpQOHdWY1lJYTd1N0lVRFI2QzFhbTdGME9tQUVPQXQwYjJ2?=
 =?utf-8?B?WGpycnBpOUFjNmtXQ3cxRTdNNUdaNkNuUjNnQ01NQUlEdzZ4YjFlQ3gwWW11?=
 =?utf-8?B?L2E1T3Z6NlVjbVNGdHBKdE9JQ05zRXkrR0YzQnJOTWpaZkZFSC9TS2ZzTDBU?=
 =?utf-8?B?VFZic2paNUNzZWlScVJjTFg5em1EWXJSVUNmTlZvVjZZTzZCTExXQ3FBNWJo?=
 =?utf-8?B?dEdXYmp2UU5IUU5GV1dHVURWR1hXcjNQN0d0dDlTRFIwNmVFTnZhMUJPS05n?=
 =?utf-8?B?R3NlVUJrTVFCZFk2NFljWS9xVVpLSWFGeFFpZ0tiK3NDKzB3cHZJZlFsTTRS?=
 =?utf-8?B?Q3I4RTZtWmc5Ry9zaUMybHgrL3BtNC9kckNpTTNFb2FpcnVwVTBXUzFielVz?=
 =?utf-8?B?VkE2bGlwMWNTdXd1alM5YU16cE9HYWxMOEp0b1pKLzZ6SDN0RkxheWpTWHFT?=
 =?utf-8?B?aHIxeHcxUXFKcDBKTTNwZjRlNHErSWxCcFo4SnBnZTgyTWZFVEt4RFZCSjI4?=
 =?utf-8?B?WjBEUkdQQjU0dXluN1poOWVoOXltSXZLRHZOUW5VVWdkM25CN0lhMzJGWEc2?=
 =?utf-8?B?RkdtK3BMZk40SGJaVGxCajQvTUlEeTl0aDhGNisxK1hSek9UcXhVUmswSFZN?=
 =?utf-8?B?RW5kdFZvd1d1TnJDZktPZDlNNGRnZWZhdFU2YTE3K0hSTTVLbCs4L0ZEU1R3?=
 =?utf-8?B?K0RES1IwSjdDREVyU1hWYVliWEo4Nkd0NzE1WTZVelZobmp5RGkzdXRjaDlI?=
 =?utf-8?B?NGJaR2hjb3F1b2I1cVQ3L1dsUHBlQS9CcUVMWnArUGJhdDJJQ0dqREhkRGhW?=
 =?utf-8?B?eGY2SEtoNlFVVnlQelBYcENCSlRKWTcvNFZGVWxON3F3YktaK3hlNHo2a0xE?=
 =?utf-8?B?V2N3Q1ZqZDgwbmg3QnJ3bVFIajRtU2JESTAwVElQTi9VdGd1N3NheTN6ZGw0?=
 =?utf-8?B?ODhVNXp4ZGtxSkFzSHp0RmF1bjZiWFljVDRIeG9vZGFKRktZUU5qbTJuc2N1?=
 =?utf-8?B?QjhxNklnR2xUSGJWWDJRRVZqSUFQTmJjRVRVa05VbElEZHU1eTFQRXJNalVE?=
 =?utf-8?B?VHo3L0VnNkUrODJFRXJiemd3VU5rU0lwTUdZdFhRSUNhblo2VXlLelpLWE9p?=
 =?utf-8?B?UWVyUEx0TUdnRkovUkNjNE84dVg1MWFRaE51Z25iVEhqT0NlVkd6djhuVTJ4?=
 =?utf-8?B?RERteFZJcFM1UnM0eDh2NEtyRVpESzg3bUUvdTl3QmdLM1piaitXUTBBWmZY?=
 =?utf-8?B?c3VaSytYUVMwaUlpeHZoL3BzSEFYWVhHaWg2MDZqUjUrRU05T09XMldVc3VJ?=
 =?utf-8?B?V3RsTGpORm1PSzJ0L0IrN0hBYWxmOE81MHFPUGNGeXV1UTZVVENFbGoyM1o1?=
 =?utf-8?B?b0pacHhWVmhXeUM1cGV5TzNXbHN3M05qRXFtbUd5dE5qSzdldEQ3Rk9sb3Bv?=
 =?utf-8?B?T0pJTjJXQ2o0dzFOS24rWVdJaU1oc0FDUENhempOVmVPQXZvVEpxYjh1MnZW?=
 =?utf-8?B?Y0NjRlliWk1DMElTSU1sYXd3dEpMSnRGSVVqc0JETUJnb0ZaRW96NUgrREpt?=
 =?utf-8?B?M2NoQnRvT3pjK2FIcHlXa0VKdXNuZXpLTERCRXBqMGMrRHZZYVQyK05TU0xZ?=
 =?utf-8?B?cytDRVZvaUJ6Mzk3d0MzZGZNbkdGSWtkS1lqazNYaFFFdXJoc2VRZlZIWUJ6?=
 =?utf-8?B?Z2U0dDF6SUdJR1NPSUZpR1FRZnB2b0sxcDRqdVFCN3pFRDdtQ2tTK1UxQW1D?=
 =?utf-8?B?V0trYUtvR3o0ajVVcGNubnBrT21tNE50K1JyYzArWi85N0R4M0drejJFM0Zw?=
 =?utf-8?B?M1ZsOThHLy90MGNSYWJvakFkc2dtWHYvWWl0aDh0TGI3T2xJL1JhTGx2TmNl?=
 =?utf-8?B?cytPOU5mUTFSY25RMmdLMklrSnU3OW5pNFBvT1Y2NTU4UXhwNHc1VzVwa0tL?=
 =?utf-8?B?V3FLQWppUkxTQUNjK2xHcml3ZTY2UkgySkhIczA4L1RBZm5zK2hZa1ROQ2hQ?=
 =?utf-8?B?V3dIS0JFdXFDNXo5UDZPN01iVnFRNUFwb0N2ZTdlNm9US0ZnMUk0NkhaV3Va?=
 =?utf-8?B?bXJNZk5tbDVSaEFmcmZ2WGRUSlk5NkFmV2xRc2tkcmRMWVUwaWhnRHY1dnR2?=
 =?utf-8?B?dFMxMGl6KzNFclNreWk4cW96L0JiaWp3cTNIc3NHRlN1TklzaVlkeXIwSGta?=
 =?utf-8?B?Ti9lZStUQ0RoRUc3TTFabGU5a0lKNlRmcFY0MFBraXBHbHM1VXNQYVBQV01w?=
 =?utf-8?B?V2FHN2xXWWxHclFSQTI5QU1tcXRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46b64e5-eb5f-42f5-8c91-08d9e0324eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 18:41:32.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dceERGcNyo01xCjaUWBW7sfkwtKVuuy9Kl0HUYI6MskDMb4z0J4TnIBayNxVGnboObayvo70D0TjQGGtMrRBlO8w6xhidfbedhJ8YBlanrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3633
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KUGxlYXNlIGZpbmQgdGhlIGlubGluZSBj
b21tZW50cy4NCg0KVGhhbmtzLA0KU2FqaWRhDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+IA0KU2VudDogRnJp
ZGF5LCBKYW51YXJ5IDIxLCAyMDIyIDE6NTIgUE0NClRvOiBTYWppZGEgQmhhbnUgKFRlbXApIChR
VUlDKSA8cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT47IEFzdXRvc2ggRGFzIChRVUlDKSA8cXVp
Y19hc3V0b3NoZEBxdWljaW5jLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IGFncm9zc0Br
ZXJuZWwub3JnOyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgbGludXgtbW1jQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCkNjOiBzdHVtbWFsYUBjb2RlYXVyb3JhLm9yZzsgdmJhZGlnYW5AY29kZWF1
cm9yYS5vcmc7IFJhbSBQcmFrYXNoIEd1cHRhIChRVUlDKSA8cXVpY19yYW1wcmFrYUBxdWljaW5j
LmNvbT47IFByYWRlZXAgUHJhZ2FsbGFwYXRpIChRVUlDKSA8cXVpY19wcmFnYWxsYUBxdWljaW5j
LmNvbT47IHNhcnRnYXJnQGNvZGVhdXJvcmEub3JnOyBuaXRpcmF3YUBjb2RlYXVyb3JhLm9yZzsg
c2F5YWxpbEBjb2RlYXVyb3JhLm9yZzsgTGlhbmdsaWFuZyBMdSA8bHVsaWFuZ0Bjb2RlYXVyb3Jh
Lm9yZz47IEJhbyBEIC4gTmd1eWVuIDxuZ3V5ZW5iQGNvZGVhdXJvcmEub3JnPg0KU3ViamVjdDog
UmU6IFtQQVRDSCBWMyA0LzRdIG1tYzogY3FoY2k6IENhcHR1cmUgZU1NQyBhbmQgU0QgY2FyZCBl
cnJvcnMNCg0KT24gMjAvMDEvMjAyMiAxOToyNiwgU2hhaWsgU2FqaWRhIEJoYW51IHdyb3RlOg0K
PiBBZGQgY2hhbmdlcyB0byBjYXB0dXJlIGVNTUMgYW5kIFNEIGNhcmQgZXJyb3JzLg0KPiBUaGlz
IGlzIHVzZWZ1bCBmb3IgZGVidWcgYW5kIHRlc3RpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBT
aGFpayBTYWppZGEgQmhhbnUgPHF1aWNfY19zYmhhbnVAcXVpY2luYy5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IExpYW5nbGlhbmcgTHUgPGx1bGlhbmdAY29kZWF1cm9yYS5vcmc+DQo+IFNpZ25lZC1v
ZmYtYnk6IFNheWFsaSBMb2toYW5kZSA8c2F5YWxpbEBjb2RlYXVyb3JhLm9yZz4NCj4gU2lnbmVk
LW9mZi1ieTogQmFvIEQuIE5ndXllbiA8bmd1eWVuYkBjb2RlYXVyb3JhLm9yZz4NCj4gU2lnbmVk
LW9mZi1ieTogUmFtIFByYWthc2ggR3VwdGEgPHF1aWNfcmFtcHJha2FAcXVpY2luYy5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9jcWhjaS1jb3JlLmMgfCA5ICsrKysrKysrLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5jIA0KPiBiL2RyaXZlcnMvbW1j
L2hvc3QvY3FoY2ktY29yZS5jIGluZGV4IGIwZDMwYzMuLjI5MDhkMzAgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qv
Y3FoY2ktY29yZS5jDQo+IEBAIC04MjIsOCArODIyLDE1IEBAIGlycXJldHVybl90IGNxaGNpX2ly
cShzdHJ1Y3QgbW1jX2hvc3QgKm1tYywgdTMyIGludG1hc2ssIGludCBjbWRfZXJyb3IsDQo+ICAJ
cHJfZGVidWcoIiVzOiBjcWhjaTogSVJRIHN0YXR1czogMHglMDh4XG4iLCBtbWNfaG9zdG5hbWUo
bW1jKSwgDQo+IHN0YXR1cyk7DQo+ICANCj4gIAlpZiAoKHN0YXR1cyAmIChDUUhDSV9JU19SRUQg
fCBDUUhDSV9JU19HQ0UgfCBDUUhDSV9JU19JQ0NFKSkgfHwNCj4gLQkgICAgY21kX2Vycm9yIHx8
IGRhdGFfZXJyb3IpDQo+ICsJICAgIGNtZF9lcnJvciB8fCBkYXRhX2Vycm9yKSB7DQo+ICsJCWlm
ICgoc3RhdHVzICYgQ1FIQ0lfSVNfUkVEKSAmJiBtbWMtPmVycl9zdGF0c19lbmFibGVkKQ0KPiAr
CQkJbW1jX2RlYnVnZnNfZXJyX3N0YXRzX2luYyhtbWMsIE1NQ19FUlJfQ01EUV9SRUQpOw0KPiAr
CQlpZiAoKHN0YXR1cyAmIENRSENJX0lTX0dDRSkgJiYgKG1tYy0+ZXJyX3N0YXRzX2VuYWJsZWQp
KQ0KPiArCQkJbW1jX2RlYnVnZnNfZXJyX3N0YXRzX2luYyhtbWMsIE1NQ19FUlJfQ01EUV9HQ0Up
Ow0KPiArCQlpZiAoKHN0YXR1cyAmIENRSENJX0lTX0lDQ0UpICYmIG1tYy0+ZXJyX3N0YXRzX2Vu
YWJsZWQpDQo+ICsJCQltbWNfZGVidWdmc19lcnJfc3RhdHNfaW5jKG1tYywgTU1DX0VSUl9DTURR
X0lDQ0UpOw0KDQpQbGVhc2UgZG9uJ3QgY2hlY2sgbW1jLT5lcnJfc3RhdHNfZW5hYmxlZA0KDQo+
Pj4+Pj4+U3VyZS4NCg0KPiAgCQljcWhjaV9lcnJvcl9pcnEobW1jLCBzdGF0dXMsIGNtZF9lcnJv
ciwgZGF0YV9lcnJvcik7DQo+ICsJfQ0KPiAgDQo+ICAJaWYgKHN0YXR1cyAmIENRSENJX0lTX1RD
Qykgew0KPiAgCQkvKiByZWFkIFRDTiBhbmQgY29tcGxldGUgdGhlIHJlcXVlc3QgKi8NCj4gDQoN
Cg==
