Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4807D5009F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbiDNJfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241821AbiDNJfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:35:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9070F46
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649928768; x=1681464768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FsFjvSxb9i9zy5TskREfGL1HZqtwG+QoArXATBXUT5o=;
  b=UngRvt0XcViq/wroDoKLSd9/AM8+E8Pq/+iTwiin+j/OkKXmSETq7BHH
   0NcLc7WOwIALNpBM2L+eKUtvc18cM+4hXtBARqZXtGXdAWEHSWkNHrP2K
   nyXbfho7yImocAgG0nZ07JEcRrURb5cxlrZTr98pN8TLJgGuT+xNfC95d
   c4zeCPeaIXC34yTJZriiGOMJWY57cg8VCNiwzIGfC9LOU/iMTN1Vc4nvN
   J5TZYaEbx160GgJec8aFP35rOknAHnbrQChjpV4jEEcIE/Am5iJBf9kNv
   OpG7DpZ35sijczw01KpqUG7ZTJoJn15Qw6f5dTZEfJ/V30/3Nkjig7dJT
   g==;
X-IronPort-AV: E=Sophos;i="5.90,259,1643698800"; 
   d="scan'208";a="152627948"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Apr 2022 02:32:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Apr 2022 02:32:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 14 Apr 2022 02:32:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS5xYP8sWmakkJxfc8oxirUa5vohsWPNrXETSdVSr8aETin5FOLGTzAylfTp4HolTLbHKWMg1y+u6EQwe53jkCPmCnkqOQdwTQto4Tu3j2xC4aUYqqyII6fLVwnp29gaJ3uzkxR9fz5zpuvBgXCCKrfMN/ujgQQqJzONDR89TaiamwJOyd6qcfGFrHWgl9kK1ZI38CP6Euksg9gcEZCzvjuHJuWxgauDFbl+KM8cvu36/msmROBxsv2f3ucsxGQ6jz6vECdHm0ujfQcwVApG8nimQbtaHHlqtHAZwEmMF8BlhGDNnZH/owVSZigS/i9NJeqCD3uDDyPvImwQNBGG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsFjvSxb9i9zy5TskREfGL1HZqtwG+QoArXATBXUT5o=;
 b=QNl5jivRXlEEDpurd/LyRu2MWdfJekwXYNB5QWJAf25T4NkRZoW6FCM7TOfYbGWxd9PC8wp+r0Un6AF4ltxxp6/QUac2YLKDV1fU9r53Jc/TdkZ2JoDcdefDin4X2xZxdGj4j4DbPSnLK7W7qMqMHRpXwm31Tq/P0TA89puKtXYMdvn3iqkRkTEb7EIggkzC/rC5iVeumClH9uIrC1HBouxLIfAlE92w0fowK9fcn4mfDwIcuh1shZgT0y3bsDAWhRQwlEEDiVA95w7GRqJh+E/xOTn2jTCHeD53W2WafgMmtfHLyD+T4cHdRkgxT/VWisHgB6SEHPysKuHhmIeeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsFjvSxb9i9zy5TskREfGL1HZqtwG+QoArXATBXUT5o=;
 b=EpKQb6HTVdAS0SxLqZlQ39EeyCeW4J8YNtagwAWEeK1IgDULlxmeo8G0SOk8XLrYH2WT5zIczxkprBcmklaU0GD/F0MeLv4eoX88ohSNOhsoVnrHJB29YsKHm9HfdXWK+f0jXMb4HFoxftHDZCXZkEzYCwqV/NYDRTHDxy6WAjQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN6PR11MB1553.namprd11.prod.outlook.com (2603:10b6:405:e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 09:32:35 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a%5]) with mapi id 15.20.5164.018; Thu, 14 Apr 2022
 09:32:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v3 3/3] mtd: spi-nor: Favor the BFPT-parsed
 set_4byte_addr_mode method
Thread-Topic: [PATCH v3 3/3] mtd: spi-nor: Favor the BFPT-parsed
 set_4byte_addr_mode method
