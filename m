Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F013B525D38
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378152AbiEMIW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377923AbiEMIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:22:40 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2156.outbound.protection.outlook.com [40.92.63.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D906725BA6E;
        Fri, 13 May 2022 01:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UByqHaLgidRHZK8o5Le/g9l13FeD2y5lE6LyGw7GY9A5unNw0iXbtuATclf0tysh8Gb7/3tBs10xUBNpeu8GUHjyPHOColfu/i3vdsV1mMPdzznwX+CuiW7fPzuszYxpFIx9XmropfmNpIV7lt4KGLJOIOGNIjJr1AGW/hx2Tjq16cUDH1zWMvXYPPWZ29CzIVw22imlsLxYTAxg2HjycmkaFnm/tT8NA8kt6dVu2V9HpRfFo5CBYVEF+QC7fQ3Yjtd8odsNt7Qn72RcaZrAy4NxDBjTCqKCP1Bj7FegJFDewGlLFIq6jrrMVMlDF9R+CTpUiSeV70dnSZfmLdvqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOpZRaDHzbAzqEFZ0F6aW4WGyfGraXNYnE8sI4Eco5Y=;
 b=alR6MSWBuculArHYR01wcaxlbfs8oPiEX1lXufpEXLBIZ24yjPV9WvMCVMsJy/Tp+8p+qKQFVKg8mdcxA8PL2aHwB5T8m9AevGOFBUSFaDYVXJJGVgZCA6h7dhUuTmh3p87ECnzAtvHfybHBSYdN7OslB2Zh5k4BbfcH64Pf0ZOMlEnjSFSz0V5joZXQGGL2K9BsFKtC1yrQNhcuHTiPSFOp73KsBzwqeLmR7dZtB0boKjleja+ZymQgEv2hWr+HBNS/gpI+25bRnZ7vZcqEdLjPInem/jUgKCOwwP5GS6OdIQArxyETMHcDqqaaBk6AxmbUA8eE8va8X8jOBo4JrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOpZRaDHzbAzqEFZ0F6aW4WGyfGraXNYnE8sI4Eco5Y=;
 b=k3l1XLiKUVgYU2utHfWH2YInMD4cibYyQsZAjddekcG1TePgDXF+2M0PZQk4YBhTJDAGHa1c9qB96bcohKfKymLxdMSBijQhFm+Bz4B2qB4lXT818IPEQmA1wbOSG+V7FVucaq44KqYZNXmi/jhOdJUfTd4fFJ6kPsxxNGxEuBTykg9ccmQ+4tmgbcJqIwwARHTg+ObPxjB1ieiaJUeoy57EhjQDjfHQ/Eq6d8XUq5/+9r18XQbL1uQ6vzqGlYqPvnIVcOCTKAUrQS0mMuQpEENKmM+Jba75iD5MoxjBqB9eU5JDHsRBUcfUF+JDRA/pDjTcrNe/FOUA4PvtmGOCYA==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by ME3P282MB0721.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:22:30 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 08:22:30 +0000
From:   =?gb2312?B?zLcg08DB1g==?= <yonglin.tan@outlook.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "mani@kernel.org" <mani@kernel.org>,
        "quic_hemantk@quicinc.com" <quic_hemantk@quicinc.com>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "mhi@lists.linux.dev" <mhi@lists.linux.dev>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSAgICAgYnVzOiBtaGk6IGhvc3Q6IEFkZCBzdXBwb3J0?=
 =?gb2312?Q?_for_Quectel_EM120_FCCL_project.?=
Thread-Topic: [PATCH]     bus: mhi: host: Add support for Quectel EM120 FCCL
 project.
Thread-Index: AQHYZpclpumYq2kRt0qDu6cacy5cWK0cY8sAgAAOwPA=
Date:   Fri, 13 May 2022 08:22:30 +0000
Message-ID: <MEYP282MB2374FA30A8EFF7CC25E256C7FDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB23742A3646D681AF27BED85EFDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
 <Yn4EVHr/xrgB0kom@kroah.com>
In-Reply-To: <Yn4EVHr/xrgB0kom@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [RdAwFmwYM2PLR2a3IiG7ACq4hrBKwiMX]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1495318-83ef-4537-5735-08da34b9b8df
x-ms-traffictypediagnostic: ME3P282MB0721:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ox4jsfmST6Plbfom2AXLl/NJF/yPFIvQUPiZzbozUv2cly/t/x86EAA79/nnMsuIL/AKuG88x3er9433CMC1NxZEuERsL3TnxXLrWPkY8Inkhj0P5awgdfn/U9k9+WkxKx7viXXnCs3SvyBwV/4nbD3QWyYdB59pNpotvz+hXZxqDcZh+yhdRvxlQUPapSqjpa1xVY31BKCqHJOn+vjB5Uo3rw5IWM42/Dy67Iw7joxLEkCpEjXB9alGMyUax/UtTT7liymkC+giGX5eA+ilBjfmrQkmt2xRXRF42rlEYiCRpsZ2W5EM01a657Wm8OnwyvqxiUMfq3hHSI5NGVPNmtrS9ih80MbWwunYgfX1O6PZ4AIIOi8YoZVKOtb1aqgrZXwiemsX9w8j1UCqkrQhqB5AT4J4aa3S0jNbGsX57nrmWqCnQnh3MkmFumIXqy7c4GwbeZqnVP60Dsn+Sh8QYNaRtbNUoo71Z+4qtqA9w/U3QtzDq+hVxIBssLPIZqgvAK0Yn2dZP/vk43C9W/tPSO8i0H2oH0uMmbDnTn1yRsQPa0G2xscAvSWRhbA6BfSpOrjb540NoJhiBXGa0N5AhA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eWs1eG5oNTZiallqSVBzTHZNbVNCcUlCaWVKN2dROFFISys4eHpHZUVKeS9U?=
 =?gb2312?B?bVBVMTc2RlJCaHR5U01DU2tFQWhiWm1uVUphcEdHVVpHWlU5SXlNZGVJRURn?=
 =?gb2312?B?MU1xaE1GbUpxSWpvZHc5dVFOcE43ZUtQRFV5a0pWSk9jNk1SWWZtYzhMemM3?=
 =?gb2312?B?RUFHTXQwbmx6MktTWVAxa0R0Smo1S3RvUDBqR2k0anFrQUFIZzRwaHYxbEV1?=
 =?gb2312?B?LzVId0pWWTRZdTRzNk5zMWIzNWd2WWRyT1FZd0x4YkxRV1NHNm5kS0FiTDhs?=
 =?gb2312?B?RVpUMXpVb1N3VEVsOFdLbnpqd1lGZGl5VEhPWjh3c29uZ04veVV3aUFGUDQr?=
 =?gb2312?B?VDdGc3RyOG40THlLaE85NG5seWk1K0JRS1BuMUlVZDNNYTgvbGJsNVVsbzda?=
 =?gb2312?B?cFRlV0h5cVFhckFHTzVGTi9QeXRlTEFxeDJFeENwM3FXWGJXTVRmeDluUlVB?=
 =?gb2312?B?bUJvUCtBUTI1MEU3YWVielNpTDRTenBBZndPamRjSWVoRENLRU9VWFZFQXIv?=
 =?gb2312?B?a21JUkVMOFNLejlyWmN0R3F3d1AzRlBMa3hlM2JjVm92WHZGNmtONS9JNEcy?=
 =?gb2312?B?S1Q2VmZWdVhlbG9qUzBYVzVyLzh0cDVON3JlTGYzSXNTL0pHWUNmdjFWT2kx?=
 =?gb2312?B?WHRPcEhkVlgwZisxdHA0M0Rxc3BKQ2pzN3VYNkEzMjYwTXE3dUhGTGZsNHVy?=
 =?gb2312?B?bzJIbFJsRFhUYXRPdkhPUlllMHVkMFgvaHg4VGc0QzlzQkQxNURjMkZlMFF6?=
 =?gb2312?B?azFibk5hKzhUMHp0SG1hMHpTR2FNNGFXc0piQlRQUHBLZXp1VXk1WGVnSjk4?=
 =?gb2312?B?UHUwck1HSUx6VGhvQ3lvTk40alZDeTlva2lBdkpRb1U2cHdCYThtaVc4Zkpt?=
 =?gb2312?B?K2gzZzdiUDJUK0VIZjRPcU84amFpWkxVZVRoMCtObEpJSzlYYnVQQm5Jb3Vj?=
 =?gb2312?B?Sk9jck9WMzY3aWJDcHgvcUFkbzNyYk1RT1VQc0dXMmIxYlpsd21oMWxVODhr?=
 =?gb2312?B?ejdYNUpnYUJENzdWVXZaNW0va0ROUVdWYUVUeUhTdDJZZmtBZkQrOU1kNGRs?=
 =?gb2312?B?aE1NKzJOSUNPY0ZSUXgweHZCYUFZYk9lMUJHK0hyQXVSMnh4NmJCbHdCM0tx?=
 =?gb2312?B?L0cxNDNEdm13YTc0Q2NiemtOaG1MNS9rY0w3N1ZnbjNzdG9yWlVoaG9FSjUr?=
 =?gb2312?B?dFB1NU8yUFN4WWZjZU9wVnEyQ2J2NzUrSWxONXVHeTVEaG56VWo4ZmFUeHlE?=
 =?gb2312?B?bWtCbFFrWm9xSEh1N05yNndlcjN6LyttYVo2SEVBd3ZyYitnTkZYNUc3WlNa?=
 =?gb2312?B?Rnd4S2VRRmJJd0hnbUovMVFUbEZlVHhtcnFYR01XOUh5a0FETTc4NGNjemxU?=
 =?gb2312?B?Qy9MaDZELzV1ejBCdlNOdVZ2NFc2aFpWbEpHeWZJeTRCQ0Y4bHBWcE43c3Zx?=
 =?gb2312?B?WDVuOFBqUlhPTjhyVFBVUG1taFNRSC84MEI1cGovNlFFdmJmV2J6WnVTQ2Jw?=
 =?gb2312?B?SjFJRElPMkFHUUVPTGlYeTRiRjJnZ1hkcXZjdVdQdEVkV1RiU0V4YjIxSjVK?=
 =?gb2312?B?MUswT3lTQ0k4NVEwYTJiVDlTNndUQitMcmsyYVA5L2ZTbzRqTEFweEpzdHJK?=
 =?gb2312?B?Y1Boa2d2UjNUSzF1ZmxrNU5pWm5SUU5Za3FqVCtLZWVGOXpLR3hVK2ozZXFK?=
 =?gb2312?B?dnZxeW5lWVBFTlZvN0piaUhSQmx5RDBSRjUreG45ZEZ2RE8wQTBZUHN0RFRk?=
 =?gb2312?B?RjBxSUpGSzVUdmZRNkVnUkllQ1V6Umc4VXQxa21abCtIeFFhSjJWSHV1dU14?=
 =?gb2312?B?N1BtNFJvZVFadUNjSy9Wa2VDT1RTNS90bFdNanFnbGFIaWpWbkNVcEkzYXhT?=
 =?gb2312?B?RnZuZTJkWUJUMGtpTlBFSjNUaDd1UE9wd3NKQUZJK293Mkx6d21SOTY5Z0pV?=
 =?gb2312?Q?4B0nR5Jloug=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a1495318-83ef-4537-5735-08da34b9b8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 08:22:30.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB0721
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBHcmVnLA0KDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNlLiBJIHdpbGwgdHJ5IHRvIGxlYXJu
IHRoZSB0dXRvcmlhbC4gDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBHcmVnIEtIIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gDQq3osvNyrG85DogMjAyMsTqNdTCMTPI1SAxNTox
MA0KytW8/sjLOiBZb25nbGluIFRhbiA8eW9uZ2xpbi50YW5Ab3V0bG9vay5jb20+DQqzrcvNOiBt
YW5pQGtlcm5lbC5vcmc7IHF1aWNfaGVtYW50a0BxdWljaW5jLmNvbTsgbG9pYy5wb3VsYWluQGxp
bmFyby5vcmc7IG1oaUBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrW98ziOiBSZTogW1BBVENIXSBidXM6
IG1oaTogaG9zdDogQWRkIHN1cHBvcnQgZm9yIFF1ZWN0ZWwgRU0xMjAgRkNDTCBwcm9qZWN0Lg0K
DQpPbiBGcmksIE1heSAxMywgMjAyMiBhdCAwMzowMDoyNVBNICswODAwLCBZb25nbGluIFRhbiB3
cm90ZToNCj4gRnJvbTogeWxpbnRhbiA8eW9uZ2xpbi50YW5Ab3V0bG9vay5jb20+DQo+IA0KPiAg
ICAgVGhpcyBwYXRjaCBhZGQgVmVuZG9ySUQvRGV2aWNlSUQgZGVmaW5pdGlvbnMgZm9yIEVNMTIw
IEZDQ0wgcHJvamVjdC4NCj4gICAgIEl0IGhhcyB0aGUgc2FtZSBjb25maWdyYXRpb24gYXMgUXVl
Y3RlbCBFTTE2MFItR0wgYW5kIEVNMTIwUi1HTC4NCj4gDQo+ICAgICBSZXZpZXdlZC1ieTogR3Jl
ZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gICAgIFJldmll
d2VkLWJ5OiBIZW1hbnQgS3VtYXIgPGhlbWFudGtAY29kZWF1cm9yYS5vcmc+DQo+ICAgICBSZXZp
ZXdlZC1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGlu
YXJvLm9yZz4NCj4gICAgIFNpZ25lZC1vZmYtYnk6IFlvbmdsaW4gVGFuIDx5b25nbGluLnRhbkBv
dXRsb29rLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5j
IHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYnVzL21oaS9ob3N0L3BjaV9nZW5lcmljLmMgYi9kcml2ZXJzL2J1cy9t
aGkvaG9zdC9wY2lfZ2VuZXJpYy5jDQo+IGluZGV4IDg0MTYyNjcuLjBhNjQ2OWMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvYnVzL21oaS9ob3N0L3BjaV9nZW5lcmljLmMNCj4gKysrIGIvZHJpdmVy
cy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYw0KPiBAQCAtNTU3LDYgKzU1Nyw4IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBtaGlfcGNpX2lkX3RhYmxlW10gPSB7DQo+ICAJ
CS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkgJm1oaV9xdWVjdGVsX2VtMXh4X2luZm8g
fSwNCj4gIAl7IFBDSV9ERVZJQ0UoMHgxZWFjLCAweDEwMDIpLCAvKiBFTTE2MFItR0wgKHNkeDI0
KSAqLw0KPiAgCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZtaGlfcXVlY3RlbF9l
bTF4eF9pbmZvIH0sDQo+ICsJeyBQQ0lfREVWSUNFKDB4MWVhYywgMHgyMDAxKSwgLyogRU0xMjBS
LUdMIGZvciBGQ0NMIChzZHgyNCkgKi8NCj4gKwkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9u
Z190KSAmbWhpX3F1ZWN0ZWxfZW0xeHhfaW5mbyB9LA0KPiAgCS8qIFQ5OVcxNzUgKHNkeDU1KSwg
Qm90aCBmb3IgZVNJTSBhbmQgTm9uLWVTSU0gKi8NCj4gIAl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRP
Ul9JRF9GT1hDT05OLCAweGUwYWIpLA0KPiAgCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25n
X3QpICZtaGlfZm94Y29ubl9zZHg1NV9pbmZvIH0sDQo+IC0tIA0KPiAyLjcuNA0KPiANCg0KT2ss
IHBsZWFzZSBzdG9wIGFuZCB0YWtlIGEgbWludXRlIGFuZCBnbyB0aHJvdWdoIHRoZSBiYXNpYyAi
aG93IGRvIEkNCndyaXRlIGEga2VybmVsIHBhdGNoIiB0dXRvcmlhbCBvbiBrZXJuZWxuZXdiaWVz
Lm9yZy4NCg0KWW91IGFyZSBzdWJtaXR0aW5nIGEgcGF0Y2ggdGhhdCBoYXMgYSBudW1iZXIgb2Yg
b2J2aW91cyB0aGluZ3Mgd3JvbmcNCndpdGggaXQ6DQoJLSBpbnZhbGlkIGZyb206IGxpbmUgdGhh
dCBkb2VzIG5vdCBtYXRjaCB0aGUgc2lnbmVkLW9mZi1ieSBsaW5lDQoJLSBtYWRlIHVwIG91dCBv
ZiB0aGluIGFpciAicmV2aWV3ZWQtYnk6IiBsaW5lcyBmcm9tIHBlb3BsZSB3aG8NCgkgIGhhdmUg
T0JWSU9VU0xZIE5PVCBSRVZJRVdFRCBUSElTIFBBVENIIQ0KCS0gaW5kZW50ZWQgY2hhbmdlbG9n
IHRleHQgaW4gYW4gb2RkIGZvcm1hdA0KCS0gZXh0cmEgc3BhY2VzIGluIHRoZSBzdWJqZWN0IGxp
bmUNCgktIG5vIHZlcnNpb25pbmcgaW4gdGhlIHN1YmplY3QgbGluZSwgb3IgYmVsb3cgdGhlIC0t
LSBsaW5lIGFzDQoJICB0aGUgZG9jdW1lbnRhdGlvbiByZXF1aXJlcw0KDQpQbGVhc2UgdGFrZSBz
b21lIHRpbWUgb2ZmLCBhbmQgY29tZSBiYWNrIG5leHQgd2VlayB3aXRoIHRoaXMgYWxsIGZpeGVk
DQp1cCBBRlRFUiB5b3UgaGF2ZSBnb25lIHRocm91Z2ggdGhlIGtlcm5lbG5ld2JpZXMgdHV0b3Jp
YWwgQU5EIHlvdSBoYXZlDQpyZWFkIGFsbCBvZiB0aGUgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1
Ym1pdHRpbmctcGF0Y2hlcy5yc3QgZmlsZS4NCg0KdGhhbmtzLA0KDQpncmVnIGstaA0K
