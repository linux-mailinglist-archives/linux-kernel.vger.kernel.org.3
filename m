Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ECA5244D0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349703AbiELFUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbiELFUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:20:13 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236641D89C5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgWanIuI54IvpDh8GZ6OqUPtfZ6bqEaLha/7VShoFMPf1K6Vm00ymn2qUaEv9g+pGh+ZZSk3jao6ba/gokrs3occM/REDhkC0OzrwRVmjDWE1rvy9dnm9tT5n1xc7pTQOrALR/N7vJt1dRQivbnuipv59o0sO/L3fZNkXRm/ns0nDgMtBTO/J64gTT7wJ/9w9BngEvtIDpceIIcVoK+6HViP0QRFGx9S3JF07/S/a3pTR017hDcHKAgtLWMLM2at0aOgfZ26BKchBjxkObiCkT2HPJ8iQZ1wkfpi+aqUctlts8py1cM9cA/D6Jc1H8g/530rFbFgCfPM5lH6/Eg+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQaIdFFjEsdQHP9SmYhQFdlTJspVWIN5NE101pqtESg=;
 b=WJfuraKiiQCvg28BIcFhH+mqf7zopcO6IP+iUbzOYPXVPvSer3OMkWn5i/Sgg/haYiRt4JQorCP2Rs+p02vqpLcGX+/CT4MfRqm5CmGZ0UTr2I/0s8+1/a3re5owJbh14ZY0gBJuWc0cxU+uLBxzp5y+hYiluv/tTL47oX4QRPQvVbVCf2u9mq57G37VOqmqnoTMoACeP/u0f5Z0dGuYbdsOSJtKruNMlBE9/HyO60VBhjxBSNBCXfihpAjCctXLTmB2B5O1i17tXybu4ws2BrqZTYsqd8me1RlliNn3/mpMwCOOGBC4EabKjBERpAvqJrsH+ZeUrxJZUJWuNIiROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQaIdFFjEsdQHP9SmYhQFdlTJspVWIN5NE101pqtESg=;
 b=e/k5IY6upMvrE+81LEAPcB8A9Zl5pxgGCCvSAR/eFLUo8fYfXG7oNIlmwOC9Yk51QqjYQDkS1ySrPwGQMo3t885QIe7uo7uTPEX8lY0nd5UVkSFGOrg9xoDHIfIYUR3mjv8s2Hb1BcS00NdIvV2wRlpGHarKxNc747KxMaTkhjPoQPkrgmiovGZy9ZEYe8oSG46lD5TiXaiomHr0j+L7PQeMgbQ5mUBSvhaW4jRxQT1MVT1oTjZ0Yj12ohpjZUJ3D3klZ5gYuP9EH2N6WvyKN+Hx6YcG5gYG6nCBQ6Cy4wdJVX1gNHi2iPmtDWh76T1zjY4Nk1u8DG2wzPRZDpBnvw==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 05:20:10 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5%9]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 05:20:10 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Subject: RE: [PATCH v1] vdpa: Warn if MTU configured is too low
Thread-Topic: [PATCH v1] vdpa: Warn if MTU configured is too low
Thread-Index: AQHYZSXQkvDSxjYK1kSGW4GgpWe2qq0ao+WAgAARG5A=
Date:   Thu, 12 May 2022 05:20:10 +0000
Message-ID: <DM8PR12MB5400A073EE1A092FA2D238AAABCB9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220511105642.124806-1-elic@nvidia.com>
 <CACGkMEv2FGZ3na_HpAWorjBPN1vSp4_pmjz0s9O_hOoSihCL-w@mail.gmail.com>