Thread-Index: AQHYT+KSwGmgjWCsIUm7mcPh0nWZaQ==
Date:   Thu, 14 Apr 2022 09:32:35 +0000
Message-ID: <2c77371b-355a-5a1a-a83d-7bf40b088683@microchip.com>
References: <20220411125346.118274-1-tudor.ambarus@microchip.com>
 <20220411125346.118274-4-tudor.ambarus@microchip.com>
 <a6519a1ce39534c35760334cd69396b3@walle.cc>
In-Reply-To: <a6519a1ce39534c35760334cd69396b3@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e2a5656-a61a-40e0-1400-08da1df9b55c
x-ms-traffictypediagnostic: BN6PR11MB1553:EE_
x-microsoft-antispam-prvs: <BN6PR11MB15539B74D27149D92CFC6755F0EF9@BN6PR11MB1553.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HzcD+Gy/du3DZAcLXdccbhIUi72W8s/HdFNeFKD4BevoIqn2WxAJgafEvlzdarlZbI1IXQZNDFlpR4mfWi2+8unc44PqA6qQgqT5wTug/huDx1r4eIRf1/BdmxVljrYa5Aw148jeEb3v9QL0/fvYh0K+/HvGq6vvCRzlJoollQZKWVEBy6swHcNtaaLhS4DRpDlF8mR9aBT3g8dYSMYXK4k40/jB1ZBmDuDCus6G6fxcxWyyJYUzQjibnDR+JENLccNNq5ZS+3Eh63MSwVrhF+0Wf2S4P+7QUX8BwE20oyYd6RMR1uOk+z7hws00LtZMQobHO0q7uK/zcecngml80v3D0R4u1bOR8S8idQoh8VqnbMLFnz6TILXCs0bxwbdnh4rPpRy/JnZAeSOqIgQmjIzJDHtEmgYsjQFEGwkYsm/huUyO10ht0UBEJqnWY7ZdtFkJkrcX89Fk14L6HY8+2cFu7p4ji2GD9HyTGpRQ4Liiz4RctYcxI+fInP3RP3YSfTqnO9J68AmaLYKhk2sMIKE8cwQlPcq7FJ1+62d9AvsGJ+tqYG4fQFtA9Ev8xdug7KlsPanbxeXhV3tW7Gd1HO6HEIRs5SF+o9HY+ouFX6hoObaigFlPbirJTHRm0uIoVzGNTZq0O6HpsmB+ZOy3TS1HnoZtUtXxdSgYX2AVl6zXS/jo46PC2jhLATrgD2APBhAXE/B175XUPrmCkG7n7kTyLigHWdTAvktIlP7b312HqPw9uTaGrEXEb5eiXN9XBapPVZxajahAnu096Fszpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(91956017)(31686004)(26005)(38100700002)(38070700005)(6512007)(6506007)(122000001)(4326008)(2906002)(86362001)(36756003)(66556008)(508600001)(66446008)(76116006)(66946007)(66476007)(64756008)(71200400001)(8676002)(6486002)(107886003)(83380400001)(5660300002)(6916009)(316002)(8936002)(31696002)(2616005)(186003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VURsZVJPSTVLRmZ2NitXSnNTMEVjV21BMG9YYytZRHJhbVJ1Ty9WQVZpcDBG?=
 =?utf-8?B?cXkvREpVRm40RkNPcSt6K1E1bWFCY05KeVNDS1hlbnVIOVQ1ZjF6YVV5aVB5?=
 =?utf-8?B?bktYRGpQczRWQThGWlpZUG5FanVnSU80ME84NHBzdW1WSExTVkUvR1BuZ3Rz?=
 =?utf-8?B?ZUVsM3dSSWJjdHc1bG5XSXN5NDZ0VHFudTJKcC9kTndZZ2x4Rm1DcFJMOEhn?=
 =?utf-8?B?RDdyelVmQ2pqSHU0cWxhYy9HT1VsdWxmcVFoandJKzQvR3BIS252WEpKR0s2?=
 =?utf-8?B?M0V1ZEtzVDJvZkVzd2lUSFNBQVFZMTQwbkFUYzV6a3AweTQ2N1JTeDc4QWtO?=
 =?utf-8?B?NnlzSkpLWitjaC9VSEJHSkZwUGl5bmVoa04rWnpKVHYvOCtRWktjRXcyakhG?=
 =?utf-8?B?bFRyZDcydWV2K1RMMU5lQWhPckJyaE9RaU5IMXVycjBNRDdaZVYzVEFkTGJn?=
 =?utf-8?B?SmdseFVwWC9LTXZLTEdvM01ZNS9XZEorL3prUlNOb0x5eFlweHdrN1NxYmhv?=
 =?utf-8?B?M09IMlFRTVViZ0ZMeTRtZzRManhZOVhybnUvWlppTVJVNWNSVFFZSkhTRy9q?=
 =?utf-8?B?QTE5ZEFNRUhWRVV2RHNINlkxVFRFeTdCYkFPV2RrZWRKNkIzZFdHdmtzcytJ?=
 =?utf-8?B?TjR0a1l2UEZ5WjlobFVoVUFQbTFHR0lnSXhjNy9CYlJtZGtHb0lreERWOTQ1?=
 =?utf-8?B?ZHdjek1DaE5FVmJuOWpxWlhnMTQ0OU16NWkxSDhBOGMxaHBQNHhLbWdxZzNO?=
 =?utf-8?B?ek9HQXNzTCs3dW9GSnlQNWU2YXE3aWFRb0J4a3ExeENhaXUrZlZZWVZ2Vzhm?=
 =?utf-8?B?MDhBQlVGUk1WNmcveTM1c0NLTjB1bWdjUGJ2b2hmUFZKZVdVQzByL2phRmls?=
 =?utf-8?B?RHFWNWYvbno1WnMxL296TE4xR0g0L2hDdCttR1hoSHZhK0JtT3JxMDdscUU0?=
 =?utf-8?B?eUgycytZOE83ck9WTENlVGkwRVBEUkQrb2xwV2llU2dMZERPUVp3MUVwZWN2?=
 =?utf-8?B?TzhLK3BGcFljcWlTZVJpUFVHSXc1d25nQnV1WkVFemthbEFiaGhGcDZQK0NZ?=
 =?utf-8?B?N1lOc045Y0V4UFMrN0crNldxWVg3cGtuY3p2Tlh1NHowS1dWUmpoSGNDUlFH?=
 =?utf-8?B?NGl2aHJvcUpjeDRHU3NHbkJQaWJ3SDZheDk1TlZPbkF0RnJOcTJJaGJxWWJR?=
 =?utf-8?B?SmVGOENaR01wUFBNU3NsTTJsRTk3UmdSbVNGemhsVDRqWGl4N3B0RjlPbkR1?=
 =?utf-8?B?YWlKOE9LMU1vcW53d0tEK05WQVgyTkFvZFA4WmhENXpYRDVEUTFGVmF1WDRO?=
 =?utf-8?B?UDQvZG9WaXJSRmF2VE9VNlhsNElHc0NTdi9LMFdqRURRU0pJTjhWRXBBRDBO?=
 =?utf-8?B?Q1NDZTY4c1A5czdEVU9JWHNjSjVWQWp3KzZ1Y3JoOWVpclM4MUVMN3QwMUtW?=
 =?utf-8?B?YW9rbGhwNXNYQWwrN3prdmZuRjFWRCsxeEJrUmNnOWxJUTduajF0OWpkRDND?=
 =?utf-8?B?YTU0cFBJL0puN2Vub2RXYitoWkNReHFuM0V4RnRTd29wRFBaQVBkdlB0OHdX?=
 =?utf-8?B?ZEUxWExMeTUzYmdnZ2NaRUlDaVdGY2MzVUlaTkUydmlDYXg5VytCWWxJbTdZ?=
 =?utf-8?B?Y3Z1OE1OU0xwK2RubE1GSXNBR1d1WTBoQWlUUS9RYVVlZDFtb242OXJEOENL?=
 =?utf-8?B?NVhNOEpCTitMYStwNS9GMzVqSHdSR29vQlR4bnMzMmZjSVdObUhTWmIxWTlo?=
 =?utf-8?B?V2xkOHU2a3dTVHo5dW12dXF0OGM0Q1NIMUVqdGZkN1dsaWRzT0Z4TzlXTkQv?=
 =?utf-8?B?NkF1Y25yemR5VjNWcnRUQTZqSUxhM3JBbU1ZVDk5eWRkOFZ0TmR1THZTWEpv?=
 =?utf-8?B?V2Jtc0VPYStFYnNIVHBmRjE3YXNyWEswdXRmWEU2ZXpyd1pzZDdJOEI0dGlh?=
 =?utf-8?B?QzFzd0pEMGRtYzFvNW9LTEFnbnZuT2p1ZGJiWFdubDJidk1EWENJQVNCMDFC?=
 =?utf-8?B?aTQ2WFV5OHliUFBERFQvbjR6RW1hYkJ0MnYyU05qanpWNzZMUkY1VVdrUFFE?=
 =?utf-8?B?Z0FSaktISUI5dHlEcnpHeTNmeUhYQkk5VG9MdmE2aFM1ZEM2RDFmVndBVkxJ?=
 =?utf-8?B?d3A3VnRWanhlVjA1YzU3eDJvYkdjaGpCZk11SDk1aXhUV2J2R3l3VHhPUXN2?=
 =?utf-8?B?ZGFpQW9Xbm1SampYRFZxQmFtQVBPcyttV0RGTFBPLzRTeHNDYmNQdC8rN2pG?=
 =?utf-8?B?QUpMaW8zclVGNzBQRHVHM1dTNHJsU3lnVDFycGtuQXlNMEVMMmZtYlVIYmh5?=
 =?utf-8?B?S2lOaURiV2dMTEpoUldKK3NpMkFJV0xXZHhaSDBIK0xFNlQ3WFN5V1RuUjJB?=
 =?utf-8?Q?NjMgSbXWRCyVHr6Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <137C8303183D8949A7615824356FB541@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2a5656-a61a-40e0-1400-08da1df9b55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 09:32:35.2494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZu8Kq3HE5IskP/obDz+n1bWsll1QHZWPp48Mq4nNPIMMaa9UJyaN8vlqFyab1hoVrzA0+FjvYDOkxtyXp22gmTkAzZBQwRKc6IIr6yNQGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1553
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNC8yMiAxMjoyMSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTA0LTExIDE0OjUzLCBzY2hyaWViIFR1
ZG9yIEFtYmFydXM6DQo+PiBKRVNEMjE2IFNGRFAgZGVmaW5lcyBpbiB0aGUgQkZQVCBzdGFuZGFy
ZCBtZXRob2RzIHRvIGVudGVyIGFuZCBleGl0IHRoZQ0KPj4gNC1CeXRlIEFkZHJlc3MgTW9kZS4g
VGhlIGZsYXNoIHBhcmFtZXRlcnMgYW5kIHNldHRpbmdzIHRoYXQgYXJlDQo+PiByZXRyaWV2ZWQN
Cj4+IGZyb20gU0ZEUCBoYXZlIGhpZ2hlciBwcmVjZWRlbmNlIHRoYW4gdGhlIHN0YXRpYyBpbml0
aWFsaXplZCBvbmVzLA0KPj4gYmVjYXVzZQ0KPj4gdGhleSBzaG91bGQgYmUgbW9yZSBhY2N1cmF0
ZSBhbmQgbGVzcyBlcnJvciBwcm9uZSB0aGFuIHRob3NlDQo+PiBpbml0aWFsaXplZA0KPj4gc3Rh
dGljYWxseS4gRmF2b3IgdGhlIEJGUFQtcGFyc2VkIHNldF80Ynl0ZV9hZGRyX21vZGUgbWV0aG9k
IGFuZCB1c2UNCj4+IHRoZQ0KPj4gZ2VuZXJpYyBjb3JlIG1ldGhvZHMgd2hlcmUgcG9zc2libGUu
DQo+PiBUaGlzIHBhdGNoIG1heSBpbnRyb2R1Y2UgcmVncmVzc2lvbnMgaW4gY2FzZSBCRlBUIGNv
bnRhaW5zIHdyb25nIGRhdGEuDQo+PiBUaGUNCj4+IGZpeCBpcyB0byBpbnRyb2R1Y2UgYSBwb3N0
X2JmcHQoKSBmaXh1cCBob29rIGFuZCB1cGRhdGUgdGhlIHdyb25nIEJGUFQNCj4+IGRhdGEuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2No
aXAuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRpLmNvbT4N
Cj4+IC0tLQ0KPj4gdjM6IG5vIGNoYW5nZXMNCj4+DQo+PiDCoGRyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jwqDCoMKgwqDCoCB8wqAgNyArKysrKystDQo+PiDCoGRyaXZlcnMvbXRkL3NwaS1ub3Iv
bWFjcm9uaXguY8KgIHwgMTAgKysrKysrKystLQ0KPj4gwqBkcml2ZXJzL210ZC9zcGktbm9yL21p
Y3Jvbi1zdC5jIHzCoCA5ICsrKysrKy0tLQ0KPj4gwqAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+IGluZGV4IDRk
NDVjZGE0ZjlkMy4uODg4NTE2ZDk4ODg0IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQvc3Bp
LW5vci9jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+PiBAQCAt
MjQxNiw2ICsyNDE2LDggQEAgc3RhdGljIHZvaWQgc3BpX25vcl9pbml0X2ZpeHVwX2ZsYWdzKHN0
cnVjdA0KPj4gc3BpX25vciAqbm9yKQ0KPj4gwqAgKi8NCj4+IMKgc3RhdGljIHZvaWQgc3BpX25v
cl9sYXRlX2luaXRfcGFyYW1zKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiDCoHsNCj4+ICvCoMKg
wqDCoCBzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgKnBhcmFtcyA9IG5vci0+cGFyYW1z
Ow0KPj4gKw0KPj4gwqDCoMKgwqDCoCBpZiAobm9yLT5tYW51ZmFjdHVyZXIgJiYgbm9yLT5tYW51
ZmFjdHVyZXItPmZpeHVwcyAmJg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG5vci0+bWFudWZhY3R1
cmVyLT5maXh1cHMtPmxhdGVfaW5pdCkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5v
ci0+bWFudWZhY3R1cmVyLT5maXh1cHMtPmxhdGVfaW5pdChub3IpOw0KPj4gQEAgLTI0MjMsNiAr
MjQyNSwxMCBAQCBzdGF0aWMgdm9pZCBzcGlfbm9yX2xhdGVfaW5pdF9wYXJhbXMoc3RydWN0DQo+
PiBzcGlfbm9yICpub3IpDQo+PiDCoMKgwqDCoMKgIGlmIChub3ItPmluZm8tPmZpeHVwcyAmJiBu
b3ItPmluZm8tPmZpeHVwcy0+bGF0ZV9pbml0KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbm9yLT5pbmZvLT5maXh1cHMtPmxhdGVfaW5pdChub3IpOw0KPj4NCj4+ICvCoMKgwqDCoCAv
KiBEZWZhdWx0IG1ldGhvZCBrZXB0IGZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5LiAqLw0KPj4g
K8KgwqDCoMKgIGlmICghcGFyYW1zLT5zZXRfNGJ5dGVfYWRkcl9tb2RlKQ0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBwYXJhbXMtPnNldF80Ynl0ZV9hZGRyX21vZGUgPSBzcGlfbm9yX3Nl
dF80Ynl0ZV9hZGRyX21vZGVfYnJ3cjsNCj4gDQo+IENhbiB0aGlzIGJlIG1vdmVkIHBhc3QuLg0K
PiANCj4+ICsNCj4+IMKgwqDCoMKgwqAgc3BpX25vcl9pbml0X2ZsYWdzKG5vcik7DQo+PiDCoMKg
wqDCoMKgIHNwaV9ub3JfaW5pdF9maXh1cF9mbGFncyhub3IpOw0KPiANCj4gLi4gdGhlc2UgdHdv
IGxpbmVzLCBzbyBpdCBpcyBuZXh0IHRvIHRoZSAic2V0IGRlZmF1bHQNCj4gbG9ja2luZyBvcHMi
Pw0KPiANCg0Kc3VyZQ0KDQo+Pg0KPj4gQEAgLTI0OTAsNyArMjQ5Niw2IEBAIHN0YXRpYyB2b2lk
IHNwaV9ub3JfaW5pdF9kZWZhdWx0X3BhcmFtcyhzdHJ1Y3QNCj4+IHNwaV9ub3IgKm5vcikNCj4+
IMKgwqDCoMKgwqAgc3RydWN0IGRldmljZV9ub2RlICpucCA9IHNwaV9ub3JfZ2V0X2ZsYXNoX25v
ZGUobm9yKTsNCj4+DQo+PiDCoMKgwqDCoMKgIHBhcmFtcy0+cXVhZF9lbmFibGUgPSBzcGlfbm9y
X3NyMl9iaXQxX3F1YWRfZW5hYmxlOw0KPj4gLcKgwqDCoMKgIHBhcmFtcy0+c2V0XzRieXRlX2Fk
ZHJfbW9kZSA9IHNwaV9ub3Jfc2V0XzRieXRlX2FkZHJfbW9kZV9icndyOw0KPj4gwqDCoMKgwqDC
oCBwYXJhbXMtPm90cC5vcmcgPSAmaW5mby0+b3RwX29yZzsNCj4+DQo+PiDCoMKgwqDCoMKgIC8q
IERlZmF1bHQgdG8gMTYtYml0IFdyaXRlIFN0YXR1cyAoMDFoKSBDb21tYW5kICovDQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9tYWNyb25peC5jDQo+PiBiL2RyaXZlcnMvbXRk
L3NwaS1ub3IvbWFjcm9uaXguYw0KPj4gaW5kZXggODVlODY1NWQzNjJjLi5jMjY3Y2JjYzdmMWQg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL21hY3Jvbml4LmMNCj4+ICsrKyBi
L2RyaXZlcnMvbXRkL3NwaS1ub3IvbWFjcm9uaXguYw0KPj4gQEAgLTEwNSwxMiArMTA1LDE4IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbw0KPj4gbWFjcm9uaXhfbm9yX3BhcnRzW10g
PSB7DQo+PiDCoHN0YXRpYyB2b2lkIG1hY3Jvbml4X25vcl9kZWZhdWx0X2luaXQoc3RydWN0IHNw
aV9ub3IgKm5vcikNCj4+IMKgew0KPj4gwqDCoMKgwqDCoCBub3ItPnBhcmFtcy0+cXVhZF9lbmFi
bGUgPSBzcGlfbm9yX3NyMV9iaXQ2X3F1YWRfZW5hYmxlOw0KPj4gLcKgwqDCoMKgIG5vci0+cGFy
YW1zLT5zZXRfNGJ5dGVfYWRkcl9tb2RlID0NCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3BpX25vcl9zZXRfNGJ5dGVfYWRkcl9tb2RlX2VuNGJfZXg0YjsNCj4+ICt9DQo+PiArDQo+PiAr
c3RhdGljIHZvaWQgbWFjcm9uaXhfbm9yX2xhdGVfaW5pdChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0K
Pj4gK3sNCj4+ICvCoMKgwqDCoCBpZiAoIW5vci0+cGFyYW1zLT5zZXRfNGJ5dGVfYWRkcl9tb2Rl
KQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBub3ItPnBhcmFtcy0+c2V0XzRieXRlX2Fk
ZHJfbW9kZSA9DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
cGlfbm9yX3NldF80Ynl0ZV9hZGRyX21vZGVfZW40Yl9leDRiOw0KPiANCj4gVGhpcyBpcyBtb3Jl
IG9mIGEgZ2VuZXJhbCBxdWVzdGlvbi4gQ2FuIHdlIGhhdmUgdGhpcyBpbiBvbmUNCj4gbGluZT8g
SU1ITyB0aGlzIGxvb2tzIGF3ZnVsIGFuZCBzaW5jZSBsaW51eCBub3dhZGF5cyByZWxheGVkIHRo
ZQ0KPiA4MCBjaGFycyBydWxlIGEgYml0IGFuZCB3ZSBoYXZlIHN1Y2ggbG9uZyBuYW1lcy4uIEkg
dGhpbmsgaXQgbWFrZXMNCj4gc2Vuc2UgdG8gYWxsb3cgc29tZSBsaW5lcyB0byBiZSBsb25nZXIg
dGhhbiA4MCBjaGFycy4NCg0KSSBzdGlsbCBzcGxpdCBteSB0ZXJtaW5hbCBpbiBtdWx0aXBsZSB3
aW5kb3dzIGFuZCBwcmV0dHkgbXVjaCByZWFkDQpjb2RlIGluIGEgODAgY2hhcnMgbGltaXQuIEJ1
dCBJIHdvbid0IGFyZ3VlIHdpdGggeW91LCBpdCBzZWVtcyB5b3UNCmNhcmUgYWJvdXQgaXQsIHNv
IEknbGwgY2hhbmdlIGl0Lg0KDQo+IA0KPj4gwqB9DQo+Pg0KPj4gwqBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHNwaV9ub3JfZml4dXBzIG1hY3Jvbml4X25vcl9maXh1cHMgPSB7DQo+PiDCoMKgwqDCoMKg
IC5kZWZhdWx0X2luaXQgPSBtYWNyb25peF9ub3JfZGVmYXVsdF9pbml0LA0KPj4gK8KgwqDCoMKg
IC5sYXRlX2luaXQgPSBtYWNyb25peF9ub3JfbGF0ZV9pbml0LA0KPj4gwqB9Ow0KPj4NCj4+IMKg
Y29uc3Qgc3RydWN0IHNwaV9ub3JfbWFudWZhY3R1cmVyIHNwaV9ub3JfbWFjcm9uaXggPSB7DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KPj4gYi9kcml2
ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+PiBpbmRleCAyZDFjYmIxZjM3YzguLjllOWIx
MDdmMjAxOCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMN
Cj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4+IEBAIC00MTQsMTQg
KzQxNCwxNyBAQCBzdGF0aWMgdm9pZCBtaWNyb25fc3Rfbm9yX2RlZmF1bHRfaW5pdChzdHJ1Y3QN
Cj4+IHNwaV9ub3IgKm5vcikNCj4+IMKgwqDCoMKgwqAgbm9yLT5mbGFncyB8PSBTTk9SX0ZfSEFT
X0xPQ0s7DQo+PiDCoMKgwqDCoMKgIG5vci0+ZmxhZ3MgJj0gflNOT1JfRl9IQVNfMTZCSVRfU1I7
DQo+PiDCoMKgwqDCoMKgIG5vci0+cGFyYW1zLT5xdWFkX2VuYWJsZSA9IE5VTEw7DQo+PiAtwqDC
oMKgwqAgbm9yLT5wYXJhbXMtPnNldF80Ynl0ZV9hZGRyX21vZGUgPQ0KPj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzcGlfbm9yX3NldF80Ynl0ZV9hZGRyX21vZGVfd3Jlbl9lbjRiX2V4NGI7
DQo+PiDCoH0NCj4+DQo+PiDCoHN0YXRpYyB2b2lkIG1pY3Jvbl9zdF9ub3JfbGF0ZV9pbml0KHN0
cnVjdCBzcGlfbm9yICpub3IpDQo+PiDCoHsNCj4+ICvCoMKgwqDCoCBzdHJ1Y3Qgc3BpX25vcl9m
bGFzaF9wYXJhbWV0ZXIgKnBhcmFtcyA9IG5vci0+cGFyYW1zOw0KPj4gKw0KPj4gwqDCoMKgwqDC
oCBpZiAobm9yLT5pbmZvLT5tZnJfZmxhZ3MgJiBVU0VfRlNSKQ0KPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBub3ItPnBhcmFtcy0+cmVhZHkgPSBtaWNyb25fc3Rfbm9yX3JlYWR5Ow0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXJhbXMtPnJlYWR5ID0gbWljcm9uX3N0X25vcl9y
ZWFkeTsNCj4+ICvCoMKgwqDCoCBpZiAoIXBhcmFtcy0+c2V0XzRieXRlX2FkZHJfbW9kZSkNCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFyYW1zLT5zZXRfNGJ5dGVfYWRkcl9tb2RlID0N
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwaV9ub3Jfc2V0
XzRieXRlX2FkZHJfbW9kZV93cmVuX2VuNGJfZXg0YjsNCj4gDQo+IHNhbWUgaGVyZS4NCj4gDQoN
CnN1cmUNCg0KVGhhbmtzLA0KdGENCg0KDQo=
