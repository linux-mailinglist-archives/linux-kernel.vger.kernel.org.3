Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA87958DFAC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245759AbiHITDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345368AbiHITCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:02:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA526AF9;
        Tue,  9 Aug 2022 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660070214; x=1691606214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oa+JS2vzNWPUbk22H8ZYSLpSJlnr+TTLiOt0aBSL1/0=;
  b=T8UAOFumRPPHC2AIueNQa/a6SleO0icj351LqeDsr3YWIrJ5QdAOGlz+
   /FcuM24Mq0g1uljWsF4Y4py1ZHYYvslTyNfevZAhRaUkDg1MGxfzH3d8h
   fUz/dEwOamLIkvwU26Jv/O+RJpwbOX8vcczFP1HyAI/9b3KTp423ewglK
   IMiIZrgx+/xMTgpX7gPy8cuEtvUkOznqWmUS9iOdc34jbjKBVlidG4kbq
   kp/DW5N28I7QO88DjCzDLM+2yPXpd9Ycxn8OouAy8DAgFg+jp1CgO412Q
   hVDM91hVKs3GR/Ow/T0pFsVMqmCsfwESowZbTy8zdve6TZ1r/sL3E0FIs
   A==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="175725462"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 11:36:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 11:36:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 11:36:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEFB1nSVcXrSVV1MxHeCmBYqA49fD3ga8kJz2KIkRH86KF6nwcovPBEnObEXGhnsowbvMDnpTINX7IhN5zxCPHnDruuBicp0h0GA/VgHuoaNFna4fXSEOs/gS9afDDqsKPDQ91RyY70pwsTOaIWLmYNXgKSzoko6KV+4034+Ik3gGKrtlDh9C3FLayiQQfsMfJRdOP49gXIexGrTGfLQES2FUy4/qJMpebUwccStT/DqaUSJSxRBsxaCndaXGd6L34GjLPY1CmKtYNopAKRGZQvMq2l+cUlvzuDBEm2oFL3oBMfgtMRYj6Cyuq2BBwj5yxF2tywOQtiQIcoRzs02oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa+JS2vzNWPUbk22H8ZYSLpSJlnr+TTLiOt0aBSL1/0=;
 b=b3aaHkJSazeW4Q3KE1ZcpXj3BmaiffZOpqVDt+5Dvikj1CJS8/63/3+baMOEc4JQ9w3Rg2gcAkwQCGz6X2REgOtkUfR6iCFKjaNqF6L/DejncWPpMk85zmUbylsH8skPwxWOYyBMsvACqzpjGJ3WvDjrKy/kf0xkRwsMF9SqG8e64xrKQEOISZKkMLMZB2hyRPUKmQUkC6Cb+R7hpGQBvx1RVLZqqeAGGRbupVrmIKNALjpzaJnQwJdHkjVKNmr3H1aIzUV4NNSgunYcvSWsuS1/6HJAL7Qka57rek7BBw8PzU6U6HErvM9ijPs6BwKE+wIed1sHU0tb/JahazD6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa+JS2vzNWPUbk22H8ZYSLpSJlnr+TTLiOt0aBSL1/0=;
 b=B0UBv3JwM4X608akkyEY61SupfbIm0rz0ldtxdOppwlv+nqrZLIq+hl70k6hXxxFN2acwGQZW7qNMOVa0kHmP8fowEQo6CF4OhngYtI3laCd15esRkXjsHV7gE60N3PybybSG8qwuQEShKYEtNER+F3uUVqsxZHAnvdvQ6My5P4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB0069.namprd11.prod.outlook.com (2603:10b6:910:79::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 18:36:46 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 18:36:46 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jrtc27@jrtc27.com>, <robh@kernel.org>, <palmer@dabbelt.com>
CC:     <tglx@linutronix.de>, <maz@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <daniel.lezcano@linaro.org>,
        <anup@brainfault.org>, <guoren@kernel.org>,
        <sagar.kadam@sifive.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <qemu-riscv@nongnu.org>
Subject: Re: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Topic: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Index: AQHYqOiQvE59vmIAhkiZ1sZQKraNy62li3AAgAAHfICAAQ/4AIAAST8A
Date:   Tue, 9 Aug 2022 18:36:46 +0000
Message-ID: <61829ccd-20d7-e2f0-0a6b-bcd0e076b9ea@microchip.com>
References: <20220805162844.1554247-1-mail@conchuod.ie>
 <YvGBYKZyW0B2/wSr@Jessicas-MacBook-Pro>
 <94fe7e46-6156-1cc5-a4dc-1eee78e99bc4@microchip.com>
 <20220809141436.GA1706120-robh@kernel.org>
In-Reply-To: <20220809141436.GA1706120-robh@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5200e0fc-52cc-4f1e-1f81-08da7a361d4b
x-ms-traffictypediagnostic: CY4PR11MB0069:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pPmyie5jB4KKXBNHfTJyUcDjmhHFWiGYr1+YPEVmh3dP+Wiabu7vVDFzlRYRdVsDkBY+e2CQEuna8P/OXgW2J2LjACF79fVYQIn8WAZyF880HudEBVdJ46cUV977G9pYZm53rcZhAp7vvQJMyygHpGBWBkN2oNMYaBliB+Vt/5ggEadOoGsz/KLn8X8G9la27TxV+hOhdGO+PWkpelHON9gWDJP7aU0JZWXQ1G6S6Q2UH8CagMwd054aveEc/uLfh1C+EHN5zbwzYclovxxVxVQvF37oXzkzSU8IRvnRVEXwzVJ/7QlJKwsdC7JLszgMBYRqiC/yRbrF221XFpnZPu4zqCd+hhayTOj3jnbsqnkf/DCge5pVuc4UNapiYe4ImYAsLdtu4KPPRRKXgO6ddwWQxorFi/HZmP9MHuDi3KW2u9qRbtS5/lzPZtmS/ctFTbM6kby7I9GJCKugxarPz0PVElMwyqKjmpp9xYn1YVEK6bfuotHz721Wj4znPxAA0BzHkEUVSD9Nsw9mfrt0uLUwrseftY72WmcaR5oiF3pzfCu13Eqo080O5MiDyktK6fYnn2d/DsmCHzuDDL2Dn5vc8Kp5AlfK+spfPpp8KjJBpfzGa8m/F4ZtvClf4qW4retIDPBLnKNIh/ibSGsBc6I4hhbtcNdQOUS4kOB/iurQUveZn4ZHAx3f90srocSK+Q7lzoSV+XU6Ag3aLUb1nryol1GlG9x3jWS25aS5O+IwJVDRMRUcy0J0hzeFPBcW+A+CduF+5yLIVlbFp+wnaZm0KddwVTMquQ1rf6atKAn5/yHB+PLA6cEje6o6a8Tch3lfDLd7d7g7cj1ETyUcv45vSJb/ZdCcIwa5ZapIMaHcfcTN4zUOiAOVotanL8w7SAsKyB4UUHlhFXxeudTqng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(366004)(396003)(136003)(66946007)(38070700005)(83380400001)(186003)(2616005)(71200400001)(76116006)(31686004)(316002)(91956017)(36756003)(110136005)(54906003)(6506007)(4326008)(6486002)(53546011)(6512007)(2906002)(31696002)(86362001)(26005)(8676002)(478600001)(64756008)(66446008)(66476007)(66556008)(8936002)(5660300002)(38100700002)(122000001)(15650500001)(7416002)(41300700001)(45980500001)(43740500002)(569394003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGFSWTlWNGM4eHJXTFRYZ2JBQmtkWGcxQlBMZjJxb29SeEhMc0JQa05qczcx?=
 =?utf-8?B?czkzalNzNU5wb1lSYXllell3TGgwanp1YWhsMzRJZTVjb1VGSldMV1FUTzV2?=
 =?utf-8?B?RTU3aWhXbzBJS2JnZE1rYU1IaHNxeVh6dDZVSS9JRnFHS211M3RkRzEwbUk2?=
 =?utf-8?B?a2RXb2gxNzJvTjdFb2ZIdjFDajE2Z2VuTHRuc3d2c3pWT0YwLy82alR3SVZJ?=
 =?utf-8?B?ZlJhNWZ0TDJkOCtCMkdzNzNIZVRjRWxtZVNnRVlyOEY2cUh3TGZYZGpkclRF?=
 =?utf-8?B?RW1xWEZWQkhTT1Z0UjVhMUlaNlNQdjRoYldZSmtqakNuN0JmcDFCNHBoR1Yw?=
 =?utf-8?B?MmxWblUrRFA5Q1VQRW8rZVdSY0hnbTRrbUN5aGpOQjhqakpyWCtIeVBCL3d2?=
 =?utf-8?B?Mkl5SUQ5SHBaN0Q5dGoxbmZKYmNpWm1qT1NGSis5ZGF2UFE3OFp5azJtOVZy?=
 =?utf-8?B?OHlZeHl4enZjanYrdDluWlp4WVhHcUtoR3VKeUlRMmRiaU0vZ1Q5UFZQM2Ji?=
 =?utf-8?B?UkZWMXdhNXVqbVoyaHZxQXkwdXY2MVhmUStCYWN5RS8zNTFpcTVPSm1GQ0xC?=
 =?utf-8?B?NVZjQTZwYk1Ca3A2OGdoQmkrdllqVG56N3RMZlhsWGpwcFMrN01KTEczQ0o1?=
 =?utf-8?B?QkkzU0hRWGc0Vjd2MzZVUEs5NzRhR1doazhGRFZvNjEzeExzczZjNFUwenRI?=
 =?utf-8?B?Nis3T1A1dGhZanhEZ1ZOZXFkRjB4L0ZsYWd3ZEhIQ01QcjFrV3lzdGRhdlhv?=
 =?utf-8?B?NCsxL3lvdkJMVm9uN0FQY3NzSFo1Rk9JUE9PRkgrWllNV1hUTWxvVW94VTNu?=
 =?utf-8?B?bVZjc2ZWNkM1ODhwNXZZUkQ1eWFxdm1FMk1Qcm5QcjJJbm1KK2lqOFpjMys1?=
 =?utf-8?B?ZVNlRUhnZHNQU0JVWUx4eDkrdjNFUG9YeFNZbWZBaHFqYXQwbTJaUFhUbzRV?=
 =?utf-8?B?dW1sa081ZUs1TzlPUWJ0RUF3elR2ei9SSnlkaDlFclhPeHc0SkNHdEtaN3k4?=
 =?utf-8?B?Y01YaGpwSkV1ZlpVUFRaNTVjc2YxeEZsc3pLN0dMQVYzY05SbElBZlo0MFhI?=
 =?utf-8?B?eUJJa0FMRXVpVy9uNzNXcDNnRC9wTEVabXM2VWF2emlXZFAwUkJLWFY2NWNp?=
 =?utf-8?B?RFdRV2JRRzFCTFptRHNHL09XdWJGcVN6U3RjQ2JGbkRIeGhHWmt5R3g1d1Jv?=
 =?utf-8?B?V25Ec3p4M2xQM01FY0VkT1hyRGV1MkY2akhFcENDYmVyZGYvUmpOdlFrQzhT?=
 =?utf-8?B?WEhSR3lCQ0tHQy95UEhqSEpwV3V1eVJGYkJlTmNQNzZHdnJxMks3NXRRVTlH?=
 =?utf-8?B?TlYvbjhwSUtZQmNBMy9TcXJGVnlIWVpqLytDVlozK3pBdXZuMVJqSW95MDMv?=
 =?utf-8?B?dG5rNVp3b3VSb0YzYUpseU1VTmlGeU0wU0lUUUM5MUliekxsMkZZbEpRdFdw?=
 =?utf-8?B?OWlBcDJKNGhDanYxeUVCcjFHRTVETVhPeWZIL3JGOVh2Wm1yN2U5dmRiSnhK?=
 =?utf-8?B?K2o1Y0hzZHh1S1VUeGhHd3E3R010aVRPZTMxUDg4OXVnUytaUkVTQXA2NjNz?=
 =?utf-8?B?QXlyMjg0QVVJZVoxM0g4YnBPbElzbldBd0VkaHYyRGdsQWQ2NmtFWm1BU2xL?=
 =?utf-8?B?OFFiNHZZcHdPT21Zc3MrNFdyVWgwR0NhSCtSWmV6QUFDcVJTZkoyTnpzQzQv?=
 =?utf-8?B?UWZtTXFTcjlqc0xOQ3VQeTlpbWR6a29WS21KS3FVelBIMWJDSUtCa3lLd0VX?=
 =?utf-8?B?d1dVOTk1Wjk3RGhkNm55NHpTUk5wdWZ1cmNlQlYrTFpDMDhYNUJYSXcrTWxK?=
 =?utf-8?B?YTdvUGc2ektDMzhqa25TVElZSE4zdlpkU1l6b3dlZSt3cDEvVkdWTEdLTTNK?=
 =?utf-8?B?bDlUZ2ZCS2h6SEFPZHA5U2c4aWJ2Y0pTVWh1UkdZSVZ3TEUxdk1vdnk0WHlS?=
 =?utf-8?B?U0lJNlkwaDlwY3U0UStJckNaQzJHb1ZER0dFendITG9jN1pGZ05tS0pHeFQ2?=
 =?utf-8?B?bm50bHZGNzJOYXBMTS96OXZYdjBDZWNZRHdPdDBzNnc4cExuMG9NcGEzV2tD?=
 =?utf-8?B?RzJZTFJOUkU5Nk8wNTVTT2NSS3FvSGw1UXRCRjF3K09UaGFna25LS05IZzNa?=
 =?utf-8?Q?Gxk8p4Uv+Rt5Kou6ZCpNqDK21?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C485E8E9E8BEF646B41C637E9D9476BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5200e0fc-52cc-4f1e-1f81-08da7a361d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 18:36:46.4319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zveljDAZtBIuN9wNCCe3gTo/o6QEvwIT3RZ3F+eQQZYggK/YTnRVvTQs+RCUBhgbfEGg9mDka3cuHwSLr1abBbJi8gd7P+y+wpmbNb+bMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0069
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDgvMjAyMiAxNToxNCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIE1vbiwgQXVnIDA4
LCAyMDIyIGF0IDEwOjAxOjExUE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPj4gT24gMDgvMDgvMjAyMiAyMjozNCwgSmVzc2ljYSBDbGFya2Ugd3JvdGU6DQo+Pj4g
T24gRnJpLCBBdWcgMDUsIDIwMjIgYXQgMDU6Mjg6NDJQTSArMDEwMCwgQ29ub3IgRG9vbGV5IHdy
b3RlOg0KPj4+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29t
Pg0KPj4+PiBUaGUgZmluYWwgcGF0Y2ggYWRkcyBzb21lIG5ldyBJU0Egc3RyaW5ncw0KPj4+PiB3
aGljaCBuZWVkcyBzY3J1aXRpbnkgZnJvbSBzb21lb25lIHdpdGggbW9yZSBrbm93bGVkZ2UgYWJv
dXQgd2hhdCBJU0ENCj4+Pj4gZXh0ZW5zaW9uIHN0cmluZ3Mgc2hvdWxkIGJlIHJlcG9ydGVkIGlu
IGEgZHQgdGhhbiBJIGhhdmUuDQo+Pj4NCj4+PiBMaXN0aW5nIGV2ZXJ5IHBvc3NpYmxlIElTQSBz
dHJpbmcgc3VwcG9ydGVkIGJ5IHRoZSBMaW51eCBrZXJuZWwgcmVhbGx5DQo+Pj4gaXMgbm90IGdv
aW5nIHRvIHNjYWxlLi4uDQo+IA0KPiBIb3cgZG9lcyB0aGUga2VybmVsIHNjYWxlPyAoTm8gbmVl
ZCB0byBhbnN3ZXIpDQo+IA0KPj4gWWVhaCwgdG90YWxseSBjb3JyZWN0IHRoZXJlLiBDYXNlIGZv
ciBhZGRpbmcgYSByZWdleCBJIHN1cHBvc2UsIGJ1dCBJDQo+PiBhbSBub3Qgc3VyZSBob3cgdG8g
Z28gYWJvdXQgaGFuZGxpbmcgdGhlIG11bHRpLWxldHRlciBleHRlbnNpb25zIG9yDQo+PiBpZiBw
YXJzaW5nIHRoZW0gaXMgcmVxdWlyZWQgZnJvbSBhIGJpbmRpbmcgY29tcGxpYW5jZSBwb2ludCBv
ZiB2aWV3Lg0KPj4gSG9waW5nIGZvciBzb21lIGlucHV0IGZyb20gUGFsbWVyIHJlYWxseS4NCj4g
DQo+IFllYWgsIGxvb2tzIGxpa2UgYSByZWdleCBwYXR0ZXJuIGlzIG5lZWRlZC4NCg0KSSBzdGFy
dGVkIHBvdHRlcmluZyBhd2F5IGF0IHRoaXMgYnV0IEkgaGF2ZSBhcnJpdmVkIGF0Og0KcnY2NGlt
YWY/ZD9jP2g/KF96W2ltYWZkcWNidmtoXShbYS16XSkqKSokDQoNCkkgc3VzcGVjdCB0aGF0IGJl
Zm9yZSAiaD8iIHRoZXJlIHNob3VsZCBiZSBtb3JlIHNpbmdsZSBsZXR0ZXINCmV4dGVuc2lvbnMg
YWRkZWQgZm9yIGNvbXBsZXRlbmVzcyBzYWtlLiBTbyB0aGVuIGl0J2QgYmxvYXQgb3V0IHRvOg0K
cnY2NGltYWY/ZD9xP2M/Yj92P2s/aD8oX3pbaW1hZmRxY2J2a2hdKFthLXpdKSopKiQNCg0KSSBj
aGVja2VkIGEgY291cGxlIGRpZmZlcmVudCAiYmFkIiBpc2Egc3RyaW5ncyBhZ2FpbnN0IGl0IGFu
ZA0Kbm90aGluZyB3ZW50IHVwIGluIGZsYW1lcyBidXQgbXkgcmVnZXggc2tpbGxzIGFyZSBmYXIg
ZnJvbSBncmVhdA0Kc28gSSdtIHN1cmUgdGhlcmUncyBiZXR0ZXIgd2F5cyB0byByZXByZXNlbnQg
dGhpcy4NCg0KQW55d2F5cywgdGhpcyBwYXR0ZXJuIGlzIGJhc2VkIG9uIG15IHVuZGVyc3RhbmRp
bmcgdGhhdDoNCi0gdGhlIHNpbmdsZSBsZXR0ZXIgb3JkZXIgaXMgZml4ZWQgJiB3ZSBkb24ndCBj
YXJlIGFib3V0IHRoaW5ncyB0aGF0DQogIGNhbid0IGV2ZW4gZG8gImltYSINCi0gdGhlIG11bHRp
IGxldHRlciBleHRlbnNpb25zIGFyZSBhbGwgaW4gYSAiX3o8Zm9vPiIgZm9ybWF0IHdoZXJlIHRo
ZQ0KICBmaXJzdCBsZXR0ZXIgb2YgPGZvbz4gaXMgYSB2YWxpZCBzaW5nbGUgbGV0dGVyIGV4dGVu
c2lvbg0KLSB3ZSBkb24ndCBjYXJlIGFib3V0IHRoZSBlIGV4dGVuc2lvbiBmcm9tIGFuIE9TIFBv
ViAodGhpcyBjb3VsZCBiZSBhDQogIHZlcnkgZmxhd2VkIHRha2UuLi4pDQotIGFmdGVyIHRoZSBm
aXJzdCB0d28gY2hhcnMsIHRoZSBleHRlbnNpb24gbmFtZSBjb3VsZCBiZSBhbiBlbmdsaXNoDQog
IHdvcmQgKGlmZW5jZWkgYW55b25lPykgc28gaXQncyBub3Qgd29ydGggcmVzdHJpY3RpbmcgdGhl
IGNoYXJzZXQNCi0gdGhhdCBhdHRlbXB0aW5nIHRvIHZhbGlkYXRlIHRoZSBjb250ZW50cyBvZiB0
aGUgbXVsdGlsZXR0ZXIgZXh0ZW5zaW9ucw0KICB3aXRoIGR0LXZhbGlkYXRlIGJleW9uZCB0aGUg
Zm9ybWF0dGluZyBpcyBhIGZ1dGlsZSwgbWFzc2l2ZWx5IHZlcmJvc2UNCiAgb3IgdW53aWVsZHkg
ZXhlcmNpc2UgYXQgYmVzdA0KDQpTb21lIG9yIGFsbCBvZiB0aG9zZSBhc3N1bXB0aW9ucyBjb3Vs
ZCBiZSB2ZXJ5IHZlcnkgd3Jvbmcgc28gaWYge3NvbWVvbmUsDQphbnlvbmV9IHdhbnRzIHRvIGNv
cnJlY3QgbWUgLSBmZWVsICoqKm1vcmUqKiogdGhhbiBmcmVlLi4gDQoNClRoYW5rcywNCkNvbm9y
Lg0KDQpwYXRjaCB3b3VsZCB0aGVuIGxvb2sgbGlrZToNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9jcHVzLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3YvY3B1cy55YW1sDQppbmRleCBkNjMyYWM3NjUzMmUu
LjFlNTRlNzc0NjE5MCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9yaXNjdi9jcHVzLnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9yaXNjdi9jcHVzLnlhbWwNCkBAIC03NCw5ICs3NCw3IEBAIHByb3BlcnRpZXM6DQogICAg
ICAgaW5zZW5zaXRpdmUsIGxldHRlcnMgaW4gdGhlIHJpc2N2LGlzYSBzdHJpbmcgbXVzdCBiZSBh
bGwNCiAgICAgICBsb3dlcmNhc2UgdG8gc2ltcGxpZnkgcGFyc2luZy4NCiAgICAgJHJlZjogIi9z
Y2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0cmluZyINCi0gICAgZW51bToNCi0gICAg
ICAtIHJ2NjRpbWFjDQotICAgICAgLSBydjY0aW1hZmRjDQorICAgIHBhdHRlcm46IHJ2NjRpbWFm
P2Q/cT9jP2I/dj9rP2g/KF96W2ltYWZkcWNidmtoXShbYS16XSkqKSokDQogDQogICAjIFJJU0Mt
ViByZXF1aXJlcyAndGltZWJhc2UtZnJlcXVlbmN5JyBpbiAvY3B1cywgc28gZGlzYWxsb3cgaXQg
aGVyZQ0KICAgdGltZWJhc2UtZnJlcXVlbmN5OiBmYWxzZQ0K
