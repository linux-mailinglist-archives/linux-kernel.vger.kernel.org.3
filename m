Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873524F4853
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380252AbiDEVgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451539AbiDEPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:53:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3B81C8854;
        Tue,  5 Apr 2022 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649170032; x=1680706032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2PX9DOsXhzLhwxkYXOwdLUJkBfcedL+KpSN/Ng3kR6k=;
  b=MczRkMEBZKQYz3zTWA+mAcC5gHl4BfvhY2tmCCYxG/OvPVqiEax8qkYP
   a1j2pr2yEvB6mOGu9szdNrZUqiMmTmqCWYxUBzJ32MmrYXnkpmrvrIRxR
   EHGsOk+hLv6CW7MlyTgKgFGJGBINdXluif9vwDTg/p0H8n6hxXBVEiPpF
   wAnBUPipnGv2naOMPwYAxpsc090lrkThErL9m4o4vhCOsrmZsbxV9adrT
   juib7AVil4TSnUGNh+E5KDDkvcs9fAFRUayRkCtZfHnfujUiw/SEIp82A
   pFqEuN/9jfDqCr7zfmpTjTUrDz/eViUqzIKjp+WAnr590v8dKZhk0hGy0
   g==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="91302429"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 07:47:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 07:47:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 5 Apr 2022 07:47:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYTXDqr3iZ91mtFW/QFWd9mftkSFH2zKEnBhD3DFVRv/j0j+F6NDihrOzyVdapVmRSOGzW4wpstlRy1dekMb7FWwQA5DXj8BRisb0O9LkVKya7reepVy6eJja7NXDD1h4jVO1RknlOMNapiii9KyTZ0WfiCp8DoabIaVxv6yT/KyCgxRZZ6PeNXJo8Bp5LbANYGkOykF1X9hTuUFA3ceR7mEfpbtyoUfXR2xQ+00uNPz3W1EQfZkjw0fnNFI5GO3EYmUbT22ZRNd9lAywY3OqLNM7xE5JOMiruRDT1vhouibo2ZH5+m76lvAm8fQsDebKi0lnP1yAlQhEgzEviVcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PX9DOsXhzLhwxkYXOwdLUJkBfcedL+KpSN/Ng3kR6k=;
 b=oZQgMdQk5bTuDyhia+zTjTyVi/DJOVERbYziN51KjoPCTT8DRPqfo25+urf2zPcNnf9NZ5DdIohh9rY/9guVl2ozEZKddhQ6G4ZG+witnyBrm3NmWFJPgPeK9YPOTo3wHMj42MYNP/tTZRjOUfRYcEfP6CJtb1iSVatYVMqFQ+ZmrcQWpC+QVHa2WMElS9HqeXrTn6UdERXqYJRYjDhgZiBLYzDqfwBttNsOQDMake9/Bqx/xMrFGlUZezEJFe3rifIiRUHngXznqv2RQTvaMA51MF7py7+jRavI4lihuVf+hzpz5szVXm7Np7PHOx2epynIMFitvNLl0qUhPSj5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PX9DOsXhzLhwxkYXOwdLUJkBfcedL+KpSN/Ng3kR6k=;
 b=kamLBRbWASmhuE/v8WOA++rdiU5vp3uzSAMjG5wNAuRkh8ohHAF4XCMNfUcMJf7VTOIqBHokw3NUQp8AUbMdgg2/3ahnIa98antgLSrwyup/5N8w+DKy5+e75kZSRN0P7MF4EBoMX+eG2Zw6fTB5/09JC+NGMgspx26YQjzjIX4=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by SA0PR11MB4640.namprd11.prod.outlook.com (2603:10b6:806:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 14:47:07 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%6]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 14:47:07 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 6/8] power: reset: at91-reset: add reset_controller_dev
 support
Thread-Topic: [PATCH 6/8] power: reset: at91-reset: add reset_controller_dev
 support
Thread-Index: AQHYSPwE63noJBr7cUyVHBDjjcHiyQ==
Date:   Tue, 5 Apr 2022 14:47:07 +0000
Message-ID: <9683a951-160a-b4e4-9494-c2e6ee51582e@microchip.com>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
 <20220405112724.2760905-7-claudiu.beznea@microchip.com>
 <0ff9a7cd2e6261a0de32db3bf16901e3737efef8.camel@pengutronix.de>