In-Reply-To: <CACGkMEv2FGZ3na_HpAWorjBPN1vSp4_pmjz0s9O_hOoSihCL-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a7327a0-8ce1-4c9e-c1ed-08da33d715f7
x-ms-traffictypediagnostic: BL3PR12MB6474:EE_
x-microsoft-antispam-prvs: <BL3PR12MB6474FAF8AFBE08D927603555ABCB9@BL3PR12MB6474.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rpzwUxccaYILkihFU/KOgsAtU+WEyF2/2R9Nj9jElf/Vwb3UeI9MbrqIkxMWqikWBI8/ITkQ1Qh8seQPqkRNVuXyABePoLDnO3l+5n4uv8J9qDuWb2t3oPtaaoR3OLQ1Nr9KaddBOaJ5HWP7SQQMT5UKrhpm3i5aHiAu6a/AzzYD8Z3z683NqsHmxUIOfdW2vXZRFE9X8PYIFdualOeVci4yBYrfDv6mSdBGttj1L61C0fcqUUAT0UYhEHLOBwNByUqVW0xNXN4pkEqRzGONzYshlLKO/6t24GwqbmvooHekXK7EKOntN/s+NetNp4XdMz3/0w6bpMyBwc+jkWhTaj/Imr3zQ8jJsVPr1MeVs4wnhFnUUpgJcmS/JAvBk5kTW2OV95jyCU3xOrwFmqj9z5+fhk/FSQHkCmOsSd74jz7cHFoj/JaQu0b4bQc6DUksuuz4dxo5xiMf4f4YG/iVPEfS17uLqlqcyay/Ag9whQe1DGtMETm2t7raF0lEma6S7SHAjyFaJypEJvPWefZFQ7Z2hJK7S2YFxVw5JnNMAMzyKaMKdc9c3Y7PCoGYz/KkHTPK/3mc5J5+UfDcPyaJbHIeXcp7kjsDcWzOmHgXqKsuLBy8CMiMTAXjKwoaZet43pWPZKDZ1SIXHIaJcMUoBpVqGgDpENXAOBTwak5M2sXWA7drmiwICgsQJPUF0W/n3R628NUNxF3CZ7CO0xAHSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(2906002)(38100700002)(38070700005)(6916009)(66556008)(316002)(7696005)(71200400001)(55016003)(122000001)(53546011)(76116006)(6506007)(186003)(83380400001)(66476007)(52536014)(66946007)(9686003)(54906003)(8936002)(86362001)(5660300002)(4326008)(64756008)(508600001)(8676002)(66446008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3VPNmlVbHd6RVkxSUc4NGtHZlY0UDFZQ05WS2tBK1F0bEJUV0dMYm9vZXh1?=
 =?utf-8?B?bFpFczdFaFFaU3NpOGhtS3VQNTB3SGhYaW5FQVZkY3Q4Q3RyMWkwYk9OanpV?=
 =?utf-8?B?cXhIak45NnJtOXNZQStuSXBOWW1IU3plYzdiZlRDZWpUTFBhNlRreEVWdjFm?=
 =?utf-8?B?aTc0aEQzQ29kbDR2MW5wQVVUdGlkUDVuajB1NlJuNzRqKzk2ZlFpSkJ6RitG?=
 =?utf-8?B?dnJjd0ZNTUNPQ1ViVU9zSGtjc1hyTGpnMlU0M1hOWXNiN3JrRVVMRS9VTTdH?=
 =?utf-8?B?U291TjVLY3VXNnBhWElvbGJib0g5QzVyUHU2TXpzMFlGRktRVlRSYnhocHk3?=
 =?utf-8?B?NmpaK2FlUzkxanBSSjRmWG1RaE1wUmpBU2swbXdkcnpiVlUzZGJDdXlaVUIz?=
 =?utf-8?B?SXRFK28vaVlTb1h2WGRNR1pveVFYUDJrSHcxeFFrMUlJK24rQlBmanpUWDBz?=
 =?utf-8?B?UlNUQWMzaWhPOUVIR1lnakM0bkxBWDFEdmVseFFISUtIL3cvMFVMb2dPVzV4?=
 =?utf-8?B?YzE4VzhSeHFCK0NvWDRQTWVJcndUSHZQQzZ6clBjbjJZU1JyN1p1M2J1THRk?=
 =?utf-8?B?b1lKclY3VXhSdy9vUlg2TVVsNzRNMHNWOFg5MStSK1RkNldtcXJXTkdURE1l?=
 =?utf-8?B?MXpuNlVZeG5hM0dQY1FWTy82MGJmekpubHRaM3VMNlNveFg5M3BDejBoL0Nt?=
 =?utf-8?B?djg1MnAzU0hCNnZuVmZmMEFSZkRtaCtleE9FL0ozMWF4NTlQNjRTKzFXYkFo?=
 =?utf-8?B?MHRIbGRLckFUZDh4c2Fhc3N6TEhtOStDeXVVMnMrZEk3Z2lkbXlxQmt5cTdk?=
 =?utf-8?B?UjZJcE8vbCtYZUJYb29xMWdnRGJWTkx4ekd1amNRSitnZDE4MDVVcFMxUkxU?=
 =?utf-8?B?cHd2N1RMTzhpV0pNb2R5dXVGd0s5Nk1aUmhJQzFYRzZyWXNKNnpmdXZva3Y5?=
 =?utf-8?B?bGJpRVBKSjZUdnF0UnVGdllEQStuU2pRVFZqYThjS3dOdjIvZlFra0grazJB?=
 =?utf-8?B?Y2NzcFcrYmFZRmZwems3L1NuQ3pmclhMaXlkN09lN0JQRnFER2VndXZTZE9w?=
 =?utf-8?B?OG1rTXJDeDBOYmh5Q3NVbGlnTDgrUGYxMEF2a003bTFxZFhhQ0pmd0hlOFR6?=
 =?utf-8?B?K2lIalVrZWhNc3ZGVFFBSUZsd2lZT0E0WUxuWjJBVjB5bkppcFllSFpjR2hW?=
 =?utf-8?B?MHZ5UFBtMXNBVnhDZmgyMGxqQUVLZEoyRUpxNFdiZXBiY0JFMVVVSTl4YUdr?=
 =?utf-8?B?UktyZUcxOHVVcXp5cUYySWtyRC9SVnRsSjJkQ2NyaXhZUzlTQ01KTDZOd0Zv?=
 =?utf-8?B?UmpUek1ySnRtYmdCWFRKVkdScXdyOEcySTJHbFpnVFlwRUtjdUJkWlBiSFlX?=
 =?utf-8?B?R1I0RWZQSWJVSkQ4S2ROOW1wQURja0pzcVlzQnRIWUdiNmJWcGlyVlV1Zys3?=
 =?utf-8?B?UFh6TEZDVzY5VTJjaW85Q0lBY2FNdEF1SWloOVpvUmVkSTNUWlNQSnU4OVk0?=
 =?utf-8?B?OTcveG9CZ0xrd011dnNkNlMvdHYzY0VlSTRkTzRzRkIzMzdhTTh5aXZIUnNO?=
 =?utf-8?B?WFpZTG85NU1VSndna1I1NXpQTS85WXNrMi80bHFXUkVsVXdaQ1g3ejhiN1l1?=
 =?utf-8?B?Q1Y5QUsxczZxeXB6TVgwQkcycy9KMTFIY0JqVkU3NzdYOXFMdTBOYWsvZldt?=
 =?utf-8?B?eHkxcHhONjdVVmF0MVFRckxudlVDVkhISkpTNHBqM0JkVWhDZmZ1bGltYThT?=
 =?utf-8?B?c1dKL1ZtcW5ZL1JhTVVIUEVBOUQ1UXUvRlByMU1lblFXUUJJTFJQa1Q2dWZI?=
 =?utf-8?B?RE9qYmZ5R3pzSmxtN2x4M2x5WXhMK1NnL1RTN0UyTzV1d0tyZ3RYZk5RN1Jk?=
 =?utf-8?B?TTdYSnViaUs3aldVODF4U3BPV1Qwd1FwQ2M3UUxSQmluSlBabGZxQVlvQmpQ?=
 =?utf-8?B?UExDYzhjM0pjMFE3aHdOeWdsRm1sYXdVaXlSSG4rajdHM2NlUUhoaGJGUWlV?=
 =?utf-8?B?L3VBWDZWUkpLMHZ1bmdvczM2M0czcXY0SldWNlJ3cW9ncEdyMCtJN0VILzJx?=
 =?utf-8?B?eFdTcWx6S1R3Y1lSSThGRGw5UURBNW52Um56TkdMdGY5aHMwNk9YNlhFV0ZL?=
 =?utf-8?B?OTdSdDN1NXlIWEtJSnZZTExYTVRtN2cwS0twTFJ4cVNBZlRTaEgyOFFCN0ZQ?=
 =?utf-8?B?ZXAyM0V5bnZLdjJKU1NJRm9PRXAvNGN6UTk5RzFsMTZRK0h5cTJaQkJUUkFu?=
 =?utf-8?B?aXFqTTgvYXhqYzFXV2xWYTBYejRROFRvUFYwOXJOejVGS3YrZkVmQVJkVVNV?=
 =?utf-8?Q?B4MgVpWXTuhGucGWQf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7327a0-8ce1-4c9e-c1ed-08da33d715f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 05:20:10.5264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/3pw3B7dsdG9JbXYKCohTCxsq2vSs3leThCU9wnLkC8SYPVmf2gOFgOq2QtZfIX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDEyLCAyMDIyIDc6MTcgQU0NCj4g
VG86IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPg0KPiBDYzogbXN0IDxtc3RAcmVkaGF0LmNv
bT47IHZpcnR1YWxpemF0aW9uIDx2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZz47IGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFNpLQ0K
PiBXZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djFdIHZkcGE6IFdhcm4gaWYgTVRVIGNvbmZpZ3VyZWQgaXMgdG9vIGxvdw0KPiANCj4gT24gV2Vk
LCBNYXkgMTEsIDIwMjIgYXQgNjo1NiBQTSBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBGb2xsb3dpbmcgdGhlIHJlY29tbWVuZGF0aW9uIGluIHZpcmlvIHNwZWMg
MS4xLCBhIGRldmljZSBvZmZlcmluZw0KPiA+IFZJUlRJT19ORVRfRl9NVFUgc2hvdWxkIHNldCB0
aGUgbXR1IHRvIGF0IGxlYXN0IDEyODAgYnl0ZXMuDQo+ID4NCj4gPiBQcmludCBhIHdhcm5pbmcg
aWYgdGhpcyByZWNvbW1lbmRhdGlvbiBpcyBub3QgbWV0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gdjAgLT4gdjE6DQo+
ID4gICBjaGFnZSBwcl93YXJuIHRvIG5ldGxpbmsgd2FybmluZyB0byB1c2Vyc3BhY2UNCj4gPg0K
PiA+ICBkcml2ZXJzL3ZkcGEvdmRwYS5jIHwgOSArKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jDQo+ID4gaW5kZXggOTFm
NGMxM2M3YzdjLi4wZmI0YTYxNWYyNjcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy92ZHBhL3Zk
cGEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMNCj4gPiBAQCAtNTgzLDYgKzU4Myw5
IEBAIHZkcGFfbmxfY21kX21nbXRkZXZfZ2V0X2R1bXBpdChzdHJ1Y3Qgc2tfYnVmZiAqbXNnLCBz
dHJ1Y3QgbmV0bGlua19jYWxsYmFjayAqY2IpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVKSAgICAgfCBcDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChWRFBBX0FUVFJfREVWX05F
VF9DRkdfTUFYX1ZRUCkpDQo+ID4NCj4gPiArLyogUmVjb21tZW5kZWQgdmlydGlvIHNwZWMgMS4x
IHNlY3Rpb24gNS4xLjQuMSAqLw0KPiA+ICsjZGVmaW5lIFZJUlRJT19NSU5fUFJFRkVSUkVEX01U
VSAxMjgwDQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IHZkcGFfbmxfY21kX2Rldl9hZGRfc2V0X2Rv
aXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IGdlbmxfaW5mbyAqaW5mbykNCj4gPiAgew0K
PiA+ICAgICAgICAgc3RydWN0IHZkcGFfZGV2X3NldF9jb25maWcgY29uZmlnID0ge307DQo+ID4g
QEAgLTYzNCw2ICs2MzcsMTAgQEAgc3RhdGljIGludCB2ZHBhX25sX2NtZF9kZXZfYWRkX3NldF9k
b2l0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBnZW5sX2luZm8gKmkNCj4gPiAgICAgICAg
ICAgICAgICAgZXJyID0gUFRSX0VSUihtZGV2KTsNCj4gPiAgICAgICAgICAgICAgICAgZ290byBl
cnI7DQo+ID4gICAgICAgICB9DQo+ID4gKyAgICAgICBpZiAoKG1kZXYtPnN1cHBvcnRlZF9mZWF0
dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX01UVSkpICYmDQo+ID4gKyAgICAgICAgICAgKGNv
bmZpZy5tYXNrICYgQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVKSAmJg0KPiA+ICsg
ICAgICAgICAgIGNvbmZpZy5uZXQubXR1IDwgVklSVElPX01JTl9QUkVGRVJSRURfTVRVKSkNCj4g
PiArICAgICAgICAgICAgICAgTkxfU0VUX0VSUl9NU0dfTU9EKGluZm8tPmV4dGFjaywgIk1UVSBp
cyBiZWxvdyByZWNvbW1lbmRlZCB2YWx1ZVxuIik7DQo+IA0KPiBDYW4gdGhpcyBmdW5jdGlvbiBi
ZSB1c2VkIGZvciB3YXJuaW5nPyBJIGhhdmUgYSBxdWljayBjc2NvcGUgdGhhdA0KPiB0ZWxscyBt
ZSBpdCdzIHByb2JhYmx5IHVzZWQgb25seSBmb3IgZXJyb3IuDQoNCkhlcmUncyB3aGF0IEkgZ2V0
Og0KIyB2ZHBhIGRldiBhZGQgbmFtZSB2ZHBhLWEgbWdtdGRldiBhdXhpbGlhcnkvbWx4NV9jb3Jl
LnNmLjEgbXR1IDEyNzkNCldhcm5pbmc6IHZkcGE6IE1UVSBpcyBiZWxvdyByZWNvbW1lbmRlZCB2
YWx1ZQ0KDQpUaGUgdmRwYSBkZXZpY2UgaXMgY3JlYXRlZCBmaW5lLg0KDQo+IA0KPiBXaWxsIGl0
IGJlIGJldHRlciBpZiB3ZSBmYWlsIG9ubHkgd2hlbiB0aGUgZGV2aWNlIHN1cHBvcnRzIFZFUlNJ
T05fMT8NCj4gDQoNCldoeT8NCg0KPiBUaGFua3MNCj4gDQo+ID4gICAgICAgICBpZiAoKGNvbmZp
Zy5tYXNrICYgbWRldi0+Y29uZmlnX2F0dHJfbWFzaykgIT0gY29uZmlnLm1hc2spIHsNCj4gPiAg
ICAgICAgICAgICAgICAgTkxfU0VUX0VSUl9NU0dfTU9EKGluZm8tPmV4dGFjaywNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJBbGwgcHJvdmlkZWQgYXR0cmlidXRlcyBh
cmUgbm90IHN1cHBvcnRlZCIpOw0KPiA+IEBAIC0xMTM1LDcgKzExNDIsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IG5sYV9wb2xpY3kgdmRwYV9ubF9wb2xpY3lbVkRQQV9BVFRSX01BWCArIDFdID0g
ew0KPiA+ICAgICAgICAgW1ZEUEFfQVRUUl9ERVZfTkFNRV0gPSB7IC50eXBlID0gTkxBX1NUUklO
RyB9LA0KPiA+ICAgICAgICAgW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSXSA9IE5MQV9Q
T0xJQ1lfRVRIX0FERFIsDQo+ID4gICAgICAgICAvKiB2aXJ0aW8gc3BlYyAxLjEgc2VjdGlvbiA1
LjEuNC4xIGZvciB2YWxpZCBNVFUgcmFuZ2UgKi8NCj4gPiAtICAgICAgIFtWRFBBX0FUVFJfREVW
X05FVF9DRkdfTVRVXSA9IE5MQV9QT0xJQ1lfTUlOKE5MQV9VMTYsIDY4KSwNCj4gPiArICAgICAg
IFtWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVXSA9IE5MQV9QT0xJQ1lfTUlOKE5MQV9VMTYsIEVU
SF9NSU5fTVRVKSwNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGdlbmxf
b3BzIHZkcGFfbmxfb3BzW10gPSB7DQo+ID4gLS0NCj4gPiAyLjM1LjENCj4gPg0KDQo=
