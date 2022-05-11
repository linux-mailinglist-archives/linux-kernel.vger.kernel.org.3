Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCD1523106
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbiEKKxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiEKKxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:53:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F98880D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAOrvY0N3H2TzVAgyV6gskOoJL/T0v2Xq8gfK0nxqoi1Brs30i7HZT7dhoSwGrT6Fc1M47jDtGLmzS8Uo0Dm4+rK41UFKx0u1QTc+13zG2upUny/PnPtcrc2zvdog7EPy5v+Q2ael1oaaLiK++iohFxYM3VWE5eGoqsg7PTsQ+c60baNH0zkYO7w1dT/HbgvgbaTH6D5GvyhpMtFVZp/kun8VbsTAIAZP7FL5wOwX0iVjUbsvum5OfwqbrQsBz91xnlezaIU7VO5QeP3RWHM+QNRLuURR54XlR9DjRd2liYZuCq7fbUVsGy/Vet/U4FXW4MLtwZE5N+WvJcWhFfxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7yKNbywr5Ls0XQMeN+yvFs8TLnER6AWC/iZUTUpXzM=;
 b=FMBQAo21b8NMRutxP7oiIqjea7Sv+E2GDLEubCzwWC/nmlJrjsffmNQaQOZeZTScTmulaOHfieUquklZh6Due/Wjkx7UP+kPkgtTYGj0nwKKv7lf8CVdmziITBLobZ1r+lje11IQStEsyLv1zKultuwwicBXxqSYTfNZ2Y+lnA7Fe6QBrQdYy1PPAg1WkGeMhIwZAEXBEuQBF2U2oabPFppwFWuBcsMcuN+ZIVdJq01SAPfiQYAItfbdn3osk0ENzSx5x216Gwb/rRwfpxZzQpw1g3NXrYxSP1roUJAr0glm+yPVsgnlvTA8N55HTagOmiZQhMhbTNd/3Gdmm59G5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7yKNbywr5Ls0XQMeN+yvFs8TLnER6AWC/iZUTUpXzM=;
 b=NzAjvdwsgEcPn5b0UfH+S5AHCTCSfUklmpJPIB/elbM8hNh1eWfqyq5MIDfFhuWZO40a8Fovvn4mnIpGSxZcSvUcxZ2KVna+4lIcxL5b+grAgXchbjtC5pEz7XHZKZ4UwtLGNbFXhPf5tndaqF3gAHPftXgcnMyD+6n4Ci0BAp6NOcNv2bc5cj9V+NPiUw05R2v47c2EGAt99+78v3kaVzMtJNPAi3ENme0cV4ULej0raFVeJvRiv70cQfWEyCubfNBakv96cFI0/8V+5WEbIEZIMheEI3VNwgosQlVWQyEp7QRTJnEyEOOjoTlPHbKHBAH/kXQJ0yJvQhWUP9HSVw==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 BYAPR12MB3237.namprd12.prod.outlook.com (2603:10b6:a03:13a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 10:53:40 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5%9]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 10:53:40 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Subject: RE: [PATCH] vdpa: Warn if MTU configured is too low
Thread-Topic: [PATCH] vdpa: Warn if MTU configured is too low
Thread-Index: AQHYZRPaxDNnxWhxK0yF85+cFflWj60ZanOAgAAHJsCAAAU/gIAACXXQ
Date:   Wed, 11 May 2022 10:53:40 +0000
Message-ID: <DM8PR12MB54000E4C886217D41415F357ABC89@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220511084804.82482-1-elic@nvidia.com>
 <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
 <DM8PR12MB5400BC33A5ABD2FCBD0CA852ABC89@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEvTTyT=RFp3aAL+8XcL229Fw=pW9_7zNntrUViriUHuNw@mail.gmail.com>
