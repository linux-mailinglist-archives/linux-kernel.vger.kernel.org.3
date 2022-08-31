Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC35A84F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiHaSEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiHaSEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:04:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D37E3426;
        Wed, 31 Aug 2022 11:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wvoi3GLWrX/4a7VwuzjeZV18d49G+JgMlXAXO2h9d4Vqw5AWKuG5lK1tloG+qeHkI85jgFE2JDt3T0Etoe8ccHr0OJSn0qFQKXGt6EQj/NLlPQLu4fuxyyGden3VZHfeUeVPmV+lgJ6L7BkLH84HZOfD8R91JfVo6TIcuoCf9+EFxIG+5wAoA20/mTG2wHwrS/WUo6Xe/5qJMnWqS6src/d1Wkqg3oeGadJrASJBaaaHTSESYAS/wJpPBlniO3kG6+VYcHVw//+Tk1oFAHjfAapjLOblfrVpmL03ZMQ4gMqQvG/FiWyGhigG9HK/qCQ3OzNUKQoTxrUBdwoGEW542w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkpW8v7hHrmj41yHY9rTX2fNSoUleuGQKOb9qbk3lGs=;
 b=YVdOpYm/RC6JXr8mrQzw3zkm2XtkscooX7+/d9UDMo5bcDaXwsXZyY17bRcLEfnod+zGb0S26cOozFBIQlNBoOgzjWx0pIT+FCnEoxggBsRdMCq5twnbiLGcfGWU10p0Bbm3OgBqrnDF/O9X7Bokr5xDxU7jrto9Vd9VpDV/vbQrXphgIVWbr72TqU3TVM8BJZwshB+FAbDFK+fB6ZTo1SX5coMdPtopzFsDmy+kiYvVAzd0XYggAXt3loYwVF5EFiw1UbiPAJDgKlrAE+BnAb8lBUO/q+2IKRDn7BxUWOilsxdL9ePHOSSh/B3z52fh/SGV5833txm0i7OPuNl5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkpW8v7hHrmj41yHY9rTX2fNSoUleuGQKOb9qbk3lGs=;
 b=X3fGzDSoYb6PeshURcFNCWfMmyzm/CMbdYz4sVUpwwicyvkanNY2qW7r1UbQLHEgc7OvFlEfSXy81xXuW/SgSR+0xGGbm5Meg1Lzh/bcqXyJiJe0OqU3K/65YhiHhFeuZGnYb1M6jg9RNTPHhOXI/F7x8smS0R1P4l2i5PvJgSc=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 18:04:03 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 18:04:02 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Brad Larson <brad@pensando.io>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 12/17] spi: dw: Add support for AMD Pensando Elba SoC
Thread-Topic: [PATCH v6 12/17] spi: dw: Add support for AMD Pensando Elba SoC
Thread-Index: AQHYtM9FM9muhs4ErEO9IKdWE4XmXK25q0sAgA+zMAA=
Date:   Wed, 31 Aug 2022 18:04:02 +0000
Message-ID: <4aab1595-53a6-32af-8cfb-90f5e258d29e@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-13-brad@pensando.io>
 <20220821181848.cxjpv2f4cqvdtnq3@mobilestation>
