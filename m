Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895F34D2A1A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiCIH6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiCIH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3338A164D10
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646812513; x=1678348513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wSgEanls18/g+9MCO+R6IVjvDSbvCzVKEO5nHi4Isf4=;
  b=xFMwgPsBiI1JQwTPOn0eu885x13a2+Tur18Mzxj7Ev8j7+iL4RMt2AvN
   PIVo4pxAe2VrWd++Iaj9GX38zvqMBY5xxoKPzkwweebuFJIpOAoqYgbEe
   bH1ff/5ExlX3XBtOBsu1vyre3OLOzpJ1i5XWh1cwq3vWNsqwdTW5Bj6l5
   CQIy115FTKX7BTAdA5mLRCdYooX4+IfH9Cd+LRjvF8YOJejxILdGuxTqe
   gM9AbtphGGo3lx/QFsRFmGACSd/cBHbtdlDYqZNwrUU4JlgGOj4vY4f6s
   VUviEhJXmswkq3aGkGBu77ZM3BOZGW3WcZSy7KUXEonIOfRdhi+dUQ81W
   g==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="151367941"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 00:55:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 00:55:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 9 Mar 2022 00:55:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P19e4qyoo9Up5UE1vll3b2ZtKPW2o7FHLYJRvyF+BTfQwxM62FqSgsCE6w6Dsx0Iv9o0/kzEl7rp0t2mOUcdgzgemEqH6Zhur3fjdND7pSYkcW0jDKhIez0tKJkM9s63ZYOxqsWS6P5ae4nc/gs2AkUtEOwzqgNOsW6gD1XNgl0HZ+Bs2UOASqej9nRjlkEbDBsZqQOR2rdHb14L/kyUba4/z9OuoyFmtARFCZpc8/KRMzs/Iislcqk84k+QTStVgxL8S+UtA7I8Qv+Iyz3cXDZwhyB8zvUHPkjUw3vNPDd8ixr2uoayIRme3Hax/I7j/iwb137La6uCeev8qPr1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSgEanls18/g+9MCO+R6IVjvDSbvCzVKEO5nHi4Isf4=;
 b=bR779PqSp6ghVPMCOSHBvfhEnqKz71RgBTrcKzoX8ZlTjQI7fFe6n/JCy8beE/2kiUYKXG/aX9w8mCiQ5cMyrIlfSxDtpy6VOv6OVOTVR6kO9OzEEpsCAUsLGy15XRvGP8fLYYQF9/4CHsrLFUAOt3XwvgHeBAQaONjMHtioSJWj6KTwVKGHO2tP5/ZgNa1Enc59gXvL3CjRK2XZKgX4wqhDmCxrYsshJYPHIP/uhsAFIZG0SiUEIKG0cIujqL3QSIoz+YDI+rB0N+WfioMyrSNF0WDKg3CbrBTc753cbljyk/Wg/ejKrR7VbHZ9m69AVxB5f9ZNHXCqEFIwW4vNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSgEanls18/g+9MCO+R6IVjvDSbvCzVKEO5nHi4Isf4=;
 b=ISXWG+3oLeKcFWpZy6S3cui9/1IoSlAGLrj1JDdtIwuWqmwM7Kcu6mjgHMlcU3gn1alK0c9Of59mM2H/VBangL4aPytdahzh2WIq8WvN/JiQF3o++LDJInnbD8qcuQazLPzsATKbozhKgFmsTEtuXBJp2HUu+6EV/tK3waIThw0=
Received: from DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) by
 CY4PR11MB1288.namprd11.prod.outlook.com (2603:10b6:903:23::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 07:55:01 +0000
Received: from DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f]) by DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f%4]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 07:55:01 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <alviro.iskandar@gnuweeb.org>, <broonie@kernel.org>
CC:     <alviro.iskandar@gmail.com>, <richiisei@gmail.com>,
        <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <gwml@vger.gnuweeb.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>
Subject: Re: [PATCH] ASoC: atmel: mchp-pdmc: Fix `-Wpointer-bool-conversion`
 warning
Thread-Topic: [PATCH] ASoC: atmel: mchp-pdmc: Fix `-Wpointer-bool-conversion`
 warning
Thread-Index: AQHYM4Mxk12Nn7WcmkyEmXLRIzWu9qy2ru0A
Date:   Wed, 9 Mar 2022 07:55:01 +0000
Message-ID: <52685dd2-593f-d39b-0f57-e6cf31bb4f2e@microchip.com>
References: <202203091430.MLY27Bif-lkp@intel.com>
 <20220309065849.96165-1-alviro.iskandar@gnuweeb.org>
