Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869AA563227
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbiGALEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiGALEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:04:37 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF0D7B34C;
        Fri,  1 Jul 2022 04:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1656673474; x=1657278274;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bv766joUVjhml/ohRewuiZUoQpgWryALAkuM5T2/NTU=;
  b=DriJBfY8sStlyjTJFerwu98iHtkrTSyqhb5zk7Da0x/k1Mj/kRbzfcEn
   9IwxbLm1ZTV0wR4HwW3gt2KNRPBGBg+wF8Qbmk2D+Wvo506eF5LTkqZrM
   A83YB403AFgIkQEzGoKOZzcPjRemEoEAtjXtNpBmmYc6whkgBijTYDN60
   U=;
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 11:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0wZ1Gd0EzEotnbEKcEBFgcloIqKurxC3BAV7QQ9HXjW6U133Ioqb7OnyjYN8JaLPPKG17Fp2dLAoSZIzzWzZIVeIr2A6yIrGH+adzhS4zfeaZBbG0HQzFFsZcWRjw40CHc6sYq0S5qRLCxIpEbVBPOyWTKxX1HDhY3c79JT9lHQsbk5/f8GAt9oDxBhHqDyWDVoTZmoZLKj3bp5eU6X77ypKQzszaKbxk3rOt9LzDYYpOoH32+RM2nsrWTkGIGeAK26bvPIV9eBnzo73Q0oMYindA9eyUXfCk3xdeuIzM+yxXO8BekazvbQgABeOlhnR9lY87+pGRKWdNFheodvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv766joUVjhml/ohRewuiZUoQpgWryALAkuM5T2/NTU=;
 b=AVMciDQkCcYXX6ClvJ831pGEyBN8i6xkLq49TDpLhU4H1MghaEo6Eka9g6g2AVAPtLLNYadAt1jLdbWF6wbusJ0RHECIgudYBH042pioMEXztrYPGYSEjGQiH5a6BPI4nJI69uoeHUAcu+5ssp+yZeOafwH5hpBR3fbMgVrf8Zr/nPvHrmfQIVI2xEbJ+t0v/UYZufipwynx5RZYLlkvuzBFOvWgrRpgCiV6ywYI9sVlqB75MAr1pvde7RB7DBOpnmxuNiTjbwANTozKRSbh+UJfsQLgYlE9EoditPZwVNpfnPnyXT5NSHVsBO/xu/NBYf31WMNWc92TATrzm3nj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13)
 by SA1PR02MB8397.namprd02.prod.outlook.com (2603:10b6:806:1f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 11:04:30 +0000
Received: from BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::e861:e6a:b148:865b]) by BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::e861:e6a:b148:865b%3]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 11:04:30 +0000
From:   "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
To:     Doug Anderson <dianders@chromium.org>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: RE: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Thread-Topic: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Thread-Index: AQHYi58pVIc+cNioKEmeVrCYMiTPqq1nBQCAgAJNqOA=
Date:   Fri, 1 Jul 2022 11:04:30 +0000
Message-ID: <BL0PR02MB4564A1EC37911A464BBEC260FABD9@BL0PR02MB4564.namprd02.prod.outlook.com>
References: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UXP+dfYEHpsS_djnWYxNVUS__2Uu5Mmxt2G4T=vfSSQQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UXP+dfYEHpsS_djnWYxNVUS__2Uu5Mmxt2G4T=vfSSQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cdefb14-8dd0-4220-3b96-08da5b5178c6
x-ms-traffictypediagnostic: SA1PR02MB8397:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ORsiSHXWlfCuk52N7kPaszhq/7EgrvHvgE8oC5CDJ6xGcYbOt5g2jZDzDp2Rxl8Js/EKLBqGWcZAR7kZS8hAK/i5oCvSohycpoUGzT3DfYVa0bB0FsbLypdi6O1hBHvp1UmV9hGW+HNtrVOpcTIEMqXHnUYsYPKCNRiL/36jtxsMDKhnwcChtKosFwDjIEGoGlcDg20e4PY0ogwtja1WJzolbIPzmu8yqCsI+DJ3xXq4E8VMs2e4t24xoydstqHg4eQ52N2pDDz0IK2rBzrzl5P3Y9wPCBhGcQDWPY03PWN2gb5qWlYscflCQ6YDWCIqAVdymPfLX5AQo+JF4JhM8nTW0r1qbdFCSnzmf8JreR6CrZZzLsRomNCXdjDkcCz9hi+DsOUDbj6/Uze11ddy8J+xJB2c8rsQq1usyjFHDs20YnCH304FGwOm8oQRGi2rBpojhbc+1irR6uqDeGgWcuP/ERVwVxWC77voYQ4Yrw9ULJw9yFpfAPfPueYk1fo5aI1O7dlbC3/RC26VrvcnF1QAUk5LRRLwjgmV6vdXFF+v47IzbpaoHI/GP1y1rDLG5HScgF7/aQuyzOQQ31VidzXGthcg8VMtw4E0gcOk4d8dzr8qDRUMUAptPm5ZDXuScy6rzQtqjGEZIFHpmnnob/POlN/EoBzl0foej7uj6r2nbi7agRaZl2uNSilF9gQi0aFoUB0deZEuRg6IqItjM0SLDe+o2HVSHAqRS+qa+PgRDqQZfrsq7y11hNaUJg93uzynGJjeeqSzCpSurlSyOWbvlGOWyq4B4OFZpCwpkTJWkTw3bI2vaU3ZK5l52vR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(76116006)(8676002)(64756008)(478600001)(66556008)(66476007)(52536014)(66946007)(5660300002)(66446008)(2906002)(33656002)(4326008)(7416002)(26005)(9686003)(86362001)(71200400001)(8936002)(7696005)(6506007)(41300700001)(53546011)(110136005)(55016003)(122000001)(316002)(38100700002)(186003)(83380400001)(54906003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ylk3YTJlRUN5cU93aHZNOStkSkxrcm5uOVdFWUJ5QnR2bXNlQ1p6OGtZVG9B?=
 =?utf-8?B?ZFF3ekRtZFZJVktQRGVsUDI0SGYyRDIzWURabXVQSXVCT2dRaGNOVVIvZm9L?=
 =?utf-8?B?bVdEWmFZakliY2w1KytkUWdFamVtejRKRW5PdDhUMGJFVXF0aEZUaUxxK1Nv?=
 =?utf-8?B?L3c3ZC82Zmdyc1M0RnQvbVpLcmtOOTJDSWdjU1poT1lsTXVvUUhYdVlITnRr?=
 =?utf-8?B?UmV4K3Qzdkg1ZmxPMk1Vc21Bc3VIR3c1eWdBR1NEc2VtSXAweW1lNHhkbEZM?=
 =?utf-8?B?VkFFejlIMGY1TlE5ckpkSnBKUG5uYnJtUmN6NCtNbTQ2MWhDTVI2ZENIT3Iv?=
 =?utf-8?B?ZHo0T3czOGJESXZGSmF2dXJmcUpwdUlmWjhBV3J5U1Z1L1FtUjRVRHk2RjlI?=
 =?utf-8?B?MFVxSk54bXBkRWwybytNN0hKU0hIMzdBTlpRS1grVU5BelVnZzgzSmlnU2gx?=
 =?utf-8?B?Q1VQYUdPeEVIeTc4dWd3L21iYmFZVmtKNzdRT2pQOXFvRW1UMkkvSGF3Z3Bx?=
 =?utf-8?B?K0dvM0NjZ09jM1czTGhLY3Z0Lzh1aTdlVmJyNldqdDg1My9ycS9iSDVpQzZK?=
 =?utf-8?B?Ym1QZWttSnRhWHI3eEIxNzArWTl1VjdWL2ZtV2hsa3ExMnRTVVE1KzBqZ1l2?=
 =?utf-8?B?TlcyOTVHanlyeHBYL3NLY1RWK0lTOXExSmtyRHZhOHY2S1VOWlZPZGdvQ1Nk?=
 =?utf-8?B?QW9uM1dPRVRZN1VodmFPaThwVTBWekhmYmpYYnZZSHFRRnJ0UzRlNlNRSTh3?=
 =?utf-8?B?dDdzRmlJYmtYWW9DeERCOWtZbTFNZFBvWjZSaXRsU0pQUXZmak1NUHFmQU9F?=
 =?utf-8?B?L0FNTlRBNDdLY25JQ2E4N2RJSUJtblcyNnVHK2ZnN2JSMTBvRXZkaUF6Y2x3?=
 =?utf-8?B?REM1Sis3T1hvWWtYeFpnZkhJbVk1ZDE1UFhhT2pxbXY5TE5jY3Y5UWIrMWVr?=
 =?utf-8?B?SUVRQlNWYXk5MEN6dTRJTk9VR2owbm5hV2xhdm9BQ3Bzb0hPRDc0bjQ1bHZq?=
 =?utf-8?B?Y0FEOUdGQ0VCcXY1Ni9OdFRiZzdQMXZ6QUNZTHlJUGI0bVdiRzhoUVgvZVBz?=
 =?utf-8?B?QW5naHhtQXpEa3oydWNXbGV4cHJtNVN6RjdpY2RPZVJqWXlxUkdEbnRlSy9t?=
 =?utf-8?B?QzYyekpSVjliRDVSajFDR1lNOXk3RS90blFoVFhFWlRYbStIT0k2cDIydWIz?=
 =?utf-8?B?NWNLOXo0cTlqUUdBd0hxNVJqcnVkeDRacjNzZDM1Z1pqRXU2Ukc2R0MraEUw?=
 =?utf-8?B?bWsranpiK0ZGWlZyN1lGYnNGWnM5T3NYZVZuM2lmVkhiaHBnMS9ZU1N3cnJE?=
 =?utf-8?B?STl1c1NvYlZwdHJpV1M0cXFpUFdGWExtR0NBdnpHTzV5L213MGJtYzNNZTBo?=
 =?utf-8?B?RVQ0RDZndnhWT2trOTlnaEtMWFBCbnJmSWkyME1IU01jUm1NSHFrTEVVQ1pr?=
 =?utf-8?B?eXlZODQ4cFlxYVdkbHN0SDdCNjZtVU1xWXY4SThhU3RaQ0hEd1pnSTh2TCtt?=
 =?utf-8?B?YThvdEtPTDlRQXRLMW5uamh4Y0I0VHkvOW5hcVk2SGFnN3ZDQlJma3BpMjQ5?=
 =?utf-8?B?bmdLRVRVcXpDL1owWVRyZHRXaHJuSitMbndYSWRmaWZsditwQWtlZlRNOEF0?=
 =?utf-8?B?MHNJUmE0VFNMc0VkSHB0cVQyc3I5Y2xrVTN1WEZTNXhpdjVRWlptZ00wYnMz?=
 =?utf-8?B?SDM0VXdsa3JDOVFqYjZZSDJCV3R5V25TU3QwbkppbmJaZUVWUDJRN3NuOUdy?=
 =?utf-8?B?cXBIaGg5Wjk2OGtEdEh2aXAyc0F4eTM4bi9uU3d3S2FXOWJPcDFkMWZBdFVL?=
 =?utf-8?B?Q3prakc2R2VNMlJnVU9KTC94WCtQdm9LOCtORFpFbDFvTTVqeUVHSUtRRXc3?=
 =?utf-8?B?M1c5Q3AwSG54ZDdlN2o0bVUrWUE1TVk1R2MvNzRJK2o1VCtFaDErZXMxeHZx?=
 =?utf-8?B?SGxEdTY5VFhEdjNKY2VPZFo4ZlhPdmo0VWcwc1hMUHRpSDNFTGN5ZGNIdU1s?=
 =?utf-8?B?SUJrdTNRTkRYREMxeHAvTE4wd0d5WlpDd1RHcmp1REdjb1ltb2ZQUFRJcWFo?=
 =?utf-8?B?NnQxRE5CL0VhYTR4SGpUUmhLYWo3aHZSa2tadnVLSGRuS2ZZWkx6RFY3bWl2?=
 =?utf-8?Q?v3f0XJiisX8G3CRpcljj+sFgX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdefb14-8dd0-4220-3b96-08da5b5178c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 11:04:30.2769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCU4G3Gf7K+L+QI96r0zo16MaaPFr4gbXOMa3oVb8y3MyGO+vnoFrTCAi4wrZk1cRSyVkbREJPjNS0dunhU7OBKp6CdnqGI0Ct+CSYwWj8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8397
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEb3VnIEFuZGVy
c29uIDxkaWFuZGVyc0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDMwLCAy
MDIyIDQ6NDUgQU0NCj4gVG86IFZpamF5YSBLcmlzaG5hIE5pdmFydGhpIChUZW1wKSAoUVVJQykg
PHF1aWNfdm5pdmFydGhAcXVpY2luYy5jb20+DQo+IENjOiBBbmR5IEdyb3NzIDxhZ3Jvc3NAa2Vy
bmVsLm9yZz47IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBLb25yYWQNCj4gRHliY2lvIDxr
b25yYWQuZHliY2lvQHNvbWFpbmxpbmUub3JnPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZz47IEppcmkgU2xhYnkgPGppcmlzbGFieUBrZXJuZWwub3Jn
PjsgbGludXgtYXJtLQ0KPiBtc20gPGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnPjsgbGlu
dXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgTEtNTA0KPiA8bGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZz47IE11a2VzaCBTYXZhbGl5YSAoUVVJQykNCj4gPHF1aWNfbXNhdmFsaXlAcXVpY2lu
Yy5jb20+OyBNYXR0aGlhcyBLYWVobGNrZSA8bWthQGNocm9taXVtLm9yZz47DQo+IFN0ZXBoZW4g
Qm95ZCA8c3dib3lkQGNocm9taXVtLm9yZz4NCj4gU3ViamVjdDogUmU6IFtWMl0gdHR5OiBzZXJp
YWw6IHFjb20tZ2VuaS1zZXJpYWw6IEZpeCBnZXRfY2xrX2Rpdl9yYXRlKCkgd2hpY2gNCj4gb3Ro
ZXJ3aXNlIGNvdWxkIHJldHVybiBhIHN1Yi1vcHRpbWFsIGNsb2NrIHJhdGUuDQo+IA0KPiANCj4g
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBTYXZlIHRoZSBmaXJzdCAo
bG93ZXN0IGZyZXEpIHdpdGhpbiB0b2xlcmFuY2UgKi8NCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNlcl9jbGsgPSBmcmVxOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKmNsa19kaXYgPSBuZXdfZGl2Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLyogbm8gbW9yZSBzZWFyY2ggZm9yIGV4YWN0IG1hdGNoIHJlcXVpcmVkIGluIDJu
ZCBydW4gKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghZXhhY3Rf
bWF0Y2gpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgfQ0K
PiA+DQo+ID4gLSAgICAgICAgICAgICAgIHByZXYgPSBmcmVxOw0KPiA+ICsgICAgICAgICAgICAg
ICBkaXYgPSBmcmVxIC8gZGVzaXJlZF9jbGsgKyAxOw0KPiANCj4gQ2FuJ3QgeW91IGluZmluaXRl
IGxvb3Agbm93Pw0KPiANCj4gU3RhcnQgd2l0aDoNCj4gDQo+IGRlc2lyZWRfY2xrID0gMTAwMDAN
Cj4gZGl2ID0gMQ0KPiBwZXJjZW50X3RvbCA9IDINCj4gDQo+IA0KPiBOb3c6DQo+IA0KPiBtdWx0
ID0gMTAwMDANCj4gb2Zmc2V0ID0gMjAwDQo+IHRlc3RfZnJlcSA9IDk4MDANCj4gZnJlcSA9IDk4
MDANCj4gZGl2ID0gOTgwMCAvIDEwMDAwICsgMSA9IDAgKyAxID0gMQ0KPiANCj4gLi4uYW5kIHRo
ZW4geW91J2xsIGxvb3AgYWdhaW4gd2l0aCAiZGl2ID0gMSIsIHdvbid0IHlvdT8gLi4ub3IgZGlk
IEkgZ2V0DQo+IHNvbWV0aGluZyB3cm9uZyBpbiBteSBhbmFseXNpcz8gVGhpcyBpcyB0aGUgcmVh
c29uIG15IHByb3Bvc2VkIGFsZ29yaXRobQ0KPiBoYWQgdHdvIGxvb3BzLg0KPiANCj4gDQoNCkkg
d2VudCBiYWNrIHRvIHlvdXIgcHJvcG9zZWQgYWxnb3JpdGhtIGFuZCBtYWRlIGNvdXBsZSBvZiBz
aW1wbGUgY2hhbmdlcywgYW5kIGl0IHNlZW1lZCBsaWtlIHdoYXQgd2UgbmVlZC4NCg0KYSkgbG9v
ayBvbmx5IGZvciBleGFjdCBtYXRjaCBvbmNlIGEgY2xvY2sgcmF0ZSB3aXRoaW4gdG9sZXJhbmNl
IGlzIGZvdW5kDQpiKSBzd2FwIHRlc3RfZnJlcSBhbmQgZnJlcSBhdCBlbmQgb2Ygd2hpbGUgbG9v
cHMgdG8gbWFrZSBpdCBydW4gYXMgZGVzaXJlZA0KDQoNCgltYXhkaXYgPSBDTEtfRElWX01TSyA+
PiBDTEtfRElWX1NIRlQ7DQoJZGl2ID0gMTsNCg0KCXdoaWxlIChkaXYgPCBtYXhkaXYpIHsNCgkJ
bXVsdCA9ICh1bnNpZ25lZCBsb25nIGxvbmcpZGl2ICogZGVzaXJlZF9jbGs7DQoJCWlmIChtdWx0
ICE9ICh1bnNpZ25lZCBsb25nKW11bHQpDQoJCQlicmVhazsNCg0KCQlpZiAoc2VyX2NsaykNCgkJ
CW9mZnNldCA9IDA7DQoJCT09PT09PT09PT09PT09PT09PT1hPT09PT09PT09PT09PT09PT09PT09
DQoJCWVsc2UNCgkJCW9mZnNldCA9IGRpdl91NjQobXVsdCAqIHBlcmNlbnRfdG9sLCAxMDApOw0K
DQoJCS8qDQoJCSAqIExvb3AgcmVxdWVzdGluZyAoZnJlcSAtIDIlKSBhbmQgcG9zc2libHkgKGZy
ZXEpLg0KCQkgKg0KCQkgKiBXZSdsbCBrZWVwIHRyYWNrIG9mIHRoZSBsb3dlc3QgZnJlcSBpbmV4
YWN0IG1hdGNoIHdlIGZvdW5kDQoJCSAqIGJ1dCBhbHdheXMgdHJ5IHRvIGZpbmQgYSBwZXJmZWN0
IG1hdGNoLiBOT1RFOiB0aGlzIGFsZ29yaXRobQ0KCQkgKiBjb3VsZCBtaXNzIGEgc2xpZ2h0bHkg
YmV0dGVyIGZyZXEgaWYgdGhlcmUncyBtb3JlIHRoYW4gb25lDQoJCSAqIGZyZXEgYmV0d2VlbiAo
ZnJlcSAtIDIlKSBhbmQgKGZyZXEpIGJ1dCAoZnJlcSkgY2FuJ3QgYmUgbWFkZQ0KCQkgKiBleGFj
dGx5LCBidXQgdGhhdCdzIE9LLg0KCQkgKg0KCQkgKiBUaGlzIGFic29sdXRlbHkgcmVsaWVzIG9u
IHRoZSBmYWN0IHRoYXQgdGhlIFF1YWxjb21tIGNsb2NrDQoJCSAqIGRyaXZlciBhbHdheXMgcm91
bmRzIHVwLg0KCQkgKi8NCgkJdGVzdF9mcmVxID0gbXVsdCAtIG9mZnNldDsNCgkJd2hpbGUgKHRl
c3RfZnJlcSA8PSBtdWx0KSB7DQoJCQlmcmVxID0gY2xrX3JvdW5kX3JhdGUoY2xrLCB0ZXN0X2Zy
ZXEpOw0KDQoJCQkvKg0KCQkJICogQSBkZWFkLW9uIGZyZXEgaXMgYW4gaW5zdGEtd2luLiBUaGlz
IGltcGxpY2l0bHkNCgkJCSAqIGhhbmRsZXMgd2hlbiAiZnJlcSA9PSBtdWx0Ig0KCQkJICovDQoJ
CQlpZiAoIShmcmVxICUgZGVzaXJlZF9jbGspKSB7DQoJCQkJKmNsa19kaXYgPSBmcmVxIC8gZGVz
aXJlZF9jbGs7DQoJCQkJcmV0dXJuIGZyZXE7DQoJCQl9DQoNCgkJCS8qDQoJCQkgKiBPbmx5IHRp
bWUgY2xvY2sgZnJhbWV3b3JrIGRvZXNuJ3Qgcm91bmQgdXAgaXMgaWYNCgkJCSAqIHdlJ3JlIHBh
c3QgdGhlIG1heCBjbG9jayByYXRlLiBXZSdyZSBkb25lIHNlYXJjaGluZw0KCQkJICogaWYgdGhh
dCdzIHRoZSBjYXNlLg0KCQkJICovDQoJCQlpZiAoZnJlcSA8IHRlc3RfZnJlcSkNCgkJCQlyZXR1
cm4gc2VyX2NsazsNCg0KCQkJLyogU2F2ZSB0aGUgZmlyc3QgKGxvd2VzdCBmcmVxKSB3aXRoaW4g
dG9sZXJhbmNlICovDQoJCQlpZiAoIXNlcl9jbGsgJiYgZnJlcSA8PSBtdWx0ICsgb2Zmc2V0KSB7
DQoJCQkJc2VyX2NsayA9IGZyZXE7DQoJCQkJKmNsa19kaXYgPSBkaXY7DQoJCQl9DQoNCgkJCS8q
DQoJCQkgKiBJZiB3ZSBhbHJlYWR5IHJvdW5kZWQgdXAgcGFzdCBtdWx0IHRoZW4gdGhpcyB3aWxs
DQoJCQkgKiBjYXVzZSB0aGUgbG9vcCB0byBleGl0LiBJZiBub3QgdGhlbiB0aGlzIHdpbGwgcnVu
DQoJCQkgKiB0aGUgbG9vcCBhIHNlY29uZCB0aW1lIHdpdGggZXhhY3RseSBtdWx0Lg0KCQkJICov
DQoJCQl0ZXN0X2ZyZXEgPSBtYXgodGVzdF9mcmVxICsgMSwgbXVsdCk7DQoJCQkgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgID09PT1iPT09PQ0KCQl9DQoNCgkJLyoNCgkJICogZnJlcSB3aWxs
IGFsd2F5cyBiZSBiaWdnZXIgdGhhbiBtdWx0IGJ5IGF0IGxlYXN0IDEuDQoJCSAqIFRoYXQgbWVh
bnMgd2UgY2FuIGdldCB0aGUgbmV4dCBkaXZpZGVyIHdpdGggYSBESVZfUk9VTkRfVVAuDQoJCSAq
IFRoaXMgaGFzIHRoZSBhZHZhbnRhZ2Ugb2Ygc2tpcHBpbmcgYnkgYSB3aG9sZSBidW5jaCBvZiBk
aXZzDQoJCSAqIElmIHRoZSBjbG9jayBmcmFtZXdvcmsgYWxyZWFkeSBieXBhc3NlZCB0aGVtLg0K
CQkgKi8NCgkJZGl2ID0gRElWX1JPVU5EX1VQKGZyZXEsIGRlc2lyZWRfY2xrKTsNCgkJICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPT09Yj09DQoJfQ0KDQoNCldpbGwgYWxz
byBkcm9wIGV4YWN0X21hdGNoIG5vdy4NCg0KV2lsbCB1cGxvYWQgdjMgYWZ0ZXIgdGVzdGluZy4N
Cg0KVGhhbmsgeW91LA0KVmlqYXkvDQoNCg0K
