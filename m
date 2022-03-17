Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF34B4DBE24
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 06:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiCQFWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 01:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiCQFWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 01:22:30 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFC416C0B5;
        Wed, 16 Mar 2022 22:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647493893; x=1648098693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K1oKVoYhwcRbmTNZTg77ui1gGniwFZLSNK0N4sknb+k=;
  b=JLWqWzlBTMuLADUP00UKTgjjABcQju/38zNCCqhzmdkS3aVFFR35q7TU
   mISIiLCXgglAYgpK0v3YZc9PW4wRHtsJiV6aPj004VuEDwGy22qTNei6M
   cPjn/MqQupghtT+xAdvM13nbWGPd3dGruf1E1GSDVQFKw6K04FPWupP3A
   Y=;
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 04:49:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On9GD+EB1iC8MMiduCrbH/emLZz5FicOZCtymwNooX8tLD4uBPFdM1pS0HuRfjusgGRh15cKIhCaMOIJL2wBIydM+dQqFIfWXsTJEDu9505Ep5kT6Zs04H7sJQ880S1AutoIXX1xH+WpfcGKoJOpI5sWatc/Azh5JUD/g/JBAdqcN5BjR563P8C7IZnelbeiaVehwCrcCSmI5M1L5zlZ7ISL93iVcmF4UktI0ehpnoaWTuEt0zfUO4XvW2KjasR+rkF70Obn9I05vtZwMdakdv7eId+sDfC9R928yxWvwJH0Cxp4L+C6hvkh3eUkGIFZv413n21ikkgt8cXxVKEpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1oKVoYhwcRbmTNZTg77ui1gGniwFZLSNK0N4sknb+k=;
 b=n4HutVKf4cWx8R4pIWG+cy0VhJkXDGPxQY1nMr507KTzhkG/FJcEzoRHc9f1pdh4Q4ZOGPPjrRy1a4689464a09C33TU52pg9s1P9WP1EyILUgElXfGkW9Zc4pVZQgBGd8NrAu7Z08DFsmo5raHk2OWjEbGyE8rmA06AdTo5dJ99EhuDdxy8ZyxTbPT2voFtcBevSQVpLFfVhTIWL9JwSD86eS9c42wbnvVdCgxwAPmYp1YGkPRc1+lNrS+QmQzxS1XuhU7gsEyt/U6sPE3d85zgNVR4N+MYDynRnb7Z4adgplxXCx1iJ04GzJomcfZyk47OQfLgxI3LdCfS+nSCmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by CY4PR02MB2854.namprd02.prod.outlook.com (2603:10b6:903:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 04:49:26 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::7c0d:590f:5903:371c]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::7c0d:590f:5903:371c%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 04:49:26 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "Asutosh Das (asd)" <asutoshd@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Veerabhadrarao Badiganti (QUIC)" <quic_vbadigan@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: RE: [PATCH V4 6/7] mmc: sdhci: Set error state for mmc driver
Thread-Topic: [PATCH V4 6/7] mmc: sdhci: Set error state for mmc driver
Thread-Index: AQHYLjYRZaxmExKfPkmW2RHozg4LWKy1S+sAgAbR/YCABXtEgIABfyBQ
Date:   Thu, 17 Mar 2022 04:49:26 +0000
Message-ID: <SJ0PR02MB8449A9EBA3D25E957499CD6CCD129@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1646226227-32429-7-git-send-email-quic_c_sbhanu@quicinc.com>
 <01515ee6-b312-7f81-43f0-e72a0d290046@intel.com>
 <SJ0PR02MB8449518ACEA501523DB8E558CD0D9@SJ0PR02MB8449.namprd02.prod.outlook.com>
 <d30b5ded-c777-4de1-c48f-e7ac1ac37a3b@intel.com>
