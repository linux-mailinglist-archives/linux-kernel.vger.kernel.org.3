Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F85522C82
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbiEKGoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242272AbiEKGo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:44:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B9A1F8C4E;
        Tue, 10 May 2022 23:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652251466; x=1683787466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uO30vbp2b+H7Bx1jE3CaAUFanu3s8idYsvDvc2QHHpQ=;
  b=Z3am/+qRs50zzY5Rz7TUBhc5TXsiloRhEJKdA1b//S31FVVs6s/Ot59j
   E4MFiuPjrZXc+wg4xD2SQ98h6UnfiFNtpIDejzkLRBxOdU9gGcrIKmeVc
   OCF/IJbWyE1Vzhk2ckCMUY8boLBSoA6PiYSXVo3iRWpPieYbqMHgNZ8Zu
   ldMNY45bk+ltLOtfbQD9lqj36k0G3vFecl1HFZb2V0vNikIOeY9vfNV1a
   FYFCqg3+VOyW3uE+niPnn5FHLv5tM0rVBh3OSLAAahMB/AC+yUh50Hvxe
   XVkkOZ3CD44Yut7pO13RSxNKguwopNEqk42Vv9IzJSgVCYHAfmhHVbKJL
   w==;
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="172847395"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2022 23:44:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 10 May 2022 23:44:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 10 May 2022 23:44:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBbWVdNsKJKiXe5Y5828mTLM/GuXEVe+/jBf/GTCh/iKcM5P5MtTaqA8h5O1iZOhUcaNFP81xIUX0fvO0jFADSjIvhKJLyMv57qH39/WScJG94hi6F5Wdip+2yZFLJpMuqTJScRaMNsEGNpkql92u7otJs2H1ViYFPiuj+Oo8SqWw8tnq/97MnuVVhxfLgYlS/nQMOzsUNHroc82jxKYRIfdhs2CK9dlzGInphd+yIiY8jiW4UqikC3njNBVQ607XE/KFSnTXKTVYkS8CLPXwh5UrTo1mNfK00g/JuYbHLG5YGBig1v5gRWSWDcmG8DLIL3vVPNTDhfQpos+nEDW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uO30vbp2b+H7Bx1jE3CaAUFanu3s8idYsvDvc2QHHpQ=;
 b=H8xghtvWjv9hxh6kQb3zN1TPseBOFBa7sc5XDnOzs25vdxSW6X8nD2RA6tmuaZQPRbjBhoD5Yg6GAjFgMf4m9BeeNZL4F60o++Zw/qUSbO6Ab+Dr25pTtMTRRjbTGOvC27vXXnala7ZbqHrZZNHWnKVtvitMh+wfL+NK40bvIXekO5hEpGO7iQBWLGngtSG0IA5vtJesyu0LT/5Vpf0OumAhkdZjksrmKzKk3JuRhr4J3qJPOC6kX47kKHrUOAX1RefVL3iy+cQv3QowcBndTmiQf+xpZa9xIOMZuxp/jGu1Mb093odnDtkXewlHvOd+GLoyBimUJqJ/LZN8UxaH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO30vbp2b+H7Bx1jE3CaAUFanu3s8idYsvDvc2QHHpQ=;
 b=CoNXPu7gI8+zLZuF+KBV/9gUzoybHhvfOtfnjkBQm88WTUJ9qAzGj2B5QNH7EWI0lAFHsgg2vxyG9/jC+2NSbs6K0A3wVQ9g5Z6Ul9ycrSNf/dCslqK+AFOxLnevjYwXYWxQlY2sv8n4lKxhkgn5czdZshVTdwuo0bYK87FvFN4=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by BN8PR11MB3586.namprd11.prod.outlook.com (2603:10b6:408:84::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 06:44:22 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 06:44:22 +0000
From:   <Conor.Dooley@microchip.com>
To:     <hch@lst.de>
CC:     <sfr@canb.auug.org.au>, <linux-next@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: linux-next: Tree for May 3
Thread-Topic: linux-next: Tree for May 3
Thread-Index: AQHYX5FrH/BqiZa6/06OwkWdFdBwha0Wk2YAgAAKyQCAAAevAIABXEcAgAE9tgCAAAeAgA==
Date:   Wed, 11 May 2022 06:44:22 +0000
Message-ID: <102578f2-5c10-e9c2-c1ef-e76ba90d011e@microchip.com>
References: <20220503172926.08215c77@canb.auug.org.au>
 <3f94c9a8-c927-5cc0-7d67-4b21c3d9dbaf@microchip.com>
 <9a424be9-380f-f99c-4126-25a00eba0271@microchip.com>
 <20220509141122.GA14555@lst.de>
 <dd946220-eaf6-773a-06b4-307cda466c9c@microchip.com>
 <505d41d1-1bc8-c8bc-5ebb-8a2b7934f3de@microchip.com>
 <20220511062232.GA32524@lst.de>
In-Reply-To: <20220511062232.GA32524@lst.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ffb0e57-3906-43c4-2804-08da3319aedd
x-ms-traffictypediagnostic: BN8PR11MB3586:EE_
x-microsoft-antispam-prvs: <BN8PR11MB3586E0449D7CBC4ECB83CC1398C89@BN8PR11MB3586.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K+w4c0HRQ9LSTCIDlphbni5bGi03dZDH9v1AoPUqcr6Blo9Fwzk3kwYu2AI+QSX1XRT9lX3op+8L5xmiOM1LsR/Ce7v6KJz4M6WVOEO8DmAQL3X89GN8CGbNnMQt3xwW5lfEW4C1pKhx+v8ifwd5/mwqJxixsWS/RZh12XXh4q/sNP90vXzZC7i/uEiLOwX/Kx07bzIzyCmp3nKkfFmpDzin/8Vz0L7sIe6RaoGEy7hV0Yare6DtKU9cz9OSrYMZviMWr0H6FKANOsLSWXJXG8SzP40JHsqD/YBT4bYWf5SjzEF2MAVz6S2gzS9YxHBN5Vu8IUdBNyIdKCJdzQN7ZiiknbuiRc+3+W2Yk+p8pCfBptuhWYkommfr+3/Zibx7sXqJfhRd093ojlmyR+R5VuPd2e45d9IfhnH6eX392H4iUbP6sbJS32MWzyz4i6EcapzyhTePmP5CT5qq5geuVtNO7w2t98aYJLG4XzWUfaKJVA69TnNcDm5b0+yEblCEWKvK4+rOMNfvQPY4s39gVfP0EM2HZP0MwjKcrwhGsYRKle35kAsAU57RSqRG1xiBZ+k9c65U0ZYrD2JagDmRQ/fB3QLi99t4M5O+ZA3ljdIuClqjn//agF/44m3g0BXfPMA3zJKb/0XaZnv9PAZUYlXxVAs6IEe4KRLVbn2ktsOaN3oXyjDJe4nX32Q7LsPmxJOmsSBcBAR0QC7uQASAZ3+RQR8XHAZ0G5Ax+SsD718tknhucM4qHf6Y/jbayJaPmX0s2DpEp2yva+K5aJO22Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(122000001)(38100700002)(91956017)(53546011)(5660300002)(36756003)(31686004)(6506007)(83380400001)(38070700005)(8936002)(26005)(66446008)(316002)(66476007)(6512007)(508600001)(6486002)(64756008)(66556008)(66946007)(76116006)(54906003)(8676002)(4326008)(31696002)(71200400001)(6916009)(2906002)(186003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUVKTFJ5aTJPd2QvQ0xDclFtMmVxbStPeGJLNHQvbWFORFRmeGdpY2J3aUZK?=
 =?utf-8?B?MHZCYXZUUU9hMnJ1YnFDSU5UbitORnVPUlphaFJpcEp3UHdmV2ZmV013eXhU?=
 =?utf-8?B?aHRDVGp4UWRUdmI4cm5vbFQ0SXpFL29ieFhzVHRMclE3Q2d3RlpiRS9EMmo3?=
 =?utf-8?B?RFVOa2t5LzdjdEJPVHVXbEwzeXVBZWFSME1xLzE4TFFRZ0QySks0UWY5UHZx?=
 =?utf-8?B?TmcxT011ei9iUmJqY0NHc3lEUkVSV2IwbGtJS3N2R2gxeTR3cmVvcUVJM3M1?=
 =?utf-8?B?K215NW95ZmZqVDYvdHdIYXlKWEtpRmMwVURhek1uRERHbzNXNk5KajlyTmRh?=
 =?utf-8?B?TERNbmFRclN0VXBQWWxmODZaNlJvUXk4SU1EVWV3R1FmcEJMSUhlKzBNRERV?=
 =?utf-8?B?SkswZ09zRGN1MnlBcFZxSzdCendpRVNMd1ZNalYwMVFmWmVCZHdmWmczbXpr?=
 =?utf-8?B?US92d25QUDBkTUNzbEpIaWlxd08xMFZ1T0IzT1hYN0R3d0tITFZ3SGtnUVoy?=
 =?utf-8?B?RFFMQVVyOXIxS3hnemRMRDFQbmVIaXZLRTlxeThqQWNPZ2h4SEZOUTdvaFQx?=
 =?utf-8?B?Y2REMGdiVndmMHpYZTMwRUhta1p4L3JuZUo0YUkyd2o2eFdTYkh2bkdyNGNB?=
 =?utf-8?B?NG4yeE1uaVBrUXdIbjJpeG42d1ViRm4rUWRQa1lWMWhrYnVxNGFmWmxacjJJ?=
 =?utf-8?B?VkROM204WUpUSm9rWGlpSTVyRHgvMFBMb0hnaGlieXZ0SUtkTnlaeWRGU1p6?=
 =?utf-8?B?bThzd1hzcEJCcVpqN2ozTmRLM3lwN2tLVkp6TERNekJCNGVka2xtTEQ1NitP?=
 =?utf-8?B?MlJwTmJGcUZzanU4SkIxYWdTemRWeUdOS2Q2Y3k4TEtVZitXQjdtNmRJRXhh?=
 =?utf-8?B?aXpMdmJiWUt5NzRFaDJBbFpUVkwrTzNMVmIreDFNSHN6R2dPcEUrNGFqYTdB?=
 =?utf-8?B?M3lYeTk4MzdJWDJZbmViU3o3QzhORFA5cGI2TGhGL2hwekpxbCtTcXBUdmhT?=
 =?utf-8?B?aGlYMThpTVFFYXhwOGxiWHZVc1VqQVJmbTBPN2FCQTBzNzdlTGp0bVNpc1p2?=
 =?utf-8?B?Q0JtVUtJQm16WlF6R1QxK3F6bjE4NVpZU3BwUDJzR3lGUDgzY2hHWlZwa0xr?=
 =?utf-8?B?aHRyOFBiTXdOVE9HRHRvY21UbVcxbWxMbnhRWmtIY0Q4eDd3MWpGcXZXWXFH?=
 =?utf-8?B?dE1uQmw0cC9wUDI3YzRGdkJuYi9INzlSWU5sVVZCMWxhYmZwa0J1UjhUQXVn?=
 =?utf-8?B?QzU5cElEUUVrVE0rS0lxWUdzNXMvNG1ZV245TjViTzFoemNxTTRkYUVsN04v?=
 =?utf-8?B?dytNbWFvQkFJbUwyalhVTFAxc0NYUWV4N0ZCdWl0Q0ptSVhWVlFyUFhIOGF5?=
 =?utf-8?B?Q1Fvc01YMjJ2VGtiOGx3VFRYVlF4VWs4dngzWW1YK2RyMllMMTM0RG1MUCs4?=
 =?utf-8?B?NVhaMndwR25mbnpGZGEza1ZyZ3hoOUhxSjhRRHRPV0VUaCtGNm01aTRxVUkv?=
 =?utf-8?B?NktwQ2JKalZSeXN5ZXpKM1laQWNnbmU2dnJPdmI4Y1g3WEc3Vi9XbXZnSloz?=
 =?utf-8?B?bFhDU1l6dHVlQzVGR3VWckxjb2hrWURoaTlWcjBqUU9yUkxpTm9ZUzdmYUNT?=
 =?utf-8?B?TENKL1hleTlHTERZUmR6Q1pFUGVkNmpVSS84d3N1WW56SExmblhNRXJUOWoz?=
 =?utf-8?B?NUxzZFAraThZTTIvM2xaVmpxN2RXeVZ5ZSsrQ0NOZ3p2VGpybHVLZm00SGhT?=
 =?utf-8?B?alA1eGlldjU2Ym5LUGZzVFg5L003NExDYWJsVm1NalFoSHFyK0w1Vkp5Z240?=
 =?utf-8?B?MjNUc0JYdnh5UGtqTE53cmhIUlo2ajlVaVBPc253MjNZTEVuMnY0QWh6K1JP?=
 =?utf-8?B?QTJFVEFoSGdsczZzMW5DYi9TYTBHZ3JGalpZaW93dDBhN2JtR1ZRbHhubXJw?=
 =?utf-8?B?QWY2OHZQV2d5RE4vcHdldE9aSS96OW5aRURCN1VrNVpiYnJ4dWk3NUpmb1hw?=
 =?utf-8?B?Tnl5aCtmbUd4VGVoSmFqeEhDQXBSQVRKNU1pbUY4VzRSWWhGQWhlY0lJamNU?=
 =?utf-8?B?bU1tYVdBYmxzTWwzUitIZWlEVDJtL3IvK2NENG9XMUsrR3BRQXVwVWIxeENQ?=
 =?utf-8?B?WGRYTzFQeW5pKzY0ZzZLeWMrYkI4bTlQSFJ4RUUra0VWcHB3YndkTXhtU2Yx?=
 =?utf-8?B?SmltaVNzWlhzVjBkVVBQRXRkdk5RRDZ0OFJ4aE94dHRqNUg3QThYMldrRDZS?=
 =?utf-8?B?eHpPdXloeVA0WGVyRzAwTk5KWWtrZDlQa0ZVbFlJYmUwaldDTEJHT3lLS0t1?=
 =?utf-8?B?K0MxRWZZdTZwWlVqTTRQb1FFTzNMbzFwTmhEZy90Ump1WlE4NlpIUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7ECA896C9233140AD101A64069772C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffb0e57-3906-43c4-2804-08da3319aedd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 06:44:22.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kt9fj7aIONxclP5ac0a0OrMcZp8zCenlELhPrYEn2UTCrkkGw6T/3c6P6avoGgZthMA+UsTkWSJKhoIV3bAnsq2cz+4ssS/hJwV4JlR2Z/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3586
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDUvMjAyMiAwNzoyMiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQ2FuIHlvdSB0cnkgdGhpcyBwYXRjaD8N
Cg0KSGV5IENocmlzdG9waCwgZ2F2ZSBpdCBhIHRyeSBidXQgbmZvcnR1bmF0ZWx5LCBubyBqb3kh
DQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9kbWEvc3dpb3Rs
Yi5jIGIva2VybmVsL2RtYS9zd2lvdGxiLmMNCj4gaW5kZXggZTJlZjA4NjRlYjFlNS4uODU2MTc5
ZjI3ZjYwOCAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2RtYS9zd2lvdGxiLmMNCj4gKysrIGIva2Vy
bmVsL2RtYS9zd2lvdGxiLmMNCj4gQEAgLTIzNCw3ICsyMzQsNyBAQCB2b2lkIF9faW5pdCBzd2lv
dGxiX2luaXRfcmVtYXAoYm9vbCBhZGRyZXNzaW5nX2xpbWl0LCB1bnNpZ25lZCBpbnQgZmxhZ3Ms
DQo+ICAgew0KPiAgICAgICAgICBzdHJ1Y3QgaW9fdGxiX21lbSAqbWVtID0gJmlvX3RsYl9kZWZh
dWx0X21lbTsNCj4gICAgICAgICAgdW5zaWduZWQgbG9uZyBuc2xhYnMgPSBkZWZhdWx0X25zbGFi
czsNCj4gLSAgICAgICBzaXplX3QgYWxsb2Nfc2l6ZSA9IFBBR0VfQUxJR04oYXJyYXlfc2l6ZShz
aXplb2YoKm1lbS0+c2xvdHMpLCBuc2xhYnMpKTsNCj4gKyAgICAgICBzaXplX3QgYWxsb2Nfc2l6
ZTsNCj4gICAgICAgICAgc2l6ZV90IGJ5dGVzOw0KPiAgICAgICAgICB2b2lkICp0bGI7DQo+IA0K
PiBAQCAtMjY3LDEyICsyNjcsMTMgQEAgdm9pZCBfX2luaXQgc3dpb3RsYl9pbml0X3JlbWFwKGJv
b2wgYWRkcmVzc2luZ19saW1pdCwgdW5zaWduZWQgaW50IGZsYWdzLA0KPiAgICAgICAgICAgICAg
ICAgIGdvdG8gcmV0cnk7DQo+ICAgICAgICAgIH0NCj4gDQo+ICsgICAgICAgYWxsb2Nfc2l6ZSA9
IFBBR0VfQUxJR04oYXJyYXlfc2l6ZShzaXplb2YoKm1lbS0+c2xvdHMpLCBuc2xhYnMpKTsNCj4g
ICAgICAgICAgbWVtLT5zbG90cyA9IG1lbWJsb2NrX2FsbG9jKGFsbG9jX3NpemUsIFBBR0VfU0la
RSk7DQo+ICAgICAgICAgIGlmICghbWVtLT5zbG90cykNCj4gICAgICAgICAgICAgICAgICBwYW5p
YygiJXM6IEZhaWxlZCB0byBhbGxvY2F0ZSAlenUgYnl0ZXMgYWxpZ249MHglbHhcbiIsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGFsbG9jX3NpemUsIFBBR0VfU0laRSk7DQo+
IA0KPiAtICAgICAgIHN3aW90bGJfaW5pdF9pb190bGJfbWVtKG1lbSwgX19wYSh0bGIpLCBkZWZh
dWx0X25zbGFicywgZmFsc2UpOw0KPiArICAgICAgIHN3aW90bGJfaW5pdF9pb190bGJfbWVtKG1l
bSwgX19wYSh0bGIpLCBuc2xhYnMsIGZhbHNlKTsNCj4gICAgICAgICAgbWVtLT5mb3JjZV9ib3Vu
Y2UgPSBmbGFncyAmIFNXSU9UTEJfRk9SQ0U7DQo+IA0KPiAgICAgICAgICBpZiAoZmxhZ3MgJiBT
V0lPVExCX1ZFUkJPU0UpDQoNCg==
