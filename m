Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564D255E215
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiF0NTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiF0NS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:18:59 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DBCC6F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:18:56 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RBkam5019202;
        Mon, 27 Jun 2022 06:18:40 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3gwyqqf1my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 06:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJD+7DbEt534whDvGtFdUqvgZJby2TA2awKbWbiXbeFCEb3F84g7Bnk1qjFOMNqiWX8/8Y0w74A6Ur95tVuzAw9K9emlCqzzfFPazhb4od7B4yRz2HFPAN5NlP4YZm5Zr2FdB0RqCptjC+G3GrnB8ndoA1qw4XindV6KFPbF2nuQYui1aMTFCb6QD7vT+ycuDVTWq9Vd5BiHilYnNkjHYpYjtuD8xWLU6On5EheXM754gQxrqEvO23mi/PcyIlo9h6uQzOAgHVuruZXazgAO9FNkxB/wkYNDQm1K/wArMCDqyE9Ecx66pONpbe8ziKBVQ4TTKD+zQ1i2+dlO827kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwlGrQOlMehPSHj1wpZhmDA2lLskIv4nlFDejEXhaUA=;
 b=Xxr1DyGvj433kcc3vFd3OmdAUPTEybiKTDdG3X4C72fZw/a8VGawDDYkXAef9x6/gTjxwlp7lqUa8SZfYqsqud18N5SAQJPlcqjDd9n1+VugeZofAjFVnozjwUOONtSoct1+CDXtssx/2LVDtG7vOvyz8PjRMvr+ANPRGD6ATTt2qdDVZ1Ab/I/hLjhVVjlOqJ3EffcdwJqy7hDQkfz/jkUyR3TQcwRmOeVS/EOoZPlW+5V1NSP9sovg9P9G0ZWV6DP8qeOgL3avxhowUmOhbMOwryw3ZdSKjen1Y5wLin+W2rGk/4fb5vlbJiGw1a3CCSuZ3BBRBjVKYexw6P/lTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwlGrQOlMehPSHj1wpZhmDA2lLskIv4nlFDejEXhaUA=;
 b=ircgxjKPtGaV/FHq6x8dUxnWmNTAPqm30N33Tz3Kdv+7c3U5VXksJoOTLsGQJdZRbWCwTPgjIalhV+vMojtMFb9myiCop96bQEsy6oQloRm//hRwNBe90CGkiGa2lPpMD39H2YSKrr3e37Rd9V21iCO3/agZBoBwLH1QQ22u7V8=
