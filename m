Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEB256206B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiF3Qh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbiF3Qhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:37:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C353BF98
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656607074; x=1688143074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=outNlcMcm7pzLwuZhe135S+Y77y774t251Bbp3eoHLI=;
  b=nOdfd9P2K9AAR8NXF9NXYztVvWLUXWyUbDUINAwXOihT68+6eh6HZj6l
   01QfA0n8AMrTgyitQuDIMzIric6fIAF3ffHjD59/HupfXKqvr7UQH72lJ
   RLsqbGv0tK9L0Hitw+gl/NlVfBA2igwYkC/MXpTZl6zF3CxG/8lJ8IXyS
   n2QWXSj2bxPrKaAQXU7B5BKNUETy9VyFwU0SDWfDRPHuDoI/rwIZaBGGF
   5FBlDj/y3DAXYf7eI/CVnjDfwfzaJGFCMl04nI3l0g4v1NMqNxVKgSKnX
   dmknwB7C+J02SCxZQHwWsGTa6qAMAQQ5BauHrRaJIEPKpC1ha2sxrazaq
   w==;
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="102513353"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 09:37:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 09:37:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 30 Jun 2022 09:37:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtA4HyQFmLcjNHeJaFm27aTL+GWd81upBij8C/lOXMCoAnBq6pAs/svzgdcz8FlUXc+hnrOauav33mnOk0uZ56a8y5rRf31uNdakzULbCjtzvZAMe9/J2fp9z7fT8fmgLYUtrk+yis0Bu+USdkQYN/mGNEtUIDlodUR6Yo2N5HgwLFoXw6m8Eu77UepbY/oO/WBb704gomkVJinelVho2Rlgmriyk1jdZKFqEvu26xZs+T5+YH+fNHT7iCWKilMcrrBkgdpM11JcYrqTAmA/WfAKhP+CDe1iPwneDi4SpqlI8nvaTUpGLR7FRXJmdy3GnnQrbkS1jCRJtCndievqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=outNlcMcm7pzLwuZhe135S+Y77y774t251Bbp3eoHLI=;
 b=Y5Y0e9wTRF1a8ukqKSomeTiyPqYQ3FBk0DvotpP5DOXEInXtdDCk9Vm57BoRqapL7frioLL74hR7HXhtCeFU9di1WY9Qfmzh456uPaXDBm7KiRyeKTCzi47V8+DE4he7pxwzneh4hiGA5kwyq109EmvIch8eM6vYE9a7xfHh650XjhKgMkm1cNxXKbqNeTlxaZ+9Jpm7d1LwRVu5eREtORzVxV6bIj5AlBeXjNBILB+jhGx8mq7dk6J1XT2LYdlGExhwXA1gCUmPeGVGVD/O3JU19Y0tSBneSrBWQpXrz7OgqNx+WMofujI5yn92MIMsViGUyUdaWH568xwMoQ0/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=outNlcMcm7pzLwuZhe135S+Y77y774t251Bbp3eoHLI=;
 b=RBOzzRSSmgqi0/PXLfOM1tiD6Lm9PGU0Lvr7WsO7jMjF3bAcLQHCXASeLgenSloyjm4l1Roc0KYMogrxBW2S6wUaINZryS0WIw3CLro57Z55kZly1whm0PbFtZNoPwfMjZGMyKBQUz/wESV6xPltFp0bh2vOr4MmcPlT2KYRHz4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1234.namprd11.prod.outlook.com (2603:10b6:404:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 16:37:51 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Thu, 30 Jun 2022
 16:37:50 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <atishp@atishpatra.org>, <atishp@rivosinc.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <wangqing@vivo.com>, <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <gshan@redhat.com>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Topic: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Index: AQHYikaSsliGXUqkU0W62iFZL9A2pK1mrJEAgAAIIICAAAargIAAEAyAgAAEPgCAAAqJAIAAMFoAgAC8ZgCAAGP7gA==
Date:   Thu, 30 Jun 2022 16:37:50 +0000
Message-ID: <9d9e80b8-17e2-b1d9-14fa-f1d8d7dfbd9a@microchip.com>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
 <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
 <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
 <20220629184217.krzt6l7qadymbj6h@bogus>
 <f1f4a30e-7a84-30e2-197c-4153b3e66b64@microchip.com>
 <20220629195454.vbsjvcadmukiunt7@bogus>
 <03433f57-04ed-44a9-a2f6-5577df94f11e@microchip.com>
 <b2ab0ac1-bfef-5ba0-4ee5-15e604d8aa2e@microchip.com>
 <20220630103958.tcear5oz3orsqwg6@bogus>
In-Reply-To: <20220630103958.tcear5oz3orsqwg6@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d27202c-5fe8-48a7-a36b-08da5ab6df55
x-ms-traffictypediagnostic: BN6PR11MB1234:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eMDqJrC0AqOXr3aGiB8WsavQP2I2xzksmJ2qzw5EUASzaGVxuoO1xl+MAViFlBz//gIkt0fmhHIi9V7w2+E6Fu3dQdqdc46PVwr/MxSAs64JfO4+mCrflo1YEw1/rc3+r1BNmIkbOKzb9KAFB4UYKhg3JUbyj+2QtrYLwe91HZ46bPqmeQFdiU3ryZ4ZGt6wsWMuXBYdgFlxZmktdmrNqhnXyfvuLEf51P4JKYzT6j51DO/EEvXXn0QNyJmENSHOxLVg3q9xO0fxXXQ1zAWFVn9qLei6sh9ZKIPznDKxbxOZpdcuIZxNqkaMoB9o1wsHg0JCivv1Kzj1UJ6yOk6dtDxsrDvN3tZdWflgfEjkZmV+dEpg90Wg25Kw0S4EhdEh/f4q0anmYOCvDv1ft3Jos3rsLFVPZXTEAy6CRgLeWZHeqAy2yLDo6mVhny/JdtUsO01jaoq7KnYliXGmzyKDMgR5C01j58OmafzGLh/ejiCu6BDcPLcJ3W74Hx6+nGRbgFnEI6Ky3BuYdlJw6yi+Ev3iBh4+ry/9jHezG7dDHmbpZnS6pMdulJWfy0GmkwpoFb6dkhteIK6ix5Vo5BhUbSA0+ZTMpzbtqzqJh5onwhlPG9FzK6/khPnejTFI4TAz7EfAHnaxnNwoghKuRy7tC0l10GBcuvd3q5r8JDAFMCVS1b15XyiyOL5C3RbUxjQXPfihKslvQm5gkYiEYPVQ/wQSP9Vu8qQEaAmH2+DeEDJd5loPlRDHUNAb0BqcXWPq7KGPqmR2vs6Js/m6e7szeWl3O5UXQ1h/ckWGgZZp9xSB2zZgLPi/X0WaGq+cR3PtgRDT0UnDVO2Yk4CDfop2nmLtkOglzwYGF5nNlJz+aPj6fq7qFmcrm8dVWfqBSn5lNvqjbScj4pPV1OEiTyApvSFyIGtQgo0g5PU4PVLze1I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(346002)(39860400002)(376002)(36756003)(31696002)(86362001)(7416002)(41300700001)(83380400001)(38100700002)(2616005)(6512007)(26005)(53546011)(6506007)(186003)(122000001)(107886003)(66574015)(38070700005)(66476007)(316002)(64756008)(54906003)(966005)(76116006)(6916009)(4326008)(478600001)(66556008)(8676002)(91956017)(71200400001)(6486002)(66946007)(2906002)(31686004)(5660300002)(8936002)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R251cDFjbFo2ZHpwaktUckhWOTFCVmNwOGdkSFBybkt2SVBvOW40c0JmUitG?=
 =?utf-8?B?RGpCcUVaTTF5eElLb0VUZVlUcC94alJBTU13bG5yRkQ4V1R4U0VDVHRUL2FH?=
 =?utf-8?B?MWNnWVlzc0N3MEloM2psakhkSXgwUGdwSjRWNmcwc293b3pJZWhldEUvdjBO?=
 =?utf-8?B?Z2kvVGlEallwWnh0TFBGQk44L0U2VDNKVWdXamYzaHlkdWk0ODBkSmNndmlM?=
 =?utf-8?B?N1pYcFFpRUlEYnNSeTRDTnoyVWltOUg4dVBzbGZYUnVZcGdjSFlYQVFkTWtB?=
 =?utf-8?B?ektScUk5ekp1WnY2ZjN5OG9NNWZSR1V1YWdPSXlxRzVnOXF4TnBIemltUE5O?=
 =?utf-8?B?eFRjNDZscUxqNWROekVSazlIb1JzVWhPcGlOcWFDRlFBVFBlWVlWLzR1R3J4?=
 =?utf-8?B?aTVXcTN0dEhRTEZxS2lJTnZubXF4SGxiQk45K3RzWUNzckRZeHV2V2FIMkVt?=
 =?utf-8?B?dlUzN2ptaXpleTM0NTZrSkV3aG9KOGM1SmRTL0NUL0FhdEZ3MzE3Vk1mR2pB?=
 =?utf-8?B?TkNlY1MyZEJlU3poTmo3MndRM0lPd1JPM1JtSGh1MXBaS1ZEczJXZGw4eG5i?=
 =?utf-8?B?NytTaHA0dHR1YklSNno0ZWV5dFNGeEcrYmZwUFhEVXllQk9SU1pGOEd4TDdM?=
 =?utf-8?B?Vk4xemp3cS9SWEExMHRDZE8vMWlxRTh4Y09QczBSdjRvNkNLSGpRQ25wK2dJ?=
 =?utf-8?B?cTlEYy9KVHZ3LzVkNWdXTDRFeTlJdUV3b0tZOENxT0FYRWkrMmlOUmtHYVlQ?=
 =?utf-8?B?OEJNUFY5UkR3Q09Sd2lTdTgyMTVaWVN5RXh3YTFvSGNDOHkwZzltaGp1WDVk?=
 =?utf-8?B?RVVhMUFRWThlb3ZDN2VQb2U4VnZ4VDFML3JpWmhyekhvenVqajNqRkI4c3Mz?=
 =?utf-8?B?Qy9ZM1JkRFUrYjExb1lyMVpLVDU4YkFGS2ZnTVlKb2NVZm05WWU2RFU3Kytx?=
 =?utf-8?B?YlFDQXoxN0RkZGhmSk9OYVVqWTEvNm1IUzNsd0QxMnQ2VnBXVXVubmFsN3BV?=
 =?utf-8?B?YUZIS2ZUZmFwUVpVOEVqUGFzRExRYkYyblU0bWIzbUJwYU1YckxENzJLcXlW?=
 =?utf-8?B?UnhCaTZVWjNiS0hKRG5WM3hWT0M3ckdoWGJ1Mm51cW9BcjlwZmtaU0J2T05H?=
 =?utf-8?B?Y1pmWnF1S3hLWW5ON2JsWGVLS2NaQ05JNVdMT3FWNUtxUVduMGtrWUFqcGUy?=
 =?utf-8?B?YlhzQzkzRjQ4bzl2S241QVF4MldyK3FUcUdNTG5wUzRXNk9mTWI3ckc5dmNL?=
 =?utf-8?B?SFhJd00zb1dqZllseFZPWXE2MFpwUzRaSWFKb0VESkZWdXVHcDZ6b29EV0lk?=
 =?utf-8?B?b0JkMHN3NyszNWhZR2cyYTgrcnp6dU5PSG9SbWlaN0FyeFZ4dlpxWmhSekt6?=
 =?utf-8?B?UWQvbVo5VXlKUzNubUo3L2tXbE1GTXgzSG5lNWg2bzQvbCtXOXVNRVB6WnpR?=
 =?utf-8?B?ZDZJU1l4VURoSWdVNjYzNlBhK0oxQjEyY3paTWdiZmpidWdrUS9TdXlxclF6?=
 =?utf-8?B?MllKVXhmaUprTnRJODNtSi90Mk05WWIvZ1Q5eEJtbU9GT3UveFFYRFRhOHlJ?=
 =?utf-8?B?dTE4RmRRRW5lR3Zzbnl5R0cwaGJXbGFtMXF6MFBjcmF0R0lXTzhZWE1Xaitq?=
 =?utf-8?B?S1A4T2hQNlRIaUl4enBhZmd0WVN6aU9QbFRlK3RGMnpkSjZ5TUZaSStscUoy?=
 =?utf-8?B?T2x1d1hveE9hcENSQmNNWkxzZk1NTmhTOFNYcS9QdDdIYS9JNzRvYWIrYld0?=
 =?utf-8?B?UWtyVU1qRnJ2NjBFUUtTRzExRXRrUWZYdk43VG9ZMUUyWGpyQk1wdWNMOWpZ?=
 =?utf-8?B?NTFUcWl0b0paekhiekxCc1hENWdnNGhSSS9LcnEydTN0RWEwNk9aUzVqcElz?=
 =?utf-8?B?ZGdWV21Td0o0VlRiUjFHcWozWGFDRlRwNk9zQWRGUEdvZmpRWHR5TDNjSFRM?=
 =?utf-8?B?RG1GRHFWOTFJNTBkcDlMbnFwNmFiSE5TdGdrSzRhU3lvaTF0TVpYWXhhZ3VY?=
 =?utf-8?B?SkRueVFYWnlQUHQ1TWxmdU1IK1p4WGNVK01yL0tFSVVyK2RYYTA2UmVTR0ND?=
 =?utf-8?B?NVBiMDB6ZUw1b0lSZGtFellZUytmSDhnSHJsTmtwYUUyWVdJb0ZnNDMxeUNP?=
 =?utf-8?B?UmExeWk2R1RxbEdxNW1SdWN3YUgvaU1xV3F6SW1VVDZPYW1jeWlVZE5EMHJy?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDB7B7AF1607C745A214FE282A0E0DE7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d27202c-5fe8-48a7-a36b-08da5ab6df55
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 16:37:50.3200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvFaAv0ipJZNfNOsASerbWVE7z3sRNuFde7XcNaQ62pQU36QopiUETkSHBhiIseoiH6hW7PDEA1RU5EwMaRnNhWQ7XtZvFUT/AAO9JgU1Nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1234
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDYvMjAyMiAxMTozOSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwgSnVuIDI5LCAyMDIyIGF0IDExOjI1
OjQxUE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMjkv
MDYvMjAyMiAyMTozMiwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiAyOS8wNi8yMDIyIDIw
OjU0LCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZQ0KPj4+Pg0KPj4+PiBPbiBXZWQsIEp1biAyOSwgMjAyMiBhdCAwNzozOTo0M1BNICsw
MDAwLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4+IE9uIDI5LzA2LzIw
MjIgMTk6NDIsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4+Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4+Pj4+Pg0KPj4+Pj4+IE9uIFdlZCwgSnVuIDI5LCAyMDIyIGF0IDA2
OjE4OjI1UE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+Pj4+
Pg0KPj4+Pj4+PiBObywgbm8gaXQgZG9lc24ndC4gTm90IHN1cmUgd2hhdCBJIHdhcyB0aGlua2lu
ZyB0aGVyZS4NCj4+Pj4+Pj4gUHJvYiB0ZXN0ZWQgdGhhdCBvbiB0aGUgdGhlIGxhc3QgY29tbWl0
IHRoYXQgYmlzZWN0IHRlc3RlZA0KPj4+Pj4+PiByYXRoZXIgdGhhbiB0aGUgb25lIGl0IHBvaW50
ZWQgb3V0IHRoZSBwcm9ibGVtIHdhcyB3aXRoLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBFaXRoZXIgd2F5
LCBib290IGlzIGJyb2tlbiBpbiAtbmV4dC4NCj4+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IENhbiB5
b3UgY2hlY2sgaWYgdGhlIGJlbG93IGZpeGVzIHRoZSBpc3N1ZT8NCj4+Pj4+DQo+Pj4+PiBVbmZv
cnR1bmF0ZWx5LCBubyBqb3kuDQo+Pj4+PiBBcHBsaWVkIHRvIGEgSEVBRCBvZiAzYjIzYmIyNTcz
ZTYgKCJhcmNoX3RvcG9sb2d5OiBVc2UgdGhlDQo+Pj4+PiBsYXN0IGxldmVsIGNhY2hlIGluZm9y
bWF0aW9uIGZyb20gdGhlIGNhY2hlaW5mbyIpLg0KPj4+Pg0KPj4+PiBUaGF0J3MgYmFkLiBEb2Vz
IHRoZSBzeXN0ZW0gYm9vdCB3aXRoDQo+Pj4+IENvbW1pdCAyZjdiNzU3ZWI2OWQgKCJhcmNoX3Rv
cG9sb2d5OiBBZGQgc3VwcG9ydCB0byBwYXJzZSBhbmQgZGV0ZWN0IGNhY2hlDQo+Pj4+IGF0dHJp
YnV0ZXMiKSA/DQo+Pj4NCj4+PiBJdCBkb2VzLg0KPj4NCj4gDQo+IEkgY2FuJ3QgdGhpbmsgb2Yg
YW55IHJlYXNvbiBmb3IgdGhhdCB0byBoYXBwZW4gdW5sZXNzIGRldGVjdF9jYWNoZV9hdHRyaWJ1
dGVzDQo+IGlzIGZhaWxpbmcgZnJvbSBpbml0X2NwdV90b3BvbG9neSBhbmQgd2UgYXJlIGlnbm9y
aW5nIHRoYXQuDQo+IA0KPiBBcmUgYWxsIFJJU0MtViBwbGF0Zm9ybXMgZmFpbGluZyBvbiAtbmV4
dCBvciBpcyBpdCBqdXN0IHRoaXMgcGxhdGZvcm0gPw0KDQpJIGRvbid0IGtub3cuIEkgb25seSBo
YXZlIFNvQ3Mgd2l0aCB0aGlzIGNvcmUgY29tcGxleCAmIG9uZSB0aGF0IGRvZXMgbm90DQp3b3Jr
IHdpdGggdXBzdHJlYW0uIEkgY2FuIHRyeSBteSBvdGhlciBib2FyZCB3aXRoIHRoaXMgU29DIC0g
YnV0IEkgYW0gb24NCmxlYXZlIGF0IHRoZSBtb21lbnQgdy8gYSBjb21wdXRlciBvciBpbnRlcm5l
dCBkdXJpbmcgdGhlIGRheSBzbyBpdCBtYXkgYmUNCmEgZmV3IGRheXMgYmVmb3JlIEkgY2FuIHRy
eSBpdC4NCg0KSG93ZXZlciwgTmlrbGFzIENhc3NlbCBoYXMgdHJpZWQgdG8gdXNlIHRoZSBDYW5h
YW4gSzIxMCBvbiBuZXh0LTIwMjIwNjMwDQpidXQgaGFkIGlzc3VlcyB3aXRoIFJDVSBzdGFsbGlu
ZzoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2L1lyM1BLUjBVajFiRTVZNk9A
eDEtY2FyYm9uL1QvI201MjAxNjk5NmZjZjVmYTA1MDEwNjZkNzMzNTJlZDhlODA2ODAzZTA2DQpO
b3QgZ29pbmcgdG8gY2xhaW0gYW55IHJlbGF0aW9uLCBidXQgdGhhdCdzIG1pbnVzIDEgdG8gdGhl
IHBsYXRmb3JtcyB0aGF0DQpjYW4gYmUgdXNlZCB0byB0ZXN0IHRoaXMgb24gdXBzdHJlYW0gUklT
Qy1WLg0KDQo+IFdlIG1heSBoYXZlIHRvIHRyeSB3aXRoIHNvbWUgbG9ncyBpbiBkZXRlY3RfY2Fj
aGVfYXR0cmlidXRlcywNCj4gbGFzdF9sZXZlbF9jYWNoZV9pc192YWxpZCBhbmQgbGFzdF9sZXZl
bF9jYWNoZV9pc19zaGFyZWQgdG8gY2hlY2sgd2hlcmUgaXQNCj4gaXMgZ29pbmcgd3JvbmcuDQo+
IA0KPiBJdCBtdXN0IGJlIGNyYXNoaW5nIGluIHNtcF9jYWxsaW4tPnVwZGF0ZV9zaWJsaW5nc19t
YXNrcy0+bGFzdF9sZXZlbF9jYWNoZV9pc19zaGFyZWQNCg0KWWVhaCwgSSB3YXMgcGxheWluZyBh
cm91bmQgbGFzdCBuaWdodCBmb3IgYSB3aGlsZSBidXQgZGlkbid0IGZpZ3VyZSBvdXQgdGhlDQpy
b290IGNhdXNlLiBJJ2xsIHRyeSBhZ2FpbiB0b25pZ2h0Lg0KDQpJbiB0aGUgbWVhbnRpbWUsIHdv
dWxkIHlvdSBtaW5kIHRha2luZyB0aGUgcGF0Y2hlcyBvdXQgb2YgLW5leHQ/DQpGV0lXIEkgcmVw
cm8nZCB0aGUgZmFpbHVyZSBvbiBuZXh0LTIwMjIwNjMwLg0KDQpUaGFua3MsDQpDb25vci4NCg0K
