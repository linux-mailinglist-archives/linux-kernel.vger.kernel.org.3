Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B714EBB33
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbiC3Gzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbiC3Gzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:55:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BE8BD885
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648623237; x=1680159237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pG3NJ3xDc4oXyXWcVKVQ1JjTzch/pynKedHM54GVVPc=;
  b=wmPJKmhE7VUGmDzPP6jkXuuiAqpfhzlLC9M39avfs4n3jiSV4FwHwcP9
   KXJ6Vp75AJB+lXmp/wN69awXw5aVJReL2AQnDCjm8IPSos06o1yOnIHqv
   iLGO4YgB3qbbI9ELBPPC0WsXm1ZXoQclm2AKZ+fW3FfpikHwfYxHAXoj+
   WQnl6XrxdPsfmyFpGm9jkhrL+txe7CcjPiLReRp7kFeIDdpMgPSyV/HaI
   RYw+oUQZXkLWkxwq+fKusDET2H2NbNxwteBaWJtiDr0z5jGbKckwt4qUl
   6au8NBzbVKnnM1SMSBpUKP/j23ZPGvHJffrJmKjsOCLLrDB/Hf19t+ZY5
   g==;
X-IronPort-AV: E=Sophos;i="5.90,222,1643698800"; 
   d="scan'208";a="150866936"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2022 23:53:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 29 Mar 2022 23:53:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 29 Mar 2022 23:53:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrkC3ZnOOdqxnyMbikFBFbi7cDjj5PWWzouaYQZ0zRzKXjBul38u7NJj0Z78Q89ttVDK2jVuYy1M7b1r8WygX8ngfJ9ebZPvQrEPCyZjKwa2zL6eXeY+huvLsIRPHxgSDnItws7cV/rSn+o521Noa54ctQwBVDgIYRtEJARIEZt+ut/wOfmMyqzaqnJR6f2OkyGaO7u7Li8eogqHkfJXzNs2IaoihTl6pBlVyzd2qNuWy3yJ4EXEOJUuwIbnx+8+0OHYe6z9iW+qn4oJGC/didvbTN/jhRuGIywSA/TQqr0yszTeBW7zE5acMeF4F8AnUnwkANEs6kuDCHWbvvbTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG3NJ3xDc4oXyXWcVKVQ1JjTzch/pynKedHM54GVVPc=;
 b=MWVffeSzfNH8REZF8KxdUqu/M9ILmMmp7Ot5ImNbgBrfxLZGSe0C7NgWCBCZQzwM9RO63E6oLrxioRKrcZGr+p47pUSYLCveWWIROGTEJfYEVUpk482W2WNvFHKWF2JMHprSIFYGeP6RE2Kgy5XvwGIjDaHYNyPZKSp06nquWYsZDtYtylTpXlWl0M7B4hmMl3CnuA+CbrUlw3clzMcuKW0FrFWzVF74RHq8UewGKfr29wmYWB+8EpcJnbwEXDY9TNguoUo5VnybaXeNNXheNkD5GCJwY2ZS0D2qktj93XLAflq97+sH8GPTcVeBA+Juw7c7EI8BEBeNaSjaYvLfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG3NJ3xDc4oXyXWcVKVQ1JjTzch/pynKedHM54GVVPc=;
 b=dE2t19MhGNkVTiCxLxe2wPJVkE+5rtc4OrRjRxZXqtcYmkY73X0X9Q+UZokT/LEF6f5vV2zWxbzCrI4SWmtutwgBFQHzUvPz1B0L/JXyv1bQ1bo+inB4xpJAbvhBR28NfxBqIXfq3BxbZHCooqHDhn/PSFDxuOP7Kn67ZOGubSo=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN8PR11MB3682.namprd11.prod.outlook.com (2603:10b6:408:88::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 06:53:45 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7cb5:d2dd:7e5:c812]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7cb5:d2dd:7e5:c812%9]) with mapi id 15.20.5123.020; Wed, 30 Mar 2022
 06:53:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 4/8] mtd: spi-nor: core: Introduce method for RDID op
