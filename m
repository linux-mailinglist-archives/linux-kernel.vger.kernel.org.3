Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAD5567557
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiGERLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiGERLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:11:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644BE20BCC;
        Tue,  5 Jul 2022 10:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0fT8WSYjOogishK2RYz2/Dte0deARnL3cX2nGnHS0JIkaRkONwmsTomEz4SNbV6XuhHpa6eZkUJcz9RStTPGJgg/jSutAhu/JkUpNa2wBxI2Ops6UR2lwpc5QXo70yf4gg0VVbLzkhb0ARZ9g9SkHYZhHABgoxxeYWQeeqCeNyhW3kA51n/MaGwB4pWPxhCzpd6h/1xUfW7gSQami4kNor7ULc/VESgGTI1gqRhw3Vy88XW77kMlLHaEhxqTm83/RetjccP58P5eR88pWDvEK2RX7xjyM3KmJE/kRSEAJp5xxcowykykQ9C2rKIK0VFaoct7ozCGwOuwm+S/PnvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D3Kr/gaUkXVVxnCRgh8yrF9VLXg7qLn58kIJsaTx0Q=;
 b=dmYQIKABAPyyZbK+xGUXFjQy/uWggu9MI6GScCVtv/dqo3js8Pa1YY9a9dgDsUF+RPkxW/BEaCySSmA/DLcObxzgSsMXcMVBZKa7yrWWU4WEKJGmdtwSflHhAnXWyeUBHszMCKsihLcBzQ+wIMNo94YvlWVA+fsYrxtjhAp0BNjnn9CTLouTuV8ZC+I6DLw14haygLZID/oSq3Hvdmhuj5CxR+i00l/17yRPyZ5Vj/z2XQ1We4jACPw+5rcm4YpNbaUdCbPe0UCkcTHXtBaXy/xfIxKIX+m02wSAJUeUlEQcG0Mm0nQs2Lbs4j9RtXcQvGwxi/aK+vywN1+VI7RAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D3Kr/gaUkXVVxnCRgh8yrF9VLXg7qLn58kIJsaTx0Q=;
 b=vGr7OAZK0/QKOwL9u8Ty9lJHeS/oH7ZnQvS0BcxO59dVe3O8q2HP4zPp6rz6s9+e8R/jNFJwtqrq3ivMBNRnI5KkOEp7x89oJawnXt/B4MOO6+vd/6mWeEZGG5ZIS75/yyHqXiAKZuX51h9Cz/+8PZyXY7skZN+aItUTvYy0tN8=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 17:10:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 17:10:19 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Tor Vic <torvic9@mailbox.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
Thread-Topic: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
Thread-Index: AQHYkI3oHwsmDIPXdEqC7OG2HKjJD61wAjmA
Date:   Tue, 5 Jul 2022 17:10:19 +0000
Message-ID: <MN0PR12MB61015A04C6E4202B2E8E08A9E2819@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <272584304.305738.1657029005216@office.mailbox.org>
 <CAHk-=wivGGgs9K_TfQYTW4RzH_C-JVfLZKNA5+hKQU0eNFBeiw@mail.gmail.com>
