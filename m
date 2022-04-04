Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27CF4F0F09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 07:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377102AbiDDFYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 01:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiDDFYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 01:24:39 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120073.outbound.protection.outlook.com [40.107.12.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090EC237EF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 22:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNV9Ve9bWoN9P1e+0M3R5NuuO6eLTWthtdM9BFcmdslVVZ0lscDip8Jmaq9okBtDqN5JHjp3ADn7A/c0qKXEuP0vOYUkCoyhuhOflxdJZ8d5SwiBUcS74/Qlgut8qUSurc8cv07vpxrm80hWbQgQ6JRXLo+5ZzaD1fcscIBTxBe5Q8RU0HmhNgQNLHAYCpy52rkALXqjGFvlfgaSvXSx/b2c2x/1ZOesNadkIQQr7XVp5+dXqsHQsMAlZvm9tE3sTBFofMlVuJsXu8ubzrKXu8MZXfZY03pB+IIrxpfuwoZrxrX+Q4JkXP4kgLxAa9YFbQwv7dN/LUFjBA/+6JGWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=el3hUKhAwM3WmDvAkIT5zbv7Utww62Oc4wDoSEPp6Lw=;
 b=VcyKZBHEopD5QISlZN2sJJXX/Y6FHPegAwqxTpDoott0nkN/237uocd4gTZ2srOWbC34gnS2l7fW2B6Yk6ohR9g3Bg0co5NSnGDtwNQTts0ft8g6tohdTgq8StN9gCp5QtvGw3prHDvE5kdpP6xhJMbl07QDfBnuWY8qmVXe9+yDHNPBrAxiunRBxerCcqKiXuRyd/tEekEdT6B9G/Q7z8JPU5KTaDk4J4ecavM8WtczDupuLb0x24wPDvMSpjHdLqRQpPkijDjYSknDAxYRXdo51GOpNF7dekfQ9qDXYeco/qhoiM3cDYZVCRDjeHeWrYHwei6Dixbp73gTBzgD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB3704.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 05:22:38 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%7]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 05:22:38 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 00/14] Convert powerpc to default topdown mmap layout
 (v8)
Thread-Topic: [PATCH v8 00/14] Convert powerpc to default topdown mmap layout
 (v8)
Thread-Index: AQHYM91qt7fUMOkc8kuu86XXaXpzE6y4LsWAgAFp6wCAAAZPgIAlwUSA
Date:   Mon, 4 Apr 2022 05:22:38 +0000
Message-ID: <e61f1ab5-075a-8d68-0315-4d7069be1650@csgroup.eu>
References: <cover.1646847561.git.christophe.leroy@csgroup.eu>
 <ddfed61b-e387-4554-eb88-6654b391d1a4@csgroup.eu>
 <877d91m7wd.fsf@mpe.ellerman.id.au>
 <20220310204917.3d42e6cf3088f7cf1c7fe7a6@linux-foundation.org>
