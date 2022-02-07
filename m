Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DADD4AB6AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiBGIbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243350AbiBGIaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:30:13 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B76C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:30:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVyqi1x0iPT1wiS8HcejYZ0I1sM2QVZqzUogx6YtXVh+K0D55WOdIegMBGXfjKssjVi9Drk4ggc/xr59iNWEk748eJWtQO8KrZYDEX2a3S4fWFgm5RAuy3u1vI/c0ogwqlW7w0oHTLfJCM8KKT+lISh8sMr23adx3ZsKpBN+I6ut/8G4Y9N+LDvRUHkK7zwHjE/0TPy4KtI9KCPX0DRLGhqYLQlshWeFEvxx0rYrZlmkfpFPkPFrmEn2n3MN23xSs7Wj7lkLBjf+gf1q/+1BBgkYCxtoa8ZGZJPf3UmRHpBxNLGymhNWCLVJYpqPm2PPF9BvpzvDYkrFJDVu29mp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyl9PCJEBCdqn/cJ3lJIviJrrwBtaxlqLMwSM4gYTw8=;
 b=FUFcRynEgbudJam6rryVN81CoPscy5+/EAlR5Vd9U3xwxC+BVqUDbTPJF2tmb/o/RQNXzi/LXUjhWzPzNK4sEb7zCir2uF6ekWBovCfHovZLr4dyzqaJ8bw1YKSow6ChqTD994mdYEpoOe/pSuctg9Sq633LAxZg5PKxpbtqiFRhX2xwKsb22RTDuay6Tl6bj4SOTnc4gyPalQF2JsIgkMME8PjZVj9J89xLABO04etwb0CxnKadDHpwRdqqVY6JO11vC+cvo1ynRz0o29UtTUXQ8RWOZzR3FHD13Yq+CyqycGCYg4+4IV9flBDvSy1tZrNYKOtilOJd4p0f2QE2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyl9PCJEBCdqn/cJ3lJIviJrrwBtaxlqLMwSM4gYTw8=;
 b=if1OFX4LOn2QboKukriib4Ae0THcIqcX98UR1cU/1BL5l6DJnvVbxm36TyVEQ6ugVo/kKtcmu1sBX5toGY0fZ9gPXy4trSKjh6eIb3JfVlXe6KQP10O3derDwhXgl1SesjNkdPtIvDI07g5bELz6zifbIQ/LZb2tpryi9LIijhY=
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by BY3PR05MB8547.namprd05.prod.outlook.com (2603:10b6:a03:3ce::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.8; Mon, 7 Feb
 2022 08:30:09 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8%7]) with mapi id 15.20.4975.010; Mon, 7 Feb 2022
 08:30:09 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH v2 4/8] VMCI: dma dg: set OS page size
Thread-Topic: [PATCH v2 4/8] VMCI: dma dg: set OS page size
Thread-Index: AQHYGQCA/huaU39+00aQRWM4KUdDyayDgRwAgARGtwA=
Date:   Mon, 7 Feb 2022 08:30:09 +0000
Message-ID: <D803905F-DA2C-421E-8D16-CAB16DE6F74A@vmware.com>
References: <20220203131237.3380-1-jhansen@vmware.com>
 <20220203131237.3380-5-jhansen@vmware.com> <Yf1CQO99mPzLg+Mq@kroah.com>