Received: from PH0PR18MB5017.namprd18.prod.outlook.com (2603:10b6:510:11c::22)
 by CH2PR18MB3174.namprd18.prod.outlook.com (2603:10b6:610:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 13:18:37 +0000
Received: from PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::fdf2:92aa:7940:a6c8]) by PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::fdf2:92aa:7940:a6c8%8]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 13:18:36 +0000
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "james.morse@arm.com" <james.morse@arm.com>
Subject: Re: [PATCH RESEND] perf/marvell_cn10k: Add MPAM support for TAD PMU
Thread-Topic: [PATCH RESEND] perf/marvell_cn10k: Add MPAM support for TAD PMU
Thread-Index: AdiKGL+qdIGmUPyiSb20urpSVOcBWg==
Date:   Mon, 27 Jun 2022 13:18:36 +0000
Message-ID: <PH0PR18MB5017CB19D896DADFCEAB6ED6D6B99@PH0PR18MB5017.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0e3bb53-0b72-448e-1387-08da583f8b3e
x-ms-traffictypediagnostic: CH2PR18MB3174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZuPAdk73BAoubosmcrd2kXa4gSOC5MKlLSiyS8XHberDU34EDn0Heb3iDV9RWx8Ddlk73m4FLUiggiYph6TKBVy0rap/PpZtmCmwFStvn5mN7ygxn2HHJYB76ks9zeBUhV21iC34O1bxZ4q4TNAbUVMcwde99NVpS7i5xaRnJZtj/Dmi+EVDN4/UbNsrD0Loe7VgrytzmmUl5o3z9JYLZSnPtmQi+8ePGiAE+bh1o4yjfUysJiP95LD2xTrvX+P7g4WFDWZdWhXFG+dOgzBzMUHEr1KmbGNkn0tSXy04UTRWiuyEm0au5VUahlPcCVYKxS0lyerPTexD0MBepPgI6eQlAML5Y+DhuES9IHfS7IPGShIf19OJgB9smdxeoidX4ZVPufz+McltBkI2DpiXYuCW/nU/jCxcUsHuK9DdYWv1vscQtVbUmkpH95VT3ZYfw39y8P31C5wgp/NAu18ehH4AZWdq3r0aqfDokJdzn2vU/dj60TNOngu/Jy6Ymn1CEPH/U/tKv5aU04Pgovpac/S0rMYTnGGqF1xvwY/sic0QDInpRJp9zu+zdNy9KRMFCmmSy6awxJNcRw+l0+Hv4rwxZK/NnbSqZNxLs1TrIli3rGwFVVR9GsNHjn+3iwDBq/rJTN0HmRxbqc7buZVVSvjx217B5PN6SJQ2kei6rMXeOtr5FRwDNntJNjHldrlRVuciW/IOCOtplcP2cexMr/f/DSrIRE5Hm+W9pJe6yPuERg/UY3F9i1CmPl+CZqXSz0k9eMk+enIEzdslWEwqvaoiNdpUf18LZuPweIdE8GpL8ikVCvRtllZBoYEIbzACwz8kll6ZeA4mU7Pr4LTEhyoOeXV7mnXNjpFIX0+gTA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5017.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(186003)(38100700002)(122000001)(55016003)(8936002)(316002)(5660300002)(54906003)(110136005)(33656002)(83380400001)(478600001)(26005)(66946007)(86362001)(66556008)(66476007)(8676002)(71200400001)(38070700005)(52536014)(64756008)(4326008)(66446008)(9686003)(2906002)(41300700001)(7696005)(76116006)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1JVUzhqQWFLZm13eVJ0QzlhTHJ4aWs5bjRINlo5NStQMUF5L1J1b0FkVzcx?=
 =?utf-8?B?bEc2VFNHam5rM3hiZjJqenBKTlB1Q2RsSEZibUh3OTNseFdTMnJqT0Q2aDNZ?=
 =?utf-8?B?VE90Q0VkMVZvOTA3dE1yQlJYVkdNdktaQ1RhT3h1eFBsTVZGeGhUclVtcW0z?=
 =?utf-8?B?ZlNkMmt0RWFqc2Z1aVV3TTlMbDdJdXhacjNzREZwdHhtRGNabFdHQUdydXp5?=
 =?utf-8?B?d2ltMldNcFZpY3N5UzNENWxVU0MzNkRnazR3UlhCUUdlNXRhaVdrRERiQnVW?=
 =?utf-8?B?THFsRkhkYzJDd1N1Ymt1K0lWb0FYSW5rM0FMSEtQSjZkcndZNjhHcVBzRjJl?=
 =?utf-8?B?cjYvbHZVbi9Fd1I2ZHZJMG9CSlZ3R3I0d2FGNFUzYXJvNkFHbVpvSkxQLzFV?=
 =?utf-8?B?UWN2aks0MGxrLzNuZU9hSTlyaTZ2WFNuUDNzNTFXRWNncFRxd3dySWdBWnRa?=
 =?utf-8?B?cjZZUXFIYy9hZk9GU2NzTkZSMlRDV0RCUVF0Tk85dFQvbmRsc2ZGOVMzVWRS?=
 =?utf-8?B?b2ZpRGJiNWhTWnBwWkkwb0s2S0lJRzVaTU9LWjhmQlJrYUxWZndHbnY0dmxS?=
 =?utf-8?B?TnlEYlN4ZjB2c0FSUTdYcnJjaHVsa3VZWnJKLzdURitXMnlnV0dsTVptNGF1?=
 =?utf-8?B?bk0zTUFKZ2VMcWZ2RnZhWGFCYWFQcGdRNmVnYllVZjVUdmRiQUtsU2N2NWtl?=
 =?utf-8?B?SC9CQVplMEFDRWNrWkpqWmlOdVJaK0J5UjdDcGxKOXpYRHRScWw0MS9lZUwx?=
 =?utf-8?B?bUp6cTZtMkpqdkMreXlFLytCY2J5VmdIK1AxOHJzYTBNd1duYTk2c3N0TUhL?=
 =?utf-8?B?WUN1OEJWNy9sOWNCVy9ON25TdW9LeWRpT1pLZm1RZUFVTWpOcDJLdncyYlVT?=
 =?utf-8?B?STBJZktaSks3QktrT05FazBZVnBJaEdodGZBQlFYNnU4OStTT3ZvZnkxYm9D?=
 =?utf-8?B?KzNJRkJCYlgvWmpvMHd0ZUpMYW9RRTJQNEVLTGhrMkJPTXA5WkgvOTBNRk84?=
 =?utf-8?B?TmhNUytkOUpRZHliUFZpR24weFpFRWk4M3ZPWWZWSGlSYzliK2NMeFZVT1Y0?=
 =?utf-8?B?a0FPRFRoOGJDUVVvK0FEU3V0MVczNGd0QlpaSWdzRWUwbkV3VFgzUmoxVGpn?=
 =?utf-8?B?K3p4TXVudlVrUEo4VUhvMkJSODU1U09qTjBGSG5xM2MyakpqZVdpRzNvRnZZ?=
 =?utf-8?B?aFJNUE1hdkhhRUg5L0VaaDZvSlFNOTBoWUZaR0lWOFdZWnpvbHRxQmtFRjFK?=
 =?utf-8?B?bkFZdzFCeDBxTmlRcERFZmpQUE8yVkRjUW9GeENXeTNHMzFHektrYWk3WDFu?=
 =?utf-8?B?NlhtazZ5VnhVTGM1QmxWMGRPK0lrRDZmay9PS1pFVUFlVzdWeGJBZDFxVTRy?=
 =?utf-8?B?ZmxLc3laS1pvTFZoanZGa1BraE1mT0FIeWpnaC9TVFhnaEtlQ2ZMVG5vT3lC?=
 =?utf-8?B?Zkc4M1RqT04vRDMxbDhWeFpLNE1GTXVlZXVJY3RYUlRnQSthTWFLcmYxcHBw?=
 =?utf-8?B?eVRpcDkzMzlreGkrMHYxL0VCR0xPUytiMFNLWnY1N0UwbWIwR01Xd3NjeEdn?=
 =?utf-8?B?ekFSRVU5Mi85bW9SU2Njb2xDQVdlTjhmRXZDMlpyV2lsUElPSlhrZGVHUG9S?=
 =?utf-8?B?Rm5TOU9Xd3liWXM3MjBPVkpwUWxHQmlKSkxEZDJ4VG04NzhleHNaME5UaklY?=
 =?utf-8?B?SWxFRFFiMTZVVDFKNGZ4eVhScVhtakpIY2N5MFZOS3ZndUJTaVM4ZjZyWkl0?=
 =?utf-8?B?a3ZzQXBvc0xyZFZlSkNoTmcxbE93ZFRZYm11TDZtNjBMYzFqL2t5eWNFZi9l?=
 =?utf-8?B?L3FMUFVOdWthK0VlQWZicVp4NzR4MjMzQVJLaXRNU084L1Nrd29HdS9FOUEw?=
 =?utf-8?B?NlF6TlJXQnpFczAzOTVvOHhoaGNua3FtUGpSbEVPOWNFdlh6cHJyNk5mZzNV?=
 =?utf-8?B?d0kxNk1uOG9iNS9leTdlaTVlam1UTWsyR2UySUdXNTdqajFkK1lSOXUxM1ky?=
 =?utf-8?B?TWNqK0JGUUx3UFpFQ3hPT0UyWWthZW1rdkpvQ1dFK1JuMlBZRkVGZGFqREx2?=
 =?utf-8?B?UytrcHIrK0k4Y1BpV05mUTJoTG9WWTVjdUVBVHo1dTdyQURxaGhLckxYSG4x?=
 =?utf-8?Q?a4Sg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5017.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e3bb53-0b72-448e-1387-08da583f8b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 13:18:36.8163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FO0nrpfiT3ZO4lNJWl1IwIfqcPFlBKo82eZosKQ1ez6mL+TkhWS06mdj2RfPScqL+yQuCQfTml9aFh5tXuEcMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3174
