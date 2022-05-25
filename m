Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8607F533646
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 06:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiEYEx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 00:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiEYExx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 00:53:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2088.outbound.protection.outlook.com [40.107.113.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1A068FA8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 21:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOsIuTye3Jd7SCrnup9isNJAulKEM/sf9FnwEpti/EXGElJleFO/sByewcu22946dCZ6qxVpJbxk+35/AmWuHnZgK8/OYkGxZ0DHQ/Gmw6cy1bUfvAy62+O5r6wGD36GmF+N5zpf/12aFZmo7dz/aR3NxkBgejBimrq5XD5eC3O6fZOoJoskFVDIiI2pRKrarGd3w/BVNolLKelZVZPOr2mf0wWdX/wgx9kmQ1vGbNkbYUcX/l9Cmo5QxmXJS/P71/nRLDVZ6hOLl8s7xxY6XcGsXj31w9krAA0kQtKLZK6PPF4f/3hP4SzRlEhj8AL6RJTpGzSKnHVZ242BT+8DSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiFTniXCAsIROlr6gA0WC8Xeq+ez8TWDp90XZKd1n/Y=;
 b=hdkuvB9PBH2JrmyuvxfBNIYlyLB9PJwzIooJTSWxMFPnrr90/iWAKvbhTArQA7lA5MJs7gyUBOs8gA9ASo8Z7pRbDV/T+ButR+wXZu8M7jpLiD3wLgQwcwR6NvUUlu0bnh8ZVxuYicOyKGB6tlZ8jbrZkBKvkGnLZ3u1f0eiu3iYMEg2lgmig94k+tliK+S0Y3Jaq7P8/pAC+Td9vmWWnV0Cl7iJa2PD1XGg7K2XcOSNr8zb0wfrEm6JGxuTYet8cBQsEIfKxsTBejJz3skUAuxLEHc5ANODEXX2/YKOxwZCfaIV/c+98bbofXhWowvXsQYWiYMOd2sPIdBw4BLYmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiFTniXCAsIROlr6gA0WC8Xeq+ez8TWDp90XZKd1n/Y=;
 b=CXG6y87YMfkwnDxjQqKA9bgcv8RQk+tG+o2rJ4wAQdzI5tWc1i3cMGn31UXuByGPaaOTxTO1rJjLahyMvGdnWI9R/WI6LARXCGiKtrIQ8GxbZ8uapDk+kkD15or7ZUBllYmo+tZ3TkLS1oaEK5zw0WCr8aYQv343YiKqF6BieCQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB4225.jpnprd01.prod.outlook.com (2603:1096:604:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 04:53:49 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 04:53:49 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "surenb@google.com" <surenb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] mm: filter out swapin error entry in shmem mapping
Thread-Topic: [PATCH v4 5/5] mm: filter out swapin error entry in shmem
 mapping
Thread-Index: AQHYa38CTdnwFUHob0q+Kg6mtqLypK0vD9kA
Date:   Wed, 25 May 2022 04:53:49 +0000
Message-ID: <20220525045348.GB808704@hori.linux.bs1.fc.nec.co.jp>
References: <20220519125030.21486-1-linmiaohe@huawei.com>
 <20220519125030.21486-6-linmiaohe@huawei.com>
In-Reply-To: <20220519125030.21486-6-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ad2f78e-fa5c-4353-f664-08da3e0a8ec5
x-ms-traffictypediagnostic: OSAPR01MB4225:EE_
x-microsoft-antispam-prvs: <OSAPR01MB422558F5135B708C1A73A85EE7D69@OSAPR01MB4225.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Na3WtRE6XB6t/hBaXyEh58bouDvqayAJuSlYJuIbRFX+aF0NPVOSKVJ1sSiaSvIcWWlYy24RuLiikisHyKbgRS3yn7y1g2TG3nh63CciIffNKZi8f1eISP2++gx5mWobk6d7oSoI7Xhoxdv4grsNDj2SQXWS+yBkyJTJwcYexIxIDYqLTe2ke6Ywq50uUu/ntcckdFStV8srP8w7UAlNPYZFoFSX1n1BMHaoDPPu9y6x6bzJdjsdCgMbHnrWz5rfaoOg+Cs2fCP8M9cOcdkIGBazUUdsA2wKIYTwrufdd/RrbI+3/I0yxHHzqMY2eOmc5JxgQ96g73LFwpv70Xv181KfSDrCChhdr84VdnvpAo3NVY319SsrptVPfTehsgJz0xm7XZmVQBuUcLU94g2dtIWhyETDg9nAHbFHKMGi5kYpc1aVc8unPMPiAkCO30VzQyoNsHZmvZs3JOZMh/JA06ebXRnSELk+EzPn9NJ83XZsOezHjNdGAVVMLKdrDBX54mHW+QUh3nue9nx7kutBxp5Cl7TRaFDz11bjHquvwmJWRAAkd5Ig0FpX2tJYYHVtfoicpIedyx1DisQYVFt6Ox6cRU91dGTXIDxpTwrpYomOWUufpHGovmX+FYVVV4NNgFxI1IqRZji2ayz1lSbGX2ooBW/M6HS94Rl0FdxpXq8v2vG3xV0rTABCvkCflEJNWcqIShOqH/VGgiVwaRRxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(86362001)(33656002)(66446008)(6486002)(8936002)(64756008)(54906003)(83380400001)(66946007)(66556008)(76116006)(316002)(55236004)(6916009)(38100700002)(26005)(6512007)(82960400001)(6506007)(9686003)(5660300002)(186003)(66476007)(508600001)(7416002)(85182001)(1076003)(122000001)(2906002)(71200400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEJOR0F0TzVlRkpTeXVpSFNLTnFWRi81alhrNUFjLzhjeWZjK1JITW9NR055?=
 =?utf-8?B?SmprSmtNcHlzSXl5ZVFZNU9hdnZQK3FGbFNkNkZiUWJQSFB4byt5NEE5TWVO?=
 =?utf-8?B?UkZpUjFYREsxUytWNmh5VmtiQ2pLR1ZrTHR0Z0Q3eVhwSmp1aHQrL3N4RS93?=
 =?utf-8?B?bzdvTHJjQk9DVnc0aGlaTmViZjlSdE5LVnl1V2oxUnBlVzF4RGt2NTNZTXUr?=
 =?utf-8?B?MGF3dFVPTXVySGFyNU4wWk5ablpiTjhxRzZDTi83bTZ1NmhDM0N0NXBleCth?=
 =?utf-8?B?TUd4L1BZSmFlek1CMERLVFdDWEFOR0daUHJtaW9QTXkycTF5Q3pIY2ViaWJY?=
 =?utf-8?B?eHFJRVZHbWpQOTczTEpzK1ZGTnc3OVVkdkRSWEwzN2FyQVZranRaVUVRZCtu?=
 =?utf-8?B?RW1LaUdiczF4NXMyU01nQk9XZ2hxRmVoZGJ4YTlUZmRab2FPeTJYallKZDZI?=
 =?utf-8?B?b1JWcEdlV25tTWcxQXpvUForTjIwdVAySmFWNTd1QWd0M1lEbnNsNWtzcWJo?=
 =?utf-8?B?ZmtOUEZPTVFLT0c0L2xyazNnbXNmK2tKMCtOZjdaQkFQVkNONUFoREtzZGw5?=
 =?utf-8?B?S1FFcWtuVnovSEZnRFRJZGZCS1lsRkgvcFIyNm8vWmQ4czA3MU1Pblh2RlJz?=
 =?utf-8?B?Zmo5R1VNbTA2dUllWW50S3doRjJuYlRmS0xHUlZ6U3FWbjNPZEtPTE9QY2ZM?=
 =?utf-8?B?cmhzbXcyS0VrR1pyOFhCck1hazNla3BzeEU0cjdLbXhlcUFIUXZ6ZklYMS9M?=
 =?utf-8?B?UnJiWWpLbUs0RjRKWHZDNUxzc1JKVFRFdkJQWlJIbnV4QXBVLzNybnBEcnNl?=
 =?utf-8?B?bGVQY0xhV0YwN1Zrbno1Z2hFcUtPcGV5UzhBL3hUelNHWlB1bGZxTGgvUlNx?=
 =?utf-8?B?cDdNSElrQUlhWFZrcnBycm5JbzQ4L0gxZmJFZ2hPcUt1VEI0cjRmeGtTaU1J?=
 =?utf-8?B?YnVVWGJCMEJLbjdrNFZNZTRuTVBKZldQL0NITTBmeXh2cnNEVloyc2lkR05P?=
 =?utf-8?B?LzFHdktLTUs2RVN1US8xRUtsTTdabE5LTC9Hc3g2cTFDNEZXYkxyUGo3TE1D?=
 =?utf-8?B?RTNKNXdobWsxQiszc1Q5MDAxZVNPeFhUQVByK0Q3cE5JQVphMjZ1TDh6TkZr?=
 =?utf-8?B?eUZhZkdWd0o3bit4aUtrV3BCTkdjaFlDb2xKaW9OK01BMjJpUzVaTHNUSjJs?=
 =?utf-8?B?OGE0TGNyVjhoTzhEM2FTSk5XdUNuTDFEOHRHWGYraTIwVEt6UXB2MmppWmJC?=
 =?utf-8?B?YjB1RUx2Q0drY1IwNUl3eHo2UGlHbmdEVHR0bTBndFpkSkFpbC9ISi9Oc0lF?=
 =?utf-8?B?WGlQYXFPcHIyTEQ4ZnBIbDhWd2c3MzF5UklybmRnZndZUU1jMTFocmUzTTBw?=
 =?utf-8?B?QVhBMXNwa2dBTXJMNkpGMjhTM2JDSGRqMHV0dDFWL0o1VjJ6NzVkdHZFRmVw?=
 =?utf-8?B?ZnBFb2VVajAxWkVuRXVpaTJOaG1kVDdWa0k3ZElnZHRXWTA3TWhJYUVHSnN6?=
 =?utf-8?B?ODNWNUJQeHY0QWNWLzJUaTc0WTJFbWkxMENNRFMyazUybDU0aEVTUndOWUVE?=
 =?utf-8?B?d2tHQ3VuUEJLNjA1MmljbGlPNnlOdjJWb1hhenpvNUVNKzIzamI1SVJMSjRT?=
 =?utf-8?B?Z1hGVFZZZXhsZG0xTXpCZU80OS83d1RFS2poUEtUT05mSDhIOXZHclI0WUNi?=
 =?utf-8?B?UktEWjlBYVRVV1lMNVoyc1hyU2lRU244eGtMQUJVRGcwY3AyQlRXVW5qZ1FE?=
 =?utf-8?B?aU9Ndk5HUGR4cWl4Y05ybUxTVXhFUVpBcnNmNFVvM2lqQTRldzVUWXVQTFdH?=
 =?utf-8?B?WmY3dks5Tno5OVlpazhsMkJ4MUxSeFpLTE44TVFnandMcUlOa0FiRE5LTXJO?=
 =?utf-8?B?SytGZjRSQjdYT2Fndm15SENGK1U3a2RCVWNnQ0M5TjZlcUdJTzB1eGxPd1ox?=
 =?utf-8?B?dVBJdWNOT0dtYVNvMVV6SEZxMzZIcFB2OEsyRlhEdkdldDNHN2ZBMHZUdjdY?=
 =?utf-8?B?a3BTYXZaTUlCNnVWOGdYVEtER2pIVGlSOFpOQ2Q2Yks0YmJGcjlubzdhY1pJ?=
 =?utf-8?B?WkYrb3F4eXBWemdWV2oxQnRsZUFvUFlEL3Y1b3lNTFdLMUtjQW5HSmtMZmlW?=
 =?utf-8?B?UVVZVVJ5cGRzUVFNRlRyMEVmc3Q2SXlDQWxLZ1psbEY4WStZVnAyWnZPUFdX?=
 =?utf-8?B?V0FacmFCTGNwTVBwc2pqbC9vWXdqZnNMcXVuWW93TU5DTW5DRE8yc2N0UkJD?=
 =?utf-8?B?ZHEvVVVNZXpLZnRpRCtiYjM0eTNaZHlUblo3WmJPKzFQa3VUOTJpazVMTlhY?=
 =?utf-8?B?U0IyNmNTcllPd2F5aDUwOFZRV09IZ0tzTllJaCtnSlFmMFhCcm5NdGkvQTFM?=
 =?utf-8?Q?sR22TueS7aRepo5o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACDD1EF29613CA458B374352C9165C97@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad2f78e-fa5c-4353-f664-08da3e0a8ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 04:53:49.1967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmQ6fxafibsRKjPNJTYGKhoYQH17S/hvGmDUsCYycALinZrUfofH307wrBS7guQMjq83Tdgzh1KCpUjrVl6wyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4225
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMTksIDIwMjIgYXQgMDg6NTA6MzBQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gVGhlcmUgbWlnaHQgYmUgc3dhcGluIGVycm9yIGVudHJpZXMgaW4gc2htZW0gbWFwcGlu
Zy4gRmlsdGVyIHRoZW0gb3V0IHRvDQo+IGF2b2lkICJCYWQgc3dhcCBmaWxlIGVudHJ5IiBjb21w
bGFpbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2Vp
LmNvbT4NCj4gLS0tDQo+ICBtbS9tYWR2aXNlLmMgICAgfCA1ICsrKystDQo+ICBtbS9zd2FwX3N0
YXRlLmMgfCAzICsrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9tYWR2aXNlLmMgYi9tbS9tYWR2aXNlLmMN
Cj4gaW5kZXggYTQyMTY1YmM0NzM1Li4zMTU4MmI2ZmY1NTEgMTAwNjQ0DQo+IC0tLSBhL21tL21h
ZHZpc2UuYw0KPiArKysgYi9tbS9tYWR2aXNlLmMNCj4gQEAgLTI0OCwxMCArMjQ4LDEzIEBAIHN0
YXRpYyB2b2lkIGZvcmNlX3NobV9zd2FwaW5fcmVhZGFoZWFkKHN0cnVjdCB2bV9hcmVhX3N0cnVj
dCAqdm1hLA0KPiAgDQo+ICAJCWlmICgheGFfaXNfdmFsdWUocGFnZSkpDQo+ICAJCQljb250aW51
ZTsNCj4gKwkJc3dhcCA9IHJhZGl4X3RvX3N3cF9lbnRyeShwYWdlKTsNCj4gKwkJLyogVGhlcmUg
bWlnaHQgYmUgc3dhcGluIGVycm9yIGVudHJpZXMgaW4gc2htZW0gbWFwcGluZy4gKi8NCj4gKwkJ
aWYgKG5vbl9zd2FwX2VudHJ5KHN3YXApKQ0KPiArCQkJY29udGludWU7DQoNClRoZSBpbmxpbmUg
Y29tbWVudCBtZW50aW9ucyBzd2FwaW4gZXJyb3IgZW50cmllcyBidXQgb3RoZXIgdHlwZXMgb2YN
Cm5vbi1zd2FwIGVudHJpZXMgc2hvdWxkIGJlIHNraXBwZWQgYnkgdGhpcyBjaGVjaywgd2hpY2gg
aXMgaGVscGZ1bCB0b28uDQpTbyBJJ20gZmluZSB3aXRoIHRoZSBjaGFuZ2UsIHRoYW5rIHlvdS4N
Cg0KUmV2aWV3ZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
DQoNCj4gIAkJeGFzX3BhdXNlKCZ4YXMpOw0KPiAgCQlyY3VfcmVhZF91bmxvY2soKTsNCj4gIA0K
PiAtCQlzd2FwID0gcmFkaXhfdG9fc3dwX2VudHJ5KHBhZ2UpOw0KPiAgCQlwYWdlID0gcmVhZF9z
d2FwX2NhY2hlX2FzeW5jKHN3YXAsIEdGUF9ISUdIVVNFUl9NT1ZBQkxFLA0KPiAgCQkJCQkgICAg
IE5VTEwsIDAsIGZhbHNlLCAmc3BsdWcpOw0KPiAgCQlpZiAocGFnZSkNCj4gZGlmZiAtLWdpdCBh
L21tL3N3YXBfc3RhdGUuYyBiL21tL3N3YXBfc3RhdGUuYw0KPiBpbmRleCBiOWU0ZWQyZTkwYmYu
Ljc3OGQ1N2QyZDkyZCAxMDA2NDQNCj4gLS0tIGEvbW0vc3dhcF9zdGF0ZS5jDQo+ICsrKyBiL21t
L3N3YXBfc3RhdGUuYw0KPiBAQCAtNDEwLDYgKzQxMCw5IEBAIHN0cnVjdCBwYWdlICpmaW5kX2dl
dF9pbmNvcmVfcGFnZShzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywgcGdvZmZfdCBpbmRl
eCkNCj4gIAkJcmV0dXJuIE5VTEw7DQo+ICANCj4gIAlzd3AgPSByYWRpeF90b19zd3BfZW50cnko
cGFnZSk7DQo+ICsJLyogVGhlcmUgbWlnaHQgYmUgc3dhcGluIGVycm9yIGVudHJpZXMgaW4gc2ht
ZW0gbWFwcGluZy4gKi8NCj4gKwlpZiAobm9uX3N3YXBfZW50cnkoc3dwKSkNCj4gKwkJcmV0dXJu
IE5VTEw7DQo+ICAJLyogUHJldmVudCBzd2Fwb2ZmIGZyb20gaGFwcGVuaW5nIHRvIHVzICovDQo+
ICAJc2kgPSBnZXRfc3dhcF9kZXZpY2Uoc3dwKTsNCj4gIAlpZiAoIXNpKQ0KPiAtLSANCj4gMi4y
My4w