In-Reply-To: <CACGkMEvTTyT=RFp3aAL+8XcL229Fw=pW9_7zNntrUViriUHuNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec00fd8d-31f2-4b38-c82b-08da333c8264
x-ms-traffictypediagnostic: BYAPR12MB3237:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3237879BB186D525FD996BCCABC89@BYAPR12MB3237.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CNYbDgbMAvl2sA0mtiuZzP3POWwgSLAEKSr9hF/OL4NJHKrm0thMdZSEkGiHrCzzTycnU+zw4y3G46YIs9Zi65cpUWM3zwCdwpRIwvV80Co7/ZyF5V/Ya6Mt1O0A9p6omyhGY6OB378i4dW4lZbQEZ3RSMj4j/hrBHCxtb5fbsOx92MLC+Ni72CBKTUumpsot4HLa3GWapc3GKWc1yuKl8uTpPLhgzIIbPDeuyPz8Od3f4tjRb7ON4Tz82H2agDBaxE9b4mWxiFNA4hXNTTVKMj9J2GCJrcWNzodijsWXMLfcVf487uxZTW+dZDv5KUt+IuqBOC5kFiJV8S2UHPI7HIpsrr+YAFA2N99XS8p+7crnmvWDaIovvil19/3ynGU3R4pMxbMA11OqGWfQq8I3e3Ea6PjSVtm7msCRBUyPPINqIUQyM9BTRt7o9v6zpcY8UHEVplnPjHbhRAFuW8tLZBS/hxv8f3vIot/R9kYOnOmuI5sf+3/Qwz130Xh2wBLfBBITIPOgsZbI26dd6VmjY6nesB34lNMY6IG1fdiJQ9KmgCou19DRWk3Pr56O1jNkuXcThix8sPfq2xXrR2LL86DpLyOdA06ATRO8WhfX2uv4g5YOjrTk7c1trQyKQWgy24nWbt+2ew/0/jiFoUxlka48Ge1DGOT4qBsdJ1SeJWwX5EBkrqYGk1yIg1Q9b2mOVLnlwSa30yYZHVuGc6E5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(86362001)(6506007)(52536014)(8936002)(33656002)(5660300002)(7696005)(508600001)(53546011)(71200400001)(83380400001)(38070700005)(122000001)(26005)(9686003)(38100700002)(55016003)(186003)(316002)(66476007)(66946007)(54906003)(66556008)(76116006)(66446008)(8676002)(64756008)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnFUZm5HOUp0T3Q5QzRaenRnbnVVaFdCRGRIcDg5RzYyZFF0ZW9TNE14anJN?=
 =?utf-8?B?Zmx6Vk5YdldyUjlibjRjQ2txVWRpaGZHRkxrRWlxVCsvVldJOWd6dUE5M2RL?=
 =?utf-8?B?T0w1WFRZb1pjektyU2tFVTQ2dDJvRjd4dGRjVE82US9QeHBMV0NKMVRRYUtk?=
 =?utf-8?B?TDJlTDFNQ0tJZ0c3THJ2VGJpUnkyeDEvTDd5UmRCbXB3SFhTUzhFb0ZISWR1?=
 =?utf-8?B?eldSNTZBbXBXNDZONzA3Qy94bmYyOXpUeEVBVTQ3aUdwWHp3RXh0RG82RGRq?=
 =?utf-8?B?Wmdpa3BjdUhCRWkwOUt1N29wbDRaMU9rRnN0YkJaNDk5SVgyb2NSTlFETFRx?=
 =?utf-8?B?U3dHM3V6Z1IzSjZBbXJjNUpscjZmOGF1UjMxZ1huaXU3NmdXOVAxWWxRdmRB?=
 =?utf-8?B?d0dUVkpYcU1tbnQ5a1NSY0U1amZXVVE0L3hqL3VTSkpaZ0pXSFhtQ24zYjRt?=
 =?utf-8?B?K2VWUlpYTFdBZjA1ZGd2UFVMa0NTaWZZOExyMkE0VzNIQUF3Ym9TTi9PUGRB?=
 =?utf-8?B?TWZ4Y0pkTUlNRjlxTFBHb2JkcjBXVkhsVzdZTmZrd0txdWd4cFJvWi9KdTFC?=
 =?utf-8?B?MXcyNkNOZ09tV3p3cFoxYmpEdjgweG1WYjNySHpGRnpzbG1mTGxGdmtXMFor?=
 =?utf-8?B?cGFQNVhqL2l6aGV3NEZKSG5XMDFoNEZrSjY0V0VBalRWem9sQUJWdUYxQi9U?=
 =?utf-8?B?VVhhMUI2aGxOcVowMGNyNXJJbzVYdXZTV1pKclY5L3EwMDRzd0NiUlV3SHFB?=
 =?utf-8?B?Z2ZwMkEralcrME9PWllVd3dHN0lEakxUV3Z1NHBRWEJrVUtLUnBNWGk1dzhK?=
 =?utf-8?B?K25RZG1vZWE5eUlKVmszbDNPUTV4T0xTaTJhblkxVTJ0Slg0aEErcWhqM0sx?=
 =?utf-8?B?Ykh6R3ZGS2d4ZTNTVCs0T3gwTnVjL3hTaFVVTW5rVHRmaHBsVEJXZndYZi9u?=
 =?utf-8?B?ZkpNN251ZGxEeEpZMGN4VC9rV0EvMG9aSzR1dXlHcVViR29sQTVuRDhSaWNs?=
 =?utf-8?B?RWFYVXlabWlzWXhlT2c0N01Dalg1NUt4bS94Vlo5azF1aDB2eUdqRkFON0dx?=
 =?utf-8?B?SHVjOFI3ZXZGVTdrMERFYzZlNFo5QnU1MjNMWVp6d0dad1NhM3NwRFdQemU0?=
 =?utf-8?B?SHJ5Z2tndE1oZ0VnMkhXaGdNMmJzMTI0K2Z2Y3BjaTNxQlJHWmM5VlBuYjUw?=
 =?utf-8?B?WnE3QVlSZHRGYnY2aFpXRGpvYmhSUG82TGNDMUFsaHdkRHYvK1cwZ0Y1L25M?=
 =?utf-8?B?d3VhWEJjT2tiNU53UzhKK3ZEVDNFcFAybmJ0T0xPZGRCUWN3enFOVlJPcGxy?=
 =?utf-8?B?TWtXdDRJVmZlRTRGQnVPZWpLQTBWWjhMVVpuVDVnNjdZaG1ESlhlc0loNFpF?=
 =?utf-8?B?dCtNYXVPN1FhRjFMK0NtY0ZhRTVWTGtIWGVBcE9Uc0x1aFlOVXdwbTE0c3FU?=
 =?utf-8?B?a2VPUU94VHY5QmM2dHpyWDE2RExFZ3NRNnZKWUNYUTF2RnVIRWJMbEpoa1FT?=
 =?utf-8?B?NWFNYUhQKy9sNTJpNUV6T0o4L096Q3VSZW1yQlgza3EwdE9rVDUvZjhzUUJs?=
 =?utf-8?B?TTZ1K2ViU3pkeWQvUkp3WFl3TEVhZDlCbmY1ZTdhQ3hKRkM0ZVVFUDFaN2g2?=
 =?utf-8?B?L3p4QjlQa0xuT3ZROTFJdHJWN1VocXR4c2ZrS0ZMK3RjUzlyT1IyaWl2S21K?=
 =?utf-8?B?WUtiYWhIdUl5Y0g0WmhVQkxIM0VVa0svcUpkZ0hKTjZCL0tGbDB3c2hPM3lJ?=
 =?utf-8?B?Z0xVdXNORkNmWUR0NWEwbnFWaEZMaE1XWXlURDVHYXE2Y1JxcklmVndrcllx?=
 =?utf-8?B?NkxHSWtpdSsvSEdxMUMxZ1NsWjJGa09zeUZDMUFTeStTdHVxZnZjUkp5MVJq?=
 =?utf-8?B?dFlJOWwyaXR2NDBMdVZYd0FOdWlWYi8wZ0c5Z0FZSGU5VW53WW5KRVpHUWhC?=
 =?utf-8?B?cnhvSUNDZ1BXR3JwUkt6SXNNK1dMUTFVU0tmdFg4NlRtUE1IZmhUWVlZL2Y4?=
 =?utf-8?B?TG5reS8vU3cvU1lEaXhtdExXdWtaemdVZGhYRkRnbzRQSGZoSG5CNG9saEhN?=
 =?utf-8?B?U05yajRLMkJyWjlTUXFxVnYrUUpLMFJQMTM1cjI3Mm80UTdOVk5KTnRyd3V2?=
 =?utf-8?B?bmdpaGwyOFdmdmptakdjQXdXcjZ5bnJyRFJteHJwOVdzbkJDSUZUQXFFcEZO?=
 =?utf-8?B?cmY0L1FVY084eUcvNjB2ZWtzaXZsM1hHUjQ2eFFRajlPakJrazVrZmE1TkEv?=
 =?utf-8?B?QmZYSkpYa1A2WUdHWWdsLzdiT3haaGxNL2daY0duU0VvTkQyMEE4WllXT1dl?=
 =?utf-8?Q?oQW6xxL+ck94sHc6Ji?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec00fd8d-31f2-4b38-c82b-08da333c8264
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 10:53:40.4418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJmCv8gBVt/roicuFewBzSsxtBKyeXrrQqgbooYB40k7jo4B7ZSk/4iI35QwENLQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3237
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAxMSwgMjAyMiAxOjE5IFBNDQo+
IFRvOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gQ2M6IG1zdCA8bXN0QHJlZGhhdC5j
b20+OyB2aXJ0dWFsaXphdGlvbiA8dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmc+OyBsaW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBTaS0N
Cj4gV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSB2ZHBhOiBXYXJuIGlmIE1UVSBjb25maWd1cmVkIGlzIHRvbyBsb3cNCj4gDQo+IE9uIFdlZCwg
TWF5IDExLCAyMDIyIGF0IDY6MDIgUE0gRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+
ID4gU2VudDogV2VkbmVzZGF5LCBNYXkgMTEsIDIwMjIgMTI6MzQgUE0NCj4gPiA+IFRvOiBFbGkg
Q29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gPiA+IENjOiBtc3QgPG1zdEByZWRoYXQuY29tPjsg
dmlydHVhbGl6YXRpb24gPHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
PjsgbGludXgta2VybmVsIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgU2ktDQo+ID4g
PiBXZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BB
VENIXSB2ZHBhOiBXYXJuIGlmIE1UVSBjb25maWd1cmVkIGlzIHRvbyBsb3cNCj4gPiA+DQo+ID4g
PiBPbiBXZWQsIE1heSAxMSwgMjAyMiBhdCA0OjQ4IFBNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEu
Y29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRm9sbG93aW5nIHRoZSByZWNvbW1lbmRhdGlv
biBpbiB2aXJpbyBzcGVjIDEuMSwgYSBkZXZpY2Ugb2ZmZXJpbmcNCj4gPiA+ID4gVklSVElPX05F
VF9GX01UVSBzaG91bGQgc2V0IHRoZSBtdHUgdG8gYXQgbGVhc3QgMTI4MCBieXRlcy4NCj4gPiA+
ID4NCj4gPiA+ID4gUHJpbnQgYSB3YXJuaW5nIGlmIHRoaXMgcmVjb21tZW5kYXRpb24gaXMgbm90
IG1ldC4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52
aWRpYS5jb20+DQo+ID4gPg0KPiA+ID4gSSB3b25kZXIgd2h5IGl0J3MgYSBtdXN0Pw0KPiA+DQo+
ID4gSXQncyBkZWZpbml0ZWx5IG5vdCBhIG11c3QgYnV0IEkgdGhvdWdodCBpZiB0aGUgc3BlYyBz
YXlzICJzaG91bGQiIGl0IGRlc2VydmVzIGEgd2FybmluZw0KPiANCj4gUmlnaHQuDQo+IA0KPiA+
IGJ1dCB3ZSBjYW4gZHJvcCB0aGlzIGlmIHlvdSB0aGluayB0aGUgd2FybmluZyBpcyBub3QgaW4g
cGxhY2UuDQo+IA0KPiBJIHJlbWVtYmVyIG5ldGxpbmsgaGFzIGFuIGV4dHJhIGxvZyBidWZmZXIs
IEkgd29uZGVyIGlmIGl0J3MgYmV0dGVyIHRvDQo+IHdhcm4gdGhlcmU/DQo+IA0KDQpZb3UgbWVh
biB1c2UgTkxfU0VUX0VSUl9NU0dfTU9EKGluZm8tPmV4dGFjaywgIk1UVSBpcyBiZWxvdyByZWNv
bW1lbmRlZCB2YWx1ZVxuIikgPw0KZG1lc2cgc3RheXMgY2xlYW4gYnV0IHRoZSB1c2VyIGdldHMg
YSB3YXJuaW5nDQoNCj4gPg0KPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL3Zk
cGEvdmRwYS5jIHwgOSArKysrKysrKy0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jDQo+ID4gPiA+IGluZGV4IDkx
ZjRjMTNjN2M3Yy4uOTYxMTY4ZmU5MDk0IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Zk
cGEvdmRwYS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMNCj4gPiA+ID4gQEAg
LTU4Myw2ICs1ODMsOSBAQCB2ZHBhX25sX2NtZF9tZ210ZGV2X2dldF9kdW1waXQoc3RydWN0IHNr
X2J1ZmYgKm1zZywgc3RydWN0IG5ldGxpbmtfY2FsbGJhY2sgKmNiKQ0KPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfTkVUX0NGR19N
VFUpICAgICB8IFwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklU
X1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUCkpDQo+ID4gPiA+DQo+ID4gPiA+ICsv
KiBSZWNvbW1lbmRlZCB2aXJ0aW8gc3BlYyAxLjEgc2VjdGlvbiA1LjEuNC4xICovDQo+ID4gPiA+
ICsjZGVmaW5lIFZJUlRJT19NSU5fUFJFRkVSUkVEX01UVSAxMjgwDQo+ID4gPiA+ICsNCj4gPiA+
ID4gIHN0YXRpYyBpbnQgdmRwYV9ubF9jbWRfZGV2X2FkZF9zZXRfZG9pdChzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiLCBzdHJ1Y3QgZ2VubF9pbmZvICppbmZvKQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAgICAg
ICAgIHN0cnVjdCB2ZHBhX2Rldl9zZXRfY29uZmlnIGNvbmZpZyA9IHt9Ow0KPiA+ID4gPiBAQCAt
NjM0LDYgKzYzNywxMCBAQCBzdGF0aWMgaW50IHZkcGFfbmxfY21kX2Rldl9hZGRfc2V0X2RvaXQo
c3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IGdlbmxfaW5mbyAqaQ0KPiA+ID4gPiAgICAgICAg
ICAgICAgICAgZXJyID0gUFRSX0VSUihtZGV2KTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGdv
dG8gZXJyOw0KPiA+ID4gPiAgICAgICAgIH0NCj4gPiA+ID4gKyAgICAgICBpZiAoKG1kZXYtPnN1
cHBvcnRlZF9mZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX01UVSkpICYmDQo+ID4gPiA+
ICsgICAgICAgICAgIChjb25maWcubWFzayAmIEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZH
X01UVSkgJiYNCj4gPiA+ID4gKyAgICAgICAgICAgY29uZmlnLm5ldC5tdHUgPCBWSVJUSU9fTUlO
X1BSRUZFUlJFRF9NVFUpKQ0KPiA+ID4NCj4gPiA+IFNob3VsZCBiZSA8PSA/DQo+ID4NCj4gPiBJ
IGRvbid0IHRoaW5rIHNvLiBJZiBpdCBlcXVhbHMgMTI4MCB5b3UgZG9uJ3Qgd2FudCB0byB3YXJu
Lg0KPiANCj4gWWVzLCB5b3UncmUgcmlnaHQuDQo+IA0KPiBUaGFua3MNCj4gDQo+ID4NCj4gPiA+
DQo+ID4gPiBUaGFua3MNCj4gPiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBwcl93YXJuKCJN
VFUgaXMgYmVsb3cgcmVjb21tZW5kZWQgdmFsdWVcbiIpOw0KPiA+ID4gPiAgICAgICAgIGlmICgo
Y29uZmlnLm1hc2sgJiBtZGV2LT5jb25maWdfYXR0cl9tYXNrKSAhPSBjb25maWcubWFzaykgew0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgTkxfU0VUX0VSUl9NU0dfTU9EKGluZm8tPmV4dGFjaywN
Cj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQWxsIHByb3ZpZGVk
IGF0dHJpYnV0ZXMgYXJlIG5vdCBzdXBwb3J0ZWQiKTsNCj4gPiA+ID4gQEAgLTExMzUsNyArMTE0
Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbmxhX3BvbGljeSB2ZHBhX25sX3BvbGljeVtWRFBB
X0FUVFJfTUFYICsgMV0gPSB7DQo+ID4gPiA+ICAgICAgICAgW1ZEUEFfQVRUUl9ERVZfTkFNRV0g
PSB7IC50eXBlID0gTkxBX1NUUklORyB9LA0KPiA+ID4gPiAgICAgICAgIFtWRFBBX0FUVFJfREVW
X05FVF9DRkdfTUFDQUREUl0gPSBOTEFfUE9MSUNZX0VUSF9BRERSLA0KPiA+ID4gPiAgICAgICAg
IC8qIHZpcnRpbyBzcGVjIDEuMSBzZWN0aW9uIDUuMS40LjEgZm9yIHZhbGlkIE1UVSByYW5nZSAq
Lw0KPiA+ID4gPiAtICAgICAgIFtWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVXSA9IE5MQV9QT0xJ
Q1lfTUlOKE5MQV9VMTYsIDY4KSwNCj4gPiA+ID4gKyAgICAgICBbVkRQQV9BVFRSX0RFVl9ORVRf
Q0ZHX01UVV0gPSBOTEFfUE9MSUNZX01JTihOTEFfVTE2LCBFVEhfTUlOX01UVSksDQo+ID4gPiA+
ICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBnZW5sX29wcyB2ZHBh
X25sX29wc1tdID0gew0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjM1LjENCj4gPiA+ID4NCj4gPg0K
DQo=