In-Reply-To: <d30b5ded-c777-4de1-c48f-e7ac1ac37a3b@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8c44c73-e949-4e71-2190-08da07d18394
x-ms-traffictypediagnostic: CY4PR02MB2854:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR02MB28540159A6BBB05D80D78ABAB1129@CY4PR02MB2854.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qd+l3HmW8rHyD3O+CGwEU0xIAt86EBRXaD0XdRmbE/DG8rLjgWbCpqVCvQjg9OdfXTK7dso2P7GuELLJutA33gY/ZUP88BWurgl1TPLid0h56iQ0ge/2IGoRK9EmSl60EFbPwvNCKerIgubT/h/rwdDiY41TzOpJE+KlMNpNFD6v++BTTLiNEIRq9E+YBgcglDyJlmjLINQCeXa//8ZLLwUkkIHJzU/zkbLgicClHHfUTEQwJ4VACuD7B3j0FNx2q77JbnOPAaaTPhpSHsNgmUmHML9dJIjjGZQ3KibmfVQbw9A8PE+C3tBjfukCpIKBGVUHAjMLgGcUmk550HfVIyqvldhhqeX/Nn6Ytmg8YUDLtFJpgTPzCAFxJQSQqtUkgQmWIFIyVT8xkcG0S6WfOVsQIXrs03WSTd2SQspDaaGz7US1rXaQ9eiIZ4MiptGgv46VmDL/nZN0Z8LO57ZcURda0cwCIXzOn5K5cKH7fQT6HqZsw+DIoTSRFARFhdm8RvfsxzDyLdl7YisOFj/9T+FeXxlYCnN8NkrZo7YceuvVYVTwaq0nz5ddF+K3G7GdcVjThAaDPWEt/v0gud+OEC+CpNCrCJs1gxmqjz+EoA01yDtb6622pc2VTvH6vBpBYQHTCT/WOyFWp0AZQovzn17d+IB4rQyW5jEYeAJVCQ169+UJlObB40MqChE+ONpEKBBC/QKlsTw1whz5xKSXHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(122000001)(186003)(4326008)(5660300002)(26005)(8936002)(66946007)(86362001)(76116006)(316002)(66556008)(64756008)(66446008)(66476007)(8676002)(38100700002)(54906003)(110136005)(55016003)(83380400001)(9686003)(7696005)(6506007)(38070700005)(33656002)(2906002)(53546011)(508600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NitUYlVUVmtSWFhQL2I0d1crRWdoaTBBbUlxSklFdU4xbm9KU1BKNFNWUDFJ?=
 =?utf-8?B?bTNXR2s3T0F5V2VFNzFlenUzWkl3c3JlWUVqNGFKNGtOM1JQSm50TTF6SjR2?=
 =?utf-8?B?Z2NtL0Nhd3pQQ2pkd3ZieFRMQzUrN0FPNURoT2ZQdmJWTnNtdmdoS3JmaExh?=
 =?utf-8?B?L2YxQ1ZXZHV3dVM1UXJzSEQ5ajV2ajNLQUxJYTVrZmxHQTZBbEp5OTFscjNO?=
 =?utf-8?B?aFFXT1BRYVMvaTNyUERxanIzdFFWR0dJWjNiQ0lPWlFseTE4cEZoeEhqbjNK?=
 =?utf-8?B?dittZzQzZTgzcjB2dzRpNnpFdjNhZStrc2pLYmNNTGJGaEpNQ0dxZWd3K3pn?=
 =?utf-8?B?eTFHZEl4cmtIS2I1RHNCcXZzZWNCMW5TaVBHU0w0KzdGdnBJNlZvK3ZacC9N?=
 =?utf-8?B?dVdzS2NyVVpNdkpHUWpmV0lheU1aNEFLTytBMSttYmMvb0ZtNjB2Mk9EY3V3?=
 =?utf-8?B?ZGVDT1Yxa3RoazNSdHdxZURmbjRwQkZ4ck90dUhXWHJPZEg5L3Z3ZlNzSldE?=
 =?utf-8?B?U2E2Mk9YbE5WSDdoalJNWm4wa2RNcnhPYlBscHFLTnpFRFB4Q1d0aW1Ranpm?=
 =?utf-8?B?QXA4VGlJamYrb0JQNXFEUkUwK0w5bSt0b2xGR1VjODk1MlM4UEJDK0h5MVpD?=
 =?utf-8?B?Nit2eis2UUhkWWhWRjFEcnFzRGdGbWNNRnNhdlYzaXAraTFMa0tyalpZZDIv?=
 =?utf-8?B?K05FdUNaVy9LajNEcktSeTZOSnJaWnNZTEZsU2FtOXhXTzcyZ29JTjBjcDRw?=
 =?utf-8?B?THM1T0NZMkpIL0Z6ZEJ0b1VPSmpxNlUybkYyNnd0RWM5N2FTNEJweURHZUxT?=
 =?utf-8?B?cUYyOVU0SVlmZlJKZEREU0RpS2ZBcVMvNHc1Wk5PWURxU3FZT3ViRzROSllU?=
 =?utf-8?B?M1JjQyszUEpkbTFKbDY4Qk9XcjlrcEc3YTZPQk5yOUczN29HKzhSa0tRWURP?=
 =?utf-8?B?cXBrSTJiMUZvTXU0bEpEWWNqOUJHOGpRVkdwdURvOEs1aW1Ed0FyYzNORHJY?=
 =?utf-8?B?MU1scTE5UFRyUy92RmxIQStIMXVwMFVQTUM1a3Rlc2VPaXQrU1c4UDFmdktU?=
 =?utf-8?B?YnR0L1NKcy9abXdNWVlrOHN1anRuYngzT0xpNjBDME9OOVgyZGZ0aktGTm1S?=
 =?utf-8?B?MHlVeWY0RkhnUXo3VWZLUy80bkNkN2x4cXFsQkFSdEV2UkM1WFBRTGhLSkR4?=
 =?utf-8?B?aklLMmNrRW96SzBZTHZydHpTWkc4Zzd6TVc2Y0MvbXBCSXRSZFozVTVLTjdt?=
 =?utf-8?B?UTFDNVBtdGFnMituUDNlbFVoOFlveWJxSjZlUXJsSXhhVWZsQldPbUtnQzlr?=
 =?utf-8?B?MGRCdXgrb2M4S2hLOWtmU0pBa1ByRFNhYk44WTVmUmt0d2FRQ3lqaGJpbjN3?=
 =?utf-8?B?ODBLaW0rL0ZPZEdjNW1ad0FycExkTUVtS2YrbGdFU2V0bWRjc2JVaHV5R01R?=
 =?utf-8?B?V2ltYmNFbDBBLzA0NUxiTnoxMUJpZWNtN1lpdncwM3dMRldKSGhlenhqc2NH?=
 =?utf-8?B?eUtBcTdwWmNQaThVaVgxTEFoY01iUEY5eW51UFVwVkJZcHRWSEpMZktzMlp5?=
 =?utf-8?B?SmZwRHNCWDBnL0JuRWdDcWV6QWJZZUg5eWE5RmY4eFAyMXFIVlBOM21VTDNl?=
 =?utf-8?B?MjNPTkU1djlwdTA2Ym02QnBnRE1sSzdERnNoMFdDbEFaZUx4Q2VkQ1ZHSnYr?=
 =?utf-8?B?UHVzT3VvYnZDV0tJNkZidWQ2blhKL21WdDJ6R3NseUlRdkVWWXlHM0RzQS8r?=
 =?utf-8?B?azZramJiUEVvWjlGK2N1bkhDdDBJZUdHNHdLaTZjUVpqL1ExRFphc0VoSENI?=
 =?utf-8?B?VDBsb0wyRkFuNFN4SGYvZkhaTGIvZHQ2WjZ4T2RTQ3ZOWncyMUlzZkZtM0Ru?=
 =?utf-8?B?Q0M3UmhtMmlRU0hsZXY1SjRKNE92a1ZTZU5iY1h4UGpWUUFUajhScVRsNDBa?=
 =?utf-8?Q?61rhwXsQB205ymF6HeY5oH/VNeD2Iz8r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c44c73-e949-4e71-2190-08da07d18394
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 04:49:26.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnUc6Vq1hw12t1/+9JfOALoaDucqqe2A0+HhzF4jaLN7Dhcjd2bK7jixXgPzSTLASAkK7g137wtDc9eH8TLsDb18XV8+QD7P6htM4dRAufU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2854
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJp
YW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxNiwgMjAyMiAx
MToyOCBBTQ0KPiBUbzogU2FqaWRhIEJoYW51IChUZW1wKSAoUVVJQykgPHF1aWNfY19zYmhhbnVA
cXVpY2luYy5jb20+OyBBc3V0b3NoDQo+IERhcyAoYXNkKSA8YXN1dG9zaGRAcXVpY2luYy5jb20+
OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPiBhZ3Jvc3NAa2VybmVsLm9yZzsgYmpvcm4uYW5k
ZXJzc29uQGxpbmFyby5vcmc7IGxpbnV4LQ0KPiBtbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0tbXNtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IFZlZXJhYmhhZHJhcmFvIEJhZGlnYW50aSAoUVVJQykgPHF1aWNfdmJhZGlnYW5AcXVp
Y2luYy5jb20+OyBSYW0NCj4gUHJha2FzaCBHdXB0YSAoUVVJQykgPHF1aWNfcmFtcHJha2FAcXVp
Y2luYy5jb20+OyBQcmFkZWVwIFByYWdhbGxhcGF0aQ0KPiAoUVVJQykgPHF1aWNfcHJhZ2FsbGFA
cXVpY2luYy5jb20+OyBTYXJ0aGFrIEdhcmcgKFFVSUMpDQo+IDxxdWljX3NhcnRnYXJnQHF1aWNp
bmMuY29tPjsgTml0aW4gUmF3YXQgKFFVSUMpDQo+IDxxdWljX25pdGlyYXdhQHF1aWNpbmMuY29t
PjsgU2F5YWxpIExva2hhbmRlIChRVUlDKQ0KPiA8cXVpY19zYXlhbGlsQHF1aWNpbmMuY29tPjsg
U2F5YWxpIExva2hhbmRlIDxzYXlhbGlsQGNvZGVhdXJvcmEub3JnPjsgQmFvDQo+IEQgLiBOZ3V5
ZW4gPG5ndXllbmJAY29kZWF1cm9yYS5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgNi83
XSBtbWM6IHNkaGNpOiBTZXQgZXJyb3Igc3RhdGUgZm9yIG1tYyBkcml2ZXINCj4gDQo+IE9uIDEy
LzAzLzIwMjIgMjA6MTUsIFNhamlkYSBCaGFudSAoVGVtcCkgKFFVSUMpIHdyb3RlOg0KPiA+IEhp
LA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KPiA+DQo+ID4gUGxlYXNlIGZpbmQg
dGhlIGlubGluZSBjb21tZW50cy4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBTYWppZGENCj4gPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQWRyaWFuIEh1bnRlciA8YWRy
aWFuLmh1bnRlckBpbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDgsIDIwMjIg
MzozNiBQTQ0KPiA+PiBUbzogU2FqaWRhIEJoYW51IChUZW1wKSAoUVVJQykgPHF1aWNfY19zYmhh
bnVAcXVpY2luYy5jb20+OyBBc3V0b3NoDQo+ID4+IERhcyAoYXNkKSA8YXN1dG9zaGRAcXVpY2lu
Yy5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPiA+PiBhZ3Jvc3NAa2VybmVsLm9yZzsg
Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGxpbnV4LQ0KPiA+PiBtbWNAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gPj4gQ2M6IFZlZXJhYmhhZHJhcmFvIEJhZGlnYW50aSAoUVVJQykg
PHF1aWNfdmJhZGlnYW5AcXVpY2luYy5jb20+OyBSYW0NCj4gPj4gUHJha2FzaCBHdXB0YSAoUVVJ
QykgPHF1aWNfcmFtcHJha2FAcXVpY2luYy5jb20+OyBQcmFkZWVwDQo+ID4+IFByYWdhbGxhcGF0
aQ0KPiA+PiAoUVVJQykgPHF1aWNfcHJhZ2FsbGFAcXVpY2luYy5jb20+OyBTYXJ0aGFrIEdhcmcg
KFFVSUMpDQo+ID4+IDxxdWljX3NhcnRnYXJnQHF1aWNpbmMuY29tPjsgTml0aW4gUmF3YXQgKFFV
SUMpDQo+ID4+IDxxdWljX25pdGlyYXdhQHF1aWNpbmMuY29tPjsgU2F5YWxpIExva2hhbmRlIChR
VUlDKQ0KPiA+PiA8cXVpY19zYXlhbGlsQHF1aWNpbmMuY29tPjsgU2F5YWxpIExva2hhbmRlIDxz
YXlhbGlsQGNvZGVhdXJvcmEub3JnPjsNCj4gPj4gQmFvIEQgLiBOZ3V5ZW4gPG5ndXllbmJAY29k
ZWF1cm9yYS5vcmc+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgNi83XSBtbWM6IHNkaGNp
OiBTZXQgZXJyb3Igc3RhdGUgZm9yIG1tYw0KPiA+PiBkcml2ZXINCj4gPj4NCj4gPj4gT24gMi4z
LjIwMjIgMTUuMDMsIFNoYWlrIFNhamlkYSBCaGFudSB3cm90ZToNCj4gPj4+IFNldCBlcnJvciBz
dGF0ZSBpZiBhbnkgZXJyb3JzIG9ic2VydmVkIGluIGVNTUMgYW5kIFNEIGNhcmQgZHJpdmVyIGxl
dmVsLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nbGlhbmcgTHUgPGx1bGlhbmdA
Y29kZWF1cm9yYS5vcmc+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBTYXlhbGkgTG9raGFuZGUgPHNh
eWFsaWxAY29kZWF1cm9yYS5vcmc+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBCYW8gRC4gTmd1eWVu
IDxuZ3V5ZW5iQGNvZGVhdXJvcmEub3JnPg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogUmFtIFByYWth
c2ggR3VwdGEgPHF1aWNfcmFtcHJha2FAcXVpY2luYy5jb20+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5
OiBTaGFpayBTYWppZGEgQmhhbnUgPHF1aWNfY19zYmhhbnVAcXVpY2luYy5jb20+DQo+ID4+PiAt
LS0NCj4gPj4+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgfCAyMiArKysrKysrKysrKysrKysr
KysrKysrDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gPj4+DQo+
ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS5jDQo+ID4+PiBpbmRleA0KPiA+Pj4gNzQxZmIwNi4uNGJhMzc5NyAxMDA2NDQN
Cj4gPj4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0KPiA+Pj4gKysrIGIvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS5jDQo+ID4+PiBAQCAtMjI0LDYgKzIyNCw4IEBAIHZvaWQgc2RoY2lf
cmVzZXQoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHU4DQo+IG1hc2spDQo+ID4+PiAgCQlpZiAo
dGltZWRvdXQpIHsNCj4gPj4+ICAJCQlwcl9lcnIoIiVzOiBSZXNldCAweCV4IG5ldmVyIGNvbXBs
ZXRlZC5cbiIsDQo+ID4+PiAgCQkJCW1tY19ob3N0bmFtZShob3N0LT5tbWMpLCAoaW50KW1hc2sp
Ow0KPiA+Pj4gKwkJCWlmIChob3N0LT5tbWMgJiYgIWhvc3QtPm1tYy0+ZXJyX3N0YXRlKQ0KPiA+
Pj4gKwkJCQltbWNfZGVidWdmc19lcnJfc3RhdHNfZW5hYmxlKGhvc3QtDQo+ID4+PiBtbWMpOw0K
PiA+Pg0KPiA+PiBJIHJlYWxseSBkbyBub3QgdW5kZXJzdGFuZCB3aHkgdGhpcyBjYW5ub3QgYmUg
YW5vdGhlciBlcnJfc3RhdHMgZW50cnkNCj4gPj4gc3VjaCBhcyBNTUNfRVJSX0RSSVZFUiBhbmQg
dGhlbiBhcyBiZWxvdz8NCj4gPj4NCj4gPj4gCQkJc2RoY2lfZXJyX3N0YXRzX2luYyhob3N0LCBE
UklWRVIpOw0KPiA+Pg0KPiA+Pg0KPiA+IEhpLA0KPiA+DQo+ID4gZXJyX3N0YXRzIGhhdmluZyBh
bGwgdGhlIGVycm9yIHR5cGVzLg0KPiA+IGVycl9zdGF0ZSBpcyBub3QgdGhlIGVycm9yIHR5cGUs
IGlmIGVycl9zdGF0ZSBzZXQgbWVhbnMgc29tZSBlcnJvcnMgb2NjdXJyZWQNCj4gaW4gZHJpdmVy
IGFuZCB3ZSB3aWxsIGdvIGFuZCBjaGVjayBlcnJfc3RhdHMgdG8ga25vdyBleGFjdCBlcnJvci4N
Cj4gDQo+IA0KPiBJbiBzZGhjaS5jIHVzZSBvbmx5IHNkaGNpX2Vycl9zdGF0c19pbmMoKSBhZGRp
bmcgZXJyX3N0YXRzIGVudHJpZXMgYXMgbmVlZGVkLg0KPiBTZWVtcyBsaWtlIHRoZXJlIGFyZSBj
b250cm9sbGVyIHRpbWVvdXRzIChzYXkgTU1DX0VSUl9DVFJMX1RJTUVPVVQpDQo+IGFuZCB1bmV4
cGVjdGVkIGludGVycnVwdHMgKHNheSBNTUNfRVJSX1VORVhQRUNURURfSVJRKQ0KPiANCj4gSW4g
ZHJpdmVycy9tbWMvY29yZS9kZWJ1Z2ZzLmMgY2FsY3VsYXRlIGVycl9zdGF0ZSBhcyBuZWVkZWQg
ZS5nLg0KPiANCj4gc3RhdGljIGludCBtbWNfZXJyX3N0YXRlX2dldCh2b2lkICpkYXRhLCB1NjQg
KnZhbCkgew0KPiAJc3RydWN0IG1tY19ob3N0ICpob3N0ID0gZGF0YTsNCj4gDQo+IAkqdmFsID0g
aG9zdC0+ZXJyX3N0YXRzW01NQ19FUlJfUkVRX1RJTUVPVVRdIHx8DQo+IAkgICAgICAgaG9zdC0+
ZXJyX3N0YXRzW01NQ19FUlJfQ1RSTF9USU1FT1VUXSB8fA0KPiAJICAgICAgIGhvc3QtPmVycl9z
dGF0c1tNTUNfRVJSX1VORVhQRUNURURfSVJRXSB8fA0KPiAJICAgICAgIDxldGM+DQo+IA0KPiAJ
cmV0dXJuIDA7DQo+IH0NCkhpLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9uLCBzdXJl
IHdpbGwgbWFrZSB0aGUgY2hhbmdlcy4NCg0KVGhhbmtzLA0KU2FqaWRhDQo=