In-Reply-To: <20220309065849.96165-1-alviro.iskandar@gnuweeb.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55a5c2ef-1795-4797-ca23-08da01a21d31
x-ms-traffictypediagnostic: CY4PR11MB1288:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1288DDE838FD06E5A7E58DCFE70A9@CY4PR11MB1288.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +R8067wuqAXTz0b1XzWDoajsv0qpMPOZv1RV7Xy+OeVFdz4x91Rri78KMw9mv+3OYGGOL4xdgZv3YpHdQqkmmdGWTYcaXHTo7hBh/3YtnjcyKptMQejVSERfGVsDERngJEiWzkvH8DJ20YCe6zftzA52mxUK84+9pUg0ikrme+yr2PKadC66xmT3yufQEduaBFLwUuUjGoaHYi3y5O82F6nXvVlBXYs5ljdO76ncTR/Pl4SBdOYMz+1cLTYXUXQAFbH9gZgUwgSAHwCgzZXvEmw0nkxhq7vsN+r8hu1U1Mu6yGlG0UEWwxOX0rEBYD/Gy7JwTS9I8KexSwKe7arjXku/S44bgLkKdihaV/P0bmAdR02UK6ENAE4RqhOuyrDkggzVprorhSqE1bvRgET+4mLK7T1vriuhKKX4t5CYfZfhTj+2cXer5CvEGMrbLldRvtmJ+X8vfo3BkM3ZugPul6yHC/Mi1dTIIthgFilhrwMWkwVALkipnq9kpddkzHRHHA7DHQVQAvUvHvw5vWEnCjjpDtQxfdKo7D+GwBI8AyF5/CAOHxOy2yo20f8VFQYU186bdG3btJLz15mOyRH9nIqxrSYAO3C1hOJgkUVejOeno8OQek3VGjT7fjMmm5fqLtL6EQcr+DZzKG8TWcZ0CKxKiS9/oaEe+bbiHYW/j6pLSsb22zuIM+YYeqLgZKf48B5ZdLoHQNYWxv0LEquhRDieHddXGYm80Xxt8KhSLOLNh/eboia1ALiTV8pArSXR8yr1jCp1b53TlKn7ew8OWnxXoBLMGnqAuTcUvJ6mn4IltPf8v7S2XH+GPXggHdJq/d8PbXlN855BDZ4L7IQzSW0jVjnCCNFZY4Ug5os+YVvlQbgs+NG4OMtppREgyMda
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66556008)(66476007)(966005)(6486002)(186003)(26005)(38070700005)(6506007)(76116006)(31696002)(66446008)(64756008)(8676002)(66946007)(8936002)(508600001)(83380400001)(5660300002)(6512007)(2906002)(38100700002)(91956017)(122000001)(31686004)(71200400001)(316002)(54906003)(110136005)(53546011)(36756003)(86362001)(2616005)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0YxV2RCZDZzNld1WEtHRHJGQnBNTDNoNG01R3lvemZ3MVhDUU53OXlTMDVh?=
 =?utf-8?B?bFJnVnIrVzhiTEp6TXEwdXVHTkVhTjhOb0pIUmc3c0c4Z1FRWVVFenRCQVFJ?=
 =?utf-8?B?d1p6Q1A0WWU2ZmtLczJsbm1DTUFGSEdvbGxhakI5cjRCY2FVbGhpTmhFZHZF?=
 =?utf-8?B?eXdwRXorZ2drcSswOVR0OWUrVDk0YWNNY0ExWXJnaFRPUnhINUNUT0QrS0ps?=
 =?utf-8?B?VHQyU2lxRUJ4RGw5cHhGY1VITzg0Q28yZHl4N3NXUXJsajl2Z2xTUitiQmta?=
 =?utf-8?B?QStibFZCQnlwc2t3TkpNUWpFTVRGVndkcTVrOW11Y05yK2QzN0dMaHFhMUVr?=
 =?utf-8?B?alhtbG9mUVErNklxa011WFg0OVFXT3luT1BJOXJKNTBDM1lDRTVTSngrM1Zu?=
 =?utf-8?B?TnBtVlNWNEhWbEhVcXJBNDB6ZTAvRVZTMEliN3p2THYzSkEwQk1paWNiMHls?=
 =?utf-8?B?UEFlc3RldDBBbHdyUHpXdWtFVU16YSsydUYrckJYMWhybWlkZjZ4eU5lTWJZ?=
 =?utf-8?B?TWV2R1pEc2Z6dGJuNFFEZndEV3lMWFhnWGhMNFp2dzhYcG5RMi9UYmRTMUI3?=
 =?utf-8?B?Q0d0SXdMM0NWc0xLT2NtaEdBR3V5SjN5NFdHUVNXcEtsamdXbzlDd2Z3Z2V6?=
 =?utf-8?B?cGkvUGxNVGRES1dwaGIzVVhXU25GNHVLYjBVVHBhc0t1eTZEU2htb0tLSTd3?=
 =?utf-8?B?dUV3U2ZjUk12QkFYK0lwUGswK0l3a1l2bGFuRlBtRXBlaWc0SGlGelZ0cEJ0?=
 =?utf-8?B?Q2ZIMEtVemVGOFZqMnRPTW9IU0hHazkvMW5tTWxycHZmdlVkd3B6dklROUlS?=
 =?utf-8?B?WHloanpoYlVjMTc5cWY5YVF3WTZZSkdQdWJVM1EwTVBKZEE2UnhweGQyVnVZ?=
 =?utf-8?B?YUluN09Gc29zYVpxeVpTYTNwWkhjZmZaZ2kxQWU2ZTNCeU5DM1J6Rml5QnVs?=
 =?utf-8?B?YUwxZWJib2dPSklWcGl5dlE5Rkl0KzQ5OWx5UkpENW5WQU1zcjMrNkp2SlFV?=
 =?utf-8?B?b0ZZOUhGZW1vcURFc0FBMWNlb3RkYVV6bFhuZlR1eUYrd0ZPNm83eTN3OXVC?=
 =?utf-8?B?bE1SNnlGNFh2VFFnbmUwTWl0d0xRa3F5N2YyZTBjUVYrR2NJQ1NqVks4WU8y?=
 =?utf-8?B?VlBnbHk3WHRvQyt0OEtqclpYN3M5SGlSazh6QlV1SE5BSCticEp3bm5PYnBk?=
 =?utf-8?B?Z01pdUZGV1owTGV4TUtEZmp3RWNQaWFadHNPMEE4YWxmbXArUDNVd0F2THFQ?=
 =?utf-8?B?WEJaT3NXSVREZ3ovL3lIc1NmcTMrV3VXcGxHTjJwcUw4SldSN05IZzdyNjJC?=
 =?utf-8?B?WXhaK0IxUVBrZDVWbzlpQm9CVUFGbkhZY1NUaklCSXUxeW43WnoxQm5zckZT?=
 =?utf-8?B?ZGhJblB0TFpjaFNaam5rd2xDbXkrSURiYURjVnl3TDd4OFJuU0h4WDlNcGRm?=
 =?utf-8?B?LzY0bm9lVEtJUEpuT2EyZDRmMjhvR1p4a2dCbzcvUVptWkh0WVhTR1kyMVNu?=
 =?utf-8?B?cS91bll1ZDRob2RjbzlxL1MrWEZlODVCMlNGUmh2Z1lOYi9RT01NSEk5bGtr?=
 =?utf-8?B?cnhQTUJ1WXhobWd2bDNYbGJpbU9FNmx1VUxZYzJJNit4b3NuZWJOOTZsbFIr?=
 =?utf-8?B?dUZhbDFnY3hVVk1vcHB5akUyVFBReDRHY0N4ZnhSbEJnN25oUlpIcW9TTkJW?=
 =?utf-8?B?MzVOb01ydmFMUGFDcXVhdXgzZWFOc2F0MUtOeWRza21HaUlRZnhLZTVLNTBH?=
 =?utf-8?B?SDZhTFVESHhUYnVNbTdRMzEyRUJWNTN2UGRLWC84dFZOSTgya2d5dlJvaENo?=
 =?utf-8?B?ajBLZEZScHdUeW8zaElPblpwTEVZY0xtMkt1K0krSGhrbkhmSis4NzJUdWZk?=
 =?utf-8?B?eEhzcmhLVzE2bk4rekJQditjZFVhVU5hMVFmOHkwQ2RrbXIrOWdaNU1tQlFt?=
 =?utf-8?B?KzRBR1laL3RpWlcrcVVqNEJqYU1pcGk0WDBoRjVXNWsrTUFwaDUzSlZreEJz?=
 =?utf-8?B?a0ZIOTdEajl1NjExKzF6ajFCc2ZoR1gweURDZ00zVThMZll6dkdKVUxnTmll?=
 =?utf-8?B?TXMrM2FCNVhFRUJGZzUwYXdiNnJvd3NrNnZiUkF1c1VrSnEyYVBabk8rYTBY?=
 =?utf-8?B?b0w3b0tIZU11T3pLN1FHS3ZOR1JTcTYrMzY4SWJyZVdjZERZMUdrZi9VdVdq?=
 =?utf-8?B?b1RVMHQ5TWtjY0pPYU1oaUgvQkZEREJ5RW5xc0UyR043ZFRMTnpqbkJxQm9p?=
 =?utf-8?B?K3N2THZQWDcyVGM1cTFqdE9DWDd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EAE1129F102CE469697CE262EBEA634@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a5c2ef-1795-4797-ca23-08da01a21d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 07:55:01.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBhjBnRZ49VgIHh7tT6y8k2QXbAhqeOegppPAHSdPqwz+vvEe8B23QuLuw/5p6R9AwXoTsoH+9WLwOljdO/bYp0kBAYwVe4/1aC+79kGg0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1288
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDMuMjAyMiAwODo1OCwgQWx2aXJvIElza2FuZGFyIFNldGlhd2FuIHdyb3RlOg0KPiBJ
biBmdW5jdGlvbiBtY2hwX3BkbWNfYWZfcHV0KCksIEludGVsJ3Mga2VybmVsIHRlc3Qgcm9ib3Qg
cmVwb3J0cyB0aGUNCj4gZm9sbG93aW5nIHdhcm5pbmc6DQo+IA0KPiAgICBzb3VuZC9zb2MvYXRt
ZWwvbWNocC1wZG1jLmM6MTg2OjM0OiB3YXJuaW5nOiBhZGRyZXNzIG9mIGFycmF5IFwNCj4gICAg
J3V2YWx1ZS0+dmFsdWUuaW50ZWdlci52YWx1ZScgd2lsbCBhbHdheXMgZXZhbHVhdGUgdG8gJ3Ry
dWUnIFwNCj4gICAgWy1XcG9pbnRlci1ib29sLWNvbnZlcnNpb25dDQo+IA0KPiBUaGlzIGlzIGJl
Y2F1c2Ugd2UgYXJlIHVzaW5nIGB1dmFsdWUtPnZhbHVlLmludGVnZXIudmFsdWVgIHdoaWNoIGl0
cw0KPiB0eXBlIGlzIGBsb25nIHZhbHVlWzEyOF07YCBmb3IgY29uZGl0aW9uYWwgZXhwcmVzc2lv
biBhbmQgdGhhdCBhcnJheQ0KPiB3aWxsIGFsd2F5cyBkZWNheSB0byBhIG5vbi1OVUxMIHBvaW50
ZXIuIFVzaW5nIGEgbm9uLU5VTEwgcG9pbnRlciBmb3INCj4gY29uZGl0aW9uYWwgZXhwcmVzc2lv
biB3aWxsIGFsd2F5cyBldmFsdWF0ZSB0byB0cnVlLg0KPiANCj4gRml4IHRoaXMgYnkgY2hhbmdp
bmcgaXQgdG8gYHV2YWx1ZS0+dmFsdWUuaW50ZWdlci52YWx1ZVswXWAgYXMgdGhhdCdzDQo+IHdo
YXQgdGhlIG1jaHBfcGRtY19hZl9nZXQoKSBmdW5jdGlvbiBzZXRzLg0KPiANCj4gVG86IE1hcmsg
QnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gQ2M6IENvZHJpbiBDaXVib3Rhcml1IDxjb2Ry
aW4uY2l1Ym90YXJpdUBtaWNyb2NoaXAuY29tPg0KPiBDYzogTnVncmFoYSA8cmljaGlpc2VpQGdt
YWlsLmNvbT4NCj4gQ2M6IGxsdm1AbGlzdHMubGludXguZGV2DQo+IENjOiBrYnVpbGQtYWxsQGxp
c3RzLjAxLm9yZw0KPiBDYzogZ3dtbEB2Z2VyLmdudXdlZWIub3JnDQo+IENjOiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtw
QGludGVsLmNvbT4NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDMw
OTE0MzAuTUxZMjdCaWYtbGtwQGludGVsLmNvbQ0KPiBGaXhlczogNTAyOTE2NTJhZjUyNjk4MTNi
YWE2MDI0ZWIwZTgxYjVmMGJiYjQ1MSAoIkFTb0M6IGF0bWVsOiBtY2hwLXBkbWM6IGFkZCBQRE1D
IGRyaXZlciIpDQo+IFNpZ25lZC1vZmYtYnk6IEFsdmlybyBJc2thbmRhciBTZXRpYXdhbiA8YWx2
aXJvLmlza2FuZGFyQGdudXdlZWIub3JnPg0KDQpSZXZpZXdlZC1ieTogQ29kcmluIENpdWJvdGFy
aXUgPGNvZHJpbi5jaXVib3Rhcml1QG1pY3JvY2hpcC5jb20+DQoNClRoYW5rIHlvdSENCg==
