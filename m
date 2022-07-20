Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4615C57B2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiGTI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGTI3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:29:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AA266AFF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658305768; x=1689841768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GF4c1Y7z6d54eq4PD+8eELx3bC3Ic3WBz2FaU4a/cD0=;
  b=sLiSxqaPHxw+7EA4Y2w/aqsR2ZfmgCTjzPRZi3LsaRF9fG9JRgAR88Wj
   G1e+FZ62U7PKZ98zHaYnWdslXone5xwaF/9p+jigbNv37jKD5Au5LMl+l
   gUq6PoSEVU4qjYQB2iQs6gwR0h4SqdLcEZ91Q7y89c14VPH0St5iK3baO
   XG8PgXaytuooVJkbc4Tl9LTBuVMHl/N30+n6hWqNCghnf9crP2NYfUICq
   VyhHYO/xOL4NIUIy0HXbYcEvjhW96GbMTiShxIRzsnvEMYjNDVAVXxRH/
   ScLIhzJfKeoMkGJ8u6zT5p19v4ZSQa2qb99+Ogg1JA1aPXi033CV47dfF
   A==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="165570665"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 01:29:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 01:29:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 20 Jul 2022 01:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2Gt2CdIJQsW4HbASzG82rITF+HFmP0PCM8Mna+QpaMwA2kHTsAhPrO4hJ1uw9NayWzYkiAl2lOP5OCciA4Vlz2VLMlMFcnYdp2qIBpuWoaUEF0j5vxg/5xEG81MKrHKKpbY+T7tGKiXn14EFctjtnilD8PJ2GjfkGxZcyBAmxXRdBZ+BoXVDnBycgEkxXtOIB9qISI4oTW7SmOfrCLR8TNeJowljOCmQb/9jSqj7lfF9MhWk/s4wgjsCY6FGHHu7Ay/+du7b8NH1wxHn+Kb0XQJvgs1eXN3VoRqqV2Rt9og/kVJ54f5TDPHVQZ0r4p18gG3KUHsBSppDsHPTFcvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF4c1Y7z6d54eq4PD+8eELx3bC3Ic3WBz2FaU4a/cD0=;
 b=XsttsbhscnLVYkYx4cCuYWeEKzTfEKpXD7VNFVTI86bHQngLCPxEZsDrab5nzGDiFJ73Pm2+q/W3J1eiWrJXihzhqfve0D3qjr+y1MuCguO6WPw3VdXkwNO4IGXZ/wBZxOrLr4e/SHtRjHGSDN3VzxhOSvAfU2iXz39L42I/K9eOQYkVPY+BlkNIJhwkMT983fHGbkLK995gjgX10ee41c7vcHeyB+HMUKDxqMe0N7SZFioGzGMblaWVtLwEUUtD/U56vLendAOW1KBF4PDEml2Gmi4ENDSfwtW9rfQ8xzoV6XWwHxwD3obYb/Unnenbwy2wxeDq7m18y0/8B8GqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF4c1Y7z6d54eq4PD+8eELx3bC3Ic3WBz2FaU4a/cD0=;
 b=DFYH5kwZvR+fRjw0HKz7dAnWGNIaYI+GJ9wPjaNdQrgqQSVDhQjK5GRPZKy7Pyt4AJzlzpswOHbMbZdwJZQTJ4sObzVjyqQCnmau7Ywt5H1mVsYS8bJXzszgvLr3uMd2ZVfNxF2IiQH5Zw5jM90hg/l1ApIIcbwoaQTF04y+M+o=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 08:29:19 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0%10]) with mapi id 15.20.5438.023; Wed, 20 Jul
 2022 08:29:18 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <clement.leger@bootlin.com>
CC:     <linux@armlinux.org.uk>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] ARM: at91: add sam_linux_is_in_normal_world()
 function
Thread-Topic: [PATCH 1/2] ARM: at91: add sam_linux_is_in_normal_world()
 function
Thread-Index: AQHYj238/VLC3Z9H60WomxAXo+ygxg==
Date:   Wed, 20 Jul 2022 08:29:18 +0000
Message-ID: <5f182f9b-9e50-657f-8a01-f98a2cec3738@microchip.com>
References: <20220606145701.185552-1-clement.leger@bootlin.com>
 <20220606145701.185552-2-clement.leger@bootlin.com>
 <fe771973-e9aa-d397-1849-41617cc2d226@microchip.com>
 <386e02d5067da8e684332c5a788326ee@bootlin.com>
