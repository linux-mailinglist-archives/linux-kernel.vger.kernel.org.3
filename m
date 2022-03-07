Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6A64CFD5D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiCGLuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbiCGLt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:49:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789666616;
        Mon,  7 Mar 2022 03:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646653744; x=1678189744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Iz2e+A8JCIX668yEacbIfK4Mi9UAwwjf1EOENyOOl04=;
  b=cqVOXz1lF1JdGBII0bJPkuSZL2KCh40nz+1DBkxZ35BWz0SFjRruIAwG
   9yXmEVNOBgJt6b7n2S4xlWafDvdNB69tnCiEpk3yiHqhOgtCeJCruOe6X
   tyyOoXXZok5BSoLMGpPS37M6EO3TR58udOTyEFjVdj+oAXwvwTRWN5A8s
   4wTKeUUaul5mPw8QWzt9XKLiIShZO7+7b0Xp/hGYdYnw89I5DlEQo2c9H
   4B27C77NiGEgH60OiizhbJdJ8eebCx4JxRsQRRoeISFEOhBOPvWQQqR2A
   dmGwj6y/hvcUhAwQU/TY+QfUJGnpEVOS2lYB65HZX/+/Fv0JbbBytwict
   A==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="155939520"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 04:49:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 04:49:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 04:49:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBQXymkcVWKGtZ705cxS54q85YGTu8/VodxmNjEXwQQa57FII1NtxUXMip7OXeN/NLyujmyadSKdpyEUvJTwnTexjWeNofBM78fnoLWFA7CkXdDPNzcHsdfQc8MSnd8sPpIESoPw5LWokpVKf6+1vnIerHJKbISvt+hITMgQutXEmXKk2nTpgFdoKIZHl6sXjw0mJhamVdbJ0gYCxgXBKt83HVucANPO1S0/UhuP8pBY9fYXZKYkBtNByskJrPwEJ90x0UrR7/fk+YZBuml0Jgwk95v0eZcBe8B3u6+Y16Q+e1Y4Jv2P8cQBlJ1G9hhQihzBdTpzTuFct+cwvmjRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz2e+A8JCIX668yEacbIfK4Mi9UAwwjf1EOENyOOl04=;
 b=QBS/0EEH4bZQ43TdeL5UT9kQHh6qYesn/oAwumciHRFSTXvaE/wuhS2Ho0OVyVvFFRja25uiUg9s7G4MVieg8R39e056/gXRR5WadRqWg8BZt6jJSRvjT/QqOKO6zSojTFJzZNPom8+ygDoKdq7ybYnqo+nBnb7EOVZ4VgFHDu6/Vmqg+rTJRuxtJoCSHSt1RYPK5UgHhbeKFRYP+MLgIJRyyAhofAYgI/JGv2h6s5D4luGPR7d0/cOyvbvQ6F2N0jZBoR38q5mEgCFNRGcDodS4ccTX7++PKiSQyTCXT3a6XA+hawkHaCsLC10wfjR2uGwXFX0jIBvxq5QvbRr5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iz2e+A8JCIX668yEacbIfK4Mi9UAwwjf1EOENyOOl04=;
 b=tyqkoakuL9d2PmPphDfT22XcVcRSDDsYg/tdjv6ic/yUHKMSKQEy33Z50QI9TyMg2bePPHL1pqq1TfnwruPzLr4BBClOyV85b7O46lOSYV5k9+XgG64p3r42TyTbNQp6Xf3Y0hrQ+o7SqQTmg0bd8yX7sJ7KiHmtUpG6QmfS888=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by SN6PR11MB3421.namprd11.prod.outlook.com (2603:10b6:805:cd::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 11:48:58 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc%9]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 11:48:58 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jacopo@jmondi.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v6 04/13] media: atmel: atmel-isc: implement media
 controller
Thread-Topic: [PATCH v6 04/13] media: atmel: atmel-isc: implement media
 controller