In-Reply-To: <20220821181848.cxjpv2f4cqvdtnq3@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5e25367-4257-4743-c8d2-08da8b7b3002
x-ms-traffictypediagnostic: DM6PR12MB4417:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i51lochLmYaPyR+SY2VfomP//XUHAQdRY9Q46i3SJZV9iQvf57l4zwJzBoJyxw9wsbUICHR2lJXp103Y/0nw6CCZdZt/N6J3CZ6FQxBg/LzQ+AzXrjCucMhtebEpskF5CY6xGwwlE1JpWBSF5UW+zM+QQ6hdcRWgaf07l/NFN82w6smGTqDkq9D43ZrFhbIFBLf0JDf3AGCDpKJdU2fpT8tdzFr2TqEcWcRJpnfRimOqI8a5lwfdKisBjpXaFB+hf7vh7GGytGlPNxkmBmNk9nkmHijMDqsO3eXZCDYff3ujVcHip3NsxlVvuVpk17n3qoNzqRMBLTBLo/AVHz480/aWA8KXoZyxfkpaXME/uAb/yi4M4pU9SGnQagifUhUnAe+cyYfJ3a3QZFP5m7SR7BVrd34Sh7XMzamL2jTerXFDtB9F/M8+12uL8qOCX9yay2WYLVF1J8+B6f8Z8PF8YEm6Pn5enIPIDZWQ+Vbqsjt1QGXyKwW6LHx7GGv5eTGwlDU0Jbk44VcaymwqKFebMS4qNAYjqRTjbWVCTAGabfbZnsA1+UiWwvRIMEAPijy4NJxsjrNu3bezw8yqmUeFEyu5wkyLcfN67a5alX8wGdBULZgur6vTY94uFVwjOcAfd5u2yODQ2zH0fQLrbQWhOxJLw/dSQ1CLjY4sE7OUz0L18Vtw1pQU9SO4e6tmDIabbBwek0JWnarr3HnQCeptawjBJmK3VPdFjcSmcJz1IAiITMgaCbx/Wa86Ag3LlBx77AGWY8qGHMDiwzAqeYlralrdVk9X/kXKiCWn2Ir2h40/Yx1p7mgogO5POu6AKhDg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(71200400001)(478600001)(8936002)(38100700002)(7416002)(31686004)(36756003)(6486002)(966005)(122000001)(41300700001)(26005)(91956017)(76116006)(66476007)(66556008)(66946007)(64756008)(4326008)(31696002)(66446008)(2906002)(86362001)(186003)(6512007)(6506007)(2616005)(83380400001)(53546011)(5660300002)(316002)(45080400002)(8676002)(54906003)(110136005)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXMxZ3ZrRHdPUUd4UTJxeE9YSnluQ1lwMEg3Q0ttOWNZUU9UWi80WnVNT0Nt?=
 =?utf-8?B?YnhzcEwwQkhHVDdVaTkzYmxiMXV1ZlN0TmNXbTJzdHUyZmY2N1VZdjNkQk84?=
 =?utf-8?B?SitqU2NQbU40RFFJdVUxanJ4bElZMmFIdTJyakdmT1JLNFc0WUJmL1Z2WXht?=
 =?utf-8?B?cllNY1F3R3BIeExvekU3N3VrT2Z5VWlsQ2UveHp0MEN3KzNENlhqQUc4OGNH?=
 =?utf-8?B?VVZsNVBYUVhTcHQ4MUV3TDlOOHduUnNjRlI1SlVqN0V4Z2Y2UWJYd1kvRXJx?=
 =?utf-8?B?N3lXcnM0V0x2ZEtjdFZwQTBJU1Vsa01XZVpNbk0wc2VmRE1PU1M1MXJBbGJw?=
 =?utf-8?B?bGlxajRsa2dFVkZUb0ZzRkRUaWhKVEFoVU04d05qZ3UzaGVzQ2s4aDZ6emVv?=
 =?utf-8?B?YWRCWGI3Rk9keU5kRlpZd0cvam43RTlOSFJ1RDNKOCtyd0wyRTVXRUhGTU5F?=
 =?utf-8?B?aG55azdZWENqeXNia2FmU1VaT1cvbDU4UzVOU0ZjYUcyWXRxRllDQTRxZFU2?=
 =?utf-8?B?citLMDYwenloMFRlRXhpbHdkK3JQVGNtbmY5amI1aEduQlRCWDROMmthNjdP?=
 =?utf-8?B?SEg3ZlN1NlM1Z1ZPNnp6dTVZSlZucTBwOERsRk8yZmlBbWphZWI4RUtLRmc0?=
 =?utf-8?B?Ui9TZ2U3WnZiQUE3TnFVUUJ3T1ZVTW1GTmllZElnS1pyRWVtRElhWlIwQjFy?=
 =?utf-8?B?NHBuUkVaMk5YRTdUMjhsSS9vZEp0QWs2bDhIdmYrU1NJRDRrWm51WHNSbUdh?=
 =?utf-8?B?ck1Ec1JsWlJhVVo1U0dHemtOU28zS05lWHJvT256cDdyVloydnIzazVuU2JQ?=
 =?utf-8?B?UlF5RTlwUkFjOFBkNkRQN3l6eDBBOG44TENRNVBRTUQ5SURqQkZmanN6cjV1?=
 =?utf-8?B?RXJrYlV5RlJmUnlRTExHOERYRWZkZm14M0Y5dDlmT0p3MkpYdjd2WGJhS2Rs?=
 =?utf-8?B?WUc0U3pJQUwyV1c2bnREcEhDMWZBQlJtb1VrODJjQzl2TEFsa0d1VzR0R3VX?=
 =?utf-8?B?RElhRFdxUmRzODFYV1pIV0Q0emQ3WFdPM2t6QTRLWEViQTVEbWF3Z0pQZzNJ?=
 =?utf-8?B?bUI4QVo0RFZudDY2ZHhpaXF5MFo5aEM4Zkp4SjMrd0ZibFNDOElFSS8zcVRz?=
 =?utf-8?B?aHVhZWNmL0RlKzl4aTE5RVZER3JVMG1BQlY2REZRd2ZXWmdBM01pL29jTHJF?=
 =?utf-8?B?b3BBRWpBYkhLQ2dGTWs1S09UR3RLSDJ1SytqZGtURlZOYmQ0MlpoQnpLVVBT?=
 =?utf-8?B?citnL2toNExtdmptUGJLa1dvN2o4MDV3Qmw0ZDY1VXBNUXQ2dnlNbjRuY2gw?=
 =?utf-8?B?SldVYU9Dem9zaDcxTmdtWmNoa29mWnNiM2w0NmszZWE1ektHbHBTeFFqWm1q?=
 =?utf-8?B?N2Nqd2FFV3QyNUREYkRxdW9FN3UyRGtXWk90bkgwNTNBdVJVTFJrK01EV1E4?=
 =?utf-8?B?T282VDRvaVZRWUNMYmZsUkt2TXR1ODNIWUhEdThKTS9RRkdobFR1UFBEeFFl?=
 =?utf-8?B?a0xaRVRJTHI2RFVhUnBRSnU3TVBrMnJqYThkSlhpUy9uOEdWck5lUjBTMGVF?=
 =?utf-8?B?QWE1UjVySy9HVE1rYnhSTnhmeWEzQVpQdWRPdFA3bEZ2WlU5NFRRMmdmV1I5?=
 =?utf-8?B?SU05SG1NZG1CTUxndTRJY3VPc0h3bFNZVDdwaFFmTnNKSXJJbzVJUHRaY3hi?=
 =?utf-8?B?REdFN0RjN1Q2alRtdjhCYUtnQVRXSDI3a1ZCeE01bmtxMmtvc2o1OE9LMUd2?=
 =?utf-8?B?bWVjM0ZJNGZYMUkwS2JYbFJ2REtueHZpeVhsdDhIV214VUZra2RkbXFkR2No?=
 =?utf-8?B?TDNjSnUvL3BSSUpXYmk5enMyME1BMStKZVZabmdJRE8relhuS0VGaVREM2V5?=
 =?utf-8?B?VHY3ZXhtbVZRZWxYT1ZZZlV6czRBclVoVUpmeVU4YkRlNmNSSWZDVEQvNkl3?=
 =?utf-8?B?dS9YeTd4QXBON3JtTSttaVQ1L2JQWVZOcUphczVQZE9wMU53M3VyRld3czFM?=
 =?utf-8?B?NTV2Lzl3R1QvTE5NRnluTnBOSGJISElvMFA4SHlzVFo3dFNKeVBIb01lTkEw?=
 =?utf-8?B?Qk5ROGpKV3Z6MTlzYnFSY3AxR3p5cHVCSGZidEl2NHd2ZDl2YlA5TlUyREt1?=
 =?utf-8?Q?QDQY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E2215E126DD974C8FFB15936EAEDACB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e25367-4257-4743-c8d2-08da8b7b3002
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 18:04:02.8761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNzvumRMxVe/dLnc5Ez50fnc+WYvcN92QVn8n2ad1XIcpWOohyEeDz7HSosrBhGU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMS8yMiAxMToxOCBBTSwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IE9uIFNhdCwgQXVnIDIw
LCAyMDIyIGF0IDEyOjU3OjQ1UE0gLTA3MDAsIEJyYWQgTGFyc29uIHdyb3RlOg0KPj4gRnJvbTog
QnJhZCBMYXJzb24gPGJsYXJzb25AYW1kLmNvbT4NCj4+DQo+PiBUaGUgQU1EIFBlbnNhbmRvIEVs
YmEgU29DIGluY2x1ZGVzIGEgRFcgYXBiX3NzaSB2NCBjb250cm9sbGVyDQo+PiB3aXRoIGRldmlj
ZSBzcGVjaWZpYyBjaGlwLXNlbGVjdCBjb250cm9sLiAgVGhlIEVsYmEgU29DDQo+PiBwcm92aWRl
cyBmb3VyIGNoaXAtc2VsZWN0cyB3aGVyZSB0aGUgbmF0aXZlIERXIElQIHN1cHBvcnRzDQo+PiB0
d28gY2hpcC1zZWxlY3RzLiAgVGhlIEVsYmEgRFdfU1BJIGluc3RhbmNlIGhhcyB0d28gbmF0aXZl
DQo+PiBDUyBzaWduYWxzIHRoYXQgYXJlIGFsd2F5cyBvdmVycmlkZGVuLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEJyYWQgTGFyc29uIDxibGFyc29uQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgZHJp
dmVycy9zcGkvc3BpLWR3LW1taW8uYyB8IDc3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktZHctbW1pby5jIGIvZHJpdmVycy9zcGkvc3Bp
LWR3LW1taW8uYw0KPj4gaW5kZXggMjZjNDBlYTZkZDEyLi4zNmI4YzVlMTBiYjMgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktZHctbW1pby5jDQo+PiArKysgYi9kcml2ZXJzL3NwaS9z
cGktZHctbW1pby5jDQo+PiBAQCAtNTMsNiArNTMsMjQgQEAgc3RydWN0IGR3X3NwaV9tc2NjIHsN
Cj4+ICAgICAgICB2b2lkIF9faW9tZW0gICAgICAgICpzcGlfbXN0OyAvKiBOb3Qgc3Bhcng1ICov
DQo+PiAgIH07DQo+Pg0KPj4gK3N0cnVjdCBkd19zcGlfZWxiYSB7DQo+PiArICAgICBzdHJ1Y3Qg
cmVnbWFwICpzeXNjb247DQo+PiArfTsNCj4+ICsNCj4+ICsvKg0KPj4gKyAqIEVsYmEgU29DIGRv
ZXMgbm90IHVzZSBzc2ksIHBpbiBvdmVycmlkZSBpcyB1c2VkIGZvciBjcyAwLDEgYW5kDQo+PiAr
ICogZ3Bpb3MgZm9yIGNzIDIsMyBhcyBkZWZpbmVkIGluIHRoZSBkZXZpY2UgdHJlZS4NCj4+ICsg
Kg0KPj4gKyAqIGNzOiAgfCAgICAgICAxICAgICAgICAgICAgICAgMA0KPj4gKyAqIGJpdDogfC0t
LTMtLS0tLS0tMi0tLS0tLS0xLS0tLS0tLTANCj4+ICsgKiAgICAgIHwgIGNzMSAgIGNzMV9vdnIg
ICBjczAgICBjczBfb3ZyDQo+PiArICovDQo+PiArI2RlZmluZSBFTEJBX1NQSUNTX1JFRyAgICAg
ICAgICAgICAgICAgICAgICAgMHgyNDY4DQo+PiArI2RlZmluZSBFTEJBX1NQSUNTX1NISUZUKGNz
KSAgICAgICAgICgyICogKGNzKSkNCj4+ICsjZGVmaW5lIEVMQkFfU1BJQ1NfTUFTSyhjcykgICAg
ICAgICAgKDB4MyA8PCBFTEJBX1NQSUNTX1NISUZUKGNzKSkNCj4+ICsjZGVmaW5lIEVMQkFfU1BJ
Q1NfU0VUKGNzLCB2YWwpICAgICAgXA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICgoKCh2YWwp
IDw8IDEpIHwgMHgxKSA8PCBFTEJBX1NQSUNTX1NISUZUKGNzKSkNCj4gUGxlYXNlIHRha2UgdGhl
IEBBbmR5JyBub3RlcyBpbnRvIGFjY291bnQ6DQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2VybmVsLm9yZyUy
RmxrbWwlMkZDQUhwNzVWZXgwVmtFQ1lkJTNEa1kwbTYlM0RqWEJZU1hnMlVGdTd2bjI3MSUyQlE0
OVdabjIyR0ElNDBtYWlsLmdtYWlsLmNvbSUyRiZhbXA7ZGF0YT0wNSU3QzAxJTdDQnJhZGxleS5M
YXJzb24lNDBhbWQuY29tJTdDMjVkMGYxN2RmY2JkNDRmNjYxYzgwOGRhODNhMTlhOTglN0MzZGQ4
OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3OTY3MDI3NDE4NjAzNDI5
JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1
TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3Nk
YXRhPVZGSSUyRnB0TTc5WVliWm0lMkZ5UW10c3NMc05JUTc1QU9VMDVyb25aMVFTdGxVJTNEJmFt
cDtyZXNlcnZlZD0wDQoNClllcywgSSBoYWQgYSB0ZXN0ZWQgY2hhbmdlIGZvciB0aGlzIGJ1dCBt
aXNzZWQgYWRkaW5nIHRvIHRoZSBwYXRjaCB1cGRhdGUuDQpUaGlzIGlzIHRoZSBjaGFuZ2UgYW5k
IEknbGwgcmVzZW5kIGp1c3QgdGhpcyBwYXRjaC4NCg0KLS0tIGEvZHJpdmVycy9zcGkvc3BpLWR3
LW1taW8uYw0KKysrIGIvZHJpdmVycy9zcGkvc3BpLWR3LW1taW8uYw0KQEAgLTY2LDEwICs2Niw2
IEBAIHN0cnVjdCBkd19zcGlfZWxiYSB7DQogwqAgKsKgwqDCoMKgwqAgfMKgIGNzMcKgwqAgY3Mx
X292csKgwqAgY3MwwqDCoCBjczBfb3ZyDQogwqAgKi8NCiDCoCNkZWZpbmUgRUxCQV9TUElDU19S
RUcgMHgyNDY4DQotI2RlZmluZSBFTEJBX1NQSUNTX1NISUZUKGNzKcKgwqDCoMKgwqDCoMKgwqDC
oMKgICgyICogKGNzKSkNCi0jZGVmaW5lIEVMQkFfU1BJQ1NfTUFTSyhjcynCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICgweDMgPDwgRUxCQV9TUElDU19TSElGVChjcykpDQotI2RlZmluZSBFTEJBX1NQ
SUNTX1NFVChjcywgdmFsKcKgwqDCoMKgwqDCoMKgIFwNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKCgodmFsKSA8PCAxKSB8IDB4MSkgPDwgRUxCQV9TUElD
U19TSElGVChjcykpDQoNCiDCoC8qDQogwqAgKiBUaGUgRGVzaWdud2FyZSBTUEkgY29udHJvbGxl
ciAocmVmZXJyZWQgdG8gYXMgbWFzdGVyIGluIHRoZSANCmRvY3VtZW50YXRpb24pDQpAQCAtMjU3
LDggKzI1Myw5IEBAIHN0YXRpYyBpbnQgZHdfc3BpX2NhbmFhbl9rMjEwX2luaXQoc3RydWN0IA0K
cGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KDQogwqBzdGF0aWMgdm9pZCBkd19zcGlfZWxiYV9vdmVy
cmlkZV9jcyhzdHJ1Y3QgZHdfc3BpX2VsYmEgKmR3c2VsYmEsIGludCANCmNzLCBpbnQgZW5hYmxl
KQ0KIMKgew0KLSByZWdtYXBfdXBkYXRlX2JpdHMoZHdzZWxiYS0+c3lzY29uLCBFTEJBX1NQSUNT
X1JFRywgRUxCQV9TUElDU19NQVNLKGNzKSwNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFTEJBX1NQSUNTX1NFVChjcywgZW5hYmxlKSk7DQorIHJl
Z21hcF91cGRhdGVfYml0cyhkd3NlbGJhLT5zeXNjb24sIEVMQkFfU1BJQ1NfUkVHLA0KK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChHRU5NQVNLKDEs
IDApIDw8ICgoY3MpIDw8IDEpKSwNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAoKGVuYWJsZSkgPDwgMSB8IEJJVCgwKSkgPDwgKChjcykgPDwgMSkp
Ow0KDQogwqB9DQoNCj4gT25lIG1vcmUgbml0cGljayBiZWxvdy4NCj4NCj4gK3N0YXRpYyBpbnQg
ZHdfc3BpX2VsYmFfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkd19zcGlfbW1pbyAqZHdzbW1pbykNCj4gK3sNCj4g
KyAgICAgY29uc3QgY2hhciAqc3lzY29uX25hbWUgPSAiYW1kLHBlbnNhbmRvLWVsYmEtc3lzY29u
IjsNCj4gKyAgICAgc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0K
Pj4gKyAgICAgc3RydWN0IGRldmljZV9ub2RlICpub2RlOw0KPj4gKyAgICAgc3RydWN0IGR3X3Nw
aV9lbGJhICpkd3NlbGJhOw0KPiBQbGVhc2UsIHVzZSB0aGUgcmV2ZXJzZSB4bWFzIHRyZWUgb3Jk
ZXIgb2YgdGhlIGxvY2FsIHZhcmlhYmxlcw0KPiBhcyB0aGUgcmVzdCBvZiB0aGUgZHJpdmVyIG1h
aW5seSBpbXBsaWVzLg0KQ2hhbmdlZCB0byByZXZlcnNlIHhtYXMgdHJlZSBvcmRlcmluZy4NCg0K
UmVnYXJkcywNCkJyYWQNCg==