In-Reply-To: <CAHk-=wivGGgs9K_TfQYTW4RzH_C-JVfLZKNA5+hKQU0eNFBeiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-05T17:07:14Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=00915ba1-77c1-4659-8ad8-6e0678b80104;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-05T17:10:18Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 789e22ef-3f06-466e-9f55-61ae20617869
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55f5dbf4-3f57-415b-430d-08da5ea93d35
x-ms-traffictypediagnostic: CY5PR12MB6060:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0JxJWWb1oRWP5FB08/g0pneIAHnrnDZF3J6j6G5fs0Hf29jeEcoh0wKwcAJ5OfjeidGUYRYrykIciUOdCYoaKuMdFjzGmww/oEERDgrzCA72jXqOaIOpV1206KI5Pp8VIlZPjb/wstXRf+WjG1tCY6MWvieBUSmN0vOfWT8o1NN7BkRhFLDUFebvXH/XJw15CTiYlbcrndSGyrKCIF/041HDWOqnOpNOaISWsREQnVHg2CfMRh6BSRonz4UBjNfFdwMdq31ztm+xT138b75VR6hZ5wR47DyKMyr4iMkWhWib7wu5QbFuqLwwEP0I5MVWWQe4AzY6bfc9UdFimQHFS+BJwxnHw9WPS2B+r0arJuLA8Ho4JO5yiZYtdCA+gaMW3uR1+9Ip7fMaqOj6Fi1FZoEyORvCcvT/mgF6ddEQ9SD1caOX5y/DijYPgPJSJequpRj03vOflujM6g8GRrHodtQ5T4FnIucF/2aIXLBui4rqgOc7JytVgzFgFkQvhqWbDITsKzm7O9p6c+JxVVHcFPmGbTh5cATIYxMMUEo29j/mcelqpyICLhsaWpxEiL+240cxrf6xJFCRTLwW1/TrMNyXt8j7KQ0Y5AK4Y1NsO+oypjfrF+yuOJAEX0rDcb6G1HjgfJu15U7t3VN3FGRZ3bNYji4YASJnJ8YpnW3017t8EyW+J6Gkg27dN9vffsQZa7EckGBkJMwBgQJ85jjI1p8W6RxG5jLx7TC1q8zCejEjBUheot+05RwhV/ZWZHj9d2N4wehlSQNtiaHrjTGWujvfoROPvBO0CIBhheTrYjqWlHD3BtoZg9BEeP90SwHZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(52536014)(8936002)(5660300002)(54906003)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(86362001)(41300700001)(6916009)(316002)(71200400001)(186003)(38070700005)(26005)(9686003)(7696005)(6506007)(2906002)(53546011)(122000001)(38100700002)(55016003)(33656002)(83380400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZThwS0xWeWdPWDRnem1adjMzYVFZbzhaRjJ5NDZMSTNVMjVpamNNWE1kZTRK?=
 =?utf-8?B?VHVHVEJZbXlHMVl0QzlqeFBNblhvUTdpbHJwTTFnQWZFSmNJUHpiQmE2a0Ux?=
 =?utf-8?B?WWtuSFVsUVdUOGJmSy9Gc2pLaDlMMENOYk9qNEplVFBzS2JlWEgzUnJEVEtR?=
 =?utf-8?B?Ymwyb2ltdzB3NHRpTTVBTEMzTDZRLzZiMFlCdGU5bzVaZnNHSVhyVklZaWZv?=
 =?utf-8?B?RUt2djUvYlAybEZ3Ti8xU0t5V2licXlWZEk1ZUd5QTVmQWJSSk0ra1prbjha?=
 =?utf-8?B?OFJZSUJHN08zUkN5MjlLbTUvYVl3R095a3N3QThvblY1bGNCdkZBOXR0QWQy?=
 =?utf-8?B?N2MxbEp4aE9yVXpGVUUzS2VDVTZRL1VPaHh4bnpnN0JpL3d1N1Nrb294RGtv?=
 =?utf-8?B?Y04yOTJzdldwYkN6LzI4aWNGd0ZRdXpSQThETmQ1RkR3cm5OSnRBZDBpYWQz?=
 =?utf-8?B?dE45NGRVVXhBY2ZVRGs3UEpVS2M2OEVFK21oZTA1UkFFd1NKaVcwNTJKdnNP?=
 =?utf-8?B?Vkdmck9tRzV1S21zU1JZeWRoOVQyMFNwNW9hMVBIL3Y2YTJhVDNqQ3p0MENp?=
 =?utf-8?B?OGFwWjlWRXJveDdvZzE3eWlYS3R6OS93cjFmSzJ2REw5MnZ2ajJab2VZbkpP?=
 =?utf-8?B?eGUrRXU4VzVZVXliYlNjR2lRZ3BKanVCN29PdURORjRhTWFnWS9VaEFCNm1r?=
 =?utf-8?B?VXRtWHBYKzI2YkpSazkycGFaRXdHM0tnZm5BKzFLLzc2RkNLTlY5dlhMbnVq?=
 =?utf-8?B?eStVcjJBWjRvRHBIMS9QYk5XVDc3WlNCZGxNNmI4Q0hVbm5Za0xKK09ZWjRY?=
 =?utf-8?B?OUpMTlVqNWl4ZUFSaVIvYldKdm9JU0ZnMFV6UUtMU2lTT21EVjJtdFN5TzBH?=
 =?utf-8?B?S0FpbDY1dnA3aHIwMFZxRG5tYnJLOWRQSWJMdm9CL041bTRSbVRtR2tnV0RF?=
 =?utf-8?B?SUhGb29FTTM4VC9Wa3J2b3FOdnl2N3J2Z1lIU3c1WXNTZ3U1bXBNOHRmMFJl?=
 =?utf-8?B?RWZRQ1c3d2N3SUZwWUFDQ2xYbW8vM291WWR3NWt6Q2tPSHNPclZaNldQOTJh?=
 =?utf-8?B?eDhabEpIZTNmaE5EYmlEcjBuR1dib0RUM1FHdmNycWFiL1hXUHlTQUJvOG1v?=
 =?utf-8?B?U1J0czhxU3MxSGhYMUxaRnNCL0JBM3RlVUZCMXhMUjhPQXB3TEQ5Mkg1aWt5?=
 =?utf-8?B?WXEySEtiV0M5d1pNZHBidEFUTldXNE5jMjZmR2ZXUWh1TWhhaWYvZTFXanFm?=
 =?utf-8?B?Qml4cTkrc0p6UWlFekwyV1dlckMwTjV1ZXpaMEhrMFUvQVczclpyQTBkVC9v?=
 =?utf-8?B?eldSRUl5MU04V2pvVGpkNlJoMWlPUnh6alhjMi9qUEZGT1ZOVVJyWitlNkhj?=
 =?utf-8?B?dURnN2U1T0VpN0RJV1AraEFxdy9iekhwYTlRdWtUVTZSZUEyQWt5ZFY3Y3cy?=
 =?utf-8?B?UjAwR0hnV3N5UlgyYVUxTFE3T2FYbE9BSmxKVkNsUEJESW9SMWZBMldWT25F?=
 =?utf-8?B?M3FTV3ovdUxMOXJnWlVocHZ6UGZqSEptQndOUmxVd3p1bDY5WllJOWE1bXlX?=
 =?utf-8?B?cURiVFNPNU9OTXM5ZC9ZWlJiNWFFRTBYVEQ1dXNjUmtlNDY3cmNjRHF6bEZl?=
 =?utf-8?B?ZWJPVlJpV1JOSVIvczd0SFZGdzJ0YnB6Ulc5bHFQVlVFZm15RnJTeDdjU1l0?=
 =?utf-8?B?Rzl3MHAvRE9sOHFiWlBITDdOMUYzN0h0aWZmZEE4ZXFIWHY2RG41RnUxSVBG?=
 =?utf-8?B?NXlBdGtCN29hODlhdXRvSzFOS1Nlb1kzd3RGa3hjMEJWVVlwWXhxSHYyUnF4?=
 =?utf-8?B?cDZHTW5QOG1ocjg1T1p0WktQU05IQkZHSG1CVW1BcDJrMmYzMVFGTmRoelpK?=
 =?utf-8?B?RU5JWVc2K0F2TDZBclpmWnErc1BJNVM0d0dJOWE4WlRrNEtQY3RFb3BNcTFB?=
 =?utf-8?B?SUpuNW9TcXdNclpkVFhQUlZJcmRmOGcveE1nUzMyK1RUY2lzMkJLeVhJVG5h?=
 =?utf-8?B?c0NVMFBwQU5iU1lFK0ZhbmRVbWtOT0VXZGZGM0doVkg0WUVLd05xdWtKYUlu?=
 =?utf-8?B?NU04QlE3RUxaRTd2SVBXd1V5aEZvTzN6MVdVRjNPYTdrTGt5R04wK0ttMHph?=
 =?utf-8?Q?iq9Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f5dbf4-3f57-415b-430d-08da5ea93d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 17:10:19.5574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhvgAaWGjmSOZI9tPyhvT4hEpOQhQvsqUxfZ+BfwJRSoLZ196WokAF1RZsWwkDDUY1FCX6Zu5MCnd2vdRhuMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBU
b3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXks
IEp1bHkgNSwgMjAyMiAxMTo0MA0KPiBUbzogVG9yIFZpYyA8dG9ydmljOUBtYWlsYm94Lm9yZz4N
Cj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHBsYXRmb3JtLWRyaXZlci14ODZA
dmdlci5rZXJuZWwub3JnOw0KPiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsg
SmFuaSBOaWt1bGENCj4gPGphbmkubmlrdWxhQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtS
ZWdyZXNzaW9uP10gTGludXggNS4xOS1yYzUgZ2V0cyBzdHVjayBvbiBib290LCBub3QgcmM0DQo+
IA0KPiBPbiBUdWUsIEp1bCA1LCAyMDIyIGF0IDY6NTAgQU0gPHRvcnZpYzlAbWFpbGJveC5vcmc+
IHdyb3RlOg0KPiA+DQo+ID4gTGludXggNS4xOS1yYzUgZG9lcyBub3QgYm9vdCBvbiBteSBLYWJ5
IExha2UgVGhpbmtwYWQuDQo+ID4gcmMzIGFuZCByYzQgd2VyZSBzdGlsbCBmaW5lLCBzbyBJIGd1
ZXNzIHNvbWV0aGluZyBiZXR3ZWVuIHJjNCBhbmQgcmM1DQo+ID4gaW50cm9kdWNlZCBhIHJlZ3Jl
c3Npb24uDQo+IA0KPiBTb3VuZHMgdGhhdCB3YXkuDQo+IA0KPiA+IFVuZm9ydHVuYXRlbHksIHRo
ZXJlIGFyZSBubyBlcnJvcnMgb3Igd2FybmluZyBtZXNzYWdlcy4NCj4gPiBJdCBnZXRzIHN0dWNr
IHF1aXRlIGVhcmx5IG9uIGJvb3QsIGFib3V0IHRoZSB0aW1lIFVTQiBpcyBpbml0aWFsaXplZCwN
Cj4gPiBzbyBsZXNzIHRoYW4gMSBzZWNvbmQgaW50byBwb3N0LWJvb3Rsb2FkZXIgYm9vdC4NCj4g
PiBJdCB0aGVuIGp1c3Qgc2l0cyB0aGVyZSBkb2luZyBub3RoaW5nIC0gU3lzUnEgc3RpbGwgd29y
a3MgdGhvdWdoLg0KPiANCj4gVGhlcmUgYXJlbid0IGFsbCB0aGF0IG1hbnkgY2hhbmdlcyBpbiBy
YzUsIGFuZCB5b3VyIGhhcmR3YXJlIGxvb2tzDQo+ICp2ZXJ5KiBzdGFuZGFyZCAoYWxsIGludGVs
IGNoaXBzZXQsIGFuZCBhIFNhbXN1bmcgU005NjEgU1NEKS4NCj4gDQo+IEFuZCB3aXRoIHRoZSBs
YWNrIG9mIGRldGFpbHMsIHdlJ2xsIGVpdGhlciBuZWVkIGEgYmlzZWN0Og0KPiANCj4gPiBJIGRv
bid0IGhhdmUgdGltZSBmb3IgYSBiaXNlY3QsIGJ1dCBJIHRob3VnaHQgSSdsbCBsZXQgeW91IGtu
b3cgYWJvdXQNCj4gPiB0aGlzIGlzc3VlLCBhbmQgbWF5YmUgc29tZW9uZSBhbHJlYWR5IGhhcyBh
biBpZGVhLg0KPiANCj4gb3Igd2UnbGwgbmVlZCBtb3JlIHJlcG9ydHMuLg0KPiANCj4gPiBTb21l
IHN5c3RlbSBpbmZvcm1hdGlvbiBiZWxvdy4gUm9vdCBmaWxlc3lzdGVtIGlzIGYyZnMuDQo+IA0K
PiBPaywgZjJmcyBpcyBjZXJ0YWlubHkgdW51c3VhbCwgYnV0IHRoZXJlIGFyZSBubyBmMmZzIGNo
YW5nZXMgaW4gcmM1Lg0KPiANCj4gVGhlcmUncyBzb21lIFBNIGNoYW5nZXMgZm9yIGk5MTUgKCJk
cm0vaTkxNS9kZ2Z4OiBEaXNhYmxlIGQzY29sZCBhdA0KPiBnZnggcm9vdCBwb3J0IikgYW5kIGEg
Y291cGxlIG9mIHRoaW5rcGFkLWFjcGkgcGxhdGZvcm0gZHJpdmVyIHVwZGF0ZXMsDQo+IHNvIEkn
bSBhZGRpbmcgYSBmZXcgcmFuZG9tIHBlb3BsZSB0byB0aGUgY2MgaW4gY2FzZSBzb21lYm9keSBn
b2VzDQo+ICJhaGguLi4iDQo+IA0KDQpJZiBhIGJpc2VjdCBpc24ndCBwb3NzaWJsZSBmb3IgeW91
IHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIHNob3VsZCBiZSBwcmV0dHkNCmhlbHBmdWwgdG8gaXNv
bGF0ZSB3aGljaCBhcmVhIHRoZSBwcm9ibGVtIGlzIGludHJvZHVjZWQuDQpJJ2Qgc2F5IHN0YXJ0
IG91dCB3aXRoICJub21vZGVzZXQiIG9uIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIHRvIHByZXZl
bnQNCmk5MTUgZnJvbSBsb2FkaW5nLiAgSWYgdGhhdCBmaXhlcyBpdCwgaG9wZWZ1bGx5IGl0J3Mg
YSBzbWFsbCBudW1iZXIgb2YgY29tbWl0cw0KdG8gcGVlbCBiYWNrIGxpa2UgdGhlIG9uZSBMaW51
cyBtZW50aW9uZWQuDQoNCkZvciB0aGlua3BhZF9hY3BpIHlvdSBjYW4gdHJ5IG1vZHByb2JlLmJs
YWNrbGlzdD10aGlua3BhZF9hY3BpLg0KDQo+IEJ1dCBvdGhlcndpc2UgSSB0aGluayB3ZSdsbCBq
dXN0IG5lZWQgbW9yZSByZXBvcnRzIG9yIGluZm8gdG8gZXZlbg0KPiBzdGFydCBndWVzc2luZy4N
Cj4gDQo+ICAgICAgICAgICAgICAgTGludXMNCg==