In-Reply-To: <20220310204917.3d42e6cf3088f7cf1c7fe7a6@linux-foundation.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dddd1dd-0590-4557-56dc-08da15fb2258
x-ms-traffictypediagnostic: PAZP264MB3704:EE_
x-microsoft-antispam-prvs: <PAZP264MB370412B29F2B4465063CEF24EDE59@PAZP264MB3704.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+oqTj9ffXQoVNpbGqcdjb5Ho4ZIKu/wLGDhraG8+hZd1bWOQaeNrTJp+EBE5AdesFRvKN4khQONEiSVqjBo/SdLiQdiPDMbEUSvCZEhwD0++a0oja73M8PNdecnOGGd4XIc5sIzPKBLh88c3rcnK4OLVAoo0qxXhAzoA9A3cStzrC7C74uObolAbV8F45qGAvLiTU8N4yEh+Tvt16ZHN7ySWza1xO94JwRAgxv4k9rqNwZxuk7/ud41rRydhjA/nr6Ka1lE1Ke64uoS7mNI5Taxe9SDoLqYSdk1r+rBCPZ1BzOfpUF8s0XZMLeMZ1sDPvLkoA9I7f1s8BgDzsO11KL90vRlBBbWm1Wi5HqjyWxbf6zg+N2Br4P0Czvsdt95omX+5iHiV40HVuObUy55PfPB8F5o2WAwxf7yynArRcH7CO4LEzgfPMc7N0j4eZI9IXJ07MryxVz9aTQz7tUXNBlJDAubVBvErcv9XPVohdOOCw+/AEOndmA4SPKin/2SvDlNjOmZ83fYBN1Ex+HItxfTNp2NAHzY2lvbGFX3y/7OsVvENz0WHqMAURAloLVZdcml/rE6EibnSw0mjNbddn/IxDFn9fdKbyfY35XZ9qIiJilWWkF0Gy5+d70rVnS+OfwE/thVqP4WiPU0RpPlIK0CiN34weOGrOAAIf/drG8FvR0AM0+rN/xJZTFV9uKsxWIfheq76gdTEIuDBga+oRjoQTWeTRy5mruF3MkrsulUDI9S/ITzBcLO1bgw3+v/UPPnY50SHYIHTuzn2ZlG3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(186003)(316002)(2906002)(110136005)(26005)(91956017)(8676002)(66946007)(64756008)(66446008)(66476007)(38070700005)(122000001)(76116006)(66556008)(4326008)(6512007)(38100700002)(86362001)(4744005)(31696002)(6506007)(7416002)(8936002)(44832011)(5660300002)(508600001)(71200400001)(6486002)(36756003)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnJ1K1JUeDdnZy9yUVo2ejE2cWpFclI3N0R0WWUwQUtIWDdmUDhxMHVaSUVq?=
 =?utf-8?B?RFRNMnpHclRyK0hPNlk2K2hudXQyMFlONFVzeVhtVm10eC91VlBTRVpqQTVB?=
 =?utf-8?B?QTZJeHl6cTJ5Q2tJUmM0ZXJLRTZmTHRhVGxjQlJLc1BwRWZSbXc5YVA2UkhG?=
 =?utf-8?B?N0RxQnM5b2lrTUN6aHVkQXE4Vi9VM3BlWFpQTHEyY2NNTm5qR04vTXRINS9H?=
 =?utf-8?B?dmtEdERBcmF5QmtIaUFSUEYzL3BaelhUYk5uQTIzRG9PbytXRDBBa0hlaTk3?=
 =?utf-8?B?czFDUk1SM1dFL2JOQlIrSkZXZTVEb3pGQm53eDlTSEs0bG5VS1kzUmloRHNU?=
 =?utf-8?B?UFpyL1FNajNPSXJRL1RvR0VoaDl2R0RuMTNxMGJNODZKU0QvRGpseGF4U2xB?=
 =?utf-8?B?S1RWZmt5eHZDZFBNbnhyOWsxYk9rTlhvWUVkM3liUmJ1VEJpRTBwTVRpcnBX?=
 =?utf-8?B?VVVsdHBIS2Y1bDN0QU96V3NkQnVzRjJyR1BnSE9odG92UXNDdHk0NE5KV2RP?=
 =?utf-8?B?cG9MVzFzZWdjSFpVbUFlclludllEQU5MTyt1QituMnRYUC9BdUhTSXpPL1gv?=
 =?utf-8?B?MkdnYy9kVTRHVjNZSlFyL1RhOXk5QlBpZEl5b2NjNDkrYlU2N0dtSjRZbGo5?=
 =?utf-8?B?SlprMWFXVUZqZzJNNXJtdm1CSzlrQnVrNEEycHI0ei9vcFJPc3U0elZhNVpw?=
 =?utf-8?B?bW1kNmtCTXN2YnZTdVI5Uno2TUpkUHJrK0Q1djBUZmM4Ukd0SFQ3US9IR1lp?=
 =?utf-8?B?TjFIS1ZhMEpMcTJMZTVLK3hnVytNOGhNVmVmais4MjNTMHQ0K2dYVEpXbS9r?=
 =?utf-8?B?dHFKeUg4TGYxWHdOeWNyT2s3K2ZKWkludEVVeDlpU0hJYmh6eGpWRjVFc3pp?=
 =?utf-8?B?NzZGRzRNY3poZnhuZDZHT0tUV3lSOFJDQURNK0lWMlJGYlpoZE1MYWc5ZWhU?=
 =?utf-8?B?UmRvc0F6M0R6aG9idGpEZjd0cklUdThrdHdGUHJkSlFzVWhrMWo4WFpNOTBL?=
 =?utf-8?B?TEdnK0NGNUV3bjdiVXhQb3dkRzdUck9vN1c2M01KQUc5VFdQam1xaG5xOHpS?=
 =?utf-8?B?bm5IeVVPSEpKYS9wRW1JZzg4NXc2QWFTaFhzVWVMWnZmT2hHNHZRN2g2RlNF?=
 =?utf-8?B?ZlJsV3RkVmhGZWMxNmcvSEhUdjhnaXlLZVRQUG5KTS8yU0RNdWJJeDFycENW?=
 =?utf-8?B?WHF5bmlYb0phUjNCamVFL2NMenJ2M1lBTmh3anUxU1N5cXZBSWFqR2xoM0VG?=
 =?utf-8?B?bW5CVmNKSStRc3JnUTZxWTZQNkNHdnVVM3NjMUxsbG1PVExBVGIrcjNMczIx?=
 =?utf-8?B?SEJBNHorOEZCVVQ1SEZ2QW5nRzZVdk14bS94UTJIWlRBU0FlbDI1Y1Z5VFR6?=
 =?utf-8?B?UE1pcXE5NWhwbnVzS0VsVEpJZ05FbExQOXIzRnc0L2VLdjBMS3dGWmhZNm1o?=
 =?utf-8?B?M1lsZ0l6VktUYlQ0OGJ0L0Nza0pHUkZpRE9haWJobXpLVjYwWU9zQUlTR21t?=
 =?utf-8?B?WlNOdUs1S1VHOWhjMmNXZ1JGNzB1UldqVldmVzcwRGtlckFlUGh5UTVUSDEr?=
 =?utf-8?B?WlFqbWZPM0w0M1NZVzFqYkhUMVk5UllQdkk1a1czbVZ4K2lBTEVyUlU2SG9F?=
 =?utf-8?B?TUc0eGRWcGNBa01QOEQ1Nm92L3Y4Wmgvb1pydjhlaTJ1MTVQUUErSmNFZmNa?=
 =?utf-8?B?ak1sRTZ2c2ZhSmp3aTJvQjBhS3RhK1NQQ1d1Q3l1cHd0a1VUZ3Z2OHowV0lz?=
 =?utf-8?B?WFljMjJLZU5jWHVJYzE2MU5Bdm1FaDFuYnY2SWsrakZ6YndlSThuZVQ3ZmRZ?=
 =?utf-8?B?ZjBzcUM4TXZjRlNHSHB5ckNiUXFnWW5JUjN0dDIxVkFhWWRTOS85MFBIcUw2?=
 =?utf-8?B?b0JoaXVEbzY0blhJdmp1WFNwUDYzTzR4dHlnV256QVZFL2w3Skt5TlJRZTVO?=
 =?utf-8?B?ZEdPZ0lYd1VZMHJ5OUpCNDVXM1N0SGl2YnNKUWtydksyTDJuNmNnN0VqVWlT?=
 =?utf-8?B?V0wybFN3VEd2dkNPa1MwWEhNWGZRalV5anZIT1VRenVhN1pERTNTVFgvZ2h4?=
 =?utf-8?B?SXVuajNkQ0k0U0ttYjFwcmJuVWhXYW0rbjRkRlF0dExTdktoWUswWVRrYTR6?=
 =?utf-8?B?Z0VlSmxlZzkwdnEvM3lmNXJvb2xmM3hGa2V0NDNkMHpuRzhYR0hDNzR1YkZk?=
 =?utf-8?B?N1A2MEZmcm1YTVpHT1ZNR1hsOU9nNGxBdFkyK1Fna05lQkUvUW5RdExKWWV5?=
 =?utf-8?B?ZXpQcHBEeWxHb0d2SmtBT0NyS1NaL3F4WExzZXNreHB6d1BqbllJYnNmV09p?=
 =?utf-8?B?Q0YvUmJjbW1lMlJtOHlUTUtZMnlPWkJQc2hITHZpOEJTRlFYRXBBbExBLzBE?=
 =?utf-8?Q?xRvF4LLA9JcfdiYgNFxbH7Hx3Akqdiy7KyV2o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48B0859F1543B745B4A81731EEDD6700@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dddd1dd-0590-4557-56dc-08da15fb2258
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 05:22:38.2598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxJj33A8B0BdMIqsL72zxrCkI8z2ZCZyS3SAWCpbneNgXO++tYmV1C9avcB4gluuSGXHkyPBfpC3GgVITk4/5PxY7GG4uvmdZ3GtBncrAwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3704
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpMZSAxMS8wMy8yMDIyIMOgIDA1OjQ5LCBBbmRyZXcgTW9ydG9uIGEgw6lj
cml0wqA6DQo+IE9uIEZyaSwgMTEgTWFyIDIwMjIgMTU6MjY6NDIgKzExMDAgTWljaGFlbCBFbGxl
cm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1PiB3cm90ZToNCj4gDQo+Pj4gV2hhdCB3aWxsIGJlIHRo
ZSBtZXJnZSBzdHJhdGVneSA/IEkgZ3Vlc3MgaXQncyBhIGJpdCBsYXRlIHRvIGdldCBpdA0KPj4+
IHRocm91Z2ggcG93ZXJwYyB0cmVlLCBzbyBJIHdhcyBqdXN0IHdvbmRlcmluZyB3aGV0aGVyIHdl
IGNvdWxkIGdldA0KPj4+IHBhdGNoZXMgMiB0byA1IGluIG1tIHRoaXMgY3ljbGUsIGFuZCB0aGUg
cG93ZXJwYyBvbmVzIG5leHQgY3ljbGUgPw0KPj4NCj4+IFllYWggSSBkaWRuJ3QgcGljayBpdCB1
cCBiZWNhdXNlIHRoZSBtbSBjaGFuZ2VzIGRvbid0IGhhdmUgbWFueSBhY2tzIGFuZA0KPj4gSSdt
IGFsd2F5cyBuZXJ2b3VzIGFib3V0IGNhcnJ5aW5nIGdlbmVyaWMgbW0gY2hhbmdlcy4NCj4+DQo+
PiBJdCB3b3VsZCBiZSBteSBwcmVmZXJlbmNlIGlmIEFuZHJldyBjb3VsZCB0YWtlIDItNSB0aHJv
dWdoIG1tIGZvciB2NS4xOCwNCj4+IGJ1dCBpdCBpcyBxdWl0ZSBsYXRlLCBzbyBJJ20gbm90IHN1
cmUgaG93IGhlIHdpbGwgZmVlbCBhYm91dCB0aGF0Lg0KPiANCj4gNS4xOCBpc24ndCBhIHByb2Js
ZW0uICBQZXJoYXBzIHlvdSBtZWFudCA1LjE3LCB3aGljaCB3b3VsZCBiZSByZWFsIHRvdWdoLg0K
PiANCj4gQ2FuIHdlIHRha2UgYSBsb29rIGFmdGVyIDUuMTgtcmMxPw0KDQo1LjE4LXJjMSB3YXMg
cmVsZWFzZWQgbGFzdCBuaWdodC4NCg0KQ2FuIHlvdSB0YWtlIHBhdGNocyAyLTUgYXMgdGhleSBh
cmUsIG9yIGRvIHlvdSBwcmVmZXIgSSByZXNlbmQgdGhlbSB0byANCnlvdXJzZWxmIGFzIGEgc3Rh
bmRhbG9uZSBzZXJpZXMgPw0KDQpUaGFua3MNCkNocmlzdG9waGU=
