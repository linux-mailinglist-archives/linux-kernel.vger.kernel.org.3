Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3817C4D7040
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 18:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiCLSAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCLSAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:00:17 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630E43EE9;
        Sat, 12 Mar 2022 09:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647107949; x=1647712749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4H3HOD4536zpLoVyHeEp1wtdXI9f/026eGLtEXNyNyE=;
  b=w8xkjVBrVZL0qk9JJq4u7GQzTGsRXyZYd5fsjSVn/O3i3wvVIpV4UkA5
   tlu0dRbls9GvCYkYBlRtovGHacmVIZLQbMK/X4clO/gCxX/483kjD37P+
   y2sbcdkSaE2TgIp8s9pPODEla4EXVomFmNE6ed6at0HUEP95SYONVjrtK
   s=;
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 17:59:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4KXPMaboAnsEdVmdkRYIiNyvhKbMvr0E9j9rkBebq7OoazSwfdDY8EnlAJEs83mzHR9X/sqBXSVllz9qbwvcUkdGxn7LJi/j6Vp11kvla1U19oIkBG4olYXDI1wIzLM43QGcTQfRZjolNO1SBGdK/y+ya9QgNLr9QfWhvchrlSqJO9usm2jZxENyiR8moIAnXKpQ2JVsE512wzD0geAVx3Qz6KGurhZ5PRv7Qaj5nukCRvNDEBjVEmBHOip8gg18KojpEDSMZAuTTW66Di/A/q1ZVNFBPAwSjva3BL+TAfHvJCFsypGl2O7/R7BlOoFNLyyHFS816DSFhKQ4QQv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H3HOD4536zpLoVyHeEp1wtdXI9f/026eGLtEXNyNyE=;
 b=dsYUoNJgklJHzu4GBXDPEVjiovHTuylNMXSeVvuzRQ0RAo7NacElBh2pqPbQNrNlnrKm/ECRlb0dluousr+ULSfkvfnu89NwHV08HAHKyC2/ReuFTqClzOczV8g5GyGefuoweP+i022ExWdrLGjSEjVx1uOymoUjZ443R2UNrxrAn3L6FCWDYcr9oyPnyLvLwfnjeHkSvfrE7j3TWgqZ2ueRvD5K6rYKH/UjhJVctTs+ndZXsnlLUA5HPWrS+ORTTp4DlJqsIG7BByrCBSwaTG8LhvVw86p28JQmNLHKv3PU3ENPoPvH/MMA3IYslFi4Tm/37W9cmjI344cX2Rd20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by BL0PR02MB3860.namprd02.prod.outlook.com (2603:10b6:207:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Sat, 12 Mar
 2022 17:59:05 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%7]) with mapi id 15.20.5061.026; Sat, 12 Mar 2022
 17:59:04 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "quic_riteshh@quicinc.com" <quic_riteshh@quicinc.com>,
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
        Liangliang Lu <quic_luliang@quicinc.com>,
        quic_nguyenb <quic_nguyenb@quicinc.com>
Subject: RE: [PATCH V4 1/7] mmc: core: Capture eMMC and SD card errors
Thread-Topic: [PATCH V4 1/7] mmc: core: Capture eMMC and SD card errors
Thread-Index: AQHYLjZpyTlE3PMrg0yUDTHrQR1moqy1RcoAgAbTfYA=
Date:   Sat, 12 Mar 2022 17:59:04 +0000
Message-ID: <SJ0PR02MB8449F9A75D973EF93EC4D0A7CD0D9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1646226227-32429-2-git-send-email-quic_c_sbhanu@quicinc.com>
 <c33540bc-0466-5a28-c85d-bfc8934b8c15@intel.com>