X-Proofpoint-GUID: -ThjICEy77DZn6pbulfppQmPDT9lnQMl
X-Proofpoint-ORIG-GUID: -ThjICEy77DZn6pbulfppQmPDT9lnQMl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbCBhbmQgUm9iaW4sDQoNCj4gT24gMjAyMi0wNi0yNCAxMzoxNCwgV2lsbCBEZWFjb24g
d3JvdGU6DQo+ID4gT24gU2F0LCBNYXkgMjgsIDIwMjIgYXQgMTI6MjY6NDdBTSArMDUzMCwgVGFu
bWF5IEphZ2RhbGUgd3JvdGU6DQo+ID4+IFRoZSBUQUQgUE1VIHN1cHBvcnRzIGZvbGxvd2luZyBj
b3VudGVycyB0aGF0IGNhbiBiZSBmaWx0ZXJlZCBieSBNUEFNDQo+ID4+IHBhcnRpdGlvbiBpZC4N
Cj4gPj4gICAgICAtICgweDFhKSB0YWRfYWxsb2NfZHRnIDogQWxsb2NhdGlvbnMgdG8gRFRHLg0K
PiA+PiAgICAgIC0gKDB4MWIpIHRhZF9hbGxvY19sdGcgOiBBbGxvY2F0aW9ucyB0byBMVEcuDQo+
ID4+ICAgICAgLSAoMHgxYykgdGFkX2FsbG9jX2FueSA6IFRvdGFsIGFsbG9jYXRpb25zIHRvIERU
Ry9MVEcuDQo+ID4+ICAgICAgLSAoMHgxZCkgdGFkX2hpdF9kdGcgICA6IERURyBoaXRzLg0KPiA+
PiAgICAgIC0gKDB4MWUpIHRhZF9oaXRfbHRnICAgOiBMVEcgaGl0cy4NCj4gPj4gICAgICAtICgw
eDFmKSB0YWRfaGl0X2FueSAgIDogSGl0IGluIExURy9EVEcuDQo+ID4+ICAgICAgLSAoMHgyMCkg
dGFkX3RhZ19yZCAgICA6IFRvdGFsIHRhZyByZWFkcy4NCj4gPj4NCj4gPj4gQWRkIGEgbmV3ICdw
YXJ0aWQnIGF0dHJpYnV0ZSBvZiAxNi1iaXRzIHRvIGdldCB0aGUgcGFydGl0aW9uIGlkDQo+ID4+
IHBhc3NlZCBmcm9tIHBlcmYgdG9vbC4gVGhpcyB2YWx1ZSB3b3VsZCBiZSBzdG9yZWQgaW4gY29u
ZmlnMSBmaWVsZA0KPiA+PiBvZiBwZXJmX2V2ZW50X2F0dHIgc3RydWN0dXJlLg0KPiA+Pg0KPiA+
PiBFeGFtcGxlOg0KPiA+PiBwZXJmIHN0YXQgLWUgdGFkL3RhZF9hbGxvY19hbnkscGFydGlkPTB4
MTIvIDxwcm9ncmFtPg0KPiA+Pg0KPiA+PiAtIERyb3AgcmVhZCBvZiBUQURfUFJGIHNpbmNlIHdl
IGRvbid0IGhhdmUgdG8gcHJlc2VydmUgYW55DQo+ID4+ICAgIGJpdCBmaWVsZHMgYW5kIGFsd2F5
cyB3cml0ZSBhbiB1cGRhdGVkIHZhbHVlLg0KPiA+PiAtIFVwZGF0ZSByZWdpc3RlciBvZmZzZXRz
IG9mIFRBRF9QUkYgYW5kIFRBRF9QRkMuDQo+ID4NCj4gPiBJdCB3b3VsZCBiZSBncmVhdCBpZiB5
b3UgY291bGQgZG9jdW1lbnQgc29tZSBvZiB0aGlzIHVuZGVyDQo+ID4gRG9jdW1lbnRhdGlvbi9h
ZG1pbi1ndWlkZS9wZXJmIGxpa2UgbWFueSBvZiB0aGUgb3RoZXIgUE1VIGRyaXZlcnMgaGF2ZQ0K
PiA+IGRvbmUuDQo+IA0KPiBFc3BlY2lhbGx5IGRvY3VtZW50aW5nIGhvdyB0aGUgdXNlciBvYnRh
aW5zIHRoZSByZXF1aXJlZCBwYXJ0aWQgdmFsdWUgdG8NCj4gcGFzcy4NCj4gDQpXZSBjcmVhdGVk
IE1QQU0gcGFydGl0aW9ucyB1c2luZyB0aGUgcmVzY3RybCBmaWxlc3lzdGVtIGludGVyZmFjZS4N
CkV4YW1wbGU6DQogICAgICAgICQgY2QgL3N5cy9mcy9yZXNjdHJsDQogICAgICAgICQgbWtkaXIg
cDENCiAgICAgICAgJCBlY2hvICJMMzowPWYiID4gcDEvc2NoZW1hdGEgKGNvbmZpZ3VyZSA0IEwz
IGNhY2hlIHdheXMpDQogICAgICAgICQgbWtkaXIgcDINCiAgICAgICAgJCBlY2hvICJMMzoxPWZm
MCIgPiBwMi9zY2hlbWF0YSAoY29uZmlndXJlIDggTDMgY2FjaGUgd2F5cykNCg0KSGVyZSBkaXJl
Y3RvcnkgbmFtZSAncDEnIGNyZWF0ZXMgYSBNUEFNIHBhcnRpZCAweDEgYW5kICdwMicgY3JlYXRl
cw0KMHgyIGFuZCBzbyBvbi4NCg0KUmlnaHQgbm93LCB0aGVyZSBpcyBubyBmaWxlIHdoaWNoIGV4
cG9zZXMgdGhlIHBhcnRpZCB0byB1c2Vyc3BhY2UuDQpXZSBtdXN0IHJlbHkgb24gdGhlIHNlcXVl
bnRpYWwgb3JkZXIgaW4gd2hpY2ggd2UgY3JlYXRlIHBhcnRpdGlvbnMNCnZpYSByZXNjdHJsIGFu
ZCB1c2UgdGhhdCB0byBkZXJpdmUgdGhlIHBhcnRpZC4NCg0KSSdsbCBzZW5kIG91dCBhIFYyIGRv
Y3VtZW50aW5nIHRoaXMuDQo+IFRoYW5rcywNCj4gUm9iaW4uDQo+IA0KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBUYW5tYXkgSmFnZGFsZSA8dGFubWF5QG1hcnZlbGwuY29tPg0KPiA+PiAtLS0NCj4gPj4g
ICBkcml2ZXJzL3BlcmYvbWFydmVsbF9jbjEwa190YWRfcG11LmMgfCAyMyArKysrKysrKysrKysr
KysrKystLS0tLQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wZXJmL21hcnZlbGxf
Y24xMGtfdGFkX3BtdS5jDQo+IGIvZHJpdmVycy9wZXJmL21hcnZlbGxfY24xMGtfdGFkX3BtdS5j
DQo+ID4+IGluZGV4IDI4MmQzYTA3MWE2Ny4uZjU1MmU2YmZmY2FjIDEwMDY0NA0KPiA+PiAtLS0g
YS9kcml2ZXJzL3BlcmYvbWFydmVsbF9jbjEwa190YWRfcG11LmMNCj4gPj4gKysrIGIvZHJpdmVy
cy9wZXJmL21hcnZlbGxfY24xMGtfdGFkX3BtdS5jDQo+ID4+IEBAIC0xOCwxMCArMTgsMTIgQEAN
Cj4gPj4gICAjaW5jbHVkZSA8bGludXgvcGVyZl9ldmVudC5oPg0KPiA+PiAgICNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPj4NCj4gPj4gLSNkZWZpbmUgVEFEX1BGQ19PRkZT
RVQJCTB4MA0KPiA+PiArI2RlZmluZSBUQURfUEZDX09GRlNFVAkJMHg4MDANCj4gPj4gICAjZGVm
aW5lIFRBRF9QRkMoY291bnRlcikJKFRBRF9QRkNfT0ZGU0VUIHwgKGNvdW50ZXIgPDwgMykpDQo+
ID4+IC0jZGVmaW5lIFRBRF9QUkZfT0ZGU0VUCQkweDEwMA0KPiA+PiArI2RlZmluZSBUQURfUFJG
X09GRlNFVAkJMHg5MDANCj4gPj4gICAjZGVmaW5lIFRBRF9QUkYoY291bnRlcikJKFRBRF9QUkZf
T0ZGU0VUIHwgKGNvdW50ZXIgPDwgMykpDQo+ID4+ICsjZGVmaW5lIFRBRF9QUkZfTUFUQ0hfUEFS
VElECSgxIDw8IDgpDQo+ID4+ICsjZGVmaW5lIFRBRF9QUkZfUEFSVElEX05TCSgxIDw8IDEwKQ0K
PiA+PiAgICNkZWZpbmUgVEFEX1BSRl9DTlRTRUxfTUFTSwkweEZGDQo+ID4+ICAgI2RlZmluZSBU
QURfTUFYX0NPVU5URVJTCTgNCj4gPj4NCj4gPj4gQEAgLTg2LDIzICs4OCwzMiBAQCBzdGF0aWMg
dm9pZCB0YWRfcG11X2V2ZW50X2NvdW50ZXJfc3RhcnQoc3RydWN0DQo+IHBlcmZfZXZlbnQgKmV2
ZW50LCBpbnQgZmxhZ3MpDQo+ID4+ICAgCXN0cnVjdCBod19wZXJmX2V2ZW50ICpod2MgPSAmZXZl
bnQtPmh3Ow0KPiA+PiAgIAl1MzIgZXZlbnRfaWR4ID0gZXZlbnQtPmF0dHIuY29uZmlnOw0KPiA+
PiAgIAl1MzIgY291bnRlcl9pZHggPSBod2MtPmlkeDsNCj4gPj4gKwl1MzIgcGFydGlkX2ZpbHRl
ciA9IDA7DQo+ID4+ICAgCXU2NCByZWdfdmFsOw0KPiA+PiArCXUzMiBwYXJ0aWQ7DQo+ID4+ICAg
CWludCBpOw0KPiA+Pg0KPiA+PiAgIAlod2MtPnN0YXRlID0gMDsNCj4gPj4NCj4gPj4gKwkvKiBF
eHRyYWN0IHRoZSBwYXJ0aWQgKGlmIGFueSkgcGFzc2VkIGJ5IHVzZXIgKi8NCj4gPj4gKwlwYXJ0
aWQgPSBldmVudC0+YXR0ci5jb25maWcxICYgMHgzZjsNCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4g
Pj4gICBQTVVfRk9STUFUX0FUVFIoZXZlbnQsICJjb25maWc6MC03Iik7DQo+ID4+ICtQTVVfRk9S
TUFUX0FUVFIocGFydGlkLCAiY29uZmlnMTowLTE1Iik7DQo+ID4NCj4gPiBUaGlzIGRvZXNuJ3Qg
c2VlbSB0byBtYXRjaCB0aGUgbWFzayB1c2VkIGFib3ZlPw0KQUNLLg0KSSB3aWxsIHNlbmQgb3V0
IGEgVjIgdGhhdCBpbmNsdWRlcyB0aGlzIGZpeC4NCg0KVGhhbmtzLA0KVGFubWF5DQo+ID4NCj4g
PiBXaWxsDQo+ID4NCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KPiA+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo=
