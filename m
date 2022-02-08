Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92624AD038
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 05:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346815AbiBHEOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 23:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346775AbiBHEOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:14:32 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 20:14:30 PST
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993D3C0401DC;
        Mon,  7 Feb 2022 20:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644293670; x=1644898470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hkdlrRiGJob7mOSUIMMFRYYr9ZiTtPDlhRZfevxiA4Q=;
  b=LjGOhw8SDHUyBBJ3E3amLNInwiBbhznOp4L3UCXab3uoQElHOO2CCdUr
   U+jJ+cAwfm7Pqaza5jKo4fB19zK/0X6dmS6PFwcGyI8mquyytSPbXhULr
   a4ngYSz9FM0rqLAjIl///XYjDtGOgokN16XgDFhHPWlHR29tTFvStBwAt
   4=;
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 04:13:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPqutOZSaidTNEYFXOeZMQ7EBbKU5BI1yTPlu1xqKhUDr4t4+busbjbXCmhaBqmunoqAFZuQ9QpfLXxS+0P4QO+8yOy97ghCRmOSn+XG4KU2OVKsEyzC2dg1j7uByxor/4eIN5WVhE3kfXz69EwVQoX7Quqt1GMERu1F7gi2lXvlTmd0s3yulIRmZjhEc/i5dq/vU4rzfmmxKTWU+7R6PCxII1/MbVgQPhcKW/wPLaQhc4ZYhZV1H1P62xcIfTIp+i0KMnFlG74+741bCGMOF0vNyGJAaepNk46WL/Ghwd74bh0b3qrkNsIuLWcgqsfZLuM75m1IYpzMrnNuiIa5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkdlrRiGJob7mOSUIMMFRYYr9ZiTtPDlhRZfevxiA4Q=;
 b=Wsu2DefOFXqieeTnT37KWwyKMtw/EaubRZXCulWSXLCcXuCMQDAZhRRQWtdgn2P9cpmhaR+Ss+jh3n1W7agGXjyTguv4HRBjLEejtogoTJV2cppFMsgBi0T7LO53VXzOaVzYekUEJb09LMGdfuB5BfQowzpMtOsfDL6S2+mj9L6E9wIvijpQur6qsAfrurRA0mze8ocPISq8pRV/jCRfvNw+vqNcs02bp1cBbhhPmhkRO4GIysYUQ4Fig59l1id01Gy+UwusgPjquZFRdem2Vwl+Ia3sYuN+nqHOL/t/l9nsFWBZF1lzZXF5lhV8LHbnlPHOtYuka8wyzsdWzyTPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 (2603:10b6:806:1e8::6) by DM6PR02MB4265.namprd02.prod.outlook.com
 (2603:10b6:5:2e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 8 Feb
 2022 04:13:10 +0000
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::45ac:4918:6d01:3009]) by SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::45ac:4918:6d01:3009%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 04:13:10 +0000
From:   "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        quic_bgodavar <quic_bgodavar@quicinc.com>,
        quic_rjliao <quic_rjliao@quicinc.com>,
        quic_hbandi <quic_hbandi@quicinc.com>,
        "abhishekpandit@chromium.org" <abhishekpandit@chromium.org>,
        "mcchou@chromium.org" <mcchou@chromium.org>
Subject: RE: [PATCH v1] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280
 crd board
Thread-Topic: [PATCH v1] arm64: dts: qcom: sc7280: Add bluetooth node on
 SC7280 crd board
Thread-Index: AQHYG9q6N7JJmMX7QUi4o6d+ajSBrKyIVEUAgAC4X3A=
Date:   Tue, 8 Feb 2022 04:13:10 +0000
Message-ID: <SN4PR0201MB8725DD28A5AF7D0E9E27C38BE32D9@SN4PR0201MB8725.namprd02.prod.outlook.com>
References: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
 <YgFTKid5hOCmSJHh@google.com>