Thread-Topic: [PATCH v2 4/8] mtd: spi-nor: core: Introduce method for RDID op
Thread-Index: AQHYPSYy5Uot3kf5wUC4x8ym1emt7w==
Date:   Wed, 30 Mar 2022 06:53:45 +0000
Message-ID: <b739a03f-fe3f-7a2d-95fc-00122ca34c39@microchip.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-5-tudor.ambarus@microchip.com>
 <20220321122149.dvqyml4riqkr3gqi@ti.com>
 <32b3449a-66db-3ed1-da96-47e124800500@microchip.com>
 <20220321173908.tcqx3ygo6qd62ukg@ti.com>
In-Reply-To: <20220321173908.tcqx3ygo6qd62ukg@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 527a433c-ffe5-49d4-a8fa-08da121a08ea
x-ms-traffictypediagnostic: BN8PR11MB3682:EE_
x-microsoft-antispam-prvs: <BN8PR11MB3682FD99FCCEC4E34CF8F374F01F9@BN8PR11MB3682.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n+sjzYLz/ASsKvTnsSt3SI7vX2RmFMAZODII0Zyn5eFM0V6SPfvMw+xT1KU79IRkQHK0VT1ky0iK0pz+TzUC/DsPAUJewSBrvYwwDgOj7vqB+p643aeh1yNz6nEJwr1uUzBWLPX5dNRtFHmmjjWBfQb9XsgwfJQuiEL9g7ZZ8FAq4NUhi1qDTyCquUVMHWI+tW/CSrJdVFBUDyt8tUbW/Piy/suh+xcFVPSQMnpwW/GdaJu85um/SU49K25L7cApURAtwdnWRM3UxCjtFW0Nr1yzzttMoa3tPc4bT/hl2WFdgdA+QnpreBwDoV9wgLFzUr5nesEMgkjvGailggZWFfXfF2fGbXQDh5zkZlDoaBLYRVr5427S6HaXBCq34L2TnpnDxfkX6cgLoBM4Ey79CsEkPw/jjWRsWsrq3IutemyiV0SuSI144vJIjWdmxDo7YmJIcPZoCxeHMCyzSy/vA5tM3j/GcSqnvlkSODaLjMgDNwh+iXXk0Ru88csVGnFN1AmOiLAxCMkWh3x/2IJfXCigwh+shW7cVJpOvRCJYBKjDJ3qFYVKkMayiEZJq/6Fhby+QWGDRmfWwMFKDz8itPKeXNSoaCAnsfcb9ktwn/wm8sB+exzgdU5prKsHmWppokysiHePLgiG4DYv1saYwEm17H9CPu0fNCvzalWZBI0FLeqJhyIVQo7nALY6uNsdPlpZf3Hx8ldLsK8740ApKFZ76zHqdavx8rV49L1emBECE7jDkWQloBWf5b6uF4Q4KLHj1e9dswAwmnCNoahzUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(86362001)(64756008)(66556008)(6916009)(66946007)(6506007)(6512007)(66446008)(122000001)(31696002)(8676002)(91956017)(66476007)(38070700005)(54906003)(4326008)(38100700002)(76116006)(5660300002)(2906002)(26005)(8936002)(107886003)(53546011)(186003)(83380400001)(508600001)(31686004)(71200400001)(6486002)(36756003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amhFY09QbEQ1QlF1SDlUTDFyVWVYa3dvNXpFc1ZEaTZrYUdkeFYzY1hVbTZ6?=
 =?utf-8?B?YmZPa3l0TThMbVF5TUN1cWZnMXpCMzNkNUFlREUwWVRIY1NJcENjRUlqYUtK?=
 =?utf-8?B?TWJUZnZwMzNPWGt0S0lMakN5cU1vaG96REthaFVocklHR0Izc2RpZUtXcEh1?=
 =?utf-8?B?YWRkOFFZelh2dVVYZzJhQmZoL2I3Y2htSGdLZTJieEcvbGVlVTRySy9VNitX?=
 =?utf-8?B?aFpGUmpGUU1QbDYwUFQ2TW1mR0ZYWkwwSUJic3FRdXVQUlg1dkdtWjJ4UjFm?=
 =?utf-8?B?SjRrNGRFaTc3MjJicTc0RDNLc3FpWVZRZ0ljTjNLc0x4dU9QaEVSeStPelZv?=
 =?utf-8?B?TU1vTFpOaXJ2bnRwWGdvZnoxVWpCNDljTEszWExLZ2NEbC9OUUlLUi9nK2x3?=
 =?utf-8?B?bENGZHF3VWJlODFmREJHNjVEemJTOE50WjBsSk5oRFhJV2RuZFJLMFVUME9E?=
 =?utf-8?B?aHczV1J1NmJWZkRmWEJablRjVU9uU2xhN1AvbjFPTlFBd2Znd29jOUdMZERF?=
 =?utf-8?B?NVAwRlE5M0JmZmdrSGRRdjV2RVpkNHZCUThOcS9rK2psZXlUMGVpc09ES3pN?=
 =?utf-8?B?ZUhiYTJOeTUweks1dmt0N3d0enZHbDFuMk14U1M5L3FvWG5nb3hvUXRQWVYr?=
 =?utf-8?B?cFJqMVp1amk3bDV4czdnMS81bDVXU2NtU3VWNjFiaVRZMnRPbVZ2bkwyS2Vo?=
 =?utf-8?B?UHJVSGtONEZXMGsvUXRpQWhZRkVobGE3RGp3NllzckJtYkpOZUkvZEY5dWNv?=
 =?utf-8?B?Wm40b05qaVlvSGlKOVhjRlYxYStkd1NPaEI1Q3lsWmtEMHNNRGhxaTVGM1Jt?=
 =?utf-8?B?UzVkb1JDd0F4Q1dsQmx3QVgwZzlweS9DS0JkcFJhazdnOEJwYjVhQXVlODd2?=
 =?utf-8?B?TzR0MkdhdVl5U1AwVWk5c3hqUFhJc0RXR0JCYnJhVDAzTEJEaFpJemt5SFlj?=
 =?utf-8?B?NXMzVFRTQkZ2UWJzdUh4OWNtbzhOemdhSk5aNEs2a1IrdnBnWnRTTTFDYXdM?=
 =?utf-8?B?M3pyMkZ1MnphYzNVaHhwUlYxd25ZOVordU4rNWxYUDVFZDZGU3hzMHhWZWFH?=
 =?utf-8?B?UmdzYldnUGxVeFMvUy9COHFjemFIZFpST2N1TTdoL3dZZE8vMzlFaXlhdVB4?=
 =?utf-8?B?Z1RPbTc1bkwwTG1LZHBHK1c3cW9nb1VuS2ZyL29hQlcwNDVwU2FxaFR0WVRE?=
 =?utf-8?B?S2szb1B4cG9EcHZjQkFmOW1XM2lKUS8rSmJTRHppTExlTXdpdml6UDhyWWZ4?=
 =?utf-8?B?ZVFzYzZydk5ZdnpGdUdWQVUyQlkwYUVWY3VRZHlqdzQ5NDEwaUdBUGlBUjJX?=
 =?utf-8?B?WVN5MUEzTnlJTWdSWmc2a1Y2RUUyWlRSVXIxZW0xTFVVMmJyWkpYaGZ6VmFz?=
 =?utf-8?B?ckFFLzlNeVpHWXBwalovOEt6K0hKUldhdDcrWWtXZ0FjenZGUGR2S1gxbW5T?=
 =?utf-8?B?cnJpc2d0d1l0TTY4bkwweVZETTltMXAxUlp3L3V4WmVLMUdXODQ0L2VKUm15?=
 =?utf-8?B?SzBKKytSZ25yRFI4TEg1VmpsbWxIS2lhK0s0VlRwK1gyVnU1Mk1nQkRGc1pp?=
 =?utf-8?B?TEQ2V2w3elZSbzVkK1pWWWVsTGdKOGtHSmFxdFh0L3JxTXE0NFkzdnFzNHFK?=
 =?utf-8?B?ZDV4UmRHOGFnRXpMaHg5bGI5MUtsQ1B4OGlOTmY1UG50L09rNDNHYlFDaVlB?=
 =?utf-8?B?bTBlVElOYmZtSW1iZE12S0FtUGhYeU1nZU1jNEZTWFovR2RKSXZtdmh0ZjIr?=
 =?utf-8?B?ZlI1ZHdnU3dYbzM1VjZKSVN2eDNUTDV6OVhubU04WXdOelBYeVBhcHNkYWM4?=
 =?utf-8?B?ODRwSUg5bG1vQ0pqN1JLTTdNdGpuOGZBUHVuVnQ4bmZIQ1FIRzZjRmorOTlo?=
 =?utf-8?B?N2lDdEpkR3NUQlNMWmhleGhtUXNOSitwbXZCNm5wMSsvNDAySEJMVlZnZEVx?=
 =?utf-8?B?cko0c3VWeHFxOHRhMVFtUlRYeUptRUcrM0ExbmdNQ0hTK1FQVk9KaTdja0Y1?=
 =?utf-8?B?U3grVWlQYVFLdDVXdWsvaXUvTjVFbFhEanhOVFJkbEtSN1BFWmQ5N2UyNUQv?=
 =?utf-8?B?bjZPMXpsVFBhZUpOWTB5SWZjWkVQc1kxcUFkWWtrNFYzT0cvL1Q1U2FSV1Nr?=
 =?utf-8?B?TDJ1VW9RY3BSdWdtOVprVStNL2lvOWh4MkNtTlBSd0kzU2M3UzNKa043d2pG?=
 =?utf-8?B?YlpxNGNCU3NFbm9hektPQjkwbmw5RE5Lc2poUGZYME9nZTFQaHFGTk5YZW95?=
 =?utf-8?B?V2t6Z1dXamowVm1jNlE3WFJ0Lzlwb1dzVlVPYVVUUXhSQzF6RTRIeUlVV050?=
 =?utf-8?B?NTJaMW4zaE1BbEk2ZlZZbVdaN2lYWXBxZURaMGpHbm9lVXA2REZkaFBHWlU3?=
 =?utf-8?Q?N63v8lqV/BYw+Z7E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0DF4BE89C1B0E479C0BCABA5FE1FC20@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527a433c-ffe5-49d4-a8fa-08da121a08ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 06:53:45.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIq1SVZuN8ByxKzuLR1ixLAtl98Wxs2Htk2SepNxyWAGMCBwsbiudCHcknbP0ciUb5juEJ9V2E35ai6R5koDY4SW3nGgUEiomkcaC+QLqNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3682
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yMS8yMiAxOTozOSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjEvMDMvMjIgMDE6MThQTSwgVHVkb3IuQW1i
YXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMy8yMS8yMiAxNDoyMSwgUHJhdHl1c2gg
WWFkYXYgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4N
Cj4+PiBPbiAyOC8wMi8yMiAwMToxN1BNLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPj4+PiBSRElE
IGlzIHVzZWQgaW4gdGhlIGNvcmUgdG8gYXV0byBkZXRlY3QgdGhlIGZsYXNoLCBidXQgYWxzbyBi
eSBzb21lDQo+Pj4+IG1hbnVmYWN0dXJlciBkcml2ZXJzIHRoYXQgY29udGFpbiBmbGFzaGVzIHRo
YXQgc3VwcG9ydCBPY3RhbCBEVFIgbW9kZSwNCj4+Pj4gc28gdGhhdCB0aGV5IGNhbiByZWFkIHRo
ZSBmbGFzaCBJRCBhZnRlciB0aGUgc3dpdGNoIHRvIE9jdGFsIERUUiB3YXMgbWFkZQ0KPj4+PiB0
byB0ZXN0IGlmIHRoZSBzd2l0Y2ggd2FzIHN1Y2Nlc3NmdWwuIEludHJvZHVjZSBhIGNvcmUgbWV0
aG9kIGZvciBSRElEIG9wDQo+Pj4+IHRvIGF2b2lkIGNvZGUgZHVwbGljYXRpb24uDQo+Pj4+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlw
LmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDU4ICsr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+Pj4+ICBkcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuaCB8ICA5ICsrKysrKw0KPj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNl
cnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+Pj4g
aW5kZXggYjFkNmZhNjU0MTdkLi4yODFlM2QyNWY3NGMgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZl
cnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29y
ZS5jDQo+Pj4+IEBAIC0zNjksNiArMzY5LDQxIEBAIGludCBzcGlfbm9yX3dyaXRlX2Rpc2FibGUo
c3RydWN0IHNwaV9ub3IgKm5vcikNCj4+Pj4gICAgICAgcmV0dXJuIHJldDsNCj4+Pj4gIH0NCj4+
Pj4NCj4+Pj4gKy8qKg0KPj4+PiArICogc3BpX25vcl9yZWFkX2lkKCkgLSBSZWFkIHRoZSBKRURF
QyBJRC4NCj4+Pj4gKyAqIEBub3I6ICAgICBwb2ludGVyIHRvICdzdHJ1Y3Qgc3BpX25vcicuDQo+
Pj4+ICsgKiBAbmFkZHI6ICAgbnVtYmVyIG9mIGFkZHJlc3MgYnl0ZXMgdG8gc2VuZC4gQ2FuIGJl
IHplcm8gaWYgdGhlIG9wZXJhdGlvbg0KPj4+PiArICogICAgICAgICAgIGRvZXMgbm90IG5lZWQg
dG8gc2VuZCBhbiBhZGRyZXNzLg0KPj4+PiArICogQG5kdW1teTogIG51bWJlciBvZiBkdW1teSBi
eXRlcyB0byBzZW5kIGFmdGVyIGFuIG9wY29kZSBvciBhZGRyZXNzLiBDYW4NCj4+Pj4gKyAqICAg
ICAgICAgICBiZSB6ZXJvIGlmIHRoZSBvcGVyYXRpb24gZG9lcyBub3QgcmVxdWlyZSBkdW1teSBi
eXRlcy4NCj4+Pj4gKyAqIEBpZDogICAgICAgICAgICAgIHBvaW50ZXIgdG8gYSBETUEtYWJsZSBi
dWZmZXIgd2hlcmUgdGhlIHZhbHVlIG9mIHRoZSBKRURFQyBJRA0KPj4+PiArICogICAgICAgICAg
IHdpbGwgYmUgd3JpdHRlbi4NCj4+Pj4gKyAqIEByZWdfcHJvdG86ICAgICAgIHRoZSBTUEkgcHJv
dG9jb2wgZm9yIHJlZ2lzdGVyIG9wZXJhdGlvbi4NCj4+Pj4gKyAqDQo+Pj4+ICsgKiBSZXR1cm46
IDAgb24gc3VjY2VzcywgLWVycm5vIG90aGVyd2lzZS4NCj4+Pj4gKyAqLw0KPj4+PiAraW50IHNw
aV9ub3JfcmVhZF9pZChzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCBuYWRkciwgdTggbmR1bW15LCB1
OCAqaWQsDQo+Pj4+ICsgICAgICAgICAgICAgICAgIGVudW0gc3BpX25vcl9wcm90b2NvbCByZWdf
cHJvdG8pDQo+Pj4NCj4+PiBOaXRwaWNrOiBDb3VsZCBqdXN0IGNhbGwgaXQgJ3Byb3RvJy4NCj4+
DQo+PiBzdXJlLCB3aWxsIHVwZGF0ZQ0KPj4NCj4+Pg0KPj4+PiArew0KPj4+PiArICAgICBpbnQg
cmV0Ow0KPj4+PiArDQo+Pj4+ICsgICAgIGlmIChub3ItPnNwaW1lbSkgew0KPj4+PiArICAgICAg
ICAgICAgIHN0cnVjdCBzcGlfbWVtX29wIG9wID0NCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
IFNQSV9OT1JfUkVBRElEX09QKG5hZGRyLCBuZHVtbXksIGlkLCBTUElfTk9SX01BWF9JRF9MRU4p
Ow0KPj4+PiArDQo+Pj4+ICsgICAgICAgICAgICAgc3BpX25vcl9zcGltZW1fc2V0dXBfb3Aobm9y
LCAmb3AsIHJlZ19wcm90byk7DQo+Pj4+ICsgICAgICAgICAgICAgcmV0ID0gc3BpX21lbV9leGVj
X29wKG5vci0+c3BpbWVtLCAmb3ApOw0KPj4+PiArICAgICB9IGVsc2Ugew0KPj4+PiArICAgICAg
ICAgICAgIHJldCA9IG5vci0+Y29udHJvbGxlcl9vcHMtPnJlYWRfcmVnKG5vciwgU1BJTk9SX09Q
X1JESUQsIGlkLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFNQSV9OT1JfTUFYX0lEX0xFTik7DQo+Pj4+ICsgICAgIH0NCj4+Pj4gKw0KPj4+
PiArICAgICBpZiAocmV0KQ0KPj4+PiArICAgICAgICAgICAgIGRldl9kYmcobm9yLT5kZXYsICJl
cnJvciAlZCByZWFkaW5nIEpFREVDIElEXG4iLCByZXQpOw0KPj4+DQo+Pj4gSSB0aGluayB0aGlz
IG1lc3NhZ2Ugc2hvdWxkIGJlIGluIHNwaV9ub3JfZGV0ZWN0KCkuIExldCBvY3RhbCBEVFIgZW5h
YmxlDQo+Pg0KPj4gQXMgb2Ygbm93IGV2ZXJ5IFNQSSBOT1Igb3BlcmF0aW9uIHRoYXQgcmV0dXJu
IGFuIGVycm9yIGFsc28gcHJpbnRzIGEgZGJnDQo+PiBtZXNzYWdlLiBJIGxpa2UgdGhpcyBiZWNh
dXNlIGl0IG9mZmVycyBhIHNtYWxsZXIgZ3JhbnVsYXJpdHkgb24gdGhlIGVycm9yDQo+PiBjYXVz
ZS4NCj4gDQo+IFllcywgYnV0IEkgdGhpbmsgdGhpcyBtZXNzYWdlIHdvdWxkIGJlIG1pc2xlYWRp
bmcuIElmIHNvbWVvbmUgc2Vlcw0KPiAiZXJyb3IgcmVhZGluZyBKRURFQyBJRCIsIHRoZXkgd291
bGQgdGhpbmsgZmxhc2ggZGV0ZWN0aW9uIGl0c2VsZiBoYXMNCj4gZmFpbGVkLCBub3QgdGhhdCB3
ZSBmYWlsZWQgdG8gc3dpdGNoIHRvIE9jdGFsIERUUiBtb2RlLg0KPiANCj4+DQo+Pj4gbWV0aG9k
cyBwcmludCB0aGVpciBvd24sIG1vcmUgc3BlY2lmaWMgZXJyb3IgbWVzc2FnZXMuDQo+Pg0KPj4g
SG93IGFib3V0IGR1cGxpY2F0aW5nIHRoZSBlcnJvciBpbiB0aGUgb2N0YWwgZHRyIGVuYWJsZSBt
ZXRob2RzIGlmIHlvdQ0KPj4gZmVlbCBpdCBpcyB3b3J0aCBpdD8NCj4gDQo+IFRoZXkgc2hvdWxk
IGF0IHRoZSB2ZXJ5IGxlYXN0IGV4cGxhaW4gdGhhdCByZWFkaW5nIElEIGZhaWxlZCBfYWZ0ZXJf
DQo+IGF0dGVtcHRpbmcgdG8gc3dpdGNoIHRvIE9jdGFsIERUUi4gQnV0IEkgdGhpbmsgaXQgd291
bGQganVzdCBiZSBzaW1wbGVyDQo+IGlmIHRoaXMgaXMgbm90IHByaW50ZWQgaGVyZSBhbmQgdGhl
IGNhbGxlciBoYXMgdGhlIGZsZXhpYmlsaXR5IHRvDQo+IGV4cGxhaW4gdGhlIGVycm9yLg0KDQpJ
ZiB0aGUgZmlyc3QgcmVhZElEIGZhaWxzLCB0aGUgb25lIHRoYXQgaWRlbnRpZmllcyB0aGUgZmxh
c2gsIHRoZW4gdGhlDQpvY3RhbCBkdHIgd2lsbCBub3QgYmUgcnVuLCB0aHVzIGEgc2luZ2xlIGVy
cm9yIG1lc3NhZ2UuIFdoZW4gb2N0YWwgZHRyDQpmYWlscywgMiBlcnJvcnMgY2FuIGJlIHByaW50
ZWQsIG9uZSBzcGVjaWZ5aW5nIHdoYXQgZmFpbGVkICh0aGUgcmVhZCBJRA0KY29tbWFuZCkgYW5k
IHRoZSBzZWNvbmQgd2hlcmUgaXQgZmFpbGVkIChhdCB0aGUgb2N0YWwgZHRyIGVuYWJsZSBtZXRo
b2QpLg0KQnV0IEkgZG9uJ3QgY2FyZSB0b28gbXVjaCwgSSdsbCBmb2xsb3cgeW91ciBzdWdnZXN0
aW9uLg0KDQo+IA0KPj4NCj4+Pg0KPj4+PiArDQo+Pj4+ICsgICAgIHJldHVybiByZXQ7DQo+Pj4+
ICt9DQo+Pj4+ICsNCj4+Pj4gIC8qKg0KPj4+PiAgICogc3BpX25vcl9yZWFkX3NyKCkgLSBSZWFk
IHRoZSBTdGF0dXMgUmVnaXN0ZXIuDQo+Pj4+ICAgKiBAbm9yOiAgICAgcG9pbnRlciB0byAnc3Ry
dWN0IHNwaV9ub3InLg0KPj4+PiBAQCAtMTY0OSwyOCArMTY4NCwxNSBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGZsYXNoX2luZm8gKnNwaV9ub3JfbWF0Y2hfaWQoc3RydWN0IHNwaV9ub3IgKm5vciwN
Cj4+Pj4gICAgICAgcmV0dXJuIE5VTEw7DQo+Pj4+ICB9DQo+Pj4+DQo+Pj4+IC1zdGF0aWMgY29u
c3Qgc3RydWN0IGZsYXNoX2luZm8gKnNwaV9ub3JfcmVhZF9pZChzdHJ1Y3Qgc3BpX25vciAqbm9y
KQ0KPj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvICpzcGlfbm9yX2RldGVjdChz
dHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4+PiAgew0KPj4+PiAgICAgICBjb25zdCBzdHJ1Y3QgZmxh
c2hfaW5mbyAqaW5mbzsNCj4+Pj4gICAgICAgdTggKmlkID0gbm9yLT5ib3VuY2VidWY7DQo+Pj4+
ICAgICAgIGludCByZXQ7DQo+Pj4+DQo+Pj4+IC0gICAgIGlmIChub3ItPnNwaW1lbSkgew0KPj4+
PiAtICAgICAgICAgICAgIHN0cnVjdCBzcGlfbWVtX29wIG9wID0NCj4+Pj4gLSAgICAgICAgICAg
ICAgICAgICAgIFNQSV9NRU1fT1AoU1BJX01FTV9PUF9DTUQoU1BJTk9SX09QX1JESUQsIDEpLA0K
Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX05PX0FERFIs
DQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfTk9fRFVN
TVksDQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfREFU
QV9JTihTUElfTk9SX01BWF9JRF9MRU4sIGlkLCAxKSk7DQo+Pj4+IC0NCj4+Pj4gLSAgICAgICAg
ICAgICByZXQgPSBzcGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGltZW0sICZvcCk7DQo+Pj4+IC0gICAg
IH0gZWxzZSB7DQo+Pj4+IC0gICAgICAgICAgICAgcmV0ID0gbm9yLT5jb250cm9sbGVyX29wcy0+
cmVhZF9yZWcobm9yLCBTUElOT1JfT1BfUkRJRCwgaWQsDQo+Pj4+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU1BJX05PUl9NQVhfSURfTEVOKTsNCj4+
Pj4gLSAgICAgfQ0KPj4+PiAtICAgICBpZiAocmV0KSB7DQo+Pj4+IC0gICAgICAgICAgICAgZGV2
X2RiZyhub3ItPmRldiwgImVycm9yICVkIHJlYWRpbmcgSkVERUMgSURcbiIsIHJldCk7DQo+Pj4+
ICsgICAgIHJldCA9IHNwaV9ub3JfcmVhZF9pZChub3IsIDAsIDAsIGlkLCBub3ItPnJlZ19wcm90
byk7DQo+Pj4NCj4+PiBIbW0sIEkgd29uZGVyIGlmIGl0IGlzIGJldHRlciB0byBleHBsaWNpdGx5
IHVzZSBTTk9SX1BST1RPXzFfMV8xIHNvDQo+Pj4gY2xlYXJseSBzaWduaWZ5IHRoYXQgdGhpcyBp
cyBpbnRlbmRlZCB0byB1c2UgMVMtMVMtMVMgb25seS4gV2hhdCBkbyB5b3UNCj4+PiB0aGluaz8N
Cj4+DQo+PiBJIHdvdWxkIGtlZXAgaXQgYXMgaXQgaXMgZm9yIG5vdywgYmVjYXVzZSBpdCBvZmZl
cnMgZmxleGliaWxpdHkuDQo+PiBJZiB3ZSBldmVyIGdvbm5hIGRldGVybWluZSB0aGUgcHJvdG9j
b2wgYXQgcnVudGltZSB0aGlzIHdpbGwgY29tZSBpbiBoYW5keQ0KPj4gYmVjYXVzZSBpdCB3aWxs
IHdvcmsgd2l0aG91dCB0b3VjaGluZyB0aGUgY29kZS4gSkVTRDIxNiBzdWdnZXN0cyBhbiBhbGdv
cml0aG0NCj4+IHRoYXQgdHJpZXMgdG8gZGV0ZXJtaW5lIHRoZSBtb2RlIGRlcGVuZGluZyBvbiB0
aGUgU0ZEUCBzaWduYXR1cmUuDQo+IA0KPiBJIHdhcyB0aGlua2luZyBleGFjdGx5IHRoaXMgYnV0
IGNhbWUgdG8gdGhlIG9wcG9zaXRlIGNvbmNsdXNpb24gOy0pLiBJDQo+IHRoaW5rIHRoaXMgd291
bGQgaW1wbHkgdGhhdCBvdGhlciBwcm90b2NvbHMgY2FuIGJlIHVzZWQgdG8gZGV0ZWN0IHRoZQ0K
PiBmbGFzaCB3aGljaCBpcyBub3QgdHJ1ZS4NCg0KSXQgY2FuIGJlY29tZSB0cnVlLiBBcyB5b3Ug
YWxyZWFkeSBzcGVjaWZpZWQgOGQtOGQtOGQgaXMgc3VwcG9ydGVkIGJ5IHNvbWUgZmxhc2hlcw0K
YW5kIHdlIGNhbiBpbXBsZW1lbnQgaG9va3MgZm9yIHRoZWlyIHNwZWNpZmljIDhkLThkLThkIHJl
YWRJRCBjb21tYW5kLiBUaGUgbG9naWMNCndpbGwgY29tcGxpY2F0ZSBhIGJpdCBhcyBvbmUgaGFz
IHRvIGFkanVzdCB0aGUgaHdjYXBzIGJlZm9yZSBpc3N1aW5nIHRoZSA4ZC04ZC04ZA0KcmVhZElE
LCBidXQgaXQncyBkb2FibGUuIE90aGVyd2lzZSwgaWYgdGhlIGJvb3Rsb2FkZXJzIHBhc3MgeW91
IHRoZSBmbGFzaCBpbiBvY3RhbA0KZHRyIG1vZGUsIHlvdSdsbCBoYXZlIHRvIGRpc2FibGUgaXQs
IGlzc3VlIHJlYWRJRCBpcyAxLTEtMSBhbmQgdGhlbiByZS1lbmFibGUgaXQuDQoNCj4gDQo+IEJ1
dCBJIGhhdmUgbm8gc3Ryb25nIHByZWZlcmVuY2VzIGhlcmUuIEVpdGhlciBpcyBmaW5lIGJ5IG1l
Lg0KDQpJIGRvbid0IGhhdmUgc3Ryb25nIHByZWZlcmVuY2VzIGVpdGhlciwgYnV0IGl0IHNlZW1z
IHRoYXQgdGhlcmUncyByb29tIGZvciBkaXNjdXNzaW9uDQpvbiB0aGlzLCBzbyBJIHdvdWxkIGtl
ZXAgaXQgZm9yIGxhdGVyLiBJcyB0aGF0IGZpbmU/DQpJIGNhbiBhZGQgYSBjb21tZW50IGlmIHlv
dSBwcmVmZXIsIHNwZWNpZnlpbmcgdGhhdCBhdCB0aGlzIHBvaW50IG5vci0+cmVnX3Byb3RvIGlz
IGluDQoxLTEtMSBtb2RlLg0KDQpDaGVlcnMsDQp0YQ0K
