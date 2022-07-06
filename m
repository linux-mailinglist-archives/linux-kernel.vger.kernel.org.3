Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535375681EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiGFIlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiGFIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:41:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B036424BD4;
        Wed,  6 Jul 2022 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657096873; x=1688632873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VPsKMNkXjZpdqbEjgsCQR2tNkFP+cnLo+fmaMSynjj4=;
  b=jgz4u/kATMrvY1m7NCkFi0s/TBgkXzuiKzhghewJQBJA3MbBdKoBAfdr
   oWC433x3Deampxa4MF82+puPhFWsXVDEhty5kCeYE5aZDzAkRrSFrU8d2
   tYo99jzbbR+VhP1lBCTaNKNeJS6zBbpu7VUt+XSCbEpx/HpTWYL11yNJV
   DnCtz+3PRoGn66VYlQFHjNBTX04103lKlbeWFrJ+MU8lQ5NPB4uGY0VO3
   3y2CDhWkS5uOdB7zq5mZz3MoMsW4A+MhTlv05gokgYYgcOHdpy5zhjGA/
   gqiN7Dm6GE2vdUAgBYG1k/tfHuHTXkA9Gd0mJ0a7KMOHY7Dn/VIqeFy29
   g==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="171236163"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 01:41:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 01:41:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 6 Jul 2022 01:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGE3IaHs4RyMVdWyNvOKZlylGmGiuEX3WMir7AEHj1Vnu6h7I9SMwwHQp4FDZrTMGeK7nNKHQvv8VkwoTb41iiOUO8Jn0C/zk9DcfuCzL1kYK0AmOdh6cY/s+t9M9D+tG1PDJivSvv5iuOmD8wD0wNcZ275fMAKMHzwodV3KtzmpshdZkkOAfOR19QBvuSvm/XgizbkkC9QAP47eY1GefHQ8iVyhV+BE7KseNoPX2nfor2DqQqjuXEeQAr6nx36hDCK1zgqRfSfV6iELhe1IhmkgimDdhZN+MWTN6S3lC5BPM/nzQMZCvD9Vw2Zh3lCOAyR5AMLJapQhSckD2raEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPsKMNkXjZpdqbEjgsCQR2tNkFP+cnLo+fmaMSynjj4=;
 b=TY3+tNhibQlJ0JZM8gWglKlbkLlYV2vNhQRQ8aTK5kS/e/MEDP5lLwt6ot0A35q0ZNpfssH6bo9FiIxaGhyzTpsJG9FZ49gmZat2tyPPDIv+AO7jfyaKwd3jC6aiXPo3EwsHAoEOiHTdiKI2xWZ3oI3mQunsLV0Wf60qa8RfjamPVXkNzpAMp4kdWIfSh1quPlrjcS1Zyb1esxJ1a0gHxDjIORFup17yeyA0FSKpsLSU1ZNTHxPzcWJ9fD6+lP3S220Gsmh75QGiuSxp+uBuijzb48780UZz2br1M4vWXVnMgTgUULXR+Wq/DRJ2BEB2T9NWM9I1gsXrbfixjglm2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPsKMNkXjZpdqbEjgsCQR2tNkFP+cnLo+fmaMSynjj4=;
 b=mbjAjMd8yP7RXeH6GR5A0F/nBeCwOYqn4u4BFSiEdHMRjO9py42pasGzFQ0DK6/o/7LueImXmfHqBYU16rZdJTGQNWFlYgM1tkNMQHZxQUT6Ar2eyxiQhct52Rf/dQeTeSBJ7FHkXd0oXdhwrtfeC2c2tPDK3uTIWdg8iyjQcQE=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by SA0PR11MB4541.namprd11.prod.outlook.com (2603:10b6:806:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 08:41:08 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0%10]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 08:41:08 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Cristian.Birsan@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: kswitch-d10: enable the USB device port
Thread-Topic: [PATCH 2/2] ARM: dts: kswitch-d10: enable the USB device port
Thread-Index: AQHYkRQjKznbj7Msf0eVP/ME+ToE5w==
Date:   Wed, 6 Jul 2022 08:41:08 +0000
Message-ID: <32a2193f-aea1-6237-a993-d0ba89cce431@microchip.com>
References: <20220705130637.1386120-1-michael@walle.cc>
 <20220705130637.1386120-2-michael@walle.cc>