In-Reply-To: <0ff9a7cd2e6261a0de32db3bf16901e3737efef8.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2ec0161-c347-461f-f501-08da17132851
x-ms-traffictypediagnostic: SA0PR11MB4640:EE_
x-microsoft-antispam-prvs: <SA0PR11MB4640FEB5A9B9E3547456B25B87E49@SA0PR11MB4640.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hdl7j/p4IiBeFI4maU0ntF3qJ6vwbgWYAUkGPCMxFZ7ckJ17QSEmnOCXlPp/d0wqdBknjCJ8tQ8DI6o7UeN7vy/qG2TH2E12pYYlieHoMeejjxuOwlsjuSEvw09ERN+Fi2xFCk7iJ5mgA/fDzDLL4rqgCSBWH5m5EEPP2XvYWiqY2fi5RE/ehEOKCdleuNnPoprrjp8eY35K1EivCyicPdogQqSpn6yhW9ZE+GOTt3o+iEZDRutYjdTW3dltHzenM6KqeiTkknRpEWftr5wu68O0puxcnuBr2dw+bez4JOM910aepSIBfaNH9yuHuFJgcsj3XWY3rRAkqaXD3r2uVUaElkG6Zle+Vy9BLcj+KXB9ip2Qn20z9U+7uwPiI1MGBkjcaHY3Y7XkUOORwHMCye1qcaRrl2llkETdTGJqmiMX6oDRDPePqaMtNnmM5Z6uvwKzObcsNdLiRXW+OiRCtv75uJcEBYEt50alQRqzjjNlvXxZ82HE/IONoSpIhujgLqewqeqrIJXsPJXCn8e0duBJ/ADZR1tUQ+RluDp5+w7u/IunJIC/fooqF+MXGQGkP46qhBiZvebAIg1dD6uuvu3YYxwkmnfIZpw+pYfyzusxSfyNHY6KelqXe+FWOkPf47eqwPzuM3cBI6skR43SYyq2N7wEjhOk5XKkHlmk8ctcCf6TA0WRzfkPLJiTZXRSmBpGnEtrwPVnpfrktNxMuCez9WJk6LSPtAs4953m8vXG0QS8TALGjoAVXirTgv8HdDp0sGnbr591N8r+V2gGUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(6506007)(91956017)(86362001)(2906002)(36756003)(186003)(5660300002)(6486002)(110136005)(66556008)(316002)(66946007)(66476007)(76116006)(66446008)(64756008)(8676002)(508600001)(53546011)(4326008)(31696002)(38100700002)(31686004)(8936002)(38070700005)(2616005)(71200400001)(54906003)(122000001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjU4WnQyQWlIK2IwdkVGV1JZRWNXS2YyenRQanF6TnNleVRnRXZ5QXhvQW1S?=
 =?utf-8?B?ZXRlbTFOM1JtR3FhRGd6WXM5ZC9tY3U3RThWOWxWVFUxbm1rWkJxdW4zR0li?=
 =?utf-8?B?QXgyL0VCN1B0c2g0TFRTaXNaTDd5RTBGekNaSnZodTNLWFNOTE8zRzNEczRK?=
 =?utf-8?B?eGhOSG1Ua00zUElxRFFpcWVkWVJ5YVY0eWplL2t1YnE1eGpHVzVPRUU0M2o2?=
 =?utf-8?B?S2JvN1VMR1pEbXRROGdDdy9nZ1duTmE5Rm5hVk80N0RRZHU0VW9RNUwvVXE4?=
 =?utf-8?B?K3ZyaFlXQldsdWtJbG9rMiswQ2l1bjFiNkJmT3JCcU5aSUYyWS91dzEwUVdv?=
 =?utf-8?B?aGg2SkZXTUhrdzVJQXZpZzdGOXVzR0lrSEFQS1JpS0FxUVVBaHZoZFVqcW1k?=
 =?utf-8?B?N0d0WEVCUk1vUWZWdEJlTnJCMTNkaUNKY0hMMGpFUXR6N1VpbXJpOHRDRjBy?=
 =?utf-8?B?UUZhdlBUVDNHSERGMVJuME9mQlBTK2hFNlBxVzFvQzZlYjdTK1hYSDhndlly?=
 =?utf-8?B?L2FQQVlFazg4R0xaWnpUSEljTHU4cEdudnhMRFRzRUtzdERnaUJSTFhDd1RW?=
 =?utf-8?B?eGRDWWhnSG0wZnozMmhTS2ZGc0tOVHpGYmNNWDgxSldyeDFDSzlGZkFXMnVz?=
 =?utf-8?B?czY1VW1Kd2tscUZYVWNnVDJ2aDJWQkcwM1lmY3NmRWxRZzJlTFQ4Mk9rZXNS?=
 =?utf-8?B?RjNsT3phYTZxOGxYRGF1V0dsaWFUWExQeXpBL0tIUElrOHhhL1pKNHFZRmpE?=
 =?utf-8?B?SUdjVE5vbUoyK2ZDVHZRNTRnYmFTeWxYb21ROXRnR3djcFlCZG1FSFllVzF2?=
 =?utf-8?B?Zm1wdjlPc3gvM0JsbTVGc3Q5aE9YQ21Qak5EYVdBSUlRcUFrM1F3WVJPaWNn?=
 =?utf-8?B?WHBnNzByLytNY1ZRQXE2UTAvdGdaZjRqYVg4NEZGYWdwbU9NYjdtSnZhK2F4?=
 =?utf-8?B?cjRtTUxXai92SWs0TjZjc2l5TGs0ZitSLzduQmYyUE1EYytyNzNXcStYMkVK?=
 =?utf-8?B?cVdCZkFDVnFhaGJzV0tqYU5OVU9uOXFRbStjKzJ0NDBjT1A2ZGc0azlpRE9x?=
 =?utf-8?B?WFZLQnl0WEZyZmlaV2RaVlowWTZibHd0dGJJUmNTMmN4QWNUQTRucllKYlFD?=
 =?utf-8?B?UjJyM2dQSlByV2NQNkUvcWxVb1lpdFN6Q3R3cFZHMzNIT2JqSVp5T1ExOFVw?=
 =?utf-8?B?RUxWQ3JFcWJFOVp6Vno1RDhDR09DbVpRWEUreklRaUZIa3JTK2dBTy9QTDIz?=
 =?utf-8?B?S1ltbU1keEppeGJjWDI5d2pMM2NoUENkMVplTEtmZDRUbEVPYzZkZFFzZmNF?=
 =?utf-8?B?NGV4dDZwUGNsNGY3L1gzLzNVTTA0STdvbEo0Y1lwTHNUTzhsbHpSckNXV2Ur?=
 =?utf-8?B?MkJZdXBYbVRvcCs4Qkd6Mmh3Vm1pL21GcUVvU1J6U28vR0VZa1ZNSHNZdUpx?=
 =?utf-8?B?TlVkbGdQTFdzVi9JYkxxVHA5N2dNSzU2QnJvRGhDWFU5a1FObWs4QkxYd1dB?=
 =?utf-8?B?RzdMKzIyd1o4SFdMTGdoWHcwL2tiOE5ESHM3NmJwanZNLzRWYm5DY3V3L0VH?=
 =?utf-8?B?QmVQeGRYZHZqS3YwOFdFNjRRWGd2MlZzNnFQRGYxTzJqUUZGN091VGE5TzNy?=
 =?utf-8?B?OXFtNVpJS24waWtUdCtwb0RoMyszV1hRRlNPaWowajNFUWZwQXc1ajBqRlM4?=
 =?utf-8?B?M0JVMFlZR2I3WFpBMmJBbm9ScDl6WlB5Uko5a0t2aSthVENjeUVyVzJGTWt4?=
 =?utf-8?B?RFloWjhVekZKSGNYRVZSQmdrRC8wQXhZYitPdHBKdGRWdkJvNFBmTDlJMXRQ?=
 =?utf-8?B?VlcvNXlNNTdocTBpOUJmYTh5TkFpdS93b29aNm85b0lBbHZMWnpSYnJLaU13?=
 =?utf-8?B?MEFKNkhwQ1AwRXBmZlRrNzJsYi9kSnJMM3NzSllud2t4dFZ0SVlaVENMNGFt?=
 =?utf-8?B?WDUrUXc4YzRJQUQxd1QveUgwcXZTSUw4UFRxL0Q5cytBV0YxaVVIL1J0eDhL?=
 =?utf-8?B?Sks5OW9hZk5QOVhMeGxIaFBSNHVFejZLYjlvWGhKOWxxNGU4RHRNL1JFQ0p4?=
 =?utf-8?B?aFJwVlFBeDJVSDNneEtZWThRZUFUdzZHWDl5REFqTEFzT3l1MWgwYmR2VlpT?=
 =?utf-8?B?eldMQjcvOHk2MG1LWGpSNUh2SW9hYWlQZFpQZExhTmphMU5ubkx4S2xVZ2Ew?=
 =?utf-8?B?UWNqY2VJTFRoYWVDeFBhS1JPVTBUMnlDRHhXVEZZemRKb3luSHBVcGxFai8x?=
 =?utf-8?B?eTV0clM4VzBxT2tzQzBXNWEvcE5KcDFPWTgzQk5SMUNIRVlOSThwSnJRWEM5?=
 =?utf-8?B?NmhjWStvWWhIaE5HT01CLzNTdFpGNGcxL1BSSTJSTGZrQjBtRGZRYlhtZGY5?=
 =?utf-8?Q?P93+ogDICete9UVU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43D3F2A702137843AE06E8F28E06F08C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ec0161-c347-461f-f501-08da17132851
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 14:47:07.3673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JHc5Ml5vd0AY3KKoSGS4i00FRoDO8eXROLCpmICGAhvY+vUJfT/Ioz319R7HEws4F7y1ydatIo0o44NbvHkcDph+uZrsO7Fyj6hgixXBLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4640
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBoaWxpcHAsDQoNCk9uIDA1LjA0LjIwMjIgMTQ6NDcsIFBoaWxpcHAgWmFiZWwgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgQ2xhdWRpdSwN
Cj4gDQo+IE9uIERpLCAyMDIyLTA0LTA1IGF0IDE0OjI3ICswMzAwLCBDbGF1ZGl1IEJlem5lYSB3
cm90ZToNCj4+IFNBTUE3RzUgcmVzZXQgY29udHJvbGxlciBoYXMgNSBleHRyYSBsaW5lcyB0aGF0
IGdvZXMgdG8gZGlmZmVyZW50DQo+PiBkZXZpY2VzDQo+PiAoMyBsaW5lcyB0byBVU0IgUEhZcywg
MSBsaW5lIHRvIEREUiBjb250cm9sbGVyLCBvbmUgbGluZSBERFIgUEhZDQo+PiBjb250cm9sbGVy
KS4gVGhlc2UgcmVzZXQgbGluZXMgY291bGQgYmUgcmVxdWVzdGVkIGJ5IGRpZmZlcmVudA0KPj4g
Y29udHJvbGxlcg0KPj4gZHJpdmVycyAoZS5nLiBVU0IgUEhZIGRyaXZlcikgYW5kIHRoZXNlIGNv
bnRyb2xsZXJzJyBkcml2ZXJzIGNvdWxkDQo+PiBhc3NlcnQvZGVhc3NlcnQgdGhlc2UgbGluZXMg
d2hlbiBuZWNlc3NhcnkuIFRodXMgYWRkIHN1cHBvcnQgZm9yDQo+PiByZXNldF9jb250cm9sbGVy
X2RldiB3aGljaCBicmluZ3MgdGhpcyBmdW5jdGlvbmFsaXR5Lg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0t
DQo+PiAgZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMgfCA5Mg0KPj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgODggaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlci9y
ZXNldC9hdDkxLXJlc2V0LmMNCj4+IGIvZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMN
Cj4+IGluZGV4IDBkNzIxZTI3ZjU0NS4uYjA0ZGY1NGMxNWQyIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMNCj4+ICsrKyBiL2RyaXZlcnMvcG93ZXIvcmVz
ZXQvYXQ5MS1yZXNldC5jDQo+PiBAQCAtMTcsNiArMTcsNyBAQA0KPj4gICNpbmNsdWRlIDxsaW51
eC9vZl9hZGRyZXNzLmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0K
Pj4gICNpbmNsdWRlIDxsaW51eC9yZWJvb3QuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQt
Y29udHJvbGxlci5oPg0KPj4NCj4+ICAjaW5jbHVkZSA8c29jL2F0OTEvYXQ5MXNhbTlfZGRyc2Ry
Lmg+DQo+PiAgI2luY2x1ZGUgPHNvYy9hdDkxL2F0OTFzYW05X3NkcmFtYy5oPg0KPj4gQEAgLTUz
LDEyICs1NCwxNiBAQCBlbnVtIHJlc2V0X3R5cGUgew0KPj4gIHN0cnVjdCBhdDkxX3Jlc2V0IHsN
Cj4+ICAgICAgICAgdm9pZCBfX2lvbWVtICpyc3RjX2Jhc2U7DQo+PiAgICAgICAgIHZvaWQgX19p
b21lbSAqcmFtY19iYXNlWzJdOw0KPj4gKyAgICAgICB2b2lkIF9faW9tZW0gKmRldl9iYXNlOw0K
Pj4gKyAgICAgICBzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgcmNkZXY7DQo+PiAgICAgICAg
IHN0cnVjdCBjbGsgKnNjbGs7DQo+PiAgICAgICAgIHN0cnVjdCBub3RpZmllcl9ibG9jayBuYjsN
Cj4+ICAgICAgICAgdTMyIGFyZ3M7DQo+PiAgICAgICAgIHUzMiByYW1jX2xwcjsNCj4+ICB9Ow0K
Pj4NCj4+ICsjZGVmaW5lIHRvX2F0OTFfcmVzZXQocikgICAgICAgY29udGFpbmVyX29mKHIsIHN0
cnVjdCBhdDkxX3Jlc2V0LCByY2RldikNCj4+ICsNCj4+ICBzdHJ1Y3QgYXQ5MV9yZXNldF9kYXRh
IHsNCj4+ICAgICAgICAgdTMyIHJlc2V0X2FyZ3M7DQo+PiAgICAgICAgIHUzMiBuX2RldmljZV9y
ZXNldDsNCj4+IEBAIC0xOTEsNiArMTk2LDc5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkDQo+PiBhdDkxX3Jlc2V0X29mX21hdGNoW10gPSB7DQo+PiAgfTsNCj4+ICBNT0RVTEVf
REVWSUNFX1RBQkxFKG9mLCBhdDkxX3Jlc2V0X29mX21hdGNoKTsNCj4+DQo+PiArc3RhdGljIGlu
dCBhdDkxX3Jlc2V0X3VwZGF0ZShzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGlkLCBib29sIGFz
c2VydCkNCj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBhdDkxX3Jlc2V0ICpyZXNldCA9IHRvX2F0
OTFfcmVzZXQocmNkZXYpOw0KPj4gKyAgICAgICB1MzIgdmFsOw0KPj4gKw0KPj4gKyAgICAgICB2
YWwgPSByZWFkbF9yZWxheGVkKHJlc2V0LT5kZXZfYmFzZSk7DQo+PiArICAgICAgIGlmIChhc3Nl
cnQpDQo+PiArICAgICAgICAgICAgICAgdmFsIHw9IEJJVChpZCk7DQo+PiArICAgICAgIGVsc2UN
Cj4+ICsgICAgICAgICAgICAgICB2YWwgJj0gfkJJVChpZCk7DQo+PiArICAgICAgIHdyaXRlbF9y
ZWxheGVkKHZhbCwgcmVzZXQtPmRldl9iYXNlKTsNCj4gDQo+IFRoaXMgcmVhZC1tb2RpZnktdXBk
YXRlIHNob3VsZCBiZSBwcm90ZWN0ZWQgYnkgYSBzcGlubG9jay4NCj4gDQo+PiArDQo+PiArICAg
ICAgIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IGF0OTFfcmVzZXRfYXNz
ZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgaWQpDQo+PiArew0KPj4gKyAgICAgICByZXR1
cm4gYXQ5MV9yZXNldF91cGRhdGUocmNkZXYsIGlkLCB0cnVlKTsNCj4+ICt9DQo+PiArDQo+PiAr
c3RhdGljIGludCBhdDkxX3Jlc2V0X2RlYXNzZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2Rl
diAqcmNkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9u
ZyBpZCkNCj4+ICt7DQo+PiArICAgICAgIHJldHVybiBhdDkxX3Jlc2V0X3VwZGF0ZShyY2Rldiwg
aWQsIGZhbHNlKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBhdDkxX3Jlc2V0X2Rldl9z
dGF0dXMoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgaWQpDQo+PiArew0KPj4gKyAgICAg
ICBzdHJ1Y3QgYXQ5MV9yZXNldCAqcmVzZXQgPSB0b19hdDkxX3Jlc2V0KHJjZGV2KTsNCj4+ICsg
ICAgICAgdTMyIHZhbDsNCj4+ICsNCj4+ICsgICAgICAgdmFsID0gcmVhZGxfcmVsYXhlZChyZXNl
dC0+ZGV2X2Jhc2UpOw0KPj4gKw0KPj4gKyAgICAgICByZXR1cm4gISEodmFsICYgQklUKGlkKSk7
DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcmVzZXRfY29udHJvbF9vcHMg
YXQ5MV9yZXNldF9vcHMgPSB7DQo+PiArICAgICAgIC5hc3NlcnQgPSBhdDkxX3Jlc2V0X2Fzc2Vy
dCwNCj4+ICsgICAgICAgLmRlYXNzZXJ0ID0gYXQ5MV9yZXNldF9kZWFzc2VydCwNCj4+ICsgICAg
ICAgLnN0YXR1cyA9IGF0OTFfcmVzZXRfZGV2X3N0YXR1cywNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0
YXRpYyBpbnQgYXQ5MV9yZXNldF9vZl94bGF0ZShzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYg
KnJjZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBv
Zl9waGFuZGxlX2FyZ3MgKnJlc2V0X3NwZWMpDQo+PiArew0KPj4gKyAgICAgICByZXR1cm4gcmVz
ZXRfc3BlYy0+YXJnc1swXTsNCj4+ICt9DQo+IA0KPiBGb3IgMToxIG1hcHBpbmdzIHRoZXJlIGlz
IG5vIG5lZWQgZm9yIGEgY3VzdG9tIG9mX3hsYXRlIGhhbmRsZXIuIEp1c3QNCj4gbGVhdmUgb2Zf
eGxhdGUgYW5kIG9mX3Jlc2V0X25fY2VsbHMgZW1wdHkuDQoNCkkndmUgZG91YmxlIGNoZWNrZWQg
dGhhdC4gVGhpcyB3b3VsZCB3b3JrIGlmIHJlc2V0IGlkcyBhcmUgY29udGludW91cyBmcm9tDQp6
ZXJvIHRvIHJjZGV2Lm5yX3Jlc2V0cy4gVGhpcyB0aGUgb2ZfcmVzZXRfc2ltcGxlX3hsYXRlOg0K
DQpzdGF0aWMgaW50IG9mX3Jlc2V0X3NpbXBsZV94bGF0ZShzdHJ1Y3QgcmVzZXRfY29udHJvbGxl
cl9kZXYgKnJjZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3Ry
dWN0IG9mX3BoYW5kbGVfYXJncyAqcmVzZXRfc3BlYykNCnsNCglpZiAocmVzZXRfc3BlYy0+YXJn
c1swXSA+PSByY2Rldi0+bnJfcmVzZXRzKQ0KCQlyZXR1cm4gLUVJTlZBTDsNCglyZXR1cm4gcmVz
ZXRfc3BlYy0+YXJnc1swXTsNCn0NCg0KQnV0IGluIHRoaXMgZHJpdmVyJ3MgY2FzZSB3ZSBoYXZl
IDMgaWRzOiA0LCA1LCA2LiBUaGF0IGlzIHRoZSByZWFzb24gSSBoYWQNCnRoaXMgc2ltcGxlIHhs
YXRlIGZ1bmN0aW9uLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPj4gKw0K
Pj4gK3N0YXRpYyBpbnQgYXQ5MV9yY2Rldl9pbml0KHN0cnVjdCBhdDkxX3Jlc2V0ICpyZXNldCwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBhdDkxX3Jlc2V0X2Rh
dGEgKmRhdGEsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPj4gK3sNCj4+ICsgICAgICAgaWYgKCFkYXRhLT5uX2RldmljZV9yZXNl
dCkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+ICsNCj4+ICsgICAgICAgcmVzZXQt
PmRldl9iYXNlID0gZGV2bV9vZl9pb21hcCgmcGRldi0+ZGV2LCBwZGV2LT5kZXYub2Zfbm9kZSwg
MSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMKTsNCj4+
ICsgICAgICAgaWYgKElTX0VSUihyZXNldC0+cnN0Y19iYXNlKSkNCj4gDQo+IFNob3VsZCBjaGVj
ayByZXNldC0+ZGV2X2Jhc2UgaGVyZS4NCj4gDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9ERVY7DQo+PiArDQo+PiArICAgICAgIHJlc2V0LT5yY2Rldi5vcHMgPSAmYXQ5MV9yZXNldF9v
cHM7DQo+PiArICAgICAgIHJlc2V0LT5yY2Rldi5vd25lciA9IFRISVNfTU9EVUxFOw0KPj4gKyAg
ICAgICByZXNldC0+cmNkZXYub2Zfbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPj4gKyAgICAg
ICByZXNldC0+cmNkZXYubnJfcmVzZXRzID0gZGF0YS0+bl9kZXZpY2VfcmVzZXQ7DQo+PiArICAg
ICAgIHJlc2V0LT5yY2Rldi5vZl9yZXNldF9uX2NlbGxzID0gMTsNCj4+ICsgICAgICAgcmVzZXQt
PnJjZGV2Lm9mX3hsYXRlID0gYXQ5MV9yZXNldF9vZl94bGF0ZTsNCj4+ICsNCj4+ICsgICAgICAg
cmV0dXJuIGRldm1fcmVzZXRfY29udHJvbGxlcl9yZWdpc3RlcigmcGRldi0+ZGV2LCAmcmVzZXQt
PnJjZGV2KTsNCj4+ICt9DQo+PiArDQo+PiAgc3RhdGljIGludCBfX2luaXQgYXQ5MV9yZXNldF9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gIHsNCj4+ICAgICAgICAgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0Y2g7DQo+PiBAQCAtMjQ0LDYgKzMyMiwxMCBAQCBz
dGF0aWMgaW50IF9faW5pdCBhdDkxX3Jlc2V0X3Byb2JlKHN0cnVjdA0KPj4gcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPj4NCj4+ICAgICAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcmVz
ZXQpOw0KPj4NCj4+ICsgICAgICAgcmV0ID0gYXQ5MV9yY2Rldl9pbml0KHJlc2V0LCBkYXRhLCBw
ZGV2KTsNCj4+ICsgICAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAgICAgICBnb3RvIGRpc2Fi
bGVfY2xrOw0KPj4gKw0KPj4gICAgICAgICBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUocGRl
di0+ZGV2Lm9mX25vZGUsDQo+PiAibWljcm9jaGlwLHNhbTl4NjAtcnN0YyIpKSB7DQo+PiAgICAg
ICAgICAgICAgICAgdTMyIHZhbCA9IHJlYWRsKHJlc2V0LT5yc3RjX2Jhc2UgKyBBVDkxX1JTVENf
TVIpOw0KPj4NCj4+IEBAIC0yNTIsMTQgKzMzNCwxNiBAQCBzdGF0aWMgaW50IF9faW5pdCBhdDkx
X3Jlc2V0X3Byb2JlKHN0cnVjdA0KPj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICAgICAg
ICB9DQo+Pg0KPj4gICAgICAgICByZXQgPSByZWdpc3Rlcl9yZXN0YXJ0X2hhbmRsZXIoJnJlc2V0
LT5uYik7DQo+PiAtICAgICAgIGlmIChyZXQpIHsNCj4+IC0gICAgICAgICAgICAgICBjbGtfZGlz
YWJsZV91bnByZXBhcmUocmVzZXQtPnNjbGspOw0KPj4gLSAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+PiAtICAgICAgIH0NCj4+ICsgICAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAgICAg
ICBnb3RvIGRpc2FibGVfY2xrOw0KPj4NCj4+ICAgICAgICAgYXQ5MV9yZXNldF9zdGF0dXMocGRl
diwgcmVzZXQtPnJzdGNfYmFzZSk7DQo+Pg0KPj4gICAgICAgICByZXR1cm4gMDsNCj4+ICsNCj4+
ICtkaXNhYmxlX2NsazoNCj4+ICsgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHJlc2V0LT5z
Y2xrKTsNCj4+ICsgICAgICAgcmV0dXJuIHJldDsNCj4+ICB9DQo+Pg0KPj4gIHN0YXRpYyBpbnQg
X19leGl0IGF0OTFfcmVzZXRfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
IA0KPiByZWdhcmRzDQo+IFBoaWxpcHANCg0K
