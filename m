Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB865547E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiFVKE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbiFVKE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:04:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EA319B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655892265; x=1687428265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UGJFHIMX29Y16ZEEjN8b21S0uVRDKzGSbWFlfTqsWw4=;
  b=1RIfp3CaXIKG9YsLytFyxnE1rnpPiqZQLgVaHZYmYL9T9x9AtdYO98g1
   vrsgITQ+ubZ7mcW3bKGbrPrkVoDHW21hvYCTNiyUwL+2xI+9sW9ybtmFR
   e/csZdg4Lr+4nOvSBEYIgO+3xBjAD2+qPGMYs0oQFtcK62KONVG78Ke32
   jFUlVHpLnm9UiRprqSULXEus9FxrTDzFHAE21/1knLdk9Q9iFLG6+/kj4
   bV27yyE1sNgK2fdTBFtajvFAtJf8M+dPgJH44QCuiF+hczQhI0QiQN7iV
   lpFT8ASSqFNNXBGr7Yr+q93STAhTVHAa2TRcP8zGmcYgPLk8QktaedIZm
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="101191892"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2022 03:04:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 22 Jun 2022 03:04:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 22 Jun 2022 03:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbo2LrjVnsdGPTlqC2VWBue3gFPBcOo3I7IAQM+ww4bjkA87iDxQWYfxQVJ6We5ECi8Lb3R7UHPuuRZUZNqMHxuD07pYeFd7B4CHpKk/1MfWo+RBeaT0GEnR6+QV1HYLCJQS/AXuLLq3POFyxvnDo4nMClZH74uzaIlIOftrCLomRt8ZbYU2CZSLQ/6DOAIIV3JubLY2OslILrW8YRjt47tzbVbkYqrlU60rbyf1nFTH1eOCpiThk6KVMKUWslbCXm4h+fv5EM4d02IJtd8Xm92EpMkqFgYKcScAJAXfo3DfkgtEB09p0Nb84oYpDf2B7eV+jsbydWwD5dRaIecZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGJFHIMX29Y16ZEEjN8b21S0uVRDKzGSbWFlfTqsWw4=;
 b=iV9rpabmdxEzDGagLjTQBkCHwTWT76s+G0MzjI3eQYlRqP2f3HOB5fARSoHyMBJAkqxZ25F3Lk7N3cQmenvJMW8FX0ItaS5t5cNWumnqzP3WaxSY7xwZDwAfAWdAAa1In++QrjjLvDfZFJGq3zPmL23BAmkhcw2zgyrM8G32D60vOIuCZZZjJTjFkqrqISNBjTIWnqLyjQjSNiwvRWQNBheGFvoPSQGnjUatTfbQLAK2Y1xT+ZHCegIrtfQeOOBjZwkbL9fFSs9S68pP7tjj+4TA/Eta2f2nPvVFtRz+zFQR64e9v1+/usfPGg8sR0jv1NRGDOEbRtL9+B5WOHnIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGJFHIMX29Y16ZEEjN8b21S0uVRDKzGSbWFlfTqsWw4=;
 b=vLSGd9U7lYMADqkjMN9kVJSxpiz8TK0yLuDsBd27OWXHTGvfn2MpiZx0IdwAiJmF/b+AHKPXBhodWq9F+6Gja/5s/XpsC+/8+umci2hEQa60syJoTWnRal2sWVNZSbDJEImBwwRgrj/AElnyIsduNYSOQJInihphQnHEnaI4GMw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 10:04:20 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 10:04:20 +0000