In-Reply-To: <20220705130637.1386120-2-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a8fcb48-113e-48a3-ffe0-08da5f2b45a6
x-ms-traffictypediagnostic: SA0PR11MB4541:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oSpxG7Td/ZKIg0R12zfNCGIiD180vMotK55S3FCYXM1ki61OBskRc85/JDhKezwoVTFhUPSYHcrGgveMlaCrl9SdYcI1O5dB4SmTJhJeUNCr94jIWJN6HFWSn0l14pCyACgJz9qFpXZigMhT4i6fiKpddBjoOb/WYZjFZzz1POh8a3Kiy7Qzy4Dne2rI4Tv8lobIAJJOBJOlaDWxucC7FF2iUkLA3O1JUWKmhgyah2TP0tHgdFgpagfETj3dLBDCY3gJjIjy4Z5qUMfvx5I4JwyWiFcZ2Hlqsgmhqkxp1blz06Y+bc+R6dog/rcJ8z0fMkAPEAvzARHtduWdiasQL4pAUMN/XMN/HWaYWYTaaxxZp7a0v+Gn3H3YUPCir2k1iMQBAH+rQ6UV/Ng+PYaoaty/oemjx3Ba8KC24gb6AuhsyYisl4E/HrxpkapOTfASQZqYSiiwbFxjVBk+A4YxEjPJOMSiE+RYIHcZDdKIoBCnPM34Nu3+wcatUir7EUWk1jashIQZOWoe3Fl/NdJRa0SVDc3dBtY5OSkKrDwMIjZncjjLlMi76n1l2S0KHgI5f+3G7tUZluHvN7BFQRtSUwjziUxZfpMJlYQr6PkBXQRdnoF9nztln7Nzjjk4tqD/l119scNQc7HMhVStuvPiZPO1C2LzZ0eZvyvEmeBoT43xhodpwoZ7wgm0ERESgDRy/inH6V4IQuq6AKnQaDm0I6QhEtKjxZjIk/ALppTPO5/B32Kox6F45pW0ieyLdOkksdj7Rmiv1F3quyLZO6FaiSOlNupOIfUoWgy3q/j1eWa1hBpJbT74ySPEXtx3/fkrj9hR3b2dLcPtAGOyVs9GMYrovrrImCqUjoeQqPSU1cQnauD7w+1MBD0MMuABpq0jKsV4Fs6GQXHIHz1VTAY6uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(376002)(366004)(136003)(8936002)(41300700001)(71200400001)(966005)(478600001)(31696002)(86362001)(6486002)(5660300002)(2906002)(38100700002)(316002)(91956017)(2616005)(36756003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(186003)(4326008)(8676002)(122000001)(53546011)(6506007)(38070700005)(31686004)(26005)(110136005)(54906003)(6512007)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzVyTkRodS81bzdaN2JucGdaMHBwV3hONUk4QkdvS2MySjFsb2J1VGxzOXVC?=
 =?utf-8?B?S1N1cVY0WW5oRDg3aHpoS1VoaWVDM0Y1YnF1Y0JhU2h0OWV2Ui9JS1J0dXJJ?=
 =?utf-8?B?YWtVS3VndGpMMmlud1FZOXBTUEszcXEyVWtLUlVPQ0NWTGp2N1k5ZExPQTVN?=
 =?utf-8?B?aUI1UWpoams2TGo1ZWJEbEFzaUFRenlCNHZmQlBJUWFWZjIxOHNNU2FiZk1k?=
 =?utf-8?B?VUlZTThBSklvRktPWlV6cFE3RzZFQzlWalUrcFk5TmNnUFdTMjFpSHdZNVpF?=
 =?utf-8?B?b0pEQkg4ZUJZS0NrNE1IdzFieFNjV3ZqSWpTNENvbjJWMEo5Nm5RNXFXRDZz?=
 =?utf-8?B?cDltRks4OCtFVEkzZEdjOUQrTU1IK0c4RHA3V2pORDgzWUJlQ2prTzE5NW52?=
 =?utf-8?B?LzFHN1pUenh5M0N2ODBSL2l4L0FNWWVKTm1SYkNDNUlkbU8zVzhkRG9jVmFD?=
 =?utf-8?B?ZW5WQ1V0RWpiQ2pmVlNnb0pzMzkveVkxK08rcm40YXFyQXRDb3VUZjZ0N0hK?=
 =?utf-8?B?VUhMa2RNMThHc3VDQWhkZXNWemhyRFR1TmtOOEloazMwN0lsYmZ4YUpZcm1H?=
 =?utf-8?B?ZnJRUktCdCszVnUxcUQxdXkvMTNvQ0xzdE5QQ3hzMEpRSDlKYWtNTkIrTDMx?=
 =?utf-8?B?dWRXaXczMFI5S2ZNUitBYmMwRHpzOHJHaXUvR1NmMmV4cHVVYWJhRlQ4UTZ3?=
 =?utf-8?B?T0JVT2d3VG9lRVp0a1BZR1JUYklMdjFrUEpjbTRhYzJDRVNHTjdaQXp6ZjRZ?=
 =?utf-8?B?eEdiWENKbGcwN2tuODVUdnBiMnRDd08wclU4bnVOdmQ4Z1k4cjFXY0hRM1NV?=
 =?utf-8?B?UmFzcEduM1RrY1JnU2p3NS8rTXBIazEvbmlyRkt2L0NRVjdSNHdHOHhWRTc0?=
 =?utf-8?B?aTYwcXFpN05FYkk4aDMvRTN1ZjN2Z3FJZHNQZXJEWlg2bEM3TlZpblJIYURp?=
 =?utf-8?B?TCtqdks3Nlh0V0Z0aVljQzlwR1VNRUQrMEhzaTUvaVhWMDNQUDZIRTlJTTJj?=
 =?utf-8?B?cmVuUkRJTE5Mb0JGV2JsU1VmNjY3dk82V0c0S3M3MTFGUkVCa1BFeGI1ZThN?=
 =?utf-8?B?VFBKZDBmSlYzRm8rMk8rTXA3M2dDN1NMYWRnUlNZQW1ORW9xbEs0cTcwOGZL?=
 =?utf-8?B?WEZ1SXJaOXVucnRwd09KN3RYdnNzVG81U1BtSWpuM1NjMlZvK1dKemRqMkJx?=
 =?utf-8?B?NTVXWnZpbW5IOE5ua3VTUDQzbzg0L0dJWUoyY3ByTXBaYkJhUW41V3RiM1pM?=
 =?utf-8?B?MXFTSDZpQWlPSnptVnpHeDZUem10ZmpoZFpTMG5Pb3pXVnljNkdyS2ZXSjBl?=
 =?utf-8?B?eitGQXV3SDRsbUZ1c3Zxc01jY2F6TkdMeXlaQzNCbnNiTWZiZXN0TGxsTWVM?=
 =?utf-8?B?YnppOGFzL3cwc1dxWldSYXYzVU91cmdhN2VHVXJSVVoxY1pWZWhlU0hkZ3pT?=
 =?utf-8?B?WGZDdWdqZVBIOU90bzRKNlF0RWtabmFkZlBmYi9xdHBydFF6dVJISGVsanN6?=
 =?utf-8?B?N3J0SjBTS2h0b05JTW96S2RoNlNLeFNBY2lSN3RYQ0ZvYVNOYkk5SjQzN1Ry?=
 =?utf-8?B?OVBPQy8vWE5KRjEvQ0d1V0w4Q3FkaUtZOWZQN3J2dHNUZlV6WnhXenE3R1Zu?=
 =?utf-8?B?M0s4S1NPL1JmSXlJaDJIVEhnem0ycU9pVU5QNWYzdkNUNjhtbWVma0ROZGR3?=
 =?utf-8?B?UFdCeWFDOGJHb2VDV2t3UUlaOVM3U3dOS3RGUXJ4SUdDc1FiWTF0Y1RUZDFv?=
 =?utf-8?B?dGtvTDVIUXV4Z1d3MFN2S3duQzFrWFIvL2xkaExaemtlRWIyL2VqZ3RVZ2Vz?=
 =?utf-8?B?MHozVGNaVFNQVUtuUGwvZW9ldkRFdXo3bFhWUWlLdE4wRUxzVEhHVS9rb0NN?=
 =?utf-8?B?K2l0cXkrRmxjR052WEJZVWtMa1ViWVY2V1Q0bnp1MFBxZWlITnZYS1Q0SFFv?=
 =?utf-8?B?UVpHaTNxeGRnamU1UExla1Z0bHE1UWhUcVpSbDlDQ0tpUkpuVllvREE3ZXZm?=
 =?utf-8?B?MkZHYjJYU0ZWb1Nsc2FQYlNWUG9DaFA4Y1NvRGJSdmcxejR5QldqT2c1RFdx?=
 =?utf-8?B?RmRGNXhDc0VLQmI0d1kwSHZtUUJxS1IzRFBnNjNmMU1XbWFFZkFJRkhUb2JW?=
 =?utf-8?B?S0pZYVA0QWZtV0NDU29OcXdwUWkxcXNzekh5OHdNblRNRjJTcnI4c0Ywb01l?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1239B36C3CA6343B066E50F14986AF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8fcb48-113e-48a3-ffe0-08da5f2b45a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 08:41:08.2961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wglsxKRkUemFQTpNBkOQdaCA1fTwbOhPzDv9QAaZOS/sCmFH2XozoF93eiwaQyIj0VeovGreNo55XyV94519xElcQ/uwUEKeBEfk3PW1fsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4541
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1pY2hhZWwsDQoNCk9uIDA1LjA3LjIwMjIgMTY6MDYsIE1pY2hhZWwgV2FsbGUgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gTm93IHRoYXQgdGhl
cmUgaXMgZHJpdmVyIHN1cHBvcnQgZm9yIHRoZSBVU0IgZGV2aWNlLCBlbmFibGUgaXQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiAtLS0N
Cj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngta29udHJvbi1rc3dpdGNoLWQxMC1tbXQuZHRz
aSB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAt
bW10LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAt
bW10LmR0c2kNCj4gaW5kZXggNWE2YzVmN2MzNzFhLi5kMGQyNmUxMzZjMzggMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngta29udHJvbi1rc3dpdGNoLWQxMC1tbXQuZHRz
aQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAt
bW10LmR0c2kNCj4gQEAgLTIwMCw2ICsyMDAsMTEgQEAgJnN3aXRjaCB7DQo+ICAgICAgICAgc3Rh
dHVzID0gIm9rYXkiOw0KPiAgfTsNCj4gDQo+ICsmdWRjIHsNCj4gKyAgICAgICBhdG1lbCx2YnVz
LWdwaW8gPSA8JmdwaW8gNjYgR1BJT19BQ1RJVkVfSElHSD47DQoNCkNhbiB5b3UgYWxzbyBhZGQg
cGluY3RybCB0byBhdm9pZCBpc3N1ZXMgZGVzY3JpYmVkIGluOg0KDQpjb21taXQgNWJhNjI5MTA4
NmQyYWU4MDA2YmU5ZTBmMTliZjIwMDFhODVjOWRjMQ0KQXV0aG9yOiBDcmlzdGlhbiBCaXJzYW4g
PGNyaXN0aWFuLmJpcnNhbkBtaWNyb2NoaXAuY29tPg0KRGF0ZTogICBXZWQgTm92IDE4IDE0OjAw
OjE3IDIwMjAgKzAyMDANCg0KICAgIEFSTTogZHRzOiBhdDkxOiBzYW05eDYwOiBhZGQgcGluY29u
dHJvbCBmb3IgVVNCIEhvc3QNCg0KICAgIFRoZSBwaW5jb250cm9sIG5vZGUgaXMgbmVlZGVkIGZv
ciBVU0IgSG9zdCBzaW5jZSBMaW51eCB2NS43LXJjMS4gV2l0aG91dA0KICAgIGl0IHRoZSBkcml2
ZXIgcHJvYmVzIGJ1dCBWQnVzIGlzIG5vdCBwb3dlcmVkIGJlY2F1c2Ugb2Ygd3JvbmcgcGluY29u
dHJvbA0KICAgIGNvbmZpZ3VyYXRpb24uDQoNCiAgICBGaXhlczogMWU1ZjUzMmMyNzM3ICgiQVJN
OiBkdHM6IGF0OTE6IHNhbTl4NjA6IGFkZCBkZXZpY2UgdHJlZSBmb3Igc29jDQphbmQgYm9hcmQi
KQ0KICAgIFNpZ25lZC1vZmYtYnk6IENyaXN0aWFuIEJpcnNhbiA8Y3Jpc3RpYW4uYmlyc2FuQG1p
Y3JvY2hpcC5jb20+DQogICAgU2lnbmVkLW9mZi1ieTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhh
bmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0KICAgIEFja2VkLWJ5OiBMdWRvdmljIERlc3JvY2hl
cyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlwLmNvbT4NCiAgICBMaW5rOg0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci8yMDIwMTExODEyMDAxOS4xMjU3NTgwLTItY3Jpc3RpYW4uYmlyc2Fu
QG1pY3JvY2hpcC5jb20NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiArICAgICAg
IHN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gICZ3YXRjaGRvZyB7DQo+ICAgICAgICAg
c3RhdHVzID0gIm9rYXkiOw0KPiAgfTsNCj4gLS0NCj4gMi4zMC4yDQo+IA0KDQo=