Thread-Index: AQHYLxSOyw0+bLUC9UC5+p6WOroqq6yzoXyAgAAdcICAABWQgA==
Date:   Mon, 7 Mar 2022 11:48:58 +0000
Message-ID: <91a12e64-cfa7-a443-fcfa-5e190e978a53@microchip.com>
References: <20220303153618.2084156-1-eugen.hristev@microchip.com>
 <20220303153618.2084156-5-eugen.hristev@microchip.com>
 <20220307084623.njcncfp3sozsob26@uno.localdomain>
 <da9d690e-e3ac-6813-c9f6-6c610ee407a0@microchip.com>
In-Reply-To: <da9d690e-e3ac-6813-c9f6-6c610ee407a0@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0250771f-e2f8-4e91-0f6e-08da00307743
x-ms-traffictypediagnostic: SN6PR11MB3421:EE_
x-microsoft-antispam-prvs: <SN6PR11MB34219CD9A93263232F76114AE8089@SN6PR11MB3421.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 45kwjAYl4ZSplaT1/wrMDQJzYNFrK1mgAnQTRedt1DoDS5BYaB/9780ktG2cccdH3FgFD0mAO+Bq5BmU/uXxivELwv5xd0/wF7lMAhe26Wicc7LpT3wNvQEb9vsVrsNuxV53CFNNdCtyk2xE3x0vswGFhXGZ6VYfqRVVSkMvHSBmZ6mNJnaSALexd2wzt/CV72PVXfnnNsm5pG9A8c7jYcQQURzMcamPQ9PUyVCqxd4nqu0DPYhoTh2xw2DsmognUu1QzmxBow3ztK7PKDbxY8XoEUrzJVYxgOvbtEQMUlKcdYO4CDh8vfgpPhuRgyTB5vUiDglWF2K5dcThYYWKSySi0av6M1YOBJrmAY2x+83ptexYbNbtftPIN2/hSeAdMsAYAhWg4f3vfe4doKrQqgr5rEa0Pt9kPzFgYc+ge506EPayzb38ktCnN90JhKMA2xifCqtwdntD0RsJiYvYRkqxapkJ4utbZZqwT+mLtx4KsNJ3qGDE+0ogPSJdAUu/qUtsfSf0G0awIvCCCFMWzlkZrN/FpAoTgd4coG0xAu9jg3pX10SnFZ+XAMGj5C2TKyO1VVKaNKccYEVV2kQLd3ha3gBCNYkf3n1TjI8C6pu5XBfOu9iXz6x7kujaMCeTJcjZyX7c+i4mjQBzKXE0Pdfd3v9moYuHhSuUrgEwpjgvfJ87S7UliaByRaPr4nkUPd1CoifbCT0DQRyzKSdrXS/FDyjKg60NAUjfxekwXD5PAPDu2xfl/0+fzt5pkmZgunziUIIsvkH5RtgK8Ek42w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(8936002)(66946007)(66556008)(86362001)(5660300002)(6512007)(6486002)(107886003)(2906002)(186003)(26005)(91956017)(8676002)(4326008)(76116006)(31696002)(64756008)(66476007)(66446008)(2616005)(38070700005)(38100700002)(122000001)(316002)(71200400001)(31686004)(54906003)(36756003)(6916009)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDRVeU9pRWt4dG1kNDZaaTFTbEZOTHlrZWw0cjZqdWxJcTNldytkcXpneUo0?=
 =?utf-8?B?NkE4cXRGZU9mRjZJRWsrclVLdS82OVZndFVNbXdlZEdUb3h2MldQZ084ZmtW?=
 =?utf-8?B?Lzl2ZWpKMTNUcWcweXk2WUo5NkpRcW11M2Q0OGlQQVZqWFlGVTZBYkdkc09D?=
 =?utf-8?B?TzRwZ0tBMSs2R3hKdVUveFNOV0FFcEtWanBLSFZoUnFjWkNBWlFDZGRWMVVk?=
 =?utf-8?B?bkJYaUJaaEFveDNSKzlaRXhnQ0xuMlJod0x3VmI5ems1dWZPdWJNZzZyKzI5?=
 =?utf-8?B?dmlrcmQ0cGJFcE5sWjllUXBkZDAvclFUQUNpbXdhdVVLb2ZEYlhTVnNRWWkz?=
 =?utf-8?B?S1picFhzdEpzQ1RjdE9tUXZoTm5ta0pybFBwTGdmY2d4QnZwMkt6bnZXcWow?=
 =?utf-8?B?NXlNTEt4NHFiajZGWlRqdjVtZlMrVTdGZk03MlFXWDRUTGZjaHVKNGNhM1Nl?=
 =?utf-8?B?d2ozSGtPNVNacEhIbGl1MEJ4VTdlQUR1N1Q2Wm9PTzJkRzcrU1V6dW5PSGFt?=
 =?utf-8?B?WlMrNWdEV2U1WWZLWlpaSUpmR3I3UUNpaGpWeCsvSkpJSUdUZGpWSnFQYVdD?=
 =?utf-8?B?N2RvR0RnWDBRcnp6TThzcUZyT0NHNHRJY2o5cExEK3hqeVUyRlJ0UXRXazhp?=
 =?utf-8?B?U0hWeThKZHd2UTBNTEs0Mjg3NUJlcmxlSTVScTJVSHlCeE5zVWkyblVUWGtY?=
 =?utf-8?B?ZmxYaStHcUdUc3ZCMmxDU2MxMkZoS2szdHVRd3BhbjFEaWw1TG1ST2U3ZzR5?=
 =?utf-8?B?UzRvM1BhbGE4MmJUODk2Q1lRRC81QkVCUVFCdk8zdFZqWGY0RThBWUpPTUpp?=
 =?utf-8?B?QjFSZWwxTmtDWFRRK3JyQ3pjamt5ZHlndjdyWW1xNVNCNEh3V3l1eVdQVDhx?=
 =?utf-8?B?cGF6WWZ3bFpjcHNLMkxJRGlrZ3E0TEJ6NGE2dFNlVDRDbzM1UU9sVldBVCsv?=
 =?utf-8?B?dDZpeXA3WEdSc0RBSEVFODdZSGdQazZTa004dEpsRFZVRlU4TjF2VTZPa2g3?=
 =?utf-8?B?WjZVbytoWm12MForeXJSK0d5YWVKaHk2Q253bDB4dk1Za2xpYUdHZWtpU0VJ?=
 =?utf-8?B?SGc3RWxYVUtlL0JCQ29rMzN5RHQxS1ZvV0NpWVBaUVpWd2FYNi9hSHpvMFhC?=
 =?utf-8?B?WDE5VjcxOHg1T2hEblhnaG5mbmcxS2RkNmY1RzUrYW5mUEN3enBSaTByOGxU?=
 =?utf-8?B?ZEpZdnlGcWh0SjREaFlrTlA4K2pPZHcweDBnekZ2YkhiQVZrK2hScTNtZDhm?=
 =?utf-8?B?RjVtb2d6S2FHYUF4L2pobE9wcGNtRkgwMEp4OUxUWEZhbFZxbm1DeXpFbzQv?=
 =?utf-8?B?dXU4U3JscnVVaGNvM1BVNGNwbWRLQ3NyclBLQVNzTDI1VVJOWmxOcW5WVG1B?=
 =?utf-8?B?L1Y0ckNYTVNUUGJEWTJlbDcxakZraHMzK0puVlNSVEZhaXg3Wmpha3dQTno1?=
 =?utf-8?B?OU83WkJYSncycmVwK0gzMWZ1cmZBTXAyWHRlcWpEczZWZFY0Tml5TXV6NnZU?=
 =?utf-8?B?WFcvVmRXV2JpUUNhWUJTMnNvNVNGTDRvZHRHYXd2cVcvRjJTNGNhTjhyUG5T?=
 =?utf-8?B?aG9mcEwydzErcmZlNjMraHJWQ3Q4T3hCZmJnR05kUFFhVm1adDAwNHA2V3pN?=
 =?utf-8?B?NXFlbjNuNVJ2eGlvdmF5dmVUa1ZaNnR4cU5aMWYrbmxJSDNLN2RYK1pLelFD?=
 =?utf-8?B?YnpVYTNzOFZ0WS85d2RELzVXR0lXL2hJVXByQVR5Z28ybWlwM0pHeXYyQVls?=
 =?utf-8?B?cEswZXFFRUZZT2VLSEFwWTJCQ3JYcHZVa0YyeXdDRWdCWWp0SzhESkNQQnl4?=
 =?utf-8?B?SVl4TTlwUzQyL0k1cDBNdVBEaXcwZVBRQTE5Mjd5MWRoZklRaC80OXluSzcw?=
 =?utf-8?B?RW0zQXZleXlnRkJ2TDJUNVJBQlBRbGt6MFh0MWVCbUlySlhLdDFwZGh5TGMw?=
 =?utf-8?B?YjQ1Si9NazQxaWw0STYxbloyWGJJRmU5T21BSmxaK2N0YjdDVzk4ZU5aTkkw?=
 =?utf-8?B?UE43c0tFd2lITi96OExCM0p3MTBXcnErTkJOR3F0VER1T2pTbG1PUDJKM09Y?=
 =?utf-8?B?aHBGNytoM1E4TXpZQlB3RU0vT0doT0krc29Nazd5N0w4em5PN1lGWEhQK0hp?=
 =?utf-8?B?U01peTVkZEtDek9KQkxwUlZsRXBnYmNZN3dPMEtRR2xwKzZLUmZEVHFrTU9W?=
 =?utf-8?B?cFk2aVBwUVhzQ01peTVYOWhIaDVIS0J2bTJVT0EvN0VPN2YwVXZlK2FwQ3Nr?=
 =?utf-8?B?YmlvQU1aQWhVc2RaOGZ1cVdYQkFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B18570AD5031BE48BB6225D893685403@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0250771f-e2f8-4e91-0f6e-08da00307743
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 11:48:58.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUKJoA9RuWjpZ1+oW1f8XUGuM1ehBuGntgn9uLVJwiRqsvUjGlbZVD3C3uowKO+Z/6oCG9hqIWlT+aQAOCbypinOnaqprWCvJAhPrdAeDSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3421
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W3NuaXBdDQoNCj4+PiArc3RhdGljIGludCBpc2Nfc2NhbGVyX2dfc2VsKHN0cnVjdCB2NGwyX3N1
YmRldiAqc2QsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdjRsMl9zdWJk
ZXZfc3RhdGUgKnNkX3N0YXRlLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHY0bDJfc3ViZGV2X3NlbGVjdGlvbiAqc2VsKQ0KPj4+ICt7DQo+Pj4gKyAgICAgc3RydWN0IGlz
Y19kZXZpY2UgKmlzYyA9IGNvbnRhaW5lcl9vZihzZCwgc3RydWN0IGlzY19kZXZpY2UsIHNjYWxl
cl9zZCk7DQo+Pj4gKw0KPj4+ICsgICAgIGlmIChzZWwtPnBhZCA9PSBJU0NfU0NBTEVSX1BBRF9T
T1VSQ0UpDQo+Pj4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+PiArDQo+Pj4gKyAg
ICAgaWYgKHNlbC0+dGFyZ2V0ID09IFY0TDJfU0VMX1RHVF9DUk9QX0JPVU5EUykgew0KPj4+ICsg
ICAgICAgICAgICAgLyogYm91bmRzIGFyZSB0aGUgaW5wdXQgZm9ybWF0IHJlY2VpdmVkICovDQo+
Pj4gKyAgICAgICAgICAgICBzZWwtPnIuaGVpZ2h0ID0gaXNjLT5zY2FsZXJfZm9ybWF0W0lTQ19T
Q0FMRVJfUEFEX1NJTktdLmhlaWdodDsNCj4+PiArICAgICAgICAgICAgIHNlbC0+ci53aWR0aCA9
IGlzYy0+c2NhbGVyX2Zvcm1hdFtJU0NfU0NBTEVSX1BBRF9TSU5LXS53aWR0aDsNCj4+DQo+PiBJ
J2xsIHJlLXBhc3RlIG91ciBkaXNjdXNzaW9uIG9uIHY0IHRvIG1ha2Ugc3VyZSB3ZSdyZSBvbiB0
aGUgc2FtZSBwYWdlDQo+Pg0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+Pj4gKyAgICAg
aWYgKHNlbC0+cGFkID09IElTQ19TQ0FMRVJfUEFEX1NPVVJDRSkNCj4+Pj4+ICsgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4+PiArDQo+Pj4+PiArICAgICBpZiAoc2VsLT50YXJnZXQg
IT0gVjRMMl9TRUxfVEdUX0NST1BfQk9VTkRTICYmDQo+Pj4+PiArICAgICAgICAgc2VsLT50YXJn
ZXQgIT0gVjRMMl9TRUxfVEdUX0NST1ApDQo+Pj4+PiArICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgICAgc2VsLT5yLmhlaWdodCA9IGlzYy0+bWF4X2hlaWdo
dDsNCj4+Pj4+ICsgICAgIHNlbC0+ci53aWR0aCA9IGlzYy0+bWF4X3dpZHRoOw0KPj4+Pg0KPj4+
PiBUaGUgQ1JPUF9CT1VORFMgc2hvdWxkIGJlIHNldCB0byB0aGUgc2FtZSBzaXplIGFzIHRoZSBz
aW5rIHBhZCBpbWFnZSBmb3JtYXQsDQo+Pj4+IGFzIGl0IHJlcHJlc2VudHMgdGhlIG1heGltdW0g
dmFsaWQgY3JvcCByZWN0YW5nbGUuDQo+Pj4+DQo+Pj4+IFRHVF9DUk9QIHNob3VsZCByZXBvcnQg
dGhlIGNvbmZpZ3VyZWQgY3JvcCByZWN0YW5nbGUgd2hpY2ggY2FuIGJlDQo+Pj4+IGludGlpYWxp
emVkIHRvIHRoZSBzYW1lIHNpemUgYXMgQ1JPUF9CT1VORFMsIGlmIG15IHVuZGVyc3RhbmRpbmcg
b2YNCj4+Pj4gdGhlIHNwZWMgaXMgY29ycmVjdA0KPj4+DQo+Pj4gU28geW91IHdvdWxkIGxpa2Ug
dG8gaGF2ZSB0aGlzIGRpZmZlcmVudGlhdGVkLCBhbmQgcmVwb3J0IHRoZQ0KPj4+IENST1BfQk9V
TkRTIHRvIHdoYXRldmVyIGlzIG9uIHRoZSBzaW5rIHBhZCwgYW5kIHRoZSBUR1RfQ1JPUCB0byB3
aGF0IGlzDQo+Pj4gcmVwb3J0ZWQgbm93LCB0aGUgbWF4aW11bSBzaXplIG9mIHRoZSBJU0MgZnJh
bWUgLg0KPj4+IE15IHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdCA/DQo+Pj4NCj4+DQo+PiBJIGRp
ZG4ndCBrbm93IHlvdSBoYXZlIGFuIEhXIGxpbWl0YXRpb24sIHNvIHlvdXIgX0JPVU5EUyBpcyBu
b3QgdGhlDQo+PiBpbnB1dCBpbWFnZSBzaXplIGJ1dCByYXRoZXIgMzI2NHgyNDY0ICggPT0gbWF4
X3dpZHRoIHggbWF4X2hlaWdodCkuDQo+Pg0KPj4gV2hhdCBJIG1lYW50IGlzIHRoYXQgX0JPVU5E
UyBzaG91bGQgcmVwb3J0IHRoZSBtYXhpbXVtIHJlY3RhbmdsZSBzaXplDQo+PiB0aGF0IGNhbiBi
ZSBhcHBsaWVkIHRvIHRoZSBfQ1JPUCB0YXJnZXQuIEluIHlvdSBjYXNlIHlvdSBoYXZlIGFuIEhX
DQo+PiBsaW1pdGF0aW9uIDMyNjR4MjQ2NCBhbmQgdGhhdCdzIHRoZSBsYXJnZXN0IHJlY3Rhbmds
ZSB5b3UgY2FuIGFwcGx5Lg0KPj4gVEdUX0NST1AgY2FuIGJlIGluaXRpYWxpemVkIHRvIHRoZSBz
YW1lIGFzIF9CT1VORCwgYnV0IGlmIHlvdQ0KPj4gaW1wbGVtZW50IHNfc2VsZWN0aW9uIGl0IHNo
b3VsZCByZXBvcnQgd2hhdCBoYXMgYmVlbiB0aGVyZSBhcHBsaWVkLg0KPj4gQnV0IGFzIHlvdSBk
b24ndCBpbXBsZW1lbnQgc19zZWxlY3Rpb24geWV0LCBJIHRoaW5rIHRoaXMgaXMgZmluZSBmb3IN
Cj4+IG5vdy4gTWF5YmUgYSBsaXR0bGUgY29tbWVudCA/DQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+Pg0KPj4gSSB0aGluayB0aGVuIHRoYXQgX0JPVU5EUyBzaG91bGQgYmUgZml4ZWQgdG8g
MzI2NHgyNDY0IGFuZCBDUk9QIHRvDQo+PiBzcmNfZm10Lg0KPj4NCj4+IFRoZSByZXN0IGxvb2tz
IGdvb2QhIFRoYW5rcyBmb3IgcHVzaGluZyB1cCB0byB0aGlzIHZlcnNpb24gYW5kIHRoYW5rcw0K
Pj4gZm9yIGFkZHJlc3NpbmdzIGNvbW1lbnRzIQ0KPj4NCj4+IFJldmlld2VkLWJ5OiBKYWNvcG8g
TW9uZGkgPGphY29wb0BqbW9uZGkub3JnPg0KPj4NCj4+IFRoYW5rcw0KPj4gICAgIGoNCj4gDQo+
IEhlbGxvIEphY29wbywNCj4gDQo+IFNvIEJPVU5EUyBnb2VzIHRvIGlzYyBtYXggSCAvIG1heCBW
LCBhbmQgQ1JPUCBnb2VzIHRvIGZvcm1hdCBvZiB0aGUNCj4gc291cmNlIHBhZC4NCj4gR290IGl0
Lg0KPiANCj4gSSB3aWxsIHVwZGF0ZSB3aXRoIGEgdjcgYXMgc29vbiBhcyB5b3UgZ2l2ZSBtZSB5
b3VyIGZlZWRiYWNrIG9uIHRoZQ0KPiBwYXRjaCA4LzEzIHdoaWNoIHN0aWxsIHJlcXVpcmVkIHNv
bWUgY2hhbmdlcyBmcm9tIHY2Lg0KPiANCj4gVGhhbmtzIGFnYWluIGZvciByZXZpZXdpbmcgdGhp
cyAhDQoNCg0KV2l0aCB0aGUgaW5jb21pbmcgdjcsIG1lZGlhLWN0bCAtcCBub3cgbG9va3MgbGlr
ZSB0aGlzOg0KDQpEZXZpY2UgdG9wb2xvZ3kNCi0gZW50aXR5IDE6IGF0bWVsX2lzY19zY2FsZXIg
KDIgcGFkcywgMiBsaW5rcykNCiAgICAgICAgICAgICB0eXBlIFY0TDIgc3ViZGV2IHN1YnR5cGUg
VW5rbm93biBmbGFncyAwDQogICAgICAgICAgICAgZGV2aWNlIG5vZGUgbmFtZSAvZGV2L3Y0bC1z
dWJkZXYwDQogICAgICAgICBwYWQwOiBTaW5rDQogICAgICAgICAgICAgICAgIFtmbXQ6U1JHR0Ix
MF8xWDEwLzMyODB4MjQ2NCBmaWVsZDpub25lIGNvbG9yc3BhY2U6c3JnYg0KICAgICAgICAgICAg
ICAgICAgY3JvcC5ib3VuZHM6KDAsMCkvMzI2NHgyNDY0DQogICAgICAgICAgICAgICAgICBjcm9w
OigwLDApLzMyNjR4MjQ2NF0NCiAgICAgICAgICAgICAgICAgPC0gImNzaTJkYyI6MSBbRU5BQkxF
RCxJTU1VVEFCTEVdDQogICAgICAgICBwYWQxOiBTb3VyY2UNCiAgICAgICAgICAgICAgICAgW2Zt
dDpTUkdHQjEwXzFYMTAvMzI2NHgyNDY0IGZpZWxkOm5vbmUgY29sb3JzcGFjZTpzcmdiXQ0KICAg
ICAgICAgICAgICAgICAtPiAiYXRtZWxfaXNjX2NvbW1vbiI6MCBbRU5BQkxFRCxJTU1VVEFCTEVd
DQoNCkJvdW5kcyBhcyBtYXhpbXVtIGlzYyBzaXplOiAzMjY0eDI0NjQsIGNyb3AgYXMgbWF4aW11
bSBpc2Mgc2l6ZSAzMjY0eDI0NjQNCg0KSW4gY2FzZSBlLmcuIHRoZSBzZW5zb3IgaXMgc2VuZGlu
ZyBhIHN0cmVhbSBhdCBsb3dlciByZXMsIGxpa2UgDQoxOTIweDEwODAsIGl0IHdpbGwga2VlcCB0
aGUgc2FtZSBib3VuZHM6DQoNCkRldmljZSB0b3BvbG9neQ0KLSBlbnRpdHkgMTogYXRtZWxfaXNj
X3NjYWxlciAoMiBwYWRzLCAyIGxpbmtzKQ0KICAgICAgICAgICAgIHR5cGUgVjRMMiBzdWJkZXYg
c3VidHlwZSBVbmtub3duIGZsYWdzIDANCiAgICAgICAgICAgICBkZXZpY2Ugbm9kZSBuYW1lIC9k
ZXYvdjRsLXN1YmRldjANCiAgICAgICAgIHBhZDA6IFNpbmsNCiAgICAgICAgICAgICAgICAgW2Zt
dDpTUkdHQjEwXzFYMTAvMTkyMHgxMDgwIGZpZWxkOm5vbmUgY29sb3JzcGFjZTpzcmdiDQogICAg
ICAgICAgICAgICAgICBjcm9wLmJvdW5kczooMCwwKS8zMjY0eDI0NjQNCiAgICAgICAgICAgICAg
ICAgIGNyb3A6KDAsMCkvMTkyMHgxMDgwXQ0KICAgICAgICAgICAgICAgICA8LSAiY3NpMmRjIjox
IFtFTkFCTEVELElNTVVUQUJMRV0NCiAgICAgICAgIHBhZDE6IFNvdXJjZQ0KICAgICAgICAgICAg
ICAgICBbZm10OlNSR0dCMTBfMVgxMC8xOTIweDEwODAgZmllbGQ6bm9uZSBjb2xvcnNwYWNlOnNy
Z2JdDQogICAgICAgICAgICAgICAgIC0+ICJhdG1lbF9pc2NfY29tbW9uIjowIFtFTkFCTEVELElN
TVVUQUJMRV0NCg0KDQo+IA0KPiBFdWdlbg0KPiANCg0KDQpbc25pcF0NCg==