In-Reply-To: <386e02d5067da8e684332c5a788326ee@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4eb35bca-bf80-4743-b0f6-08da6a29f08a
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JgVqguPA8GYauc4TZtKVGX+2pXX851O1PWxOhozH9QGm5+xwRWfX4e/mzLul2wG7TrHRds/dpfzTSOwVotpQi6dsfBWwZ1jHfDAgOYly0vORYh0/DbUP/WkOUTcDAvn/OmcLEmI30D7vTklTdOXjeeqtfZ8b4I0HhE5Y1j20KI11ErzGClhJ4Dma3tRwmFEIW4yK71lo8d5eHUvEtYiSq9flvnuaSibv0j1vJB9e/gZ/P++dHu7BKWwmKWfOU+EyYSsmThDzW7U2jwZj2Jz/8o1J/IdzMW0cTjZsgIKJgBDdw3ENrztq4MN6YU61PuQDB06v7YMFd1tras39CrFGoTEYNszQCRxPiKTPxPLY6iu9w8ss1fIjmuOqeXXMRDId5A3lsbmogep5LD+GDI90aeWYdSRn1ff+W6vIb3Fi0+2AoLqrXn2BnuSO9/WIHiTb3TjxeQlfJBQu+n7w3lsDr366esSyEovwZnXAI5GNoVLfrkko/C9pICcgJCuPeMy4kcg25lO6mtwfH3UBq0LRP5F2Vb/LeRPuneSdrCPGMjeHLWcDuaa/AHlikiQbGZBvmjFxCAe4CFQtq2ZNNkyUnUuMbHsz2REP3RRy/paTwEeq6dGkHpn522/Z2Qa0E+abHQKi4BPv78ZeOCoGiKdJoQH1ygp15fWMoxpJosY45h9H6pYfAn7vFpObjrg7jzr12xZnezCQsR87+KhvXEBr+H/h01/EHvrBJMyf7HyTA0t9gPuSDgF6TE4hMhJX9v84aNzeCq/lHAVJn2L4Og7Wv+EfjImv3K//JKvjoav9TbyNMeCckQlCRTUJuNWfd7L9+cLklQXgEZALUC5gT2ATxjXc5Q/5tNaYFgj8YJomiyM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(136003)(346002)(396003)(66476007)(66446008)(5660300002)(8676002)(8936002)(64756008)(91956017)(66946007)(66556008)(76116006)(4326008)(2906002)(38100700002)(122000001)(36756003)(31696002)(86362001)(38070700005)(71200400001)(6486002)(478600001)(6916009)(54906003)(316002)(41300700001)(186003)(83380400001)(26005)(53546011)(6506007)(2616005)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGhkYWxwRys0YjZzUFI4MGUvZDYrWUZISGdmbFlqd2F2Sko1eWgxeUI1RjBQ?=
 =?utf-8?B?WjRBdzQyOUhEMUxGWUQyMnFmM2ZLdUdPYnRXWnhaNjRaMnl3RG9QY2Q0cFQx?=
 =?utf-8?B?NkQ4U3ZaVWkwd1pKNWRSVVIyclIvUDlyRUg1U0pqaERrU2RnMzRRdTk4b3dp?=
 =?utf-8?B?UEo5RDZtTnZiMGtteThxTVpEU05HVk5tZm56NTVZR3FmeG1nOVRtSENJck5M?=
 =?utf-8?B?RzFSK3dxNDdSMmcyR0hzdUlCaXhpWEQxNmkvOVI4MGdXYlY1NTB2NGVyTC9i?=
 =?utf-8?B?ditDRnJ6WUk2QTlYb25XaFRFSnB2Ujk3L3pZRlZxdUlqenZ2QllvT2RUcTVk?=
 =?utf-8?B?S2VZVzd1MUlvbUUvdFFpdkZCY01PNEt6QTV2QTA0ckM5dUs4WEdIT0NjK0lw?=
 =?utf-8?B?OFhZQWFsbG44QmNQbkViWkZaSGVUcldsQ3poT3R5Y3JyY1FkZi9WWW5yUDRR?=
 =?utf-8?B?cHJ0ZTJGWERIMU5uU1MwY2VwaHFmR1hjeWZVTzR0TVRnQ0xmRTJFMHFOMUQw?=
 =?utf-8?B?ejZGSTNnTU1lRkxFS0xrS0xnLzhkMnc3cFhack5pTlJLSWZsK1orZlFYeVZ3?=
 =?utf-8?B?Q3phaTQ1R0dRcFlQa1ZQVU81UUZRMXN3SEZkTW13VHJCMUJZSXZYVlF0cjdQ?=
 =?utf-8?B?VUs0MjhzN011dDRXdFFWTzhqSm5US3U0UlQ1bUIvTGR6VHhKamp0THZMalIz?=
 =?utf-8?B?S3kxdjJTZkV4TWFQYVpMNFNTZFpRWW1lSTJudC9UK3VNcC9KL2lsY0VJK2dF?=
 =?utf-8?B?d3grUjJDT0N3MHhYbWhIZXRFbGRkNGlxM3cyZ2ZzdXVPdHdvSm5pMmdYSjN2?=
 =?utf-8?B?VFlXNVVlWGp3RGNkRmkxL2pRSlVTOERBWVpDdXczMVR1ZVhVNXBlV2JoVjRt?=
 =?utf-8?B?ejhzdFYrczNPUThnT0ZwMlE0amYzQVFWRmNJNGMxOENlU1VrZWdqWmtCbmVK?=
 =?utf-8?B?WDNpUVZZUjlRVzgrWnV2d3hDYk1jNnBvVWxISUlSN1JENUtYTkxoQVU1UytI?=
 =?utf-8?B?dGhGcWtvZXovR1JRQ3g5VHRlVkhyOTVaeS8zSWplY0lhZ3UyQlpiL2ljUnhI?=
 =?utf-8?B?VjlmYnVsVXRaNXYxWlNncWJPRDB6WXZRTVVRZWFZdkRLUUUyRUVQVldGNHJy?=
 =?utf-8?B?c0hvNXhYcG5WNGl6NU9HT2tUc2Q1UUdMWjJQNUJEZXkybVU2NENhSkxzKy9Y?=
 =?utf-8?B?dS82QnhkODRNNURjKzJ3Y2I3ZGQwOEFYcFlhSnBIcS9IbXFZQk5xR21ML2Z4?=
 =?utf-8?B?V2dmRXA2SzJ5TEtNNWw4L3U1UU1IK0JYcUx5TnlnV3JkNmNDeGVZSUVERjlv?=
 =?utf-8?B?YUFmdlNHQWxuUmYzN2R6RFBNUWQvZzNlR1dBeWFKMEJiUDdsN0liM0FQS3Ar?=
 =?utf-8?B?STZHZWdZdTlXZkxRdnNpWUpFQlMxN3ludVZ2VlJjckFDRXFramUrVmo1S2Va?=
 =?utf-8?B?UExTZzhrYWVzVGhUZTZFdExrVEZJU3ZDSzVWZGdsU083UXhpU05tWTBvbnlD?=
 =?utf-8?B?SEJxMnk3elpRNTBuWE5wdUlGdGVGSW0rVGJRbTVjS3F2YndNdFZ3QWlKNFF4?=
 =?utf-8?B?RXJmTnBmQk55Zm1aZG1YdkhRQkVjMFRkZ01XKzRlUGdrK0VWdEZSSkM4ZDR2?=
 =?utf-8?B?dUJzZ0FFYmRmeUNQT2Z2NWJqOFBGZHhOMnJVenJWS2c1U0tQaERudk5mTXB5?=
 =?utf-8?B?VlAweUkwRVF3NzR1SWNvdUEzVEIvZzV1cEd0ZDdEUk9Pa01Gd1l4K3FDaUZI?=
 =?utf-8?B?MFRMendBTUxpdGcwMys5UnZSbmNRNy8zemMwVDhvV0lnM1Jjdm1rSUh6QWJm?=
 =?utf-8?B?ajVHL1Q4QkxSNVd0aUI0bFdwY0RjWWM2Q1RQTDJEYmh5SDdJWHZNS1pSa1Zy?=
 =?utf-8?B?Y2tmelBZUWdxWE9VVytlWFVTYzVad3lQWUZzelJkNDh5MU5udTVtOFpWTzdh?=
 =?utf-8?B?SFdEUXNDMEZVWDJwL0dXYjJzQ0NqTEZNRDNlUzFFQ3YxYW1ENkN0aE9DOWlF?=
 =?utf-8?B?S1dabjNQZlZYRGZ2ckwySkdGNnRUSGNrOEZ5eUpxQnlNQ0xYTmR1YlhLQmZP?=
 =?utf-8?B?SHIxeHoxcnJwZmlXN3k4YmVYY3ZKbDdLNE1HYTNPTlJkR2J3VUIzUkExTTY4?=
 =?utf-8?B?eWNYT1RwKzlVR3g3T29HKy8zQnlUNFNVcWx4enNKdVBWTWk3ME1rQnY0S00z?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBB70BC2DEDDAB4097E5F7B0AD60C710@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb35bca-bf80-4743-b0f6-08da6a29f08a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 08:29:18.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4K3PzodJNi/CAV/MK8jWoY/UDCw1tUb1hW0/xYvx1GF5n3HyidH/OkHmuN1602F4WcIj3ni8z02wyL5U8jGZQGbbsQGx2cmuRfhUR4xNvRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1392
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDcuMjAyMiAyMDozNCwgY2xlbWVudC5sZWdlckBib290bGluLmNvbSB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBMZSAyMDIyLTA3LTA0
IDA4OjE5LCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIGEgw6ljcml0IDoNCj4+IEhpLCBD
bGVtZW50LA0KPj4NCj4+IE9uIDA2LjA2LjIwMjIgMTc6NTcsIENsw6ltZW50IEzDqWdlciB3cm90
ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93DQo+Pj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4g
QWRkIHNhbV9saW51eF9pc19pbl9ub3JtYWxfd29ybGQoKSB3aGljaCBhbGxvd3MgdG8ga25vdyBp
ZiBMaW51eCBpcw0KPj4+IHJ1bm5pbmcgaW4gdGhlIG5vcm1hbCB3b3JsZCBvciBub3QuIFRoaXMg
ZnVuY3Rpb24gaXMgdXNlZCBieSBjb2RlDQo+Pj4gd2hpY2ggbmVlZHMgdG8gZGlmZmVyZW50aWF0
ZSB0aGUgd29ybGQgaW4gd2hpY2ggTGludXggaXMgcnVubmluZy4NCj4+Pg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IENsw6ltZW50IEzDqWdlciA8Y2xlbWVudC5sZWdlckBib290bGluLmNvbT4NCj4+PiAt
LS0NCj4+PiDCoGFyY2gvYXJtL21hY2gtYXQ5MS9zYW1fc2VjdXJlLmMgfCA2ICsrKysrKw0KPj4+
IMKgYXJjaC9hcm0vbWFjaC1hdDkxL3NhbV9zZWN1cmUuaCB8IDEgKw0KPj4+IMKgMiBmaWxlcyBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9t
YWNoLWF0OTEvc2FtX3NlY3VyZS5jDQo+Pj4gYi9hcmNoL2FybS9tYWNoLWF0OTEvc2FtX3NlY3Vy
ZS5jDQo+Pj4gaW5kZXggMmEwMWY3YTdkMTNmLi4xZWM4YzhiOWQxMTkgMTAwNjQ0DQo+Pj4gLS0t
IGEvYXJjaC9hcm0vbWFjaC1hdDkxL3NhbV9zZWN1cmUuYw0KPj4+ICsrKyBiL2FyY2gvYXJtL21h
Y2gtYXQ5MS9zYW1fc2VjdXJlLmMNCj4+PiBAQCAtMjcsNiArMjcsMTIgQEAgc3RydWN0IGFybV9z
bWNjY19yZXMgc2FtX3NtY2NjX2NhbGwodTMyIGZuLCB1MzINCj4+PiBhcmcwLCB1MzIgYXJnMSkN
Cj4+PiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmVzOw0KPj4+IMKgfQ0KPj4+DQo+Pj4gK2Jvb2wg
c2FtX2xpbnV4X2lzX2luX25vcm1hbF93b3JsZCh2b2lkKQ0KPj4+ICt7DQo+Pj4gK8KgwqDCoMKg
wqDCoCAvKiBJZiBvcHRlZSBoYXMgYmVlbiBkZXRlY3RlZCwgdGhlbiB3ZSBhcmUgcnVubmluZyBp
biBub3JtYWwNCj4+PiB3b3JsZCAqLw0KPj4NCj4+IEluIGNhc2Ugb3B0ZWUgaGFzbid0IGJlZW4g
ZGV0ZWN0ZWQgZG9uJ3Qgd2UgcnVuIGFsc28gaW4gbm9ybWFsIHdvcmxkPw0KPj4gV2hhdCBJIHdh
bnQgdG8gc2F5IGlzIHRoYXQgbWF5YmUgeW91IGNhbiBjaGFuZ2UgdGhlIGZ1bmN0aW9uIG5hbWUg
dG8NCj4+IHNvbWV0aGluZyBsaWtlIHNhbV9saW51eF9pc19vcHRlZV9hdmFpbGFibGUoKS4NCj4g
DQo+IEkgd291bGQgc2F5IGl0IGRlcGVuZHMgb24gdGhlIGJvb3Rsb2FkZXIgY29uZmlndXJhdGlv
biwgYnV0IExpbnV4IGNhbg0KPiBydW4NCj4gaW4gc2VjdXJlIHdvcmxkIGFsc28uIEl0IHdvdWxk
IG5vdCBjaGFuZ2UgYSBsb3Qgb2YgdGhpbmcgdGhvdWdoLg0KPiBIb3dldmVyLCB5b3UgYXJlIHJp
Z2h0IHNhbV9saW51eF9vcHRlZV9pc19hdmFpbGFibGUoKSBzZWVtcyBlYXNpZXIgdG8NCj4gdW5k
ZXJzdGFuZCA7KQ0KDQpDaGFuZ2VkIHRoZSBuYW1lIGFuZCBhcHBsaWVkIGl0IHRvIGF0OTEtc29j
LCB0aGFua3MhDQoNCj4gDQo+IENsw6ltZW50DQoNCg==
