Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC29D4B6646
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiBOIiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:38:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiBOIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:38:08 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2055.outbound.protection.outlook.com [40.107.113.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50036EA343
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:37:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhoXP5PDT8d/Po1gI7lQ3MfcFgFbfHM0toqnvLCiHfNHThZ41f+J1W604VJwt55qOkHpI0g2fJ9NxyMY39iaPhaZ0b6bMLcLacClus1gTy4LvNK9aizuFuGzSvtlgGg3UrxP27uwRuDdvsmbITGyAr6Ql9b2001zWTAq/QQUvLoc9A0sVllIt5aDeu6huyCyW7H4E2cPqRiTr57cD70ehOh3RZbQwTurAXLVpXPR4IPQC6DxTo+p9m6NyjrSIaG6bdodjSZg9VjLKJqEnx/kMOf24yD4YAN/9loJKYq6X2SrJjlXZ8oko4VSJ/oL6BVoWfBGGFvhp7aF3xeDKIwWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3age2PU8/OW6Unf3IlGtHMnMS+PPg5JW2BmgE+McwC8=;
 b=UClgZtt8K7hd7PhLpoRGoWLfBPw8qOM+ZsqwMiMO3U++DQmvEIUh1A5qu+kr4YFhatOArhUE33HrEKeX1nAvmA6bVxZPAEok1J2tgC9Idz7fJaxQYhMTmSK6sLqM5qR8vTKyDKOSU+DBjZSSGQcLJJOj7kILStd0reMDQIVEYoJ91fHoauAl0E5sOT9J+VhzJeImhdW33EGf9W/UUkZzMz0RaNhfq/lDv7Safvr3NGQtbJD1cVTUPcwqyFjWoB4IPt0uWkMq4xYF0uZHkBju0NCc8yu3m4Q1a8c4qQkrj5bxwFgYnbXye4TKLz3fsc/LT7NKwMoL971QKMVvJC/EXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3age2PU8/OW6Unf3IlGtHMnMS+PPg5JW2BmgE+McwC8=;
 b=Ch/OMKLW/d/ONaNr7pmbLSkIbpKxsHAU2ON5EjrbRUPw+0hdQmJdJ8KqCh7t7Y5AhDrpD/R+/GmVeKdUNQzBUSL4xxMgWSl2MrAA5H/b72/j4BeMFAw0QOsYCGLwklqbmFeL3LSIuTRIqOZTKty3ZTdhLrVP5f44J3wkL4aRaCk=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB8251.jpnprd01.prod.outlook.com (2603:1096:400:104::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 08:37:56 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 08:37:56 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] mm/memory-failure.c: avoid walking page table when
 vma_address() return -EFAULT
Thread-Topic: [PATCH 2/8] mm/memory-failure.c: avoid walking page table when
 vma_address() return -EFAULT
Thread-Index: AQHYIhVedAER3YKqlUy29jDjivEPIqyUSnyA
Date:   Tue, 15 Feb 2022 08:37:56 +0000
Message-ID: <20220215083755.GA2001565@hori.linux.bs1.fc.nec.co.jp>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
 <20220210141733.1908-3-linmiaohe@huawei.com> <20220214144826.GB2624914@u2004>
 <1c464c41-81f4-fff9-c4e0-45fd4d05e34b@huawei.com>
In-Reply-To: <1c464c41-81f4-fff9-c4e0-45fd4d05e34b@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69f9e92c-53e0-44f0-c02a-08d9f05e7716
x-ms-traffictypediagnostic: TYCPR01MB8251:EE_
x-microsoft-antispam-prvs: <TYCPR01MB82517FACD0A951C25A3B1494E7349@TYCPR01MB8251.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxJ+NifqF+7+ihkxbtxFpqse7YSufKOBrRnmj9le4qspCrwI6HMOlyqSrXBE9NoHm0t6YL9jQDUUAXnz8C14rsRqCj8kdma5CFhud9q4qOHnU8BLwBB42gzaSwEcVUETPkqS9fzHTFsTXUtE6MOQpDZvo+4RFJfr7lEabvMzISeWfpfk3M6wC+n/wCjJVXUS/sIpQ5axoKk8RkYEgcayB6eZq87S5hZoOI88FK5Dy4jVVuw145mMPX2HFlBYZ3m/P+RgcH96P6fRTvht71303AFt83sP883mCZW5scRh7e+9AoWOd2txbJhVDGpEIBoLVW3wPJzlV3j0UYpv4l2lv1C6WXiSxy8tiGYKLd/0FnSTC6Xd7KfMS2nvIVUeRhisYt+kb9W5TRQE+BgFyLxN1gFK6tcHHvP9C3EgzYvK/eteuVVhZx1lYUvW/rz0WQoyDRzZcX7Pxi13FmRI3yDd0w0ZiN3YjaTG1CvVfB0cvnF71ObHVNKnc8Auk+HGy1hqOq13WvFatTwS82e0HenwpBp+TTuxFefmjh0TJNMw0vKtKjxzfoK5M1ueKOsHx9KaLVUWByswvqBNaauT26MqoevAFE8AqyXi0d7XfYFWBbUA9lbCvvle5pcYlGRuxxuIbsxoD2Wwrl3PHc+ALJXOFqQR2TeCohl7BDPNpx+f8gqL6ttqEoZZ74WDE5b2rdUZoYd1m9T1BumomUBP7eqOrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66946007)(66446008)(186003)(66476007)(66556008)(64756008)(38070700005)(76116006)(4326008)(53546011)(86362001)(71200400001)(55236004)(6506007)(6486002)(508600001)(6512007)(26005)(1076003)(54906003)(6916009)(9686003)(316002)(82960400001)(2906002)(122000001)(85182001)(5660300002)(8936002)(33656002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHNGUHJQSnpyT0xQejMwdGhDWnFTOFBONDIzcFhsQmMyNndBMGlWVnl6UFJQ?=
 =?utf-8?B?bEdWUE95dGVja2oxVDMwTlNZT3lKNXlQdldWNmZ5T2NWazRvNkRYVEgwc2F4?=
 =?utf-8?B?QzJjS0daZ3VNQ2xGazAyN2tRZzhERTQxaXFxQW1zZXp1clM5NmIxbzJWbTBi?=
 =?utf-8?B?aHNEdjB4YTQrYTVtUFI2Ujh6eWk1bEZPRis1dXova0NFeHNjc3diUTRHNEhK?=
 =?utf-8?B?d0U0d1hLZjBDT0QzVmNjZFFLNjl2S0JVV1VIa1Z6UWx2cVFicURlZ294TWRC?=
 =?utf-8?B?SGhMcnZMS0c1ZWFRVGJUTXpPQ2xuT1VQMEdwd0ZQanBnWi9leEZBZVJuR3hV?=
 =?utf-8?B?UFhoUHdiRlRPNjAyN0YwdzdQTW9vN3FuOHRuVnlVaHgrZENHUGNpZ3Q1Wngr?=
 =?utf-8?B?NHBab0Z0YjIwYm43bEo1ekUrbFRHeXVSM2M1b2pPVC80VWRhWXVqWkJLYnJ6?=
 =?utf-8?B?RFhlYnpWbGZGTU9LckVsRXpFWUg1bkhnY0huQjcyeGlseWIrMUlKQzdIWkN5?=
 =?utf-8?B?K1IwM01QTTlpV1l0Y1pxbFJUY3NJeWpCaUs0VmFiK1hrRUtvSHp6SCtnbE5D?=
 =?utf-8?B?QUwyWW1ZaWd1eitWMFBvaXlhUlkzcnhDWTM0RUp5MjVlUWRTVnZKZTliQ1J4?=
 =?utf-8?B?NGpTUHJGSXM0UzdWYzVsSFNhSzY4aWtvajNMSkQ5TWkvZnpiUmZ5MXY4WGNt?=
 =?utf-8?B?OU9TWkpyVHhIelpWNlI4dkZ3YlYxcWI2eW5xamJxUDJtOEZUK3pJVDhldXNQ?=
 =?utf-8?B?V0VoQVhtL2tqYWVjVEE0QWRaUTRabDl1M2thUEFiamJTTHU5Wmt0STVoUnZ2?=
 =?utf-8?B?bHdzcUpWNlVKWmpkUkFDRkNlbkl6ZXN5Mk1sMEp6TUpqVWgwT3NvNTBrQmda?=
 =?utf-8?B?YkNkQWRGY1JNbGtSZFprSTJaTWVsYVJBZk1QL0RVMDZ4SW5HN0paMS9mRGk2?=
 =?utf-8?B?Qm45M09XekZlU0RwWjRHb2U1alY0WXdkRnh0ZHRKS05id1ZDODZGazVBK2Iy?=
 =?utf-8?B?clBzaiszTWptaWdHMjBMT2hWaEhnTW9OU2dhUjArWlJCYnowTHpLK3EwN0RR?=
 =?utf-8?B?a3kwOHRKYTUzcjlZWllRd3hSWVppQ0ljRFU4WUhEWDV0TkJLeThrdy9OejdH?=
 =?utf-8?B?TUhhVnBlcyt2bU8xUDhlbkhWWC9Zb1BlcUJ0YXBRUnF1UWE3dUtXUWFZcnM0?=
 =?utf-8?B?UXNuRUdFWUlXY252S2RGR3FUUzN1VFNUTFFKWjlLN3llRGJONWw4VzZuOW5R?=
 =?utf-8?B?alFoZEpueGhGUFA1OWJDQ2dlM241THFHN055UWxCV2tqMkR5MVFMeUJJbm51?=
 =?utf-8?B?azRmQ3MxRlBiOFlIeVBVdW5uaU9xZWUrdndWOHBIQnBGb2xaRUVYQWtpQ2Ny?=
 =?utf-8?B?SHJ3THdoZDlkdWE2SHFTdS9NS1Q4Q1ZSUUpSMXVwU0Q2cStNY3k4U3ZiNzE0?=
 =?utf-8?B?ZUNkd2I4Njcvbko5Q0d2eHFNeVlieFhia2JFU0wwZFpXelRrYnJ1NnZURm0x?=
 =?utf-8?B?M2V0YmUxc0lUblVMejNzMUExMlZBcitnNHpZTEhTSmp5eDg4SUtYUFlSRXRG?=
 =?utf-8?B?SE1NODc0RG9MazFkVk1SSXZYc0xrMUlmaURKd2Qxc1I3SFp2alZPOVZPd2E0?=
 =?utf-8?B?RTlpbHZFVUZJVUZYd051c1FFRkdYMTJBcVVBOVVsekttdDQyQUtxS01ZY21x?=
 =?utf-8?B?MkQ0ZGpudTJGejFuaWcvQlRyUE9FL2t4c1ZMbzVzcGw4MXZ5L1MvZFNTNFVh?=
 =?utf-8?B?THpFbjFhK2FlcEFKaVo1TzJ1SDZwNEROQkoxc2pSZkFIU3doZk1oUnF5amw4?=
 =?utf-8?B?NkRjbkdSOXI1NW1OMXRwL1ZnbTZmZVhoejdIRGNmbTcxanVnVURJWnJoWDkx?=
 =?utf-8?B?ZmZBYVVHa3N6UTNkUlNXMGJwb3RQeHllSHg2WTI3eGRWbU85YmY4SHlKejh2?=
 =?utf-8?B?WGYrS1dwRHhXZGhzREpkZHJzYVNRdVJiWi85UXdVcjJ0K1o3NGo4NjZnaG1O?=
 =?utf-8?B?QlgvdTc0QWVPWnNkUzk3UTRld3pvR2hXVlFuMzVVVGJndjlKRnI0czFTQnBC?=
 =?utf-8?B?MmtkNmtwVGFMTlMrSGI3YjdaL3M3dUFxT0V6YjdUWHZ2Zm5Md0pXSmdoSkI0?=
 =?utf-8?B?MEJ2RUF4ZmphQ1A1MzB3eDZuNG9LUUVldXg1a0dkdm4vVjNhVkNNc2MycW5O?=
 =?utf-8?Q?w0fUofuojnTVpKrtIZAZ5KTymUFXZzcq0FGvTDcGY3qa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAE601C01053F8458C2DE1E64A5E44B3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f9e92c-53e0-44f0-c02a-08d9f05e7716
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 08:37:56.4738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5U5uznmCRk62SrpbiFcnA90H8NOiXkI6ZQqwfQFotnOvEvE59HNJjTD66YjlS6oicARdVz3ZHjlNnxaI87duqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8251
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBGZWIgMTUsIDIwMjIgYXQgMTA6NDA6MDJBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi8yLzE0IDIyOjQ4LCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gT24g
VGh1LCBGZWIgMTAsIDIwMjIgYXQgMTA6MTc6MjdQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90ZToN
Cj4gPj4gSXQncyB1bm5lY2Vzc2FyeSB0byB3YWxrIHRoZSBwYWdlIHRhYmxlIHdoZW4gdm1hX2Fk
ZHJlc3MoKSByZXR1cm4gLUVGQVVMVC4NCj4gPj4gUmV0dXJuIGVhcmx5IGlmIHNvIHRvIHNhdmUg
c29tZSBjcHUgY3ljbGVzLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxs
aW5taWFvaGVAaHVhd2VpLmNvbT4NCj4gPiANCj4gPiBBY2tlZC1ieTogTmFveWEgSG9yaWd1Y2hp
IDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gDQo+IE1hbnkgdGhhbmtzIGZvciB5b3VyIHJl
dmlldyBhbmQgQWNrZWQtYnkgdGFnIQ0KDQpZb3UncmUgd2VsY29tZSA6KQ0KDQo+IA0KPiA+IA0K
PiA+IERvZXMgdGhpcyBwYXRjaCBmaXggdGhlIHJlYWwgcHJvYmxlbSByYXRoZXIgdGhhbiBqdXN0
IHNhdmluZyBjcHUgY3ljbGVzPw0KPiA+IFdpdGhvdXQgdGhpcyBwYXRjaCwgImFkZHJlc3MgPT0g
LUVGQVVMVCIgc2VlbXMgdG8gbWFrZSBwZ2Rfb2Zmc2V0KCkgcmV0dXJuDQo+ID4gaW52YWxpZCBw
b2ludGVyIGFuZCByZXN1bHQgaW4gc29tZSBzZXJpb3VzIHJlc3VsdCBsaWtlIGdlbmVyYWwgcHJv
dGVjdGlvbiBmYXVsdC4NCj4gDQo+IEkgdGhpbmsgeW91J3JlIHJpZ2h0LiBXZSBtaWdodCBkZXJl
ZmVyZW5jZSB0aGUgaW52YWxpZCBwb2ludGVyIGluIHRoZSBmb2xsb3dpbmcgcGFnZXRhYmxlDQo+
IHdhbGsgYW5kIHJlc3VsdHMgaW4gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0Lg0KPiANCj4gPiBJ
ZiB0aGF0J3MgdGhlIGNhc2UsIHRoaXMgcGF0Y2ggbWlnaHQgYmUgd29ydGggc2VuZGluZyB0byBz
dGFibGUuDQo+IA0KPiBCdXQgSSdhbSBub3Qgc3VyZSB2bWFfYWRkcmVzcyB3aWxsIHJldHVybiAt
RUZBVUxUIGZvciBkYXggcGFnZXMgaW4gdGhlIHJlYWwgd29ya2xvYWQ/DQo+IElmIHNvLCBJIHdp
bGwgc2VuZCBhIHYyIHdpdGggRml4ZXMgdGFnLg0KDQpIbSwgYWN0dWFsbHkgSSdtIG5vdCBzdXJl
IGVpdGhlci4gIEJ1dCBkZXZfcGFnZW1hcF9tYXBwaW5nX3NoaWZ0KCkgaXMgY2FsbGVkIG9ubHkN
CndoZW4gdm1hIGFzc29jaWF0ZWQgdG8gdGhlIGVycm9yIHBhZ2UgaXMgZm91bmQgYWxyZWFkeSBp
biBjb2xsZWN0X3Byb2NzX3tmaWxlLGFub259LA0Kc28gdm1hX2FkZHJlc3MoKSBzaG91bGQgbm90
IHJldHVybiAtRUZBVUxUIGV4Y2VwdCB3aXRoIHNvbWUgYnVnLg0KU28gVk1fQlVHX09OKCkgbWln
aHQgYmUgbW9yZSBzdWl0YWJsZT8NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