In-Reply-To: <c33540bc-0466-5a28-c85d-bfc8934b8c15@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b9ca112-ee5b-4f77-4c18-08da0451ff0f
x-ms-traffictypediagnostic: BL0PR02MB3860:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB38607A2D29CAB4DC969C5673B10D9@BL0PR02MB3860.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 78ysY89NqQqd4ZI3EXdF3daiRKb+H8SszWJCBGvlMX4zrKPtUGLKoLUVLX9dQmYluDpwAWslgFyDBeeWiEqsYaEHQquUObliuu4w/mBSWKrCxGs2JCViZd0tTl5fDJnhbrF76Sy5FVMFh31YpPPenKhH+ktJnuxNuEJEeV16I+nY7cpGbRN5Ziudd9jYB1k7KMt3EctCfUo8Rk3HmZLKi4scEV7fuRgG0aQ7YsrQOP5u5j7a5dZyep7jGhxnfLYtNAHZw2rYrvmAB0yOhKSjNo/zro4yyBvS4ng8ARLbOiAVfzHXsJkVNIIL7HLNLQC9RnBtLNkXfwuJIMokEyx9ZT5H6IXDUN4uRlEEfF15F1hma4quJrlakPkn4H3PmkzG6WtL60c63jUui84P0VY46WFF4zb1WNQ3qkvu6u9AXK0sRk+5BkhixYmrYyXqrLrssahZf2zMx3x1Df+ZmLzW1tqdH0t5CUNJQLx4+psSLoJCROnf811ng17VO7n/803XKf4bz6nNwE9Ph7knTR0jAuF01GdaM7ISeU4CNd0Z6LEwFarDKi6H+bkQrn7i94gNJRfSEV7Z07V82bVqsvgpIDBc+pNwH/HnlSIN4xdiUp0cNTFi+uw8V6KuV+fTnF3LMza7YDIjq61QqiagAcGIdVoMzCBzOxIcctSn56EOdDYOe4hD7CE9ItdrgxG+9F1LXwXDdiLCpzIIPEcjEnFzap8a8oi6/8t/p7SmY6MbSyg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(186003)(26005)(86362001)(921005)(508600001)(5660300002)(9686003)(107886003)(38100700002)(33656002)(83380400001)(76116006)(66476007)(38070700005)(53546011)(71200400001)(316002)(6506007)(66446008)(7696005)(4326008)(52536014)(110136005)(66556008)(2906002)(64756008)(66946007)(54906003)(8676002)(8936002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0FXeEZtVnFiUmxjNmRNdFkvV2wrSmpxSVFvNjBJdXFxUTZRU05MQUw5MXVr?=
 =?utf-8?B?WjhoSGtleDJJU0VSTUhvdlprcW5HK1MvV0JtWlVBS0h0VStWUHFQTFJwZWl4?=
 =?utf-8?B?MWQzUlh5U244Rlo1SE5TdHlzVms0UHRaa0ZMZlpBRnBkOGdIOW12WFN5dDZP?=
 =?utf-8?B?T1IxeUxwZEowY1B5WVdyM05GLzY0TmNSR1BJbGk2U1JPaDNkdkhaR2FlQWp0?=
 =?utf-8?B?enA1K082TmtVZkhQTnlreExqZnpJNWg3WDdPcVdpVlg3dFFxNFRGenhUUG5x?=
 =?utf-8?B?Nm5FSDlpRmJpSmxnNURvZmtWcDd0ZTJvbGFoM0Y0MGdBR243TTQ4LzZVUk4w?=
 =?utf-8?B?TDZjNzhKbWxOMGEvVnlTcTVkcGVWVkxrZjhOZlYxZHh3WXBqVHlhbko0UUhK?=
 =?utf-8?B?azAyZEdXY3hoa3BwRi95OW1VOFhLZ3l0RERhWHZHMkVPUzRYU1Q4azJMenV3?=
 =?utf-8?B?RXQrZi9FMzZWVVhRMXhhSTBvT3ljZGVlalJNK05VUTVhU3MxSDMxNC9rdS9G?=
 =?utf-8?B?RCsrTzEwTHd0QU1IaHRiL1EyWE5IRXE1cDdyVzRqcTJ2YXhLbFlQaDBHdmJo?=
 =?utf-8?B?alZEQjR5RVBmLzNCV1Y0VUhVZmRkQnBXZmltMmpBWkw4TEVtNDR2cHVkMXU2?=
 =?utf-8?B?b2JRVWh5M3dsNWExV3Z2cGhCR0lWVEhzL2VqZHpVZ014dFJhMG9DNzUyaVRD?=
 =?utf-8?B?aTkzbmtJRGptTGxUYTRya0JVWDJjVFJhZHZ5dXNkd2xNeDh5VjVSaFJkNXg3?=
 =?utf-8?B?ekJlOG04WWc2dUY1d2FjdjdTQ1c5STVOSy85OUxnWU1MSzUrSDk1cTBJWk5L?=
 =?utf-8?B?RzFqS1Fkb0U3Tnh5NmY3UVVkSExtYldzV1E0Q2EyODhiRTlZRlNxcjVaelI2?=
 =?utf-8?B?UDQvY3I1UkFkZXc2WTFScGtIR1AvN2NoclFnTjYyYkdjYWpJa1NHb0o5dHJ2?=
 =?utf-8?B?RHEwbUV2QzJQM0pkWmRpcGtlTXdaWWF1aGZ5TElPZmtMNSsrejQ3NVc2dlR3?=
 =?utf-8?B?QnBaeXFPd0dzcXZqdGYra1RKenE1dUdYSS93VTlISXA3OUVhM1dYa2dFMndz?=
 =?utf-8?B?aXJIcXFpak92VytpWWdRU3Y4ZlFZTnRuMHRiY1ArY203dnFKc0xHTEsyK084?=
 =?utf-8?B?Y2hmSktFcjFESzV6YkNRdUZSVjRoVGRGTEZXbjhpeWNGamRaNmxjR1FTelVs?=
 =?utf-8?B?aDZSbHBVRTNFdTZ3RWZWUk5Pck1oODgrS1NQdVBiUG9adUtjRldtdHkvc2Ex?=
 =?utf-8?B?ekt5SktYbTFVaFJBNTVPcUM4bjdyZ1ZiRlBqazZqdUNXUzc1UzloNTc2eGdJ?=
 =?utf-8?B?eFdoVmpTQU9VTjNDK2ZmclV2eUhlcVJLYk1XSGY4cUUwMEJVKzl5TjcrNndJ?=
 =?utf-8?B?NDZaeW5xc3I5U3ppR05qcXlsMloxamlQeEcrZWJMTHBlZ1FPSTY0aVBSUW0y?=
 =?utf-8?B?MlQwbS9jbHBYa2NYMjcwTlZ0b2V6Mi9KYlBBMFV1a1VVdHRXRXhkK05UZ1ZT?=
 =?utf-8?B?cUR2cFZZeW9TUGtNUlp3dUh3d3dxYkRKc3ppekZjQWIrUVc1aks0NmNRRUpP?=
 =?utf-8?B?SHVQWU1BQ3Bidjc4SDNoalc2RXM3RlJHbWNoMzdOeDBFSW5Hb3Q3WFVpSEFw?=
 =?utf-8?B?T3lsSlU1eXhjYngzdlRZc2plY29QSnpneFBzR3MxMkY2WkFmeUpYemphSHdY?=
 =?utf-8?B?Sng0TVlsa2RMc2h2c3JKYU04dHNsSUtYN21tSzBGbWM4dUlwN2x0dTdHdlJm?=
 =?utf-8?B?L3Bhb1k2cjJsRk9FSzhmUEhid2piKzE3RXQ2c3hjOWRwWUdPRE5mYmV6Unox?=
 =?utf-8?B?WnhxdXU5RmZHdStTVHorMlVFeks3MktpbWxlWFd3ZEsrWHZYT0NKSjFncWY4?=
 =?utf-8?B?UW9oK01reU12bitNdFA3bzRrSmFpZHJwNTl4SER6YzluMnZHSE1YaEdnOGhM?=
 =?utf-8?Q?/V2ydNubCqoZXSIKxP/zJgbE/vtINggM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9ca112-ee5b-4f77-4c18-08da0451ff0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2022 17:59:04.2983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80IcdwrdTLYWLvm/fj5WdqzzEI22fuGGSeCli2AYc4AO12f380sdCXpKIY8eBwSxa5ZGreZ0kOB7YEF3y6NuYqg/NS+Ej58GqcYNVYixyqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3860
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KUGxlYXNlIGZpbmQgdGhlIGlubGluZSBj
b21tZW50cy4NCg0KVGhhbmtzLA0KU2FqaWRhDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBNYXJjaCA4LCAyMDIyIDM6MTUgUE0NCj4gVG86IFNhamlkYSBCaGFudSAoVGVt
cCkgKFFVSUMpIDxxdWljX2Nfc2JoYW51QHF1aWNpbmMuY29tPjsNCj4gcXVpY19yaXRlc2hoQHF1
aWNpbmMuY29tOyBBc3V0b3NoIERhcyAoYXNkKSA8YXN1dG9zaGRAcXVpY2luYy5jb20+Ow0KPiB1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBhZ3Jvc3NAa2VybmVsLm9yZzsgYmpvcm4uYW5kZXJzc29u
QGxpbmFyby5vcmc7DQo+IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1tc21A
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
VmVlcmFiaGFkcmFyYW8gQmFkaWdhbnRpIChRVUlDKSA8cXVpY192YmFkaWdhbkBxdWljaW5jLmNv
bT47IFJhbQ0KPiBQcmFrYXNoIEd1cHRhIChRVUlDKSA8cXVpY19yYW1wcmFrYUBxdWljaW5jLmNv
bT47IFByYWRlZXAgUHJhZ2FsbGFwYXRpDQo+IChRVUlDKSA8cXVpY19wcmFnYWxsYUBxdWljaW5j
LmNvbT47IFNhcnRoYWsgR2FyZyAoUVVJQykNCj4gPHF1aWNfc2FydGdhcmdAcXVpY2luYy5jb20+
OyBOaXRpbiBSYXdhdCAoUVVJQykNCj4gPHF1aWNfbml0aXJhd2FAcXVpY2luYy5jb20+OyBTYXlh
bGkgTG9raGFuZGUgKFFVSUMpDQo+IDxxdWljX3NheWFsaWxAcXVpY2luYy5jb20+OyBMaWFuZ2xp
YW5nIEx1IDxxdWljX2x1bGlhbmdAcXVpY2luYy5jb20+Ow0KPiBxdWljX25ndXllbmIgPHF1aWNf
bmd1eWVuYkBxdWljaW5jLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCAxLzddIG1tYzog
Y29yZTogQ2FwdHVyZSBlTU1DIGFuZCBTRCBjYXJkIGVycm9ycw0KPiANCj4gT24gMi4zLjIwMjIg
MTUuMDMsIFNoYWlrIFNhamlkYSBCaGFudSB3cm90ZToNCj4gPiBBZGQgY2hhbmdlcyB0byBjYXB0
dXJlIGVNTUMgYW5kIFNEIGNhcmQgZXJyb3JzLg0KPiA+IFRoaXMgaXMgdXNlZnVsIGZvciBkZWJ1
ZyBhbmQgdGVzdGluZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpYW5nbGlhbmcgTHUgPHF1
aWNfbHVsaWFuZ0BxdWljaW5jLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYXlhbGkgTG9raGFu
ZGUgPHF1aWNfc2F5YWxpbEBxdWljaW5jLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYW8gRC4g
Tmd1eWVuIDxxdWljX25ndXllbmJAcXVpY2luYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFt
IFByYWthc2ggR3VwdGEgPHF1aWNfcmFtcHJha2FAcXVpY2luYy5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogU2hhaWsgU2FqaWRhIEJoYW51IDxxdWljX2Nfc2JoYW51QHF1aWNpbmMuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL2NvcmUuYyAgfCAgNiArKysrKysNCj4gPiAgaW5j
bHVkZS9saW51eC9tbWMvaG9zdC5oIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgYi9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYyBpbmRleA0K
PiA+IDM2OGYxMDQuLmYzNjc5ZWQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9j
b3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYw0KPiA+IEBAIC0yMjQyLDYg
KzIyNDIsMTIgQEAgdm9pZCBtbWNfcmVzY2FuKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4g
PiAgCQlpZiAoZnJlcXNbaV0gPD0gaG9zdC0+Zl9taW4pDQo+ID4gIAkJCWJyZWFrOw0KPiA+ICAJ
fQ0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBJZ25vcmUgdGhlIGNvbW1hbmQgdGltZW91dCBl
cnJvcnMgb2JzZXJ2ZWQgZHVyaW5nDQo+ID4gKwkgKiB0aGUgY2FyZCBpbml0IGFzIHRob3NlIGFy
ZSBleGNlcHRlZC4NCj4gPiArCSAqLw0KPiA+ICsJaG9zdC0+ZXJyX3N0YXRzW01NQ19FUlJfQ01E
X1RJTUVPVVRdID0gMDsNCj4gPiAgCW1tY19yZWxlYXNlX2hvc3QoaG9zdCk7DQo+ID4NCj4gPiAg
IG91dDoNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oIGIvaW5jbHVk
ZS9saW51eC9tbWMvaG9zdC5oIGluZGV4DQo+ID4gN2FmYjU3Yy4uM2I3ZjFlNSAxMDA2NDQNCj4g
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tYy9ob3N0LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L21tYy9ob3N0LmgNCj4gPiBAQCAtOTMsNiArOTMsMjMgQEAgc3RydWN0IG1tY19jbGtfcGhhc2Vf
bWFwIHsNCj4gPg0KPiA+ICBzdHJ1Y3QgbW1jX2hvc3Q7DQo+ID4NCj4gPiArZW51bSBtbWNfZXJy
X3N0YXQgew0KPiA+ICsJTU1DX0VSUl9DTURfVElNRU9VVCwNCj4gPiArCU1NQ19FUlJfQ01EX0NS
QywNCj4gPiArCU1NQ19FUlJfREFUX1RJTUVPVVQsDQo+ID4gKwlNTUNfRVJSX0RBVF9DUkMsDQo+
ID4gKwlNTUNfRVJSX0FVVE9fQ01ELA0KPiA+ICsJTU1DX0VSUl9BRE1BLA0KPiA+ICsJTU1DX0VS
Ul9UVU5JTkcsDQo+ID4gKwlNTUNfRVJSX0NNRFFfUkVELA0KPiA+ICsJTU1DX0VSUl9DTURRX0dD
RSwNCj4gPiArCU1NQ19FUlJfQ01EUV9JQ0NFLA0KPiA+ICsJTU1DX0VSUl9SRVFfVElNRU9VVCwN
Cj4gPiArCU1NQ19FUlJfQ01EUV9SRVFfVElNRU9VVCwNCj4gPiArCU1NQ19FUlJfSUNFX0NGRywN
Cj4gPiArCU1NQ19FUlJfTUFYLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RydWN0IG1tY19ob3N0
X29wcyB7DQo+ID4gIAkvKg0KPiA+ICAJICogSXQgaXMgb3B0aW9uYWwgZm9yIHRoZSBob3N0IHRv
IGltcGxlbWVudCBwcmVfcmVxIGFuZCBwb3N0X3JlcSBpbg0KPiA+IEBAIC01MDAsNiArNTE3LDcg
QEAgc3RydWN0IG1tY19ob3N0IHsNCj4gPg0KPiA+ICAJLyogSG9zdCBTb2Z0d2FyZSBRdWV1ZSBz
dXBwb3J0ICovDQo+ID4gIAlib29sCQkJaHNxX2VuYWJsZWQ7DQo+ID4gKwl1MzIgICAgICAgICAg
ICAgICAgICAgICBlcnJfc3RhdHNbTU1DX0VSUl9NQVhdOw0KPiANCj4gVGhpcyBtYWtlcyBpdCBs
b29rIGxpa2UgZXJyX3N0YXRzIGhhcyBzb21ldGhpbmcgdG8gZG8gd2l0aCBIb3N0IFNvZnR3YXJl
DQo+IFF1ZXVlLg0KPiBQZXJoYXBzIG1vdmUgaXQgdG8gYmUgd2l0aCBkZWJ1Z2ZzX3Jvb3QuIEFs
c28gdXNlIHRhYnMgbm90IHNwYWNlcw0KPiANCj4gCXN0cnVjdCBkZW50cnkJCSpkZWJ1Z2ZzX3Jv
b3Q7DQo+IAl1MzIJCQllcnJfc3RhdHNbTU1DX0VSUl9NQVhdOw0KPiANClN1cmUgd2lsbCBtb3Zl
DQo+ID4NCj4gPiAgCXVuc2lnbmVkIGxvbmcJCXByaXZhdGVbXSBfX19fY2FjaGVsaW5lX2FsaWdu
ZWQ7DQo+ID4gIH07DQo+ID4gQEAgLTYzNSw2ICs2NTMsMTEgQEAgc3RhdGljIGlubGluZSBlbnVt
IGRtYV9kYXRhX2RpcmVjdGlvbg0KPiBtbWNfZ2V0X2RtYV9kaXIoc3RydWN0IG1tY19kYXRhICpk
YXRhKQ0KPiA+ICAJcmV0dXJuIGRhdGEtPmZsYWdzICYgTU1DX0RBVEFfV1JJVEUgPyBETUFfVE9f
REVWSUNFIDoNCj4gPiBETUFfRlJPTV9ERVZJQ0U7ICB9DQo+ID4NCj4gPiArc3RhdGljIGlubGlu
ZSB2b2lkIG1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19pbmMoc3RydWN0IG1tY19ob3N0ICpob3N0LA0K
PiA+ICsJCWVudW0gbW1jX2Vycl9zdGF0IHN0YXQpIHsNCj4gPiArCWhvc3QtPmVycl9zdGF0c1tz
dGF0XSArPSAxOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBpbnQgbW1jX3NlbmRfdHVuaW5nKHN0cnVj
dCBtbWNfaG9zdCAqaG9zdCwgdTMyIG9wY29kZSwgaW50DQo+ID4gKmNtZF9lcnJvcik7ICBpbnQg
bW1jX3NlbmRfYWJvcnRfdHVuaW5nKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwgdTMyDQo+ID4gb3Bj
b2RlKTsgIGludCBtbWNfZ2V0X2V4dF9jc2Qoc3RydWN0IG1tY19jYXJkICpjYXJkLCB1OA0KPiAq
Km5ld19leHRfY3NkKTsNCg0K
