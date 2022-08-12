Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731CE59141C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbiHLQnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiHLQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:43:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAD8AFADA;
        Fri, 12 Aug 2022 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660322614; x=1691858614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KbyWncIN09kWOteOHO3sLbGyvZUP7qp+fxoYHThB7Rw=;
  b=R3Vn4XdiKdgaIt/lC8mPWV61ZSJKmv/53Ms3GYSQblxLajVX4ePk9De1
   NUVOy3bTFqR97ii4KLcVz4DjObya5fMcxFx6LRWzTSK/21A2SdVLSBv20
   PIqOWNfKfINzJhYEDcq4bRtWFQT7s5cTvt03HtKFddJNotqsIrOS+kKCy
   6J1wDL7tRdwD6dvJlGFUhDmaVpziKRl7zUoHj/Hg9sYVoQBVwosmhCzS1
   WtkFUqrZo/aImXS4OOQYBmrM5f5YJjOKOAV34Fd6KHB2Ozy90cu9UygS8
   KpJDgP6CzcEApB+y+kqfHXZS6jmSXsQFDWRnPu40ML+77HzAHwtWqV571
   g==;
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="172217712"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 09:43:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 09:43:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 09:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsLWZ/RSx/yZq8BqP+zVCtnjXrdFoCYnMNga8Ek0d3zgO2lkTiBhFgWj2GEPp2TIL+nUlnpLEmyJc3BQx/bskkNDE2PDJ7CBKT+RTPQEVPCje9QwmcQvp9HBlF3kR8Lx2l71X1q5D+Z3qqq0D+wdFGRa/IRjd2PYTBXftyBkqdfrDIk8MX5FCwlDxoaT77rHKlHd7ezqJKXs0B/b70FO0Dms44Iw33MjhIWHgqO6zPk/u508F3Y0JGRQ7KvQS64AQ5jFnbQZhgbFa5mN64u50osYAbULwKsZkcH0Zrs1UKgm406KaZIGi0K5pwyYkkOllOKOOBpNwdo8zfwyh25bNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbyWncIN09kWOteOHO3sLbGyvZUP7qp+fxoYHThB7Rw=;
 b=mXbPKPC+6cYScPz+RsN+GVEEPpzqU05edzaL05YZzuF5AUK3UDrnI32NtjZgL4J/SAT0HZbi+h77zbFhNsed1IRd8ULoj+LJswGqGCSm6yoAkX6IJf5PUmVrK8ElFyheAlktXhPejrn3wlvDGQEwYs2k/T9sCG9OpVPryXQN7WNX5yk2GNUWX6dwsDzWH4Gmsaw3GxXEhAAstVUJGw9Z6lFfFu8LiwHDfUQR4nu0mCj+LmEaiOkzj/6ruUUuJlbf7M1gxNYBd6+hAKP3mQ+ZpAxg13FdoYrlqGJA6ukPAGbSAVFRTQszZCTsmZ7CVNklJJJGk61OcTyYJaL/CJCAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbyWncIN09kWOteOHO3sLbGyvZUP7qp+fxoYHThB7Rw=;
 b=uuD7aREPJBnRbM950feTLyngVLIFQkwoh3o8/qqro9IYuOUTm0GxSDh265QUcIsUMGXRgHKil0AmD+Yv6oQGoTAA6xAgAAsuGykJIq1d2dxmgr0J8M32UAYcR6/0pdwV4QgIMx0EWcFK9xJUeoyZMgVoDWJQ0qG6DmkKnukBTuw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1922.namprd11.prod.outlook.com (2603:10b6:404:100::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 16:43:27 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 16:43:24 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh+dt@kernel.org>
CC:     <mail@conchuod.ie>, <ulf.hansson@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <piotrs@cadence.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: mmc: cdns: add card-detect-delay property
Thread-Topic: [PATCH] dt-bindings: mmc: cdns: add card-detect-delay property
Thread-Index: AQHYrcFxzXmqZluWDkK6zKWVpeVxJ62rZiyAgAADpYCAAA6JgIAAAWoA
Date:   Fri, 12 Aug 2022 16:43:24 +0000
Message-ID: <fd3e5466-76e4-f678-5729-bfe9f2b0b811@microchip.com>
References: <20220811203151.179258-1-mail@conchuod.ie>
 <CAL_JsqLOGLZD6vrNPqDUqYypkz8xoCPJ4DA4JF-BrG=WHWPurw@mail.gmail.com>
 <46c51365-b4a5-9666-bc3a-24ff833d8fb2@microchip.com>
 <CAL_JsqKZ2N7rTb0Fm0Y8CjN8XrTkBsu2uU_TFfhU0iwjSz5row@mail.gmail.com>
In-Reply-To: <CAL_JsqKZ2N7rTb0Fm0Y8CjN8XrTkBsu2uU_TFfhU0iwjSz5row@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a6de2ba-219f-4b07-925a-08da7c81c66e
x-ms-traffictypediagnostic: BN6PR11MB1922:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWe8LQAs85/7fSJXEEhpLxRo8bGtPbcbxr+8Gnso02kpwQZV73xvaaoqRTb2BIPKyqRSJqgzY26LMIhx0KItU3+56KjGzbQP4ozSDJk7+BPjKHKGYojr3lB7/sNHQk0pgTjN6dIH2YZDFUQcx/mkazAHV5rFwomYtUOMrsrVueYtqtke3VJKCbU9SuxYR6RNiRGoo80/N01+TBkrXGyNrR83PNK6PCpk7zWl6oJSIT2udWcZCWLSMWo//gkInrHgEqQBjAh/5JZ5zFU13iSEgJgTDB9r7EKqVUMrESESHKu/dIwRtyI+QrE0M+QghnIurWFURFoUsrHn7sY+Bh4ErCKsDov4eQNOhUVNkOQ5euAqqMVRvwN3CMJ528w9plRv2tk6X3f9rFQ2Le1cqO7oiuuJXEHP1qQbqLkISKb+7eOllAt6B/TRI9KrTYc8/HFgZXPRmHP1VJfsFlp6q4soMJZg35evU5NiukWf7WbjasKQrOhIW61sHNCWogoTMTt45vx/WCV+egp2qAhB4DUyaBhJVDjJlj5AGllFGFR6ltDt4wQE3n1dxs4o5OzpMrS9jaJSjDECoxwhAJikAki7TwqFeTlcZqVt3nGBhbjgyNY//0K8eqOQ+hCX867ITpTrniK1mxGU10VOpOZrpZI1P/GtPkVKJhF/B7RN2/5zaZrqp+E5J2kpEByrhzTPfqVzmBP7a4amdpVM2APIkP9h8K1VuR7LzozJbQ77ovBEbe2p6gsY29z5uhWFo7p9FoF1NEddv1tmVU9KIssb4jWA5uXSOrA+p3xpHuE1jNM+5q7x7HHq7SkpzhCTg9kNPPEK8jd74O0PnXFpZRb5sPRR0lSRdodNir/XZ7Y6g3DQqHQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(39860400002)(136003)(366004)(6512007)(31696002)(26005)(8676002)(38070700005)(76116006)(38100700002)(91956017)(122000001)(66556008)(64756008)(66476007)(53546011)(66446008)(66946007)(4326008)(71200400001)(478600001)(6486002)(6506007)(316002)(41300700001)(54906003)(36756003)(2616005)(186003)(2906002)(4744005)(5660300002)(31686004)(8936002)(7416002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2ZZUGd5SUtURDZqcjVVZUx3Z1dWTTg1c0dwUmhpUlNsZHoxNE5nYlFLekc0?=
 =?utf-8?B?R0lJcC8zMGZoSmpPb0toblFwTGdVQjl4SGpqU3VWN2d4TmVWbkREbXg5Nzcv?=
 =?utf-8?B?M1VaYmsxbTR6U3NHYm5iNmxkREt4OXVYZU9tdVdJK1U3V01Ob0x0UXlZNkJH?=
 =?utf-8?B?TEJod0Qza01xd0pycG42aFZMTzFqeEFNRU15MEZUai9uV1RlWVYzdzdqQlRP?=
 =?utf-8?B?OEludWNLdTIycFdFNWloS2dnYUw1SmRUMk9tZit1U0pRQ3BHL0dFMWg3dlJ2?=
 =?utf-8?B?TndYNk1JL3VzSmkyemZ3Qnp2M0tKdEV0cTZLc0JoVzZoMjR5MEhRL2oxak1V?=
 =?utf-8?B?T2ErN1pBdDQ0T28waFBxTllpQnpGbUtncW1ZQWwxN2tITlQzd0NyRkVpWERJ?=
 =?utf-8?B?ekxPKzZqZUJLWnFhbkxJbFZaOFM3ajBid1FYM1NZa2N2MW5zSkJqZmZ6RTVt?=
 =?utf-8?B?Z3haaGxCWmR0TjZDTU4yKzFDbkcxU1FHaG9lN0VTc2Vzb1pQd0IwS2pCc2RQ?=
 =?utf-8?B?YzdWeklNUHlncW55RXhvRW9CZTV5a01GNVRPZGpaTWdidEpvMDBKZEtYOU9v?=
 =?utf-8?B?Q1o4L001MzNIRUlrSGt2UHJPbjgwVlJLaDVPS3JHSzMvTmxKY1RiK2tYZFNa?=
 =?utf-8?B?Uzk5WTJ5aHNLMEMwWUVUWWhCQVhjM1hKbmJQMy9wd2dtd0dBcFhMYUUwZjJG?=
 =?utf-8?B?OFZLb2E2TW1iaVNTSjZndWdLK1VDR3Izb21pRHBCazBlM1huU2dFVkxHMDF1?=
 =?utf-8?B?TEtDTGhQMVNqa2J3RmVzMmlhbjZ0eHlINjk4Ty9xZjNNSk9PL1ZrQlZxYXJz?=
 =?utf-8?B?Q2tlL3lha0lmbXpqZklyN1NlNGNZRGJQTjFWRkEzOEQ0ZEdYNUlBYW5iM2Vq?=
 =?utf-8?B?RndTNWFyc2VNRm5ZSTNUdDF5a1RzemVScWdiK2xIRG9JbVAyaVpWdTBlVnZ4?=
 =?utf-8?B?ZTc1UTRJQ3RkNEIrK0NvTWFDYXFJV2hjVFlMN0dnT2NRbE5kVGZqd1A3QTlj?=
 =?utf-8?B?bnFzODNGN0twNW1lSE1KU2YxV0lpd0ZtTDJVS21PNnNMWjM0Y3ppc0F3RXlh?=
 =?utf-8?B?dEFETlAzOTdDRytUOFBrY0RJQzU0SlZtN0ZEK1BJdVRvM2JCTzliUWJxWHlX?=
 =?utf-8?B?MWhHZno4aFRXZmJYMVlTSklQZGtKZXExbzEyWjdvakZra2ZCVUpzT1NJblZo?=
 =?utf-8?B?em0rMkRBN2daR2Vkd1Y2bmUwcXdrK2NoR2hveko0ODhqUndzWmlPMW8vc2Z2?=
 =?utf-8?B?UEs2bkJjWjB6K2krak5uU1lMc2lFeTlEQkFCSEhicU1ubXNYQmFMa2ljSEo3?=
 =?utf-8?B?cWdPb05aMVFqd0E1c2hFcUZ6UzNZcGhmaEVTbmRhb3czbDlsMWtUdUxmVlNJ?=
 =?utf-8?B?OUVzVDVCN0JGMzcxV0RIUHlDeWM3K3MrN25ZTXZwcTZPdVdSaXBtZnZENHFQ?=
 =?utf-8?B?d3NCWDdiSXNHWkZxa3d2WmMxejM1REpzSll6bGQ2NnFtUTBMSGJ4TlJEek5U?=
 =?utf-8?B?Ky9rZEEvNlpJQlBWSXppdXhFdjBvRWFTYllkQTdpWlZjZWprbW5pc0IwWmkx?=
 =?utf-8?B?bkhRUVI5cEp4bU1RdkRaMmkvSFkwTGtHYkE0ZVJoTytOTTgwSWVrempIYXVI?=
 =?utf-8?B?K3E1TUdURTZSbTlLUW5Qc3FieHlORnhQdUM0dUlCS3FvRi91dDJadkl1R0hE?=
 =?utf-8?B?U0lwVjAyaXVabklmaGhvYXhDZ1VaUVpET3dKNE1FVUNINDAwd3JldVRmMmdq?=
 =?utf-8?B?Lyswb25XV2JyMmpQbzNPMlovSUZRbjY4TzdHcTM3KzRmR3YzOUZKM04veWkz?=
 =?utf-8?B?bkI3LzRPdTRGQngvUms5ZUpjaUpZOFFaS1NtMCtGTW5ZV0oySDNIVU9FVzhk?=
 =?utf-8?B?WHBMc1pEQWhzdFhDeUpZMVQwc1hhTE4zRGVZaklaYi9LdVJtclFJL0ppNFYx?=
 =?utf-8?B?amswNTllaXVtUnZBcCs5aUxDNkNDUS9ndWM3VWZzYjRnWnZNM2MweGtXSmV0?=
 =?utf-8?B?VTFVZkJ3bGYwQkpQZXQya05RRndva3VJQUhZM2hzaXJPRExKTndMSldwMk1w?=
 =?utf-8?B?Rjc4eVpHa3c2YWN6TkpOcUk0Uk9LdUVxR21vQVI5MmZVTEZiNWQvemRPZzJR?=
 =?utf-8?Q?vK18IHra0UbG2z7Gka6dfXnR/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <210F10C4E4B1384EA40528F9DC07D7EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6de2ba-219f-4b07-925a-08da7c81c66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 16:43:24.7482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzuQKHcogdDJwpGLOxXBy29J4+4FUMWubfNL05XX5vRvlXzLClYllQlUVGSpokzX8bhFuaug1fU/aI/KsH34CgzxkebPVhnc7ZoiASSe7BY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1922
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMDgvMjAyMiAxNzozOCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+Pj4gTm8sIHRoZSBjb21t
b24gcHJvcGVydHkgJ2NkLWRlYm91bmNlLWRlbGF5LW1zJyBzaG91bGQgYmUgdXNlZCBpbnN0ZWFk
Lg0KPj4NCj4+IFNvIGl0J3MgYSBjYXNlIG9mICJ3aGF0J3MgaW4gdGhlIGR0cyBpcyB3cm9uZyBz
byBpdCBuZWVkcyB0byBjaGFuZ2UiPw0KPiANCj4gWWVzLg0KPiANCj4+IEZvciB0aGUgZnV0dXJl
LCB3aGVyZSBpcyB0aGUgbGluZSBkcmF3biBiZXR3ZWVuICJkb24ndCBicmVhayB0aGUgZHRzIg0K
Pj4gJiAiZG9uJ3QgdXNlIGJhZCBwcm9wZXJ0aWVzIj8NCj4gDQo+IERlcGVuZHMuLi4NCj4gDQo+
PiBPbmx5IGlmIHRoZSBwcm9wZXJ0eSBoYXMgY29uc3VtZXJzPw0KPj4gSSBkb24ndCBtaW5kLCBq
dXN0IHdhbnQgdG8gZ2V0IGl0IHJpZ2h0IG5leHQgdGltZSA7KQ0KPiANCj4gSW4gdGhpcyBjYXNl
LCB0aGVyZSBzaG91bGRuJ3QgYmUgYW55IGNvbXBhdGliaWxpdHkgaXNzdWVzIGJlY2F1c2UgdGhl
DQo+IG1tYyBjb3JlIGhhcyBzdXBwb3J0ZWQgdGhlIGNvbW1vbiBwcm9wZXJ0eSBsb25nZXIgdGhh
biB0aGUgZHRzDQo+IGV4aXN0ZWQuIElmIHRoYXQgd2FzIG5vdCB0aGUgY2FzZSwgdGhlbiB3ZSdk
IHByb2JhYmx5IGJlIHN0dWNrIHdpdGgNCj4gdGhlIHByb3BlcnR5IGluIHRoZSBkdHMgZmlsZS4g
VGhhdCBzdGlsbCBkZXBlbmRzIG9uIHVzYWdlIGluIHRoZQ0KPiBrZXJuZWwgb3IgZWxzZXdoZXJl
LCBpbiBkdHMgZmlsZXMsIHN0YWJpbGl0eSBvZiB0aGUgcGxhdGZvcm0gc3VwcG9ydCwNCj4gZXRj
Lg0KDQpDb29sLCB0aGFua3MgUm9iIQ0KDQoNCg==