In-Reply-To: <Yf1CQO99mPzLg+Mq@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e50902c-f365-4eca-ec0b-08d9ea140d8c
x-ms-traffictypediagnostic: BY3PR05MB8547:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BY3PR05MB85474D047187E88A1211A3B5DA2C9@BY3PR05MB8547.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NxFUnJVjiaTNzf3cheCA5R9X+rh/Sl/X0jWWg6Qik7efQFhRnngZEU6sfZtyLz3cL4PotaPeT6Zaw3H+nk04SqU0kAPfK6e9nq1WDd8QinX8Kr94X+ajXSVdVZoTONx68sEKM3gznXjo+ZoZRmWOT9uUGFH3h9Ucz6GhYola/Oi8e7/Dh2kaXsTRlwM9pyeJxXVFJsSYRc9E0DG+RJxnTcfa6TH0Rlns9411WYsvSQSu+6QutA5QvJi8VWLSNrZH+eJZQ93C4n+G70L30Smi1Jwj7fXBot8TDoV19dmYeteugpNY9WJrfJGsewq9A87GqUFNcYTgAFbZdmKFfkueKPxFC07ljkjDPa3UBi6u3wNZ56GsPEcyVEBNLqqeopJEXwK1+1yNfi5JL/hl7ApNuQMRgEyfvHu5TrNIJ+cQL8Dm+My9PzJiIGJpfPdicWPXAkicwJZBa3seeHP+KZhOOBpnCeIQ+xIaCmIhJHR9C5JY+sHRHAUvtUqR8n8bTUbreS4+3VPFWZlj31DFRpR1Y6g4afQSct49uLDCbsJjV4XE/r79pbHeq59oHrZRz1Jic7UXpFHlUBYapPt5KxI+NpdGvZ7UkAMZtJnRNH5KU//76QjLNUr4Rx4iWtT6iakx7FjPGw159/WshOBFjLTDA9XA5Z25XbNAiSnofudGWn5IrG0iezblbJX9metOS29D18ULROEE5DeKd1gsTJEkTmxt5U29WDP8pKARbFwlWJjHmmMqxoGlkMtwz3KfWDCAIAQcz/GCwftiNmPnCXwBYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(26005)(91956017)(86362001)(36756003)(107886003)(122000001)(8936002)(38100700002)(71200400001)(186003)(6506007)(2906002)(66946007)(6916009)(6486002)(38070700005)(54906003)(2616005)(6512007)(4326008)(8676002)(66556008)(66476007)(66446008)(64756008)(76116006)(316002)(33656002)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWVMSSttdkgyc0VKbFd2S25RbmFTWE0zT3dHUllUdTZ6VUZmYlhJUDk0azlU?=
 =?utf-8?B?bU1rQ3VZSkxmUWNnTWJaY3ZTTUZSbDk2RlFHdkJqZzhJS1B6ZStiRkdoN3No?=
 =?utf-8?B?WWx4WkZVb1U5MDlKQ3d6RktlbWVXdFM0dzVyUk9nMnVqWGRwR1lKd2ZURWRQ?=
 =?utf-8?B?TkZ6R010MVRQRU5rWWRNQXBkallxYS9RY2p4VXVzN09lZ3VLcFdXWll2NFpr?=
 =?utf-8?B?NjlJcHBaamlYcC9HWXEralNWRU16VTJpSUx0UlpUd0xpNHhqRHgwbTFJYjk2?=
 =?utf-8?B?dzhqdThqaDJwZ0d1WE02WHFtZ1JKMXVRVkVSYXpUL3o0TzJ0bGNOTFNMZlFp?=
 =?utf-8?B?YVpWeXltS1grMFA3bnV2ZndPRWJNT3I0SWJ2Z1ZPbE52dmZUZTVIR3JBS2hi?=
 =?utf-8?B?SmcybDNVOEFIbEdGZHYrN2xyTnFyMmd1UkgyblVyVjZqNlhIZWE3dE1teU1l?=
 =?utf-8?B?YnpSRWNXRGJWdHBqbUN3MW1kdkdNbHNCOFRDTlhpeVIvUlZjcnRhYlA0Umhs?=
 =?utf-8?B?NUExeGY5VURBYm00SDNBcG1ISWEraFJIdXNtTTY2QXBTNDMxNFZxeXVacUN3?=
 =?utf-8?B?aHN4ZkgxeXhsUlYwb1dqVDRZanZFTVdLOGtuL2Y3ZkFJanpraVhRdFJMakJG?=
 =?utf-8?B?N2lnWW45dURJOFdjQVRqVGlKaWdPZ0pSRjJOd3N5aHhUV3NNcmk2Tk5URlZ1?=
 =?utf-8?B?OXFPb1p2OG9WRk4rYVpRK0loKzYzaDJ2T0RTbEh3N2NqaFpIeElhdU9kak92?=
 =?utf-8?B?MmFWRlBIOWVCL0VEOFJraklBcGUwbzArVG1SbmNleUkvRGNTNWgxbld4UjFB?=
 =?utf-8?B?NVZKYm9LUEtlRUxSNEgreFBOTWpsRXlsRlgvOTVnTXc2VXRtQUZiN1BpOUht?=
 =?utf-8?B?QUVsMWgvY1NPeUMvaHo1dHpVTERxQnlxM2JOcDdqTTZFdGFWK2xIc2Z1ZFQ5?=
 =?utf-8?B?cU1ISXlkRmFRcjNqQVpWOFltNU1Tb3ovYlExbVB0TUdXNUZiakxLVHZRQ1lF?=
 =?utf-8?B?Z3FEL29FQ3FsT2pjMTZEVFlKeFNENEpCT1JvT0p1bzdhVlVEVGE3RlRHV0FC?=
 =?utf-8?B?UnM1OG4xbzNiWW8vaU1HcXVlTUZFMEc0VXBtTVJyKyt5UEJ4MGo5YWhyKytk?=
 =?utf-8?B?ck4xWGlRRkttcnhiTTZMdit0VDJ0TkszSUh0bTIwK0lUWVEvT1hnR2ZaSUww?=
 =?utf-8?B?L2drSmRIcUpNY2pybHJ5bEN6cnJsVU4vaXpPcVFQVjVpeGliNTBEdGRrOUR5?=
 =?utf-8?B?VExPSVpKeHI5S0pUeG9QRVlyb1J2T2kraTZnNG1GSVYzZjBINjlDS2Z6bVZI?=
 =?utf-8?B?cllZSGxXMVFtb25ydHIwM1pRR3dtWjA2MUZPbmJGS3FjOGQzaldDWmVpeU45?=
 =?utf-8?B?MmttMVFYZVNwR3YxL3o3dGhPamlIQ1AybStVbG1KWTVibi81aDV6SFZyZUFj?=
 =?utf-8?B?a0dDZGZxSjRYZlBSK2RUTXU3Z2xmZFYxclkvQjN5czlrRHVHd1Ria3ZjUW1E?=
 =?utf-8?B?bHhUaXBYLzJ0b0lRb3FkNU50cWRIelI5SXVJbUVDRFg3aXNITjZhcHZzT0pz?=
 =?utf-8?B?SUY1VlFvL1kwVlFuUWs5RS84cmxpYXdaSys0ZThGMlMrUTFYOVZVVzBEdnk3?=
 =?utf-8?B?SUtYUXN3VXBFb0NqZWRFSlJDSUVkajhVeVBiSENSZkNjTUtralhKaDVwVUd6?=
 =?utf-8?B?NUgrdkppSklmYnAzTUdjUWZiNjhybEtnU1pwdkRXdTh5TURsUTlLU2RjN2dw?=
 =?utf-8?B?MVlYc1djN1dDdERaM09YbnhWV2o1d1QrcmVzTitKM04zUXY5QmdZaE9hZEtP?=
 =?utf-8?B?VkJTYmd1MTBrVTJFVnB2aytNc1VwbkFWZkFzWDlGZFBYdDhWc01xM05DN3pD?=
 =?utf-8?B?WWRMVkhKcEtxUFJSQVJtSDJPdDN4QWw2SEUxOGc5dXdwd1R0TmptU0Q0ekVF?=
 =?utf-8?B?Mzc4c1JxRXRTWGpmakNtc0VpOFVOaHd5MTE5azRhOCt3aEE3eGdNdUtxZWRx?=
 =?utf-8?B?Uy9YUlpnYWJSZ3FScHpiVW1OMVZTQkl5b2RyQ3EzbWh6L3RxdVBRdHJYV0hl?=
 =?utf-8?B?NkhKa1pzRnZCRkswTW5iK0dIVHBEUHQ4eVRHRExnUitRQWlYRnFZT1Y1MnZO?=
 =?utf-8?B?T0JsK3BRWkpuMlZwQWIrUVRKR2psM2tSYTIwbE9wTXhxSTBDSmhUR0xNaU5y?=
 =?utf-8?Q?eIfZsHPGHoIWZBIRlHYF4N4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D81FBE92AD1B3A44BF607A217A260E18@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e50902c-f365-4eca-ec0b-08d9ea140d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 08:30:09.5814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kO3OEtCoWeN3umha8Kj39uzCNPbQkrrZtK2geKz6r3JuPdnoB50YreDm1Cdpdsb5YrstH3k4WXcEmM1qBwRdqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8547
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gNCBGZWIgMjAyMiwgYXQgMTYuMTIsIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgRmViIDAzLCAyMDIyIGF0IDA1OjEyOjMz
QU0gLTA4MDAsIEpvcmdlbiBIYW5zZW4gd3JvdGU6DQo+PiBUZWxsIHRoZSBkZXZpY2UgdGhlIHBh
Z2Ugc2l6ZSB1c2VkIGJ5IHRoZSBPUy4NCj4+IA0KPj4gUmV2aWV3ZWQtYnk6IFZpc2hudSBEYXNh
IDx2ZGFzYUB2bXdhcmUuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9yZ2VuIEhhbnNlbiA8amhh
bnNlbkB2bXdhcmUuY29tPg0KPj4gLS0tDQo+PiBkcml2ZXJzL21pc2Mvdm13X3ZtY2kvdm1jaV9n
dWVzdC5jIHwgOSArKysrKysrKysNCj4+IGluY2x1ZGUvbGludXgvdm13X3ZtY2lfZGVmcy5oICAg
ICAgfCAxICsNCj4+IDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL3Ztd192bWNpL3ZtY2lfZ3Vlc3QuYyBiL2RyaXZlcnMv
bWlzYy92bXdfdm1jaS92bWNpX2d1ZXN0LmMNCj4+IGluZGV4IDVhOTlkOGUyNzg3My4uODA4Njgw
ZGMwODIwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9taXNjL3Ztd192bWNpL3ZtY2lfZ3Vlc3Qu
Yw0KPj4gKysrIGIvZHJpdmVycy9taXNjL3Ztd192bWNpL3ZtY2lfZ3Vlc3QuYw0KPj4gQEAgLTU4
MSw2ICs1ODEsMTUgQEAgc3RhdGljIGludCB2bWNpX2d1ZXN0X3Byb2JlX2RldmljZShzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwNCj4+IAkvKiBMZXQgdGhlIGhvc3Qga25vdyB3aGljaCBjYXBhYmlsaXRp
ZXMgd2UgaW50ZW5kIHRvIHVzZS4gKi8NCj4+IAl2bWNpX3dyaXRlX3JlZyh2bWNpX2RldiwgY2Fw
c19pbl91c2UsIFZNQ0lfQ0FQU19BRERSKTsNCj4+IA0KPj4gKwlpZiAoY2Fwc19pbl91c2UgJiBW
TUNJX0NBUFNfRE1BX0RBVEFHUkFNKSB7DQo+PiArCQl1aW50MzJfdCBwYWdlX3NoaWZ0Ow0KPj4g
Kw0KPj4gKwkJLyogTGV0IHRoZSBkZXZpY2Uga25vdyB0aGUgc2l6ZSBmb3IgcGFnZXMgcGFzc2Vk
IGRvd24uICovDQo+PiArCQl2bWNpX3dyaXRlX3JlZyh2bWNpX2RldiwgUEFHRV9TSElGVCwgVk1D
SV9HVUVTVF9QQUdFX1NISUZUKTsNCj4+ICsJCXBhZ2Vfc2hpZnQgPSB2bWNpX3JlYWRfcmVnKHZt
Y2lfZGV2LCBWTUNJX0dVRVNUX1BBR0VfU0hJRlQpOw0KPj4gKwkJZGV2X2luZm8oJnBkZXYtPmRl
diwgIlVzaW5nIHBhZ2Ugc2hpZnQgJWRcbiIsIHBhZ2Vfc2hpZnQpOw0KPiANCj4gUGxlYXNlIGRv
IG5vdCBwcmludCBvdXQgZGVidWdnaW5nIHN0dWZmIGxpa2UgdGhpcyB0byB0aGUga2VybmVsIGxv
Zy4NCg0KT0ssIEnigJlsbCByZW1vdmUgaXQuDQoNCj4gV2hlbiBkcml2ZXJzIGFyZSB3b3JraW5n
IHByb3Blcmx5LCB0aGV5IGFyZSBxdWlldC4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1o
DQoNClRoYW5rcywNCkpvcmdlbg==