From:   <Conor.Dooley@microchip.com>
To:     <yuanjilin@cdjrlc.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm:kernel:Fix typo in comment
Thread-Topic: [PATCH] arm:kernel:Fix typo in comment
Thread-Index: AQHYhh9wOYpyKAsor0qnDlygz9djKw==
Date:   Wed, 22 Jun 2022 10:04:20 +0000
Message-ID: <a686e9da-c825-5f53-1320-65be4cb0b8af@microchip.com>
References: <20220622083701.20973-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220622083701.20973-1-yuanjilin@cdjrlc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 032539a4-11c2-4e59-b53c-08da54369368
x-ms-traffictypediagnostic: PH0PR11MB5029:EE_
x-microsoft-antispam-prvs: <PH0PR11MB50296D8ABEC647AAE161932798B29@PH0PR11MB5029.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HsYJelvCXbHXu2+65j9hmZZhXWNE90+Yl9SyvLUA9Yhuf3tpvfhJIQ9u6bUKY+0HVQ42G6OGbe6EkyBySG7IIW0N08DCny8cqpwatVcKx+kDVtPj4pIpUqKgD+LPlqjVdAQiJKmaEN2mVdzgpe0P1vIEYw+dI/ecjSC+CO488eBvBdRmH45XtHCANeAFCT80lmHvzypYs3H3NXaXZDEkJbMG1fuEgRJvaSf+0aU6iPfXTCG8GXh/dE4aacx/1YDK5+vyk2Hx+eTN48DiQ44Qk/P3d+bwku5lKGYhcgmQaBotZCIyTNkYi9RwW2Jok/OiBuq8Z6PKASHCs1NL4GrntAdwCWZ6KoUY72KuDJQ6yHo/ylGvZuC4RbXarJyAgkqB5obzX7o5lb7WRJJlV+aj7YIIdzRwcK/RacVKhwXGMTlS+nkWLwyI3qfqlm0kEH76Xw03YSG6j2HrKqjDjn5ITNIiYL/tkr6QLPqawM2atVcdncWAYEUGqQ7cX4SbMyytcE0/9Db1mPAUTxyI+opwt7CD1DrRnSpJ8Gmac5TljnLuMrRG9iPmKaw6M4EWO3p+WSohaa0+KR+cePlymUzCP09kYjkNLyrr5t1Z7PG15z/khAX4n8hotm9CMIB0vsdWsOLNWE3jjRJ6K5di714N2ZukFqgRIxb2+VdX/zKt0uEK2KU8BQtvPD95LodK9Jc9nglrHqyVMkPrNVi4jAZMeRQ7/fwLgnMnC3YsIjf0yf/mkx3TfQ533DOuPcj8ny40tFmnnEUD5j8vRU1YwGdRDvCfua2PToa+Kbvx7ObShTeWHQby2X/Y++K7zsfzkz/Zxy/8tt9lCOiSjgj9jj1yDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(346002)(396003)(366004)(86362001)(38100700002)(36756003)(38070700005)(31696002)(8936002)(122000001)(2906002)(6486002)(316002)(31686004)(66946007)(71200400001)(110136005)(66476007)(54906003)(8676002)(76116006)(66556008)(4326008)(83380400001)(53546011)(186003)(2616005)(5660300002)(478600001)(91956017)(66446008)(6512007)(41300700001)(6506007)(26005)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1lqUUZEbjZWN0Rma1gvZldLQ3l6NnZ2bWNMbkh2WDdwQzZXNldlTVRaOGhV?=
 =?utf-8?B?Ym9nTmZEOTRyMU96Q3NUNUo5T0M5OUh4ZnU3Vi85bEw1alZMMHV4L3BnbDFS?=
 =?utf-8?B?R1V0N1RpWG5iZ0dzT0lqdkhuWW9lMGVkY0hHVm15cGF4V21FSTdwcm1PUXZO?=
 =?utf-8?B?V09ic3E0cHBOQzltbFljMWd4ZnR0S1AyYVN0TURGZnFrMWp5VlZ3cHpmWkEz?=
 =?utf-8?B?QmFVWUNyZm44aFZyZlVEY3kybkI5Yjd6YzFtRTlBQTFVSWRqNVJ5N2pQZkov?=
 =?utf-8?B?dXhYaVZ0dHlyL2Jqa3BUZDA5eUxmVnY3ZzVXazRtamxCWVA1NlpkQVlJTkVt?=
 =?utf-8?B?WXRTbGhUeGd0SjBlVDVUYTluRmdINzJDM2VNM2lSWDJNcStWUk95b0VJcFgw?=
 =?utf-8?B?amJadDVYSjk4UEZBb29CUnBtZmJ1SlgxREo5aVBTNXJYdnNObWxGQUFxZDJx?=
 =?utf-8?B?RW9iVFE1c2hMQ0xIQmhFQU45alp0dlUwMldqQlRLVXY4Z2lHK0p4b3kwamZx?=
 =?utf-8?B?QkVjblBqZzIrL3o0SjE3bUVKWVlqb2NMUE5zNDloZUo3bXViV2NMdDExVGN6?=
 =?utf-8?B?akZndXdnZjMwbVhVQkdwMDVVREVUYmRCMUswUE9kUlh5bUIrV1kvTDYxNTBR?=
 =?utf-8?B?WE5VRDl3UGpCaFh1K0RkaURHd1l6SzNzRFBKS3lRWWthRVY0L0ZybWkwRncw?=
 =?utf-8?B?VVJHdXlGMElSWExqVVRkV2I3cEYzN0N2eDh1dUtvb0NqVUJmVVNZRlY2YjdF?=
 =?utf-8?B?M0FSd01aQ1JTbzhGR0JxMDhxcjJrOEZkWlZvQjhibEk4YzJsTG80UUM3TElo?=
 =?utf-8?B?TW9tRXZyTTl3SE1hcGNsWlN1czJHUUptZmdjcTJoOVlwYjhUc2N3U2N4bUw5?=
 =?utf-8?B?V2hZQkFzWmpkaFZ1ZVg4MmhhYXhzQmx4UHpYcld1dDZLejRmWnV3MUlzbkk0?=
 =?utf-8?B?TGZKQU9NSzl3NFNQVWxzSTVlNFBTaCtTeVhTSVJoNGNLUUQ5cW8xZWVIeC9O?=
 =?utf-8?B?ZlBJcE5KSUN2SURWNmhDcHlhTnFCeEVrTWFrU3JXdW4xUW9xblRCY2UrQXJN?=
 =?utf-8?B?VHVoL0xvMFpYN00wbHU4aU5TUWo5RTZiMkorei9GSzZiZ1NYM0Y1OG5Uc2pQ?=
 =?utf-8?B?L2dEbU9JZTNqV2RMMDRTbTJSallnNWpDK1RQUkZvM3djVXpRWk9LUmprVHBr?=
 =?utf-8?B?MmovOGpscUxPMzNYMDZDaGRQeXlQTkNvUzVEMENFZUE2bWpwaUZqam1WQUZn?=
 =?utf-8?B?ZVgyOTJwTWJodXlXWnJOQXRlOHlGUHIzMitJdTRCeHZ4OEFXcHpxL0ZCSW1U?=
 =?utf-8?B?MVJBNHg2dkU1a1BNTW9iZXRXQzVMYUNHUW9Gc0ZZREhiNGJraXBxYjYyWGpz?=
 =?utf-8?B?dVErR1BkN2RMdXdkZ0FhQlpWbXJOdVRScEMzSk5pRGRuRVJJUnNMQWJxR0I1?=
 =?utf-8?B?Q3BmRVV1dG5wZkw0UHZvUDYxekJqQzZTcGJ0NVRnQmZneFNGa01OZ09KVzFk?=
 =?utf-8?B?UXdiMzFJaS9oY2MrUzk3NlZ6UUxjRDBaSXA4bWM1RWxaZmVsMnBsRHNBdnh4?=
 =?utf-8?B?Q2cxenRWRDA0OFVjRE5BNmI0S01ndkI5N2R3Yi8yQlowc1lSdTY2Njd0YkZy?=
 =?utf-8?B?Umh5Q2ZTbXpoeVlUMkhtMHJCSjBRenp1dXM4dUgvSzYrMXRKRGQxeDJENTdC?=
 =?utf-8?B?UFYvUk10L0oySnFRcGJSbXFDYlNzY1d6OTA0dFNXS2JzMTFvWEx1UVpma3Zn?=
 =?utf-8?B?czErQ3dVVWYrdWQ1RzZ6U2tLN0thTGNjQ0dhaFJrR0RhT24wWk04NGxCSlpu?=
 =?utf-8?B?aVlEaS9KdVFJK29aRXNvMExLN0NCMEZSdElXVUx1cGFxQVJNSjZzdElhQVVT?=
 =?utf-8?B?cEt4YldWc0VNcEF4cjIzZHN5ZDFQMUM5Njg4QWp4bjBhQnprS2RWa0taSXE3?=
 =?utf-8?B?OWVxOWExSjZkWk11MVp3blRrYUJBZ1A0ZDBCaEJNMVEvcmhPUVhIZk9Helh0?=
 =?utf-8?B?czFrWmh0VVg2aTA3cVNOWHl4QUUybkVyTjF6dkV6UUM5R1BIeGIza1dDZmZP?=
 =?utf-8?B?L2k3R0hFaU9kb1FoVzBKNHR6Q2JKWGVqQkxCaWU4UGdBSHdnZUc2Wmt0OGtq?=
 =?utf-8?Q?9782YLa8cW8GsJXdu3fothMfI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44092A571AC26D47B59723E64FD9383B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032539a4-11c2-4e59-b53c-08da54369368
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 10:04:20.4114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nv+BfxeOw6n1Z1u4eLIMG+TMpyNTjO6kBSC0PXtJSz+toJR/eoj55n8UXw2hhD7Mk7iGwkfxmW6emGQx8zIIq6Tt90lu1ZYWAUpgxQSZDQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIyLzA2LzIwMjIgMDk6MzcsIEppbGluIFl1YW4gd3JvdGU6DQo+IERlbGV0ZSB0aGUg
cmVkdW5kYW50IHdvcmQgJ0FSTScuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaWxpbiBZdWFuIDx5
dWFuamlsaW5AY2RqcmxjLmNvbT4NCj4gLS0tDQo+ICAgYXJjaC9hcm0va2VybmVsL2h3X2JyZWFr
cG9pbnQuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9rZXJuZWwvaHdfYnJlYWtwb2lu
dC5jIGIvYXJjaC9hcm0va2VybmVsL2h3X2JyZWFrcG9pbnQuYw0KPiBpbmRleCAwNTRlOTE5OWYz
MGQuLjBiM2M4ZjJmZjdiMCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0va2VybmVsL2h3X2JyZWFr
cG9pbnQuYw0KPiArKysgYi9hcmNoL2FybS9rZXJuZWwvaHdfYnJlYWtwb2ludC5jDQo+IEBAIC0x
OTksNyArMTk5LDcgQEAgc3RhdGljIGludCBnZXRfbnVtX3dycHModm9pZCkNCj4gICAJICoga25v
dyB3aGljaCB3YXRjaHBvaW50IGZpcmVkLiBJbiB0aGUgZnV0dXJlIHdlIGNhbiBlaXRoZXIgYWRk
IGENCj4gICAJICogZGlzYXNzZW1ibGVyIGFuZCBhZGRyZXNzIGdlbmVyYXRpb24gZW11bGF0b3Is
IG9yIHdlIGNhbiBpbnNlcnQgYQ0KPiAgIAkgKiBjaGVjayB0byBzZWUgaWYgdGhlIERGQVIgaXMg
c2V0IG9uIHdhdGNocG9pbnQgZXhjZXB0aW9uIGVudHJ5DQo+IC0JICogW3RoZSBBUk0gQVJNIHN0
YXRlcyB0aGF0IHRoZSBERkFSIGlzIFVOS05PV04sIGJ1dCBleHBlcmllbmNlIHNob3dzDQo+ICsJ
ICogW3RoZSBBUk0gc3RhdGVzIHRoYXQgdGhlIERGQVIgaXMgVU5LTk9XTiwgYnV0IGV4cGVyaWVu
Y2Ugc2hvd3MNCg0KVGhpcyBpc250IGEgZHVwbGljYXRlIGlzIGl0PyBJdCdzIFRoZSBBUk0gQXJj
aC4gUmVmZXJlbmNlIE1hbnVhbCwgbm8/DQpTYW1lIHdvdWxkIGFwcGx5IHRvIHlvdXIgb3RoZXIg
ZHVwbGljYXRlIHJlbW92YWxzIGZvciBBUk0gSSBndWVzcy4NCg0KPiAgIAkgKiB0aGF0IGl0IGlz
IHNldCBvbiBzb21lIGltcGxlbWVudGF0aW9uc10uDQo+ICAgCSAqLw0KPiAgIAlpZiAoZ2V0X2Rl
YnVnX2FyY2goKSA8IEFSTV9ERUJVR19BUkNIX1Y3XzEpDQo=