In-Reply-To: <YgFTKid5hOCmSJHh@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b2793b4-73d1-426a-7625-08d9eab95182
x-ms-traffictypediagnostic: DM6PR02MB4265:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB42652B9B99059508D3930E4F9F2D9@DM6PR02MB4265.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQT9Yv2vXL5BZOjyjMDLrQdVvECIXpPxkfYPgSazt+PyxnjL0ZPWk2CqD1KGXLMTgd3GC3RWBsqRVCCpuHRpX3RW1MzcgibW3K1RPCVsY4cT7ZHv9cA0HuZmCY5k+J39XYDK9tAcDa1rudeifXuwIkGM/DlOgqB69QNBlg9HGmcS3BNV5R0I4Qi0z6reiO5mpvMJz41kWxW/8iYkQfWI+MMxqIV1yeVNBk7moIP+whNwpWs3vSc1s9Cljz7/6ZujBcSLZvYxiKB7P0P9cpeTPhMOiEtGBPKZcc7yp1rI3N0lJLmw1zp7wsRo5c65S51sb8Q2pknnppQUilkiZLZ96z28HAy9y9wti2EuTQBD+4NXoymIsNVD40KFcLIgwhMjjSsDWWlNAk3Zf61k8nWYpOTayzp14XW4zLiROQjTChrLbO0o9KokDE94F/0an/dkY1JVbL/Zk1ae5pntVqaBYSS0WnodHUy/BrBo0IaYk7Cp39xLwykWtlQxX4Jwog2fu4IpWrf/RXEKk7cfWzqX7aM+3zoJhQi9b7lTkGwJ5siNsBwANR6D0dHW8+/ZOa9r1aV/K2WigzCP+KroiDzZvm7ZHxCxyhOIzKnX2wgMJth2qc6KQvaeYWI1dKrQCnXRBdEdFZAiukGRya5QF5znsh3tjmUzpjmy+LJgp9dMqLgAAQkiPOzBTdQ7qWQJYxOUG9yjYDCh1jFABK4IbxJEXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB8725.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(6506007)(53546011)(33656002)(26005)(186003)(55016003)(7696005)(71200400001)(38070700005)(508600001)(86362001)(8676002)(38100700002)(122000001)(83380400001)(316002)(110136005)(4326008)(76116006)(52536014)(54906003)(2906002)(5660300002)(4744005)(64756008)(8936002)(66946007)(66556008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WStlRmFLZGR1TFE1SFQ4UjVSdnRXRG5LczJmZi9WWS9WaFFxVW1pM2tsWkJR?=
 =?utf-8?B?Ty9lYWtxbk1wZTExZnV3NGYyUHZwRzBIcXhZVEM5bWlCbmpzemNUcHZwZzFN?=
 =?utf-8?B?aGdEVC93b0MvaU45YUlRK2JRRk5MVGEydWpQOTMzSzB0d292VzVPU3E0eGNx?=
 =?utf-8?B?RmNyY1BiOW9qZUcrU2toRXFKemozTGVZTXdnaHhVY3VKU2JtRkVWVXFCaFRS?=
 =?utf-8?B?ZjVmb1hrdDBUOFo0d2FrN21JSnZFRkJ2QkFQSDNYajJaQ2NINllTS2Jwdmpl?=
 =?utf-8?B?d0plTTJMd3BiZ1FXY0w2dHN4SEgrdTZtbTBRTlpNTmt3bGE3ZzZlNkxqd2VQ?=
 =?utf-8?B?SkxTWUZOYUhMbTN6RzRTbm11VTVlLy9SclBzRkNac1Y4VzVrNUNzL2JqVmQ4?=
 =?utf-8?B?b3FqYVVNYm4xUjlIZnBHWmRTVGwzeDYrTzdpUGJERCtNdlZSUy9RV1plWkQ0?=
 =?utf-8?B?WVl0dFlRNm8zMFB3cFRUd3RwbXZaSmoyZ25hZnY5dzVDSVB6T1loeUhodUY1?=
 =?utf-8?B?M09oMmpCeUNRU1dpWi9CaENsY2dPSTJDeGE1QzA3S0k1T0pDdFk0dlQxSkFz?=
 =?utf-8?B?YzhkOXJ1WDlrQ1hZU1hUSldRTGNvcGVHNHgyZld0UFdBTkY3Y0IyY2w2NnVW?=
 =?utf-8?B?aEorRmRVZmhmS1lUZDJUbyt1a1h0ZmQ2YjFSckJRREwzZnZ5M25ZVDYyOGNG?=
 =?utf-8?B?NDdmNjl0dHRRQzVWVm11NGJNK3Avci9PZDJPdTg4bU9DNkhEcDNqUDVJRnVl?=
 =?utf-8?B?WWd6dEZFK0FHMG00K25EVlhycFZDeVg3KzlHdXgycUxQcll1MHZ0SmxkZGxG?=
 =?utf-8?B?UWlsTkQzNlBaaWtkWU1oV1Exb2lpSzFmUmFvTWF0R0E4ZWRRejZxNjdNTWta?=
 =?utf-8?B?VzVUUWxMcXFNQVVsVGZQMi9naTVPblJZSTRBL2V4TXNjVDF1czNrMVZhcG9o?=
 =?utf-8?B?eUpZbjB4VjZyMVF2RWlNcFh2djUvc280cXlPU29wLzE0NExuTURRNE12OXlZ?=
 =?utf-8?B?R2pzSnUvZjFyTFFUU25kOGFLelkwYXJoNUtrcG5MZG8xa0Q4MWVrSGcwNmN2?=
 =?utf-8?B?SEtvMlRTZlJMNDNZaWd5K2Fwd3ZML2NaVlR1ZGhCeFJFRU5GdXVrVmJPU0Iv?=
 =?utf-8?B?NG40M0xvUGVQWEh1amlDRlZvclhxdDIwS2ZFeGp0MnNGZFBDRFhmWXFHMjlv?=
 =?utf-8?B?L282M29RbUExNjhTOVhINDBZQjE0VTRxVnozeW9oNUhROGhzTmlsOEFEbDly?=
 =?utf-8?B?MEpDVFQ3cDVCbTFQQ0FXdktUeUJScisrbitpbFlubk1sbWdMZ3pNckZzNm5H?=
 =?utf-8?B?WEc2TEpHbE9HcDlUQUxZcTlxU2VHZ3YzU0lINWswMUpVU1hrL0IyZkEwZW1m?=
 =?utf-8?B?ZzJpb05XUU85ejRJRTM2UVVkZ201UzZEeGJMZGtpVmlpWno2a2VZYThHUzdF?=
 =?utf-8?B?aXJyMjJYSWluVmFxTno5MHZVWkpxWGU3bU5iRy9ZQmRjOW1UemJTcDZRS2lY?=
 =?utf-8?B?dUZ1aW03N2ROWGJTNFJLYWNRTzRnQ0c5WnVUVDBiSS9PVnhTMHNlSGF3UHcr?=
 =?utf-8?B?a0RySGIwMDhtZWhrYWthUjFqbjh3ZW9DUXdCTjA5QXRVUU1SMTlSTFM2Q1cv?=
 =?utf-8?B?dUJiMjNBWVRuczBDSzdUOW9Jc0daZFdndThLWHpGMVZPb0FxNXE1d0lPdXR1?=
 =?utf-8?B?bmtuVUxUMWpYZVc0UDgrWER3SWFDUDhDeUg4SUlGY3FLa1htVG5XNHY1N2da?=
 =?utf-8?B?Zms3bmxqQTBpMzIrbE9WOWw0c1hyR0xKeUNTYzd1aVZoVXN6MU1STnpQQVV3?=
 =?utf-8?B?c2c2Z1VhNTZKVnhtVERXc21BSzB3bzB2MExqYUVkdmZ3R2VsK25IMURXY2Mz?=
 =?utf-8?B?WlJaOE94SExWempKYTVqZzdZMmkrWllPaUtEZ2xvbGtaNWthaWdteGVxdlUz?=
 =?utf-8?B?WElmeStQeFZxeFB0TVl3Q1l3ZTNla0Z0eDM1VmlQS21keFFLeTlMSlVpRmRp?=
 =?utf-8?B?RFIwNGVzYWVjZm5hVjR4ZGV3VEN6eHQxTUxCUWhPYTJCWFQ3M2IxK29vL2JG?=
 =?utf-8?B?NlJibW0valNCaFo2ak9zUHRqVloxV20yS0d4cnhhdTFZdEpheUF3bk4xRDVW?=
 =?utf-8?B?cmZyV1N5elJ4N3UwWmtwWFNKaGVXNjV2RXB6YUpUb1I2cFpHU2s0Wml5eDVF?=
 =?utf-8?B?NkY3VlI3ZTdmVDdoNG1OMVI2L3ozTG03MjR3bW44SWptRW9xbUlRV2ZWQjE3?=
 =?utf-8?B?N29IR1I2K0tTWHNEd3RZaUcyZExBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8725.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2793b4-73d1-426a-7625-08d9eab95182
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 04:13:10.5739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXVqInCxdrM5g2zAi1mngznOo0SEiuoFeZPEDerTVSTSGH8PBnqi9aR8F5LRdu3puF6p1aIUtM1haO2oorgoGRkfDQjkuiAPwlsV9wwk3HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4265
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXR0aGlhcyBLYWVobGNrZSA8
bWthQGNocm9taXVtLm9yZz4gDQpTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDcsIDIwMjIgMTA6NDMg
UE0NClRvOiBTYWkgVGVqYSBBbHV2YWxhIChUZW1wKSAoUVVJQykgPHF1aWNfc2FsdXZhbGFAcXVp
Y2luYy5jb20+DQpDYzogbWFyY2VsQGhvbHRtYW5uLm9yZzsgam9oYW4uaGVkYmVyZ0BnbWFpbC5j
b207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtl
cm5lbC5vcmc7IEhlbWFudCBHdXB0YSAoUVVJQykgPHF1aWNfaGVtYW50Z0BxdWljaW5jLmNvbT47
IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnOyBxdWljX2Jnb2RhdmFyIDxxdWljX2Jnb2Rh
dmFyQHF1aWNpbmMuY29tPjsgcXVpY19yamxpYW8gPHF1aWNfcmpsaWFvQHF1aWNpbmMuY29tPjsg
cXVpY19oYmFuZGkgPHF1aWNfaGJhbmRpQHF1aWNpbmMuY29tPjsgYWJoaXNoZWtwYW5kaXRAY2hy
b21pdW0ub3JnOyBtY2Nob3VAY2hyb21pdW0ub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBh
cm02NDogZHRzOiBxY29tOiBzYzcyODA6IEFkZCBibHVldG9vdGggbm9kZSBvbiBTQzcyODAgY3Jk
IGJvYXJkDQoNCk9uIE1vbiwgRmViIDA3LCAyMDIyIGF0IDA5OjU0OjM4QU0gKzA1MzAsIFNhaSBU
ZWphIEFsdXZhbGEgd3JvdGU6DQoNCj4gU3ViamVjdDogYXJtNjQ6IGR0czogcWNvbTogc2M3Mjgw
OiBBZGQgYmx1ZXRvb3RoIG5vZGUgb24gU0M3MjgwIGNyZCANCj4gYm9hcmQNCj4NCj4gQWRkIEJs
dWV0b290aCBTb0MgV0NONjc1MCBub2RlIGZvciBTQzcyODAgY3JkIGJvYXJkDQoNClRoYXQgZG9l
c24ndCBkZXNjcmliZSBhY2N1cmF0ZWx5IHdoYXQgdGhpcyBwYXRjaCBkb2VzLiBUaGUgQ1JEIGFs
cmVhZHkgaGFzIGEgQmx1ZXRvb3RoIG5vZGUgLSBmcm9tIGluY2x1ZGluZyBzYzcyODAtaWRwLmR0
c2kgLSB3aGF0IHRoaXMgcGF0Y2ggZG9lcyBpcyBzZXR0aW5nIHRoZSB2ZGRpbyBzdXBwbHkgZm9y
IEJsdWV0b290aCBvbiB0aGUgQ1JELg0KW1NhaV06IHdpbGwgdXBkYXRlIGluIG5leHQgcGF0Y2gN
Cg==
